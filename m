From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH v5 0/2] Support for nesting IOMMUs in VFIO
Date: Thu, 25 Sep 2014 18:44:59 +0100
Message-ID: <1411667101-26197-1-git-send-email-will.deacon@arm.com>
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

This is version five of the patches I previously posted here:

  RFCv1: http://permalink.gmane.org/gmane.linux.kernel.iommu/5552
  RFCv2: http://permalink.gmane.org/gmane.linux.kernel.iommu/5700
     v3: http://permalink.gmane.org/gmane.linux.kernel.iommu/6230
     v4: http://permalink.gmane.org/gmane.linux.kernel.iommu/6590

Changes since v4 are:

  - Move temporary attr variable into local scope (suggested by Alex)
  - Fix memory leak of iommu on open failure
  - Added Joerg's ack to the second patch
  - Dropped the arm-smmu patch remove the series, as I'll push this
    separately

Thanks,

Will


Will Deacon (2):
  iommu: introduce domain attribute for nesting IOMMUs
  vfio/iommu_type1: add new VFIO_TYPE1_NESTING_IOMMU IOMMU type

 drivers/vfio/vfio_iommu_type1.c | 30 +++++++++++++++++++++++++-----
 include/linux/iommu.h           |  1 +
 include/uapi/linux/vfio.h       |  3 +++
 3 files changed, 29 insertions(+), 5 deletions(-)

-- 
2.1.0
