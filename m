From: Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH] iommu/of: Fix probe-deferral
Date: Mon,  7 Jan 2019 17:04:50 +0000
Message-ID: <b158bd8aae8e9fd1a7fc7960cf17fa623dd47b11.1546880690.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: joro@8bytes.org
Cc: iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org
List-Id: iommu@lists.linux-foundation.org

Whilst iommu_probe_device() does check for non-NULL ops as the previous
code did, it does not do so in the same order relative to the other
checks, and as a result means that -EPROBE_DEFER returned by of_xlate()
(plus any real error condition too) gets overwritten with -EINVAL and
leads to various misbehaviour.

Reinstate the original logic, but without implicitly relying on ops
being set to infer !err as the initial condition (now that the validity
of ops for its own sake is checked elsewhere).

Fixes: 641fb0efbff0 ("iommu/of: Don't call iommu_ops->add_device directly")
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/of_iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index d8947b28db2d..f04a6df65eb8 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -224,7 +224,7 @@ const struct iommu_ops *of_iommu_configure(struct device *dev,
 	 * If we have reason to believe the IOMMU driver missed the initial
 	 * probe for dev, replay it to get things in order.
 	 */
-	if (dev->bus && !device_iommu_mapped(dev))
+	if (!err && dev->bus && !device_iommu_mapped(dev))
 		err = iommu_probe_device(dev);
 
 	/* Ignore all other errors apart from EPROBE_DEFER */
-- 
2.19.1.dirty
