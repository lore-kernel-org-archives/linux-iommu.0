Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65C3678F47
	for <iommu@lists.linux.dev>; Tue, 11 Mar 2025 14:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741703876; cv=none; b=IsLKNmQf0yuVjHGaSSjRFQ8u2LH0v0oWen5c0vro6ax4/30WnALETZFhN0/opjjbwWdvBPcvWR+t1ecMX0+vNsF3buZSvZyzJbypM6WQGrrSZ5ovKDXf4hD11mGpNFNeQo88zwchUB0r4g1tSLI3UvVDkS595CzgnZKo+tF4I0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741703876; c=relaxed/simple;
	bh=xLuI5lqAjWTTmx57sgMjkb37akll+8TyZv4iWhDeumg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dFcVaqiY+szaVu+5jJwtSIeazLUFrqlezMqoOJR/D3ZRwcudXy/bjQ1KnGI9Rj2qRYxvNS1pYWciO5+5U6k/0ggDrlfJM+XVV2FbHAshpsBnYqi3QRY7lToLE29nzw3te/hXEM3Y9ER32+qp/I+chD8yJPSNS45fCRDrfx4mQR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BA4FF152B;
	Tue, 11 Mar 2025 07:38:04 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DD4E23F694;
	Tue, 11 Mar 2025 07:37:50 -0700 (PDT)
Message-ID: <58c5e76a-e320-4296-8292-1ddf3f7ba56d@arm.com>
Date: Tue, 11 Mar 2025 14:37:48 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] iommu/arm: Add BBM Level 2 smmu feature
To: Jason Gunthorpe <jgg@ziepe.ca>, Ryan Roberts <ryan.roberts@arm.com>
Cc: =?UTF-8?Q?Miko=C5=82aj_Lenczewski?= <miko.lenczewski@arm.com>,
 Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 "suzuki.poulose@arm.com" <suzuki.poulose@arm.com>,
 "yang@os.amperecomputing.com" <yang@os.amperecomputing.com>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "will@kernel.org" <will@kernel.org>, "joro@8bytes.org" <joro@8bytes.org>,
 "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
 "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "joey.gouly@arm.com" <joey.gouly@arm.com>,
 "oliver.upton@linux.dev" <oliver.upton@linux.dev>,
 "james.morse@arm.com" <james.morse@arm.com>,
 "broonie@kernel.org" <broonie@kernel.org>, "maz@kernel.org"
 <maz@kernel.org>, "david@redhat.com" <david@redhat.com>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "mshavit@google.com" <mshavit@google.com>,
 "jsnitsel@redhat.com" <jsnitsel@redhat.com>,
 "smostafa@google.com" <smostafa@google.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>
References: <20250228182403.6269-2-miko.lenczewski@arm.com>
 <20250228182403.6269-6-miko.lenczewski@arm.com>
 <20250228193221.GM5011@ziepe.ca>
 <b23aa37f8e864dea82a6143bece912d6@huawei.com>
 <20250303103102.GC13345@e133081.arm.com> <20250303165255.GS5011@ziepe.ca>
 <20250303190330.GA426248@e133081.arm.com> <20250304142634.GC5011@ziepe.ca>
 <67fbe3f4-4fb6-4753-b34c-320b7897fd16@arm.com>
 <20250304161943.GD5011@ziepe.ca>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20250304161943.GD5011@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 04/03/2025 4:19 pm, Jason Gunthorpe wrote:
> On Tue, Mar 04, 2025 at 04:02:20PM +0000, Ryan Roberts wrote:
>> On 04/03/2025 14:26, Jason Gunthorpe wrote:
>>> On Mon, Mar 03, 2025 at 07:03:42PM +0000, Mikołaj Lenczewski wrote:
>>>
>>>> For example, if we use BBML2 for kernel mappings, does that require us
>>>> to repaint all kernel mappings when disabling BBML2 on smmu attach? I
>>>> am not sure, but definitely something to be worked out.
>>>
>>> No, it would be a per-mm_struct basis only if we did something like
>>> that
>>>
>>> When the SMMU driver puts a SVA on top of the mm_struct it would
>>> disable BBML2 usage only for that mm_struct and it's contained VMAs.
>>
>> I guess we would need to figure out some synchonization mechanism if disabling
>> BBML2 dynaically per-mm. If there was already a BBML2 operation in flight would
>> want to wait for it to end. But that's a problem to solve if/when it's shown to
>> be needed, I think.
> 
> I have a feeling we can piggyback on the mmu notifiers to achieve this
> as all the changes to the PTEs should be bracketed by notifier
> callbacks..
> 
> Let's hope it isn't needed.

Yup, as mentioned previously, this is largely theoretical and at worst 
only a risk of affecting 3rd-party SMMU implementations. Arm's 
implementations from MMU-700 onwards do support BBML2; MMU-600 *might* 
actually be OK as well, but it predates the definition of the feature, 
and there are more practical reasons not to integrate a decade-old SMMU 
design with brand new CPUs anyway.

Thanks,
Robin.
