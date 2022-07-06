Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2088.outbound.protection.outlook.com [40.107.93.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6928D33C6
	for <iommu@lists.linux.dev>; Wed,  6 Jul 2022 11:48:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d1M2tmti+NUdbAPSyCElSdhiDsgVvp++k5u9znUAvJu4DGCc4MiLskWhbmPvE+T40267imalhMd8vAFg5jfXXc8AskYtPQpMm64+BKfL7fZ5xdT89Nia8rT3gEK60SM8O8nClEx4kTxToDLJs7m0vDgLhfKmn55XQL6eGiXrWclo0DzV2G321GxadSGwKuNuCiqjSeHhUtkXFIMudE1jDVFPWn3rwbT54QBUc93phLNCfBQbyUfcSsJGjYlavwsmfre9+gdmn5OyOu1K20PdprQ1KRwMDVsLN58si+lJ68Hrsz0evpmppAjv8Jm/WnZmwY4Ms+dhgNL5HvppX0R+0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZmHcrVKMxrIPLnBdlKKrrGSDD5UiKpNfrp7BSwmJ3MI=;
 b=U7oZkt6puJnEIY66k98Tb/5nrktUclvJ0nMtqiI6na0t9To/GJIPnXWsPHFVzCPZv608dge5gGfPxT+nxcBtT38NWgW3J8bQgTwHDzCMW7Oq52Q4zWubrPB6ox0UTaaxcTvYg8xLRoIfkOxDegHaKiDiK79OJ434E4lZqs90kVyGhNQQBp0kBxpFfNGUuds7cH8i+f+N+Z+QOCv1DutUZndrtRtcO66YvT+QTkk2JHCzlAVucCXcOt+lx2Rg+dkJ5swbbXx/exfriK9Fzxdx42xN+WKRRsz3lU6M2pVLnH1fq/snszzFeNrJp7Sa+iXM7BTjZzltofwQblf+CCZUAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=8bytes.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZmHcrVKMxrIPLnBdlKKrrGSDD5UiKpNfrp7BSwmJ3MI=;
 b=T+ruZ284xfuSGNOjUz+eQYVLCgP9pUbK++HzIeQUnDcMJXzsDEENNskSOqHXJ+MlyhDeKX6rjvEhUkHeAO7SQf0VxaoHyW5C16EYAWldfLP4DUWHNXbaVF9r05IkJyzW7WY8isAz6ZhRDjBZuewBjqkeQJfxqasF29hHjppJiVc=
Received: from MWHPR10CA0071.namprd10.prod.outlook.com (2603:10b6:300:2c::33)
 by MWHPR1201MB0125.namprd12.prod.outlook.com (2603:10b6:301:55::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.18; Wed, 6 Jul
 2022 11:48:34 +0000
Received: from CO1NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:2c:cafe::1e) by MWHPR10CA0071.outlook.office365.com
 (2603:10b6:300:2c::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15 via Frontend
 Transport; Wed, 6 Jul 2022 11:48:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT063.mail.protection.outlook.com (10.13.175.37) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5417.15 via Frontend Transport; Wed, 6 Jul 2022 11:48:33 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 6 Jul
 2022 06:48:30 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <joro@8bytes.org>, <iommu@lists.linux.dev>
CC: <iommu@lists.linux-foundation.org>, <suravee.suthikulpanit@amd.com>,
	Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v3 RESEND 24/35] iommu/amd: Update set_dte_irq_entry
Date: Wed, 6 Jul 2022 17:08:14 +0530
Message-ID: <20220706113825.25582-25-vasant.hegde@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 8138aa91-cc14-4b0a-d99b-08da5f457459
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0125:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	w1rwMsH3P7dk1ew71LgkhuwCSKnZYC3nD1h/DkjZsen/pT3I/zUdDLJHriTpSK/pUcKmlbYPCP3M5zoRTKnPgGgYicTmiM8t6CwYP3mnxa+5nzMmo15Sj0tUOEpHgWCYbr1t3oPre0mC3YS+by6Sq/N0hjNe+Cndqc+9avJSOd1E2zyKwB6lE5sD4ZRukSdDPcTVVHsCvpmXjfQMbl4lkNc8jhK4jIZfXGK2a5HLeTQueHaf2jw73rPpqTWfhuGaeRxdORVwQgs5o0S6hxWLNnT7k8HiwWFXd5hF0cUEW5uNXg5yjalvMtjRfmKfRmt/+AkTvr+ohY0FFHGwohZq9dmF6JE9G1cw4namSnQlNZxDgTRgx77uWavABnCeODJSXLDSt7zeoO9iCbQDdGg62jCGYW5TlLzUw0Hfu/+p4kcA3F1o1zjKxZaOD5V0PbRnf6de9Th7Tod3iPEuM9md2L7NHp870460UELExK/g3ufC6IyNgQr1MJii1jMcGhq8gJog65p5akWs2NGQHhomD7K8LJ/yaqw8f/xgxYxJVBqYLy00DKF22vIjKa9LwUfBfuYW5e1OJ9iWJgbUw/tkO3lxSVZIyRH+Abhrk3Zza+KjDirBoRRGAZon/M79qjxkAHhMZXOUsdVgkEM3YQczVdyHSQhMUvK8E7LLk9Ztnm0lkTNCANXM541M7gBUJT3MNPbWv2P9eYd2n9yypDRupYbYrUBDAqXCJMHrgWrA68eywXwhhYXXnuMJKwACtXxzcrzQZzCBAp1By9p6k8wJq6cGRMRkFbDDcqFhrC/sSsYvcM2jmhIzc9tEyS7YNYawibMSS/6bw3Lue03A2FV5yoAOYkm6uvQtcb4mn+XuuDJp6oURdAbXCKdXz82kXtbF
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(136003)(396003)(376002)(346002)(40470700004)(36840700001)(46966006)(16526019)(186003)(2616005)(40480700001)(1076003)(82310400005)(336012)(47076005)(426003)(36756003)(316002)(54906003)(8676002)(4326008)(83380400001)(110136005)(70206006)(70586007)(5660300002)(8936002)(7696005)(86362001)(40460700003)(44832011)(478600001)(26005)(82740400003)(356005)(81166007)(34020700004)(36860700001)(41300700001)(2906002)(6666004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2022 11:48:33.3899
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8138aa91-cc14-4b0a-d99b-08da5f457459
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0125
Message-ID: <20220706113814.MUK5yncu5rczFSIZAh7JS3Bm1UP25weV19VrNECVCms@z>

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

Start using per PCI segment device table instead of global
device table.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/iommu.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 790a3449e7b7..f1fab4168101 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2731,18 +2731,20 @@ EXPORT_SYMBOL(amd_iommu_device_info);
 static struct irq_chip amd_ir_chip;
 static DEFINE_SPINLOCK(iommu_table_lock);
 
-static void set_dte_irq_entry(u16 devid, struct irq_remap_table *table)
+static void set_dte_irq_entry(struct amd_iommu *iommu, u16 devid,
+			      struct irq_remap_table *table)
 {
 	u64 dte;
+	struct dev_table_entry *dev_table = get_dev_table(iommu);
 
-	dte	= amd_iommu_dev_table[devid].data[2];
+	dte	= dev_table[devid].data[2];
 	dte	&= ~DTE_IRQ_PHYS_ADDR_MASK;
 	dte	|= iommu_virt_to_phys(table->table);
 	dte	|= DTE_IRQ_REMAP_INTCTL;
 	dte	|= DTE_INTTABLEN;
 	dte	|= DTE_IRQ_REMAP_ENABLE;
 
-	amd_iommu_dev_table[devid].data[2] = dte;
+	dev_table[devid].data[2] = dte;
 }
 
 static struct irq_remap_table *get_irq_table(struct amd_iommu *iommu, u16 devid)
@@ -2793,7 +2795,7 @@ static void set_remap_table_entry(struct amd_iommu *iommu, u16 devid,
 	struct amd_iommu_pci_seg *pci_seg = iommu->pci_seg;
 
 	pci_seg->irq_lookup_table[devid] = table;
-	set_dte_irq_entry(devid, table);
+	set_dte_irq_entry(iommu, devid, table);
 	iommu_flush_dte(iommu, devid);
 }
 
@@ -2809,8 +2811,7 @@ static int set_remap_table_entry_alias(struct pci_dev *pdev, u16 alias,
 
 	pci_seg = iommu->pci_seg;
 	pci_seg->irq_lookup_table[alias] = table;
-	set_dte_irq_entry(alias, table);
-
+	set_dte_irq_entry(iommu, alias, table);
 	iommu_flush_dte(pci_seg->rlookup_table[alias], alias);
 
 	return 0;
-- 
2.31.1

