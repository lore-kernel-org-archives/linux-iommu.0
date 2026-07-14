Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010062.outbound.protection.outlook.com [52.101.193.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F77427FBA
	for <iommu@lists.linux.dev>; Tue, 14 Jul 2026 20:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784062557; cv=fail; b=JrtZSCX7ju3jdELhIRcHO6MDGKoMelKZbOPq8tHzSJO+06NutXphYWsxGQovndiu3ca/7ivaD379TVGjF1ZysJeblI91LHdSzdWnuXBlI7bXirCrLlOieqx8fOCzZhCQf2IOsgWXlaTbDw4aMdSxHRX/N/C12bNIrtOLIGy1t58=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784062557; c=relaxed/simple;
	bh=yExzBTt2qPcj80DNM32crk940r4rNuxg0ljWZU5yrAw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DCKZkvPy+zUCouyPYlMyxzkrWIvybv1ny8Fkcc/qvvj2HUNRj8KcN2UPue4WmDhEigsj9Bds8n9j7vega4zFG9/wj4gyvuutdIWT8m4XnDUtVkd3UcGoFRBEYPCQ30baaJDmbTVVG8/Vjzm7bH0t32RHQzKXY5pMl4g9vrymmu4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Cl9MNCn8; arc=fail smtp.client-ip=52.101.193.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Cl9MNCn8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rIVdruwgK7MjQKfx3BfutRdoZJ0XmGtwfwtRWv5qbhFDQuEcHnunY4tcnb8fegPuuFwkwKpSW662LY1vqhJrPrSxQ6oVm9NzlNht7u/3yhnOnEGC1dlWe1oTUrrXgum+t/LZA/KoqoxFgWJ8te9g+1XvIO3Cs+jYQJyGsZP/sjxrpJVraMBV9DsGllqpgPTDeySuYiBBctwxl8d3MpnsVDJaqTRB3zxl+B51P5jJRBQ9MHLvYYSon5uHi0hrdBHJw9XBDchwU9VWDzggl0ED5A8MCNed0KeftFkAwMd/KIgvzIUlCV5Ilv68zWv92o6RTzPx1i3MDXSZ3XYu9cUAaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XmpNk9qGPsz4Qzcw/ZGmi42J4ven8E8cs5INl9cFIKs=;
 b=qj17MmHyLknTBk6kBjOIWlvhCGXtHlp9AbN4a1VIMLXQxYTNQ21gGtlwi6Qw/pqp9mVCt2SfGy7rbnRABrNyKTCD0CLHHozSp+7OS95lV5Hc/ttpSZkz/RCjnPo4MKtenfeIQLlxIUtnrgMBpuJ400HlAJwjLIQp/ovCY99FcAPVirmhox3qHT87HIZYbWKovE3flLZwIDkKNy2a1mu7uNVEXzqZWghheelx9H6XmHPHBJFp25330AR6m/0B1aZH5fzuRKMObPAsn3KL9EnXmtEeAnzPVZPrQAjN/rXexDoP+5W3I/CvBaOGm6HSlwkFTSJJR7fsHJ0pAyjP51nwyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XmpNk9qGPsz4Qzcw/ZGmi42J4ven8E8cs5INl9cFIKs=;
 b=Cl9MNCn8fKwff+480sOHLbM/CQbRWUXLcoQ9uciow50narrORw55Zl8QY2n+OC1XCgAO+3mAXt8OSvdXQB0OhnhjnFTQCXiBMH+V0IHbQqGVpw1HGs7T+qq7+oWF9JVqAcdAJdM3l4dgn7vpoWmtBxOZl8SLMZGxAArPflNUzCcG5FMUvmv6qUVYlixttzGhXryj8Ed5MSodAlhemvmbTwZ2z2MhwfUF8j3gaLiFc9qgwRWYqDlKALnOvd4hoa+VNKjCdulJVJ469b4s1aGc1lvsN/F6TgFVaq/M2nzgVIU+qk3yAFPdUoGmsO0RTfnMg+Jx2c3qE52uTltrE9ywog==
Received: from PH7PR17CA0036.namprd17.prod.outlook.com (2603:10b6:510:323::20)
 by PH8PR12MB7447.namprd12.prod.outlook.com (2603:10b6:510:215::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.23; Tue, 14 Jul
 2026 20:55:43 +0000
Received: from CY4PEPF0000FCBE.namprd03.prod.outlook.com
 (2603:10b6:510:323:cafe::8e) by PH7PR17CA0036.outlook.office365.com
 (2603:10b6:510:323::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.10 via Frontend Transport; Tue,
 14 Jul 2026 20:55:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CY4PEPF0000FCBE.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Tue, 14 Jul 2026 20:55:40 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Tue, 14 Jul
 2026 13:55:19 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 14 Jul 2026 13:55:19 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 14 Jul 2026 13:55:18 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Will Deacon <will@kernel.org>
CC: Robin Murphy <robin.murphy@arm.com>, "Joerg Roedel (AMD)"
	<joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
	<linux-tegra@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 11/11] iommu/tegra241-cmdqv: Rate-limit the error ISR's log message
Date: Tue, 14 Jul 2026 13:55:08 -0700
Message-ID: <2e9d088c059037d5fc23532820444720b870d2c7.1784059577.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1784059577.git.nicolinc@nvidia.com>
References: <cover.1784059577.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBE:EE_|PH8PR12MB7447:EE_
X-MS-Office365-Filtering-Correlation-Id: b79a75eb-52fb-494c-33da-08dee1ea43ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|23010399003|1800799024|82310400026|56012099006|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	l/YjfowV4yTR96luHjRLF+63+OSZr8Jb2k9HgBLY43gMa/zhSD5Mb1lFa2w7eIr9FHlD4bjLikakhR/k7ZgbUlTFcBAJGAXcI+mCuIGhEgsyOwCvZnFjWgayagKnrkiQb+UfsPlzufHC1Jg0gBOmDdzGUAdVjUzVlMaT9EH1CYmv5moAl0NvQLBpcDYAeVSYC9ketoKZc2TCRlnz7w6u4Tq5xy3PCtpYp3pxNvB7SA9Jt38zAzzgu8L8bxXbG7PrXt+l5AJWMm/Ey2HKcLf1I5xWhKnjW8I/Ep86uIzLOm8K5kiFk/O1aWTDY6pBrmiWkvKG3a+tLbTbI1NnBVL/plwh7Z+Yke36bJwfr1hktXKZUo6P8Iq6tG9xjVoo6Eu3ljaqZd0+OcamSx+ZxswJM+ktqRTI1nMAi07NVde3XLvWCeS+QNI2NjXvIkdUmOF3KBcMM2jpcWJFwaCcL5XiqfFhCFoh7Po+0S/VQnoY0EArv5ws65ZQPYdcRJemeAmt09YLCcpfc/bCAXC0AcVRqCQUsUb+86YzXQK++T3nB9gbvYmG8dxYsBD47BFs4HNddgJR1ul3zFO73RfIbt0BS7E5At6ZFuMOI1bq+Pwcx2dlSHhUOihSDBwiBHBnJrUfRse4oH6QSMeb7yXuKNct5tBYMCFkxc8ipafsNBdZZXatjxo9xN/UHo2FMpfi02pj8CCLgh9wbzRLihDsaOsiGg==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700016)(23010399003)(1800799024)(82310400026)(56012099006)(18002099003)(22082099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ZgxprbMR3v7QDSCXf/fb4u0+URPvhKBdxcYo4gcxka3dQ3sS6djjTeIQPawQEEJryblTwYEgkX1sz8ZDzDzZOIrve9Clkup+ry5p0FBpIHhzyYM04q++L8MPrxQWZDsGYPVrdEEMd4oGrji0d8gPablbgqZroeMyHQlRLya8h10HEVLk5bvvKhDbyvmbCYo+DtSAopEfzjQwAqydB2ePoEuCFLZixu0nFcttMCxzjYhzTg3T0bFcZ63VeWF4IWdixszsvkt7FHx39u2MkmAvh7nmDf2+KogZQdcqSmmkFaA56XvVBR5Tyrmz6DiSqhHs/qUynL7fkA8XtG9MheoF0/bkQBArP3fv5LYnahRY9uQUQwOOq6MiDEW2e8owo5vg9NizQ53udF73/+SnP7UjyJ/hsPUrDc22quYylDGSOymBswsGm8hp/47hcqIaiXgY
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 20:55:40.6296
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b79a75eb-52fb-494c-33da-08dee1ea43ad
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCBE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7447

tegra241_cmdqv_isr() logs the error-map registers on every error interrupt.
A malfunctioning device, or a guest deliberately faulting its own VCMDQs,
can raise these interrupts rapidly, and the unconditional dev_warn() then
floods the kernel log.

Rate-limit the message with dev_warn_ratelimited(), and pass the error-map
registers straight to it so their four MMIO reads run only when the limiter
prints, instead of building the string on every interrupt.

Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
index d27ee215032f7..6fa981574db9f 100644
--- a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
+++ b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
@@ -353,21 +353,19 @@ static irqreturn_t tegra241_cmdqv_isr(int irq, void *devid)
 {
 	struct tegra241_cmdqv *cmdqv = (struct tegra241_cmdqv *)devid;
 	void __iomem *reg_vintf_map = REG_CMDQV(cmdqv, VINTF_ERR_MAP);
-	char err_str[256];
 	u64 vintf_map;
 
 	/* Use readl_relaxed() as register addresses are not 64-bit aligned */
 	vintf_map = (u64)readl_relaxed(reg_vintf_map + 0x4) << 32 |
 		    (u64)readl_relaxed(reg_vintf_map);
 
-	snprintf(err_str, sizeof(err_str),
-		 "vintf_map: %016llx, vcmdq_map %08x:%08x:%08x:%08x", vintf_map,
-		 readl_relaxed(REG_CMDQV(cmdqv, CMDQ_ERR_MAP(3))),
-		 readl_relaxed(REG_CMDQV(cmdqv, CMDQ_ERR_MAP(2))),
-		 readl_relaxed(REG_CMDQV(cmdqv, CMDQ_ERR_MAP(1))),
-		 readl_relaxed(REG_CMDQV(cmdqv, CMDQ_ERR_MAP(0))));
-
-	dev_warn(cmdqv->dev, "unexpected error reported. %s\n", err_str);
+	dev_warn_ratelimited(
+		cmdqv->dev,
+		"unexpected error reported. vintf_map: %016llx, vcmdq_map %08x:%08x:%08x:%08x\n",
+		vintf_map, readl_relaxed(REG_CMDQV(cmdqv, CMDQ_ERR_MAP(3))),
+		readl_relaxed(REG_CMDQV(cmdqv, CMDQ_ERR_MAP(2))),
+		readl_relaxed(REG_CMDQV(cmdqv, CMDQ_ERR_MAP(1))),
+		readl_relaxed(REG_CMDQV(cmdqv, CMDQ_ERR_MAP(0))));
 
 	/* Handle VINTF0 and its LVCMDQs */
 	if (vintf_map & BIT_ULL(0)) {
-- 
2.43.0

