From: valmiki <valmikibow@gmail.com>
Subject: Re: [RFC PATCH 21/30] iommu/arm-smmu-v3: Handle device faults from
 PRI
Date: Sat, 25 Mar 2017 10:46:34 +0530
Message-ID: <0b3e3ddd-acc3-5ba7-639f-5c9192da57c3@gmail.com>
References: <20170227195441.5170-1-jean-philippe.brucker@arm.com>
 <20170227195441.5170-22-jean-philippe.brucker@arm.com>
 <8520D5D51A55D047800579B0941471982640F43C@XAP-PVEXMBX02.xlnx.xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <8520D5D51A55D047800579B0941471982640F43C@XAP-PVEXMBX02.xlnx.xilinx.com>
Sender: linux-pci-owner@vger.kernel.org
To: jean-philippe.brucker@arm.com, linux-pci-owner@vger.kernel.org, harba@qti.qualcomm.com, Will Deacon <will.deacon@arm.com>, Shanker Donthineni <shankerd@qti.qualcomm.com>, Bjorn Helgaas <bhelgaas@google.com>, Sinan Kaya <okaya@qti.qualcomm.com>, lorenzo.pieralisi@arm.com, Catalin Marinas <catalin.marinas@arm.com>, Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, Nate Watterson <nwatters@qti.qualcomm.com>, Alex Williamson <alex.williamson@redhat.com>, David Woodhouse <dwmw2@infradead.org>, linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org, kvm@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

> When we receive a PRI Page Request (PPR) from the SMMU, it contains a context identifier SID:SSID, an IOVA and the requested access flags.
>
> Search the domain corresponding to SID:SSID, and call handle_mm_fault on its mm. If memory management is able to fix the fault, we ask the device to retry the access with a PRI_SUCCESS message. Otherwise send PRI_FAIL.
>
Hi Jean,

I need some clarification. Page fault handling is already part of MMU. 
When PRI requested page results in page fault, smmu is going to invoke 
handle_mm_fault which is part of memory management unit ?

If so this functionality is yet to be added in SMMU driver ?

Because i haven't seen this API being called in your patches.

Regards,
Valmiki
