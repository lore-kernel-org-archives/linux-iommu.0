Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2054.outbound.protection.outlook.com [40.107.220.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E45B33C6
	for <iommu@lists.linux.dev>; Wed,  6 Jul 2022 11:46:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zby5Le9f/WzVloe/9//0a8DAMAziYkbMJKeRuuwswcfN6jZ9iELQ83KUUCWq6a5rO5X/EKtdOERjIyL+1cMtOrJQnZumi6/dGu5oB1eHkOtMihNC5YDzpq8wA5DCozrHYXmxXhE6uavhpCe1DtNOKdNBU6abJV0medF9GNcUxn5OWByw0BCEJx6ty2mQBsZ2kFwtJ9rFOuP6vaYF/Ch/GL8HzW1/dyRpWYfyBupvWLcU55zAC7I9uV9m9JNxKJpNOcOjCdLkE1ePBhRIEyHvGZ152+x+EwguZzrLUyoiTRo47pKvV2IPKKW6ZpmUDCVkFwUsx6RLHZ8R7RaB++y46A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K8uZ8hvm1dd6UHl0DROTfX/PH+6ZfaPxhigmyby0pac=;
 b=UaJCk+jBfG2GjO/CoqZjVQDn86/urkdfTNvGyi2Mtj6+VzF1w64h6yHs6nDqr+KAgRvr6tKtMOHatxzqQgKlGV8mnf1pO3PiafJ27JLubA+EvgFVQVD4sDiOntXwmHMz0/LIgG7jDdZcsqueV5K9ZyjQN+7gIHm6DTL/27ok5yhtZsGHIzZQ5c8dEgARmKaCCKOFYsj0yd4eho6dFPNF5wmsSucTxLCFpkl5sGQxJOWjIEQQtRkMuALZmL8iYfpBB3QcPjpB0L5zl/oqs+/95wjJSSlmWl1NFJZl/Q+S0l/BVJ66rZ0mq8FBkkKuaszftMlhCJLOqgh33Sl2NcVSUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=8bytes.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K8uZ8hvm1dd6UHl0DROTfX/PH+6ZfaPxhigmyby0pac=;
 b=Wv5TJZhoOr1k28q9x2biy6g1hWeC971ZALTwICj1FfS0guUvG1Vc9DiGYXP9PShLOuh9CYKqloboA5B2kcyecn01hlBWaqAJgYGsawKkFFv0HHPHyHA4oqQ1BxauHkcgXOZmw5xMqHaD0jsPdWcbAPOSHiMoeX3m6K7NvJ1pBfM=
Received: from MWHPR02CA0010.namprd02.prod.outlook.com (2603:10b6:300:4b::20)
 by SJ1PR12MB6196.namprd12.prod.outlook.com (2603:10b6:a03:456::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.20; Wed, 6 Jul
 2022 11:46:46 +0000
Received: from CO1NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:4b:cafe::7d) by MWHPR02CA0010.outlook.office365.com
 (2603:10b6:300:4b::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.15 via Frontend
 Transport; Wed, 6 Jul 2022 11:46:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT013.mail.protection.outlook.com (10.13.174.227) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5417.15 via Frontend Transport; Wed, 6 Jul 2022 11:46:46 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 6 Jul
 2022 06:46:43 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <joro@8bytes.org>, <iommu@lists.linux.dev>
CC: <iommu@lists.linux-foundation.org>, <suravee.suthikulpanit@amd.com>,
	Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v3 RESEND 17/35] iommu/amd: Introduce struct amd_ir_data.iommu
Date: Wed, 6 Jul 2022 17:08:07 +0530
Message-ID: <20220706113825.25582-18-vasant.hegde@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 7563b947-9e43-49c7-ea79-08da5f4534ac
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6196:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	COE2eoUO7CJZqscfQ5wNqtuW0w+bY65rd99EOZFvyfIjkWdlsiO0NiuWO69QWPlsLWNoiuQSHAYEzoOy8IcDz01VAhTkAyCK4+89b5v6iGPjTSRZzPjKFPiWBbv0QsS6nTqSCLkLQiXqivIma1AoiD5ASTyt3u51bobx9hMZ0bmH/L/R0d0Q6fMuoR1EgkRKfmJwlhYfU5LsuHgJxw/YCkOjWsywB2Iw14miD5Qcsz6xRrSgw0nWux3tbOyntNVWzvgqaNYEwZa2E6njVcSlmm4EEYga3moErzYfb7L7mhdNsmNIXvTXLNarNJ4Mry+GUPF5mNMmieQBMzdIAcOtUIyxm2I01Jhi+WyM3SfsrUbXvJ2tbt3gPelfZ+ceySMKiCadSdt50dylAxXDDvxUgSZ7lPh3/Zhx16FIUkMBJ6+U8xdoSd504Ypya7coflyt+PyjuWOpCYNX8jRjABjWA7snTlzeiUv/edR/5oUppKpYz5Ps816cACZn1TaZwvPifOlRll5Y00HX9FCopXDL7BWU+8S3oEp9+ILL+LqbMEIGvApaFAt2UBSNkAfd25fFiSqlw12xqPLHFzRaP9mTZCR69BXK33fl2SElVc/kOyuazSGEmwjzYQIMG58vh//u+JTD+M6S3oQEGTqakTxareco7wpTz5pfSLg07JO0+KOtrDMqbHHAEI8FfoIsCllezaK9dh7HKm+EGaA6a/A42Q02oG7fh/1H6s9Twpgz36DANgxt4LpSliuXxlc3TQTk+i1E+pEg8DVTgqR6FIjfsFzAqaPQjy/TyKar+qpsm3q48FiO2GaLEA+XbnQYEbH3V9gaCG/R0GyQqhaw6pajB8tw+iOGs/jpVD8js/MNJpbpH/2OfI/6rsQHbbUOFzQP
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(136003)(396003)(346002)(376002)(36840700001)(40470700004)(46966006)(16526019)(186003)(2616005)(40480700001)(1076003)(44832011)(4326008)(82310400005)(6666004)(426003)(47076005)(336012)(110136005)(54906003)(8676002)(70206006)(83380400001)(70586007)(36756003)(316002)(5660300002)(8936002)(40460700003)(478600001)(86362001)(356005)(82740400003)(81166007)(26005)(41300700001)(2906002)(7696005)(34020700004)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2022 11:46:46.5445
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7563b947-9e43-49c7-ea79-08da5f4534ac
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6196
Message-ID: <20220706113807.dd0XJOP2ZBub1Tqod_pGA3-Bem3MCalRBB5ovXOrblM@z>

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

Add a pointer to struct amd_iommu to amd_ir_data structure, which
can be used to correlate interrupt remapping data to a per-PCI-segment
interrupt remapping table.

Co-developed-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h |  1 +
 drivers/iommu/amd/iommu.c           | 34 +++++++++++++----------------
 2 files changed, 16 insertions(+), 19 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index ca1a3d55cc83..693926afdd0f 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -989,6 +989,7 @@ struct irq_2_irte {
 
 struct amd_ir_data {
 	u32 cached_ga_tag;
+	struct amd_iommu *iommu;
 	struct irq_2_irte irq_2_irte;
 	struct msi_msg msi_entry;
 	void *entry;    /* Pointer to union irte or struct irte_ga */
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 5e4648cadff9..9f373b164762 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -3002,16 +3002,11 @@ static int modify_irte(u16 devid, int index, union irte *irte)
 	return 0;
 }
 
-static void free_irte(u16 devid, int index)
+static void free_irte(struct amd_iommu *iommu, u16 devid, int index)
 {
 	struct irq_remap_table *table;
-	struct amd_iommu *iommu;
 	unsigned long flags;
 
-	iommu = amd_iommu_rlookup_table[devid];
-	if (iommu == NULL)
-		return;
-
 	table = get_irq_table(iommu, devid);
 	if (!table)
 		return;
@@ -3195,7 +3190,7 @@ static void irq_remapping_prepare_irte(struct amd_ir_data *data,
 				       int devid, int index, int sub_handle)
 {
 	struct irq_2_irte *irte_info = &data->irq_2_irte;
-	struct amd_iommu *iommu = amd_iommu_rlookup_table[devid];
+	struct amd_iommu *iommu = data->iommu;
 
 	if (!iommu)
 		return;
@@ -3336,6 +3331,7 @@ static int irq_remapping_alloc(struct irq_domain *domain, unsigned int virq,
 			goto out_free_data;
 		}
 
+		data->iommu = iommu;
 		irq_data->hwirq = (devid << 16) + i;
 		irq_data->chip_data = data;
 		irq_data->chip = &amd_ir_chip;
@@ -3352,7 +3348,7 @@ static int irq_remapping_alloc(struct irq_domain *domain, unsigned int virq,
 			kfree(irq_data->chip_data);
 	}
 	for (i = 0; i < nr_irqs; i++)
-		free_irte(devid, index + i);
+		free_irte(iommu, devid, index + i);
 out_free_parent:
 	irq_domain_free_irqs_common(domain, virq, nr_irqs);
 	return ret;
@@ -3371,7 +3367,7 @@ static void irq_remapping_free(struct irq_domain *domain, unsigned int virq,
 		if (irq_data && irq_data->chip_data) {
 			data = irq_data->chip_data;
 			irte_info = &data->irq_2_irte;
-			free_irte(irte_info->devid, irte_info->index);
+			free_irte(data->iommu, irte_info->devid, irte_info->index);
 			kfree(data->entry);
 			kfree(data);
 		}
@@ -3389,7 +3385,7 @@ static int irq_remapping_activate(struct irq_domain *domain,
 {
 	struct amd_ir_data *data = irq_data->chip_data;
 	struct irq_2_irte *irte_info = &data->irq_2_irte;
-	struct amd_iommu *iommu = amd_iommu_rlookup_table[irte_info->devid];
+	struct amd_iommu *iommu = data->iommu;
 	struct irq_cfg *cfg = irqd_cfg(irq_data);
 
 	if (!iommu)
@@ -3406,7 +3402,7 @@ static void irq_remapping_deactivate(struct irq_domain *domain,
 {
 	struct amd_ir_data *data = irq_data->chip_data;
 	struct irq_2_irte *irte_info = &data->irq_2_irte;
-	struct amd_iommu *iommu = amd_iommu_rlookup_table[irte_info->devid];
+	struct amd_iommu *iommu = data->iommu;
 
 	if (iommu)
 		iommu->irte_ops->deactivate(data->entry, irte_info->devid,
@@ -3502,12 +3498,16 @@ EXPORT_SYMBOL(amd_iommu_deactivate_guest_mode);
 static int amd_ir_set_vcpu_affinity(struct irq_data *data, void *vcpu_info)
 {
 	int ret;
-	struct amd_iommu *iommu;
 	struct amd_iommu_pi_data *pi_data = vcpu_info;
 	struct vcpu_data *vcpu_pi_info = pi_data->vcpu_data;
 	struct amd_ir_data *ir_data = data->chip_data;
 	struct irq_2_irte *irte_info = &ir_data->irq_2_irte;
-	struct iommu_dev_data *dev_data = search_dev_data(NULL, irte_info->devid);
+	struct iommu_dev_data *dev_data;
+
+	if (ir_data->iommu == NULL)
+		return -EINVAL;
+
+	dev_data = search_dev_data(ir_data->iommu, irte_info->devid);
 
 	/* Note:
 	 * This device has never been set up for guest mode.
@@ -3529,10 +3529,6 @@ static int amd_ir_set_vcpu_affinity(struct irq_data *data, void *vcpu_info)
 		pi_data->is_guest_mode = false;
 	}
 
-	iommu = amd_iommu_rlookup_table[irte_info->devid];
-	if (iommu == NULL)
-		return -EINVAL;
-
 	pi_data->prev_ga_tag = ir_data->cached_ga_tag;
 	if (pi_data->is_guest_mode) {
 		ir_data->ga_root_ptr = (pi_data->base >> 12);
@@ -3578,7 +3574,7 @@ static int amd_ir_set_affinity(struct irq_data *data,
 	struct irq_2_irte *irte_info = &ir_data->irq_2_irte;
 	struct irq_cfg *cfg = irqd_cfg(data);
 	struct irq_data *parent = data->parent_data;
-	struct amd_iommu *iommu = amd_iommu_rlookup_table[irte_info->devid];
+	struct amd_iommu *iommu = ir_data->iommu;
 	int ret;
 
 	if (!iommu)
@@ -3648,7 +3644,7 @@ int amd_iommu_update_ga(int cpu, bool is_run, void *data)
 	    !ref || !entry || !entry->lo.fields_vapic.guest_mode)
 		return 0;
 
-	iommu = amd_iommu_rlookup_table[devid];
+	iommu = ir_data->iommu;
 	if (!iommu)
 		return -ENODEV;
 
-- 
2.31.1

