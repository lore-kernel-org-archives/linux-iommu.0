Return-Path: <SRS0=ekvE=HY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB736C433E0
	for <iommu@archiver.kernel.org>; Mon, 22 Feb 2021 17:57:17 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A140601FF
	for <iommu@archiver.kernel.org>; Mon, 22 Feb 2021 17:57:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A140601FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2C0E2834FE;
	Mon, 22 Feb 2021 17:57:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tpEpMm5uQ8rW; Mon, 22 Feb 2021 17:57:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id A1054834F2;
	Mon, 22 Feb 2021 17:57:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 773FBC000A;
	Mon, 22 Feb 2021 17:57:15 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AAD20C0001
 for <iommu@lists.linux-foundation.org>; Mon, 22 Feb 2021 17:57:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 95B5D834F2
 for <iommu@lists.linux-foundation.org>; Mon, 22 Feb 2021 17:57:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XzTlR_-A1daN for <iommu@lists.linux-foundation.org>;
 Mon, 22 Feb 2021 17:57:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E87AA834FC
 for <iommu@lists.linux-foundation.org>; Mon, 22 Feb 2021 17:57:11 +0000 (UTC)
IronPort-SDR: gYo+JlORtZMhLFHR8MHjLqUJKDf7LzygZDBILRvwEUOsiAzRoGneImGUQVASxByYU3fELBqduB
 s4RIIo1rXGPQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9903"; a="184644820"
X-IronPort-AV: E=Sophos;i="5.81,197,1610438400"; d="scan'208";a="184644820"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Feb 2021 09:57:11 -0800
IronPort-SDR: EiAgx9BcJeHoJJxNILbt0ATqQN8YupwBd7ME4C8JWsvg4II1d/cdeXGcWindSzUkn76jF3j4d1
 XM0mMi/NrUZQ==
X-IronPort-AV: E=Sophos;i="5.81,197,1610438400"; d="scan'208";a="364097390"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
 by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Feb 2021 09:57:10 -0800
Date: Mon, 22 Feb 2021 09:59:48 -0800
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH 1/4] iommu/vt-d: Enable write protect for supervisor SVM
Message-ID: <20210222095948.295178f5@jacob-builder>
In-Reply-To: <fba522cc-7f34-a090-4669-e7720452033b@linux.intel.com>
References: <1613683878-89946-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1613683878-89946-2-git-send-email-jacob.jun.pan@linux.intel.com>
 <fba522cc-7f34-a090-4669-e7720452033b@linux.intel.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Raj Ashok <ashok.raj@intel.com>, Sanjay Kumar <sanjay.k.kumar@intel.com>,
 LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org,
 Jean-Philippe Brucker <jean-philippe@linaro.com>, Yi Sun <yi.y.sun@intel.com>,
 Wu Hao <hao.wu@intel.com>
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

Hi Lu,

On Sat, 20 Feb 2021 09:56:26 +0800, Lu Baolu <baolu.lu@linux.intel.com>
wrote:

> Hi Jacob and Sanjay,
> 
> On 2/19/21 5:31 AM, Jacob Pan wrote:
> > Write protect bit, when set, inhibits supervisor writes to the read-only
> > pages. In supervisor shared virtual addressing (SVA), where page tables
> > are shared between CPU and DMA, IOMMU PASID entry WPE bit should match
> > CR0.WP bit in the CPU.
> > This patch sets WPE bit for supervisor PASIDs if CR0.WP is set.  
> 
>  From reading the commit message, the intention of this patch is to match
> PASID entry WPE bith with CPU CR0.WP if 1) SRE is set (supervisor
> pasid); 2) page table is shared between CPU and IOMMU. Do I understand
> it right?
> 
yes. that is my intention.

> But what the real code doing is failing pasid entry setup for first
> level translation if CPU CR0.WP is not set. It's not consistent with
> what described above.
> 
> What I am thinking is that, as long as SRE is set, we should always set
> WPE in intel_pasid_setup_first_level(). For supervisor SVA case, we
> should check CPU CR0.WP in intel_svm_bind_mm() and abort binding if
> CR0.WP is not set.
> 
> Thought?
> 
This code only affects supervisor SVA, since PASID_FLAG_SUPERVISOR_MODE
flag is not set for FL IOVA.

> Best regards,
> baolu
> 
> > 
> > Signed-off-by: Sanjay Kumar <sanjay.k.kumar@intel.com>
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > ---
> >   drivers/iommu/intel/pasid.c | 26 ++++++++++++++++++++++++++
> >   1 file changed, 26 insertions(+)
> > 
> > diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
> > index 0cceaabc3ce6..0b7e0e726ade 100644
> > --- a/drivers/iommu/intel/pasid.c
> > +++ b/drivers/iommu/intel/pasid.c
> > @@ -410,6 +410,15 @@ static inline void pasid_set_sre(struct
> > pasid_entry *pe) pasid_set_bits(&pe->val[2], 1 << 0, 1);
> >   }
> >   
> > +/*
> > + * Setup the WPE(Write Protect Enable) field (Bit 132) of a
> > + * scalable mode PASID entry.
> > + */
> > +static inline void pasid_set_wpe(struct pasid_entry *pe)
> > +{
> > +	pasid_set_bits(&pe->val[2], 1 << 4, 1 << 4);
> > +}
> > +
> >   /*
> >    * Setup the P(Present) field (Bit 0) of a scalable mode PASID
> >    * entry.
> > @@ -553,6 +562,20 @@ static void pasid_flush_caches(struct intel_iommu
> > *iommu, }
> >   }
> >   
> > +static inline int pasid_enable_wpe(struct pasid_entry *pte)
> > +{
> > +	unsigned long cr0 = read_cr0();
> > +
> > +	/* CR0.WP is normally set but just to be sure */
> > +	if (unlikely(!(cr0 & X86_CR0_WP))) {
> > +		pr_err_ratelimited("No CPU write protect!\n");
> > +		return -EINVAL;
> > +	}
> > +	pasid_set_wpe(pte);
> > +
> > +	return 0;
> > +};
> > +
> >   /*
> >    * Set up the scalable mode pasid table entry for first only
> >    * translation type.
> > @@ -584,6 +607,9 @@ int intel_pasid_setup_first_level(struct
> > intel_iommu *iommu, return -EINVAL;
> >   		}
> >   		pasid_set_sre(pte);
> > +		if (pasid_enable_wpe(pte))
> > +			return -EINVAL;
> > +
> >   	}
> >   
> >   	if (flags & PASID_FLAG_FL5LP) {
> >   


Thanks,

Jacob
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
