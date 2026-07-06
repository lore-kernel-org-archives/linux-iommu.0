Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010028.outbound.protection.outlook.com [52.101.56.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DAFE3BBFBD
	for <iommu@lists.linux.dev>; Mon,  6 Jul 2026 05:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783316218; cv=fail; b=TGqi6ERR74qci5HXyz3hQpZBodJZR0x1tILtjJjvLmL6eCHrgvVLvEuagHMI00dAji9mqp0l6Clb2W8C8+eweEZXakwz6fZBl9udOdNiR67LbF36ThxOCY4A1Fnr735lRuqaiHLvGexlt0Xj7HCzWcigEv+3NGzPyNSngdbRlYY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783316218; c=relaxed/simple;
	bh=gBrgHL1OqOhRt4a+HWUdgnDFqfnrZJWzdTK4h8U12Aw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YfrTPtz7vqFpdxHSiu/VophYhFZWmgQHyixhZy5U7ZY1JgKmfPjblb3yMMNPBwozrf+yssek1X3wLRlkTy0Sq2hKV8wRHRK4UW5E+RX9rJUWD49xqZXwhzvU51ThLN0NlxxxMj553PXZrJclVzpOu38yxHUdHA6ph7OS6V68Mv4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YuGFUiLU; arc=fail smtp.client-ip=52.101.56.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YuGFUiLU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AZO2FYnX9BDDbYGPJqyubTcQl24PcNNtxHUevdv32nvZH1YZSOOVKPg+uqHjQCG3rseMILP/JE109ZTUzqGZ5R+zyEhSg4FDwRI74tQn/qQPFGlcbC52kFHZVMmibwb8t19iYOP2iasODsRCnDUK7isLofTvW+KlKmgFqolNjtMU4dxFoe4oP6UaWvtyUxB/at4VzQynTTue98QKhIrxbxcbeHc4/EozfY7PhgTKCx/K6rz7yqAQ0U7rEVL++o+ihh58ncvAJUTK/4/Tp/XzRxEz7Pf5S86mwYaMOTA225SU423SRi4+5k9XSMvNNA+E/6FGymwLIiMloj7J0uQt/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZgMuR1aNHn5GQpHs5l/DTCnvU5JKPJm6hfsh4qO3Ayw=;
 b=mOp4ZKTFBmmkKZFN0W8ysDBh78LKm9ZNWSLnQasKL/8cA8xcue9GFfnc43rlhGG+HarP3SmFApvUmRXfTUpi0v5mkFmtDeZOrYBCUltTkn2WyuA8Ta4mdaeXyHIPbe2p6S6GVMJdOjbzYnndnGrWxvWRlq6W0M+fDHUM4NMYmppoFLnIX/XIHBZDVRRzmM99cP1WSC5X9RfBkt87/MxkXb+Y3uIfcAfxdyWkKAv10yhYibtDDnwidV0gAk8rAWppDir0sIOIuqhwXECjqdUOADv9kYQCIQqR/sg4tMwDYP7kNSjxhhIMPOcMzaFBmui3OCVUSdeNOcVQi/rllQ+FDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZgMuR1aNHn5GQpHs5l/DTCnvU5JKPJm6hfsh4qO3Ayw=;
 b=YuGFUiLUV7nufPbM0Vp0aPqCMuZ2tVDvHq7r0P3bExnoD36S4gDfD6+CUoSvITIfpN7hGkoCyed4YTlDCTd5zSPHCgbXesfOU0CnTfLfORIJP4EZuXBdkDDNZiVnPGQetnAdhlZUj7hDRYIfQsGscpCD1uN/iqS+ymeG5cFK+jXlo9jL3gjxx8ugV+z5635sb1kE6pe443+S4YWV4HBnHEaMwaxIoLrOxG/SXbq1AO/3l6pySjSQC4ElG5eH/AXV3N7SFLv2iLGEsdCrczLmmQC1OXqtXQF12+L87KQcy8LR/rQgCerFuAcLc3SOGSkjSrTCGAVSGl0idVAA5i0MHQ==
Received: from CH5PR03CA0010.namprd03.prod.outlook.com (2603:10b6:610:1f1::20)
 by DS0PR12MB9275.namprd12.prod.outlook.com (2603:10b6:8:1be::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Mon, 6 Jul
 2026 05:36:50 +0000
Received: from CH3PEPF0000000B.namprd04.prod.outlook.com
 (2603:10b6:610:1f1:cafe::2b) by CH5PR03CA0010.outlook.office365.com
 (2603:10b6:610:1f1::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.13 via Frontend Transport; Mon, 6
 Jul 2026 05:36:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH3PEPF0000000B.mail.protection.outlook.com (10.167.244.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Mon, 6 Jul 2026 05:36:50 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 5 Jul
 2026 22:36:36 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 5 Jul
 2026 22:36:35 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Sun, 5 Jul 2026 22:36:34 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>
CC: Robin Murphy <robin.murphy@arm.com>, <joro@8bytes.org>, Kevin Tian
	<kevin.tian@intel.com>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 2/3] iommufd/viommu: Publish a vDEVICE only after vdevice_init() succeeds
Date: Sun, 5 Jul 2026 22:36:10 -0700
Message-ID: <1e05999347f4bf583edbc6a1312c857d5548708c.1783311134.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1783311134.git.nicolinc@nvidia.com>
References: <cover.1783311134.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000B:EE_|DS0PR12MB9275:EE_
X-MS-Office365-Filtering-Correlation-Id: 420fa9f5-25ca-456b-1a06-08dedb209436
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|1800799024|376014|23010399003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	f50jeDq3Rw4VHrvy4qRiBbvJLb3kg1e7OS65kuSi3u+XJoDvQKPglL9BPvJg6uSzUVtRNGeWQikLzMcvvVwYNE8T4D9CwnCRQTa6hsw5Urom2QodvsfOxhzvO1+SQM9NIBByWclKomC4HErrTOVGrjFvWBsmc/Q0iH9RR2uTXbB4maTvNkUspvJdNpudJlPK3N8WOFyiZ8e1O7Hc0Hd/OWEGOgA7t/tgD7OGuCX1QpQdpR62+0B1ojJm1xEnZFSTVVzQaOtP1KpSPAEUvUdciwkezjM234qQ9Duxc8kRmfY0fGAIffyp22HMuedCStjSMF8xL7y5kzbvelQVMZ/YWoD9TIRVV3SwSfBntfeSbYMsBbuTazu7mj+L3y9zx59Bk0Gr2URreyR/IUygGnbfW+q6ETc1i/PfsFrH6gx65NpLXcQ/YYLgppplHEI+SlkdTlj199PExgh/TdxLeD9vrB+inkkmu1ITYYzDJ6Lq7kCFhju+WhmCFQA2kenDTMjdZ1kj3TPRL2sJAoa6oMo/DzLol2h5NZD3Jo10Li+pOo4ZaQoUMj6q/POIhtYFqjiVVQE0tV4pUu46JQW2obl2ksRB4SiKCssgwQJpEB2uNQ4KbNfpfJcAOiNoPWfPjTFqP3pB4RNGHjxfJGr4NcXrhARAHwmgBSogwcKRz3+sXUbw8ZVrpl1xpLmv0E9vWE6k3hRcaiDP6PhSB2urvL/Zkw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014)(23010399003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	qdfMwDtDdx2dgtJDpML5LdMnfmgktrvpC5EnchqjOAfIh6YOtRkMuutOoCNA21SzTIDMrWsDMGoJljEIVbetEM/2twrcYQJsddIxlBdiRNpBknO2upwwy4xrFxw7DUQNDDGxX7SWkBrZZjXboxwvZZSdfwgdyv6sMi8YwlXripPWeFZYy9hn31cHKfC91Pnn2aqjhKn1yoVJ4o2/m1kEFunXOQFYecsCgcMuvEszu3xvPVqgfhLgC7r2Lw+cbClfGGHGC8hRq0ryt2MhMeND25E8QMu5eMiLL6KDZipluCBt1j9pXocQbhfSN85U1QsRVEcClv80cbrv4NRiKxpMQQXzWHiOBdRCNl/tnsaKwW3BMgUwj1FsQpO+jx5RvTFSul/KjVFzCaUBeuuGYdxY7pDCNkcAKRDOYTLyzcsz1Ro/xFwZxfaDFC8Ii0ZdC9FJ
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 05:36:50.3499
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 420fa9f5-25ca-456b-1a06-08dedb209436
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9275

iommufd_vdevice_alloc_ioctl() adds the vDEVICE to the viommu->vdevs xarray
with xa_cmpxchg() before the driver's vdevice_init() op runs. That op is
where a driver validates the device and may reject it, but the xarray entry
is already live by then: a concurrent IOMMU_HWPT_INVALIDATE can look it up
with iommufd_viommu_find_dev() and run the driver invalidation path against
a device that vdevice_init() would have refused.

Reserve the index with xa_insert(): it stores a zero entry that reads back
as NULL, and returns -EBUSY on a duplicate virt_id. Run vdevice_init() and
store the vDEVICE pointer only once it succeeds. A failed vdevice_init()
releases the reservation, so lookups observe the vDEVICE only after it is
fully initialized and accepted.

Fixes: ed42eee797ff3 ("iommufd/viommu: Add driver-defined vDEVICE support")
Cc: stable@vger.kernel.org
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/viommu.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/iommufd/viommu.c b/drivers/iommu/iommufd/viommu.c
index 0c12c7e352a14..fc13cf4737ea3 100644
--- a/drivers/iommu/iommufd/viommu.c
+++ b/drivers/iommu/iommufd/viommu.c
@@ -143,7 +143,7 @@ void iommufd_vdevice_destroy(struct iommufd_object *obj)
 int iommufd_vdevice_alloc_ioctl(struct iommufd_ucmd *ucmd)
 {
 	struct iommu_vdevice_alloc *cmd = ucmd->cmd;
-	struct iommufd_vdevice *vdev, *curr;
+	struct iommufd_vdevice *vdev;
 	size_t vdev_size = sizeof(*vdev);
 	struct iommufd_viommu *viommu;
 	struct iommufd_device *idev;
@@ -218,18 +218,28 @@ int iommufd_vdevice_alloc_ioctl(struct iommufd_ucmd *ucmd)
 	 */
 	idev->vdev = vdev;
 
-	curr = xa_cmpxchg(&viommu->vdevs, virt_id, NULL, vdev, GFP_KERNEL);
-	if (curr) {
-		rc = xa_err(curr) ?: -EEXIST;
+	/*
+	 * Reserve the slot with a zero entry (reads back as NULL) until the
+	 * vdevice_init() op accepts the vDEVICE. Only the xa_* helpers hide a
+	 * reserved entry, so never use a raw xas_* iterator on this xarray.
+	 */
+	rc = xa_insert(&viommu->vdevs, virt_id, NULL, GFP_KERNEL);
+	if (rc) {
+		if (rc == -EBUSY)
+			rc = -EEXIST;
 		goto out_abort;
 	}
 
 	if (viommu->ops && viommu->ops->vdevice_init) {
 		rc = viommu->ops->vdevice_init(vdev);
-		if (rc)
+		if (rc) {
+			xa_release(&viommu->vdevs, virt_id);
 			goto out_abort;
+		}
 	}
 
+	xa_store(&viommu->vdevs, virt_id, vdev, GFP_KERNEL);
+
 	cmd->out_vdevice_id = vdev->obj.id;
 	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
 	if (rc)
-- 
2.43.0

