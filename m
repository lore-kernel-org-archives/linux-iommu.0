From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH 0/4] Genericise the IOVA allocator
Date: Mon, 12 Jan 2015 17:51:12 +0000
Message-ID: <cover.1420822848.git.robin.murphy@arm.com>
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
To: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: will.deacon-5wv7dgnIgG8@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi all,

Here's an update of my previous RFC[1] in preparation for hooking the
IOVA allocator up to the arm64 DMA mapping API, rebased onto 3.19-rc3.

I tried rebasing patches 3 and 4 onto Sakari's RFC series[2] (the merge
conflict is pretty trivial), however I found that series applied to rc3
causes a build error in intel-iommu.c. Thus for now I've left in my
simpler patches 1 and 2 for breaking out the library. Hopefully we can
reach some consensus on that.

Tested on arm64 (DMA mapping series coming soon), and compile-tested
for x86_64_defconfig.

Changes since RFC:
Patch 1: Use a proper Kconfig symbol rather than a hack
Patch 4: sanity check for powers of two also, and clarify the comment

[1]:http://thread.gmane.org/gmane.linux.kernel.iommu/7480
[2]:http://thread.gmane.org/gmane.linux.kernel.iommu/7436

Robin Murphy (4):
  iommu: allow building iova.c independently
  iommu: consolidate IOVA allocator code
  iommu: make IOVA domain low limit flexible
  iommu: make IOVA domain page size explicit

 drivers/iommu/Kconfig       |  4 ++++
 drivers/iommu/Makefile      |  3 ++-
 drivers/iommu/intel-iommu.c | 45 ++++++++++----------------------------
 drivers/iommu/iova.c        | 53 +++++++++++++++++++++++++++++++++++++++++----
 include/linux/iova.h        | 41 +++++++++++++++++++++++++++++++----
 5 files changed, 103 insertions(+), 43 deletions(-)

-- 
1.9.1
