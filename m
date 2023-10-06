Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2052.outbound.protection.outlook.com [40.107.223.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D4215C2
	for <iommu@lists.linux.dev>; Fri,  6 Oct 2023 10:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5M4DcGys"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kVnDXpF9kPmowOeYyhzZ6Ymm0IHYp94MPyzX9OJOg9jxoQNL0iRqaosmRwDn9Q8opVuyc5KJi5Nj15o4XnOqm77I7FPjDw8MCJUtWbNvpFpGiF5lk0WOJlX/VVKolCtuDvMOIxdjGyAhJfXRMgW5BlXkGIa+3VuHA3apEQMq3TS2ROHexrONf9CJWOHi6FUnjiHrlLaN/9BVeECc3ooUEtOU/cBv+87k2p/H1TVIqxziJ9LUC/PVnNotntbk2txaY2BlSDOyN96clJNcJQZ6Xwsda3ZE5QQBEk+C2FnueIQnI0H33qe3boGID9di7Zwqq/3Nh2DMQ2j64Sgvx99DhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z4yYg6citx07Xyx+YYFzHttm0mFqDSnUxA8gANTFAOk=;
 b=ADKwAbXD2zsValy6uWgI5hb8dOvS7Zi3lSzLPLiKL+ZABHhh6j6uY0iUG+qMgS+qaGwD30zIu9a/Kd3tiehboiT4abWPG3nhj28dWK4g2MpDlHGRlk2MXULVrceVxDXsdZA60QQs2XvxPsw3GLUOcHj07G1C8mo8AX4Fo1mYTt+o5V4KitnNWImKR0eKAqucm2BsZl4SGe+aVJPOjUC+4Lks3hq2zc5mv+jDyE//757sGI+SDu0xkLIyuFqX8Ys5j8Drg5Q+0OLFnigGhnHkm5lRa+FP9NYiL84/lH11wjVethICSjhyQSgYSBheOF/fS7z8p11sEPZu4hiCK1IZpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z4yYg6citx07Xyx+YYFzHttm0mFqDSnUxA8gANTFAOk=;
 b=5M4DcGysJpB3hs5LQMmT2QZTqzeDwu5W+KOIQd4RHVlNd079vc+MZcMUHG4B4tw578vShLA5TZfOvcZDirsTbYj0rdoCCrlZ4jzJmX3/Z1l2Zkv2L0HnkkYQI6oS1BvqQSE6pWtxEOvn9ogSArCgAdJea0k+S+jkcumHi2YEQNA=
Received: from MN2PR11CA0003.namprd11.prod.outlook.com (2603:10b6:208:23b::8)
 by MW4PR12MB7165.namprd12.prod.outlook.com (2603:10b6:303:21b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.31; Fri, 6 Oct
 2023 10:17:16 +0000
Received: from BL6PEPF0001AB55.namprd02.prod.outlook.com
 (2603:10b6:208:23b:cafe::a9) by MN2PR11CA0003.outlook.office365.com
 (2603:10b6:208:23b::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.29 via Frontend
 Transport; Fri, 6 Oct 2023 10:17:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB55.mail.protection.outlook.com (10.167.241.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Fri, 6 Oct 2023 10:17:15 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 6 Oct
 2023 05:17:13 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v1 01/13] iommu/amd: Rename iommu_flush_all_caches() -> amd_iommu_flush_all_caches()
Date: Fri, 6 Oct 2023 10:16:12 +0000
Message-ID: <20231006101624.5912-2-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231006101624.5912-1-vasant.hegde@amd.com>
References: <20231006101624.5912-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB55:EE_|MW4PR12MB7165:EE_
X-MS-Office365-Filtering-Correlation-Id: f3f7f46f-2f3e-46ba-b3d8-08dbc6556a06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ng04r02Uxt4Fh4doG7tUWCeVt9TFttYM6DhXoy+mYlP+SGKhQaHSYS6J+EfZAVwaI07tkWUG7ndxLRfXi0j4BPgADIlnvicaVoZ4D6agTyi4Yh5uSW4As9ysJ9OV/9ecyRp3eqO2WI0Y9uK27wF5kboJk/BhXQ4aNMQQgbUQRWweL068CiBavFCE8FiAuLuT0qDv8WMZua1WU5WWzWZ5yDZrZXQUfKvX8e/8gG/TC1/YeazM75/9AqQQ/4OxFmnA62Zs0oBWSIPdVvh4s+8L/Nwz4zY/fr8p4XeyMV9zKDug94eMOsx88Uowq6zwCfmKLb4K2gfrlwuGzefoErra0TU0izjhzkdawbKc/fAZov0QCsBaXsPXaHa59/L17w57pN8PGBqdFW22ZEr/3wg38hxXjhidicDGhtlw6wEGMGheRsl9lrTmO/4pwjR8XWlVisxILZUYe8BZaTRhAJmcIjWI9UiJzmTRSCwmewggrnOivtob91SVo8XYFxgvEo4mJPMYToNQUHlBT5tgCikthI6IVMJom8xfkC7+lKHuhNfwUQYhblRWuo1rdt5OYORUjnrUFQBLaMzFxovolhzZMb9SiIFrEXBX6fTnJrHSiYGIzTaGzXA7c+1x5idcc1JybEY7tXbyf4+pxpzf5qQQP9KD3uj87uaX3oxV3LkICXGErxoKNvg3EhDifZpXwZ3bXGDkmFmUZzkMap4pmVmZeXM+ctfDqId/wEFn6CcJPI2s65m+D+tUZ7J+NuuotGs0MurZOykSYVw7zjZt2pz9xQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(396003)(346002)(136003)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(82310400011)(40470700004)(46966006)(36840700001)(40460700003)(36756003)(86362001)(40480700001)(54906003)(41300700001)(4326008)(44832011)(426003)(336012)(5660300002)(8676002)(478600001)(70206006)(2616005)(110136005)(1076003)(16526019)(316002)(70586007)(26005)(8936002)(47076005)(7696005)(2906002)(36860700001)(81166007)(82740400003)(356005)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2023 10:17:15.5932
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f3f7f46f-2f3e-46ba-b3d8-08dbc6556a06
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB55.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7165

Rename function inline with driver naming convention.

No functional changes.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/amd_iommu.h       | 5 +++++
 drivers/iommu/amd/amd_iommu_types.h | 6 ------
 drivers/iommu/amd/init.c            | 8 ++++----
 drivers/iommu/amd/iommu.c           | 2 +-
 4 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 86be1edd50ee..234db57cd320 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -53,6 +53,11 @@ int amd_iommu_pdev_enable_cap_pri(struct pci_dev *pdev);
 void amd_iommu_pdev_disable_cap_pri(struct pci_dev *pdev);
 
 int amd_iommu_flush_page(struct iommu_domain *dom, u32 pasid, u64 address);
+/*
+ * This function flushes all internal caches of
+ * the IOMMU used by this driver.
+ */
+void amd_iommu_flush_all_caches(struct amd_iommu *iommu);
 void amd_iommu_update_and_flush_device_table(struct protection_domain *domain);
 void amd_iommu_domain_update(struct protection_domain *domain);
 void amd_iommu_domain_flush_complete(struct protection_domain *domain);
diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index e742006f2885..ba40e5066300 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -890,12 +890,6 @@ extern int amd_iommu_max_glx_val;
 extern u64 amd_iommu_efr;
 extern u64 amd_iommu_efr2;
 
-/*
- * This function flushes all internal caches of
- * the IOMMU used by this driver.
- */
-void iommu_flush_all_caches(struct amd_iommu *iommu);
-
 static inline int get_ioapic_devid(int id)
 {
 	struct devid_map *entry;
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 64bcf3df37ee..c83bd0c2a1c9 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -2223,7 +2223,7 @@ static int __init amd_iommu_init_pci(void)
 		init_device_table_dma(pci_seg);
 
 	for_each_iommu(iommu)
-		iommu_flush_all_caches(iommu);
+		amd_iommu_flush_all_caches(iommu);
 
 	print_iommu_info();
 
@@ -2773,7 +2773,7 @@ static void early_enable_iommu(struct amd_iommu *iommu)
 	iommu_enable_xt(iommu);
 	iommu_enable_irtcachedis(iommu);
 	iommu_enable(iommu);
-	iommu_flush_all_caches(iommu);
+	amd_iommu_flush_all_caches(iommu);
 }
 
 /*
@@ -2829,7 +2829,7 @@ static void early_enable_iommus(void)
 			iommu_enable_xt(iommu);
 			iommu_enable_irtcachedis(iommu);
 			iommu_set_device_table(iommu);
-			iommu_flush_all_caches(iommu);
+			amd_iommu_flush_all_caches(iommu);
 		}
 	}
 }
@@ -3293,7 +3293,7 @@ static int __init state_next(void)
 				uninit_device_table_dma(pci_seg);
 
 			for_each_iommu(iommu)
-				iommu_flush_all_caches(iommu);
+				amd_iommu_flush_all_caches(iommu);
 		}
 	}
 	return ret;
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 45b74dfedce9..fd4154c2e770 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1390,7 +1390,7 @@ static void amd_iommu_flush_irt_all(struct amd_iommu *iommu)
 	iommu_completion_wait(iommu);
 }
 
-void iommu_flush_all_caches(struct amd_iommu *iommu)
+void amd_iommu_flush_all_caches(struct amd_iommu *iommu)
 {
 	if (check_feature(FEATURE_IA)) {
 		amd_iommu_flush_all(iommu);
-- 
2.31.1

