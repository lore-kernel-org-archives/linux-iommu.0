Return-Path: <SRS0=hcXW=7Z=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6561DC433DF
	for <iommu@archiver.kernel.org>; Fri, 12 Jun 2020 03:22:09 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB6AA2078C
	for <iommu@archiver.kernel.org>; Fri, 12 Jun 2020 03:22:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hPVYoqh8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB6AA2078C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 8DED288500;
	Fri, 12 Jun 2020 03:22:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aWqz2f0YDktW; Fri, 12 Jun 2020 03:22:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 7996388432;
	Fri, 12 Jun 2020 03:22:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5C0FCC0865;
	Fri, 12 Jun 2020 03:22:07 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1A99AC016F
 for <iommu@lists.linux-foundation.org>; Fri, 12 Jun 2020 03:22:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 0F9F188BA8
 for <iommu@lists.linux-foundation.org>; Fri, 12 Jun 2020 03:22:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yFMVZOrh1MuE for <iommu@lists.linux-foundation.org>;
 Fri, 12 Jun 2020 03:22:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ej1-f66.google.com (mail-ej1-f66.google.com
 [209.85.218.66])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 0FED588B83
 for <iommu@lists.linux-foundation.org>; Fri, 12 Jun 2020 03:22:05 +0000 (UTC)
Received: by mail-ej1-f66.google.com with SMTP id n24so8661512ejd.0
 for <iommu@lists.linux-foundation.org>; Thu, 11 Jun 2020 20:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=B4Mrm1gIXHBqQrJzDMxE7hny1sPLrSiwXYO/60LCrf4=;
 b=hPVYoqh8jPs/l54Gc1r4kVaNzjMB73wKzEjspttHVKjphYyFYBNLvFvhAQHgCVuMXD
 UrW+7t7+BjCCRAb619IpW+4HHRVsgemrpBPTZgHjC/3gzR+obgnFNZvECSNXA9/pCqXz
 HhQmCLyRPV4bDpj/WbkqT06lRQ5NGJDrYyClx7y0Pw1u1IrVuE89/OQi/G/Xfxj2P6/A
 q50xVFJ9qf09Fj3gXSwSGq/TCkNbFQz1FMxOxyxexgyiUDja4LM8/ZfhMrlDakdtj+7B
 mLQMDgcvIZWW4w4wgQpH4a5uPbkhNBMMS2LzQSmi1fC6hyZj/87JizBAF+eT4jMoDrjk
 jv8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=B4Mrm1gIXHBqQrJzDMxE7hny1sPLrSiwXYO/60LCrf4=;
 b=VyMVzCN3z5zu35G3o5ZhABfIN6Xqx4VqS64L0p2sv80VXmO9lstPv3LryuuAsopnSM
 5/dUSRd7l53vinWldAOC4ILGJE6lqvUOnr2u8jMEym2V5/Gj4csD7ZSbc/tQDoub59+D
 RikY9k41+kXtS5rAgoql/1WB1Ur47oF63tpK1U2UF94T6CKWNtQ2WAQHDHtcURhtgMT2
 ZsdyiQ5kkvd6zcVKwA6lGlGFQidhBoGHqtiw11783ttNkf5vGdw3Gh9oJVoHGuOgunu+
 smFcH8e7cIHRmL29+XS/FNvrTySWaPwvCE4vcIFwQw7/yylfHkpEsbf9i+1FnTag0h7y
 hECw==
X-Gm-Message-State: AOAM53123tpqGSI6upD658oddUM3OfjPNjwXTKqu7MAxbeq4UMOwD7bd
 TOyySi4X9A6fWJcx3xs1Jhwl6o1CYe/oYFmst9k=
X-Google-Smtp-Source: ABdhPJyzNHPsnPsZMtc0S9NLfKpqe1fzAhLdA7GvVWT23D3A2fUYLq5KDR2bpDt/AdIyu5RKOlbarT8SJfsSUirryUA=
X-Received: by 2002:a17:906:1088:: with SMTP id
 u8mr11881278eju.428.1591932123108; 
 Thu, 11 Jun 2020 20:22:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200611222921.464-1-jcrouse@codeaurora.org>
 <20200611222921.464-7-jcrouse@codeaurora.org>
In-Reply-To: <20200611222921.464-7-jcrouse@codeaurora.org>
From: Rob Clark <robdclark@gmail.com>
Date: Thu, 11 Jun 2020 20:22:29 -0700
Message-ID: <CAF6AEGuyqgYKZsnBPCii4W=jxPcFU7JYKn4NBd8JVq7Pt1kR_Q@mail.gmail.com>
Subject: Re: [PATCH 6/6] drm/msm/a6xx: Add support for per-instance pagetables
To: Jordan Crouse <jcrouse@codeaurora.org>
Cc: Sean Paul <sean@poorly.run>, Jonathan Marek <jonathan@marek.ca>,
 David Airlie <airlied@linux.ie>, linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 Sharat Masetty <smasetty@codeaurora.org>,
 Akhil P Oommen <akhilpo@codeaurora.org>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Eric Anholt <eric@anholt.net>,
 "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
 Daniel Vetter <daniel@ffwll.ch>, freedreno <freedreno@lists.freedesktop.org>
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

On Thu, Jun 11, 2020 at 3:29 PM Jordan Crouse <jcrouse@codeaurora.org> wrote:
>
> Add support for using per-instance pagetables if all the dependencies are
> available.
>
> Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
> ---
>
>  drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 69 ++++++++++++++++++++++++++-
>  drivers/gpu/drm/msm/msm_ringbuffer.h  |  1 +
>  2 files changed, 69 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> index a1589e040c57..5e82b85d4d55 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> @@ -79,6 +79,58 @@ static void get_stats_counter(struct msm_ringbuffer *ring, u32 counter,
>         OUT_RING(ring, upper_32_bits(iova));
>  }
>
> +static void a6xx_set_pagetable(struct msm_gpu *gpu, struct msm_ringbuffer *ring,
> +               struct msm_file_private *ctx)
> +{
> +       phys_addr_t ttbr;
> +       u32 asid;
> +
> +       if (msm_iommu_pagetable_params(ctx->aspace->mmu, &ttbr, &asid))
> +               return;
> +
> +       OUT_PKT7(ring, CP_SET_PROTECTED_MODE, 1);
> +       OUT_RING(ring, 0);
> +
> +       /* Turn on APIV mode to access critical regions */
> +       OUT_PKT4(ring, REG_A6XX_CP_MISC_CNTL, 1);
> +       OUT_RING(ring, 1);
> +
> +       /* Make sure the ME is synchronized before staring the update */
> +       OUT_PKT7(ring, CP_WAIT_FOR_ME, 0);
> +
> +       /* Execute the table update */
> +       OUT_PKT7(ring, CP_SMMU_TABLE_UPDATE, 4);
> +       OUT_RING(ring, lower_32_bits(ttbr));
> +       OUT_RING(ring, (((u64) asid) << 48) | upper_32_bits(ttbr));
> +       /* CONTEXTIDR is currently unused */
> +       OUT_RING(ring, 0);
> +       /* CONTEXTBANK is currently unused */
> +       OUT_RING(ring, 0);

I can add this to xml (on userspace side, we've been describing packet
payload in xml and using the generated builders), and update generated
headers, if you agree to not add more open-coded pkt7 building ;-)

> +
> +       /*
> +        * Write the new TTBR0 to the memstore. This is good for debugging.
> +        */
> +       OUT_PKT7(ring, CP_MEM_WRITE, 4);
> +       OUT_RING(ring, lower_32_bits(rbmemptr(ring, ttbr0)));
> +       OUT_RING(ring, upper_32_bits(rbmemptr(ring, ttbr0)));
> +       OUT_RING(ring, lower_32_bits(ttbr));
> +       OUT_RING(ring, (((u64) asid) << 48) | upper_32_bits(ttbr));
> +
> +       /* Invalidate the draw state so we start off fresh */
> +       OUT_PKT7(ring, CP_SET_DRAW_STATE, 3);
> +       OUT_RING(ring, 0x40000);
> +       OUT_RING(ring, 1);
> +       OUT_RING(ring, 0);

Ie, this would look like:

    OUT_PKT7(ring, CP_SET_DRAW_STATE, 3);
    OUT_RING(ring, CP_SET_DRAW_STATE__0_COUNT(0) |
            CP_SET_DRAW_STATE__0_DISABLE_ALL_GROUPS |
            CP_SET_DRAW_STATE__0_GROUP_ID(0));
    OUT_RING(ring, CP_SET_DRAW_STATE__1_ADDR_LO(1));
    OUT_RING(ring, CP_SET_DRAW_STATE__2_ADDR_HI(0));

.. but written that way, I think you meant ADDR_LO to be zero?

(it is possible we need to regen headers for that to work, the kernel
headers are somewhat out of date by now)

BR,
-R

> +
> +       /* Turn off APRIV */
> +       OUT_PKT4(ring, REG_A6XX_CP_MISC_CNTL, 1);
> +       OUT_RING(ring, 0);
> +
> +       /* Turn off protected mode */
> +       OUT_PKT7(ring, CP_SET_PROTECTED_MODE, 1);
> +       OUT_RING(ring, 1);
> +}
> +
>  static void a6xx_submit(struct msm_gpu *gpu, struct msm_gem_submit *submit,
>         struct msm_file_private *ctx)
>  {
> @@ -89,6 +141,8 @@ static void a6xx_submit(struct msm_gpu *gpu, struct msm_gem_submit *submit,
>         struct msm_ringbuffer *ring = submit->ring;
>         unsigned int i;
>
> +       a6xx_set_pagetable(gpu, ring, ctx);
> +
>         get_stats_counter(ring, REG_A6XX_RBBM_PERFCTR_CP_0_LO,
>                 rbmemptr_stats(ring, index, cpcycles_start));
>
> @@ -872,6 +926,18 @@ static unsigned long a6xx_gpu_busy(struct msm_gpu *gpu)
>         return (unsigned long)busy_time;
>  }
>
> +struct msm_gem_address_space *a6xx_address_space_instance(struct msm_gpu *gpu)
> +{
> +       struct msm_mmu *mmu;
> +
> +       mmu = msm_iommu_pagetable_create(gpu->aspace->mmu);
> +       if (IS_ERR(mmu))
> +               return msm_gem_address_space_get(gpu->aspace);
> +
> +       return msm_gem_address_space_create(mmu,
> +               "gpu", 0x100000000ULL, 0x1ffffffffULL);
> +}
> +
>  static const struct adreno_gpu_funcs funcs = {
>         .base = {
>                 .get_param = adreno_get_param,
> @@ -893,8 +959,9 @@ static const struct adreno_gpu_funcs funcs = {
>  #if defined(CONFIG_DRM_MSM_GPU_STATE)
>                 .gpu_state_get = a6xx_gpu_state_get,
>                 .gpu_state_put = a6xx_gpu_state_put,
> -               .create_address_space = adreno_iommu_create_address_space,
>  #endif
> +               .create_address_space = adreno_iommu_create_address_space,
> +               .address_space_instance = a6xx_address_space_instance,
>         },
>         .get_timestamp = a6xx_get_timestamp,
>  };
> diff --git a/drivers/gpu/drm/msm/msm_ringbuffer.h b/drivers/gpu/drm/msm/msm_ringbuffer.h
> index 7764373d0ed2..0987d6bf848c 100644
> --- a/drivers/gpu/drm/msm/msm_ringbuffer.h
> +++ b/drivers/gpu/drm/msm/msm_ringbuffer.h
> @@ -31,6 +31,7 @@ struct msm_rbmemptrs {
>         volatile uint32_t fence;
>
>         volatile struct msm_gpu_submit_stats stats[MSM_GPU_SUBMIT_STATS_COUNT];
> +       volatile u64 ttbr0;
>  };
>
>  struct msm_ringbuffer {
> --
> 2.17.1
>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
