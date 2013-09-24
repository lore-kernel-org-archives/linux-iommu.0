From: Andreas Herrmann <andreas.herrmann@calxeda.com>
Subject: [PATCH 6/7] iommu/arm-smmu: Add module parameter
 arm-smmu=off|force_isolation
Date: Tue, 24 Sep 2013 17:07:00 +0200
Message-ID: <1380035221-11576-7-git-send-email-andreas.herrmann@calxeda.com>
References: <1380035221-11576-1-git-send-email-andreas.herrmann@calxeda.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1380035221-11576-1-git-send-email-andreas.herrmann@calxeda.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Will Deacon <will.deacon@arm.com>
Cc: Andreas Herrmann <andreas.herrmann@calxeda.com>, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org
List-Id: iommu@lists.linux-foundation.org

  arm-smmu=	arm-smmu driver option

	off	Disable arm-smmu driver (ie. ignore available SMMUs)

	force_isolation
		Try to attach each master device on every SMMU to a
		separate iommu_domain.

Default is that driver detects SMMUs but no translation is configured
(transactions just bypass translation process).

Signed-off-by: Andreas Herrmann <andreas.herrmann@calxeda.com>
---
 drivers/iommu/arm-smmu.c |   26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 3eb2259..251564e 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -399,6 +399,9 @@ struct arm_smmu_domain {
 static DEFINE_SPINLOCK(arm_smmu_devices_lock);
 static LIST_HEAD(arm_smmu_devices);
 
+static bool arm_smmu_disabled;
+static bool arm_smmu_force_isolation;
+
 static struct arm_smmu_master *find_smmu_master(struct arm_smmu_device *smmu,
 						struct device_node *dev_node)
 {
@@ -1837,6 +1840,9 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev)
 	struct of_phandle_args masterspec;
 	int num_irqs, i, err;
 
+	if (arm_smmu_disabled)
+		return -ENODEV;
+
 	smmu = devm_kzalloc(dev, sizeof(*smmu), GFP_KERNEL);
 	if (!smmu) {
 		dev_err(dev, "failed to allocate arm_smmu_device\n");
@@ -2022,6 +2028,23 @@ static struct platform_driver arm_smmu_driver = {
 	.remove	= arm_smmu_device_remove,
 };
 
+static int __init arm_smmu_parse_options(char *str)
+{
+	if (*str) {
+		str++;
+		if (!strncmp(str, "off", 3))
+			arm_smmu_disabled = true;
+		else if(!strncmp(str, "force_isolation", 15))
+			arm_smmu_force_isolation = true;
+		else {
+			pr_warn("arm_smmu: invalid parameter (\"%s\")\n", str);
+			return 0;
+		}
+	}
+	return 1;
+}
+__setup("arm-smmu", arm_smmu_parse_options);
+
 static int __init arm_smmu_init(void)
 {
 	int ret;
@@ -2037,6 +2060,9 @@ static int __init arm_smmu_init(void)
 	if (!iommu_present(&amba_bustype))
 		bus_set_iommu(&amba_bustype, &arm_smmu_ops);
 
+	if (arm_smmu_force_isolation)
+		arm_smmu_isolate_devices();
+
 	return 0;
 }
 
-- 
1.7.9.5
