Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE0D1369B0
	for <iommu@lists.linux.dev>; Thu, 13 Jun 2024 06:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718260962; cv=none; b=Fx0qhSnEWizxAjCcLOrYIDn7c0CpTeJZH6T6OreMj0CKl87YiHB7QQgCVSmUQ3hAbarkWBDg5v5IfQkofAGz+jt4qIeydD67B+ril/ilIpoNez2DLr6xprFltQSHwya7KCR4N3zvWqht8qhB433vp8zm5kihrBZbvi44EDryusM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718260962; c=relaxed/simple;
	bh=nih8HgDoXnDxJo9FTwV8yzVyB7RsNmA2vKpkgq0mT6g=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=QOuj6hPUOV/3BEExAAAU25S75W5l+rwXnex9ukYQrCPgAFVFAEBYdqhmpBYYpS5O9kwMofBUko6Mrpe8EOxSp6TPEz9x2IP+JlwdoWGruICLzpUUzYPfmB+9ims04oZf7tFti1phSi4c1DvnnCM5mNGrlUdZXu20MZKMqb+wxEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JjqU0A7u; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JjqU0A7u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718260961; x=1749796961;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=nih8HgDoXnDxJo9FTwV8yzVyB7RsNmA2vKpkgq0mT6g=;
  b=JjqU0A7u7M2alVXh4k2XXNxYR5wHs+PJ5OhGdjKrMn1v7TZtXEgQR032
   XVyXeIlLr0hWk5qmaZg8BgCtFGomrjblJUDLpRao7HJEbF2gBb5OTjnS5
   Rm4LJOKvISNo0v89DDnhFeQm5McbslMnzpTtK4T793h0vS0RkrgrrjoCo
   acpKT6gWLmgsXqNfAvzMnmO7bxZIzzqwK22NNSERXXQT5UDavxSLyB8+u
   B0b5mjOv+n5Es73zJ4sxBhTVBCdDm0w9Xv7rVCGQsEbcV2qE89ad0fEx1
   RRO7ya4+Yn7fkfTEcpfsI60861H1DbB2eFZ6YJYEk4opmM/DkU71wJPrR
   Q==;
X-CSE-ConnectionGUID: s70fZzc3R/W6ZHnd5Tlmmg==
X-CSE-MsgGUID: oHnlSwlzRtC0DXiuB3tz7A==
X-IronPort-AV: E=McAfee;i="6700,10204,11101"; a="32546262"
X-IronPort-AV: E=Sophos;i="6.08,234,1712646000"; 
   d="scan'208";a="32546262"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2024 23:42:40 -0700
X-CSE-ConnectionGUID: nMJpsTrOTnS0VSuRh0vJ5w==
X-CSE-MsgGUID: I3OWTSD2SEOg9c+X370K5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,234,1712646000"; 
   d="scan'208";a="45167888"
Received: from unknown (HELO [10.239.159.127]) ([10.239.159.127])
  by orviesa004.jf.intel.com with ESMTP; 12 Jun 2024 23:42:37 -0700
Message-ID: <247f231c-3829-49c2-a8d9-11c3cc4b80ca@linux.intel.com>
Date: Thu, 13 Jun 2024 14:40:18 +0800
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
Subject: Re: [PATCH v6 05/10] iommufd: Add fault and response message
 definitions
To: Jason Gunthorpe <jgg@ziepe.ca>
References: <20240527040517.38561-1-baolu.lu@linux.intel.com>
 <20240527040517.38561-6-baolu.lu@linux.intel.com>
 <20240612135219.GZ791043@ziepe.ca>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20240612135219.GZ791043@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/12/24 9:52 PM, Jason Gunthorpe wrote:
> On Mon, May 27, 2024 at 12:05:12PM +0800, Lu Baolu wrote:
>> +/**
>> + * struct iommu_hwpt_pgfault - iommu page fault data
>> + * @size: sizeof(struct iommu_hwpt_pgfault)
>> + * @flags: Combination of enum iommu_hwpt_pgfault_flags
>> + * @dev_id: id of the originated device
>> + * @pasid: Process Address Space ID
>> + * @grpid: Page Request Group Index
>> + * @perm: Combination of enum iommu_hwpt_pgfault_perm
>> + * @addr: Fault address
>> + * @length: a hint of how much data the requestor is expecting to fetch. For
>> + *          example, if the PRI initiator knows it is going to do a 10MB
>> + *          transfer, it could fill in 10MB and the OS could pre-fault in
>> + *          10MB of IOVA. It's default to 0 if there's no such hint.
>> + * @cookie: kernel-managed cookie identifying a group of fault messages. The
>> + *          cookie number encoded in the last page fault of the group should
>> + *          be echoed back in the response message.
>> + */
>> +struct iommu_hwpt_pgfault {
>> +	__u32 size;
> Given we fail the system call if size is not exactly the right value
> we should probably drop it here.
> 
> The ioctl to get the FD can someday specify the format of the fault
> messages if we need to upgrade. If we want to change it down the road
> then the old FD will be exactly as it is now, and the user will
> request a new format FD that only works in whatever the new way is.

Okay, sure!

Best regards,
baolu
