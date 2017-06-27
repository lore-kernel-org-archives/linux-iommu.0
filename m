From: Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [RFC 0/9] IOMMU driver support for shared virtual memory
	virtualization
Date: Tue, 27 Jun 2017 12:47:54 -0700
Message-ID: <1498592883-56224-1-git-send-email-jacob.jun.pan@linux.intel.com>
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
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Tian, Kevin" <kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Shared virtual memory (SVM) space between devices and applications can
reduce programming complexity and enhance security. To enable SVM in
the guest, i.e. share guest application address space with physical
device DMA address, IOMMU driver must provide some new functionalities.

The complete guest SVM support also involves changes in QEMU and VFIO,
which has been posted earlier.
https://www.spinics.net/lists/kvm/msg148798.html

This is the IOMMU portion follow up of the more complete series of the
kernel changes to support SVM. Please refer to the link below for more
details. https://www.spinics.net/lists/kvm/msg148819.html

Generic APIs are introduced in addition to Intel VT-d specific changes,
the goal is to have common interfaces across IOMMU and device types for
both VFIO and other in-kernel users.

At the top level, three new IOMMU interfaces are introduced:
 - bind PASID table
 - passdown invalidation
 - per device IOMMU fault notification

The additional patches are Intel VT-d specific, which either implements or
replaces existing private interfaces with the generic ones.

Thanks,

Jacob


Jacob Pan (8):
  iommu: Introduce bind_pasid_table API function
  iommu/vt-d: add bind_pasid_table function
  iommu/vt-d: Add iommu do invalidate function
  iommu: Introduce fault notifier API
  iommu/vt-d: track device with pasid table bond to a guest
  iommu/dmar: notify unrecoverable faults
  iommu/intel-svm: notify page request to guest
  iommu/intel-svm: replace dev ops with generic fault notifier

Liu, Yi L (1):
  iommu: Introduce iommu do invalidate API function

 drivers/iommu/dmar.c          |  38 ++++++++-
 drivers/iommu/intel-iommu.c   | 177 +++++++++++++++++++++++++++++++++++++-----
 drivers/iommu/intel-svm.c     | 102 +++++++++++++++++++++---
 drivers/iommu/iommu.c         |  77 ++++++++++++++++++
 include/linux/dma_remapping.h |   1 +
 include/linux/intel-iommu.h   |  30 ++++++-
 include/linux/intel-svm.h     |  20 +----
 include/linux/iommu.h         |  59 ++++++++++++++
 include/uapi/linux/iommu.h    |  85 ++++++++++++++++++++
 9 files changed, 540 insertions(+), 49 deletions(-)
 create mode 100644 include/uapi/linux/iommu.h

-- 
2.7.4
