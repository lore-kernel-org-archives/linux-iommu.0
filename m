Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9D14F9CB
	for <iommu@lists.linux.dev>; Wed, 23 Apr 2025 15:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745423438; cv=none; b=Db/M1JY1wtoKuRIYZ/LBW4BkCilg1rnwlCYZtqTidGLz/t2qjw4P2uM6HOo8o8O4GAx0cgM5e04SqFIkdFeAR6M2t6+Xar9YmaetXOMVMEfdlnwuaw9TZYksCaJ6Pzif5WX6CmX/PaxkIUPTqiClIdwfdUVzK0GvSL+ixcM+dFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745423438; c=relaxed/simple;
	bh=obJ4KNRdop1ri6ey3P8GkkISiNkN9TepbOopmkOaHtM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=boP3f/zjglMtwWriRNbb/XJdHfCna4BjLXPO7pbFJJnMQyktpLkD6XRv8OyGoGOUc18tBuoQp3hM4OFWarHiOsOFUqbAMRgTwsjGUJ4LocBxe0FiRKgA5cCiOCcQmZVHNuEis2jsRoHHM0wzKD4s+1gbUpLl5AYyAMu9C++emuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7FB331063;
	Wed, 23 Apr 2025 08:50:29 -0700 (PDT)
Received: from [10.57.74.63] (unknown [10.57.74.63])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BA5153F66E;
	Wed, 23 Apr 2025 08:50:31 -0700 (PDT)
Message-ID: <4129dca9-07fa-4b9d-a7d8-de7561d509e7@arm.com>
Date: Wed, 23 Apr 2025 16:50:29 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] platform: Fix race condition during DMA configure at
 IOMMU probe time
To: Bjorn Helgaas <helgaas@kernel.org>,
 Will McVicker <willmcvicker@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 Jason Gunthorpe <jgg@ziepe.ca>, "Rob Herring (Arm)" <robh@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Joerg Roedel <jroedel@suse.de>,
 Bjorn Helgaas <bhelgaas@google.com>, iommu@lists.linux.dev,
 Saravana Kannan <saravanak@google.com>, kernel-team@android.com,
 linux-kernel@vger.kernel.org
References: <20250423150823.GA422889@bhelgaas>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20250423150823.GA422889@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-04-23 4:08 pm, Bjorn Helgaas wrote:
> On Tue, Apr 22, 2025 at 04:26:49PM -0700, Will McVicker wrote:
>> If devices are probed asynchronously, then there is a chance that during
>> the IOMMU probe the driver is bound to the device in parallel. If this
>> happens after getting the platform_driver pointer while in the function
>> `platform_dma_configure()`, then the invalid `drv` pointer
>> (drv==0xf...ffd8) will be de-referenced since `dev->driver != NULL`.
> 
> I need a little more hand-holding to make sense out of this.
> 
> After digging out
> https://lore.kernel.org/all/aAa2Zx86yUfayPSG@google.com/, I see that
> drv==0xf...ffd8 must be a result of applying to_platform_driver() to a
> NULL pointer.  This patch still applies to_platform_driver(NULL), but
> avoids using the result by testing drv for NULL later, which seems
> prone to error.
> 
> I think this would all be clearer if we tested for the NULL pointer
> explicitly before applying to_platform_driver().  I don't like setting
> a pointer to an invalid value.  I think it's better if the pointer is
> either valid or uninitialized because the compiler can help find uses
> of uninitialized pointers.

Yeah, I was also in the middle of looking at this after managing to hit 
it playing with driver_async_probe at the end of last week. I guess when 
I originally wrote this pattern I was maybe thinking the compiler would 
defer the to_x_driver() computation to the point it's eventually 
dereferenced, but I suppose it can't since dev is passed to an external 
function in program order in between.

Indeed in my half-written version of this patch I was leaning towards 
removing the drv variable altogether (just doing 
to_x_driver(dev->driver)->driver_managed_dma inline), or at least doing 
the same as Will's previous diff. I figure the one-liner replacing 
"!dev->driver" with "!&drv->driver" would be too disgustingly 
non-obvious for anyone else's tastes...

For consistency we should really fix all the buses the same way - sorry 
for the bother (I can write up the other patches if you'd like). FWIW 
this part really was the most temporary stopgap, as my planned next step 
is to propose moving driver_managed_dma and the use_default_domain() 
call up into the driver core and so removing all this bus-level code 
anyway, hence trying to minimise the effort spent churning it. Oh well.

>> To avoid a kernel panic and eliminate the race condition, we should
>> guard the usage of `dev->driver` by only reading it once at the
>> beginning of the function.
>>
>> Fixes: bcb81ac6ae3c ("iommu: Get DT/ACPI parsing into the proper probe path")
>> Signed-off-by: Will McVicker <willmcvicker@google.com>
>> ---
>>   drivers/base/platform.c | 7 ++++---
>>   1 file changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/base/platform.c b/drivers/base/platform.c
>> index 1813cfd0c4bd..b948c6e8e939 100644
>> --- a/drivers/base/platform.c
>> +++ b/drivers/base/platform.c
>> @@ -1440,7 +1440,8 @@ static void platform_shutdown(struct device *_dev)
>>   
>>   static int platform_dma_configure(struct device *dev)
>>   {
>> -	struct platform_driver *drv = to_platform_driver(dev->driver);
>> +	struct device_driver *drv = READ_ONCE(dev->driver);

Beware this might annoy a different set of people as it's not paired 
with a WRITE_ONCE(), but for now I guess using it is still arguably 
better than not. Really we should be under device_lock at this point and 
so have no race at all, but we can't do that without keeping track of 
which devices are IOMMUs themselves to avoid deadlock, and that's not 
something I fancy throwing out as an -rc fix in a hurry...

Thanks,
Robin.

>> +	struct platform_driver *pdrv = to_platform_driver(drv);
>>   	struct fwnode_handle *fwnode = dev_fwnode(dev);
>>   	enum dev_dma_attr attr;
>>   	int ret = 0;
>> @@ -1451,8 +1452,8 @@ static int platform_dma_configure(struct device *dev)
>>   		attr = acpi_get_dma_attr(to_acpi_device_node(fwnode));
>>   		ret = acpi_dma_configure(dev, attr);
>>   	}
>> -	/* @drv may not be valid when we're called from the IOMMU layer */
>> -	if (ret || !dev->driver || drv->driver_managed_dma)
>> +	/* @dev->driver may not be valid when we're called from the IOMMU layer */
>> +	if (ret || !drv || pdrv->driver_managed_dma)
>>   		return ret;
>>   
>>   	ret = iommu_device_use_default_domain(dev);
>> -- 
>> 2.49.0.805.g082f7c87e0-goog
>>

