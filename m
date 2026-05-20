Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010022.outbound.protection.outlook.com [52.101.193.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CEC63F166E
	for <iommu@lists.linux.dev>; Wed, 20 May 2026 17:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779296655; cv=fail; b=cMdl7+6bZub4/36aqkNu8fpimU2TWv3XMKSHfzAgkS716Iq13TmnCMYhpnWR/ayhGQmPnLNzdrdDlSOFAtXjpFblych/NrdiJObdQyEsebP29TIrJ95Mkpt1SqO0sv54+Yb7iQVJh9wTgfE2gDPl19S56lc8ZLV701IHNdDXlI8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779296655; c=relaxed/simple;
	bh=tvTYT/ZMaRkdroaJ6tA9Iyl059UXdkIAPb2I/ndKN3I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X03iiMvmKEd4DddRIMLG03q8qG+r58nbzj/XcTEdI0erwkb2ApzC/hNS+Ade2H73GAB282siwTiffZxi5Fb87jLOvIFqvF2sVbMlqBwEJ5G9JeKPzSQXWz70/tCP5WIXhr1jZcsts1SUO+SwEm+ksuiIzEnyqe5GOV3/ltR3Ch4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZneXJ9vO; arc=fail smtp.client-ip=52.101.193.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZneXJ9vO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UCfmArGauoaqz4t4iPA5oBuVKt8G5Qldk6pwIYTdeVFaq1mEKNq5otazwlS1ikPQzrcn0/d8741c9qLq2lvbKwrVBWdKKiB8evnZQZ3ExY0PHepA35s2ynbwFdEliFwNLJS9lLtAK28w7ZolOznolkKSjMW9j/Utgimd5S6tXg4fAjkyglchssjb/i7SwTqFj1UQtNMioNkEDfwfDw9mpup+1HcMoGK2hukNYAaqUHpBqwYpbjAHjMiu6tLCw+k92LbDeooZmUV5jVlXXy2fPWuejtIFmo11uoQiNMuV4QC0re81PB+TEUaaCTYz8c/88B7UJyhj+LFIQWQxoL1+mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pnDtufOW8l6Zrd59ofXSykOoKaT3jPPK1CfcZDK6ip0=;
 b=FFwGVw13WI/ACtyHoPbII4Q2Fu0LDcM6clzBFvtIeMmuFnowd86IRbnGG7aII+GQNNt5Q0EGjqnZf5MLYXjtsqvyONR/QjlquKikkCV75p4/OMIo5HciJkfZ275gVbxrwL0rpgaoT1ecKYvUpIn8jeeYCTcIJh/ykFZW8lUNt2H3sy92g7K11+NZcDE5JM4GyhUg5XdbFefdbf0448bW0EWp08PT4tLtU0e4TaGkfsl+A9uex67qjQFgt3mETZe9lOYLqEl8c3OdWno/sIBtPmN/AVeCu7HrY321JwJ81FQKPQRaTZ+oUAc2FFnywStTN7N5IHtvYlw6+BVzsDso7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pnDtufOW8l6Zrd59ofXSykOoKaT3jPPK1CfcZDK6ip0=;
 b=ZneXJ9vOy1ol95gFACX0wXMByjdkIyj6WcuOElW1QoWc+3D4EUz0frYOpoJvki3hCexNLnF2lz9ClAkaqKyG6lD6XMJZ1bn276CP3/1Pg8l/A2p9QGGDn2Sp8VawtAiacvrhm+HTI5VK+uN+g9YeD//MasEldcGtV2WZv0kFXjXMkyhQ6l3CWIECQwBo04Fc/mdwMYgQZmyakWklaSnSuPki7ffE1WcVQdjrey/iHG/yczPOKJA99JoIU4JV44jB+Acyih0/3V59eGfEsBbEeT/Ivtg8UEex7MIGKtnUvCkj1j9el9xvrE6EbNnwx35e715CRnEeOd5SYYnNzWhn8A==
Received: from MW4PR03CA0355.namprd03.prod.outlook.com (2603:10b6:303:dc::30)
 by PH7PR12MB7234.namprd12.prod.outlook.com (2603:10b6:510:205::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.18; Wed, 20 May
 2026 17:04:09 +0000
Received: from SJ1PEPF00002322.namprd03.prod.outlook.com
 (2603:10b6:303:dc:cafe::38) by MW4PR03CA0355.outlook.office365.com
 (2603:10b6:303:dc::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.16 via Frontend Transport; Wed, 20
 May 2026 17:04:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ1PEPF00002322.mail.protection.outlook.com (10.167.242.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Wed, 20 May 2026 17:04:09 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 20 May
 2026 10:03:48 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 20 May 2026 10:03:48 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 20 May 2026 10:03:47 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>
CC: <joro@8bytes.org>, <praan@google.com>, <kees@kernel.org>,
	<baolu.lu@linux.intel.com>, <kevin.tian@intel.com>,
	<miko.lenczewski@arm.com>, <smostafa@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>, <jamien@nvidia.com>
Subject: [PATCH rc v6 5/7] iommu/arm-smmu-v3: Retain CR0_SMMUEN during kdump device reset
Date: Wed, 20 May 2026 10:03:22 -0700
Message-ID: <f3866cc84cde2108b28c35b570ae502384e84c2a.1779265413.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1779265413.git.nicolinc@nvidia.com>
References: <cover.1779265413.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002322:EE_|PH7PR12MB7234:EE_
X-MS-Office365-Filtering-Correlation-Id: 6551ea99-dd0f-4be7-b812-08deb691cef8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|376014|1800799024|7416014|18002099003|22082099003|56012099003|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info:
	tZRWY12OSSVPEv2fJLN/Cxv4cMkKyuaJFSbky0CuSfUC0EJ/uujg1FhXxrWJkYewypNOQMadVh6HQcO6O8NC5bIpXpGbVyuMjAVTi94p1K/L3MQKnumk4eOtQZU0wRfX1AE0/QsV7x+PED6+/OT9uADYFY7gd/L0osNNxGhMXObO1/e7Y0bkpiimWug6pqJ3FLVJrOd31M8g+UFPVD5QkB9NjoxRV7dCZt1TZQlKxd1Ytiz/bNo0UOLat3HOsQWNHeest0S/LWSZloGhZiLZzXYeh8PLw6Ir5wCuvGKRUX0tBXRgw8X7jSGSnX3lZBbWC/Ga89WOzNmiOlDS9XL9dOsKX7bmGOAc50Q5YWbaz1D0CxEHcbpv/WNywAcxwiFGlMhbo/yyK5xrgkFRXpuK9K6D+QKglY+7VY2zTctDW2Ajhp5L7XUKo3fN51/rDPQKEC8V5HsOfK9Ke1FUXvNHpnz56T1MQTEoQae3epEDOY24HGsFKtAcCYK4o6gktrvQHNXTj2TxBF1Ar9eTOOcto5HujXfj+vEM7Sxeq+ZJyF2yZ5lozOF5VUlujSsBfPlzj6X7Lghf3IjaoRqMrYixIB9Za0zckXRqNpALeDorQQbXIy5ZRDsgkgR+axjNz2ytRbfNZz98yVZdx4sv22IV8apRUJ6SvAl+Qc1j9+sDzj+cYZrdVQ8gLf7iuWnkdlNctzckXCj5tw63AYi6SCuhMBwo5Kbowkvd3d1gtOCqNsI=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(7416014)(18002099003)(22082099003)(56012099003)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	8v9zQULJfA+MInfY2IsxDVijzJch1FP4RpO/A+kvPEB7XTEeprIjSeqWitRj5sqhRTBPBR5s4AjQm3now6bXFd6zFdMg6fwdPQB5p1x7qS+bOsZod6G2q68Hy4+VYXyNDkC8muRUfC+Uwr4tJA2CSbXxduN8E5JBYWgWq5NhKqE04JDeNHO8COqbn9sWY5sgtb3b0r4zZn3NHFNqHZpgmjMVTANtenq516NnGiMEXbOX6OPLqeq3+7Mub/lGxy3+mQhr2pC+AhJDhAwvr6oL8wdlgKZQmqbaXjjswn/OqiAxpc2F3o2l1MeZQ2VrQ4K1YTpU22nnIlhGviRpLi2sjx42fq0sapQmE5fWlUxoBEWzImR7wkTnP+tQgzqT98t65dmZlUb8IeRgqnVlxYNo54548SjRLar156LDcwUWP9uKUoLKY6Dk4OVfVWZE6XOK
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 17:04:09.1974
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6551ea99-dd0f-4be7-b812-08deb691cef8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002322.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7234

When ARM_SMMU_OPT_KDUMP_ADOPT is detected, do not disable SMMUEN and skip
the CR1/CR2/STRTAB_BASE update sequence in arm_smmu_device_reset(). Those
register writes are all CONSTRAINED UNPREDICTABLE while CR0_SMMUEN==1, so
leaving them intact lets in-flight DMAs continue to be translated by the
adopted stream table.

Initialize 'enables' to 0 so it can carry CR0_SMMUEN in kdump case. Then,
preserve that when enabling the command queue.

Clear latched gerror bits if necessary.

Fixes: b63b3439b856 ("iommu/arm-smmu-v3: Abort all transactions if SMMU is enabled in kdump kernel")
Cc: stable@vger.kernel.org # v6.12+
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 47 +++++++++++++++++++--
 1 file changed, 44 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 3f22949391c82..f9220c007ad25 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -5101,11 +5101,28 @@ static void arm_smmu_write_strtab(struct arm_smmu_device *smmu)
 static int arm_smmu_device_reset(struct arm_smmu_device *smmu)
 {
 	int ret;
-	u32 reg, enables;
+	u32 reg, enables = 0;
 	struct arm_smmu_cmdq_ent cmd;
 
-	/* Clear CR0 and sync (disables SMMU and queue processing) */
 	reg = readl_relaxed(smmu->base + ARM_SMMU_CR0);
+
+	/*
+	 * In a kdump case (set when CR0_SMMUEN=1 and !GERROR_SFM_ERR), retain
+	 * CR0_SMMUEN to avoid aborting in-flight DMA, and CR0_ATSCHK to carry
+	 * on the ATS-check policy.
+	 *
+	 * According to spec, updating STRTAB_BASE/CR1/CR2 when CR0_SMMUEN=1 is
+	 * CONSTRAINED UNPREDICTABLE. So, skip those register updates and rely
+	 * on the adopted stream table from the crashed kernel.
+	 */
+	if (smmu->options & ARM_SMMU_OPT_KDUMP_ADOPT) {
+		dev_info(smmu->dev,
+			 "kdump: retaining SMMUEN for in-flight DMA\n");
+		enables = reg & (CR0_SMMUEN | CR0_ATSCHK);
+		goto reset_queues;
+	}
+
+	/* Clear CR0 and sync (disables SMMU and queue processing) */
 	if (reg & CR0_SMMUEN) {
 		dev_warn(smmu->dev, "SMMU currently enabled! Resetting...\n");
 		arm_smmu_update_gbpa(smmu, GBPA_ABORT, 0);
@@ -5135,12 +5152,36 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu)
 	/* Stream table */
 	arm_smmu_write_strtab(smmu);
 
+reset_queues:
+	if (smmu->options & ARM_SMMU_OPT_KDUMP_ADOPT) {
+		/* Disable queues since arm_smmu_device_disable() was skipped */
+		ret = arm_smmu_write_reg_sync(smmu, enables, ARM_SMMU_CR0,
+					      ARM_SMMU_CR0ACK);
+		if (ret) {
+			dev_err(smmu->dev, "failed to disable queues\n");
+			return ret;
+		}
+	}
+
+	/*
+	 * GERROR bits are latched. Read after queue disabling so that unhandled
+	 * errors would be visible. Ack everything prior to re-enabling the CMDQ
+	 * as a stale CMDQ_ERR would halt the CMDQ and new command will timeout.
+	 */
+	if (is_kdump_kernel()) {
+		u32 gerror = readl_relaxed(smmu->base + ARM_SMMU_GERROR);
+		u32 gerrorn = readl_relaxed(smmu->base + ARM_SMMU_GERRORN);
+
+		if ((gerror ^ gerrorn) & GERROR_ERR_MASK)
+			writel(gerror, smmu->base + ARM_SMMU_GERRORN);
+	}
+
 	/* Command queue */
 	writeq_relaxed(smmu->cmdq.q.q_base, smmu->base + ARM_SMMU_CMDQ_BASE);
 	writel_relaxed(smmu->cmdq.q.llq.prod, smmu->base + ARM_SMMU_CMDQ_PROD);
 	writel_relaxed(smmu->cmdq.q.llq.cons, smmu->base + ARM_SMMU_CMDQ_CONS);
 
-	enables = CR0_CMDQEN;
+	enables |= CR0_CMDQEN;
 	ret = arm_smmu_write_reg_sync(smmu, enables, ARM_SMMU_CR0,
 				      ARM_SMMU_CR0ACK);
 	if (ret) {
-- 
2.43.0

