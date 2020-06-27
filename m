Return-Path: <SRS0=8AL1=AI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94CA6C433E0
	for <iommu@archiver.kernel.org>; Sat, 27 Jun 2020 19:55:46 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DC242071A
	for <iommu@archiver.kernel.org>; Sat, 27 Jun 2020 19:55:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ADOMlQVg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DC242071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 248832153D;
	Sat, 27 Jun 2020 19:55:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UrYnjkmcte8U; Sat, 27 Jun 2020 19:55:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 9362221544;
	Sat, 27 Jun 2020 19:55:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7DE4EC0863;
	Sat, 27 Jun 2020 19:55:44 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E42DCC016F
 for <iommu@lists.linux-foundation.org>; Sat, 27 Jun 2020 19:55:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 8F8F221544
 for <iommu@lists.linux-foundation.org>; Sat, 27 Jun 2020 19:55:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id S+50tOXb3muR for <iommu@lists.linux-foundation.org>;
 Sat, 27 Jun 2020 19:55:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ej1-f65.google.com (mail-ej1-f65.google.com
 [209.85.218.65])
 by silver.osuosl.org (Postfix) with ESMTPS id 1855D2153D
 for <iommu@lists.linux-foundation.org>; Sat, 27 Jun 2020 19:55:42 +0000 (UTC)
Received: by mail-ej1-f65.google.com with SMTP id dp18so12471175ejc.8
 for <iommu@lists.linux-foundation.org>; Sat, 27 Jun 2020 12:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=QOPfoXRxkPWp2u0z5mv5D29mlE3sBKTSjg6aVVNHMmI=;
 b=ADOMlQVgmyn0JbKIm7nurXpb8KAlP8vwxxcUdXLQDZaEWBo6nqINqhDqQzbDVtcuGu
 dcG4BcF6ktIIdoYhiVl5rZR9ZZxfZeXAJ90oi/HD374aYjhBBXXP2XESpFGCQLGWqHg9
 4I7qe4sQPaxIiQCiotoKnAwJT7aDVwt+rPgHcQcZFt9yz+Q+3MeZsYxzD3hmtCAlj+Lt
 bzhja5CD1NZpdVH1wtlZY0s6GYPUr5PxaR4DrE0PREvMK6OGxgkPE5oXcjdEdl7UjCWO
 6PUAXoefoiHafUucYJhqJyEPgRGt4xiipf82dkDZpQspI4KGFpZSEitw43zE1Mhzm6al
 NYrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=QOPfoXRxkPWp2u0z5mv5D29mlE3sBKTSjg6aVVNHMmI=;
 b=UA+VfqSGc+WqpASLmYNMRUF/M4O7rvWcZRp0CB5/FKDI9BN7pn8w3qJmuyMI/qpGwW
 nBRTLeONr/FTTNEmOTVlv+yFOb2qOfHyUgA739x4fC/lAlloBy1oqB0f64ebOYZvpdMq
 yxqWf5iPkT2rdBm3b+vhipw2S11lPFzBRsKpZ2DLCQx/RbObHgkw13EuaEHZVIV5QeDv
 DGaUQr+YF/eaT/8l2CCfttD/xck3MyZwmpZ1O5ulI3oa43h+mu82IdawV6Xy8oiTC7Zm
 Lc3vqvg30Ktu7nNXjOaXzIQSs3hI8szdpTyqPByk6doSLXy2Zw9ea5ts5SPyI7PgFGd7
 ucJQ==
X-Gm-Message-State: AOAM532qVk/PBjusFzSpxq/IsU+LK/qfXxLOuQ7wYqNjyyd9Ox6LLpXb
 wJgsCFDpjBdZ2ePqxOyDsmK9ZayJl5IKHyKpkS4=
X-Google-Smtp-Source: ABdhPJyr67bO1u4l0SujwKghbBcBSRSMmsE0uuFjMfuxxLWVEf5xomeGYdDv+Tk2qeoHV4EBherSjl1CPzPASNo+sb4=
X-Received: by 2002:a17:906:494a:: with SMTP id
 f10mr8135393ejt.428.1593287740217; 
 Sat, 27 Jun 2020 12:55:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200626200414.14382-1-jcrouse@codeaurora.org>
 <20200626200414.14382-7-jcrouse@codeaurora.org>
In-Reply-To: <20200626200414.14382-7-jcrouse@codeaurora.org>
From: Rob Clark <robdclark@gmail.com>
Date: Sat, 27 Jun 2020 12:56:09 -0700
Message-ID: <CAF6AEGvFPtiFcBg5j3An5piPWy3Sg3=-o2k8Xzzf6anzVi9_ZA@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] drm/msm/a6xx: Add support for per-instance
 pagetables
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
 John Stultz <john.stultz@linaro.org>, Daniel Vetter <daniel@ffwll.ch>,
 freedreno <freedreno@lists.freedesktop.org>,
 Emil Velikov <emil.velikov@collabora.com>
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

On Fri, Jun 26, 2020 at 1:04 PM Jordan Crouse <jcrouse@codeaurora.org> wrote:
>
> Add support for using per-instance pagetables if all the dependencies are
> available.
>
> Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
> ---
>
>  drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 43 +++++++++++++++++++++++++++
>  drivers/gpu/drm/msm/msm_ringbuffer.h  |  1 +
>  2 files changed, 44 insertions(+)
>
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> index aa53f47b7e8b..95ed2ceac121 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> @@ -79,6 +79,34 @@ static void get_stats_counter(struct msm_ringbuffer *ring, u32 counter,
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
> +       /* Execute the table update */
> +       OUT_PKT7(ring, CP_SMMU_TABLE_UPDATE, 4);
> +       OUT_RING(ring, lower_32_bits(ttbr));
> +       OUT_RING(ring, (((u64) asid) << 48) | upper_32_bits(ttbr));
> +       /* CONTEXTIDR is currently unused */
> +       OUT_RING(ring, 0);
> +       /* CONTEXTBANK is currently unused */
> +       OUT_RING(ring, 0);
> +
> +       /*
> +        * Write the new TTBR0 to the memstore. This is good for debugging.
> +        */
> +       OUT_PKT7(ring, CP_MEM_WRITE, 4);
> +       OUT_RING(ring, lower_32_bits(rbmemptr(ring, ttbr0)));
> +       OUT_RING(ring, upper_32_bits(rbmemptr(ring, ttbr0)));
> +       OUT_RING(ring, lower_32_bits(ttbr));
> +       OUT_RING(ring, (((u64) asid) << 48) | upper_32_bits(ttbr));
> +}
> +
>  static void a6xx_submit(struct msm_gpu *gpu, struct msm_gem_submit *submit,
>         struct msm_file_private *ctx)
>  {
> @@ -89,6 +117,8 @@ static void a6xx_submit(struct msm_gpu *gpu, struct msm_gem_submit *submit,
>         struct msm_ringbuffer *ring = submit->ring;
>         unsigned int i;
>
> +       a6xx_set_pagetable(gpu, ring, ctx);
> +
>         get_stats_counter(ring, REG_A6XX_RBBM_PERFCTR_CP_0_LO,
>                 rbmemptr_stats(ring, index, cpcycles_start));
>
> @@ -872,6 +902,18 @@ static unsigned long a6xx_gpu_busy(struct msm_gpu *gpu)
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
> @@ -895,6 +937,7 @@ static const struct adreno_gpu_funcs funcs = {
>                 .gpu_state_put = a6xx_gpu_state_put,
>  #endif
>                 .create_address_space = adreno_iommu_create_address_space,
> +               .address_space_instance = a6xx_address_space_instance,

Hmm, maybe instead of .address_space_instance, something like
.create_context_address_space?

Since like .create_address_space, it is creating an address space..
the difference is that it is a per context/process aspace..

BR,
-R

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
