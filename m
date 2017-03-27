From: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [RFC PATCH 21/30] iommu/arm-smmu-v3: Handle device faults from PRI
Date: Mon, 27 Mar 2017 12:05:47 +0100
Message-ID: <132394da-38e9-1722-833e-88303463ca4c@arm.com>
References: <20170227195441.5170-1-jean-philippe.brucker@arm.com>
	<20170227195441.5170-22-jean-philippe.brucker@arm.com>
	<8520D5D51A55D047800579B0941471982640F43C@XAP-PVEXMBX02.xlnx.xilinx.com>
	<0b3e3ddd-acc3-5ba7-639f-5c9192da57c3@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <0b3e3ddd-acc3-5ba7-639f-5c9192da57c3-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: valmiki <valmikibow-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-pci-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, harba-Rm6X0d1/PG5y9aJCnZT0Uw@public.gmane.org, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Shanker Donthineni <shankerd-Rm6X0d1/PG5y9aJCnZT0Uw@public.gmane.org>, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Sinan Kaya <okaya-Rm6X0d1/PG5y9aJCnZT0Uw@public.gmane.org>, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Nate Watterson <nwatters-Rm6X0d1/PG5y9aJCnZT0Uw@public.gmane.org>, Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Valmiki,

On 25/03/17 05:16, valmiki wrote:
>> When we receive a PRI Page Request (PPR) from the SMMU, it contains a
>> context identifier SID:SSID, an IOVA and the requested access flags.
>>
>> Search the domain corresponding to SID:SSID, and call handle_mm_fault on
>> its mm. If memory management is able to fix the fault, we ask the device
>> to retry the access with a PRI_SUCCESS message. Otherwise send PRI_FAIL.
>>
> Hi Jean,
> 
> I need some clarification. Page fault handling is already part of MMU.
> When PRI requested page results in page fault, smmu is going to invoke
> handle_mm_fault which is part of memory management unit ?

Yes, the SMMU driver calls into the memory management code.

> If so this functionality is yet to be added in SMMU driver ?
>
> Because i haven't seen this API being called in your patches.

This patch implements the fault handling part:

(1) A PRI Page Request (PPR) is received by arm_smmu_handle_ppr. It is
    forwarded to work queue fault_queue
(2) The PPR is handled by arm_smmu_handle_fault, which calls
    _arm_smmu_handle_fault, which calls arm_smmu_handle_mm_fault and
    finally handle_mm_fault.
(3) We send a response via arm_smmu_fault_reply

Thanks,
Jean-Philippe
