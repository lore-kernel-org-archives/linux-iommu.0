Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767214963E
	for <iommu@lists.linux.dev>; Mon, 24 Jun 2024 08:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719216690; cv=none; b=KM7kDwleNQjUOZXeEGlmRg479refEgwg8BPo/hmY+rlSutgMqoOKHsfNUmIPNgQsEda0PbNhAlpcPxjhn+gmhPQ5PaoBeGLcSpKRkaSqEjtceCxjhGoEZ/GTu/CH8VMXD9Fp6T3vihMJAVuuxfPNNATTw3AJCdtC8HH/qJnScJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719216690; c=relaxed/simple;
	bh=5/3o+1zuQSrtmWhv6M+q+yIZbsryQ+tIgRK0WSHB310=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Ef8qwKqtzXIoRL0Y/fladdApicmpNnb82c7UPhgPxN8A/3jOglrBMfVAY92BFN0ze2wg4rJY1hYUSIFNSLtGej5Hg6BsN0f3Fnt4bHo2EPFEjNdXGs87+ekRIzSCCy5mb4mcvGx50eg5ALcRWWzB/afbZn4ZvdZtwRMsnnBkYS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PggHGIEv; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PggHGIEv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719216689; x=1750752689;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=5/3o+1zuQSrtmWhv6M+q+yIZbsryQ+tIgRK0WSHB310=;
  b=PggHGIEvb3Z53F6uvSIXk8n2OqUD2wdTBlhQS4NdggutEabeolW8jny/
   3nT0IlzpVI0zGAZRS+c8OzD+TatvAPcmaz4iNLgrDUFcj21cfPKmK9cyP
   xtcLyVHoOyMw1UFG+QWY7JxO7kwCQeILG990gex46Mr2kqDWG17bdcBAL
   8Oxb3TXBFdn/wG3dcYaau+eEMTfGybxdsCN95viuSfxkb6ZkM4193ofZ8
   XX0+gHoMgVrZ6hDbS+Crw5+dCUnqeJq+0FuZg8idu5MNjgPRIiC/D5Krc
   Y9AGSsy5yk4Rjmb/19rPZCwg0lVMdbXjcknTd8FOAM2g2hTWlchaio30/
   Q==;
X-CSE-ConnectionGUID: XnJioE1nTt+S7bpk9DjpXA==
X-CSE-MsgGUID: stgiIH5hRF64+RKP1cjqKg==
X-IronPort-AV: E=McAfee;i="6700,10204,11112"; a="20056092"
X-IronPort-AV: E=Sophos;i="6.08,261,1712646000"; 
   d="scan'208";a="20056092"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2024 01:11:29 -0700
X-CSE-ConnectionGUID: ygUZ6XyEQ2ioYfMvalHL2w==
X-CSE-MsgGUID: TRjDnuJtQTKqQzi2uNhiow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,261,1712646000"; 
   d="scan'208";a="47752570"
Received: from unknown (HELO [10.124.237.100]) ([10.124.237.100])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2024 01:11:26 -0700
Message-ID: <ba6b6baf-6fe7-4238-91ee-262ac006c25f@linux.intel.com>
Date: Mon, 24 Jun 2024 16:11:24 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iommu/vt-d: Remove hardware automatic ATS dependency
To: Yi Liu <yi.l.liu@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Kevin Tian <kevin.tian@intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>
References: <20240624052501.253405-1-baolu.lu@linux.intel.com>
 <20240624052501.253405-2-baolu.lu@linux.intel.com>
 <15590835-ed6a-44a5-94b5-663f159653cc@intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <15590835-ed6a-44a5-94b5-663f159653cc@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/6/24 16:06, Yi Liu wrote:
> On 2024/6/24 13:25, Lu Baolu wrote:
>> If a device is listed in the SATC table with ATC_REQUIRED flag set, it
>> indicates that the device has a functional requirement to enable its ATC
>> (via the ATS capability) for device operation. However, when IOMMU is
>> running in the legacy mode, ATS could be automatically supported by the
>> hardware so that the OS has no need to support the ATS functionality.
> 
> It seems like if VT-d hw is operating in legacy mode, ATS is enabled
> automatically? 

Yes.

> This is really suprising. Maybe I got it wrongly. Could you
> elaborate a bit?

It's for backward compatible purpose, but I have no hardware details.

Best regards,
baolu
