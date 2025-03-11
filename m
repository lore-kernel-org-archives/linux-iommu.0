Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 553CD19AA63
	for <iommu@lists.linux.dev>; Tue, 11 Mar 2025 14:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741702870; cv=none; b=RLKxDJdPGu9p1v13XbVwpVZIeuPUlBnXQBR+hcH/NAWYFdjgfPMMkqkDMqLdVVjdvpO64KfszN+FYagX9uNDdcuo/8KD94T7knkBccxCB/JSNCghyxxWTwZ8SjSUFepNH2M2PEtKt9PPFbJXxRyatYAMVQDisCEm0lEVXzDaQX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741702870; c=relaxed/simple;
	bh=StPmBXB4eYnJAelf1pTF4/wgXdgTyLgjeTsRRh40oMY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FtyoRN/yDCnzEDh9ngG+1bJrcCtNPNtF/JJ62PAda7jVzuaaCiZu2Gs5xMKSDGaNORakYIc6MgmkNrcPakATarQsoBDXyxNiglYOvHpM2hBCsMBj/ZJBoOyJ2CjAhYCsBRUqTBwSEkRoNX1tTY62uQ5cHfY8pDs25RsN+hSClr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6BCF51516;
	Tue, 11 Mar 2025 07:21:19 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 53CB93F694;
	Tue, 11 Mar 2025 07:21:07 -0700 (PDT)
Message-ID: <d8d7c381-b3e6-4259-b1f4-ff06328df0a0@arm.com>
Date: Tue, 11 Mar 2025 14:21:05 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu: Unexport iommu_fwspec_free()
To: Joerg Roedel <joro@8bytes.org>
Cc: will@kernel.org, iommu@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, yong.wu@mediatek.com,
 thierry.reding@gmail.com, vdumpa@nvidia.com
References: <36e245489361de2d13db22a510fa5c79e7126278.1740667667.git.robin.murphy@arm.com>
 <Z9A3WJSgUPjROev6@8bytes.org>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <Z9A3WJSgUPjROev6@8bytes.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/03/2025 1:15 pm, Joerg Roedel wrote:
> This patch triggered two compile issues on ARM32, which I fixed up in my
> tree:
> 
> On Thu, Feb 27, 2025 at 02:47:47PM +0000, Robin Murphy wrote:
>>   static struct iommu_device *mtk_iommu_v1_probe_device(struct device *dev)
>>   {
>> -	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
>> +	struct iommu_fwspec *fwspec = NULL
> 
> Missing semicolon here.
> 
>>   	struct of_phandle_args iommu_spec;
>>   	struct mtk_iommu_v1_data *data;
>>   	int err, idx = 0, larbid, larbidx;
>>   	struct device_link *link;
>>   	struct device *larbdev;
>>   
>> -	/*
>> -	 * In the deferred case, free the existed fwspec.
>> -	 * Always initialize the fwspec internally.
>> -	 */
>> -	if (fwspec) {
>> -		iommu_fwspec_free(dev);
>> -		fwspec = dev_iommu_fwspec_get(dev);
>> -	}
>> -
>>   	while (!of_parse_phandle_with_args(dev->of_node, "iommus",
>>   					   "#iommu-cells",
>>   					   idx, &iommu_spec)) {
>> @@ -476,6 +467,9 @@ static struct iommu_device *mtk_iommu_v1_probe_device(struct device *dev)
>>   		idx++;
>>   	}
>>   
>> +	if (!fwspec)
>> +		return -ENODEV;
>> +
> 
> Wrong return type here.
> 
> Please be more cautious next time and make sure to compile-test all
> changed files of a patch.

Oops, sorry, indeed that was a failure of my process - seems I need to 
be more diligent about COMPILE_TEST. Patch sent :)

Thanks a lot for the fixups!

Robin.
