Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58AE1202F70
	for <iommu@lists.linux.dev>; Tue, 16 Sep 2025 04:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757998721; cv=none; b=OHZ4WJigadpbnTrLgFvObNpBdR6UnnrDCxCX/bdQDQVuk1jARN1R7ZkuOzTWGjf3id1e9LJGXkjJ7riJ0V0xyyrKCqU8mzFthh0XjyORbnPnnt3teQ2sQFKkttG1p9j0TX7W9+8yh1CjEKEcTrvVvHS218I1ouHj6OdhDneYFL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757998721; c=relaxed/simple;
	bh=mLkW+UHC/cNrrlNRgkQdIRjdrZqLNM29lG0v4DTH+IQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qi5wH866IUp3/JajNpBuLukOwX9yp1mQdfOyt0XLzb62JiJ9/NfWL9T27aphZswVtFsFdGaFMUrpwJ5gI924bRU5HwgKNqFQd2WsoJWXwnme5Q647QJqgike+KNHK3RG4IknVXRZbnHmQ4oSpfMEEb4mRp8jlrwtpAnux3eCy6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L9RCkOcU; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L9RCkOcU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757998720; x=1789534720;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=mLkW+UHC/cNrrlNRgkQdIRjdrZqLNM29lG0v4DTH+IQ=;
  b=L9RCkOcU5A/QI/smiu60XNTDdp4KCHcSKfo7ijB3FbYyknWsZCzTTd/W
   fc4du3HbmlWUoOV7OO3dwWyg93ZADPUrihQyd793tYbZr79mOkQRBHSZE
   LxaIAbEmRhrr72QBeeYPYoh7+a8LOTKgQFwWTE60f/cruSFeysxXkU0Vp
   XDUKazSD5LywbuHgRxLRcWAWZOg+MiGBxY6Wqpi9ViJRCdSy9g6Bk+x7j
   1qgr9/oLk/vMIp6NWnPR2kcwJ5bouqrVA1+3lp3A4YOSeSzKBec5vgQZG
   eawkBgOw/BYZSKF8tmlpo5zd14MmlGFbaqBQET86y2/dBH9L0vwLv68g7
   w==;
X-CSE-ConnectionGUID: 5W6lAXIwQsaee8Nl1V3psQ==
X-CSE-MsgGUID: xiTbtMV0S/2gu8EFRH5jjw==
X-IronPort-AV: E=McAfee;i="6800,10657,11554"; a="59489852"
X-IronPort-AV: E=Sophos;i="6.18,268,1751266800"; 
   d="scan'208";a="59489852"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2025 21:58:40 -0700
X-CSE-ConnectionGUID: x0hWP9bdRIK1qULDo7Yq2w==
X-CSE-MsgGUID: GVmznKMQSuuc9TlRwIvHTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,268,1751266800"; 
   d="scan'208";a="174382759"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2025 21:58:37 -0700
Message-ID: <7a1c334d-4fc5-49c5-9e67-b220ea073f81@linux.intel.com>
Date: Tue, 16 Sep 2025 12:55:48 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] iommu/vt-d: Remove LPIG from page group response
 descriptor
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>,
 Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20250901053943.1708490-1-baolu.lu@linux.intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20250901053943.1708490-1-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/1/25 13:39, Lu Baolu wrote:
> Bit 66 in the page group response descriptor used to be the LPIG (Last
> Page in Group), but it was marked as Reserved since Specification 4.0.
> Remove programming on this bit to make it consistent with the latest
> specification.
> 
> Existing hardware all treats bit 66 of the page group response descriptor
> as "ignored", therefore this change doesn't break any existing hardware.
> 
> Signed-off-by: Lu Baolu<baolu.lu@linux.intel.com>
> ---
>   drivers/iommu/intel/iommu.h | 1 -
>   drivers/iommu/intel/prq.c   | 7 ++-----
>   2 files changed, 2 insertions(+), 6 deletions(-)

Queued for v6.18.
