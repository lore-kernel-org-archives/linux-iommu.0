Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66EC015A8;
	Fri, 31 Mar 2023 02:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680229291; x=1711765291;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=orr6xqCdjVUNwW1o1J9QySot3FwRNobGMrB1NVthcEw=;
  b=BTU6kxFYX9xiUbO40E1W0WHWEJPm4462ByWbzFLiLZm3MKHdVcaNeChQ
   AykAntuRZ+urbUbS44IAUS94VyhJPt/sGzo1KDXkr2l6rm39BfFKdL/Dv
   71Q942D/6b/eIGsJjwd8h1BuigXvGSzTifTw1aMnaNoLvX9eQ24uoFu73
   CU2RC87dhszSQdvCrHb4blk+mCPcIxdtxx/0YgEhtKN0N3g0OG7ShUlBX
   exJF7rGRei3YXE22uGbsgKAlAXP44NBXMPXqoB2mqu7zzfFqxTkzX/xmU
   fyaOz96kHCz+aC+978FUjstN1kivlL7xbe+fBG0X4/ag4UbXqNkdDIgcc
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10665"; a="325293552"
X-IronPort-AV: E=Sophos;i="5.98,306,1673942400"; 
   d="scan'208";a="325293552"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2023 19:21:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10665"; a="795925958"
X-IronPort-AV: E=Sophos;i="5.98,306,1673942400"; 
   d="scan'208";a="795925958"
Received: from allen-box.sh.intel.com (HELO [10.239.159.48]) ([10.239.159.48])
  by fmsmga002.fm.intel.com with ESMTP; 30 Mar 2023 19:21:27 -0700
Message-ID: <496c9a7f-41ea-1f06-e8ce-437854916f3b@linux.intel.com>
Date: Fri, 31 Mar 2023 10:21:42 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Cc: baolu.lu@linux.intel.com, iommu@lists.linux.dev,
 Joerg Roedel <joro@8bytes.org>, llvm@lists.linux.dev,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Miguel Ojeda <ojeda@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Tom Rix <trix@redhat.com>,
 Will Deacon <will@kernel.org>, Kevin Tian <kevin.tian@intel.com>,
 Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [PATCH v2 07/14] iommu: Make iommu_group_do_dma_first_attach()
 simpler
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>
References: <7-v2-cd32667d2ba6+70bd1-iommu_err_unwind_jgg@nvidia.com>
 <5a249f94-7742-a2c8-2eff-88821783a6f2@linux.intel.com>
 <ZCWfomPrtmG08s9F@nvidia.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <ZCWfomPrtmG08s9F@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/30/23 10:41 PM, Jason Gunthorpe wrote:
> On Thu, Mar 30, 2023 at 02:42:20PM +0800, Baolu Lu wrote:
> 
>>> @@ -405,18 +409,10 @@ static bool iommu_is_attach_deferred(struct device *dev)
>>>    	return false;
>>>    }
>>> -static int iommu_group_do_dma_first_attach(struct device *dev, void *data)
>>> +static int iommu_group_do_dma_first_attach(struct iommu_group *group, struct device *dev)
>>>    {
>>> -	struct iommu_domain *domain = data;
>>> -
>>> -	lockdep_assert_held(&dev->iommu_group->mutex);
>>> -
>>> -	if (iommu_is_attach_deferred(dev)) {
>>> -		dev->iommu->attach_deferred = 1;
>>> -		return 0;
>>> -	}
>>> -
>>> -	return __iommu_attach_device(domain, dev);
>>> +	return __iommu_device_set_domain(group, dev, group->domain,
>>> +					 IOMMU_SET_DOMAIN_WITH_DEFERRED);
>> Just out of curiosity, why is this group->domain instead of
>> group->default_domain?
> The overall invariant is that all devices are attached to
> group->domain, whatever it is.
> 
> Devices are not attached to the default_domain, the default_domain is
> made the current group->domain which changes all the devices.
> 
> Eventually the caller is made to look like:
> 
>          if (group->domain) {
>                  ret = iommu_group_do_dma_first_attach(group, dev);
>                  if (ret)
>                          goto err_unlock;
>                  iommu_create_device_direct_mappings(group->domain, dev);
>          } else if (!group->default_domain) {
>                  ret = iommu_setup_default_domain(group, 0);
>                  if (ret)
>                          goto err_unlock;
>          }
> 
> Which makes it clear we can't assume that default_domain == domain at
> this point.

Yeah! That's clearer.

Best regards,
baolu
