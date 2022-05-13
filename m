Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA774C433F5
	for <iommu@archiver.kernel.org>; Fri, 13 May 2022 23:42:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 70CA760BDB;
	Fri, 13 May 2022 23:42:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vS6liUnlK7td; Fri, 13 May 2022 23:42:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 31A7360BB2;
	Fri, 13 May 2022 23:42:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0746BC0032;
	Fri, 13 May 2022 23:42:09 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5C204C002D
 for <iommu@lists.linux-foundation.org>; Fri, 13 May 2022 23:42:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 35A1C60BCD
 for <iommu@lists.linux-foundation.org>; Fri, 13 May 2022 23:42:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fcLjarXqPBtl for <iommu@lists.linux-foundation.org>;
 Fri, 13 May 2022 23:42:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4922860BB2
 for <iommu@lists.linux-foundation.org>; Fri, 13 May 2022 23:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1652485327; x=1684021327;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=l9BUQ0IAZJ5rrqEJ/wlo5FNsSwI6FBi8qNsQPZI+Uzg=;
 b=WtpuFRxkUJzwL4OynZnDn8HtOPiQ+6Cfl4/O8VGXAfpBbS1FY8HzF+q5
 u82RvuXlllre3ZugldLT6/+1ddVdlElelm131i1QmzOm0CyUbwFR/S0yv
 nxlO1PjmN1TwJt0yvLW6OhNzse/bOBkVdc974xrGecz6MQICLYx7M9hD9
 vXWfEHh1OOdp0XMS/0fPrnYsbLl1ziRSAU41lDnPrk33GCLhmRc2JrUam
 qFypY+5ATI1TYxJDkkaHVtV+Zc+cfZQlCcRf9zJIEh6UtZdmlEo+cZdNk
 sQTESxtVeaAQOwmWfsQzFipjS1fahkbiwhvr3QXe3WpYdr2rKCA2gBs7M Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10346"; a="356859679"
X-IronPort-AV: E=Sophos;i="5.91,223,1647327600"; d="scan'208";a="356859679"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 May 2022 16:42:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,223,1647327600"; d="scan'208";a="625093273"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
 by fmsmga008.fm.intel.com with ESMTP; 13 May 2022 16:42:06 -0700
Date: Fri, 13 May 2022 16:45:42 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v6 05/29] x86/apic/vector: Do not allocate vectors for NMIs
Message-ID: <20220513234542.GC9074@ranerica-svr.sc.intel.com>
References: <20220506000008.30892-1-ricardo.neri-calderon@linux.intel.com>
 <20220506000008.30892-6-ricardo.neri-calderon@linux.intel.com>
 <87zgjufjrf.ffs@tglx>
 <20220513180320.GA22683@ranerica-svr.sc.intel.com>
 <87v8u9rwce.ffs@tglx>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87v8u9rwce.ffs@tglx>
User-Agent: Mutt/1.9.4 (2018-02-28)
Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
 Andi Kleen <ak@linux.intel.com>, linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
 Ricardo Neri <ricardo.neri@intel.com>, Stephane Eranian <eranian@google.com>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Tony Luck <tony.luck@intel.com>, Nicholas Piggin <npiggin@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Woodhouse <dwmw2@infradead.org>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Fri, May 13, 2022 at 10:50:09PM +0200, Thomas Gleixner wrote:
> On Fri, May 13 2022 at 11:03, Ricardo Neri wrote:
> > On Fri, May 06, 2022 at 11:12:20PM +0200, Thomas Gleixner wrote:
> >> Why would a NMI ever end up in this code? There is no vector management
> >> required and this find cpu exercise is pointless.
> >
> > But even if the NMI has a fixed vector, it is still necessary to determine
> > which CPU will get the NMI. It is still necessary to determine what to
> > write in the Destination ID field of the MSI message.
> >
> > irq_matrix_find_best_cpu() would find the CPU with the lowest number of
> > managed vectors so that the NMI is directed to that CPU. 
> 
> What's the point to send it to the CPU with the lowest number of
> interrupts. It's not that this NMI happens every 50 microseconds.
> We pick one online CPU and are done.

Indeed, that is sensible.

> 
> > In today's code, an NMI would end up here because we rely on the existing
> > interrupt management infrastructure... Unless, the check is done the entry
> > points as you propose.
> 
> Correct. We don't want to call into functions which are not designed for
> NMIs.

Agreed.

>  
> >> > +
> >> > +	if (apicd->hw_irq_cfg.delivery_mode == APIC_DELIVERY_MODE_NMI) {
> >> > +		cpu = irq_matrix_find_best_cpu_managed(vector_matrix, dest);
> >> > +		apicd->cpu = cpu;
> >> > +		vector = 0;
> >> > +		goto no_vector;
> >> > +	}
> >> 
> >> This code can never be reached for a NMI delivery. If so, then it's a
> >> bug.
> >> 
> >> This all is special purpose for that particular HPET NMI watchdog use
> >> case and we are not exposing this to anything else at all.
> >> 
> >> So why are you sprinkling this NMI nonsense all over the place? Just
> >> because? There are well defined entry points to all of this where this
> >> can be fenced off.
> >
> > I put the NMI checks in these points because assign_vector_locked() and
> > assign_managed_vector() are reached through multiple paths and these are
> > the two places where the allocation of the vector is requested and the
> > destination CPU is determined.
> >
> > I do observe this code being reached for an NMI, but that is because this
> > code still does not know about NMIs... Unless the checks for NMI are put
> > in the entry points as you pointed out.
> >
> > The intent was to refactor the code in a generic manner and not to focus
> > only in the NMI watchdog. That would have looked hacky IMO.
> 
> We don't want to have more of this really. Supporting NMIs on x86 in a
> broader way is simply not reasonable because there is only one NMI
> vector and we have no sensible way to get to the cause of the NMI
> without a massive overhead.
> 
> Even if we get multiple NMI vectors some shiny day, this will be
> fundamentally different than regular interrupts and certainly not
> exposed broadly. There will be 99.99% fixed vectors for simplicity sake.

Understood.

> 
> >> +		if (info->flags & X86_IRQ_ALLOC_AS_NMI) {
> >> +			/*
> >> +			 * NMIs have a fixed vector and need their own
> >> +			 * interrupt chip so nothing can end up in the
> >> +			 * regular local APIC management code except the
> >> +			 * MSI message composing callback.
> >> +			 */
> >> +			irqd->chip = &lapic_nmi_controller;
> >> +			/*
> >> +			 * Don't allow affinity setting attempts for NMIs.
> >> +			 * This cannot work with the regular affinity
> >> +			 * mechanisms and for the intended HPET NMI
> >> +			 * watchdog use case it's not required.
> >
> > But we do need the ability to set affinity, right? As stated above, we need
> > to know what Destination ID to write in the MSI message or in the interrupt
> > remapping table entry.
> >
> > It cannot be any CPU because only one specific CPU is supposed to handle the
> > NMI from the HPET channel.
> >
> > We cannot hard-code a CPU for that because it may go offline (and ignore NMIs)
> > or not be part of the monitored CPUs.
> >
> > Also, if lapic_nmi_controller.irq_set_affinity() is NULL, then irq_chips
> > INTEL-IR, AMD-IR, those using msi_domain_set_affinity() need to check for NULL.
> > They currently unconditionally call the parent irq_chip's irq_set_affinity().
> > I see that there is a irq_chip_set_affinity_parent() function. Perhaps it can
> > be used for this check?
> 
> Yes, this lacks obviously a NMI specific set_affinity callback and this
> can be very trivial and does not have any of the complexity of interrupt
> affinity assignment. First online CPU in the mask with a fallback to any
> online CPU.

Why would we need a fallback to any online CPU? Shouldn't it fail if it cannot
find an online CPU in the mask?

> 
> I did not claim that this is complete. This was for illustration.

In the reworked patch, may I add a Co-developed-by with your name and your SOB?

> 
> >> +			 */
> >> +			irqd_set_no_balance(irqd);
> >
> > This code does not set apicd->hw_irq_cfg.delivery_mode as NMI, right?
> > I had to add that to make it work.
> 
> I assumed you can figure that out on your own :)

:)

Thanks and BR,
Ricardo
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
