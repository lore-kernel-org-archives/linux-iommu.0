Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FE04C433F5
	for <iommu@archiver.kernel.org>; Mon, 25 Apr 2022 11:39:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 35FA540598;
	Mon, 25 Apr 2022 11:39:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id w-dZ6NmcMk5G; Mon, 25 Apr 2022 11:39:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id A78C4400CE;
	Mon, 25 Apr 2022 11:39:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 832EDC0039;
	Mon, 25 Apr 2022 11:39:36 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 30927C002D
 for <iommu@lists.linux-foundation.org>; Mon, 25 Apr 2022 11:39:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2D42260BEF
 for <iommu@lists.linux-foundation.org>; Mon, 25 Apr 2022 11:39:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AA-qONjvxJhD for <iommu@lists.linux-foundation.org>;
 Mon, 25 Apr 2022 11:39:35 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2061d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::61d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2EAC260B2C
 for <iommu@lists.linux-foundation.org>; Mon, 25 Apr 2022 11:39:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WkrVzx0oHCNdV3dZFNu3DUDEL9gWdI1pumLuxyqpNSZixc7dZWfvA28hMeGKmDdJWzR24lptRGtgYRb44Br9BdQVDFilupSBJERQC95epoJdwNEKHk+p9OgF/pHecpPqJ9bN9RjZJl1XdzcI4AfsORN32P9HvaHOZT52zzLhJmPQE57JAXA+t7Kgv7WRsJZ2Z8Pt2ao5aOTsBrMcC4XlWxKRGntGRBnaik6qq2uFvrX3SwgDbK5lCip57fNJiVu7ch99b5mDPnSmTugKx95IaYlBc8QSE1mwerN5ydyrjIOG0RysOKjaF2kRYYVaatTwq2ditBUQbGSx97hl3OkOlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wlOQBRo+fxZavO/5lKkM0NhINpoG1t7sqAPbQtyvnJU=;
 b=BNvF+Pc3NCesDV3CUfhNUSYKndHi0eb4FENIMJmY0gsb6CTGZjNXxwXrqtRe42G2wi27zNnlvHD9PJmZYS5ezMNyxMobIuGbp3wZ2wkK2aG0juYmUKB1u+JbNskb6K9lLGQ1QL9w6s7fwO+iDR7HSY1R3Zfgd6MbbfvyCs7fkc7cONHlZVZBzipBWRNRMZUPoB0two8fTb9oJSWoFXsND1RpGSGlLNuMsG8qZEBdf2K4FH/VVgLwCYfmQMinbrhd/UFhDnm6ZZow08nmNxCHE4cQ+t4rJ3n+LgldzWOWzibpwAHGmBb87/vS8R14hDbJ7zoRflQWteJANMnXuzQObw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wlOQBRo+fxZavO/5lKkM0NhINpoG1t7sqAPbQtyvnJU=;
 b=DvSYhARk2xcPQuJl4FLs+K1TTk5KO8gkOvik5dWJvdccHi6qxR/6SmJELVyEQZkgbklL96HSfiMplcaWixXaQeyCEgx8jz4TMDdD8ZBBjQZwGeU0pDL8G3V3LYYIYDQzVJoxTiivmXtlXDtj1pupoNCmkcODsU+5YEgpZHUcwRo=
Received: from BN9PR03CA0723.namprd03.prod.outlook.com (2603:10b6:408:110::8)
 by SJ1PR12MB6219.namprd12.prod.outlook.com (2603:10b6:a03:456::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Mon, 25 Apr
 2022 11:39:31 +0000
Received: from BN8NAM11FT045.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:110:cafe::70) by BN9PR03CA0723.outlook.office365.com
 (2603:10b6:408:110::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14 via Frontend
 Transport; Mon, 25 Apr 2022 11:39:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT045.mail.protection.outlook.com (10.13.177.47) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5186.14 via Frontend Transport; Mon, 25 Apr 2022 11:39:31 +0000
Received: from kali.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 25 Apr
 2022 06:39:28 -0500
To: <iommu@lists.linux-foundation.org>
Subject: [PATCH v2 18/37] iommu/amd: Update amd_irte_ops functions
Date: Mon, 25 Apr 2022 17:03:56 +0530
Message-ID: <20220425113415.24087-19-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220425113415.24087-1-vasant.hegde@amd.com>
References: <20220425113415.24087-1-vasant.hegde@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3d8c9afd-e397-4e40-0e2c-08da26b04341
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6219:EE_
X-Microsoft-Antispam-PRVS: <SJ1PR12MB6219388CD16C6E43FF8EE58687F89@SJ1PR12MB6219.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UWesc02bUanlpE46BOutJsORhy1Kg+2Agz409yHt7uAxGf88/S5TXOXBazVtQi9NFNkn/tstXq6mtezFlZ7AlaDUWg73HAJj8PGRaSpnR97xIhAryGZqUCQh0IALoD/iIyoz8DYmVmuP5wd8kQkjqgRZ2oWZaPamos2H/o1plPwCbdwo2rjWOIR48ItqyYJ+1ziKfeGDjn9F5jbWCwcItO3uACEbT2N03v2emDEtwsOpMvUFPm/NMY1hZltWNXVHeufbbotAORpU2SXfmbzI5x4GbAy/X57tzPn5LSv+5VWFZJ8fDeNgdrzLk0F5zGzqvLxzJfrubaEtD68Qp7wiSQpImbePTtuHZqswSOtIJJwm879hFcl6x+MoUYCZWVgWGeqA/YZESALeq3wFYPXnJZTulIB0GhJ36tkfEP5Uqkk85SqRk5/fukMq542QDriq55pS6SmC7zEM+UZzQW2vT7TAZibVkg4vzhXXWp9bqVRH2YCsj8uYgbs0FESz+eDjIT16OUi8gxY8F0eYFQP7owI8gXY1Fi/PnsXrntWn18SSF/GteB4QJgSqRYxLhR+0njg7NZTR09W1HDXDKdSB0N9EwHwJ/L6T1Yrocm4KTUDKwmrPaVmoQBCasRWzxet7TlGxQmatyywxmaLraOONldG5R3NT9X67oUgqZ6CmfkK71mRw3BMMSDKjnXJbOuM9PaaiNo3hy9xU897S2891hA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(316002)(4326008)(508600001)(8676002)(70586007)(81166007)(40460700003)(356005)(86362001)(70206006)(6916009)(54906003)(47076005)(426003)(15650500001)(5660300002)(6666004)(2906002)(336012)(36756003)(83380400001)(82310400005)(44832011)(26005)(186003)(1076003)(2616005)(16526019)(8936002)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2022 11:39:31.0158 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d8c9afd-e397-4e40-0e2c-08da26b04341
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT045.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6219
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

Pass amd_iommu structure as one of the parameter to amd_irte_ops functions
since its needed to activate/deactivate the iommu.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h |  6 ++--
 drivers/iommu/amd/iommu.c           | 51 ++++++++++++-----------------
 2 files changed, 24 insertions(+), 33 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 0ef9ecb8d3fc..990272a470aa 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -999,9 +999,9 @@ struct amd_ir_data {
 
 struct amd_irte_ops {
 	void (*prepare)(void *, u32, bool, u8, u32, int);
-	void (*activate)(void *, u16, u16);
-	void (*deactivate)(void *, u16, u16);
-	void (*set_affinity)(void *, u16, u16, u8, u32);
+	void (*activate)(struct amd_iommu *iommu, void *, u16, u16);
+	void (*deactivate)(struct amd_iommu *iommu, void *, u16, u16);
+	void (*set_affinity)(struct amd_iommu *iommu, void *, u16, u16, u8, u32);
 	void *(*get)(struct irq_remap_table *, int);
 	void (*set_allocated)(struct irq_remap_table *, int);
 	bool (*is_allocated)(struct irq_remap_table *, int);
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index b34d0851866b..ecace06d61cb 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2932,19 +2932,14 @@ static int alloc_irq_index(u16 devid, int count, bool align,
 	return index;
 }
 
-static int modify_irte_ga(u16 devid, int index, struct irte_ga *irte,
-			  struct amd_ir_data *data)
+static int modify_irte_ga(struct amd_iommu *iommu, u16 devid, int index,
+			  struct irte_ga *irte, struct amd_ir_data *data)
 {
 	bool ret;
 	struct irq_remap_table *table;
-	struct amd_iommu *iommu;
 	unsigned long flags;
 	struct irte_ga *entry;
 
-	iommu = amd_iommu_rlookup_table[devid];
-	if (iommu == NULL)
-		return -EINVAL;
-
 	table = get_irq_table(iommu, devid);
 	if (!table)
 		return -ENOMEM;
@@ -2976,16 +2971,12 @@ static int modify_irte_ga(u16 devid, int index, struct irte_ga *irte,
 	return 0;
 }
 
-static int modify_irte(u16 devid, int index, union irte *irte)
+static int modify_irte(struct amd_iommu *iommu,
+		       u16 devid, int index, union irte *irte)
 {
 	struct irq_remap_table *table;
-	struct amd_iommu *iommu;
 	unsigned long flags;
 
-	iommu = amd_iommu_rlookup_table[devid];
-	if (iommu == NULL)
-		return -EINVAL;
-
 	table = get_irq_table(iommu, devid);
 	if (!table)
 		return -ENOMEM;
@@ -3047,49 +3038,49 @@ static void irte_ga_prepare(void *entry,
 	irte->lo.fields_remap.valid       = 1;
 }
 
-static void irte_activate(void *entry, u16 devid, u16 index)
+static void irte_activate(struct amd_iommu *iommu, void *entry, u16 devid, u16 index)
 {
 	union irte *irte = (union irte *) entry;
 
 	irte->fields.valid = 1;
-	modify_irte(devid, index, irte);
+	modify_irte(iommu, devid, index, irte);
 }
 
-static void irte_ga_activate(void *entry, u16 devid, u16 index)
+static void irte_ga_activate(struct amd_iommu *iommu, void *entry, u16 devid, u16 index)
 {
 	struct irte_ga *irte = (struct irte_ga *) entry;
 
 	irte->lo.fields_remap.valid = 1;
-	modify_irte_ga(devid, index, irte, NULL);
+	modify_irte_ga(iommu, devid, index, irte, NULL);
 }
 
-static void irte_deactivate(void *entry, u16 devid, u16 index)
+static void irte_deactivate(struct amd_iommu *iommu, void *entry, u16 devid, u16 index)
 {
 	union irte *irte = (union irte *) entry;
 
 	irte->fields.valid = 0;
-	modify_irte(devid, index, irte);
+	modify_irte(iommu, devid, index, irte);
 }
 
-static void irte_ga_deactivate(void *entry, u16 devid, u16 index)
+static void irte_ga_deactivate(struct amd_iommu *iommu, void *entry, u16 devid, u16 index)
 {
 	struct irte_ga *irte = (struct irte_ga *) entry;
 
 	irte->lo.fields_remap.valid = 0;
-	modify_irte_ga(devid, index, irte, NULL);
+	modify_irte_ga(iommu, devid, index, irte, NULL);
 }
 
-static void irte_set_affinity(void *entry, u16 devid, u16 index,
+static void irte_set_affinity(struct amd_iommu *iommu, void *entry, u16 devid, u16 index,
 			      u8 vector, u32 dest_apicid)
 {
 	union irte *irte = (union irte *) entry;
 
 	irte->fields.vector = vector;
 	irte->fields.destination = dest_apicid;
-	modify_irte(devid, index, irte);
+	modify_irte(iommu, devid, index, irte);
 }
 
-static void irte_ga_set_affinity(void *entry, u16 devid, u16 index,
+static void irte_ga_set_affinity(struct amd_iommu *iommu, void *entry, u16 devid, u16 index,
 				 u8 vector, u32 dest_apicid)
 {
 	struct irte_ga *irte = (struct irte_ga *) entry;
@@ -3100,7 +3091,7 @@ static void irte_ga_set_affinity(void *entry, u16 devid, u16 index,
 					APICID_TO_IRTE_DEST_LO(dest_apicid);
 		irte->hi.fields.destination =
 					APICID_TO_IRTE_DEST_HI(dest_apicid);
-		modify_irte_ga(devid, index, irte, NULL);
+		modify_irte_ga(iommu, devid, index, irte, NULL);
 	}
 }
 
@@ -3389,7 +3380,7 @@ static int irq_remapping_activate(struct irq_domain *domain,
 	if (!iommu)
 		return 0;
 
-	iommu->irte_ops->activate(data->entry, irte_info->devid,
+	iommu->irte_ops->activate(iommu, data->entry, irte_info->devid,
 				  irte_info->index);
 	amd_ir_update_irte(irq_data, iommu, data, irte_info, cfg);
 	return 0;
@@ -3403,7 +3394,7 @@ static void irq_remapping_deactivate(struct irq_domain *domain,
 	struct amd_iommu *iommu = data->iommu;
 
 	if (iommu)
-		iommu->irte_ops->deactivate(data->entry, irte_info->devid,
+		iommu->irte_ops->deactivate(iommu, data->entry, irte_info->devid,
 					    irte_info->index);
 }
 
@@ -3458,7 +3449,7 @@ int amd_iommu_activate_guest_mode(void *data)
 	entry->hi.fields.vector            = ir_data->ga_vector;
 	entry->lo.fields_vapic.ga_tag      = ir_data->ga_tag;
 
-	return modify_irte_ga(ir_data->irq_2_irte.devid,
+	return modify_irte_ga(ir_data->iommu, ir_data->irq_2_irte.devid,
 			      ir_data->irq_2_irte.index, entry, ir_data);
 }
 EXPORT_SYMBOL(amd_iommu_activate_guest_mode);
@@ -3488,7 +3479,7 @@ int amd_iommu_deactivate_guest_mode(void *data)
 	entry->hi.fields.destination =
 				APICID_TO_IRTE_DEST_HI(cfg->dest_apicid);
 
-	return modify_irte_ga(ir_data->irq_2_irte.devid,
+	return modify_irte_ga(ir_data->iommu, ir_data->irq_2_irte.devid,
 			      ir_data->irq_2_irte.index, entry, ir_data);
 }
 EXPORT_SYMBOL(amd_iommu_deactivate_guest_mode);
@@ -3560,7 +3551,7 @@ static void amd_ir_update_irte(struct irq_data *irqd, struct amd_iommu *iommu,
 	 * Atomically updates the IRTE with the new destination, vector
 	 * and flushes the interrupt entry cache.
 	 */
-	iommu->irte_ops->set_affinity(ir_data->entry, irte_info->devid,
+	iommu->irte_ops->set_affinity(iommu, ir_data->entry, irte_info->devid,
 				      irte_info->index, cfg->vector,
 				      cfg->dest_apicid);
 }
-- 
2.27.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
