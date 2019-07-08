Return-Path: <SRS0=EbOf=VF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9359C606AC
	for <iommu@archiver.kernel.org>; Mon,  8 Jul 2019 12:03:34 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B277820665
	for <iommu@archiver.kernel.org>; Mon,  8 Jul 2019 12:03:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Rm7uAMB7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B277820665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id F02432504;
	Mon,  8 Jul 2019 12:03:31 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 2E00724E6
	for <iommu@lists.linux-foundation.org>;
	Mon,  8 Jul 2019 11:56:29 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-vs1-f66.google.com (mail-vs1-f66.google.com
	[209.85.217.66])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id C16B7884
	for <iommu@lists.linux-foundation.org>;
	Mon,  8 Jul 2019 11:56:28 +0000 (UTC)
Received: by mail-vs1-f66.google.com with SMTP id h28so7999503vsl.12
	for <iommu@lists.linux-foundation.org>;
	Mon, 08 Jul 2019 04:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=HBytyteQEqE0MSe1IOfYnAnkrJNKH8hCeBxnrS0M68E=;
	b=Rm7uAMB7M5Qn0X6mOV3Iz8dOnLsIQ9eGsDcwh4z92MopdN7KKiq31AboQlypIo9V9v
	ue9bef6yCpVOq2onDY/zQSjkhhKHmc+cbTLwy6OlgG0Lcy3AwSUbpz29HJdKqTZdjodu
	FOu1QU4FrfCCQ1PSZLHjJ1nnN1sfcEYlYy1FvzGRBwpgHIN6h3mwMUDQ1P2H8Tc3oKv7
	oZ+QkHk+nRGF5xp1DGXIjCku+ZIdHyeJCvc/Tsm/3sQbRgU0UlPbI2wofVSyQNLdHlAO
	Tg+EJOx0U9geRwo4Pu/oWUFHPGyernGW0Sp6KVrxuMab2/nNUIIQi9O9nfwGze9pk7AV
	w6xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=HBytyteQEqE0MSe1IOfYnAnkrJNKH8hCeBxnrS0M68E=;
	b=DBlnGy+5qDy72mpQxyjdv2+uK/jQmIQOxgrGaVWsNjGok/a9xNXgm836ytvQZuO5AV
	AFJ/cgtZL0MdCmc4nKRS5CdHSn+LKatxxfMdOuCWgAtzRAzJhnI7dRqaa8ftKExK3rcn
	QfUw9S/1iBEUS2ie0rv7fEPH41I0iNTNyTBx1dK7JzSLuT7fwGlaQxQOqlqcfxCXckl4
	1o+4b3YpmmpxJnXdWXwO8V9M07S2s8M50Cas0qR1pOOp5B2inOacPahjM0vJJrMnFePp
	QsofnRWgXRe8cGi7ab8hFp86jBfjph8ZMbLY52g3Sn2JThRXjydHVN2OUpTUM3XvoAGG
	LpoQ==
X-Gm-Message-State: APjAAAVGwwyqHqxSoVJb4FtXi7QtntspXvUoxy6/jin8sNfASZxjDEgg
	eHWJtrIiyjtWQzgSa/2zrXrDU0+h/GyOwsBV/MTfTQ==
X-Google-Smtp-Source: APXvYqzg4E2v4x7VsWLV3ufXyfYMYcZpu74cfh+llLws+qIdafA82e7IbF0d3dN/j1DEFitRvg4vHdb6lzOYvkL7RiA=
X-Received: by 2002:a67:7a90:: with SMTP id v138mr9705298vsc.200.1562586987921;
	Mon, 08 Jul 2019 04:56:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190625092042.19320-1-hch@lst.de>
	<20190625092042.19320-3-hch@lst.de>
In-Reply-To: <20190625092042.19320-3-hch@lst.de>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 8 Jul 2019 13:55:52 +0200
Message-ID: <CAPDyKFr=skv_109JfYQgZrzrEox_CdSmpO_9iU10OC+sGTz1wQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] dma-mapping: remove dma_max_pfn
To: Christoph Hellwig <hch@lst.de>, Marc Gonzalez <marc.w.gonzalez@free.fr>
Cc: "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
	Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Linux ARM <linux-arm-kernel@lists.infradead.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Tue, 25 Jun 2019 at 11:21, Christoph Hellwig <hch@lst.de> wrote:
>
> These days the DMA mapping code must bounce buffer for any not supported
> address, and if they driver needs to optimize for natively supported
> ranged it should use dma_get_required_mask.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Applied for next, by amending the changelog according to suggestions
from Marc, thanks!

I also decided to consider to the reply from Marc (with the changes
made) as an ack, so added a tag for that.

If there are any objections, from anyone, please tell now.

Kind regards
Uffe


> ---
>  arch/arm/include/asm/dma-mapping.h | 7 -------
>  include/linux/dma-mapping.h        | 7 -------
>  2 files changed, 14 deletions(-)
>
> diff --git a/arch/arm/include/asm/dma-mapping.h b/arch/arm/include/asm/dma-mapping.h
> index 03ba90ffc0f8..7e0486ad1318 100644
> --- a/arch/arm/include/asm/dma-mapping.h
> +++ b/arch/arm/include/asm/dma-mapping.h
> @@ -89,13 +89,6 @@ static inline dma_addr_t virt_to_dma(struct device *dev, void *addr)
>  }
>  #endif
>
> -/* The ARM override for dma_max_pfn() */
> -static inline unsigned long dma_max_pfn(struct device *dev)
> -{
> -       return dma_to_pfn(dev, *dev->dma_mask);
> -}
> -#define dma_max_pfn(dev) dma_max_pfn(dev)
> -
>  /* do not use this function in a driver */
>  static inline bool is_device_dma_coherent(struct device *dev)
>  {
> diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> index 6309a721394b..8d13e28a8e07 100644
> --- a/include/linux/dma-mapping.h
> +++ b/include/linux/dma-mapping.h
> @@ -729,13 +729,6 @@ static inline int dma_set_seg_boundary(struct device *dev, unsigned long mask)
>         return -EIO;
>  }
>
> -#ifndef dma_max_pfn
> -static inline unsigned long dma_max_pfn(struct device *dev)
> -{
> -       return (*dev->dma_mask >> PAGE_SHIFT) + dev->dma_pfn_offset;
> -}
> -#endif
> -
>  static inline int dma_get_cache_alignment(void)
>  {
>  #ifdef ARCH_DMA_MINALIGN
> --
> 2.20.1
>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
