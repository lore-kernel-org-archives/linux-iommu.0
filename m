Return-Path: <SRS0=Te3Q=WX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2BC8C3A5A6
	for <iommu@archiver.kernel.org>; Tue, 27 Aug 2019 09:04:09 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 112202173E
	for <iommu@archiver.kernel.org>; Tue, 27 Aug 2019 09:04:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="HSu1hjAb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 112202173E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id AF11E1259;
	Tue, 27 Aug 2019 09:04:08 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 607D21225
	for <iommu@lists.linux-foundation.org>;
	Tue, 27 Aug 2019 09:04:07 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from conssluserg-06.nifty.com (conssluserg-06.nifty.com
	[210.131.2.91])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 885288A9
	for <iommu@lists.linux-foundation.org>;
	Tue, 27 Aug 2019 09:04:06 +0000 (UTC)
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com
	[209.85.217.51]) (authenticated)
	by conssluserg-06.nifty.com with ESMTP id x7R93rTK023581
	for <iommu@lists.linux-foundation.org>; Tue, 27 Aug 2019 18:03:54 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com x7R93rTK023581
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
	s=dec2015msa; t=1566896634;
	bh=9QFLgDLrDq6oYc9M2pjMIY7wPViunYCOH8ybzE+CYKY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=HSu1hjAbOHY7OxZVCGnKn6WOKUDa1+OQNj8CpTIBQXpwRexsrpcByAJ0Hke93xF2j
	54/fWwjfQv/Udt1zdzb1OGxcDwzapAiUqJDFvvIhXyn123gTbqQ2J+ZCwQcqY6g5rq
	klP7bI6NJx444TwTaoLIGR6lOCrMbUAA0jmd5g8o1V3ZLTtZ0BlWfM0tgSFejtgt+M
	fK1ETpvRwPIoZnx/rkOZy0IeUrpyKMKDM3CXp+HMj344fQg5wN42a+tu78TLMu19IR
	XRsFC89dZBLV3cuYVQF5GSVRjNsadYcQNkyIqv8tKNxYVOeEfHN2T0jQ3uHXKK56LO
	x3il+Myr/RDuA==
X-Nifty-SrcIP: [209.85.217.51]
Received: by mail-vs1-f51.google.com with SMTP id y16so12960276vsc.3
	for <iommu@lists.linux-foundation.org>;
	Tue, 27 Aug 2019 02:03:53 -0700 (PDT)
X-Gm-Message-State: APjAAAU0Eu/ydo7aC9FB9ayb6zA8Q6gUlLy+aGoB4RqG19uYxsOby63Q
	IPuK77PyQTAuWS3oZ0EnHXSZ4R3d9JI37tSsv/c=
X-Google-Smtp-Source: APXvYqwricK86V/H4mlXnBje+CLjj05rUISZsABUzE/wYSQ2E+9R0KKypcnkK7mnt6KPt7U5OLwH2hsMH6JJJTu7VOI=
X-Received: by 2002:a67:fe12:: with SMTP id l18mr12998082vsr.54.1566896631370; 
	Tue, 27 Aug 2019 02:03:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190506223334.1834-1-nicoleotsuka@gmail.com>
	<20190506223334.1834-3-nicoleotsuka@gmail.com>
	<CAK7LNARacEorb38mVBw_V-Zvz-znWgBma1AP1-z_5B_xZU4ogg@mail.gmail.com>
	<CAK7LNAQfYBCoChMV=MOwcUyVoqRkrPWs7DaWdzDqjBe18gGiAQ@mail.gmail.com>
	<20190825011025.GA23410@lst.de>
	<CAK7LNAQb1ZHr=DiHLNeNRaQExMuXdDOV4sFghoGbco_Q=Qzb8g@mail.gmail.com>
	<20190826073320.GA11712@lst.de>
	<CAK7LNATYOLEboUTO4qPx2z7cqwDrHBO1HFHG8VzZEJ15STv+nw@mail.gmail.com>
	<20190827075021.GA953@lst.de>
In-Reply-To: <20190827075021.GA953@lst.de>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Tue, 27 Aug 2019 18:03:14 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQZ+bueZZzSoMADmgLjWNvijHRV=wLQzN_kvLG3b5Uu+w@mail.gmail.com>
Message-ID: <CAK7LNAQZ+bueZZzSoMADmgLjWNvijHRV=wLQzN_kvLG3b5Uu+w@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] dma-contiguous: Use fallback alloc_pages for
	single pages
To: Christoph Hellwig <hch@lst.de>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Tony Lindgren <tony@atomide.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Max Filippov <jcmvbkbc@gmail.com>, Stephen Rothwell <sfr@canb.auug.org.au>,
	Russell King <linux@armlinux.org.uk>, Thierry Reding <treding@nvidia.com>,
	linux-xtensa@linux-xtensa.org, Kees Cook <keescook@chromium.org>,
	Nicolin Chen <nicoleotsuka@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
	Chris Zankel <chris@zankel.net>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	David Woodhouse <dwmw2@infradead.org>,
	linux-mmc <linux-mmc@vger.kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	iommu@lists.linux-foundation.org, iamjoonsoo.kim@lge.com,
	Robin Murphy <robin.murphy@arm.com>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On Tue, Aug 27, 2019 at 4:50 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Tue, Aug 27, 2019 at 04:45:20PM +0900, Masahiro Yamada wrote:
> > On Mon, Aug 26, 2019 at 4:33 PM Christoph Hellwig <hch@lst.de> wrote:
> > >
> > > On Mon, Aug 26, 2019 at 11:05:00AM +0900, Masahiro Yamada wrote:
> > > > This is included in v5.3-rc6
> > > > so I tested it.
> > >
> > > So there is no allocation failure, but you get I/O errors later?
> >
> > Right.
> >
> > >
> > > Does the device use a device-private CMA area?
> >
> > Not sure.
> > My driver is drivers/mmc/host/sdhci-cadence.c
> > It reuses routines in drivers/mmc/host/sdhci.c
> >
> >
> >
> > >  Does it work with Linux
> > > 5.2 if CONFIG_DMA_CMA is disabled?
> >
> > No.
> > 5.2 + disable CONFIG_DMA_CMA
> > failed in the same way.
>
> So it seems like the device wants CMA memory.   I guess the patch
> below will fix it, but that isn't the solution.  Can you try it
> to confirm?  In the end it probably assumes a dma mask it doesn't
> set that the CMA memory satisfies or something similar.


Thanks for the pointer.


> diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
> index 69cfb4345388..bd2f24aa7f19 100644
> --- a/kernel/dma/contiguous.c
> +++ b/kernel/dma/contiguous.c
> @@ -236,7 +236,7 @@ struct page *dma_alloc_contiguous(struct device *dev, size_t size, gfp_t gfp)
>
>         if (dev && dev->cma_area)
>                 cma = dev->cma_area;
> -       else if (count > 1)
> +       else
>                 cma = dma_contiguous_default_area;
>
>         /* CMA can be used only in the context which permits sleeping */

Yes, this makes my driver working again
when CONFIG_DMA_CMA=y.


If I apply the following, my driver gets back working
irrespective of CONFIG_DMA_CMA.


diff --git a/drivers/mmc/host/sdhci-cadence.c b/drivers/mmc/host/sdhci-cadence.c
index 163d1cf4367e..504459395c39 100644
--- a/drivers/mmc/host/sdhci-cadence.c
+++ b/drivers/mmc/host/sdhci-cadence.c
@@ -237,6 +237,7 @@ static const struct sdhci_ops sdhci_cdns_ops = {

 static const struct sdhci_pltfm_data sdhci_cdns_pltfm_data = {
        .ops = &sdhci_cdns_ops,
+       .quirks2 = SDHCI_QUIRK2_BROKEN_64_BIT_DMA,
 };

 static int sdhci_cdns_set_tune_val(struct sdhci_host *host, unsigned int val)







-- 
Best Regards
Masahiro Yamada
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
