From: Simon Xue <xxm-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: [PATCH V3 1/3] Docs: dt: rockchip: add rockchip,
	disable-mmu-reset property
Date: Mon, 24 Jul 2017 10:37:13 +0800
Message-ID: <1500863835-32877-1-git-send-email-xxm@rock-chips.com>
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
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
Cc: linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Add rockchip,disable-mmu-reset property to disable some mmu
reset operation

Signed-off-by: Simon Xue <xxm-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
---
changes since V2:
use rockchip,disable-mmu-reset instead of rk-iommu,disable-reset-quirk

 Documentation/devicetree/bindings/iommu/rockchip,iommu.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/iommu/rockchip,iommu.txt b/Documentation/devicetree/bindings/iommu/rockchip,iommu.txt
index 9a55ac3..2098f77 100644
--- a/Documentation/devicetree/bindings/iommu/rockchip,iommu.txt
+++ b/Documentation/devicetree/bindings/iommu/rockchip,iommu.txt
@@ -15,6 +15,11 @@ Required properties:
                     to associate with its master device.  See:
                     Documentation/devicetree/bindings/iommu/iommu.txt
 
+Optional properties:
+- rockchip,disable-mmu-reset : Don't use the mmu reset operation.
+			       Some mmu instances may produce unexpected results
+			       when the reset operation is used.
+
 Example:
 
 	vopl_mmu: iommu@ff940300 {
-- 
1.9.1
