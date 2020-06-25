Return-Path: <SRS0=A59K=AG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 557A1C433E0
	for <iommu@archiver.kernel.org>; Thu, 25 Jun 2020 07:17:28 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CB5920720
	for <iommu@archiver.kernel.org>; Thu, 25 Jun 2020 07:17:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CB5920720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id C00AB22D2D;
	Thu, 25 Jun 2020 07:17:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zkZXR4CGueH9; Thu, 25 Jun 2020 07:17:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 6EF0D20198;
	Thu, 25 Jun 2020 07:17:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 58680C0863;
	Thu, 25 Jun 2020 07:17:26 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E0597C016F
 for <iommu@lists.linux-foundation.org>; Thu, 25 Jun 2020 07:17:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id D4A4720198
 for <iommu@lists.linux-foundation.org>; Thu, 25 Jun 2020 07:17:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GYjYZBD82ZXq for <iommu@lists.linux-foundation.org>;
 Thu, 25 Jun 2020 07:17:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by silver.osuosl.org (Postfix) with ESMTPS id C1D6220133
 for <iommu@lists.linux-foundation.org>; Thu, 25 Jun 2020 07:17:23 +0000 (UTC)
IronPort-SDR: dYxOducHuMhiysx7z7aOiuMEI44IPqfBS/2sobwNtJn5nnR+3f+0A7Gkp8on058fn+Z3P5urrq
 smz+OoOcTIyg==
X-IronPort-AV: E=McAfee;i="6000,8403,9662"; a="162861457"
X-IronPort-AV: E=Sophos;i="5.75,278,1589266800"; d="scan'208";a="162861457"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jun 2020 00:17:23 -0700
IronPort-SDR: 9SU8WSOXjOb5cGfblHCGaq4sbltWg3ZPoCkOiUtleR9YbF5N4YmR0x/cq0Jpk7BHB9Lcgk/TVU
 36t/6pIx+png==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,278,1589266800"; d="scan'208";a="263857069"
Received: from yijiangw-mobl1.ccr.corp.intel.com (HELO [10.255.28.52])
 ([10.255.28.52])
 by fmsmga007.fm.intel.com with ESMTP; 25 Jun 2020 00:17:20 -0700
Subject: Re: [PATCH 2/7] iommu/vt-d: Remove global page support in devTLB flush
To: Jacob Pan <jacob.jun.pan@linux.intel.com>,
 iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>,
 Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>
References: <1592926996-47914-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1592926996-47914-3-git-send-email-jacob.jun.pan@linux.intel.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <cfbddc34-b70b-1ee6-9a9f-fa76e484de70@linux.intel.com>
Date: Thu, 25 Jun 2020 15:17:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <1592926996-47914-3-git-send-email-jacob.jun.pan@linux.intel.com>
Content-Language: en-US
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 2020/6/23 23:43, Jacob Pan wrote:
> Global pages support is removed from VT-d spec 3.0 for dev TLB
> invalidation. This patch is to remove the bits for vSVA. Similar change
> already made for the native SVA. See the link below.
> 

Acked-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu

> Link: https://lkml.org/lkml/2019/8/26/651
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
>   drivers/iommu/intel/dmar.c  | 4 +---
>   drivers/iommu/intel/iommu.c | 4 ++--
>   include/linux/intel-iommu.h | 3 +--
>   3 files changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
> index cc46dff98fa0..d9f973fa1190 100644
> --- a/drivers/iommu/intel/dmar.c
> +++ b/drivers/iommu/intel/dmar.c
> @@ -1437,8 +1437,7 @@ void qi_flush_piotlb(struct intel_iommu *iommu, u16 did, u32 pasid, u64 addr,
>   
>   /* PASID-based device IOTLB Invalidate */
>   void qi_flush_dev_iotlb_pasid(struct intel_iommu *iommu, u16 sid, u16 pfsid,
> -			      u32 pasid,  u16 qdep, u64 addr,
> -			      unsigned int size_order, u64 granu)
> +			      u32 pasid,  u16 qdep, u64 addr, unsigned int size_order)
>   {
>   	unsigned long mask = 1UL << (VTD_PAGE_SHIFT + size_order - 1);
>   	struct qi_desc desc = {.qw1 = 0, .qw2 = 0, .qw3 = 0};
> @@ -1446,7 +1445,6 @@ void qi_flush_dev_iotlb_pasid(struct intel_iommu *iommu, u16 sid, u16 pfsid,
>   	desc.qw0 = QI_DEV_EIOTLB_PASID(pasid) | QI_DEV_EIOTLB_SID(sid) |
>   		QI_DEV_EIOTLB_QDEP(qdep) | QI_DEIOTLB_TYPE |
>   		QI_DEV_IOTLB_PFSID(pfsid);
> -	desc.qw1 = QI_DEV_EIOTLB_GLOB(granu);
>   
>   	/*
>   	 * If S bit is 0, we only flush a single page. If S bit is set,
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 9129663a7406..96340da57075 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -5466,7 +5466,7 @@ intel_iommu_sva_invalidate(struct iommu_domain *domain, struct device *dev,
>   						info->pfsid, pasid,
>   						info->ats_qdep,
>   						inv_info->addr_info.addr,
> -						size, granu);
> +						size);
>   			break;
>   		case IOMMU_CACHE_INV_TYPE_DEV_IOTLB:
>   			if (info->ats_enabled)
> @@ -5474,7 +5474,7 @@ intel_iommu_sva_invalidate(struct iommu_domain *domain, struct device *dev,
>   						info->pfsid, pasid,
>   						info->ats_qdep,
>   						inv_info->addr_info.addr,
> -						size, granu);
> +						size);
>   			else
>   				pr_warn_ratelimited("Passdown device IOTLB flush w/o ATS!\n");
>   			break;
> diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
> index 729386ca8122..9a6614880773 100644
> --- a/include/linux/intel-iommu.h
> +++ b/include/linux/intel-iommu.h
> @@ -380,7 +380,6 @@ enum {
>   
>   #define QI_DEV_EIOTLB_ADDR(a)	((u64)(a) & VTD_PAGE_MASK)
>   #define QI_DEV_EIOTLB_SIZE	(((u64)1) << 11)
> -#define QI_DEV_EIOTLB_GLOB(g)	((u64)(g) & 0x1)
>   #define QI_DEV_EIOTLB_PASID(p)	((u64)((p) & 0xfffff) << 32)
>   #define QI_DEV_EIOTLB_SID(sid)	((u64)((sid) & 0xffff) << 16)
>   #define QI_DEV_EIOTLB_QDEP(qd)	((u64)((qd) & 0x1f) << 4)
> @@ -704,7 +703,7 @@ void qi_flush_piotlb(struct intel_iommu *iommu, u16 did, u32 pasid, u64 addr,
>   
>   void qi_flush_dev_iotlb_pasid(struct intel_iommu *iommu, u16 sid, u16 pfsid,
>   			      u32 pasid, u16 qdep, u64 addr,
> -			      unsigned int size_order, u64 granu);
> +			      unsigned int size_order);
>   void qi_flush_pasid_cache(struct intel_iommu *iommu, u16 did, u64 granu,
>   			  int pasid);
>   
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
