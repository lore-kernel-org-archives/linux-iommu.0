Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C9E5C433FE
	for <iommu@archiver.kernel.org>; Sat, 30 Apr 2022 04:12:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 14DDC60A9B;
	Sat, 30 Apr 2022 04:12:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id p7wqThGaw3FQ; Sat, 30 Apr 2022 04:12:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 9391C60A98;
	Sat, 30 Apr 2022 04:12:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5CFC2C0032;
	Sat, 30 Apr 2022 04:12:00 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BDAD3C002D
 for <iommu@lists.linux-foundation.org>; Sat, 30 Apr 2022 04:11:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id AB8CE4088C
 for <iommu@lists.linux-foundation.org>; Sat, 30 Apr 2022 04:11:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VVDWTcO0whe2 for <iommu@lists.linux-foundation.org>;
 Sat, 30 Apr 2022 04:11:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 38E374087D
 for <iommu@lists.linux-foundation.org>; Sat, 30 Apr 2022 04:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1651291917; x=1682827917;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=M4ApWe30dZrJzIldBGr5eaJaZ5nwJjnAqUCAfnpMWSI=;
 b=PZGbZPhtvsbkIq01/bHqfR3b49Bv0bxz65dkfvVoBeviJfO4IxKdrJpd
 TZoCTZcnttHxUm0/KTcXotSuv2sLtBqwKUIhmSdfIEGkEJytOvqvHtSor
 hi6Qnv5e6mBjr1McDRvMifsPY0bDlxpVC0xfGAzTvMk28Z4ioQP/5jZlU
 VwdNx2eh6r/lDaaUE0/KnJ5DTIeUe25rhmcOy3t0hL7bZVHqugaA1VRpQ
 8OpjfV0lKvuXZKCiy8NmpdjsY8iDQYkzq0yZ9vdjacNbpv3B+afpMcsMc
 eQzTMIvLLrqZroPom0jo501UZuhb3N6KUzZMZZvryG/L4rERF6lkq+aft g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10332"; a="247386159"
X-IronPort-AV: E=Sophos;i="5.91,187,1647327600"; d="scan'208";a="247386159"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Apr 2022 21:11:55 -0700
X-IronPort-AV: E=Sophos;i="5.91,187,1647327600"; d="scan'208";a="582576210"
Received: from aliu1-mobl.ccr.corp.intel.com (HELO [10.255.30.71])
 ([10.255.30.71])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Apr 2022 21:11:50 -0700
Message-ID: <d80b318d-278b-2592-8665-e5dec91f70e3@linux.intel.com>
Date: Sat, 30 Apr 2022 12:11:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH RFC 03/19] iommufd: Dirty tracking data support
Content-Language: en-US
To: Joao Martins <joao.m.martins@oracle.com>, iommu@lists.linux-foundation.org
References: <20220428210933.3583-1-joao.m.martins@oracle.com>
 <20220428210933.3583-4-joao.m.martins@oracle.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20220428210933.3583-4-joao.m.martins@oracle.com>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Kevin Tian <kevin.tian@intel.com>, Yishai Hadas <yishaih@nvidia.com>,
 Jason Gunthorpe <jgg@nvidia.com>, kvm@vger.kernel.org,
 Will Deacon <will@kernel.org>, Cornelia Huck <cohuck@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 David Woodhouse <dwmw2@infradead.org>, Robin Murphy <robin.murphy@arm.com>
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

On 2022/4/29 05:09, Joao Martins wrote:
> Add an IO pagetable API iopt_read_and_clear_dirty_data() that
> performs the reading of dirty IOPTEs for a given IOVA range and
> then copying back to userspace from each area-internal bitmap.
> 
> Underneath it uses the IOMMU equivalent API which will read the
> dirty bits, as well as atomically clearing the IOPTE dirty bit
> and flushing the IOTLB at the end. The dirty bitmaps pass an
> iotlb_gather to allow batching the dirty-bit updates.
> 
> Most of the complexity, though, is in the handling of the user
> bitmaps to avoid copies back and forth. The bitmap user addresses
> need to be iterated through, pinned and then passing the pages
> into iommu core. The amount of bitmap data passed at a time for a
> read_and_clear_dirty() is 1 page worth of pinned base page
> pointers. That equates to 16M bits, or rather 64G of data that
> can be returned as 'dirtied'. The flush the IOTLB at the end of
> the whole scanned IOVA range, to defer as much as possible the
> potential DMA performance penalty.
> 
> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
> ---
>   drivers/iommu/iommufd/io_pagetable.c    | 169 ++++++++++++++++++++++++
>   drivers/iommu/iommufd/iommufd_private.h |  44 ++++++
>   2 files changed, 213 insertions(+)
> 
> diff --git a/drivers/iommu/iommufd/io_pagetable.c b/drivers/iommu/iommufd/io_pagetable.c
> index f4609ef369e0..835b5040fce9 100644
> --- a/drivers/iommu/iommufd/io_pagetable.c
> +++ b/drivers/iommu/iommufd/io_pagetable.c
> @@ -14,6 +14,7 @@
>   #include <linux/err.h>
>   #include <linux/slab.h>
>   #include <linux/errno.h>
> +#include <uapi/linux/iommufd.h>
>   
>   #include "io_pagetable.h"
>   
> @@ -347,6 +348,174 @@ int iopt_set_dirty_tracking(struct io_pagetable *iopt,
>   	return ret;
>   }
>   
> +int iommufd_dirty_iter_init(struct iommufd_dirty_iter *iter,
> +			    struct iommufd_dirty_data *bitmap)
> +{
> +	struct iommu_dirty_bitmap *dirty = &iter->dirty;
> +	unsigned long bitmap_len;
> +
> +	bitmap_len = dirty_bitmap_bytes(bitmap->length >> dirty->pgshift);
> +
> +	import_single_range(WRITE, bitmap->data, bitmap_len,
> +			    &iter->bitmap_iov, &iter->bitmap_iter);
> +	iter->iova = bitmap->iova;
> +
> +	/* Can record up to 64G at a time */
> +	dirty->pages = (struct page **) __get_free_page(GFP_KERNEL);
> +
> +	return !dirty->pages ? -ENOMEM : 0;
> +}
> +
> +void iommufd_dirty_iter_free(struct iommufd_dirty_iter *iter)
> +{
> +	struct iommu_dirty_bitmap *dirty = &iter->dirty;
> +
> +	if (dirty->pages) {
> +		free_page((unsigned long) dirty->pages);
> +		dirty->pages = NULL;
> +	}
> +}
> +
> +bool iommufd_dirty_iter_done(struct iommufd_dirty_iter *iter)
> +{
> +	return iov_iter_count(&iter->bitmap_iter) > 0;
> +}
> +
> +static inline unsigned long iommufd_dirty_iter_bytes(struct iommufd_dirty_iter *iter)
> +{
> +	unsigned long left = iter->bitmap_iter.count - iter->bitmap_iter.iov_offset;
> +
> +	left = min_t(unsigned long, left, (iter->dirty.npages << PAGE_SHIFT));
> +
> +	return left;
> +}
> +
> +unsigned long iommufd_dirty_iova_length(struct iommufd_dirty_iter *iter)
> +{
> +	unsigned long left = iommufd_dirty_iter_bytes(iter);
> +
> +	return ((BITS_PER_BYTE * left) << iter->dirty.pgshift);
> +}
> +
> +unsigned long iommufd_dirty_iova(struct iommufd_dirty_iter *iter)
> +{
> +	unsigned long skip = iter->bitmap_iter.iov_offset;
> +
> +	return iter->iova + ((BITS_PER_BYTE * skip) << iter->dirty.pgshift);
> +}
> +
> +void iommufd_dirty_iter_advance(struct iommufd_dirty_iter *iter)
> +{
> +	iov_iter_advance(&iter->bitmap_iter, iommufd_dirty_iter_bytes(iter));
> +}
> +
> +void iommufd_dirty_iter_put(struct iommufd_dirty_iter *iter)
> +{
> +	struct iommu_dirty_bitmap *dirty = &iter->dirty;
> +
> +	if (dirty->npages)
> +		unpin_user_pages(dirty->pages, dirty->npages);
> +}
> +
> +int iommufd_dirty_iter_get(struct iommufd_dirty_iter *iter)
> +{
> +	struct iommu_dirty_bitmap *dirty = &iter->dirty;
> +	unsigned long npages;
> +	unsigned long ret;
> +	void *addr;
> +
> +	addr = iter->bitmap_iov.iov_base + iter->bitmap_iter.iov_offset;
> +	npages = iov_iter_npages(&iter->bitmap_iter,
> +				 PAGE_SIZE / sizeof(struct page *));
> +
> +	ret = pin_user_pages_fast((unsigned long) addr, npages,
> +				  FOLL_WRITE, dirty->pages);
> +	if (ret <= 0)
> +		return -EINVAL;
> +
> +	dirty->npages = ret;
> +	dirty->iova = iommufd_dirty_iova(iter);
> +	dirty->start_offset = offset_in_page(addr);
> +	return 0;
> +}
> +
> +static int iommu_read_and_clear_dirty(struct iommu_domain *domain,
> +				      struct iommufd_dirty_data *bitmap)

This looks more like a helper in the iommu core. How about

	iommufd_read_clear_domain_dirty()?

> +{
> +	const struct iommu_domain_ops *ops = domain->ops;
> +	struct iommu_iotlb_gather gather;
> +	struct iommufd_dirty_iter iter;
> +	int ret = 0;
> +
> +	if (!ops || !ops->read_and_clear_dirty)
> +		return -EOPNOTSUPP;
> +
> +	iommu_dirty_bitmap_init(&iter.dirty, bitmap->iova,
> +				__ffs(bitmap->page_size), &gather);
> +	ret = iommufd_dirty_iter_init(&iter, bitmap);
> +	if (ret)
> +		return -ENOMEM;
> +
> +	for (; iommufd_dirty_iter_done(&iter);
> +	     iommufd_dirty_iter_advance(&iter)) {
> +		ret = iommufd_dirty_iter_get(&iter);
> +		if (ret)
> +			break;
> +
> +		ret = ops->read_and_clear_dirty(domain,
> +			iommufd_dirty_iova(&iter),
> +			iommufd_dirty_iova_length(&iter), &iter.dirty);
> +
> +		iommufd_dirty_iter_put(&iter);
> +
> +		if (ret)
> +			break;
> +	}
> +
> +	iommu_iotlb_sync(domain, &gather);
> +	iommufd_dirty_iter_free(&iter);
> +
> +	return ret;
> +}
> +
> +int iopt_read_and_clear_dirty_data(struct io_pagetable *iopt,
> +				   struct iommu_domain *domain,
> +				   struct iommufd_dirty_data *bitmap)
> +{
> +	unsigned long iova, length, iova_end;
> +	struct iommu_domain *dom;
> +	struct iopt_area *area;
> +	unsigned long index;
> +	int ret = -EOPNOTSUPP;
> +
> +	iova = bitmap->iova;
> +	length = bitmap->length - 1;
> +	if (check_add_overflow(iova, length, &iova_end))
> +		return -EOVERFLOW;
> +
> +	down_read(&iopt->iova_rwsem);
> +	area = iopt_find_exact_area(iopt, iova, iova_end);
> +	if (!area) {
> +		up_read(&iopt->iova_rwsem);
> +		return -ENOENT;
> +	}
> +
> +	if (!domain) {
> +		down_read(&iopt->domains_rwsem);
> +		xa_for_each(&iopt->domains, index, dom) {
> +			ret = iommu_read_and_clear_dirty(dom, bitmap);

Perhaps use @domain directly, hence no need the @dom?

	xa_for_each(&iopt->domains, index, domain) {
		ret = iommu_read_and_clear_dirty(domain, bitmap);

> +			if (ret)
> +				break;
> +		}
> +		up_read(&iopt->domains_rwsem);
> +	} else {
> +		ret = iommu_read_and_clear_dirty(domain, bitmap);
> +	}
> +
> +	up_read(&iopt->iova_rwsem);
> +	return ret;
> +}
> +
>   struct iopt_pages *iopt_get_pages(struct io_pagetable *iopt, unsigned long iova,
>   				  unsigned long *start_byte,
>   				  unsigned long length)
> diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
> index d00ef3b785c5..4c12b4a8f1a6 100644
> --- a/drivers/iommu/iommufd/iommufd_private.h
> +++ b/drivers/iommu/iommufd/iommufd_private.h
> @@ -8,6 +8,8 @@
>   #include <linux/xarray.h>
>   #include <linux/refcount.h>
>   #include <linux/uaccess.h>
> +#include <linux/iommu.h>
> +#include <linux/uio.h>
>   
>   struct iommu_domain;
>   struct iommu_group;
> @@ -49,8 +51,50 @@ int iopt_unmap_iova(struct io_pagetable *iopt, unsigned long iova,
>   		    unsigned long length);
>   int iopt_unmap_all(struct io_pagetable *iopt);
>   
> +struct iommufd_dirty_data {
> +	unsigned long iova;
> +	unsigned long length;
> +	unsigned long page_size;
> +	unsigned long *data;
> +};

How about adding some comments around this struct? Any alingment
requirement for iova/length? What does the @data stand for?

> +
>   int iopt_set_dirty_tracking(struct io_pagetable *iopt,
>   			    struct iommu_domain *domain, bool enable);
> +int iopt_read_and_clear_dirty_data(struct io_pagetable *iopt,
> +				   struct iommu_domain *domain,
> +				   struct iommufd_dirty_data *bitmap);
> +
> +struct iommufd_dirty_iter {
> +	struct iommu_dirty_bitmap dirty;
> +	struct iovec bitmap_iov;
> +	struct iov_iter bitmap_iter;
> +	unsigned long iova;
> +};

Same here.

> +
> +void iommufd_dirty_iter_put(struct iommufd_dirty_iter *iter);
> +int iommufd_dirty_iter_get(struct iommufd_dirty_iter *iter);
> +int iommufd_dirty_iter_init(struct iommufd_dirty_iter *iter,
> +			    struct iommufd_dirty_data *bitmap);
> +void iommufd_dirty_iter_free(struct iommufd_dirty_iter *iter);
> +bool iommufd_dirty_iter_done(struct iommufd_dirty_iter *iter);
> +void iommufd_dirty_iter_advance(struct iommufd_dirty_iter *iter);
> +unsigned long iommufd_dirty_iova_length(struct iommufd_dirty_iter *iter);
> +unsigned long iommufd_dirty_iova(struct iommufd_dirty_iter *iter);
> +static inline unsigned long dirty_bitmap_bytes(unsigned long nr_pages)
> +{
> +	return (ALIGN(nr_pages, BITS_PER_TYPE(u64)) / BITS_PER_BYTE);
> +}
> +
> +/*
> + * Input argument of number of bits to bitmap_set() is unsigned integer, which
> + * further casts to signed integer for unaligned multi-bit operation,
> + * __bitmap_set().
> + * Then maximum bitmap size supported is 2^31 bits divided by 2^3 bits/byte,
> + * that is 2^28 (256 MB) which maps to 2^31 * 2^12 = 2^43 (8TB) on 4K page
> + * system.
> + */
> +#define DIRTY_BITMAP_PAGES_MAX  ((u64)INT_MAX)
> +#define DIRTY_BITMAP_SIZE_MAX   dirty_bitmap_bytes(DIRTY_BITMAP_PAGES_MAX)
>   
>   int iopt_access_pages(struct io_pagetable *iopt, unsigned long iova,
>   		      unsigned long npages, struct page **out_pages, bool write);

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
