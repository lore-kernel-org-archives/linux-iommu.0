Return-Path: <SRS0=7VEr=CT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC7E1C433E2
	for <iommu@archiver.kernel.org>; Thu, 10 Sep 2020 11:45:17 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 319512145D
	for <iommu@archiver.kernel.org>; Thu, 10 Sep 2020 11:45:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 319512145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id D3BEC86A40;
	Thu, 10 Sep 2020 11:45:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rVqhy3CqO3kj; Thu, 10 Sep 2020 11:45:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 2A60286F5A;
	Thu, 10 Sep 2020 11:45:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 04F4BC0052;
	Thu, 10 Sep 2020 11:45:16 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1568DC0051
 for <iommu@lists.linux-foundation.org>; Thu, 10 Sep 2020 11:45:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 0E8CD86F5A
 for <iommu@lists.linux-foundation.org>; Thu, 10 Sep 2020 11:45:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id C13hJJt_xY_v for <iommu@lists.linux-foundation.org>;
 Thu, 10 Sep 2020 11:45:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by fraxinus.osuosl.org (Postfix) with ESMTP id D5A6086A40
 for <iommu@lists.linux-foundation.org>; Thu, 10 Sep 2020 11:45:13 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DDAF61045;
 Thu, 10 Sep 2020 04:45:12 -0700 (PDT)
Received: from [10.57.40.122] (unknown [10.57.40.122])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 41C013F68F;
 Thu, 10 Sep 2020 04:45:12 -0700 (PDT)
Subject: Re: [PATCH 2/2] dma-debug: remove all exports
To: Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org
References: <20200908163959.3177173-1-hch@lst.de>
 <20200908163959.3177173-3-hch@lst.de>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <3f414683-d399-17a1-676b-5b6f36e048fa@arm.com>
Date: Thu, 10 Sep 2020 12:45:09 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200908163959.3177173-3-hch@lst.de>
Content-Language: en-GB
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 2020-09-08 17:39, Christoph Hellwig wrote:
> Now that the main dma mapping entry points are out of line none
> of these functions can be called from modular code.

FWIW I did briefly look at how much of dma-debug we could drop from 
dma-mapping.h and make entirely private to kernel/dma/, but couldn't 
convince myself that an awkward split with a few calls still needing to 
be public would be worthwhile.

> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   kernel/dma/debug.c | 12 ------------
>   1 file changed, 12 deletions(-)
> 
> diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
> index 8e9f7b301c6d39..9e5370e3700c08 100644
> --- a/kernel/dma/debug.c
> +++ b/kernel/dma/debug.c
> @@ -1199,7 +1199,6 @@ void debug_dma_map_single(struct device *dev, const void *addr,
>   		err_printk(dev, NULL, "device driver maps memory from vmalloc area [addr=%p] [len=%lu]\n",
>   			   addr, len);
>   }
> -EXPORT_SYMBOL(debug_dma_map_single);

This is still called inline via dma_map_single_attrs(), no?

>   void debug_dma_map_page(struct device *dev, struct page *page, size_t offset,
>   			size_t size, int direction, dma_addr_t dma_addr)
> @@ -1235,7 +1234,6 @@ void debug_dma_map_page(struct device *dev, struct page *page, size_t offset,
>   
>   	add_dma_entry(entry);
>   }
> -EXPORT_SYMBOL(debug_dma_map_page);
>   
>   void debug_dma_mapping_error(struct device *dev, dma_addr_t dma_addr)
>   {
> @@ -1273,7 +1271,6 @@ void debug_dma_mapping_error(struct device *dev, dma_addr_t dma_addr)
>   
>   	put_hash_bucket(bucket, flags);
>   }
> -EXPORT_SYMBOL(debug_dma_mapping_error);

Ditto this for dma_mapping_error(). We hardly want to discourage modules 
from calling that ;)

With those fixed (unless I've missed some other preceding change),

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

Cheers,
Robin.

>   void debug_dma_unmap_page(struct device *dev, dma_addr_t addr,
>   			  size_t size, int direction)
> @@ -1290,7 +1287,6 @@ void debug_dma_unmap_page(struct device *dev, dma_addr_t addr,
>   		return;
>   	check_unmap(&ref);
>   }
> -EXPORT_SYMBOL(debug_dma_unmap_page);
>   
>   void debug_dma_map_sg(struct device *dev, struct scatterlist *sg,
>   		      int nents, int mapped_ents, int direction)
> @@ -1328,7 +1324,6 @@ void debug_dma_map_sg(struct device *dev, struct scatterlist *sg,
>   		add_dma_entry(entry);
>   	}
>   }
> -EXPORT_SYMBOL(debug_dma_map_sg);
>   
>   static int get_nr_mapped_entries(struct device *dev,
>   				 struct dma_debug_entry *ref)
> @@ -1380,7 +1375,6 @@ void debug_dma_unmap_sg(struct device *dev, struct scatterlist *sglist,
>   		check_unmap(&ref);
>   	}
>   }
> -EXPORT_SYMBOL(debug_dma_unmap_sg);
>   
>   void debug_dma_alloc_coherent(struct device *dev, size_t size,
>   			      dma_addr_t dma_addr, void *virt)
> @@ -1466,7 +1460,6 @@ void debug_dma_map_resource(struct device *dev, phys_addr_t addr, size_t size,
>   
>   	add_dma_entry(entry);
>   }
> -EXPORT_SYMBOL(debug_dma_map_resource);
>   
>   void debug_dma_unmap_resource(struct device *dev, dma_addr_t dma_addr,
>   			      size_t size, int direction)
> @@ -1484,7 +1477,6 @@ void debug_dma_unmap_resource(struct device *dev, dma_addr_t dma_addr,
>   
>   	check_unmap(&ref);
>   }
> -EXPORT_SYMBOL(debug_dma_unmap_resource);
>   
>   void debug_dma_sync_single_for_cpu(struct device *dev, dma_addr_t dma_handle,
>   				   size_t size, int direction)
> @@ -1503,7 +1495,6 @@ void debug_dma_sync_single_for_cpu(struct device *dev, dma_addr_t dma_handle,
>   
>   	check_sync(dev, &ref, true);
>   }
> -EXPORT_SYMBOL(debug_dma_sync_single_for_cpu);
>   
>   void debug_dma_sync_single_for_device(struct device *dev,
>   				      dma_addr_t dma_handle, size_t size,
> @@ -1523,7 +1514,6 @@ void debug_dma_sync_single_for_device(struct device *dev,
>   
>   	check_sync(dev, &ref, false);
>   }
> -EXPORT_SYMBOL(debug_dma_sync_single_for_device);
>   
>   void debug_dma_sync_sg_for_cpu(struct device *dev, struct scatterlist *sg,
>   			       int nelems, int direction)
> @@ -1556,7 +1546,6 @@ void debug_dma_sync_sg_for_cpu(struct device *dev, struct scatterlist *sg,
>   		check_sync(dev, &ref, true);
>   	}
>   }
> -EXPORT_SYMBOL(debug_dma_sync_sg_for_cpu);
>   
>   void debug_dma_sync_sg_for_device(struct device *dev, struct scatterlist *sg,
>   				  int nelems, int direction)
> @@ -1588,7 +1577,6 @@ void debug_dma_sync_sg_for_device(struct device *dev, struct scatterlist *sg,
>   		check_sync(dev, &ref, false);
>   	}
>   }
> -EXPORT_SYMBOL(debug_dma_sync_sg_for_device);
>   
>   static int __init dma_debug_driver_setup(char *str)
>   {
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
