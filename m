Return-Path: <SRS0=kAxJ=B4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8426C433DF
	for <iommu@archiver.kernel.org>; Tue, 18 Aug 2020 10:11:05 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7633E207DF
	for <iommu@archiver.kernel.org>; Tue, 18 Aug 2020 10:11:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="IwGU1YGV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7633E207DF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 4DEE286094;
	Tue, 18 Aug 2020 10:11:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id o6MFpluUQNaG; Tue, 18 Aug 2020 10:10:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id C224A86294;
	Tue, 18 Aug 2020 10:10:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A92A1C089F;
	Tue, 18 Aug 2020 10:10:58 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9D665C0894
 for <iommu@lists.linux-foundation.org>; Tue, 18 Aug 2020 10:10:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 89B3784518
 for <iommu@lists.linux-foundation.org>; Tue, 18 Aug 2020 10:10:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id m5OuNg_4uoxD for <iommu@lists.linux-foundation.org>;
 Tue, 18 Aug 2020 10:10:55 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from m43-7.mailgun.net (m43-7.mailgun.net [69.72.43.7])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 2D1728462E
 for <iommu@lists.linux-foundation.org>; Tue, 18 Aug 2020 10:10:53 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1597745455; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=cMiPEOYAp7lCAutY0bCyWT5k1cICbkV3n89hqvcObrw=;
 b=IwGU1YGVKwmS6zcaYgHlU9H/MvA3/Oc9DeGiWKVy9cNEc5NAi4rO3EknXgWyddUPUoJdt6/C
 QmJB08Po10yAq1B2lA+shns2U0oIqUGaEOzdJ2DUCIQf1V5oXkaLPk93GcbgwQy417E/a1zF
 WQ1Tfl9Pnv0CSZ4Vdkg9TKdq3Ow=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3NDkwMCIsICJpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 5f3ba912cbcd42bdee71c5fc (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 18 Aug 2020 10:10:26
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id 6EE6FC4339C; Tue, 18 Aug 2020 10:10:25 +0000 (UTC)
Received: from [192.168.1.7] (unknown [59.99.218.195])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: akhilpo)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 08D03C433C6;
 Tue, 18 Aug 2020 10:10:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 08D03C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 spf=none smtp.mailfrom=akhilpo@codeaurora.org
Subject: Re: [PATCH 16/20] drm/msm/a6xx: Add support for per-instance
 pagetables
To: Rob Clark <robdclark@gmail.com>, dri-devel@lists.freedesktop.org,
 iommu@lists.linux-foundation.org, linux-arm-msm@vger.kernel.org
References: <20200817220238.603465-1-robdclark@gmail.com>
 <20200817220238.603465-17-robdclark@gmail.com>
From: Akhil P Oommen <akhilpo@codeaurora.org>
Message-ID: <e10e295a-7022-8250-f01d-dbf4ba98e786@codeaurora.org>
Date: Tue, 18 Aug 2020 15:40:15 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200817220238.603465-17-robdclark@gmail.com>
Content-Language: en-US
Cc: Rob Clark <robdclark@chromium.org>, Daniel Vetter <daniel@ffwll.ch>,
 Jonathan Marek <jonathan@marek.ca>, Eric Anholt <eric@anholt.net>,
 David Airlie <airlied@linux.ie>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Sean Paul <sean@poorly.run>,
 Sibi Sankar <sibis@codeaurora.org>, Vivek Gautam <vivek.gautam@codeaurora.org>,
 Stephen Boyd <swboyd@chromium.org>, freedreno@lists.freedesktop.org,
 Sharat Masetty <smasetty@codeaurora.org>,
 open list <linux-kernel@vger.kernel.org>
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

Reviewed-by: Akhil P Oommen <akhilpo@codeaurora.org>

On 8/18/2020 3:31 AM, Rob Clark wrote:
> From: Jordan Crouse <jcrouse@codeaurora.org>
> 
> Add support for using per-instance pagetables if all the dependencies are
> available.
> 
> Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
>   drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 63 +++++++++++++++++++++++++++
>   drivers/gpu/drm/msm/adreno/a6xx_gpu.h |  1 +
>   drivers/gpu/drm/msm/msm_ringbuffer.h  |  1 +
>   3 files changed, 65 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> index 5eabb0109577..d7ad6c78d787 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> @@ -81,6 +81,49 @@ static void get_stats_counter(struct msm_ringbuffer *ring, u32 counter,
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
> +	OUT_RING(ring,
> +		CP_SMMU_TABLE_UPDATE_1_TTBR0_HI(upper_32_bits(ttbr)) |
> +		CP_SMMU_TABLE_UPDATE_1_ASID(asid));
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
> +	OUT_RING(ring, (asid << 16) | upper_32_bits(ttbr));
> +
> +	/*
> +	 * And finally, trigger a uche flush to be sure there isn't anything
> +	 * lingering in that part of the GPU
> +	 */
> +
> +	OUT_PKT7(ring, CP_EVENT_WRITE, 1);
> +	OUT_RING(ring, 0x31);
> +
> +	a6xx_gpu->cur_ctx = ctx;
> +}
> +
>   static void a6xx_submit(struct msm_gpu *gpu, struct msm_gem_submit *submit)
>   {
>   	unsigned int index = submit->seqno % MSM_GPU_SUBMIT_STATS_COUNT;
> @@ -90,6 +133,8 @@ static void a6xx_submit(struct msm_gpu *gpu, struct msm_gem_submit *submit)
>   	struct msm_ringbuffer *ring = submit->ring;
>   	unsigned int i;
>   
> +	a6xx_set_pagetable(a6xx_gpu, ring, submit->queue->ctx);
> +
>   	get_stats_counter(ring, REG_A6XX_RBBM_PERFCTR_CP_0_LO,
>   		rbmemptr_stats(ring, index, cpcycles_start));
>   
> @@ -696,6 +741,8 @@ static int a6xx_hw_init(struct msm_gpu *gpu)
>   	/* Always come up on rb 0 */
>   	a6xx_gpu->cur_ring = gpu->rb[0];
>   
> +	a6xx_gpu->cur_ctx = NULL;
> +
>   	/* Enable the SQE_to start the CP engine */
>   	gpu_write(gpu, REG_A6XX_CP_SQE_CNTL, 1);
>   
> @@ -1008,6 +1055,21 @@ static unsigned long a6xx_gpu_busy(struct msm_gpu *gpu)
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
> @@ -1031,6 +1093,7 @@ static const struct adreno_gpu_funcs funcs = {
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
