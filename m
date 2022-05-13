Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CAD0C433F5
	for <iommu@archiver.kernel.org>; Fri, 13 May 2022 18:04:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0F41F4199E;
	Fri, 13 May 2022 18:04:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Sb683-3Jcvkv; Fri, 13 May 2022 18:04:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id C9F664154C;
	Fri, 13 May 2022 18:04:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A6854C0032;
	Fri, 13 May 2022 18:04:21 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0F17CC002D
 for <iommu@lists.linux-foundation.org>; Fri, 13 May 2022 18:04:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E930441550
 for <iommu@lists.linux-foundation.org>; Fri, 13 May 2022 18:04:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2wWKq5vQN3rp for <iommu@lists.linux-foundation.org>;
 Fri, 13 May 2022 18:04:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1CF964154C
 for <iommu@lists.linux-foundation.org>; Fri, 13 May 2022 18:04:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1652465058; x=1684001058;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=mmVeSLOWGrrJNNPaH5sVqOAPJshfUhndaLU/q/Ct39k=;
 b=k6DTy+8a9N9ZurG7IH6Ce4F8AVlncYrjRXz9m4UjhjtF9TMq5ZWCpuvU
 MZTi0ZW0jfgZSg2EG/tT8NMTnuSDsAWjVBTlGz2C49ibrEb50lNMaEd/Y
 Ih30AX+SSqD1k/X3whBcthatBMdbBHTuyg7bQqD6sFQFbbpeR+dKfm5dV
 x+pr+qSQNFBA88CgIhzhE0EEP7jSoVtaAOTBdm2QQUwsjQ1//V5OBzxci
 MaAeCzZe3ga3i+Zsh1q/C8XW3N8DTMyucnCzNgyrIirEOdVWOdeyyIN1w
 YRrlJA4v4tWQXQO+vGWHzjK3all6cTsseQqeTyvCWQWYa2Z8rrWCyQ5kx w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10346"; a="333405930"
X-IronPort-AV: E=Sophos;i="5.91,223,1647327600"; d="scan'208";a="333405930"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 May 2022 11:04:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,223,1647327600"; d="scan'208";a="624962791"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
 by fmsmga008.fm.intel.com with ESMTP; 13 May 2022 11:04:09 -0700
Date: Fri, 13 May 2022 11:07:44 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v6 10/29] iommu/vt-d: Implement minor tweaks for NMI irqs
Message-ID: <20220513180744.GB22683@ranerica-svr.sc.intel.com>
References: <20220506000008.30892-1-ricardo.neri-calderon@linux.intel.com>
 <20220506000008.30892-11-ricardo.neri-calderon@linux.intel.com>
 <87wneyfj90.ffs@tglx>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87wneyfj90.ffs@tglx>
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

On Fri, May 06, 2022 at 11:23:23PM +0200, Thomas Gleixner wrote:
> On Thu, May 05 2022 at 16:59, Ricardo Neri wrote:
> > The Intel IOMMU interrupt remapping driver already programs correctly the
> > delivery mode of individual irqs as per their irq_data. Improve handling
> > of NMIs. Allow only one irq per NMI. Also, it is not necessary to cleanup
> > irq vectors after updating affinity.
> 
> Structuring a changelog in paragraphs might make it readable. New lines
> exist for a reason.

Sure, I can structure this in paragraphps.
> 
> > NMIs do not have associated vectors.
> 
> Again. NMI has an vector associated, but it is not subject to dynamic
> vector management.

Indeed, it is clear to me now.

> 
> > diff --git a/drivers/iommu/intel/irq_remapping.c b/drivers/iommu/intel/irq_remapping.c
> > index fb2d71bea98d..791a9331e257 100644
> > --- a/drivers/iommu/intel/irq_remapping.c
> > +++ b/drivers/iommu/intel/irq_remapping.c
> > @@ -1198,8 +1198,12 @@ intel_ir_set_affinity(struct irq_data *data, const struct cpumask *mask,
> >  	 * After this point, all the interrupts will start arriving
> >  	 * at the new destination. So, time to cleanup the previous
> >  	 * vector allocation.
> > +	 *
> > +	 * Do it only for non-NMI irqs. NMIs don't have associated
> > +	 * vectors.
> 
> See above.

Sure.

> 
> >  	 */
> > -	send_cleanup_vector(cfg);
> > +	if (cfg->delivery_mode != APIC_DELIVERY_MODE_NMI)
> > +		send_cleanup_vector(cfg);
> 
> So this needs to be replicated for all invocations of
> send_cleanup_vector(), right? Why can't you put it into that function?

Certainly, it can be done inside the function.

>   
> >  	return IRQ_SET_MASK_OK_DONE;
> >  }
> > @@ -1352,6 +1356,9 @@ static int intel_irq_remapping_alloc(struct irq_domain *domain,
> >  	if (info->type == X86_IRQ_ALLOC_TYPE_PCI_MSI)
> >  		info->flags &= ~X86_IRQ_ALLOC_CONTIGUOUS_VECTORS;
> >  
> > +	if ((info->flags & X86_IRQ_ALLOC_AS_NMI) && nr_irqs != 1)
> > +		return -EINVAL;
> 
> This cannot be reached when the vector allocation domain already
> rejected it, but copy & pasta is wonderful and increases the line count.

Yes, this is not needed.

Thanks and BR,
Ricardo
> 
> Thanks,
> 
>         tglx
> 
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
