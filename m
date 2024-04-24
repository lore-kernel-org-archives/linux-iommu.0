Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CEB715B102
	for <iommu@lists.linux.dev>; Wed, 24 Apr 2024 12:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713961767; cv=none; b=b3bBOKy6WNsnwyfJIYd8mpAyJu4exkYnU9b+qif931v/5ORU7ztt1cavy8ysHRUNY7We5TR42jVjGRqoerIMFrffjeiWVarYc46nEbK7UCDQl6m6PjhEYHGXGV4FOwc7wWP2Q4HB7ez2C1RyYOcu3kTzf4ljGj0RDxwsIk89VY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713961767; c=relaxed/simple;
	bh=go/vozbHlYh54AKHVCbSDBA9gEnyWJgHRW3/Row1ThA=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Y+56Ae/CWBYv9VAyecXETU9CBkre2bTEDnf/08rC23x9uKi6Kx9YsWlHu+M8b0jIn4Vaz+m4tNH3y8b4wfrGK5vhQ95xvzgTDuqIK0MN7wb9fQSRVCQwwubPmiDt4YnXcw16sp8A5VrvK11i1xiu7X4Yo8Oz+Rz4979ZO6k8Iac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SlVDkqxm; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SlVDkqxm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713961766; x=1745497766;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=go/vozbHlYh54AKHVCbSDBA9gEnyWJgHRW3/Row1ThA=;
  b=SlVDkqxmTtJU6e0FB8n6y7ozn0FQglq2mjSaL8q7Z8wzuNZ8dT+qMolI
   ffvWdPraQy9tzJh30cVPScgNDfn10BxOPZx2G7hqtnXO0qAG959ecDUek
   hAevRBOeWNrAUj/U94ApFalhIz5pwV2LZX9VprOYcQ57pg8UWBB93uq8j
   YMXLfxaX2uAZqddV2b3YRPkUkzETT6p9J7RxfT4tu1MsUgTWpOzcGt/xs
   FngKcY56pplL7DZ2RQYHW8Gw4FoGMwsi2utm7VMWkteaMcKcMfvY2QK90
   g9uPDk/i7pXJ4aV9Ezuye/0nTOKafh/m4dQ8rftcFlHCcHOwX6WLtew58
   w==;
X-CSE-ConnectionGUID: WlJlwoz5SEit1qM8+TUkkw==
X-CSE-MsgGUID: btTpxpelQjSJyPku3xJEIg==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="20739087"
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; 
   d="scan'208";a="20739087"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 05:29:26 -0700
X-CSE-ConnectionGUID: 8TcAdR00SQq/46Eyi8q+gA==
X-CSE-MsgGUID: aKSvIcoTSv6Hc5y649PIhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; 
   d="scan'208";a="24733040"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.124.237.86]) ([10.124.237.86])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 05:29:22 -0700
Message-ID: <dd5da28d-1301-4e4a-856d-07fdb4a2b2d4@linux.intel.com>
Date: Wed, 24 Apr 2024 20:29:20 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Alex Williamson <alex.williamson@redhat.com>,
 "Liu, Yi L" <yi.l.liu@intel.com>, "joro@8bytes.org" <joro@8bytes.org>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "chao.p.peng@linux.intel.com" <chao.p.peng@linux.intel.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "Pan, Jacob jun" <jacob.jun.pan@intel.com>
Subject: Re: [PATCH v2 0/4] vfio-pci support pasid attach/detach
To: "Tian, Kevin" <kevin.tian@intel.com>, Jason Gunthorpe <jgg@nvidia.com>
References: <20240417122051.GN3637727@nvidia.com>
 <20240417170216.1db4334a.alex.williamson@redhat.com>
 <BN9PR11MB52765314C4E965D4CEADA2178C0E2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <4037d5f4-ae6b-4c17-97d8-e0f7812d5a6d@intel.com>
 <20240418143747.28b36750.alex.williamson@redhat.com>
 <BN9PR11MB5276819C9596480DB4C172228C0D2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20240419103550.71b6a616.alex.williamson@redhat.com>
 <BN9PR11MB52766862E17DF94F848575248C112@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20240423120139.GD194812@nvidia.com>
 <BN9PR11MB5276B3F627368E869ED828558C112@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20240424001221.GF941030@nvidia.com>
 <BN9PR11MB5276555B3294D5A0892043E98C102@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB5276555B3294D5A0892043E98C102@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/4/24 10:57, Tian, Kevin wrote:
>> From: Jason Gunthorpe <jgg@nvidia.com>
>> Sent: Wednesday, April 24, 2024 8:12 AM
>>
>> On Tue, Apr 23, 2024 at 11:47:50PM +0000, Tian, Kevin wrote:
>>>> From: Jason Gunthorpe <jgg@nvidia.com>
>>>> Sent: Tuesday, April 23, 2024 8:02 PM
>>>>
>>>> On Tue, Apr 23, 2024 at 07:43:27AM +0000, Tian, Kevin wrote:
>>>>> I'm not sure how userspace can fully handle this w/o certain assistance
>>>>> from the kernel.
>>>>>
>>>>> So I kind of agree that emulated PASID capability is probably the only
>>>>> contract which the kernel should provide:
>>>>>    - mapped 1:1 at the physical location, or
>>>>>    - constructed at an offset according to DVSEC, or
>>>>>    - constructed at an offset according to a look-up table
>>>>>
>>>>> The VMM always scans the vfio pci config space to expose vPASID.
>>>>>
>>>>> Then the remaining open is what VMM could do when a VF supports
>>>>> PASID but unfortunately it's not reported by vfio. W/o the capability
>>>>> of inspecting the PASID state of PF, probably the only feasible option
>>>>> is to maintain a look-up table in VMM itself and assumes the kernel
>>>>> always enables the PASID cap on PF.
>>>>
>>>> I'm still not sure I like doing this in the kernel - we need to do the
>>>> same sort of thing for ATS too, right?
>>>
>>> VF is allowed to implement ATS.
>>>
>>> PRI has the same problem as PASID.
>>
>> I'm surprised by this, I would have guessed ATS would be the device
>> global one, PRI not being per-VF seems problematic??? How do you
>> disable PRI generation to get a clean shutdown?
> 
> Here is what the PCIe spec says:
> 
>    For SR-IOV devices, a single Page Request Interface is permitted for
>    the PF and is shared between the PF and its associated VFs, in which
>    case the PF implements this capability and its VFs must not.
> 
> I'll let Baolu chime in for the potential impact to his PRI cleanup
> effort, e.g. whether disabling PRI generation is mandatory if the
> IOMMU side is already put in a mode auto-responding error to
> new PRI request instead of reporting to sw.

The PRI cleanup steps are defined like this:

  * - Disable new PRI reception: Turn off PRI generation in the IOMMU 
hardware
  *   and flush any hardware page request queues. This should be done before
  *   calling into this helper.
  * - Acknowledge all outstanding PRQs to the device: Respond to all 
outstanding
  *   page requests with IOMMU_PAGE_RESP_INVALID, indicating the device 
should
  *   not retry. This helper function handles this.
  * - Disable PRI on the device: After calling this helper, the caller could
  *   then disable PRI on the device.

Disabling PRI on the device is the last step and optional because the
IOMMU is required to support a PRI blocking state and has already been
put in that state at the first step.

For the VF case, it probably is a no-op except for maintaining a
reference count. Once PRI is disabled on all PFs and VFs, it can then be
physically disabled on the PF.

> 
> But I do see another problem for shared capabilities between PF/VFs.
> 
> Now those shared capabilities are enabled/disabled when the PF is
> attached to/detached from a domain, w/o counting the shared usage
> from VFs.
> 
> Looks we have a gap here.

Yes, there's a gap at least for the Intel IOMMU driver. I'll soon fix
this by moving the handling of ATS out of the driver, especially from
the default domain attach/detach paths.

Best regards,
baolu
