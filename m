Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F211B29A7
	for <iommu@lists.linux.dev>; Fri, 16 Aug 2024 13:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723813507; cv=none; b=NEtyIM7zsgp2khaG6Db8fa6NaikendwJpRCNtHYEe4PJU0VIfDt45ECajkF2tMbEEOT0Ua7mwWcjAu+O3XmlLRmrZ8/ru4YqjjN0tbDjDggdEyc+AZwnLnbx578MDweGLNxYSyHLBBa9xdnQuG9kcaNIOlnpzLVr1AmPTe7OOfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723813507; c=relaxed/simple;
	bh=zZDvKiEzO+CMLqT/WL8EPPoLWf7dnT41Z2Z5rQ2p3VA=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=KjnDPxpek+9cxWFITVZacV4c7eAjRMuKOXVnCcmEeoyDkg7q+FIhe7Lklr/TFOshwwVYLz1gP33kHmA4tEu0DkF5y+khmnZ82MIEbcOfPsKg28h1mOBnH2/BgElZ7Fu1IQabREw3Neq1XLtPLvaBpBLFMq9D0C9WDwtwDOFtpqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BlDCfWOf; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BlDCfWOf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723813506; x=1755349506;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=zZDvKiEzO+CMLqT/WL8EPPoLWf7dnT41Z2Z5rQ2p3VA=;
  b=BlDCfWOflvAWviDUUfHTjhGmHnXs/tisKSD+OropgxLKYb90+Xg9HOUx
   OFiKnmJiThc/T/H3V67VvMpe11wJCYqeVunPqEXN7qFQR4KYreU6XQAJ0
   Af6FUOtRbf9WIs1gJbQ8XiHJ53MGLKVMcg7VtL0oIX9kPP0ci0Zb1vshR
   GetrgMd9wV84F8t0uERMb2ClFBTC8Oz1D2n9ZvnEtwTdjiXgwXVfCOx8A
   jyi+Zk4R78Pw9mGu2FP5rwplB9xxzW1LiG3bERx34YRfqofK7NnN6BMAK
   rOfWX+467apQTKlrxt/9LkD/qohFyiw1uL39W+YADzAPWXU7sGBd+mMeM
   Q==;
X-CSE-ConnectionGUID: /PlZfwagQ92hicrqYRXGrQ==
X-CSE-MsgGUID: q8srKSuhRFaqNnoAenzYiw==
X-IronPort-AV: E=McAfee;i="6700,10204,11166"; a="47511417"
X-IronPort-AV: E=Sophos;i="6.10,151,1719903600"; 
   d="scan'208";a="47511417"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2024 06:05:05 -0700
X-CSE-ConnectionGUID: 8zQVtGDASrmi62S/zeeU+g==
X-CSE-MsgGUID: fTc59kmlSz2WqzV2+dd1DA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,151,1719903600"; 
   d="scan'208";a="90444487"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.125.248.220]) ([10.125.248.220])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2024 06:05:03 -0700
Message-ID: <7dcc6982-31db-4273-af5f-5f99982165ca@linux.intel.com>
Date: Fri, 16 Aug 2024 21:05:01 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, "Tian, Kevin" <kevin.tian@intel.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>
Subject: Re: Two opens about iommufd pasid + IOPF
To: Jason Gunthorpe <jgg@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
References: <0bf383b7-ed96-49ca-b1da-d1fff48e161a@intel.com>
 <20240816124707.GZ2032816@nvidia.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20240816124707.GZ2032816@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024/8/16 20:47, Jason Gunthorpe wrote:
> On Fri, Aug 16, 2024 at 07:50:05PM +0800, Yi Liu wrote:
>> Hi Kevin, Baolu, Jason,
>>
>> I've got two opens when rebasing iommufd pasid series on top of 6.11.
>> Would like to hear about your ideas. 🙂
>>
>> 1) How to retrieve attached domain for pasid in the iommu core. This is
>>     needed when adding domain replacement for pasid. In the before, it can
>>     be done by searching the group->pasid_array[1]. However, the
>>     group->pasid_array stores iommu_attach_handle after the iopf patch [2].
>>     IIUC, iommu_attach_handle is passed only when the domain is
>>     iopf-capable. So, if the old domain does not support iopf, then it's not
>>     able to get this old domain from the group->pasid_array when trying to
>>     do domain replacement. 🙁
>>     Not sure if any side-effect if I always pass an iommu_attach_handle even
>>     if the hwpt/domain is not iopf-capable. @Baolu?
> You should always pass the handle
> 
> Alternatively you could use the xa based encoding I showed earlier to
> store either handles or naked domains in the xarray. But really it
> seems just fine to have iommufd allocate handle memory

That works.

An alternative approach is to separate replace_pasid from set_pasid. In
that case, both new and old domains could be passed from iommufd to
replace callback.

>> 2) Should I enable/disable IOPF when attaching/detaching pasid to/from
>>     domains just like patch [3] does?
>>
>> [1]https://lore.kernel.org/linux-iommu/20240628090557.50898-2-yi.l.liu@intel.com/
>> [2]https://lore.kernel.org/linux-iommu/20240702063444.105814-2-baolu.lu@linux.intel.com/
>> [3]https://lore.kernel.org/linux-iommu/20240702063444.105814-8-baolu.lu@linux.intel.com/
> I would really like to remove IOMMU_DEV_FEAT_IOPF...

That's reasonable. Then iopf is automatically enabled when the first
iopf-capable domain is attached and disabled when the last such domain
is detached.

Thanks,
baolu
