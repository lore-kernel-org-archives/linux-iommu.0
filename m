Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BDE615A4B7
	for <iommu@lists.linux.dev>; Wed, 28 Aug 2024 12:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724848296; cv=none; b=IEm5nlaKLXFaw7lnHBCSufcqmHxGeZAMH12rP15qdgoSAKx4Pht8LFlofTasoqrwLGLIwWMm7RBlA5BQ0K5c3eNVzkm/DJhyqPadz2s3urZT0TMzipv9GQxfaRtVKF9yIOo/7JeokAfkdTRlocCzjZw29pMknp/+uZMF3h9N+Eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724848296; c=relaxed/simple;
	bh=q7I3X99MoFquWLbykU6JkGpvClcCE8EOA6z/oR+IS4s=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=YfKELikQ6EA2ftHgys37a7iJPt3DdVG/QuGQIcnMf8VH51aGsPlHQhgwmS3AElGXHUsHFetJ3gBfP+/x5FMuxLJpnkmenQYn4iqvO+9sH2dUQC81G7EsRuixjS5QCog262Bq+s7+BC5GqsGpMSP1/tXg8rBoSXLockRcr4aTLv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Wv3gB6K6Zz2Dbb0;
	Wed, 28 Aug 2024 20:31:18 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id 4F9951A0188;
	Wed, 28 Aug 2024 20:31:30 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 dggpeml500022.china.huawei.com (7.185.36.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 28 Aug 2024 20:31:30 +0800
Message-ID: <29458d89-132e-4069-81f4-a5b02598590c@huawei.com>
Date: Wed, 28 Aug 2024 20:31:29 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] iommu/omap: Use IS_ERR_OR_NULL() helper function
To: Robin Murphy <robin.murphy@arm.com>, <joro@8bytes.org>, <will@kernel.org>
CC: <iommu@lists.linux.dev>
References: <20240828122152.3697094-1-lihongbo22@huawei.com>
 <ee9b096a-7d23-47ed-850f-f8ca2c9af97f@arm.com>
Content-Language: en-US
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <ee9b096a-7d23-47ed-850f-f8ca2c9af97f@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500022.china.huawei.com (7.185.36.66)



On 2024/8/28 20:24, Robin Murphy wrote:
> On 2024-08-28 1:21 pm, Hongbo Li wrote:
>> Use the IS_ERR_OR_NULL() helper instead of open-coding a
>> NULL and an error pointer checks to simplify the code and
>> improve readability.
> 
> IS_ERR_OR_NULL() is usually a bad smell to begin with... Sure enough, if 
> you really want to simplify and improve this code, it doesn't take much 
> to look a little further and see that the suspicious checks are entirely 
> pointless anyway. Both callsites have this pattern:
> 
>          omap_iommu_detach(oiommu);
>          ...
>          oiommu->domain = NULL;
> 
> so clearly the pointer must always be valid.

Yes, in IS_ERR_OR_NULL, the ptr is unlikely NULL, it match this 
condition. But the original condition does not have this expectation.

Thanks,
Hongbo

> 
> Thanks,
> Robin.
>> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
>> ---
>>   drivers/iommu/omap-iommu.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
>> index c9528065a59a..b7e323aa016f 100644
>> --- a/drivers/iommu/omap-iommu.c
>> +++ b/drivers/iommu/omap-iommu.c
>> @@ -881,7 +881,7 @@ static int omap_iommu_attach(struct omap_iommu 
>> *obj, u32 *iopgd)
>>    **/
>>   static void omap_iommu_detach(struct omap_iommu *obj)
>>   {
>> -    if (!obj || IS_ERR(obj))
>> +    if (IS_ERR_OR_NULL(obj))
>>           return;
>>       spin_lock(&obj->iommu_lock);
> 
