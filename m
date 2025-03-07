Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F2618027
	for <iommu@lists.linux.dev>; Fri,  7 Mar 2025 01:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741311361; cv=none; b=oV69fzUQojQuqQGU6HKqBwg1vEwJVbnARSj7hnFTZ49sTgnOcPeKbXI0V9DZ9ncQ36YFbZnY513siojQU5a+RfPtVW0ElZD4tqHHDQjTGPSl1GN951kWnY611t5LTJbE68HPmrOtQXR0i8pt+D2nP/MZU9qpKiFGJ8uLtkgOCnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741311361; c=relaxed/simple;
	bh=jkCYtC/1pVg8NU6E6YvRhtjpepudinQpQZ3sDGVo+tY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OLApZ+5Cd8kR9jriEylIT2fZSe6vEU/cOechXsBu0vkBH3gTz3WBhE99yTB1iBDD7Yaja6an+egI43DVFEWv+EsO4KusOxy8xyW00Y/tpZMBTk5tWv9bQolHBMm5Di2QUBH1QThB678zT6QfR/dGOIfUbPVevtcAPpBN8YzjK6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RPh3hVx4; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RPh3hVx4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741311360; x=1772847360;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=jkCYtC/1pVg8NU6E6YvRhtjpepudinQpQZ3sDGVo+tY=;
  b=RPh3hVx4Xas1kyO7EjP9xtojayWeMtsxLEdZls9J4wy7v1ZPVFb9965o
   cTpzxmbw90n+0y2TtgFZ6U6lM3U5ROuUy1vFCmv9tImVB8+5o99cmZfZ+
   wbHfmqPLRyiLtL4aJheHhONQ/aWckSxSX8Jnh9dEb/supg7Mz/9/sFaqf
   CtCInvUtZ1c+evmxRq9e30gq5qUPOG5WmkZGSrlpvDWN2sAOdGfIdTTbJ
   nlo35juJipBMYwebTP7kz2bp3WTuq4kwcirIFzNNgMRU/iiAdrHqJT+n0
   7sE66ktdZzcxnKzvZT8FM5k/YK9p37+AYj+9pFfprZLjg//Q36YOWjf3q
   Q==;
X-CSE-ConnectionGUID: 0sq9T+o/Tjmu4d0KgTIGRg==
X-CSE-MsgGUID: WDRzRkwpTyuOIqhhh9+G3A==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="46003627"
X-IronPort-AV: E=Sophos;i="6.14,227,1736841600"; 
   d="scan'208";a="46003627"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 17:35:56 -0800
X-CSE-ConnectionGUID: kt3Vwsw7Ro+A4LBmsaZ0Bw==
X-CSE-MsgGUID: wACPHHdkQUyCCOQWAYAVxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,227,1736841600"; 
   d="scan'208";a="142416694"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 17:35:54 -0800
Message-ID: <626f37a5-7427-4e63-910c-785a66cae4b4@linux.intel.com>
Date: Fri, 7 Mar 2025 09:32:47 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] iommufd: Use accurate dev_id in the PRI forwarding path
To: Jason Gunthorpe <jgg@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>
References: <20250305130356.126424-1-yi.l.liu@intel.com>
 <20250305171838.GC133783@nvidia.com>
 <BN9PR11MB5276771968FF57AC0FE74BCB8CCA2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <d4da9e8a-e393-487d-ae4c-892fc139f2b3@intel.com>
 <77fcb453-d88e-413e-8637-c61aa73be376@intel.com>
 <20250306190634.GH354511@nvidia.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20250306190634.GH354511@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/7/25 03:06, Jason Gunthorpe wrote:
> On Thu, Mar 06, 2025 at 03:09:34PM +0800, Yi Liu wrote:
>> +bool iommu_group_is_singular(struct iommu_group *group)
>> +{
>> +	bool res;
>> +
>> +	mutex_lock(&group->mutex);
>> +	res = list_count_nodes(&group->devices) == 1;
>> +	mutex_unlock(&group->mutex);
>> +
>> +	return res;
>> +}
>> +EXPORT_SYMBOL_NS_GPL(iommu_group_is_singular, "IOMMUFD_INTERNAL");
> I'm not so excited about something racy like this..
> 
> I still think this is a bit wrong, we only care about aliases, not
> multi device groups.
> 
> Aliases are created here:
> 
> 	if (pci_for_each_dma_alias(pdev, get_pci_alias_or_group, &data))
> 		return data.group;
> 
> And maybe in a few other places..
> 
> Can you tag the group that it has aliases in it directly during group
> creation so there are no races?
> 
> I've long had a desire to more clearly separate the two cases of
> groups:
> 
>   1) The HW cannot tell the different struct device sources on a per
>      DMA basis
>   2) There is a security intertwinement between the devices but they
>      can all run separately in the IOMMU HW
> 
> Maybe it is not so hard?

This is a long-standing issue. If I recall correctly, Joerg once
proposed the concept of iommu subgroup.

Thanks,
baolu
