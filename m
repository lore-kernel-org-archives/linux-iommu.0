Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F4E1C433EF
	for <iommu@archiver.kernel.org>; Thu,  7 Apr 2022 13:26:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C70186121C;
	Thu,  7 Apr 2022 13:26:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id I2uE4icPPDOW; Thu,  7 Apr 2022 13:26:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id BFDE761221;
	Thu,  7 Apr 2022 13:26:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 91C25C002C;
	Thu,  7 Apr 2022 13:26:53 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8525DC0012
 for <iommu@lists.linux-foundation.org>; Thu,  7 Apr 2022 13:26:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6DDB68401C
 for <iommu@lists.linux-foundation.org>; Thu,  7 Apr 2022 13:26:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id igmPMPKLhq65 for <iommu@lists.linux-foundation.org>;
 Thu,  7 Apr 2022 13:26:50 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 269B483FF9
 for <iommu@lists.linux-foundation.org>; Thu,  7 Apr 2022 13:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=mDNPBdIxUmUHG8SJ7MeeqPWQKsy0BA3146FhhfZqyjU=; b=JfeHaW2RKEgrbGW6YO9yOfWc66
 10aZDQX4B3pQ5N+zIjv6x9wqODHHSt28l+sMw04wINvwYvpXfl8mmAjP4SV9zWZ0JmFvj255X6TtG
 ENHDChoD61tcQ42Cjfj05hdYWfImC0fjvGS17IdkIcfY6sc7FGlp+/YwMCVZ2Za1+CMy+jlggJoFW
 DUR22ECxowZI+SJFMipDyJEM6OO/kSZ9GR2xKLwMg/5HYiAIbdSIcptECdagodEzNAMf3Q8vjVBhh
 KlTjhhI1l4tt1pvlF8LHU5VPArMyHNgSqkl4rMwcT9FodHvCjfulNNoyP/cK7TC4t9Es0PVpl9FNi
 8ypXELOw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1ncS9s-00C8AT-Bp; Thu, 07 Apr 2022 13:26:44 +0000
Date: Thu, 7 Apr 2022 06:26:44 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH v9 05/11] iommu/dma: Introduce a helper to remove
 reserved regions
Message-ID: <Yk7mlMjnRZjDoUqb@infradead.org>
References: <20220404124209.1086-1-shameerali.kolothum.thodi@huawei.com>
 <20220404124209.1086-6-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220404124209.1086-6-shameerali.kolothum.thodi@huawei.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: will@kernel.org, jon@solid-run.com, linuxarm@huawei.com,
 steven.price@arm.com, linux-acpi@vger.kernel.org,
 iommu@lists.linux-foundation.org, wanghuiqiang@huawei.com,
 guohanjun@huawei.com, yangyicong@huawei.com, Sami.Mujawar@arm.com,
 robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org
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

>  
> +static inline void iommu_dma_put_resv_regions(struct device *dev, struct list_head *list)
> +{
> +}
> +
>  #endif	/* CONFIG_IOMMU_DMA */

This changes behavior when CONFIG_IOMMU_DMA is not set.  So e.g. on
ARM all the drivers that are using the new helper now fail to release
reserved regions.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
