From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH v4 0/3] Support for nesting IOMMUs in VFIO
Date: Wed, 24 Sep 2014 10:21:22 +0100
Message-ID: <1411550485-32483-1-git-send-email-will.deacon@arm.com>
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

Hi all,

This is version four of the patches I originally posted here:

  RFCv1: http://permalink.gmane.org/gmane.linux.kernel.iommu/5552
  RFCv2: http://permalink.gmane.org/gmane.linux.kernel.iommu/5700
     v3: http://permalink.gmane.org/gmane.linux.kernel.iommu/6230

The main change since v3 is the mass simplification of the type1 IOMMU
code based on discussions with Alex. We now unconditionally advertise
support for nesting IOMMUs and postpone failure until group attach time.

Alex -- any chance you could queue the first two patches please? I'll
deal with the arm-smmu patch for 3.19.

Feedback welcome,

Will


Will Deacon (3):
  iommu: introduce domain attribute for nesting IOMMUs
  vfio/iommu_type1: add new VFIO_TYPE1_NESTING_IOMMU IOMMU type
  iommu/arm-smmu: add support for DOMAIN_ATTR_NESTING attribute

 drivers/iommu/arm-smmu.c        | 110 ++++++++++++++++++++++++++++++++--------
 drivers/vfio/vfio_iommu_type1.c |  29 ++++++++---
 include/linux/iommu.h           |   1 +
 include/uapi/linux/vfio.h       |   3 ++
 4 files changed, 117 insertions(+), 26 deletions(-)

-- 
2.1.0
