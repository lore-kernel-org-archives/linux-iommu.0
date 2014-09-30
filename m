From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v3 0/5] enhance DMA CMA on x86
Date: Wed, 1 Oct 2014 01:45:44 +0200 (CEST)
Message-ID: <alpine.DEB.2.11.1410010131380.4455@nanos>
References: <1397567329-3771-1-git-send-email-akinobu.mita@gmail.com> <5426CA0A.7000806@hurleysoftware.com> <CAC5umyhgs8---HZLa7_DOSbqW0uPbLgqTfBweScZSR9oWbG9xg@mail.gmail.com> <54294C0B.1060705@hurleysoftware.com> <CAC5umyjP4OscSC8igVLYPEm-6gqiXt9md46sLu77Vut5UiPb=g@mail.gmail.com>
 <542ABF77.1020402@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <542ABF77.1020402@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: Akinobu Mita <akinobu.mita@gmail.com>, LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, David Woodhouse <dwmw2@infradead.org>, Don Dutile <ddutile@redhat.com>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <andi@firstfloor.org>, x86@kernel.org, iommu@lists.linux-foundation.org, Greg KH <greg@kroah.com>
List-Id: iommu@lists.linux-foundation.org

On Tue, 30 Sep 2014, Peter Hurley wrote:
> I read the UFS Unified Memory Extension v1.0 (JESD220-1) specification and
> it is not clear to me that using DMA mapping is the right approach to
> supporting UM, at least on x86.
> 
> And without a mainline user, the merits of this approach are not evident.
> I cannot even find a production x86 UFS controller, much less one that
> supports UME.
> 
> The only PCI UFS controller I could find (and that mainline supports) is
> Samsung's x86 FPGA-based test unit for developing UFS devices in a x86 test
> environment, and not a production x86 design.

And how is that relevant? That device exists and you have no reason to
deny it to be supported just because you are not interested in it.
 
> Unless there's something else I've missed, I don't think these patches
> belong in mainline.

You missed that there is no reason WHY such a device should not be
supported in mainline.

> Samsung's own roadmap
> (http://www.slideshare.net/linaroorg/next-gen-mobilestorageufs)
> mentions nothing about bringing UFS to x86 designs.

And that's telling you what? 

   - That we should deny Samsung proper support for their obviously
     x86 based test card

   - That we should ignore a JEDEC Standard which is obviously never
     going to hit x86 land just because you decide it?

Your argumentation is just ass backwards. Linux wants to support the
full zoo of hardware including this particular PCI card. Period.

Whether the proposed patchset is the correct solution to support it is
a completely different question.

So either you stop this right now and help Akinobu to find the proper
solution or you just go back in your uncontaminated x86 cave and STFU.

Thanks,

	tglx
