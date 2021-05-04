Return-Path: <SRS0=4008=J7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A447C433ED
	for <iommu@archiver.kernel.org>; Tue,  4 May 2021 23:03:28 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5B99610EA
	for <iommu@archiver.kernel.org>; Tue,  4 May 2021 23:03:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5B99610EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7477B607CA;
	Tue,  4 May 2021 23:03:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id P86UWEcwSAjs; Tue,  4 May 2021 23:03:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2CED06071C;
	Tue,  4 May 2021 23:03:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 03DB4C000E;
	Tue,  4 May 2021 23:03:26 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 66122C0001
 for <iommu@lists.linux-foundation.org>; Tue,  4 May 2021 23:03:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 386DE60781
 for <iommu@lists.linux-foundation.org>; Tue,  4 May 2021 23:03:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dEeas-B4mlxU for <iommu@lists.linux-foundation.org>;
 Tue,  4 May 2021 23:03:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a0a:51c0:0:12e:550::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E61AC6071C
 for <iommu@lists.linux-foundation.org>; Tue,  4 May 2021 23:03:22 +0000 (UTC)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1620169399;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ll/PI4F/FVWkSEpqvRhq/+/IfArUdPCmgxQCahW3Q3M=;
 b=bA7TtUpy/VkWS1LYnlQ8VPaObfNtx7ewqZbJgB5Tg6hFjPki3RG1ZAEV24kBg5QP5vTFR6
 qbabswYvNGCQlIas1dckpYV9HQ+awsOR5m+D4b7wL+CxS4F4pEoBTkjd66/JXo9iswdkVi
 uaMq9PckdldwUYtmKnN+eqslJALyoM77mFCq3+sN0f96cFl+Lsh6ZgOrgXH4JPRwLX/fw+
 N/upsUArXqTsu669S4r+mfxIhBez18YqekBzal9/gLz5Gjsy7AOmyPOGEQf6mogqetKdmq
 ISKjbIsBXOZ/8/6cXGcnw0JVnDm6n15FWi11mo30tb4mP/i/NNvzbLJgvuIa+w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1620169399;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ll/PI4F/FVWkSEpqvRhq/+/IfArUdPCmgxQCahW3Q3M=;
 b=ZOtoHv13IU/mSywRedzAxnTRdphnFF8B7Do7UiUO4rjVFd53PtqHXsYUbJzGN3lnENbXiG
 zj5CY/++GeQ1rzAg==
To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
Subject: Re: [RFC PATCH v5 5/7] iommu/vt-d: Fixup delivery mode of the HPET
 hardlockup interrupt
In-Reply-To: <20210504191049.22661-6-ricardo.neri-calderon@linux.intel.com>
References: <20210504191049.22661-1-ricardo.neri-calderon@linux.intel.com>
 <20210504191049.22661-6-ricardo.neri-calderon@linux.intel.com>
Date: Wed, 05 May 2021 01:03:18 +0200
Message-ID: <87lf8uhzk9.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
 Ricardo Neri <ricardo.neri-calderon@linux.intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org, Stephane Eranian <eranian@google.com>,
 Ricardo Neri <ricardo.neri@intel.com>, iommu@lists.linux-foundation.org,
 "woodhouse, 
 Jacob Pan" <jacob.jun.pan@intel.com>, Andi Kleen <andi.kleen@intel.com>,
 Borislav Petkov <bp@suse.de>, David Woodhouse <dwmw2@infradead.org>,
 Ingo Molnar <mingo@kernel.org>
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

On Tue, May 04 2021 at 12:10, Ricardo Neri wrote:
> In x86 there is not an IRQF_NMI flag that can be used to indicate the

There exists no IRQF_NMI flag at all. No architecture provides that.

> delivery mode when requesting an interrupt (via request_irq()). Thus,
> there is no way for the interrupt remapping driver to know and set
> the delivery mode.

There is no support for this today. So what?

> Hence, when allocating an interrupt, check if such interrupt belongs to
> the HPET hardlockup detector and fixup the delivery mode accordingly.

What?

> +		/*
> +		 * If we find the HPET hardlockup detector irq, fixup the
> +		 * delivery mode.
> +		 */
> +		if (is_hpet_irq_hardlockup_detector(info))
> +			irq_cfg->delivery_mode = APIC_DELIVERY_MODE_NMI;

Again. We are not sticking some random device checks into that
code. It's wrong and I explained it to you before.

  https://lore.kernel.org/lkml/alpine.DEB.2.21.1906161042080.1760@nanos.tec.linutronix.de/

But I'm happy to repeat it again:

  "No. This is horrible hackery violating all the layering which we carefully
   put into place to avoid exactly this kind of sprinkling conditionals into
   all code pathes.

   With some thought the existing irqdomain hierarchy can be used to achieve
   the same thing without tons of extra functions and conditionals."

So the outcome of thought and using the irqdomain hierarchy is:

   Replacing an hpet specific conditional in one place with an hpet
   specific conditional in a different place.

Impressive.

hpet_assign_irq(...., bool nmi)
  init_info(info)
    ...
    if (nmi)
        info.flags |= X86_IRQ_ALLOC_AS_NMI;
  
   irq_domain_alloc_irqs(domain, 1, NUMA_NO_NODE, &info)
     intel_irq_remapping_alloc(..., info)
       irq_domain_alloc_irq_parents(..., info)
         x86_vector_alloc_irqs(..., info)
         {   
           if (info->flags & X86_IRQ_ALLOC_AS_NMI && nr_irqs != 1)
                  return -EINVAL;

           for (i = 0; i < nr_irqs; i++) {
             ....
             if (info->flags & X86_IRQ_ALLOC_AS_NMI) {
                 irq_cfg_setup_nmi(apicd);
                 continue;
             }
             ...
         }

irq_cfg_setup_nmi() sets irq_cfg->delivery_mode and whatever is required
and everything else just works. Of course this needs a few other minor
tweaks but none of those introduces random hpet quirks all over the
place. Not convoluted enough, right?

But that solves none of other problems. Let me summarize again which
options or non-options we have:

    1) Selective IPIs from NMI context cannot work

       As explained in the other thread.

    2) Shorthand IPI allbutself from NMI
    
       This should work, but that obviously does not take the watchdog
       cpumask into account.

       Also this only works when IPI shorthand mode is enabled. See
       apic_smt_update() for details.

    3) Sending the IPIs from irq_work

       This would solve the problem, but if the CPU which is the NMI
       target is really stuck in an interrupt disabled region then the
       IPIs won't be sent.

       OTOH, if that's the case then the CPU which was processing the
       NMI will continue to be stuck until the next NMI hits which
       will detect that the CPU is stuck which is a good enough
       reason to send a shorthand IPI to all CPUs ignoring the
       watchdog cpumask.

       Same limitation vs. shorthand mode as #2

    4) Changing affinity of the HPET NMI from NMI

       As we established two years ago that cannot work with interrupt
       remapping

    5) Changing affinity of the HPET NMI from irq_work

       Same issues as #3

Anything else than #2 is just causing more problems than it solves, but
surely the NOHZ_FULL/isolation people might have opinions on this.

OTOH, as this is opt-in, anything which wants a watchdog mask which is
not the full online set, has to accept that HPET has these restrictions.

And that's exactly what I suggested two years ago:

 https://lore.kernel.org/lkml/alpine.DEB.2.21.1906172343120.1963@nanos.tec.linutronix.de/

  "It definitely would be worthwhile to experiment with that. if we
   could use shorthands (also for regular IPIs) that would be a great
   improvement in general and would nicely solve that NMI issue. Beware
   of the dragons though."

As a consequence of this conversation I implemented shorthand IPIs...

But I haven't seen any mentioning that this has been tried, why the
approach was not chosen or any discussion about that matter.

Not that I'm surprised.

Thanks,

        tglx
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
