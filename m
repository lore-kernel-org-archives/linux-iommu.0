Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6301B22ACEB
	for <iommu@lists.linux.dev>; Wed, 24 Sep 2025 06:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758696105; cv=none; b=phFhJmfqqVj7MxJjcCjcP7r1dhtqmYwXVflfDak0rw10+ant+ICztyNLYkBQHzVKjLe9K969yC2FXf45Ft7gFF8mjDGLlSyT4AV2XfpRXm7essLuTq9k1luvHzOPwiwh0xBEzqwjtdui2gGxcpcwOV9MFqN9F3N3f2nrw4as7AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758696105; c=relaxed/simple;
	bh=ADPEIYUoTRtabK9AIFdYyLub1tp3eT0/9jSS1VO1FYw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fl6WOHHerpOuGLx+Mritf97T+MY0uY9u1AdnJi4ZRsktCw8srTnS6uhHqTts7qIpIhYFfwfrN4rYD8Zn0gO6HkzqLFzR2vzDskOjmwtbFjZ51DgdbapNyAw/FjIhv5DrBJnvqjSj3mxotjGxG3rJZTCmnhxQsvHMvYplBXLtEUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=hcsSV83O; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="hcsSV83O"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1758696093; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=4Fcy7H7yNylAxF+WhWGt9J+75W31LY0C4wvIp9sNR0I=;
	b=hcsSV83O0Hc2iiKd9faeqtcMQLd04aSOt6kk+baI0ea7twZz7JsM1PUFCRBIfsUoutpjRgEcZN3OBFu8rJKPfCCDeekWAejX0OYS5OxJl9SknakkIzC7oq60lMFH0fGjXSz999ceID9oNlUqmvUmV+SRfA5ncuZr3i89J0QapoI=
Received: from 30.178.82.6(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0WoianiE_1758696092 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 24 Sep 2025 14:41:33 +0800
Message-ID: <89c7e1cf-890c-4ced-a646-88a2d2de4824@linux.alibaba.com>
Date: Wed, 24 Sep 2025 14:41:31 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: =?UTF-8?B?TW96aWxsYSBUaHVuZGVyYmlyZCDmtYvor5XniYg=?=
Subject: Re: [PATCH v2] iommu: Fix iommu selftest running test mock domain
 fail
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 iommu@lists.linux.dev
References: <20250916090333.68179-1-kanie@linux.alibaba.com>
 <20250923173252.GE2547959@ziepe.ca>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <20250923173252.GE2547959@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/9/24 01:32, Jason Gunthorpe 写道:
> On Tue, Sep 16, 2025 at 05:03:33PM +0800, Guixin Liu wrote:
>> When intel_iommu=on is enabled and the iommu selftests are executed,
>> we observed multiple test case failures. Our investigation revealed
>> that both the Intel iommu driver and the mock iommu driver registered
>> iommu_device instances with fwnode=NULL, and both were added to the
>> iommu_device_list. Later, when the mock iommu driver attempted to
>> create a device, iommu_init_device attempted to retrieve the iommu_ops
>> by searching the iommu_device_list using the provided fwnode
>> (which was NULL).
>> Since the iommu_device registered by the Intel iommu driver appeared
>> earlier in the list, it was matched first instead of the mock iommu
>> driver's iommu_device. This ultimately caused probe_device to fail.
>>
>> Fix this by alloc a software fwnode for mock iommu driver's iommu_device,
>> and set it to the device which mock iommu driver created.
>>
>> Test by "make -C toosl/testing/selftests TARGETS=iommu run_tests":
>> PASSED: 229 / 229 tests passed.
>>
>> In addition, this issue is also can be found on amd platform, and
>> also tested on a amd machine.
>>
>> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
>> Tested-by: Qinyun Tan <qinyuntan@linux.alibaba.com>
>> ---
>> Changes from v1 to v2:
>> - Remove print when iommu_fwspec_init() fail.
>>
>>   drivers/iommu/iommu.c            | 12 ++++++++++++
>>   drivers/iommu/iommufd/selftest.c |  9 +++++++++
>>   2 files changed, 21 insertions(+)
>>
>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>> index 060ebe330ee1..cda5e1c039aa 100644
>> --- a/drivers/iommu/iommu.c
>> +++ b/drivers/iommu/iommu.c
>> @@ -304,6 +304,7 @@ void iommu_device_unregister_bus(struct iommu_device *iommu,
>>   				 struct notifier_block *nb)
>>   {
>>   	bus_unregister_notifier(bus, nb);
>> +	fwnode_remove_software_node(iommu->fwnode);
>>   	iommu_device_unregister(iommu);
>>   }
>>   EXPORT_SYMBOL_GPL(iommu_device_unregister_bus);
>> @@ -326,6 +327,14 @@ int iommu_device_register_bus(struct iommu_device *iommu,
>>   	if (err)
>>   		return err;
>>   
>> +	iommu->fwnode = fwnode_create_software_node(NULL, NULL);
>> +	if (IS_ERR(iommu->fwnode)) {
>> +		iommu->fwnode = NULL;
>> +		dev_err(iommu->dev, "add property failed:%d\n", err);
>> +		bus_unregister_notifier(bus, nb);
>> +		return err;
>> +	}
>> +
>>   	spin_lock(&iommu_device_lock);
>>   	list_add_tail(&iommu->list, &iommu_device_list);
>>   	spin_unlock(&iommu_device_lock);
>> @@ -335,6 +344,7 @@ int iommu_device_register_bus(struct iommu_device *iommu,
>>   		iommu_device_unregister_bus(iommu, bus, nb);
>>   		return err;
>>   	}
>> +	WRITE_ONCE(iommu->ready, true);
>>   	return 0;
>>   }
>>   EXPORT_SYMBOL_GPL(iommu_device_register_bus);
>> @@ -555,6 +565,7 @@ static struct iommu_domain *pasid_array_entry_to_domain(void *entry)
>>   }
>>   
>>   DEFINE_MUTEX(iommu_probe_device_lock);
>> +EXPORT_SYMBOL_GPL(iommu_probe_device_lock);
> I'm still unhappy to see this exported.
>
> I'd rather you export some new selftest only functions for this
> special fwspec usage.
>
> We already have the block
>
> #if IS_ENABLED(CONFIG_IOMMUFD_TEST)
>
> in iommu.c
>
> So lest add a
>
> iommu_mock_device_init(struct device *dev, struct iommu_device *iommu);
> iommu_mock_device_abort(struct device *dev);
OK, Changed in v3, thanks.

Best Regards,
Guixin Liu
>> --- a/drivers/iommu/iommufd/selftest.c
>> +++ b/drivers/iommu/iommufd/selftest.c
>> @@ -1126,12 +1126,21 @@ static struct mock_dev *mock_dev_create(unsigned long dev_flags)
>>   		goto err_put;
>>   	}
>>   
>> +	mutex_lock(&iommu_probe_device_lock);
>> +	rc = iommu_fwspec_init(&mdev->dev, mock_iommu.iommu_dev.fwnode);
>> +	if (rc) {
>> +		mutex_unlock(&iommu_probe_device_lock);
>> +		goto err_put;
>> +	}
>> +	mutex_unlock(&iommu_probe_device_lock);
>> +
>>   	rc = device_add(&mdev->dev);
>>   	if (rc)
>>   		goto err_put;
>>   	return mdev;
>>   
>>   err_put:
>> +	iommu_fwspec_free(&mdev->dev);
>>   	put_device(&mdev->dev);
>>   	return ERR_PTR(rc);
> That handles these two cases.
>
> Jason

