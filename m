Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A60293FB90
	for <iommu@lists.linux.dev>; Mon, 18 Mar 2024 13:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710767110; cv=none; b=GD1HxBnZ1lKBnecuHf/Lzh5q7v8vYKWUNNo/gNXxfAccS5c4MDtGBW1ABUWbQVswxiW0yrxWF+CUick3WEQwRdOpKaDbGsw6Ebpj6J09/Hg6iD3Iy4TW36lxn9ELgVXIvDbXsdaKQJFDU/1eMibE9s9bbAN8Ldtw6alzs8bT0SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710767110; c=relaxed/simple;
	bh=ZarPO9ClVSp9miIoAdrkxdLyf33d8aB50kRIYFkoTQw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OmVukxA7/tlOu46pZHajy61ghmfUjiy80UnHa+YbWwssppVAq82mnlDhoFGukZovUbn46NgYyy0PMP4rsH+DRzKvk08eAH0eRZVY0Wb/kciKPMRi5OoIdpn93JyyzWVQnE28hPTL3byye2a5zsxPr1npPc/962JC15+JgazVOuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DCE18DA7;
	Mon, 18 Mar 2024 06:05:40 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 87B973F23F;
	Mon, 18 Mar 2024 06:05:04 -0700 (PDT)
Message-ID: <b4488238-0c05-4d06-a60d-10e00460ea98@arm.com>
Date: Mon, 18 Mar 2024 13:05:03 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] swiotlb: extend buffer pre-padding to
 alloc_align_mask if necessary
Content-Language: en-GB
To: Michael Kelley <mhklinux@outlook.com>,
 Petr Tesarik <petrtesarik@huaweicloud.com>, Christoph Hellwig <hch@lst.de>,
 Marek Szyprowski <m.szyprowski@samsung.com>, Will Deacon <will@kernel.org>,
 Nicolin Chen <nicolinc@nvidia.com>,
 "open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>,
 open list <linux-kernel@vger.kernel.org>
Cc: Roberto Sassu <roberto.sassu@huaweicloud.com>,
 Petr Tesarik <petr.tesarik1@huawei-partners.com>
References: <20240312134149.497-1-petrtesarik@huaweicloud.com>
 <SN6PR02MB4157FB27CD890E9F29408926D4282@SN6PR02MB4157.namprd02.prod.outlook.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <SN6PR02MB4157FB27CD890E9F29408926D4282@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15/03/2024 2:53 am, Michael Kelley wrote:
[...]
>> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
>> index 86fe172b5958..8ce11abc691f 100644
>> --- a/kernel/dma/swiotlb.c
>> +++ b/kernel/dma/swiotlb.c
>> @@ -69,11 +69,13 @@
>>    * @alloc_size:	Size of the allocated buffer.
>>    * @list:	The free list describing the number of free entries available
>>    *		from each index.
>> + * @padding:    Number of preceding padding slots.
>>    */
>>   struct io_tlb_slot {
>>   	phys_addr_t orig_addr;
>>   	size_t alloc_size;
>>   	unsigned int list;
>> +	unsigned int padding;
> 
> Even without the padding field, I presume that in
> 64-bit builds this struct is already 24 bytes in size so as
> to maintain 64-bit alignment for the orig_addr and
> alloc_size fields. If that's the case, then adding the
> padding field doesn't change the amount of memory
> required for the slot array.  Is that correct? Both the
> "list" and "padding" fields contain only small integers,
> but presumably reducing their size from "int" to "short"
> wouldn't help except in 32-bit builds.

Technically I think we could shrink the whole thing down to 16 bytes*, 
since just 24 bits of size should still be more than enough, with the 
remaining 8 bits similarly plenty for a padding slot count. Depends if 
we think the overall memory saving is worth the marginal extra 
complexity of packing values into bitfields.

Thanks,
Robin.


* The relevance of SWIOTLB to 32-bit builds is primarily going to be for 
PAE cases where phys_addr_t is still 64-bit.
