Return-Path: <SRS0=szPT=AU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B051BC433DF
	for <iommu@archiver.kernel.org>; Thu,  9 Jul 2020 19:43:15 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7237C206DF
	for <iommu@archiver.kernel.org>; Thu,  9 Jul 2020 19:43:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FoBl5rfN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7237C206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 21100891CE;
	Thu,  9 Jul 2020 19:43:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Tgijz5Z-iXQa; Thu,  9 Jul 2020 19:43:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 2F44D89174;
	Thu,  9 Jul 2020 19:43:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1EB84C077B;
	Thu,  9 Jul 2020 19:43:13 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 313A1C016F
 for <iommu@lists.linux-foundation.org>; Thu,  9 Jul 2020 19:43:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 89D4120365
 for <iommu@lists.linux-foundation.org>; Thu,  9 Jul 2020 19:42:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PZQ7sGZ-vAiy for <iommu@lists.linux-foundation.org>;
 Thu,  9 Jul 2020 19:42:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com
 [209.85.214.194])
 by silver.osuosl.org (Postfix) with ESMTPS id BDD54220B2
 for <iommu@lists.linux-foundation.org>; Thu,  9 Jul 2020 19:42:28 +0000 (UTC)
Received: by mail-pl1-f194.google.com with SMTP id k5so1227364plk.13
 for <iommu@lists.linux-foundation.org>; Thu, 09 Jul 2020 12:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=RioqnPMkVqNkvL0qwtl83DPVR6qY0R22jJG9ZzsK4ps=;
 b=FoBl5rfNFNF7RvfrMZsfGQpRYnl5VL/d9OqDtLbMx7J82YIVogRqiyjg6viQRbY+2J
 sTW1A3ir/PtIWNZEM6ULSEO2nNc+yv0S1qyqib1pleNf+mjT5TvR0yZiIUyEcaH0FIcA
 ioe3ofKBxKlluH6T9my5/Q+TQeGAuzy/JsjtAUjoILV2h+JvxOmISR8UiatNtpihyrEx
 Y0li6/XqOccp0iEXvWrUkYdnMeokyZYkWJBDqFmSLdNTXJSeHuDXw+WJl4ZBfzWZb45Z
 BuIIzcn2cSkFtDqq75Cq5AcJzfZq7uM2JUab2iXercNaTm48unxLZIEoKOzu0kc4hztU
 Tq4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=RioqnPMkVqNkvL0qwtl83DPVR6qY0R22jJG9ZzsK4ps=;
 b=XdZHbB9O8W+B3yhzhtF5OBwIvw8rOt7GAfoU+Emoly54HE2dD5e9S1qERN6TmNWjyq
 BCDVzjFNM8yC8jgDN4HCYAS2O8nsB8tJKPCA61lbqcQzF624/jVaaFzFsiaL9Ef8uuTo
 1kFTwKZvr8YBVWLaxBWeuPFU5GPv6MYBU2ovmOg63BWJWvCSDNWrAEmaBjQKh1IDPGX0
 +t26hOXeDr6+vdSPVrm6QyyU90b8bo9LWAzpHyzD/YEBl6UH9ARGgQq1CDtVi9HYlw/T
 Ppe01J0U1E2U6GZY/bvQvJhcw4ykwHKNa1bvbuC/B8hH55ffmGth/DxvqzmcR7FFTIbb
 gUuA==
X-Gm-Message-State: AOAM5319tT6iDtcVaQOpDhQMInap20HmeUtkPY8hd29sVX4c/35cXKGp
 4vu1nLYGVR63XU9NtoIta5wDQg==
X-Google-Smtp-Source: ABdhPJyve4niYHT9cwXeej5Gpn/TePKakafs8sB2QJi42hBXqcwUfp/cv0b8La4DdeVsv0QPYrPoZw==
X-Received: by 2002:a17:90a:f014:: with SMTP id
 bt20mr1758584pjb.135.1594323748072; 
 Thu, 09 Jul 2020 12:42:28 -0700 (PDT)
Received: from builder.lan (104-188-17-28.lightspeed.sndgca.sbcglobal.net.
 [104.188.17.28])
 by smtp.gmail.com with ESMTPSA id m16sm3870910pfd.101.2020.07.09.12.42.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2020 12:42:27 -0700 (PDT)
Date: Thu, 9 Jul 2020 12:40:12 -0700
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Rob Clark <robdclark@gmail.com>
Subject: Re: [PATCH 2/5] iommu/arm-smmu: Emulate bypass by using context banks
Message-ID: <20200709194012.GX388985@builder.lan>
References: <20200709050145.3520931-1-bjorn.andersson@linaro.org>
 <20200709050145.3520931-3-bjorn.andersson@linaro.org>
 <CAF6AEGugJYmMpeH_9mWXcegq1awzraUzBTa0S1Rqcr3=Bmk0uQ@mail.gmail.com>
 <20200709164833.GR11847@yoga>
 <CAF6AEGvmqSNeQSFhc4SDJ=09x_LMVz=DmzUEb6GGv=s=f8P2aA@mail.gmail.com>
 <CAF6AEGvHjiS8r32FkVs5yK+nk+caEr4dikCnrE205nqToTA4tg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAF6AEGvHjiS8r32FkVs5yK+nk+caEr4dikCnrE205nqToTA4tg@mail.gmail.com>
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

On Thu 09 Jul 11:55 PDT 2020, Rob Clark wrote:

> On Thu, Jul 9, 2020 at 9:56 AM Rob Clark <robdclark@gmail.com> wrote:
> >
> > On Thu, Jul 9, 2020 at 9:48 AM Bjorn Andersson
> > <bjorn.andersson@linaro.org> wrote:
> > >
> > > On Thu 09 Jul 09:17 PDT 2020, Rob Clark wrote:
> > >
> > > > On Wed, Jul 8, 2020 at 10:01 PM Bjorn Andersson
> > > > <bjorn.andersson@linaro.org> wrote:
> > > [..]
> > > > > @@ -678,7 +680,11 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
> > > > >         if (smmu_domain->smmu)
> > > > >                 goto out_unlock;
> > > > >
> > > > > -       if (domain->type == IOMMU_DOMAIN_IDENTITY) {
> > > > > +       /*
> > > > > +        * Nothing to do for IDENTITY domains,unless disabled context banks are
> > > > > +        * used to emulate bypass mappings on Qualcomm platforms.
> > > > > +        */
> > > > > +       if (domain->type == IOMMU_DOMAIN_IDENTITY && !smmu->qcom_bypass_quirk) {
> > > >
> > > > maybe I'm overlooking something, but I think this would put us back to
> > > > allocating pgtables (and making iommu->map/unmap() no longer no-ops),
> > > > which I don't think we want
> > > >
> > >
> > > You're right, we are allocating page tables for these contexts and
> > > map/unmap would modify the page tables. But afaict traversal is never
> > > performed, given that the banks are never enabled.
> > >
> > > But as drivers probe properly, or the direct mapped drivers sets up
> > > their iommu domains explicitly with translation this would not be used.
> > >
> > > So afaict we're just wasting some memory - for the gain of not
> > > overcomplicating this function.
> >
> > the problem is that it makes dma_map/unmap less of a no-op than it
> > should be (for the case where the driver is explicitly managing it's
> > own domain)..  I was hoping to get rid of the hacks to use dma_sync go
> > back to dma_map/unmap for cache cleaning
> 
> That said, it seems to cause less explosions than before.. either that
> or I'm not trying hard enough.  Still, I think it would probably
> result in unnecessary tlb inv's.
> 
> Previously, *somehow* we seemed to end up with dma_map/unmap trying to
> modify the domain that we had attached.
> 

I might need some help to really understand the plumbing here, but this
is what I read from the code and can see in my debugging...


The display device will upon creation be allocated a default_domain, of
type IOMMU_DOMAIN_IDENTITY - per the qcom-impl. Then you then allocate a
new iommu domain on the platform bus in the display driver and attach
this to the device. This will result in the group's domain being of type
IOMMU_DOMAIN_UNMANAGED.

But when you then invoke dma_map_single() on the display device, the map
operation will acquire the iommu_group's default_domain (not domain) and
as such attempt to map stuff on the IDENTITY domain.

__iommu_map() will however reject this, given that the type does not
have __IOMMU_DOMAIN_PAGING set. Afaict, this would happen regardless of
this patch actually setting up a page table for the default_domain or
not.


So, afaict, you can't use dma_map_single()/dma_unmap() to operate your
page table on a lately attached iommu domain.

This would also imply that the display device consumes two context
banks, which worries me more than the waste of page tables etc.

Regards,
Bjorn

> BR,
> -R
> 
> > BR,
> > -R
> >
> >
> > >
> > > Regards,
> > > Bjorn
> > >
> > > > BR,
> > > > -R
> > > >
> > > > >                 smmu_domain->stage = ARM_SMMU_DOMAIN_BYPASS;
> > > > >                 smmu_domain->smmu = smmu;
> > > > >                 goto out_unlock;
> > > > > @@ -826,6 +832,10 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
> > > > >         domain->geometry.aperture_end = (1UL << ias) - 1;
> > > > >         domain->geometry.force_aperture = true;
> > > > >
> > > > > +       /* Enable translation for non-identity context banks */
> > > > > +       if (domain->type != IOMMU_DOMAIN_IDENTITY)
> > > > > +               cfg->m = true;
> > > > > +
> > > > >         /* Initialise the context bank with our page table cfg */
> > > > >         arm_smmu_init_context_bank(smmu_domain, &pgtbl_cfg);
> > > > >         arm_smmu_write_context_bank(smmu, cfg->cbndx);
> > > > > diff --git a/drivers/iommu/arm-smmu.h b/drivers/iommu/arm-smmu.h
> > > > > index d172c024be61..a71d193073e4 100644
> > > > > --- a/drivers/iommu/arm-smmu.h
> > > > > +++ b/drivers/iommu/arm-smmu.h
> > > > > @@ -305,6 +305,8 @@ struct arm_smmu_device {
> > > > >
> > > > >         /* IOMMU core code handle */
> > > > >         struct iommu_device             iommu;
> > > > > +
> > > > > +       bool                            qcom_bypass_quirk;
> > > > >  };
> > > > >
> > > > >  enum arm_smmu_context_fmt {
> > > > > @@ -323,6 +325,7 @@ struct arm_smmu_cfg {
> > > > >         };
> > > > >         enum arm_smmu_cbar_type         cbar;
> > > > >         enum arm_smmu_context_fmt       fmt;
> > > > > +       bool                            m;
> > > > >  };
> > > > >  #define ARM_SMMU_INVALID_IRPTNDX       0xff
> > > > >
> > > > > --
> > > > > 2.26.2
> > > > >
> > > > > _______________________________________________
> > > > > iommu mailing list
> > > > > iommu@lists.linux-foundation.org
> > > > > https://lists.linuxfoundation.org/mailman/listinfo/iommu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
