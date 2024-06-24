Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CECC1FC08
	for <iommu@lists.linux.dev>; Mon, 24 Jun 2024 17:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719250575; cv=none; b=sjaEdQF0J4yjHpwKfeTQW79yt1X+0YnN5ab+LaZMetDPSqhXprtDtjhmX42PaJo8WOSHopXoQgFRNzLOLdNj2KbVioD5Q551Zk5DloNqzS4GHGskm9IFTxg+MTY7r1ljlr3jWLgC/UzJB7WPvEhC+ZcyOdLPwuET22AkVr5AK/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719250575; c=relaxed/simple;
	bh=sOowh0xhHtvu3M7hx/XJKzu3l/ehSo/m5VZI2Ue3U+s=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=rEo4kInnxVh49mc/jtMA7sYkzNCaMO3bb4iI26+BSVskm7tnulA432stytIMEKPTzHQXH0FHKF5K1MLjldJqZwuemIv/629tY77Ov5yoRVVfhVNEtd/crOI68IW9KA/mGqodkOyVTATNuVojQmaUxUHxZRCPaHH7vSm9jB7lNVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=VVCfWIl7; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="VVCfWIl7"
Received: from [192.168.49.54] (c-73-118-245-227.hsd1.wa.comcast.net [73.118.245.227])
	by linux.microsoft.com (Postfix) with ESMTPSA id EC03920B7001;
	Mon, 24 Jun 2024 10:36:12 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com EC03920B7001
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1719250573;
	bh=eyV8+Wg7rnqJN5ZB9yu5wi+VOQhkLpSVFBwuzs99BlA=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=VVCfWIl7rgyeYeV8qIBFhuEhQtA9/ytKRfyRl/4eY4ANSsdOSMWk2mdcUDzvdZmAe
	 4GO6WjN3LwG820PLck1snRRlElpxqRpeCd3Rm3dT7S93RgHw/IxDmLU514kEfk1qlM
	 342hnCK2Z3orW9MBS5LKS1er7VB5BKCVvhhoPL7I=
Message-ID: <900edf8a-885c-4bf3-84bd-5e7b165a1ed7@linux.microsoft.com>
Date: Mon, 24 Jun 2024 10:36:13 -0700
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: eahariha@linux.microsoft.com, Robin Murphy <robin.murphy@arm.com>,
 xen-devel@lists.xenproject.org, iommu@lists.linux.dev,
 Juergen Gross <jgross@suse.com>, Stefano Stabellini
 <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 =?UTF-8?Q?Marek_Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>
Subject: Re: [RFC PATCH v2] iommu/xen: Add Xen PV-IOMMU driver
To: Jason Gunthorpe <jgg@ziepe.ca>, Teddy Astie <teddy.astie@vates.tech>
References: <24d7ec005e77e4e0127995ba6f4ad16f33737fa5.1718981216.git.teddy.astie@vates.tech>
 <da3ec316-b001-4711-b323-70af3e6bb014@arm.com>
 <a04e169d-b38a-43dc-b783-a8af1e1b0468@vates.tech>
 <20240624163254.GT791043@ziepe.ca>
Content-Language: en-US
From: Easwar Hariharan <eahariha@linux.microsoft.com>
In-Reply-To: <20240624163254.GT791043@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Jason,

On 6/24/2024 9:32 AM, Jason Gunthorpe wrote:
> On Mon, Jun 24, 2024 at 02:36:45PM +0000, Teddy Astie wrote:
>>>> +bool xen_iommu_capable(struct device *dev, enum iommu_cap cap)
>>>> +{
>>>> +    switch (cap) {
>>>> +    case IOMMU_CAP_CACHE_COHERENCY:
>>>> +        return true;
>>>
>>> Will the PV-IOMMU only ever be exposed on hardware where that really is
>>> always true?
>>>
>>
>> On the hypervisor side, the PV-IOMMU interface always implicitely flush
>> the IOMMU hardware on map/unmap operation, so at the end of the
>> hypercall, the cache should be always coherent IMO.
> 
> Cache coherency is a property of the underlying IOMMU HW and reflects
> the ability to prevent generating transactions that would bypass the
> cache.
> 
> On AMD and Intel IOMMU HW this maps to a bit in their PTEs that must
> always be set to claim this capability.
> 
> No ARM SMMU supports it yet.
> 

Unrelated to this patch: Both the arm-smmu and arm-smmu-v3 drivers claim
this capability if the device tree/IORT table have the corresponding flags.

I read through DEN0049 to determine what are the knock-on effects, or
equivalently the requirements to set those flags in the IORT, but came
up empty. Could you help with what I'm missing to resolve the apparent
contradiction between your statement and the code?

Thanks,
Easwar
