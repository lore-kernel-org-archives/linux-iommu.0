Return-Path: <SRS0=32yV=6V=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60ADFC38A2A
	for <iommu@archiver.kernel.org>; Thu,  7 May 2020 08:48:03 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 286D62075E
	for <iommu@archiver.kernel.org>; Thu,  7 May 2020 08:48:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="OsQAOw4B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 286D62075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xs4all.nl
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id E45E488E52;
	Thu,  7 May 2020 08:48:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id O0xddh2e2W4T; Thu,  7 May 2020 08:48:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 8E517878AC;
	Thu,  7 May 2020 08:48:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 65F01C0859;
	Thu,  7 May 2020 08:48:01 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3062CC07FF
 for <iommu@lists.linux-foundation.org>; Thu,  7 May 2020 08:48:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 18DF7871DE
 for <iommu@lists.linux-foundation.org>; Thu,  7 May 2020 08:48:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 368_7ZJTNRzH for <iommu@lists.linux-foundation.org>;
 Thu,  7 May 2020 08:47:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from lb2-smtp-cloud7.xs4all.net (lb2-smtp-cloud7.xs4all.net
 [194.109.24.28])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id D95DE864E6
 for <iommu@lists.linux-foundation.org>; Thu,  7 May 2020 08:47:57 +0000 (UTC)
Received: from cust-b5b5937f ([IPv6:fc0c:c16d:66b8:757f:c639:739b:9d66:799d])
 by smtp-cloud7.xs4all.net with ESMTPA
 id WcByjUh3NtKAsWcC2jYyHm; Thu, 07 May 2020 10:47:55 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=s1;
 t=1588841275; bh=GOj2i2e0G1hf/TdwWNiZFyEjE3oPm0LZIISDTcjRCZ0=;
 h=Subject:To:From:Message-ID:Date:MIME-Version:Content-Type:From:
 Subject;
 b=OsQAOw4BCiMS8nSpCtEbPal3MaDqPDcvb/AHQPtbrBn3ybi/ChB9KwzXym2ZJIKEO
 9n3yxwQxFyEQdTZjBDavlhIJ3bwHq99nJquR43ukYrIEo8zFaxzzorFeTA9UX6Mxr7
 ZfY09bw58dMpE1iugEl5bl4lD2KkLSoIqeZRlTxUsbmPi2ileE8h9LVdgcYdY9J02p
 k1SYzSlQ04u5cqWHv/K/V44E8Dcc8g5gk1hF/kcK5zfD+Q794ZuD51BKklzQ44VlF+
 cM8xZ14JNalRlgsLP5+CJKpqYIx2q5sysXW+fsaZppDUXAwt1PStxKdRo87bHZXmb7
 3ArwWoakmqsyA==
Subject: Re: [PATCH v3 01/25] dma-mapping: add generic helpers for mapping
 sgtable objects
To: Marek Szyprowski <m.szyprowski@samsung.com>,
 dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
References: <20200505083926.28503-1-m.szyprowski@samsung.com>
 <CGME20200505084624eucas1p2a9a5c4d2aece2c1555a5480c19c2e050@eucas1p2.samsung.com>
 <20200505084614.30424-1-m.szyprowski@samsung.com>
From: Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <13d9029f-7d03-3624-1e22-f88b769e1b30@xs4all.nl>
Date: Thu, 7 May 2020 10:47:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200505084614.30424-1-m.szyprowski@samsung.com>
Content-Language: en-US
X-CMAE-Envelope: MS4wfAY0hozkR2I/OEMAY07+RlgR2H0QspkxLI2sVoCrd7jtub/9esOqC31rXfxbYuIfHeJywJq8p3okwW7LEnUgwRaMNBLBmY8XaNmNC1q8aD5iqeqrS0+3
 loy39fSj6vKmxMdJ/t/aMa5txJkwIIgY1BiELtj9686KjXylfnKrRwbDajHHCli2Nt7ZhivGlG/zCAB4/X+SSpgwR3rKKJZiUe5NvgAh6hGEoywFvYE1HSZk
 q2x9Is67YxPhYF4ju5OX4UztbgGbpq5EbFAyWG1RHCFu9yQ5Xdwa10osaZR9lg5ePqvj8UY1Fu1L8YZnB5pron1MFYUvqMX5G0z5T/LdyqVpebpH/rQ9ob5x
 cZNA271ZHYJvk7MTMWGAknMenTl9VrTI2Ivs0vG9seLlf4sMGjm+toxhFV+oKDbGOQKvfDpBZExiNqoOmA0VuD+gBc1WsPWoLRlo0kmF1APZyBumzDdWHIU4
 tkK7mecVvV6KzLBwTtyGvFU8TRAxyohKPBqdfyxWZKckt5QzTXjamshO2gVMKfD22MppB9HSSp4M5Fy+
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 David Airlie <airlied@linux.ie>, Robin Murphy <robin.murphy@arm.com>,
 Christoph Hellwig <hch@lst.de>, linux-arm-kernel@lists.infradead.org
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

Hi Marek,

On 05/05/2020 10:45, Marek Szyprowski wrote:
> struct sg_table is a common structure used for describing a memory
> buffer. It consists of a scatterlist with memory pages and DMA addresses
> (sgl entry), as well as the number of scatterlist entries: CPU pages
> (orig_nents entry) and DMA pages (nents entry).
> 
> It turned out that it was a common mistake to misuse nents and orig_nents
> entries, call dma-mapping functions with a wrong number of entries or
> ignoring the number of mapped entries returned by the dma_map_sg
> function.
> 
> To avoid such issues, lets introduce a common wrappers operating directly
> on the struct sg_table objects, which take care of the proper use of
> the nents and orig_nents entries.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  include/linux/dma-mapping.h | 32 ++++++++++++++++++++++++++++++++
>  include/linux/iommu.h       |  6 ++++++
>  2 files changed, 38 insertions(+)
> 
> diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> index b43116a..8364c20d 100644
> --- a/include/linux/dma-mapping.h
> +++ b/include/linux/dma-mapping.h
> @@ -609,6 +609,36 @@ static inline void dma_sync_single_range_for_device(struct device *dev,
>  	return dma_sync_single_for_device(dev, addr + offset, size, dir);
>  }
>  
> +static inline int dma_map_sgtable_attrs(struct device *dev,
> +	struct sg_table *sgt, enum dma_data_direction dir, unsigned long attrs)

Please document these new inline functions!

The core reason IMHO why so many drivers do this wrong is that the struct sg_table
documentation is very poor. In particular w.r.t. how the nents and orig_nents
fields should be used.

It confused me, and clearly I am not alone in that.

So while this is a very nice improvement, it doesn't address the core issue, i.e.
the documentation.

Especially some examples on how to use these new functions would be welcome.

Regards,

	Hans

> +{
> +	int n = dma_map_sg_attrs(dev, sgt->sgl, sgt->orig_nents, dir, attrs);
> +
> +	if (n > 0) {
> +		sgt->nents = n;
> +		return 0;
> +	}
> +	return -EINVAL;
> +}
> +
> +static inline void dma_unmap_sgtable_attrs(struct device *dev,
> +	struct sg_table *sgt, enum dma_data_direction dir, unsigned long attrs)
> +{
> +	dma_unmap_sg_attrs(dev, sgt->sgl, sgt->orig_nents, dir, attrs);
> +}
> +
> +static inline void dma_sync_sgtable_for_cpu(struct device *dev,
> +	struct sg_table *sgt, enum dma_data_direction dir)
> +{
> +	dma_sync_sg_for_cpu(dev, sgt->sgl, sgt->orig_nents, dir);
> +}
> +
> +static inline void dma_sync_sgtable_for_device(struct device *dev,
> +	struct sg_table *sgt, enum dma_data_direction dir)
> +{
> +	dma_sync_sg_for_device(dev, sgt->sgl, sgt->orig_nents, dir);
> +}
> +
>  #define dma_map_single(d, a, s, r) dma_map_single_attrs(d, a, s, r, 0)
>  #define dma_unmap_single(d, a, s, r) dma_unmap_single_attrs(d, a, s, r, 0)
>  #define dma_map_sg(d, s, n, r) dma_map_sg_attrs(d, s, n, r, 0)
> @@ -617,6 +647,8 @@ static inline void dma_sync_single_range_for_device(struct device *dev,
>  #define dma_unmap_page(d, a, s, r) dma_unmap_page_attrs(d, a, s, r, 0)
>  #define dma_get_sgtable(d, t, v, h, s) dma_get_sgtable_attrs(d, t, v, h, s, 0)
>  #define dma_mmap_coherent(d, v, c, h, s) dma_mmap_attrs(d, v, c, h, s, 0)
> +#define dma_map_sgtable(d, s, r) dma_map_sgtable_attrs(d, s, r, 0)
> +#define dma_unmap_sgtable(d, s, r) dma_unmap_sgtable_attrs(d, s, r, 0)
>  
>  extern int dma_common_mmap(struct device *dev, struct vm_area_struct *vma,
>  		void *cpu_addr, dma_addr_t dma_addr, size_t size,
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 7ef8b0b..5106b65 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -466,6 +466,12 @@ extern size_t iommu_map_sg_atomic(struct iommu_domain *domain,
>  extern void iommu_set_fault_handler(struct iommu_domain *domain,
>  			iommu_fault_handler_t handler, void *token);
>  
> +static inline size_t iommu_map_sgtable(struct iommu_domain *domain,
> +			unsigned long iova, struct sg_table *sgt, int prot)
> +{
> +	return iommu_map_sg(domain, iova, sgt->sgl, sgt->orig_nents, prot);
> +}
> +
>  extern void iommu_get_resv_regions(struct device *dev, struct list_head *list);
>  extern void iommu_put_resv_regions(struct device *dev, struct list_head *list);
>  extern void generic_iommu_put_resv_regions(struct device *dev,
> 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
