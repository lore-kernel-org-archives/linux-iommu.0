Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010032.outbound.protection.outlook.com [52.101.193.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D18427F91
	for <iommu@lists.linux.dev>; Tue, 14 Jul 2026 20:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784062540; cv=fail; b=fc9r1ucFDn0AMyLuxw1PgIBvKEkiCwvebOt8dWjE+hGIY51BzwTf7+O1oBPffGktydvs5KUL5P2+MBRMLus0JzqxIX0nUCfuYtrnJtidtSXno6PbcZ72SPUxlSC5NL0wmcuSfNzk/mPgw5g4unt8Nn7trXl29OYp02xM7Xlu0kA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784062540; c=relaxed/simple;
	bh=NmQ26D0DURdXUgTfoc0+/QPFXgmGm+SJTUvJE+Y/B88=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O4RCZt/1m/L5zSckC6emL/Q6eX9aC8NNXYJ4Nqpd9OZiXI9Sb99hLFmCI5K6x+bSAeENBhl0ZLLNxs0B7pTFxIgdy8nWrovFxNOxnCbRkva4XS9uLaOH3rpRVtcQLV0HVDTsC4A+wg8iHo7XJL23EVgsPKE5N3TnjzaF92+C7Bk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MZr4MUcB; arc=fail smtp.client-ip=52.101.193.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MZr4MUcB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yhnlBE430LCepyGnEpiExlNe8naIG7s4hrfj0/Spgd+Br7p7CGBcjhYklxfFN7kgyMHotl5cZo2oYMfYrQ7jrpMr/3/CVHTZK0Mbr3Iu1K7cyoM/8YzHkoWKHXVQVGSti0FXO7d4kZ5grFXrxselOv/ArIVQHeWKAxT9PgMOcsLeMp6Xunu5qIpBpwr91VcTB4N9trjs3+Ln07eM8FGuMn/fnngJlB82pGte7Q4m2eHDHdGJdhkcu/BVp5BegrLImYsJDJqiA/hislpd7xwkP8g7obp4ia2Kv2gXwmcQoa4LaBqYk6aLByAU+c7VVfaCuGWxIh0D7yEWmerjmjWNKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gTAQo2ZdJr7KL7ACFzpn34b6XHoSyP7nCp/LZkZwBC0=;
 b=OT18JKLrADuX40xSZvDeUV12wa9u2iwl2rQS3VT+QwOZv9RTlbXj7m9c665OF/PqvO9t2TVQoJ2bOA6hVgQrmKjoTdwzJ8WOxFbAKYjGRTjmbtF8BtdxAP8tGZYFAvMmYZjtoes2XBoHsZOH1VX2YAEkAfT9GpEY4e0il986KjzFCl3J1pXNAxioTNmxwBc82bKYzybhnShT5g3AjG4PtX+4Wo1hY/fcRlKXkFI4G8G4FNuienwxFmpg+2rBbHyG4kDboSPSs3yXBlBLs1OB1dWbtgZGaIqh0Yflt/YvaewDz1PTxTEDeucEGzb05oOGL6/Gk92djOn0sK/2FqUvlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gTAQo2ZdJr7KL7ACFzpn34b6XHoSyP7nCp/LZkZwBC0=;
 b=MZr4MUcBtx5Lfla/Wes97PLJSxViZSdxPQhwfJufIUzaQFG4Mk7DJg4VimGAQzvDaR3hw17lzBKbY+ESXjD+Oqtfhb/srYaZI8p8MJOCLyEiuW6oJ9P6qgMVRf0JzdgwXziXdTwLO6nOYrwgrtfnxktCOo5F0rg+tOrBQAygf6s94fmoFu17lAP0KFpaBEuOlBcypF0XoPe8RA4HGSNIjXvz8z6jQ6bBdOd4JexJTLRkbe+dnmmDByD9UA+GsrSXDlxRSEANYmdFjvpddcde/+ugwvUuArT4YlGmOJPWgg4KMp6LzLrtGI7E19J3ph6be/3dla4dbFMA+IR3AMQ1+A==
Received: from PH8P221CA0024.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:2d8::30)
 by LV8PR12MB9450.namprd12.prod.outlook.com (2603:10b6:408:202::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.19; Tue, 14 Jul
 2026 20:55:30 +0000
Received: from CY4PEPF0000FCC2.namprd03.prod.outlook.com
 (2603:10b6:510:2d8:cafe::40) by PH8P221CA0024.outlook.office365.com
 (2603:10b6:510:2d8::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.10 via Frontend Transport; Tue,
 14 Jul 2026 20:55:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CY4PEPF0000FCC2.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Tue, 14 Jul 2026 20:55:29 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Tue, 14 Jul
 2026 13:55:14 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 14 Jul 2026 13:55:14 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 14 Jul 2026 13:55:13 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Will Deacon <will@kernel.org>
CC: Robin Murphy <robin.murphy@arm.com>, "Joerg Roedel (AMD)"
	<joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
	<linux-tegra@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 04/11] iommu/tegra241-cmdqv: Don't run the error ISR before probe sets up vintfs
Date: Tue, 14 Jul 2026 13:55:01 -0700
Message-ID: <c1b474c1b2a2178770e45c200c5c42b6be4be4e8.1784059577.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC2:EE_|LV8PR12MB9450:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e0fc20f-8f3a-429b-8dd5-08dee1ea3d1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700016|82310400026|23010399003|22082099003|18002099003|3023799007|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	N0oU3YTP2zJ95hTsDkmK0bsBVX+Aa/bIKXPdIrsWsDAoXFo+boJ/Tj+0pfi8lKgDaLXgUhbr/R3wg69YTU6cbklMrDRyUWjOetXqMCGIwzotUzOqaarmpfQttiJ4kytl0dXkydh/TRpWUrCVnoqmxov1zX6oZk8XQiRo8qKnEXqLkCag+nGgPwLljJK83OjOboXY39XvHIXTEae8e6ZyuerccyRnbK08yu2UfMmSITRgtY3QcQXgnAy9X8TkO4EK5D27ttg65FLASd7Q+v/ZfVYXS29FHQdbgc3obNO+Y8pvCB/7EQPZuCtENU7MmK7sI0fL/xY5iIpi2fek2IAjeShOwgqyBJl+9fUlF/VoqJcbSFgbgi7LFyW4pyDZfrBCaDLj9JvD+f0MwIBFE6sUbz+58X6zSjQhG12ZBiByeio2XNo5ZTdGNxYAJCnT7exDVtc3znts6G+Q1qPjMF7iGXH4efAY9Y9YYJIzcGAePFonkV4jrzbRNQlx/aM3f/SZBbILrjzpn087K63VSLqBO1KcrFYcsNU6mRkixl/ijl8bmfU1/D1U4/KlRxzfkVDwck5khY9+Zoz8Rbryb/CBhFuQIKUi04iGUSR2Msjuq4xVJHdF1MjvzUs4dG15QKXNdIxHvkz/U+hRNApDhT6SpF/LC+JLxG9QnJYx/jcs0Jv6iTOXg9rPjwnMQhYWcG4RSDgwskTnY37HZNjLpiDWQA==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(23010399003)(22082099003)(18002099003)(3023799007)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	JNwUwnSCMXND1xHS5CuAM13Y0ZoA2GcBz9rd9EiNCQHeX0sZIDMtCZZcRbSP3ZNsIfbsNH7vs2aFL9tYxa2JbzNsbEWB9glZFanVV7zt7Ar+pwF++UzMyELS33GXdgMTP5NI2XkmOJn7oLKOe134wD6VyNg72mnjgkZHxqOvyv6pvWhG/gHU01c7fetPXmwThB9iDLc7/rp2bK2SsbSfUF9x1qgrKC5aApRv9SE7ZA7aG2vwiGMY/2O0BfP+EzRdSW/yCSFUEHZtjxegWtzCvhGwD2ng6E3ZfJNcrjYSGrrZ2u36swgGIHlazWOqa3HLhEDPeS0lrzcZ4WjVdhFHWOwURt/UIwLMZ/ASsRSWQhrSarSisV1otX8UlUSVddII7S3PWPgm0h1YQYIfUQghzxtaPf5Ih677SkHBIoHLptnllr7S59VFBGTWL+IZUtjV
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 20:55:29.5870
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e0fc20f-8f3a-429b-8dd5-08dee1ea3d1e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9450

__tegra241_cmdqv_probe() requests the error IRQ before it has allocated the
cmdqv->vintfs array and set cmdqv->num_vintfs. A CMDQV left enabled with a
latched error across a kexec fires the IRQ as soon as it is requested, and
tegra241_cmdqv_isr() then walks the uninitialized cmdqv->vintfs array.

Request the IRQ only after cmdqv->vintfs is allocated and zeroed, so that
a latched interrupt firing early runs the ISR against a valid array of NULL
slots that it safely skips.

Fixes: 918eb5c856f6 ("iommu/arm-smmu-v3: Add in-kernel support for NVIDIA Tegra241 (Grace) CMDQV")
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 .../iommu/arm/arm-smmu-v3/tegra241-cmdqv.c    | 34 +++++++++++--------
 1 file changed, 19 insertions(+), 15 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
index b89f021ba0b86..7e366030d9d70 100644
--- a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
+++ b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
@@ -973,17 +973,6 @@ __tegra241_cmdqv_probe(struct arm_smmu_device *smmu, struct resource *res,
 	cmdqv->dev = smmu->impl_dev;
 	cmdqv->base_phys = res->start;
 
-	if (cmdqv->irq > 0) {
-		ret = request_threaded_irq(irq, NULL, tegra241_cmdqv_isr,
-					   IRQF_ONESHOT, "tegra241-cmdqv",
-					   cmdqv);
-		if (ret) {
-			dev_err(cmdqv->dev, "failed to request irq (%d): %d\n",
-				cmdqv->irq, ret);
-			goto iounmap;
-		}
-	}
-
 	regval = readl_relaxed(REG_CMDQV(cmdqv, PARAM));
 	cmdqv->num_vintfs = 1 << FIELD_GET(CMDQV_NUM_VINTF_LOG2, regval);
 	cmdqv->num_vcmdqs = 1 << FIELD_GET(CMDQV_NUM_VCMDQ_LOG2, regval);
@@ -994,10 +983,25 @@ __tegra241_cmdqv_probe(struct arm_smmu_device *smmu, struct resource *res,
 	cmdqv->vintfs =
 		kzalloc_objs(*cmdqv->vintfs, cmdqv->num_vintfs);
 	if (!cmdqv->vintfs)
-		goto free_irq;
+		goto iounmap;
 
 	ida_init(&cmdqv->vintf_ids);
 
+	/*
+	 * Request the IRQ only after cmdqv->vintfs is allocated and zeroed, so
+	 * the ISR would not walk an uninitialized array.
+	 */
+	if (cmdqv->irq > 0) {
+		ret = request_threaded_irq(irq, NULL, tegra241_cmdqv_isr,
+					   IRQF_ONESHOT, "tegra241-cmdqv",
+					   cmdqv);
+		if (ret) {
+			dev_err(cmdqv->dev, "failed to request irq (%d): %d\n",
+				cmdqv->irq, ret);
+			goto free_vintfs;
+		}
+	}
+
 #ifdef CONFIG_IOMMU_DEBUGFS
 	if (!cmdqv_debugfs_dir) {
 		cmdqv_debugfs_dir =
@@ -1012,9 +1016,9 @@ __tegra241_cmdqv_probe(struct arm_smmu_device *smmu, struct resource *res,
 
 	return new_smmu;
 
-free_irq:
-	if (cmdqv->irq > 0)
-		free_irq(cmdqv->irq, cmdqv);
+free_vintfs:
+	ida_destroy(&cmdqv->vintf_ids);
+	kfree(cmdqv->vintfs);
 iounmap:
 	iounmap(base);
 	return NULL;
-- 
2.43.0

