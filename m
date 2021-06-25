Return-Path: <SRS0=Ze3H=LT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 483CBC2B9F4
	for <iommu@archiver.kernel.org>; Fri, 25 Jun 2021 15:39:05 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D926661981
	for <iommu@archiver.kernel.org>; Fri, 25 Jun 2021 15:39:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D926661981
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9719D40407;
	Fri, 25 Jun 2021 15:39:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ncGL_I2690i4; Fri, 25 Jun 2021 15:39:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 4ED71421F2;
	Fri, 25 Jun 2021 15:39:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 213B3C001A;
	Fri, 25 Jun 2021 15:39:03 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 41342C000E
 for <iommu@lists.linux-foundation.org>; Fri, 25 Jun 2021 15:39:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 28B074015D
 for <iommu@lists.linux-foundation.org>; Fri, 25 Jun 2021 15:39:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id B_0kUpyZA5Mh for <iommu@lists.linux-foundation.org>;
 Fri, 25 Jun 2021 15:39:01 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 44CCB40129
 for <iommu@lists.linux-foundation.org>; Fri, 25 Jun 2021 15:39:01 +0000 (UTC)
Received: by mail-wr1-x430.google.com with SMTP id g7so6440411wri.7
 for <iommu@lists.linux-foundation.org>; Fri, 25 Jun 2021 08:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=vdo63xtloDEOamPYATEH0AS03eYl+iSZfl6fPLjUbC0=;
 b=Jb0i1Lvqmij+LCFT/Mg28ra5KlS0qJQBQ26bnZVtH4y9cZM+GnQHp1dvUZ3LUnWJU1
 VzKHiDXKJ9TXOkl17FLwldxn5maUTbOx3wMjeu2i22mk56UmTrPM2C2y1zrh2p4371l0
 ngGo21DjmXU8rIwuOaB0GEvcMZhCKAAVE7WsMozqU4xp0DWnN/diafx6zcMFlVz8YtbY
 aIz9j5DOTQ8JoWobUYeiB5EYVcMY3rgGVqh20F/KXHQpiUCypMMwLwq0Qv/Y/y5sMS5I
 Wf5LtD+mCjflS70/C4h1O3yl6AOOjPMzZUBQRWl3uyvHi7tsu3jsi7mwnFUC1vgtP6yY
 uOMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=vdo63xtloDEOamPYATEH0AS03eYl+iSZfl6fPLjUbC0=;
 b=ZCLOb2IIMq04A+OmrAk89pPh+adn0a+9KWGcrhncLrSt0dBcQ+RKRqXMHqDxKeyBid
 oT/pExpOzFhh7tzFeJD8t/c/IQ494X5Cz4AOOczhNM9cFXiW50K2zHVCVBwYK6jPiFSE
 5PrP8wUgv9RibmhxHgnLlC+hcTXAKXrRiRyF77FAEFL9734GGc7nDdmLv4DGcvx/M4vs
 G+ewocURimd1N3JbjODvzBOcwDqpQ3XFRwB/RGOKBgoN2P3GHhQmmhupp5bV57F/6DSa
 PB5WxtwV4zfqkZIs7hOhVyhauCGh/2HoYgngSdHPp91OG3zH0M9XVRkIJdLzwsVzHun2
 bOqA==
X-Gm-Message-State: AOAM532bNCfV6g1czuu19m7g5vJzUppogF8Lfh9UK+fNeJZ/DMpKCA7j
 0qK1ba6G+7SzrAt1w9XQjxtDHWE8XfzJmcMgGLA=
X-Google-Smtp-Source: ABdhPJxMd2QD5QxjGCuh4pj9v343g3SW9Px0O12bqlsmSQOJev5MZ4vy4Nc2H7rSC6xBZLfN8VeV69ccnD8vSa1vkF0=
X-Received: by 2002:adf:fcc5:: with SMTP id f5mr11934898wrs.83.1624635539523; 
 Fri, 25 Jun 2021 08:38:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210610214431.539029-1-robdclark@gmail.com>
 <20210610214431.539029-4-robdclark@gmail.com>
 <YNVP6rfQ699BejsI@yoga>
In-Reply-To: <YNVP6rfQ699BejsI@yoga>
From: Rob Clark <robdclark@gmail.com>
Date: Fri, 25 Jun 2021 08:42:59 -0700
Message-ID: <CAF6AEGvTjTUQXqom-xhdh456tdLscbVFPQ+iud1H1gHc8A2=hA@mail.gmail.com>
Subject: Re: [PATCH v5 3/5] drm/msm: Improve the a6xx page fault handler
To: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Rob Clark <robdclark@chromium.org>,
 freedreno <freedreno@lists.freedesktop.org>,
 Jordan Crouse <jcrouse@codeaurora.org>, Jonathan Marek <jonathan@marek.ca>,
 David Airlie <airlied@linux.ie>, linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 Sharat Masetty <smasetty@codeaurora.org>,
 Konrad Dybcio <konrad.dybcio@somainline.org>,
 Douglas Anderson <dianders@chromium.org>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 Akhil P Oommen <akhilpo@codeaurora.org>, Eric Anholt <eric@anholt.net>,
 "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
 "Kristian H. Kristensen" <hoegsberg@google.com>,
 Daniel Vetter <daniel@ffwll.ch>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>,
 Marijn Suijten <marijn.suijten@somainline.org>, Sean Paul <sean@poorly.run>,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Thu, Jun 24, 2021 at 8:39 PM Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
>
> On Thu 10 Jun 16:44 CDT 2021, Rob Clark wrote:
> [..]
> > diff --git a/drivers/gpu/drm/msm/msm_iommu.c b/drivers/gpu/drm/msm/msm_iommu.c
> > index 50d881794758..6975b95c3c29 100644
> > --- a/drivers/gpu/drm/msm/msm_iommu.c
> > +++ b/drivers/gpu/drm/msm/msm_iommu.c
> > @@ -211,8 +211,17 @@ static int msm_fault_handler(struct iommu_domain *domain, struct device *dev,
> >               unsigned long iova, int flags, void *arg)
> >  {
> >       struct msm_iommu *iommu = arg;
> > +     struct adreno_smmu_priv *adreno_smmu = dev_get_drvdata(iommu->base.dev);
> > +     struct adreno_smmu_fault_info info, *ptr = NULL;
> > +
> > +     if (adreno_smmu->get_fault_info) {
>
> This seemed reasonable when I read it last time, but I didn't realize
> that the msm_fault_handler() is installed for all msm_iommu instances.
>
> So while we're trying to recover from the boot splash and setup the new
> framebuffer we end up here with iommu->base.dev being the mdss device.
> Naturally drvdata of mdss is not a struct adreno_smmu_priv.
>
> > +             adreno_smmu->get_fault_info(adreno_smmu->cookie, &info);
>
> So here we just jump straight out into hyperspace, never to return.
>
> Not sure how to wire this up to avoid the problem, but right now I don't
> think we can boot any device with a boot splash.
>

I think we could do:

------------------------
diff --git a/drivers/gpu/drm/msm/msm_iommu.c b/drivers/gpu/drm/msm/msm_iommu.c
index eed2a762e9dd..30ee8866154e 100644
--- a/drivers/gpu/drm/msm/msm_iommu.c
+++ b/drivers/gpu/drm/msm/msm_iommu.c
@@ -29,6 +29,9 @@ static struct msm_iommu_pagetable
*to_pagetable(struct msm_mmu *mmu)
  return container_of(mmu, struct msm_iommu_pagetable, base);
 }

+static int msm_fault_handler(struct iommu_domain *domain, struct device *dev,
+ unsigned long iova, int flags, void *arg);
+
 static int msm_iommu_pagetable_unmap(struct msm_mmu *mmu, u64 iova,
  size_t size)
 {
@@ -151,6 +154,8 @@ struct msm_mmu *msm_iommu_pagetable_create(struct
msm_mmu *parent)
  struct io_pgtable_cfg ttbr0_cfg;
  int ret;

+ iommu_set_fault_handler(iommu->domain, msm_fault_handler, iommu);
+
  /* Get the pagetable configuration from the domain */
  if (adreno_smmu->cookie)
  ttbr1_cfg = adreno_smmu->get_ttbr1_cfg(adreno_smmu->cookie);
@@ -300,7 +305,6 @@ struct msm_mmu *msm_iommu_new(struct device *dev,
struct iommu_domain *domain)

  iommu->domain = domain;
  msm_mmu_init(&iommu->base, dev, &funcs, MSM_MMU_IOMMU);
- iommu_set_fault_handler(domain, msm_fault_handler, iommu);

  atomic_set(&iommu->pagetables, 0);

------------------------

That would have the result of setting the same fault handler multiple
times, but that looks harmless.  Mostly the fault handling stuff is to
make it easier to debug userspace issues, the fallback dmesg spam from
arm-smmu should be sufficient for any kernel side issues.

BR,
-R
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
