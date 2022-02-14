Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A95EEC433EF
	for <iommu@archiver.kernel.org>; Mon, 14 Feb 2022 07:38:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 501824020E;
	Mon, 14 Feb 2022 07:38:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5uPknsh57mrk; Mon, 14 Feb 2022 07:38:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 4A815401FE;
	Mon, 14 Feb 2022 07:38:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EF073C001A;
	Mon, 14 Feb 2022 07:38:25 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 12AACC000B
 for <iommu@lists.linux-foundation.org>; Mon, 14 Feb 2022 07:38:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0541240207
 for <iommu@lists.linux-foundation.org>; Mon, 14 Feb 2022 07:38:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5R-zM7JdnZGw for <iommu@lists.linux-foundation.org>;
 Mon, 14 Feb 2022 07:38:24 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 68649401FE
 for <iommu@lists.linux-foundation.org>; Mon, 14 Feb 2022 07:38:24 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id 7900468AFE; Mon, 14 Feb 2022 08:38:20 +0100 (CET)
Date: Mon, 14 Feb 2022 08:38:20 +0100
From: Christoph Hellwig <hch@lst.de>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v2 10/11] iommu/vt-d: Use xarray for global
 device_domain_info
Message-ID: <20220214073820.GF17411@lst.de>
References: <20220214025704.3184654-1-baolu.lu@linux.intel.com>
 <20220214025704.3184654-11-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220214025704.3184654-11-baolu.lu@linux.intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: Kevin Tian <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Jason Gunthorpe <jgg@nvidia.com>, Robin Murphy <robin.murphy@arm.com>,
 Christoph Hellwig <hch@lst.de>
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
>  const struct iommu_ops intel_iommu_ops;
> @@ -903,7 +905,8 @@ static void pgtable_walk(struct intel_iommu *iommu, unsigned long pfn, u8 bus, u
>  	struct dmar_domain *domain;
>  	int offset, level;
>  
> -	info = dmar_search_domain_by_dev_info(iommu->segment, bus, devfn);
> +	info = xa_load(&device_domain_array,
> +		       devi_idx(iommu->segment, bus, devfn));
>  	if (!info || !info->domain) {
>  		pr_info("device [%02x:%02x.%d] not probed\n",
>  			bus, PCI_SLOT(devfn), PCI_FUNC(devfn));
> @@ -1742,14 +1745,14 @@ static int iommu_init_domains(struct intel_iommu *iommu)

Don't we need a rcu critical section here?

> -	list_for_each_entry_safe(info, tmp, &device_domain_list, global) {
> +	rcu_read_lock();
> +	xa_for_each(&device_domain_array, index, info) {
>  		if (info->iommu != iommu)
>  			continue;
>  
> @@ -1758,7 +1761,7 @@ static void disable_dmar_iommu(struct intel_iommu *iommu)
>  
>  		__dmar_remove_one_dev_info(info);
>  	}
> -	spin_unlock_irqrestore(&device_domain_lock, flags);
> +	rcu_read_unlock();

__dmar_remove_one_dev_info asserts that device_domain_lock is held,
which these two hunks remove.

>  	spin_lock_irqsave(&device_domain_lock, flags);
>  	dev_iommu_priv_set(dev, NULL);
> -	list_del(&info->global);
> +	xa_erase(&device_domain_array,
> +		 devi_idx(info->segment, info->bus, info->devfn));
>  	spin_unlock_irqrestore(&device_domain_lock, flags);
>  
>  	kfree(info);

Do we need a kfree_rcu here to allow rcu based access?
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
