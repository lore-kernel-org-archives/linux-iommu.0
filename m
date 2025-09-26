Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8808D17996
	for <iommu@lists.linux.dev>; Fri, 26 Sep 2025 02:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758854726; cv=none; b=XoYGYcSSJEJDbCQaganwZh6/Fegi3CVNAhaNGkFs1gUxkHeTXgG2Ps9JFzYgRC+qiZcOqwFFH97sQA1O++YKEN3DOIo2vBi6rgIGBjHnlARKvVDmDC7RFI2hBJhEPvrTuEWeghhGB/rRehhDZKnx2QAwL+fwzRgbYyc6/aVPgF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758854726; c=relaxed/simple;
	bh=e1R+YiitagScegsoBIEClZJRlcP+TCKSKZtIsn+7rto=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jbn6K6O/OXPUvxwE6t60zRtiU1iWS8RIGlodYtazWJVtc9/2Jhf6nbAPLz5Py1KqJEtzCxQvmabISD9r+o3yBGwXQOxcnTkI/zdJQRpeLaCpAJ3KHMb4lCDb9+P/xsA3Ttqjgwk7tOsUIw66Bz6QNwH+FnrNFvtj3MOXqGJZStQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HqOiLKr3; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HqOiLKr3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758854725; x=1790390725;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=e1R+YiitagScegsoBIEClZJRlcP+TCKSKZtIsn+7rto=;
  b=HqOiLKr31VLhSDGvkrqUPfPL13u3laDHHww5552q8TN5uREvQvgMQnYz
   BO8zlKsBYwZw3Q30cH+232ny63znf2tSWqn4pDkmLLEpEERilgxj8ll9M
   twx+VMtSqxEJDwMX8w3kzybEXwUO5ZvWNfyz1c9xKid0SkNWpGUqikBwO
   GyqagSZdk1xT/Vwt3QvAU8GGpBhwc4/0smx0oRZ4snrA7hbKmYjzah2Sd
   ipCIj7PG0FDwCSQzM1FtTucBW4dd1UtD+T/Z7ZpaKA/Cq3uQ3uf2Zyfd+
   GVy/xFSCS6sqCwzgZLh4jMTWTJqUfhHzRJ0ZK2aMlBwm9ucCaeejus2/B
   A==;
X-CSE-ConnectionGUID: QSKpdSBnTwKDJM1u/iFlow==
X-CSE-MsgGUID: v7rTjkKWRGa1WjGUNSMjMA==
X-IronPort-AV: E=McAfee;i="6800,10657,11564"; a="61354414"
X-IronPort-AV: E=Sophos;i="6.18,293,1751266800"; 
   d="scan'208";a="61354414"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2025 19:45:25 -0700
X-CSE-ConnectionGUID: +h60nvdtRYenIeOI6RfHMQ==
X-CSE-MsgGUID: wNHod1CbQt2uCm0KyIkekw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,293,1751266800"; 
   d="scan'208";a="177948941"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2025 19:45:22 -0700
Message-ID: <485b2ba8-273d-494b-a778-c5dd7fd0631b@linux.intel.com>
Date: Fri, 26 Sep 2025 10:42:16 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] iommu/vt-d: Disallow dirty tracking if incoherent
 page walk
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>,
 Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20250924083447.123224-1-baolu.lu@linux.intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20250924083447.123224-1-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/24/25 16:34, Lu Baolu wrote:
> Dirty page tracking relies on the IOMMU atomically updating the dirty bit
> in the paging-structure entry. For this operation to succeed, the paging-
> structure memory must be coherent between the IOMMU and the CPU. In
> another word, if the iommu page walk is incoherent, dirty page tracking
> doesn't work.
> 
> The Intel VT-d specification, Section 3.10 "Snoop Behavior" states:
> 
> "Remapping hardware encountering the need to atomically update A/EA/D bits
>   in a paging-structure entry that is not snooped will result in a non-
>   recoverable fault."
> 
> To prevent an IOMMU from being incorrectly configured for dirty page
> tracking when it is operating in an incoherent mode, mark SSADS as
> supported only when both ecap_slads and ecap_smpwc are supported.
> 
> Signed-off-by: Lu Baolu<baolu.lu@linux.intel.com>
> ---
>   drivers/iommu/intel/iommu.h | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)

Queued for v6.18-rc1.
