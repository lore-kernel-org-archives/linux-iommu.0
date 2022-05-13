Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30B64C433EF
	for <iommu@archiver.kernel.org>; Fri, 13 May 2022 01:32:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CA78981499;
	Fri, 13 May 2022 01:32:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bE0obX266Cp3; Fri, 13 May 2022 01:32:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id BAB1E82419;
	Fri, 13 May 2022 01:32:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 92A2BC0039;
	Fri, 13 May 2022 01:32:03 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 218B0C002D
 for <iommu@lists.linux-foundation.org>; Fri, 13 May 2022 01:32:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 10DF560BD0
 for <iommu@lists.linux-foundation.org>; Fri, 13 May 2022 01:32:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0cl7AeZfF7s2 for <iommu@lists.linux-foundation.org>;
 Fri, 13 May 2022 01:32:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E3E7E607FE
 for <iommu@lists.linux-foundation.org>; Fri, 13 May 2022 01:32:00 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id B4BB962111;
 Fri, 13 May 2022 01:31:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD566C385B8;
 Fri, 13 May 2022 01:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1652405519;
 bh=qjctFxJKv3PzS7uzlW76cYZ2Kpe6i9eksyNQBmQzjxI=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=CltnUnZO6wz0jn//IYGNbjRZOzX7g3zIXYcWvlZqHxtthBJUAr+banq/01hYoijjp
 7Ez0+AWThXRb3t92m7BfwU5Ow+FBw6wWo0Mw6gFP3Be0LvMc7l/EUY4uDWpkdO1Izp
 Fs7O6+3nf+NCvq1fFwc1MRjpViq2gA1wJRwid26sZguxblQQNWQbsOI0ZpEaKJ6Pet
 cFL03OxYL7kjcZwb3qDFHQG4D+nuu6Py4uNbHIZDK4ZqO31aPLmWylKY3/Aq6QBRID
 tkHYYjdRcLOXUuCe1eB4qBnluUWtfT+Cks87VyjJbnrJrlp899sYhntxr93v3aGNA6
 Fa7do414QlbIg==
Date: Thu, 12 May 2022 18:31:57 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 1/3] swiotlb: don't panic when the swiotlb buffer can't
 be allocated
In-Reply-To: <20220511125805.1377025-2-hch@lst.de>
Message-ID: <alpine.DEB.2.22.394.2205121831340.3842@ubuntu-linux-20-04-desktop>
References: <20220511125805.1377025-1-hch@lst.de>
 <20220511125805.1377025-2-hch@lst.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Cc: xen-devel@lists.xenproject.org, iommu@lists.linux-foundation.org,
 Stefano Stabellini <sstabellini@kernel.org>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>, Conor.Dooley@microchip.com
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

On Wed, 11 May 2022, Christoph Hellwig wrote:
> For historical reasons the switlb code paniced when the metadata could
> not be allocated, but just printed a warning when the actual main
> swiotlb buffer could not be allocated.  Restore this somewhat unexpected
> behavior as changing it caused a boot failure on the Microchip RISC-V
> PolarFire SoC Icicle kit.
> 
> Fixes: 6424e31b1c05 ("swiotlb: remove swiotlb_init_with_tbl and swiotlb_init_late_with_tbl")
> Reported-by: Conor Dooley <Conor.Dooley@microchip.com>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Tested-by: Conor Dooley <Conor.Dooley@microchip.com>

Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>


> ---
>  kernel/dma/swiotlb.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index e2ef0864eb1e5..3e992a308c8a1 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -254,8 +254,10 @@ void __init swiotlb_init_remap(bool addressing_limit, unsigned int flags,
>  		tlb = memblock_alloc(bytes, PAGE_SIZE);
>  	else
>  		tlb = memblock_alloc_low(bytes, PAGE_SIZE);
> -	if (!tlb)
> -		panic("%s: failed to allocate tlb structure\n", __func__);
> +	if (!tlb) {
> +		pr_warn("%s: failed to allocate tlb structure\n", __func__);
> +		return;
> +	}
>  
>  	if (remap && remap(tlb, nslabs) < 0) {
>  		memblock_free(tlb, PAGE_ALIGN(bytes));
> -- 
> 2.30.2
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
