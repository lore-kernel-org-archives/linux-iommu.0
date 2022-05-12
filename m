Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1189DC433EF
	for <iommu@archiver.kernel.org>; Thu, 12 May 2022 00:06:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9A81B83E50;
	Thu, 12 May 2022 00:06:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vLaziLW57Jud; Thu, 12 May 2022 00:06:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 6FCC483E4B;
	Thu, 12 May 2022 00:06:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 59355C0032;
	Thu, 12 May 2022 00:06:00 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E15AFC002D
 for <iommu@lists.linux-foundation.org>; Thu, 12 May 2022 00:05:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CFA2183E4E
 for <iommu@lists.linux-foundation.org>; Thu, 12 May 2022 00:05:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tS3fkpqJbJgZ for <iommu@lists.linux-foundation.org>;
 Thu, 12 May 2022 00:05:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 98EE083E4B
 for <iommu@lists.linux-foundation.org>; Thu, 12 May 2022 00:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1652313954; x=1683849954;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=iEGg3ZUCdx9uygbP/iQOaVPDEP0BAuMfZKqEQ1Cahnc=;
 b=dnMGvaTXHWuuTExgra1KNQ/YaJWLXwDZY3IY2u2jTWDTSwzW0QOt+n9X
 BuEEi3WZFEjOC/IyS9LoxDKm7dXgawfOGoW/q3SpaJpppFIk7aElieQQK
 bAOOJgYlNPju5LEYICGrGMSHkYW411W0r5YR0lRIihzSKoSBTAr2/Eqij
 76UIGnXl6+ousI702WdCErVxQPHfcncu6etVxZW+E1CtKSWA0EiU3AC2p
 3a7EwE0C4bHrX5yXaP/B1KLHobxDi82IlpEhQ+7udj1rLpI/O2BLfCLd5
 VEj6O8yRAswmaWI8WFVlYLVi4M57ugSw3PVPxsqZwAWTmrsGdFRPNMmOt w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10344"; a="268680458"
X-IronPort-AV: E=Sophos;i="5.91,218,1647327600"; d="scan'208";a="268680458"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 May 2022 17:05:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,218,1647327600"; d="scan'208";a="658374063"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
 by FMSMGA003.fm.intel.com with ESMTP; 11 May 2022 17:05:53 -0700
Date: Wed, 11 May 2022 17:09:24 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v6 01/29] irq/matrix: Expose functions to allocate the
 best CPU for new vectors
Message-ID: <20220512000924.GA16273@ranerica-svr.sc.intel.com>
References: <20220506000008.30892-1-ricardo.neri-calderon@linux.intel.com>
 <20220506000008.30892-2-ricardo.neri-calderon@linux.intel.com>
 <878rreh27n.ffs@tglx>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <878rreh27n.ffs@tglx>
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

On Fri, May 06, 2022 at 09:48:28PM +0200, Thomas Gleixner wrote:
> Ricardo,

Thank you very much for your feedback Thomas! I am sorry for my late reply, I
had been out of office.

> 
> On Thu, May 05 2022 at 16:59, Ricardo Neri wrote:
> > Certain types of interrupts, such as NMI, do not have an associated vector.
> > They, however, target specific CPUs. Thus, when assigning the destination
> > CPU, it is beneficial to select the one with the lowest number of
> > vectors.
> 
> Why is that beneficial especially in the context of a NMI watchdog which
> then broadcasts the NMI to all other CPUs?

My intent was not the NMI watchdog specifically but potential use cases that do
not involve NMI broadcasts. If the NMI targets a single CPU, it is best to
select the CPU with the lowest vector allocation count.

> 
> That's wishful thinking perhaps, but I don't see any benefit at all.
> 
> > Prepend the functions matrix_find_best_cpu_managed() and
> > matrix_find_best_cpu_managed()
> 
> The same function prepended twice becomes two functions :)
> 

Sorry, I missed this.

> > with the irq_ prefix and expose them for
> > IRQ controllers to use when allocating and activating vector-less IRQs.
> 
> There is no such thing like a vectorless IRQ. NMIs have a vector. Can we
> please describe facts and not pulled out of thin air concepts which do
> not exist?

Thank you for the clarification. I see your point. I wrote this patch because
maskable interrupts and NMIs have different entry points. As you state,
however, the also have a vector.

I can drop this patch.

BR,
Ricardo

> 
> Thanks,
> 
>         tglx
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
