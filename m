Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011008.outbound.protection.outlook.com [52.101.62.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B26F35A3B1
	for <iommu@lists.linux.dev>; Sun, 26 Jul 2026 08:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785053968; cv=fail; b=iXe8W056ZKBS90MEv/BjBTGluFZATjWg5cqVKpm9/1zMQKUQxQrW7kpzj3nW8frHQJpzG1OLW+koJ3vbjj5UIzQQW0N93+3vD0St1CPyaszoaR16biYFenPnM01oSKzCPMBOsihKDZtacaw93oMq1t2CYDxsuOEgzl4d6I/h34Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785053968; c=relaxed/simple;
	bh=w62IXIfMjJv4vhVpXFwMWCMAyr7fuIrIGukI9hb6ynk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lJDm+qKYRBOqD1gDzODdTXtQQFw3uoF+WkERrt42dkH8XhVw5AsF5XITToNP82fT5weqWkIfJDeZieRj2I3NHa21Z3pVYhz343nPMHeyC0QqKuxAraPWYT2wK01P3wD10Ifzk62e4dXxS/b4kRy0P7krqjYcv8CoGC30nLq9w1U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=S/22k4y2; arc=fail smtp.client-ip=52.101.62.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="S/22k4y2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PPJpN4uhauakmPvF0Y4Y8LnEcxxvStcFE1sBXYQH5/7FmT43ylrQ3ZvvYstJhd42zepI1ujMPDNvGyC2TtWIDEf5C5vCuocHx44JKjYMXeLxDx3HnfUqhNRXOcV2UWxc06TmaK+UntZZ73XOQKK3Ctps0Y4YFc7VFqq3TbWFoXGDwWCw0kzMAfiU2Et2rqPeaaMiAsrfaN8xRzP9s18QGNo10UCcYVDvWmsbfCV7bROa60tjPLjeTzPyG3YMBQIZn5H67HZWmj4E1m24Qt9xqp6QuDfh+7/1oYUUW4LtAHzppzDU2z9uVdPSgTwRCPLW2+NY2GD6bShhn8Itd2ZcCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QNgVHnR29hKv8AxhEEB/3mVV1987v41489Xs1dBqzPI=;
 b=N7a36zsshOtS6tZVetXKmb6Yblrjmt0vSrcxMd32HfqhTxFMryJCt1PUzPJzs17DfFledDvavN1nImGXmmuZg38vged44LolFGi/dinI2vRmXRCugm3OOH5RXkrOXQsKbAl0RhkFHdicLzAygZa/DHl3k8Tuv3Pu8hfecQJuFR17Bp3Et/SKa7ezzB/+AQD8Lyj9XviR+yNEIJ6kraU63Qw2CRGuhbHNCsaNg2t1e1O6LKz3P8IXDP86796U3Phyc8s/TmbAgBrAGAIiZKUNNDdXqkHxc53AzgAJ0z40UvllGn+UHcvOrRO8g5sYIF/XqIotzDs4/QXRNup3oH8b/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QNgVHnR29hKv8AxhEEB/3mVV1987v41489Xs1dBqzPI=;
 b=S/22k4y2pZm5/UQphT0LLO29uNkK2qKuBfjF+hFrmDnHB30nEgY1N+M/uI5dJ/jLvvR8FGGos5DkqUMbxPfx0mWorBUc9rmTXF9D7b55FQUXDD50Lwds3cuYd2FEY+TnQ+/D5J087btc+5ltViAW2TI+m5bqheA3ME2cyYyVjsesJWPwG3hr5jKhDN6G1SsC0TfspvFRX7fEqxlwludaeh8IrEXoWUDcgiquuW+u2RkXhMKgpggLpjUrmmslwgVeSKQZ6WGg83xkCHOdT0stmQpYfBj//hTm5HcbNOjBJQWFOUrHQh6yEOYZxcEzQBQ+VrYOwpf0EImAU1nZSNhLEw==
Received: from SJ2PR07CA0007.namprd07.prod.outlook.com (2603:10b6:a03:505::12)
 by IA1PR12MB6212.namprd12.prod.outlook.com (2603:10b6:208:3e4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Sun, 26 Jul
 2026 08:19:19 +0000
Received: from MWH0EPF000C6193.namprd02.prod.outlook.com
 (2603:10b6:a03:505:cafe::53) by SJ2PR07CA0007.outlook.office365.com
 (2603:10b6:a03:505::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.12 via Frontend Transport; Sun,
 26 Jul 2026 08:19:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 MWH0EPF000C6193.mail.protection.outlook.com (10.167.249.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Sun, 26 Jul 2026 08:19:18 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 26 Jul
 2026 01:19:08 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 26 Jul 2026 01:19:07 -0700
Received: from build-amhetre-focal-20260716.internal (10.127.8.12) by
 mail.nvidia.com (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20
 via Frontend Transport; Sun, 26 Jul 2026 01:19:07 -0700
From: Ashish Mhetre <amhetre@nvidia.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <corbet@lwn.net>,
	<skhan@linuxfoundation.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<nicolinc@nvidia.com>, <jgg@ziepe.ca>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-tegra@vger.kernel.org>, Ashish Mhetre <amhetre@nvidia.com>
Subject: [PATCH v9 3/4] iommu/arm-smmu-v3-iommufd: Report CFGI/TLBI-repeat erratum
Date: Sun, 26 Jul 2026 08:19:03 +0000
Message-ID: <20260726081904.1408859-4-amhetre@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260726081904.1408859-1-amhetre@nvidia.com>
References: <20260726081904.1408859-1-amhetre@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6193:EE_|IA1PR12MB6212:EE_
X-MS-Office365-Filtering-Correlation-Id: 8298cb25-6329-4af0-27a0-08deeaee96ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|23010399003|7416014|82310400026|376014|3023799007|11063799006|10067099003|56012099006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	eZfxQleIi+m+iAnWI9FdwrGZ2RvzTXR5h8yjvHAVf52UeFyZ2dR9dZ95LSqLpXF+7b5RVHJXG/rSlnbB07hPlvcIeCSiVg03LjKXt01VG/kcYxXX2CAxZMrokwb/64lclOQqKtr7SHI27T2rKDKEqWxhoaQ+10f5NTBqviWiwPlhY31n3zt3DOZPOK3yb+3hMRWy5yAkZC3WusN2xP5g1njb9bn6OiXds0vx+IgazUmLyHQ5IAboQ2FHKJRbMbaXLxIZMXt2B8Pv0er38F4v69/JCOA9cU3abUPs4r5x1UiqjA7EKcpq+i7/4nrE80MPddGwS7wRpaVtZKKl9FJFVcGqKRZZMT7zAeceL9h7U5Z46VHnzijEinayyzKnceDAybOL5P6sGceyO+KEzY781f5CaSlCUM9+jvPkz0OQ7ia1oz/UcXF7j2Isz/9eAG7DMQyHvaj1c178LjE3BfeO8pXSGVxKuIyLOy/FaXlA8l5OHzlWaejWuB6AxD15ikk0NjQtUd0DWiAZ9jtowSde/yr03BYjuKS5OYM+SbGKp8cxEbgiloPT23b/l8wd5tw2Tt+UfuVHM1UnjXt0Km/yBgohummgYPdLBknEPTtwXSKUUsE2TbOWYV0roouHVeXvomFc/EkV2TK88ZkWYriKVh/eklI8ZY96rUk4kRSfTjrG6jBg5+wZsqGwKz9bUcca6x/3vN7Lqv5ZDhbMNeaDwQ==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(23010399003)(7416014)(82310400026)(376014)(3023799007)(11063799006)(10067099003)(56012099006)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	U8PKDWIXCs+C/+/35xyJLKnsSDcWp3bTw39qCrlRmpPTeXQaQ3/U9UJHli/eA+FXOXIpdfQk35eOk8I9JMosn3GTJk5QkyXnynq80mkuz3OjRTTCmHdR6VIs6rm/OhfL/lXrNxPj9XsyLj1O60bXBXZ8Yh/Ijz9FWrhnmBTFoqxvw1JN7wbxtemOCINF+Eh6ae4RtxlVVSGyYdFh/b55NvfLP2TRctjH93eA9Ar6ZoDqCPYU2M6uaBsuAROXEXcAH3gF6KyOyHF2gO5iAFz3Ee3X88fHu4Nw1pfTwpNigwxY8nqT8uk+oxGpo8na5FkI5oqH8QrsWeIY168BEn+NraS64ekSgnHBbUY7nHtK699oPPPnHk8okjQm2Ge18CxgoPfdoVLW4GFz8hFYDybRT0/5GHHEHVoD59NNiKB2z3WJnM49cEpfLVQUDu5D1OYx
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2026 08:19:18.5028
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8298cb25-6329-4af0-27a0-08deeaee96ca
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000C6193.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6212

A guest with access to VCMDQ generates its own invalidation commands
and must apply any invalidation errata before submitting them. If the
host also repeats those commands, each affected invalidation is issued
four times instead of twice.

Add IOMMU_HW_INFO_ARM_SMMUV3_ERRATA_REPEAT_TLBI_CFGI to report the
CFGI/TLBI-repeat erratum to user space. This allows the VMM to expose
the erratum to the guest or apply the workaround itself.

Use the raw __arm_smmu_cmdq_issue_cmdlist() helper for user-provided
invalidations so the host does not apply the workaround a second time.
Add arm_smmu_erratum_repeat_tlbi_cfgi() to query the static key when
populating the SMMUv3 hardware information.

Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c |  7 +++++--
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c         |  7 ++++++-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h         |  1 +
 include/uapi/linux/iommufd.h                        | 13 ++++++++++++-
 4 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
index 85ebfdb3d2a7..25982bdbcbd9 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
@@ -33,6 +33,9 @@ void *arm_smmu_hw_info(struct device *dev, u32 *length,
 	info->iidr = readl_relaxed(master->smmu->base + ARM_SMMU_IIDR);
 	info->aidr = readl_relaxed(master->smmu->base + ARM_SMMU_AIDR);
 
+	if (arm_smmu_erratum_repeat_tlbi_cfgi())
+		info->flags |= IOMMU_HW_INFO_ARM_SMMUV3_ERRATA_REPEAT_TLBI_CFGI;
+
 	*length = sizeof(*info);
 	*type = IOMMU_HW_INFO_TYPE_ARM_SMMUV3;
 
@@ -400,8 +403,8 @@ int arm_vsmmu_cache_invalidate(struct iommufd_viommu *viommu,
 			continue;
 
 		/* FIXME always uses the main cmdq rather than trying to group by type */
-		ret = arm_smmu_cmdq_issue_cmdlist(smmu, &smmu->cmdq, &last->cmd,
-						  cur - last, true);
+		ret = __arm_smmu_cmdq_issue_cmdlist(smmu, &smmu->cmdq, &last->cmd,
+						    cur - last, true);
 		if (ret) {
 			cur--;
 			goto out;
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index e2f1faaa0d6f..f9f2f47e0ffc 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -829,11 +829,16 @@ int __arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
 	return ret;
 }
 
+bool arm_smmu_erratum_repeat_tlbi_cfgi(void)
+{
+	return static_branch_unlikely(&arm_smmu_erratum_repeat_tlbi_cfgi_key);
+}
+
 static bool arm_smmu_erratum_cmd_needs_repeating(struct arm_smmu_cmd *cmd)
 {
 	u8 opcode;
 
-	if (!static_branch_unlikely(&arm_smmu_erratum_repeat_tlbi_cfgi_key))
+	if (!arm_smmu_erratum_repeat_tlbi_cfgi())
 		return false;
 
 	opcode = FIELD_GET(CMDQ_0_OP, cmd->data[0]);
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 3030f07a7c85..43f4d24e7847 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -1216,6 +1216,7 @@ int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
 				struct arm_smmu_cmdq *cmdq,
 				struct arm_smmu_cmd *cmds, int n,
 				bool sync);
+bool arm_smmu_erratum_repeat_tlbi_cfgi(void);
 
 #ifdef CONFIG_ARM_SMMU_V3_SVA
 bool arm_smmu_sva_supported(struct arm_smmu_device *smmu);
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index fddaf14cfdd2..e9d6d89dcd89 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -602,11 +602,22 @@ struct iommu_hw_info_vtd {
 	__aligned_u64 ecap_reg;
 };
 
+/**
+ * enum iommu_hw_info_arm_smmuv3_flags - Flags for ARM SMMUv3 hw_info
+ * @IOMMU_HW_INFO_ARM_SMMUV3_ERRATA_REPEAT_TLBI_CFGI:
+ *    If set, user space must issue TLBI/CFGI+SYNC commands twice due to
+ *    hardware erratum T264-SMMU-3. See the description at
+ *    arm_smmu_erratum_repeat_tlbi_cfgi_key.
+ */
+enum iommu_hw_info_arm_smmuv3_flags {
+	IOMMU_HW_INFO_ARM_SMMUV3_ERRATA_REPEAT_TLBI_CFGI = 1 << 0,
+};
+
 /**
  * struct iommu_hw_info_arm_smmuv3 - ARM SMMUv3 hardware information
  *                                   (IOMMU_HW_INFO_TYPE_ARM_SMMUV3)
  *
- * @flags: Must be set to 0
+ * @flags: Combination of enum iommu_hw_info_arm_smmuv3_flags
  * @__reserved: Must be 0
  * @idr: Implemented features for ARM SMMU Non-secure programming interface
  * @iidr: Information about the implementation and implementer of ARM SMMU,
-- 
2.50.1

