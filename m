Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010028.outbound.protection.outlook.com [52.101.56.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E66243B3F8
	for <iommu@lists.linux.dev>; Tue, 21 Jul 2026 21:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784669954; cv=fail; b=RNXGh6PbDUVY7r2HkvcZ14RMfDSd5yJoTV9QvMqxtRjgR/OdBGz3A+5OJBDn5qklgRpmH5a1ilGGa1eEdDtpFxlWEQaWcgtfut62NU78Nc+ytQzlDikgErHAz1vmrYeTGbMfvCRso2De3sNa0yskHsZguQWqhOjCQmDNnJb2YFI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784669954; c=relaxed/simple;
	bh=PSFzcWMNcD2Fk/GtRGv7UdYS1EWZS8w5FnmWPH6Gem8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u8g1VJot80H+SfU32u1OjJ1zK6HsYPwLETa/VPPwBy+54N8UH1m4b98r28g8he8cmPvvjoEZrl/Bsbuw4TpNDJE5WqcWq6AFY6niXfuMETp3Zyv1SSf7pv5RjhWMel8xgvyGl01uwULfgIK+5yl3g4y7DHPEpZa8LkBycaenbCI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OSlk1KBH; arc=fail smtp.client-ip=52.101.56.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OSlk1KBH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SqdpI37GfsgLZ9Xgc5NsGl1iyU0PNTN/+8Ob4W5MUwmSLtEAhGU+zPK+euSbd6mrodsSaFytAHtr2NlovqqNjLp7mQ7MikpN6xq2IPtdmkRH9QSroKtdIWowPwpIEd/0NOJOKIGsk5p7wwfWYRgHkpieXCtL4ByTAYu9G6bp+M+9a7wovpUJQ3W6lBFIZlb7oBpKs5QbNLPWu5AWfclpF/Zgua73kECmobn2BpWtYI9ZIEsZWpVqKjSgKln/dWfwhYVrmXQY5DKqmx2il9Juct/KADiLSk0B+TlPyKOORRBY2QwOn+OAFMrkxXIk/J3ej2oQSdRodeKndbLX44IyZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rIpNseA2QTaw0inpiCE3UDKt3XhcTNuN23NO8baE66k=;
 b=XO+lZwbGLyBy901eQIy3ztJL2zyRaCdvsrDPGPFAjLgRhVtqRjxdLJyGQ9h/QB4izoz4jTMMY2osGFvpAbAMHMVBNcbXlrgWKZsXxNMtooTsOW4XUPCP2mA38nVYvdTPSpMhp7SkiQDUxyEYEZNFx/XArPV73l1pElb+Q4BvX+ukuvwW0+jCd5KjG13ApvqsKM8l69nzer0Do/cE7oSD0Ky4jIVveM5oE2cR9ZO/FZkWqmFng5mIFYic3OIjg7Wksu5qqmCcR3iBpX14QgKLklIFAq0AOhdope/zprt8z8eHDB8JjvOE/zd34GrXWyNHh1u9JZ/TysWnCY+36C7JCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rIpNseA2QTaw0inpiCE3UDKt3XhcTNuN23NO8baE66k=;
 b=OSlk1KBHwW8UvSR+Z9xWMeC4YGtXEveO6L2FysY9MwUY5J24LvxTY+BmUd4T4hdqPA1b4zA2ttadV3AmlQ/VK2IGp9cpEiN1eb/JDAzu0h45bl/uWMpOWmOQxgSRcAL99mt7P/w4HjiV2sf8eLV6qgCApk1YmDuKtMxV/4uRyarpOSxFHvMMTuJ9UU7+/uzKYqv8yPyNoRjBHjI1k6oWGCvT8E4xJJ335troPKVMblOQ9ROi84+HM626AVqWFZ1ozLn0dgpFKBMxSRyRr9PQunBzwUVPDvbv/wn+Cv5ejVmN+pgT7xWhdtF4ZJ02XPPssicicthJp8VbL2Rp+nfAyA==
Received: from MW4P222CA0002.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::7)
 by DM6PR12MB4404.namprd12.prod.outlook.com (2603:10b6:5:2a7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Tue, 21 Jul
 2026 21:39:05 +0000
Received: from MWH0EPF000C6191.namprd02.prod.outlook.com
 (2603:10b6:303:114:cafe::65) by MW4P222CA0002.outlook.office365.com
 (2603:10b6:303:114::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.10 via Frontend Transport; Tue,
 21 Jul 2026 21:39:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000C6191.mail.protection.outlook.com (10.167.249.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Tue, 21 Jul 2026 21:39:05 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 21 Jul
 2026 14:38:46 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 21 Jul
 2026 14:38:46 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 21 Jul 2026 14:38:45 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>
CC: <joro@8bytes.org>, <praan@google.com>, <kevin.tian@intel.com>,
	<smostafa@google.com>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>, <jamien@nvidia.com>
Subject: [PATCH v9 12/12] iommu/arm-smmu-v3: Detect ARM_SMMU_OPT_KDUMP_ADOPT in probe()
Date: Tue, 21 Jul 2026 14:38:39 -0700
Message-ID: <629e0eeb1dac857bce3ebcf027938888ab95483f.1784663184.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1784663183.git.nicolinc@nvidia.com>
References: <cover.1784663183.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6191:EE_|DM6PR12MB4404:EE_
X-MS-Office365-Filtering-Correlation-Id: bcd75bb5-4407-4ac0-9745-08dee7707d00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|23010399003|36860700016|6133799003|22082099003|18002099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	zX0jU8nfbMPkC4SNTpSVotnaauMoevS92hDt4BP+XcBZjiSuY5TVzYb7WoTpoyAlcUw+tz9TYeGJ3vLXZ0yi4vsC1knDu3RCk363UM4hyp0utBhd8F/EpEVD3L+9U83Ubhw0F0DR7OOrPz02siDYkxIQK569rJsCbk5n+pmaBBOsv+ETSPXP1niAoG+zjMBK3QfGoon/WqfTZ4tUEcBR2wDpn1F3mhAGXu/ajE4FlvneZC92sdUBYfPzDU5yuYwzE2ao5TT3SSqcL/q1ap/nvywsQjtL+8XhJ3lZVBDWz4oBACh/ezawm7DKEXlv9knDuwgkqyw+AeuAuTjWer8i+h5sgU3tA9OI+2JjFDIhetLnaj8kg74QqsxmuImx1A2m9Ik4DWIfqQjl1IzBJiKQ5dv6WwVQL0F6ERpq80lZgKtqWruC31oW4OQMGDzfUHbGC101IkHFk6IKlAzhZX4AJh8YbdgEprq2d1dUf3OAeI1m+aINRgNgrnGbdRfgq7/WHrGtSrpEmaY0VVv+4lFz8VxwmQxAN9JWMpcyM3h9k5ZaT5CIYyxJWcW5HcO0MrMMM2U5mMCRPE43+Xbye7FaNxrt4V4btd1n/ceOKpkx+GPcdVp0ciW1wv2rWzdd0toYw9U6mQirHpC7Tl9CD6ACzOiW+gqN00Np2nvInIMCsn1ABN3QYhNfG+wTyjItolo6WsiK3NYbfc4w3N7CtLTIEA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(23010399003)(36860700016)(6133799003)(22082099003)(18002099003)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	8I5yMzq0I/w9pf4B8YDWHP/sXk1pOM1catmchh3p+ylGT4H/Pfd3I8MXLJ/xwvj6Xh2Av2kK0S27J2lGh1//S1mN6EtljwHK7OPQzQfYVRUPh7T9a8zw4IcmzOcKKMawo/7js2DmW2dtvWOJgjuLZkosHENBd2JqtA2lnWSYvEXo6tub6ye74qIhGJ8AezyohCXVAdVWzag9qWU2mSx3X5RHrPp21Z+8npdiX6l5oKuXNUek5tE5APim/HqSIJeUpOWPAclPiAq2sWti4TXFdA5NSLQtos4VVMLENwupqNCj5nHE1yCP6slqk6Gi/e6YWq2HDRKOtksL1Iv8QqzpfiGWKN2LRgEJ4h6UqqTaoFp2BH2FlpqqJqLmXcJ+Ko0cQ7XTH/ODlHYQ1zKp8AXeh1IqCutHd1H/qVbTXQva92DEEw7yxPogMX02p3su0XBh
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 21:39:05.1949
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bcd75bb5-4407-4ac0-9745-08dee7707d00
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000C6191.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4404

arm_smmu_device_hw_probe() runs before arm_smmu_init_structures(), so it's
natural to decide whether the kdump kernel must adopt the crashed kernel's
stream table.

Given that memremap is used to adopt the old stream table, set this option
only on a coherent SMMU.

And make sure SMMU isn't in Service Failure Mode.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Pranjal Shrivastava <praan@google.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  5 ++++
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-kdump.c | 27 +++++++++++++++++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |  4 +++
 3 files changed, 36 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 0bc1de6463785..06146b535a1fc 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -1279,6 +1279,7 @@ int arm_smmu_kdump_adopt_deferred_l2_strtab(struct arm_smmu_device *smmu,
 					    u32 sid, phys_addr_t base, u32 span,
 					    struct arm_smmu_strtab_l2 **l2table);
 bool arm_smmu_kdump_is_attach_deferred(struct arm_smmu_master *master);
+void arm_smmu_device_kdump_probe(struct arm_smmu_device *smmu);
 #else /* CONFIG_CRASH_DUMP */
 static inline int arm_smmu_kdump_adopt_strtab(struct arm_smmu_device *smmu)
 {
@@ -1298,6 +1299,10 @@ arm_smmu_kdump_is_attach_deferred(struct arm_smmu_master *master)
 {
 	return false;
 }
+
+static inline void arm_smmu_device_kdump_probe(struct arm_smmu_device *smmu)
+{
+}
 #endif /* CONFIG_CRASH_DUMP */
 
 struct arm_vsmmu {
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-kdump.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-kdump.c
index ea7a2bdd77a58..cc52bfdcb30ae 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-kdump.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-kdump.c
@@ -259,3 +259,30 @@ bool arm_smmu_kdump_is_attach_deferred(struct arm_smmu_master *master)
 
 	return false;
 }
+
+void arm_smmu_device_kdump_probe(struct arm_smmu_device *smmu)
+{
+	u32 gerror, gerrorn, active;
+
+	/* No adoption if SMMU is disabled (i.e., there is no in-flight DMA) */
+	if (!(readl_relaxed(smmu->base + ARM_SMMU_CR0) & CR0_SMMUEN))
+		return;
+
+	/* For now, only support a coherent SMMU that works with MEMREMAP_WB */
+	if (!(smmu->features & ARM_SMMU_FEAT_COHERENCY)) {
+		dev_warn(smmu->dev,
+			 "non-coherent SMMU unsupported; reset to block all DMAs\n");
+		return;
+	}
+
+	gerror = readl_relaxed(smmu->base + ARM_SMMU_GERROR);
+	gerrorn = readl_relaxed(smmu->base + ARM_SMMU_GERRORN);
+	active = gerror ^ gerrorn;
+	if (active & GERROR_SFM_ERR) {
+		dev_warn(smmu->dev,
+			 "SMMU in Service Failure Mode, must reset\n");
+		return;
+	}
+
+	smmu->options |= ARM_SMMU_OPT_KDUMP_ADOPT;
+}
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 168865af868ad..cfa0991cbd332 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -5257,6 +5257,10 @@ static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
 
 	dev_info(smmu->dev, "oas %lu-bit (features 0x%08x)\n",
 		 smmu->oas, smmu->features);
+
+	if (is_kdump_kernel())
+		arm_smmu_device_kdump_probe(smmu);
+
 	return 0;
 }
 
-- 
2.43.0

