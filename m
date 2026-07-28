Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010058.outbound.protection.outlook.com [52.101.193.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C293E3C5DC5
	for <iommu@lists.linux.dev>; Tue, 28 Jul 2026 17:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785260066; cv=fail; b=LBuhbwMSOoquZhNidT9agoY/DDORmhdiouuSvqgHvKM237BcolF2fCQCljkR0EhU9AjkLhUwV/uLzNUW1YcFCeq7YUJdM6UJ6CrEAAM72trT7PCzFZUqjWDaejNqcrGSQZXXEGIfC50VIbWVARdhTkEbZ5ZZsUE4WeP7MzNCuVU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785260066; c=relaxed/simple;
	bh=3z5FiJYOBlG3bp3h1+HfREzWU2GuY8wqYCOePyFLfpc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ys3nBBeQQvJ5Xv50I3PXauxYMNv26FXqQFwybQJgR456TEIftG76zUJwwW5xZGUxMK6lWaB22lkKHHn+e8Ig4aqh32+zJob71ekdH3GGTKPIBzHbbvwSSnTSAmN69M/XB8jcP8hqNop29MWqnc8RuWZn1iuvnNmfbQHTUyAwLhI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=s0r9OS+G; arc=fail smtp.client-ip=52.101.193.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="s0r9OS+G"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HAXIeIxlWVzTtU7CslBJO8BqmM12383wT3hM9lSJ04283wqChcqmgjKcD+PKa86Hu8ebusizG3Q4gjfCOjJxxajk9Ij2NPeKSl9PM0AUlWUUVLcNUtRILbl+cD1hhtaTzv5z8ECiys0ru6C+S4Otd5Is9CnJEesgPWwXMAICydK/Taay65kYwoepoYROppMi7haSVK1ggO6OZVwcODxUXBrkwm04UIA6jeTu7rCM6uO4n3ZNbY4iG+gJR1JgT27NNtTL5kuKMXVTXcCjCpH5RQNN4z6QTHZ3JZAEHIecif9X3alrFpEvZftYfil6kSoC4lRbDdIWc3/wJr3pJmY8Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2kHouXK6Nt6M9Rsk/xWF8aeIpWHaFYDAPur/bFB/sdI=;
 b=BsiOq3dt5XxF2kIiXcBnDlqpTCufQ9OLIZ2cQ5MMFPrZWSPhvMpPuMeQDIGyEe7EArGINqnvE3ydRAGYGtsVqpIexff+Sdusd3pAfGnrVdxaxTokfLNRD8SlOEiHLYvwzoxLuGpLECqNL35qDZneaR9kqPnEEoNhW1IRgNOTnMI/07RZ/APjqr+cU7HqaJ7sPRrNkSTkPWZniOB10R1PD12vp0GdMtxQWUKGZE3yZxrRUAWnIozyK+ACEf+kRmu+uw6d1QIEwXaoNfhrJN/3rAErO+vADXG+9abuOSrH/46kbwdW5NaUWh6rFAirZGSTYWm8wJlNPm8DzZS+GuIUEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2kHouXK6Nt6M9Rsk/xWF8aeIpWHaFYDAPur/bFB/sdI=;
 b=s0r9OS+GAIMql33Ifxqjiju1xgxgbmlo+/sQebr8tuSzcNprhi1BPJc4Tc+JpORNN//vy2Cw0Z9yWfJXMY/lrlYPNvcIOSkxf4AdLGthpqKZAP2arq5nbf8xZtiQ1Ki9xrtd7WDW65Bydgdq0VhZdNY91DSEo8bhzU2d26yYSpt7Semz59RuByRo5AHSu+dduLLk/ueaw31wrsayAd4AI57hnPCSbBq1lt+RjWwXp9Anh7iXJjmKPsdaLWtaKKTmR7xD9NLmgzqsccnU6Punf45b+ro6KFk3HzPSlO6AUnr97Fgy304jifVqbUQl1fmeAehAKi6BQ8qF3KlVzU3beg==
Received: from DS7PR05CA0085.namprd05.prod.outlook.com (2603:10b6:8:56::15) by
 MN6PR12MB8491.namprd12.prod.outlook.com (2603:10b6:208:46f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Tue, 28 Jul
 2026 17:34:19 +0000
Received: from SN1PEPF0002BA4C.namprd03.prod.outlook.com
 (2603:10b6:8:56:cafe::a2) by DS7PR05CA0085.outlook.office365.com
 (2603:10b6:8:56::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.12 via Frontend Transport; Tue,
 28 Jul 2026 17:34:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF0002BA4C.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Tue, 28 Jul 2026 17:34:19 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 28 Jul
 2026 10:33:52 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 28 Jul
 2026 10:33:52 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 28 Jul 2026 10:33:51 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>
CC: Robin Murphy <robin.murphy@arm.com>, <joro@8bytes.org>, Kevin Tian
	<kevin.tian@intel.com>, David Woodhouse <dwmw2@infradead.org>, Lu Baolu
	<baolu.lu@linux.intel.com>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>, Pranjal Shrivastava
	<praan@google.com>
Subject: [PATCH v5 6/6] iommu/vt-d: Convert nested cache invalidation to the core array loop
Date: Tue, 28 Jul 2026 10:33:38 -0700
Message-ID: <ec5209c44095dd681bc8ed9bf54e3487872fd0d3.1785258826.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1785258826.git.nicolinc@nvidia.com>
References: <cover.1785258826.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4C:EE_|MN6PR12MB8491:EE_
X-MS-Office365-Filtering-Correlation-Id: b53b85a0-3a4b-4678-d821-08deecce7456
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|7416014|36860700016|82310400026|10067099003|11063799006|5023799004|6133799003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	ps5imjOKFMU7VFFvuHytlRpGs4BWBWEiLv4KEUY7GjrZNVq+BUqXkgQlS0VLgkVIl5Nd0QySMNp4dn/TnPaqzY+u6ThPa0r55yO24TkmKJBrp6hekbV8rsd17j5kEpF7Q/mI6o1LtlQSDkoDfVa2jHL/V9E7Djo8c5jct/2QYB2oBU2qla0hwPK5UVBF5WHZRJA7mdY82ZXGb0mHnVu6ZpJxhfxShvyB4b8oJjsUgrdVys+SwhHTo/lKjgzvjAaS5Iz/CKieOz6GWSTetKmzTtuDFTO105nYimzRsPsD+ChM5hgkvr4nxvpOuByfuQYd0iO3mbqGAVj25YAHSEZgiS500KVfpP5S++EkVnIbFRKfnbH07lTx+Rm8jw6lqJyaKWVAEMLPJ+txjHV6yHWNPmC2iBVpmb2cEuhUxS83dWVd9v8N+KhmgDZmVTWLdYCWmv/Uu4FGoIlajoDSuSet7Pb85QR1U+T0Sij95nVNRtj+1X2xIFVVSCrFwfPsVhESmZUTvKU2y0YzlFIqKiFHZO6jWulxg8u0Lzp7kjQiUiGv+VsebhZ2rk1KGTLlvkOG0/+/dLYscxjkI3gKyNkYGhUgOGYxJWxuhVOiTEhE7Ntsf/5fO7tv2Q/jNl7+fxIt54AiFdPA7uDQU1eTwwzKT+zs+GpSORDDqIQPRQZS+JCsGa/skIt8nCVWsByaZPPRTqWKa6QXpfNPKzS/5ymI4w==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(7416014)(36860700016)(82310400026)(10067099003)(11063799006)(5023799004)(6133799003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	1057kvqYDdqqQpdRAEjX4AMjkJvK9GXb6nv6qzuRBypQ5oyO59hScexM9/BJqCu//QHb7qiX1R8M2tF0uBVwwD99IgzHS4CsoT1UZfF7k80UhNJSuO7iGiAgQQ7hM6hv63ymG5dcc50Lf5ZtGBDq1Egi2bjBl1BYUnKWUpofX8rdWhruBAlS8Mv1vO9YR7RKebWaLNADKr+QyhWOPpGTqkjAZ/zU0YZ+4enFedSC+TFPO/pPZfJYaPxZbqucZMr94mzt2M285PvJbPAViFYcnzdVoHz/noQ6coFBY+WosTyZN7nK8YJmKwweHYq89xbZzRA1PXqmxe6xOf4X6MwKAEaX6Q6RvtOmXgBPZ3vL/qNFc95W8M84n3DhsVUBb9OdrJhpNHnY+HdygQBjov4MJXtAMnDyWrDP3N4BA3X953MBltZgvlgVXqIB/aFIGWR2
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 17:34:19.0838
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b53b85a0-3a4b-4678-d821-08deecce7456
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8491

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

