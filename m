From: Sinan Kaya <okaya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH V7 08/11] drivers: acpi: Handle IOMMU lookup failure with
	deferred probing or error
Date: Mon, 30 Jan 2017 08:59:10 -0500
Message-ID: <14751205-f034-7f0d-442a-854c3909425c@codeaurora.org>
References: <1485188293-20263-1-git-send-email-sricharan@codeaurora.org>
	<1485188293-20263-9-git-send-email-sricharan@codeaurora.org>
	<20170124123711.GA11996@red-moon>
	<f2370671-ece8-fbee-de19-350dd625088f@codeaurora.org>
	<93e79759-d614-9b36-d5ab-63e8eb725009@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <93e79759-d614-9b36-d5ab-63e8eb725009-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>, Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, Tomasz Nowicki <tn-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 1/30/2017 7:22 AM, Robin Murphy wrote:
> On 29/01/17 17:53, Sinan Kaya wrote:
>> On 1/24/2017 7:37 AM, Lorenzo Pieralisi wrote:
>>> [+hanjun, tomasz, sinan]
>>>
>>> It is quite a key patchset, I would be glad if they can test on their
>>> respective platforms with IORT.
>>>
>>
>> Tested on top of 4.10-rc5.
>>
>> 1.	Platform Hidma device passed dmatest
>> 2.	Seeing some USB stalls on a platform USB device.
>> 3.	PCIe NVME drive probed and worked fine with MSI interrupts after boot.
>> 4. 	NVMe driver didn't probe following a hotplug insertion and received an
>> SMMU error event during the insertion.
> 
> What was the SMMU error - a translation/permission fault (implying the
> wrong DMA ops) or a bad STE fault (implying we totally failed to tell
> the SMMU about the device at all)?
> 

root@ubuntu:/sys/bus/pci/slots/4# echo 0 > power

[__204.698522]_iommu:_Removing_device_0003:01:00.0_from_group_0
[  204.708704] pciehp 0003:00:00.0:pcie004: Slot(4): Link Down
[  204.708723] pciehp 0003:00:00.0:pcie004: Slot(4): Link Down event ignored; already powering off

root@ubuntu:/sys/bus/pci/slots/4#

[__254.820440]_iommu:_Adding_device_0003:01:00.0_to_group_8
[  254.820599] nvme nvme0: pci function 0003:01:00.0
[  254.820621] nvme 0003:01:00.0: enabling device (0000 -> 0002)
[  261.948558] arm-smmu-v3 arm-smmu-v3.0.auto: event 0x0a received:
[  261.948561] arm-smmu-v3 arm-smmu-v3.0.auto:  0x000001000000000a
[  261.948563] arm-smmu-v3 arm-smmu-v3.0.auto:  0x0000000000000000
[  261.948564] arm-smmu-v3 arm-smmu-v3.0.auto:  0x0000000000000000
[  261.948566] arm-smmu-v3 arm-smmu-v3.0.auto:  0x0000000000000000
root@ubuntu:/sys/bus/pci/slots/4#

root@ubuntu:/sys/bus/pci/slots/4#ls /dev/nvme*
/dev/nvme0

I should have seen /dev/nvme0n1 partition here. 

> Robin.
> 
>>
>> /sys/bus/pci/slots/4 #
>> /sys/bus/pci/slots/4 # dmesg | grep nvme
>> [   14.041357] nvme nvme0: pci function 0003:01:00.0
>> [  198.399521] nvme nvme0: pci function 0003:01:00.0
>> [__198.416232]_nvme_0003:01:00.0:_enabling_device_(0000_->_0002)
>> [  264.402216] nvme nvme0: I/O 228 QID 0 timeout, disable controller
>> [  264.402313] nvme nvme0: Identify Controller failed (-4)
>> [  264.421270] nvme nvme0: Removing after probe failure status: -5
>> /sys/bus/pci/slots/4 #
>>
>>
>>
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
