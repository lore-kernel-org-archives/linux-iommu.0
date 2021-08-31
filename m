Return-Path: <SRS0=eAvY=NW=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA904C4320E
	for <iommu@archiver.kernel.org>; Tue, 31 Aug 2021 15:17:58 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4945D6103D
	for <iommu@archiver.kernel.org>; Tue, 31 Aug 2021 15:17:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4945D6103D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 16447824DC;
	Tue, 31 Aug 2021 15:17:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HYJHjzHgcrqX; Tue, 31 Aug 2021 15:17:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id D58C58249C;
	Tue, 31 Aug 2021 15:17:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AD27DC0010;
	Tue, 31 Aug 2021 15:17:53 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A7C86C000E
 for <iommu@lists.linux-foundation.org>; Tue, 31 Aug 2021 15:17:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9118B4037F
 for <iommu@lists.linux-foundation.org>; Tue, 31 Aug 2021 15:17:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KWGg9k6o4SWw for <iommu@lists.linux-foundation.org>;
 Tue, 31 Aug 2021 15:17:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2A90F4037D
 for <iommu@lists.linux-foundation.org>; Tue, 31 Aug 2021 15:17:52 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5432360724;
 Tue, 31 Aug 2021 15:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1630423071;
 bh=Gze4tbWximZZAQoREaDEMclW35VaWPdDTv5B4j6qHX0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=OeyrkZc+CBDZ1kqmQ9WpxRHA7iBGHgRCtg6iJhsdEAhaiG4ZStFXL2Mm7pDluNsMW
 gXi28iVYXOjEXS6s7DOi5h5kKTD/9rtqErELDvWJeFP4UPF8ork8X80pXNeYQherK0
 fBJ4Q0fnA8wPw5gk+eSwWOzoiERQJ0ajAU2SnFwkXBUE268P0zkU0ktzj2X9dO9w2b
 zZKGAIdeyAcEQYoua1Ivq2uteKDRRhzi8E9eou4/LhVp0G7tVUBJGr6X62tNOHv+vQ
 gsk4f71fg6bpdbge4+rkUO5SPdD65cUbgo9yQBI6qS58/xse/Q1Huo+ts5ZUxZ6mIN
 w6QIz/QPOaUPA==
Date: Tue, 31 Aug 2021 16:17:47 +0100
From: Will Deacon <will@kernel.org>
To: Claire Chang <tientzu@chromium.org>
Subject: Re: [PATCH] swiotlb: use depends on for DMA_RESTRICTED_POOL
Message-ID: <20210831151746.GB32001@willie-the-truck>
References: <20210827034802.1065294-1-tientzu@chromium.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210827034802.1065294-1-tientzu@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: konrad.wilk@oracle.com, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, robin.murphy@arm.com, hch@lst.de,
 linux@roeck-us.net
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

On Fri, Aug 27, 2021 at 11:48:02AM +0800, Claire Chang wrote:
> Use depends on instead of select for DMA_RESTRICTED_POOL; otherwise it
> will make SWIOTLB user configurable and cause compile errors for some
> arch (e.g. mips).
> 
> Fixes: 0b84e4f8b793 ("swiotlb: Add restricted DMA pool initialization")
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Claire Chang <tientzu@chromium.org>
> ---
>  kernel/dma/Kconfig | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig
> index fd4db714d86b..1b02179758cb 100644
> --- a/kernel/dma/Kconfig
> +++ b/kernel/dma/Kconfig
> @@ -82,8 +82,7 @@ config SWIOTLB
>  
>  config DMA_RESTRICTED_POOL
>  	bool "DMA Restricted Pool"
> -	depends on OF && OF_RESERVED_MEM
> -	select SWIOTLB
> +	depends on OF && OF_RESERVED_MEM && SWIOTLB
>  	help
>  	  This enables support for restricted DMA pools which provide a level of
>  	  DMA memory protection on systems with limited hardware protection

Acked-by: Will Deacon <will@kernel.org>

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
