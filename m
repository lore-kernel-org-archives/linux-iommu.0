Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53541E493
	for <iommu@lists.linux.dev>; Fri, 18 Oct 2024 02:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729219091; cv=none; b=kWbVMW8oRauL0CDsazyegwOf1KK9kIOtMDNYbp7OHxDzo0lW5iOcUi9qAgt5NNyDFMLttKQjVtq4s5aH9ueo6hnHoIL6VdvXc+2yZ9IDXiJ+GoqRfsxWd+rRK/MwVCDS37HbvqU0xHoY/9ZfNPGzlMKvigYjXkJiDUGu4CSBQio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729219091; c=relaxed/simple;
	bh=ZQswLgbdbG7N0sBMXETXKQhEpJDXJFymX3XvXs28GNw=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=S0JvJcbk1uwfQHtTUFrhQXXyN1ia6c9730nSN7Rbhhl7vv6A7rDPNbp069b5HLcXOXbXvAZhn4CEg3AYEGIrc7mU5I69WDehMcrzmHCsmENMFAhYXh06mDhptQCMNzN+w8tS3rLE/1ILcLKXnX4q+Zvra61kAIudbHN9kr1BZDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dyrlV5Ee; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dyrlV5Ee"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729219090; x=1760755090;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ZQswLgbdbG7N0sBMXETXKQhEpJDXJFymX3XvXs28GNw=;
  b=dyrlV5EeYXcFURDOjFJU9tyFKTDkathJcPxK2krzHQkisE5QP0cvPvH3
   yZdKe3UwMGsgKC6yttXMap6mML5FhOn/aTpl0+Rxb07dKlhpP4mGRhIqi
   1dMObemClDNM8GWGNTF1ascRViIaPz2dmiYUjLTnqFH2jVjcr7zz6QTJx
   JXx80oo1otUuTcfNDhvnhblTV1TLc3giaJ5E30fVpwtQsU7PMMG7uCCi3
   U484gXCPlCuAieozVlE9qrlKcTdR+JGORgkGAdxYS06MncZFdgGkRpll3
   MvKZ33ml95QsE9UguyeG041eqyib+fyAfQYDAnZePLtHe6lFVCZ2Fkwev
   Q==;
X-CSE-ConnectionGUID: ZmIucx0fS+ORpicgSsPjQA==
X-CSE-MsgGUID: wasFzGjKRaidkNAZh19KfQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11228"; a="40137655"
X-IronPort-AV: E=Sophos;i="6.11,212,1725346800"; 
   d="scan'208";a="40137655"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 19:38:09 -0700
X-CSE-ConnectionGUID: N9mMYZCcQW+IJqwHDIaCqw==
X-CSE-MsgGUID: W/M0qxwVSMmHLQKOgCLPLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,212,1725346800"; 
   d="scan'208";a="78780012"
Received: from unknown (HELO [10.238.0.51]) ([10.238.0.51])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 19:38:07 -0700
Message-ID: <4b0f1d5d-778d-4161-92e4-8e2ad1c211e9@linux.intel.com>
Date: Fri, 18 Oct 2024 10:38:05 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, iommu@lists.linux.dev, joro@8bytes.org,
 will@kernel.org, robin.murphy@arm.com, suravee.suthikulpanit@amd.com
Subject: Re: [PATCH v3 06/10] iommu/amd: Reduce domain lock scope in attach
 device path
To: Jason Gunthorpe <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
References: <20241016053501.97497-1-vasant.hegde@amd.com>
 <20241016053501.97497-7-vasant.hegde@amd.com>
 <20241017133244.GP4020792@ziepe.ca>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20241017133244.GP4020792@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/10/17 21:32, Jason Gunthorpe wrote:
> On Wed, Oct 16, 2024 at 05:34:57AM +0000, Vasant Hegde wrote:
>> Currently attach device path takes protection domain lock followed by
>> dev_data lock. Most of the operations in this function is specific to
>> device data except pdom_attach_iommu() where it updates protection
>> domain structure. Hence reduce the scope of protection domain lock.
>>
>> Note that this changes the locking order. Now it takes device lock
>> before taking domain lock (group->mutex -> dev_data->lock ->
>> pdom->lock). dev_data->lock is used only in device attachment path.
>> So changing order is fine. It will not create any issue.
>>
>> Finally move numa node assignment to pdom_attach_iommu().
> numa node assignment should only be done during domain
> allocation. This is important because the domain can be mapped prior
> to being attached and without the right nid table levels will be mis
> allocated.

Sorry for off the topic, just a question about the domain numa ID.

When a domain is about to be attached to a device on a different numa
node, what should the iommu driver do? Should it:

- Ignore the difference (probably log an informational message);

or

- Return -EINVAL to force the upper layer to allocate a different domain
   for the device?

Thanks,
baolu
