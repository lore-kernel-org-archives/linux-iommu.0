Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6102CC433EF
	for <iommu@archiver.kernel.org>; Fri,  4 Mar 2022 15:54:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0252540160;
	Fri,  4 Mar 2022 15:54:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JBNE3Qv_3N0x; Fri,  4 Mar 2022 15:54:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 8A937400F2;
	Fri,  4 Mar 2022 15:54:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 42793C001D;
	Fri,  4 Mar 2022 15:54:04 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 13449C000B
 for <iommu@lists.linux-foundation.org>; Fri,  4 Mar 2022 15:54:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 019F38417A
 for <iommu@lists.linux-foundation.org>; Fri,  4 Mar 2022 15:54:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id w0DqFelPDysx for <iommu@lists.linux-foundation.org>;
 Fri,  4 Mar 2022 15:54:00 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 272DB84173
 for <iommu@lists.linux-foundation.org>; Fri,  4 Mar 2022 15:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=1+Qh0+uXxcAV1aciqUFtIAq+pnhtnrmQDTbORGN7Wvs=; b=3QQrs5rXY6WU70eO/f3dbib5GH
 1Ws7kXHYxdcDcAalTNsFLK3BV1kg7uGIHGVnBQete1rgLW9fjlhnqalk9dOEL4JJa0MPBVJwlxqzO
 3UzDYk4CkgReFuLQE8JMN3vTlaedMY+f+WSzSqWSZ/1kLzmW//fsbQMNve5dYzvrxDlWD93ocTpqy
 /Lxvj+suxpIpyo1DOLyDHSclHsL0ZMNHWETaraBuE18e/b2PKmCEN7emT3yeb64ie6gKiVNrFMUMf
 6TrTwrsXmvRy2MIkLwTSE5ayJXIjKVEBRaSdpUnWkMLwKwI1fKfY2nj9SudJlPQrMAXuLdKcvtDZp
 Y2j0uk1Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1nQAFY-00As6b-1X; Fri, 04 Mar 2022 15:53:48 +0000
Date: Fri, 4 Mar 2022 07:53:48 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH 0/2] swiotlb: rework fix info leak with DMA_FROM_DEVICE
Message-ID: <YiI2DPIrNLKwanZw@infradead.org>
References: <20220304135859.3521513-1-pasic@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220304135859.3521513-1-pasic@linux.ibm.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: Tom Lendacky <thomas.lendacky@amd.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 "James E.J. Bottomley" <jejb@linux.ibm.com>, linux-doc@vger.kernel.org,
 stable@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 iommu@lists.linux-foundation.org, Doug Gilbert <dgilbert@interlog.com>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 Robin Murphy <robin.murphy@arm.com>,
 Thiago Jung Bauermann <bauerman@linux.ibm.com>
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

On Fri, Mar 04, 2022 at 02:58:57PM +0100, Halil Pasic wrote:
> Unfortunately, we ended up with the wrong version of the patch "fix info
> leak with DMA_FROM_DEVICE" getting merged. We got v4 merged, but the
> version we want is v7 with some minor tweaks which were supposed to be
> applied by Christoph (swiotlb maintainer). After pointing this out, I
> was asked by Christoph to create an incremental fix. 
> 
> IMHO the cleanest way to do this is a reverting the incorrect version
> of the patch and applying the correct one. I hope that qualifies as
> an incremental fix.

I'd really do one patch to move to the expected state.  I'd volunteer
to merge the two patches, but I've recently shown that I'm not
exactly good at that..
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
