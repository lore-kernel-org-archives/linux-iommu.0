Return-Path: <SRS0=roZV=HU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8161CC433DB
	for <iommu@archiver.kernel.org>; Thu, 18 Feb 2021 09:48:04 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F03186148E
	for <iommu@archiver.kernel.org>; Thu, 18 Feb 2021 09:48:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F03186148E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 88987605E6
	for <iommu@archiver.kernel.org>; Thu, 18 Feb 2021 09:48:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lxs4liUv5g4Z for <iommu@archiver.kernel.org>;
	Thu, 18 Feb 2021 09:48:01 +0000 (UTC)
Received: by smtp3.osuosl.org (Postfix, from userid 1001)
	id 1653460603; Thu, 18 Feb 2021 09:48:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4C4D86009C;
	Thu, 18 Feb 2021 09:47:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1E5CAC000F;
	Thu, 18 Feb 2021 09:47:55 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 50D12C000D
 for <iommu@lists.linux-foundation.org>; Thu, 18 Feb 2021 02:44:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 389898485A
 for <iommu@lists.linux-foundation.org>; Thu, 18 Feb 2021 02:44:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OTatUJ0uhFXo for <iommu@lists.linux-foundation.org>;
 Thu, 18 Feb 2021 02:44:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 7ABF68484B
 for <iommu@lists.linux-foundation.org>; Thu, 18 Feb 2021 02:44:15 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 275AE64E15
 for <iommu@lists.linux-foundation.org>; Thu, 18 Feb 2021 02:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1613616255;
 bh=sy8iwMXSGDS2c4e5QxmwRLlBenOB+zXEq/e8dETRyzg=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=g/Kr2Fzyuee3+iP5ggZmEmwlj4ttvKXK1fyFZYXDb5BUHpEp7V9zY+MKwJ9mq2WHw
 a90PJDKAmMjp13RidKhhvX8AHwoBlRpGp17QhsSFWXtW5KzwQ384P80M36mIHqR1dp
 w8tp+fI0/W+O22CWWyxaPNTF9hoZDW7kxGRn61xAmE5MdMdDVf5M02CGjy/hs1mQs/
 +vsq1ePu13m7NJbv1lAEYVzRnEsB8aOds+aqvpH5Njwm3JuiqTK8cj1B+kGGce+tmd
 weNXoaKjUmbw2Pun1O20kDsF8RwruJZbnsBfbP3POkBhHRBcHcvPvEbEIdaqFiZf1M
 HHUi33L0wpsvg==
Received: by mail-io1-f47.google.com with SMTP id f6so546334ioz.5
 for <iommu@lists.linux-foundation.org>; Wed, 17 Feb 2021 18:44:15 -0800 (PST)
X-Gm-Message-State: AOAM533dgtXb8zRVv7t+fQfCE6aihD2L+tKubFDRH4oeOEhpiGatVKLN
 H9WHaFWaBzkYwKCIYw9IIUlpG/q03o0iQEdzHcI=
X-Google-Smtp-Source: ABdhPJz7XjKIp6zYI6MQB/vAQmLnv0OLQF/zoMf/GQc2JEzoi69wCw8l6Fwgo8FbpsTKdcZrvMov8bTvMN9eHAfjtmY=
X-Received: by 2002:a5e:9612:: with SMTP id a18mr1808999ioq.13.1613616254599; 
 Wed, 17 Feb 2021 18:44:14 -0800 (PST)
MIME-Version: 1.0
References: <20210210095641.23856-1-hch@lst.de>
 <20210210095641.23856-6-hch@lst.de>
In-Reply-To: <20210210095641.23856-6-hch@lst.de>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Thu, 18 Feb 2021 10:44:02 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4kxyOygLg4_nEqjmO8qS8aW2M5WXn_ia7jO0hLY3_waw@mail.gmail.com>
Message-ID: <CAAhV-H4kxyOygLg4_nEqjmO8qS8aW2M5WXn_ia7jO0hLY3_waw@mail.gmail.com>
Subject: Re: [PATCH 5/6] MIPS: remove CONFIG_DMA_MAYBE_COHERENT
To: Christoph Hellwig <hch@lst.de>
X-Mailman-Approved-At: Thu, 18 Feb 2021 09:47:53 +0000
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 iommu@lists.linux-foundation.org,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 "open list:MIPS" <linux-mips@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
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

Reviewed-by: Huacai Chen <chenhuacai@kernel.org>

On Wed, Feb 10, 2021 at 6:04 PM Christoph Hellwig <hch@lst.de> wrote:
>
> CONFIG_DMA_MAYBE_COHERENT just guards two early init options now.  Just
> enable them unconditionally for CONFIG_DMA_NONCOHERENT.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/mips/Kconfig        | 8 ++------
>  arch/mips/kernel/setup.c | 2 +-
>  2 files changed, 3 insertions(+), 7 deletions(-)
>
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index 0e86162df65541..1f1603a08a6d2d 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -181,7 +181,7 @@ config MIPS_ALCHEMY
>         select CEVT_R4K
>         select CSRC_R4K
>         select IRQ_MIPS_CPU
> -       select DMA_MAYBE_COHERENT       # Au1000,1500,1100 aren't, rest is
> +       select DMA_NONCOHERENT          # Au1000,1500,1100 aren't, rest is
>         select MIPS_FIXUP_BIGPHYS_ADDR if PCI
>         select SYS_HAS_CPU_MIPS32_R1
>         select SYS_SUPPORTS_32BIT_KERNEL
> @@ -546,7 +546,7 @@ config MIPS_MALTA
>         select CLKSRC_MIPS_GIC
>         select COMMON_CLK
>         select CSRC_R4K
> -       select DMA_MAYBE_COHERENT
> +       select DMA_NONCOHERENT
>         select GENERIC_ISA_DMA
>         select HAVE_PCSPKR_PLATFORM
>         select HAVE_PCI
> @@ -1127,10 +1127,6 @@ config FW_CFE
>  config ARCH_SUPPORTS_UPROBES
>         bool
>
> -config DMA_MAYBE_COHERENT
> -       select DMA_NONCOHERENT
> -       bool
> -
>  config DMA_PERDEV_COHERENT
>         bool
>         select ARCH_HAS_SETUP_DMA_OPS
> diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
> index d6b2ba527f5b81..b25d07675b1ee1 100644
> --- a/arch/mips/kernel/setup.c
> +++ b/arch/mips/kernel/setup.c
> @@ -805,7 +805,7 @@ static int __init debugfs_mips(void)
>  arch_initcall(debugfs_mips);
>  #endif
>
> -#ifdef CONFIG_DMA_MAYBE_COHERENT
> +#ifdef CONFIG_DMA_NONCOHERENT
>  static int __init setcoherentio(char *str)
>  {
>         dma_default_coherent = true;
> --
> 2.29.2
>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
