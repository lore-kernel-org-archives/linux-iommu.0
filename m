From: Lu Baolu <baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH v4 0/9] iommu/vt-d: Improve PASID id and table management
Date: Mon,  9 Jul 2018 13:22:49 +0800
Message-ID: <1531113778-28238-1-git-send-email-baolu.lu@linux.intel.com>
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
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, sanjay.k.kumar-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, yi.y.sun-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, jacob.jun.pan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi,

This patch set improves the PASID id and PASID table management
for Intel IOMMU driver.

PATCH 1~3 replace per IOMMU idr name space with a global one.
Current per IOMMU idr doesn't work in some cases where one
application (associated with a PASID) might talk to two physical
devices simultaneously while the two devices could reside behind
two different IOMMU units.

PATCH 4~9 implement per device PASID table. Current per IOMMU
PASID table implementation is insecure in the cases where
multiple devices under one single IOMMU unit support PASID
feature. With per domain PASID table, we can achieve finer
protection and isolation granularity. This has been discussed
at https://lkml.org/lkml/2018/5/16/154.

Best regards,
Lu Baolu

Change log:
v1->v2:
  - Patches have been reviewed by "Liu Yi L <yi.l.liu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>".
  - An error case handling was added in PATCH 6/9.
  - Some commit messages are refined to be more accurate.
v2->v3:
  - Patches rebased on top of v4.18-rc1.
  - Replace per-domain with per-device pasid table.
v3->v4:
  - Patches rebased on top of Joerg's x86/vt-d branch.

Lu Baolu (9):
  iommu/vt-d: Global PASID name space
  iommu/vt-d: Avoid using idr_for_each_entry()
  iommu/vt-d: Apply global PASID in SVA
  iommu/vt-d: Move device_domain_info to header
  iommu/vt-d: Add for_each_device_domain() helper
  iommu/vt-d: Per PCI device pasid table interfaces
  iommu/vt-d: Allocate and free pasid table
  iommu/vt-d: Apply per pci device pasid table in SVA
  iommu/vt-d: Remove the obsolete per iommu pasid tables

 drivers/iommu/Makefile      |   2 +-
 drivers/iommu/intel-iommu.c | 143 ++++++++++++--------------
 drivers/iommu/intel-pasid.c | 238 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/iommu/intel-pasid.h |  39 ++++++++
 drivers/iommu/intel-svm.c   |  79 ++++++---------
 include/linux/intel-iommu.h |  72 +++++++++++++-
 6 files changed, 440 insertions(+), 133 deletions(-)
 create mode 100644 drivers/iommu/intel-pasid.c
 create mode 100644 drivers/iommu/intel-pasid.h

-- 
2.7.4
