Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66E0B5256
	for <iommu@lists.linux.dev>; Fri, 12 Jul 2024 15:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720798456; cv=none; b=tuDm2i0Wu6ic9yHzE/4u6cEE4WQ3nB7uD7sXxeJxrS1cpyuqLaMfhAlolmiHc0m5YjL40+RbIFz6Qu6t5qa/351xi/Nm1qD8U2wxLo3U+3oIEW5i9sqMkdIfrNJsZFbhNApTS5YLvgr34/Q/z5gvq/kkQY9GtmEG/BmNMSCf8Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720798456; c=relaxed/simple;
	bh=SJIRZyX/ICybBrUmTLIKHvNwu1kYDLFaZJHiXyqtHTo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nwCFCabMcJOwFTn9JdnzvaZwUNmazxmGvB5OTHZIAofjpyAsrmB9GAqiV+Wds5T2JREwLkB/jC/ynvSxvOfIdekR9da2L6Lqxtdx7QLecw8+AfTjwFlAAYErJCafo1Oicw7MHhvF0yIlfyRDA91PNxbw9ZMJahlnKkKs/8qmVDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DB6631007;
	Fri, 12 Jul 2024 08:34:39 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6DF5C3F762;
	Fri, 12 Jul 2024 08:34:12 -0700 (PDT)
Message-ID: <96c1f2ff-7cb6-42bb-92fc-ab64ba8c1060@arm.com>
Date: Fri, 12 Jul 2024 16:34:11 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/5] iommu: Resolve fwspec ops automatically
To: Will Deacon <will@kernel.org>
Cc: Jon Hunter <jonathanh@nvidia.com>, Joerg Roedel <joro@8bytes.org>,
 linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
 devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>,
 Saravana Kannan <saravanak@google.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Hanjun Guo
 <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@arm.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Andy Shevchenko <andy.shevchenko@gmail.com>, Yong Wu <yong.wu@mediatek.com>,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <cover.1719919669.git.robin.murphy@arm.com>
 <0e2727adeb8cd73274425322f2f793561bdc927e.1719919669.git.robin.murphy@arm.com>
 <0eec5f84-6b39-43ba-ab2f-914688a5cf45@nvidia.com>
 <01c05fb2-16ce-450c-befb-8a92ac2a8af9@arm.com>
 <ee24cb5f-d170-41d3-9928-5507b8ab22a7@nvidia.com>
 <82624cf6-98ad-47df-8dcd-368117600805@arm.com>
 <20240712153137.GC16474@willie-the-truck>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20240712153137.GC16474@willie-the-truck>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/07/2024 4:31 pm, Will Deacon wrote:
> On Fri, Jul 12, 2024 at 04:28:37PM +0100, Robin Murphy wrote:
>> On 12/07/2024 4:24 pm, Jon Hunter wrote:
>>>
>>> On 12/07/2024 12:48, Robin Murphy wrote:
>>>
>>> ...
>>>
>>>>> I am seeing some failures on -next with some of our devices.
>>>>> Bisect is pointing to this commit. Looks like the host1x device
>>>>> is no longer probing successfully. I see the following ...
>>>>>
>>>>> ï¿½ï¿½tegra-host1x 50000000.host1x: failed to initialize fwspec: -517
>>>>> ï¿½ï¿½nouveau 57000000.gpu: failed to initialize fwspec: -517
>>>>>
>>>>> The probe seems to be deferred forever. The above is seen on
>>>>> Tegra210 but Tegra30 and Tegra194 are also having the same
>>>>> problem. Interestingly it is not all devices and so make me
>>>>> wonder if we are missing something on these devices? Let me know
>>>>> if you have any thoughts.
>>>>
>>>> Ugh, tegra-smmu has been doing a complete nonsense this whole time -
>>>> on closer inspection, it's passing the fwnode of the *client device*
>>>> where it should be that of the IOMMU device :(
>>>>
>>>> I *think* it should probably just be a case of:
>>>>
>>>> -ï¿½ï¿½ï¿½ err = iommu_fwspec_init(dev, of_fwnode_handle(dev->of_node));
>>>> +ï¿½ï¿½ï¿½ err = iommu_fwspec_init(dev, of_fwnode_handle(smmu->dev->of_node));
>>>>
>>>> since smmu->dev appears to be the same one initially passed to
>>>> iommu_device_register(), so it at least ought to match and work, but
>>>> the SMMU device vs. MC device thing leaves me mildly wary of how
>>>> correct it might be overall.
>>>>
>>>> (Also now I'm wondering why I didn't just use dev_fwnode() there...)
>>>
>>>
>>> Yes making that change in the tegra-smmu driver does fix it.
>>
>> Ace, thanks for confirming! I was just writing a follow-up to say that I've
>> pretty much convinced myself that this (proper diff below) should in fact be
>> the right thing to do in general as well :)
>>
>> Will, Joerg, would you prefer to have a standalone fix patch for the
>> nvidia/tegra branch to then re-merge fwspec-ops-removal and fix up the
>> conflict, or just a patch on top of fwspec-ops-removal as below?
> 
> I've just fixed it locally on the tegra branch, so I'll then just
> resolve the conflict with fwspec-ops-removal the right way. That way, we
> can backport the thing if we need to.

Cool, thanks for taking care of it!

Robin.
