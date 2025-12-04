Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB772F8BD9
	for <iommu@lists.linux.dev>; Thu,  4 Dec 2025 05:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764827488; cv=none; b=ZEZjukClBmPNc+seVrHFJ+j2nv/uH6Gh7x5sMDlcV5FRMuarHGDY6NlwBgxMcKzfhKR+A5TrjfF5w9s6xPw4tTGCxy5a3e7tMSoZw2jYXubKsyDkgbzDKShG8IT2QYYvRdIHiAQ9yN3lox5kDwj7wbeoIuzuT7doPVRBRm1Zbz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764827488; c=relaxed/simple;
	bh=Bync738mSU0DZAQDAvaarLl8XrS67kZ7wWGnHbeaKqs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LNDndoyuPM09RFNZniqmDuT6Y8boQ+sH0DQL0zc7zH3ML3cKINGhtfb2mIWO522u9wA8/lwRTYDlwLF36MwjH/sNyKIyqvz81Ovvl/P9vkxQ8MjfN4RoohDlSbndRTMZy6EQGllcEjdD8eHA92Xdtx7djl2OO3v3a6Yi3/7WIOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fUBkiwa+; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fUBkiwa+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764827487; x=1796363487;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Bync738mSU0DZAQDAvaarLl8XrS67kZ7wWGnHbeaKqs=;
  b=fUBkiwa+RKQl1b+7mgxPNQw9Os/2tRA6N46eLSAPLddoGXGzgvyomedf
   XytSCYqT2WLVCPpyVe654IFGiJaeTua7RQq4R017ZUC3B6n9W4pVc8u3L
   15D0+M51Cv9WsAb7n6O76yl1CR8EoDdgHtXjIiW5yydOvqDq2/YrCXD4i
   +izE+VkNaRnTK81xaCDLPitDUnNOFVtYvXY8wBvboWtbn4lJU4DfDa/f4
   gXY9tZyxtJzim3NJtwXi0IvaBAJiYiL679EIiI5tTdJisAIdD/Wj2E3Yz
   da0u5jBvAnBgBC0okvOhUJxOHEXfEAMA9LFAPkRzvKue89N/rqdkcAOQD
   A==;
X-CSE-ConnectionGUID: HFVcsJq8T86kK/iiinpLuQ==
X-CSE-MsgGUID: TM3SkfHVTlS84i2tuLs0IQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11631"; a="77161243"
X-IronPort-AV: E=Sophos;i="6.20,248,1758610800"; 
   d="scan'208";a="77161243"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2025 21:51:27 -0800
X-CSE-ConnectionGUID: Lz4RNir8TlqguSEwGc65gQ==
X-CSE-MsgGUID: /41ge+ShS/m0HD64xU8mwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,248,1758610800"; 
   d="scan'208";a="195133395"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2025 21:51:21 -0800
Message-ID: <299dd94a-2cc8-4e5b-984a-4ffef0f05e8b@linux.intel.com>
Date: Thu, 4 Dec 2025 13:46:53 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 16/32] iommu: Add API to preserve/unpreserve a
 device
To: Samiullah Khawaja <skhawaja@google.com>,
 David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, iommu@lists.linux.dev
Cc: Robin Murphy <robin.murphy@arm.com>, Pratyush Yadav
 <pratyush@kernel.org>, Kevin Tian <kevin.tian@intel.com>,
 Alex Williamson <alex@shazbot.org>, linux-kernel@vger.kernel.org,
 Saeed Mahameed <saeedm@nvidia.com>,
 Adithya Jayachandran <ajayachandra@nvidia.com>,
 Parav Pandit <parav@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>,
 William Tu <witu@nvidia.com>, Vipin Sharma <vipinsh@google.com>,
 dmatlack@google.com, YiFei Zhu <zhuyifei@google.com>,
 Chris Li <chrisl@kernel.org>, praan@google.com
References: <20251202230303.1017519-1-skhawaja@google.com>
 <20251202230303.1017519-17-skhawaja@google.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20251202230303.1017519-17-skhawaja@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/3/25 07:02, Samiullah Khawaja wrote:
> iommu_preserve_device/iommu_unpreserve_device can be used to
> preserve/unpreserve a device for liveupdate. During device preservation
> the state of the associated IOMMU is also preserved. The device can only
> be preseved if the attached iommu domain is preserved and the assocated
> iommu supports preservation.

If the device supports PASID, multiple domains might be attached to it.

...

> 
> Signed-off-by: Samiullah Khawaja<skhawaja@google.com>
> ---
>   drivers/iommu/iommu.c      |   3 +
>   drivers/iommu/liveupdate.c | 115 +++++++++++++++++++++++++++++++++++++
>   include/linux/iommu-lu.h   |   2 +
>   include/linux/iommu.h      |  18 ++++++
>   4 files changed, 138 insertions(+)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index a70898d11959..3feb440de40a 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -382,6 +382,9 @@ static struct dev_iommu *dev_iommu_get(struct device *dev)
>   
>   	mutex_init(&param->lock);
>   	dev->iommu = param;
> +#ifdef CONFIG_LIVEUPDATE
> +	dev->iommu->device_ser = NULL;
> +#endif
>   	return param;
>   }
>   
> diff --git a/drivers/iommu/liveupdate.c b/drivers/iommu/liveupdate.c
> index 25a943e5e1e3..5780761a7024 100644
> --- a/drivers/iommu/liveupdate.c
> +++ b/drivers/iommu/liveupdate.c
> @@ -11,6 +11,7 @@
>   #include <linux/liveupdate.h>
>   #include <linux/iommu-lu.h>
>   #include <linux/iommu.h>
> +#include <linux/pci.h>
>   #include <linux/errno.h>
>   
>   static void iommu_liveupdate_free_objs(u64 next, bool incoming)
> @@ -209,3 +210,117 @@ int iommu_domain_unpreserve(struct iommu_domain *domain)
>   	return 0;
>   }
>   EXPORT_SYMBOL_GPL(iommu_domain_unpreserve);
> +
> +static int iommu_preserve_locked(struct iommu_device *iommu)
> +{
> +	struct iommu_lu_flb_obj *flb_obj;
> +	struct iommu_ser *iommu_ser;
> +	int idx, ret;
> +
> +	if (!iommu->ops->preserve)
> +		return -EOPNOTSUPP;
> +
> +	if (iommu->outgoing_preserved_state) {
> +		iommu->outgoing_preserved_state->obj.ref_count++;
> +		return 0;
> +	}
> +
> +	ret = liveupdate_flb_get_outgoing(&iommu_flb, (void **)&flb_obj);
> +	if (ret)
> +		return ret;
> +
> +	idx = reserve_obj_ser((struct iommu_objs_ser **)&flb_obj->iommus, MAX_IOMMU_SERS);
> +	if (idx < 0)
> +		return idx;
> +
> +	iommu_ser = &flb_obj->iommus->iommus[idx];
> +	idx = flb_obj->ser->nr_iommus++;
> +	iommu_ser->obj.idx = idx;
> +	iommu_ser->obj.ref_count = 1;
> +
> +	ret = iommu->ops->preserve(iommu, iommu_ser);
> +	if (ret)
> +		iommu_ser->obj.deleted = true;
> +
> +	iommu->outgoing_preserved_state = iommu_ser;
> +	return ret;
> +}
> +
> +static void iommu_unpreserve_locked(struct iommu_device *iommu)
> +{
> +	struct iommu_ser *iommu_ser = iommu->outgoing_preserved_state;
> +
> +	iommu_ser->obj.ref_count--;
> +	if (iommu_ser->obj.ref_count)
> +		return;
> +
> +	iommu->outgoing_preserved_state = NULL;
> +	iommu->ops->unpreserve(iommu, iommu_ser);
> +	iommu_ser->obj.deleted = true;
> +}
> +
> +int iommu_preserve_device(struct iommu_domain *domain, struct device *dev)
> +{

... but this helper only cares about a single domain.

> +	struct iommu_lu_flb_obj *flb_obj;
> +	struct device_ser *device_ser;
> +	struct dev_iommu *iommu;
> +	struct pci_dev *pdev;
> +	int ret, idx;

Thanks,
baolu
