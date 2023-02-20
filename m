Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05olkn2074.outbound.protection.outlook.com [40.92.91.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5938497
	for <iommu@lists.linux.dev>; Mon, 20 Feb 2023 19:21:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Os7GtlLipoBSCDn6HCQpez9ZcL54vv+I6Z0dH7QlAo1bDbHaTGD44/kYHIsqlqfExAezzWFa7MW6qKE4oCbugnzTTAJzETUmlrqsjHFEGvq3bdNhY1rISXGtZ9Gi6k6cQjkn7x7ImKS9EvsNUpsxgKvO2WoBNh8JM8uoXIKUIuhFoM7veEm2FZrZA4hXSZueGiJ6XgU8lEOPWUFc5Og8R1vsL6LZmRz8/v1kf6GcoPIrSXzaOYgyRntVKPCMiq8qQg5XjCWOXzdsCSRLX6l+HDqmK0T+JuYiP6pD0O3dCimdju74BGSkp+9K2roKM6T2Wua7kccp0v5xvuV8k5GDpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9iBjaZre3pYH7hpVb0UtHPOugvxi0R80kH+p5qw4Lt8=;
 b=TkuBlAgLO54GzrGVltAwm8Uc0PhQTrXJTaafjnvdexEpQKJIG/+tdZ2L/7vUs/UUgTe/QJhrnPtYaJXrwjd2VNE0hgc1XtrV95h5fjOs98ThgJTSx2+Ga4by5xEOhkLOVTyyvmUH44+ISoSOtCGMGa1pp/VVLmVWX3rTeAlGU/0Q7KFcpU0UW7NKk+V4hj5FCAKcln7ws87L9jdpuk+AXhMk7XP8RXdmmgsDYjHL2WavtFpb0sADkPndcNrChNUGsXH0wZSqKFZCi8e7LQZx4QYc5FD+9vxRIl2NdVadEiSJEqVCeeUF3NgEkWk0YD1vr7aXt0p3D7NXawpC+TPJdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9iBjaZre3pYH7hpVb0UtHPOugvxi0R80kH+p5qw4Lt8=;
 b=eHo5YN9/0rGtKQIv119ef001KMl5h3ZC3jnQ7MZbbHBCpq+O9xy0DUb8d9okTUatks5q/+xIU1wtjVcS46S1dh7kHxQBTu8COIEnDm2aWaFg96YrNabgxSgPiyIe+fKQZqA/2QuTmsYN30jjw0F8adhd09S+NxtQO7chfTBA1l4PgsLINLZG8gnOjbAaxXivPRxv9vvZyPKpILN/Y0CZMaZXeGDqk5LfDeLUcDrgaV/KyX0CYJcSQoi2qQR3nCKZ2wbyiRA/0emh10wWciPYlIZEPEMJSG/+rTXSkKZF0+lEiD5sZ1EXjf50rX0mnx8Qzv0ccZWCa70GFKcD8igCqg==
Received: from AS8P193MB2095.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:40e::16)
 by DU2P193MB2226.EURP193.PROD.OUTLOOK.COM (2603:10a6:10:2ff::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.20; Mon, 20 Feb
 2023 19:21:45 +0000
Received: from AS8P193MB2095.EURP193.PROD.OUTLOOK.COM
 ([fe80::3d5a:43b6:acd8:3be8]) by AS8P193MB2095.EURP193.PROD.OUTLOOK.COM
 ([fe80::3d5a:43b6:acd8:3be8%9]) with mapi id 15.20.6111.021; Mon, 20 Feb 2023
 19:21:45 +0000
Message-ID:
 <AS8P193MB209596DC2B89931C57C565BDD2A49@AS8P193MB2095.EURP193.PROD.OUTLOOK.COM>
Date: Mon, 20 Feb 2023 20:21:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: SR-IOV on ARM64 system with SMMU
Content-Language: en-US
To: Robin Murphy <robin.murphy@arm.com>, will@kernel.org, joro@8bytes.org,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev
References: <AS8P193MB2095640357779A7F9B6026F8D2A19@AS8P193MB2095.EURP193.PROD.OUTLOOK.COM>
 <c8366f3a-3eba-6a54-558d-c87350187793@arm.com>
From: Martin Bayern <martinbayern@outlook.com>
In-Reply-To: <c8366f3a-3eba-6a54-558d-c87350187793@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TMN: [vsuXEWkN8FllBZM7lGEcPj3NSUKdMAuE]
X-ClientProxiedBy: ZR2P278CA0062.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:52::10) To AS8P193MB2095.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:40e::16)
X-Microsoft-Original-Message-ID:
 <54e0899b-cbb8-403e-a7ae-38515a48373c@outlook.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P193MB2095:EE_|DU2P193MB2226:EE_
X-MS-Office365-Filtering-Correlation-Id: f7ae06a7-82db-4452-ff6e-08db1377b472
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7ILCIdCbEHmse/Ed8KsQJuiYgaHJOLj9BpTIpXcYcHXga8uVuD4sOj8JRQaSi8IxiijmL1GETZPiR6JpKXLwFGl5k/wCB9GVFVww/bU1htKC211NBR0v1N6MRVF6D11cvoO+IdamVFY9he3q+SxNmrHS2WYRt5tmSvgk9k5rWgXeYoVVaJRU1Qzps+VT1ugWFu5bjhBPG2RKQ9MHIyTRFwx/1iqhLuOMeumoe9An/7F5LfIsdnbf5jmYcwMX9IBRoPlIAHJMblokIG6pQxALeTPgDkI5xO5onwq91r3bE/U7iBW9I8NWmJbWsxTCO/vMK8HQJIHuPT2P/UHtYWgC0k0YeVVk2brTlqcOUszrdSakujMHN9ZObtCOjYIlg9EX3ESs8956dyxFY653XhD+A/96OYduzm+sB1zCegU+haDgctSuygz7O4lUqgl9LFAbBeByl/kfubpmOGp07Xi1vb0yCeBH04FQblTrVtmrRBV9PvDFX+0+IEQOsLFXoat95BgGIyE5bQfO3zIJYN+VDBwJ7e7JxAHaIvxfVc9oUnKcdeFmFmlKIOpIc2yyBXnGS5bKP0xpAgtl2Ilxv/dnvG050KNbS++DPSA02NQaX9J+QQxDgO5TAhWEZM/3YSw/xP5Ggadt/DShGJSqw+FBVw==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VHIwdmtVQ1o5NXpicy9VTzVJVk1VWXlQOUFqMVlKMVlmU1BadmNMRE1FcUtI?=
 =?utf-8?B?aVloaVZPNzcxQmU4Q0hTWXV1MW50dW9NUDFoOUtzYjIvTlVvMU53VVZaK0l2?=
 =?utf-8?B?Z1FSUzd5VEJSZGY0RDIxdExkNGNKUHpmT0VDUnE4cjltUHFtS0lucE5GVkh2?=
 =?utf-8?B?RERJRkZwVGJOOXVReEI0R1IxRzQ0VEdjUDZnSFNXN3dKTFo2MzNlOFY2RVpy?=
 =?utf-8?B?SkY4SU12cW9IS01VWVFVSHgwTHpTMEpjUW1PQU1xaW0wU0lYVUE1a21yR0ZN?=
 =?utf-8?B?NnBaS1JNL0lzM1RjWFh6U1o0TCtpbHRWZHM5bGFha1lSc3k5TTZrR0EydkhD?=
 =?utf-8?B?ZjFEU1V2cmE0ci9aMUM0SEcwUzk2SHlSZlZWWGc4NHJZYko5K0Rjb252dnlm?=
 =?utf-8?B?cmk5Sms1L0Q5K2VaN0o4U2gzaUVPSlozM3o1aHNtNTE0a3hxbmhoOE1hTndD?=
 =?utf-8?B?YWN4YndSNWc3UHNTK1hJckViaUlKdmVSSlJVNmdtdmxaVHRaeUhsZEo0dmpT?=
 =?utf-8?B?OXI2Y2Ixbk5YTTI5Q0N4ZXZsSkp3eERRTGZNUlRKdW1ReXExZ1NNN3N1emxZ?=
 =?utf-8?B?clY1Rm9RVy95WVdiaW9uckt6VnljVS9LZGRURlFPNVpvS3BrR1dDV1FuTzZ4?=
 =?utf-8?B?T2d6VTNneitsZHI5L3RtajlvU0F2YmhmSlo2dlRpTTNKOU5JOXBzVFErZ05u?=
 =?utf-8?B?MUtXazFpaVVRV1VhUnBQMG9HVGJUbWFuTUpKMnFCV0hUalRyYVlCcVAvWXRu?=
 =?utf-8?B?UjN5eldqWUxLQ1E2T0RXaW1LUFZDdDdiYnJtellJbWRHV0hCMGs1b0U5ODYr?=
 =?utf-8?B?c1kwMml4Nzk2V3IwakxLMFdSTXhwREhpRlNMNVh0YitFSmQzVmxzUk9COXg2?=
 =?utf-8?B?NEROa2tQVzR5OTV2dW9KeHpLcXNmWnJlWnhjY2xHSFQ2cmtQZ3FFY3dlbVA3?=
 =?utf-8?B?cHZxTzZSSEFEcXlBYVc4VE96Mmw2Y1JIOUdRclFkYy9LUjJicGhMUFZwRDVu?=
 =?utf-8?B?bWRGeVV0enR5ejBLS0lPdmJqQVlvS2UzS3FlWFQ2cTIwdXNQcnltTmtwVGdU?=
 =?utf-8?B?NmpyTFBqeXRGMjRhOVBzTnJUbDRiRUtqSzRaU0JMdUxnbEw2MkJoQVZhVGhr?=
 =?utf-8?B?b2pMaWFXOS93cHU3TlBKYlk2VlFMalBNQklueUFKUXpPVHRsZmhQRXE2cng5?=
 =?utf-8?B?ckhKQlVFTHZnbUEwVFRRaFZJZHdZVnhvdVByQjZ5K3NJMHlFSFdUa3ZjYzNu?=
 =?utf-8?B?Q081aklpSXdWcXl4T1Y0akJjNm9HYnJNcVRTZDZleDZWc0I4Rk5yL1FaTEpi?=
 =?utf-8?B?YjdPQnFyV3d1ZUQ5R2s5Nm45YkVUeGJHbmtKWmNmVGtIZnM5U1QzNEFCYkFz?=
 =?utf-8?B?ZFNZRFZuMDJyempHVGRWN1hUWmJnQ1lVT3RGWTcxSFd4M25TMkp1YU9OWWI5?=
 =?utf-8?B?Tk1kcGlqUFZDOXYzRUNMK2VzVjZyZGlzYzlrcHJmSEpEdVc0L0RIRi94VFJV?=
 =?utf-8?B?WlYvSGdidE43VjY4am5rdzh6VWdOVFg4RkFWd3VNdTFvU0ZvVWVZUW1sR0pD?=
 =?utf-8?B?bitudjA5T1cveXhML1VYd2xjVVd5VXZBS04ycXluK0xjdVZQYXhjUGpBZVVn?=
 =?utf-8?B?RjV6ZDFIZ0g1MUhWMkVrdzVRbzNBaTdUZUFTcUdvaGkxWXkxV2xVV3NMMHQ1?=
 =?utf-8?B?OUE2MzlWVkg0WG9LRjNYVjJFZ2grTEFMelVNUVJvQ1g4dmxISkcrN0NMZTNQ?=
 =?utf-8?Q?//esVDG15KgLSXly1I=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7ae06a7-82db-4452-ff6e-08db1377b472
X-MS-Exchange-CrossTenant-AuthSource: AS8P193MB2095.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2023 19:21:45.5652
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2P193MB2226

Hi Robin,

thanks for your email. the platform doesn't support ACS, so I added  
pcie ACS override patch:

martin@ubuntu:~$ sudo dmesg | grep ACS
[    0.000000] Warning: PCIe ACS overrides enabled; This may allow 
non-IOMMU protected peer-to-peer DMA

but, after applying this patch, the PCIe VFs and PF are still grouped in 
the same IOMMU group 10:


martin@ubuntu:~$ find /sys/kernel/iommu_groups/ -type l
/sys/kernel/iommu_groups/20/devices/15340000.vic
/sys/kernel/iommu_groups/10/devices/0005:01:00.2
/sys/kernel/iommu_groups/10/devices/0005:01:00.0
/sys/kernel/iommu_groups/10/devices/0005:00:00.0
/sys/kernel/iommu_groups/10/devices/0005:01:00.3
/sys/kernel/iommu_groups/10/devices/141a0000.pcie

martin@ubuntu:~$ sudo lspci -vvt
-+-[0005:00]---00.0-[01-ff]--+-00.0  Micron NVMe SSD Controller PCC
  |                           +-00.2 Micron NVMe SSD Controller PCC
  |                           \-00.3  Micron NVMe SSD Controller PCC
  +-[0001:00]---00.0-[01-ff]----00.0  Marvell Technology Group Ltd. 
Device 9171
  \-[0000:00]-



martin@ubuntu:~$ ls -lah /sys/kernel/iommu_groups/10/devices/
total 0
drwxr-xr-x 2 root root 0 Feb 17 17:58 .
drwxr-xr-x 3 root root 0 Feb 17 17:58 ..
lrwxrwxrwx 1 root root 0 Feb 17 18:09 0005:00:00.0 -> 
../../../../devices/platform/141a0000.pcie/pci0005:00/0005:00:00.0
lrwxrwxrwx 1 root root 0 Feb 17 18:09 0005:01:00.0 -> 
../../../../devices/platform/141a0000.pcie/pci0005:00/0005:00:00.0/0005:01:00.0
lrwxrwxrwx 1 root root 0 Feb 17 18:09 0005:01:00.2 -> 
../../../../devices/platform/141a0000.pcie/pci0005:00/0005:00:00.0/0005:01:00.2
lrwxrwxrwx 1 root root 0 Feb 17 18:09 0005:01:00.3 -> 
../../../../devices/platform/141a0000.pcie/pci0005:00/0005:00:00.0/0005:01:00.3
lrwxrwxrwx 1 root root 0 Feb 17 18:09 141a0000.pcie -> 
../../../../devices/platform/141a0000.pcie


IOMMU Group 10:
     0005:00:00.0 PCI bridge [0604]: NVIDIA Corporation Device 
[10de:1ad0] (rev a1)
     0005:01:00.0 Non-Volatile memory controller [0108]: Micron NVMe SSD 
Controller PCC [144d:a824]
     0005:01:00.2 Non-Volatile memory controller [0108]: Micron NVMe SSD 
Controller PCC [144d:a824]
     0005:01:00.3 Non-Volatile memory controller [0108]: Micron NVMe SSD 
Controller PCC [144d:a824]

martin@ubuntu:~$ lspci
0001:00:00.0 PCI bridge: NVIDIA Corporation Device 1ad2 (rev a1)
0001:01:00.0 SATA controller: Marvell Technology Group Ltd. Device 9171 
(rev 13)
0005:00:00.0 PCI bridge: NVIDIA Corporation Device 1ad0 (rev a1)   // 
this is PCIe bridge
0005:01:00.0 Non-Volatile memory controller: Micron NVMe SSD Controller 
PCC   // this is PF
0005:01:00.2 Non-Volatile memory controller: Micron NVMe SSD Controller 
PCC   // this is VF1
0005:01:00.3 Non-Volatile memory controller: Micron NVMe SSD Controller 
PCC   //this is VF2



so after creating VFs,  bind the vfio-pci driver to the relevant 
device(s), here I use VF1


martin@ubuntu:~$ sudo modprobe -v vfio-pci
insmod /lib/modules/5.10.104-tegra/kernel/drivers/vfio/vfio.ko
insmod /lib/modules/5.10.104-tegra/kernel/drivers/vfio/vfio_iommu_type1.ko
insmod /lib/modules/5.10.104-tegra/kernel/drivers/vfio/vfio_virqfd.ko
insmod /lib/modules/5.10.104-tegra/kernel/drivers/vfio/pci/vfio-pci.ko

martin@ubuntu:~$ sudo modprobe -r vfio_iommu_type1

martin@ubuntu:~$ sudo modprobe -v vfio_iommu_type1 
allow_unsafe_interrupts=1
insmod 
/lib/modules/5.10.104-tegra/kernel/drivers/vfio/vfio_iommu_type1.ko 
allow_unsafe_interrupts=1


martin@ubuntu:~$ echo vfio-pci > 
/sys/bus/pci/devices/0005\:01\:00.2/driver_override

martin@ubuntu:~$ sudo chmod 777 -R /sys/bus/pci
martin@ubuntu:~$ echo 0005:01:00.2 > /sys/bus/pci/drivers/nvme/unbind
martin@ubuntu:~$ echo 144d a824 > /sys/bus/pci/drivers/vfio-pci/new_id
martin@ubuntu:~$ sudo echo 0005:01:00.2 > /sys/bus/pci/drivers_probe
martin@ubuntu:~$
martin@ubuntu:~$

after that, the VF1 disappears in the nvme list, but "virsh 
nodedev-list" still doesn't have VF PCIe, and I added VF PCIe bus in the 
vm.xml, after start vm,
I got this error,

martin@ubuntu:~$ virsh start --domain vm1
error: Failed to start domain vm1
error: internal error: Found invalid device link '141a0000.pcie' in 
'/sys/bus/pci/devices/0005:01:00.2/iommu_group/devices' //141a0000 is 
PCIe bridge

I checked the IOMMU group 10, VFs, PF and a PCIe bridge are still 
grouped in the same group.


do you know what else I missed?

kind regards,
Martin


On 20.02.23 2:15 PM, Robin Murphy wrote:
> Hi Martin,
>
> On 2023-02-17 15:42, Martin Bayern wrote:
>> Hello,
>>
>> Recently I faced the challenge of enabling SR-IOV on an ARM based 
>> system, PCIe devices have SR-IOV capability, I enabled it and created 
>> its VF, "lspci -nn" can also list these PF and VF PCIe nodes, but the 
>> command  'virsh nodedev-list' lists no PCIe node devices, and the 
>> hypervisor cannot detach the VF from the host, attaches to the 
>> virtual machine. I checked many blogs and papers, it seems that for 
>> ARM-based systems, we should use VFIO-PCI or pci-stub module,I tried 
>> these commands:
>>
>>
>> sudo modprobe -v vfio-pci
>> sudo modprobe -r vfio_iommu_type1
>> sudo modprobe -v vfio_iommu_type1 allow_unsafe_interrupts=1
>>
>> After that, the problem persists, do you know what else I should 
>> check and enable? Does this require ARM64 chipset support SR-IOV? If 
>> yes, how can I check if the CPU supports it?
>
> If you can successfully enable VFs, then the system supports SR-IOV as 
> far as is relevant. Beyond that it's just regular VFIO usage - there's 
> nothing Arm-specific about that (note that if you have a sufficiently 
> modern system you shouldn't need allow_unsafe_interrupts either). 
> Taking the above at face value it looks like you're missing the steps 
> to actually bind the vfio-pci driver to the relevant device(s) - see 
> here:
>
> https://www.kernel.org/doc/html/latest/driver-api/vfio.html?highlight=vfio#vfio-usage-example 
>
>
> However it's also possible that you won't get usefully-assignable 
> groups because the system doesn't support PCIe ACS (and therefore 
> can't prevent peer-to-peer traffic between your VFs and other devices 
> the host is still using).
>
> Thanks,
> Robin.
