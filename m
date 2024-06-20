Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757DA18E
	for <iommu@lists.linux.dev>; Thu, 20 Jun 2024 00:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718844764; cv=none; b=TGNDco6rcGLogL996V1Fy4MKduVr77HAC7QW35jDPspZ5ky++BNHw5LP2ZjqE/ovVz1BTLqkfBI5Poh1/S7EEDEoAzAbgWEZP8gBFsnWFe/1M7HSvWlv5MkRNkonZDXvc6OC2rKV6BNWTk2c7mrR5CaBDQOZM5/BlnQNxoi0SxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718844764; c=relaxed/simple;
	bh=pzgNgLM/C6RQs73syGGvhEqDNO15KvwDaj1OvQas57Q=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=tDv9UUK8zFjjGpyHdw9DqQjO3LWnspDpEVtABAgoJK1vRqXbWhXoV3AGfrnUAUg6aahyvJN35O4fmYx3dVcpM/VaVaa7KpdOclLA4HM7fbt1BZ8jH2I5O+9WgVUuxkPBW7irXS0B+Kd/RKQM+ehvlgZXTfFTKmBvdMBoaa/Mxnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bZYfUMsR; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bZYfUMsR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718844763; x=1750380763;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=pzgNgLM/C6RQs73syGGvhEqDNO15KvwDaj1OvQas57Q=;
  b=bZYfUMsRTWKObKCQmTtxgDavVd1E+9plcj5+qxxSMmtPgB4UhNNteyaj
   G0Ic+YTuLOCeo0Lifzmg7WU68OoQBS9HtGf+OTk+PDrbHz/o/hBLSpqOh
   9nLP+CZ2fnCSqX7FdFf+58/RW+KD/RmUUoD2DumfKOeWFBnMQeZnYAIgN
   NAZKuM39dtgdXQeEjwE4sx2/OTeLF0ef+iBWm67DGD7L6Iv+WVTZZhxdp
   Ip0u4b6T7EO1KgaS5y3jtqXEtp3FgPBUehKCivOqHKxcf03ZCEiu2WlKk
   3uYnuzcyo5jR0HMcE9HhUKNe3wogtUJDRfYoPkYHY1GZdo+P+SMpfZXkY
   A==;
X-CSE-ConnectionGUID: SUzQT3qxRXKWL6z0uOrR8A==
X-CSE-MsgGUID: x13VE5QJRHqGMDRoXoX/4w==
X-IronPort-AV: E=McAfee;i="6700,10204,11108"; a="18714550"
X-IronPort-AV: E=Sophos;i="6.08,251,1712646000"; 
   d="scan'208";a="18714550"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2024 17:52:42 -0700
X-CSE-ConnectionGUID: Kk9bPp+oRj2Psr0oJCpCDQ==
X-CSE-MsgGUID: 5Qxc66WDSqWlrKLFdQhvPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,251,1712646000"; 
   d="scan'208";a="46984799"
Received: from unknown (HELO [10.239.159.127]) ([10.239.159.127])
  by orviesa003.jf.intel.com with ESMTP; 19 Jun 2024 17:52:40 -0700
Message-ID: <1dfb467d-f25a-4270-8a36-a048f061e2aa@linux.intel.com>
Date: Thu, 20 Jun 2024 08:50:13 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Kevin Tian <kevin.tian@intel.com>,
 Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] iommu/vt-d: Fix missed device TLB cache tag
To: Jason Gunthorpe <jgg@ziepe.ca>
References: <20240619015345.182773-1-baolu.lu@linux.intel.com>
 <20240619164620.GN791043@ziepe.ca>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20240619164620.GN791043@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/20/24 12:46 AM, Jason Gunthorpe wrote:
> On Wed, Jun 19, 2024 at 09:53:45AM +0800, Lu Baolu wrote:
>> When a domain is attached to a device, the required cache tags are
>> assigned to the domain so that the related caches could be flushed
>> whenever it is needed. The device TLB cache tag is created selectively
>> by checking the ats_enabled field of the device's iommu data. This
>> creates an ordered dependency between attach and ATS enabling paths.
>>
>> The device TLB cache tag will not be created if device's ATS is enabled
>> after the domain attachment. This causes some devices, for example
>> intel_vpu, to malfunction.
> What? How is this even possible?
> 
> ATS is controlled exclusively by the iommu driver, how can it be
> changed without the driver knowing??

Yes. ATS is currently controlled exclusively by the iommu driver. The
intel iommu driver enables PCI/ATS on the probe path after the default
domain is attached. That means when the default domain is attached to
the device, the ats_supported is set, but ats_enabled is cleared. So the
cache tag for the device TLB won't be created.

A possible solution is to move ATS enabling to a place before the
default domain attachment. However, this is not future-proof,
considering that we will eventually hand over the ATS control to the
device drivers. Therefore, this fix creates the device TLB cache tags as
long as ats_supported is true and relies on ats_enabled to decide
whether device TLB needs to be invalidated.

Best regards,
baolu
