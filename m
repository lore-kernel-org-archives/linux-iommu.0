Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82D77C433EF
	for <iommu@archiver.kernel.org>; Tue,  5 Apr 2022 04:34:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1525B40154;
	Tue,  5 Apr 2022 04:34:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UJGd7f-L3BvX; Tue,  5 Apr 2022 04:34:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id D756F40103;
	Tue,  5 Apr 2022 04:34:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B538BC001D;
	Tue,  5 Apr 2022 04:34:24 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3E399C0012
 for <iommu@lists.linux-foundation.org>; Tue,  5 Apr 2022 04:34:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 14A1A8151E
 for <iommu@lists.linux-foundation.org>; Tue,  5 Apr 2022 04:34:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qx0KE0Mh911U for <iommu@lists.linux-foundation.org>;
 Tue,  5 Apr 2022 04:34:20 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9BD14814B4
 for <iommu@lists.linux-foundation.org>; Tue,  5 Apr 2022 04:34:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=YXowaCt6OTBiY4NBWi7XroJoXl
 wV8rPSLVuG0fn0hkHnMSNc+iinVfAMaADHWj4JPogkg/iMzvCIUj/68fYaLyagGsGGLruNkOYjCiL
 ISbiOdMX0lLYPe0NoiGsJBCqPt7Q0sxG/JCEsSc+BX7+wnZi8QEWngSQgK1ctGtOeejMj+PchKMI5
 YH02T8hO8vpKviSZvvnx7BiETDJeVdRmqlsMgqLzg44E/iVhELIKknXHFc13Wl01pd7WDOzcDTLt1
 3TGEGZYIh8NRlJiDKDqO1kSDD9ARE4HvqWHuLUIH/bxAgwDxlvTQ6GlQTzeA+CN55f+wOJVJgZEIb
 CYpqXlVA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1nbatM-00H53L-6G; Tue, 05 Apr 2022 04:34:08 +0000
Date: Mon, 4 Apr 2022 21:34:08 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH v2 1/2] iommu/amd: Enable swiotlb in all cases
Message-ID: <YkvGwMlrv8JKjHJQ@infradead.org>
References: <20220404204723.9767-1-mario.limonciello@amd.com>
 <20220404204723.9767-2-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220404204723.9767-2-mario.limonciello@amd.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: Will Deacon <will@kernel.org>, Hegde Vasant <Vasant.Hegde@amd.com>,
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

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
