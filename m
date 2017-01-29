From: Sinan Kaya <okaya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH V7 08/11] drivers: acpi: Handle IOMMU lookup failure with
	deferred probing or error
Date: Sun, 29 Jan 2017 12:53:57 -0500
Message-ID: <f2370671-ece8-fbee-de19-350dd625088f@codeaurora.org>
References: <1485188293-20263-1-git-send-email-sricharan@codeaurora.org>
	<1485188293-20263-9-git-send-email-sricharan@codeaurora.org>
	<20170124123711.GA11996@red-moon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20170124123711.GA11996@red-moon>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>, Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, Tomasz Nowicki <tn-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 1/24/2017 7:37 AM, Lorenzo Pieralisi wrote:
> [+hanjun, tomasz, sinan]
> 
> It is quite a key patchset, I would be glad if they can test on their
> respective platforms with IORT.
> 

Tested on top of 4.10-rc5.

1.	Platform Hidma device passed dmatest
2.	Seeing some USB stalls on a platform USB device.
3.	PCIe NVME drive probed and worked fine with MSI interrupts after boot.
4. 	NVMe driver didn't probe following a hotplug insertion and received an
SMMU error event during the insertion.

/sys/bus/pci/slots/4 #
/sys/bus/pci/slots/4 # dmesg | grep nvme
[   14.041357] nvme nvme0: pci function 0003:01:00.0
[  198.399521] nvme nvme0: pci function 0003:01:00.0
[__198.416232]_nvme_0003:01:00.0:_enabling_device_(0000_->_0002)
[  264.402216] nvme nvme0: I/O 228 QID 0 timeout, disable controller
[  264.402313] nvme nvme0: Identify Controller failed (-4)
[  264.421270] nvme nvme0: Removing after probe failure status: -5
/sys/bus/pci/slots/4 #



-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
