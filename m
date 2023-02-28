Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3960F636
	for <iommu@lists.linux.dev>; Tue, 28 Feb 2023 01:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677549570; x=1709085570;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=tM9zExhdsZkMDzEMOeD9THty+rKAp+OwuxntkkK6SV4=;
  b=dfz5czKc0uhe1GVPQ0dpeb5CnHiOoq0+X7MsLJX3DEga97knl13ZZ5jl
   n2gXqDx9GzuBFgk4UhwfCUk7d1F6rgNIJrbYXfQn0AOX+S3VGrVcYJiX+
   tcAcOb+L5fpC52yMgI1J0Or49DmwUt3dtXs+DblXE/4QdBlI8ClWTNBXs
   zGy+L9DY5vhRmaLbUxw742DOtPVIibaAQHE8c0grE9z8Rh9bBMv8iYTtR
   sfSW7GUdrmlXNQ4CTlbLJeiHZfRQChJaRLFNadA7zdkG6jw3uD8BfxQIx
   hjjwIgx4opcxdyUoJlS9L6EXuL9rwv5hJOH+zIrFd3sGle4/DutSrVBTH
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10634"; a="361583334"
X-IronPort-AV: E=Sophos;i="5.98,220,1673942400"; 
   d="scan'208";a="361583334"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2023 17:59:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10634"; a="762982545"
X-IronPort-AV: E=Sophos;i="5.98,220,1673942400"; 
   d="scan'208";a="762982545"
Received: from allen-box.sh.intel.com (HELO [10.239.159.48]) ([10.239.159.48])
  by FMSMGA003.fm.intel.com with ESMTP; 27 Feb 2023 17:59:27 -0800
Message-ID: <adfd78d1-006e-5e7c-236b-cc00e8afb8c0@linux.intel.com>
Date: Tue, 28 Feb 2023 09:50:52 +0800
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
 <cdbc3707-d326-26d4-3adc-ff2ed80aa2ba@linux.intel.com>
 <Y/y3A4LJqunT0ZwS@nvidia.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <Y/y3A4LJqunT0ZwS@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/27/23 9:58 PM, Jason Gunthorpe wrote:
> On Sun, Feb 26, 2023 at 11:01:59AM +0800, Baolu Lu wrote:
>> On 2/25/23 8:27 AM, Jason Gunthorpe wrote:
>>> @@ -437,25 +517,77 @@ int iommufd_device_attach(struct iommufd_device *idev, u32 *pt_id)
>>>    		struct iommufd_ioas *ioas =
>>>    			container_of(pt_obj, struct iommufd_ioas, obj);
>>> -		rc = iommufd_device_auto_get_domain(idev, ioas, pt_id);
>>> -		if (rc)
>>> +		destroy_hwpt = iommufd_device_auto_get_domain(idev, ioas, pt_id,
>>> +							      do_attach);
>>> +		if (IS_ERR(destroy_hwpt))
>>>    			goto out_put_pt_obj;
>>>    		break;
>>>    	}
>>>    	default:
>>> -		rc = -EINVAL;
>>> +		destroy_hwpt = ERR_PTR(-EINVAL);
>>>    		goto out_put_pt_obj;
>>>    	}
>>> +	iommufd_put_object(pt_obj);
>>> -	refcount_inc(&idev->obj.users);
>>> -	rc = 0;
>>> +	/* This destruction has to be after we unlock everything */
>>> +	if (destroy_hwpt)
>> Should this be
>>
>> 	if (!IS_ERR_OR_NULL(destroy_hwpt))
>>
>> ?
> Never use IS_ERR_OR_NULL ..

Can you please elaborate a bit on this? I can still see a lot of use of
it in the tree.

> 
> What am I missing? all the flows that could possibly have err_ptr here
> do goto_out_put_pt_obj ?

Oh yes! You are right. All err_ptr's have gone to an error handling
path.

Best regards,
baolu
