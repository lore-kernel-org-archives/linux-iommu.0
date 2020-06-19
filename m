Return-Path: <SRS0=CQHw=AA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E4C6C433DF
	for <iommu@archiver.kernel.org>; Fri, 19 Jun 2020 08:20:50 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AE112080C
	for <iommu@archiver.kernel.org>; Fri, 19 Jun 2020 08:20:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AE112080C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 4BDC289921;
	Fri, 19 Jun 2020 08:20:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VfFVjO1mWl1d; Fri, 19 Jun 2020 08:20:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 68EED898EF;
	Fri, 19 Jun 2020 08:20:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 53EF9C0865;
	Fri, 19 Jun 2020 08:20:49 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9E790C016E
 for <iommu@lists.linux-foundation.org>; Fri, 19 Jun 2020 08:20:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 9A32A881AD
 for <iommu@lists.linux-foundation.org>; Fri, 19 Jun 2020 08:20:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Vsb10jq3MNxb for <iommu@lists.linux-foundation.org>;
 Fri, 19 Jun 2020 08:20:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by whitealder.osuosl.org (Postfix) with ESMTP id 287FB882BE
 for <iommu@lists.linux-foundation.org>; Fri, 19 Jun 2020 08:20:46 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C319A1435;
 Fri, 19 Jun 2020 01:20:45 -0700 (PDT)
Received: from red-moon.arm.com (unknown [10.57.58.158])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 477D03F71F;
 Fri, 19 Jun 2020 01:20:43 -0700 (PDT)
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 06/12] of/iommu: Make of_map_rid() PCI agnostic
Date: Fri, 19 Jun 2020 09:20:07 +0100
Message-Id: <20200619082013.13661-7-lorenzo.pieralisi@arm.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200619082013.13661-1-lorenzo.pieralisi@arm.com>
References: <20200521130008.8266-1-lorenzo.pieralisi@arm.com>
 <20200619082013.13661-1-lorenzo.pieralisi@arm.com>
MIME-Version: 1.0
Cc: devicetree@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
 Hanjun Guo <guohanjun@huawei.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Makarand Pawagi <makarand.pawagi@nxp.com>, Sudeep Holla <sudeep.holla@arm.com>,
 linux-acpi@vger.kernel.org, iommu@lists.linux-foundation.org,
 Rob Herring <robh+dt@kernel.org>, linux-pci@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, Robin Murphy <robin.murphy@arm.com>,
 Diana Craciun <diana.craciun@oss.nxp.com>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

There is nothing PCI specific (other than the RID - requester ID)
in the of_map_rid() implementation, so the same function can be
reused for input/output IDs mapping for other busses just as well.

Rename the RID instances/names to a generic "id" tag.

No functionality change intended.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Marc Zyngier <maz@kernel.org>
---
 drivers/iommu/of_iommu.c |  4 ++--
 drivers/of/base.c        | 42 ++++++++++++++++++++--------------------
 drivers/of/irq.c         |  2 +-
 include/linux/of.h       |  4 ++--
 4 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index 20738aacac89..016316244737 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -129,7 +129,7 @@ static int of_pci_iommu_init(struct pci_dev *pdev, u16 alias, void *data)
 	struct of_phandle_args iommu_spec = { .args_count = 1 };
 	int err;
 
-	err = of_map_rid(info->np, alias, "iommu-map", "iommu-map-mask",
+	err = of_map_id(info->np, alias, "iommu-map", "iommu-map-mask",
 			 &iommu_spec.np, iommu_spec.args);
 	if (err)
 		return err == -ENODEV ? NO_IOMMU : err;
@@ -145,7 +145,7 @@ static int of_fsl_mc_iommu_init(struct fsl_mc_device *mc_dev,
 	struct of_phandle_args iommu_spec = { .args_count = 1 };
 	int err;
 
-	err = of_map_rid(master_np, mc_dev->icid, "iommu-map",
+	err = of_map_id(master_np, mc_dev->icid, "iommu-map",
 			 "iommu-map-mask", &iommu_spec.np,
 			 iommu_spec.args);
 	if (err)
diff --git a/drivers/of/base.c b/drivers/of/base.c
index ae03b1218b06..ea44fea99813 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -2201,15 +2201,15 @@ int of_find_last_cache_level(unsigned int cpu)
 }
 
 /**
- * of_map_rid - Translate a requester ID through a downstream mapping.
+ * of_map_id - Translate an ID through a downstream mapping.
  * @np: root complex device node.
- * @rid: device requester ID to map.
+ * @id: device ID to map.
  * @map_name: property name of the map to use.
  * @map_mask_name: optional property name of the mask to use.
  * @target: optional pointer to a target device node.
  * @id_out: optional pointer to receive the translated ID.
  *
- * Given a device requester ID, look up the appropriate implementation-defined
+ * Given a device ID, look up the appropriate implementation-defined
  * platform ID and/or the target device which receives transactions on that
  * ID, as per the "iommu-map" and "msi-map" bindings. Either of @target or
  * @id_out may be NULL if only the other is required. If @target points to
@@ -2219,11 +2219,11 @@ int of_find_last_cache_level(unsigned int cpu)
  *
  * Return: 0 on success or a standard error code on failure.
  */
-int of_map_rid(struct device_node *np, u32 rid,
+int of_map_id(struct device_node *np, u32 id,
 	       const char *map_name, const char *map_mask_name,
 	       struct device_node **target, u32 *id_out)
 {
-	u32 map_mask, masked_rid;
+	u32 map_mask, masked_id;
 	int map_len;
 	const __be32 *map = NULL;
 
@@ -2235,7 +2235,7 @@ int of_map_rid(struct device_node *np, u32 rid,
 		if (target)
 			return -ENODEV;
 		/* Otherwise, no map implies no translation */
-		*id_out = rid;
+		*id_out = id;
 		return 0;
 	}
 
@@ -2255,22 +2255,22 @@ int of_map_rid(struct device_node *np, u32 rid,
 	if (map_mask_name)
 		of_property_read_u32(np, map_mask_name, &map_mask);
 
-	masked_rid = map_mask & rid;
+	masked_id = map_mask & id;
 	for ( ; map_len > 0; map_len -= 4 * sizeof(*map), map += 4) {
 		struct device_node *phandle_node;
-		u32 rid_base = be32_to_cpup(map + 0);
+		u32 id_base = be32_to_cpup(map + 0);
 		u32 phandle = be32_to_cpup(map + 1);
 		u32 out_base = be32_to_cpup(map + 2);
-		u32 rid_len = be32_to_cpup(map + 3);
+		u32 id_len = be32_to_cpup(map + 3);
 
-		if (rid_base & ~map_mask) {
-			pr_err("%pOF: Invalid %s translation - %s-mask (0x%x) ignores rid-base (0x%x)\n",
+		if (id_base & ~map_mask) {
+			pr_err("%pOF: Invalid %s translation - %s-mask (0x%x) ignores id-base (0x%x)\n",
 				np, map_name, map_name,
-				map_mask, rid_base);
+				map_mask, id_base);
 			return -EFAULT;
 		}
 
-		if (masked_rid < rid_base || masked_rid >= rid_base + rid_len)
+		if (masked_id < id_base || masked_id >= id_base + id_len)
 			continue;
 
 		phandle_node = of_find_node_by_phandle(phandle);
@@ -2288,20 +2288,20 @@ int of_map_rid(struct device_node *np, u32 rid,
 		}
 
 		if (id_out)
-			*id_out = masked_rid - rid_base + out_base;
+			*id_out = masked_id - id_base + out_base;
 
-		pr_debug("%pOF: %s, using mask %08x, rid-base: %08x, out-base: %08x, length: %08x, rid: %08x -> %08x\n",
-			np, map_name, map_mask, rid_base, out_base,
-			rid_len, rid, masked_rid - rid_base + out_base);
+		pr_debug("%pOF: %s, using mask %08x, id-base: %08x, out-base: %08x, length: %08x, id: %08x -> %08x\n",
+			np, map_name, map_mask, id_base, out_base,
+			id_len, id, masked_id - id_base + out_base);
 		return 0;
 	}
 
-	pr_info("%pOF: no %s translation for rid 0x%x on %pOF\n", np, map_name,
-		rid, target && *target ? *target : NULL);
+	pr_info("%pOF: no %s translation for id 0x%x on %pOF\n", np, map_name,
+		id, target && *target ? *target : NULL);
 
 	/* Bypasses translation */
 	if (id_out)
-		*id_out = rid;
+		*id_out = id;
 	return 0;
 }
-EXPORT_SYMBOL_GPL(of_map_rid);
+EXPORT_SYMBOL_GPL(of_map_id);
diff --git a/drivers/of/irq.c b/drivers/of/irq.c
index a296eaf52a5b..d632bc5b3a2d 100644
--- a/drivers/of/irq.c
+++ b/drivers/of/irq.c
@@ -587,7 +587,7 @@ static u32 __of_msi_map_rid(struct device *dev, struct device_node **np,
 	 * "msi-map" property.
 	 */
 	for (parent_dev = dev; parent_dev; parent_dev = parent_dev->parent)
-		if (!of_map_rid(parent_dev->of_node, rid_in, "msi-map",
+		if (!of_map_id(parent_dev->of_node, rid_in, "msi-map",
 				"msi-map-mask", np, &rid_out))
 			break;
 	return rid_out;
diff --git a/include/linux/of.h b/include/linux/of.h
index c669c0a4732f..60abe3f636ad 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -554,7 +554,7 @@ bool of_console_check(struct device_node *dn, char *name, int index);
 
 extern int of_cpu_node_to_id(struct device_node *np);
 
-int of_map_rid(struct device_node *np, u32 rid,
+int of_map_id(struct device_node *np, u32 id,
 	       const char *map_name, const char *map_mask_name,
 	       struct device_node **target, u32 *id_out);
 
@@ -978,7 +978,7 @@ static inline int of_cpu_node_to_id(struct device_node *np)
 	return -ENODEV;
 }
 
-static inline int of_map_rid(struct device_node *np, u32 rid,
+static inline int of_map_id(struct device_node *np, u32 id,
 			     const char *map_name, const char *map_mask_name,
 			     struct device_node **target, u32 *id_out)
 {
-- 
2.26.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
