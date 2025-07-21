Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719D21552E0
	for <iommu@lists.linux.dev>; Mon, 21 Jul 2025 01:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753063198; cv=none; b=eR4BBvlmywg7zTkKuOzZvs2LeKAvSpwar0p+ZSEUVRf00P8EyUhE9f/Aj5SvxkOTUHWD9Ckf7Lh4tBOEJzSpJPwyM9IlQnKVR7YgGLjXQSjuGi+pxfm/W8ylRQr3KAXkBY9z6bEWYBRUyQygwLeKoLUNE45XeK0FacQw0nENBms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753063198; c=relaxed/simple;
	bh=Tx8iuGI0EGhXnQPTDG2IckNxNu+e77dp+qofKYwYb/w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BJLoXirSdnafgrPnpmREOblaD9H3vQhdJ+9zD57YWvBkYisgR+5galy9aJ1aRzkdjcqsTJSLX3UJJ2K9z/DBvPHj200ObazHbfygCOjqxZhaMpOUHth/5vDC+xqs2ln+WvgLYi9/3MIw9kj1LblNUE964J5xte1VYJ3rAA+K5NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BJjRW/2G; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BJjRW/2G"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753063197; x=1784599197;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Tx8iuGI0EGhXnQPTDG2IckNxNu+e77dp+qofKYwYb/w=;
  b=BJjRW/2Ggs4246apuMiKutKf0YKeQrGaNf6/6W7VsqYmU8DL/wJz2G0q
   c35+NzQUkUPOgUou1TD8L0PMl8anTC6hhuwbckxIz+aIarV+GGo1htAtj
   CDvWMGjYgUvoSKU/f5dxG0T+PHzCpgYfnABZ84f2COgXJx+o8sS2QrHWO
   qUgP0/jQgPexCF0t7vppXGf8wZKGNqNvtnvk0qvHr4AVMpOg/VMjiw2Xu
   DX2ZxBYnNx/aPl9EQggTkRrqDH07uMErcNInYlNwNI7Qq2p8F7G9EbF1P
   ufFYwSrfCWddTL12z0BGbiehFhP6IWh3lLk0EBjAiZfMZsxyIB0BIxIfp
   Q==;
X-CSE-ConnectionGUID: Rj0xLmZAQCiqjDyX7dNDyA==
X-CSE-MsgGUID: mpLMLbNKQLGIKNH21TmN1w==
X-IronPort-AV: E=McAfee;i="6800,10657,11498"; a="54480016"
X-IronPort-AV: E=Sophos;i="6.16,328,1744095600"; 
   d="scan'208";a="54480016"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2025 18:59:56 -0700
X-CSE-ConnectionGUID: ZXFFNqvNQs+P229+0CECqw==
X-CSE-MsgGUID: 7qj5tw7JRX+rp0ocs9hkyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,328,1744095600"; 
   d="scan'208";a="189657239"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2025 18:59:55 -0700
Message-ID: <2867cd08-132b-40f9-bd19-707f9a78b2c7@linux.intel.com>
Date: Mon, 21 Jul 2025 09:57:55 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/11] iommu/vt-d: Optimize iotlb_sync_map for
 non-caching/non-RWBF modes
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Joerg Roedel <joro@8bytes.org>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20250714045028.958850-1-baolu.lu@linux.intel.com>
 <20250714045028.958850-3-baolu.lu@linux.intel.com>
 <20250716141218.GA2166806@nvidia.com>
 <8aedbbcc-9f4c-4700-acb7-43ec4f540135@linux.intel.com>
 <20250717115559.GD2177622@nvidia.com>
 <3ea54d65-7ccc-479a-8912-bccd79d678d4@linux.intel.com>
 <20250718132912.GC2250220@nvidia.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20250718132912.GC2250220@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/18/25 21:29, Jason Gunthorpe wrote:
> On Fri, Jul 18, 2025 at 10:56:24AM +0800, Baolu Lu wrote:
> 
>> How about the following changes (compiled but not tested)?
> Yes, exactly what I was thinking!

I will submit a formal patch.

> 
> That leaves the cache tag linked list race..
> 
> Nicolin is working on a neat solution for SMMU I wonder if we can
> reuse it here too..

Okay, let's wait and see.

Thanks,
baolu
