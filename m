From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH v3 0/3] Support for nesting IOMMUs in VFIO
Date: Tue,  2 Sep 2014 10:53:36 +0100
Message-ID: <1409651619-27342-1-git-send-email-will.deacon@arm.com>
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
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hello,

This is version three of the patches I originally posted here:

  RFCv1: http://permalink.gmane.org/gmane.linux.kernel.iommu/5552
  RFCv2: http://permalink.gmane.org/gmane.linux.kernel.iommu/5700

Changes since RFCv2 include:

  - Dropped the RFC tag
  - Rebased onto 3.17-rc*
  - Iterate the support bus_types (currently just PCI) and check that
    nesting is actually supported

The corresponding arm-smmu changes are included to show how the new
domain attribute can be used.

All feedback welcome,

Will

-->8

Will Deacon (3):
  iommu: introduce domain attribute for nesting IOMMUs
  vfio/iommu_type1: add new VFIO_TYPE1_NESTING_IOMMU IOMMU type
  iommu/arm-smmu: add support for DOMAIN_ATTR_NESTING attribute

 drivers/iommu/arm-smmu.c        | 110 ++++++++++++++++++++++++++++++++--------
 drivers/vfio/vfio_iommu_type1.c |  87 ++++++++++++++++++++++++++++---
 include/linux/iommu.h           |   1 +
 include/uapi/linux/vfio.h       |   2 +
 4 files changed, 173 insertions(+), 27 deletions(-)

-- 
2.1.0
