Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CA30C43334
	for <iommu@archiver.kernel.org>; Fri,  3 Jun 2022 11:22:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1E29A404F8;
	Fri,  3 Jun 2022 11:22:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id n_poWnEra90q; Fri,  3 Jun 2022 11:22:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id DD834404BF;
	Fri,  3 Jun 2022 11:22:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A4738C0039;
	Fri,  3 Jun 2022 11:22:51 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 21D07C002D
 for <iommu@lists.linux-foundation.org>; Fri,  3 Jun 2022 11:22:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 10F6D607D1
 for <iommu@lists.linux-foundation.org>; Fri,  3 Jun 2022 11:22:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vye87HyE1Ntn for <iommu@lists.linux-foundation.org>;
 Fri,  3 Jun 2022 11:22:49 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20621.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::621])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C4FEB606BF
 for <iommu@lists.linux-foundation.org>; Fri,  3 Jun 2022 11:22:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c4YlGpg9LUvY6nEoo8AsfUw64LjBp0gsLSyVdjZKlsKSoFWZBol7/M5FeerGuEdPnH5TWFdLdWBybu/NmPE16uVLnqWIMc2jf0Rg3xwy2KCMGJcr8P1yU7r3m5AjpbclAxPQaVXDBtGJ5HnkP+bL2IkNKMqutqLtav5OvBb7lSx3udYVlR7HmyxTjuR0+wvw04LfBYJLaRPaKr/k+1xlkbXcLkGPfXcBnV2BKnh/qZTR1I7Q+8nATSX17y0eFzO2zSo85aBUXsuWVS734GfH9gQsTzEox7SJVuMlNzfobpthrq7eFdmRBn3kEXJA3ftGT4ULuaH3/+phzqK2ioQ9rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IHSqBpbx7tCfGJVFtFlYPfh5xxfWF1hRWPTxprp77K4=;
 b=BVn6LyjKV6FG95OZkAGOgTVtSgKTzbJgjhL8wpLB/cTsfX8lHS69E/b3C0vByCFz9aTRMA3gNAHx8jInJFR8EGLNrUopxcDkp0cozoc9pCk9mm7fMldSEutm+4H9F/agSSFt9BhHQ4FP7Jj2r6apndG5JRhd9/Ba5Ap8DEc69EveY3rbNcKDbgul7pgvUShiS1iGXmOXZySifhMYHDc3eyyi2VJMaa88VuPOcRx5vPREkkCPRkQQ+mq1MbLTj1PQ8F89ZYmLQE3xvDM2uHZyYmpgzBQQQ90MJ1THKatKcPokf/txVHlgjWa+AkXrOH7rgcZU0uOIfOtfsWXe9RV7Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IHSqBpbx7tCfGJVFtFlYPfh5xxfWF1hRWPTxprp77K4=;
 b=TYkfayDU+9fvjtraAkfjefp/w4x25YqaPJOZ5Up16QCZjPJKkCnUc0aLsmzG3smdf9XR+OAe4Q7YkPv3T59d0kTAQdaQ/tIqxjQ3+07aGcgAKiuE5dUvr9pRKVvQMDo+ScOSzY6E4TjOP740Bc+WEI5J3MLvx647oVmh5VZjK4I=
Received: from DM5PR18CA0081.namprd18.prod.outlook.com (2603:10b6:3:3::19) by
 CY4PR1201MB0119.namprd12.prod.outlook.com (2603:10b6:910:1e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.18; Fri, 3 Jun
 2022 11:22:47 +0000
Received: from DM6NAM11FT049.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:3:cafe::dd) by DM5PR18CA0081.outlook.office365.com
 (2603:10b6:3:3::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.15 via Frontend
 Transport; Fri, 3 Jun 2022 11:22:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT049.mail.protection.outlook.com (10.13.172.188) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5314.12 via Frontend Transport; Fri, 3 Jun 2022 11:22:46 +0000
Received: from kali.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 3 Jun
 2022 06:22:44 -0500
To: <iommu@lists.linux-foundation.org>
Subject: [PATCH v1 5/7] iommu/amd: Add support for Guest IO protection
Date: Fri, 3 Jun 2022 16:51:05 +0530
Message-ID: <20220603112107.8603-6-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220603112107.8603-1-vasant.hegde@amd.com>
References: <20220603112107.8603-1-vasant.hegde@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 96e68b6c-f5dd-4aac-656e-08da455362c3
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0119:EE_
X-Microsoft-Antispam-PRVS: <CY4PR1201MB011927C1653496CE2003AD7087A19@CY4PR1201MB0119.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rBNO199L0Kwds/XHhtrXhbRa3hnvXom7vTlaSfl2QKRLVVhXN0+vr/u6TqqbBnxeaoSSzNMvgS8mUNZ1bnRol3TklbNWklUFjcLV02vsRW0FExq97fb3S/bfIat3MFiEpisi22TVLvxUXIMw1xb73WFIiJzvxq2//7F2tUgURRnF37UobL4HXSdtZqJ0+ujgmzNLYoZ5twHgzhJbhexTW4x0VDmNMrl90bnnHnMYx+gvjKPAxNIYUQLIN5powLyiWaNEsLPSdNRzkvV30LuJFy6JEoCBgK94vnYnU7uUsi0wiXqvPdqCdFOvDAV4WCxS1y4e3O4r6dQ9Ak4o02y3OoBWYFXYA34DHxPW8grjo3fWtpazKvniiw4ZqOGPdfMPDE0pdBBVjLAZk/avz2i/weg+tV5rPRYkUmE2zQ5CwJH76hiND0CNrA/sDSyA2biI35wD9t/M6B2c7/NHgjtvxNUd2BFNfx26GfMZNO2/wQ67p9DJuX0bIR6IIJRvPcweYiHMKbISjJvnfanekD2nMB0iExY8F+f2sNG4lCAIZ14ssCj3kaw+9uOJkGOIKxFkkxCzHpORjOuPNLFRqLj7QutgzT2TF1umu/QamGfyAl2BplsvulXlHoq/1ZTFbIlof6orm2iF+M74kM8snAQIus5GY9HxIzIviqppkLhjZ3KVWkwhxEl6VGE7Tm6NYptshMoyr0mObcJzotmBeS1stg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(356005)(186003)(82310400005)(86362001)(6916009)(83380400001)(36756003)(508600001)(70586007)(70206006)(6666004)(8676002)(4326008)(316002)(426003)(81166007)(5660300002)(54906003)(336012)(44832011)(2616005)(1076003)(16526019)(47076005)(36860700001)(40460700003)(8936002)(26005)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2022 11:22:46.6827 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 96e68b6c-f5dd-4aac-656e-08da455362c3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT049.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0119
Cc: Vasant Hegde <vasant.hegde@amd.com>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
From: Vasant Hegde via iommu <iommu@lists.linux-foundation.org>
Reply-To: Vasant Hegde <vasant.hegde@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

AMD IOMMU introduces support for Guest I/O protection where the request
from the I/O device without a PASID are treated as if they have PASID 0.

Co-developed-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h | 3 +++
 drivers/iommu/amd/init.c            | 8 ++++++++
 drivers/iommu/amd/iommu.c           | 5 +++++
 3 files changed, 16 insertions(+)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 4062313a2407..a25c24188104 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -93,6 +93,7 @@
 #define FEATURE_HE		(1ULL<<8)
 #define FEATURE_PC		(1ULL<<9)
 #define FEATURE_GAM_VAPIC	(1ULL<<21)
+#define FEATURE_GIOSUP		(1ULL<<48)
 #define FEATURE_EPHSUP		(1ULL<<50)
 #define FEATURE_SNP		(1ULL<<63)
 
@@ -370,6 +371,7 @@
 #define DTE_FLAG_IW (1ULL << 62)
 
 #define DTE_FLAG_IOTLB	(1ULL << 32)
+#define DTE_FLAG_GIOV	(1ULL << 54)
 #define DTE_FLAG_GV	(1ULL << 55)
 #define DTE_FLAG_MASK	(0x3ffULL << 32)
 #define DTE_GLX_SHIFT	(56)
@@ -427,6 +429,7 @@
 #define PD_PASSTHROUGH_MASK	(1UL << 2) /* domain has no page
 					      translation */
 #define PD_IOMMUV2_MASK		(1UL << 3) /* domain has gcr3 table */
+#define PD_GIOV_MASK		(1UL << 4) /* domain enable GIOV support */
 
 extern bool amd_iommu_dump;
 #define DUMP_printk(format, arg...)				\
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 453afce7d478..d4d9c812305d 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -2024,6 +2024,12 @@ static int __init iommu_init_pci(struct amd_iommu *iommu)
 
 	init_iommu_perf_ctr(iommu);
 
+	if (amd_iommu_pgtable == AMD_IOMMU_V2 &&
+	    !iommu_feature(iommu, FEATURE_GIOSUP)) {
+		pr_warn("Cannot enable v2 page table for DMA-API. Fallback to v1.\n");
+		amd_iommu_pgtable = AMD_IOMMU_V1;
+	}
+
 	if (is_rd890_iommu(iommu->dev)) {
 		int i, j;
 
@@ -2098,6 +2104,8 @@ static void print_iommu_info(void)
 		if (amd_iommu_xt_mode == IRQ_REMAP_X2APIC_MODE)
 			pr_info("X2APIC enabled\n");
 	}
+	if (amd_iommu_pgtable == AMD_IOMMU_V2)
+		pr_info("V2 page table enabled\n");
 }
 
 static int __init amd_iommu_init_pci(void)
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index deb546266d42..f2d939b7cc4d 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1553,6 +1553,11 @@ static void set_dte_entry(struct amd_iommu *iommu, u16 devid,
 
 	pte_root |= (domain->iop.mode & DEV_ENTRY_MODE_MASK)
 		    << DEV_ENTRY_MODE_SHIFT;
+
+	if ((domain->flags & PD_IOMMUV2_MASK) &&
+	    (domain->flags & PD_GIOV_MASK))
+		pte_root |= DTE_FLAG_GIOV;
+
 	pte_root |= DTE_FLAG_IR | DTE_FLAG_IW | DTE_FLAG_V | DTE_FLAG_TV;
 
 	flags = dev_table[devid].data[1];
-- 
2.27.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
