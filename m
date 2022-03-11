Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C18E0C433F5
	for <iommu@archiver.kernel.org>; Fri, 11 Mar 2022 09:56:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 78BD2842F1;
	Fri, 11 Mar 2022 09:56:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1YFfNOk-ZX-v; Fri, 11 Mar 2022 09:56:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 021AC82980;
	Fri, 11 Mar 2022 09:56:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DE79DC0012;
	Fri, 11 Mar 2022 09:56:49 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B7D66C000B
 for <iommu@lists.linux-foundation.org>; Fri, 11 Mar 2022 09:56:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A3791418F1
 for <iommu@lists.linux-foundation.org>; Fri, 11 Mar 2022 09:56:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Vu6qKe54Iht6 for <iommu@lists.linux-foundation.org>;
 Fri, 11 Mar 2022 09:56:47 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2061d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::61d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9BA99418E6
 for <iommu@lists.linux-foundation.org>; Fri, 11 Mar 2022 09:56:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FS7R7IEha1pv0RbMWeEfo4vr/UP/pH6X0MsDgOM7puCTLf2q+baU6u0h6oHZIsd4BtUq9m7g5J6G5krOUTbRy2OOnNV5NkmKIIOSaRR1R5CpcFF+TOq1qqeHUc6PGHdqhrOtCltlB6QR2mFy6wDr87gPmhx/AwSDiZJj5EZct02lIY+Lansrss69Oo8ZGN/TU4VdkozlAEUXZEfPZ8i0rcZ7sJoI2Y2JxmsdeS2TPrXqlFWn1ieiFfdGvy1qEQyAqni4DnVFRh9u3xIBVEy8Lxl64NtN1sbAoTbuqMkmY2N7teq4iG1hbViRLOGoekozvI96RZFOb6HQuyk9mNHGPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E62iInUKJmZLCrnDFpr3ety/2eZloJhE5bXemzLF0iQ=;
 b=F9aH8iauDZAr+CyAuqPET5KFN2izn1E0VI7JXPZtttTeEp6tnsI2/pqz1wgJfHdjnpcYb/S+LYjSDM8gL4m0UEiAZpREJgCDhTFY6nh7guzT9KIzv4KVU2QPNY/5yX7PdWyT7Eio9RkZtyC25cnnNf07l6lB6S3SAHsrubag5wpytke2kYcpH1eS9t3egAUi5cEtVgPo3eCqTa/gs4UsSw99lNxNhe1XRHUg8MfI9Z76bpRXEyAhW6Nx9DteUzLbvQYgzkHdQ20Z4S8IOPWhKpOAzJigTz88NzbPagjs63svctoh8T1uJoSSTirpyl3XwilpISxpYnwJtGmoj6/Mlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E62iInUKJmZLCrnDFpr3ety/2eZloJhE5bXemzLF0iQ=;
 b=ziP7nFG7mcPOrYSP0LWNyeB9fScSypTXvwSqyhmkK158nWtQVtBHiPT2xZezdVGKqwnEGhLwJq1n3z9CkF+lSj0Rl07cPIB7T4hgWN470XJgamQJU3l01hH6JUwyTn1XMrRO/5ogl3U25fqF3oTw8LwPkA+PIepM+UZK8acKdlo=
Received: from DM3PR14CA0130.namprd14.prod.outlook.com (2603:10b6:0:53::14) by
 MWHPR1201MB0062.namprd12.prod.outlook.com (2603:10b6:301:54::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.22; Fri, 11 Mar
 2022 09:56:44 +0000
Received: from DM6NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:53:cafe::db) by DM3PR14CA0130.outlook.office365.com
 (2603:10b6:0:53::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.22 via Frontend
 Transport; Fri, 11 Mar 2022 09:56:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT027.mail.protection.outlook.com (10.13.172.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5061.22 via Frontend Transport; Fri, 11 Mar 2022 09:56:43 +0000
Received: from kali.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 11 Mar
 2022 03:56:37 -0600
To: <iommu@lists.linux-foundation.org>, <joro@8bytes.org>
Subject: [RFC PATCH 17/36] iommu/amd: Update amd_irte_ops functions
Date: Fri, 11 Mar 2022 15:18:35 +0530
Message-ID: <20220311094854.31595-18-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220311094854.31595-1-vasant.hegde@amd.com>
References: <20220311094854.31595-1-vasant.hegde@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2515374f-c69b-40a0-0ee6-08da034572c4
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0062:EE_
X-Microsoft-Antispam-PRVS: <MWHPR1201MB00628429BCB01B05263088D5870C9@MWHPR1201MB0062.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K3zrhDa/cqP4ZkWTSw35S/Bahy7t1BuGLVj1d2HylAzFEh5lCVJ7Rkltu9q14P+uHGooufgFBRDFKPOB5WrdR7mYmnaiL8T5LKJCxxuviA59c6UelP7UMTB3uHWNsR7C2dnuQYwtTcpSqlzmVY0W9ka3SXwsbY2K84F//FfdJqRjYPowxwylvViZ/j6kvcbVwKP72eCl5s4oK+jqWo0ADTpBuch/8jzbeHsXCV1r9obl9LCrO+R+8DbE/cQLn42LABb76w0ZaYCG6vAvWbWykjlPKToNpfmSea67tWPa0C1F3LszHxBIxPOn3zLqHsAv1DY79AXSKQo7oGkQ33yBwhZXuhIkBhayb0ZCksV6O6W65fXfY+oCatxH5OgidmAjCpoMYus2KjVo5otpwS6ejwx6Rob5VkLV2DLIf3iZmNLDrb7NwQ+JYSsF1ydPVU6kqqvecygv1nu4X6gkt6NgnkO0+DWfchzMspCy3BQJ4w53NxeFGYEWk7xs/OMhnJPWKU+5XiSyNQDDsqK/DzA30r7l9KYmDdvPCXHtxPfNQY+AO9n6Q7zx3rhkllhPH68QQgKi7ClSpFVb2OwlkAWSgEzrOjhx00W7tJq7ld90nL6V83l34dZF012KSLo0BAybOTZptnyxWpguKR1jBSYkjazb1FzTZLy9d5TxrBkf2ptios4vHWsI5FBGSYQfQpd43VjWSedqiKNVnlm1diip0Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(86362001)(36860700001)(82310400004)(81166007)(356005)(40460700003)(8676002)(70586007)(70206006)(5660300002)(4326008)(316002)(110136005)(54906003)(426003)(8936002)(83380400001)(47076005)(44832011)(16526019)(26005)(186003)(336012)(15650500001)(2906002)(1076003)(2616005)(508600001)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2022 09:56:43.8331 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2515374f-c69b-40a0-0ee6-08da034572c4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT027.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0062
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
index fad9f7a10413..c4bc07a58348 100644
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
index 8edf334ce7f4..98484b190869 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2925,19 +2925,14 @@ static int alloc_irq_index(u16 devid, int count, bool align,
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
@@ -2969,16 +2964,12 @@ static int modify_irte_ga(u16 devid, int index, struct irte_ga *irte,
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
@@ -3040,49 +3031,49 @@ static void irte_ga_prepare(void *entry,
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
@@ -3093,7 +3084,7 @@ static void irte_ga_set_affinity(void *entry, u16 devid, u16 index,
 					APICID_TO_IRTE_DEST_LO(dest_apicid);
 		irte->hi.fields.destination =
 					APICID_TO_IRTE_DEST_HI(dest_apicid);
-		modify_irte_ga(devid, index, irte, NULL);
+		modify_irte_ga(iommu, devid, index, irte, NULL);
 	}
 }
 
@@ -3382,7 +3373,7 @@ static int irq_remapping_activate(struct irq_domain *domain,
 	if (!iommu)
 		return 0;
 
-	iommu->irte_ops->activate(data->entry, irte_info->devid,
+	iommu->irte_ops->activate(iommu, data->entry, irte_info->devid,
 				  irte_info->index);
 	amd_ir_update_irte(irq_data, iommu, data, irte_info, cfg);
 	return 0;
@@ -3396,7 +3387,7 @@ static void irq_remapping_deactivate(struct irq_domain *domain,
 	struct amd_iommu *iommu = data->iommu;
 
 	if (iommu)
-		iommu->irte_ops->deactivate(data->entry, irte_info->devid,
+		iommu->irte_ops->deactivate(iommu, data->entry, irte_info->devid,
 					    irte_info->index);
 }
 
@@ -3451,7 +3442,7 @@ int amd_iommu_activate_guest_mode(void *data)
 	entry->hi.fields.vector            = ir_data->ga_vector;
 	entry->lo.fields_vapic.ga_tag      = ir_data->ga_tag;
 
-	return modify_irte_ga(ir_data->irq_2_irte.devid,
+	return modify_irte_ga(ir_data->iommu, ir_data->irq_2_irte.devid,
 			      ir_data->irq_2_irte.index, entry, ir_data);
 }
 EXPORT_SYMBOL(amd_iommu_activate_guest_mode);
@@ -3481,7 +3472,7 @@ int amd_iommu_deactivate_guest_mode(void *data)
 	entry->hi.fields.destination =
 				APICID_TO_IRTE_DEST_HI(cfg->dest_apicid);
 
-	return modify_irte_ga(ir_data->irq_2_irte.devid,
+	return modify_irte_ga(ir_data->iommu, ir_data->irq_2_irte.devid,
 			      ir_data->irq_2_irte.index, entry, ir_data);
 }
 EXPORT_SYMBOL(amd_iommu_deactivate_guest_mode);
@@ -3553,7 +3544,7 @@ static void amd_ir_update_irte(struct irq_data *irqd, struct amd_iommu *iommu,
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
