Return-Path: <SRS0=E0xS=ZG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08356C43141
	for <iommu@archiver.kernel.org>; Thu, 14 Nov 2019 08:48:52 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5CD72070E
	for <iommu@archiver.kernel.org>; Thu, 14 Nov 2019 08:48:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="h8xc1Vk4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5CD72070E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id AE6A5BDC;
	Thu, 14 Nov 2019 08:48:51 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id BB940B8A
	for <iommu@lists.linux-foundation.org>;
	Thu, 14 Nov 2019 08:48:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 48D5FCF
	for <iommu@lists.linux-foundation.org>;
	Thu, 14 Nov 2019 08:48:50 +0000 (UTC)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits)
	server-digest SHA256) (No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 47DFWh1KCJz9sNT;
	Thu, 14 Nov 2019 19:48:48 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
	s=201909; t=1573721328;
	bh=bDF+Yyy88Fi18Ty7c9txdLpa+ezncf6v+l29k9UorgE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=h8xc1Vk45YLl9MzdGeCdPvVM/gZgFW8kGJAtTantRRnTOlPRUk++Y13aiXGqk/x0i
	+uYEKQ6YmW092dWaZrlWweY0cIjcwmDub4jkR/wcrMJYEUmFGPzEJ2z6Ihh2l9l84s
	VWu2apAPX2+lF206X5eZXVLXEk+Z4OjWoh3rvv3tb1AO83VqhnrRpa/I0Gcb49rzlo
	KnNUrtMjeae+4ZLyJp+BqjmUzhV2MqmSlAxK7/LELcl2os+oGvZOJwGpAm8mUJEh5W
	erpXofYK/ZCFPUo11Pk1SoU/EupeIr+q89BxoSTnukj3aY8zV7vWldzixXShJN/wTN
	wKlQaaHzA3RhQ==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christoph Hellwig <hch@lst.de>,
	Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
	iommu@lists.linux-foundation.org, Russell King <linux@armlinux.org.uk>
Subject: Re: [PATCH 3/3] powerpc: remove support for NULL dev in __phys_to_dma
	/ __dma_to_phys
In-Reply-To: <20191113073539.9660-4-hch@lst.de>
References: <20191113073539.9660-1-hch@lst.de>
	<20191113073539.9660-4-hch@lst.de>
Date: Thu, 14 Nov 2019 19:48:47 +1100
Message-ID: <8736eq268g.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, linux-mips@vger.kernel.org,
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

Christoph Hellwig <hch@lst.de> writes:
> Support for calling the DMA API functions without a valid device pointer
> was removed a while ago, so remove the stale support for that from the
> powerpc __phys_to_dma / __dma_to_phys helpers.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/powerpc/include/asm/dma-direct.h | 4 ----
>  1 file changed, 4 deletions(-)

Acked-by: Michael Ellerman <mpe@ellerman.id.au>

cheers

> diff --git a/arch/powerpc/include/asm/dma-direct.h b/arch/powerpc/include/asm/dma-direct.h
> index e29e8a236b8d..abc154d784b0 100644
> --- a/arch/powerpc/include/asm/dma-direct.h
> +++ b/arch/powerpc/include/asm/dma-direct.h
> @@ -4,15 +4,11 @@
>  
>  static inline dma_addr_t __phys_to_dma(struct device *dev, phys_addr_t paddr)
>  {
> -	if (!dev)
> -		return paddr + PCI_DRAM_OFFSET;
>  	return paddr + dev->archdata.dma_offset;
>  }
>  
>  static inline phys_addr_t __dma_to_phys(struct device *dev, dma_addr_t daddr)
>  {
> -	if (!dev)
> -		return daddr - PCI_DRAM_OFFSET;
>  	return daddr - dev->archdata.dma_offset;
>  }
>  #endif /* ASM_POWERPC_DMA_DIRECT_H */
> -- 
> 2.20.1
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
