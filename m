From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC PATCH v9 03/13] mm: Add support for eXclusive Page Frame
 Ownership (XPFO)
Date: Wed, 17 Apr 2019 16:52:54 -0700
Message-ID: <CAHk-=whUwOjFW6RjHVM8kNOv1QVLJuHj2Dda0=mpLPdJ1UyatQ@mail.gmail.com>
References: <cover.1554248001.git.khalid.aziz@oracle.com> <f1ac3700970365fb979533294774af0b0dd84b3b.1554248002.git.khalid.aziz@oracle.com>
 <20190417161042.GA43453@gmail.com> <e16c1d73-d361-d9c7-5b8e-c495318c2509@oracle.com>
 <20190417170918.GA68678@gmail.com> <56A175F6-E5DA-4BBD-B244-53B786F27B7F@gmail.com>
 <20190417172632.GA95485@gmail.com> <063753CC-5D83-4789-B594-019048DE22D9@gmail.com>
 <alpine.DEB.2.21.1904172317460.3174@nanos.tec.linutronix.de>
 <CAHk-=wgBMg9P-nYQR2pS0XwVdikPCBqLsMFqR9nk=wSmAd4_5g@mail.gmail.com> <alpine.DEB.2.21.1904180129000.3174@nanos.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.21.1904180129000.3174@nanos.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Nadav Amit <nadav.amit@gmail.com>, Ingo Molnar <mingo@kernel.org>, Khalid Aziz <khalid.aziz@oracle.com>, juergh@gmail.com, Tycho Andersen <tycho@tycho.ws>, jsteckli@amazon.de, Kees Cook <keescook@google.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Juerg Haefliger <juerg.haefliger@canonical.com>, deepa.srinivasan@oracle.com, chris.hyser@oracle.com, Tyler Hicks <tyhicks@canonical.com>, David Woodhouse <dwmw@amazon.co.uk>, Andrew Cooper <andrew.cooper3@citrix.com>, Jon Masters <jcm@redhat.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, iommu <iommu@lists.linux-foundation.org>, X86 ML <x86@kernel.org>, "linux-alpha@vger.kernel.org" <linux-arm-kernel@lists.infradead.org>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, Linux
List-Id: iommu@lists.linux-foundation.org

On Wed, Apr 17, 2019 at 4:42 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Wed, 17 Apr 2019, Linus Torvalds wrote:
>
> > With SMEP, user space pages are always NX.
>
> We talk past each other. The user space page in the ring3 valid virtual
> address space (non negative) is of course protected by SMEP.
>
> The attack utilizes the kernel linear mapping of the physical
> memory. I.e. user space address 0x43210 has a kernel equivalent at
> 0xfxxxxxxxxxx. So if the attack manages to trick the kernel to that valid
> kernel address and that is mapped X --> game over. SMEP does not help
> there.

Oh, agreed.

But that would simply be a kernel bug. We should only map kernel pages
executable when we have kernel code in them, and we should certainly
not allow those pages to be mapped writably in user space.

That kind of "executable in kernel, writable in user" would be a
horrendous and major bug.

So i think it's a non-issue.

> From the top of my head I'd say this is a non issue as those kernel address
> space mappings _should_ be NX, but we got bitten by _should_ in the past:)

I do agree that bugs can happen, obviously, and we might have missed something.

But in the context of XPFO, I would argue (*very* strongly) that the
likelihood of the above kind of bug is absolutely *miniscule* compared
to the likelihood that we'd have something wrong in the software
implementation of XPFO.

So if the argument is "we might have bugs in software", then I think
that's an argument _against_ XPFO rather than for it.

                Linus
