Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018001836D9
	for <iommu@lists.linux.dev>; Wed, 15 Jan 2025 05:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736918647; cv=none; b=KjM501liQL0dMqPZTAj3J+ohikgF+QMLuF9AtFVUBuOOxX32Poxmux+SZqalckOEefdVHa2LMOoMyiHOf98Epr1G4KZf1GhIXH9O4tgxxVNW8nVyYk/D+pYx9y6T+tKWoguM4PWn9PTyQ00uyKeKucYcPECZqiACDmWYvul+jxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736918647; c=relaxed/simple;
	bh=nvFxh9nXTRHxo+39A43cmn8TdIU1tgMQmbidBlOxBI4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lvlxG9RObIRDoFafLbh3LP3unA4UQqQS/mX2F+lafDGZ8x22Bie2laqu+ZWWKAYjM+8f6QR96KgNDYnYHRE3KXqCS297UiyARrQxfZzQlXLVVpqNrbsKbceUKVcIwIuGF0VvQcfZdRRSCDo1MJb61r9xNUy9XlhBIlPhyEKodgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=czU1Dixi; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="czU1Dixi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736918646; x=1768454646;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=nvFxh9nXTRHxo+39A43cmn8TdIU1tgMQmbidBlOxBI4=;
  b=czU1Dixi9vR5r78bNWChDq4QxNLDD9mHZApVPsLqaLqGKkRmSr+dtxwC
   piNycDli304fkyPMS+EfMa2soIwePFkHC5B3Oj8sJLTI3coVu7rhU7t3q
   OMrAtEHJHeBrntXR5uG+JP1GVIGWY5UJwn7UGS0GIvTtZwPKW21+OqDJJ
   N48zisjPGgw3kMRM23iV5Wz16nHWYHvhGNUPF2nbcTVbPcCkK+FC72QKk
   qS3+h/mLNczIKNSGFwSFgutvvgYd+2PujOmy5UvdTxzdCYJlYaf9l8n82
   E5Cu+LsI4ufOtiLCRpLcif+lBarBxdsSmDTADRdsbDDJnY0WDT9ixkp9x
   g==;
X-CSE-ConnectionGUID: pbeyzL2mT2KvfEn8MMJJdQ==
X-CSE-MsgGUID: ac/MpUiZQh6b6DMiGRYuzA==
X-IronPort-AV: E=McAfee;i="6700,10204,11315"; a="36518478"
X-IronPort-AV: E=Sophos;i="6.12,316,1728975600"; 
   d="scan'208";a="36518478"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2025 21:24:06 -0800
X-CSE-ConnectionGUID: KQtTZr+dSVqKuaihwacDIw==
X-CSE-MsgGUID: EB0ZSl4HQjKwZE8vDZCMYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="109085612"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2025 21:24:04 -0800
Message-ID: <5f3c5386-c131-48eb-8328-555a3407b6a7@linux.intel.com>
Date: Wed, 15 Jan 2025 13:21:51 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rc 1/2] iommufd/fault: Destroy response and mutex in
 iommufd_fault_destroy()
To: Nicolin Chen <nicolinc@nvidia.com>, jgg@nvidia.com, kevin.tian@intel.com
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org, joro@8bytes.org,
 will@kernel.org, robin.murphy@arm.com
References: <cover.1736894696.git.nicolinc@nvidia.com>
 <5e78ecaa3f731c782785de7b1aa5cc535f3cb0a1.1736894696.git.nicolinc@nvidia.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <5e78ecaa3f731c782785de7b1aa5cc535f3cb0a1.1736894696.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/15/25 07:28, Nicolin Chen wrote:
> Both were missing in the initial patch.
> 
> Fixes: 07838f7fd529 ("iommufd: Add iommufd fault object")
> Cc:stable@vger.kernel.org
> Signed-off-by: Nicolin Chen<nicolinc@nvidia.com>
> ---
>   drivers/iommu/iommufd/fault.c | 8 ++++++++
>   1 file changed, 8 insertions(+)

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
