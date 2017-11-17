From: Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH v3 00/16] [PATCH v3 00/16] IOMMU driver support for SVM
	virtualization
Date: Fri, 17 Nov 2017 10:54:58 -0800
Message-ID: <1510944914-54430-1-git-send-email-jacob.jun.pan@linux.intel.com>
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
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Rafael Wysocki <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi All,

Shared virtual memory (SVM), or more precisely shared virtual address (SVA),
between device DMA and applications can reduce programming complexity
and enhance security. To enable SVM in the guest, i.e. shared guest application
address space and physical device DMA address, IOMMU driver must provide
some new functionalities.

This patchset is a follow-up on the discussions held at LPC 2017
VFIO/IOMMU/PCI track. Slides and notes can be found here:
https://linuxplumbersconf.org/2017/ocw/events/LPC2017/tracks/636

The complete guest SVM support also involves changes in QEMU and VFIO,
which has been posted earlier.
https://www.spinics.net/lists/kvm/msg148798.html

This is the IOMMU portion follow up of the more complete series of the
kernel changes to support vSVM. Please refer to the link below for more
details. https://www.spinics.net/lists/kvm/msg148819.html

Generic APIs are introduced in addition to Intel VT-d specific changes,
the goal is to have common interfaces across IOMMU and device types for
both VFIO and other in-kernel users.

At the top level, new IOMMU interfaces are introduced as follows:
 - bind guest PASID table
 - passdown invalidations of translation caches
 - IOMMU device fault reporting including page request/response and
   non-recoverable faults.

For IOMMU detected device fault reporting, struct device is extended to
provide callback and tracking at device level. The original proposal was
discussed here "Error handling for I/O memory management units"
(https://lwn.net/Articles/608914/). I have experimented two alternative
solutions:
1. use a shared group notifier, this does not scale well also causes unwanted
notification traffic when group sibling device is reported with faults.
2. place fault callback at device IOMMU arch data, e.g. device_domain_info
in Intel/FSL IOMMU driver. This will cause code duplication, since per
device fault reporting is generic.

The additional patches are Intel VT-d specific, which either implements or
replaces existing private interfaces with the generic ones.

This patchset is based on the work and ideas from many people, especially:
Ashok Raj <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Liu, Yi L <yi.l.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>

Thanks,

Jacob

V3
	- Consolidated fault reporting data format based on discussions on v2,
	  including input from ARM and AMD.
	- Renamed invalidation APIs from svm to sva based on discussions on v2
	- Use a parent pointer under struct device for all iommu per device data
	- Simplified device fault callback, allow driver private data to be
	  registered. This might make it easy to replace domain fault handler.
V2
	- Replaced hybrid interface data model (generic data + vendor specific
	data) with all generic data. This will have the security benefit where
	data passed from user space can be sanitized by all software layers if
	needed.
	- Addressed review comments from V1
	- Use per device fault report data
	- Support page request/response communications between host IOMMU and
	guest or other in-kernel users.
	- Added unrecoverable fault reporting to DMAR
	- Use threaded IRQ function for DMAR fault interrupt and fault
	reporting


Jacob Pan (15):
  iommu: introduce bind_pasid_table API function
  iommu/vt-d: add bind_pasid_table function
  iommu/vt-d: move device_domain_info to header
  iommu/vt-d: support flushing more TLB types
  iommu/vt-d: add svm/sva invalidate function
  iommu/vt-d: assign PFSID in device TLB invalidation
  iommu: introduce device fault data
  driver core: add iommu device fault reporting data
  iommu: introduce device fault report API
  iommu/vt-d: use threaded irq for dmar_fault
  iommu/vt-d: report unrecoverable device faults
  iommu/intel-svm: notify page request to guest
  iommu/intel-svm: replace dev ops with fault report API
  iommu: introduce page response function
  iommu/vt-d: add intel iommu page response function

Liu, Yi L (1):
  iommu: introduce iommu invalidate API function

 drivers/iommu/dmar.c          | 151 ++++++++++++++++-
 drivers/iommu/intel-iommu.c   | 365 +++++++++++++++++++++++++++++++++++++++---
 drivers/iommu/intel-svm.c     |  87 ++++++++--
 drivers/iommu/iommu.c         | 110 ++++++++++++-
 include/linux/device.h        |   3 +
 include/linux/dma_remapping.h |   1 +
 include/linux/intel-iommu.h   |  47 +++++-
 include/linux/intel-svm.h     |  20 +--
 include/linux/iommu.h         | 223 +++++++++++++++++++++++++-
 include/uapi/linux/iommu.h    | 101 ++++++++++++
 10 files changed, 1047 insertions(+), 61 deletions(-)
 create mode 100644 include/uapi/linux/iommu.h

-- 
2.7.4
