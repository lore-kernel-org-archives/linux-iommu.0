Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6026EC433F5
	for <iommu@archiver.kernel.org>; Thu,  7 Apr 2022 07:59:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 10B0660F45;
	Thu,  7 Apr 2022 07:59:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oOleRx2w_YvC; Thu,  7 Apr 2022 07:59:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id DE115611C0;
	Thu,  7 Apr 2022 07:59:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C7640C001D;
	Thu,  7 Apr 2022 07:59:04 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EDA85C0012
 for <iommu@lists.linux-foundation.org>; Thu,  7 Apr 2022 07:59:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id EAA5A611C0
 for <iommu@lists.linux-foundation.org>; Thu,  7 Apr 2022 07:59:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id b_8KHAGCiBAi for <iommu@lists.linux-foundation.org>;
 Thu,  7 Apr 2022 07:59:02 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4A56F60F45
 for <iommu@lists.linux-foundation.org>; Thu,  7 Apr 2022 07:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=fBAouhGMrAo4DR21FYAu/hvO6g8bk7dvXwun6YXeuSE=; b=Smgn4MBYQqPfCENKlpEWrjQHKW
 gfvj1P3sx4Vmhf2Fzh+x3284suy6km700wOok3jPpwxks7KLHgPB0G98v/T9P2OGObvDNL7yhJSDg
 K9v7vfqJnGH5VwuprEkGR4tdW7aNbWqOJhrIcnez3erz7etFn31uBEgPl3J3QTcFmSssf68wkzmkE
 rHLUB17PgGec6f1gzgHv5FMuBkCh+rAT4raH/a97uGj7gWG1YZPPNi0euyxFWOSs2ldCoRebdnqZ2
 pvr+DLyThl5MHFgE7YW3DwZxb1NqO2dlWQwCnmtng1Tv1eLWc+qz6XK235F7NhVPvdfdAyH47AjTE
 YjbDYTiQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1ncN2d-00AB66-8g; Thu, 07 Apr 2022 07:58:55 +0000
Date: Thu, 7 Apr 2022 00:58:55 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Limonciello, Mario" <Mario.Limonciello@amd.com>
Subject: Re: [PATCH v2 1/2] iommu/amd: Enable swiotlb in all cases
Message-ID: <Yk6Zv8ubRmQMPPcX@infradead.org>
References: <20220404204723.9767-1-mario.limonciello@amd.com>
 <20220404204723.9767-2-mario.limonciello@amd.com>
 <YkvGwMlrv8JKjHJQ@infradead.org>
 <BL1PR12MB5157E55F2F469E66B46157CDE2E79@BL1PR12MB5157.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <BL1PR12MB5157E55F2F469E66B46157CDE2E79@BL1PR12MB5157.namprd12.prod.outlook.com>
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

On Wed, Apr 06, 2022 at 05:04:52PM +0000, Limonciello, Mario wrote:
> Considering before this fix effectively swiotlb was turned off on most AMD
> systems, when this is picked up I think y'all should consider to add a:
> 
> Cc: stable@vger.kernel.org # 5.11+

Agreed.  I think this is for Joerg to pick up, and I'd love to see it
picked up soon as I'll have to rebase my

"cleanup swiotlb initialization" series on top of it.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
