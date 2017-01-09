From: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH v2 0/4] Fixes for Exynos IOMMU driver
Date: Mon, 09 Jan 2017 13:03:52 +0100
Message-ID: <1483963436-29803-1-git-send-email-m.szyprowski@samsung.com>
References: <CGME20170109120410eucas1p2caf69260dc125da0d9651321eadd03ca@eucas1p2.samsung.com>
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
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Krzysztof Kozlowski <krzk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hello,

This is collection of fixes for Exynos IOMMU driver. Patches 1-2 are
resend and update of the patches, which got lost on mainline list.
Patches 3-4 solve the issue, which arises when IOMMU deferred probe
patches will be merged.

Patches are based on current iommu/next branch.

Best regards
Marek Szyprowski
Samsung R&D Institute Poland

Changelog:

v2:
- dropped "iommu/exynos: Add default_domain check in iommu_attach_device"
  patch, this is handled in iommu core
- replaced BUG_ON with proper error propagation

v1: http://www.spinics.net/lists/linux-samsung-soc/msg56354.html
- initial version

Patch summary:

Marek Szyprowski (4):
  iommu/exynos: Improve page fault debug message
  iommu/exynos: Fix warnings from DMA-debug
  iommu/exynos: Ensure that SYSMMU is added only once to its master
    device
  iommu/exynos: Properly release device from the default domain in
    ->remove

 drivers/iommu/exynos-iommu.c | 39 +++++++++++++++++++++++++++++++++------
 1 file changed, 33 insertions(+), 6 deletions(-)

-- 
1.9.1
