Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25003200AE
	for <iommu@lists.linux.dev>; Wed, 28 Feb 2024 03:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709091363; cv=none; b=H6h3tXlrgwJRViRkuXPNSG4p+8oLFMQhsa3hu9gQTKSDFPcOZVy7khcjZ6WKzYjQU9No9yFQYD1fYGKchhiX0dKbYoNd2k1/GzDJDIjVgA8IhO0t/8EpJAsnEUVxJD4JP//DJExRA8EaxUtx8znehcLSX2XebcJD6rZAz8JHmTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709091363; c=relaxed/simple;
	bh=YCqVTPnQ/3+ioaGUkl85kz8Ob2hQzSVPb22/I3w19a8=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=CYWAqH3I5Nl47/HUgPEDTcD8GEk7kXegP2nSrEVzDnDEtZNWeGwRIcNlGrYsQAlg366G2VsIUwK02GdVOsk/FvsQFeAE22GyBFcSJiOhWnXotVQzUymAXevnbtACa0vzwBjUMImvgsxwi9CUaiDq8ZSlvJegw4tpFyEAU4bFUhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JQYOgxNK; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JQYOgxNK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709091362; x=1740627362;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=YCqVTPnQ/3+ioaGUkl85kz8Ob2hQzSVPb22/I3w19a8=;
  b=JQYOgxNKcAiT20EoWDrZbcjwsnKB2Lgn0EGZHJ8nR6FTBQWYev14v9u2
   /Io6tx+Z0J23R6P0E0vNEQIibyDCXs4pbCMixCtA6J39q90UvujdTip4M
   ZaKkc1Az9K/Kw7c98R1VGKMtdVrTh/A5WB1+uOHbRIXCf2NANwXlbwmb3
   MVJqwAlvfgKaF2js6JadiHvYqtWwuGAyZOz+ZBzDnqkTkz0gvDSDkPuIl
   KY5xtGC+cKPHVCZYsUkh18WHLXw40tl8XBi2n01Xf1SiDKE3k9DhfU6P7
   2XtfURcmLKHOp5a/8+4b0TFYuEBM0JkaooFuC5cbw2/04j6pQMO16Z0bZ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="25939900"
X-IronPort-AV: E=Sophos;i="6.06,189,1705392000"; 
   d="scan'208";a="25939900"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 19:36:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,189,1705392000"; 
   d="scan'208";a="7222544"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by fmviesa009.fm.intel.com with ESMTP; 27 Feb 2024 19:35:58 -0800
Message-ID: <599a72b7-3343-4862-93fe-c6985d20a784@linux.intel.com>
Date: Wed, 28 Feb 2024 11:30:02 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, "iommu@lists.linux.dev"
 <iommu@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH 1/2] iommu: Add static iommu_ops->release_domain
Content-Language: en-US
To: "Tian, Kevin" <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, "Badger, Eric" <ebadger@purestorage.com>
References: <20240223051302.177596-1-baolu.lu@linux.intel.com>
 <20240223051302.177596-2-baolu.lu@linux.intel.com>
 <BN9PR11MB52766C0E58E2CB6989E0EB608C592@BN9PR11MB5276.namprd11.prod.outlook.com>
 <c8bfc031-27a2-464e-b98e-47a7e6a05286@linux.intel.com>
 <BN9PR11MB52766698FA25EA5D397188878C582@BN9PR11MB5276.namprd11.prod.outlook.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB52766698FA25EA5D397188878C582@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/28/24 11:08 AM, Tian, Kevin wrote:
>> From: Baolu Lu <baolu.lu@linux.intel.com>
>> Sent: Wednesday, February 28, 2024 9:14 AM
>>
>> On 2/27/24 3:32 PM, Tian, Kevin wrote:
>>>> From: Lu Baolu<baolu.lu@linux.intel.com>
>>>> Sent: Friday, February 23, 2024 1:13 PM
>>>>
>>>>
>>>> +	/*
>>>> +	 * If the iommu driver provides release_domain then the core code
>>>> +	 * ensures that domain is attached prior to calling release_device.
>>>> +	 * Drivers can use this to enforce a translation on the idle iommu.
>>> 'enforce a translation' is confusing in the context of blocking/identity
>>> domain.
>>
>> Blocking or identity domain is also kind of a translation from the
>> core's perspective. The core does not care what type of translation the
>> release_domain is; it just enforces this type of translation before
>> device release if the driver has specified one.
>>
> 
> OK.
> 
> btw you may also want to update the following comment together:
> 
> 	/*
> 	 * release_device() must stop using any attached domain on the device.
> 	 * If there are still other devices in the group they are not effected
> 	 * by this callback.
> 	 *
> 	 * The IOMMU driver must set the device to either an identity or
> 	 * blocking translation and stop using any domain pointer, as it is
> 	 * going to be freed.
> 	 */
> 
> all the purpose is to set the device to identity or blocking, either via attaching
> to an explicit release_domain or implicitly by release_device().

Done.

Best regards,
baolu
