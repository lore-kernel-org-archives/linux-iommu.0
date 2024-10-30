Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2080.outbound.protection.outlook.com [40.107.212.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D092863CB
	for <iommu@lists.linux.dev>; Wed, 30 Oct 2024 06:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730270568; cv=fail; b=qKfyHZ25UEPvNiI1/NUMf7tleDZaWDj9Wmu9m1ks+MFM7WlIfNwCAiD8S3T8tgHO4YlTjiBnu9gu63BdCEM0s7vyrNRTOBHtRnx1kb80wla6WudhrAHJfOFJG6GXBXbECvlfrnQEF96NO+9Y+wO5ZE5YjS2Uo64ErlSTMCFxBD8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730270568; c=relaxed/simple;
	bh=WgZGIxb9UlWjpAF6dtsVKcBTqlcFnZOnI7BReXW1Bos=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aN7wzz5PLsbuTGdkws1I8HX6GRmEe/wgW0VdaEYz8YW3yPXKo+e7uo39biBaECw3o4rPftwnOK4AeVWrK7Dauhn6NltNGwl25zmFJOdHGwmzCEzJ99pYUFPw9lixlf8iD7FNm4pDFqHatJpUs4OR7FK4/Ycfv1u9pDWu/ZoGGxo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=P+atUpWs; arc=fail smtp.client-ip=40.107.212.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="P+atUpWs"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GRQ9ynMX75Dz6Is7UUesUvQJGQ9drdbbNfyU3YzPMJrAvPRQn0wfVXYDJvYw2TrBx7V0yEAgrHgry2dE/jaSZ7BXyGSb70wvtUVDA/N6uq33SO1Mx/foQVXLZyZ0+/p9VKdzVt/FQZ/KjEPd3sSgYuTfZ4aFjwuadirrxvwNQmfgxYHb2SkbgrXl0lucgsUnmb89iJYsGj4H+ISea20wPZDSK4NbetmjRUtcz5W4T2gctxG75z40fdV6OdeDYLELQNGg76tkJeTgA6jxLWVA6LaRSpDc5y3FmthHxmPwl4dDeC8UlzY//UeXT0H1KL7UXF1khLx5ai1uPaCqHsW+cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CobeZSMksNDCh6EWtrvu/oKYFFmdMYHRSmgiLxkjag0=;
 b=c6nFB7KT4nyc1Z73xXjN4m4ZlAD+YK29+cFyFlJLJ+cuuFThoNm9bXP65s5kUlBY7bN0UpMMgSKJMRzxQzf7NCh9XIITld3MreoXRnaMGvFJw447wfZMgISrP7y5n0qHoOuFTdHycYVdIwdf1UtDPN5B61BRv1iIJP5xyynvPkOMs8xUsfySSYDfG9YaJIn7w1vgfb0wptXLvUJtNUlX2rQwTpMhotGNXVdfGhoDstz24nlIRZZfafq8lUO0WtdVcvjgimdWN48MsKCtuafP/LfLhK6OL7TC0dr/ZgUjLCz7ier6WtM99By+BIgBesJJcbZtE3Rg7mK3Sy+tmxES/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CobeZSMksNDCh6EWtrvu/oKYFFmdMYHRSmgiLxkjag0=;
 b=P+atUpWsmTq1gdwB+iRBjRsVKAYOsj0o/raI1Nuvn7Luo3aC0SX22PCrsk8z4NZlgkDI0QI6l7dkTEvhyYBpqg/YEl8LsiEG+FS4NqOgYAnPAwmXErfxo//YCBrY1+JgEy41Iuv1CWrSQ1peDtbaTVtOKJszBoxnDWTyQ4kJeNI=
Received: from MN2PR07CA0020.namprd07.prod.outlook.com (2603:10b6:208:1a0::30)
 by PH7PR12MB7236.namprd12.prod.outlook.com (2603:10b6:510:207::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Wed, 30 Oct
 2024 06:42:39 +0000
Received: from BL6PEPF00020E66.namprd04.prod.outlook.com
 (2603:10b6:208:1a0:cafe::d2) by MN2PR07CA0020.outlook.office365.com
 (2603:10b6:208:1a0::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.17 via Frontend
 Transport; Wed, 30 Oct 2024 06:42:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E66.mail.protection.outlook.com (10.167.249.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Wed, 30 Oct 2024 06:42:38 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 30 Oct
 2024 01:42:31 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, <jgg@ziepe.ca>, Vasant Hegde
	<vasant.hegde@amd.com>, Joerg Roedel <jroedel@suse.de>, Jason Gunthorpe
	<jgg@nvidia.com>
Subject: [PATCH v5 03/12] iommu/amd: Remove protection_domain.dev_cnt variable
Date: Wed, 30 Oct 2024 06:35:47 +0000
Message-ID: <20241030063556.6104-4-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241030063556.6104-1-vasant.hegde@amd.com>
References: <20241030063556.6104-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E66:EE_|PH7PR12MB7236:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d2380b0-794a-49f1-c6bd-08dcf8ae0be4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wnZN4ZEEb/st1z0uiEsSTeULkxhryn45SJezq2TXrD3MWHPBU6sdNEwThoOM?=
 =?us-ascii?Q?wVhx9wXh8HNh20FoTIGVPljmPu76Fq9qYQ44IqzjT402QizAuf78USC2a90X?=
 =?us-ascii?Q?mlWq6Id+HD0KMOauwHU9CZrx1JzN6gS9ctTToMVIu9P2OyzOfW3HiUQRagF0?=
 =?us-ascii?Q?Uo1q7LoPawieZjOHwJsRlTtk/4wszspUU7McMB0h58uOIQxLeII0bfaQRM/X?=
 =?us-ascii?Q?7Mq1iR+XE0ru29wM3OzM4+4HYsdUSk79B7y+nY0S01xSL3lIwNt22OXoYcpM?=
 =?us-ascii?Q?HOCBeQseMiakwuufI9nczYRiV0cmPNbJ4bY7h88nczbOFK7O+b0xLtvsAb6q?=
 =?us-ascii?Q?kxD2cSP26fa3J6WXT48bDaSXEVkcxUtqVKMtIMk+JPvSyHYGx70YEsNpkumm?=
 =?us-ascii?Q?GOYL2vj+M64zvdNoNDNx5TO1i5QLYVOiXR/w5Gbq7hl4BeOW4Up4gd3A9Z53?=
 =?us-ascii?Q?3NR3LQz2y1mX+87VNCS0Dz/4xlqokJY8B3p/imAK1eGE/adTojdQoaH1e6VV?=
 =?us-ascii?Q?spdQNd4YdMAh2VZM5vSybJOA+tB82g2XCODf4o5O3/RQvAxI5LLmkjIEhGzf?=
 =?us-ascii?Q?aClPb+GC6i7tQQCepS9dqeXTItaXDmLK+zqSBi6eOsISsTHCMchp8w3IJ1l/?=
 =?us-ascii?Q?hEZnsUjhHizsZ7LCwpUxvb0BEjnf+FDxpJMbLzPSFeQoKsVk0YbeaoLvpdiY?=
 =?us-ascii?Q?xtszSclKwOrQDGmy5cGjnmCr48K1eq6AgWbxkOmapTbqIOcYrQtmT7aUXN+j?=
 =?us-ascii?Q?/JYtG2Ior/uesi0b2CXlX7azu4mbaQ+ChTIOrZ0C1jdrdwh7pfkr/Nh2MwTh?=
 =?us-ascii?Q?N3snWNJgoi0rnksKmuS11WDI+lMmC9QsGzr1UHihMKfdA6A8//8LmP5Mwgav?=
 =?us-ascii?Q?NnuAYnfhx6s2UvWw7EysjMbEdyrmGGUIGXP+12NL9Elu9M/DPHv1k5NYMpBA?=
 =?us-ascii?Q?1+JBxGzduHYN71Ny4/mWE82NYbqnd2kj7hmFQMVs3wZsvXm2oHueZk6cLWQY?=
 =?us-ascii?Q?8peZAe7ALjho2LZrgKunMj8JKwPna0DF7Lim2uc4zqO95J7YHKQy2IywnaBX?=
 =?us-ascii?Q?tmaPI5oigk3spl9GGf3SCM9muCwAzLv6Gv+BhcJNMaJDCyBny9upCTP2tqYM?=
 =?us-ascii?Q?CyLATRXYKw4XzQO51l/ZVLGN2JtdEvB5ygsE0d2cfV3mZnb7zxsAKiKg97IR?=
 =?us-ascii?Q?hzJjg9OuVY5CJYrXx0btS0eeobCeQFVSD3neMdrkPul+t5VwODOQbsAobG3k?=
 =?us-ascii?Q?Tha/QpTaWTcklCPbM61BRYtYtWme9u7zYA8Kw9aVSTJJY7/oOc97i9ciZm+h?=
 =?us-ascii?Q?/X7ku5geIRRhoIEmctSkP7GGRltPE3dmrYsUj1DZn0DckyJKZBUvl3gGMknO?=
 =?us-ascii?Q?yKyVpzeCJ+YomdvmeIpRba7BnSGnRC3eYY5lIzrVBYeeawRKMA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 06:42:38.6214
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d2380b0-794a-49f1-c6bd-08dcf8ae0be4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E66.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7236

protection_domain->dev_list tracks list of attached devices to
domain. We can use list_* functions on dev_list to get device count.
Hence remove 'dev_cnt' variable.

No functional change intended.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Reviewed-by: Joerg Roedel <jroedel@suse.de>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/amd/amd_iommu_types.h | 1 -
 drivers/iommu/amd/iommu.c           | 7 +------
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index e70f6299f765..90a752f57463 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -578,7 +578,6 @@ struct protection_domain {
 	u16 id;			/* the domain id written to the device table */
 	enum protection_domain_mode pd_mode; /* Track page table type */
 	bool dirty_tracking;	/* dirty tracking is enabled in the domain */
-	unsigned dev_cnt;	/* devices assigned to this domain */
 	unsigned dev_iommu[MAX_IOMMUS]; /* per-IOMMU reference count */
 
 	struct mmu_notifier mn;	/* mmu notifier for the SVA domain */
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 1e4f678a2cac..00dbfbce263f 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2031,7 +2031,6 @@ static int do_attach(struct iommu_dev_data *dev_data,
 
 	/* Do reference counting */
 	domain->dev_iommu[iommu->index] += 1;
-	domain->dev_cnt                 += 1;
 
 	/* Setup GCR3 table */
 	if (pdom_is_sva_capable(domain)) {
@@ -2064,7 +2063,6 @@ static void do_detach(struct iommu_dev_data *dev_data)
 
 	/* decrease reference counters - needs to happen after the flushes */
 	domain->dev_iommu[iommu->index] -= 1;
-	domain->dev_cnt                 -= 1;
 }
 
 /*
@@ -2237,16 +2235,13 @@ static void cleanup_domain(struct protection_domain *domain)
 
 	lockdep_assert_held(&domain->lock);
 
-	if (!domain->dev_cnt)
-		return;
-
 	while (!list_empty(&domain->dev_list)) {
 		entry = list_first_entry(&domain->dev_list,
 					 struct iommu_dev_data, list);
 		BUG_ON(!entry->domain);
 		do_detach(entry);
 	}
-	WARN_ON(domain->dev_cnt != 0);
+	WARN_ON(!list_empty(&domain->dev_list));
 }
 
 void protection_domain_free(struct protection_domain *domain)
-- 
2.31.1

