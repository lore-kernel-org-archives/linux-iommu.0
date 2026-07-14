Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012010.outbound.protection.outlook.com [52.101.43.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB3042BC56
	for <iommu@lists.linux.dev>; Tue, 14 Jul 2026 20:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784062554; cv=fail; b=hs6l3yGV8+b21u/32JwYLioYxCt0sfLPkFfkVnu913yrXevNKuEBzUssI6GAQJX6G6Vd1CttnL/U1kI2wN41jrK/aBohgnmXDJCuhYP2ZxvAyF4BaL9uITcs5mvbeAA9DZbC2Fp4gne8xy6f01BLHFfM5UmvY+WbUPTYnd3fwUM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784062554; c=relaxed/simple;
	bh=XXjBO3fCtJ8pV/FjkM4tmLF3aG4NBkBa+vYv6T6qw0k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OGh3TZHQw+xz1IEzgtSYIMoEx4AtUS/9rtOeQobkxr2b3XduUDz0Ex1vz4dVnIe8q3U88saycnTx94bZytmig8lh0z4/SgiVvbopnxfipYnn0pnHi9UbixHY1j6LnFvXbaySsiZW+pAE1Eo/bGXbwhTVOSeHEANILj1qIfYOb2g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nd5xDFB4; arc=fail smtp.client-ip=52.101.43.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nd5xDFB4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cxO2cV0dwS8QlS0tNVZE6oxKRQ00wovfRpfhPP/+9zzaaMCVGcEoMJrrFF+kPAlEbcbVBRS8qPd+5vtDu2J8DOBlOarfp1gcbay8uDHn3Hl+EaIp8NCx5Jrrf7jbhVJFcyUgi9mddC/bka2yY13GKb+rqwTuEPkzVne4yGMurInWps5TJGIGdP3viMfNeX2lx0zzgJjdzX3yL/GJBFHhnzTcUgN81ce34K+vC+2/K4tUlSEcSqJGrq1dVBuv36VfiSIp+LP2Olzyxg8PNolZsbDNGC4h3f0MaVMeo0ahny/Z8VlZPKaEV/3i8q/RRo0kJLWK70f34ASNu+69/tpE6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gb2OczpIKYaIK1PP5Qu02iBDQ0Tamghwba5pckLeWic=;
 b=yA7qUWuTBgQSN6qg26+kDcm9p9oV13zwiclNe2k5hgzHJjdSy4ys/npy6ADlDALLoCO4VTLco8y4P6X7l43ibXF2SAVSsBvvtHaINb4pEusnWfpr5o/qqAl+y1GTUHr3El3bxzagiTCu6zo9qB/JyiSzmR6IQUoKAGxIPAK2EC2UM+5uudKDkxSasjcDP2zRweLkz5clooXmXRs83Lm7ztFvJf9hXhrmHk8OGFT2YGdIOflSW639lCW8F5H0Xh7QVfPvhR0vMVUub/8cMwlUhLzaceGq/iGBhfgoR1BwvvbhvjsqezwpXjboiYdSY8s/JUZsytoHDNGLa0CuLfN0lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gb2OczpIKYaIK1PP5Qu02iBDQ0Tamghwba5pckLeWic=;
 b=nd5xDFB4akAx1xZtCtbQBhEj4lqksn97KIFZ0F8ot2mtm4papZ+R6q+fZ1xfGeSIFacMtnVBV2rm7S7jqu5Wbx7UEUhyK2anBoXBQHz3l8nVla5fqpdMTmyhe1B+1u9ROc/syJHR09YYIcDD7PRni+GxU0scQhVPEV1eUBgLhCMThn3CSGpl5zuF04A4KkfdKbndESVvCpHBqL/47l8YfVO8wCExqshamtgOeM6Asy1UTp6bPZ6rxM9dZ4YoVu/Vm8U5z03kaSiB0M4pMVB9gbFuuaJpycIQ+y8+hvGKaVxUZmSjJSo1opoCGzZJ4rj1quU4WpfX4+ORuV7jX86x9w==
Received: from PH7PR17CA0047.namprd17.prod.outlook.com (2603:10b6:510:323::29)
 by DS5PPF016FC81DF.namprd12.prod.outlook.com (2603:10b6:f:fc00::644) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Tue, 14 Jul
 2026 20:55:38 +0000
Received: from CY4PEPF0000FCBE.namprd03.prod.outlook.com
 (2603:10b6:510:323:cafe::98) by PH7PR17CA0047.outlook.office365.com
 (2603:10b6:510:323::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.10 via Frontend Transport; Tue,
 14 Jul 2026 20:55:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CY4PEPF0000FCBE.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Tue, 14 Jul 2026 20:55:35 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Tue, 14 Jul
 2026 13:55:16 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 14 Jul 2026 13:55:16 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 14 Jul 2026 13:55:15 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Will Deacon <will@kernel.org>
CC: Robin Murphy <robin.murphy@arm.com>, "Joerg Roedel (AMD)"
	<joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
	<linux-tegra@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 07/11] iommu/tegra241-cmdqv: Reject a vSID wider than the SID_MATCH field
Date: Tue, 14 Jul 2026 13:55:04 -0700
Message-ID: <3cf17b4f317a6b9dff6dc2cffed24b069d310f1f.1784059577.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBE:EE_|DS5PPF016FC81DF:EE_
X-MS-Office365-Filtering-Correlation-Id: e803bc18-caa9-45e1-ca0e-08dee1ea4064
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|376014|82310400026|1800799024|6133799003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	i71lnoNQ6aSy3rkw0DVCCaQ2QSBZC8lXvszQUsHZvq2c0QvEDWqkHkN1KAvCKG1ZeDymwzcdmvCszt5+vWFqTUdaAACnRBVdPepHeQKOvBTJ7aBufWn2wSWDK+MTYE5wmvu3lF+bqf6/0W65/FfFjrSdF09K8+W/HW7mBLS0QFwRAAqYhGiJcAXeVn1Ic0eNZ+CJCW6w0mjnboKDYnVKv8NY2R7vPR+3XQTAyi48Whhpv8IwaRDkiXSbvdVZNyXiGxgL8Momjjz6Zf0PPf3/61ejpaXBJGDTjNq5dW3jjjNopJm5Vn1yTO3ZAZ0uLRZyI/CfeZ//9+af7TZdIsUtZ1IriubZ4vzchomSftUN0xi58F90CGP3thDRd14LIPl1CD/Cr+gRDSo9jm4wl6tCMeVdMbOeeu4Cl1YxUiZ/OZQA910aJ/S0QjQPU1GKvlQHCfV4ANhzuy0p6Ewu6m0uYYhqLxOD8IngLKVtnaYCIgxhnZfaq8hLDWmHTSzC4woDEB8qi+HBwoGBVUsEpMpc1KJjVwxPbqF79leGY8EnocDxRm1o3TR6S+Cz9B4/6TI63Fc8+CCYUg2O/tAj46s83huFQkzxekOQqrp3CmFRk4vjo3NZbZeo/5qh0EiGYQeaZ2oaPuEWxlNGPfkZDTa8nIc1I9GbvXebCAvxFkG9KotvRO01SLhzLaQF1e6+oyJ33atjp67Prf7p4Z8zhO950A==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(376014)(82310400026)(1800799024)(6133799003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	OEolRh30qZp2j5bWfWjBjiO+Z01lvXGp+YWn6DLRInT9hv7Cm0DokA5pRO6xVnIRg4mrTfemYCLYbiQkFGWpbLRiBxWXQQM8/lUXTbYi1K88vgh04WiFWusXwG/VW20mEj+oBxdOp88WMMCBXmfJKGHIQyiVxmITCW83g5+qV4x7t+krnZJOJh5OoXQdfLEAD2wEOjq98leBAl3aRlBhCYkWbd47oHvM3t9QakMklFsXowVe/M8OKnj98hsydyeW4nmfTlHE0lDhsv7c7FznyfDw6xTwVz0y42NxpMbyCWBo9DFRbiB2cCnd+FaYHUVF3FuMrvDbHiBJF68QA3zNL4icmtzMqYzWNwaMFAqR8HDZ3O2WfiOnIkRGyEDvV7Hr/DUgrQpG4mNY0WlsgcqKL4a556oPG22aIugzcVdAFqoDNUgiZsN0n2WaeDZX8TH5
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 20:55:35.0902
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e803bc18-caa9-45e1-ca0e-08dee1ea4064
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCBE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF016FC81DF

tegra241_vintf_init_vsid() programs the guest-provided vSID into SID_MATCH,
whose VIRT_SID field spans bits [20:1] with bit 0 as the match-enable flag.
The HW therefore matches only a 20-bit Stream ID.

The bound check rejects only virt_sid > UINT_MAX, which admits a value far
wider than the field. The write "virt_sid << 1 | 0x1" then drops every bit
above 20: a virt_sid of 0x80000000 lands as SID_MATCH = 0x1, a valid match
on vSID 0, so the entry aliases the wrong Stream ID. Because vdev->virt_id
is guest-controlled, a VMM can trigger it.

Validate virt_sid against the field width with FIELD_MAX(), and program the
register with FIELD_PREP() so the value and the field stay consistent.

Fixes: 4dc0d12474f9 ("iommu/tegra241-cmdqv: Add user-space use support")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
index fbf7ecf043a8c..812cc500b4a1e 100644
--- a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
+++ b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
@@ -56,6 +56,8 @@
 #define  VINTF_ENABLED			BIT(0)
 
 #define TEGRA241_VINTF_SID_MATCH(s)	(0x0040 + 0x4*(s))
+#define  VINTF_SID_MATCH_VIRT_SID	GENMASK(20, 1)
+#define  VINTF_SID_MATCH_ENABLE		BIT(0)
 #define TEGRA241_VINTF_SID_REPLACE(s)	(0x0080 + 0x4*(s))
 
 #define TEGRA241_VINTF_LVCMDQ_ERR_MAP_64(m) \
@@ -1244,7 +1246,7 @@ static int tegra241_vintf_init_vsid(struct iommufd_vdevice *vdev)
 	u64 virt_sid = vdev->virt_id;
 	int sidx;
 
-	if (virt_sid > UINT_MAX)
+	if (virt_sid > FIELD_MAX(VINTF_SID_MATCH_VIRT_SID))
 		return -EINVAL;
 
 	WARN_ON_ONCE(master->num_streams != 1);
@@ -1256,7 +1258,9 @@ static int tegra241_vintf_init_vsid(struct iommufd_vdevice *vdev)
 		return sidx;
 
 	writel(stream->id, REG_VINTF(vintf, SID_REPLACE(sidx)));
-	writel(virt_sid << 1 | 0x1, REG_VINTF(vintf, SID_MATCH(sidx)));
+	writel(FIELD_PREP(VINTF_SID_MATCH_VIRT_SID, virt_sid) |
+		       VINTF_SID_MATCH_ENABLE,
+	       REG_VINTF(vintf, SID_MATCH(sidx)));
 	dev_dbg(vintf->cmdqv->dev,
 		"VINTF%u: allocated SID_REPLACE%d for pSID=%x, vSID=%x\n",
 		vintf->idx, sidx, stream->id, (u32)virt_sid);
-- 
2.43.0

