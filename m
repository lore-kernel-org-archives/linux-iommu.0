Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE9417C9
	for <iommu@lists.linux.dev>; Thu, 13 Oct 2022 01:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665623291; x=1697159291;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=sI7uA/BF8g87pdoZDXo20zv0ZMkz5SEoNiAKN8ktSaI=;
  b=F/OiR5XLYqB+3ktlZSdEYXr2LsGtqPcV0IVnH/vxJUawsGIAw+9SjjA4
   DdLzI7TDsrARNjgOEKjuXnicvyU3QVPAJqE8y1SkXEHpYo2c+HrZtkMzO
   G83DWnkVaVUrTn8Ola5TwFLEp12dW2CGJSp4K5vi5N4qxSwKwQiDSWnsX
   UPGvjb8JdAJ0D33uP1G470vgKl6XnlWBC1XX+p1qSkHAn48k9pJFYfOri
   JUJ/1UFOefQyvjN5rOhPEJ55JX1XkUU2NYDItn3Z2/vaPAnRS5GNqDLlv
   UKlv0OKFqbnxmbYfA08rDxgM4fsYZ7RSiy59RtbmBxGKXtYJP2JgyRJ7u
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10498"; a="366948992"
X-IronPort-AV: E=Sophos;i="5.95,180,1661842800"; 
   d="scan'208";a="366948992"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2022 18:08:11 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10498"; a="621972685"
X-IronPort-AV: E=Sophos;i="5.95,180,1661842800"; 
   d="scan'208";a="621972685"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.210.100]) ([10.254.210.100])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2022 18:08:07 -0700
Message-ID: <9f3acdbc-26a5-46a1-bdbf-0a66bb7b43dd@linux.intel.com>
Date: Thu, 13 Oct 2022 09:08:05 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Cc: baolu.lu@linux.intel.com, joro@8bytes.org, will@kernel.org,
 iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 kevin.tian@intel.com, suravee.suthikulpanit@amd.com, vasant.hegde@amd.com,
 mjrosato@linux.ibm.com, schnelle@linux.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 05/16] iommu: Move bus setup to IOMMU device
 registration
To: Alex Williamson <alex.williamson@redhat.com>,
 Robin Murphy <robin.murphy@arm.com>
References: <cover.1660572783.git.robin.murphy@arm.com>
 <d342b6f27efb5ef3e93aacaa3012d25386d74866.1660572783.git.robin.murphy@arm.com>
 <20221012102841.478c2b3b.alex.williamson@redhat.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20221012102841.478c2b3b.alex.williamson@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Alex,

On 2022/10/13 0:28, Alex Williamson wrote:
> On Mon, 15 Aug 2022 17:20:06 +0100
> Robin Murphy<robin.murphy@arm.com>  wrote:
> 
>> Move the bus setup to iommu_device_register(). This should allow
>> bus_iommu_probe() to be correctly replayed for multiple IOMMU instances,
>> and leaves bus_set_iommu() as a glorified no-op to be cleaned up next.
>>
>> At this point we can also handle cleanup better than just rolling back
>> the most-recently-touched bus upon failure - which may release devices
>> owned by other already-registered instances, and still leave devices on
>> other buses with dangling pointers to the failed instance. Now it's easy
>> to clean up the exact footprint of a given instance, no more, no less.
>>
>> Tested-by: Marek Szyprowski<m.szyprowski@samsung.com>
>> Reviewed-By: Krishna Reddy<vdumpa@nvidia.com>
>> Reviewed-by: Kevin Tian<kevin.tian@intel.com>
>> Tested-by: Matthew Rosato<mjrosato@linux.ibm.com>  # s390
>> Tested-by: Niklas Schnelle<schnelle@linux.ibm.com>  # s390
>> Signed-off-by: Robin Murphy<robin.murphy@arm.com>
>> ---
>>
>> v4: Factor out the ops check in iommu_device_register() to keep the loop
>> even simpler, and comment the nominal change in behaviour
>>
>>   drivers/iommu/iommu.c | 55 +++++++++++++++++++++++--------------------
>>   1 file changed, 30 insertions(+), 25 deletions(-)
> This introduces the below lockdep spat regression, bisected to commit:
> 
> 57365a04c921 ("iommu: Move bus setup to IOMMU device registration")
> 
> This can be reproduced with simple vfio-pci device assignment to a VM
> on x86_64 with VT-d.  Thanks,

Thank you for reporting this. I have proposed below fix:

https://lore.kernel.org/all/20220927053109.4053662-1-baolu.lu@linux.intel.com/

Does it work for you?

Best regards,
baolu
