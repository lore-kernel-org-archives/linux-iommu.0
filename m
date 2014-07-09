From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: [RFC PATCHv2 0/3] Support for nesting IOMMUs in VFIO
Date: Wed,  9 Jul 2014 19:28:43 +0100
Message-ID: <1404930526-32119-1-git-send-email-will.deacon@arm.com>
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

This is v2 of the RFC I originally posted here:

 RFCv1: http://permalink.gmane.org/gmane.linux.kernel.iommu/5552

It's changed significantly since then, based on helpful feedback from
Alex. In particular, I no longer butcher the IOMMU API, instead making
use of a new iommu_attr to indicate that a domain requires support for
nesting.

All feedback welcome (this is still an RFC after all),

Cheers,

Will


Will Deacon (3):
  iommu: introduce domain attribute for nesting IOMMUs
  vfio/iommu_type1: add new VFIO_TYPE1_NESTING_IOMMU IOMMU type
  iommu/arm-smmu: add support for DOMAIN_ATTR_NESTING attribute

 drivers/iommu/arm-smmu.c        | 112 +++++++++++++++++++++++++++++++++-------
 drivers/vfio/vfio_iommu_type1.c |  56 +++++++++++++++++---
 include/linux/iommu.h           |   1 +
 include/uapi/linux/vfio.h       |   2 +
 4 files changed, 144 insertions(+), 27 deletions(-)

-- 
2.0.0
