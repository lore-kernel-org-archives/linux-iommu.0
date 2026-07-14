Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010056.outbound.protection.outlook.com [40.93.198.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7384427F8E
	for <iommu@lists.linux.dev>; Tue, 14 Jul 2026 20:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784062540; cv=fail; b=ImSqf4Ib2GSDKt2WQfrk8pguRrPKcBF8b87YnxpPTQeLcX6gaYDso/+gz9cTzRtct/3Pk94EeQYJ5jE3GClurYodcZGSDpfoGWT9FSLU5+LWIJlvKeIr1VBu7XFrpbqmQtWmo2sYPzJNCpQGjAIHn2QSOFZFxj+5qAauv6LjZjk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784062540; c=relaxed/simple;
	bh=Urbg6QUsvaHws4O9rajkpTDDHewVWE849Im+8P6nDqc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E4K2u5YZwLwqRcBK+KhTEfe9tSzbfUNIO3llGwaT4iQ7BEeLqPeYKEWDMZ6G8aqr34yYLBzj9v63l0NsU0bmCpYHPmXslhK0N5E0SuO+pRuGKsPMacqDA+aNoOQjE/0ucBw2GJThIbzMZWPIl6GizNSBYlD2Yb4pqphkQGJjDaY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tMFGoZAg; arc=fail smtp.client-ip=40.93.198.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tMFGoZAg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YbGAzWIBWHV1JdVUhgzy6GGzj8wh5/P4Lj0b0i2T5HwCWEcBNEg8CKNyFlz7jjf6z9zbzGtafKWPfrDQWKG2k4HmhUzitMjPcGHXX23k2tVvKWLE2ufK75G228DrbXr4P6rcyosF3t07CKjwz/YrKGrDlUwpDY+8gRXi+K2hX5SRTGOwGGgvqIADurlS73mw6di7fcF8doBjO/Cgjd9cmNAtCa5+natsf0Dtgr7P3u87gNnBCeeEPFwZqyEhHjYVT7IR+XqOxbgq8w0ad5zhF1WC8IzsJQ1T7vBSbFvxkSRuTkBlWhXDM30WMS3v+HkpL0x0y97XgssueTIV+a0uiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bdn0PEMO559eGmJIGVgBPlKC/Zz31FDwlfVkx8vP6oc=;
 b=KEO8ypnx7p7qUYb/Z78lJ4YXE4eGwiwtfPedAC4vyUaP0eQXHG+7zVPn7pY6NIHspIDcITI7Wj87g89xFLNvybGZTqqHmhP8hRwfoVdKYcv+e+82y/zGTAvBpJBJdNH+b20ZYnVnn1eynEsgU2E35z1VbhJkiA3y4EeqGuN8OwDyPhM5ddn4In6zbb6+8pQyeLJ6YdFVvMZlxs4PoeyPJbXYYIER8+541K6Lh6QndYxSrm+RXe60VKNl7+k1sweI0HgnvmQbhlbOd1KwA81BfOZ3PmGFBY5uht0hktKovXR/zMXnNUphBm/syV4TjDTzMAwXYXjJfvmcy5h2KiB1ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bdn0PEMO559eGmJIGVgBPlKC/Zz31FDwlfVkx8vP6oc=;
 b=tMFGoZAgwfiE/AdyT6kgIDvxhGlRb2gbLsG8RcLoJF5jfErfj7Fh+VJZixRJqH+oVbJ+fkeEC4Y3Oj8mooFmUqmDqUlJfDl18sV+tVUkEeb13e1KO4Vv17BY72165n4goUxRLl0DXASiwvdEiVdL+9ryo5QZcmG3FhqEme6Vm+M1rhtlETnNaAgPbCZvQU3OcYD4sjU/q60ke/6uRpbhzeDCpWSLs2dA52oeN+4H9bse/lfMXgnEvgItFDD2BBEHBDGHmH0lFPpYnOXPZL0ZnND/Th9c+MmV3jSYIUJ00N18hHqZfkQNimu9+vY1QvnrAqGAiCF73NLYRbGkTDEbwQ==
Received: from PH8P221CA0022.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:2d8::7)
 by BY5PR12MB4242.namprd12.prod.outlook.com (2603:10b6:a03:203::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.10; Tue, 14 Jul
 2026 20:55:33 +0000
Received: from CY4PEPF0000FCC2.namprd03.prod.outlook.com
 (2603:10b6:510:2d8:cafe::3) by PH8P221CA0022.outlook.office365.com
 (2603:10b6:510:2d8::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.9 via Frontend Transport; Tue, 14
 Jul 2026 20:55:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CY4PEPF0000FCC2.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Tue, 14 Jul 2026 20:55:33 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Tue, 14 Jul
 2026 13:55:16 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 14 Jul 2026 13:55:15 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 14 Jul 2026 13:55:15 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Will Deacon <will@kernel.org>
CC: Robin Murphy <robin.murphy@arm.com>, "Joerg Roedel (AMD)"
	<joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
	<linux-tegra@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 06/11] iommu/tegra241-cmdqv: Free the error IRQ before tearing down VINTFs
Date: Tue, 14 Jul 2026 13:55:03 -0700
Message-ID: <cb219d3a195decc5ade9d687162ad545d6999212.1784059577.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC2:EE_|BY5PR12MB4242:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cfc2ad3-a4ee-4016-fa88-08dee1ea3f2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|23010399003|1800799024|376014|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	S2onWIRPHHkTfjrIujNCkd4VY47Xvz2X2fwzw/MGZQy2NNoqZHa5wOBQLLbsyDGnCtJHTDp6sNdBdwqU42tIlDiVSHgyl2PyaZHtq4cZJ5/tk7Nn8lW9fKcaExr7Gl5I0TFZkI68VbWJbMZhLD7qjzqTKbV7s3AK+z8d9HACcieHFZrJsDAjfWhLc5nU2K87SDjxaPpW3WGQEejln8Aoytiv4emF1A3JFWvtKtjJ+ZQtWIkkAEL38bTcXJEm5kyHDWUkKgEewHcJzb+4FK8/hIlZyBe/8QySZWLZvJubqFpY8MFE28DCNaNRWh/fFMo4OFAzPw3B8qlM0tMbQnalXGynnCE9EM6XF9nEQ8o5aFWXmPV9yQtqURLGng2Jmdo8+fLLbeBb4rciIxvt6Y2lIEZwPCybO9SIMSUN/I0nCALcMmjSW2qdH7REKSTTxWu9/d5tNehfjZgOLAfNdxPci3OmscOU0+Mb7+CGMDI3LPIaW59G2Q3+KThruYNT5mKslOyfE0gfjQelu+sC2qy7Usvr18zsoiPM2CbBpsUE0Z+x1v18OH48cTFlELDjwfbvby9cGOOvjrHyBFySHYUOQMkYcYcew+3By7e85QeHge1VtICNfnNBPpyvsUVLmXkIkajES2pV0WlBmZLDarKJmd+vWCpLaN+Ws90WpwqW5gt1Of6Bc7zdsIgYUG4kmZW8kD/EUbLEBbp9C0Ly95W6aQ==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(23010399003)(1800799024)(376014)(18002099003)(22082099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	pXsceft1IxArnQqEH82EXO046zb5Mm7x6RQFETc0KvXXfLv/2+LgGJu7gSgtX9Hx74c/9mAsanxaqoyhlSvjt4RkcF/NTQ7Jzpbl5Yit1u08EFZAXY555q/oZy86mD/DHAhoXbLQL6bFA6K79dNgZdJpmS8zm2lXn9uqi+BYWIroEU7CAsExKweHg7CK4QEayS6tahKSTyiGf9z4Gn9Rp3kkOsLjRevd5xqe5OLR1k7iMbl3DngNYsAi5cocvqOjMqdzNT//Q0c57kWBEYepp/d9OC7ILhqYHqtSC2jlIFbpaAbU42cmVFmVM1aYLhXdM3Oy9xyQyFtHYi1HSPY0rVbblS61dgtSc2PsW8m6dCeQXT8tygBLu1OXQnOUFpnPqKsa4jE+wuy1X7lFEaS56ko//s2CewX56ZsAObm/UaWGQRpU0I9MwxpbwLpZ7PjZ
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 20:55:33.0163
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cfc2ad3-a4ee-4016-fa88-08dee1ea3f2a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4242

tegra241_cmdqv_remove() tears each VINTF down first, then calls free_irq().
Tearing a VINTF down frees vintf0 and clears cmdqv->vintfs[0]. An error in
that window makes tegra241_cmdqv_isr() read the stale slot and hand it to
tegra241_vintf0_handle_error(), which dereferences a NULL or freed pointer.

Free the IRQ before tearing the VINTFs down. free_irq() waits for in-flight
handlers to finish and blocks new ones, so no ISR can observe a VINTF as it
is torn down.

Note: a user-owned VINTF (viommu) could outlive this teardown, which unmaps
cmdqv->base and frees cmdqv->vintfs, so a later viommu close then touches
freed memory. This is neither introduced nor fixed here: a physical IOMMU
is not a pluggable device, so iommufd by design holds no reference on the
one behind a viommu, and this teardown is not expected while that viommu is
still alive.

Fixes: 918eb5c856f6 ("iommu/arm-smmu-v3: Add in-kernel support for NVIDIA Tegra241 (Grace) CMDQV")
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
index 262798cd6b8a8..fbf7ecf043a8c 100644
--- a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
+++ b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
@@ -829,6 +829,14 @@ static void tegra241_cmdqv_remove(struct arm_smmu_device *smmu)
 		container_of(smmu, struct tegra241_cmdqv, smmu);
 	u16 idx;
 
+	/*
+	 * Free the IRQ before tearing down the VINTFs. free_irq() waits for any
+	 * in-flight tegra241_cmdqv_isr() to finish and blocks new ones, so the
+	 * ISR cannot dereference a VINTF that is freed by the loop below.
+	 */
+	if (cmdqv->irq > 0)
+		free_irq(cmdqv->irq, cmdqv);
+
 	/* Remove VINTF resources */
 	for (idx = 0; idx < cmdqv->num_vintfs; idx++) {
 		if (cmdqv->vintfs[idx]) {
@@ -841,8 +849,6 @@ static void tegra241_cmdqv_remove(struct arm_smmu_device *smmu)
 	/* Remove cmdqv resources */
 	ida_destroy(&cmdqv->vintf_ids);
 
-	if (cmdqv->irq > 0)
-		free_irq(cmdqv->irq, cmdqv);
 	iounmap(cmdqv->base);
 	kfree(cmdqv->vintfs);
 	put_device(cmdqv->dev); /* smmu->impl_dev */
-- 
2.43.0

