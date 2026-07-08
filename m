Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010035.outbound.protection.outlook.com [52.101.201.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB6A3D0918
	for <iommu@lists.linux.dev>; Wed,  8 Jul 2026 19:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783539905; cv=fail; b=uC0mb2saeLCRNdRApyBrwFS1LSL7wFavEhqadcdJS1RN7aVon/NJrr0rWqvy3MseGBg+bM0nKhXdTwpTSIxfH+V2lEgYSwSgsYtChUmLSolGswlPXy8CC1fmo6pnvgJmc1L1cwsb87xkLf5UTHCCuxzlvzgw8551r9mIJgZddbQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783539905; c=relaxed/simple;
	bh=jrSB6rj+d9qFnT58HAvaqpBAkpyiFgvvwk86MlgS4C4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nrkL3H+RuXjzM9y58JIQA/9Z/mZtoMQB+8bMGHx0CpK18lcjbASM0cJxw0l1zHhzBsJHrj5LLcOn6Z9UmWTe//dNb7kPZM0YVfvYMkVQCrbLFrbUb1t9+kkj3ensTF2Ag1QTiSeExyc77Bu2B06gpzHhffrMuG1xzKuS/9lCTkw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bxIBn/m4; arc=fail smtp.client-ip=52.101.201.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bxIBn/m4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mzQivZX738fUdfcOq2f1z80ORX3jI2AA6xxygxukuQnuE/ITETkJwYUrSYrBuZwWXLQAV5GiDko3OMWoQLm0cNIL2jZx9plgZn30stmyQFf8UOY97/cKVOwAHTmDIr0uFfHzrP4ggBP+vetZortduLo95jc4w+rHHCiW68+YIadbv9pKa+hR81JbImAyF0oBeHlKXgCvzoND0KJnWPKLT8phy2Uz57e7nVqvzI7wsTMYvHayZEIxePPkscRjHlfYAJrVJVqp7i2S+X1wUe8kxb+kOwBjPAv10lzJmYVTpOHeKwRs+Ijfi0UUYEINuUc6RZSULnDoIMILV6SJku6Hiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sGbjO+pNrdd+UW4OsilpKM9X8br0di0p/DjFAoXl5PA=;
 b=hdZI/lQ0FtxDA681vU7BWisUc51MkMAsAv2Qpn/WMWskC+AJMVq9w/ZEmsi+bszqCVnFImFlg8HngTITcQIxe9jP7TJrCJ3Keb/JCqfMcPBjZ9pZjJwcDW94WwpGMIwRnube6bs+hchg65+F+qST2aiJBcPuf7qXljJt64J0c1yYMVEH1Sx8Jtz/JnnaNvQt0NyGHw4DGEr/otnvY0IUe2pTt3laCcfas9nSCS/dEUwHiILoT6NOTBFu1qPKM0ZgMolP/EHTIn8AMEohRfQUfVmr3uUZEXtGM/vWhElAZV9cq3GO0Oqna5l3I0PjblfKR1WR9MMd0RrXc/OKqFv2XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sGbjO+pNrdd+UW4OsilpKM9X8br0di0p/DjFAoXl5PA=;
 b=bxIBn/m4nw2aN4o01jD73yYVEjiLhJ01FOYblWCtlr8m19g19Fkm4bYVrSqzAd89gq7ERYCcNb1IoMry2peTb+BMgD35LomldHVOqCI9adDCqloXg+qKcZupFV6Xh0i1oFcfcIafNuGiFFKU5evJahZwIli7Pf+CYMY0MUxCrEfcAVBOBFzlZAEfquY1bnw3PZOLXsZD77BnxLsAnHg7AVWGS1zqJzHEgBYXNAXRl8w58IbLVT6PT0ZIMhyNxoZDjcpZcOU+ZN1kLx06aiTnF6BVV90Eqfti6lU+w6WVbDIGkFchRvHM1SHaxWV4sovZJwIOcmiRYdcMRJgAhXzNBA==
Received: from SJ0PR03CA0142.namprd03.prod.outlook.com (2603:10b6:a03:33c::27)
 by PH7PR12MB6696.namprd12.prod.outlook.com (2603:10b6:510:1b3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Wed, 8 Jul
 2026 19:44:53 +0000
Received: from SJ5PEPF00000209.namprd05.prod.outlook.com
 (2603:10b6:a03:33c:cafe::2e) by SJ0PR03CA0142.outlook.office365.com
 (2603:10b6:a03:33c::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.9 via Frontend Transport; Wed, 8
 Jul 2026 19:44:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ5PEPF00000209.mail.protection.outlook.com (10.167.244.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Wed, 8 Jul 2026 19:44:53 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 8 Jul
 2026 12:44:42 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 8 Jul 2026 12:44:41 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 8 Jul 2026 12:44:41 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>, "Kevin
 Tian" <kevin.tian@intel.com>, Lu Baolu <baolu.lu@linux.intel.com>
CC: Robin Murphy <robin.murphy@arm.com>, <joro@8bytes.org>, David Woodhouse
	<dwmw2@infradead.org>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 5/5] iommu/vt-d: Convert nested cache invalidation to the core array loop
Date: Wed, 8 Jul 2026 12:44:20 -0700
Message-ID: <15bf2bf57e7bca35fdfd8262d2524026bb7574d3.1783539724.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1783539724.git.nicolinc@nvidia.com>
References: <cover.1783539724.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000209:EE_|PH7PR12MB6696:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a9ec960-569a-4765-5ace-08dedd29616f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|82310400026|23010399003|1800799024|5023799004|6133799003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	ynqoZRiMaSXYp1CM0iOfZLDepEOcpfUlORiE9D6zb2IF/iPZyu3cka0YqTP/doEVlR/uLLhxK2wlT9O7vKFVXB9Te5vRuPCBoGjBQN+Z7MYcvnTKba59QgbF/C+A8XZpUxlgKeYiYKdJ/TlV39ZaTeN0YXDkh8pLXntvb0s/OkXSoaQ6fNEdUadf1kgIlBRUx+LH+ZYVmk+Pap4RoaubWQZb9CnsCSxteAauz6bj+frIp7CdN7smd0Ap4R2O2U3LJEly91gpr/cC3YG4ZDx/NqkVBe0I2bmVMmvRmGaMo7oPPrwhxmgBQfvce4KZDXS8RjOBA4DVSHkz66T5LhOubb5kluJYSyzMG/j0TqmmBHxriC6U2yCeX4WxhwbRyhRwDt/yfLpY4nWlsQj9hWIgaTId1X1PLY1lgozwoQ3b16Xyin1MfC7QAXvmIw5MbKcOtcvSlOEouJuUQPdatr0ceWSulmE246HLWJMWAc+XRATK4ZVltzBKLmhNQqZMA8vaWs6/pSUlbD0OfoJNmBCOGffev1ZLETteBwmwsZp279efuNYNRWMmyVvfJI1RcBowk243JwRTUvxGpDwmhdK2Ru2I0qguta0hVSnSNxZ/IEtBznuxAhl6RUNQEs74EFRqpj2t2xUxNZBqh8mF2d6mQ2/XrxfeTZGth2gzlAw1OErl6c+U+gp+IPa5+nt6+xF74CFFdtJvYrvIew+MRpyn4A==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(376014)(82310400026)(23010399003)(1800799024)(5023799004)(6133799003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	53DUw7Xjkg1f5EgqO2JoAjQa/C8SKJWPMPfbZkgrPZ/V983yEDMfgWAlHzPNqJRLY8Yo/xEwYUvmOIr/QWWILQ0sstfKMKpZmNRm/OSSL2+zfaYRstq+FS8nJlMDy7XJ2pRRZVv1HnpKR8gkDLl6kTiExv1IE304UjpZQ5LNemXus4RMQu+IbKC2uJyF8LohE5QG6i58Nn2g4tqClsmDEOpUpXDwgSlcd9GWIz/+QHHYDAeehJDsQ35QayYAGrAVdjrPtb5i4y0yhyCRKs10AR5LQwsYvUmQSY9kBS4xMNkKG0E1LwmHolxQxSDU2jqt1agpQqvJIsoTUBM46z21/fTkMtLeGu672A+lgbzTJu8tmst/GriPW0Hsg0jhu9Bsti1Xm2YjmcaP4dQaLFG8Kz37KsJqB6eFMZS5ebkUQKxKnBhbCnQcbeQCMVv6fYOO
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 19:44:53.1110
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a9ec960-569a-4765-5ace-08dedd29616f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000209.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6696

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

