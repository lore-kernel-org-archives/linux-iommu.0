Return-Path: <SRS0=xflu=WZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4667C3A59F
	for <iommu@archiver.kernel.org>; Thu, 29 Aug 2019 22:50:00 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84EC62189D
	for <iommu@archiver.kernel.org>; Thu, 29 Aug 2019 22:50:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="wnkNFIIv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84EC62189D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 54ED559BC;
	Thu, 29 Aug 2019 22:49:58 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id DFDEE4687
	for <iommu@lists.linux-foundation.org>;
	Thu, 29 Aug 2019 22:48:33 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 7F26B887
	for <iommu@lists.linux-foundation.org>;
	Thu, 29 Aug 2019 22:48:33 +0000 (UTC)
Received: from localhost (c-67-164-102-47.hsd1.ca.comcast.net [67.164.102.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
	bits)) (No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id D7AD72189D;
	Thu, 29 Aug 2019 22:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567118913;
	bh=ZGRvcaq/a8pJd+ywMIWiJwEFzqT0vsYzNvrp/+e8HkA=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=wnkNFIIv+4LJV93bbLL55j9Hxy9G2m3QtVn4rgC4iUTgVBDhTaNaO2ubx36Anoprj
	/xtSvbGDC2SgW8e7dEuJQF71Y045fGovXpA3c1vi7wuauPYe1W8Ib/cgSSGlSTK4Qd
	G4oXD/PaKu6vmQypn5BNG22/goyVDTLPSBwEAb58=
Date: Thu, 29 Aug 2019 15:48:32 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@sstabellini-ThinkPad-T480s
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 11/11] arm64: use asm-generic/dma-mapping.h
In-Reply-To: <20190826121944.515-12-hch@lst.de>
Message-ID: <alpine.DEB.2.21.1908281527130.8175@sstabellini-ThinkPad-T480s>
References: <20190826121944.515-1-hch@lst.de>
	<20190826121944.515-12-hch@lst.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Cc: Stefano Stabellini <sstabellini@kernel.org>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
	xen-devel@lists.xenproject.org, Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org
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

On Mon, 26 Aug 2019, Christoph Hellwig wrote:
> Now that the Xen special cases are gone nothing worth mentioning is
> left in the arm64 <asm/dma-mapping.h> file, so switch to use the
> asm-generic version instead.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Will Deacon <will@kernel.org>

Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>


> ---
>  arch/arm64/include/asm/Kbuild        |  1 +
>  arch/arm64/include/asm/dma-mapping.h | 22 ----------------------
>  arch/arm64/mm/dma-mapping.c          |  1 +
>  3 files changed, 2 insertions(+), 22 deletions(-)
>  delete mode 100644 arch/arm64/include/asm/dma-mapping.h
> 
> diff --git a/arch/arm64/include/asm/Kbuild b/arch/arm64/include/asm/Kbuild
> index c52e151afab0..98a5405c8558 100644
> --- a/arch/arm64/include/asm/Kbuild
> +++ b/arch/arm64/include/asm/Kbuild
> @@ -4,6 +4,7 @@ generic-y += delay.h
>  generic-y += div64.h
>  generic-y += dma.h
>  generic-y += dma-contiguous.h
> +generic-y += dma-mapping.h
>  generic-y += early_ioremap.h
>  generic-y += emergency-restart.h
>  generic-y += hw_irq.h
> diff --git a/arch/arm64/include/asm/dma-mapping.h b/arch/arm64/include/asm/dma-mapping.h
> deleted file mode 100644
> index 67243255a858..000000000000
> --- a/arch/arm64/include/asm/dma-mapping.h
> +++ /dev/null
> @@ -1,22 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0-only */
> -/*
> - * Copyright (C) 2012 ARM Ltd.
> - */
> -#ifndef __ASM_DMA_MAPPING_H
> -#define __ASM_DMA_MAPPING_H
> -
> -#ifdef __KERNEL__
> -
> -#include <linux/types.h>
> -#include <linux/vmalloc.h>
> -
> -#include <xen/xen.h>
> -#include <asm/xen/hypervisor.h>
> -
> -static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
> -{
> -	return NULL;
> -}
> -
> -#endif	/* __KERNEL__ */
> -#endif	/* __ASM_DMA_MAPPING_H */
> diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
> index 4b244a037349..6578abcfbbc7 100644
> --- a/arch/arm64/mm/dma-mapping.c
> +++ b/arch/arm64/mm/dma-mapping.c
> @@ -8,6 +8,7 @@
>  #include <linux/cache.h>
>  #include <linux/dma-noncoherent.h>
>  #include <linux/dma-iommu.h>
> +#include <xen/xen.h>
>  #include <xen/swiotlb-xen.h>
>  
>  #include <asm/cacheflush.h>
> -- 
> 2.20.1
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
