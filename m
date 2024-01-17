Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F800BA27
	for <iommu@lists.linux.dev>; Wed, 17 Jan 2024 07:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705476620; cv=none; b=h0AR8MksCxouQof6Iy85zUfdv+JdoM8jocu3AFXmVUCCKaXTABUtHkGYKjEyXhN/mTtqS6zw+YEMkLu8wBtZZyLAnG/ayb89Sa2TWP4g04QMPkFqGZhkOSnTPdiaN19Ll59BNy+Lb7m4CLNoqJ9CTcF8M7aogGVnGFLiucwdGWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705476620; c=relaxed/simple;
	bh=O/mptNX2sEdLmq2Q9GwMM7iGGGOaIXPaqQ3Le11Da04=;
	h=DKIM-Signature:X-IronPort-AV:X-IronPort-AV:Received:X-ExtLoop1:
	 X-IronPort-AV:X-IronPort-AV:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Cc:Subject:Content-Language:To:References:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding; b=T7MoAM8LJ1KLAb3ltJC+qNok3j8eYmYb+F4OzGoGZJMNbqG7bEEGCq2gYV+s/MtIher27T65/8o3U8AArt2g0xrv9KIZPa7ebqLNp+bSzexJzpwhFSi2hiFkfhWUhoou1S9hteKtqEG68eismKZC9RiDxnO5a0wzL1/4WAnkK0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kPnTiqve; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kPnTiqve"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705476618; x=1737012618;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=O/mptNX2sEdLmq2Q9GwMM7iGGGOaIXPaqQ3Le11Da04=;
  b=kPnTiqve/EMVIwJYYuMiM7kb/wzmPBbboOUohjEcmZi9om2BQpWT7WCN
   OKN+uIoZ1Y84qOZ+atBTESQ/0utvlXPG6bDugtlvq8JxXseAaTK8ScCx1
   JKixiGnS58rKtIEZBQvGBPkaLhPQ1j3UkI6jkFrPiJc0Tj0BMx+Swd7Kn
   At9P7pYWjGmjSyXQhTYtd2AX5ZdJTNNYgDAeUGfcPhaFQth+tc5Q8EU5s
   LipPtvOG9MjmhxQbv7Mrs+2liOYLJfBn2WzbEfTGqKq6ExjTvtUYJzGDA
   ZlB0KLoeh69KXgu8CAVWQXkAbjd/0W5uaWnE2XeEt1l1fsJ/qpsmixajn
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10955"; a="7476069"
X-IronPort-AV: E=Sophos;i="6.05,200,1701158400"; 
   d="scan'208";a="7476069"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2024 23:30:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10955"; a="957463638"
X-IronPort-AV: E=Sophos;i="6.05,200,1701158400"; 
   d="scan'208";a="957463638"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.249.171.146]) ([10.249.171.146])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2024 23:30:14 -0800
Message-ID: <dd7b65e4-0a76-4a85-91ed-47992f91eeda@linux.intel.com>
Date: Wed, 17 Jan 2024 15:30:11 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Kevin Tian <kevin.tian@intel.com>
Subject: Re: [PATCH 07/11] iommu/vt-d: Use RCU for dev_pasids list updates in
 set/remove_dev_pasid()
Content-Language: en-US
To: Tina Zhang <tina.zhang@intel.com>, iommu@lists.linux.dev
References: <20240116011146.18645-1-tina.zhang@intel.com>
 <20240116011146.18645-8-tina.zhang@intel.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20240116011146.18645-8-tina.zhang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/1/16 9:11, Tina Zhang wrote:
> Extend intel_iommu_remove_dev_pasid() and intel_iommu_set_dev_pasid() to
> support updating dev_pasids list concurrently with readers.
> 
> For default domain operations, the dev_pasids list accesses are protected
> by domain->lock and therefore all read/write accesses of default domain
> operations to dev_pasids list are performed sequentially. However, for sva
> domain, the dev_pasids list accesses could be performed concurrently.
> For example, the callbacks invoked by memory management notifier may run
> in a process which runs concurrently with another process wherein the
> intel_iommu_set/remove_dev_pasid operations are performed.
> 
> To extend intel_iommu_set/remove_dev_pasid() to have the ability to update
> the dev_pasids list concurrently with multiple readers (which is required
> by sva domain), RCU mechanism is being used here.
> 
> Signed-off-by: Tina Zhang <tina.zhang@intel.com>
> ---
>   drivers/iommu/intel/iommu.c | 12 +++++++++---
>   1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 847e21117e7a..0eec5d971315 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -4553,7 +4553,7 @@ static void intel_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid)
>   	spin_lock_irqsave(&dmar_domain->lock, flags);
>   	list_for_each_entry(curr, &dmar_domain->dev_pasids, link_domain) {
>   		if (curr->dev == dev && curr->pasid == pasid) {
> -			list_del(&curr->link_domain);
> +			list_del_rcu(&curr->link_domain);
>   			dev_pasid = curr;
>   			break;
>   		}
> @@ -4563,7 +4563,7 @@ static void intel_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid)
>   
>   	domain_detach_iommu(dmar_domain, iommu);
>   	intel_iommu_debugfs_remove_dev_pasid(dev_pasid);
> -	kfree(dev_pasid);
> +	kfree_rcu(dev_pasid, rcu);
>   out_tear_down:
>   	intel_pasid_tear_down_entry(iommu, dev, pasid, false);
>   	intel_drain_pasid_prq(dev, pasid);
> @@ -4613,8 +4613,14 @@ static int intel_iommu_set_dev_pasid(struct iommu_domain *domain,
>   
>   	dev_pasid->dev = dev;
>   	dev_pasid->pasid = pasid;
> +
> +	/*
> +	 * Spin lock protects dev_pasids list from being updated concurrently with
> +	 * multiple updaters, while rcu ensures concurrency between one updater
> +	 * and multiple readers
> +	 */
>   	spin_lock_irqsave(&dmar_domain->lock, flags);
> -	list_add(&dev_pasid->link_domain, &dmar_domain->dev_pasids);
> +	list_add_rcu(&dev_pasid->link_domain, &dmar_domain->dev_pasids);
>   	spin_unlock_irqrestore(&dmar_domain->lock, flags);
>   
>   	if (domain->type & __IOMMU_DOMAIN_PAGING)

It appears you're using an RCU lock within another spinlock critical
region. Wouldn't that be redundant?

Best regards,
baolu
