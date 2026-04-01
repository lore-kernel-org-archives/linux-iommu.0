Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013046.outbound.protection.outlook.com [40.93.196.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712D63FADFE
	for <iommu@lists.linux.dev>; Wed,  1 Apr 2026 14:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775054713; cv=fail; b=jreW4U0tA/ylS4pHx98m+QkQ+8UcJEMhJD12p+6u/usuSfuVxyGI5X4iajE2/qB1jYldaRgcVdWcD6Ki9pexL/MNGSFBnaDXaiBbqzYPkCeQbBgN/YzEf2JeYp0lXHzoufBWVrJOZxZRc6gUrMHUf6yo/geEc19uysaJmeuK7FM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775054713; c=relaxed/simple;
	bh=DCZKDMuZY4tOJ6i9+VXlLtdnUe/gKwAeovATWsAcuPA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jSL9HDVRkFNkI0sToPc6YUYQ9IJTFc/L+70i+xsLjyU1TwIYe4D9q4gF5UV+KFKmWf5pj7n3qxrAoHC66N3s6qGC6DNw3yfRwlgmDhVAFxiBR8f5TP3hxjeecnSCfgoDW1MOq9+WHCWn+L8rtp8sB6Henvw+UUvPqoXZm4czIlA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=d9HWj7Fd; arc=fail smtp.client-ip=40.93.196.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="d9HWj7Fd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ix9ytGMPeTTKzqsTMV3sNc2TgX7it+2sOQihAN7s07Vw3u2z7oBC7JJDxOepEzXxocaRUIoWOOKQaIG11y64gthmSoRVQ8zzWZlNhlKHwJRFfriDDPHe/3isFjCd2WSRFqoqt5tVakvnwz112b3pDZiDWC/0KRrZI2bHvaITRpwMfsnwc4bsZP0OsCQqWpKm/hVVBn7mjpKzTmIr8pXtxE39j72NWoMKOb5u4gZIUMzzBioJvctpbtMDuHXN6kpZ8tthNWFwq+8SCjA2x/Ub90ufZSCQMxSmMs/F57k1/qo6K86rKx4Kj9SFbcDEG8rWtJE81VNxbTMOfc3mUMjgIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gMjgv5D/NxjIEOm2CnE6AxkkfyAd4I2Bc/iOPjfFCPI=;
 b=D2IBhzHlkKLOH9ytUcSud06dSoQL/n2wZAsAP7lPhvrkhd6QmOr+pJUhzYhYE/FRaz6GoaFC8NXRoZXoxWemDhIwU7T052lt11FSElbZ0UHu0eWCy55prpbnaaiSkrDG3Aa6cbvW/JilapMv3FXxrqZ7pqI8msK5mLgvu4I2k6cYHHJjwZrYADCPtEPWGjPY93CCCx+i50jugJFlSf1xMHatrWXx3Eb3aeepTDB7UQb2ufjf8xa84M9dk/yS3bwcSMGdqNpH2P/BhM9VeE1t53fkOSf30lMHIRvDcCt3l4bSjodNTaB2Z89OLZWIczKbGo6SnXU4HMNbnu4VlC9kWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gMjgv5D/NxjIEOm2CnE6AxkkfyAd4I2Bc/iOPjfFCPI=;
 b=d9HWj7Fd17PHHNhyHmYVwPbK3vrb9Z654dYvnvHnzmNMvDIVW178gCc2MX+e2fNhuKUxBTkvn4uo8ewVQdn7PBmtmBmKq7rvZzGB0b77rVWifCtpajRz71r1e0yP9+yvw0Yt8XQyOqYD41V0qrF/oS2NqoIXjA/vG823VBHs7/U=
Received: from MN2PR16CA0037.namprd16.prod.outlook.com (2603:10b6:208:234::6)
 by IA0PR12MB7627.namprd12.prod.outlook.com (2603:10b6:208:437::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Wed, 1 Apr
 2026 14:45:05 +0000
Received: from MN1PEPF0000ECD5.namprd02.prod.outlook.com
 (2603:10b6:208:234:cafe::2a) by MN2PR16CA0037.outlook.office365.com
 (2603:10b6:208:234::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.31 via Frontend Transport; Wed,
 1 Apr 2026 14:45:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000ECD5.mail.protection.outlook.com (10.167.242.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 1 Apr 2026 14:45:05 +0000
Received: from BLRANKISONI.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 1 Apr
 2026 09:45:01 -0500
From: Ankit Soni <Ankit.Soni@amd.com>
To: <iommu@lists.linux.dev>
CC: <vasant.hegde@amd.com>, <suravee.suthikulpanit@amd.com>,
	<joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>,
	<linux-kernel@vger.kernel.org>, <jgg@ziepe.ca>
Subject: [PATCH v4 2/3] iommu_pt: add kunit config for 32-bit VA (amdv1_cfg_1)
Date: Wed, 1 Apr 2026 14:43:56 +0000
Message-ID: <993efc6aec604ca6c7e706e5faf7ee216e70ce2c.1775045213.git.Ankit.Soni@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1775045213.git.Ankit.Soni@amd.com>
References: <cover.1775045213.git.Ankit.Soni@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD5:EE_|IA0PR12MB7627:EE_
X-MS-Office365-Filtering-Correlation-Id: 595a4dec-149d-4e19-6469-08de8ffd43a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|376014|82310400026|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	qsjgQ8NXGUir7KTwWKgT0OH99tpT+H8JGoUFd01TNJxgGxVq8PJ6Ca5Bi8KAQOv2ymZcs11PfJRQoucsKn02cjQ6AaxtoQMLKV/BZgo1z+h+E2+NEJzJRyTpFC2W2MFgWhQyKAqVJk/YoMY1oHvgbfYWv6fQCM+dgPQPgs+a7Cd5Q9fjEOtV85hg13GK0G3GP07eNA0IX8YykzBqXeSW1mVlG+LVkva/czqt2F83wLm5Adjx79SNEdM7hlNgq83hYHPApOSxP8+2mhhjkr5l4HgWR0EPyKsQtgZxhxus4JrY8VC98vPfOocW77H8O5z5erfuUfewLlWl4aps4yd6J7iZxNQ2ZcVruh4TdszcpY/Eo5S8Iv3MA2QFnJqdfoqzPus/GePlL1JskX/7pmgIlgct30bApRJaeo0ZF5Fj26+yaTMxLOUhr8H8mEsn8eFk4s8n0lzqj9PBUh7XIibEfh5Xnxokp1qNkgTBSRUS0yh4CLjsYpU7GNdDZyBggu1wqvELe+glmupnINcepjobOtS4lsICw48ejk/w6XHqkwJZOQu0sqmlTDIhgepc7Tn/87jwJJfH5zXqxotUhkTRIKSFIXRnvujHMSZttmmYQ0IAVhC3CQRsi8LZbv6csjQoY3ur4o/Za2DKzshxnbvu3LwezMBFMgT6U9prKZ+EppZuDPuXcEsnU1fbObdb+1q2VTRk9fcvOVyaWrWq29a2y1H4rLp9zJTTTWTBnQby7GOlbm/u6r93iSONtBptu1eixeeLhF3MCeYbYITaDzhNkQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	jROovE6pFbbaSF6QxNAr21yL9ynbi4EUWFHcN0x7LPYybSMNgXftT1HfCoCXFlJoHGdclXsD8vLGr2W2XOIGSXNqnZ37qJy6qUySMrDyQrTtjRHRjAuBJP3L5y/m/4uV+Xlszs2u/tLMcJ2jgxjUgSRWgwzANQMdchRaMgvMYQsQTev+E4C/uUuVqs869dNRMhSaHkXvOduHvnPOpnNuhbjG1LNI/wvIh2bja7xlMK3KDrKcrrf0lFRYnc7tG0xFZNhsx6NL1dBM0wLEe1pd/4lb0MRSill2JuIRCQ78bOueUqYADwF0fnqAsVwuKGAJml04trsrim6XKLyni0GmLPG7/kpzmIdcO+Wh0bBpMXcpFVMfKKVTArfchj6L6fTCtJFe80F8iCX0Ia5mSXXFDIuyfGH0KPHe5YUtmvB3bCCpQkH9qxvDIAkOBZA19sUb
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 14:45:05.6887
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 595a4dec-149d-4e19-6469-08de8ffd43a1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7627

Add test coverage for small VAs (32‑bit) starting at level 2 by enabling
the AMDv1 KUnit configuration. This limits level expansion because the
starting level can accommodate only the maximum virtual address requested.

Signed-off-by: Ankit Soni <Ankit.Soni@amd.com>
---
 drivers/iommu/generic_pt/fmt/amdv1.h      | 1 +
 drivers/iommu/generic_pt/kunit_iommu_pt.h | 5 +++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/generic_pt/fmt/amdv1.h b/drivers/iommu/generic_pt/fmt/amdv1.h
index bc04d482c12f..289c1c010e18 100644
--- a/drivers/iommu/generic_pt/fmt/amdv1.h
+++ b/drivers/iommu/generic_pt/fmt/amdv1.h
@@ -406,6 +406,7 @@ amdv1pt_iommu_fmt_hw_info(struct pt_iommu_amdv1 *table,
 static const struct pt_iommu_amdv1_cfg amdv1_kunit_fmt_cfgs[] = {
 	/* Matches what io_pgtable does */
 	[0] = { .starting_level = 2 },
+	[1] = { .starting_level = 2, .common.hw_max_vasz_lg2 = 32 },
 };
 #define kunit_fmt_cfgs amdv1_kunit_fmt_cfgs
 enum { KUNIT_FMT_FEATURES = 0 };
diff --git a/drivers/iommu/generic_pt/kunit_iommu_pt.h b/drivers/iommu/generic_pt/kunit_iommu_pt.h
index e8a63c8ea850..ece1c9b8c55d 100644
--- a/drivers/iommu/generic_pt/kunit_iommu_pt.h
+++ b/drivers/iommu/generic_pt/kunit_iommu_pt.h
@@ -112,8 +112,9 @@ static void test_increase_level(struct kunit *test)
 	if (IS_32BIT)
 		kunit_skip(test, "Unable to test on 32bit");
 
-	KUNIT_ASSERT_GT(test, common->max_vasz_lg2,
-			pt_top_range(common).max_vasz_lg2);
+	if (common->max_vasz_lg2 <= pt_top_range(common).max_vasz_lg2)
+		kunit_skip(test,
+			   "max_vasz_lg2 fits in starting level, no growth possible");
 
 	/* Add every possible level to the max */
 	while (common->max_vasz_lg2 != pt_top_range(common).max_vasz_lg2) {
-- 
2.43.0

