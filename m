Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28C52C433EF
	for <iommu@archiver.kernel.org>; Mon,  4 Apr 2022 10:07:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C26EC4093E;
	Mon,  4 Apr 2022 10:07:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wyNn4BHstW1f; Mon,  4 Apr 2022 10:07:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 5DDFF4091C;
	Mon,  4 Apr 2022 10:07:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 309CBC002C;
	Mon,  4 Apr 2022 10:07:56 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DF227C0012
 for <iommu@lists.linux-foundation.org>; Mon,  4 Apr 2022 10:07:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BD7B54093E
 for <iommu@lists.linux-foundation.org>; Mon,  4 Apr 2022 10:07:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tWV_Q_ab0sPw for <iommu@lists.linux-foundation.org>;
 Mon,  4 Apr 2022 10:07:53 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2060e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::60e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 780664091C
 for <iommu@lists.linux-foundation.org>; Mon,  4 Apr 2022 10:07:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=llIV7/m7ejhC5FLgjlEiKDm53xQ4xAdMRo2JCDGQwP5GXPawb4+B+44Khb9oI+dIdNu68FlcN+dXQP3P+CQRsN+KWv1Ma+z/EnlaFWYhvWt0fXcM2aC5e6EmOrGmbPoy1z9YwaWT/LrUw0qcVil6uI7MVfUk8Qupb4CSEoHjr7CY6oIE9j/O1XNnmFI8AfKa8614F81GgtmfzNbaPwcLkS7jmPt1o+aeg1jWCOOMCort3tX8Oa3JawEeJkXmxvnfoZCm5RebfUCV1ivukyaITewO//ZhCjhYp/u09nEjYIMfK7V8eQuasqVT40Nsgzfx2bWrEZGsWD97nmFpV5YFJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s03REyaBCqrYQbt6EENCM2+ZOM9KGRhd09WwDPk8h+M=;
 b=EvaEr+1N4IJq91b0XBL8Q/R3k8yMzfYIlhq44JHJzxsqSpTEB+keqXUU6rMDvxmlTHinb1q2z/gipWRnPXkfZt7/Bxq0tRiIC2ykFNsLYyqvwFZISFcXAQQ3iPIowDeMf2Ot3VkCMfh+9rGlBWzthUXoJscLTia1o2JBvIJKgcXiGRNeRupDyI5DU6RwWqvB9biWsCSpSdty7vjhr8uME6FVgNBXKQRDv8rjV0n1QExPi8zUl2keEf+Ru0YhmrxIqOBo8SnXnjj152rkp/Ha05ocZA1BFQy0zlDx8kstk7KyjauYet6tdHRJbesLFXi/SjsocR2aLBo1B5aqeV3JeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s03REyaBCqrYQbt6EENCM2+ZOM9KGRhd09WwDPk8h+M=;
 b=n9yEZPnnodVJoGWqiTDI0h+KM1CoROpAzm8A1aNndbP4pJD7SHpHxABk4lVypt78Tv2xD8jgQ7cly58lkHoUTiNYOrYGGVoRAIaN2X1oengtSXJXupxvJfTOyWIK2Z/4MRxb8s+QErtkTZPsl1R+HiYqBTuhUQwOo67ssUKxpq4=
Received: from MW4PR03CA0337.namprd03.prod.outlook.com (2603:10b6:303:dc::12)
 by DM6PR12MB3194.namprd12.prod.outlook.com (2603:10b6:5:184::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Mon, 4 Apr
 2022 10:07:51 +0000
Received: from CO1NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:dc:cafe::4c) by MW4PR03CA0337.outlook.office365.com
 (2603:10b6:303:dc::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31 via Frontend
 Transport; Mon, 4 Apr 2022 10:07:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT034.mail.protection.outlook.com (10.13.174.248) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5123.19 via Frontend Transport; Mon, 4 Apr 2022 10:07:50 +0000
Received: from kali.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 4 Apr
 2022 05:07:47 -0500
To: <iommu@lists.linux-foundation.org>, <joro@8bytes.org>
Subject: [RESEND PATCH v1 28/37] iommu/amd: Remove global amd_iommu_alias_table
Date: Mon, 4 Apr 2022 15:30:14 +0530
Message-ID: <20220404100023.324645-29-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220404100023.324645-1-vasant.hegde@amd.com>
References: <20220404100023.324645-1-vasant.hegde@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e18ad737-a565-424a-260a-08da1622f9fb
X-MS-TrafficTypeDiagnostic: DM6PR12MB3194:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB319429E6DD4A436389B0CF6287E59@DM6PR12MB3194.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: khky2GEHrRJ0SqQUrFXmSF+qgeMsdELH7X2tW/hAfgBL/pwYqD6yb94VohLC06liphzSHyz6Uk+Is33GEiVLqO8hbU6RlcS2OZ3vRltSBWE27WHnTzh+coKe2aY+eRp6lsJi71R7va6/51CP8gmkukw8e8c72jjTayWSltwLtpEXoG+JxlTljK86eYI85SH+KAsNipWO1B4ni9P7EFErpW9Fak6g0XLMvxZGZaiAyD0dxUw/oHskTSpg4NCrfkHN+KRUXUC8M85tF4dyvzkarCmVPcyVZhfSIiaTD6QVegPJDIyolcHrCL8RArAYQm9Z9HbtLb3VbOpaRFeYwOMxRapUSyy/iVwOrPApFSlEyaaaE95XrNqbqrHrCn2LPOKFpcrgS89HfqmwaRXWqinPvVJdslLaZoT1sqLjZXTpe4d3Qjv7jKB92AX4FJbGzCVS8GG4VOHpzq7hsUR6x2vrn2uHJaT1neqTKn+BqN8pr9oitX1V8CF32an8YnzIZKlBt3kFrpDczA2wtCDKHJ9a/QoUJb9z2/TGLfNLULnsxN5anJ1RWUeVMpx3rlcnm1Wwdv7w+aRstMJMVvkclOVbRElx//x4M+gojQRGLLdS/M2thUjlRf2WbN5pnVc2c70VK4cxjUJHrmmJ3wr+KT73stxvj6Ia4EI5QisJgeZVmUWwuWXk1HQLBCRXqaiKumTJU0wF3L2J7Xw7v+tlCAStNw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(508600001)(36756003)(426003)(47076005)(356005)(54906003)(5660300002)(316002)(1076003)(36860700001)(16526019)(336012)(86362001)(70206006)(44832011)(40460700003)(6666004)(8676002)(4326008)(26005)(70586007)(110136005)(8936002)(2906002)(2616005)(82310400004)(83380400001)(186003)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2022 10:07:50.3000 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e18ad737-a565-424a-260a-08da1622f9fb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3194
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
index dc76ee2c3ea5..0aa170014b85 100644
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
