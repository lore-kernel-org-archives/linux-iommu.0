Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3EC41F4C83
	for <iommu@lists.linux.dev>; Mon,  3 Mar 2025 17:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741024071; cv=none; b=SH5UNIVOGw28uk1NKuG8fiVyqJP7Dx9g7KP6NRgzrpV4MlHmoaMYnaMBBOyUIP0BSZpWMjPyJHvqLFM8wbcgg0IwNVmPWrVrE6aog3ELbbxs+NW6GpetH0OHvWCefaUtzS+ut5+INT5QhDkOVN3RSc5dXevdadD1bS6PMOI0uxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741024071; c=relaxed/simple;
	bh=ENeLXkajZ1XmegI24iKgWhC88jOENk4HHBJ5Oq5Wa48=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HZFmkK2CZ3LqCHG4AYovFL8TR9vKjpiZHCpreaO9Ip2UPEOLjn92V7/tQbAByCa9qZJJPXoOtbwLiF/buHw2knF8I0VDXcsPMNsV7J0aub1GjmkYjSnDHQSS9HqLXamJje61Nob56e0p/ejD5e2lVw9pnjvaYaoTk6W6x0EIg/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C2923106F;
	Mon,  3 Mar 2025 09:48:02 -0800 (PST)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0B8C53F673;
	Mon,  3 Mar 2025 09:47:47 -0800 (PST)
Message-ID: <e92da382-b5a3-400a-a382-4ffb35397c81@arm.com>
Date: Mon, 3 Mar 2025 17:47:46 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu: Sort out domain user data
To: Jason Gunthorpe <jgg@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, joro@8bytes.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <4e68d5820be06adc1b34fc0d1c9399481151daee.1740742271.git.robin.murphy@arm.com>
 <Z8IapaN1ZD0wImak@Asurada-Nvidia> <20250303172746.GB133783@nvidia.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20250303172746.GB133783@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03/03/2025 5:27 pm, Jason Gunthorpe wrote:
> On Fri, Feb 28, 2025 at 12:20:53PM -0800, Nicolin Chen wrote:
>> On Fri, Feb 28, 2025 at 11:31:11AM +0000, Robin Murphy wrote:
>>> +enum iommu_domain_cookie_type {
>>> +	IOMMU_NO_COOKIE,
>>> +	IOMMU_DMA_IOVA_COOKIE,
>>> +	IOMMU_DMA_MSI_COOKIE,
>>> +	IOMMU_FAULT_HANDLER_COOKIE,
>>> +	IOMMU_SVA_COOKIE,
>>
>> I would like to change them to IOMMU_COOKIE_* so the iommufd one
>> wouldn't feel redundant like "IOMMU_IOMMUFD_COOKIE".

Heh, I guess strictly it might just be IOMMUFD_COOKIE, since what I've 
really done here is messily overlap a new IOMMU_x namespace with the 
original IOMMU_DMA_x one... :)

>> If you don't mind, I will make the following list:
>> -	IOMMU_NO_COOKIE,
>> -	IOMMU_DMA_IOVA_COOKIE,
>> -	IOMMU_DMA_MSI_COOKIE,
>> -	IOMMU_FAULT_HANDLER_COOKIE,
>> -	IOMMU_SVA_COOKIE,
>> +	IOMMU_COOKIE_NONE,
>> +	IOMMU_COOKIE_DMA_IOVA,
>> +	IOMMU_COOKIE_DMA_MSI,
>> +	IOMMU_COOKIE_FAULT_HANDLER,
>> +	IOMMU_COOKIE_SVA,
>> +	IOMMU_COOKIE_IOMMUFD,
> 
> I like that better too

...but yeah, no objection to going this way for consistency - splitting 
into IOMMU_x_DMA does seem more logical and understandable than the 
other alternative of having one weird IOMMU_FD_x symbol.

Thanks,
Robin.
