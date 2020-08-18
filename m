Return-Path: <SRS0=kAxJ=B4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F30CCC433E4
	for <iommu@archiver.kernel.org>; Tue, 18 Aug 2020 22:03:11 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD2EB2075E
	for <iommu@archiver.kernel.org>; Tue, 18 Aug 2020 22:03:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b0VdabeT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD2EB2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 5A7A987B20;
	Tue, 18 Aug 2020 22:03:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GIO+7+s1oQL8; Tue, 18 Aug 2020 22:03:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 9ADB387AEE;
	Tue, 18 Aug 2020 22:03:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7A1D5C088B;
	Tue, 18 Aug 2020 22:03:10 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 32C6DC0051
 for <iommu@lists.linux-foundation.org>; Tue, 18 Aug 2020 22:03:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 0EECF2000E
 for <iommu@lists.linux-foundation.org>; Tue, 18 Aug 2020 22:03:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4qokkrrgEdhl for <iommu@lists.linux-foundation.org>;
 Tue, 18 Aug 2020 22:03:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-oi1-f195.google.com (mail-oi1-f195.google.com
 [209.85.167.195])
 by silver.osuosl.org (Postfix) with ESMTPS id B2FBC204C3
 for <iommu@lists.linux-foundation.org>; Tue, 18 Aug 2020 22:03:06 +0000 (UTC)
Received: by mail-oi1-f195.google.com with SMTP id n128so15463352oif.0
 for <iommu@lists.linux-foundation.org>; Tue, 18 Aug 2020 15:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=diQpwa3braoDFIWAByVDgaoQfS004fXuMypoBUCVdtk=;
 b=b0VdabeT3wDVIbsWC3+UUFu/XIeQMDjK+Xkxa9ATJN7g6hRVTbi7XDjpV5TPaXfGmT
 wCslWgKlUXSyClpdNtyCqXZhL8SHL1wLFyVVbHWqLxWhH354vCXo69U7GQLCdiGKgJTk
 qsn7lgRuF4gN2odTDj14Cj6eeH9USU6CdxJdFtpXQsbmo9fA7Bzxyr8zqr4Tho5Mlacg
 NNBUaVOoobOAL4BO/aK64cIbDncboXoxOXNIwdZS7zVuFJy7fVFc5rfAYnrB5O8feCmD
 xIq+FyJqN/khbmBqaIvmo3ds1WTecSqZPFQhBYfsn8tMHwNAklxW5j52iXCStxFayCQ8
 JtwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=diQpwa3braoDFIWAByVDgaoQfS004fXuMypoBUCVdtk=;
 b=OhmczGXT+m8dNMEjt64nznlmFuBvDvOh1r5ebTzVYGlbPz7uTYf0ysB87CssoWEmNJ
 qRYXCvRos1a+Fk07/a0k5rTL1pwJ2bYJa60pUb76m+TwsnrNlv7Q3f2uogj5WxlmS515
 1E3yA9e4T22gU4+KTZUzGAnW5oN87f9+FQslGyopgGvokI3/D1ah2WQuuv2DhOj70Isf
 jP6XxNn9tUIQ5wwtiI1DLLOonhNAkqvekvqTNM6F6c7fnbIHc720Ap9zBJA2WH6UlXCx
 Hpcaa6iuQA/bDGOVaSVXkyFyjg48JvyiMH1Cc5wCYXdLcWgfewTZ/Ey3EcEZk3pRT8d+
 e1ig==
X-Gm-Message-State: AOAM5333+l6n9eHsYes4Y0QJqDvRUtZPmtsxh1asyDuJDUZVEnRGZucz
 ds14wnT8E0pf6z0MRAKpwywZJ8wzqrKp9cZaVG2+fQ==
X-Google-Smtp-Source: ABdhPJyGzE0nx7m/2KMeb3GHpmBH6vjSg1G7xFIBMVTmsTi1vQDYWMmdQoiFgnNFFNSMKmEyMesrHuoEyoSXZV5UF2Y=
X-Received: by 2002:aca:dc85:: with SMTP id t127mr1404925oig.169.1597788185528; 
 Tue, 18 Aug 2020 15:03:05 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1597650455.git.mchehab+huawei@kernel.org>
 <5c7918b6-c506-680b-cb0f-9e5f6a7038d9@arm.com>
 <20200818172909.71f5243a@coco.lan>
 <79f40595-7769-aa6a-fbba-53adcffca327@arm.com>
In-Reply-To: <79f40595-7769-aa6a-fbba-53adcffca327@arm.com>
From: John Stultz <john.stultz@linaro.org>
Date: Tue, 18 Aug 2020 15:02:54 -0700
Message-ID: <CALAqxLXBYvwZ9kiKSGBeO5f-eKi2DD14QtoZgFGyGd-B7EOPQA@mail.gmail.com>
Subject: Re: [PATCH 00/16] IOMMU driver for Kirin 960/970
To: Robin Murphy <robin.murphy@arm.com>
Cc: driverdevel <devel@driverdev.osuosl.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Joerg Roedel <jroedel@suse.de>,
 Manivannan Sadhasivam <mani@kernel.org>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Suzhuangluan <suzhuangluan@hisilicon.com>, linuxarm@huawei.com,
 Wei Xu <xuwei5@hisilicon.com>, lkml <linux-kernel@vger.kernel.org>,
 iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
 Chenfeng <puck.chen@hisilicon.com>, mauro.chehab@huawei.com,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
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

On Tue, Aug 18, 2020 at 9:26 AM Robin Murphy <robin.murphy@arm.com> wrote:
> On 2020-08-18 16:29, Mauro Carvalho Chehab wrote:
> > Em Tue, 18 Aug 2020 15:47:55 +0100
> > Basically, the DT binding has this, for IOMMU:
> >
> >
> >       smmu_lpae {
> >               compatible = "hisilicon,smmu-lpae";
> >       };
> >
> > ...
> >       dpe: dpe@e8600000 {
> >               compatible = "hisilicon,kirin970-dpe";
> >               memory-region = <&drm_dma_reserved>;
> > ...
> >               iommu_info {
> >                       start-addr = <0x8000>;
> >                       size = <0xbfff8000>;
> >               };
> >       }
> >
> > This is used by kirin9xx_drm_dss.c in order to enable and use
> > the iommu:
> >
> >
> >       static int dss_enable_iommu(struct platform_device *pdev, struct dss_hw_ctx *ctx)
> >       {
> >               struct device *dev = NULL;
> >
> >               dev = &pdev->dev;
> >
> >               /* create iommu domain */
> >               ctx->mmu_domain = iommu_domain_alloc(dev->bus);
> >               if (!ctx->mmu_domain) {
> >                       pr_err("iommu_domain_alloc failed!\n");
> >                       return -EINVAL;
> >               }
> >
> >               iommu_attach_device(ctx->mmu_domain, dev);
> >
> >               return 0;
> >       }
> >
> > The only place where the IOMMU domain is used is on this part of the
> > code(error part simplified here) [1]:
> >
> >       void hisi_dss_smmu_on(struct dss_hw_ctx *ctx)
> >       {
> >               uint64_t fama_phy_pgd_base;
> >               uint32_t phy_pgd_base;
> > ...
> >               fama_phy_pgd_base = iommu_iova_to_phys(ctx->mmu_domain, 0);
> >               phy_pgd_base = (uint32_t)fama_phy_pgd_base;
> >               if (WARN_ON(!phy_pgd_base))
> >                       return;
> >
> >               set_reg(smmu_base + SMMU_CB_TTBR0, phy_pgd_base, 32, 0);
> >       }
> >
> > [1] https://github.com/mchehab/linux/commit/36da105e719b47bbe9d6cb7e5619b30c7f3eb1bd
> >
> > In other words, the driver needs to get the physical address of the frame
> > buffer (mapped via iommu) in order to set some DRM-specific register.
> >
> > Yeah, the above code is somewhat hackish. I would love to replace
> > this part by a more standard approach.
>
> OK, so from a quick look at that, my impression is that your display
> controller has its own MMU and you don't need to pretend to use the
> IOMMU API at all. Just have the DRM driver use io-pgtable directly to
> run its own set of ARM_32_LPAE_S1 pagetables - see Panfrost for an
> example (but try to ignore the wacky "Mali LPAE" format).

Yea. For the HiKey960, there was originally a similar patch series but
it was refactored out and the (still out of tree) DRM driver I'm
carrying doesn't seem to need it (though looking we still have the
iommu_info subnode in the dts that maybe needs to be cleaned up).

thanks
-john
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
