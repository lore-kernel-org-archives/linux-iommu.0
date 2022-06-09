Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0289AC433EF
	for <iommu@archiver.kernel.org>; Thu,  9 Jun 2022 17:06:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8B2A540C3E;
	Thu,  9 Jun 2022 17:06:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id D9py7oxoUyVn; Thu,  9 Jun 2022 17:06:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 595C5400A8;
	Thu,  9 Jun 2022 17:06:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 397AFC0039;
	Thu,  9 Jun 2022 17:06:48 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D82B6C002D
 for <iommu@lists.linux-foundation.org>; Thu,  9 Jun 2022 17:06:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B2AB040C3E
 for <iommu@lists.linux-foundation.org>; Thu,  9 Jun 2022 17:06:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AHKpVtk25-Db for <iommu@lists.linux-foundation.org>;
 Thu,  9 Jun 2022 17:06:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DC93E400A8
 for <iommu@lists.linux-foundation.org>; Thu,  9 Jun 2022 17:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1654794405; x=1686330405;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=DqcLSXzla24BAOWUg0Q7TFQHtplmc6Xrbtg5PjslZl4=;
 b=LCq8PSsKdBB7DpZLdrPlEjOoSm7YEbVgv9cfXR8n5KLxmw4rhvjT6vxb
 RTQTJQRg44o+JmcRtQPVvCtnwEvDif24ryOPq6RynJtprt3pDTgvad/28
 NAjVhOPqCWTEEqEqVwTEOimgy5SPG+jT6oPMQtUySQP1TdQrYxlWzW8rz
 RCcxXCIu8JYiNJVjF6/RyszMnOt0aRNK9ZKubd8CbgwKgU18uGnVx5Cil
 Fx0WvN+eAzidLpVUxNkuA3K0M5HMUfRyQLNxGL0LvtWYMfl3Ytthj/42Y
 t/cbjfUrSbJsNE7zM1ewhaNANidWWPeB+/iQHtVdZyQ9K+9tXriKKRdnV Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10373"; a="274879234"
X-IronPort-AV: E=Sophos;i="5.91,287,1647327600"; d="scan'208";a="274879234"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2022 10:06:45 -0700
X-IronPort-AV: E=Sophos;i="5.91,287,1647327600"; d="scan'208";a="610347539"
Received: from araj-dh-work.jf.intel.com (HELO araj-dh-work) ([10.165.157.158])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2022 10:06:44 -0700
Date: Thu, 9 Jun 2022 17:06:44 +0000
From: "Raj, Ashok" <ashok.raj@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [RFC PATCHES 1/2] iommu: Add RCU-protected page free support
Message-ID: <20220609170644.GA33363@araj-dh-work>
References: <20220609070811.902868-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220609070811.902868-1-baolu.lu@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
 Christoph Hellwig <hch@infradead.org>, iommu@lists.linux-foundation.org,
 Jason Gunthorpe <jgg@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>,
 Will Deacon <will@kernel.org>
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

On Thu, Jun 09, 2022 at 03:08:10PM +0800, Lu Baolu wrote:
> The IOMMU page tables are updated using iommu_map/unmap() interfaces.
> Currently, there is no mandatory requirement for drivers to use locks
> to ensure concurrent updates to page tables, because it's assumed that
> overlapping IOVA ranges do not have concurrent updates. Therefore the
> IOMMU drivers only need to take care of concurrent updates to level
> page table entries.

The last part doesn't read well.. 
s/updates to level page table entries/ updates to page-table entries at the
same level

> 
> But enabling new features challenges this assumption. For example, the
> hardware assisted dirty page tracking feature requires scanning page
> tables in interfaces other than mapping and unmapping. This might result
> in a use-after-free scenario in which a level page table has been freed
> by the unmap() interface, while another thread is scanning the next level
> page table.
> 
> This adds RCU-protected page free support so that the pages are really
> freed and reused after a RCU grace period. Hence, the page tables are
> safe for scanning within a rcu_read_lock critical region. Considering
> that scanning the page table is a rare case, this also adds a domain
> flag and the RCU-protected page free is only used when this flat is set.

s/flat/flag

> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  include/linux/iommu.h |  9 +++++++++
>  drivers/iommu/iommu.c | 23 +++++++++++++++++++++++
>  2 files changed, 32 insertions(+)
> 
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 5e1afe169549..6f68eabb8567 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -95,6 +95,7 @@ struct iommu_domain {
>  	void *handler_token;
>  	struct iommu_domain_geometry geometry;
>  	struct iommu_dma_cookie *iova_cookie;
> +	unsigned long concurrent_traversal:1;

Does this need to be a bitfield? Even though you are needing just one bit
now, you can probably make have maskbits?


>  };
>  
>  static inline bool iommu_is_dma_domain(struct iommu_domain *domain)
> @@ -657,6 +658,12 @@ static inline void dev_iommu_priv_set(struct device *dev, void *priv)
>  	dev->iommu->priv = priv;
>  }
>  
> +static inline void domain_set_concurrent_traversal(struct iommu_domain *domain,
> +						   bool value)
> +{
> +	domain->concurrent_traversal = value;
> +}
> +
>  int iommu_probe_device(struct device *dev);
>  void iommu_release_device(struct device *dev);
>  
> @@ -677,6 +684,8 @@ int iommu_group_claim_dma_owner(struct iommu_group *group, void *owner);
>  void iommu_group_release_dma_owner(struct iommu_group *group);
>  bool iommu_group_dma_owner_claimed(struct iommu_group *group);
>  
> +void iommu_free_pgtbl_pages(struct iommu_domain *domain,
> +			    struct list_head *pages);
>  #else /* CONFIG_IOMMU_API */
>  
>  struct iommu_ops {};
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 847ad47a2dfd..ceeb97ebe3e2 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -3252,3 +3252,26 @@ bool iommu_group_dma_owner_claimed(struct iommu_group *group)
>  	return user;
>  }
>  EXPORT_SYMBOL_GPL(iommu_group_dma_owner_claimed);
> +
> +static void pgtble_page_free_rcu(struct rcu_head *rcu)

maybe the names can be consistent? pgtble_ vs pgtbl below.

vote to drop the 'e' :-)

> +{
> +	struct page *page = container_of(rcu, struct page, rcu_head);
> +
> +	__free_pages(page, 0);
> +}
> +
> +void iommu_free_pgtbl_pages(struct iommu_domain *domain,
> +			    struct list_head *pages)
> +{
> +	struct page *page, *next;
> +
> +	if (!domain->concurrent_traversal) {
> +		put_pages_list(pages);
> +		return;
> +	}
> +
> +	list_for_each_entry_safe(page, next, pages, lru) {
> +		list_del(&page->lru);
> +		call_rcu(&page->rcu_head, pgtble_page_free_rcu);
> +	}
> +}
> -- 
> 2.25.1
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
