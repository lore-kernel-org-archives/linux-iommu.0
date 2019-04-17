From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC PATCH v9 03/13] mm: Add support for eXclusive Page Frame
 Ownership (XPFO)
Date: Thu, 18 Apr 2019 01:42:26 +0200 (CEST)
Message-ID: <alpine.DEB.2.21.1904180129000.3174@nanos.tec.linutronix.de>
References: <cover.1554248001.git.khalid.aziz@oracle.com> <f1ac3700970365fb979533294774af0b0dd84b3b.1554248002.git.khalid.aziz@oracle.com> <20190417161042.GA43453@gmail.com> <e16c1d73-d361-d9c7-5b8e-c495318c2509@oracle.com> <20190417170918.GA68678@gmail.com>
 <56A175F6-E5DA-4BBD-B244-53B786F27B7F@gmail.com> <20190417172632.GA95485@gmail.com> <063753CC-5D83-4789-B594-019048DE22D9@gmail.com> <alpine.DEB.2.21.1904172317460.3174@nanos.tec.linutronix.de>
 <CAHk-=wgBMg9P-nYQR2pS0XwVdikPCBqLsMFqR9nk=wSmAd4_5g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHk-=wgBMg9P-nYQR2pS0XwVdikPCBqLsMFqR9nk=wSmAd4_5g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Nadav Amit <nadav.amit@gmail.com>, Ingo Molnar <mingo@kernel.org>, Khalid Aziz <khalid.aziz@oracle.com>, juergh@gmail.com, Tycho Andersen <tycho@tycho.ws>, jsteckli@amazon.de, keescook@google.com, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Juerg Haefliger <juerg.haefliger@canonical.com>, deepa.srinivasan@oracle.com, chris.hyser@oracle.com, tyhicks@canonical.com, David Woodhouse <dwmw@amazon.co.uk>, Andrew Cooper <andrew.cooper3@citrix.com>, jcm@redhat.com, Boris Ostrovsky <boris.ostrovsky@oracle.com>, iommu <iommu@lists.linux-foundation.org>, X86 ML <x86@kernel.org>, linux-arm-kernel@lists.infradead.org, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>LSM List <linux>
List-Id: iommu@lists.linux-foundation.org

On Wed, 17 Apr 2019, Linus Torvalds wrote:

> On Wed, Apr 17, 2019, 14:20 Thomas Gleixner <tglx@linutronix.de> wrote:
> 
> >
> > It's not necessarily a W+X issue. The user space text is mapped in the
> > kernel as well and even if it is mapped RX then this can happen. So any
> > kernel mappings of user space text need to be mapped NX!
> 
> With SMEP, user space pages are always NX.

We talk past each other. The user space page in the ring3 valid virtual
address space (non negative) is of course protected by SMEP.

The attack utilizes the kernel linear mapping of the physical
memory. I.e. user space address 0x43210 has a kernel equivalent at
0xfxxxxxxxxxx. So if the attack manages to trick the kernel to that valid
kernel address and that is mapped X --> game over. SMEP does not help
there.

>From the top of my head I'd say this is a non issue as those kernel address
space mappings _should_ be NX, but we got bitten by _should_ in the past:)

Thanks,

	tglx
