Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3425C433FE
	for <iommu@archiver.kernel.org>; Wed, 11 May 2022 07:24:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A755B404F0;
	Wed, 11 May 2022 07:24:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LKTYoM3qeuxu; Wed, 11 May 2022 07:24:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 556F04056F;
	Wed, 11 May 2022 07:24:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2B3D1C0039;
	Wed, 11 May 2022 07:24:53 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 111D1C002D
 for <iommu@lists.linux-foundation.org>; Wed, 11 May 2022 07:24:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E3A7683224
 for <iommu@lists.linux-foundation.org>; Wed, 11 May 2022 07:24:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JNabdxYTxbt6 for <iommu@lists.linux-foundation.org>;
 Wed, 11 May 2022 07:24:51 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2062b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::62b])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0E1DC81836
 for <iommu@lists.linux-foundation.org>; Wed, 11 May 2022 07:24:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=la77oBJUYhhzltKN9HLQ/0NOEVyb2wskO/AwjzN+YIsi52T2seIw/pyhZ678XXlr1YNmM58VzLVBOX703JSdoJBkjt/vn+qjpEvJ4+UsOGfpcjaEewrzvsH0Szj9h4BI8/haPBWEQ+E+HjfNPZkTvsQ9Fg/n4X72BU+YAwSoPUNTZ3BIoYJmodsEe0CG+ERis2sW0E/apHu+0doQ7LeoJlQtS7WRMDOvB08gQmRS4mH7iCYFeJ9WlQfhyqwF1413QddtQgrphPWaw9DI6mAWk/shvt+IRdkYMFEeqGd39mJyRhn/fKWsXE8CRNs/RKcU1wBmajyu3DtUO4fzAW3j8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QT+V4IrcMoTecwq/+N3dfrL7POHGB/zCmG9NHPNA7Qg=;
 b=BvebQLr/4xRSeK4c8c5CIUFTSKisjS1ACrK3PXIku5CTE5nkjdT8BCLt7d1ihFlKH2/J72UQ9V50v2jBYdKgvcFLksRbMSQcwndMt30qVdhmiokDulaypmueAk4YzhF1DF4+3n/69BulNggWLBtlSXWVmkL0Gh19ucL6oAa5wI0/A9teEOc4WndKLg/HGuZDraha4idwIfHsazz9T9Tx9pdADeZ1oRUn8LxLISy7p+4I4MOkJzAVhOJl4cbt6ELR2Npc4NLri1tJ/pgwluZA38oOKEAi5K5P5HTO9Zn3MWfPuKa3H4qYPIrmaPo+TU3UnYTZY8SfaEitCK2oamCdVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QT+V4IrcMoTecwq/+N3dfrL7POHGB/zCmG9NHPNA7Qg=;
 b=Nm92+8rl77WarnX0LSBlp4kO4qBern4hgFUSB+rfI12oLKazUiMJeXOwVMTxypdKQUymRIvpfWf4WCHc2DZiiBfSV8iZ1RVjPk7Vf7u2KjZiYtCSLxnbsAQnMCVunbfkTea/53jcjP/BJutmnn4CYzzhJefGV6u4kuNbfxbmB/4=
Received: from DM5PR21CA0009.namprd21.prod.outlook.com (2603:10b6:3:ac::19) by
 CY4PR12MB1493.namprd12.prod.outlook.com (2603:10b6:910:11::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5227.20; Wed, 11 May 2022 07:24:46 +0000
Received: from DM6NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:ac:cafe::2f) by DM5PR21CA0009.outlook.office365.com
 (2603:10b6:3:ac::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.4 via Frontend
 Transport; Wed, 11 May 2022 07:24:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT016.mail.protection.outlook.com (10.13.173.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5250.13 via Frontend Transport; Wed, 11 May 2022 07:24:45 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 11 May
 2022 02:24:43 -0500
To: <iommu@lists.linux-foundation.org>
Subject: [PATCH v3 10/35] iommu/amd: Introduce per PCI segment last_bdf
Date: Wed, 11 May 2022 12:51:16 +0530
Message-ID: <20220511072141.15485-11-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220511072141.15485-1-vasant.hegde@amd.com>
References: <20220511072141.15485-1-vasant.hegde@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2a2967b8-e39d-4f05-b12e-08da331f534b
X-MS-TrafficTypeDiagnostic: CY4PR12MB1493:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB1493DB4111A084E1061A375D87C89@CY4PR12MB1493.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NtLn0xJd7xR04c4BpVg6iUIjqkJWMCPRCcnvNwkpHEkJtXpXpsMnBCjFNpDsg63+5HckJkqtb7qVkdcfU3rbAqxq65JDOgYW6p8i63i9prA8K2j+E9BcBc1tkAVv5uSCQcKAXma9ptxixFZbXcWqaPiYrl0koakFzrjtE1HnHG/7i73cTyE/hb74vDPxV2eIEhcfgCVPVFaCReUHd1xdps5hTI2sDH3lEBJb8m2383QbmEW3t5L5XbkEHfou1tmplDC/Wour9wdJ3v7HHEDkiYLZHxJ0YBD77jOksihPIE7O9IpGNN92wClsMa/2yGwOvt9ftPbVnz1MxzMmNLPKbisuB5kTBiav13EIkdD52cu1TyIEaujycjp5UnRaCGKm7Z7rJ3nSzNp80Z8Z93UCYRRq9bE2OWHLnZtdQ5d7pCIR6fwBHlsQhM7+HxqMZmlLgH+HUN1Mtc51jCAgt+xpvnHEwSmduib+f/r1TH5deB8dhLWtBTrVXY57nNnEEKLPVSMpoAmR2WgyBWfmFKqI+M4OE/Oy2nZF483HAtQrR56bCGq5yzMTu0QCqpt46DkesnuI77s9UYc62LrwRcEzMR4YZKzPKGiiDie6fG7mMyn10ylTYW7Yg6tRPNKFhR+nMf/ep9irR/pSutLkl/YKscU6zVmamv9PmsTJKF+Ot5i3fl2sYeRQkzOK/kqwt2KVWr9qMhjEO5jLF48t8aeLaQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(36860700001)(426003)(47076005)(336012)(40460700003)(5660300002)(83380400001)(82310400005)(186003)(2906002)(44832011)(16526019)(36756003)(4326008)(316002)(1076003)(2616005)(8676002)(86362001)(70586007)(8936002)(70206006)(6916009)(54906003)(7696005)(81166007)(26005)(508600001)(6666004)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2022 07:24:45.9881 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a2967b8-e39d-4f05-b12e-08da331f534b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1493
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

Current code uses global "amd_iommu_last_bdf" to track the last bdf
supported by the system. This value is used for various memory
allocation, device data flushing, etc.

Introduce per PCI segment last_bdf which will be used to track last bdf
supported by the given PCI segment and use this value for all per
segment memory allocations. Eventually it will replace global
"amd_iommu_last_bdf".

Co-developed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h |  3 ++
 drivers/iommu/amd/init.c            | 69 ++++++++++++++++++-----------
 2 files changed, 45 insertions(+), 27 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 574f4f414f7d..8b8079fdf0d4 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -548,6 +548,9 @@ struct amd_iommu_pci_seg {
 	/* PCI segment number */
 	u16 id;
 
+	/* Largest PCI device id we expect translation requests for */
+	u16 last_bdf;
+
 	/*
 	 * device table virtual address
 	 *
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 5cb21d43bd6f..67a92f453731 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -550,6 +550,7 @@ static int __init find_last_devid_from_ivhd(struct ivhd_header *h)
 {
 	u8 *p = (void *)h, *end = (void *)h;
 	struct ivhd_entry *dev;
+	int last_devid = -EINVAL;
 
 	u32 ivhd_size = get_ivhd_header_size(h);
 
@@ -567,13 +568,15 @@ static int __init find_last_devid_from_ivhd(struct ivhd_header *h)
 		case IVHD_DEV_ALL:
 			/* Use maximum BDF value for DEV_ALL */
 			update_last_devid(0xffff);
-			break;
+			return 0xffff;
 		case IVHD_DEV_SELECT:
 		case IVHD_DEV_RANGE_END:
 		case IVHD_DEV_ALIAS:
 		case IVHD_DEV_EXT_SELECT:
 			/* all the above subfield types refer to device ids */
 			update_last_devid(dev->devid);
+			if (dev->devid > last_devid)
+				last_devid = dev->devid;
 			break;
 		default:
 			break;
@@ -583,7 +586,7 @@ static int __init find_last_devid_from_ivhd(struct ivhd_header *h)
 
 	WARN_ON(p != end);
 
-	return 0;
+	return last_devid;
 }
 
 static int __init check_ivrs_checksum(struct acpi_table_header *table)
@@ -607,27 +610,31 @@ static int __init check_ivrs_checksum(struct acpi_table_header *table)
  * id which we need to handle. This is the first of three functions which parse
  * the ACPI table. So we check the checksum here.
  */
-static int __init find_last_devid_acpi(struct acpi_table_header *table)
+static int __init find_last_devid_acpi(struct acpi_table_header *table, u16 pci_seg)
 {
 	u8 *p = (u8 *)table, *end = (u8 *)table;
 	struct ivhd_header *h;
+	int last_devid, last_bdf = 0;
 
 	p += IVRS_HEADER_LENGTH;
 
 	end += table->length;
 	while (p < end) {
 		h = (struct ivhd_header *)p;
-		if (h->type == amd_iommu_target_ivhd_type) {
-			int ret = find_last_devid_from_ivhd(h);
-
-			if (ret)
-				return ret;
+		if (h->pci_seg == pci_seg &&
+		    h->type == amd_iommu_target_ivhd_type) {
+			last_devid = find_last_devid_from_ivhd(h);
+
+			if (last_devid < 0)
+				return -EINVAL;
+			if (last_devid > last_bdf)
+				last_bdf = last_devid;
 		}
 		p += h->length;
 	}
 	WARN_ON(p != end);
 
-	return 0;
+	return last_bdf;
 }
 
 /****************************************************************************
@@ -1551,14 +1558,28 @@ static int __init init_iommu_from_acpi(struct amd_iommu *iommu,
 }
 
 /* Allocate PCI segment data structure */
-static struct amd_iommu_pci_seg *__init alloc_pci_segment(u16 id)
+static struct amd_iommu_pci_seg *__init alloc_pci_segment(u16 id,
+					  struct acpi_table_header *ivrs_base)
 {
 	struct amd_iommu_pci_seg *pci_seg;
+	int last_bdf;
+
+	/*
+	 * First parse ACPI tables to find the largest Bus/Dev/Func we need to
+	 * handle in this PCI segment. Upon this information the shared data
+	 * structures for the PCI segments in the system will be allocated.
+	 */
+	last_bdf = find_last_devid_acpi(ivrs_base, id);
+	if (last_bdf < 0)
+		return NULL;
 
 	pci_seg = kzalloc(sizeof(struct amd_iommu_pci_seg), GFP_KERNEL);
 	if (pci_seg == NULL)
 		return NULL;
 
+	pci_seg->last_bdf = last_bdf;
+	DUMP_printk("PCI segment : 0x%0x, last bdf : 0x%04x\n", id, last_bdf);
+
 	pci_seg->id = id;
 	init_llist_head(&pci_seg->dev_data_list);
 	INIT_LIST_HEAD(&pci_seg->unity_map);
@@ -1574,7 +1595,8 @@ static struct amd_iommu_pci_seg *__init alloc_pci_segment(u16 id)
 	return pci_seg;
 }
 
-static struct amd_iommu_pci_seg *__init get_pci_segment(u16 id)
+static struct amd_iommu_pci_seg *__init get_pci_segment(u16 id,
+					struct acpi_table_header *ivrs_base)
 {
 	struct amd_iommu_pci_seg *pci_seg;
 
@@ -1583,7 +1605,7 @@ static struct amd_iommu_pci_seg *__init get_pci_segment(u16 id)
 			return pci_seg;
 	}
 
-	return alloc_pci_segment(id);
+	return alloc_pci_segment(id, ivrs_base);
 }
 
 static void __init free_pci_segments(void)
@@ -1684,12 +1706,13 @@ static void amd_iommu_ats_write_check_workaround(struct amd_iommu *iommu)
  * together and also allocates the command buffer and programs the
  * hardware. It does NOT enable the IOMMU. This is done afterwards.
  */
-static int __init init_iommu_one(struct amd_iommu *iommu, struct ivhd_header *h)
+static int __init init_iommu_one(struct amd_iommu *iommu, struct ivhd_header *h,
+				 struct acpi_table_header *ivrs_base)
 {
 	struct amd_iommu_pci_seg *pci_seg;
 	int ret;
 
-	pci_seg = get_pci_segment(h->pci_seg);
+	pci_seg = get_pci_segment(h->pci_seg, ivrs_base);
 	if (pci_seg == NULL)
 		return -ENOMEM;
 	iommu->pci_seg = pci_seg;
@@ -1864,7 +1887,7 @@ static int __init init_iommu_all(struct acpi_table_header *table)
 			if (iommu == NULL)
 				return -ENOMEM;
 
-			ret = init_iommu_one(iommu, h);
+			ret = init_iommu_one(iommu, h, table);
 			if (ret)
 				return ret;
 		}
@@ -2408,13 +2431,14 @@ static void __init free_unity_maps(void)
 }
 
 /* called for unity map ACPI definition */
-static int __init init_unity_map_range(struct ivmd_header *m)
+static int __init init_unity_map_range(struct ivmd_header *m,
+				       struct acpi_table_header *ivrs_base)
 {
 	struct unity_map_entry *e = NULL;
 	struct amd_iommu_pci_seg *pci_seg;
 	char *s;
 
-	pci_seg = get_pci_segment(m->pci_seg);
+	pci_seg = get_pci_segment(m->pci_seg, ivrs_base);
 	if (pci_seg == NULL)
 		return -ENOMEM;
 
@@ -2481,7 +2505,7 @@ static int __init init_memory_definitions(struct acpi_table_header *table)
 	while (p < end) {
 		m = (struct ivmd_header *)p;
 		if (m->flags & (IVMD_FLAG_UNITY_MAP | IVMD_FLAG_EXCL_RANGE))
-			init_unity_map_range(m);
+			init_unity_map_range(m, table);
 
 		p += m->length;
 	}
@@ -2905,15 +2929,6 @@ static int __init early_amd_iommu_init(void)
 	amd_iommu_target_ivhd_type = get_highest_supported_ivhd_type(ivrs_base);
 	DUMP_printk("Using IVHD type %#x\n", amd_iommu_target_ivhd_type);
 
-	/*
-	 * First parse ACPI tables to find the largest Bus/Dev/Func
-	 * we need to handle. Upon this information the shared data
-	 * structures for the IOMMUs in the system will be allocated
-	 */
-	ret = find_last_devid_acpi(ivrs_base);
-	if (ret)
-		goto out;
-
 	dev_table_size     = tbl_size(DEV_TABLE_ENTRY_SIZE);
 	alias_table_size   = tbl_size(ALIAS_TABLE_ENTRY_SIZE);
 	rlookup_table_size = tbl_size(RLOOKUP_TABLE_ENTRY_SIZE);
-- 
2.27.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
