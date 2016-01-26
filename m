From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH 0/4] Miscellaneous ARM SMMU patches
Date: Tue, 26 Jan 2016 18:06:33 +0000
Message-ID: <cover.1453830752.git.robin.murphy@arm.com>
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
To: will.deacon-5wv7dgnIgG8@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, tchalamarla-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Will,

Here's my current "miscellaneous SMMU enhancements" branch for your
consideration. Patch #1 solves a subtle corner case that cropped up
while exercising stage 1 context formats on the DMA330-MMU500 model;
#3 will be wanted fairly soon for DMA ops integration so may as well
get some exposure now; #2 and #4 are more nice-to-haves.

Thanks,
Robin.

Robin Murphy (4):
  iommu/arm-smmu: Treat all device transactions as unprivileged
  iommu/arm-smmu: Allow disabling unmatched stream bypass
  iommu/arm-smmu: Support DMA-API domains
  iommu/arm-smmu: Use per-context TLB sync as appropriate

 drivers/iommu/arm-smmu-v3.c | 10 +++++-
 drivers/iommu/arm-smmu.c    | 79 ++++++++++++++++++++++++++++++++++-----------
 2 files changed, 69 insertions(+), 20 deletions(-)

-- 
2.7.0.25.gfc10eb5.dirty
