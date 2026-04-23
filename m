Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010040.outbound.protection.outlook.com [52.101.193.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5A92D8399;
	Thu, 23 Apr 2026 19:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776971729; cv=fail; b=gfwzxLLy9Ah6YIPD1fiAywgARRI+8jJ5phbx+Kyyvhan1bflHTrPjq7rM4Hk4bykhB1ImdxQLDm/bo3g0mlK85RbiCaUX4+Q88DFh8F81aoZC+BxPPkFJPVUV1keSCT45/v0/Hr6datT6TZNtOhsKaKDyXv8l/3bfF1M5AofQNk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776971729; c=relaxed/simple;
	bh=VAFoJC9tL1FRE0Yhl4S0LM5mVjwNBN+PknpjRmzTcKk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N8wIr5sSxXYmBj9GvwlsZc9jMR61Yl8b/uI1uZ0X0MhKPC2htbcsgFFTertOjHaoXQ4WJHCNhmLOYTaqx5mdMmAWedTsQBugI8LcG73kto9KaEWEnm+rYQN5la2WH/4GnKvdwNqXU7Q1ZseCEqAr7jP+t6urzJ6GEqwcDS7xzEA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=a9UDIRdA; arc=fail smtp.client-ip=52.101.193.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="a9UDIRdA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jkOvSl7nLeVYe3Y+1jOtmEzlKsGR8E6HDyt7GmipjOk0ObUDBwLBlQ+QecmNZn+rNSrGLHJO9uhHcpSO7aId1aZnfi88mr5j08vSeTnQ8I/mBPs26HRxp2zQEC/UzAiGxKtf4Wm2XLt3jgQlQshMzSPYl98CmbIPTB5LPjigKwHJgYF955uBQ4JUgH4Ch8RXrVsi6udA4J38bZ+Eb/J9ImgmAQpOgr6S+WmZlrGhWN3lypHi2vRAsdkUKSOLgdUB14YLpz/PdMVWJjpBirmP0uECDbtaGUHfqJSFxgFZ5X1w08bhuFmHP3HzpkADEdjgM4Tuv54329W2JNwNVVbhfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OKHqwV2QbPbXzwDwf3D/S0RD+6/qQBO4oCsf6Vrz6BI=;
 b=cLgLjwlVq8xlYqIY8OBJinKBW3P/Rs1xNWFg02Lg2BnnW/TTE0u+QKjdgaEINRfVE68o8zEKeg2Ibu7ykAEPptbiLfu9ncOaWz0ILeHVdwiBJ/Nw4Y1mSQOLv/WQjMDzmJns1JnH/wCOJnev79mlxdSnPmKxpyt4q/Gdn2bvUlJVHSNY+3ROjYOZidGpEnYMnb1Y6fDNYgKxDjqcygdIMF9KQQZ99T7rFZMfl5L6hneiNGaVJ+WM06rFxuCEFW0+62iw/E0TFXp6e+bMxoG3a5SI6SWDDPqc1KXsJABYaCKKCXTZpcyZK+0D5xoJE43tNVdiuLNn9Oxomf/JRf66kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OKHqwV2QbPbXzwDwf3D/S0RD+6/qQBO4oCsf6Vrz6BI=;
 b=a9UDIRdAhnMykUTuS6DH2GBKWOqSIRoHiDSCml92LooPk/4k7fFrix0cq6Bhlgw0I5T77/5O9e7vLrfBJGvOxoD+Vy9RRD3ZiSePp5fPz/c8zhmuWZoanTuaW3qXUyQu8Ua4Zvhpx7nEjG1Gg439Yr1advQbztwbuwv+DfJIIBqh7JSNXUDNiFmT3c6Ghzwbe70zpo3dJJSMHohfR3AH9YaI7UNdFYK2k8jldAO3QOOK8+PoUTR96fNExCw1grjkynoU8rC/iwQbWpPDq3f8w0uAkr1mwnYIPiwyQ1c9us5PfZjrI31MfpmgTn4k5duvSZ26IalncKJcvkpfLshBhA==
Received: from BN9PR03CA0234.namprd03.prod.outlook.com (2603:10b6:408:f8::29)
 by SN7PR12MB6839.namprd12.prod.outlook.com (2603:10b6:806:265::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.15; Thu, 23 Apr
 2026 19:15:13 +0000
Received: from BN1PEPF0000467F.namprd03.prod.outlook.com
 (2603:10b6:408:f8:cafe::d1) by BN9PR03CA0234.outlook.office365.com
 (2603:10b6:408:f8::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.21 via Frontend Transport; Thu,
 23 Apr 2026 19:15:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF0000467F.mail.protection.outlook.com (10.167.243.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Thu, 23 Apr 2026 19:15:13 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 23 Apr
 2026 12:14:59 -0700
Received: from vidyas-server.nvidia.com (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 23 Apr 2026 12:14:53 -0700
From: Vidya Sagar <vidyas@nvidia.com>
To: <rafael@kernel.org>, <lenb@kernel.org>, <saket.dumbre@intel.com>,
	<lpieralisi@kernel.org>, <guohanjun@huawei.com>, <sudeep.holla@kernel.org>,
	<will@kernel.org>, <catalin.marinas@arm.com>, <joro@8bytes.org>,
	<robin.murphy@arm.com>, <jgg@ziepe.ca>, <nicolinc@nvidia.com>,
	<praan@google.com>
CC: <vsethi@nvidia.com>, <sdonthineni@nvidia.com>, <kthota@nvidia.com>,
	<sagar.tv@gmail.com>, <linux-acpi@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <acpica-devel@lists.linux.dev>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>, Vidya Sagar
	<vidyas@nvidia.com>
Subject: [PATCH V1 2/3] ACPI/IORT: Plumb Root Complex PASID descriptors into iommu_fwspec
Date: Fri, 24 Apr 2026 00:44:16 +0530
Message-ID: <20260423191417.2031652-3-vidyas@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260423191417.2031652-1-vidyas@nvidia.com>
References: <20260423191417.2031652-1-vidyas@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000467F:EE_|SN7PR12MB6839:EE_
X-MS-Office365-Filtering-Correlation-Id: 127033e8-7d2e-436b-b7b2-08dea16ca559
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|36860700016|376014|82310400026|921020|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	wN6PiBAmqkLX7+5C3BJU6eu/Vbgpe9ivGQ1BW3rCDzZm5hlJQiSkWAtBMIzKXYWTmPRXM8PRjTUaw0nd/P5xOoHktESDH/CJ9c+89X4lIAW04P/jn43OonUlw579Bo80UEP+UodDaA8kAmB/ixsIZxqWXW7yrGvvhILTGSb+7uq465ZNi8r+e5GRs+DtoMcRtNy5fX0HUIwZU0eaBH3gJ0EjrYXoAlRLVG6L93rmzlsqL9rb/UEc0lX3AqmaCjXUCGLGEWyCLWKzID45KwbHmhY2TTo8RvxWEoQuzvJ0iGM8ocy+M8fex2puY4b+yfbMpS5rt9w7JBoqNNq0vD9fV34qFmplT7oPL6RGQVp/wL2SDIvKiVZd9jzM1t9HiE6KTStcdXi2spXQw7n9JmRJbvI8mWcGSKJAccTKwnRePcucOUUi8WWoOqbApEVcFZiTB4MOvDI6XGh45tQ6uXIhacg8TpYFVIxryWuEpVAMu+VATLB7xYSbg9+B4hkOas6Ce0czAaaEBZzwq5Vz6TaN8fx7/60jqJk0cMqLzOm11FKvbRWgVkU3FZfQgBUtWafNy38HABH43Y2nrc/VQAatL5qjF2mh58A3JF/WN2feoYvozN0knWOirMt1h8eao0ywSho4McJa5/pTXMlkxXQpU+qoJ6twl/kXaIOgh/r7rox1bVI+OfBOm/JvnWO4XXI2bAOr/y9cuasdI/FXNm2BbokEWrWxnspxXHJIKiaIzZZbFRWzADFa73tU4CX47z+3uJfIYPtqyyr5UlHspIExMzMmI23q2Pt/QNws2J+e2uXV+1hkgTPJYl2OyYk4HP09
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(36860700016)(376014)(82310400026)(921020)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	I5AzO6sAlt3EqX2COftA5ld0TyKNLhfvZlPYTMC/tqDth3pZFa3sTF+VGzq200ZvXkC3vZ8zTBSItPjc7M0mDFeL2XljoD3IE4JA2wRysloeHdE5XQB1P5krtJWNF++XFuYJ7EU6m+WcSq+4lVthJTus7JVL+tENDEgio3gCRyUN+n7qSzs3vQo2G3cpNybPfmkHuGREiLFoSxx+AQRYWl/e8l3Tf15ddu+yNo9g6Oo3mo8kxlsDjQCfLAiIVQLfTavEYoo8ICp2rEzBhAkKfkFDGJm8QclhKa//oF4J2Fh3lD4b7UAm7Bj0ZDtkkd0OhP8Uq4REw/cc3pBhdrBFycmj7X5k2px8F/3vNjizcXd/si8DJKXY11EIGm1V6ckMAqpGu7xooUW6E6VuGn3qsxbnf0k1c8XoxCrOhl4/G5BYK3iAmTeTq5LB1nZavBwE
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2026 19:15:13.3882
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 127033e8-7d2e-436b-b7b2-08dea16ca559
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000467F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6839

The IORT spec, Issue E.c (ARM DEN 0049E.c, January 2022), gives
software two ways to learn about Root Complex PASID capability:

  - the Flags field at byte offset 36 (RC node revision >= 4), bit 0
    of which says whether the Root Complex itself supports PASID, and
  - bit 2 of the long-standing ATS Attribute field at offset 24, which
    says whether the Root Complex forwards PASID information on
    translated transactions to the SMMU.

Neither is consumed by Linux today. Modeled after the CANWBS support
in commit 807404d66fcf ("ACPI/IORT: Support CANWBS memory access
flag"), expose both bits via the existing iommu_fwspec mechanism so
IOMMU drivers can consult them at device probe time:

  - IOMMU_FWSPEC_PCI_RC_PASID      (bit 2): RC declares PASID support
  - IOMMU_FWSPEC_PCI_RC_PASID_FWD  (bit 3): RC forwards PASID

Add three new static helpers in iort.c that read the corresponding
fields, with iort_pci_rc_supports_pasid() and the new
iort_pci_rc_pasid_max_width() helper guarded by node->revision >= 4
because their backing storage was only added in E.c. The PASID
forwarding bit lives in the older ats_attribute field and needs no
guard. Set the new fwspec flags from iort_iommu_configure_id().

In addition, expose two device-facing wrappers,
iort_pci_rc_pasid_max_width_known() and _for_dev(), so IOMMU drivers
can clamp endpoint PASID widths by what the Root Complex can actually
carry without having to walk the IORT themselves. Provide stubs in
include/linux/acpi_iort.h for !CONFIG_ACPI_IORT.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
 drivers/acpi/arm64/iort.c | 80 +++++++++++++++++++++++++++++++++++++++
 include/linux/acpi_iort.h |  6 +++
 include/linux/iommu.h     |  4 ++
 3 files changed, 90 insertions(+)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index af7a9b2fd5bc..40486de6bd79 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -1352,6 +1352,36 @@ static bool iort_pci_rc_supports_canwbs(struct acpi_iort_node *node)
 	return memory_access->memory_flags & ACPI_IORT_MF_CANWBS;
 }
 
+static bool iort_pci_rc_supports_pasid(struct acpi_iort_node *node)
+{
+	struct acpi_iort_root_complex *pci_rc;
+
+	if (node->revision < 4)
+		return false;
+
+	pci_rc = (struct acpi_iort_root_complex *)node->node_data;
+	return pci_rc->flags & ACPI_IORT_RC_PASID_SUPPORTED;
+}
+
+static bool iort_pci_rc_supports_pasid_fwd(struct acpi_iort_node *node)
+{
+	struct acpi_iort_root_complex *pci_rc;
+
+	pci_rc = (struct acpi_iort_root_complex *)node->node_data;
+	return pci_rc->ats_attribute & ACPI_IORT_PASID_FWD_SUPPORTED;
+}
+
+static int iort_pci_rc_pasid_max_width(struct acpi_iort_node *node)
+{
+	struct acpi_iort_root_complex *pci_rc;
+
+	if (node->revision < 4)
+		return -ENODEV;
+
+	pci_rc = (struct acpi_iort_root_complex *)node->node_data;
+	return FIELD_GET(ACPI_IORT_PASID_MAX_WIDTH, pci_rc->pasid_capabilities);
+}
+
 static int iort_iommu_xlate(struct device *dev, struct acpi_iort_node *node,
 			    u32 streamid)
 {
@@ -1471,6 +1501,10 @@ int iort_iommu_configure_id(struct device *dev, const u32 *id_in)
 			fwspec->flags |= IOMMU_FWSPEC_PCI_RC_ATS;
 		if (fwspec && iort_pci_rc_supports_canwbs(node))
 			fwspec->flags |= IOMMU_FWSPEC_PCI_RC_CANWBS;
+		if (fwspec && iort_pci_rc_supports_pasid(node))
+			fwspec->flags |= IOMMU_FWSPEC_PCI_RC_PASID;
+		if (fwspec && iort_pci_rc_supports_pasid_fwd(node))
+			fwspec->flags |= IOMMU_FWSPEC_PCI_RC_PASID_FWD;
 	} else {
 		node = iort_scan_node(ACPI_IORT_NODE_NAMED_COMPONENT,
 				      iort_match_node_callback, dev);
@@ -1556,6 +1590,52 @@ int iort_dma_get_ranges(struct device *dev, u64 *limit)
 		return nc_dma_get_range(dev, limit);
 }
 
+static struct acpi_iort_node *iort_pci_rc_node_for_dev(struct device *dev)
+{
+	struct pci_bus *pbus;
+
+	if (!dev_is_pci(dev))
+		return NULL;
+
+	pbus = to_pci_dev(dev)->bus;
+	return iort_scan_node(ACPI_IORT_NODE_PCI_ROOT_COMPLEX,
+			      iort_match_node_callback, &pbus->dev);
+}
+
+/**
+ * iort_pci_rc_pasid_max_width_known() - Whether IORT firmware describes the
+ * Root Complex PASID width for the given PCI device.
+ * @dev: PCI device to lookup
+ *
+ * Returns true iff a matching IORT Root Complex node exists and has revision
+ * >= 4 (IORT spec E.c), i.e. the PASID Capabilities descriptor is present.
+ */
+bool iort_pci_rc_pasid_max_width_known(struct device *dev)
+{
+	struct acpi_iort_node *node = iort_pci_rc_node_for_dev(dev);
+
+	return node && node->revision >= 4;
+}
+
+/**
+ * iort_pci_rc_pasid_max_width_for_dev() - Look up the Root Complex Max PASID
+ * Width for the given PCI device.
+ * @dev: PCI device to lookup
+ *
+ * Returns the Max PASID Width (bits[4:0] of PASID Capabilities) declared by
+ * the Root Complex node in IORT firmware, or a negative errno when the field
+ * is not present (RC node revision < 4) or the device is not PCI.
+ */
+int iort_pci_rc_pasid_max_width_for_dev(struct device *dev)
+{
+	struct acpi_iort_node *node = iort_pci_rc_node_for_dev(dev);
+
+	if (!node)
+		return -ENODEV;
+
+	return iort_pci_rc_pasid_max_width(node);
+}
+
 static void __init acpi_iort_register_irq(int hwirq, const char *name,
 					  int trigger,
 					  struct resource *res)
diff --git a/include/linux/acpi_iort.h b/include/linux/acpi_iort.h
index 17bb3374f4ca..befe19d87c2c 100644
--- a/include/linux/acpi_iort.h
+++ b/include/linux/acpi_iort.h
@@ -45,6 +45,8 @@ void iort_put_rmr_sids(struct fwnode_handle *iommu_fwnode,
 int iort_dma_get_ranges(struct device *dev, u64 *limit);
 int iort_iommu_configure_id(struct device *dev, const u32 *id_in);
 void iort_iommu_get_resv_regions(struct device *dev, struct list_head *head);
+bool iort_pci_rc_pasid_max_width_known(struct device *dev);
+int iort_pci_rc_pasid_max_width_for_dev(struct device *dev);
 phys_addr_t acpi_iort_dma_get_max_cpu_address(void);
 #else
 static inline u32 iort_msi_map_id(struct device *dev, u32 id)
@@ -71,6 +73,10 @@ static inline int iort_iommu_configure_id(struct device *dev, const u32 *id_in)
 static inline
 void iort_iommu_get_resv_regions(struct device *dev, struct list_head *head)
 { }
+static inline bool iort_pci_rc_pasid_max_width_known(struct device *dev)
+{ return false; }
+static inline int iort_pci_rc_pasid_max_width_for_dev(struct device *dev)
+{ return -ENODEV; }
 
 static inline phys_addr_t acpi_iort_dma_get_max_cpu_address(void)
 { return PHYS_ADDR_MAX; }
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index e587d4ac4d33..e78d7f56d603 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -1118,6 +1118,10 @@ struct iommu_fwspec {
 #define IOMMU_FWSPEC_PCI_RC_ATS			(1 << 0)
 /* CANWBS is supported */
 #define IOMMU_FWSPEC_PCI_RC_CANWBS		(1 << 1)
+/* Root complex declares PASID support (IORT E.c Flags bit 0) */
+#define IOMMU_FWSPEC_PCI_RC_PASID		(1 << 2)
+/* Root complex forwards PASID on translated transactions (IORT ATS bit 2) */
+#define IOMMU_FWSPEC_PCI_RC_PASID_FWD		(1 << 3)
 
 /*
  * An iommu attach handle represents a relationship between an iommu domain
-- 
2.25.1

