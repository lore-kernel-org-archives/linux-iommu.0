Return-Path: <SRS0=f2Pc=WY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15716C3A5A1
	for <iommu@archiver.kernel.org>; Wed, 28 Aug 2019 10:54:44 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD28E20828
	for <iommu@archiver.kernel.org>; Wed, 28 Aug 2019 10:54:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="0jdopBxY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD28E20828
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id AE67B2A62;
	Wed, 28 Aug 2019 10:54:43 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 642C92A5E
	for <iommu@lists.linux-foundation.org>;
	Wed, 28 Aug 2019 10:54:30 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from conssluserg-02.nifty.com (conssluserg-02.nifty.com
	[210.131.2.81])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 3150C8A2
	for <iommu@lists.linux-foundation.org>;
	Wed, 28 Aug 2019 10:54:29 +0000 (UTC)
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com
	[209.85.217.48]) (authenticated)
	by conssluserg-02.nifty.com with ESMTP id x7SAsI0r005439
	for <iommu@lists.linux-foundation.org>; Wed, 28 Aug 2019 19:54:18 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com x7SAsI0r005439
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
	s=dec2015msa; t=1566989659;
	bh=0aEfdaeY7mGkEAyGyJedaS36AmSkDHSHLjJWK6eJ8jU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=0jdopBxYpW2jlgymQ97Wo2mDW8Ocinpkn0GDsHhW0Ov8/5w/cZYHnpHPDL9MbgQp1
	k2eAe7fMoEPCApep0PNiR8076Cotxx25MkzTwsFQRvm1sYfOy9nZ+FNjnVBwP/Na03
	IgeK/E6EcnPPkTS/uRUO6EtFW1gc57eLFPyFR3YO0uypWxWfaxVK/upAY4b+322soH
	45eaZHAuZwRf1fqAKHRsRSx4lJrq0j7svZRBryQ2k6CKiTpG4Zp/Fbgw9fvri+jT0B
	f3w03DJSqgU/0wxij+kbolKImc1PXouf0pbtZH2eUf2CtcF9Rstl5gLud85huTUN10
	jWwXAXypV8gpg==
X-Nifty-SrcIP: [209.85.217.48]
Received: by mail-vs1-f48.google.com with SMTP id y62so1538329vsb.6
	for <iommu@lists.linux-foundation.org>;
	Wed, 28 Aug 2019 03:54:18 -0700 (PDT)
X-Gm-Message-State: APjAAAVXiheCXK//pgkg9g1YGRsr6fK6coOYiwlG8SI5PoPLLEyD6Ecv
	pQMt8xai5svDnLRbxROMqc7TV2eozdI3la8LonA=
X-Google-Smtp-Source: APXvYqyTOMfJYEouCiB1bEN4976TgQu4HqralgHD2818HsBCGBXAYnYZsbiCyyA54/vVKIRU/ogvfy3faarlq+XW0VM=
X-Received: by 2002:a67:8a83:: with SMTP id m125mr1914365vsd.181.1566989656023;
	Wed, 28 Aug 2019 03:54:16 -0700 (PDT)
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
	<CAK7LNAQZ+bueZZzSoMADmgLjWNvijHRV=wLQzN_kvLG3b5Uu+w@mail.gmail.com>
	<20190827115541.GB5921@lst.de>
In-Reply-To: <20190827115541.GB5921@lst.de>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Wed, 28 Aug 2019 19:53:40 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQ_nQcBt=xH1-h+=co85mTxFgbe+_46Gu4LaNsDSm+kYA@mail.gmail.com>
Message-ID: <CAK7LNAQ_nQcBt=xH1-h+=co85mTxFgbe+_46Gu4LaNsDSm+kYA@mail.gmail.com>
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

Hi Christoph,

On Tue, Aug 27, 2019 at 8:55 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Tue, Aug 27, 2019 at 06:03:14PM +0900, Masahiro Yamada wrote:
> > Yes, this makes my driver working again
> > when CONFIG_DMA_CMA=y.
> >
> >
> > If I apply the following, my driver gets back working
> > irrespective of CONFIG_DMA_CMA.
>
> That sounds a lot like the device simply isn't 64-bit DMA capable, and
> previously always got CMA allocations under the limit it actually
> supported.  I suggest that you submit this quirk to the mmc maintainers.


I tested v5.2 and my MMC host controller works with
dma_address that exceeds 32-bit physical address.

So, I believe my MMC device is 64-bit DMA capable.

I am still looking into the code
to find out what was changed.




--
Best Regards
Masahiro Yamada
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
