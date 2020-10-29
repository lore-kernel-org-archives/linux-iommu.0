Return-Path: <SRS0=7pZu=EE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA650C5517A
	for <iommu@archiver.kernel.org>; Thu, 29 Oct 2020 09:56:14 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A2282076D
	for <iommu@archiver.kernel.org>; Thu, 29 Oct 2020 09:56:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="cJ89gKM6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A2282076D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id A2D3320356;
	Thu, 29 Oct 2020 09:56:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XupoSIJaDr00; Thu, 29 Oct 2020 09:56:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id DA42E2014B;
	Thu, 29 Oct 2020 09:56:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D3A92C088B;
	Thu, 29 Oct 2020 09:56:08 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A4081C0051
 for <iommu@lists.linux-foundation.org>; Thu, 29 Oct 2020 09:56:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 92854868D6
 for <iommu@lists.linux-foundation.org>; Thu, 29 Oct 2020 09:56:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9ayRbn8ym8P2 for <iommu@lists.linux-foundation.org>;
 Thu, 29 Oct 2020 09:56:06 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 699C586773
 for <iommu@lists.linux-foundation.org>; Thu, 29 Oct 2020 09:56:06 +0000 (UTC)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4CMLRm3sBKz9sRR;
 Thu, 29 Oct 2020 20:56:04 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1603965364;
 bh=agmXWLfdIA/pQg1LOAdVjmxcr2Hn93lU+lUVrcQP8co=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=cJ89gKM6AYK1YY7ZnpS2yHhbxcLbjmfev6r+5Jf2idhvDbSxMIo9mcs5wY0pZEN+W
 0cIi327yBjBEVGmz2pNNAQhtIV6qLKR3otIH/eMSHWT8mkLPkvUeDXaqyd9QCBHNzm
 CfpAwbuDAh283Mb+6+j6c+iKHCQxlkMPxtW0ZlVJQx/hfchdhnlspaTuscYQS28C6O
 QBWRvvDEFrskk+0H/CtSY0Sfiq0kkRmoVc8ubM3WkGa/iXYDThHknl8QOTMUnF5RxN
 wBM1Rru6FhrMzWGzN5iSbrz6kKMpgR5ihXYDENlh5i9jVI4j2JWzRbw4K4THt9hwP+
 LlKTdcZt3QDnQ==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH kernel v4 2/2] powerpc/dma: Fallback to dma_ops when
 persistent memory present
In-Reply-To: <20201029015241.73920-3-aik@ozlabs.ru>
References: <20201029015241.73920-1-aik@ozlabs.ru>
 <20201029015241.73920-3-aik@ozlabs.ru>
Date: Thu, 29 Oct 2020 20:56:03 +1100
Message-ID: <878sbpwe30.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Cc: iommu@lists.linux-foundation.org, Christoph Hellwig <hch@lst.de>,
 linux-kernel@vger.kernel.org
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

Alexey Kardashevskiy <aik@ozlabs.ru> writes:
> So far we have been using huge DMA windows to map all the RAM available.
> The RAM is normally mapped to the VM address space contiguously, and
> there is always a reasonable upper limit for possible future hot plugged
> RAM which makes it easy to map all RAM via IOMMU.
>
> Now there is persistent memory ("ibm,pmemory" in the FDT) which (unlike
> normal RAM) can map anywhere in the VM space beyond the maximum RAM size
> and since it can be used for DMA, it requires extending the huge window
> up to MAX_PHYSMEM_BITS which requires hypervisor support for:
> 1. huge TCE tables;
> 2. multilevel TCE tables;
> 3. huge IOMMU pages.
>
> Certain hypervisors cannot do either so the only option left is
> restricting the huge DMA window to include only RAM and fallback to
> the default DMA window for persistent memory.
>
> This defines arch_dma_map_direct/etc to allow generic DMA code perform
> additional checks on whether direct DMA is still possible.
>
> This checks if the system has persistent memory. If it does not,
> the DMA bypass mode is selected, i.e.
> * dev->bus_dma_limit = 0
> * dev->dma_ops_bypass = true <- this avoid calling dma_ops for mapping.
>
> If there is such memory, this creates identity mapping only for RAM and
> sets the dev->bus_dma_limit to let the generic code decide whether to
> call into the direct DMA or the indirect DMA ops.
>
> This should not change the existing behaviour when no persistent memory
> as dev->dma_ops_bypass is expected to be set.
>
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Acked-by: Michael Ellerman <mpe@ellerman.id.au>

cheers
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
