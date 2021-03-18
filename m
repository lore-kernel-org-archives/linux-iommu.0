Return-Path: <SRS0=56b4=IQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC2BDC433E0
	for <iommu@archiver.kernel.org>; Thu, 18 Mar 2021 09:34:19 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75CFA64F3B
	for <iommu@archiver.kernel.org>; Thu, 18 Mar 2021 09:34:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75CFA64F3B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 30E7260650;
	Thu, 18 Mar 2021 09:34:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id f6PhvFMwMqvE; Thu, 18 Mar 2021 09:34:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2A5176F65A;
	Thu, 18 Mar 2021 09:34:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 06A72C000A;
	Thu, 18 Mar 2021 09:34:18 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 49A05C0001
 for <iommu@lists.linux-foundation.org>; Thu, 18 Mar 2021 09:34:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 33912430AA
 for <iommu@lists.linux-foundation.org>; Thu, 18 Mar 2021 09:34:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yHRWelLSxuWR for <iommu@lists.linux-foundation.org>;
 Thu, 18 Mar 2021 09:34:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp2.osuosl.org (Postfix) with ESMTPS id ADDEF430A2
 for <iommu@lists.linux-foundation.org>; Thu, 18 Mar 2021 09:34:15 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7050F64F10;
 Thu, 18 Mar 2021 09:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1616060055;
 bh=bpjdUT7mYAkt++YvEabfHinPz/dgXdis2kqeg7zxKmg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=A7MVodnx/1mHnKEbPNWjC1zAuQkHOP4+D+4iGIKG0kmpNZ/u50h2Bv4dyeW187l19
 509empEP1GQL1FA00IXhmWraKryKQg6WJEF7AvCKmvuRty3R3O+afgxEfHRCjYAhQ2
 Z9ym4+D79CDSoUaKkZlQlDbb0gIgHXeIr2RwScxh1G4Ht/RGOlAxCT4gphHisD+X6L
 /+vgFrHlt1g1vzmR9li3A/NdMxX29JOhskLoqINkXJxwLh4bc0Rg38BvBL543U/ict
 klxPQWFPfx/VgiKiZjGZdDHRxxfA4GXPf7odMJccNZqxkMoJPGyiyVZ2k9w8ZF5xre
 bvu3r+tp4ki5Q==
Date: Thu, 18 Mar 2021 09:34:11 +0000
From: Will Deacon <will@kernel.org>
To: chenxiang <chenxiang66@hisilicon.com>
Subject: Re: [PATCH] iommu/dma: Fix a typo in a comment
Message-ID: <20210318093410.GA6574@willie-the-truck>
References: <1616037684-59399-1-git-send-email-chenxiang66@hisilicon.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1616037684-59399-1-git-send-email-chenxiang66@hisilicon.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: iommu@lists.linux-foundation.org, robin.murphy@arm.com
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

On Thu, Mar 18, 2021 at 11:21:24AM +0800, chenxiang wrote:
> From: Xiang Chen <chenxiang66@hisilicon.com>
> 
> Fix a type "SAC" to "DAC" in the comment of function
> iommu_dma_alloc_iova().
> 
> Signed-off-by: Xiang Chen <chenxiang66@hisilicon.com>
> ---
>  drivers/iommu/dma-iommu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index af765c8..3bc17ee 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -443,7 +443,7 @@ static dma_addr_t iommu_dma_alloc_iova(struct iommu_domain *domain,
>  	if (domain->geometry.force_aperture)
>  		dma_limit = min(dma_limit, (u64)domain->geometry.aperture_end);
>  
> -	/* Try to get PCI devices a SAC address */
> +	/* Try to get PCI devices a DAC address */
>  	if (dma_limit > DMA_BIT_MASK(32) && dev_is_pci(dev))
>  		iova = alloc_iova_fast(iovad, iova_len,
>  				       DMA_BIT_MASK(32) >> shift, false);

This doesn't look like a typo to me... Please explain.

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
