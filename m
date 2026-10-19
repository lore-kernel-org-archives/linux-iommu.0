Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012057.outbound.protection.outlook.com [40.93.195.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5ABC4F55A2
	for <iommu@lists.linux.dev>; Mon, 19 Oct 2026 13:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792415354; cv=fail; b=bhGl/YyL/1Mq9nx/tYl/N3zCh7EEVpyW8RWvT17ZBhP1ajCcnxAM2hD6k/phYrPc00pPvpMd/dSUQA4DhRS+/rrAVktIz+W+bpw7kDILuPnHGdzsrKSv4Vv5CdG0IA/SQt3lxFXSUWxL4WDrZADzKF8MKJXvz4pqe6mkEJdGbC4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792415354; c=relaxed/simple;
	bh=LfprJjlLEoiyDCu23uyBjHh53q0SEo7XT5Jx3TduYZs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lzhJFKt1dxxFtIw+Pzr3X5HFFiaLwvDVjIlEF6Wda6r/ux08k7EU9Ko8Ula/K4OOZ8KPpPMhx7BJydRLC1CJ7HeU42BPqpg+4STNDXob/kKbT7m+QsX2ruNrZqxKxF53b/i889xJp629YA1WQxGD79SBS9EJF4EwPXaKLmpMbf0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TbBQClWj; arc=fail smtp.client-ip=40.93.195.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TbBQClWj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jhW59uFsVb46W56M9BBYzG807AaARPoPTTwcxDYzucJ6FVRgKBRDqtI8fJGNL7YGOAxXxkEFABh6A2CD8FblT+aaN5FUDEm4f367a9LIjYK86KsyTZAAjqDqe7vDrDzGbVcpwHbMYVPcyJpGtWE6iurDNKB58PES259Vmcdep8RFYh7abOsN6ETl8EHnFdQxBBdex8BC7+iDwfFAZMITyKgiz4UZj/EbmjF/3jl0if46i2UUuGzZFUXXbzERiPXqoium6Sj9KNN4tOmyIeX6NRC1OKmrMDzhUBgb4AN4ma+/LHZtwjW6vhsGt4Rw31MdvA2EkG77vb0m9FgT95VphA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aOOgRtwiQhaN/Y02uKQWqsJVlpih+VXbHV5cMNIi9KA=;
 b=WJrkofgx5s+grfYxGEPleZKYUThNBSyBRLVlbzDNGVKM/GcTR2fh2s53YyYfvVq6dnguHU+r3rviLBG73dqgZyfuo7GuSLBt8mRUvO9RrhTRG0ct4lrUkn1L7qs84RJhVFpl3mPTCWQtA5B9RJ46Qd9yh7+K4sSRVIIKkcsX2U+trr3hfUej4BDs8YVaG+Q1ZxVgG79DNqdle8F8/YSj68gskg0jyhwf18AmpVXrVJj95cSxMvywjBQs4yPWU5usNQ5V83k9FewAV21lolk4e29ZfvYZPglxaU3FTu/k7fc/3gFU94VAcqPa/eklCfrQWRGjJ7ZY6RbCuAffDgipiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aOOgRtwiQhaN/Y02uKQWqsJVlpih+VXbHV5cMNIi9KA=;
 b=TbBQClWjZ4Nj2a7aLYuiXpkH8jMY5q59ekuJ2tUGyNtHMh882f82j5S0tu4bMWOlrKGsjhrVgmSu0tIBEFJpOo6/QapPspo+M/JjK/OtQe8bnFGL+O4WBmwqwVzbrABqEa/DBDhoiKeKLRQX3hqMaUjpNXpdFJZxP0RO8JrT/a4=
Received: from BN9PR03CA0721.namprd03.prod.outlook.com (2603:10b6:408:110::6)
 by DS4PR12MB9793.namprd12.prod.outlook.com (2603:10b6:8:2a3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 13:09:08 +0000
Received: from BN5PEPF00046989.namprd02.prod.outlook.com
 (2603:10b6:408:110:cafe::44) by BN9PR03CA0721.outlook.office365.com
 (2603:10b6:408:110::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Mon, 19
 Oct 2026 13:09:08 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN5PEPF00046989.mail.protection.outlook.com (10.167.245.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Mon, 19 Oct 2026 13:09:07 +0000
Received: from BLRANKISONI.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 19 Oct
 2026 08:08:54 -0500
From: Ankit Soni <Ankit.Soni@amd.com>
To: <iommu@lists.linux.dev>
CC: <vasant.hegde@amd.com>, <suravee.suthikulpanit@amd.com>,
	<joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] iommu/amd: Adhere to IVINFO[PAsize] for output address limits
Date: Mon, 19 Oct 2026 13:08:02 +0000
Message-ID: <234b46f9a73ff3a78fd47dc1a83146a591a8aed8.1792156095.git.Ankit.Soni@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1792156095.git.Ankit.Soni@amd.com>
References: <cover.1792156095.git.Ankit.Soni@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN5PEPF00046989:EE_|DS4PR12MB9793:EE_
X-MS-Office365-Filtering-Correlation-Id: 7adb95af-f248-4d10-ec98-08df2de228b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|23010399003|36860700016|82310400026|56012099006|11063799006|261009223027099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	nt2kBmnGyZ7pLDyz0/xRDKQu3TyzSNwrd/PPmO/yXqxOTSolGw1bmpjnrvXR7o7Ex709mfi4VmsMoQiscbaHTtvtlsEjtOAjCI/nZ9sAELi+B9i91+xjoXtDFSbSCxM0SgbUSxDZ5IBnwkFpzdnkyw4A/RT2kV1IsHT3zerAVW41SxVRtuLdF5dEjgDHThjSuZeo3KMutb7YC7Y6EoGECKGDI6xtNou6wpv2apS2gYcMUZcDVCMwiudirQTZsr/gMmxxQbx1EHiJSYSPiz8t0NBZbz0aopEXU25Aqb3ewZD2AP0Oo9P+SfVfhpEV8aWTeYbJJgOUd6/S/ykFv6Danvq23QLsQqW8L7Vd2O827lmosfXH37WSmxbPvNcydctzywWSWwLFrHpu4WLuxFb3tXbMw7nIoQ6oqcmMpoeTiP8MuBcgBeii3wFNG4MdA8Cx9HrJga95gHEpg0WlL94bKUR6OAf2aO18S6WH2wypf6m2geXzmG84k0MUXPWm88yprtwS0/ZW4ryGH3IzKLp4Bwy/pRbhavt7PFXwyzl+FMywXq1xv7sgw3tfON2vILypxHNGETevUhjEb+g95bMmaKxEshAurjpaSDr7F2zLrBWitSfsQKOKgE1NHVQaQU588WRfu/bUkB9MAhuXNBEEjCSjRE2nKQAqv6tOjfsksw9kqnLomJv2baG7gq5VBrZHd0qyYZ0KyNo4/Ktua1TOig==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(36860700016)(82310400026)(56012099006)(11063799006)(261009223027099003)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	NdWARft/CfZPkW+zWFHF5Vqdg50JtWA1jQYnxT2TJ4xZGtVOUje8wbcJlJXe/7Oho7pOSZfuZr6yydp+ukEKQqnW3JrPZjv5gD8+tkljR/UxKoKweiUBm3nqiAcQioKUf61E7VORrJ5+t2gfFKf0MNGRJjJ3I0+Qera1ZD7BoDFYlKg1/LRJAE/y2h+dXBDjERDHyzl0Xt+2gOwKF14wWb+k7fH0Qc+b0uOwQwGaiETwn2KBUkzikCK4kN+3eBUkr5G3tl0321YxBi87LMuAYD5hs/mgKyKcYNyZewo0JgEXS+5EMhZEi+jXcQ2K5WCnHxPIgvm71B2WTWwIAtFV79AQjwGdkz1H2+nWPfpQmWIj3HIi7hAZ6E1n16YyYEIDBp2Qk2UESUmIRpimdFNXTLM9krKsTyhF+snh107NXcwyteFauAuLR3sQ5tPHGwjT
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 13:09:07.8126
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7adb95af-f248-4d10-ec98-08df2de228b2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN5PEPF00046989.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9793

ACPI IVRS IVinfo reports the maximum physical address size (PAsize)
supported by the IOMMU. The AMD IOMMU driver currently hardcodes 52
bits when configuring paging domains. On systems where firmware or a
VM advertises a smaller limit, the driver may over-advertise
capabilities and create domains outside the hardware's actual bounds.

Signed-off-by: Ankit Soni <Ankit.Soni@amd.com>
---
 drivers/iommu/amd/amd_iommu.h       | 1 +
 drivers/iommu/amd/amd_iommu_types.h | 1 +
 drivers/iommu/amd/init.c            | 9 ++++++++-
 drivers/iommu/amd/iommu.c           | 4 ++--
 4 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 71113e860859..e90fdcc2f4a8 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -45,6 +45,7 @@ extern int amd_iommu_guest_ir;
 extern enum protection_domain_mode amd_iommu_pgtable;
 extern int amd_iommu_gpt_level;
 extern u8 amd_iommu_hpt_vasize;
+extern u8 amd_iommu_pasize;
 extern unsigned long amd_iommu_pgsize_bitmap;
 extern bool amd_iommu_hatdis;
 
diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 4a15b16bd2ca..35ffeb16c1a3 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -382,6 +382,7 @@
 #define IOMMU_IVINFO_EFRSUP     BIT(0)
 #define IOMMU_IVINFO_DMA_REMAP  BIT(1)
 #define IOMMU_IVINFO_VASIZE	GENMASK_ULL(21, 15)
+#define IOMMU_IVINFO_PASIZE	GENMASK_ULL(14, 8)
 
 /* IOMMU Feature Reporting Field (for IVHD type 10h */
 #define IOMMU_FEAT_GASUP_SHIFT	6
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 89da993d7d15..136e35362631 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -157,6 +157,8 @@ bool amd_iommu_irq_remap __read_mostly;
 enum protection_domain_mode amd_iommu_pgtable = PD_MODE_V1;
 /* Virtual address size */
 u8 amd_iommu_hpt_vasize;
+/* Physical address size */
+u8 amd_iommu_pasize __ro_after_init;
 /* Guest page table level */
 int amd_iommu_gpt_level = PAGE_MODE_4_LEVEL;
 
@@ -3196,7 +3198,12 @@ static void __init ivinfo_init(void *ivrs)
 
 static void __init init_pgtable_params(void)
 {
-	u8 vasize, efr_hats;
+	u8 pasize, vasize, efr_hats;
+
+	pasize = FIELD_GET(IOMMU_IVINFO_PASIZE, amd_iommu_ivinfo);
+	if (!pasize)
+		pasize = 52;
+	amd_iommu_pasize = min_t(u8, pasize, 52);
 
 	vasize = FIELD_GET(IOMMU_IVINFO_VASIZE, amd_iommu_ivinfo);
 	if (!vasize)
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 893cd2be11a2..a64045f5a54a 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2760,7 +2760,7 @@ static struct iommu_domain *amd_iommu_domain_alloc_paging_v1(struct device *dev,
 		cfg.common.features |= BIT(PT_FEAT_FLUSH_RANGE);
 
 	cfg.common.hw_max_vasz_lg2 = amd_iommu_hpt_vasize;
-	cfg.common.hw_max_oasz_lg2 = 52;
+	cfg.common.hw_max_oasz_lg2 = amd_iommu_pasize;
 	cfg.starting_level = 2;
 	domain->domain.ops = &amdv1_ops;
 
@@ -2835,7 +2835,7 @@ static struct iommu_domain *amd_iommu_domain_alloc_paging_v2(struct device *dev,
 		cfg.common.hw_max_vasz_lg2 = 47;
 		cfg.top_level = 3;
 	}
-	cfg.common.hw_max_oasz_lg2 = 52;
+	cfg.common.hw_max_oasz_lg2 = amd_iommu_pasize;
 	domain->domain.ops = &amdv2_ops;
 
 	ret = pt_iommu_x86_64_init(&domain->amdv2, &cfg, GFP_KERNEL);
-- 
2.43.0

