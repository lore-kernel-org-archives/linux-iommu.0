Return-Path: <SRS0=szPT=AU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D168C433E2
	for <iommu@archiver.kernel.org>; Thu,  9 Jul 2020 18:54:55 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C86E520774
	for <iommu@archiver.kernel.org>; Thu,  9 Jul 2020 18:54:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tvU8QRAc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C86E520774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id A0C2389604;
	Thu,  9 Jul 2020 18:54:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 40j1QP+9eQzx; Thu,  9 Jul 2020 18:54:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 0D1F98967D;
	Thu,  9 Jul 2020 18:54:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D2C97C0865;
	Thu,  9 Jul 2020 18:54:53 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EF129C016F
 for <iommu@lists.linux-foundation.org>; Thu,  9 Jul 2020 18:54:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id D5DED8967D
 for <iommu@lists.linux-foundation.org>; Thu,  9 Jul 2020 18:54:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IZjNegXwUj4t for <iommu@lists.linux-foundation.org>;
 Thu,  9 Jul 2020 18:54:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com
 [209.85.208.66])
 by hemlock.osuosl.org (Postfix) with ESMTPS id E8CAE89604
 for <iommu@lists.linux-foundation.org>; Thu,  9 Jul 2020 18:54:51 +0000 (UTC)
Received: by mail-ed1-f66.google.com with SMTP id d15so2645431edm.10
 for <iommu@lists.linux-foundation.org>; Thu, 09 Jul 2020 11:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ZzXAPkftkjwIiTphx145Tg9PbZ/KHwLrGaBNp1a/xzQ=;
 b=tvU8QRAcYPj7xFR2ZHt/uKYrnPP4wkoFfX28TjcL/pFxTLV2IgSaR2IfCTVUc5C8ft
 wAK8oqMsRtX943tVcu41vQrumnICSdXvMbI/NTQyYkYZgardoazLQTKgv+X4h39scIQi
 TODpYm6aeYq7ibHXJ3L2oLrJYfTaVhDdaMBabgLLCr/5dtgUD+X0sTbTVHDrOyVxmwWY
 BOY0G5TV0xFy8lZEpKtb2aTjrKTW+UougWVzOxB2Zn5MfrcY5pxVhjn20F/tVx+UDPo5
 B4ZXm9JFtu8jGgY9izBB36l0NrExqWlBwHFBt4j1jD2NIYabekiiIwNQ30LpmUJDo8eP
 tf2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ZzXAPkftkjwIiTphx145Tg9PbZ/KHwLrGaBNp1a/xzQ=;
 b=cZxCfmk+SA74ymfclT1r8K9Ew1mtVAltfOTCTxtn3i3ouIOi+p6HWHZlueE1kTqIVJ
 g51HX97tEpU24BMxz4EJuXmpQwM0dcN+TiOkxO1cw+mjZcedSuF+S4ToCstFwdi3ST89
 reIX5/yPJQa5wzlhwM0G8W/1j9wfSqV+ij8f3qji5wcwoqTle6ziLhcLXMSKg030G+VU
 cmzi9KkNe1MK7vULV0rIaohtHUFoG/JceyV+Z27KQ5ljHLSfrE3rsqq+sA65owP1j3Wj
 SbZWpTcVBh/ERhrJ8xsV77TRFJrom/QfwOK1wh1sUFFriOzGNXkGw1Frq2VrrHdjZ1tq
 uyqg==
X-Gm-Message-State: AOAM533S2EiTL+LuZVP7JDGiXEqdhVi71CJse3Bd3pAyFVlj9H5WLlx2
 KnFrG8NpuMIKATFwfuxoq5htfAZMdeURhbh61T8=
X-Google-Smtp-Source: ABdhPJym+0byF6j2MSgwE+oVtEh+E1cDSaOiZnSMabgRzWHKmr9yu4WK140lJjmBsViWfoDA1MBCeBx5R81Ch8oM2oM=
X-Received: by 2002:a05:6402:1250:: with SMTP id
 l16mr74987434edw.362.1594320890278; 
 Thu, 09 Jul 2020 11:54:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200709050145.3520931-1-bjorn.andersson@linaro.org>
 <20200709050145.3520931-3-bjorn.andersson@linaro.org>
 <CAF6AEGugJYmMpeH_9mWXcegq1awzraUzBTa0S1Rqcr3=Bmk0uQ@mail.gmail.com>
 <20200709164833.GR11847@yoga>
 <CAF6AEGvmqSNeQSFhc4SDJ=09x_LMVz=DmzUEb6GGv=s=f8P2aA@mail.gmail.com>
In-Reply-To: <CAF6AEGvmqSNeQSFhc4SDJ=09x_LMVz=DmzUEb6GGv=s=f8P2aA@mail.gmail.com>
From: Rob Clark <robdclark@gmail.com>
Date: Thu, 9 Jul 2020 11:55:22 -0700
Message-ID: <CAF6AEGvHjiS8r32FkVs5yK+nk+caEr4dikCnrE205nqToTA4tg@mail.gmail.com>
Subject: Re: [PATCH 2/5] iommu/arm-smmu: Emulate bypass by using context banks
To: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Jonathan Marek <jonathan@marek.ca>, Will Deacon <will@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
 Thierry Reding <thierry.reding@gmail.com>,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
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

On Thu, Jul 9, 2020 at 9:56 AM Rob Clark <robdclark@gmail.com> wrote:
>
> On Thu, Jul 9, 2020 at 9:48 AM Bjorn Andersson
> <bjorn.andersson@linaro.org> wrote:
> >
> > On Thu 09 Jul 09:17 PDT 2020, Rob Clark wrote:
> >
> > > On Wed, Jul 8, 2020 at 10:01 PM Bjorn Andersson
> > > <bjorn.andersson@linaro.org> wrote:
> > [..]
> > > > @@ -678,7 +680,11 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
> > > >         if (smmu_domain->smmu)
> > > >                 goto out_unlock;
> > > >
> > > > -       if (domain->type == IOMMU_DOMAIN_IDENTITY) {
> > > > +       /*
> > > > +        * Nothing to do for IDENTITY domains,unless disabled context banks are
> > > > +        * used to emulate bypass mappings on Qualcomm platforms.
> > > > +        */
> > > > +       if (domain->type == IOMMU_DOMAIN_IDENTITY && !smmu->qcom_bypass_quirk) {
> > >
> > > maybe I'm overlooking something, but I think this would put us back to
> > > allocating pgtables (and making iommu->map/unmap() no longer no-ops),
> > > which I don't think we want
> > >
> >
> > You're right, we are allocating page tables for these contexts and
> > map/unmap would modify the page tables. But afaict traversal is never
> > performed, given that the banks are never enabled.
> >
> > But as drivers probe properly, or the direct mapped drivers sets up
> > their iommu domains explicitly with translation this would not be used.
> >
> > So afaict we're just wasting some memory - for the gain of not
> > overcomplicating this function.
>
> the problem is that it makes dma_map/unmap less of a no-op than it
> should be (for the case where the driver is explicitly managing it's
> own domain)..  I was hoping to get rid of the hacks to use dma_sync go
> back to dma_map/unmap for cache cleaning

That said, it seems to cause less explosions than before.. either that
or I'm not trying hard enough.  Still, I think it would probably
result in unnecessary tlb inv's.

Previously, *somehow* we seemed to end up with dma_map/unmap trying to
modify the domain that we had attached.

BR,
-R

> BR,
> -R
>
>
> >
> > Regards,
> > Bjorn
> >
> > > BR,
> > > -R
> > >
> > > >                 smmu_domain->stage = ARM_SMMU_DOMAIN_BYPASS;
> > > >                 smmu_domain->smmu = smmu;
> > > >                 goto out_unlock;
> > > > @@ -826,6 +832,10 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
> > > >         domain->geometry.aperture_end = (1UL << ias) - 1;
> > > >         domain->geometry.force_aperture = true;
> > > >
> > > > +       /* Enable translation for non-identity context banks */
> > > > +       if (domain->type != IOMMU_DOMAIN_IDENTITY)
> > > > +               cfg->m = true;
> > > > +
> > > >         /* Initialise the context bank with our page table cfg */
> > > >         arm_smmu_init_context_bank(smmu_domain, &pgtbl_cfg);
> > > >         arm_smmu_write_context_bank(smmu, cfg->cbndx);
> > > > diff --git a/drivers/iommu/arm-smmu.h b/drivers/iommu/arm-smmu.h
> > > > index d172c024be61..a71d193073e4 100644
> > > > --- a/drivers/iommu/arm-smmu.h
> > > > +++ b/drivers/iommu/arm-smmu.h
> > > > @@ -305,6 +305,8 @@ struct arm_smmu_device {
> > > >
> > > >         /* IOMMU core code handle */
> > > >         struct iommu_device             iommu;
> > > > +
> > > > +       bool                            qcom_bypass_quirk;
> > > >  };
> > > >
> > > >  enum arm_smmu_context_fmt {
> > > > @@ -323,6 +325,7 @@ struct arm_smmu_cfg {
> > > >         };
> > > >         enum arm_smmu_cbar_type         cbar;
> > > >         enum arm_smmu_context_fmt       fmt;
> > > > +       bool                            m;
> > > >  };
> > > >  #define ARM_SMMU_INVALID_IRPTNDX       0xff
> > > >
> > > > --
> > > > 2.26.2
> > > >
> > > > _______________________________________________
> > > > iommu mailing list
> > > > iommu@lists.linux-foundation.org
> > > > https://lists.linuxfoundation.org/mailman/listinfo/iommu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
