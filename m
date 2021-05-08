Return-Path: <SRS0=sTZ6=KD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FBF0C433ED
	for <iommu@archiver.kernel.org>; Sat,  8 May 2021 03:47:56 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68B9D61106
	for <iommu@archiver.kernel.org>; Sat,  8 May 2021 03:47:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68B9D61106
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 17DC840490;
	Sat,  8 May 2021 03:47:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SlspWlwWj3po; Sat,  8 May 2021 03:47:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6ABD740523;
	Sat,  8 May 2021 03:47:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4D6E5C000D;
	Sat,  8 May 2021 03:47:51 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 573C9C0001
 for <iommu@lists.linux-foundation.org>; Sat,  8 May 2021 03:47:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2EE7C40490
 for <iommu@lists.linux-foundation.org>; Sat,  8 May 2021 03:47:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OlOzxcYgAazC for <iommu@lists.linux-foundation.org>;
 Sat,  8 May 2021 03:47:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A16E74052A
 for <iommu@lists.linux-foundation.org>; Sat,  8 May 2021 03:47:41 +0000 (UTC)
IronPort-SDR: /aDOfchytiKVhWGX/njZnF3Y1ZqwxwwrInBZ9vCdFgj+MJd5RA4EFT5OPbgmDwekAA+uo+gSbU
 fG0uo6f1a/HQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9977"; a="198516801"
X-IronPort-AV: E=Sophos;i="5.82,282,1613462400"; d="scan'208";a="198516801"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 May 2021 20:47:38 -0700
IronPort-SDR: BAUQpAKx+ToeZn5dRxJS1VxNcza0WkWrPnhbHwjgf8BMtxog3GGfZ8CfX8If4GIgnFS9neQIBG
 KzHBAxG7Hdbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,282,1613462400"; d="scan'208";a="620437358"
Received: from allen-box.sh.intel.com (HELO [10.239.159.128])
 ([10.239.159.128])
 by fmsmga006.fm.intel.com with ESMTP; 07 May 2021 20:47:34 -0700
Subject: Re: [RFC PATCH v4 01/13] iommu: Introduce dirty log tracking framework
To: Keqian Zhu <zhukeqian1@huawei.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org,
 Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
 Joerg Roedel <joro@8bytes.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Yi Sun <yi.y.sun@linux.intel.com>, Tian Kevin <kevin.tian@intel.com>
References: <20210507102211.8836-1-zhukeqian1@huawei.com>
 <20210507102211.8836-2-zhukeqian1@huawei.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <efc2d868-28ba-8ed9-1d6b-610b67d671b5@linux.intel.com>
Date: Sat, 8 May 2021 11:46:52 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210507102211.8836-2-zhukeqian1@huawei.com>
Content-Language: en-US
Cc: jiangkunkun@huawei.com, Cornelia Huck <cohuck@redhat.com>,
 Kirti Wankhede <kwankhede@nvidia.com>, lushenming@huawei.com,
 Alex Williamson <alex.williamson@redhat.com>, wanghaibin.wang@huawei.com
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

Hi Keqian,

On 5/7/21 6:21 PM, Keqian Zhu wrote:
> Some types of IOMMU are capable of tracking DMA dirty log, such as
> ARM SMMU with HTTU or Intel IOMMU with SLADE. This introduces the
> dirty log tracking framework in the IOMMU base layer.
> 
> Four new essential interfaces are added, and we maintaince the status
> of dirty log tracking in iommu_domain.
> 1. iommu_support_dirty_log: Check whether domain supports dirty log tracking
> 2. iommu_switch_dirty_log: Perform actions to start|stop dirty log tracking
> 3. iommu_sync_dirty_log: Sync dirty log from IOMMU into a dirty bitmap
> 4. iommu_clear_dirty_log: Clear dirty log of IOMMU by a mask bitmap
> 
> Note: Don't concurrently call these interfaces with other ops that
> access underlying page table.
> 
> Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
> Signed-off-by: Kunkun Jiang <jiangkunkun@huawei.com>
> ---
>   drivers/iommu/iommu.c        | 201 +++++++++++++++++++++++++++++++++++
>   include/linux/iommu.h        |  63 +++++++++++
>   include/trace/events/iommu.h |  63 +++++++++++
>   3 files changed, 327 insertions(+)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 808ab70d5df5..0d15620d1e90 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -1940,6 +1940,7 @@ static struct iommu_domain *__iommu_domain_alloc(struct bus_type *bus,
>   	domain->type = type;
>   	/* Assume all sizes by default; the driver may override this later */
>   	domain->pgsize_bitmap  = bus->iommu_ops->pgsize_bitmap;
> +	mutex_init(&domain->switch_log_lock);
>   
>   	return domain;
>   }
> @@ -2703,6 +2704,206 @@ int iommu_set_pgtable_quirks(struct iommu_domain *domain,
>   }
>   EXPORT_SYMBOL_GPL(iommu_set_pgtable_quirks);
>   
> +bool iommu_support_dirty_log(struct iommu_domain *domain)
> +{
> +	const struct iommu_ops *ops = domain->ops;
> +
> +	return ops->support_dirty_log && ops->support_dirty_log(domain);
> +}
> +EXPORT_SYMBOL_GPL(iommu_support_dirty_log);

I suppose this interface is to ask the vendor IOMMU driver to check
whether each device/iommu in the domain supports dirty bit tracking.
But what will happen if new devices with different tracking capability
are added afterward?

To make things simple, is it possible to support this tracking only when
all underlying IOMMUs support dirty bit tracking?

Or, the more crazy idea is that we don't need to check this capability
at all. If dirty bit tracking is not supported by hardware, just mark
all pages dirty?

> +
> +int iommu_switch_dirty_log(struct iommu_domain *domain, bool enable,
> +			   unsigned long iova, size_t size, int prot)
> +{
> +	const struct iommu_ops *ops = domain->ops;
> +	unsigned long orig_iova = iova;
> +	unsigned int min_pagesz;
> +	size_t orig_size = size;
> +	bool flush = false;
> +	int ret = 0;
> +
> +	if (unlikely(!ops->switch_dirty_log))
> +		return -ENODEV;
> +
> +	min_pagesz = 1 << __ffs(domain->pgsize_bitmap);
> +	if (!IS_ALIGNED(iova | size, min_pagesz)) {
> +		pr_err("unaligned: iova 0x%lx size 0x%zx min_pagesz 0x%x\n",
> +		       iova, size, min_pagesz);
> +		return -EINVAL;
> +	}
> +
> +	mutex_lock(&domain->switch_log_lock);
> +	if (enable && domain->dirty_log_tracking) {
> +		ret = -EBUSY;
> +		goto out;
> +	} else if (!enable && !domain->dirty_log_tracking) {
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	pr_debug("switch_dirty_log %s for: iova 0x%lx size 0x%zx\n",
> +		 enable ? "enable" : "disable", iova, size);
> +
> +	while (size) {
> +		size_t pgsize = iommu_pgsize(domain, iova, size);
> +
> +		flush = true;
> +		ret = ops->switch_dirty_log(domain, enable, iova, pgsize, prot);

Per minimal page callback is much expensive. How about using (pagesize,
count), so that all pages with the same page size could be handled in a
single indirect call? I remember I commented this during last review,
but I don't mind doing it again.

Best regards,
baolu

> +		if (ret)
> +			break;
> +
> +		pr_debug("switch_dirty_log handled: iova 0x%lx size 0x%zx\n",
> +			 iova, pgsize);
> +
> +		iova += pgsize;
> +		size -= pgsize;
> +	}
> +
> +	if (flush)
> +		iommu_flush_iotlb_all(domain);
> +
> +	if (!ret) {
> +		domain->dirty_log_tracking = enable;
> +		trace_switch_dirty_log(orig_iova, orig_size, enable);
> +	}
> +out:
> +	mutex_unlock(&domain->switch_log_lock);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(iommu_switch_dirty_log);
> +
> +int iommu_sync_dirty_log(struct iommu_domain *domain, unsigned long iova,
> +			 size_t size, unsigned long *bitmap,
> +			 unsigned long base_iova, unsigned long bitmap_pgshift)
> +{
> +	const struct iommu_ops *ops = domain->ops;
> +	unsigned long orig_iova = iova;
> +	unsigned int min_pagesz;
> +	size_t orig_size = size;
> +	int ret = 0;
> +
> +	if (unlikely(!ops->sync_dirty_log))
> +		return -ENODEV;
> +
> +	min_pagesz = 1 << __ffs(domain->pgsize_bitmap);
> +	if (!IS_ALIGNED(iova | size, min_pagesz)) {
> +		pr_err("unaligned: iova 0x%lx size 0x%zx min_pagesz 0x%x\n",
> +		       iova, size, min_pagesz);
> +		return -EINVAL;
> +	}
> +
> +	mutex_lock(&domain->switch_log_lock);
> +	if (!domain->dirty_log_tracking) {
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	pr_debug("sync_dirty_log for: iova 0x%lx size 0x%zx\n", iova, size);
> +
> +	while (size) {
> +		size_t pgsize = iommu_pgsize(domain, iova, size);
> +
> +		ret = ops->sync_dirty_log(domain, iova, pgsize,
> +					  bitmap, base_iova, bitmap_pgshift);
> +		if (ret)
> +			break;
> +
> +		pr_debug("sync_dirty_log handled: iova 0x%lx size 0x%zx\n",
> +			 iova, pgsize);
> +
> +		iova += pgsize;
> +		size -= pgsize;
> +	}
> +
> +	if (!ret)
> +		trace_sync_dirty_log(orig_iova, orig_size);
> +out:
> +	mutex_unlock(&domain->switch_log_lock);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(iommu_sync_dirty_log);
> +
> +static int __iommu_clear_dirty_log(struct iommu_domain *domain,
> +				   unsigned long iova, size_t size,
> +				   unsigned long *bitmap,
> +				   unsigned long base_iova,
> +				   unsigned long bitmap_pgshift)
> +{
> +	const struct iommu_ops *ops = domain->ops;
> +	unsigned long orig_iova = iova;
> +	size_t orig_size = size;
> +	int ret = 0;
> +
> +	if (unlikely(!ops->clear_dirty_log))
> +		return -ENODEV;
> +
> +	pr_debug("clear_dirty_log for: iova 0x%lx size 0x%zx\n", iova, size);
> +
> +	while (size) {
> +		size_t pgsize = iommu_pgsize(domain, iova, size);
> +
> +		ret = ops->clear_dirty_log(domain, iova, pgsize, bitmap,
> +					   base_iova, bitmap_pgshift);
> +		if (ret)
> +			break;
> +
> +		pr_debug("clear_dirty_log handled: iova 0x%lx size 0x%zx\n",
> +			 iova, pgsize);
> +
> +		iova += pgsize;
> +		size -= pgsize;
> +	}
> +
> +	if (!ret)
> +		trace_clear_dirty_log(orig_iova, orig_size);
> +
> +	return ret;
> +}
> +
> +int iommu_clear_dirty_log(struct iommu_domain *domain,
> +			  unsigned long iova, size_t size,
> +			  unsigned long *bitmap, unsigned long base_iova,
> +			  unsigned long bitmap_pgshift)
> +{
> +	unsigned long riova, rsize;
> +	unsigned int min_pagesz;
> +	bool flush = false;
> +	int rs, re, start, end;
> +	int ret = 0;
> +
> +	min_pagesz = 1 << __ffs(domain->pgsize_bitmap);
> +	if (!IS_ALIGNED(iova | size, min_pagesz)) {
> +		pr_err("unaligned: iova 0x%lx min_pagesz 0x%x\n",
> +		       iova, min_pagesz);
> +		return -EINVAL;
> +	}
> +
> +	mutex_lock(&domain->switch_log_lock);
> +	if (!domain->dirty_log_tracking) {
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	start = (iova - base_iova) >> bitmap_pgshift;
> +	end = start + (size >> bitmap_pgshift);
> +	bitmap_for_each_set_region(bitmap, rs, re, start, end) {
> +		flush = true;
> +		riova = base_iova + (rs << bitmap_pgshift);
> +		rsize = (re - rs) << bitmap_pgshift;
> +		ret = __iommu_clear_dirty_log(domain, riova, rsize, bitmap,
> +					      base_iova, bitmap_pgshift);
> +		if (ret)
> +			break;
> +	}
> +
> +	if (flush)
> +		iommu_flush_iotlb_all(domain);
> +out:
> +	mutex_unlock(&domain->switch_log_lock);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(iommu_clear_dirty_log);
> +
>   void iommu_get_resv_regions(struct device *dev, struct list_head *list)
>   {
>   	const struct iommu_ops *ops = dev->bus->iommu_ops;
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 32d448050bf7..e0e40dda974d 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -87,6 +87,8 @@ struct iommu_domain {
>   	void *handler_token;
>   	struct iommu_domain_geometry geometry;
>   	void *iova_cookie;
> +	bool dirty_log_tracking;
> +	struct mutex switch_log_lock;
>   };
>   
>   enum iommu_cap {
> @@ -193,6 +195,10 @@ struct iommu_iotlb_gather {
>    * @device_group: find iommu group for a particular device
>    * @enable_nesting: Enable nesting
>    * @set_pgtable_quirks: Set io page table quirks (IO_PGTABLE_QUIRK_*)
> + * @support_dirty_log: Check whether domain supports dirty log tracking
> + * @switch_dirty_log: Perform actions to start|stop dirty log tracking
> + * @sync_dirty_log: Sync dirty log from IOMMU into a dirty bitmap
> + * @clear_dirty_log: Clear dirty log of IOMMU by a mask bitmap
>    * @get_resv_regions: Request list of reserved regions for a device
>    * @put_resv_regions: Free list of reserved regions for a device
>    * @apply_resv_region: Temporary helper call-back for iova reserved ranges
> @@ -245,6 +251,22 @@ struct iommu_ops {
>   	int (*set_pgtable_quirks)(struct iommu_domain *domain,
>   				  unsigned long quirks);
>   
> +	/*
> +	 * Track dirty log. Note: Don't concurrently call these interfaces with
> +	 * other ops that access underlying page table.
> +	 */
> +	bool (*support_dirty_log)(struct iommu_domain *domain);
> +	int (*switch_dirty_log)(struct iommu_domain *domain, bool enable,
> +				unsigned long iova, size_t size, int prot);
> +	int (*sync_dirty_log)(struct iommu_domain *domain,
> +			      unsigned long iova, size_t size,
> +			      unsigned long *bitmap, unsigned long base_iova,
> +			      unsigned long bitmap_pgshift);
> +	int (*clear_dirty_log)(struct iommu_domain *domain,
> +			       unsigned long iova, size_t size,
> +			       unsigned long *bitmap, unsigned long base_iova,
> +			       unsigned long bitmap_pgshift);
> +
>   	/* Request/Free a list of reserved regions for a device */
>   	void (*get_resv_regions)(struct device *dev, struct list_head *list);
>   	void (*put_resv_regions)(struct device *dev, struct list_head *list);
> @@ -475,6 +497,17 @@ extern struct iommu_domain *iommu_group_default_domain(struct iommu_group *);
>   int iommu_enable_nesting(struct iommu_domain *domain);
>   int iommu_set_pgtable_quirks(struct iommu_domain *domain,
>   		unsigned long quirks);
> +extern bool iommu_support_dirty_log(struct iommu_domain *domain);
> +extern int iommu_switch_dirty_log(struct iommu_domain *domain, bool enable,
> +				  unsigned long iova, size_t size, int prot);
> +extern int iommu_sync_dirty_log(struct iommu_domain *domain, unsigned long iova,
> +				size_t size, unsigned long *bitmap,
> +				unsigned long base_iova,
> +				unsigned long bitmap_pgshift);
> +extern int iommu_clear_dirty_log(struct iommu_domain *domain, unsigned long iova,
> +				 size_t dma_size, unsigned long *bitmap,
> +				 unsigned long base_iova,
> +				 unsigned long bitmap_pgshift);
>   
>   void iommu_set_dma_strict(bool val);
>   bool iommu_get_dma_strict(struct iommu_domain *domain);
> @@ -848,6 +881,36 @@ static inline int iommu_set_pgtable_quirks(struct iommu_domain *domain,
>   	return 0;
>   }
>   
> +static inline bool iommu_support_dirty_log(struct iommu_domain *domain)
> +{
> +	return false;
> +}
> +
> +static inline int iommu_switch_dirty_log(struct iommu_domain *domain,
> +					 bool enable, unsigned long iova,
> +					 size_t size, int prot)
> +{
> +	return -EINVAL;
> +}
> +
> +static inline int iommu_sync_dirty_log(struct iommu_domain *domain,
> +				       unsigned long iova, size_t size,
> +				       unsigned long *bitmap,
> +				       unsigned long base_iova,
> +				       unsigned long pgshift)
> +{
> +	return -EINVAL;
> +}
> +
> +static inline int iommu_clear_dirty_log(struct iommu_domain *domain,
> +					unsigned long iova, size_t size,
> +					unsigned long *bitmap,
> +					unsigned long base_iova,
> +					unsigned long pgshift)
> +{
> +	return -EINVAL;
> +}
> +
>   static inline int iommu_device_register(struct iommu_device *iommu,
>   					const struct iommu_ops *ops,
>   					struct device *hwdev)
> diff --git a/include/trace/events/iommu.h b/include/trace/events/iommu.h
> index 72b4582322ff..6436d693d357 100644
> --- a/include/trace/events/iommu.h
> +++ b/include/trace/events/iommu.h
> @@ -129,6 +129,69 @@ TRACE_EVENT(unmap,
>   	)
>   );
>   
> +TRACE_EVENT(switch_dirty_log,
> +
> +	TP_PROTO(unsigned long iova, size_t size, bool enable),
> +
> +	TP_ARGS(iova, size, enable),
> +
> +	TP_STRUCT__entry(
> +		__field(u64, iova)
> +		__field(size_t, size)
> +		__field(bool, enable)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->iova = iova;
> +		__entry->size = size;
> +		__entry->enable = enable;
> +	),
> +
> +	TP_printk("IOMMU: iova=0x%016llx size=%zu enable=%u",
> +			__entry->iova, __entry->size, __entry->enable
> +	)
> +);
> +
> +TRACE_EVENT(sync_dirty_log,
> +
> +	TP_PROTO(unsigned long iova, size_t size),
> +
> +	TP_ARGS(iova, size),
> +
> +	TP_STRUCT__entry(
> +		__field(u64, iova)
> +		__field(size_t, size)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->iova = iova;
> +		__entry->size = size;
> +	),
> +
> +	TP_printk("IOMMU: iova=0x%016llx size=%zu", __entry->iova,
> +			__entry->size)
> +);
> +
> +TRACE_EVENT(clear_dirty_log,
> +
> +	TP_PROTO(unsigned long iova, size_t size),
> +
> +	TP_ARGS(iova, size),
> +
> +	TP_STRUCT__entry(
> +		__field(u64, iova)
> +		__field(size_t, size)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->iova = iova;
> +		__entry->size = size;
> +	),
> +
> +	TP_printk("IOMMU: iova=0x%016llx size=%zu", __entry->iova,
> +			__entry->size)
> +);
> +
>   DECLARE_EVENT_CLASS(iommu_error,
>   
>   	TP_PROTO(struct device *dev, unsigned long iova, int flags),
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
