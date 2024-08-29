Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82BA410A24
	for <iommu@lists.linux.dev>; Thu, 29 Aug 2024 01:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724894454; cv=none; b=TgSWnn8UzxFYE86+1b0lrqMKheZCr20JkQZC7QzyRqdCx3LZGzLEa2v+knqrlQopdwa9ptF1ndgURn5uHkMlv3GKlqZ92qrueXilkviKwRlytXDBmbxk4N0oi8beUmiICLwJjK4m6fy5q+3dJbxfYjH4shYAIAcjOCkTXppk1Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724894454; c=relaxed/simple;
	bh=WT2k6pxQ2AAElkFlvBijJyF1nHMOX9r8hXie5PJ/IY0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=YGz+dCpc/mL5/K3vTTj8UBr2SAa9eEbTYRlwWfPr1tUva79/pAYiCS06nP8utBzNjNxVLdr1H05bpauvP3TDHce3Rgr1c7U9R4iQ3bbXicPXfKEh84tA/npT0K0lwz2R7OjquTc8eeOFAwy0sujAAjIx6Ebu4XO3ODC46roS4AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WvNk74y4szyQbK;
	Thu, 29 Aug 2024 09:19:59 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id EDFE01800D2;
	Thu, 29 Aug 2024 09:20:48 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 dggpeml500022.china.huawei.com (7.185.36.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 29 Aug 2024 09:20:48 +0800
Message-ID: <d81c2a3c-7190-4bc9-83c7-6c4f7d74708a@huawei.com>
Date: Thu, 29 Aug 2024 09:20:48 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] iommu/omap: Use IS_ERR_OR_NULL() helper function
Content-Language: en-US
To: Robin Murphy <robin.murphy@arm.com>, <joro@8bytes.org>, <will@kernel.org>
CC: <iommu@lists.linux.dev>
References: <20240828122152.3697094-1-lihongbo22@huawei.com>
 <ee9b096a-7d23-47ed-850f-f8ca2c9af97f@arm.com>
 <29458d89-132e-4069-81f4-a5b02598590c@huawei.com>
 <8d47c290-8146-4a3a-b163-e60b605557fe@arm.com>
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <8d47c290-8146-4a3a-b163-e60b605557fe@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500022.china.huawei.com (7.185.36.66)



On 2024/8/28 23:24, Robin Murphy wrote:
> On 2024-08-28 1:31 pm, Hongbo Li wrote:
>>
>>
>> On 2024/8/28 20:24, Robin Murphy wrote:
>>> On 2024-08-28 1:21 pm, Hongbo Li wrote:
>>>> Use the IS_ERR_OR_NULL() helper instead of open-coding a
>>>> NULL and an error pointer checks to simplify the code and
>>>> improve readability.
>>>
>>> IS_ERR_OR_NULL() is usually a bad smell to begin with... Sure enough, 
>>> if you really want to simplify and improve this code, it doesn't take 
>>> much to look a little further and see that the suspicious checks are 
>>> entirely pointless anyway. Both callsites have this pattern:
>>>
>>>          omap_iommu_detach(oiommu);
>>>          ...
>>>          oiommu->domain = NULL;
>>>
>>> so clearly the pointer must always be valid.
>>
>> Yes, in IS_ERR_OR_NULL, the ptr is unlikely NULL, it match this 
>> condition. But the original condition does not have this expectation.
> 
> My point is that the original condition here serves no purpose, so 
> refactoring it is a waste of time, and the only cleanup worth making is 
> to delete it.
> 
> Open-coded or not, the fact is that if we ever _could_ take that early 
> return by virtue of either caller's "oiommu" pointer being NULL or an 
> error value, then we'd still crash by unconditionally dereferencing it 
> two lines later. And it's pretty clear from the rest of the flow of 
> ->iommu_dev pointers through omap_iommu_probe_device() and 
> omap_iommu_attach_dev() that a NULL value cannot get here by 
> construction. As far as I can see nothing anywhere *ever* assigns an 
> ERR_PTR() value to one...
> 
> Churning pointless dead code into slightly different pointless dead code 
> is not valuable to anyone. Churning ugly code into slightly different 
May be we can just remove the condition !oiommu? This does indeed seem 
to have little value, and this judgment should not have existed in the 
first place.

Thanks,
Hongbo

> ugly code is still questionable at best. If you're finding places which 
> look like they could use IS_ERR_OR_NULL(), then be aware that often at 
> least one of the two conditions might be erroneous anyway. Otherwise, it 
> usually represents some badly-designed interface which really wants to 
> be fixed properly such that it *would* only need one or other condition.
> 
> Thanks,
> Robin.
> 
