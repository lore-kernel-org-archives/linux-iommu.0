From: Lu Baolu <baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH 0/9] iommu/vt-d: Improve PASID id and table management
Date: Tue, 17 Apr 2018 11:03:13 +0800
Message-ID: <1523934202-21669-1-git-send-email-baolu.lu@linux.intel.com>
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
To: David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, sanjay.k.kumar-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, yi.y.sun-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, jacob.jun.pan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

This patch set improves the PASID id and PASID table management
for Intel IOMMU driver.

PATCH 1~3 replace per IOMMU idr name space with a global one.
Current per IOMMU idr doesn't work in some cases where one
application (associated with a PASID) might talk to two physical
devices simultaneously while the two devices could reside behind
two different IOMMU units.

PATCH 4~9 implement per domain PASID table. Current per IOMMU
PASID table implementation is insecure in the cases where
multiple devices under one single IOMMU unit support PASID
feature. With per domain PASID table, we can achieve finer
protection and isolation granularity.

Best regards,
Lu Baolu

Lu Baolu (9):
  iommu/vt-d: Global PASID name space
  iommu/vt-d: Decouple idr bond pointer from svm
  iommu/vt-d: Use global PASID for SVM usage
  iommu/vt-d: Move device_domain_info to header
  iommu/vt-d: Per domain pasid table interfaces
  iommu/vt-d: Allocate and free pasid table
  iommu/vt-d: Calculate PTS value
  iommu/vt-d: Use per-domain pasid table
  iommu/vt-d: Clean up PASID talbe management for SVM

 drivers/iommu/Makefile      |   2 +-
 drivers/iommu/intel-iommu.c | 122 +++++++++++++++------------------------
 drivers/iommu/intel-pasid.c | 135 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/iommu/intel-pasid.h |  34 +++++++++++
 drivers/iommu/intel-svm.c   |  98 ++++++++++++++++----------------
 include/linux/intel-iommu.h |  90 +++++++++++++++++++++++++++--
 6 files changed, 346 insertions(+), 135 deletions(-)
 create mode 100644 drivers/iommu/intel-pasid.c
 create mode 100644 drivers/iommu/intel-pasid.h

-- 
2.7.4
