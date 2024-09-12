Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24DAC2629D
	for <iommu@lists.linux.dev>; Thu, 12 Sep 2024 04:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726114904; cv=none; b=i9pRsDJGZOR7WdUzUqBIAgLwyFwttAPzmfNCmsBmSWVSpXtMBzE47zh8NUcb2cRufarLHpnrDR8Z7ih2gPnhTQ86FWvPKqQKa39XDltUhkZf9RpxNBmrNk2efXH5JPB2DpZKD+NQ+tOiVFwxex9AGDrd0K4xbqWj3V6idd1uPsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726114904; c=relaxed/simple;
	bh=LOwOrrEd5V9kC4PV9dh2XF1Ia+QPcKZnVrhHbMhSQzU=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Wy8kvqMgMEKJ8yapGfz6jK7svdnAg+zZP2ViE58CIUeG1okcmdl/LZ14za5PNATnBZnryOVeCO/0EadfVaQANmBHBfS2i1e4VixFatkRBwIzEcCbUJ58vb10Ydf5mMlOhb9VCxf2wlEVF0EQonBTerGh3Q79lgE4Guk6KIJ0VRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=enxgjC3F; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="enxgjC3F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726114903; x=1757650903;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=LOwOrrEd5V9kC4PV9dh2XF1Ia+QPcKZnVrhHbMhSQzU=;
  b=enxgjC3FUPh1+2jtT+k67SQRCGNVeOUK9XTP33I9KKUT1wrFE/f1RvB1
   +3zQUJhP4znE/CBHOEyCSKe8mPvBlVNfAaguXpz70C2MPxYMKOzEYYit9
   9Hv5acDJakrk7ZPVL5Qusg+Dyn5alPRyjmWnUBZp3KQlw5WNuuhlKYdB+
   Yd2Md/gmF9dOJANfblCsyS6QFeGSnrV3Sbth+9oa6zTbfWjvOD7SDRZeA
   /2FLvpur8NUIMUfGaSdsTGV8E4wNmhi3xAmiQXKN+zOxRCMQswx4nd0CO
   dmo3SeZrXBf/2zBsYaRdeuVkK8rTqv/WfDdWCGNhMaBHFfn22jcy+BYag
   w==;
X-CSE-ConnectionGUID: GKFBMasCQ0CjyS8hHTRk3w==
X-CSE-MsgGUID: 4H5ighC2TweVQOa6oBbvIA==
X-IronPort-AV: E=McAfee;i="6700,10204,11192"; a="28682534"
X-IronPort-AV: E=Sophos;i="6.10,221,1719903600"; 
   d="scan'208";a="28682534"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2024 21:21:42 -0700
X-CSE-ConnectionGUID: JZMo6NzPRKmkUWViTvaLIQ==
X-CSE-MsgGUID: G9pzfVkaT1iqS0zn6JR7eA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,221,1719903600"; 
   d="scan'208";a="67510649"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by orviesa009.jf.intel.com with ESMTP; 11 Sep 2024 21:21:40 -0700
Message-ID: <f4ea2a66-49ac-41ae-94c4-2832f08303f1@linux.intel.com>
Date: Thu, 12 Sep 2024 12:17:35 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, David Woodhouse <dwmw2@infradead.org>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Kevin Tian <kevin.tian@intel.com>, Klaus Jensen <its@irrelevant.dk>,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Subject: Re: [PATCH 5/6] iommu: init pasid array while doing domain_replace
 and iopf is active
To: Joel Granados <j.granados@samsung.com>
References: <20240904-jag-iopfv8-v1-0-e3549920adf3@samsung.com>
 <20240904-jag-iopfv8-v1-5-e3549920adf3@samsung.com>
 <CGME20240905033408eucas1p2ad508d4f3377f4daa38f28bf6c3d1118@eucas1p2.samsung.com>
 <c2e765a8-d935-42db-bd22-c12e7960f2f0@linux.intel.com>
 <20240911095544.4ad3u6jxgsdsymhj@joelS2.panther.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20240911095544.4ad3u6jxgsdsymhj@joelS2.panther.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/11/24 5:55 PM, Joel Granados wrote:
> On Thu, Sep 05, 2024 at 11:30:05AM +0800, Baolu Lu wrote:
>> On 9/4/24 9:17 PM, Joel Granados via B4 Relay wrote:
>>> From: Joel Granados<j.granados@samsung.com>
>>>
>>> iommu_report_device_fault expects a pasid array to have an
>>> iommu_attach_handle when a fault is detected.
>> The iommu_attach_handle is expected only when an iopf-capable domain is
>> attached to the device or PASID. The iommu_report_device_fault() treats
>> it as a fault when a fault occurs, but no iopf-capable domain is
>> attached.
> I don't follow. The way that I read it: if the pasid_array x-array does
> not have an iommu_attach_handle indexed by either fault->prm.pasid or
> IOMMU_NO_PASID, it will follow the err_bad_iopf and return -EINVAL
> (please correct me if I'm wrong). So the iommu_attach_handle is*always*
> expected.
> 
> Would it be more clear for it to be:
> """
> The iommu_report_device_fault function expects the pasid_array x-array
> to have an iommu_attach_handle indexed by a PASID. Add one indexed with
> IOMMU_NO_PASID when the replacing HWPT has a valid iommufd fault object.
> Remove it when we release ownership of the group.

Can you please explain why iommu core needs to remove the attach handle
when the ownership of the group is changed?

Thanks,
baolu
