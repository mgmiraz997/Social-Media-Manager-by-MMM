-- CreateTable
CREATE TABLE `User` (
    `id` VARCHAR(191) NOT NULL,
    `email` VARCHAR(191) NOT NULL,
    `password` VARCHAR(191) NOT NULL,
    `name` VARCHAR(191) NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    UNIQUE INDEX `User_email_key`(`email`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Team` (
    `id` VARCHAR(191) NOT NULL,
    `name` VARCHAR(191) NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `TeamMember` (
    `id` VARCHAR(191) NOT NULL,
    `role` ENUM('OWNER', 'ADMIN', 'EDITOR', 'ANALYST') NOT NULL,
    `userId` VARCHAR(191) NOT NULL,
    `teamId` VARCHAR(191) NOT NULL,

    UNIQUE INDEX `TeamMember_userId_teamId_key`(`userId`, `teamId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `SocialAccount` (
    `id` VARCHAR(191) NOT NULL,
    `provider` ENUM('FACEBOOK', 'INSTAGRAM', 'LINKEDIN', 'X') NOT NULL,
    `externalId` VARCHAR(191) NOT NULL,
    `handle` VARCHAR(191) NOT NULL,
    `teamId` VARCHAR(191) NOT NULL,
    `accessToken` VARCHAR(191) NOT NULL,
    `refreshToken` VARCHAR(191) NULL,
    `meta` JSON NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Media` (
    `id` VARCHAR(191) NOT NULL,
    `teamId` VARCHAR(191) NOT NULL,
    `url` VARCHAR(191) NOT NULL,
    `filename` VARCHAR(191) NOT NULL,
    `mimeType` VARCHAR(191) NOT NULL,
    `size` INTEGER NOT NULL,
    `createdBy` VARCHAR(191) NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Post` (
    `id` VARCHAR(191) NOT NULL,
    `teamId` VARCHAR(191) NOT NULL,
    `authorId` VARCHAR(191) NOT NULL,
    `status` ENUM('DRAFT', 'SCHEDULED', 'PUBLISHED', 'FAILED') NOT NULL DEFAULT 'DRAFT',
    `visibility` ENUM('PUBLIC', 'PRIVATE') NOT NULL DEFAULT 'PUBLIC',
    `caption` VARCHAR(191) NOT NULL,
    `media` JSON NULL,
    `scheduledAt` DATETIME(3) NULL,
    `publishedAt` DATETIME(3) NULL,
    `error` VARCHAR(191) NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `PostVariant` (
    `id` VARCHAR(191) NOT NULL,
    `postId` VARCHAR(191) NOT NULL,
    `provider` ENUM('FACEBOOK', 'INSTAGRAM', 'LINKEDIN', 'X') NOT NULL,
    `caption` VARCHAR(191) NOT NULL,
    `extra` JSON NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `ScheduledJob` (
    `id` VARCHAR(191) NOT NULL,
    `postId` VARCHAR(191) NOT NULL,
    `runAt` DATETIME(3) NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    UNIQUE INDEX `ScheduledJob_postId_key`(`postId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `JobRun` (
    `id` VARCHAR(191) NOT NULL,
    `postId` VARCHAR(191) NOT NULL,
    `startedAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `finishedAt` DATETIME(3) NULL,
    `success` BOOLEAN NULL,
    `message` VARCHAR(191) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `AccountMetricDaily` (
    `id` VARCHAR(191) NOT NULL,
    `accountId` VARCHAR(191) NOT NULL,
    `date` DATETIME(3) NOT NULL,
    `followers` INTEGER NOT NULL,
    `impressions` INTEGER NULL,
    `engagements` INTEGER NULL,
    `clicks` INTEGER NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    UNIQUE INDEX `AccountMetricDaily_accountId_date_key`(`accountId`, `date`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `TeamMember` ADD CONSTRAINT `TeamMember_userId_fkey` FOREIGN KEY (`userId`) REFERENCES `User`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `TeamMember` ADD CONSTRAINT `TeamMember_teamId_fkey` FOREIGN KEY (`teamId`) REFERENCES `Team`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `SocialAccount` ADD CONSTRAINT `SocialAccount_teamId_fkey` FOREIGN KEY (`teamId`) REFERENCES `Team`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Post` ADD CONSTRAINT `Post_teamId_fkey` FOREIGN KEY (`teamId`) REFERENCES `Team`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `PostVariant` ADD CONSTRAINT `PostVariant_postId_fkey` FOREIGN KEY (`postId`) REFERENCES `Post`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;
