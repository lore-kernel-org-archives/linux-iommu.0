Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 060342BB13
	for <iommu@lists.linux.dev>; Thu, 25 Sep 2025 05:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758776699; cv=none; b=XXqbVLdalSXDvhY+YXqYnM4325cw+GZCIDhFOs85q7hSEnBz+32aDlp7mqhh9CCt03K6mYbqD6QofAXD0mUs/zRbJczjWWgAvVYYfAGhhPZmfAnzOxXPF6R+tAOj+Ni8GDdISywgBNjICQ7RMFhJRW5Wuc2banuvBi0szUMWYAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758776699; c=relaxed/simple;
	bh=00Jb5ofRs2Wx/M1a27kog/dSlNO4Defx87U3WcPzeZU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R2RDEgJVqCuauiUcv24X8+1vWVmiKOpUwQ7Q0f/7KIY6kkhWJBDH+HfhUvXL2hm6gskPaqNbCm6XMAND9VFRPJJ6NWMzr7DmpfDwmyuw54/+BAA7elqracEuee8LAABMoHG16zJ6mrOphKVIz/0BtFnRh6IBDw/73orb0i8seX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GfkGr5i2; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GfkGr5i2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758776697; x=1790312697;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=00Jb5ofRs2Wx/M1a27kog/dSlNO4Defx87U3WcPzeZU=;
  b=GfkGr5i2fJXz7bMORc7XLMMvBZq8ePHcFSahJjAjQwBS6j4PHvNfq4IJ
   p+PnZ5pucgKSCOgNNV0sL6dULFVoAycmM5yblvEbVkkxFjf4z1RwB+Ymx
   yazUeDcO4gJBigqmDZntlc1orCCakxQzxVSYVjBz3pNchRKohkRq9P2sD
   XXGHIIXiEWefwzVYbYJn9inwoGig2HINXW0VDBveLVLgYaJbXeWH21iP/
   yPruuXhPjqXYZ+S/NFVbqHzQhhDHceUsUGaZxNn49xLFMlY5G+31d0+SZ
   WTFIBXoooODpxADQnp52HAwhK8wekaYbtH4LpGpeiQRjXLfga8+ohy1Wk
   Q==;
X-CSE-ConnectionGUID: BkXZqL3ZSEy9z30PZLlddg==
X-CSE-MsgGUID: AFmBeFWrSKG6JL+UGgk8DQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="60998101"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="60998101"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2025 22:04:57 -0700
X-CSE-ConnectionGUID: 9rKldSriT8W2w9og2jh/yA==
X-CSE-MsgGUID: 4C/avaKRSVmnT1fOeF/5Ig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,291,1751266800"; 
   d="scan'208";a="200922802"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2025 22:04:54 -0700
Message-ID: <a6506e38-84c9-45f2-9e3e-8beae2dc4668@linux.intel.com>
Date: Thu, 25 Sep 2025 13:01:49 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] iommu: Fix iommu selftest running test mock domain
 fail
To: Guixin Liu <kanie@linux.alibaba.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>
Cc: iommu@lists.linux.dev
References: <20250925025251.64578-1-kanie@linux.alibaba.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20250925025251.64578-1-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/25/25 10:52, Guixin Liu wrote:
> When intel_iommu=on is enabled and the iommu selftests are executed,
> we observed multiple test case failures. Our investigation revealed
> that both the Intel iommu driver and the mock iommu driver registered
> iommu_device instances with fwnode=NULL, and both were added to the
> iommu_device_list. Later, when the mock iommu driver attempted to
> create a device, iommu_init_device attempted to retrieve the iommu_ops
> by searching the iommu_device_list using the provided fwnode
> (which was NULL).
> Since the iommu_device registered by the Intel iommu driver appeared
> earlier in the list, it was matched first instead of the mock iommu
> driver's iommu_device. This ultimately caused probe_device to fail.
> 
> Fix this by alloc a software fwnode for mock iommu driver's iommu_device,
> and set it to the device which mock iommu driver created.
> 
> Test by "make -C toosl/testing/selftests TARGETS=iommu run_tests":
> PASSED: 229 / 229 tests passed.
> 
> In addition, this issue is also can be found on amd platform, and
> also tested on a amd machine.
> 
> Signed-off-by: Guixin Liu<kanie@linux.alibaba.com>
> Tested-by: Qinyun Tan<qinyuntan@linux.alibaba.com>
> ---
> Changes from v3 to v4:
> - Remove iommu_mock_device_abort(), rename iommu_mock_device_init() to
> iommu_mock_device_add(), and fold device_add() into iommu_mock_device_add().
> 
> Changes from v2 to v3:
> - Add export symbol iommu_mock_device_init() and iommu_mock_device_abort()
> in iommu.c instead of export iommu_probe_device_lock and iommu_fwspec_free().
> 
> Changes from v1 to v2:
> - Remove print when iommu_fwspec_init() fail.
>   drivers/iommu/iommu-priv.h       |  2 ++
>   drivers/iommu/iommu.c            | 28 ++++++++++++++++++++++++++++
>   drivers/iommu/iommufd/selftest.c |  2 +-
>   3 files changed, 31 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/iommu-priv.h b/drivers/iommu/iommu-priv.h
> index e236b932e766..c95394cd03a7 100644
> --- a/drivers/iommu/iommu-priv.h
> +++ b/drivers/iommu/iommu-priv.h
> @@ -37,6 +37,8 @@ void iommu_device_unregister_bus(struct iommu_device *iommu,
>   				 const struct bus_type *bus,
>   				 struct notifier_block *nb);
>   
> +int iommu_mock_device_add(struct device *dev, struct iommu_device *iommu);
> +
>   struct iommu_attach_handle *iommu_attach_handle_get(struct iommu_group *group,
>   						    ioasid_t pasid,
>   						    unsigned int type);
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 060ebe330ee1..5d4670aa50e6 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -304,6 +304,7 @@ void iommu_device_unregister_bus(struct iommu_device *iommu,
>   				 struct notifier_block *nb)
>   {
>   	bus_unregister_notifier(bus, nb);
> +	fwnode_remove_software_node(iommu->fwnode);
>   	iommu_device_unregister(iommu);
>   }
>   EXPORT_SYMBOL_GPL(iommu_device_unregister_bus);
> @@ -326,6 +327,14 @@ int iommu_device_register_bus(struct iommu_device *iommu,
>   	if (err)
>   		return err;
>   
> +	iommu->fwnode = fwnode_create_software_node(NULL, NULL);
> +	if (IS_ERR(iommu->fwnode)) {
> +		iommu->fwnode = NULL;
> +		dev_err(iommu->dev,"add property failed:%d\n", err);
> +		bus_unregister_notifier(bus, nb);
> +		return err;
> +	}

Nit: I don't think we need a dev_err() here. Also, there's no need for
"iommu->fwnode = NULL;" since you don't do this in
iommu_device_unregister_bus().

Just simply

	if (IS_ERR(iommu->fwnode)) {
		bus_unregister_notifier(bus, nb);
		return err;
	}

?

Otherwise, it looks good to me.

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
