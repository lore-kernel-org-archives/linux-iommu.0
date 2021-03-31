Return-Path: <SRS0=WBHG=I5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4221AC433DB
	for <iommu@archiver.kernel.org>; Wed, 31 Mar 2021 08:08:32 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEACD619CF
	for <iommu@archiver.kernel.org>; Wed, 31 Mar 2021 08:08:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEACD619CF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6A6EE83A6A;
	Wed, 31 Mar 2021 08:08:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0CePZmT2LWOq; Wed, 31 Mar 2021 08:08:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0C61A83979;
	Wed, 31 Mar 2021 08:08:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DBD4AC000E;
	Wed, 31 Mar 2021 08:08:28 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 01660C000A
 for <iommu@lists.linux-foundation.org>; Wed, 31 Mar 2021 08:08:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id F0838404B7
 for <iommu@lists.linux-foundation.org>; Wed, 31 Mar 2021 08:08:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FEjZlzKldY9B for <iommu@lists.linux-foundation.org>;
 Wed, 31 Mar 2021 08:08:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 48066402EA
 for <iommu@lists.linux-foundation.org>; Wed, 31 Mar 2021 08:08:26 +0000 (UTC)
Received: from fraeml742-chm.china.huawei.com (unknown [172.18.147.226])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4F9JcH0vpGz6842b;
 Wed, 31 Mar 2021 15:59:11 +0800 (CST)
Received: from lhreml735-chm.china.huawei.com (10.201.108.86) by
 fraeml742-chm.china.huawei.com (10.206.15.223) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 31 Mar 2021 10:08:18 +0200
Received: from lhreml703-chm.china.huawei.com (10.201.108.52) by
 lhreml735-chm.china.huawei.com (10.201.108.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2106.2; Wed, 31 Mar 2021 09:08:18 +0100
Received: from lhreml703-chm.china.huawei.com ([10.201.68.198]) by
 lhreml703-chm.china.huawei.com ([10.201.68.198]) with mapi id 15.01.2106.013; 
 Wed, 31 Mar 2021 09:08:18 +0100
From: Salil Mehta <salil.mehta@huawei.com>
To: Robin Murphy <robin.murphy@arm.com>, John Garry <john.garry@huawei.com>,
 "joro@8bytes.org" <joro@8bytes.org>, "will@kernel.org" <will@kernel.org>,
 "jejb@linux.ibm.com" <jejb@linux.ibm.com>, "martin.petersen@oracle.com"
 <martin.petersen@oracle.com>, "hch@lst.de" <hch@lst.de>,
 "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>
Subject: RE: [PATCH 5/6] dma-mapping/iommu: Add dma_set_max_opt_size()
Thread-Topic: [PATCH 5/6] dma-mapping/iommu: Add dma_set_max_opt_size()
Thread-Index: AQHXHMQXnn0Ai8cuTkuBkW77wwOhrKqLiR4AgBJGVlA=
Date: Wed, 31 Mar 2021 08:08:18 +0000
Message-ID: <e9ec4d0117f049fc87d985dde6c0d7e1@huawei.com>
References: <1616160348-29451-1-git-send-email-john.garry@huawei.com>
 <1616160348-29451-6-git-send-email-john.garry@huawei.com>
 <9ecb6980-7f40-0333-572f-f9d4b8238353@arm.com>
In-Reply-To: <9ecb6980-7f40-0333-572f-f9d4b8238353@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.47.65.208]
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 Linuxarm <linuxarm@huawei.com>
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

(+) correction below, sorry for the typo in earlier post.

> From: iommu [mailto:iommu-bounces@lists.linux-foundation.org] On Behalf Of
> Robin Murphy
> Sent: Friday, March 19, 2021 5:00 PM
> To: John Garry <john.garry@huawei.com>; joro@8bytes.org; will@kernel.org;
> jejb@linux.ibm.com; martin.petersen@oracle.com; hch@lst.de;
> m.szyprowski@samsung.com
> Cc: iommu@lists.linux-foundation.org; linux-kernel@vger.kernel.org;
> linux-scsi@vger.kernel.org; Linuxarm <linuxarm@huawei.com>
> Subject: Re: [PATCH 5/6] dma-mapping/iommu: Add dma_set_max_opt_size()
> 
> On 2021-03-19 13:25, John Garry wrote:
> > Add a function to allow the max size which we want to optimise DMA mappings
> > for.
> 
> It seems neat in theory - particularly for packet-based interfaces that
> might have a known fixed size of data unit that they're working on at
> any given time - but aren't there going to be many cases where the
> driver has no idea because it depends on whatever size(s) of request
> userspace happens to throw at it? Even if it does know the absolute
> maximum size of thing it could ever transfer, that could be
> impractically large in areas like video/AI/etc., so it could still be
> hard to make a reasonable decision.


This is also the case for networking workloads where we have MTU set but
actual packet sizes might vary.

> 
> Being largely workload-dependent is why I still think this should be a
> command-line or sysfs tuneable - we could set the default based on how
> much total memory is available, but ultimately it's the end user who
> knows what the workload is going to be and what they care about
> optimising for.
> 
> Another thought (which I'm almost reluctant to share) is that I would
> *love* to try implementing a self-tuning strategy that can detect high
> contention on particular allocation sizes and adjust the caches on the
> fly, but I can easily imagine that having enough inherent overhead to
> end up being an impractical (but fun) waste of time.


This might be particularly useful for the NICs where packet sizes vary
from 64B to 9K. But without optimal strategy this can affect the
performance of networking workloads.


> 
> Robin.
> 
> > Signed-off-by: John Garry <john.garry@huawei.com>
> > ---
> >   drivers/iommu/dma-iommu.c   |  2 +-
> >   include/linux/dma-map-ops.h |  1 +
> >   include/linux/dma-mapping.h |  5 +++++
> >   kernel/dma/mapping.c        | 11 +++++++++++
> >   4 files changed, 18 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> > index a5dfbd6c0496..d35881fcfb9c 100644
> > --- a/drivers/iommu/dma-iommu.c
> > +++ b/drivers/iommu/dma-iommu.c
> > @@ -447,7 +447,6 @@ static dma_addr_t iommu_dma_alloc_iova(struct iommu_domain
> *domain,
> >   	return (dma_addr_t)iova << shift;
> >   }
> >
> > -__maybe_unused
> >   static void iommu_dma_set_opt_size(struct device *dev, size_t size)
> >   {
> >   	struct iommu_domain *domain = iommu_get_dma_domain(dev);
> > @@ -1278,6 +1277,7 @@ static const struct dma_map_ops iommu_dma_ops = {
> >   	.map_resource		= iommu_dma_map_resource,
> >   	.unmap_resource		= iommu_dma_unmap_resource,
> >   	.get_merge_boundary	= iommu_dma_get_merge_boundary,
> > +	.set_max_opt_size	= iommu_dma_set_opt_size,
> >   };
> >
> >   /*
> > diff --git a/include/linux/dma-map-ops.h b/include/linux/dma-map-ops.h
> > index 51872e736e7b..fed7a183b3b9 100644
> > --- a/include/linux/dma-map-ops.h
> > +++ b/include/linux/dma-map-ops.h
> > @@ -64,6 +64,7 @@ struct dma_map_ops {
> >   	u64 (*get_required_mask)(struct device *dev);
> >   	size_t (*max_mapping_size)(struct device *dev);
> >   	unsigned long (*get_merge_boundary)(struct device *dev);
> > +	void (*set_max_opt_size)(struct device *dev, size_t size);
> >   };
> >
> >   #ifdef CONFIG_DMA_OPS
> > diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> > index 2a984cb4d1e0..91fe770145d4 100644
> > --- a/include/linux/dma-mapping.h
> > +++ b/include/linux/dma-mapping.h
> > @@ -144,6 +144,7 @@ u64 dma_get_required_mask(struct device *dev);
> >   size_t dma_max_mapping_size(struct device *dev);
> >   bool dma_need_sync(struct device *dev, dma_addr_t dma_addr);
> >   unsigned long dma_get_merge_boundary(struct device *dev);
> > +void dma_set_max_opt_size(struct device *dev, size_t size);
> >   #else /* CONFIG_HAS_DMA */
> >   static inline dma_addr_t dma_map_page_attrs(struct device *dev,
> >   		struct page *page, size_t offset, size_t size,
> > @@ -257,6 +258,10 @@ static inline unsigned long dma_get_merge_boundary(struct
> device *dev)
> >   {
> >   	return 0;
> >   }
> > +static inline void dma_set_max_opt_size(struct device *dev, size_t size)
> > +{
> > +}
> > +
> >   #endif /* CONFIG_HAS_DMA */
> >
> >   struct page *dma_alloc_pages(struct device *dev, size_t size,
> > diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
> > index b6a633679933..59e6acb1c471 100644
> > --- a/kernel/dma/mapping.c
> > +++ b/kernel/dma/mapping.c
> > @@ -608,3 +608,14 @@ unsigned long dma_get_merge_boundary(struct device *dev)
> >   	return ops->get_merge_boundary(dev);
> >   }
> >   EXPORT_SYMBOL_GPL(dma_get_merge_boundary);
> > +
> > +void dma_set_max_opt_size(struct device *dev, size_t size)
> > +{
> > +	const struct dma_map_ops *ops = get_dma_ops(dev);
> > +
> > +	if (!ops || !ops->set_max_opt_size)
> > +		return;
> > +
> > +	ops->set_max_opt_size(dev, size);
> > +}
> > +EXPORT_SYMBOL_GPL(dma_set_max_opt_size);
> >
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
