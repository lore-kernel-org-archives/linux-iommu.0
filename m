Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7690A7C
	for <iommu@lists.linux.dev>; Fri,  3 Feb 2023 01:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675388030; x=1706924030;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=WJ6u+bSQfkFJ6nD8V86oF3q/j3AxY6FQANJ6lvw+ZS0=;
  b=VW45wwYRTS07OprqbS0UksuM8qwL46NAGeryg6ruByXfyMw+qmLtfM5Z
   GvmT7/E+feJKCAPkF7D5KB4ScG354SA1xPYIWFF8DTFA7F0Lj6uJ1CWvt
   t7Q0bIOWybx3InY29zc1VE13navb4yZO7YYA33BSe8p6kx8zFU8gfbklC
   nPVcwwYnSP9dhi3+1WFCKrXKcnPJeA1SrbBPAf80ySKeQH6BuM6KjqT6Z
   WMx9CJ/3gfABS8uDhCSuQ5eFdL+Z5pM4fmbUx+b/N+TKymvRPnH55eC9c
   0zpA0A+eo2s32H/lf19HGEk5YC/fyLEyr5PpOSsFaIf633VLqoYz9diNz
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10609"; a="316627903"
X-IronPort-AV: E=Sophos;i="5.97,269,1669104000"; 
   d="scan'208";a="316627903"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2023 17:33:49 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10609"; a="734145077"
X-IronPort-AV: E=Sophos;i="5.97,269,1669104000"; 
   d="scan'208";a="734145077"
Received: from yujiepan-mobl.ccr.corp.intel.com (HELO [10.254.208.253]) ([10.254.208.253])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2023 17:33:46 -0800
Message-ID: <58837041-c0ea-2c65-4ed5-6b2d2189415e@linux.intel.com>
Date: Fri, 3 Feb 2023 09:33:44 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Cc: baolu.lu@linux.intel.com, jgg@nvidia.com, kevin.tian@intel.com,
 joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
 alex.williamson@redhat.com, shuah@kernel.org, yi.l.liu@intel.com,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev, kvm@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v1 2/8] iommu: Introduce a new
 iommu_group_replace_domain() API
To: Nicolin Chen <nicolinc@nvidia.com>
References: <cover.1675320212.git.nicolinc@nvidia.com>
 <a98e622f41d76b64f5a7d0c758d8bda5e8043013.1675320212.git.nicolinc@nvidia.com>
 <d5147b2f-4698-b39f-e956-84db122e9822@linux.intel.com>
 <Y9wLmBZzkZk2Mkh9@Asurada-Nvidia>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <Y9wLmBZzkZk2Mkh9@Asurada-Nvidia>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023/2/3 3:14, Nicolin Chen wrote:
> On Thu, Feb 02, 2023 at 06:21:20PM +0800, Baolu Lu wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> On 2023/2/2 15:05, Nicolin Chen wrote:
>>> +/**
>>> + * iommu_group_replace_domain - replace the domain that a group is attached to
>>> + * @new_domain: new IOMMU domain to replace with
>>> + * @group: IOMMU group that will be attached to the new domain
>>> + *
>>> + * This API allows the group to switch domains without being forced to go to
>>> + * the blocking domain in-between.
>>> + *
>>> + * If the attached domain is a core domain (e.g. a default_domain), it will act
>>> + * just like the iommu_attach_group().
>> I am not following above two lines. Why and how could iommufd set a
>> core domain to an iommu_group?
> Perhaps this isn't the best narrative. What it's supposed to say
> is that this function acts as an iommu_attach_group() call if the
> device is "detached", yet we have changed the semantics about the
> word "detach". So, what should the correct way to write such a
> note?

How could this interface be used as detaching a domain from a group?
Even it could be used, doesn't it act as an iommu_detach_group()?

Best regards,
baolu
