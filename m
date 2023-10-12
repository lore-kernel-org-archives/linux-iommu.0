Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5671B7E4
	for <iommu@lists.linux.dev>; Thu, 12 Oct 2023 02:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="REhVRYpN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697076630; x=1728612630;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=t1vIK7JXKv8WT99rVeioMzC8BuOwbIY4b9dnxtFA/lU=;
  b=REhVRYpNmkUSHIpYOsIVGNO/gipKX+caBGwQHap1lEUvmsHc+lsZv4o0
   ZI07LJp7P+zKYn/O6QuNdaAzfEicmlXlbjTnOFgEhtq5SFs4LvBVvahyk
   VDW6kAUrM+ecf00Q4d003O6hS8Nodqm1ymytrTLy60v2izlUpfM8Hp9HR
   pSUIrvOEW/EEiF6CAebULm1zdCTIhRq3D7tWz7IgFoci7Wal0ev5JyHus
   hs6K6NlVqEMO8xUV+Z6AheTn/EeT4SSJoNEPaJwWhEf0TZBcF5AdO2hTv
   WCTD5Iqxk2bJryq2jsYD43N9yrbadTnb6n/nEVhAN3aKkz6cPsbNpV3GE
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="365087265"
X-IronPort-AV: E=Sophos;i="6.03,217,1694761200"; 
   d="scan'208";a="365087265"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 19:10:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="754061834"
X-IronPort-AV: E=Sophos;i="6.03,217,1694761200"; 
   d="scan'208";a="754061834"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by orsmga002.jf.intel.com with ESMTP; 11 Oct 2023 19:10:25 -0700
Message-ID: <3252ab70-10dc-4eeb-b566-8a89c6b4abac@linux.intel.com>
Date: Thu, 12 Oct 2023 10:06:53 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
 kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] iommu: change iommu_map_sgtable to return signed values
Content-Language: en-US
To: Dan Carpenter <dan.carpenter@linaro.org>, Joerg Roedel <joro@8bytes.org>
References: <06672b96-23fd-424c-8880-1626e7bf119c@moroto.mountain>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <06672b96-23fd-424c-8880-1626e7bf119c@moroto.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/11/23 4:01 PM, Dan Carpenter wrote:
> The iommu_map_sgtable() function returns ssize_t and negative error 
> codes but it's declared as size_t instead. I think that static checkers 
> would have complained if this caused a bug, but even though it doesn't 
> cause a bug, it's definitely worth fixing. Signed-off-by: Dan Carpenter 
> <dan.carpenter@linaro.org> --- include/linux/iommu.h | 2 +- 1 file 
> changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
