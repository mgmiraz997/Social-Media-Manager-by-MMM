"use client";
import { atom } from "jotai";
export const accessTokenAtom = atom<string | null>(null);
export const teamIdAtom = atom<string | null>(null);
