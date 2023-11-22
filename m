Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902AE2BAEA
	for <iommu@lists.linux.dev>; Wed, 22 Nov 2023 09:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lKr4ynUO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cw4wzEMkStTUWu1W2grsoFsqpLU4rP7drNzGFtE4nFfJS28mE17qOjiGClW63QJwgic3mTbK9fL+5SctA+3x64vsGHgGqqGcoE5aOejY+E7efts30I9Mk1QCqHFBpDfqjqM1o8+K8OrTo/EjO6PEQLw26AH5L88kL/nu0IgUi3F/MtwBgpH6c6H7AdFu4DkBVnibAkXD/NjCRGppZ9MJFB5IXBxvq14zw0y/HfKofD16+oLalq/FKQopV+Xd2Xzt6ITjNPYp6bkhOptPcXqsc5wkXCIosbN28UFLmJgVnPhWUGGM4E5DhIj36+vFgUQoECMiAMCYyn9AIDjz8bbycw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CPWysY/2c+FMqyusBnX1J2LfdY6It4jAbRygNWdvLrg=;
 b=hr9q8mMoOkquj8mjg+iZC6fWpaiyAatkI5CY2j55N8tZRXDjSw1ZByx1J63naEafC5i1LMA0SekHmyPpJdiVcMKSUhs7lFeBm3Nq4paMSIbT/F5gwnaCKuJveXWrwcS5C5u5mDwG4Wxb1BaX0+Uh3K82rvq/E31XNggQMGHo2hcDy9XPxE1BcuoUIm7R+90mAriI+TtAwVTX9wPl+J8oLxUosp9b4mZeVSFmedPu270kNg3fvCp768fbH6AKeJD4HF7lzEExPbY8Ao3n0gXlOh5JKJcHruNSsPvxtKUPXhvFTOjpiM7gZ8hy6327F3yDXnGAgVEkKRsG3DP3nYtLfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CPWysY/2c+FMqyusBnX1J2LfdY6It4jAbRygNWdvLrg=;
 b=lKr4ynUOIKUcRTKSdlSt40LozvwhMH+wMoE3gE5YeKkD2unMPzhCEFlJ2RBR7pCvirA77MZ5+9eogwrlWzx4LrHND8wwjOUIFLATNyAQmVLze5Zr+8XWO1bJ7APzURuTfaIaLuFXG3gEUEtxRx5Y3fyupBYybhFejAN1Sbq07sA=
Received: from PH8PR15CA0015.namprd15.prod.outlook.com (2603:10b6:510:2d2::23)
 by SN7PR12MB8601.namprd12.prod.outlook.com (2603:10b6:806:26e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.18; Wed, 22 Nov
 2023 09:03:00 +0000
Received: from SN1PEPF0002BA4F.namprd03.prod.outlook.com
 (2603:10b6:510:2d2:cafe::85) by PH8PR15CA0015.outlook.office365.com
 (2603:10b6:510:2d2::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.18 via Frontend
 Transport; Wed, 22 Nov 2023 09:03:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF0002BA4F.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7025.12 via Frontend Transport; Wed, 22 Nov 2023 09:03:00 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 22 Nov
 2023 03:02:57 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <jgg@ziepe.ca>, Vasant Hegde
	<vasant.hegde@amd.com>, Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v2 1/9] iommu/amd: Rename iommu_flush_all_caches() -> amd_iommu_flush_all_caches()
Date: Wed, 22 Nov 2023 09:02:07 +0000
Message-ID: <20231122090215.6191-2-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231122090215.6191-1-vasant.hegde@amd.com>
References: <20231122090215.6191-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4F:EE_|SN7PR12MB8601:EE_
X-MS-Office365-Filtering-Correlation-Id: f5714db1-667d-466e-821f-08dbeb39d3fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	FefQd/pjwUGtw6oe06nwbAUjuuHKb+ts6W3NOFL1FF3Bku2oTl6+W7C+dxGfIZQ89zy36ss2osojw5yJc+pyV4aXoLSKXs1rdRyP2fJEbSKqRrVPazNzTcOuduzzZEnfRcSKRr0tRIdhn+b6SSTY9SxLU+7H+AT01eUpnYhMhhSMf/+21eoOL77j48vSp8CYNGsUIQD8LeITmk8t+c7UdJbOnV4SyglZpIvcrfNOzNUN71fmIz/LzAMh/fMMwvqfIcPwVXXLSMlBisfUgQeI+3ml2xXj/333kjb7Bzt/hAqiOw0DWqaDLogDYIl11Tkt0oUV6xkxf1YA/en7FcgGZ2LFNG0VIrp07pV7MZ7q9LZQn/Nd+PS/JRExuyKhcFDLvvXXEtvunflFT9Eqrv6gBGhy2XyaQKpLm1Tvg+jfvAIqCHM9iIBiJcXKyxoRbLOR4T+tECBt9MF086q2mP6ZDxwwyNoRWvvFgpBe6gJGQkha0GXzHMarpqzMQc8efTGRobBbjUYUSU0qb2T35TXyOmnGKP4hpAr7USt/Chl39Xfw1UwGUMyor8+dIos/TmGAL4LT1QQ4ZQoSvOGZ5cGfyX6K1RsSDIIt//QEOixtqcPRsVP1sWVzMk9DVCobHWy+sOwnYIoCCqYaTTifLOXjOm280R1ytyf5ysyy33E04xqUfY5qgYZj4mVzkMmzIuo3bRf5p907vvKQEPG6EjO2IRvgBi4R0lvRtxQqkSwc+jpbtC3t/mccvYStg+/hs0aG8u8m58bJH0S4uhG/ueWUpQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(376002)(39860400002)(136003)(346002)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(82310400011)(36840700001)(40470700004)(46966006)(40460700003)(426003)(336012)(83380400001)(16526019)(81166007)(47076005)(36756003)(82740400003)(356005)(86362001)(36860700001)(70586007)(110136005)(8936002)(316002)(8676002)(41300700001)(4326008)(5660300002)(2906002)(44832011)(70206006)(54906003)(1076003)(26005)(2616005)(40480700001)(6666004)(478600001)(7696005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 09:03:00.4701
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f5714db1-667d-466e-821f-08dbeb39d3fd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8601

Rename function inline with driver naming convention.

No functional changes.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
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
index 90b7d7950a9e..809d74faa1a5 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -902,12 +902,6 @@ extern int amd_iommu_max_glx_val;
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
index fcc987f5d4ed..6a43ebddaf87 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1392,7 +1392,7 @@ static void amd_iommu_flush_irt_all(struct amd_iommu *iommu)
 	iommu_completion_wait(iommu);
 }
 
-void iommu_flush_all_caches(struct amd_iommu *iommu)
+void amd_iommu_flush_all_caches(struct amd_iommu *iommu)
 {
 	if (check_feature(FEATURE_IA)) {
 		amd_iommu_flush_all(iommu);
-- 
2.31.1

