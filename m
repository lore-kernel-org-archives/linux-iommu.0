From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH v2 0/8] io-pgtable lock removal
Date: Thu, 22 Jun 2017 16:53:49 +0100
Message-ID: <cover.1498145008.git.robin.murphy@arm.com>
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
To: will.deacon-5wv7dgnIgG8@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org
Cc: sunil.goutham-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org, thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, wangzhou1-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, ray.jui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linu.cherian-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

The feedback has been promising, so v2 is just a final update to cover
a handful of memory ordering and cosmetic tweaks that came up when Will
and I went through this offline.

Thanks,
Robin.


Robin Murphy (8):
  iommu/io-pgtable-arm-v7s: Check table PTEs more precisely
  iommu/io-pgtable-arm: Improve split_blk_unmap
  iommu/io-pgtable-arm-v7s: Refactor split_blk_unmap
  iommu/io-pgtable: Introduce explicit coherency
  iommu/io-pgtable-arm: Support lockless operation
  iommu/io-pgtable-arm-v7s: Support lockless operation
  iommu/arm-smmu: Remove io-pgtable spinlock
  iommu/arm-smmu-v3: Remove io-pgtable spinlock

 drivers/iommu/arm-smmu-v3.c        |  36 ++-----
 drivers/iommu/arm-smmu.c           |  48 ++++------
 drivers/iommu/io-pgtable-arm-v7s.c | 179 +++++++++++++++++++++-------------
 drivers/iommu/io-pgtable-arm.c     | 191 ++++++++++++++++++++++++-------------
 drivers/iommu/io-pgtable.h         |   6 ++
 5 files changed, 274 insertions(+), 186 deletions(-)

-- 
2.12.2.dirty
