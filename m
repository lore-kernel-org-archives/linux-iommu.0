Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EED5CC433EF
	for <iommu@archiver.kernel.org>; Wed,  2 Feb 2022 14:18:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8C46C41655;
	Wed,  2 Feb 2022 14:18:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id J6tP5yUbfZdx; Wed,  2 Feb 2022 14:18:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 602F841582;
	Wed,  2 Feb 2022 14:18:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 38776C001A;
	Wed,  2 Feb 2022 14:18:26 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7FA75C000B
 for <iommu@lists.linux-foundation.org>; Wed,  2 Feb 2022 14:18:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6E7A460FB9
 for <iommu@lists.linux-foundation.org>; Wed,  2 Feb 2022 14:18:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YN3l0p5_wqUh for <iommu@lists.linux-foundation.org>;
 Wed,  2 Feb 2022 14:18:23 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9379E60586
 for <iommu@lists.linux-foundation.org>; Wed,  2 Feb 2022 14:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=u0UMpt5R0DZsXe8onQGJg8MHl0
 LW4Ndvh2ka0Mju98F0zQFdCL/g5yEWNd0YPJj5Zaa6RETECrJuc70bLHQ6/45lHau3i7MgmahozCY
 1SLESdfnhSvIohKkkHJ6nYOxbZsxdnl94SbpuOXor67peuJkCT4jtbxxdBfOrcb0q8WRMntEi7XTr
 jP76yfBZDSw1pK3TU96ConTheHx8zPYgnfCSy6tErUSBoOuwysly4qpwilCDQqoWRSNt8kwWs1N1L
 QGT7K5YTUB0hkCv7ODSFWM55XXnoOnN7ozdNIC9ZBx3MYy6YOnU/7k7Um9kGH7qT95+U8ERtyuQX2
 8eisWkqA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1nFGSi-00FclL-Ox; Wed, 02 Feb 2022 14:18:20 +0000
Date: Wed, 2 Feb 2022 06:18:20 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Akeem G Abodunrin <akeem.g.abodunrin@intel.com>
Subject: Re: [PATCH] iommu/vt-d: Remove comment reference to
 iommu_dev_has_feature
Message-ID: <YfqSrK09u67EyACx@infradead.org>
References: <20220202023743.28135-1-akeem.g.abodunrin@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220202023743.28135-1-akeem.g.abodunrin@intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: iommu@lists.linux-foundation.org, matthew.d.roper@intel.com,
 dri-devel@lists.freedesktop.org
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
