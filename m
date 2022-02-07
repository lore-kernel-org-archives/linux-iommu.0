Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F271C433EF
	for <iommu@archiver.kernel.org>; Mon,  7 Feb 2022 07:14:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 12F9A8136C;
	Mon,  7 Feb 2022 07:14:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id k2xz2fr0lhje; Mon,  7 Feb 2022 07:14:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id ED48281352;
	Mon,  7 Feb 2022 07:14:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AF61FC001A;
	Mon,  7 Feb 2022 07:14:26 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CAC3AC000B
 for <iommu@lists.linux-foundation.org>; Mon,  7 Feb 2022 07:14:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B580081352
 for <iommu@lists.linux-foundation.org>; Mon,  7 Feb 2022 07:14:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 76D98LD42OFF for <iommu@lists.linux-foundation.org>;
 Mon,  7 Feb 2022 07:14:24 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2A46A80BDF
 for <iommu@lists.linux-foundation.org>; Mon,  7 Feb 2022 07:14:24 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id 653AF68BEB; Mon,  7 Feb 2022 08:14:20 +0100 (CET)
Date: Mon, 7 Feb 2022 08:14:20 +0100
From: Christoph Hellwig <hch@lst.de>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v1 07/10] iommu/vt-d: Use an xarray for global
 device_domain_info
Message-ID: <20220207071420.GG23941@lst.de>
References: <20220207064142.1092846-1-baolu.lu@linux.intel.com>
 <20220207064142.1092846-8-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220207064142.1092846-8-baolu.lu@linux.intel.com>
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

> + #define DEVI_IDX(seg, bus, devfn) ((((u16)(seg)) << 16) | PCI_DEVID(bus, devfn))

Please turn this into an real function.
>  /*
> - * Iterate over elements in device_domain_list and call the specified
> + * Iterate over elements in device_domain_array and call the specified
>   * callback @fn against each element.
>   */
>  int for_each_device_domain(int (*fn)(struct device_domain_info *info,
>  				     void *data), void *data)
>  {
>  	struct device_domain_info *info;
> +	unsigned long index;
> +	int ret = 0;
>  
> +	rcu_read_lock();
> +	xa_for_each(&device_domain_array, index, info) {
>  		ret = fn(info, data);
> +		if (ret)
> +			break;
>  	}
> +	rcu_read_unlock();

Can't we just open code this in the caller now?

>  const struct iommu_ops intel_iommu_ops;
> @@ -900,7 +898,8 @@ static void pgtable_walk(struct intel_iommu *iommu, unsigned long pfn, u8 bus, u
>  	struct dmar_domain *domain;
>  	int offset, level;
>  
> -	info = dmar_search_domain_by_dev_info(iommu->segment, bus, devfn);
> +	info = xa_load(&device_domain_array,
> +		       DEVI_IDX(iommu->segment, bus, devfn));
>  	if (!info || !info->domain) {
>  		pr_info("device [%02x:%02x.%d] not probed\n",
>  			bus, PCI_SLOT(devfn), PCI_FUNC(devfn));

Is there any refcounting or other life time protection for the info
structures?
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
