Return-Path: <SRS0=qe9F=AK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D87ABC433DF
	for <iommu@archiver.kernel.org>; Mon, 29 Jun 2020 14:52:34 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EC7E2337F
	for <iommu@archiver.kernel.org>; Mon, 29 Jun 2020 14:52:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="Kqx7YrA0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EC7E2337F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 783AF893C7;
	Mon, 29 Jun 2020 14:52:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2tn8bY-NBQfd; Mon, 29 Jun 2020 14:52:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 32F9B893BE;
	Mon, 29 Jun 2020 14:52:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 174ADC0865;
	Mon, 29 Jun 2020 14:52:33 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 646B1C016E
 for <iommu@lists.linux-foundation.org>; Mon, 29 Jun 2020 14:52:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 4C78B886A9
 for <iommu@lists.linux-foundation.org>; Mon, 29 Jun 2020 14:52:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JbswHGFKOwAc for <iommu@lists.linux-foundation.org>;
 Mon, 29 Jun 2020 14:52:30 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail29.static.mailgun.info (mail29.static.mailgun.info
 [104.130.122.29])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 8BE9088650
 for <iommu@lists.linux-foundation.org>; Mon, 29 Jun 2020 14:52:22 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1593442350; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Cc: To: From: Date: Sender;
 bh=SBDpthJsACP4X9l/XtUwp2evGNFSv28FhmlHvAnZ2bs=;
 b=Kqx7YrA0MbUYvOT7BpKzIwP8GE97UbXKYtu5/XnovSD9mQfEAF2WKpWiRbxUkC8jM6y6r2PR
 fbcjBX83ag0OJ1DOPdF2hdAnQq/JSDLNLgo135OAk3tX5TjZna9W4TXDEmrg3opm43mchBIJ
 sJeK+f3J2/EKfZdEZkmUhGrS29w=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3NDkwMCIsICJpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n14.prod.us-east-1.postgun.com with SMTP id
 5efa001b8fe116ddd903c468 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 29 Jun 2020 14:52:11
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id F1274C433CB; Mon, 29 Jun 2020 14:52:09 +0000 (UTC)
Received: from jcrouse1-lnx.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: jcrouse)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id A262AC433C6;
 Mon, 29 Jun 2020 14:52:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A262AC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 spf=none smtp.mailfrom=jcrouse@codeaurora.org
Date: Mon, 29 Jun 2020 08:52:04 -0600
From: Jordan Crouse <jcrouse@codeaurora.org>
To: Rob Clark <robdclark@gmail.com>
Subject: Re: [Freedreno] [PATCH v9 6/7] drm/msm: Set the global virtual
 address range from the IOMMU domain
Message-ID: <20200629145203.GB25740@jcrouse1-lnx.qualcomm.com>
Mail-Followup-To: Rob Clark <robdclark@gmail.com>,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
 David Airlie <airlied@linux.ie>, Sean Paul <sean@poorly.run>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Takashi Iwai <tiwai@suse.de>,
 "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>, 
 John Stultz <john.stultz@linaro.org>,
 Daniel Vetter <daniel@ffwll.ch>, Shawn Guo <shawn.guo@linaro.org>,
 freedreno <freedreno@lists.freedesktop.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Brian Masney <masneyb@onstation.org>
References: <20200626200042.13713-1-jcrouse@codeaurora.org>
 <20200626200042.13713-7-jcrouse@codeaurora.org>
 <CAF6AEGuNSAYNMG6CH6VMuyjiz5dfRoLWQ9OAFxPJrFmBrHe+Wg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAF6AEGuNSAYNMG6CH6VMuyjiz5dfRoLWQ9OAFxPJrFmBrHe+Wg@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Cc: freedreno <freedreno@lists.freedesktop.org>,
 David Airlie <airlied@linux.ie>, linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>, Takashi Iwai <tiwai@suse.de>,
 "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
 John Stultz <john.stultz@linaro.org>, Daniel Vetter <daniel@ffwll.ch>,
 Shawn Guo <shawn.guo@linaro.org>, Sean Paul <sean@poorly.run>,
 Brian Masney <masneyb@onstation.org>
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

On Sat, Jun 27, 2020 at 10:10:14AM -0700, Rob Clark wrote:
> On Fri, Jun 26, 2020 at 1:01 PM Jordan Crouse <jcrouse@codeaurora.org> wrote:
> >
> > Use the aperture settings from the IOMMU domain to set up the virtual
> > address range for the GPU. This allows us to transparently deal with
> > IOMMU side features (like split pagetables).
> >
> > Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
> > ---
> >
> >  drivers/gpu/drm/msm/adreno/adreno_gpu.c | 13 +++++++++++--
> >  drivers/gpu/drm/msm/msm_iommu.c         |  7 +++++++
> >  2 files changed, 18 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> > index 5db06b590943..3e717c1ebb7f 100644
> > --- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> > +++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> > @@ -192,9 +192,18 @@ adreno_iommu_create_address_space(struct msm_gpu *gpu,
> >         struct iommu_domain *iommu = iommu_domain_alloc(&platform_bus_type);
> >         struct msm_mmu *mmu = msm_iommu_new(&pdev->dev, iommu);
> >         struct msm_gem_address_space *aspace;
> > +       u64 start, size;
> >
> > -       aspace = msm_gem_address_space_create(mmu, "gpu", SZ_16M,
> > -               0xffffffff - SZ_16M);
> > +       /*
> > +        * Use the aperture start or SZ_16M, whichever is greater. This will
> > +        * ensure that we align with the allocated pagetable range while still
> > +        * allowing room in the lower 32 bits for GMEM and whatnot
> > +        */
> > +       start = max_t(u64, SZ_16M, iommu->geometry.aperture_start);
> > +       size = iommu->geometry.aperture_end - start + 1;
> > +
> > +       aspace = msm_gem_address_space_create(mmu, "gpu",
> > +               start & GENMASK(48, 0), size);
> 
> hmm, I kinda think this isn't going to play well for the 32b gpus
> (pre-a5xx).. possibly we should add address space size to 'struct
> adreno_info'?

I checked and qcom-iommu sets the aperture correctly so this should be okay for
everybody. To be honest, I'm nots sure if we even need to mask the start to 49
bits. It seems that all of the iommu implementations do the right thing.  Of
course it would be worth a check if you have a 4xx handy.

> Or I guess it is always going to be the same for all devices within a
> generation?  So it could just be passed in to adreno_gpu_init()

We can do that easily if we are worried about it (see also: a2xx). I just
figured this might save us a bit of code.

> Hopefully that makes things smoother if we someday had more than 48bits..

We'll be at 49 bits for as far ahead as I can see. 49 bits has a special
meaning in the SMMU so it is a natural fit for the GPU hardware. If we change in
N generations we can just shift to a family specific function at that point.

Jordan

> BR,
> -R
> 
> >
> >         if (IS_ERR(aspace) && !IS_ERR(mmu))
> >                 mmu->funcs->destroy(mmu);
> > diff --git a/drivers/gpu/drm/msm/msm_iommu.c b/drivers/gpu/drm/msm/msm_iommu.c
> > index 3a381a9674c9..1b6635504069 100644
> > --- a/drivers/gpu/drm/msm/msm_iommu.c
> > +++ b/drivers/gpu/drm/msm/msm_iommu.c
> > @@ -36,6 +36,10 @@ static int msm_iommu_map(struct msm_mmu *mmu, uint64_t iova,
> >         struct msm_iommu *iommu = to_msm_iommu(mmu);
> >         size_t ret;
> >
> > +       /* The arm-smmu driver expects the addresses to be sign extended */
> > +       if (iova & BIT_ULL(48))
> > +               iova |= GENMASK_ULL(63, 49);
> > +
> >         ret = iommu_map_sg(iommu->domain, iova, sgt->sgl, sgt->nents, prot);
> >         WARN_ON(!ret);
> >
> > @@ -46,6 +50,9 @@ static int msm_iommu_unmap(struct msm_mmu *mmu, uint64_t iova, size_t len)
> >  {
> >         struct msm_iommu *iommu = to_msm_iommu(mmu);
> >
> > +       if (iova & BIT_ULL(48))
> > +               iova |= GENMASK_ULL(63, 49);
> > +
> >         iommu_unmap(iommu->domain, iova, len);
> >
> >         return 0;
> > --
> > 2.17.1
> >
> > _______________________________________________
> > Freedreno mailing list
> > Freedreno@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/freedreno

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
