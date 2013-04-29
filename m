From: Suravee Suthikulanit <suravee.suthikulpanit-5C7GfCeVMHo@public.gmane.org>
Subject: RFC: IOMMU/AMD: Error Handling
Date: Mon, 29 Apr 2013 14:45:30 -0500
Message-ID: <517ECDDA.3000606@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: =?ISO-8859-1?Q?J=F6rg_R=F6del?= <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Cc: "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Joerg,

We are in the process of implementing AMD IOMMU error handling, and I 
would like some comments from you and the community.

Currently, the AMD IOMMU driver only reports events from the event log 
in the dmesg, and does not try to handle them in case of errors.  AMD 
IOMMU errors can be categorized as device-specific errors and IOMMU errors.

1. For IOMMU errors such as:
     - DEV_TAB_HADWARE_ERROR
     - PAGE_TAB_ERROR
     - COMMAND_HARDWARE_ERROR
If the error is detected during IOMMU initialization, we could disable 
IOMMU and proceed.  If the error occurs after IOMMU is initialized, we 
won't be able to recover from this, and might need to result in panic.

2. For device-specific errors such as:
     - ILLEGAL_DEV_TABLE_ENTRY
     - IO_PAGE_FAULT
     - INVALDE_DEVICE_REQUEST
We think the AMD IOMMU driver should try to isolate the device. This 
involves blocking device transactions at IOMMU DTE and tries to disable 
the device (e.g. calling the remove(struct pci_dev *pdev) interface 
generally provides by device drivers).  This could prevents the device 
from continuing to fail and to risk of system instability.

3. In case of posted memory write transaction, device driver might not 
be aware that the transaction has failed and blocked at IOMMU. If there 
is no HW IOMMU, I believe this is handled by PCI error handling code.  
If the IOMMU hardware reporth such case, could this potentially leverage 
the Linux IOMMU fault handling interface, iommu_set_fault_handler() and 
report_iommu_fault(),  to communicate to device driver or PCI driver?

Any feedback or comments are appreciated.

Thank you,
Suravee
