---
layout: post
title: "A Dive into CPU Process Execution Modes"
date: 2026-01-25
categories: [Computer architectures]
tags: [Computer security, rings]
description: "Understanding the protection rings (Ring 0 to Ring 3) that secure modern operating systems."
---

First things first, what are **process execution modes**?

Simply put, it's the processor's way of managing what code can run at what privilege level. In modern Intel CPU architectures, these levels are often visualized as a series of concentric circles, called "protection rings."

There are four rings in total:

-   **Ring 0 (Kernel Mode):** This is the most privileged level with absolute, unrestricted access to the hardware. It's where the heart of the operating system—the kernel—resides. The kernel is the ultimate manager of your computer's resources.
-   **Ring 1 and Ring 2:** These are intended for operating system services or drivers that don't need the full power of the kernel. However, most modern operating systems like Windows and Linux simplify their model and primarily use only Ring 0 and Ring 3. This creates a clearer boundary between the "trusted" OS and "untrusted" applications.
-   **Ring 3 (User Mode):** This is the least privileged level. It's where all your applications run, from your web browser to your calculator. Code running in this ring has no direct access to hardware and must ask the kernel for permission to perform privileged operations.

A fair question at this point is: *Why bother with all these rings? Why not put everything in one place?*

To answer that, let's take a quick trip back in time to the era of **"flat-mode"** processors. In these early systems, there was no separation. Kernel programs, user programs—everything—coexisted in the same memory space with the same privileges. The slightest bug in a simple program (imagine your calculator having a glitch) could overwrite critical operating system data and bring down the entire system. (Yes, opening a calculator could literally crash your whole computer!)

This flat architecture also posed a massive security risk. A malicious program could easily bypass the operating system and gain direct control over the hardware, with the highest privilege possible.

The introduction of protection rings solved these problems by creating a strict hierarchy. This model ensures two critical things:

1.  **Stability:** An application crashing in Ring 3 won't take the whole system with it. The kernel, protected in Ring 0, remains stable and can clean up the mess.
2.  **Security:** Applications are prevented from directly accessing hardware or meddling with the memory of other programs.

So, how does a user-mode program perform an action that requires higher privileges, like writing to a file or opening a network connection? It can't do it directly.

Instead, it must make a special request to the kernel. This process is called a **System Call**.

Think of it like this: your application (in Ring 3) sends a formal request to the kernel (in Ring 0), saying, "Hey, I need you to do this privileged task for me." The kernel then validates the request. If everything checks out, the kernel performs the action on behalf of the application and hands back the result. This carefully controlled transition from user mode to kernel mode and back is the fundamental mechanism that allows your applications to safely interact with the system's underlying hardware.

There are many more layers to this topic, but understanding the basics of protection rings is a huge step toward grasping modern operating system design and security. For those interested in a deeper dive, you can check out the materials in my GitHub repository, particularly [this section](https://github.com/annisvvv/Materials_SystemSecurity-Exploitation/tree/main/Architecture%20And%20Hardware/x86-x64/Architecture%202001%20x86-64%20OS%20internals).
