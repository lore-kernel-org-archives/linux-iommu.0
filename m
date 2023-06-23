Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275057E0
	for <iommu@lists.linux.dev>; Fri, 23 Jun 2023 03:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687489818; x=1719025818;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=edw6ZvM8tfBewdFGe/+Lz038cAB/+q048znYLMjVRnY=;
  b=Q3kOLJJYlJhqVU3sHG2Zq7ZY/U0XDlRsbui3cZfYlr2znyqPqrw+gfSY
   HFwGeIj77zw9cf7kGSEl5fudDdVQcrkcM3uXP8y1wjEsjaJWdbwFJuJpF
   428iH/NJFQlh9vJ98U0h9JYW6ldv8vbqhr4XvOtaT5hiYaHlAs7VioZ9Z
   1wR3O8/uCO+dG02JvKvVPzPtBWhGnCJiswhIgFULuH2o/g5sxq0aQIfnb
   CDNpjXn7xCi/Gw1ryuYJzJ3zq3EWtcuU3SgcH42GsfcCNoj08IYqMfBnp
   PbWfVhSnZBYtx/1M+/bJVvYFi5iACgI1RAIb9BUXSCxjNQJiHHZNZJAqf
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="350436255"
X-IronPort-AV: E=Sophos;i="6.01,150,1684825200"; 
   d="scan'208";a="350436255"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2023 20:10:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="828210162"
X-IronPort-AV: E=Sophos;i="6.01,150,1684825200"; 
   d="scan'208";a="828210162"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by fmsmga002.fm.intel.com with ESMTP; 22 Jun 2023 20:10:15 -0700
Message-ID: <febaefc7-9b2c-5634-ea1d-0286b57b1766@linux.intel.com>
Date: Fri, 23 Jun 2023 11:08:56 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Cc: baolu.lu@linux.intel.com, iommu@lists.linux.dev, joro@8bytes.org,
 suravee.suthikulpanit@amd.com,
 Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
Subject: Re: [PATCH v2 iommu/next] iommu: Fix default domain setup
Content-Language: en-US
To: Jason Gunthorpe <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
References: <20230619084945.6427-1-vasant.hegde@amd.com>
 <13d072e5-df86-d3c8-6742-e52b66fd96a4@linux.intel.com>
 <ZJGQsWXkgTuj7xC1@ziepe.ca> <13b8b3a8-4dc5-7e61-4e0b-f545a3679a8a@amd.com>
 <ZJRSuBsVBVSi8Swn@ziepe.ca>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <ZJRSuBsVBVSi8Swn@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/22/23 9:55 PM, Jason Gunthorpe wrote:
> On Thu, Jun 22, 2023 at 10:29:58AM +0530, Vasant Hegde wrote:
>> Hi Baolu, Jason,
>>
>>
>> On 6/20/2023 5:12 PM, Jason Gunthorpe wrote:
>>> On Tue, Jun 20, 2023 at 02:31:43PM +0800, Baolu Lu wrote:
>>>>>    err_restore:
>>>>>    	if (old_dom) {
>>>>>    		__iommu_group_set_domain_internal(
>>>>>    			group, old_dom, IOMMU_SET_DOMAIN_MUST_SUCCEED);
>>>>> +		group->default_domain = old_dom;
>>>>>    		iommu_domain_free(dom);
>>>>>    		old_dom = NULL;
>>>>>    	}
>>>> The err_restore branch doesn't work if old_dom is NULL. We have no means
>>>> to restore a group from a successful first-time attaching to NULL
>>>> attaching.
>>> Yes, this is what I fixed in my alternative version
>> Not really. Even your version has
> I though what Baolu means is that it crashes in some of the cases.
> 
>> +err_restore_domain:
>> +	if (old_dom)
>>
>>
>> Only first time we will have old_dom is NULL and this functions returns error
>> code. iommu_probe_device()/bus_iommu_probe() handler error path properly and
>> frees resources. So I think this is fine.
> Yes, the design is to leave it as-is and know that the error unwind
> will fail to attach the device and free the domain after
> release. There is a comment explaining this.
> 

I thought that perhaps we could throw a warning to the driver when
old_dom is NULL. Something like this:

	if (!old_dom)
		pr_warn("can't restore to old domain\n");
	else
		goto err_restore_domain;

But as Vasant said the only caller can handle this error case
gracefully. Then it's fine to keep the code as it is.

Best regards,
baolu
