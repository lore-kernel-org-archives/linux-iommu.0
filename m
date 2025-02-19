Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4651B87EF
	for <iommu@lists.linux.dev>; Wed, 19 Feb 2025 05:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739944780; cv=none; b=UBnYaUGjZZKgZcNTjJGtgrOFO9XQjTCCwe6jLi4I77hKD6ACLkhHeNfMKazGDQLafokkJcwpfvn6SWad96QFrYm/xmODd+dH0YTyIgw3aPihBVRQ8ghRNB4HB/JttggG/kE4zHJ6GDovdd5/1sQ0IZhBF4fAffkP5iMvf/K53fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739944780; c=relaxed/simple;
	bh=WP4TPs5YAWDBxm0IUni+rpJ1e/IzyI1sEZ0aUdZXZOU=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=GEEK10Z2d9FZ4WPQnJYSytWfF5XzwbtGAz0Vd9Xq0sdZIVZMl4khvw7YVbHxj/o3SXe9NcT9/juoFqfYFpzX/xox2ENiwYZizX/6VMXDhZd4O4BbzA1EoNXwhzNWJ/bVACD9K47mCdUgEAJrvkzIH/tJDlTozPu7F8jrn9udOe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CNBwut6u; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CNBwut6u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739944778; x=1771480778;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=WP4TPs5YAWDBxm0IUni+rpJ1e/IzyI1sEZ0aUdZXZOU=;
  b=CNBwut6u1o+FyUCwpVivkcSME6YLOmAXspGqObNhsTB8sRV8u5E7NSEU
   ltIcbFA9F4YjLAy0aheLZiuK9WH0/GD451nQAX8b1mGN7GsqNNkR1m0uD
   PW3c6lNzuJpdC5/WPHUzhaPOqOe3adxapen2nj9ta36i8Q0zPgDJKh4VQ
   W3u6WqCis/YtepUE3hyDGro5mByQhtdz2nNtGhT++2HlIfE3I5pF3iyRk
   Wup7u16ZY5OmFNVwaHyQ0uCNoH+dXHCvv/5Z0HK8pyWilXu9AxuCJqPIo
   +mL0IZL/EIo+eaVk9HCLJKTdJRGukIUnowK2cbO1rMCInvf0jnzqPiu7C
   A==;
X-CSE-ConnectionGUID: nysM4vGrTVKeLk4vopDnMg==
X-CSE-MsgGUID: W0kxl9/lSmSww3uJxxnoMw==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="40531812"
X-IronPort-AV: E=Sophos;i="6.13,298,1732608000"; 
   d="scan'208";a="40531812"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2025 21:59:38 -0800
X-CSE-ConnectionGUID: wYuA1e3oRbOXSfLzikMOdw==
X-CSE-MsgGUID: 4SOjxFkHT9ibvvSVRQUTmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,298,1732608000"; 
   d="scan'208";a="114539447"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.124.240.17]) ([10.124.240.17])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2025 21:59:34 -0800
Message-ID: <c366a32d-1c64-4d03-8206-d7a92815bb68@linux.intel.com>
Date: Wed, 19 Feb 2025 13:59:31 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Nicolin Chen <nicolinc@nvidia.com>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>,
 Fenghua Yu <fenghua.yu@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Vinod Koul <vkoul@kernel.org>, Zhangfei Gao <zhangfei.gao@linaro.org>,
 Zhou Wang <wangzhou1@hisilicon.com>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/12] iommufd: Remove unnecessary IOMMU_DEV_FEAT_IOPF
To: Jason Gunthorpe <jgg@ziepe.ca>
References: <20250214061104.1959525-1-baolu.lu@linux.intel.com>
 <20250214061104.1959525-12-baolu.lu@linux.intel.com>
 <Z67rghQyQrjb5sT1@Asurada-Nvidia>
 <4ee09fd2-92c6-4295-88ca-1cc061135417@linux.intel.com>
 <20250218130607.GG3696814@ziepe.ca>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20250218130607.GG3696814@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025/2/18 21:06, Jason Gunthorpe wrote:
> On Sat, Feb 15, 2025 at 02:32:32PM +0800, Baolu Lu wrote:
>> On 2/14/25 15:06, Nicolin Chen wrote:
>>> On Fri, Feb 14, 2025 at 02:11:03PM +0800, Lu Baolu wrote:
>>>> The iopf enablement has been moved to the iommu drivers. It is unnecessary
>>>> for iommufd to handle iopf enablement. Remove the iopf enablement logic to
>>>> avoid duplication.
>>>>
>>>> Signed-off-by: Lu Baolu<baolu.lu@linux.intel.com>
>>>> ---
>>>>    drivers/iommu/iommufd/device.c          |   1 -
>>>>    drivers/iommu/iommufd/fault.c           | 111 ++++++------------------
>>>>    drivers/iommu/iommufd/iommufd_private.h |   3 -
>>>>    3 files changed, 28 insertions(+), 87 deletions(-)
>>> This is in conflict with my fault patches that Jason just took
>>> a couple days ago:
>>> https://git.kernel.org/pub/scm/linux/kernel/git/jgg/iommufd.git/log/?
>>> h=for-next
>>>
>>> I think it needs a rebase, perhaps on the branch mentioned here:
>>> https://lore.kernel.org/linux-iommu/20250213150836.GC3754072@nvidia.com/
>> Yes, sure. I will rebase it in the next version to avoid the conflict.
> That's troublesome, I think just leave it so Joerg can pick it up. We
> can figure out what to do with the conflict later.

Okay, sure.
