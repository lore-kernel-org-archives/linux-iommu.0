From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 3/3] iommu: Document iommu_ops.is_attach_deferred()
Date: Wed, 20 Feb 2019 14:00:53 +0100
Message-ID: <20190220130053.784-4-geert+renesas@glider.be>
References: <20190220130053.784-1-geert+renesas@glider.be>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190220130053.784-1-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: Dmitry Osipenko <digetx@gmail.com>, Baoquan He <bhe@redhat.com>, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: iommu@lists.linux-foundation.org

Add missing kerneldoc for iommu_ops.is_attach_deferred().

Fixes: e01d1913b0d08171 ("iommu: Add is_attach_deferred call-back to iommu-ops")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 include/linux/iommu.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 3ed5d372b090af54..ffbbc7e39ceeba3e 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -184,6 +184,8 @@ struct iommu_resv_region {
  * @domain_window_enable: Configure and enable a particular window for a domain
  * @domain_window_disable: Disable a particular window for a domain
  * @of_xlate: add OF master IDs to iommu grouping
+ * @is_attach_deferred: Check if domain attach should be deferred from iommu
+ *                      driver init to device driver init (default no)
  * @pgsize_bitmap: bitmap of all possible supported page sizes
  */
 struct iommu_ops {
-- 
2.17.1
