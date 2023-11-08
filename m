Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD53CA4C
	for <iommu@lists.linux.dev>; Wed,  8 Nov 2023 05:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vdc6cYBY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699421255; x=1730957255;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=fMu5EDzVmizg3Q2e6bKjnNDsScNf7NXsqCUrWwUVBJs=;
  b=Vdc6cYBYtaYGrho1QIo4m9uPxlYoYnZQypzPrk1oiYy5PQ0jx3hM+k7k
   Vfwq+7V7HMe7gUiWa8TCclIMEzSsgdAgCJEvhPL11QQi5WrJdf6G/lb0e
   aE9f1fWYmNy7tA3g6DcoJMcDjsKN1icp90iDl+ekelrihWk7LU9qI7fUJ
   mwgcFkXfDd7kaBqrKgwvISYKUEwvIHvhnON4v1ykZ6aH6hNfmnrFLYjfG
   CfjlATLN087mJFDIT4v3K4kq2ifMi0SOZFiCMCutA6G070ZnGKS1rj5IW
   O6GQEA1ZxBFOfLR7grqxy1o5lQJa1OO4x1s0tPBT20XwWpKaUX0WjN8FZ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10887"; a="456189872"
X-IronPort-AV: E=Sophos;i="6.03,285,1694761200"; 
   d="scan'208";a="456189872"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2023 21:27:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10887"; a="880090281"
X-IronPort-AV: E=Sophos;i="6.03,285,1694761200"; 
   d="scan'208";a="880090281"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by fmsmga002.fm.intel.com with ESMTP; 07 Nov 2023 21:27:31 -0800
Message-ID: <78c28624-caa2-4207-b6dc-8810a4dfe2ab@linux.intel.com>
Date: Wed, 8 Nov 2023 13:23:28 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, iommu@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, quic_tingweiz@quicinc.com
Subject: Re: [RFC PATCH 1/1] iommu: Fix one concurrency issue happens on
 non-iommu binding device
Content-Language: en-US
To: Zhenhua Huang <quic_zhenhuah@quicinc.com>, jgg@ziepe.ca,
 robin.murphy@arm.com, joro@8bytes.org, will@kernel.org
References: <1698825902-10685-1-git-send-email-quic_zhenhuah@quicinc.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <1698825902-10685-1-git-send-email-quic_zhenhuah@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/1/23 4:05 PM, Zhenhua Huang wrote:
> Thread (1)
> During SMMU probe:
> iommu_device_register
>          bus_iommu_probe
>                  probe_iommu_group for all devices in bus
>                          _probe_iommu_device
> (non-iommu binding device)	first allocate dev->iommu then free
> 
> Thread (2)
> client device probing:
> dma_configure
>          of_iommu_configure
>                  get dev->iommu->fwspec and call fwspec->ops
> 
> There may be a time window that dev->iommu allocated even for non iommu
> binding device in thread (1). It would be possible thread (2) meet Use-
> after-free errors at that window.
> 
> Fix it by closing the time window, set dev->iommu only once
> ops->probe_device successfully.
> Previous discussion details:
> https://lore.kernel.org/linux-arm-kernel/20231017163337.GE282036@ziepe.ca/T/#mee0d7bdc375541934a571ae69f43b9660f8e7312
> 
> Suggested-by: Jason Gunthorpe<jgg@ziepe.ca>
> Signed-off-by: Zhenhua Huang<quic_zhenhuah@quicinc.com>
> ---
> Hi Jason, Robin,
> Shall we first address non-iommu binding device crash with below patch? It's
> seen a lot especially when smmu probing and other driver probing at same time.
> Although it doesn't comprehensively fixes race with of_xlate VS probe, it
> indeed solves issue for non-iommu binding device.
> 
>   drivers/iommu/iommu.c | 42 +++++++++++++++++++++++++++++-------------
>   include/linux/iommu.h |  5 +----
>   2 files changed, 30 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index f17a111..88ce802 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -386,6 +386,17 @@ static u32 dev_iommu_get_max_pasids(struct device *dev)
>   	return min_t(u32, max_pasids, dev->iommu->iommu_dev->max_pasids);
>   }
>   
> +void dev_iommu_priv_set(struct device *dev, void *priv)
> +{
> +	struct dev_iommu *dev_iommu;
> +
> +	dev_iommu = dev_iommu_get(dev);
> +	if (WARN_ON(!dev_iommu))
> +		return;
> +
> +	dev->iommu->priv = priv;
> +}

The dev_iommu_priv_set() function is intended for iommu drivers to store
per-device iommu private data after successful device probing. Invoking
dev_iommu_get() within this helper is inappropriate as it may
inadvertently allocate dev->iommu, which is not the intended purpose of
dev_iommu_priv_set().

Best regards,
baolu
