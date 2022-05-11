Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC733C433F5
	for <iommu@archiver.kernel.org>; Wed, 11 May 2022 20:28:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 45B9460B61;
	Wed, 11 May 2022 20:28:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DykAGBYftKhO; Wed, 11 May 2022 20:28:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 265F460B9F;
	Wed, 11 May 2022 20:28:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EC1ECC0039;
	Wed, 11 May 2022 20:28:11 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C898CC002D
 for <iommu@lists.linux-foundation.org>; Wed, 11 May 2022 20:28:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id AFC5760B61
 for <iommu@lists.linux-foundation.org>; Wed, 11 May 2022 20:28:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id g85HOzNn8wz4 for <iommu@lists.linux-foundation.org>;
 Wed, 11 May 2022 20:28:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DF78E60BEB
 for <iommu@lists.linux-foundation.org>; Wed, 11 May 2022 20:28:07 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id B9B3FB82622;
 Wed, 11 May 2022 20:28:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72760C340EE;
 Wed, 11 May 2022 20:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1652300883;
 bh=aqsoCvtdR+zz0dA1DNGarTzDOHpfs5A6XpKMT8xqPOM=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=pMwK+ZNueI6AJjV7vbGATVbILl14UMy4p+hOg2BNOug+M6rvPrN8UL/yKJOIFKBOx
 7iFJ/u+2UqawSTsNNa3EK+yZjholM2lT9aiLcR4CDkWYdRf4y60KavdKEuPtLwxyl9
 uBmcugCkgu4GQ1qENN3t9bIFa+oGEXVlw+sKW6swGMIPUiW3Pv5EqOMKSnjMyl0rqi
 yAvxH/VvvXY0kptwTzwpHSQrBIM6vArAuow10lsvg8GbWdjq44dEvCgdI19/q3ZIu/
 i14PdKWE8+jUQ5/nximFi10JHmsflSZBmypI1k/bZkjZplWA2IYwLxqVuFXZdNGNqK
 ngpYy/Bie6jvg==
Date: Wed, 11 May 2022 13:28:01 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] swiotlb-xen: fix DMA_ATTR_NO_KERNEL_MAPPING on arm
In-Reply-To: <20220511141328.GA31939@lst.de>
Message-ID: <alpine.DEB.2.22.394.2205111327530.43560@ubuntu-linux-20-04-desktop>
References: <20220423171422.1831676-1-hch@lst.de>
 <alpine.DEB.2.22.394.2204261605420.915916@ubuntu-linux-20-04-desktop>
 <20220428132737.GA13999@lst.de>
 <alpine.DEB.2.22.394.2204281449060.915916@ubuntu-linux-20-04-desktop>
 <27d39d5a-3b79-bdda-b7e4-f4477667919f@oracle.com>
 <alpine.DEB.2.22.394.2204281548320.915916@ubuntu-linux-20-04-desktop>
 <41c2483c-ab54-41be-7815-9d4a98e0249e@oracle.com>
 <alpine.DEB.2.22.394.2204291615130.1947187@ubuntu-linux-20-04-desktop>
 <20220511141328.GA31939@lst.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Cc: jgross@suse.com, Stefano Stabellini <sstabellini@kernel.org>,
 iommu@lists.linux-foundation.org, xen-devel@lists.xenproject.org,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Rahul Singh <Rahul.Singh@arm.com>, linux-arm-kernel@lists.infradead.org
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
> On Fri, Apr 29, 2022 at 04:15:38PM -0700, Stefano Stabellini wrote:
> > Great! Christoph you can go ahead and pick it up in your tree if you are
> > up for it.
> 
> The patch is in the dma-mapping for-next brancch now:
> 
> http://git.infradead.org/users/hch/dma-mapping.git/commitdiff/62cb1ca1654b57589c582efae2748159c74ee356
> 
> There were a few smaller merge conflicts with the swiotlb refactoring.
> I think everything is fine, but please take another look if possible.

Looks good to me
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
