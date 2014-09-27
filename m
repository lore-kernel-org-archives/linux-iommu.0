From: Mitchel Humpherys <mitchelh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: [PATCH v2 0/2] iommu/arm-smmu: hard iova_to_phys
Date: Sat, 27 Sep 2014 14:31:51 -0700
Message-ID: <1411853513-9571-1-git-send-email-mitchelh@codeaurora.org>
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
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

This series introduces support for performing iova-to-phys translations via
the ARM SMMU hardware on supported implementations. We also make use of
some new generic macros for polling hardware registers.

Changes since v1:

  - Renamed one of the iopoll macros to use the more standard `_atomic'
    suffix
  - Removed some convenience iopoll wrappers to encourage explicitness


Matt Wagantall (1):
  iopoll: Introduce memory-mapped IO polling macros

Mitchel Humpherys (1):
  iommu/arm-smmu: add support for iova_to_phys through ATS1PR

 drivers/iommu/arm-smmu.c | 73 ++++++++++++++++++++++++++++++++++++++++++++-
 include/linux/iopoll.h   | 77 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 149 insertions(+), 1 deletion(-)
 create mode 100644 include/linux/iopoll.h

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
