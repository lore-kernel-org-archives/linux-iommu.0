Return-Path: <SRS0=vyM6=WW=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA7AAC3A5A1
	for <iommu@archiver.kernel.org>; Mon, 26 Aug 2019 02:06:00 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A88A82168B
	for <iommu@archiver.kernel.org>; Mon, 26 Aug 2019 02:06:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="HlDVXApQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A88A82168B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 67A1917DD;
	Mon, 26 Aug 2019 02:06:00 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id D686217D9
	for <iommu@lists.linux-foundation.org>;
	Mon, 26 Aug 2019 02:05:58 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from conssluserg-02.nifty.com (conssluserg-02.nifty.com
	[210.131.2.81])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 56AE6710
	for <iommu@lists.linux-foundation.org>;
	Mon, 26 Aug 2019 02:05:58 +0000 (UTC)
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com
	[209.85.166.52]) (authenticated)
	by conssluserg-02.nifty.com with ESMTP id x7Q25bri024077
	for <iommu@lists.linux-foundation.org>; Mon, 26 Aug 2019 11:05:37 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com x7Q25bri024077
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
	s=dec2015msa; t=1566785138;
	bh=Y6CSk1yG6UDaWDZc7YQfg16zRcI7iqnK0vjwzjH84CE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=HlDVXApQJeqCASixrhojuW15nWeQKG/b7hMjdNZda/cmyuZxv+3t8UR0Ca6JpcyWP
	9LCxrDSsal0l/bwFSN1/POqAIsyKHp9lrBRnGhkqGX0unc+w0vAQTdFPyLa2f8pVAx
	e4Kg/wFqgXUqqAE5S88ZYvoK4bt8cMHtT/QomTtqKxLvol6HE6z51sO2OSdFX/e5eK
	yjRfQCHxDe+12O+JuZOWS5G0X5mv4iqgEjB4NwStZvN20TU0h0gnlOzo/XNI5a00e2
	Fpor8TyphVLqrvSFkArvbCYf7XiAN7MZrk/5l15wOdIufExGAWeGpB1El0zTlpqBJp
	Vfi3CKBbLrf/Q==
X-Nifty-SrcIP: [209.85.166.52]
Received: by mail-io1-f52.google.com with SMTP id s21so33583889ioa.1
	for <iommu@lists.linux-foundation.org>;
	Sun, 25 Aug 2019 19:05:37 -0700 (PDT)
X-Gm-Message-State: APjAAAXUMoJEB/c8bF2fwTkBcww2+ZSdwPwY+1NY7v1G9gDw1XTfMCmZ
	+rirZriW8PikEdlfkbmAD8ijNvKx1Yzdos640VE=
X-Google-Smtp-Source: APXvYqxTTMLLHvl8ZQ3KknXXOxUMTC3Y3hppkNTfIGAtnJsgB3ydviER0RL9pfJ3r191gBIB66pQqdIW5M4t3FT5soQ=
X-Received: by 2002:ab0:442:: with SMTP id 60mr1079956uav.109.1566785136210;
	Sun, 25 Aug 2019 19:05:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190506223334.1834-1-nicoleotsuka@gmail.com>
	<20190506223334.1834-3-nicoleotsuka@gmail.com>
	<CAK7LNARacEorb38mVBw_V-Zvz-znWgBma1AP1-z_5B_xZU4ogg@mail.gmail.com>
	<CAK7LNAQfYBCoChMV=MOwcUyVoqRkrPWs7DaWdzDqjBe18gGiAQ@mail.gmail.com>
	<20190825011025.GA23410@lst.de>
In-Reply-To: <20190825011025.GA23410@lst.de>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Mon, 26 Aug 2019 11:05:00 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQb1ZHr=DiHLNeNRaQExMuXdDOV4sFghoGbco_Q=Qzb8g@mail.gmail.com>
Message-ID: <CAK7LNAQb1ZHr=DiHLNeNRaQExMuXdDOV4sFghoGbco_Q=Qzb8g@mail.gmail.com>
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

Christoph,

On Sun, Aug 25, 2019 at 10:10 AM Christoph Hellwig <hch@lst.de> wrote:
>
> On Fri, Aug 23, 2019 at 09:56:52PM +0900, Masahiro Yamada wrote:
> > + linux-mmc, Ulf Hansson, Adrian Hunter,
> >
> >
> > ADMA of SDHCI is not working
> > since bd2e75633c8012fc8a7431c82fda66237133bf7e
>
> Does it work for you with this commit:
>
> http://git.infradead.org/users/hch/dma-mapping.git/commitdiff/90ae409f9eb3bcaf38688f9ec22375816053a08e


This is included in v5.3-rc6
so I tested it.

No, it did not fix the problem.


--
Best Regards
Masahiro Yamada
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
