Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D7712F4B
	for <iommu@lists.linux.dev>; Mon, 20 Feb 2023 13:15:53 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2FA6215BF;
	Mon, 20 Feb 2023 05:16:35 -0800 (PST)
Received: from [10.57.76.145] (unknown [10.57.76.145])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5D36C3F881;
	Mon, 20 Feb 2023 05:15:51 -0800 (PST)
Message-ID: <c8366f3a-3eba-6a54-558d-c87350187793@arm.com>
Date: Mon, 20 Feb 2023 13:15:47 +0000
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
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <AS8P193MB2095640357779A7F9B6026F8D2A19@AS8P193MB2095.EURP193.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Martin,

On 2023-02-17 15:42, Martin Bayern wrote:
> Hello,
> 
> Recently I faced the challenge of enabling SR-IOV on an ARM based 
> system, PCIe devices have SR-IOV capability, I enabled it and created 
> its VF, "lspci -nn" can also list these PF and VF PCIe nodes, but the 
> command  'virsh nodedev-list' lists no PCIe node devices, and the 
> hypervisor cannot detach the VF from the host, attaches to the virtual 
> machine. I checked many blogs and papers, it seems that for ARM-based 
> systems, we should use VFIO-PCI or pci-stub module,I tried these commands:
> 
> 
> sudo modprobe -v vfio-pci
> sudo modprobe -r vfio_iommu_type1
> sudo modprobe -v vfio_iommu_type1 allow_unsafe_interrupts=1
> 
> After that, the problem persists, do you know what else I should check 
> and enable? Does this require ARM64 chipset support SR-IOV? If yes, how 
> can I check if the CPU supports it?

If you can successfully enable VFs, then the system supports SR-IOV as 
far as is relevant. Beyond that it's just regular VFIO usage - there's 
nothing Arm-specific about that (note that if you have a sufficiently 
modern system you shouldn't need allow_unsafe_interrupts either). Taking 
the above at face value it looks like you're missing the steps to 
actually bind the vfio-pci driver to the relevant device(s) - see here:

https://www.kernel.org/doc/html/latest/driver-api/vfio.html?highlight=vfio#vfio-usage-example

However it's also possible that you won't get usefully-assignable groups 
because the system doesn't support PCIe ACS (and therefore can't prevent 
peer-to-peer traffic between your VFs and other devices the host is 
still using).

Thanks,
Robin.
