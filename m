Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7FE01FD7
	for <iommu@lists.linux.dev>; Tue, 21 Feb 2023 11:43:54 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BD60DFEC;
	Tue, 21 Feb 2023 03:44:30 -0800 (PST)
Received: from [10.57.13.181] (unknown [10.57.13.181])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E98323F703;
	Tue, 21 Feb 2023 03:43:46 -0800 (PST)
Message-ID: <77bf61fd-485e-7162-c0d3-c1bd7735deaa@arm.com>
Date: Tue, 21 Feb 2023 11:43:41 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: SR-IOV on ARM64 system with SMMU
To: Martin Bayern <martinbayern@outlook.com>, will@kernel.org,
 joro@8bytes.org, linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev
References: <AS8P193MB2095640357779A7F9B6026F8D2A19@AS8P193MB2095.EURP193.PROD.OUTLOOK.COM>
 <c8366f3a-3eba-6a54-558d-c87350187793@arm.com>
 <AS8P193MB209596DC2B89931C57C565BDD2A49@AS8P193MB2095.EURP193.PROD.OUTLOOK.COM>
Content-Language: en-GB
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <AS8P193MB209596DC2B89931C57C565BDD2A49@AS8P193MB2095.EURP193.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2023-02-20 19:21, Martin Bayern wrote:
> Hi Robin,
> 
> thanks for your email. the platform doesn't support ACS, so I added pcie 
> ACS override patch:
> 
> martin@ubuntu:~$ sudo dmesg | grep ACS
> [    0.000000] Warning: PCIe ACS overrides enabled; This may allow 
> non-IOMMU protected peer-to-peer DMA
> 
> but, after applying this patch, the PCIe VFs and PF are still grouped in 
> the same IOMMU group 10:
> 
> 
> martin@ubuntu:~$ find /sys/kernel/iommu_groups/ -type l
> /sys/kernel/iommu_groups/20/devices/15340000.vic
> /sys/kernel/iommu_groups/10/devices/0005:01:00.2
> /sys/kernel/iommu_groups/10/devices/0005:01:00.0
> /sys/kernel/iommu_groups/10/devices/0005:00:00.0
> /sys/kernel/iommu_groups/10/devices/0005:01:00.3
> /sys/kernel/iommu_groups/10/devices/141a0000.pcie
> 
> martin@ubuntu:~$ sudo lspci -vvt
> -+-[0005:00]---00.0-[01-ff]--+-00.0  Micron NVMe SSD Controller PCC
>   |                           +-00.2 Micron NVMe SSD Controller PCC
>   |                           \-00.3  Micron NVMe SSD Controller PCC
>   +-[0001:00]---00.0-[01-ff]----00.0  Marvell Technology Group Ltd. 
> Device 9171
>   \-[0000:00]-
> 
> 
> 
> martin@ubuntu:~$ ls -lah /sys/kernel/iommu_groups/10/devices/
> total 0
> drwxr-xr-x 2 root root 0 Feb 17 17:58 .
> drwxr-xr-x 3 root root 0 Feb 17 17:58 ..
> lrwxrwxrwx 1 root root 0 Feb 17 18:09 0005:00:00.0 -> 
> ../../../../devices/platform/141a0000.pcie/pci0005:00/0005:00:00.0
> lrwxrwxrwx 1 root root 0 Feb 17 18:09 0005:01:00.0 -> 
> ../../../../devices/platform/141a0000.pcie/pci0005:00/0005:00:00.0/0005:01:00.0
> lrwxrwxrwx 1 root root 0 Feb 17 18:09 0005:01:00.2 -> 
> ../../../../devices/platform/141a0000.pcie/pci0005:00/0005:00:00.0/0005:01:00.2
> lrwxrwxrwx 1 root root 0 Feb 17 18:09 0005:01:00.3 -> 
> ../../../../devices/platform/141a0000.pcie/pci0005:00/0005:00:00.0/0005:01:00.3
> lrwxrwxrwx 1 root root 0 Feb 17 18:09 141a0000.pcie -> 
> ../../../../devices/platform/141a0000.pcie

Oh, that's fun; the *platform* side of the PCIe root complex has somehow 
come along to the party as well. I guess the DT decided it really needed 
a StreamID?

Either way, this is the start of the answer. Until very recently[1], 
VFIO refused to touch groups whose devices spanned multiple bus types...

> IOMMU Group 10:
>      0005:00:00.0 PCI bridge [0604]: NVIDIA Corporation Device 
> [10de:1ad0] (rev a1)
>      0005:01:00.0 Non-Volatile memory controller [0108]: Micron NVMe SSD 
> Controller PCC [144d:a824]
>      0005:01:00.2 Non-Volatile memory controller [0108]: Micron NVMe SSD 
> Controller PCC [144d:a824]
>      0005:01:00.3 Non-Volatile memory controller [0108]: Micron NVMe SSD 
> Controller PCC [144d:a824]
> 
> martin@ubuntu:~$ lspci
> 0001:00:00.0 PCI bridge: NVIDIA Corporation Device 1ad2 (rev a1)
> 0001:01:00.0 SATA controller: Marvell Technology Group Ltd. Device 9171 
> (rev 13)
> 0005:00:00.0 PCI bridge: NVIDIA Corporation Device 1ad0 (rev a1)   // 
> this is PCIe bridge
> 0005:01:00.0 Non-Volatile memory controller: Micron NVMe SSD Controller 
> PCC   // this is PF
> 0005:01:00.2 Non-Volatile memory controller: Micron NVMe SSD Controller 
> PCC   // this is VF1
> 0005:01:00.3 Non-Volatile memory controller: Micron NVMe SSD Controller 
> PCC   //this is VF2
> 
> 
> 
> so after creating VFs,  bind the vfio-pci driver to the relevant 
> device(s), here I use VF1
> 
> 
> martin@ubuntu:~$ sudo modprobe -v vfio-pci
> insmod /lib/modules/5.10.104-tegra/kernel/drivers/vfio/vfio.ko
> insmod /lib/modules/5.10.104-tegra/kernel/drivers/vfio/vfio_iommu_type1.ko
> insmod /lib/modules/5.10.104-tegra/kernel/drivers/vfio/vfio_virqfd.ko
> insmod /lib/modules/5.10.104-tegra/kernel/drivers/vfio/pci/vfio-pci.ko

...so given the implication that this is an older kernel, your "internal 
error" below is almost certainly the -EINVAL from that check.

The rest of the information here also points to why you have that 
grouping, and unfortunately it appears that it's not just down to ACS 
but to a fundamental limitation of that platform. Looking at the 
upstream Tegra DTs which match that PCIe layout, it appears there's only 
a single StreamID for each whole PCIe segment. Thus all the devices and 
functions *have* to be grouped together since the SMMU has not been 
given the ability to distinguish one's traffic from another's.

Even if you could solve the platform device conundrum (which is not 
reflected in the upstream DTs, and I can't speak for whether the 
downstream kernel actually *needs* an "iommus" property there or not), 
the best you'd be able to achieve on a system like that is to give the 
whole group over to VFIO, PF and all.

Thanks,
Robin.

[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit?id=eed20c782aea57b7efb42af2905dc381268b21e9

> martin@ubuntu:~$ sudo modprobe -r vfio_iommu_type1
> 
> martin@ubuntu:~$ sudo modprobe -v vfio_iommu_type1 
> allow_unsafe_interrupts=1
> insmod 
> /lib/modules/5.10.104-tegra/kernel/drivers/vfio/vfio_iommu_type1.ko 
> allow_unsafe_interrupts=1
> 
> 
> martin@ubuntu:~$ echo vfio-pci > 
> /sys/bus/pci/devices/0005\:01\:00.2/driver_override
> 
> martin@ubuntu:~$ sudo chmod 777 -R /sys/bus/pci
> martin@ubuntu:~$ echo 0005:01:00.2 > /sys/bus/pci/drivers/nvme/unbind
> martin@ubuntu:~$ echo 144d a824 > /sys/bus/pci/drivers/vfio-pci/new_id
> martin@ubuntu:~$ sudo echo 0005:01:00.2 > /sys/bus/pci/drivers_probe
> martin@ubuntu:~$
> martin@ubuntu:~$
> 
> after that, the VF1 disappears in the nvme list, but "virsh 
> nodedev-list" still doesn't have VF PCIe, and I added VF PCIe bus in the 
> vm.xml, after start vm,
> I got this error,
> 
> martin@ubuntu:~$ virsh start --domain vm1
> error: Failed to start domain vm1
> error: internal error: Found invalid device link '141a0000.pcie' in 
> '/sys/bus/pci/devices/0005:01:00.2/iommu_group/devices' //141a0000 is 
> PCIe bridge
> 
> I checked the IOMMU group 10, VFs, PF and a PCIe bridge are still 
> grouped in the same group.
> 
> 
> do you know what else I missed?
> 
> kind regards,
> Martin
> 
> 
> On 20.02.23 2:15 PM, Robin Murphy wrote:
>> Hi Martin,
>>
>> On 2023-02-17 15:42, Martin Bayern wrote:
>>> Hello,
>>>
>>> Recently I faced the challenge of enabling SR-IOV on an ARM based 
>>> system, PCIe devices have SR-IOV capability, I enabled it and created 
>>> its VF, "lspci -nn" can also list these PF and VF PCIe nodes, but the 
>>> command  'virsh nodedev-list' lists no PCIe node devices, and the 
>>> hypervisor cannot detach the VF from the host, attaches to the 
>>> virtual machine. I checked many blogs and papers, it seems that for 
>>> ARM-based systems, we should use VFIO-PCI or pci-stub module,I tried 
>>> these commands:
>>>
>>>
>>> sudo modprobe -v vfio-pci
>>> sudo modprobe -r vfio_iommu_type1
>>> sudo modprobe -v vfio_iommu_type1 allow_unsafe_interrupts=1
>>>
>>> After that, the problem persists, do you know what else I should 
>>> check and enable? Does this require ARM64 chipset support SR-IOV? If 
>>> yes, how can I check if the CPU supports it?
>>
>> If you can successfully enable VFs, then the system supports SR-IOV as 
>> far as is relevant. Beyond that it's just regular VFIO usage - there's 
>> nothing Arm-specific about that (note that if you have a sufficiently 
>> modern system you shouldn't need allow_unsafe_interrupts either). 
>> Taking the above at face value it looks like you're missing the steps 
>> to actually bind the vfio-pci driver to the relevant device(s) - see 
>> here:
>>
>> https://www.kernel.org/doc/html/latest/driver-api/vfio.html?highlight=vfio#vfio-usage-example
>>
>> However it's also possible that you won't get usefully-assignable 
>> groups because the system doesn't support PCIe ACS (and therefore 
>> can't prevent peer-to-peer traffic between your VFs and other devices 
>> the host is still using).
>>
>> Thanks,
>> Robin.
