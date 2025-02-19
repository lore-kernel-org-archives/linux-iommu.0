Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1201B87F5
	for <iommu@lists.linux.dev>; Wed, 19 Feb 2025 06:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739944928; cv=none; b=bkHxUt2RjUyKvD1PCTM5NS/jiUFvijHLE0Zje2iOWYxy1b9gIktYdJw7Ni75+Rle9udRfYBWNWuUfbfP6IZqASe8Fto19z3Y3QLku4/ZDOsa+5yhFsdL45aPPMW3GN7MV/0eHUzHPDMzJXTHb7UsYZMzay0xkRbo4KF6HlNyYrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739944928; c=relaxed/simple;
	bh=KjpYYG/KKSxKeVYVZIzx1tumhkfjES6+uEjUpium104=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Xf8mQ8ZWYcp6rklsQeHSfjud7HA9tB6p0fUdIaoVWRbhAZ38rs9+wndf+feL4mwuNOkPYoyUnQz0z0o0Vakiyui3LTuMBSWH4nVBJxkLzCo9lzWMX4NEtM6TWDWOVw+7hUgkmZJmRNNPTNXEvQxkS6KHRnGmSo0v4YdqUNMm1ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hPfxm+V6; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hPfxm+V6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739944926; x=1771480926;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=KjpYYG/KKSxKeVYVZIzx1tumhkfjES6+uEjUpium104=;
  b=hPfxm+V6DAYPTvBuz9fxEky4oGTUhZh7GQ8iMhxUYk0jczAWXS+p5qCq
   3tT5SeSgdZYU4cQ1/iE23u5e5hp5i9wJHcrIJL4juDJC80N/qctu0q+Iv
   WU+fi4DJZLHQTPSbcqHiI8rSRW48dTkX5TWxeLQETva8ktnEaLovov8EN
   zOGERLe4XaJbDtf0tt7xjUUbAdy3EntwDHe6EVHo1RxB68mM/egO8/AyE
   i9rzxo9FamCfhUsO7KoBSUKqA/EpcBcU1lEkLfXXKxwbQyk1rNa9T6Tza
   NQtP5G6J3R4S3bpWxClX1cXKxMorYLvuar+pnRffia8/JKqkBphZdH+I8
   A==;
X-CSE-ConnectionGUID: Do7L1D42RBulHLXKN2HLQA==
X-CSE-MsgGUID: 0y2dd3WfQBiSnjk5mMzLIA==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="40925467"
X-IronPort-AV: E=Sophos;i="6.13,298,1732608000"; 
   d="scan'208";a="40925467"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2025 22:02:05 -0800
X-CSE-ConnectionGUID: qmJ6BvPDR9a4Gg0Lh5N98A==
X-CSE-MsgGUID: IEs/MSOVRRqefGp8wzDFYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,298,1732608000"; 
   d="scan'208";a="119729197"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.124.240.17]) ([10.124.240.17])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2025 22:02:02 -0800
Message-ID: <e21e71c4-d627-4150-996b-893fe5bd4726@linux.intel.com>
Date: Wed, 19 Feb 2025 14:02:00 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Dave Jiang <dave.jiang@intel.com>,
 Vinod Koul <vkoul@kernel.org>, Zhangfei Gao <zhangfei.gao@linaro.org>,
 Zhou Wang <wangzhou1@hisilicon.com>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/12] dmaengine: idxd: Remove unnecessary
 IOMMU_DEV_FEAT_IOPF
To: Fenghua Yu <fenghuay@nvidia.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>
References: <20250214061104.1959525-1-baolu.lu@linux.intel.com>
 <20250214061104.1959525-10-baolu.lu@linux.intel.com>
 <94b6f4fa-8a92-47a1-8938-b838ce19d122@nvidia.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <94b6f4fa-8a92-47a1-8938-b838ce19d122@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025/2/19 6:55, Fenghua Yu wrote:
> On 2/13/25 22:11, Lu Baolu wrote:
>> The IOMMU_DEV_FEAT_IOPF implementation in the iommu driver is just a 
>> no-op.
>> It will also be removed from the iommu driver in the subsequent patch.
>> Remove it to avoid dead code.
>>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>

Thank you, Fenghua.

Can you please update your contact email in MAINTAINERS file.

Thanks,
baolu
