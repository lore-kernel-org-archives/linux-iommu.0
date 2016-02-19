From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH 0/6] iommu/arm-smmu: Current patch queue for 4.6
Date: Fri, 19 Feb 2016 17:46:37 +0000
Message-ID: <1455904003-28069-1-git-send-email-will.deacon@arm.com>
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
Cc: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, jroedel-l3A5Bk7waGM@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hello,

Here's the current state of my ARM SMMU queue for 4.6. I plan to send a
pull to Joerg next week.

We're *nearly* there with the default domain stuff, but we're just
missing the actual swizzling of the DMA ops, which is needed to support
VFIO (when we bind the device back to the host, it ends up in the default
domain). I reckon we'll get that sorted for 4.7, which would allow us
to fault DMA transactions by default for devices that we don't know
about.

Cheers,

Will

--->8

Anup Patel (1):
  of: iommu: Increment DT node refcount in of_iommu_set_ops()

Robin Murphy (3):
  iommu/arm-smmu: Treat all device transactions as unprivileged
  iommu/arm-smmu: Support DMA-API domains
  iommu/arm-smmu: Allow disabling unmatched stream bypass

Will Deacon (2):
  iommu/arm-smmu: Don't fail device attach if already attached to a
    domain
  iommu/arm-smmu: Treat IOMMU_DOMAIN_DMA as bypass for now

 drivers/iommu/arm-smmu-v3.c | 50 +++++++++++++++-------------
 drivers/iommu/arm-smmu.c    | 79 ++++++++++++++++++++++++++++-----------------
 drivers/iommu/of_iommu.c    |  1 +
 3 files changed, 78 insertions(+), 52 deletions(-)

-- 
2.1.4
