Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A68EE8C0B
	for <iommu@lists.linux.dev>; Tue, 21 Feb 2023 19:30:20 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AE4371650;
	Tue, 21 Feb 2023 11:31:02 -0800 (PST)
Received: from [10.57.13.181] (unknown [10.57.13.181])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E3B363F703;
	Tue, 21 Feb 2023 11:30:18 -0800 (PST)
Message-ID: <e182594b-5cdb-881d-59c8-a20dc90b62fb@arm.com>
Date: Tue, 21 Feb 2023 19:30:12 +0000
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
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <AS8P193MB2095CD44400D95C79C262249D2A59@AS8P193MB2095.EURP193.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2023-02-21 17:27, Martin Bayern wrote:
> Hi Robin
> 
> thanks for your replying.
> 
> On 21.02.23 12:43 PM, Robin Murphy wrote:
>> ...so given the implication that this is an older kernel, your 
>> "internal error" below is almost certainly the -EINVAL from that check.
>>
>> The rest of the information here also points to why you have that 
>> grouping, and unfortunately it appears that it's not just down to ACS 
>> but to a fundamental limitation of that platform. Looking at the 
>> upstream Tegra DTs which match that PCIe layout, it appears there's 
>> only a single StreamID for each whole PCIe segment. Thus all the 
>> devices and functions *have* to be grouped together since the SMMU has 
>> not been given the ability to distinguish one's traffic from another's.
>>
>> Even if you could solve the platform device conundrum (which is not 
>> reflected in the upstream DTs, and I can't speak for whether the 
>> downstream kernel actually *needs* an "iommus" property there or not), 
>> the best you'd be able to achieve on a system like that is to give the 
>> whole group over to VFIO, PF and all. 
> 
> I tried to apply your patch to the current v5.10 kernel, there are so 
> many sub-patches needed to be applied as well, so I give up that.  and 
> then,  I tried to give the whole group over to VFIO, PF, and VFs, I 
> cannot give the PCIe bridge to VFIO since I got a permission error. 
> after that, I saw VF is in use by vfio-pci with lspci command, but try 
> to start vm with virsh, but still got the same error.

Sorry, I probably could have been clearer - the only difference those 
recent changes will make in this case is that instead of VFIO 
automatically rejecting the group for having both PCI and platform 
devices, it would get a bit further and end up still rejecting the group 
because the platform device isn't bound to a VFIO driver. And of course 
removing the platform driver would unhelpfully make the whole PCI bus 
disappear :)

The only actual solution to that problem is to make the platform device 
not be in the group to begin with. As mentioned, that is presumably 
because the PCIe node in the DT has an "iommus = ..." property (not to 
be confused with the "iommu-map" properties which are for the PCI side). 
I'd expect you could probably get away with removing that - the only 
reason I can imagine it being functionally necessary is if the root 
complex has internal DMA engines that the downstream kernel is using.

But yeah, by that point it's arguably just an exercise in achieving 
satisfaction by making *something* work, rather than a really practical 
prospect.

> martin@ubuntu:~$ virsh start --domain vm1
> error: Failed to start domain vm1
> error: internal error: Found invalid device link '141a0000.pcie' in 
> '/sys/bus/pci/devices/0005:01:00.2/iommu_group/devices'
> 
> I'm going to completely give up on implementing SR-IOV on NVIDIA 
> platforms, too bad I posted the same question on their forum with no 
> response. So if you want to try SR-IOV on an ARM-based platform, don't 
> use an NVIDIA Orin board.
> 
> do you have any idea which ARM-based platform can be used to implement 
> SR-IOV?

As far as I'm aware, SoCs with a sensible SMMU/PCIe integration are 
still mostly up at the server end where the systems come with 4-figure 
price tags. The most accessible options off the top of my head would 
probably be network-focused SoCs like the Marvell Armada 8040 or NXP 
LX2160A/LS1088A/LS1028A.

Cheers,
Robin.
