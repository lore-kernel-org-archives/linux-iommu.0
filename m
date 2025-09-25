Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25374246BC5
	for <iommu@lists.linux.dev>; Thu, 25 Sep 2025 05:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758778970; cv=none; b=i3o3EEIGLahxX7GNiTppKkhj+Et3zqECBnU7L2h5hXhFvB4yzCsPQL44uE065bxCNO0Bn0ODrf/u4K/x5wA/Hf8Aqd4DedhiC8LR3zctyT1PnZV6swL2F2V4IFTfDXvyQ3RXyvE3rkn3gW68/64BG3LZ/dkDGDHJkxRBwTObFCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758778970; c=relaxed/simple;
	bh=DuDXWtf4YO6KmefB884epBSskCLXBsRQiaMD6JanyOA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pxm6at3vCxELwOoSzEsBPACxC5KV/4DAGsSthisded3ERGwPemN5HZbITA84IYuxmgCpezKzc77Gigbe7WGx19mmXiOfgB/zckvcg/FH+adCL4GSBXIWBuQl7K68i0caW1y3pyjRTJXv9ooiKVkpZK0DCFoLZouY+093QSX3pHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=qqwa0q1g; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="qqwa0q1g"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1758778964; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=w0/eWT0dgJX6oy5E6Pbk1aRxOchxuhT5uAVOgaz1DXg=;
	b=qqwa0q1gg0SzGGyX7SGxE+wuFK8FHezk4XgU7MQty04iKMxWqnmbOalklNns2k9Bkup98hE5JG2elqqbdgeTe0f+Jb7D+YmcmLr/5RkRYj6e1GcAXIEeFEvYWAsocfw+XSbOK0fLBB93L6GtBzRgjCSE36cdGydi4KWzcckWHQY=
Received: from 30.178.82.13(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0WomO-3s_1758778962 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 25 Sep 2025 13:42:43 +0800
Message-ID: <6402f169-0402-4538-905f-1ddb67e79a11@linux.alibaba.com>
Date: Thu, 25 Sep 2025 13:42:42 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: =?UTF-8?B?TW96aWxsYSBUaHVuZGVyYmlyZCDmtYvor5XniYg=?=
Subject: Re: [PATCH v4] iommu: Fix iommu selftest running test mock domain
 fail
To: Baolu Lu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>
Cc: iommu@lists.linux.dev
References: <20250925025251.64578-1-kanie@linux.alibaba.com>
 <a6506e38-84c9-45f2-9e3e-8beae2dc4668@linux.intel.com>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <a6506e38-84c9-45f2-9e3e-8beae2dc4668@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/9/25 13:01, Baolu Lu 写道:
> On 9/25/25 10:52, Guixin Liu wrote:
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
>> Fix this by alloc a software fwnode for mock iommu driver's 
>> iommu_device,
>> and set it to the device which mock iommu driver created.
>>
>> Test by "make -C toosl/testing/selftests TARGETS=iommu run_tests":
>> PASSED: 229 / 229 tests passed.
>>
>> In addition, this issue is also can be found on amd platform, and
>> also tested on a amd machine.
>>
>> Signed-off-by: Guixin Liu<kanie@linux.alibaba.com>
>> Tested-by: Qinyun Tan<qinyuntan@linux.alibaba.com>
>> ---
>> Changes from v3 to v4:
>> - Remove iommu_mock_device_abort(), rename iommu_mock_device_init() to
>> iommu_mock_device_add(), and fold device_add() into 
>> iommu_mock_device_add().
>>
>> Changes from v2 to v3:
>> - Add export symbol iommu_mock_device_init() and 
>> iommu_mock_device_abort()
>> in iommu.c instead of export iommu_probe_device_lock and 
>> iommu_fwspec_free().
>>
>> Changes from v1 to v2:
>> - Remove print when iommu_fwspec_init() fail.
>>   drivers/iommu/iommu-priv.h       |  2 ++
>>   drivers/iommu/iommu.c            | 28 ++++++++++++++++++++++++++++
>>   drivers/iommu/iommufd/selftest.c |  2 +-
>>   3 files changed, 31 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/iommu/iommu-priv.h b/drivers/iommu/iommu-priv.h
>> index e236b932e766..c95394cd03a7 100644
>> --- a/drivers/iommu/iommu-priv.h
>> +++ b/drivers/iommu/iommu-priv.h
>> @@ -37,6 +37,8 @@ void iommu_device_unregister_bus(struct 
>> iommu_device *iommu,
>>                    const struct bus_type *bus,
>>                    struct notifier_block *nb);
>>   +int iommu_mock_device_add(struct device *dev, struct iommu_device 
>> *iommu);
>> +
>>   struct iommu_attach_handle *iommu_attach_handle_get(struct 
>> iommu_group *group,
>>                               ioasid_t pasid,
>>                               unsigned int type);
>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>> index 060ebe330ee1..5d4670aa50e6 100644
>> --- a/drivers/iommu/iommu.c
>> +++ b/drivers/iommu/iommu.c
>> @@ -304,6 +304,7 @@ void iommu_device_unregister_bus(struct 
>> iommu_device *iommu,
>>                    struct notifier_block *nb)
>>   {
>>       bus_unregister_notifier(bus, nb);
>> +    fwnode_remove_software_node(iommu->fwnode);
>>       iommu_device_unregister(iommu);
>>   }
>>   EXPORT_SYMBOL_GPL(iommu_device_unregister_bus);
>> @@ -326,6 +327,14 @@ int iommu_device_register_bus(struct 
>> iommu_device *iommu,
>>       if (err)
>>           return err;
>>   +    iommu->fwnode = fwnode_create_software_node(NULL, NULL);
>> +    if (IS_ERR(iommu->fwnode)) {
>> +        iommu->fwnode = NULL;
>> +        dev_err(iommu->dev,"add property failed:%d\n", err);
>> +        bus_unregister_notifier(bus, nb);
>> +        return err;
>> +    }
>
> Nit: I don't think we need a dev_err() here. Also, there's no need for
> "iommu->fwnode = NULL;" since you don't do this in
> iommu_device_unregister_bus().
Changed in v5, thanks.
>
> Just simply
>
>     if (IS_ERR(iommu->fwnode)) {
>         bus_unregister_notifier(bus, nb);
>         return err;
>     }
>
> ?
>
> Otherwise, it looks good to me.
>
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Best Regards,

Guixin Liu

