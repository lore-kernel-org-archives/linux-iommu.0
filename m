Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011044.outbound.protection.outlook.com [52.101.57.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B312E7374
	for <iommu@lists.linux.dev>; Mon, 15 Jun 2026 19:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781552765; cv=fail; b=WYaJCazNzDRSPgDcAQ6wiTSbh25wVDf5JLWjC7oo8AaYTO22VEkOSTDPJQq0q0cyQ92mDvldLiM0vEyxUyKk7ztT1m0HXNsHqNhoF5b3TdjvxCx6Vc3KDh78sfAA0SsHHSUyMGHe8zPKHZZ/upLojBxUaFcNgisCV2tiO4rlUFQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781552765; c=relaxed/simple;
	bh=dMTPCQyG1qXDOMzn36kH94jG+NDqQBOb2t8F0iKgTs8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CDI7PslreqoXLmpBfR3x11kuRIh+iz1cRYa600P/wI4V6R3ZCjJdCqehTUWfQWns3T++Pe6zscKsDfMcInQ0q5QhbJX1yDaZjSNT60oqsgrXUTlAo6KDFsnd6Db2dHnQOitOjbdQkoQ2cblXhZNlM3terA3ZPPSYitYXFfKQgpY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QL6ySo5B; arc=fail smtp.client-ip=52.101.57.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QL6ySo5B"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ofz3tqIRbm2Eb6ulnsVeKt2H+9mli4VYduMzFzR6Olybj/2N22BX2148C7rMnWd616nZ3tdqBg/X/rL1RXulT87BYOZRezX1IgAa/jmJ84d++UF0dOJWAQTVb8MG1+yEVRnYXo6paYAytDndSEcv+ge3y11OWwQaBRhIeSa7Ca+NH927R9kRYYMg6U7DeUcUZqpO67mSXkSIAVUjxqdjR89isD0d8aMtnC4TqaShFGnAsf8xEs/t358/1GKZrNXsxOYBfLqmi6xoteVsqVPT3rD5lCRoxVo1O8BnKc5pfz67j46smZ6u9GSgiwJfY5SKMnu14d4WlOkMvPt7J3puYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VaydGCLz1+VN5ArHZl+LQ8hyJ6x5Vq8sQDQntDkns0M=;
 b=HrlRx384JRECYNP2xHxkjgTO3DQm2j4OUw1C1Np1Pv15C8iL6/f6NOTsRmrqNa3Gy3sHTBhqdYXfOekD8paZii2Orb01YvcqEuA3HgZS6YBKAozgUtJDkysnUqiQ/LpqHIwzIoRqPJdNWfkAdkQpMqxbi7czr/1n0ZBSF/XXm5rQpca/U7PlMKk7V5MEd1Y/PmpM6FKHzmluVu/VWHhc9UxS0IHtfzkP39VIfxuknEwY12VRc/cFWgVFKzBAiLXa5j3m/GyFkqCC+s1JURcFFdBwjLTjm7e3Z6U514JKawn0470edQyWxGv9x0Fje8SrMhd+W7ArVkPQtNE70qX8Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VaydGCLz1+VN5ArHZl+LQ8hyJ6x5Vq8sQDQntDkns0M=;
 b=QL6ySo5B4zc7++1zGYD2zRamt4/JbFOO6rCIXLNSRqzlm6JqjEq1NrCwLkWKoWhE2lu4x2PIhMGEkqgUHFcKU+1aAbbGEbkXIx8G0IwbvsLTak2i5RZdEtSTk68ugcr+zseH0EFae9pCPmrPR3bg+AsEXcV1gXq7jaUQfxdK0BfVq3iJ9MuGwxeMjuCuMy8/LfQH9JpbaGyh1kqvIXfUvgWZqzB/d8YIUGOjAy5uKtdvTD8PdpFycdzCoBQ6d9CuH5DhK1Y4YEnnYaiYNO/IOdkmIBQ5hyg62YiOA+ejsTMkm29bA0N82/y5NREDe0MhjEJGjv4l7omrzsNQZRxmEw==
Received: from DS7P220CA0004.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:1ca::11) by
 SA3PR12MB8439.namprd12.prod.outlook.com (2603:10b6:806:2f7::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.18; Mon, 15 Jun 2026 19:45:57 +0000
Received: from DS2PEPF00003441.namprd04.prod.outlook.com
 (2603:10b6:8:1ca:cafe::9a) by DS7P220CA0004.outlook.office365.com
 (2603:10b6:8:1ca::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.18 via Frontend Transport; Mon,
 15 Jun 2026 19:45:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DS2PEPF00003441.mail.protection.outlook.com (10.167.17.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Mon, 15 Jun 2026 19:45:57 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 15 Jun
 2026 12:45:37 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 15 Jun 2026 12:45:36 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 15 Jun 2026 12:45:35 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Will Deacon <will@kernel.org>
CC: Robin Murphy <robin.murphy@arm.com>, <joro@8bytes.org>, Jason Gunthorpe
	<jgg@nvidia.com>, Shuai Xue <xueshuai@linux.alibaba.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH] iommu/arm-smmu-v3: Declare eats_s1chk and eats_trans as host-endian u64
Date: Mon, 15 Jun 2026 12:45:33 -0700
Message-ID: <20260615194533.3290010-1-nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003441:EE_|SA3PR12MB8439:EE_
X-MS-Office365-Filtering-Correlation-Id: 5630b9a8-e62b-4e6f-aad5-08decb16b834
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|82310400026|376014|23010399003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	pOkLWglOYY7vjwnJfV4B+l3cplwOUkdpJ/wla5rp9+pUDDcC32pO/MyXpcvG9jaISSGIF6hwgW6q2y0YQu75JHKBYLbg6YCS20WTe7n8Y+81Bj4txFo6rXDIPMR/tggc2OP6FFcE19fX92DyyGooGZN/+5V4W+umPtVjDsEqwCwNJqBbLQYMKj9t971g1pqm4otmzWCnzEnOMjiAOOY+FAEzjbTFky6QSM7Svs7Sbc4Pco7s9QV8VEw5amcegpxZkULIh2IdeIiOLKRXwBHCmj65Nn8Wb5Ct5xRMIikP9Ycdk34OpV0fHtts3iltkCfA/Nqn7a1gwLBUC+FA+5Iqgj0A68JfcK0fPRO9eNqphm2Yw4ZfgafYWbqMxIpq1RD1kgmRWWwFcAAb8cN4NPT1cp1Y6a56vhCUA4jVcDjiM2KhEUpZ69a+QpL9EF4WTDMa/tF0k1vrU/2Ij0507I0UW5DomZgqhDJVZfVNnBl0q5kxuQNPjAJivmJwZdFp93bXrVX3qx6I2dTGEfz4bVh6HcMAtgIrke18IiuEKYhfAesxBNMO3GSxuC9taR/wbuqMmDLf45EE+kbyyQKZGg244OX9l/Bftmf6RJ9TAgg3CyXl0NDtmxfcaP2xXHWxTnnZpeynytOme3a17jgDNn6Ld+9eQ5MKQdkRR3QCjM1fy9YOr5sqywFr4gjVD5Y+kaKnCYINFwAND0YD4KgdAZKCITr44Xjz+Fe0mkqJ7EA65uTl45+bqMtBegnmOTLL5Aqu
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(23010399003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	nhRkg/qQ4hASqt44PXNjE7or8+h09K+woBHRpAC6OWI5bkwrSsSs1HwDsak/yv7wWKVTfRsRawQyeE5v9ZDhoe+krPp9hFJKBeyzUDtcD8oOOujlb9zn+sMQw2SVj2agTJuEiZnoCfwzmz13xxjz+lg7b0+Ect5gEDeQGqkvBoRuud3Ee1uNfnC3dUl/NepBAaZFvu5tO2gFVn435Ibl1jrd9H7hQgdmndpKdiIkPJC1ARAy5rchjAhDcA8M7ypx+60pJ9MPVmiDuuWN9OpWpBm8P6Y2C+H1OywwVplqpX+z4f03GX6L2nqWfhJ7Y1NGMv5FmBYc0piM+Wlou14dcpW2rU4TiImKR1EGtDJtWtJvp3n9OOMM5DZfdZJ7t6wpNFhzzhRairt6roZhuAzcKTuQAYVD7wNbgEE211Hmr7JOGQDwL7jZXCdmRRR/31l0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 19:45:57.1911
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5630b9a8-e62b-4e6f-aad5-08decb16b834
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003441.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8439

arm_smmu_get_ste_update_safe() declares the eats_s1chk and eats_trans
locals as __le64, but initializes them from FIELD_PREP(), which returns a
host-endian value, and passes them through cpu_to_le64() at the use sites.

Sparse reports the following warnings:

>> drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c:1122:38: sparse: sparse: cast from restricted __le64
   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c:1124:33: sparse: sparse: cast from restricted __le64

Declare both locals as u64 so the type matches FIELD_PREP() and the
existing cpu_to_le64() at the use sites performs the host-to-little-endian
conversion. No functional change.

Fixes: 7cad80048595 ("iommu/arm-smmu-v3: Mark EATS_TRANS safe when computing the update sequence")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/all/202606151017.QU0evpH9-lkp@intel.com/
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 8ce3e801eda3b..4c0f7b17b1f37 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1240,9 +1240,9 @@ VISIBLE_IF_KUNIT
 void arm_smmu_get_ste_update_safe(const __le64 *cur, const __le64 *target,
 				  __le64 *safe_bits)
 {
-	const __le64 eats_s1chk =
+	const u64 eats_s1chk =
 		FIELD_PREP(STRTAB_STE_1_EATS, STRTAB_STE_1_EATS_S1CHK);
-	const __le64 eats_trans =
+	const u64 eats_trans =
 		FIELD_PREP(STRTAB_STE_1_EATS, STRTAB_STE_1_EATS_TRANS);
 
 	/*
-- 
2.43.0

