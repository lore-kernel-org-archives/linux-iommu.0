From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH 06/29] drivers: iommu: add notify about failed bind
Date: Tue, 05 Aug 2014 12:47:34 +0200
Message-ID: <1407235677-26324-7-git-send-email-m.szyprowski@samsung.com>
References: <1407235677-26324-1-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-reply-to: <1407235677-26324-1-git-send-email-m.szyprowski@samsung.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: iommu@lists.linux-foundation.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Rob Herring <robh@kernel.org>, Thierry Reding <treding@nvidia.com>, Shaik Ameer Basha <shaik.ameer@samsung.com>, Arnd Bergmann <arnd@arndb.de>, Inki Dae <inki.dae@samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Joerg Roedel <joro@8bytes.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Tomasz Figa <tomasz.figa@gmail.com>, linaro-mm-sig@lists.linaro.org, Kyungmin Park <kyungmin.park@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Olof Johansson <olof@lixom.net>, Cho KyongHo <pullip.cho@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>
List-Id: iommu@lists.linux-foundation.org

This patch adds support for forwarding recently introduced
BUS_NOTIFY_DRVBIND_FAILED event to iommu groups. This lets us getting a
notify for failed device driver bind, so all the items done in
IOMMU_GROUP_NOTIFY_BIND_DRIVER event can be cleaned if the driver fails
to bind.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/iommu/iommu.c | 3 +++
 include/linux/iommu.h | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 1698360..516e93a 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -758,6 +758,9 @@ static int iommu_bus_notifier(struct notifier_block *nb,
 	case BUS_NOTIFY_UNBOUND_DRIVER:
 		group_action = IOMMU_GROUP_NOTIFY_UNBOUND_DRIVER;
 		break;
+	case BUS_NOTIFY_DRVBIND_FAILED:
+		group_action = IOMMU_GROUP_NOTIFY_DRVBIND_FAILED;
+		break;
 	}
 
 	if (group_action)
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 20f9a52..f9fdae5 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -139,6 +139,7 @@ struct iommu_ops {
 #define IOMMU_GROUP_NOTIFY_BOUND_DRIVER		4 /* Post Driver bind */
 #define IOMMU_GROUP_NOTIFY_UNBIND_DRIVER	5 /* Pre Driver unbind */
 #define IOMMU_GROUP_NOTIFY_UNBOUND_DRIVER	6 /* Post Driver unbind */
+#define IOMMU_GROUP_NOTIFY_DRVBIND_FAILED	7 /* Driver failed to bind */
 
 extern int bus_set_iommu(struct bus_type *bus, const struct iommu_ops *ops);
 extern bool iommu_present(struct bus_type *bus);
-- 
1.9.2
