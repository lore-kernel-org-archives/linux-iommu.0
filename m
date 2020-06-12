Return-Path: <SRS0=hcXW=7Z=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70E19C433E0
	for <iommu@archiver.kernel.org>; Fri, 12 Jun 2020 17:22:15 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16526207ED
	for <iommu@archiver.kernel.org>; Fri, 12 Jun 2020 17:22:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="IKPjfmlQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16526207ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id C9A5888B0C;
	Fri, 12 Jun 2020 17:22:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nYAXKiW8Ga9b; Fri, 12 Jun 2020 17:22:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 66E0A88A11;
	Fri, 12 Jun 2020 17:22:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4BF1CC0178;
	Fri, 12 Jun 2020 17:22:13 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0E07AC016F
 for <iommu@lists.linux-foundation.org>; Fri, 12 Jun 2020 17:22:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id EEDDB888EA
 for <iommu@lists.linux-foundation.org>; Fri, 12 Jun 2020 17:22:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Jo3a-TtLV9kB for <iommu@lists.linux-foundation.org>;
 Fri, 12 Jun 2020 17:22:11 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from m43-7.mailgun.net (m43-7.mailgun.net [69.72.43.7])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 544A588A11
 for <iommu@lists.linux-foundation.org>; Fri, 12 Jun 2020 17:22:06 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1591982531; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Cc: To: From: Date: Sender;
 bh=fWknkGYfbRq73n5akkvEQmXOR+Mhuj3iaaByL0gFj24=;
 b=IKPjfmlQFIdR6v+tOSAjhKTtgURUIR1NMYvXo4zDTH13k6dr0P3y7KNaAZwJzk87wIMIbAcm
 xwo50J5IjNvrHR1M6AMzh1oidJkLqmqv/TqSRtsTgVRq5nyRphBHpXXSojIULjgfFjQHELXe
 6QbUtdLxYEGCYAGoNB6OgSxpdO0=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3NDkwMCIsICJpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n15.prod.us-east-1.postgun.com with SMTP id
 5ee3b9b68fe116ddd972fe34 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 12 Jun 2020 17:21:58
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id 1FDB8C433AF; Fri, 12 Jun 2020 17:21:57 +0000 (UTC)
Received: from jcrouse1-lnx.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: jcrouse)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id D60C1C43391;
 Fri, 12 Jun 2020 17:21:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D60C1C43391
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 spf=none smtp.mailfrom=jcrouse@codeaurora.org
Date: Fri, 12 Jun 2020 11:21:51 -0600
From: Jordan Crouse <jcrouse@codeaurora.org>
To: Rob Clark <robdclark@gmail.com>
Subject: Re: [PATCH 6/6] drm/msm/a6xx: Add support for per-instance pagetables
Message-ID: <20200612172151.GA12783@jcrouse1-lnx.qualcomm.com>
Mail-Followup-To: Rob Clark <robdclark@gmail.com>,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 freedreno <freedreno@lists.freedesktop.org>,
 "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>, 
 Akhil P Oommen <akhilpo@codeaurora.org>,
 Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
 Eric Anholt <eric@anholt.net>, Jonathan Marek <jonathan@marek.ca>,
 Sean Paul <sean@poorly.run>,
 Sharat Masetty <smasetty@codeaurora.org>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20200611222921.464-1-jcrouse@codeaurora.org>
 <20200611222921.464-7-jcrouse@codeaurora.org>
 <CAF6AEGuyqgYKZsnBPCii4W=jxPcFU7JYKn4NBd8JVq7Pt1kR_Q@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAF6AEGuyqgYKZsnBPCii4W=jxPcFU7JYKn4NBd8JVq7Pt1kR_Q@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
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

On Thu, Jun 11, 2020 at 08:22:29PM -0700, Rob Clark wrote:
> On Thu, Jun 11, 2020 at 3:29 PM Jordan Crouse <jcrouse@codeaurora.org> wrote:
> >
> > Add support for using per-instance pagetables if all the dependencies are
> > available.
> >
> > Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
> > ---
> >
> >  drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 69 ++++++++++++++++++++++++++-
> >  drivers/gpu/drm/msm/msm_ringbuffer.h  |  1 +
> >  2 files changed, 69 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> > index a1589e040c57..5e82b85d4d55 100644
> > --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> > +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> > @@ -79,6 +79,58 @@ static void get_stats_counter(struct msm_ringbuffer *ring, u32 counter,
> >         OUT_RING(ring, upper_32_bits(iova));
> >  }
> >
> > +static void a6xx_set_pagetable(struct msm_gpu *gpu, struct msm_ringbuffer *ring,
> > +               struct msm_file_private *ctx)
> > +{
> > +       phys_addr_t ttbr;
> > +       u32 asid;
> > +
> > +       if (msm_iommu_pagetable_params(ctx->aspace->mmu, &ttbr, &asid))
> > +               return;
> > +
> > +       OUT_PKT7(ring, CP_SET_PROTECTED_MODE, 1);
> > +       OUT_RING(ring, 0);
> > +
> > +       /* Turn on APIV mode to access critical regions */
> > +       OUT_PKT4(ring, REG_A6XX_CP_MISC_CNTL, 1);
> > +       OUT_RING(ring, 1);
> > +
> > +       /* Make sure the ME is synchronized before staring the update */
> > +       OUT_PKT7(ring, CP_WAIT_FOR_ME, 0);
> > +
> > +       /* Execute the table update */
> > +       OUT_PKT7(ring, CP_SMMU_TABLE_UPDATE, 4);
> > +       OUT_RING(ring, lower_32_bits(ttbr));
> > +       OUT_RING(ring, (((u64) asid) << 48) | upper_32_bits(ttbr));
> > +       /* CONTEXTIDR is currently unused */
> > +       OUT_RING(ring, 0);
> > +       /* CONTEXTBANK is currently unused */
> > +       OUT_RING(ring, 0);
> 
> I can add this to xml (on userspace side, we've been describing packet
> payload in xml and using the generated builders), and update generated
> headers, if you agree to not add more open-coded pkt7 building ;-)

But open coding opcode is so much fun! :)  Its fine to put this in the XML. It
can only be executed from the ringbuffer FWIW.

> > +
> > +       /*
> > +        * Write the new TTBR0 to the memstore. This is good for debugging.
> > +        */
> > +       OUT_PKT7(ring, CP_MEM_WRITE, 4);
> > +       OUT_RING(ring, lower_32_bits(rbmemptr(ring, ttbr0)));
> > +       OUT_RING(ring, upper_32_bits(rbmemptr(ring, ttbr0)));
> > +       OUT_RING(ring, lower_32_bits(ttbr));
> > +       OUT_RING(ring, (((u64) asid) << 48) | upper_32_bits(ttbr));
> > +
> > +       /* Invalidate the draw state so we start off fresh */
> > +       OUT_PKT7(ring, CP_SET_DRAW_STATE, 3);
> > +       OUT_RING(ring, 0x40000);
> > +       OUT_RING(ring, 1);
> > +       OUT_RING(ring, 0);
> 
> Ie, this would look like:
> 
>     OUT_PKT7(ring, CP_SET_DRAW_STATE, 3);
>     OUT_RING(ring, CP_SET_DRAW_STATE__0_COUNT(0) |
>             CP_SET_DRAW_STATE__0_DISABLE_ALL_GROUPS |
>             CP_SET_DRAW_STATE__0_GROUP_ID(0));
>     OUT_RING(ring, CP_SET_DRAW_STATE__1_ADDR_LO(1));
>     OUT_RING(ring, CP_SET_DRAW_STATE__2_ADDR_HI(0));
> 
> .. but written that way, I think you meant ADDR_LO to be zero?
> 
> (it is possible we need to regen headers for that to work, the kernel
> headers are somewhat out of date by now)

As we discussed on IRC this bit isn't needed because the CP_SMMU_TABLE_UPDATE
handles it for us.  I'll remove that.

> BR,
> -R

Jordan

> > +
> > +       /* Turn off APRIV */
> > +       OUT_PKT4(ring, REG_A6XX_CP_MISC_CNTL, 1);
> > +       OUT_RING(ring, 0);
> > +
> > +       /* Turn off protected mode */
> > +       OUT_PKT7(ring, CP_SET_PROTECTED_MODE, 1);
> > +       OUT_RING(ring, 1);
> > +}
> > +
> >  static void a6xx_submit(struct msm_gpu *gpu, struct msm_gem_submit *submit,
> >         struct msm_file_private *ctx)
> >  {
> > @@ -89,6 +141,8 @@ static void a6xx_submit(struct msm_gpu *gpu, struct msm_gem_submit *submit,
> >         struct msm_ringbuffer *ring = submit->ring;
> >         unsigned int i;
> >
> > +       a6xx_set_pagetable(gpu, ring, ctx);
> > +
> >         get_stats_counter(ring, REG_A6XX_RBBM_PERFCTR_CP_0_LO,
> >                 rbmemptr_stats(ring, index, cpcycles_start));
> >
> > @@ -872,6 +926,18 @@ static unsigned long a6xx_gpu_busy(struct msm_gpu *gpu)
> >         return (unsigned long)busy_time;
> >  }
> >
> > +struct msm_gem_address_space *a6xx_address_space_instance(struct msm_gpu *gpu)
> > +{
> > +       struct msm_mmu *mmu;
> > +
> > +       mmu = msm_iommu_pagetable_create(gpu->aspace->mmu);
> > +       if (IS_ERR(mmu))
> > +               return msm_gem_address_space_get(gpu->aspace);
> > +
> > +       return msm_gem_address_space_create(mmu,
> > +               "gpu", 0x100000000ULL, 0x1ffffffffULL);
> > +}
> > +
> >  static const struct adreno_gpu_funcs funcs = {
> >         .base = {
> >                 .get_param = adreno_get_param,
> > @@ -893,8 +959,9 @@ static const struct adreno_gpu_funcs funcs = {
> >  #if defined(CONFIG_DRM_MSM_GPU_STATE)
> >                 .gpu_state_get = a6xx_gpu_state_get,
> >                 .gpu_state_put = a6xx_gpu_state_put,
> > -               .create_address_space = adreno_iommu_create_address_space,
> >  #endif
> > +               .create_address_space = adreno_iommu_create_address_space,
> > +               .address_space_instance = a6xx_address_space_instance,
> >         },
> >         .get_timestamp = a6xx_get_timestamp,
> >  };
> > diff --git a/drivers/gpu/drm/msm/msm_ringbuffer.h b/drivers/gpu/drm/msm/msm_ringbuffer.h
> > index 7764373d0ed2..0987d6bf848c 100644
> > --- a/drivers/gpu/drm/msm/msm_ringbuffer.h
> > +++ b/drivers/gpu/drm/msm/msm_ringbuffer.h
> > @@ -31,6 +31,7 @@ struct msm_rbmemptrs {
> >         volatile uint32_t fence;
> >
> >         volatile struct msm_gpu_submit_stats stats[MSM_GPU_SUBMIT_STATS_COUNT];
> > +       volatile u64 ttbr0;
> >  };
> >
> >  struct msm_ringbuffer {
> > --
> > 2.17.1
> >

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
