Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012045.outbound.protection.outlook.com [52.101.43.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0BD3BF688
	for <iommu@lists.linux.dev>; Mon, 13 Apr 2026 14:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776091604; cv=fail; b=ZRoIej42Rq9xNLifbpCjBktBWKUyH5dVrSzQNMbiOFDzHgnlWu5PuOHBsKYg+k6t1oZAKuh8K3Vf7g8GZQfbGO62tuM1u+d++GZ/QcTI1IebAE2f6szrPRMsSrmuBhFKA7o2K17YWH9gZSg9Yc02hbMgmluZBD+ZLroWWXHBNWM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776091604; c=relaxed/simple;
	bh=jVTLsEObGIUMP/m5zUwrdMkv3uYTAHnltW7REaasuys=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nkBjk7S6Rjizj2L4kRW3k/I46eyKa1ioRo1SNOU6szjWaLqVQY6PjmOpaBKXjqS6XX/7LSP+pXg1IVbdrc4InTyq3YghPkpnVkGJ0AJov8M2R4L2hjcCEkiwYEPOH4/nx7Fg7xQHg1BO0lNZxkhMBs6LupzAbZdHXlS8WpVo5nw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DXaZ077X; arc=fail smtp.client-ip=52.101.43.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DXaZ077X"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RoprMrRaUzO2J2Pmyq8ksQBAR0OshJrPezJ+smh5gVDxB1xnF+/GUPl57IklbFQCnFCUniMkUBWwqUHamX62R1tfCg90utKQISL7tG8YmZeh5vDkZqR4o7PlnxhuHBTKlpvDD8ZLmp/txLnu0GE9TBeX/aoO38K51a+DxZ9ksMO5mDXCgTFc9JioHY5NcaOV1jDhKo5zzv1HDn2OEKw/DspYGd90fnWwjLC1J7JW6ZI/3so6F9xdXhS3bxVRVxC2STlZ2f1L3O8GSCAqb+uMr8lvk2OfZ/sRdZA6omw3mhu4p/2pxtEKjNnI4loUwXzA4vx2wBwZmIzYhC9N2+eOLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dExW8Kc5DD8ZAKFmUPtQsFfQrkJ7XwD96TWSzFbMqUE=;
 b=CspUJzFNoof9CEoeQN0sUViF01dulFi3+x5LTFHGeou6cpysdlzkELBLhImfOigtm8LdJvL2kYn2HnxRC7JOARiMAVyVNjsRplt5+q+GdS/LQdlwDfLXMcI420lD2DygfUyQ5akILn9P4F5OxFqAtMEHgXKOoD/byc8PKY7nMF3zClkPohauIc00G4xSg4VQOYiM97zb2Z4HxC78rP/UavPB9YlshGMg5v4TrZAZaT6SloAK9lG0ifDN8arCsDLBL+VrRwupgh6q/lBokgAukIeTeGLaDCUbSI2nB5TFUb/1YRUqu0CBII3ZQI3d1t8x+djL4+Laiecm8lPMdkM3SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dExW8Kc5DD8ZAKFmUPtQsFfQrkJ7XwD96TWSzFbMqUE=;
 b=DXaZ077X2rMnFUr0lG4wr7vRdud2J5BLN1Ew1kFq4TSIo6XQQybbTyNPOYPznzycuqlih0XFoRNgYs91vr9+MABfgguyH4UEvfwPvjfutap95C9s2QbQgA1L58plXtyxD0oU8aNgD+uX5OndfSmPmr6xETir3dy4bJYET/odjaE=
Received: from CH3P221CA0011.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1e7::7)
 by DM4PR12MB6254.namprd12.prod.outlook.com (2603:10b6:8:a5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9791.34; Mon, 13 Apr
 2026 14:46:38 +0000
Received: from CH3PEPF00000014.namprd21.prod.outlook.com
 (2603:10b6:610:1e7:cafe::83) by CH3P221CA0011.outlook.office365.com
 (2603:10b6:610:1e7::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.48 via Frontend Transport; Mon,
 13 Apr 2026 14:46:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000014.mail.protection.outlook.com (10.167.244.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.0 via Frontend Transport; Mon, 13 Apr 2026 14:46:37 +0000
Received: from BLRANKISONI.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 13 Apr
 2026 09:46:32 -0500
From: Ankit Soni <Ankit.Soni@amd.com>
To: <iommu@lists.linux.dev>
CC: <vasant.hegde@amd.com>, <suravee.suthikulpanit@amd.com>,
	<joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>,
	<linux-kernel@vger.kernel.org>, <jgg@ziepe.ca>
Subject: [PATCH v5 3/4] iommu_pt: add kunit config for 32-bit VA (amdv1_cfg_1)
Date: Mon, 13 Apr 2026 14:45:20 +0000
Message-ID: <2a9b91f957bc6538e86c71da75503fb320fbf30d.1776075533.git.Ankit.Soni@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1776075533.git.Ankit.Soni@amd.com>
References: <cover.1776075533.git.Ankit.Soni@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000014:EE_|DM4PR12MB6254:EE_
X-MS-Office365-Filtering-Correlation-Id: 78562035-c8db-44d0-d3b3-08de996b7721
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700016|82310400026|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	asAoEi4uj/p6VFtzMQd12MaqGqs5oqKoeO/784+Lfu88YReDcB+XrIARJa4iOsqkbSe6gJARqyIqL/YK/zLrUch+fMF8nvp4cASh2BjLYu1RS/MP3Y79mzHxVF53uJ0yLr7WsEMkbSfmc5OtjG4nm5KOS9bjkp01V6vqnv9Lk0xbJjIcKXhGe3SRTM1MeIGkj6nYr41JNcmCfj8m4vAli+V1xrYsRZ+PrJqf9j9GeQ/33nYNW5f9Tn24XlGcF9yDmjZamty0ud/enoPVYBWWPzHUazj7NYjRJP1mSv3zTqMM5DbHH3olhjHP4cCuNEUEP0hZ7v8tU4XyR7y6olSsgnl4qIzA4RqnXFG7PWNbMhfskbFgqhF26qY4qAt7p53ZpKa/rGoTFiUpLYdFirTQnjAAGU2EOHVemYDYZ0EFryBJhFp1bdpGtG1ZWA1StlFxovL5Z24PLJoZaeXMsDuN8c9QrBVuKJ0Duw7UoPODSqnA5KXgkxsWW+L0bhHUDIcCmPMHq98R/oVXwp6/UPmbZhQua6baJ4FPNKpke+pqlU6L3eM7EXPPBZhFqLCt/LvEeQOMzb6o2kfxgTLjYyk6/3yg4AFhiVwZV7W2bk8lBvcXasK21b7Y2zdkmPAmBHMSVzwPz5tiW9Ihl0g2v9aQfukLBVCzxAGSliNqrfk8h5EYVOgHJYma6EBvb8+XS+uVq7itkewA3rLpWLqqyVEiTZQftpqmIpLqbu/IlwebCkMu9j2bOjQ9nGymdfc8zdMgWbbK5Gmh1SX2tKmP9uvmAQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	e+2tIEaTkKPfyn/PRPxuMroFtJb8ZWetGKlRT3lL6Gmdh3zmv+R1K/W/NfZSzbgz+HtX9lxwaWdHIX8o5gfDUNsLfnfPzDv5WGNMB+G0ObtrVhuCjKxai3fC1k6TIlNGNPYiXDNfn1HFmqP5QTerF//qk4t98mwFnz1TBkP9ThfYP4Q4S/by02RWFXYquYGlyCEkjBeYeGiQ3xPYSrXpsfmX7zJ6uJ601eUDP4zJ4MRUSeZ3PERpNgDE7MllURFKbVcl+RtXZGdDiPrr6s0BGrRQPy+7vuDcq+pSW9UgWDW0rBf7ygnzea/0aTKb+A06qrBHYX3kuasPZgzob+NculO9cyOLIPoES2NRlbyHEsURRpLrCv/LOVFOEOhWl4pF5Q1eCxJAvJTVKp99atx/5QIJdCsefTKi5OyZdOsvur3zRsCQ3XED1spcwpx+v3Iu
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2026 14:46:37.2172
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 78562035-c8db-44d0-d3b3-08de996b7721
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000014.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6254

Add test coverage for small VAs (32‑bit) starting at level 2 by enabling
the AMDv1 KUnit configuration. This limits level expansion because the
starting level can accommodate only the maximum virtual address requested.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Ankit Soni <Ankit.Soni@amd.com>
---
 drivers/iommu/generic_pt/fmt/amdv1.h      | 1 +
 drivers/iommu/generic_pt/kunit_iommu_pt.h | 5 +++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/generic_pt/fmt/amdv1.h b/drivers/iommu/generic_pt/fmt/amdv1.h
index 3b2c41d9654d..52ea88ee46da 100644
--- a/drivers/iommu/generic_pt/fmt/amdv1.h
+++ b/drivers/iommu/generic_pt/fmt/amdv1.h
@@ -404,6 +404,7 @@ amdv1pt_iommu_fmt_hw_info(struct pt_iommu_amdv1 *table,
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

