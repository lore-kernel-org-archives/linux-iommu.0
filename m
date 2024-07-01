Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC0A141C72
	for <iommu@lists.linux.dev>; Mon,  1 Jul 2024 05:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719813352; cv=none; b=JKtnm7NT+ZjMcvsT5VxRt6BITTyD7G/aZPVkI+UPKkrYeANcV9nvo7EGO0bMBpCzVxwSRGDdnPdQGijHyHL16biT/PC/Dng8oBXBEbL8m0ghtjiRfyGjFWF9TJ5Jvly2uQrc9Mat3+0239Ja8v11WN8XpRBJyzh63IEZVrV7DQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719813352; c=relaxed/simple;
	bh=zoolY0j9tBgKN2MEBj7jMgK5u98hB3qhLdhkSd0qq80=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=NryxKfZyAWLXv6osvdGD7fMVGK/AIvjtIKMnFY+MDEjThxVSBJ/48n48A5Z1GWaRim5QQ4NMbNnYEdpTd5MbWhcQwddEDCxFBZP+myV8xygBFRCmNmuwmDuJzuflmNEHj2noyqSXMlXeVqwE2Spxjkym/gyZvnUzVkzndZs0lks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QL50/L3Y; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QL50/L3Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719813350; x=1751349350;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=zoolY0j9tBgKN2MEBj7jMgK5u98hB3qhLdhkSd0qq80=;
  b=QL50/L3YpB0qMAXuN6WxWNgtzV3EB4bYpTwp/bjLW5nLo/pISs1d5haw
   xsjzD6qN0HjnFi2NzeLwOXJym/osl+I2DHnN4PNgJY8kIpPc1anc7WgTx
   uX1Ie/nWAzSYNXiD1V0jVBd5PYa9FkoyrQoI/OxdlJ91GZ/qO8plR+qph
   yD7NM8Scep7mi+WegZa+r2mVIUKt81v3vQMIUOMRcMXXZD/yxqHn464Jv
   kwMxFlI6H9ALvjAS3VLKPFPxEQbAAlbqUUwbnnfThX1xkI+N1ocGj26iW
   kEgl7fMeNR20GyzTdDu76OFQCU3UP5cmgabNch9xFvYhRKxc0fUC3dNw1
   g==;
X-CSE-ConnectionGUID: 5nMAhiCUTnCCtwZgXLOqCw==
X-CSE-MsgGUID: +dYFI+IaRKOUCRNkn4z9sQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11119"; a="19817036"
X-IronPort-AV: E=Sophos;i="6.09,175,1716274800"; 
   d="scan'208";a="19817036"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2024 22:55:17 -0700
X-CSE-ConnectionGUID: YvK3MWzjQP6f2lsibkttYQ==
X-CSE-MsgGUID: p91iEwuIRdqyjcfXzEouHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,175,1716274800"; 
   d="scan'208";a="49860164"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.124.229.145]) ([10.124.229.145])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2024 22:55:14 -0700
Message-ID: <7421b923-0bd6-4c9d-81e6-07d954085171@linux.intel.com>
Date: Mon, 1 Jul 2024 13:55:12 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Kevin Tian <kevin.tian@intel.com>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>,
 Joel Granados <j.granados@samsung.com>, iommu@lists.linux.dev,
 virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 07/10] iommufd: Fault-capable hwpt
 attach/detach/replace
To: Jason Gunthorpe <jgg@ziepe.ca>
References: <20240616061155.169343-1-baolu.lu@linux.intel.com>
 <20240616061155.169343-8-baolu.lu@linux.intel.com>
 <Zn8oZ80p0p1bHgBC@ziepe.ca>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <Zn8oZ80p0p1bHgBC@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/6/29 5:17, Jason Gunthorpe wrote:
> On Sun, Jun 16, 2024 at 02:11:52PM +0800, Lu Baolu wrote:
>> +static int iommufd_fault_iopf_enable(struct iommufd_device *idev)
>> +{
>> +	struct device *dev = idev->dev;
>> +	int ret;
>> +
>> +	/*
>> +	 * Once we turn on PCI/PRI support for VF, the response failure code
>> +	 * should not be forwarded to the hardware due to PRI being a shared
>> +	 * resource between PF and VFs. There is no coordination for this
>> +	 * shared capability. This waits for a vPRI reset to recover.
>> +	 */
>> +	if (dev_is_pci(dev) && to_pci_dev(dev)->is_virtfn)
>> +		return -EINVAL;
> I don't quite get this remark, isn't not supporting PRI on VFs kind of
> useless? What is the story here?

This remark is trying to explain why attaching an iopf-capable hwpt to a
VF is not supported for now. The PCI sepc (section 10.4.2.1) states that
a response failure will disable the PRI on the function. But for PF/VF
case, the PRI is a shared resource, therefore a response failure on a VF
might cause iopf on other VFs to malfunction. So, we start from simple
by not allowing it.

Best regards,
baolu
