Return-Path: <SRS0=/IpK=5P=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0F5CC2D0E5
	for <iommu@archiver.kernel.org>; Mon, 30 Mar 2020 17:45:14 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8114D2073B
	for <iommu@archiver.kernel.org>; Mon, 30 Mar 2020 17:45:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8114D2073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 5DC3D87C25;
	Mon, 30 Mar 2020 17:45:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id m1Pd+vmwOQFI; Mon, 30 Mar 2020 17:45:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id B87F087838;
	Mon, 30 Mar 2020 17:45:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A0022C1AE8;
	Mon, 30 Mar 2020 17:45:13 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A2136C07FF
 for <iommu@lists.linux-foundation.org>; Mon, 30 Mar 2020 17:45:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 90E6D87928
 for <iommu@lists.linux-foundation.org>; Mon, 30 Mar 2020 17:45:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nXSFBNjqv9Fj for <iommu@lists.linux-foundation.org>;
 Mon, 30 Mar 2020 17:45:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by whitealder.osuosl.org (Postfix) with ESMTPS id EA8C387838
 for <iommu@lists.linux-foundation.org>; Mon, 30 Mar 2020 17:45:11 +0000 (UTC)
IronPort-SDR: aON/s4W+ZyZb74Gs13sHfIXoR+bgZNBxVJXBvuEDfu8Cn93vb2Hl2B3FHhct3ZU9RZpj48g+up
 lx+4PEsFj97A==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Mar 2020 10:45:11 -0700
IronPort-SDR: hFmrBJo7Lw54DVGU1sjW1hTTNaRCgzAIqFjN2qN/JhxkRSfx9I9NRSzPJByrrcvg0NjHEQp+ca
 EQYXm41zyQ2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,325,1580803200"; d="scan'208";a="422004388"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
 by orsmga005.jf.intel.com with ESMTP; 30 Mar 2020 10:45:10 -0700
Date: Mon, 30 Mar 2020 10:50:57 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH V10 03/11] iommu/vt-d: Add a helper function to skip agaw
Message-ID: <20200330105057.222c5928@jacob-builder>
In-Reply-To: <d17053c3-9a40-837a-dffa-57492cded028@linux.intel.com>
References: <1584746861-76386-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1584746861-76386-4-git-send-email-jacob.jun.pan@linux.intel.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D7ED8FF@SHSMSX104.ccr.corp.intel.com>
 <d17053c3-9a40-837a-dffa-57492cded028@linux.intel.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: "Tian, Kevin" <kevin.tian@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 David Woodhouse <dwmw2@infradead.org>, Jonathan Cameron <jic23@kernel.org>
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

On Sun, 29 Mar 2020 15:20:55 +0800
Lu Baolu <baolu.lu@linux.intel.com> wrote:

> On 2020/3/27 19:53, Tian, Kevin wrote:
> >> From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> >> Sent: Saturday, March 21, 2020 7:28 AM
> >>
> >> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>  
> > 
> > could you elaborate in which scenario this helper function is
> > required?  
> 
> I added below commit message:
> 
>      An Intel iommu domain uses 5-level page table by default. If the
>      iommu that the domain tries to attach supports less page levels,
>      the top level page tables should be skipped. Add a helper to do
>      this so that it could be used in other places.
> 
Thanks Baolu,
I will also add this to my v11, it might save you some time :)


> Best regards,
> baolu
> 
> >     
> >> ---
> >>   drivers/iommu/intel-pasid.c | 22 ++++++++++++++++++++++
> >>   1 file changed, 22 insertions(+)
> >>
> >> diff --git a/drivers/iommu/intel-pasid.c
> >> b/drivers/iommu/intel-pasid.c index 22b30f10b396..191508c7c03e
> >> 100644 --- a/drivers/iommu/intel-pasid.c
> >> +++ b/drivers/iommu/intel-pasid.c
> >> @@ -500,6 +500,28 @@ int intel_pasid_setup_first_level(struct
> >> intel_iommu *iommu,
> >>   }
> >>
> >>   /*
> >> + * Skip top levels of page tables for iommu which has less agaw
> >> + * than default. Unnecessary for PT mode.
> >> + */
> >> +static inline int iommu_skip_agaw(struct dmar_domain *domain,
> >> +				  struct intel_iommu *iommu,
> >> +				  struct dma_pte **pgd)
> >> +{
> >> +	int agaw;
> >> +
> >> +	for (agaw = domain->agaw; agaw > iommu->agaw; agaw--) {
> >> +		*pgd = phys_to_virt(dma_pte_addr(*pgd));
> >> +		if (!dma_pte_present(*pgd)) {
> >> +			return -EINVAL;
> >> +		}
> >> +	}
> >> +	pr_debug_ratelimited("%s: pgd: %llx, agaw %d d_agaw %d\n",
> >> __func__, (u64)*pgd,
> >> +		iommu->agaw, domain->agaw);
> >> +
> >> +	return agaw;
> >> +}
> >> +
> >> +/*
> >>    * Set up the scalable mode pasid entry for second only
> >> translation type. */
> >>   int intel_pasid_setup_second_level(struct intel_iommu *iommu,
> >> --
> >> 2.7.4  
> >   

[Jacob Pan]
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
