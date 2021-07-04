Return-Path: <SRS0=1ePL=L4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E483C07E96
	for <iommu@archiver.kernel.org>; Sun,  4 Jul 2021 18:16:47 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D879361364
	for <iommu@archiver.kernel.org>; Sun,  4 Jul 2021 18:16:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D879361364
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A22B640156;
	Sun,  4 Jul 2021 18:16:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bAqOLaqIACuS; Sun,  4 Jul 2021 18:16:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 82889400C4;
	Sun,  4 Jul 2021 18:16:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 63864C0010;
	Sun,  4 Jul 2021 18:16:45 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A1BCBC000E
 for <iommu@lists.linux-foundation.org>; Sun,  4 Jul 2021 18:16:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7C4D4605E4
 for <iommu@lists.linux-foundation.org>; Sun,  4 Jul 2021 18:16:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vxUMHtVYcJDQ for <iommu@lists.linux-foundation.org>;
 Sun,  4 Jul 2021 18:16:43 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6528A605C5
 for <iommu@lists.linux-foundation.org>; Sun,  4 Jul 2021 18:16:43 +0000 (UTC)
Received: by mail-wr1-x429.google.com with SMTP id n9so1864836wrs.13
 for <iommu@lists.linux-foundation.org>; Sun, 04 Jul 2021 11:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=miJU8b04qqipglFSfedfahzFO5P9/VuRwGLqZ5UonxA=;
 b=sadO98ciWj/6FqhCdSiYXg7eS3ipmrZ2bwJ3FAXgaAhoWhBPzbV+zMvsaChj7gP23C
 XQOkPXd65OjjNPZV2rIXp01e4FU2+nPoiCNBvlXmy2xzEoywupkzZOOHdpEMUja8I8SE
 AJE1Z/TmWfXPFtm3dCvO+aBBikKGryJ02zyI6zQ36zWIn2xzpIZIyeDCldXgjbT0Z3OX
 d0Ixb1PoaQ7zDQxIMg2Xwg5ji1KII2FugaR6OkpGiUs883u0ABnlYYgHI0GJGopadw16
 0eEMhd+B6iHPdg/LHOnlapBeFV3jJ64GeQ7rTPEMVgyYkxIhrc5HS9fW1VCQyoyUniAI
 +daQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=miJU8b04qqipglFSfedfahzFO5P9/VuRwGLqZ5UonxA=;
 b=QrQ/JEy0+EQ5RxDO9mPsOCMH0NY3mMuqItucy3TXmswxt83W6avsGFtDkv3SuQT/ot
 wWUDpjOC9FBpvJykA63p2By4jTWyJFoiSaYM+229smcht1OXJifSLj6TV/SnrujiEoAu
 beQhamSO1SkTcZjd3piQZb/YbYWe7ni9Q3brVXLmuf2BWp4R8yS5YF+WF9Svc2uv6OKu
 Ii10taH08ZjOuz0169vc2RZlVfxPO7gi3ThQGwGNAFm0p9tekPJBbUl19W/qmcmhCqgW
 c8dagSO/jwBwvsQ7mOlmeUeDK5gEQEnvr5GcfjQrfeVfPqqludG/4B0sLpb+SdpjMpge
 tX8A==
X-Gm-Message-State: AOAM530o5StFCDgrEjO9v4yZHNh6PzuSRnryxhZLR7Z0hJh/rUC1KCtD
 VEqs6aPxYmq5l4UOos5hQLgZehkry2Ou3X8hrrM=
X-Google-Smtp-Source: ABdhPJybAZlml4By7IUmHm+CwJj4AogiRenrlTNVsLwz2P5TR+I4uckHpD3LeJoevYMRoITwkCKKpvPkU3Zix9MNJIY=
X-Received: by 2002:adf:f48e:: with SMTP id l14mr7294511wro.28.1625422601605; 
 Sun, 04 Jul 2021 11:16:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210610214431.539029-1-robdclark@gmail.com>
 <2016473f-2b38-f049-1e8d-04bdf5af6cea@linaro.org>
In-Reply-To: <2016473f-2b38-f049-1e8d-04bdf5af6cea@linaro.org>
From: Rob Clark <robdclark@gmail.com>
Date: Sun, 4 Jul 2021 11:20:43 -0700
Message-ID: <CAF6AEGu6Wt+FDh_Kp8GrZB9TV7ufTuidmqBfkzA9rcCJc7zSQQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/5] iommu/arm-smmu: adreno-smmu page fault handling
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Konrad Dybcio <konrad.dybcio@somainline.org>,
 Akhil P Oommen <akhilpo@codeaurora.org>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 open list <linux-kernel@vger.kernel.org>, Eric Anholt <eric@anholt.net>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Lee Jones <lee.jones@linaro.org>, Rob Clark <robdclark@chromium.org>,
 Jonathan Marek <jonathan@marek.ca>, Will Deacon <will@kernel.org>,
 Zhenzhong Duan <zhenzhong.duan@gmail.com>, Joerg Roedel <jroedel@suse.de>,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 Sharat Masetty <smasetty@codeaurora.org>, John Stultz <john.stultz@linaro.org>,
 "moderated list:ARM SMMU DRIVERS" <linux-arm-kernel@lists.infradead.org>,
 "Isaac J. Manjarres" <isaacm@codeaurora.org>,
 Robin Murphy <robin.murphy@arm.com>, Douglas Anderson <dianders@chromium.org>,
 "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
 "Kristian H. Kristensen" <hoegsberg@google.com>,
 freedreno <freedreno@lists.freedesktop.org>
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

I suspect you are getting a dpu fault, and need:

https://lore.kernel.org/linux-arm-msm/CAF6AEGvTjTUQXqom-xhdh456tdLscbVFPQ+iud1H1gHc8A2=hA@mail.gmail.com/

I suppose Bjorn was expecting me to send that patch

BR,
-R

On Sun, Jul 4, 2021 at 5:53 AM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> Hi,
>
> I've had splash screen disabled on my RB3. However once I've enabled it,
> I've got the attached crash during the boot on the msm/msm-next. It
> looks like it is related to this particular set of changes.
>
> On 11/06/2021 00:44, Rob Clark wrote:
> > From: Rob Clark <robdclark@chromium.org>
> >
> > This picks up an earlier series[1] from Jordan, and adds additional
> > support needed to generate GPU devcore dumps on iova faults.  Original
> > description:
> >
> > This is a stack to add an Adreno GPU specific handler for pagefaults. The first
> > patch starts by wiring up report_iommu_fault for arm-smmu. The next patch adds
> > a adreno-smmu-priv function hook to capture a handful of important debugging
> > registers such as TTBR0, CONTEXTIDR, FSYNR0 and others. This is used by the
> > third patch to print more detailed information on page fault such as the TTBR0
> > for the pagetable that caused the fault and the source of the fault as
> > determined by a combination of the FSYNR1 register and an internal GPU
> > register.
> >
> > This code provides a solid base that we can expand on later for even more
> > extensive GPU side page fault debugging capabilities.
> >
> > v5: [Rob] Use RBBM_STATUS3.SMMU_STALLED_ON_FAULT to detect case where
> >      GPU snapshotting needs to avoid crashdumper, and check the
> >      RBBM_STATUS3.SMMU_STALLED_ON_FAULT in GPU hang irq paths
> > v4: [Rob] Add support to stall SMMU on fault, and let the GPU driver
> >      resume translation after it has had a chance to snapshot the GPUs
> >      state
> > v3: Always clear FSR even if the target driver is going to handle resume
> > v2: Fix comment wording and function pointer check per Rob Clark
> >
> > [1] https://lore.kernel.org/dri-devel/20210225175135.91922-1-jcrouse@codeaurora.org/
> >
> > Jordan Crouse (3):
> >    iommu/arm-smmu: Add support for driver IOMMU fault handlers
> >    iommu/arm-smmu-qcom: Add an adreno-smmu-priv callback to get pagefault
> >      info
> >    drm/msm: Improve the a6xx page fault handler
> >
> > Rob Clark (2):
> >    iommu/arm-smmu-qcom: Add stall support
> >    drm/msm: devcoredump iommu fault support
> >
> >   drivers/gpu/drm/msm/adreno/a5xx_gpu.c       |  23 +++-
> >   drivers/gpu/drm/msm/adreno/a6xx_gpu.c       | 110 +++++++++++++++++++-
> >   drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c |  42 ++++++--
> >   drivers/gpu/drm/msm/adreno/adreno_gpu.c     |  15 +++
> >   drivers/gpu/drm/msm/msm_gem.h               |   1 +
> >   drivers/gpu/drm/msm/msm_gem_submit.c        |   1 +
> >   drivers/gpu/drm/msm/msm_gpu.c               |  48 +++++++++
> >   drivers/gpu/drm/msm/msm_gpu.h               |  17 +++
> >   drivers/gpu/drm/msm/msm_gpummu.c            |   5 +
> >   drivers/gpu/drm/msm/msm_iommu.c             |  22 +++-
> >   drivers/gpu/drm/msm/msm_mmu.h               |   5 +-
> >   drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c  |  50 +++++++++
> >   drivers/iommu/arm/arm-smmu/arm-smmu.c       |   9 +-
> >   drivers/iommu/arm/arm-smmu/arm-smmu.h       |   2 +
> >   include/linux/adreno-smmu-priv.h            |  38 ++++++-
> >   15 files changed, 367 insertions(+), 21 deletions(-)
> >
>
>
> --
> With best wishes
> Dmitry
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
