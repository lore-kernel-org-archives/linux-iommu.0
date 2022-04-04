Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30B69C433EF
	for <iommu@archiver.kernel.org>; Mon,  4 Apr 2022 09:44:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E11A160A80;
	Mon,  4 Apr 2022 09:44:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2DRLB155gW7j; Mon,  4 Apr 2022 09:44:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id C0EA260C34;
	Mon,  4 Apr 2022 09:44:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9D1C3C002C;
	Mon,  4 Apr 2022 09:44:38 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5384EC0012
 for <iommu@lists.linux-foundation.org>; Mon,  4 Apr 2022 09:44:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 33E6140183
 for <iommu@lists.linux-foundation.org>; Mon,  4 Apr 2022 09:44:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vla4D8vfiB-6 for <iommu@lists.linux-foundation.org>;
 Mon,  4 Apr 2022 09:44:36 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2062f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::62f])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6AE034002B
 for <iommu@lists.linux-foundation.org>; Mon,  4 Apr 2022 09:44:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CYMfLSI45lQiguGVJ9V7fMQ26HorNmCxpg4La+2joJ7Uy56+Nh0xJCE34FFqUbQEtCRcUoVYst4pJgHF1SQo1oeoV9sW5AsHJW8v5HN0Is/24+eWvAsba++Stzq9CEMfpoISMyoZMgaQDAYo9OuuR1jKpjJqk6sXehr2kxGYXS+yWGzK/XG4pdgqWGq90+Gv2XvHOrZDhO3A3Y0Q1SlCZ3HHm4oyJ4X/J2fpUYzVZGuzAXkfvX1b9PHyAhMmJpCI20xFYZ6HzE20DbrANKAeU1/EnmiLnUwRwAcfLnRHcReXtfrbChqwa0x3Cr7XGqyStV6HMfXgcmM19i5uSQDCiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ENeM+WnXDJxgRdfWaCLlOwHbvng5w8EgcYiNIE25bcg=;
 b=b0BNN+ezQL/pSP4waYrgXWnvQTRUNR+vmgThso2VlLSrjSiFyFvayBhf0glJte+jDpjgJ7dMp/aFNpEJwcAXXLi6+o2t8qXTS+uRR35/efEbfCBZGFbM53za0oSCYMfFFmE49NKA00Rub3Gp/Ah7MAJOcgYcBvaJkfLP7+5ue6MzOZ6jGGWw7i2igL3b4DmCJsDknuJqAV+G4kb0APnlSdKTVSDXdQZi/txiogvW3XyQajIxDyE+iAvZ2H4Z8I3j7WAGCHwkQU6JUfFJadjyENgE2Kqh0eCoVFYFKHRSh8h0GEVelaJVrGsJpGmQ6ZUfERBQTBEmWW1bvMCsLwQLyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ENeM+WnXDJxgRdfWaCLlOwHbvng5w8EgcYiNIE25bcg=;
 b=3c1nOD7tWFqWx/90L2he3d2bPuabLOE80G90mZtH+qeoEHtH4VRdW1Siog4YzYTSW35+7I3YMiIz91sTMZZh0BF/AgtJfoRiQM8+3O4Y1nsl2Dd5rLDeN5UD0Js/Pr7WMNV1qv/uSKPVIIqhG/gzt9zcNyJzb17xlNXLUgY+Z18=
Received: from MW2PR2101CA0013.namprd21.prod.outlook.com (2603:10b6:302:1::26)
 by DM6PR12MB3898.namprd12.prod.outlook.com (2603:10b6:5:1c6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Mon, 4 Apr
 2022 09:44:33 +0000
Received: from CO1NAM11FT035.eop-nam11.prod.protection.outlook.com
 (2603:10b6:302:1:cafe::32) by MW2PR2101CA0013.outlook.office365.com
 (2603:10b6:302:1::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.4 via Frontend
 Transport; Mon, 4 Apr 2022 09:44:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT035.mail.protection.outlook.com (10.13.175.36) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5123.19 via Frontend Transport; Mon, 4 Apr 2022 09:44:32 +0000
Received: from kali.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 4 Apr
 2022 04:44:30 -0500
To: <iommu@lists.linux-foundation.org>, <joro@8bytes.org>
Subject: [PATCH v1 05/37] iommu/amd: Introduce per PCI segment irq_lookup_table
Date: Mon, 4 Apr 2022 15:10:57 +0530
Message-ID: <20220404094129.323642-6-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220404094129.323642-1-vasant.hegde@amd.com>
References: <20220404094129.323642-1-vasant.hegde@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a451bb5b-0672-4252-fd72-08da161fb902
X-MS-TrafficTypeDiagnostic: DM6PR12MB3898:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB3898946C47CAD20ECBCED55887E59@DM6PR12MB3898.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hSqg0XAoK4I/YKcvhGYWwPpO0nYy+7AUCXoksuznIhQtc8QDrfTQqkByNRrnkEpved8+2xqD8e7+JvdEYE/6XAVfdrCzncLWuhueXClOOeQo8WnWe1SbGXqiGjgRxf7Mq9/wQU0WmgF66YlhZMH0rV5YuXQph2SYwyztvi6tZp6IaHh2Ns4Lo4+xO5wnakrqDFWgbkhGZn/Ca6D9GQUfohYgMnXgOzUPUeXGZn/dxtxHpxDlumxyeEqdtiUahuMV4B5QfAr8NYRIAWdj5Ht21ao3dsREB555Lfe6kkoVvFiWFnTW+/ft+5DwawTuLAFV8WwQEAxcHdFl3dPvAdOEOT9olusDW20557UnSQK0/0H4kT9ir01RAa2xFUjS6NmVoO5e+OXjfZrSyudeYcDOCkwRvAyNGH/WnJXFVaruC4VLpwFY0QfJAk/fv0FlbmWblV9iYR7IpN+gOXNGju+c0aHAjTEAsWfLjmtZEGItaig5SUyQaZ2xpZWrzrwLORbC5TmviyQmmab6ucMEuxdsT/1drh8x3Wa+20NDhheHAVaalA3N9QxNzAmV+wHUJWSYfcWA8+G/REpmbJ0VjK+/qinInAWM9DRYkTiJ08tOxf+RcJniQ7gmWRdPYQBgRtGM4s1apfxTkKbiog7TbsSFSTQqImiRVZhVT/QksX2mnsB6jYxBb763OQfxEaF/XE7gpQGzv+M537WTmPFgl2hMvg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(44832011)(8936002)(40460700003)(356005)(508600001)(36756003)(54906003)(6666004)(5660300002)(81166007)(2906002)(110136005)(316002)(8676002)(70586007)(70206006)(86362001)(83380400001)(47076005)(36860700001)(16526019)(26005)(4326008)(336012)(186003)(82310400004)(2616005)(1076003)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2022 09:44:32.8249 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a451bb5b-0672-4252-fd72-08da161fb902
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT035.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3898
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

This will replace global irq lookup table (irq_lookup_table).

Co-developed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h |  6 ++++++
 drivers/iommu/amd/init.c            | 27 +++++++++++++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 9c008662be1b..d507c96598a7 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -557,6 +557,12 @@ struct amd_iommu_pci_seg {
 	 * device id.
 	 */
 	struct amd_iommu **rlookup_table;
+
+	/*
+	 * This table is used to find the irq remapping table for a given
+	 * device id quickly.
+	 */
+	struct irq_remap_table **irq_lookup_table;
 };
 
 /*
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index a2efc02ba80a..48db6c3164aa 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -682,6 +682,26 @@ static inline void free_rlookup_table(struct amd_iommu_pci_seg *pci_seg)
 	pci_seg->rlookup_table = NULL;
 }
 
+static inline int __init alloc_irq_lookup_table(struct amd_iommu_pci_seg *pci_seg)
+{
+	pci_seg->irq_lookup_table = (void *)__get_free_pages(
+					     GFP_KERNEL | __GFP_ZERO,
+					     get_order(rlookup_table_size));
+	kmemleak_alloc(pci_seg->irq_lookup_table,
+		       rlookup_table_size, 1, GFP_KERNEL);
+	if (pci_seg->irq_lookup_table == NULL)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static inline void free_irq_lookup_table(struct amd_iommu_pci_seg *pci_seg)
+{
+	kmemleak_free(pci_seg->irq_lookup_table);
+	free_pages((unsigned long)pci_seg->irq_lookup_table,
+		   get_order(rlookup_table_size));
+	pci_seg->irq_lookup_table = NULL;
+}
 
 /*
  * Allocates the command buffer. This buffer is per AMD IOMMU. We can
@@ -1533,6 +1553,7 @@ static void __init free_pci_segment(void)
 
 	for_each_pci_segment_safe(pci_seg, next) {
 		list_del(&pci_seg->list);
+		free_irq_lookup_table(pci_seg);
 		free_rlookup_table(pci_seg);
 		free_dev_table(pci_seg);
 		kfree(pci_seg);
@@ -2896,6 +2917,7 @@ static int __init early_amd_iommu_init(void)
 		amd_iommu_irq_remap = check_ioapic_information();
 
 	if (amd_iommu_irq_remap) {
+		struct amd_iommu_pci_seg *pci_seg;
 		/*
 		 * Interrupt remapping enabled, create kmem_cache for the
 		 * remapping tables.
@@ -2912,6 +2934,11 @@ static int __init early_amd_iommu_init(void)
 		if (!amd_iommu_irq_cache)
 			goto out;
 
+		for_each_pci_segment(pci_seg) {
+			if (alloc_irq_lookup_table(pci_seg))
+				goto out;
+		}
+
 		irq_lookup_table = (void *)__get_free_pages(
 				GFP_KERNEL | __GFP_ZERO,
 				get_order(rlookup_table_size));
-- 
2.27.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
