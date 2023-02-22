Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7869B5392
	for <iommu@lists.linux.dev>; Wed, 22 Feb 2023 12:38:57 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3DA5C139F;
	Wed, 22 Feb 2023 04:39:33 -0800 (PST)
Received: from [10.57.16.42] (unknown [10.57.16.42])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6BBE13F881;
	Wed, 22 Feb 2023 04:38:49 -0800 (PST)
Message-ID: <28ef1727-161d-1165-3878-08f7534f6e47@arm.com>
Date: Wed, 22 Feb 2023 12:38:44 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: SR-IOV on ARM64 system with SMMU
Content-Language: en-GB
To: Martin Bayern <martinbayern@outlook.com>, will@kernel.org,
 joro@8bytes.org, linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev
References: <AS8P193MB2095640357779A7F9B6026F8D2A19@AS8P193MB2095.EURP193.PROD.OUTLOOK.COM>
 <c8366f3a-3eba-6a54-558d-c87350187793@arm.com>
 <AS8P193MB209596DC2B89931C57C565BDD2A49@AS8P193MB2095.EURP193.PROD.OUTLOOK.COM>
 <77bf61fd-485e-7162-c0d3-c1bd7735deaa@arm.com>
 <AS8P193MB2095CD44400D95C79C262249D2A59@AS8P193MB2095.EURP193.PROD.OUTLOOK.COM>
 <e182594b-5cdb-881d-59c8-a20dc90b62fb@arm.com>
 <PAXP193MB2105A8519929AD3E4A508F25D2AA9@PAXP193MB2105.EURP193.PROD.OUTLOOK.COM>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <PAXP193MB2105A8519929AD3E4A508F25D2AA9@PAXP193MB2105.EURP193.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023-02-22 11:53, Martin Bayern wrote:
> hi Robin
> 
> Thank you so much for your support on this!
> 
> On 21.02.23 8:30 PM, Robin Murphy wrote:
>> The only actual solution to that problem is to make the platform 
>> device not be in the group to begin with. As mentioned, that is 
>> presumably because the PCIe node in the DT has an "iommus = ..." 
>> property (not to be confused with the "iommu-map" properties which are 
>> for the PCI side). I'd expect you could probably get away with 
>> removing that - the only reason I can imagine it being functionally 
>> necessary is if the root complex has internal DMA engines that the 
>> downstream kernel is using.
>>
>> But yeah, by that point it's arguably just an exercise in achieving 
>> satisfaction by making *something* work, rather than a really 
>> practical prospect
> 
> I search the keyword string "iommus" in NVIDIA Orin/Xavier related 
> dts/dtsi, but there is no iommus attribute node, nor iommu-map. Relevant 
> questions have been posted in the NVIDIA forum, and I hope NVIDIA can 
> respond. Please let me know if you have any other thoughts/suggestions. 
> I'm currently working on study of the drivers of smmu and iommu, trying 
> to figure out the root cause of it.

That sounds like the properties are getting added dynamically by the 
bootloader (or possibly an overlay), or it might be using a DTB from 
some other source entirely - I'd check under 
/sys/firmware/devicetree/base/ at runtime and/or decompile 
/sys/firmware/fdt to see what ends up actually passed to the kernel.

Unless the downstream kernel has made major changes to the IOMMU logic, 
it's the only way to explain why the SMMU driver would be aware of the 
PCI controller platform device at all.

Cheers,
Robin.
