Return-Path: <SRS0=9F5p=AF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1799C433E0
	for <iommu@archiver.kernel.org>; Wed, 24 Jun 2020 00:31:48 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BF3A20675
	for <iommu@archiver.kernel.org>; Wed, 24 Jun 2020 00:31:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BF3A20675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 434F8214EC;
	Wed, 24 Jun 2020 00:31:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Up6URazZl9c7; Wed, 24 Jun 2020 00:31:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 780C522C44;
	Wed, 24 Jun 2020 00:31:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 57961C088E;
	Wed, 24 Jun 2020 00:31:46 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 86DF8C016F
 for <iommu@lists.linux-foundation.org>; Wed, 24 Jun 2020 00:31:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 8147587ABA
 for <iommu@lists.linux-foundation.org>; Wed, 24 Jun 2020 00:31:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id u0vTszUZyiLr for <iommu@lists.linux-foundation.org>;
 Wed, 24 Jun 2020 00:31:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 9942487BF1
 for <iommu@lists.linux-foundation.org>; Wed, 24 Jun 2020 00:31:43 +0000 (UTC)
IronPort-SDR: euAxlJ4xdf+KrIZL58Lf5c+8rEypemp1uH98PJxXRNd0150dh+KdVIB436/O3pSnl0hGoTMXsh
 l71UOfG9ZMJQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9661"; a="141775668"
X-IronPort-AV: E=Sophos;i="5.75,273,1589266800"; d="scan'208";a="141775668"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jun 2020 17:31:43 -0700
IronPort-SDR: JuRKAVOTj0bzM5gYHe59Qpoho2OXHhXh0++ajff75JbolNyznLJ4KWTbW+rIlS5pQwJ5oGfU8t
 Lb3ul8PRwrsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,273,1589266800"; d="scan'208";a="452444240"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
 by orsmga005.jf.intel.com with ESMTP; 23 Jun 2020 17:31:42 -0700
Date: Tue, 23 Jun 2020 17:38:13 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>,
 "Lu Baolu" <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
 David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH 5/7] iommu/vt-d: Fix devTLB flush for vSVA
Message-ID: <20200623173813.6a02353c@jacob-builder>
In-Reply-To: <1592926996-47914-6-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1592926996-47914-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1592926996-47914-6-git-send-email-jacob.jun.pan@linux.intel.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Tue, 23 Jun 2020 08:43:14 -0700
Jacob Pan <jacob.jun.pan@linux.intel.com> wrote:

> From: Liu Yi L <yi.l.liu@intel.com>
> 
> For guest SVA usage, in order to optimize for less VMEXIT, guest
> request of IOTLB flush also includes device TLB.
> 
> On the host side, IOMMU driver performs IOTLB and implicit devTLB
> invalidation. When PASID-selective granularity is requested by the
> guest we need to derive the equivalent address range for devTLB
> instead of using the address information in the UAPI data. The reason
> for that is, unlike IOTLB flush, devTLB flush does not support
> PASID-selective granularity. This is to say, we need to set the
> following in the PASID based devTLB invalidation descriptor:
> - entire 64 bit range in address ~(0x1 << 63)
> - S bit = 1 (VT-d CH 6.5.2.6).
> 
> Without this fix, device TLB flush range is not set properly for PASID
> selective granularity. This patch also merged devTLB flush code for
> both implicit and explicit cases.
> 
> Fixes: 6ee1b77ba3ac ("iommu/vt-d: Add svm/sva invalidate function")
> Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
>  drivers/iommu/intel/iommu.c | 25 +++++++++++++++++--------
>  1 file changed, 17 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 96340da57075..5ea5732d5ec4 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -5408,7 +5408,7 @@ intel_iommu_sva_invalidate(struct iommu_domain
> *domain, struct device *dev, sid = PCI_DEVID(bus, devfn);
>  
>  	/* Size is only valid in address selective invalidation */
> -	if (inv_info->granularity != IOMMU_INV_GRANU_PASID)
> +	if (inv_info->granularity == IOMMU_INV_GRANU_ADDR)
>  		size = to_vtd_size(inv_info->addr_info.granule_size,
>  				   inv_info->addr_info.nb_granules);
>  
> @@ -5417,6 +5417,7 @@ intel_iommu_sva_invalidate(struct iommu_domain
> *domain, struct device *dev, IOMMU_CACHE_INV_TYPE_NR) {
>  		int granu = 0;
>  		u64 pasid = 0;
> +		u64 addr = 0;
>  
>  		granu = to_vtd_granularity(cache_type,
> inv_info->granularity); if (granu == -EINVAL) {
> @@ -5456,19 +5457,27 @@ intel_iommu_sva_invalidate(struct
> iommu_domain *domain, struct device *dev, (granu ==
> QI_GRAN_NONG_PASID) ? -1 : 1 << size, inv_info->addr_info.flags &
> IOMMU_INV_ADDR_FLAGS_LEAF); 
> +			if (!info->ats_enabled)
> +				break;
>  			/*
>  			 * Always flush device IOTLB if ATS is
> enabled. vIOMMU
>  			 * in the guest may assume IOTLB flush is
> inclusive,
>  			 * which is more efficient.
>  			 */
> -			if (info->ats_enabled)
> -				qi_flush_dev_iotlb_pasid(iommu, sid,
> -						info->pfsid, pasid,
> -						info->ats_qdep,
> -
> inv_info->addr_info.addr,
> -						size);
> -			break;
> +			fallthrough;
>  		case IOMMU_CACHE_INV_TYPE_DEV_IOTLB:
> +			/*
> +			 * There is no PASID selective flush for
> device TLB, so
> +			 * the equivalent of that is we set the size
> to be the
> +			 * entire range of 64 bit. User only
> provides PASID info
> +			 * without address info. So we set addr to 0.
> +			 */
> +			if (inv_info->granularity ==
> IOMMU_INV_GRANU_PASID) {
> +				size = 64 - VTD_PAGE_SHIFT;
> +				addr = 0;
> +			} else if (inv_info->granularity ==
> IOMMU_INV_GRANU_ADDR)
> +				addr = inv_info->addr_info.addr;
> +
>  			if (info->ats_enabled)
>  				qi_flush_dev_iotlb_pasid(iommu, sid,
>  						info->pfsid, pasid,
addr should be used here. will fix in the next version. Baolu has
pointed out this before but missed it here.

Jacob
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
