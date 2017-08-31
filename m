From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH v2 0/4] SMMUv3 CMD_SYNC optimisation
Date: Thu, 31 Aug 2017 14:44:24 +0100
Message-ID: <cover.1504182142.git.robin.murphy@arm.com>
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
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, sgoutham-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi all,

Since Nate reported a reasonable performance boost from the out-of-line
MSI polling in v1 [1], I've now implemented the equivalent for cons
polling as well - that has been boot-tested on D05 with some trivial I/O
and at least doesn't seem to lock up or explode. There's also a little
cosmetic tweaking to make the patches a bit cleaner as a series.

Robin.

[1] https://www.mail-archive.com/iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org/msg19657.html

Robin Murphy (5):
  iommu/arm-smmu-v3: Specialise CMD_SYNC handling
  iommu/arm-smmu-v3: Forget about cmdq-sync interrupt
  iommu/arm-smmu-v3: Use CMD_SYNC completion interrupt
  iommu/arm-smmu-v3: Poll for CMD_SYNC outside cmdq lock
  iommu/arm-smmu-v3: Use burst-polling for sync completion

 drivers/iommu/arm-smmu-v3.c | 194 ++++++++++++++++++++++++++++++--------------
 1 file changed, 135 insertions(+), 59 deletions(-)

-- 
2.13.4.dirty
