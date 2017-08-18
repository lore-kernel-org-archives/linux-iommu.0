From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH 0/3] SMMUv3 CMD_SYNC optimisation
Date: Fri, 18 Aug 2017 18:33:01 +0100
Message-ID: <cover.1503075486.git.robin.murphy@arm.com>
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
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi all,

Waiting for the command queue to drain for CMD_SYNC completion is likely
a contention hotspot on high-core-count systems. If the SMMU is coherent
and supports MSIs, though, we can use this cool feature (as suggested by
the architecture, no less) to make syncs effectively non-blocking for
anyone other than the caller.

I don't have any hardware that supports MSIs, but this has at least
passed muster on the Fast Model with cache modelling enabled - I'm hoping
the Qualcomm machines have the appropriate configuration to actually test
how well it works in reality. If it is worthwhile, I do have most of a
plan for how we can do something similar in the non-MSI polling case (it's
mostly a problem of handling the queue-wrapping edge cases correctly).

Robin.


Robin Murphy (3):
  iommu/arm-smmu-v3: Specialise CMD_SYNC handling
  iommu/arm-smmu-v3: Forget about cmdq-sync interrupt
  iommu/arm-smmu-v3: Utilise CMD_SYNC MSI feature

 drivers/iommu/arm-smmu-v3.c | 117 +++++++++++++++++++++++++++++---------------
 1 file changed, 77 insertions(+), 40 deletions(-)

-- 
2.13.4.dirty
