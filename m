Return-Path: <SRS0=C308=ZZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0FCAC432C0
	for <iommu@archiver.kernel.org>; Tue,  3 Dec 2019 17:38:30 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 710A02080F
	for <iommu@archiver.kernel.org>; Tue,  3 Dec 2019 17:38:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 710A02080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 3E83987F5D;
	Tue,  3 Dec 2019 17:38:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GYy-KmMHwb9y; Tue,  3 Dec 2019 17:38:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id CD63087EDB;
	Tue,  3 Dec 2019 17:38:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BABF0C1799;
	Tue,  3 Dec 2019 17:38:28 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 44BECC1799
 for <iommu@lists.linux-foundation.org>; Tue,  3 Dec 2019 17:38:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 3116786C59
 for <iommu@lists.linux-foundation.org>; Tue,  3 Dec 2019 17:38:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id j2ernplOLvSC for <iommu@lists.linux-foundation.org>;
 Tue,  3 Dec 2019 17:38:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 344E586C39
 for <iommu@lists.linux-foundation.org>; Tue,  3 Dec 2019 17:38:26 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 03 Dec 2019 09:38:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,273,1571727600"; d="scan'208";a="385401803"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
 by orsmga005.jf.intel.com with ESMTP; 03 Dec 2019 09:38:25 -0800
Date: Tue, 3 Dec 2019 09:43:08 -0800
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH 4/5] iommu/vt-d: Consolidate pasid-based tlb invalidation
Message-ID: <20191203094308.60e348df@jacob-builder>
In-Reply-To: <20191122030449.28892-5-baolu.lu@linux.intel.com>
References: <20191122030449.28892-1-baolu.lu@linux.intel.com>
 <20191122030449.28892-5-baolu.lu@linux.intel.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: kevin.tian@intel.com, ashok.raj@intel.com, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, David Woodhouse <dwmw2@infradead.org>
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

On Fri, 22 Nov 2019 11:04:48 +0800
Lu Baolu <baolu.lu@linux.intel.com> wrote:

> Merge pasid-based tlb invalidation into iommu->flush.p_iotlb_inv.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/intel-iommu.c | 43
> +++++++++++++++++++++++++++++++++++++ drivers/iommu/intel-pasid.c |
> 18 ++-------------- drivers/iommu/intel-svm.c   | 23
> +++----------------- 3 files changed, 48 insertions(+), 36
> deletions(-)
> 
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index 4eeb18942d3c..fec78cc877c1 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -3032,6 +3032,48 @@ qi_flush_dev_iotlb(struct intel_iommu *iommu,
> u16 sid, u16 pfsid, qi_submit_sync(&desc, iommu);
>  }
>  
> +/* PASID-based IOTLB invalidation */
> +static void
> +qi_flush_piotlb(struct intel_iommu *iommu, u16 did, u32 pasid, u64
> addr,
> +		unsigned long npages, bool ih)
> +{
> +	struct qi_desc desc = {.qw2 = 0, .qw3 = 0};
> +
> +	/*
> +	 * npages == -1 means a PASID-selective invalidation,
> otherwise,
> +	 * a positive value for Page-selective-within-PASID
> invalidation.
> +	 * 0 is not a valid input.
> +	 */
> +	if (WARN_ON(!npages)) {
> +		pr_err("Invalid input npages = %ld\n", npages);
> +		return;
> +	}
> +
> +	if (npages == -1) {
> +		desc.qw0 = QI_EIOTLB_PASID(pasid) |
> +				QI_EIOTLB_DID(did) |
> +				QI_EIOTLB_GRAN(QI_GRAN_NONG_PASID) |
> +				QI_EIOTLB_TYPE;
> +		desc.qw1 = 0;
Is this based on the latest kernel? seems to be missing the recent
change for checking page selective cap. So I run into conflict.

+       /*                                                                     
+        * Do PASID granu IOTLB invalidation if page selective
  capability is   
+        * not
  available.                                                      
+
  */                                                                    
+       if (pages == -1 || !cap_pgsel_inv(svm->iommu->cap))
  {                  
+               desc.qw0 = QI_EIOTLB_PASID(svm->pasid)
  |                       

Seems missing this one in your base?

Refs: v5.3-rc6-2-g8744daf4b069                              
Author:     Jacob Pan <jacob.jun.pan@linux.intel.com>       
AuthorDate: Mon Aug 26 08:53:29 2019 -0700                  
Commit:     Joerg Roedel <jroedel@suse.de>                  
CommitDate: Tue Sep 3 15:01:27 2019 +0200                   
                                                            
    iommu/vt-d: Remove global page flush support            

> +	} else {
> +		int mask = ilog2(__roundup_pow_of_two(npages));
> +		unsigned long align = (1ULL << (VTD_PAGE_SHIFT +
> mask)); +
> +		if (WARN_ON_ONCE(!ALIGN(addr, align)))
> +			addr &= ~(align - 1);
> +
> +		desc.qw0 = QI_EIOTLB_PASID(pasid) |
> +				QI_EIOTLB_DID(did) |
> +				QI_EIOTLB_GRAN(QI_GRAN_PSI_PASID) |
> +				QI_EIOTLB_TYPE;
> +		desc.qw1 = QI_EIOTLB_ADDR(addr) |
> +				QI_EIOTLB_IH(ih) |
> +				QI_EIOTLB_AM(mask);
> +	}
> +
> +	qi_submit_sync(&desc, iommu);
> +}
> +
>  static void intel_iommu_init_qi(struct intel_iommu *iommu)
>  {
>  	/*
> @@ -3065,6 +3107,7 @@ static void intel_iommu_init_qi(struct
> intel_iommu *iommu) iommu->flush.iotlb_inv = qi_flush_iotlb;
>  		iommu->flush.pc_inv = qi_flush_pasid;
>  		iommu->flush.dev_tlb_inv = qi_flush_dev_iotlb;
> +		iommu->flush.p_iotlb_inv = qi_flush_piotlb;
>  		pr_info("%s: Using Queued invalidation\n",
> iommu->name); }
>  }
> diff --git a/drivers/iommu/intel-pasid.c b/drivers/iommu/intel-pasid.c
> index 01dd9c86178b..78ff4eee8595 100644
> --- a/drivers/iommu/intel-pasid.c
> +++ b/drivers/iommu/intel-pasid.c
> @@ -359,20 +359,6 @@ pasid_set_flpm(struct pasid_entry *pe, u64 value)
>  	pasid_set_bits(&pe->val[2], GENMASK_ULL(3, 2), value << 2);
>  }
>  
> -static void
> -iotlb_invalidation_with_pasid(struct intel_iommu *iommu, u16 did,
> u32 pasid) -{
> -	struct qi_desc desc;
> -
> -	desc.qw0 = QI_EIOTLB_PASID(pasid) | QI_EIOTLB_DID(did) |
> -			QI_EIOTLB_GRAN(QI_GRAN_NONG_PASID) |
> QI_EIOTLB_TYPE;
> -	desc.qw1 = 0;
> -	desc.qw2 = 0;
> -	desc.qw3 = 0;
> -
> -	qi_submit_sync(&desc, iommu);
> -}
> -
>  static void
>  devtlb_invalidation_with_pasid(struct intel_iommu *iommu,
>  			       struct device *dev, int pasid)
> @@ -409,7 +395,7 @@ void intel_pasid_tear_down_entry(struct
> intel_iommu *iommu, clflush_cache_range(pte, sizeof(*pte));
>  
>  	iommu->flush.pc_inv(iommu, did, pasid, QI_PC_GRAN_PSWD);
> -	iotlb_invalidation_with_pasid(iommu, did, pasid);
> +	iommu->flush.p_iotlb_inv(iommu, did, pasid, 0, -1, 0);
>  
>  	/* Device IOTLB doesn't need to be flushed in caching mode.
> */ if (!cap_caching_mode(iommu->cap))
> @@ -425,7 +411,7 @@ static void pasid_flush_caches(struct intel_iommu
> *iommu, 
>  	if (cap_caching_mode(iommu->cap)) {
>  		iommu->flush.pc_inv(iommu, did, pasid,
> QI_PC_GRAN_PSWD);
> -		iotlb_invalidation_with_pasid(iommu, did, pasid);
> +		iommu->flush.p_iotlb_inv(iommu, did, pasid, 0, -1,
> 0); } else {
>  		iommu_flush_write_buffer(iommu);
>  	}
> diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
> index f5594b9981a5..02c6b14f0568 100644
> --- a/drivers/iommu/intel-svm.c
> +++ b/drivers/iommu/intel-svm.c
> @@ -118,27 +118,10 @@ static void intel_flush_svm_range_dev (struct
> intel_svm *svm, struct intel_svm_d unsigned long address, unsigned
> long pages, int ih) {
>  	struct qi_desc desc;
> +	struct intel_iommu *iommu = svm->iommu;
>  
> -	if (pages == -1) {
> -		desc.qw0 = QI_EIOTLB_PASID(svm->pasid) |
> -			QI_EIOTLB_DID(sdev->did) |
> -			QI_EIOTLB_GRAN(QI_GRAN_NONG_PASID) |
> -			QI_EIOTLB_TYPE;
> -		desc.qw1 = 0;
> -	} else {
> -		int mask = ilog2(__roundup_pow_of_two(pages));
> -
> -		desc.qw0 = QI_EIOTLB_PASID(svm->pasid) |
> -				QI_EIOTLB_DID(sdev->did) |
> -				QI_EIOTLB_GRAN(QI_GRAN_PSI_PASID) |
> -				QI_EIOTLB_TYPE;
> -		desc.qw1 = QI_EIOTLB_ADDR(address) |
> -				QI_EIOTLB_IH(ih) |
> -				QI_EIOTLB_AM(mask);
> -	}
> -	desc.qw2 = 0;
> -	desc.qw3 = 0;
> -	qi_submit_sync(&desc, svm->iommu);
> +	iommu->flush.p_iotlb_inv(iommu, sdev->did,
> +				 svm->pasid, address, pages, ih);
>  
>  	if (sdev->dev_iotlb) {
>  		desc.qw0 = QI_DEV_EIOTLB_PASID(svm->pasid) |

[Jacob Pan]
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
