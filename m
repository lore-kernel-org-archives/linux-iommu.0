Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D45DC433FE
	for <iommu@archiver.kernel.org>; Mon,  3 Jan 2022 07:54:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B9F7381A58;
	Mon,  3 Jan 2022 07:54:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id z-lO_1uKndZV; Mon,  3 Jan 2022 07:54:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 9B68C813F4;
	Mon,  3 Jan 2022 07:54:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6FEA3C002F;
	Mon,  3 Jan 2022 07:54:54 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 415C7C001E
 for <iommu@lists.linux-foundation.org>; Mon,  3 Jan 2022 07:54:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 164464025E
 for <iommu@lists.linux-foundation.org>; Mon,  3 Jan 2022 07:54:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IqNpYZ7oGwbM for <iommu@lists.linux-foundation.org>;
 Mon,  3 Jan 2022 07:54:52 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 34B5540175
 for <iommu@lists.linux-foundation.org>; Mon,  3 Jan 2022 07:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=s6pxSP+ajg4hdJ8d9+GMrlSCSiEOlsN0aP8e9JW0qCo=; b=uwCl5XU5JVUEfQ5LILKGctTPdV
 W4RvxzbFzkCYUQTJJoMl95IYrXXq8egkDmG8VnN9qzDoRSF3iPjX2K2zD2BJUfTyWZPez2W8QypCS
 gGCYTCbUAXJpJjRCO4elEs/2p0PdcAelqWqxQ5e2N0468VevRiAEAFV/9f+L4f368gWnUBhVRsLrM
 4V9Qr6jWY5HUFk4pko1sxKX62jJ72ZPI8rlv/Kc31o52X9NRMoxgJIzwbcguYpHsXN8OYBoyTTFak
 Y4K+tnefWkBNxwIBxpOfFtse4bOvsvogp1hPaIu49dPj+o1KpPyp6rQNe70AL3e92RtD3JY4MHIF0
 GeHFtCGg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1n4IB4-008XyT-FD; Mon, 03 Jan 2022 07:54:46 +0000
Date: Sun, 2 Jan 2022 23:54:46 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Tianyu Lan <ltykernel@gmail.com>
Subject: Re: [PATCH] Swiotlb: Add CONFIG_HAS_IOMEM check around memremap() in
 the swiotlb_mem_remap()
Message-ID: <YdKrxgnpT0Dc0t2T@infradead.org>
References: <20211231165640.1245751-1-ltykernel@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211231165640.1245751-1-ltykernel@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: parri.andrea@gmail.com, michael.h.kelley@microsoft.com, wei.liu@kernel.org,
 Tianyu Lan <Tianyu.Lan@microsoft.com>, kernel test robot <lkp@intel.com>,
 konrad.wilk@oracle.com, linux-kernel@vger.kernel.org, hch@infradead.org,
 iommu@lists.linux-foundation.org, thomas.lendacky@amd.com,
 brijesh.singh@amd.com, vkuznets@redhat.com, kys@microsoft.com,
 robin.murphy@arm.com, hch@lst.de
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

On Fri, Dec 31, 2021 at 11:56:40AM -0500, Tianyu Lan wrote:
> From: Tianyu Lan <Tianyu.Lan@microsoft.com>
> 
> HAS_IOMEM option may not be selected on some platforms(e.g, s390) and this
> will cause compile error due to miss memremap() implementation. Fix it via
> adding HAS_IOMEM check around memremap() in the swiotlb.c.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
> ---
>  kernel/dma/swiotlb.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index b36c1cdd0c4f..3de651ba38cc 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -167,6 +167,7 @@ static void *swiotlb_mem_remap(struct io_tlb_mem *mem, unsigned long bytes)
>  {
>  	void *vaddr = NULL;
>  
> +#ifdef CONFIG_HAS_IOMEM

Please stub out all of swiotlb_mem_remap instead of the ifdef inside the
function.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
