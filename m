Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F5CFC433EF
	for <iommu@archiver.kernel.org>; Mon,  4 Apr 2022 17:24:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DCE69408F6;
	Mon,  4 Apr 2022 17:24:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2BtTaAR7jivY; Mon,  4 Apr 2022 17:24:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 7CE74408B4;
	Mon,  4 Apr 2022 17:24:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 63D68C002C;
	Mon,  4 Apr 2022 17:24:38 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B34F0C0012
 for <iommu@lists.linux-foundation.org>; Mon,  4 Apr 2022 17:24:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A303C81B14
 for <iommu@lists.linux-foundation.org>; Mon,  4 Apr 2022 17:24:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yYEidSnDcWH2 for <iommu@lists.linux-foundation.org>;
 Mon,  4 Apr 2022 17:24:36 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3315381AAB
 for <iommu@lists.linux-foundation.org>; Mon,  4 Apr 2022 17:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=N24CpBDygfALbt/hrcJkTFYe4AX/XLB390dNSfysj5g=; b=NVYwAi0WWPljQrXbqyVfROhDET
 Yia/c6sRhlxlfiABHHpesebhHQjtnVtRPI7ShBOv/6Eq1SP3n0t6faH96gj+xfWQ6ORQTfK4Plt4j
 WgCLKfbqhOU/yRzepQHfQ8eEWl0qaGp6rTobEXAEg41NGF13ZC0++grPjTX0ENG/sTkyNp2jJpHV2
 8qgXWugQhy8Qux2xZu6rlNSffJCdWpeuVdlLsex6Nbrnerg22khrz62qDjPyGKtHJid9ney+hx58n
 EtN3vqK6Ss/pqCTABq4+L0b/rmyE/yi62/XVUy+EwV6CHHTsUntUszvh8dB36LsGCiGrSPb0+HmHH
 +4VlDutw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1nbQRJ-00G0Q6-1x; Mon, 04 Apr 2022 17:24:29 +0000
Date: Mon, 4 Apr 2022 10:24:29 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Limonciello, Mario" <Mario.Limonciello@amd.com>
Subject: Re: [PATCH 0/2] Fix issues with untrusted devices and AMD IOMMU
Message-ID: <YkspzQLcfvTQfJ9i@infradead.org>
References: <20220404164707.1128-1-mario.limonciello@amd.com>
 <YksizUJzRgEEdHLJ@infradead.org>
 <BL1PR12MB51573B811E1F7321E25EF785E2E59@BL1PR12MB5157.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <BL1PR12MB51573B811E1F7321E25EF785E2E59@BL1PR12MB5157.namprd12.prod.outlook.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: Will Deacon <will@kernel.org>, "Hegde, Vasant" <Vasant.Hegde@amd.com>,
 open list <linux-kernel@vger.kernel.org>,
 Christoph Hellwig <hch@infradead.org>,
 "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
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

On Mon, Apr 04, 2022 at 05:05:00PM +0000, Limonciello, Mario wrote:
> I do expect that solves it as well.  The reason I submitted the way I
> did is that there seemed to be a strong affinity for having swiotlb
> disabled when IOMMU is enabled on AMD IOMMU.  The original code that
> disabled SWIOTLB in AMD IOMMU dates all the way back to 2.6.33 (commit
> 75f1cdf1dda92cae037ec848ae63690d91913eac) and it has ping ponged around
> since then to add more criteria that it would be or wouldn't be
> disabled, but was never actually dropped until your suggestion.

Well, that was before we started bounce buffering for untrusted devices.
We can't just have a less secure path for them because some conditions
are not met.  Especially given that most AMD systems right now probably
don't have that swiotlb buffer if the IOMMU is enabled.  So not freeing
the buffer in this case is a bug fix that is needed to properly
support the bounce buffering for unaligned I/O to untrusted devices.

> I do think that my messaging patch (1/2) may still be useful for
> debugging in the future if for another reason SWIOTLB is disabled.

I think the warning is useful.  For dma-direct we have it in the caller
so I'd be tempted todo the same for dma-iommu.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
