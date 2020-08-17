Return-Path: <SRS0=aSVE=B3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87F1BC433DF
	for <iommu@archiver.kernel.org>; Mon, 17 Aug 2020 16:18:35 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36B4F20789
	for <iommu@archiver.kernel.org>; Mon, 17 Aug 2020 16:18:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="b6AnxvNX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36B4F20789
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id D391884CAC;
	Mon, 17 Aug 2020 16:18:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IopJ5Jf9GA0X; Mon, 17 Aug 2020 16:18:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 2DDD584C4E;
	Mon, 17 Aug 2020 16:18:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 23E30C07FF;
	Mon, 17 Aug 2020 16:18:34 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 48230C07FF
 for <iommu@lists.linux-foundation.org>; Mon, 17 Aug 2020 15:41:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 43C4F85650
 for <iommu@lists.linux-foundation.org>; Mon, 17 Aug 2020 15:41:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cOEY93n6T03g for <iommu@lists.linux-foundation.org>;
 Mon, 17 Aug 2020 15:41:23 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from m43-7.mailgun.net (m43-7.mailgun.net [69.72.43.7])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 2D3C285644
 for <iommu@lists.linux-foundation.org>; Mon, 17 Aug 2020 15:41:21 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1597678883; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=VYK3lYSXyLSuNZtDJEqONO4W2R+VnVrEGPnXZiROXgU=;
 b=b6AnxvNXMNpB+9wwyNfmBLpudtXErwmojPy/KUUEwOvzqRHa/4/KV06NsNoemFvxV6Kon/V1
 5K1cxlJRpFdZltV4QBGH1Me+AV43XUe4M3lVOQJNpeL7pMxmG1Ap9oiOR/gVcE8pgA1vZvQo
 ykszWvyzEi+wzDsl01erZCE4ixc=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3NDkwMCIsICJpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n09.prod.us-east-1.postgun.com with SMTP id
 5f3aa50bba4c2cd3679b6959 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 17 Aug 2020 15:40:59
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id A5EFFC433B6; Mon, 17 Aug 2020 15:40:58 +0000 (UTC)
Received: from [192.168.1.7] (unknown [117.217.239.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: akhilpo)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 7AE34C43391;
 Mon, 17 Aug 2020 15:40:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7AE34C43391
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 spf=none smtp.mailfrom=akhilpo@codeaurora.org
Subject: Re: [PATCH 16/19] drm/msm/a6xx: Add support for per-instance
 pagetables
To: Rob Clark <robdclark@gmail.com>, dri-devel@lists.freedesktop.org,
 iommu@lists.linux-foundation.org, linux-arm-msm@vger.kernel.org
References: <20200810222657.1841322-1-jcrouse@codeaurora.org>
 <20200814024114.1177553-17-robdclark@gmail.com>
From: Akhil P Oommen <akhilpo@codeaurora.org>
Message-ID: <7c130df7-c7f4-8694-c7be-ce3debe01662@codeaurora.org>
Date: Mon, 17 Aug 2020 21:10:46 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200814024114.1177553-17-robdclark@gmail.com>
Content-Language: en-US
X-Mailman-Approved-At: Mon, 17 Aug 2020 16:18:33 +0000
Cc: Rob Clark <robdclark@chromium.org>,
 open list <linux-kernel@vger.kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
 Jonathan Marek <jonathan@marek.ca>, Eric Anholt <eric@anholt.net>,
 David Airlie <airlied@linux.ie>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Sean Paul <sean@poorly.run>,
 Sibi Sankar <sibis@codeaurora.org>, Vivek Gautam <vivek.gautam@codeaurora.org>,
 Stephen Boyd <swboyd@chromium.org>, freedreno@lists.freedesktop.org,
 Sharat Masetty <smasetty@codeaurora.org>, linux-arm-kernel@lists.infradead.org
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

On 8/14/2020 8:11 AM, Rob Clark wrote:
> From: Jordan Crouse <jcrouse@codeaurora.org>
> 
> Add support for using per-instance pagetables if all the dependencies are
> available.
> 
> Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
>   drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 70 +++++++++++++++++++++++++++
>   drivers/gpu/drm/msm/adreno/a6xx_gpu.h |  1 +
>   drivers/gpu/drm/msm/msm_ringbuffer.h  |  1 +
>   3 files changed, 72 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> index 5eabb0109577..9653ac9b3cb8 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> @@ -81,6 +81,56 @@ static void get_stats_counter(struct msm_ringbuffer *ring, u32 counter,
>   	OUT_RING(ring, upper_32_bits(iova));
>   }
>   
> +static void a6xx_set_pagetable(struct a6xx_gpu *a6xx_gpu,
> +		struct msm_ringbuffer *ring, struct msm_file_private *ctx)
> +{
> +	phys_addr_t ttbr;
> +	u32 asid;
> +	u64 memptr = rbmemptr(ring, ttbr0);
> +
> +	if (ctx == a6xx_gpu->cur_ctx)
> +		return;
> +
> +	if (msm_iommu_pagetable_params(ctx->aspace->mmu, &ttbr, &asid))
> +		return;
> +
> +	/* Execute the table update */
> +	OUT_PKT7(ring, CP_SMMU_TABLE_UPDATE, 4);
> +	OUT_RING(ring, CP_SMMU_TABLE_UPDATE_0_TTBR0_LO(lower_32_bits(ttbr)));
> +
> +	/*
> +	 * For now ignore the asid since the smmu driver uses a TLBIASID to
> +	 * flush the TLB when we use iommu_flush_tlb_all() and the smmu driver
> +	 * isn't aware that the asid changed.  Instead, keep the default asid
> +	 * (0, same as the context bank) to make sure the TLB is properly
> +	 * flushed.
> +	 */
> +	OUT_RING(ring,
> +		CP_SMMU_TABLE_UPDATE_1_TTBR0_HI(upper_32_bits(ttbr)) |
> +		CP_SMMU_TABLE_UPDATE_1_ASID(0));
> +	OUT_RING(ring, CP_SMMU_TABLE_UPDATE_2_CONTEXTIDR(0));
> +	OUT_RING(ring, CP_SMMU_TABLE_UPDATE_3_CONTEXTBANK(0));
> +
> +	/*
> +	 * Write the new TTBR0 to the memstore. This is good for debugging.
> +	 */
> +	OUT_PKT7(ring, CP_MEM_WRITE, 4);
> +	OUT_RING(ring, CP_MEM_WRITE_0_ADDR_LO(lower_32_bits(memptr)));
> +	OUT_RING(ring, CP_MEM_WRITE_1_ADDR_HI(upper_32_bits(memptr)));
> +	OUT_RING(ring, lower_32_bits(ttbr));
> +	OUT_RING(ring, (0 << 16) | upper_32_bits(ttbr));
why (0 << 16) is required here?
> +
> +	/*
> +	 * And finally, trigger a uche flush to be sure there isn't anything
> +	 * lingering in that part of the GPU
> +	 */
> +
> +	OUT_PKT7(ring, CP_EVENT_WRITE, 1);
> +	OUT_RING(ring, 0x31);
This may be unnecessary, but no harm in keeping it. SMMU_TABLE_UPDATE is 
supposed to do a UCHE flush.

-Akhil
> +
> +	a6xx_gpu->cur_ctx = ctx;
> +}
> +
>   static void a6xx_submit(struct msm_gpu *gpu, struct msm_gem_submit *submit)
>   {
>   	unsigned int index = submit->seqno % MSM_GPU_SUBMIT_STATS_COUNT;
> @@ -90,6 +140,8 @@ static void a6xx_submit(struct msm_gpu *gpu, struct msm_gem_submit *submit)
>   	struct msm_ringbuffer *ring = submit->ring;
>   	unsigned int i;
>   
> +	a6xx_set_pagetable(a6xx_gpu, ring, submit->queue->ctx);
> +
>   	get_stats_counter(ring, REG_A6XX_RBBM_PERFCTR_CP_0_LO,
>   		rbmemptr_stats(ring, index, cpcycles_start));
>   
> @@ -696,6 +748,8 @@ static int a6xx_hw_init(struct msm_gpu *gpu)
>   	/* Always come up on rb 0 */
>   	a6xx_gpu->cur_ring = gpu->rb[0];
>   
> +	a6xx_gpu->cur_ctx = NULL;
> +
>   	/* Enable the SQE_to start the CP engine */
>   	gpu_write(gpu, REG_A6XX_CP_SQE_CNTL, 1);
>   
> @@ -1008,6 +1062,21 @@ static unsigned long a6xx_gpu_busy(struct msm_gpu *gpu)
>   	return (unsigned long)busy_time;
>   }
>   
> +static struct msm_gem_address_space *
> +a6xx_create_private_address_space(struct msm_gpu *gpu)
> +{
> +	struct msm_gem_address_space *aspace = NULL;
> +	struct msm_mmu *mmu;
> +
> +	mmu = msm_iommu_pagetable_create(gpu->aspace->mmu);
> +
> +	if (!IS_ERR(mmu))
> +		aspace = msm_gem_address_space_create(mmu,
> +			"gpu", 0x100000000ULL, 0x1ffffffffULL);
> +
> +	return aspace;
> +}
> +
>   static const struct adreno_gpu_funcs funcs = {
>   	.base = {
>   		.get_param = adreno_get_param,
> @@ -1031,6 +1100,7 @@ static const struct adreno_gpu_funcs funcs = {
>   		.gpu_state_put = a6xx_gpu_state_put,
>   #endif
>   		.create_address_space = adreno_iommu_create_address_space,
> +		.create_private_address_space = a6xx_create_private_address_space,
>   	},
>   	.get_timestamp = a6xx_get_timestamp,
>   };
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
> index 03ba60d5b07f..da22d7549d9b 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
> @@ -19,6 +19,7 @@ struct a6xx_gpu {
>   	uint64_t sqe_iova;
>   
>   	struct msm_ringbuffer *cur_ring;
> +	struct msm_file_private *cur_ctx;
>   
>   	struct a6xx_gmu gmu;
>   };
> diff --git a/drivers/gpu/drm/msm/msm_ringbuffer.h b/drivers/gpu/drm/msm/msm_ringbuffer.h
> index 7764373d0ed2..0987d6bf848c 100644
> --- a/drivers/gpu/drm/msm/msm_ringbuffer.h
> +++ b/drivers/gpu/drm/msm/msm_ringbuffer.h
> @@ -31,6 +31,7 @@ struct msm_rbmemptrs {
>   	volatile uint32_t fence;
>   
>   	volatile struct msm_gpu_submit_stats stats[MSM_GPU_SUBMIT_STATS_COUNT];
> +	volatile u64 ttbr0;
>   };
>   
>   struct msm_ringbuffer {
> 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
