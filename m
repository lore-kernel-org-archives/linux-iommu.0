Return-Path: <SRS0=AxcK=KG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F022DC43470
	for <iommu@archiver.kernel.org>; Tue, 11 May 2021 16:06:17 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DC6361921
	for <iommu@archiver.kernel.org>; Tue, 11 May 2021 16:06:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DC6361921
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4993F4055B;
	Tue, 11 May 2021 16:06:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ab5jGTr1R0um; Tue, 11 May 2021 16:06:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id AB3AD40565;
	Tue, 11 May 2021 16:06:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 80B8CC000E;
	Tue, 11 May 2021 16:06:13 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2C462C0001
 for <iommu@lists.linux-foundation.org>; Tue, 11 May 2021 16:06:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 286DD60803
 for <iommu@lists.linux-foundation.org>; Tue, 11 May 2021 16:06:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6eDHDv1YLNVE for <iommu@lists.linux-foundation.org>;
 Tue, 11 May 2021 16:06:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 28B3B607DE
 for <iommu@lists.linux-foundation.org>; Tue, 11 May 2021 16:06:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1620749170;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AYzMm9vNy1mQ7xlxpQxo7ktyLZlBtsEnRv4GpKCQ6cM=;
 b=P3/hiWxNSBvfzpNFzhYzMVPUIuNgkofygjKjrxv7nhpHrSywrzOl/U1rXPDYKcoCJBC9/f
 scIGN+UKn0zqX4NbUqZBQKIVl5uVPORUmEukoZy90XFQHjH1Z1m39Sq9Vy0xkQVJaKSxGf
 qBIorXlUVYfo8WSvmc7gsJTXJvSHkIY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-153-mqNbg_zrPqi8D2Qovi2qcA-1; Tue, 11 May 2021 12:06:05 -0400
X-MC-Unique: mqNbg_zrPqi8D2Qovi2qcA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 006E2FC8E;
 Tue, 11 May 2021 16:06:01 +0000 (UTC)
Received: from [10.3.115.19] (ovpn-115-19.phx2.redhat.com [10.3.115.19])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0FBB95C232;
 Tue, 11 May 2021 16:05:56 +0000 (UTC)
Subject: Re: [PATCH 05/16] dma-mapping: Introduce dma_map_sg_p2pdma()
To: Logan Gunthorpe <logang@deltatee.com>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org
References: <20210408170123.8788-1-logang@deltatee.com>
 <20210408170123.8788-6-logang@deltatee.com>
From: Don Dutile <ddutile@redhat.com>
Message-ID: <a59daad2-31eb-b7b6-d68f-f42d717dbc2c@redhat.com>
Date: Tue, 11 May 2021 12:05:56 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20210408170123.8788-6-logang@deltatee.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Cc: Minturn Dave B <dave.b.minturn@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 John Hubbard <jhubbard@nvidia.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 Robin Murphy <robin.murphy@arm.com>, Matthew Wilcox <willy@infradead.org>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Bjorn Helgaas <helgaas@kernel.org>,
 Jason Ekstrand <jason@jlekstrand.net>, Daniel Vetter <daniel.vetter@ffwll.ch>,
 Dan Williams <dan.j.williams@intel.com>, Stephen Bates <sbates@raithlin.com>,
 Jakowski Andrzej <andrzej.jakowski@intel.com>, Christoph Hellwig <hch@lst.de>,
 Xiong Jianxin <jianxin.xiong@intel.com>
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

On 4/8/21 1:01 PM, Logan Gunthorpe wrote:
> dma_map_sg() either returns a positive number indicating the number
> of entries mapped or zero indicating that resources were not available
> to create the mapping. When zero is returned, it is always safe to retry
> the mapping later once resources have been freed.
>
> Once P2PDMA pages are mixed into the SGL there may be pages that may
> never be successfully mapped with a given device because that device may
> not actually be able to access those pages. Thus, multiple error
> conditions will need to be distinguished to determine weather a retry
s/weather/whether/
> is safe.
>
> Introduce dma_map_sg_p2pdma[_attrs]() with a different calling
> convention from dma_map_sg(). The function will return a positive
> integer on success or a negative errno on failure.
>
> ENOMEM will be used to indicate a resource failure and EREMOTEIO to
> indicate that a P2PDMA page is not mappable.
>
> The __DMA_ATTR_PCI_P2PDMA attribute is introduced to inform the lower
> level implementations that P2PDMA pages are allowed and to warn if a
> caller introduces them into the regular dma_map_sg() interface.
>
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
John caught any other comment I had (and more).
-dd

> ---
>   include/linux/dma-mapping.h | 15 +++++++++++
>   kernel/dma/mapping.c        | 52 ++++++++++++++++++++++++++++++++-----
>   2 files changed, 61 insertions(+), 6 deletions(-)
>
> diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> index 2a984cb4d1e0..50b8f586cf59 100644
> --- a/include/linux/dma-mapping.h
> +++ b/include/linux/dma-mapping.h
> @@ -60,6 +60,12 @@
>    * at least read-only at lesser-privileged levels).
>    */
>   #define DMA_ATTR_PRIVILEGED		(1UL << 9)
> +/*
> + * __DMA_ATTR_PCI_P2PDMA: This should not be used directly, use
> + * dma_map_sg_p2pdma() instead. Used internally to indicate that the
> + * caller is using the dma_map_sg_p2pdma() interface.
> + */
> +#define __DMA_ATTR_PCI_P2PDMA		(1UL << 10)
>   
>   /*
>    * A dma_addr_t can hold any valid DMA or bus address for the platform.  It can
> @@ -107,6 +113,8 @@ void dma_unmap_page_attrs(struct device *dev, dma_addr_t addr, size_t size,
>   		enum dma_data_direction dir, unsigned long attrs);
>   int dma_map_sg_attrs(struct device *dev, struct scatterlist *sg, int nents,
>   		enum dma_data_direction dir, unsigned long attrs);
> +int dma_map_sg_p2pdma_attrs(struct device *dev, struct scatterlist *sg,
> +		int nents, enum dma_data_direction dir, unsigned long attrs);
>   void dma_unmap_sg_attrs(struct device *dev, struct scatterlist *sg,
>   				      int nents, enum dma_data_direction dir,
>   				      unsigned long attrs);
> @@ -160,6 +168,12 @@ static inline int dma_map_sg_attrs(struct device *dev, struct scatterlist *sg,
>   {
>   	return 0;
>   }
> +static inline int dma_map_sg_p2pdma_attrs(struct device *dev,
> +		struct scatterlist *sg, int nents, enum dma_data_direction dir,
> +		unsigned long attrs)
> +{
> +	return 0;
> +}
>   static inline void dma_unmap_sg_attrs(struct device *dev,
>   		struct scatterlist *sg, int nents, enum dma_data_direction dir,
>   		unsigned long attrs)
> @@ -392,6 +406,7 @@ static inline void dma_sync_sgtable_for_device(struct device *dev,
>   #define dma_map_single(d, a, s, r) dma_map_single_attrs(d, a, s, r, 0)
>   #define dma_unmap_single(d, a, s, r) dma_unmap_single_attrs(d, a, s, r, 0)
>   #define dma_map_sg(d, s, n, r) dma_map_sg_attrs(d, s, n, r, 0)
> +#define dma_map_sg_p2pdma(d, s, n, r) dma_map_sg_p2pdma_attrs(d, s, n, r, 0)
>   #define dma_unmap_sg(d, s, n, r) dma_unmap_sg_attrs(d, s, n, r, 0)
>   #define dma_map_page(d, p, o, s, r) dma_map_page_attrs(d, p, o, s, r, 0)
>   #define dma_unmap_page(d, a, s, r) dma_unmap_page_attrs(d, a, s, r, 0)
> diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
> index b6a633679933..923089c4267b 100644
> --- a/kernel/dma/mapping.c
> +++ b/kernel/dma/mapping.c
> @@ -177,12 +177,8 @@ void dma_unmap_page_attrs(struct device *dev, dma_addr_t addr, size_t size,
>   }
>   EXPORT_SYMBOL(dma_unmap_page_attrs);
>   
> -/*
> - * dma_maps_sg_attrs returns 0 on error and > 0 on success.
> - * It should never return a value < 0.
> - */
> -int dma_map_sg_attrs(struct device *dev, struct scatterlist *sg, int nents,
> -		enum dma_data_direction dir, unsigned long attrs)
> +static int __dma_map_sg_attrs(struct device *dev, struct scatterlist *sg,
> +		int nents, enum dma_data_direction dir, unsigned long attrs)
>   {
>   	const struct dma_map_ops *ops = get_dma_ops(dev);
>   	int ents;
> @@ -197,6 +193,20 @@ int dma_map_sg_attrs(struct device *dev, struct scatterlist *sg, int nents,
>   		ents = dma_direct_map_sg(dev, sg, nents, dir, attrs);
>   	else
>   		ents = ops->map_sg(dev, sg, nents, dir, attrs);
> +
> +	return ents;
> +}
> +
> +/*
> + * dma_maps_sg_attrs returns 0 on error and > 0 on success.
> + * It should never return a value < 0.
> + */
> +int dma_map_sg_attrs(struct device *dev, struct scatterlist *sg, int nents,
> +		enum dma_data_direction dir, unsigned long attrs)
> +{
> +	int ents;
> +
> +	ents = __dma_map_sg_attrs(dev, sg, nents, dir, attrs);
>   	BUG_ON(ents < 0);
>   	debug_dma_map_sg(dev, sg, nents, ents, dir);
>   
> @@ -204,6 +214,36 @@ int dma_map_sg_attrs(struct device *dev, struct scatterlist *sg, int nents,
>   }
>   EXPORT_SYMBOL(dma_map_sg_attrs);
>   
> +/*
> + * like dma_map_sg_attrs, but returns a negative errno on error (and > 0
> + * on success). This function must be used if PCI P2PDMA pages might
> + * be in the scatterlist.
> + *
> + * On error this function may return:
> + *    -ENOMEM indicating that there was not enough resources available and
> + *      the transfer may be retried later
> + *    -EREMOTEIO indicating that P2PDMA pages were included but cannot
> + *      be mapped by the specified device, retries will always fail
> + *
> + * The scatterlist should be unmapped with the regular dma_unmap_sg[_attrs]().
> + */
> +int dma_map_sg_p2pdma_attrs(struct device *dev, struct scatterlist *sg,
> +		int nents, enum dma_data_direction dir, unsigned long attrs)
> +{
> +	int ents;
> +
> +	ents = __dma_map_sg_attrs(dev, sg, nents, dir,
> +				  attrs | __DMA_ATTR_PCI_P2PDMA);
> +	if (!ents)
> +		ents = -ENOMEM;
> +
> +	if (ents > 0)
> +		debug_dma_map_sg(dev, sg, nents, ents, dir);
> +
> +	return ents;
> +}
> +EXPORT_SYMBOL_GPL(dma_map_sg_p2pdma_attrs);
> +
>   void dma_unmap_sg_attrs(struct device *dev, struct scatterlist *sg,
>   				      int nents, enum dma_data_direction dir,
>   				      unsigned long attrs)

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
