Return-Path: <SRS0=LOQj=BI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B1BDC433E0
	for <iommu@archiver.kernel.org>; Wed, 29 Jul 2020 10:45:22 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C295207E8
	for <iommu@archiver.kernel.org>; Wed, 29 Jul 2020 10:45:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C295207E8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 2BF6586D81;
	Wed, 29 Jul 2020 10:45:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uhSYHq2Gnryk; Wed, 29 Jul 2020 10:45:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 669AB86D39;
	Wed, 29 Jul 2020 10:45:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 10D1CC004F;
	Wed, 29 Jul 2020 10:45:21 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DFE1EC004D
 for <iommu@lists.linux-foundation.org>; Wed, 29 Jul 2020 10:45:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id C8CDF85A88
 for <iommu@lists.linux-foundation.org>; Wed, 29 Jul 2020 10:45:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GIeHLRbBvN3t for <iommu@lists.linux-foundation.org>;
 Wed, 29 Jul 2020 10:45:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 18A1985A82
 for <iommu@lists.linux-foundation.org>; Wed, 29 Jul 2020 10:45:19 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 9E8B5AE48;
 Wed, 29 Jul 2020 10:45:28 +0000 (UTC)
Message-ID: <18a3b93cc5ba3e0e39ae1b14759ce31121d54045.camel@suse.de>
Subject: Re: dma-pool fixes
From: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To: Christoph Hellwig <hch@lst.de>, Amit Pundir <amit.pundir@linaro.org>
Date: Wed, 29 Jul 2020 12:45:15 +0200
In-Reply-To: <20200728153055.GA16701@lst.de>
References: <20200728104742.422960-1-hch@lst.de>
 <CAMi1Hd3=6ZZykF1yx_CChqx71k6T-wj12TzJiz_uJZbwrEtTXw@mail.gmail.com>
 <20200728120716.GA2507@lst.de>
 <CAMi1Hd1c3cNMYg+S5Pwuv30QCdcWJw+QxkWmNP34s3nb+_yUuA@mail.gmail.com>
 <20200728124114.GA4865@lst.de>
 <CAMi1Hd0wpcLVJ41h6gs4H0WEDVpNEs7N=wx+KQ_yRKeSv0kQ9g@mail.gmail.com>
 <20200728153055.GA16701@lst.de>
User-Agent: Evolution 3.36.3-0ubuntu1 
MIME-Version: 1.0
Cc: iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>,
 linux-rpi-kernel@lists.infradead.org, jeremy.linton@arm.com,
 David Rientjes <rientjes@google.com>
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

On Tue, 2020-07-28 at 17:30 +0200, Christoph Hellwig wrote:
> On Tue, Jul 28, 2020 at 06:18:41PM +0530, Amit Pundir wrote:
> > > Oh well, this leaves me confused again.  It looks like your setup
> > > really needs a CMA in zone normal for the dma or dma32 pool.
> > 
> > Anything I should look up in the downstream kernel/dts?
> 
> I don't have a good idea right now.  Nicolas, can you think of something
> else?

To summarise, the device is:
 - Using the dma-direct code path.
 - Requesting ZONE_DMA memory to then fail when provided memory falls in
   ZONE_DMA. Actually, the only acceptable memory comes from CMA, which is
   located topmost of the 4GB boundary.

My wild guess is that we may be abusing an iommu identity mapping setup by
firmware.

That said, what would be helpful to me is to find out the troublesome device.
Amit, could you try adding this patch along with Christoph's modified series
(so the board boots). Ultimately DMA atomic allocations are not that common, so
we should get only a few hits:

diff --git a/kernel/dma/pool.c b/kernel/dma/pool.c
index 83fda1039493..de93fce6d5d2 100644
--- a/kernel/dma/pool.c
+++ b/kernel/dma/pool.c
@@ -276,8 +276,11 @@ struct page *dma_alloc_from_pool(struct device *dev, size_t size,
        while ((pool = dma_guess_pool(pool, gfp))) {
                page = __dma_alloc_from_pool(dev, size, pool, cpu_addr,
                                             phys_addr_ok);
-               if (page)
+               if (page) {
+                       dev_err(dev, "%s: phys addr 0x%llx, size %lu, dev->coherent_dma_mask 0x%llx, dev->bus_dma_limit 0x%llx\n",
+                               __func__, (phys_addr_t)*cpu_addr, size, dev->coherent_dma_mask, dev->bus_dma_limit);
                        return page;
+               }
        }
 
        WARN(1, "Failed to get suitable pool for %s\n", dev_name(dev));


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
