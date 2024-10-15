Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 734821E7C00
	for <iommu@lists.linux.dev>; Tue, 15 Oct 2024 15:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729006651; cv=none; b=BIYW29nX9t7n88TcocXI3yBxqqzYmE1oxqLtl2g1ONxXCOXCYseRPyLwLS6PgjfklMVW+bdMr28F+w/k8XoeC2TXOQLd00OQ+TKIWVDIn7Jq7pUItC7hiZfsiXmREaVOGQ/i3IUdzHex65B9PeRgCZ5DjunQIWrC+AFcJqqpov4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729006651; c=relaxed/simple;
	bh=jIHKLLYvcMpH1boWXYI/mCtJG1/1ZWjBoHvUBhjHlYk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UL4YfhjtEZVbp3S9rmQnAiZGjq6uipIMB9fWRCTSx9fpm7UqbHVipQlLFVWLTnKfFwOXggX7+kQmaO9gYV6oXvg0LHjPaqF0jOqER9VdZUDQco4bs7SmkXDl97gG91vLU3JNwh24jWJJg+1MOwgRMuQBnEmFKb+zzBfgiB0KDdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 87583FEC;
	Tue, 15 Oct 2024 08:37:59 -0700 (PDT)
Received: from [10.57.87.12] (unknown [10.57.87.12])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5ABE13F528;
	Tue, 15 Oct 2024 08:37:27 -0700 (PDT)
Message-ID: <ce7cc76f-426f-4d19-b4be-3964647a2f2d@arm.com>
Date: Tue, 15 Oct 2024 16:37:25 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 2/2] iommu/arm-smmu-v3: Bypass SID0 for NXP i.MX95
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Pranjal Shrivastava <praan@google.com>,
 "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, Will Deacon <will@kernel.org>,
 Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Joy Zou <joy.zou@nxp.com>,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Peng Fan <peng.fan@nxp.com>
References: <20241015-smmuv3-v1-0-e4b9ed1b5501@nxp.com>
 <20241015-smmuv3-v1-2-e4b9ed1b5501@nxp.com> <Zw4kKDFOcXEC78mb@google.com>
 <20241015124723.GI1825128@ziepe.ca>
 <ab21d602-5349-47be-b346-2fbc041fa13e@arm.com>
 <20241015153110.GM1825128@ziepe.ca>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20241015153110.GM1825128@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-10-15 4:31 pm, Jason Gunthorpe wrote:
> On Tue, Oct 15, 2024 at 04:13:13PM +0100, Robin Murphy wrote:
>> On 2024-10-15 1:47 pm, Jason Gunthorpe wrote:
>>> On Tue, Oct 15, 2024 at 08:13:28AM +0000, Pranjal Shrivastava wrote:
>>>
>>>> Umm.. this was specific for rmr not a generic thing. I'd suggest to
>>>> avoid meddling with the STEs directly for acheiving bypass. Playing
>>>> with the iommu domain type could be neater. Perhaps, modify the
>>>> ops->def_domain_type to return an appropriate domain?
>>>
>>> Yeah, that is the expected way, to force the def_domain_type to
>>> IDENTITY and refuse to attach a PAGING/BLOCKED domain.
>>
>> There is no domain, this is bypassing an arbitrary StreamID not associated
>> with any device.
> 
> If the stream ID is going to flow traffic shouldn't it have a DT node
> for it? Something must be driving the DMA on this SID, and the kernel
> does need to know what that is in some way, even for basic security
> things like making sure VFIO doesn't get a hold of it :\

Exactly, hence this RFC is definitely not the right approach.

Thanks,
Robin.
