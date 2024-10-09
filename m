Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5B81D69E
	for <iommu@lists.linux.dev>; Wed,  9 Oct 2024 01:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728438098; cv=none; b=MAJbKTTdfMKo/YAJHWOFEQUUNwJA24JFRQjy/neoombudChxFu0CdP27YHPihqvxW8+AAAK5Q8NyhbuZO4sndHF2xqdgGKRrtoqT1qgxYbPqgxBFKFT1P372tVXxNshQ4CuCCdlHxTSW4W4G8FPwFy6dN1+wwXDtAdmwFDL+YBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728438098; c=relaxed/simple;
	bh=UwgAQVZ1IPNTaU++Fsk1Wxl2yWzNBWufNRTZ6AyHv1o=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=bgUrlMJPtm6peVQ780CvO+D6HfEIIZsgnHjJ9ezVyMFIyjn8s2FZ0e//jVsgqSe3ixoZLjnqZyTZXRsTO4nSqOnMZayDrBlp8Zhj/hB80Cdt0e5JTxM4+nAx7J/W8ZJD5VV5SNGK0FPVNJzRFcFrxzoWlNuMOmiROrewJn4PN/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VuBYQ7NJ; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VuBYQ7NJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728438097; x=1759974097;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=UwgAQVZ1IPNTaU++Fsk1Wxl2yWzNBWufNRTZ6AyHv1o=;
  b=VuBYQ7NJAwINVDgM9mnp6YVxrv4pB01Ibiv/GYM8e0WC/t/1yryMhfL3
   7U8+wQ/U8T6Mco4VrJ7YkVD/X7E6PcCBpFSzV8N0Ol02HmZLO+y24q2BX
   sVtl2qFTZbWTRrgOzf4RRif88xg5eQvCskGopSZOkcp0ZnikPrMMat2tq
   LFb2xfOdJV7PgvH+ORhdsCAGn2eYtD+1yLDkKFLRnzN8OOFdkWybIK8/s
   OQ92JvyqOJ5HlWG2L5Q755mc883PCUm/KdWI2u9m46BANLIhxo93o+Gvc
   qV9WUK0TYH9r1Bf18KGzQNXeGee9LAEVNj/qaINSJheMfL9yF0e4BB0DP
   w==;
X-CSE-ConnectionGUID: hoJmLJgZTTu0MiME5ww6jQ==
X-CSE-MsgGUID: jxUcrrULQO+Zz2XmUsu7Sw==
X-IronPort-AV: E=McAfee;i="6700,10204,11219"; a="27600642"
X-IronPort-AV: E=Sophos;i="6.11,188,1725346800"; 
   d="scan'208";a="27600642"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2024 18:41:20 -0700
X-CSE-ConnectionGUID: p0YnptwTRR6qShrCSjERpw==
X-CSE-MsgGUID: Ce4WEcpgRCKxWwyPlDIIIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,188,1725346800"; 
   d="scan'208";a="99419168"
Received: from unknown (HELO [10.238.0.51]) ([10.238.0.51])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2024 18:41:18 -0700
Message-ID: <370ca3fe-41bf-4dab-a678-a499d606d6bf@linux.intel.com>
Date: Wed, 9 Oct 2024 09:41:16 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Kevin Tian <kevin.tian@intel.com>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] iommu: Remove iommu_present()
To: Jason Gunthorpe <jgg@nvidia.com>
References: <20240930004235.69368-1-baolu.lu@linux.intel.com>
 <20241001175458.GH1365916@nvidia.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20241001175458.GH1365916@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/10/2 1:54, Jason Gunthorpe wrote:
> On Mon, Sep 30, 2024 at 08:42:35AM +0800, Lu Baolu wrote:
>> The last callsite of iommu_present() is removed by commit <45c690aea8ee>
>> ("drm/tegra: Use iommu_paging_domain_alloc()"). Remove it to avoid dead
>> code.
>>
>> Fixes: 45c690aea8ee ("drm/tegra: Use iommu_paging_domain_alloc()")
>> Signed-off-by: Lu Baolu<baolu.lu@linux.intel.com>
>> Reviewed-by: Jason Gunthorpe<jgg@nvidia.com>
>> ---
>>   include/linux/iommu.h |  6 ------
>>   drivers/iommu/iommu.c | 25 -------------------------
>>   2 files changed, 31 deletions(-)
> Also think the fixes should be removed

Okay. I will send a v2 with the fixes tag removed.

Thanks,
baolu


