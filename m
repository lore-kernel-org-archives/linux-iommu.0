Return-Path: <SRS0=cbBT=EB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B5C3C388F9
	for <iommu@archiver.kernel.org>; Mon, 26 Oct 2020 17:23:07 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A847B22265
	for <iommu@archiver.kernel.org>; Mon, 26 Oct 2020 17:23:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="foNtOJ3d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A847B22265
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 342D58634E;
	Mon, 26 Oct 2020 17:23:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OVgKcLeP8DFH; Mon, 26 Oct 2020 17:23:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id C516B81437;
	Mon, 26 Oct 2020 17:23:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B5754C088B;
	Mon, 26 Oct 2020 17:23:04 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9BBE3C0051
 for <iommu@lists.linux-foundation.org>; Mon, 26 Oct 2020 17:23:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 8AFE18601E
 for <iommu@lists.linux-foundation.org>; Mon, 26 Oct 2020 17:23:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UheAFwWK-IAa for <iommu@lists.linux-foundation.org>;
 Mon, 26 Oct 2020 17:23:02 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from m42-4.mailgun.net (m42-4.mailgun.net [69.72.42.4])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 83F9A81437
 for <iommu@lists.linux-foundation.org>; Mon, 26 Oct 2020 17:22:59 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1603732982; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Cc: To: From: Date: Sender;
 bh=+aOZQ/t6QGi1VJth3AWIBfLCnxWUxT0nkcXTfMK4Iow=;
 b=foNtOJ3dW2y4+mbemtcVmnSek+6g2h0lssdftZW2G4KvxCRqA6FrZsDuA/hO4+oR/zyIv7bj
 3hP4jDhNk7JCFF3SFe2PCTZwfV1OLH1SmWVgQZgCSZZ/Ec/Bi0Y5aaLcceN9o9MfcVztsVuJ
 PF6sJQM+W7jcVYjSiwxbJ8HILCw=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI3NDkwMCIsICJpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 5f9705c6efbfd79b3762e285 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 26 Oct 2020 17:22:14
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id 6766AC43395; Mon, 26 Oct 2020 17:22:14 +0000 (UTC)
Received: from jcrouse1-lnx.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: jcrouse)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id A27F3C433CB;
 Mon, 26 Oct 2020 17:22:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A27F3C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 spf=fail smtp.mailfrom=jcrouse@codeaurora.org
Date: Mon, 26 Oct 2020 11:22:08 -0600
From: Jordan Crouse <jcrouse@codeaurora.org>
To: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Subject: Re: [PATCHv6 4/6] drm/msm/a6xx: Add support for using system
 cache(LLC)
Message-ID: <20201026172208.GB23509@jcrouse1-lnx.qualcomm.com>
Mail-Followup-To: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>, Rob Clark <robdclark@gmail.com>,
 iommu@lists.linux-foundation.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org,
 Akhil P Oommen <akhilpo@codeaurora.org>,
 freedreno@lists.freedesktop.org,
 "Kristian H . Kristensen" <hoegsberg@google.com>,
 dri-devel@lists.freedesktop.org,
 Sharat Masetty <smasetty@codeaurora.org>
References: <cover.1603448364.git.saiprakash.ranjan@codeaurora.org>
 <947f799846dd02501032af5e5ed4b42d12801c84.1603448364.git.saiprakash.ranjan@codeaurora.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <947f799846dd02501032af5e5ed4b42d12801c84.1603448364.git.saiprakash.ranjan@codeaurora.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Cc: freedreno@lists.freedesktop.org, Will Deacon <will@kernel.org>,
 iommu@lists.linux-foundation.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Akhil P Oommen <akhilpo@codeaurora.org>,
 linux-arm-msm@vger.kernel.org,
 "Kristian H . Kristensen" <hoegsberg@google.com>,
 Robin Murphy <robin.murphy@arm.com>, Sharat Masetty <smasetty@codeaurora.org>,
 linux-arm-kernel@lists.infradead.org
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

On Mon, Oct 26, 2020 at 05:24:03PM +0530, Sai Prakash Ranjan wrote:
> From: Sharat Masetty <smasetty@codeaurora.org>
> 
> The last level system cache can be partitioned to 32 different
> slices of which GPU has two slices preallocated. One slice is
> used for caching GPU buffers and the other slice is used for
> caching the GPU SMMU pagetables. This talks to the core system
> cache driver to acquire the slice handles, configure the SCID's
> to those slices and activates and deactivates the slices upon
> GPU power collapse and restore.
> 
> Some support from the IOMMU driver is also needed to make use
> of the system cache to set the right TCR attributes. GPU then
> has the ability to override a few cacheability parameters which
> it does to override write-allocate to write-no-allocate as the
> GPU hardware does not benefit much from it.
> 
> DOMAIN_ATTR_SYS_CACHE is another domain level attribute used by the
> IOMMU driver to set the right attributes to cache the hardware
> pagetables into the system cache.
> 
> Signed-off-by: Sharat Masetty <smasetty@codeaurora.org>
> [saiprakash.ranjan: fix to set attr before device attach to iommu and rebase]
> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>

As with the previous patch this doesn't exactly need the IOMMU side changes
outside of the update to the domain attribute enum.

If the attribute didn't exist we would just lose no-write-allocate which is
undesirable but not devastating.

Hopefully the arm-smmu changes are ready to go but I'm just trying to figure
out a game plan to keep Sai from having to maintain these patches
for another cycle.

Jordan

> ---
>  drivers/gpu/drm/msm/adreno/a6xx_gpu.c   | 83 +++++++++++++++++++++++++
>  drivers/gpu/drm/msm/adreno/a6xx_gpu.h   |  4 ++
>  drivers/gpu/drm/msm/adreno/adreno_gpu.c | 17 +++++
>  3 files changed, 104 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> index 8915882e4444..151190ff62f7 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> @@ -8,7 +8,9 @@
>  #include "a6xx_gpu.h"
>  #include "a6xx_gmu.xml.h"
>  
> +#include <linux/bitfield.h>
>  #include <linux/devfreq.h>
> +#include <linux/soc/qcom/llcc-qcom.h>
>  
>  #define GPU_PAS_ID 13
>  
> @@ -1022,6 +1024,79 @@ static irqreturn_t a6xx_irq(struct msm_gpu *gpu)
>  	return IRQ_HANDLED;
>  }
>  
> +static void a6xx_llc_rmw(struct a6xx_gpu *a6xx_gpu, u32 reg, u32 mask, u32 or)
> +{
> +	return msm_rmw(a6xx_gpu->llc_mmio + (reg << 2), mask, or);
> +}
> +
> +static void a6xx_llc_write(struct a6xx_gpu *a6xx_gpu, u32 reg, u32 value)
> +{
> +	return msm_writel(value, a6xx_gpu->llc_mmio + (reg << 2));
> +}
> +
> +static void a6xx_llc_deactivate(struct a6xx_gpu *a6xx_gpu)
> +{
> +	llcc_slice_deactivate(a6xx_gpu->llc_slice);
> +	llcc_slice_deactivate(a6xx_gpu->htw_llc_slice);
> +}
> +
> +static void a6xx_llc_activate(struct a6xx_gpu *a6xx_gpu)
> +{
> +	u32 cntl1_regval = 0;
> +
> +	if (IS_ERR(a6xx_gpu->llc_mmio))
> +		return;
> +
> +	if (!llcc_slice_activate(a6xx_gpu->llc_slice)) {
> +		u32 gpu_scid = llcc_get_slice_id(a6xx_gpu->llc_slice);
> +
> +		gpu_scid &= 0x1f;
> +		cntl1_regval = (gpu_scid << 0) | (gpu_scid << 5) | (gpu_scid << 10) |
> +			       (gpu_scid << 15) | (gpu_scid << 20);
> +	}
> +
> +	if (!llcc_slice_activate(a6xx_gpu->htw_llc_slice)) {
> +		u32 gpuhtw_scid = llcc_get_slice_id(a6xx_gpu->htw_llc_slice);
> +
> +		gpuhtw_scid &= 0x1f;
> +		cntl1_regval |= FIELD_PREP(GENMASK(29, 25), gpuhtw_scid);
> +	}
> +
> +	if (cntl1_regval) {
> +		/*
> +		 * Program the slice IDs for the various GPU blocks and GPU MMU
> +		 * pagetables
> +		 */
> +		a6xx_llc_write(a6xx_gpu, REG_A6XX_CX_MISC_SYSTEM_CACHE_CNTL_1, cntl1_regval);
> +
> +		/*
> +		 * Program cacheability overrides to not allocate cache lines on
> +		 * a write miss
> +		 */
> +		a6xx_llc_rmw(a6xx_gpu, REG_A6XX_CX_MISC_SYSTEM_CACHE_CNTL_0, 0xF, 0x03);
> +	}
> +}
> +
> +static void a6xx_llc_slices_destroy(struct a6xx_gpu *a6xx_gpu)
> +{
> +	llcc_slice_putd(a6xx_gpu->llc_slice);
> +	llcc_slice_putd(a6xx_gpu->htw_llc_slice);
> +}
> +
> +static void a6xx_llc_slices_init(struct platform_device *pdev,
> +		struct a6xx_gpu *a6xx_gpu)
> +{
> +	a6xx_gpu->llc_mmio = msm_ioremap(pdev, "cx_mem", "gpu_cx");
> +	if (IS_ERR(a6xx_gpu->llc_mmio))
> +		return;
> +
> +	a6xx_gpu->llc_slice = llcc_slice_getd(LLCC_GPU);
> +	a6xx_gpu->htw_llc_slice = llcc_slice_getd(LLCC_GPUHTW);
> +
> +	if (IS_ERR(a6xx_gpu->llc_slice) && IS_ERR(a6xx_gpu->htw_llc_slice))
> +		a6xx_gpu->llc_mmio = ERR_PTR(-EINVAL);
> +}
> +
>  static int a6xx_pm_resume(struct msm_gpu *gpu)
>  {
>  	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
> @@ -1038,6 +1113,8 @@ static int a6xx_pm_resume(struct msm_gpu *gpu)
>  
>  	msm_gpu_resume_devfreq(gpu);
>  
> +	a6xx_llc_activate(a6xx_gpu);
> +
>  	return 0;
>  }
>  
> @@ -1048,6 +1125,8 @@ static int a6xx_pm_suspend(struct msm_gpu *gpu)
>  
>  	trace_msm_gpu_suspend(0);
>  
> +	a6xx_llc_deactivate(a6xx_gpu);
> +
>  	devfreq_suspend_device(gpu->devfreq.devfreq);
>  
>  	return a6xx_gmu_stop(a6xx_gpu);
> @@ -1091,6 +1170,8 @@ static void a6xx_destroy(struct msm_gpu *gpu)
>  		drm_gem_object_put(a6xx_gpu->shadow_bo);
>  	}
>  
> +	a6xx_llc_slices_destroy(a6xx_gpu);
> +
>  	a6xx_gmu_remove(a6xx_gpu);
>  
>  	adreno_gpu_cleanup(adreno_gpu);
> @@ -1209,6 +1290,8 @@ struct msm_gpu *a6xx_gpu_init(struct drm_device *dev)
>  	if (info && info->revn == 650)
>  		adreno_gpu->base.hw_apriv = true;
>  
> +	a6xx_llc_slices_init(pdev, a6xx_gpu);
> +
>  	ret = adreno_gpu_init(dev, pdev, adreno_gpu, &funcs, 1);
>  	if (ret) {
>  		a6xx_destroy(&(a6xx_gpu->base.base));
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
> index 3eeebf6a754b..9e6079af679c 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
> @@ -28,6 +28,10 @@ struct a6xx_gpu {
>  	uint32_t *shadow;
>  
>  	bool has_whereami;
> +
> +	void __iomem *llc_mmio;
> +	void *llc_slice;
> +	void *htw_llc_slice;
>  };
>  
>  #define to_a6xx_gpu(x) container_of(x, struct a6xx_gpu, base)
> diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> index fd8f491f2e48..86c4fe667225 100644
> --- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> @@ -16,6 +16,7 @@
>  #include <linux/soc/qcom/mdt_loader.h>
>  #include <soc/qcom/ocmem.h>
>  #include "adreno_gpu.h"
> +#include "a6xx_gpu.h"
>  #include "msm_gem.h"
>  #include "msm_mmu.h"
>  
> @@ -189,6 +190,8 @@ struct msm_gem_address_space *
>  adreno_iommu_create_address_space(struct msm_gpu *gpu,
>  		struct platform_device *pdev)
>  {
> +	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
> +	struct a6xx_gpu *a6xx_gpu = to_a6xx_gpu(adreno_gpu);
>  	struct iommu_domain *iommu;
>  	struct msm_mmu *mmu;
>  	struct msm_gem_address_space *aspace;
> @@ -198,7 +201,21 @@ adreno_iommu_create_address_space(struct msm_gpu *gpu,
>  	if (!iommu)
>  		return NULL;
>  
> +	/*
> +	 * This allows GPU to set the bus attributes required to use system
> +	 * cache on behalf of the iommu page table walker.
> +	 */
> +	if (!IS_ERR(a6xx_gpu->htw_llc_slice)) {
> +		int gpu_htw_llc = 1;
> +
> +		iommu_domain_set_attr(iommu, DOMAIN_ATTR_SYS_CACHE, &gpu_htw_llc);
> +	}
> +
>  	mmu = msm_iommu_new(&pdev->dev, iommu);
> +	if (IS_ERR(mmu)) {
> +		iommu_domain_free(iommu);
> +		return ERR_CAST(mmu);
> +	}
>  
>  	/*
>  	 * Use the aperture start or SZ_16M, whichever is greater. This will
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation
> 

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
