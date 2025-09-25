Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F402E62A6
	for <iommu@lists.linux.dev>; Thu, 25 Sep 2025 02:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758767375; cv=none; b=MqulVMQo9NulQoZQIyw4f95nb29oJW6hCVKIZTmiXkv1PsHjEuW02z2kKkNlaTAikLiO+xg3/niPaekT0LzoS/0SMWXkfk1Gg9Yp1qbI6FDl5ryRFb4RtiUGlHgvlH2lTZltpBdh///MRk70PK6jTo4nI9ZZzguYfXoKPL4G+yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758767375; c=relaxed/simple;
	bh=9gkVIUMhhvAd5aYysUoXavSxtXeTDq11RA6RJ0c63NE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ihe6PDRTQliNFjD4ToiigYfQw/UkG+9MhsXS1ct2gHEgUGkRNxJmpyiqcWR4P3ZrBD/ECMUgjZCiSA17+x/Zis5ASd40kClaPhBsqV3bE9DdPvtGSMrTq2TqrWGd+x0hETMDkjdvPPN4ciKCW6feYF75DZBci5ZsQV0DQ/unnyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=oMSJJPHf; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="oMSJJPHf"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1758767365; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=YkpHDfnGJfvVhhhkrhYpZrvXfN+vSN8XLi8F585YTbo=;
	b=oMSJJPHfiRfTXPrfLIaFh+nNy7WECNN7sEkG3TEsGjp5GU9rDZUpI5YWMTWN4UqtvFU7Gu4/3fx3KgMgkcqwxOvaiFNh9lv95eUAVoWpKzC4M7BPoasduk1WVLZJ8uWf1xZMd1AN3kydfSSI7BupyTC3JR/UVQQdCoOSt0XH9lc=
Received: from 30.178.82.13(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0WolnjIP_1758767363 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 25 Sep 2025 10:29:24 +0800
Message-ID: <3697dc65-63fd-477b-8622-0236741babbc@linux.alibaba.com>
Date: Thu, 25 Sep 2025 10:29:23 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: =?UTF-8?B?TW96aWxsYSBUaHVuZGVyYmlyZCDmtYvor5XniYg=?=
Subject: Re: [PATCH v3] iommu: Fix iommu selftest running test mock domain
 fail
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>,
 iommu@lists.linux.dev
References: <20250924074359.41510-1-kanie@linux.alibaba.com>
 <20250924125352.GI2547959@ziepe.ca>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <20250924125352.GI2547959@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/9/24 20:53, Jason Gunthorpe 写道:
> On Wed, Sep 24, 2025 at 03:43:59PM +0800, Guixin Liu wrote:
>> @@ -1077,6 +1077,7 @@ static void mock_dev_release(struct device *dev)
>>   {
>>   	struct mock_dev *mdev = to_mock_dev(dev);
>>   
>> +	iommu_mock_device_abort(&mdev->dev);
>>   	ida_free(&mock_dev_ida, mdev->id);
>>   	kfree(mdev);
>>   }
> I don't think this call is necessary? Once device_add() completes the
> iommu_bus_notifier() should be active for the device.
>
> BUS_NOTIFY_REMOVED_DEVICE triggers iommu_release_device() which does
> dev_iommu_free() and frees the fwspec automatically.
>
> The only unnatural condition is if device_add() fails then the
> notifier can't run and the caller has to clean it up.
>
> Yes?
You are right, I didn't consider it comprehensively.
>
>> @@ -1126,6 +1127,10 @@ static struct mock_dev *mock_dev_create(unsigned long dev_flags)
>>   		goto err_put;
>>   	}
>>   
>> +	rc = iommu_mock_device_init(&mdev->dev, &mock_iommu.iommu_dev);
>> +	if (rc)
>> +		goto err_put;
>> +
>>   	rc = device_add(&mdev->dev);
>>   	if (rc)
>>   		goto err_put;
> So I will suggest one further refinement to pull the device_add() into
> iommu_mock_device_add() and then it can internally free the fwspec on
> error and don't bother with iommu_mock_device_abort().
Nice idea, I will change it in v4, thanks.

Best Regards,
Guixin Liu
> But other than that little note this looks fine to me.
>
> Jason

