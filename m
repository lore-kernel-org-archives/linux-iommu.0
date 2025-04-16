Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF7722A801
	for <iommu@lists.linux.dev>; Wed, 16 Apr 2025 07:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744788862; cv=none; b=Zakt0t8PQe3/FIaJArACwTec8r/L9WK4nPhRxVouiINb9RzOTCcc7go39UKUz7JT9a8ILwxRRvzcIdLUow7JALCGbFZmPzsIGRHyPjIN5llC0owO3XBDXU8LJLdJMydpfAFeTk5f+YSpgcJ1c7ndSxRLxwx7lPweBZ1GtEivBxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744788862; c=relaxed/simple;
	bh=ZUN9+7CmphzoKuPXXSpctMXJwKc0QOJymdWLosS5Tvw=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=I4224UDOnywkB/9eDiH+ai0p+NK3MzXW1IYYeoHYXBnu0JAQlTeUdmXNUem72+4uQrdjK5Jt5o1z8UxnZVrM1OwosWJL2TRfuZWxbQCwrBkv1FOrcWlgz5d6mWeKEvhK9emLAZFKbJxEoZqXiLx05D/z36I/0bJ2Mq4OaVvovD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BmvPfDPA; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BmvPfDPA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744788861; x=1776324861;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ZUN9+7CmphzoKuPXXSpctMXJwKc0QOJymdWLosS5Tvw=;
  b=BmvPfDPA8pr6G7R2b2GhW9HSh8F4Nshaj/OF8bwyzBPpUcMqczEe6aAW
   5+Ihdb/8XumoNV9on+NWT6e4kPz/tAHpjiSDjnMuBxx25Y3dFM7wXEcO9
   mGngn58CHMlanKg3B/qY9nNzlmwW6FCL8sigm7amd5UsTuJi/Qah7snMM
   QLvYhDYLL/xh547opyqw5CRLTeATkLp6Kq5j75Mch11KZK4eFIBAZPjNH
   YljDXt+aCbZpMQx+DqD3Dmoyk4gkTZ9DIkCXf4M/VQuK0HLjr7hERsFzS
   VEvarmgIxRAz0sCYAgC776j3weisbsv8mHl3pO4FM2x61pjYLOflgWmu3
   g==;
X-CSE-ConnectionGUID: FIj6p9GjQ2eBcch2b4dVvg==
X-CSE-MsgGUID: chyO2qgHSqyX8LxI2IUMFg==
X-IronPort-AV: E=McAfee;i="6700,10204,11404"; a="46485617"
X-IronPort-AV: E=Sophos;i="6.15,215,1739865600"; 
   d="scan'208";a="46485617"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2025 00:34:09 -0700
X-CSE-ConnectionGUID: ppPxQ+7RQCm5WzotWagkmw==
X-CSE-MsgGUID: kvlO5vS7QhWi9g3+BRw6OQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,215,1739865600"; 
   d="scan'208";a="130310379"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.124.241.230]) ([10.124.241.230])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2025 00:34:06 -0700
Message-ID: <8440c210-3d98-492f-9212-c7ed3cf375e2@linux.intel.com>
Date: Wed, 16 Apr 2025 15:33:46 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>,
 Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>,
 Fenghua Yu <fenghuay@nvidia.com>, Zhou Wang <wangzhou1@hisilicon.com>,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v4 0/8] iommu: Remove IOMMU_DEV_FEAT_SVA/_IOPF
To: Zhangfei Gao <zhangfei.gao@linaro.org>
References: <20250313051953.4064532-1-baolu.lu@linux.intel.com>
 <CABQgh9HbFOYsVinxr6eY-C-5UACaYeLcX8kU_HG696Wks9wn1Q@mail.gmail.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <CABQgh9HbFOYsVinxr6eY-C-5UACaYeLcX8kU_HG696Wks9wn1Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/16/2025 3:29 PM, Zhangfei Gao wrote:
> On Thu, 13 Mar 2025 at 13:19, Lu Baolu<baolu.lu@linux.intel.com> wrote:
>> The new method for driver fault reporting support relies on the domain
>> to specify a iopf_handler. The driver should detect this and setup the
>> HW when fault capable domains are attached.
>>
>> Move SMMUv3 to use this method and have VT-D validate support during
>> attach so that all three fault capable drivers have a no-op FEAT_SVA and
>> _IOPF. Then remove them.
>>
>> This was initiated by Jason. I'm following up to remove FEAT_IOPF and
>> further clean up.
>>
>> The whole series is also available at github:
>> https://github.com/LuBaolu/intel-iommu/commits/iommu_no_feat-v4
>>
>> Signed-off-by: Jason Gunthorpe<jgg@nvidia.com>
>> Signed-off-by: Lu Baolu<baolu.lu@linux.intel.com>
>>
> Will you re-spin this patchset, it is not in 6.15-rc.

Yes. I will rebase the patches and post a new version for v6.16 merge.

Thanks,
baolu
