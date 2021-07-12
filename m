Return-Path: <SRS0=b5xv=ME=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4386C07E99
	for <iommu@archiver.kernel.org>; Mon, 12 Jul 2021 04:09:56 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60ED061006
	for <iommu@archiver.kernel.org>; Mon, 12 Jul 2021 04:09:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60ED061006
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0A5BE40143;
	Mon, 12 Jul 2021 04:09:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iKazIJcFdLnM; Mon, 12 Jul 2021 04:09:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 979F8400C2;
	Mon, 12 Jul 2021 04:09:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5EEFFC001A;
	Mon, 12 Jul 2021 04:09:54 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9AC62C000E
 for <iommu@lists.linux-foundation.org>; Mon, 12 Jul 2021 04:09:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with UTF8SMTP id 733DA607DA
 for <iommu@lists.linux-foundation.org>; Mon, 12 Jul 2021 04:09:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=mg.codeaurora.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with UTF8SMTP id TipmmVQft0vv for <iommu@lists.linux-foundation.org>;
 Mon, 12 Jul 2021 04:09:51 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from m43-7.mailgun.net (m43-7.mailgun.net [69.72.43.7])
 by smtp3.osuosl.org (Postfix) with UTF8SMTPS id 1FA04607D5
 for <iommu@lists.linux-foundation.org>; Mon, 12 Jul 2021 04:09:45 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1626062991; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=HPk2fk17LJV6t8Nptb5i9ROY3EZisk/sI3PRE0KGEbM=;
 b=lXJMFpi273+f0VjIczOyH543Dh8dK/fzQy+HaryQD0TUIi1jPK+jjAI9+hfxtoEzT/6Qkq3X
 vORVwyGF89cLTGeOFbdauCsOG59oiwplvdCYe79j+OGiRgRvtkvbKyXXPCXQsszcrO7b7Szn
 6VP9rxmz+mI8yLIsBy/xRCGBm9s=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3NDkwMCIsICJpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 60ebc0805e3e57240bf61092 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 12 Jul 2021 04:09:36
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id 032F7C43144; Mon, 12 Jul 2021 04:09:34 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: saiprakash.ranjan)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 6904CC433D3;
 Mon, 12 Jul 2021 04:09:33 +0000 (UTC)
MIME-Version: 1.0
Date: Mon, 12 Jul 2021 09:39:33 +0530
From: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCHv3] iommu/arm-smmu: Optimize ->tlb_flush_walk() for qcom
 implementation
In-Reply-To: <20210623134201.16140-1-saiprakash.ranjan@codeaurora.org>
References: <20210623134201.16140-1-saiprakash.ranjan@codeaurora.org>
Message-ID: <ee8314e4752aa777131dda22c6f4e9ef@codeaurora.org>
X-Sender: saiprakash.ranjan@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Cc: Doug Anderson <dianders@chromium.org>, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Thierry Reding <treding@nvidia.com>, linux-arm-kernel@lists.infradead.org
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

Hi Robin,

On 2021-06-23 19:12, Sai Prakash Ranjan wrote:
> Currently for iommu_unmap() of large scatter-gather list with page size
> elements, the majority of time is spent in flushing of partial walks in
> __arm_lpae_unmap() which is a VA based TLB invalidation invalidating
> page-by-page on iommus like arm-smmu-v2 (TLBIVA).
> 
> For example: to unmap a 32MB scatter-gather list with page size 
> elements
> (8192 entries), there are 16->2MB buffer unmaps based on the pgsize 
> (2MB
> for 4K granule) and each of 2MB will further result in 512 TLBIVAs 
> (2MB/4K)
> resulting in a total of 8192 TLBIVAs (512*16) for 16->2MB causing a 
> huge
> overhead.
> 
> On qcom implementation, there are several performance improvements for
> TLB cache invalidations in HW like wait-for-safe (for realtime clients
> such as camera and display) and few others to allow for cache
> lookups/updates when TLBI is in progress for the same context bank.
> So the cost of over-invalidation is less compared to the unmap latency
> on several usecases like camera which deals with large buffers. So,
> ASID based TLB invalidations (TLBIASID) can be used to invalidate the
> entire context for partial walk flush thereby improving the unmap
> latency.
> 
> Non-strict mode can use this by default for all platforms given its
> all about over-invalidation saving time on individual unmaps and
> non-deterministic generally.
> 
> For this example of 32MB scatter-gather list unmap, this change results
> in just 16 ASID based TLB invalidations (TLBIASIDs) as opposed to 8192
> TLBIVAs thereby increasing the performance of unmaps drastically.
> 
> Test on QTI SM8150 SoC for 10 iterations of iommu_{map_sg}/unmap:
> (average over 10 iterations)
> 
> Before this optimization:
> 
>     size        iommu_map_sg      iommu_unmap
>       4K            2.067 us         1.854 us
>      64K            9.598 us         8.802 us
>       1M          148.890 us       130.718 us
>       2M          305.864 us        67.291 us
>      12M         1793.604 us       390.838 us
>      16M         2386.848 us       518.187 us
>      24M         3563.296 us       775.989 us
>      32M         4747.171 us      1033.364 us
> 
> After this optimization:
> 
>     size        iommu_map_sg      iommu_unmap
>       4K            1.723 us         1.765 us
>      64K            9.880 us         8.869 us
>       1M          155.364 us       135.223 us
>       2M          303.906 us         5.385 us
>      12M         1786.557 us        21.250 us
>      16M         2391.890 us        27.437 us
>      24M         3570.895 us        39.937 us
>      32M         4755.234 us        51.797 us
> 
> This is further reduced once the map/unmap_pages() support gets in 
> which
> will result in just 1 TLBIASID as compared to 16 TLBIASIDs.
> 
> Real world data also shows big difference in unmap performance as 
> below:
> 
> There were reports of camera frame drops because of high overhead in
> iommu unmap without this optimization because of frequent unmaps issued
> by camera of about 100MB/s taking more than 100ms thereby causing frame
> drops.
> 
> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> ---
> 
> Changes in v3:
>  * Move the logic to arm-smmu driver from io-pgtable (Robin)
>  * Use a new set of iommu_flush_ops->arm_smmu_s1_tlb_impl_ops and use
> it for qcom impl
> 
> Changes in v2:
>  * Add a quirk to choose tlb_flush_all in partial walk flush
>  * Set the quirk for QTI SoC implementation
> 
> ---
>  drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 13 +++++++++++++
>  drivers/iommu/arm/arm-smmu/arm-smmu.c      | 17 ++++++++++++++++-
>  2 files changed, 29 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> index 7771d40176de..218c71465819 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> @@ -10,6 +10,8 @@
> 
>  #include "arm-smmu.h"
> 
> +extern const struct iommu_flush_ops arm_smmu_s1_tlb_impl_ops;
> +
>  struct qcom_smmu {
>  	struct arm_smmu_device smmu;
>  	bool bypass_quirk;
> @@ -146,6 +148,8 @@ static int qcom_adreno_smmu_init_context(struct
> arm_smmu_domain *smmu_domain,
>  {
>  	struct adreno_smmu_priv *priv;
> 
> +	pgtbl_cfg->tlb = &arm_smmu_s1_tlb_impl_ops;
> +
>  	/* Only enable split pagetables for the GPU device (SID 0) */
>  	if (!qcom_adreno_smmu_is_gpu_device(dev))
>  		return 0;
> @@ -185,6 +189,14 @@ static const struct of_device_id
> qcom_smmu_client_of_match[] __maybe_unused = {
>  	{ }
>  };
> 
> +static int qcom_smmu_init_context(struct arm_smmu_domain *smmu_domain,
> +		struct io_pgtable_cfg *pgtbl_cfg, struct device *dev)
> +{
> +	pgtbl_cfg->tlb = &arm_smmu_s1_tlb_impl_ops;
> +
> +	return 0;
> +}
> +
>  static int qcom_smmu_cfg_probe(struct arm_smmu_device *smmu)
>  {
>  	unsigned int last_s2cr = ARM_SMMU_GR0_S2CR(smmu->num_mapping_groups - 
> 1);
> @@ -308,6 +320,7 @@ static int qcom_smmu500_reset(struct 
> arm_smmu_device *smmu)
>  }
> 
>  static const struct arm_smmu_impl qcom_smmu_impl = {
> +	.init_context = qcom_smmu_init_context,
>  	.cfg_probe = qcom_smmu_cfg_probe,
>  	.def_domain_type = qcom_smmu_def_domain_type,
>  	.reset = qcom_smmu500_reset,
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c
> b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> index d3c6f54110a5..f3845e822565 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> @@ -341,6 +341,12 @@ static void arm_smmu_tlb_add_page_s1(struct
> iommu_iotlb_gather *gather,
>  				  ARM_SMMU_CB_S1_TLBIVAL);
>  }
> 
> +static void arm_smmu_tlb_inv_walk_impl_s1(unsigned long iova, size_t 
> size,
> +				     size_t granule, void *cookie)
> +{
> +	arm_smmu_tlb_inv_context_s1(cookie);
> +}
> +
>  static void arm_smmu_tlb_inv_walk_s2(unsigned long iova, size_t size,
>  				     size_t granule, void *cookie)
>  {
> @@ -388,6 +394,12 @@ static const struct iommu_flush_ops 
> arm_smmu_s1_tlb_ops = {
>  	.tlb_add_page	= arm_smmu_tlb_add_page_s1,
>  };
> 
> +const struct iommu_flush_ops arm_smmu_s1_tlb_impl_ops = {
> +	.tlb_flush_all	= arm_smmu_tlb_inv_context_s1,
> +	.tlb_flush_walk	= arm_smmu_tlb_inv_walk_impl_s1,
> +	.tlb_add_page	= arm_smmu_tlb_add_page_s1,
> +};
> +
>  static const struct iommu_flush_ops arm_smmu_s2_tlb_ops_v2 = {
>  	.tlb_flush_all	= arm_smmu_tlb_inv_context_s2,
>  	.tlb_flush_walk	= arm_smmu_tlb_inv_walk_s2,
> @@ -703,7 +715,10 @@ static int arm_smmu_init_domain_context(struct
> iommu_domain *domain,
>  			ias = min(ias, 32UL);
>  			oas = min(oas, 32UL);
>  		}
> -		smmu_domain->flush_ops = &arm_smmu_s1_tlb_ops;
> +		if (!iommu_get_dma_strict(domain))
> +			smmu_domain->flush_ops = &arm_smmu_s1_tlb_impl_ops;
> +		else
> +			smmu_domain->flush_ops = &arm_smmu_s1_tlb_ops;
>  		break;
>  	case ARM_SMMU_DOMAIN_NESTED:
>  		/*

Any review comments on this version?

Thanks,
Sai

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a 
member
of Code Aurora Forum, hosted by The Linux Foundation
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
