Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F6A636
	for <iommu@lists.linux.dev>; Tue, 28 Feb 2023 02:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677550758; x=1709086758;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=A8N9428Tcr7/tfdQWiJlI1cxLImMy9WDZy/+x8nbwRk=;
  b=LaJMbWHS52aGP5STVmq3JyoPwx/V3VSBs+XG+uxpCdl0+zNj1OPa8eNZ
   1m9Zg1omm7IWjnXP28HPFHGnsHYc4y/H94XaYT0lo+BeqwCfg/CrKJXlu
   RR3dEiutHFMqOI7XOrIUlz26KoY8M+NPLisZoQKwMW37+bz+Ca79va83u
   /GQc3Eah3FtNrmEDhX3fbVlALMGS7kXX/3WP5NIXCwa7B5eMYM2uxZQzm
   ErWjonSVQFXionMUWFFHcQhq0lWjF6GrHNZd1bMn6k/SC4PCTT/Nx/oO0
   J2WJXzstiU8vBUDEBG5/DXLF9NIsdTGQklp7DMNyEucqCKG0v8XI7HSE5
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10634"; a="336312331"
X-IronPort-AV: E=Sophos;i="5.98,220,1673942400"; 
   d="scan'208";a="336312331"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2023 18:19:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10634"; a="797889831"
X-IronPort-AV: E=Sophos;i="5.98,220,1673942400"; 
   d="scan'208";a="797889831"
Received: from allen-box.sh.intel.com (HELO [10.239.159.48]) ([10.239.159.48])
  by orsmga004.jf.intel.com with ESMTP; 27 Feb 2023 18:19:16 -0800
Message-ID: <322462b2-a3e2-31a3-d520-34fe1467b26e@linux.intel.com>
Date: Tue, 28 Feb 2023 10:10:41 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Cc: baolu.lu@linux.intel.com, iommu@lists.linux.dev,
 Kevin Tian <kevin.tian@intel.com>, linux-kselftest@vger.kernel.org,
 kvm@vger.kernel.org, Nicolin Chen <nicolinc@nvidia.com>,
 Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH 09/14] iommufd: Add iommufd_device_replace()
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>
References: <9-v1-7612f88c19f5+2f21-iommufd_alloc_jgg@nvidia.com>
 <909ee61a-9cbd-eda1-89a2-349348eeb735@linux.intel.com>
 <Y/y3fnSJZB7QhAKM@nvidia.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <Y/y3fnSJZB7QhAKM@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/27/23 10:00 PM, Jason Gunthorpe wrote:
> On Sun, Feb 26, 2023 at 11:13:16AM +0800, Baolu Lu wrote:
>> On 2/25/23 8:27 AM, Jason Gunthorpe wrote:
>>> +/**
>>> + * iommufd_device_attach - Connect a device to an iommu_domain
>>> + * @idev: device to attach
>>> + * @pt_id: Input a IOMMUFD_OBJ_IOAS, or IOMMUFD_OBJ_HW_PAGETABLE
>>> + *         Output the IOMMUFD_OBJ_HW_PAGETABLE ID
>>
>> "Output the hwpt ID" only happens when the caller input an IOAS object
>> and an auto domain was selected or created for the device.
>>
>> Do I understand it right?
> 
> Technically it always outputs the hwpt, if a hwpt is in put then the
> same hwpt is output.

 From the code point of view, the pt_id is set only when an auto domain
is selected. Otherwise, it is untouched. Hence, probably we could
describe it more accurately in the comments. That is, if auto domain is
selected, its hwpt id will be returned in pt_id and the caller could
return it to userspace.

> 
>>>    EXPORT_SYMBOL_NS_GPL(iommufd_device_attach, IOMMUFD);
>>> +/**
>>> + * iommufd_device_replace - Change the device's iommu_domain
>>> + * @idev: device to change
>>> + * @pt_id: Input a IOMMUFD_OBJ_IOAS, or IOMMUFD_OBJ_HW_PAGETABLE
>>> + *         Output the IOMMUFD_OBJ_HW_PAGETABLE ID
>>
>> If my above understanding is correct, then replace will never output a
>> hwpt id as it only happens after a successful attach.
> 
> Replace calls iommufd_device_auto_get_domain() which always sets pt_id
> on success?

Yes. replace also calls iommufd_device_auto_get_domain().

> 
> If a HWPT was passed in then it just leaves it unchanged which is also
> correct.

Functionally right. Above I just want to make the comment matches what
the real code does.

Best regards,
baolu
