Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEA98C433F5
	for <iommu@archiver.kernel.org>; Wed, 22 Dec 2021 08:23:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5E20E60DC2;
	Wed, 22 Dec 2021 08:23:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qdaAqhA3ezhw; Wed, 22 Dec 2021 08:23:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 5D93060D71;
	Wed, 22 Dec 2021 08:23:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 35C6BC002F;
	Wed, 22 Dec 2021 08:23:38 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D5BD1C0012
 for <iommu@lists.linux-foundation.org>; Wed, 22 Dec 2021 08:23:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B5B7D410E9
 for <iommu@lists.linux-foundation.org>; Wed, 22 Dec 2021 08:23:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WCXxKx_zFcmO for <iommu@lists.linux-foundation.org>;
 Wed, 22 Dec 2021 08:23:35 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A6092408BB
 for <iommu@lists.linux-foundation.org>; Wed, 22 Dec 2021 08:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=yCKFrFKF7Vuw4wleZFantaSzNpNvWrWC62nu2LjDawE=; b=zwiLqyHJ8YjH3ItyJiTITRKs3/
 4MNGRtpdfgq3VOfNwzfWpqZJC6xkSpeBbuNea8WcQ2KMPEjos8WbIcz/83m3KrG0YRhdk758OSvWx
 p7tdUj6mrdJ0WRB7c/SzSlHvOqvJLD/bvIUMRzwPBdUdRglqLOvfh5TpVdy/ROn+VqggTu3aiRC0X
 Fy3X1MZCG65iP64qp0YEvJdBk8JfbiohCiljB5+OpUwvhNDCPv0rKygcOgmcPv2qvsxyCvY6QH1aY
 QmN1R+YRQLZe0tiLRNjZi01iw8iYArCmelw4nzNJZYqESbFZG3U4QzHtwjqmWp1w6oxooQhVQ10MY
 +uiPmzBQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1mzwuI-009eYF-8w; Wed, 22 Dec 2021 08:23:30 +0000
Date: Wed, 22 Dec 2021 00:23:30 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Guo Zhengkui <guozhengkui@vivo.com>
Subject: Re: [PATCH] Swiotlb: remove a duplicate include
Message-ID: <YcLgggVZn4pATxEo@infradead.org>
References: <20211222025416.3505-1-guozhengkui@vivo.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211222025416.3505-1-guozhengkui@vivo.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: open list <linux-kernel@vger.kernel.org>,
 Christoph Hellwig <hch@infradead.org>, kernel@vivo.com,
 "open list:SWIOTLB SUBSYSTEM" <iommu@lists.linux-foundation.org>,
 Robin Murphy <robin.murphy@arm.com>
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

On Wed, Dec 22, 2021 at 10:54:16AM +0800, Guo Zhengkui wrote:
> Remove a duplicate "#include <linux/io.h>". The deleted one in line 43
> is under "#ifdef CONFIG_DMA_RESTRICTED_POOL". However, there is already
> one in line 53 with no conditional compile.

This doesn't apply to the dma-mapping for-next tree.  Also please don't
capitalize the subject line.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
