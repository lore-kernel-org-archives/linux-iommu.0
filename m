Return-Path: <SRS0=4RPJ=Z7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F65DC43603
	for <iommu@archiver.kernel.org>; Mon,  9 Dec 2019 05:52:40 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E7AA2071E
	for <iommu@archiver.kernel.org>; Mon,  9 Dec 2019 05:52:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="igRorkS9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E7AA2071E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 23DE28633E;
	Mon,  9 Dec 2019 05:52:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id o6iffCQa3EEb; Mon,  9 Dec 2019 05:52:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 9F8178631D;
	Mon,  9 Dec 2019 05:52:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 780E3C1D7D;
	Mon,  9 Dec 2019 05:52:38 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 684EAC0881
 for <iommu@lists.linux-foundation.org>; Mon,  9 Dec 2019 05:52:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 64CCA85D08
 for <iommu@lists.linux-foundation.org>; Mon,  9 Dec 2019 05:52:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3TF7H4rDwLoF for <iommu@lists.linux-foundation.org>;
 Mon,  9 Dec 2019 05:52:35 +0000 (UTC)
X-Greylist: delayed 00:09:12 by SQLgrey-1.7.6
Received: from ozlabs.org (ozlabs.org [203.11.71.1])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 0FD7185C95
 for <iommu@lists.linux-foundation.org>; Mon,  9 Dec 2019 05:52:35 +0000 (UTC)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 47WXD73mCSz9sP6;
 Mon,  9 Dec 2019 16:43:19 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1575870201;
 bh=EU4lPc5IWHfktnisegd6j5Y6xKovFoBVkVjlsMX4/pE=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=igRorkS97HOON5GNqt21oBCytjvq3MO/I/pbqKeA+/w/EC95/C9ComNHV83pfOIJo
 b4BGFIKg3r1DHuXk2sPf8s03P3Ccx8hYkery5YB1CDqnFS8wlBMbZBLR3vtejfl7jy
 h6x4j9eJEGkJyxOc4uI8gM+N1rH/AVk/tDaClHwM+fcgo3GK4PTf+I/L3YSt4sLzOe
 RiNCkQNfxvAXHlPpCsDKltYrZ92IGr8D/O4Hj8MjwAiYJrgDx589PIR6zviioFUxG3
 +7ISbse34yFB4L6wshgcHwRY2JHcyhf5nNMe6B1HMP9BmG6lP0V29ZZes4qk3i1bZa
 6BWY4Z7Sl5Y9Q==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Mike Rapoport <rppt@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc: ensure that swiotlb buffer is allocated from low
 memory
In-Reply-To: <20191204123524.22919-1-rppt@kernel.org>
References: <20191204123524.22919-1-rppt@kernel.org>
Date: Mon, 09 Dec 2019 16:43:17 +1100
Message-ID: <87h82aqcju.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Cc: linux-arch@vger.kernel.org, Darren Stevens <darren@stevens-zone.net>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Robin Murphy <robin.murphy@arm.com>, Mike Rapoport <rppt@linux.ibm.com>,
 linux-mm@kvack.org, iommu@lists.linux-foundation.org,
 Rob Herring <robh+dt@kernel.org>, Paul Mackerras <paulus@samba.org>,
 mad skateman <madskateman@gmail.com>,
 Christian Zigotzky <chzigotzky@xenosoft.de>, linuxppc-dev@lists.ozlabs.org,
 Christoph Hellwig <hch@lst.de>,
 Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
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

Mike Rapoport <rppt@kernel.org> writes:
> From: Mike Rapoport <rppt@linux.ibm.com>
>
> Some powerpc platforms (e.g. 85xx) limit DMA-able memory way below 4G. If a
> system has more physical memory than this limit, the swiotlb buffer is not
> addressable because it is allocated from memblock using top-down mode.
>
> Force memblock to bottom-up mode before calling swiotlb_init() to ensure
> that the swiotlb buffer is DMA-able.
>
> Link: https://lkml.kernel.org/r/F1EBB706-73DF-430E-9020-C214EC8ED5DA@xenosoft.de

This wasn't bisected, but I thought it was a regression. Do we know what
commit caused it?

Was it 25078dc1f74b ("powerpc: use mm zones more sensibly") ?

Or was that a red herring?

cheers

> Reported-by: Christian Zigotzky <chzigotzky@xenosoft.de>
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Darren Stevens <darren@stevens-zone.net>
> Cc: mad skateman <madskateman@gmail.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> ---
>  arch/powerpc/mm/mem.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
> index be941d382c8d..14c2c53e3f9e 100644
> --- a/arch/powerpc/mm/mem.c
> +++ b/arch/powerpc/mm/mem.c
> @@ -260,6 +260,14 @@ void __init mem_init(void)
>  	BUILD_BUG_ON(MMU_PAGE_COUNT > 16);
>  
>  #ifdef CONFIG_SWIOTLB
> +	/*
> +	 * Some platforms (e.g. 85xx) limit DMA-able memory way below
> +	 * 4G. We force memblock to bottom-up mode to ensure that the
> +	 * memory allocated in swiotlb_init() is DMA-able.
> +	 * As it's the last memblock allocation, no need to reset it
> +	 * back to to-down.
> +	 */
> +	memblock_set_bottom_up(true);
>  	swiotlb_init(0);
>  #endif
>  
> -- 
> 2.24.0
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
