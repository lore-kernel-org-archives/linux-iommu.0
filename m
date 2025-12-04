Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 174F5335540
	for <iommu@lists.linux.dev>; Thu,  4 Dec 2025 10:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764845625; cv=none; b=G0S7lrcCaghztRS6KKIkBFyriUqXSmccUV4Jj4uOE7uEP67u1DlT94auLOtCrauNilBjfaZdWKIXzdwSmSXr/VZIwMwxlp0Ei7tCvL4rz0ZcgfFisgvuwTITP5fbGATzDtkZSaBCoxIEGJkWR4Zt6Lb+Wd8iCILhtqBm6UYf+xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764845625; c=relaxed/simple;
	bh=pb4Y8Xy72P5CM97YkzT6uqcEO3QLex+UVWy5K1mkh/w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UVcY/nGPYKyU4rF3C6anFmSbX+HesUpo4aIuaVELzSAdw3is7eUbtCXs72qydQsX5x96oG81f0aFBYvHKMyec7csKVes/bMJtUDejiVb4rGq2IINQupCZMqeL+UQwWmRKTv0JXIqrPATzSs8rfbmdrwgW/iaHVdQ9lLb2cRx+Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0D6BA339;
	Thu,  4 Dec 2025 02:53:35 -0800 (PST)
Received: from [10.57.45.56] (unknown [10.57.45.56])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A9D523F59E;
	Thu,  4 Dec 2025 02:53:39 -0800 (PST)
Message-ID: <0f3dad6d-b320-4d6d-a0b2-8919f3fca5e3@arm.com>
Date: Thu, 4 Dec 2025 10:53:36 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 2/8] iommu: Add a helper to check if any iommu device is
 registered
To: Jacob Pan <jacob.pan@linux.microsoft.com>,
 Jason Gunthorpe <jgg@nvidia.com>
Cc: Baolu Lu <baolu.lu@linux.intel.com>, linux-kernel@vger.kernel.org,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 Alex Williamson <alex.williamson@redhat.com>, Joerg Roedel
 <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Nicolin Chen <nicolinc@nvidia.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "Liu, Yi L" <yi.l.liu@intel.com>, skhawaja@google.com,
 pasha.tatashin@soleen.com, Zhang Yu <zhangyu1@linux.microsoft.com>,
 Jean Philippe-Brucker <jean-philippe@linaro.org>,
 David Matlack <dmatlack@google.com>, Alex Williamson <alex@shazbot.org>
References: <20251201173012.18371-1-jacob.pan@linux.microsoft.com>
 <20251201173012.18371-3-jacob.pan@linux.microsoft.com>
 <f88707d4-bd04-4e9b-8d4b-ccb679d70dae@linux.intel.com>
 <20251202160635.0000433e@linux.microsoft.com>
 <20251203131129.GD1109247@nvidia.com>
 <20251203143609.00006b72@linux.microsoft.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20251203143609.00006b72@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-12-03 10:36 pm, Jacob Pan wrote:
> Hi Jason,
> 
> On Wed, 3 Dec 2025 09:11:29 -0400
> Jason Gunthorpe <jgg@nvidia.com> wrote:
> 
>> On Tue, Dec 02, 2025 at 04:06:35PM -0800, Jacob Pan wrote:
>>> However, as you pointed out there seems to be no standard ordering
>>> for iommu device registration across platforms. e.g. VT-d hooks up
>>> with x86_init, smmuv3 does that in platform driver probe. This
>>> patchset puts dummy driver under early_initcall which is after both
>>> but not a guarantee for all platforms. Any suggestions?
>>
>> I think we need to do something more like the sefltest does and
>> manually bind a driver to a device so this init time ordering
>> shouldn't matter.
> I have moved this dummy iommu driver init under iommufd_init(), which
> aligns well since it runs after all physical IOMMU drivers have
> registered. This dummy driver is intended for iommufd after all. But I
> don't see a need to bind to a platform device as the selttest does.

There is no "after all physical IOMMU drivers have registered", there is 
only "after we've given up waiting to see if one might be loaded as a 
module", but even that may be indefinite depending on build/runtime 
configuration.

Thanks,
Robin.
