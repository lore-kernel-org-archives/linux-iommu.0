Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05DBD157A53
	for <iommu@lists.linux.dev>; Wed, 26 Jun 2024 07:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719387747; cv=none; b=dFC131LVnVG/UmswYUyiV5snLVSqTDGk/T7VV5RQRO9c1Jsy2SI0umy7Oa0qnSwChYW9x1j95KqjC/6W1X3MS0Pd150DkJ1hhMPYGFOI8gJFAsL8XtcujOvvGf3ayepsuwWTmCSiJ4WUmOqHcr4TLAY7VMDghuGaltYPA40Zpj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719387747; c=relaxed/simple;
	bh=lTLXdrFJceF59PkvLkG2bcwF+M1eaH+7bx08IMB9IdI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=sehQlyfs/XwpyYxwh3Ki2c712DvqEubkPRebxYtUr+6uZfbowJua+5a3B75J7N0oHaReOMJyufTl8tl+F2CFfDoQ9K4NLo6UkxyoGmTjWf6aR8U4omfk7QWRtJ1JWgQb84AWvndQ/nBzrmztU3lkp9EAOVGlAvN8bLM/zYIlLvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4W8DC44WK0zdf0m;
	Wed, 26 Jun 2024 15:40:48 +0800 (CST)
Received: from kwepemf500003.china.huawei.com (unknown [7.202.181.241])
	by mail.maildlp.com (Postfix) with ESMTPS id 7441214011D;
	Wed, 26 Jun 2024 15:42:22 +0800 (CST)
Received: from [10.174.176.82] (10.174.176.82) by
 kwepemf500003.china.huawei.com (7.202.181.241) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 26 Jun 2024 15:42:21 +0800
Message-ID: <3d4234f5-6000-4fb5-b997-fc4f444128ae@huawei.com>
Date: Wed, 26 Jun 2024 15:42:17 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/iova: Bettering utilizing cpu_rcaches in no-strict
 mode
To: Robin Murphy <robin.murphy@arm.com>
CC: <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>, "joro@8bytes.org"
	<joro@8bytes.org>, <will@kernel.org>, John Garry <john.g.garry@oracle.com>
References: <20240624083952.52612-1-zhangzekun11@huawei.com>
 <5149c162-cf38-4aa4-9e96-27c6897cad36@arm.com>
 <0322849d-dc1f-4e1c-a47a-463f3c301bdc@huawei.com>
 <c4c44f66-fb9c-4d71-ac35-f3fef75832bd@arm.com>
 <c6ae28eb-69b6-4508-a516-1d419e950b37@huawei.com>
 <53b7ec9c-9542-4f7a-960e-8cecaf428b27@arm.com>
From: "zhangzekun (A)" <zhangzekun11@huawei.com>
In-Reply-To: <53b7ec9c-9542-4f7a-960e-8cecaf428b27@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemf500003.china.huawei.com (7.202.181.241)



在 2024/6/26 2:03, Robin Murphy 写道:
> On 2024-06-25 2:29 am, zhangzekun (A) wrote:
>>
>>
>> 在 2024/6/24 21:32, Robin Murphy 写道:
>>
>>>> This patch is firstly intent to minimize the chance of softlock 
>>>> issue in fq_flush_timeout(), which is already dicribed erarlier in 
>>>> [1], which has beed applied in a commercial kernel[2] for years.
>>>>
>>>> However, the later tests show that this single patch is not enough 
>>>> to fix the softlockup issue, since the root cause of softlockup is 
>>>> the underlying iova_rbtree_lock. In our softlockup scenarios, the 
>>>> average
>>>> time cost to get this spinlock is about 6ms.
>>>
>>> That should already be fixed, though. The only reason for 
>>> fq_flush_timeout() to interact with the rbtree at all was due to the 
>>> notion of a fixed-size depot which could become full. That no longer 
>>> exists since 911aa1245da8 ("iommu/iova: Make the rcache depot scale 
>>> better").
>>>
>>> Thanks,
>>> Robin.
>>>
>> Hi, Robin,
>>
>> The commit 911aa1245da8 ("iommu/iova: Make the rcache depot scale 
>> better") can reduce the risks of softlockup, but can not fix it 
>> entirely. We do solve a softlockup issue[1] with that patch, and that is
>> why it has aleady been backported in our branch. The softlockup issue 
>> which we met recently is a 5.10-based kernel with that patch already 
>> backported, which can be found in [2].
> 
> Sorry, I was implying some context that I should have made clear - yes, 
> the softlockup can still happen in general if the flush queues are full 
> of IOVAs which are too large for the rcache mechanism at all, so are 
> always freed directly to the rbtree, but then there's no way *this* 
> patch could make any difference to that case either.
> 
> Thanks,
> Robin.
> 

Yes, this patch can't fix softlockup issue in this case. In such a case, 
it would be better to put the free iova logic in fq_flush_timeout() to a 
kthread and add a cond_resched() in it.

Thanks,
Zekun
