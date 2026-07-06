Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012047.outbound.protection.outlook.com [52.101.48.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E3B3BADA2
	for <iommu@lists.linux.dev>; Mon,  6 Jul 2026 18:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783363670; cv=fail; b=P2/et4NlzeUmyAPkeYSIMAMv2wvINzlKhwzk1yk7SO43T7qcym1MZmy0nP9lOVbNYi+hBbC8XrXhQpxr1WCZjUOJJptuMVCE3kux5gSYfeUNrSUDF497KTP5YJK0uM7TT2GGCP8sKiAIFl2CsCMU10IpWv6xPOY+h5H5Oq2h7Ss=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783363670; c=relaxed/simple;
	bh=jrSB6rj+d9qFnT58HAvaqpBAkpyiFgvvwk86MlgS4C4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TGwHWkvQw6dQa0FrIQuOV7cQ0+UihIq9Y/cLnsHbCf3i36SRKiXScsPnd8Yq39uHaOqYyHR3ma4kPt8+Gpqy1jfdPwPO2uaKhWeDEW5k3OXaxCXlQTQxQppv7Q60dhDobLU9AsgBtCwuVMzLLGbNiEarmch9aU26ICBSlkLWaRw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hrEdP5lz; arc=fail smtp.client-ip=52.101.48.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hrEdP5lz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a3XtxueiLpCxzzUpXocVJrSPEJ5SGs+74WEp0EHyjy3bSLl8E8ZaHbNVKsDVmJDiRfEJXm1gWTI9yFqqqs3yg4ZhaQxuNd4k1Hss0cWST/7FTK/ntqnAmVEL+m+UVU1lkNCLmh76e6uxJqtvx2masg5ueZheseqYRohkcsOwCkgmA/Nqm0dbCbJYXK8LRAc5rJd59b5NjjBL1LnZyNTTRJvTm59X5hJ4tRoVW4TpQik/UL9TE3uBJa0Ur5thhMpnqYLshbJlzUbYLmmVZ0ikSXltRjqmXGHN8RVLHDlpeftXtK60eduo/j982C7538k2TbieKHBwET/D7qR7uFcTWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sGbjO+pNrdd+UW4OsilpKM9X8br0di0p/DjFAoXl5PA=;
 b=CAIHCBFE8aZE1Hy2LtnI04P4aZVVpTyhuwB6LUK8vXJSBhdnEjvLzYZ+6qCB9tny5ODTEbtYlFIpzRNYadJkTGaKBEp2GYxnTeINFkxSwVzrMx6dbaPC2CQeksv+S4gPH7dZXshSdV//OEYm6g/LGLlU4/bGO0HhzG8LxOCQDdVrNHJgSmvMrfx2R1cu9wBJSvcvhgzacZC5xipbZQcMjP3AB3RrUmVUi8anOWXk1X8SvoYEPEnAIUe9iC7FHLPAaqkV5/OLwL1nMlZmM9jU2FdrIy7wKbJzv46jshkLQaKgTgL5j8gwqNOKUlymWDn5JzPHXRCtB9j91+vR6VRb8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sGbjO+pNrdd+UW4OsilpKM9X8br0di0p/DjFAoXl5PA=;
 b=hrEdP5lzxE2LcneuoI49UZZfhAOJkpAwuqoh2TJoYMw4oOEgUGmNKiF+X+5yQJmxHZn/hfShvFpQTH9YYpZawPveVC519pgRTqgWXlAMPgRDjThrhEYWpkyeL13j6ckQV+JKIGfPBKSEUEN0KVXFGJRHR5RUxp82eQMSvYitKUqZyKd6oLcYXQ+nJoh9M/+CrRsnm0wcAKk4F9ZPiI89kHCLFPT+dH5lLhDDPE3IV/vXm2UJEqt2Ocv23Jor0I22uOFEUokf6wJL2zggxd8paTp0XpohWPIEC+4Y2ZwCWStDR6+TxReg9EmVt0XIQLCnaVow+2ToISX4dlQJIUj7MQ==
Received: from DS7P220CA0119.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:25f::11) by
 IA1PR12MB6017.namprd12.prod.outlook.com (2603:10b6:208:3d7::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.10; Mon, 6 Jul 2026 18:47:34 +0000
Received: from CY4PEPF0000E9D6.namprd05.prod.outlook.com
 (2603:10b6:8:25f:cafe::aa) by DS7P220CA0119.outlook.office365.com
 (2603:10b6:8:25f::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.13 via Frontend Transport; Mon, 6
 Jul 2026 18:47:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CY4PEPF0000E9D6.mail.protection.outlook.com (10.167.241.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Mon, 6 Jul 2026 18:47:33 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 6 Jul
 2026 11:47:14 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 6 Jul 2026 11:47:13 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 6 Jul 2026 11:47:13 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>, "Kevin
 Tian" <kevin.tian@intel.com>, Lu Baolu <baolu.lu@linux.intel.com>
CC: Robin Murphy <robin.murphy@arm.com>, <joro@8bytes.org>, David Woodhouse
	<dwmw2@infradead.org>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 5/5] iommu/vt-d: Convert nested cache invalidation to the core array loop
Date: Mon, 6 Jul 2026 11:46:55 -0700
Message-ID: <d9c86bdf43e126b1c1998e22143ad54a5711bafb.1783363477.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1783363477.git.nicolinc@nvidia.com>
References: <cover.1783363477.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D6:EE_|IA1PR12MB6017:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a9760aa-7067-4e00-9424-08dedb8f0a93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|82310400026|1800799024|376014|6133799003|56012099006|11063799006|5023799004|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	oIuYgocj3kRjPjeXHKiNqQOnqNTKoMG8ziJaK7cZfPTIxVGAhiccq8rNxIp/yr32mfQFrbGXUpNMpJfkoFId/OPN20jOfjNEKCz83XHPeZ4fldcXF4LiwHYP2J7SlaFsYkKKRTGEe5kmXRqZZlWUUb2rNlIkFAvDt/VJXkTs9CCD2DZOaf8PlopvvS2GTVv8s2rIAr8J+8o3QjtPUhhotl/CCR4pJzmninZxGeSJLvX/qKn5qxeKzdF0vLwcI9n8jmaPyfhxw1hwFAjbDp7iEV58/cDjM43TKrOJu+AjM5H3y7iyBbWqWBPtle2ZgpSCXWXflVrm2bVYkSDPIX24plmMDAbwE61B3PFrnqeSUMSlyEEPX2QJdOkbNA1HEywQSPYyzMurhslR4zLmKbHmLq55YqRPxVKU518VHyUHYW9t7gRdeTIYrPTrURIzsegxyM20IA72lvUk5M4SUHaU7EZDo5V8OOmMBoEycEIPnvYBbkApXnGZBf0gEP5hT7FrVi3GClUSF/C1BqN7CuWGzqmYJxTbcRvj5J/rPHr3UFhoB5t26XKWTqbTLso0akrYXb5SLuR6rHesdYewp+w4/7dw0Dqcy23Evz73V9wwsXs7+eTgT6c4G/F0uPdi5M/8dYiMjmgsjPDWzDM/g9ZbHhpxUXFxKkX/2DsnGR/PIkRC6jX5YPJ55BFgndxgxdBX/VPOmMmlteXAkqoOWrYGSQ==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(82310400026)(1800799024)(376014)(6133799003)(56012099006)(11063799006)(5023799004)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Giamd7eVO+BYRSiJ7R2mFIhtqtZPMrR/WbYq0Y32ZYnSX9uJyShIxxoKZae7sXZ+Y1C0VrACTvUs8dvDIP599Hc6IuMjv1IQ74uGm5oYjqnJ6qTN14ikXk8iGSVG5sQlSA/Sg7NSj7cPTeFTJnR64jgGejCJHSEdzvRaPQ1BlAc3w8f742FSG9SnJ8yy5HwqTxsElsyJuGhvuAIoSrxxWSwcE+fFcFp5q6zGDPBjw0hStOS2/sCcwJw8UAS/atgKDeBdiYdvextXdRIZjqQr2PM1IXyHfU8BfgwEqdmSUZUbRHurQ+QWFn7K5CadcelmAnZH/2IyMOZpaQxoXYXh/js2ECXChnbLG1PJ1lsWPmxMZPd1S/SfPlJPfXeSQ36fMLpomVW5VVg5dq47DC1Axy2pDflVB8EWMHqkoxc3XV3opOwqOfa7NfX1SF/Adp/d
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 18:47:33.5817
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a9760aa-7067-4e00-9424-08dedb8f0a93
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6017

intel_nested_cache_invalidate_user() used to walk the whole request array
on its own, copying and then flushing one single entry at a time.

The iommufd core now iterates the request array itself and re-invokes the
op with the not-yet-handled sub-array, so handle just a single request per
call out of the front of that sub-array and report one handled entry via
the array->entry_num. An empty array keeps returning a success, used as a
probe of IOMMU_HWPT_INVALIDATE_DATA_VTD_S1 support.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/intel/nested.c | 54 ++++++++++++++++++++----------------
 1 file changed, 30 insertions(+), 24 deletions(-)

diff --git a/drivers/iommu/intel/nested.c b/drivers/iommu/intel/nested.c
index 2b979bec56cef..36e0e8e85c065 100644
--- a/drivers/iommu/intel/nested.c
+++ b/drivers/iommu/intel/nested.c
@@ -93,7 +93,7 @@ static int intel_nested_cache_invalidate_user(struct iommu_domain *domain,
 {
 	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
 	struct iommu_hwpt_vtd_s1_invalidate inv_entry;
-	u32 index, processed = 0;
+	u32 processed = 0;
 	int ret = 0;
 
 	if (array->type != IOMMU_HWPT_INVALIDATE_DATA_VTD_S1) {
@@ -101,31 +101,37 @@ static int intel_nested_cache_invalidate_user(struct iommu_domain *domain,
 		goto out;
 	}
 
-	for (index = 0; index < array->entry_num; index++) {
-		ret = iommu_copy_struct_from_user_array(&inv_entry, array,
-							IOMMU_HWPT_INVALIDATE_DATA_VTD_S1,
-							index, __reserved);
-		if (ret)
-			break;
-
-		if ((inv_entry.flags & ~IOMMU_VTD_INV_FLAGS_LEAF) ||
-		    inv_entry.__reserved) {
-			ret = -EOPNOTSUPP;
-			break;
-		}
-
-		if (!IS_ALIGNED(inv_entry.addr, VTD_PAGE_SIZE) ||
-		    ((inv_entry.npages == U64_MAX) && inv_entry.addr)) {
-			ret = -EINVAL;
-			break;
-		}
-
-		cache_tag_flush_range(dmar_domain, inv_entry.addr,
-				      inv_entry.addr + nrpages_to_size(inv_entry.npages) - 1,
-				      inv_entry.flags & IOMMU_VTD_INV_FLAGS_LEAF);
-		processed++;
+	/*
+	 * The core re-invokes this op for the remaining requests, so handle one
+	 * request per call. A zero-length array only probes the type, validated
+	 * above.
+	 */
+	if (!array->entry_num)
+		return 0;
+
+	ret = iommu_copy_struct_from_user_array(
+		&inv_entry, array, IOMMU_HWPT_INVALIDATE_DATA_VTD_S1, 0,
+		__reserved);
+	if (ret)
+		goto out;
+
+	if ((inv_entry.flags & ~IOMMU_VTD_INV_FLAGS_LEAF) ||
+	    inv_entry.__reserved) {
+		ret = -EOPNOTSUPP;
+		goto out;
+	}
+
+	if (!IS_ALIGNED(inv_entry.addr, VTD_PAGE_SIZE) ||
+	    (inv_entry.npages == U64_MAX && inv_entry.addr)) {
+		ret = -EINVAL;
+		goto out;
 	}
 
+	cache_tag_flush_range(dmar_domain, inv_entry.addr,
+			      inv_entry.addr +
+				      nrpages_to_size(inv_entry.npages) - 1,
+			      inv_entry.flags & IOMMU_VTD_INV_FLAGS_LEAF);
+	processed = 1;
 out:
 	array->entry_num = processed;
 	return ret;
-- 
2.43.0

