Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A6A013776F
	for <iommu@lists.linux.dev>; Mon, 24 Jun 2024 11:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719227370; cv=none; b=rDcNxNQuGx8+UmAWzxognCjMRpcPEIOVwsrJUG+G/IHizL5NCeGNDI0hBB2Fpmf0DAqwcQe0GT5/XPL51hophWWWZp1cwgY6xoE8hWncjmcCZ/Fo2Y4MKfdM374vy8J4Vi8h8wh29sYF1dKbJDDeNpUGBwkroDuobeqZmbBsqYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719227370; c=relaxed/simple;
	bh=lLvLGmBL9ObbAsFrqs2bLSwFQlEI0fsUX/vQlv3s7jE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fw+pgCHrre0me+qsX0ILSU0/xmNTub5AxLt2jcpZ/SiDq4T0w5gi9UEe/+IkDvZY43EycHE5BESZArP1qTlWaDe8kVjqM8swb71YsQ2qI6tDDmemJA52yN71cGXz8APg9JaiQYD1zaCzfvh7Dzc0BHYtTMIcw3Uss6tE57dxvwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1DB2DDA7;
	Mon, 24 Jun 2024 04:09:52 -0700 (PDT)
Received: from [10.57.74.124] (unknown [10.57.74.124])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4C7383F73B;
	Mon, 24 Jun 2024 04:09:25 -0700 (PDT)
Message-ID: <4c941977-868a-4bd0-9c57-eb58255d95bf@arm.com>
Date: Mon, 24 Jun 2024 12:09:23 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] iommu/xen: Add Xen PV-IOMMU driver
To: Baolu Lu <baolu.lu@linux.intel.com>, Teddy Astie
 <teddy.astie@vates.tech>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: xen-devel@lists.xenproject.org, iommu@lists.linux.dev,
 Juergen Gross <jgross@suse.com>, Stefano Stabellini
 <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 =?UTF-8?Q?Marek_Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>
References: <fe36b8d36ed3bc01c78901bdf7b87a71cb1adaad.1718286176.git.teddy.astie@vates.tech>
 <20240619163000.GK791043@ziepe.ca>
 <750967b7-252f-4523-872f-64b79358c97c@vates.tech>
 <4ba90f86-fd14-4d2a-b7a0-c3eaab243565@linux.intel.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <4ba90f86-fd14-4d2a-b7a0-c3eaab243565@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024-06-23 4:21 am, Baolu Lu wrote:
> On 6/21/24 11:09 PM, Teddy Astie wrote:
>> Le 19/06/2024 à 18:30, Jason Gunthorpe a écrit :
>>> On Thu, Jun 13, 2024 at 01:50:22PM +0000, Teddy Astie wrote:
>>>
>>>> +struct iommu_domain *xen_iommu_domain_alloc(unsigned type)
>>>> +{
>>>> +    struct xen_iommu_domain *domain;
>>>> +    u16 ctx_no;
>>>> +    int ret;
>>>> +
>>>> +    if (type & IOMMU_DOMAIN_IDENTITY) {
>>>> +        /* use default domain */
>>>> +        ctx_no = 0;
>>> Please use the new ops, domain_alloc_paging and the static identity 
>>> domain.
>> Yes, in the v2, I will use this newer interface.
>>
>> I have a question on this new interface : is it valid to not have a
>> identity domain (and "default domain" being blocking); well in the
>> current implementation it doesn't really matter, but at some point, we
>> may want to allow not having it (thus making this driver mandatory).
> 
> It's valid to not have an identity domain if "default domain being
> blocking" means a paging domain with no mappings.
> 
> In the iommu driver's iommu_ops::def_domain_type callback, just always
> return IOMMU_DOMAIN_DMA, which indicates that the iommu driver doesn't
> support identity translation.

That's not necessary - if neither ops->identity_domain nor 
ops->domain_alloc(IOMMU_DOMAIN_IDENTITY) gives a valid domain then we 
fall back to IOMMU_DOMAIN_DMA anyway.

Thanks,
Robin.
