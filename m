Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 359C9C433F5
	for <iommu@archiver.kernel.org>; Fri, 11 Mar 2022 09:52:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E45D2409F2;
	Fri, 11 Mar 2022 09:52:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CUVqHoX3InYZ; Fri, 11 Mar 2022 09:52:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 908B5408D9;
	Fri, 11 Mar 2022 09:52:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6668CC0012;
	Fri, 11 Mar 2022 09:52:47 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 353C4C000B
 for <iommu@lists.linux-foundation.org>; Fri, 11 Mar 2022 09:52:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 220C640906
 for <iommu@lists.linux-foundation.org>; Fri, 11 Mar 2022 09:52:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OdIPpfbl6iE8 for <iommu@lists.linux-foundation.org>;
 Fri, 11 Mar 2022 09:52:45 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2062b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::62b])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 12D55408D9
 for <iommu@lists.linux-foundation.org>; Fri, 11 Mar 2022 09:52:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e5OWxSpqdQELJ8LgwpcLvCgJfo+2SxaqjCvUyOXrqW4eK9OEk2N2xoxOdzMs5+mBl0hzVTKSjbfxMb+HbrfOWP6X+txVjs0Timp+s2CvOd4L8ICLX2WvBS67e92hK3FIEBsZD76lS0ldaBBTegZtQVMeoQ3glzDvf/e8s3PNuVldkruMjOZwIvdm4VCUqnXzzvlcVFsnvs2cg3XbkQtqBtDkI9MCFqxziLd4KAx9QpCEyDGCXi1I+EOGP6eR1ewFOdcK0D0DYV9AjSFZa6oAmGFHY/ixXUEyia1qIBK02B0K1c1vdZX2Sm2ZnUWIttu9nWv855t6z633Juqsh+SrkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1aljGsGjG6EpqGfA5bW9A47ukq0esw8E/NB/wXESf7k=;
 b=YhyIOrH/RGt/ScZXoEGZL5WKEgU18eRug7Egr+fXDXaWaJ5zdur9MbRrkepneQ10ML8gaPVPz/IWq0oKwJZ7DsdUf32nb9AgXz7soJy0Zt/r477v766/67gPjVfCEflVTaL4nMauCoLTYroapANEa7wabMkNClhKDTFRWn4uFSZO8sclrUJwVxyl+HgTkAmlahwkeXxU46INqoS7obEqISeQ0T1GdV2oiD4ogV3mCadoOPuBDwnPxsl0YMYYw+VmCr4uVDJaVn/9EJozPtUCKat+HpMJd63lMfXOMXs4s9eGvLq1eMRsfZtJJMOUBPNeHsO9e+6jICyKUFkrjsoWDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1aljGsGjG6EpqGfA5bW9A47ukq0esw8E/NB/wXESf7k=;
 b=Zz6UKbdvnf9cE0LYMhofMPxRNBhj6r9QZuc0UShoWrZDgDm/Qq/B+aDrukO+mnTs5746bCONZ3GO9YCaYlUUv3PhYYZYW1qK4gaHMbQ8Y7erGymlur07a8JVJqyGhIz/YyST9uG3RLjzhL+lNguLIr6p9/Wya+R+V41j+GG7yJs=
Received: from BN8PR04CA0010.namprd04.prod.outlook.com (2603:10b6:408:70::23)
 by BL0PR12MB4948.namprd12.prod.outlook.com (2603:10b6:208:1cc::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.22; Fri, 11 Mar
 2022 09:52:42 +0000
Received: from BN8NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:70:cafe::58) by BN8PR04CA0010.outlook.office365.com
 (2603:10b6:408:70::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.23 via Frontend
 Transport; Fri, 11 Mar 2022 09:52:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT055.mail.protection.outlook.com (10.13.177.62) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5061.22 via Frontend Transport; Fri, 11 Mar 2022 09:52:42 +0000
Received: from kali.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 11 Mar
 2022 03:52:26 -0600
To: <iommu@lists.linux-foundation.org>, <joro@8bytes.org>
Subject: [RFC PATCH 11/36] iommu/amd: Introduce per PCI segment alias table
 size
Date: Fri, 11 Mar 2022 15:18:29 +0530
Message-ID: <20220311094854.31595-12-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220311094854.31595-1-vasant.hegde@amd.com>
References: <20220311094854.31595-1-vasant.hegde@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1d49b8bc-c704-4593-5a94-08da0344e2b3
X-MS-TrafficTypeDiagnostic: BL0PR12MB4948:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB49482CE7394403FA3811DFBF870C9@BL0PR12MB4948.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8JzxehAjhsJfqCX9C1bphgoRbUm+5toO3hnsbpaGNQ5xlWUoJfJTecqSilTlplsQ0w+M5Jd2saLfucR+edxCLvQ642RIW7OGZyLq2aRbqemrdnaqReWEwOFz57nutCoIcr36yhmeGbQOSlfdi6nlHHQCsa0dIMNo5MmLEUMcSlZLChcxS64u0AuU9eP6sapDQ0793YcmsdY1fcyJNdDfUUAgQneE3KYRgmCvxJfaZ9W6mlZAmK/rdUDMx+9fp6WLhSDrYaLjDQlhaZmR0ynRLUrAhSXer9Koz69KhHL/e6HShPP3Oqf74cdCb19dr0Gcw9ZEL9aURS7vL/iOtHtZf4XvK4ua2fyXUr+o0SPdeAWq/TubKf85ggwQnsDu66pI1beYGpt+oJpRT299e5+1Ca5UtwgfEXYIirT52k4C2rUsa4w0Py8XSY1/jtXz8LJtaaxKwftu6oBZNJwtr1FGGcdNXinXOMokKB0yT0Z/k4b96SzlB3j6X/qqCrp9/aOQb3xkY/S3xIX+9fTtZLqz5YzXZXEVa6ZU9r0JXJsTy+yX9/VLpSYyrct4HKsTLRew9sPq1gfMj2242TLJhejehaP3G/JIdn1EbOdCJCDRpAb5/NIGDo6rS+jbhS0vka0RAZj4iOku0E5QpstzV01Gq8qytGy8jnfS7lcIHLU8gUrraynr2nr2OWAEJ10qQt7g3ANAm51Dqz8qBzZH4jzLBg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(356005)(40460700003)(83380400001)(426003)(336012)(81166007)(8936002)(5660300002)(44832011)(2906002)(2616005)(36756003)(70206006)(70586007)(82310400004)(47076005)(508600001)(1076003)(16526019)(26005)(186003)(54906003)(110136005)(4326008)(86362001)(8676002)(316002)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2022 09:52:42.1629 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d49b8bc-c704-4593-5a94-08da0344e2b3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4948
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

It will replace global "alias_table_size" variable.

Co-developed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h | 3 +++
 drivers/iommu/amd/init.c            | 5 +++--
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index b5b0c23eacf2..e6ee376b6280 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -550,6 +550,9 @@ struct amd_iommu_pci_seg {
 	/* Size of the device table */
 	u32 dev_table_size;
 
+	/* Size of the alias table */
+	u32 alias_table_size;
+
 	/*
 	 * device table virtual address
 	 *
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index f8da686182b5..d4e4f49066f8 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -711,7 +711,7 @@ static int __init alloc_alias_table(struct amd_iommu_pci_seg *pci_seg)
 	int i;
 
 	pci_seg->alias_table = (void *)__get_free_pages(GFP_KERNEL,
-						    get_order(alias_table_size));
+					get_order(pci_seg->alias_table_size));
 	if (!pci_seg->alias_table)
 		return -ENOMEM;
 
@@ -727,7 +727,7 @@ static int __init alloc_alias_table(struct amd_iommu_pci_seg *pci_seg)
 static void __init free_alias_table(struct amd_iommu_pci_seg *pci_seg)
 {
 	free_pages((unsigned long)pci_seg->alias_table,
-		   get_order(alias_table_size));
+		   get_order(pci_seg->alias_table_size));
 	pci_seg->alias_table = NULL;
 }
 
@@ -1582,6 +1582,7 @@ static struct amd_iommu_pci_seg *__init alloc_pci_segment(u16 id,
 	pci_seg->last_bdf = last_bdf;
 	DUMP_printk("PCI segment : 0x%0x, last bdf : 0x%04x\n", id, last_bdf);
 	pci_seg->dev_table_size     = tbl_size(DEV_TABLE_ENTRY_SIZE);
+	pci_seg->alias_table_size   = tbl_size(ALIAS_TABLE_ENTRY_SIZE);
 
 	pci_seg->id = id;
 	init_llist_head(&pci_seg->dev_data_list);
-- 
2.27.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
