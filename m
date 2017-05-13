From: shameer <shameerali.kolothum.thodi-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Subject: [RFC v1 2/7] iommu/arm-smmu-v3: Add erratum framework functions
Date: Sat, 13 May 2017 10:47:26 +0100
Message-ID: <20170513094731.3676-3-shameerali.kolothum.thodi@huawei.com>
References: <20170513094731.3676-1-shameerali.kolothum.thodi@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170513094731.3676-1-shameerali.kolothum.thodi-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: will.deacon-5wv7dgnIgG8@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, hanjun.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Cc: gabriele.paoloni-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, john.garry-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devel-E0kO6a4B6psdnm+yROfE0A@public.gmane.org, linuxarm-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, wangzhou1-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, guohanjun-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, shameer <shameerali.kolothum.thodi-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

This will provide a way to replace the existing skip_prefetch_cmd
erratum using the new framework.

Signed-off-by: shameer <shameerali.kolothum.thodi-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
---
 drivers/iommu/arm-smmu-v3.c | 58 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index a166590..f20d5d5 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -664,16 +664,72 @@ enum smmu_erratum_match_type {
 	se_match_dt,
 };
 
+void erratum_skip_prefetch_cmd(struct arm_smmu_device *smmu, void *arg)
+{
+	smmu->options |= ARM_SMMU_OPT_SKIP_PREFETCH;
+}
+
 struct smmu_erratum_workaround {
 	enum smmu_erratum_match_type match_type;
 	const void *id;	/* Indicate the Erratum ID */
 	const char *desc_str;
+	void (*enable)(struct arm_smmu_device *, void *);
 };
 
 static const struct smmu_erratum_workaround smmu_workarounds[] = {
 
 };
 
+typedef bool (*se_match_fn_t)(const struct smmu_erratum_workaround *,
+							  const void *);
+static
+bool smmu_check_dt_erratum(const struct smmu_erratum_workaround *wa,
+						   const void *arg)
+{
+	const struct device_node *np = arg;
+
+	return of_property_read_bool(np, wa->id);
+}
+
+static void smmu_enable_errata(struct arm_smmu_device *smmu,
+				enum smmu_erratum_match_type type,
+				se_match_fn_t match_fn,
+				void *arg)
+{
+	const struct smmu_erratum_workaround *wa = smmu_workarounds;
+
+	for (; wa->desc_str; wa++) {
+		if (wa->match_type != type)
+			continue;
+
+		if (match_fn(wa, arg)) {
+			if (wa->enable) {
+				wa->enable(smmu, arg);
+				dev_info(smmu->dev,
+					"Enabling workaround for %s\n",
+					 wa->desc_str);
+			}
+		}
+	}
+}
+
+
+static void smmu_check_workarounds(struct arm_smmu_device *smmu,
+				  enum smmu_erratum_match_type type,
+				  void *arg)
+{
+	se_match_fn_t match_fn = NULL;
+
+	switch (type) {
+	case se_match_dt:
+		match_fn = smmu_check_dt_erratum;
+		break;
+	}
+
+	smmu_enable_errata(smmu, type, match_fn, arg);
+
+}
+
 static struct arm_smmu_domain *to_smmu_domain(struct iommu_domain *dom)
 {
 	return container_of(dom, struct arm_smmu_domain, domain);
@@ -2641,6 +2697,8 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev,
 
 	parse_driver_options(smmu);
 
+	smmu_check_workarounds(smmu, se_match_dt, dev->of_node);
+
 	if (of_dma_is_coherent(dev->of_node))
 		smmu->features |= ARM_SMMU_FEAT_COHERENCY;
 
-- 
2.5.0


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
