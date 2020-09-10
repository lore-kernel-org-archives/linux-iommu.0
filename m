Return-Path: <SRS0=7VEr=CT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 558B4C43461
	for <iommu@archiver.kernel.org>; Thu, 10 Sep 2020 11:51:59 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 969E620C09
	for <iommu@archiver.kernel.org>; Thu, 10 Sep 2020 11:51:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 969E620C09
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 36B74875CD;
	Thu, 10 Sep 2020 11:51:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lAXA9TbB65zN; Thu, 10 Sep 2020 11:51:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 1ED2486D31;
	Thu, 10 Sep 2020 11:51:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 00D12C0052;
	Thu, 10 Sep 2020 11:51:56 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1AF4CC0051
 for <iommu@lists.linux-foundation.org>; Thu, 10 Sep 2020 11:51:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 03C408766B
 for <iommu@lists.linux-foundation.org>; Thu, 10 Sep 2020 11:51:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id j57C0EMDSj-3 for <iommu@lists.linux-foundation.org>;
 Thu, 10 Sep 2020 11:51:53 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 6F01E8765E
 for <iommu@lists.linux-foundation.org>; Thu, 10 Sep 2020 11:51:53 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id D832C68C4E; Thu, 10 Sep 2020 13:51:48 +0200 (CEST)
Date: Thu, 10 Sep 2020 13:51:48 +0200
From: Christoph Hellwig <hch@lst.de>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 2/2] dma-debug: remove all exports
Message-ID: <20200910115148.GA5403@lst.de>
References: <20200908163959.3177173-1-hch@lst.de>
 <20200908163959.3177173-3-hch@lst.de>
 <3f414683-d399-17a1-676b-5b6f36e048fa@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <3f414683-d399-17a1-676b-5b6f36e048fa@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: iommu@lists.linux-foundation.org, Christoph Hellwig <hch@lst.de>
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

On Thu, Sep 10, 2020 at 12:45:09PM +0100, Robin Murphy wrote:
> FWIW I did briefly look at how much of dma-debug we could drop from 
> dma-mapping.h and make entirely private to kernel/dma/, but couldn't 
> convince myself that an awkward split with a few calls still needing to be 
> public would be worthwhile.

I've stared to look into a major dma header reshuffle, basically
have dma-mapping.h only contain the API needed by consumer of the
DMA API, a new linux/dma-map-ops.h for providers, and everyting else
under kernel/dma/.  The initial prototype looks nice, but I need to
finish off a few lose ends.

>> -EXPORT_SYMBOL(debug_dma_map_single);
>
> This is still called inline via dma_map_single_attrs(), no?
>
>>   }
>> -EXPORT_SYMBOL(debug_dma_mapping_error);
>
> Ditto this for dma_mapping_error(). We hardly want to discourage modules 
> from calling that ;)
>
> With those fixed (unless I've missed some other preceding change),

Also yes.  I actually fixed it up locall this morning, this is what
I have now:

---
From 8a310506789611f7a9426e270a8bac647d6f4b1b Mon Sep 17 00:00:00 2001
From: Christoph Hellwig <hch@lst.de>
Date: Tue, 8 Sep 2020 18:35:24 +0200
Subject: dma-debug: remove most exports

Now that the main dma mapping entry points are out of line most of the
symbols in dma-debug.c can only be called from built-in code.  Remove
the unused exports.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 kernel/dma/debug.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
index 8e9f7b301c6d39..6f53c2e03aa4f8 100644
--- a/kernel/dma/debug.c
+++ b/kernel/dma/debug.c
@@ -1235,7 +1235,6 @@ void debug_dma_map_page(struct device *dev, struct page *page, size_t offset,
 
 	add_dma_entry(entry);
 }
-EXPORT_SYMBOL(debug_dma_map_page);
 
 void debug_dma_mapping_error(struct device *dev, dma_addr_t dma_addr)
 {
@@ -1290,7 +1289,6 @@ void debug_dma_unmap_page(struct device *dev, dma_addr_t addr,
 		return;
 	check_unmap(&ref);
 }
-EXPORT_SYMBOL(debug_dma_unmap_page);
 
 void debug_dma_map_sg(struct device *dev, struct scatterlist *sg,
 		      int nents, int mapped_ents, int direction)
@@ -1328,7 +1326,6 @@ void debug_dma_map_sg(struct device *dev, struct scatterlist *sg,
 		add_dma_entry(entry);
 	}
 }
-EXPORT_SYMBOL(debug_dma_map_sg);
 
 static int get_nr_mapped_entries(struct device *dev,
 				 struct dma_debug_entry *ref)
@@ -1380,7 +1377,6 @@ void debug_dma_unmap_sg(struct device *dev, struct scatterlist *sglist,
 		check_unmap(&ref);
 	}
 }
-EXPORT_SYMBOL(debug_dma_unmap_sg);
 
 void debug_dma_alloc_coherent(struct device *dev, size_t size,
 			      dma_addr_t dma_addr, void *virt)
@@ -1466,7 +1462,6 @@ void debug_dma_map_resource(struct device *dev, phys_addr_t addr, size_t size,
 
 	add_dma_entry(entry);
 }
-EXPORT_SYMBOL(debug_dma_map_resource);
 
 void debug_dma_unmap_resource(struct device *dev, dma_addr_t dma_addr,
 			      size_t size, int direction)
@@ -1484,7 +1479,6 @@ void debug_dma_unmap_resource(struct device *dev, dma_addr_t dma_addr,
 
 	check_unmap(&ref);
 }
-EXPORT_SYMBOL(debug_dma_unmap_resource);
 
 void debug_dma_sync_single_for_cpu(struct device *dev, dma_addr_t dma_handle,
 				   size_t size, int direction)
@@ -1503,7 +1497,6 @@ void debug_dma_sync_single_for_cpu(struct device *dev, dma_addr_t dma_handle,
 
 	check_sync(dev, &ref, true);
 }
-EXPORT_SYMBOL(debug_dma_sync_single_for_cpu);
 
 void debug_dma_sync_single_for_device(struct device *dev,
 				      dma_addr_t dma_handle, size_t size,
@@ -1523,7 +1516,6 @@ void debug_dma_sync_single_for_device(struct device *dev,
 
 	check_sync(dev, &ref, false);
 }
-EXPORT_SYMBOL(debug_dma_sync_single_for_device);
 
 void debug_dma_sync_sg_for_cpu(struct device *dev, struct scatterlist *sg,
 			       int nelems, int direction)
@@ -1556,7 +1548,6 @@ void debug_dma_sync_sg_for_cpu(struct device *dev, struct scatterlist *sg,
 		check_sync(dev, &ref, true);
 	}
 }
-EXPORT_SYMBOL(debug_dma_sync_sg_for_cpu);
 
 void debug_dma_sync_sg_for_device(struct device *dev, struct scatterlist *sg,
 				  int nelems, int direction)
@@ -1588,7 +1579,6 @@ void debug_dma_sync_sg_for_device(struct device *dev, struct scatterlist *sg,
 		check_sync(dev, &ref, false);
 	}
 }
-EXPORT_SYMBOL(debug_dma_sync_sg_for_device);
 
 static int __init dma_debug_driver_setup(char *str)
 {
-- 
2.28.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
