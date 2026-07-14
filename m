Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011050.outbound.protection.outlook.com [40.107.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F7B377A8E
	for <iommu@lists.linux.dev>; Tue, 14 Jul 2026 18:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784054990; cv=fail; b=O006kXSjXQsDeSuVR7AZceOOwnkIs6ut+O9F+/dbKvM9a9aJ0pHB/Kn5f5y4ts52p3zLsyIAKfAesbQV/6ZlK48v2fgFFs+FbEeKFz0euWJcH2hT5+29nNQcQIYpazsbtOLC5DjTTCFWW2SK0Uv5PQtTDptztY5pdBveaApQ0RA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784054990; c=relaxed/simple;
	bh=3z5FiJYOBlG3bp3h1+HfREzWU2GuY8wqYCOePyFLfpc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=POW5XzbDXURr1jPuP9LzCkevTAaBQC/xrqfC+A+LQFCjQHRWvr5n+tOjWmGNt7D446ewa40E/r0BN8rRrb8sL/ubnfaKZObwOQxEJFl1TGu0CTGrwssDoP2tw6noFEE8UxMXSAyt4+jyjsE3sYCnQQulmF4Ny8EVDVIlY27HFgY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QFIBvWqF; arc=fail smtp.client-ip=40.107.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QFIBvWqF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FGrJVm1SN1j6K1E87p411J1aqtLNvPdbYGfJpnzzCDPxIkQK9WT02jdsYXMt72Fhz+imo/pfjC0BgwneW61+eij9yIeKRI4TOWz4/cT3OWMCuG9TsAKO36tTksrel2ZnxM6Npwv0hLkhdo3SSYSSTZqZd0nP0+UGkIjh7woh+so76KBWeEHjHom/ZBgfAteWG4T1Mla73Fnm2F8Xnb2/qN2yrZTfPkt4zPogGax39iq54HHenwM8wGkDwVilaP6dgpa//YyopTbrdXEQ6Hd+weydnsWrpW+ut/OMw+i8OtG8CS8akMzfUw0f+Z9zZGLfd2IIrzF7WTFXsEayIHtb8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2kHouXK6Nt6M9Rsk/xWF8aeIpWHaFYDAPur/bFB/sdI=;
 b=jHpfe2ek3FLC6bToTnb9VoZ7WHAbEECF4v4zcdag0sSK5Rap9P81OYbah/xOcCvce3bOmrNASzHX0WYydf/fVk9kCDfabGajPczdXMbHAWvzMtXepuK9oMxS5aGU6MFaZoWmdgFLcg1m3GRDTN1r74decA2nD5RAfRx/rnwSvVC1SPOvWgaq3mJqNo+EYdP7RfFe2NKEWq+pvW0Ct8dTuGT3XFWsRwY/bbvIMmUGEVup40auujbx60p9yeTxtIBedQ3hqt+Az7JO6EAt/HCC9f6bihktTUFv9/BIHvqGvbh8s850Rpe1kcHs2sE9ZtUTds3sisMQE7uBYiq9sMu/mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2kHouXK6Nt6M9Rsk/xWF8aeIpWHaFYDAPur/bFB/sdI=;
 b=QFIBvWqFg9f/X7XFRb/hVkM8fSyISRMdg/FNK5EAbHopgoqSy3/NTqlBX64iqJCAwjcR3I5XRqt2lXiI85hcPdpdhWkoQUiDBA+CsYa99fnO+/ctQsuRGzj6VxvtIRhQ5DKnbdwXY4NKjR7ChlePt19nOJPvTPY0HdmpBiSN3sRx7Awt7Xw1U9ml/nC6PHkcZGzvrqfbjqs65J8mvYfbfj7Gq3grXXiBJKOIerczwef7SD9hMX4Qqrj9UJsTmk7DCvntVyCAZq8M/vcu88t58IqN+4N0A6KSMUG8WwrChJh7YGRSfRoGJGicznI2l42/YMps7sq2bZfP2slPio80/A==
Received: from SJ0PR13CA0093.namprd13.prod.outlook.com (2603:10b6:a03:2c5::8)
 by SA3PR12MB7998.namprd12.prod.outlook.com (2603:10b6:806:320::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.9; Tue, 14 Jul
 2026 18:49:41 +0000
Received: from CO1PEPF000075F0.namprd03.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::5c) by SJ0PR13CA0093.outlook.office365.com
 (2603:10b6:a03:2c5::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.10 via Frontend Transport; Tue,
 14 Jul 2026 18:49:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000075F0.mail.protection.outlook.com (10.167.249.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Tue, 14 Jul 2026 18:49:40 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 14 Jul
 2026 11:49:22 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 14 Jul
 2026 11:49:22 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 14 Jul 2026 11:49:21 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>, "Kevin
 Tian" <kevin.tian@intel.com>
CC: Robin Murphy <robin.murphy@arm.com>, <joro@8bytes.org>, David Woodhouse
	<dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, Pranjal Shrivastava <praan@google.com>
Subject: [PATCH v4 6/6] iommu/vt-d: Convert nested cache invalidation to the core array loop
Date: Tue, 14 Jul 2026 11:48:52 -0700
Message-ID: <6fc43e814362d65d4c2b7d22c6fcc50ff56378c4.1784054606.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1784054606.git.nicolinc@nvidia.com>
References: <cover.1784054606.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F0:EE_|SA3PR12MB7998:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b55edda-b6cd-4fed-29cc-08dee1d8a9ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|1800799024|7416014|376014|23010399003|6133799003|18002099003|56012099006|11063799006|5023799004|22082099003;
X-Microsoft-Antispam-Message-Info:
	+0bfizfZ++x6OfvOzDmSUcyzWH41LnRfhALkb2obHrf0OcYzSaRZR4OMLru88sNdq43pb72pVJUKrmk9rOmK+698j3z6MuUQK7nk2ODP3KM5lBr5GCRgxIRusd/2AHOtdaZ5ptuLZ5wctzrK7fro9XgnlNaGcTFcHKxew08PPdr5aDiEkKcuaYHL9SN3lxZhaRN/YOL5YxJGfWhWbqzirsZcdLTgxtM8nfy2dN6GtMwt7gCqmxkgVNGerxyF7nsLOsRI7o/wUPkn/Xtl6KGaMOmS0Pbm2OHJNr8XE6T4Upe8JXbeKyyZ2NXL/umeADlTonHakXXTcuBw7lKNv9OCjzelyjdy5qrBEjgkNwF0mPbL70fdJJiTJ5LeSv6vWdM7szEcdEAhrTvmwPeONLWak5422KwsaGCTFMgdCN+aHZxA4StC/Ukllek5W9pWj0dy9hyYJsJDm98O8G05HMEeVe3JSJ2r6oY3DGzwbNZQUUkVuuVM/6pYQCslfTOIl6zHdojp1tLeD5Y3bZtiD3aZu8WmKncEGYvtrYhzLTSt1Y+V6SJ3EDiu3+0rJIzAfqZ4tPHZoU5dV26keN0fNgSWqBgLQcYtejfZ9TgZMhGDok169im7XYK5WR2Xo297kbHi1qyo0SRqEN9cS+DMzHGvW4XmnsI9gPH5vIWvxIyR4YNU1sN83xe7LBo8ED7Bpp2s8N+Uw/BDa4CwxmydNnFSOA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(1800799024)(7416014)(376014)(23010399003)(6133799003)(18002099003)(56012099006)(11063799006)(5023799004)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	sfSSziw5H7xH340qd7hDFfu7vutgHsl6B5xqygCpp/8QlL+jbY5lEI9CU3NV1Eba5ershPrHAabysJyVO/YAk7LVMCl694+7DcVTh2I+SZGfvrlESl+Dme+6YrGDTb/BEkSrEgZW2Ni75JMZAftCHW/612BQGG77ii4LA46Ac2LKnogwpXJ0nogykj6RzzAn47QKu/fqCodvLmwvW/P8yGnEY10/Z7J5pgwNkbB3LT2e+0AG1dM1OLYJL3eXkKtC4yNLxqjaeJjy7/Any1LjpgGGxRByMSE4XeuvabRBoPLhal5S9JRRtU6qBF3WCIENwkOXPQ+vhTcinHOeuEIZ8+zkOUY7rJw/NWt+AdtkbufhC0wyhFdsAe3UTOcZP1ExyhjCihhVtQLe2hDMatXc9BYRPzjxZgaY4L4rbRXyOCceFpqlxiDM5ttT89JO3W41
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 18:49:40.7999
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b55edda-b6cd-4fed-29cc-08dee1d8a9ab
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075F0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7998

intel_nested_cache_invalidate_user() used to walk the whole request array
on its own, copying and then flushing one single entry at a time.

The iommufd core now iterates the request array itself and re-invokes the
op with the not-yet-handled sub-array, so handle just a single request per
call out of the front of that sub-array and report one handled entry via
the array->entry_num. An empty array keeps returning a success, used as a
probe of IOMMU_HWPT_INVALIDATE_DATA_VTD_S1 support.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
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

