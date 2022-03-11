Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 312F3C433EF
	for <iommu@archiver.kernel.org>; Fri, 11 Mar 2022 09:59:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E3508605BE;
	Fri, 11 Mar 2022 09:59:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2e2HcACC1WSl; Fri, 11 Mar 2022 09:59:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id D19526127F;
	Fri, 11 Mar 2022 09:59:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AA1CEC0012;
	Fri, 11 Mar 2022 09:59:27 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A60AFC000B
 for <iommu@lists.linux-foundation.org>; Fri, 11 Mar 2022 09:59:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 868CB60D80
 for <iommu@lists.linux-foundation.org>; Fri, 11 Mar 2022 09:59:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rGQ9HHzn5gnk for <iommu@lists.linux-foundation.org>;
 Fri, 11 Mar 2022 09:59:25 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2060f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::60f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C0A70605BE
 for <iommu@lists.linux-foundation.org>; Fri, 11 Mar 2022 09:59:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V0KL6v9uejbbWSF0DkoyG0GQNR2QACIRPmOUKqtagC3PZrr+17ZqOKUrjDYgiAruQ3KzigA6YaJTDgORsT5Jnuz33IOyZp0ad0l7dvi4poFnFY/AvvSsI++AUvKcPFdCfVIEapmB8REp3LH4jS+OE4Ndi14aTPDmq9hIhaYG49VfhKuFUXtB621vTpU1Faxs5VaFaOJo7FUwgibUES9Z1i4FAf02IAqb22LZPdAfbA9sYY0pe/L+r49UnH/UTFM8FBKuTpvpz2OhgTxAr29iGwAARfSt69LcJtqSwWQXgpPlMAHpLCHuWK08nR9M7nedNz6qdNAWrf69C+z+nHUpcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zBaAzAGJBNj3rp8ipMZYUV5iokI2Y+YtwRWToJxutZU=;
 b=ZdEnAtGITW1ZkWguuxN/g1HgNZ1Thi5dzDLsDWQDczHlLgTFiZIVkg5akEjJ7VR0pPbncNGo+1cmPgg5TMOA2jVCHqScW4ywsieboc2z1MteZn9YeinCvOD+ECOm4htonZV6RVLBcLFPOrGgeMTcOLV+GSb4TjOYRXHeb7BRY3CybpIMcCgTbdSxw2OXLUotJ/EBPg2dp2G1aeaMrB8w53SWqRK3RCmECitvmd9YoRKa0TxBr+Kpx7xUrF8CsD3YlPkFNmoT4cuYuwbRmPKQks8kS6izykzXUO966xaozrIcfGpIZvYA/L00uDInd/4PZGgiHwc1SY9JniQEWo9xDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zBaAzAGJBNj3rp8ipMZYUV5iokI2Y+YtwRWToJxutZU=;
 b=kfpYQE6hczLR8vCW1Ih9niKYxLCcmGv2MZk/qNcc7paLpCKkZYsOWPn2USVpDEzzOEXBLoKRJa04C49Nrtac0H6j1hxvQfwz2V8enzm9ka5TyThb5gJ+paBFvLxm4FPaDMrfgfaueUXafhRj+EzWwC4rWvKRZ/liGMB+muDiN+c=
Received: from DS7PR03CA0141.namprd03.prod.outlook.com (2603:10b6:5:3b4::26)
 by DM5PR12MB1884.namprd12.prod.outlook.com (2603:10b6:3:10d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.16; Fri, 11 Mar
 2022 09:59:19 +0000
Received: from DM6NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b4:cafe::cb) by DS7PR03CA0141.outlook.office365.com
 (2603:10b6:5:3b4::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.23 via Frontend
 Transport; Fri, 11 Mar 2022 09:59:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT065.mail.protection.outlook.com (10.13.172.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5061.22 via Frontend Transport; Fri, 11 Mar 2022 09:59:19 +0000
Received: from kali.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 11 Mar
 2022 03:59:14 -0600
To: <iommu@lists.linux-foundation.org>, <joro@8bytes.org>
Subject: [RFC PATCH 27/36] iommu/amd: Remove global amd_iommu_alias_table
Date: Fri, 11 Mar 2022 15:18:45 +0530
Message-ID: <20220311094854.31595-28-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220311094854.31595-1-vasant.hegde@amd.com>
References: <20220311094854.31595-1-vasant.hegde@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 05b408f0-07a8-417d-280b-08da0345cf7d
X-MS-TrafficTypeDiagnostic: DM5PR12MB1884:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB1884713C8C49437149D87801870C9@DM5PR12MB1884.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I5pOatBZpPN2EaayeDLpDqS1sqScHY7W1tiu/HCXQe+Cxwt/g0sVB29WmyHsFRWaWa9C1LiGABGOIwGRe32ubujA8UHLaXK+m31l0e6g1tTGLLJTFQhChv0yaV8rKrfc+AOo5cZWRehMJaSNY2THLs8fw1riJ8IpGzOmovkUeBkXf60i1DSuP95LQJKA4oJfB0GVTV/5bJs+D3xjYe56Eh1o4vyk1z4ixAgQqvGOPJszuKZnpljdcflDQ+JLJBmuPujKF3VvDNmMn5PGIcMzx1DEhOBvaIyeXokMurFl+JI1tgx7tw6kvNZbEzhtKKOEBNKOoWcJpXe3GY2UyOoc3IReJNNEsmSDmTeo/RoOO+F3XJFAJDfL2YC5VasmI6/NvPTM+QMnFVFHJJmaL0cHk0ijwU+bCF2r/ZQ/T/vdwcC9H5X3gJwHIMPr+Ymfyn0iSPQEvae0rOXmSqch645GGOEWNzbgurMYEKv/wCB08tRx4uFEFqm5cKH/4YSxg8GX0QGv7sT7Fd4LZDxVwETczBEx7+45DC7eudPtNPSOSlo5X1fo+S6qOx8Bb17/blub3s9cN20fZuC7hcqhL9wYtAMdHUhJJpkPy4xfaZPv3fHQ40KOGzQfdC1nmRGTSAexykxh2KO6O4b5ttHDqAppNNnKAZWsLKv+06Y81fk18utzBBkqShTy7q1On6nyJnvnflq5AZ5Zp6eVDixgOa5yUg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(26005)(82310400004)(316002)(110136005)(186003)(16526019)(54906003)(426003)(336012)(2616005)(6666004)(1076003)(4326008)(5660300002)(36756003)(8676002)(44832011)(8936002)(70206006)(70586007)(47076005)(86362001)(356005)(508600001)(83380400001)(36860700001)(81166007)(2906002)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2022 09:59:19.3965 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 05b408f0-07a8-417d-280b-08da0345cf7d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT065.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1884
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

This is replaced by the per PCI segment alias table.
Also remove alias_table_size variable.

Co-developed-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h |  6 ------
 drivers/iommu/amd/init.c            | 24 ------------------------
 2 files changed, 30 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index ca54e7665771..7d719461db27 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -826,12 +826,6 @@ struct unity_map_entry {
  * Data structures for device handling
  */
 
-/*
- * Alias table to find requestor ids to device ids. Not locked because only
- * read on runtime.
- */
-extern u16 *amd_iommu_alias_table;
-
 /* size of the dma_ops aperture as power of 2 */
 extern unsigned amd_iommu_aperture_order;
 
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index dd667dfb4355..b3905b1c4bc9 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -185,21 +185,12 @@ static bool amd_iommu_pc_present __read_mostly;
 
 bool amd_iommu_force_isolation __read_mostly;
 
-/*
- * The alias table is a driver specific data structure which contains the
- * mappings of the PCI device ids to the actual requestor ids on the IOMMU.
- * More than one device can share the same requestor id.
- */
-u16 *amd_iommu_alias_table;
-
 /*
  * AMD IOMMU allows up to 2^16 different protection domains. This is a bitmap
  * to know which ones are already in use.
  */
 unsigned long *amd_iommu_pd_alloc_bitmap;
 
-static u32 alias_table_size;	/* size of the alias table */
-
 enum iommu_init_state {
 	IOMMU_START_STATE,
 	IOMMU_IVRS_DETECTED,
@@ -2791,10 +2782,6 @@ static void __init free_iommu_resources(void)
 	kmem_cache_destroy(amd_iommu_irq_cache);
 	amd_iommu_irq_cache = NULL;
 
-	free_pages((unsigned long)amd_iommu_alias_table,
-		   get_order(alias_table_size));
-	amd_iommu_alias_table = NULL;
-
 	free_iommu_all();
 	free_pci_segment();
 }
@@ -2923,20 +2910,9 @@ static int __init early_amd_iommu_init(void)
 	amd_iommu_target_ivhd_type = get_highest_supported_ivhd_type(ivrs_base);
 	DUMP_printk("Using IVHD type %#x\n", amd_iommu_target_ivhd_type);
 
-	alias_table_size   = tbl_size(ALIAS_TABLE_ENTRY_SIZE);
-
 	/* Device table - directly used by all IOMMUs */
 	ret = -ENOMEM;
 
-	/*
-	 * Alias table - map PCI Bus/Dev/Func to Bus/Dev/Func the
-	 * IOMMU see for that device
-	 */
-	amd_iommu_alias_table = (void *)__get_free_pages(GFP_KERNEL,
-			get_order(alias_table_size));
-	if (amd_iommu_alias_table == NULL)
-		goto out;
-
 	amd_iommu_pd_alloc_bitmap = (void *)__get_free_pages(
 					    GFP_KERNEL | __GFP_ZERO,
 					    get_order(MAX_DOMAIN_ID/8));
-- 
2.27.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
