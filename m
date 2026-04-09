Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011038.outbound.protection.outlook.com [52.101.57.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E78532BF4B
	for <iommu@lists.linux.dev>; Thu,  9 Apr 2026 19:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775764053; cv=fail; b=Dolwc55PthHXsbF8uunkczJOfR5ygPmeEFMvT8k65VJ7jPzxTbcOuJBVaI+uAmaEFsAGj1uRBZMqoWsP5LtwFC6B+j+ZfKMVIrQt3/AEgqAMyGvzc6oTqtGmbTvlF0s/PSThuwP38Rk9v42j2aOc75nseGDzSEEtePv0UMVOUVo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775764053; c=relaxed/simple;
	bh=rS7V/R46B3KCandkmu07XO1c9SXdJ+UgazyihSVGijc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gM4VC7cDAZUZJ2EakynZlIdbpqvzekTOUK0dHkwhrnsZQP3bf8j804bbiu+9EhX6ois7/YVbp6uMZ0pCCr3NrilghlvAej6Y+QFuLlz8GYPPz6T28/iH8blOqgkqJislc5aEicfcHWlCgkzUXPDF6ImJ3cP27UlJpR1IJEEZRls=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bzib6ixo; arc=fail smtp.client-ip=52.101.57.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bzib6ixo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rlt+ftQB9EamrOy+CPIovI3N1zkobO/+tMmuwbHZgxc4uxXwn8X1LadnD6o/QctF+zB6PhtTU6WA+q//dQOiOhWflg22YHZK2vckiNuR32MmZvpkFg7YPt2E6jc8gZDWbTPKvS9uHG5g5MwnWfal9rUTNbBhOh0+dHSb+tFeK47A3NKOkkqyXzbQttGQyo1d3YfcOWniFMq3cZ1zjCsw4EezPw9R7PQvMx9/+TcHqulOrNIfKtU9Th8c38PWqT8yWG6shZ+R7jvjHcKpc+fMM8dsDNREbYgCFyHbxweNDXdVFHHB+QsKq4rCXafR0hJ1vhdhxd9v8i5XoffX0+A+3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YlsgMILGi6M6Rfnr4sWvDKsCUOQ/IqxJ9ZegVh/xfS8=;
 b=g1bQ/IzzdcDfIplOKaJOX2iDfgOgGXEsGcUKbzCchaJj4ZYc2AhVI5asGBr9i30GvOPqhvISaukM0CFYMAJUaIP3ma5EN/Bp4O06GPmKQZ5WsRZpc+AccZUY2FEZL7QoHVA5EQjj89qmFDz7+T8Gr48j7jH7A6ZmaA0qQElGBrOJ7aTqDWiHTr+d2SHQjTuWpSnh44GCcv1tyUfLZRoBPOcbbC0jnwNcydW/fh19wu1B9AJNIcMXWig/wyQpPh/OOwsg+0drKVPmMN1wGzgK+3wxLFU5pUSF0mbSzzrfrmgMT0WbSnwEb1uCqfZxcMEeBDA9YPq1K4Re0HhJtj3fAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YlsgMILGi6M6Rfnr4sWvDKsCUOQ/IqxJ9ZegVh/xfS8=;
 b=bzib6ixov6kd+tKlQX6wO7VmZriJjiP3nAzW8QYhK7B6RvvFb7RpXebf/En/USE9yDto04qYZgsixSFUYaVTG//PoE/DFUd7fEQnvJNpvSR6ZLg5QSwxM9e9rzRzBSNsOT0kgItyCXNosdovKRxkydaqFyjxT0mp0E6mWACXR7t7Ddo4qCMN/qhD5WLTK4bBnlmmp6HpZSrn6KxsUXR4CJ18voEkhmvLZl9AgyiEnI29shApotOs0lc3H4/xSgb/AQy9VHyxu7fglbrjhtXDw3ACTgm0NroF9CMV4viiCipjoIT5WiZUh5jeKAdyy8hfb0O9VFXzC5u0xCYcvisOdA==
Received: from SJ0PR05CA0204.namprd05.prod.outlook.com (2603:10b6:a03:330::29)
 by IA0PPFD4454CAA9.namprd12.prod.outlook.com (2603:10b6:20f:fc04::be5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9791.33; Thu, 9 Apr
 2026 19:47:28 +0000
Received: from SJ5PEPF00000203.namprd05.prod.outlook.com
 (2603:10b6:a03:330:cafe::57) by SJ0PR05CA0204.outlook.office365.com
 (2603:10b6:a03:330::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.41 via Frontend Transport; Thu,
 9 Apr 2026 19:47:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF00000203.mail.protection.outlook.com (10.167.244.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 9 Apr 2026 19:47:28 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 9 Apr
 2026 12:47:12 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 9 Apr
 2026 12:47:11 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 9 Apr 2026 12:47:10 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <will@kernel.org>, <robin.murphy@arm.com>
CC: <jamien@nvidia.com>, <joro@8bytes.org>, <praan@google.com>,
	<baolu.lu@linux.intel.com>, <kevin.tian@intel.com>, <smostafa@google.com>,
	<miko.lenczewski@arm.com>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>
Subject: [PATCH rc v1 2/4] iommu/arm-smmu-v3: Implement is_attach_deferred() for kdump
Date: Thu, 9 Apr 2026 12:46:51 -0700
Message-ID: <e8ecb53e8b435fe324e685ebcc4942a3204a733b.1775763475.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1775763475.git.nicolinc@nvidia.com>
References: <cover.1775763475.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000203:EE_|IA0PPFD4454CAA9:EE_
X-MS-Office365-Filtering-Correlation-Id: ebe3c974-1038-4af3-7f0f-08de9670d4e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|7416014|1800799024|82310400026|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	54jw8tL56ab3/PmFqeDxELpD8w8u+nKL/fGRxgUFmhOiXSIWNRqgmhfNj9Jzr9JAJeW3aj7/NOiG33S2Xj+o8RBOeRXJyYnabOkodE9vtEvnSC2U1Bt8/3YMLaAbqfhXraitpTm4bJZU44vVdXWURm56sQRu7nhJg6T9+2VMTvsGyvXfmH0aU6y30DgDkPbWyl6f1MvMW+XjeVPPKejjbuAkcqw85bC8S1shdqPzJosu9grV5Wk+nmU/Zgc2oMeyj8FfXOfQxsBDKTcmOyuMcaJ9cmKk1hORpcnuXBdYgXcjipvfYTsAJDaZS6mEpOiqaoA4suFCPsMC3VHBjot4D3HXE72XaOmlZxJNWFsXyGIyyKFBXUXKi/UMaCVlZNtEQNoiWrxqY/9za0jBdfJOy1eXTdGOXjXU9CrXLjQ3A7/0gXzqO9chx/vlmyA5JQ34ZfCQ0Zj/ec5rTT/0Y9jzPsMxaMOOafDVgbQlbhuLMyExrcka+ToIV/wgqUk5WSYg4i1064fV/H+pZovEDmXp+N8Cc+yzIvfzVadT9NA84klHR3MIW+0+8exc8C86CKxIpXTSxb9rOhU0E9rjo1oBn1vj6D5Gg0szKuvPFUCmPnluKIpGH+7coXzSTmEHAqz37z+V5ZNt3aMH6+yXN8oI7vbovti6juPckuunlOEzhLcnlU8jYGHqlXUigrBX/uWD/zmF7foxsM7ykfKaffW751owKNFcjfflfui5c7VMlT3dBoT/mJ9kjnU9Qt6pMkwPKisYqcRDaJ9kq7rsJb/37g==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(376014)(7416014)(1800799024)(82310400026)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	tAq8NWwdHwGqpYt9jDGDVKwTreG801jIw19BLwPs7UrY9tTwvriJh0wZO3sSoyH+a3Jz8B7mp62GjWHTLdsS6B8N6tr6QHI06kRngr55cbH98qgS37zoF8KutFURXwD1dsGlX2+owtG3/9UQXUSyoAwgrzpK3+GpOcxuTbTYERXrKbxIfN13wiNiSYBAzOuNyM3m62cg+NU1exZQuW/uLwkGNYKQpwDIiAGT0fLjY1qEuheR7Y9kRVs3hMM0VGoOlg9w8IVFE6T5cF7sz4f+zFbpg6SL3NMdBQ8CB2Q9vaBICjxnqQgq96WZD0UZ8Trls2k0F/ydiz6jOWZD6Mfkv6+bgnwq5j/ECMlqxeoTQVOU/BYT25DSK3B3Ep4s7MUltrzhl7e9sJ7Zuunakyaf1h34z8WIEUlW5lVdnaVYQG7vZ3NKDoAZq9AjUVXk3yDD
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 19:47:28.4863
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ebe3c974-1038-4af3-7f0f-08de9670d4e5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000203.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPFD4454CAA9

Though the kdump kernel adopts the crashed kernel's stream table, the iommu
core will still try to attach each probed device to a default domain, which
overwrites the adopted STE and breaks in-flight DMA from that device.

Implement an is_attach_deferred() callback to prevent this. For each device
that has STE.V=1 in the adopted table, defer the default domain attachment,
until the device driver explicitly requests it.

Fixes: b63b3439b856 ("iommu/arm-smmu-v3: Abort all transactions if SMMU is enabled in kdump kernel")
Cc: stable@vger.kernel.org # v6.12+
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 28 +++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 8a1de3a67f78c..ff3c1beb3739e 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -4212,6 +4212,33 @@ static void arm_smmu_remove_master(struct arm_smmu_master *master)
 	kfree(master->build_invs);
 }
 
+static bool arm_smmu_is_attach_deferred(struct device *dev)
+{
+	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
+	struct arm_smmu_device *smmu = master->smmu;
+	int i;
+
+	if (!(smmu->options & ARM_SMMU_OPT_KDUMP))
+		return false;
+
+	for (i = 0; i < master->num_streams; i++) {
+		u32 sid = master->streams[i].id;
+		struct arm_smmu_ste *step;
+
+		/* Guard against unpopulated L2 entries in the adopted table */
+		if ((smmu->features & ARM_SMMU_FEAT_2_LVL_STRTAB) &&
+		    !smmu->strtab_cfg.l2.l2ptrs[arm_smmu_strtab_l1_idx(sid)])
+			continue;
+
+		step = arm_smmu_get_step_for_sid(smmu, sid);
+		/* If the STE has the Valid bit set, defer the attach */
+		if (le64_to_cpu(step->data[0]) & STRTAB_STE_0_V)
+			return true;
+	}
+
+	return false;
+}
+
 static struct iommu_device *arm_smmu_probe_device(struct device *dev)
 {
 	int ret;
@@ -4374,6 +4401,7 @@ static const struct iommu_ops arm_smmu_ops = {
 	.hw_info		= arm_smmu_hw_info,
 	.domain_alloc_sva       = arm_smmu_sva_domain_alloc,
 	.domain_alloc_paging_flags = arm_smmu_domain_alloc_paging_flags,
+	.is_attach_deferred	= arm_smmu_is_attach_deferred,
 	.probe_device		= arm_smmu_probe_device,
 	.release_device		= arm_smmu_release_device,
 	.device_group		= arm_smmu_device_group,
-- 
2.43.0

