From: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Subject: Re: [PATCH] iommu/amd: Assign default IOMMU when there is only one
 IOMMU
Date: Wed, 16 Dec 2015 00:20:03 -0600
Message-ID: <56710293.6010701@amd.com>
References: <1449874478-31770-1-git-send-email-Suravee.Suthikulpanit@amd.com>
 <20151214150805.GE11292@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151214150805.GE11292@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
List-Id: iommu@lists.linux-foundation.org

Hi Joerg,

On 12/14/2015 09:08 AM, Joerg Roedel wrote:
> On Fri, Dec 11, 2015 at 04:54:38PM -0600, Suravee Suthikulpanit wrote:
>> Current driver makes assumption that device with devid zero is always
>> included in the range of devices to be managed by IOMMU. However,
>> certain FW does not include devid zero in IVRS table.
>> This has caused IOMMU perf driver to fail to initialize.
>
> Hmm, this is a firmware bug. Is this bug seen in any systems that are
> for sale?
>
>> This patch implements a workaround for this case by always assign
>> devid zero to be handled by the first IOMMU.
>
> Otherwise its better to fix the firmware than to add workarounds.
>
>
> 	Joerg
>

Please correct me if I am wrong. But I don't think this is necessary a 
bug in the FW. From the CZ system, here are the IVHD device entry dump 
that belong to this IOMMU:

[    0.070351] AMD-Vi: device: 00:00.2 cap: 0040 seg: 0 flags: b8 info 0000
[    0.070354] AMD-Vi:        mmio-addr: 00000000feb80000
[    0.070384] AMD-Vi:   DEV_SELECT_RANGE_START     devid: 00:01.0 flags: 00
[    0.070386] AMD-Vi:   DEV_RANGE_END         devid: ff:1f.6
[    0.071414] AMD-Vi:   DEV_ALIAS_RANGE         devid: ff:00.0 flags: 
00 devid_to: 00:14.4
[    0.071417] AMD-Vi:   DEV_RANGE_END         devid: ff:1f.7
[    0.071423] AMD-Vi:   DEV_SPECIAL(HPET[0])        devid: 00:14.0
[    0.071426] AMD-Vi:   DEV_SPECIAL(IOAPIC[0])        devid: 00:14.0
[    0.071427] AMD-Vi:   DEV_SPECIAL(IOAPIC[1])        devid: 00:00.1

And here is the output from lspci:

00:00.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Device 1576
00:00.2 IOMMU: Advanced Micro Devices, Inc. [AMD] Device 1577
00:01.0 VGA compatible controller: Advanced Micro Devices, Inc. 
[AMD/ATI] Device 9874 (rev c4)
00:01.1 Audio device: Advanced Micro Devices, Inc. [AMD/ATI] Device 9840
00:02.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Device 157b
00:02.4 PCI bridge: Advanced Micro Devices, Inc. [AMD] Device 157c
00:03.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Device 157b
00:03.1 PCI bridge: Advanced Micro Devices, Inc. [AMD] Device 157c
00:08.0 Encryption controller: Advanced Micro Devices, Inc. [AMD] Device 
1578
00:09.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Device 157d
00:09.2 Audio device: Advanced Micro Devices, Inc. [AMD] Device 157a
00:10.0 USB controller: Advanced Micro Devices, Inc. [AMD] FCH USB XHCI 
Controller (rev 20)
00:11.0 SATA controller: Advanced Micro Devices, Inc. [AMD] FCH SATA 
Controller [AHCI mode] (rev 49)
00:12.0 USB controller: Advanced Micro Devices, Inc. [AMD] FCH USB EHCI 
Controller (rev 49)
00:14.0 SMBus: Advanced Micro Devices, Inc. [AMD] FCH SMBus Controller 
(rev 4a)
00:14.3 ISA bridge: Advanced Micro Devices, Inc. [AMD] FCH LPC Bridge 
(rev 11)
00:14.7 SD Host controller: Advanced Micro Devices, Inc. [AMD] FCH SD 
Flash Controller (rev 01)
00:18.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Device 1570
00:18.1 Host bridge: Advanced Micro Devices, Inc. [AMD] Device 1571
00:18.2 Host bridge: Advanced Micro Devices, Inc. [AMD] Device 1572
00:18.3 Host bridge: Advanced Micro Devices, Inc. [AMD] Device 1573
00:18.4 Host bridge: Advanced Micro Devices, Inc. [AMD] Device 1574
00:18.5 Host bridge: Advanced Micro Devices, Inc. [AMD] Device 1575
01:00.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5720 
Gigabit Ethernet PCIe
01:00.1 Ethernet controller: Broadcom Corporation NetXtreme BCM5720 
Gigabit Ethernet PCIe
02:00.0 Ethernet controller: Intel Corporation 82599ES 10-Gigabit 
SFI/SFP+ Network Connection (rev 01)
02:00.1 Ethernet controller: Intel Corporation 82599ES 10-Gigabit 
SFI/SFP+ Network Connection (rev 01)

The IVHD seems valid. We should not need to include from devid 0 if it 
has already specified the IOAPIC[1] separately.

Thanks,
Suravee
