From: "Li, Zhen-Hua" <zhen-hual-VXdhtT5mjnY@public.gmane.org>
Subject: [PATCH 0/5] iommu/vt-d: Fix crash dump failure caused by legacy DMA/IO
Date: Tue, 21 Oct 2014 16:04:14 +0800
Message-ID: <1413878659-1383-1-git-send-email-zhen-hual@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
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
To: dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, indou.takao-+CUm20s59erQFUHtdCDX3A@public.gmane.org, bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Cc: tom.vaden-VXdhtT5mjnY@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kexec-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, lisa.mitchell-VXdhtT5mjnY@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Li, Zhen-Hua" <zhen-hual-VXdhtT5mjnY@public.gmane.org>, doug.hatch-VXdhtT5mjnY@public.gmane.org, ishii.hironobu-+CUm20s59erQFUHtdCDX3A@public.gmane.org, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, li.zhang6-VXdhtT5mjnY@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

The following series implements a fix for:
A kdump problem about DMA that has been discussed for a long time.
That is, when a kernel panics and boots into the kdump kernel, DMA that was
started by the panicked kernel is not stopped before the kdump kernel is booted;
and the kdump kernel disables the IOMMU while this DMA continues.
This causes the IOMMU to stop translating the DMA addresses as IOVAs and
begin to treat them as physical memory addresses -- which causes the DMA to either:
1. generate DMAR errors or
2. generate PCI SERR errors or
3. transfer data to or from incorrect areas of memory.
Often this causes the dump to fail.

This patch set modifies the behavior of the Intel iommu in the crashdump kernel: 
1. to accept the iommu hardware in an active state,
2. to leave the current translations in-place so that legacy DMA will continue
   using its current buffers until the device drivers in the crashdump kernel
   initialize and initialize their devices,
3. to use different portions of the iova address ranges for the device drivers
   in the crashdump kernel than the iova ranges that were in-use at the time
   of the panic.  

Advantages of this approach:
1. All manipulation of the IO-device is done by the Linux device-driver
   for that device.
2. This approach behaves in a manner very similar to operation without an
   active iommu.
3. Any activity between the IO-device and its RMRR areas is handled by the
   device-driver in the same manner as during a non-kdump boot.
4. If an IO-device has no driver in the kdump kernel, it is simply left alone.
   This supports the practice of creating a special kdump kernel without
   drivers for any devices that are not required for taking a crashdump. 
5. Minimal code-changes among the existing mainline intel-iommu code.

Summary of changes in this patch set:
1. Updated to a more current top-of-tree and merged the code with the
   large number of changes that were recently taken-in to intel-iommu.c
2. Returned to the structure of a patch-set
3. Enabled the intel-iommu driver to consist of multiple *.c files
   by moving many of the #defines, prototypes, and inline functions
   into a new file: intel-iommu-private.h (First three patches implement
   only this enhancement -- could be applied independent of the last 5)
4. Moved the new "crashdump fix" code into a new file: intel-iommu-kdump.c 
5. Removed the pr_debug constructs from the new code that implements the
   "crashdump fix" -- making the code much cleaner and easier to read.
6. Miscellaneous cleanups such as enum-values for return-codes.
7. Simplified the code that retrieves the values needed to initialize a new
   domain by using the linked-list of previously-collected values
   instead of stepping back into the tree of translation tables.

Original version by Bill Sumner:
	https://lkml.org/lkml/2014/4/24/836

Changed in this version:
	Split the original patchset into two sets. This patchset includes 
	4~8 patches in the original set.

Bill Sumner (5):
  iommu/vt-d: Update iommu_attach_domain() and its callers
  iommu/vt-d: Items required for kdump
  iommu/vt-d: data types and functions used for kdump
  iommu/vt-d: Add domain-id functions
  iommu/vt-d: enable kdump support in iommu module

 drivers/iommu/intel-iommu.c | 829 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 803 insertions(+), 26 deletions(-)

-- 
2.0.0-rc0
