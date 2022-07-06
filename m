Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2051.outbound.protection.outlook.com [40.107.94.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A0B033C6
	for <iommu@lists.linux.dev>; Wed,  6 Jul 2022 11:47:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hsYHmCQ7RDJrN+buAQ6UqCjRJU4+O1LZlNAINjOetZZixHXjl7tyWkCUXS301fS5McD/OQX3/s8zsEdDcs4aRa4nJsp0iDhn33ondvsfsvtLRCyXdHnmgAoWAx+goqCpKIfVmuPdATnduZ7BQJAk081kUCtfHGdm3Tlem5hB5DwxFYNhRGEc8x4YK3evJag4COLiIWXmSOd8nN8M6OgTo2uPDc7Wr2gYpbxXYcQiN2SfJnsxkR4c3l2HbvNm6oBPaCCOitzFaljYReRd7CFa1MebwDWZRSjFPz5KoMN4oYnU/u1LWlJagsF2cM+n/HuVWbiRoyUEXxNQP3pezRtOKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CBNnIXXeXcEcn3R6DcTlZivM3leaNr/PLBvj3kE68nk=;
 b=MnrzAqtq1xouAufHbHILx4Y9TW2joOYLVys0Q+exdv2Qmb9pWI+EX3i9w/KOwPzeVAuZcHZWBPCQFlZa1n2u+ejmfJRkDT1WuuMi8a4G0h4rh7jI70EQ38Ta0PgOcx2QHeC0oALodouo8hxG2NuHL/UgmJo3kgzLaLvnLkNK/OH/IBhUwN8AuQsN8BfodQBN0K4+mLaCcpUxYbWmIHsL9XOqPyX04DYrHNS+tURYGGvbSlrMR/2PjL9ZMOyFIlb903XLbV6Clz+8z/PsdWK22whOuLLlsMMNEY5q20LnOMHyvXOJDwrytTKvDcl6vQ74KQqeCmRRR7yzj66oRXY1xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=8bytes.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CBNnIXXeXcEcn3R6DcTlZivM3leaNr/PLBvj3kE68nk=;
 b=KCykiHBCgg2CWwI0gcXTY6SPdoltYwkqkatr1kTIOHN2UASgvVPdiTLNneo6Duex1NJG07e/nOzvQkm7WW8/5v5gz1rAjZtDcVhmTSKbAkAIwLJ2fucNyxiuXiFqBZ2vJWvSjvF+dSCwUdouuPFKAT/KF4xEzuXZKD/AxBjqyEs=
Received: from MWHPR13CA0039.namprd13.prod.outlook.com (2603:10b6:300:95::25)
 by BY5PR12MB4902.namprd12.prod.outlook.com (2603:10b6:a03:1dd::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.17; Wed, 6 Jul
 2022 11:47:02 +0000
Received: from CO1NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:95:cafe::3c) by MWHPR13CA0039.outlook.office365.com
 (2603:10b6:300:95::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.9 via Frontend
 Transport; Wed, 6 Jul 2022 11:47:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT031.mail.protection.outlook.com (10.13.174.118) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5417.15 via Frontend Transport; Wed, 6 Jul 2022 11:47:01 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 6 Jul
 2022 06:46:58 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <joro@8bytes.org>, <iommu@lists.linux.dev>
CC: <iommu@lists.linux-foundation.org>, <suravee.suthikulpanit@amd.com>,
	Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v3 RESEND 18/35] iommu/amd: Update amd_irte_ops functions
Date: Wed, 6 Jul 2022 17:08:08 +0530
Message-ID: <20220706113825.25582-19-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220706113825.25582-1-vasant.hegde@amd.com>
References: <20220706113825.25582-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c1a725a4-bcc4-4c1f-6a6c-08da5f453db6
X-MS-TrafficTypeDiagnostic: BY5PR12MB4902:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7xeuRdCVOMAB9dQl0TOazxxQ17DiWjebAbCfFH8fSdfFZVOPdS+HOT2/lfJdIaJ9FruKjIpmLE3gO/eV1+633pZA2BuYeU3QQDbwNaf9xp/ln0yjJHKMDsIS06KtX/YDkdEwO9VAsH0tYlMtGXCoFMHhBhITBfqB5A2n/1l0UQLOMoEyfXAGqIznHBgiUuO34zX8/4Tm8aiJn2NvQf/rY5PFafh+SmHE5wZsXoi6R6jZgB00unEFojhXdr7Mk6ilUBmhKyF4ssAetgAg/pZ2GcxV7IsaSNxyd4uxL+8rsgTfqSGCFx1iHlksHtXUd/qKiNRKlc4nwbSfEj13q2ZjgAepzVc5qsPlC2s8zUR5nNRG1pYEm13bENr7gzYp3DSR2+W6ue3GQ64rfW6gJvZpA+wD4wTaNBfaLY90hFWM0ijFJ3ImD1gb8GLzD3vsM5MX1jQGnSGTrH4dpFuG0gElWaWvCGEs6ies8yIfHqkDzvGkq2kwSVset7Xn3l6sSkAtpTfMLCU2eXDHGVx0iCMqBHw601I2ebzOAlQIM4cFPw90cq2HaRqNCaVcbC0FN2gk//lvsC7SEVgDmVbGwIVFyn5syLN8fq1a0zzsxNlTozcM4oVwZmNrSiRned/CFIR0GfmIZ+shbNHfQ+oWa/RKKwWEErVNeWqc1sC9XnfDlEtIT0sDOB7DW67frNYQ4InRptc2X1ETvl6OxJf75Zurf/U9RycSZ54yf20Q8fRuqKOtoDO6X+eYBRq8zPUTXE7mjDO625ruyos4S8B0/CY7elLwwZi6Sv8DWVwyPgBW3TnAdh+p/+lMqQweq0aaldQHq7RI1b5snIWj1N0qnX+6X0OZ3mLvyrbmhFky/Tm0mdI81M8FonEEHgaLYcH2mRJd
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(136003)(346002)(376002)(396003)(39860400002)(36840700001)(46966006)(40470700004)(6666004)(478600001)(41300700001)(15650500001)(83380400001)(82740400003)(356005)(36756003)(2906002)(7696005)(26005)(81166007)(44832011)(5660300002)(86362001)(40480700001)(36860700001)(70206006)(4326008)(8936002)(110136005)(70586007)(34020700004)(1076003)(47076005)(426003)(336012)(186003)(16526019)(2616005)(8676002)(82310400005)(40460700003)(54906003)(316002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2022 11:47:01.7218
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1a725a4-bcc4-4c1f-6a6c-08da5f453db6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4902
Message-ID: <20220706113808.90gUlybDy0hKH6QFL9k-W4cgLVjY8y9Iq0xxkw8dEJc@z>

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
index 693926afdd0f..67feb847fc13 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -1007,9 +1007,9 @@ struct amd_ir_data {
 
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
index 9f373b164762..c4701fa957d0 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2934,19 +2934,14 @@ static int alloc_irq_index(u16 devid, int count, bool align,
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
@@ -2978,16 +2973,12 @@ static int modify_irte_ga(u16 devid, int index, struct irte_ga *irte,
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
@@ -3049,49 +3040,49 @@ static void irte_ga_prepare(void *entry,
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
@@ -3102,7 +3093,7 @@ static void irte_ga_set_affinity(void *entry, u16 devid, u16 index,
 					APICID_TO_IRTE_DEST_LO(dest_apicid);
 		irte->hi.fields.destination =
 					APICID_TO_IRTE_DEST_HI(dest_apicid);
-		modify_irte_ga(devid, index, irte, NULL);
+		modify_irte_ga(iommu, devid, index, irte, NULL);
 	}
 }
 
@@ -3391,7 +3382,7 @@ static int irq_remapping_activate(struct irq_domain *domain,
 	if (!iommu)
 		return 0;
 
-	iommu->irte_ops->activate(data->entry, irte_info->devid,
+	iommu->irte_ops->activate(iommu, data->entry, irte_info->devid,
 				  irte_info->index);
 	amd_ir_update_irte(irq_data, iommu, data, irte_info, cfg);
 	return 0;
@@ -3405,7 +3396,7 @@ static void irq_remapping_deactivate(struct irq_domain *domain,
 	struct amd_iommu *iommu = data->iommu;
 
 	if (iommu)
-		iommu->irte_ops->deactivate(data->entry, irte_info->devid,
+		iommu->irte_ops->deactivate(iommu, data->entry, irte_info->devid,
 					    irte_info->index);
 }
 
@@ -3460,7 +3451,7 @@ int amd_iommu_activate_guest_mode(void *data)
 	entry->hi.fields.vector            = ir_data->ga_vector;
 	entry->lo.fields_vapic.ga_tag      = ir_data->ga_tag;
 
-	return modify_irte_ga(ir_data->irq_2_irte.devid,
+	return modify_irte_ga(ir_data->iommu, ir_data->irq_2_irte.devid,
 			      ir_data->irq_2_irte.index, entry, ir_data);
 }
 EXPORT_SYMBOL(amd_iommu_activate_guest_mode);
@@ -3490,7 +3481,7 @@ int amd_iommu_deactivate_guest_mode(void *data)
 	entry->hi.fields.destination =
 				APICID_TO_IRTE_DEST_HI(cfg->dest_apicid);
 
-	return modify_irte_ga(ir_data->irq_2_irte.devid,
+	return modify_irte_ga(ir_data->iommu, ir_data->irq_2_irte.devid,
 			      ir_data->irq_2_irte.index, entry, ir_data);
 }
 EXPORT_SYMBOL(amd_iommu_deactivate_guest_mode);
@@ -3562,7 +3553,7 @@ static void amd_ir_update_irte(struct irq_data *irqd, struct amd_iommu *iommu,
 	 * Atomically updates the IRTE with the new destination, vector
 	 * and flushes the interrupt entry cache.
 	 */
-	iommu->irte_ops->set_affinity(ir_data->entry, irte_info->devid,
+	iommu->irte_ops->set_affinity(iommu, ir_data->entry, irte_info->devid,
 				      irte_info->index, cfg->vector,
 				      cfg->dest_apicid);
 }
-- 
2.31.1

