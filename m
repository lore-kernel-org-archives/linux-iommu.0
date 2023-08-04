Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2047.outbound.protection.outlook.com [40.107.96.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3936B1FC8
	for <iommu@lists.linux.dev>; Fri,  4 Aug 2023 06:43:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UQrecunJvT1BtvxKnGq83zIb6EFuQJihUF9o5bWMIKBPfzJ4xp4ZCH1YJdFnM9nN8tGtxMG8QWtWx7EFOMRlr9FZLt41Aj4vfCFW/CxGnvW/0AsENV8yH3ShLQUNE0IfaJFKuSX7cnB13ptSlaEM7NIvrgeqU3vut7bsEPMsBBCSm6z4XuxS6c8ocMcCW5Poixi8hpyfHx3Ak/Qx8VqfwXmJO79XeLkSBYqw51j7B0g7ad8JvkYMi+cDVFJ4sIu+vCOaCXJ8AMTYusEnxviBxBBb9w6q7fEv+MSJXgyRvPUfgf1uVNPQ6U3iW7JBeF8xx+XnQsp4wVK1GhHQ8j/3/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ObUTDdk50+dpJECC6QHvpc97zJzYYVMffTd7m0Meol4=;
 b=nq6J/yXDDuKAqBGh5sQzRPzLNs2fTZEL2ocpZYfrimZb8D3ZhMjFTAT3+7woqwDJqnIGwkk5bolEfaVMIYyNAQ4ICibs0hNpwlVh+xZt0IFRqtURONkdyv3POCqae7PTq2GR2q+VgheYnZlXyTfdI8uz/bXq+6eUIvwEX4C7w24ZZ7uahA94N2/uZbDVqJRuuBA8oNH/G9dMOakK9yGROIvoHrIfyxV4QB3Ucsz1hJs7fbvB8eovBx6p35++BGdww5ZFzij34ukdT+gj8kVUg4o5a6nPyROjWFBmzEnKDBaD0yRbwY4BjTX0CfKGMTbxtCuhHDBZmSXW6XCIhKj85A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ObUTDdk50+dpJECC6QHvpc97zJzYYVMffTd7m0Meol4=;
 b=RxC0jYWf2QbOza6suA0s/1pgF2gBuvgJ6uYupk7I/05ICe18QJqYlC14QBHciF70PmtSouw5Ie6L4bPEbMD1WP+vCX4fITA1Bb60hCWgPwur+I1Fz7ib76l8GfUCQj0Zfs3pMKB7avpHKoFWKJULg7cCi0Ic4BEFyLIGwHPpaqs=
Received: from CYXPR03CA0067.namprd03.prod.outlook.com (2603:10b6:930:d1::20)
 by MW4PR12MB7429.namprd12.prod.outlook.com (2603:10b6:303:21b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Fri, 4 Aug
 2023 06:43:32 +0000
Received: from CY4PEPF0000E9D4.namprd03.prod.outlook.com
 (2603:10b6:930:d1:cafe::cc) by CYXPR03CA0067.outlook.office365.com
 (2603:10b6:930:d1::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.20 via Frontend
 Transport; Fri, 4 Aug 2023 06:43:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D4.mail.protection.outlook.com (10.167.241.147) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Fri, 4 Aug 2023 06:43:32 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 4 Aug
 2023 01:43:29 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v3 03/16] iommu/amd: Consolidate logic to allocate protection domain
Date: Fri, 4 Aug 2023 06:42:03 +0000
Message-ID: <20230804064216.835544-4-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230804064216.835544-1-vasant.hegde@amd.com>
References: <20230804064216.835544-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D4:EE_|MW4PR12MB7429:EE_
X-MS-Office365-Filtering-Correlation-Id: 28c37a0c-4fb4-49f2-47a6-08db94b61edb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qpqBmHWKm19+ImL1yWUcFFKWMT/JDJSK4R9dmsd3ecMurbGCovLHaeCzMUFf4vB48E4Py+1Gqwc8orbC7O+T0cmDrSmTZPx6+ehQakmBK0ib7Pk/xe7tOOHpUC5HZnPtO0LZr/Y2LoSrlFNDQnRlIJOIL6VzohJR0RXHkHWOzYhHO9qOcwT9wETej+QyVjBIQdcymPAknj3p2n0dcQcuWMJbMvfGaGbFQ1vkeF9sWzr6o4djAaeMW50rxUtN9G1UsJ66GWzaAU5af0vnZLw+T1Zvfu0K7yJP833gmRaijYtSV8tLhIYFqNm89Ryi1SwSUBAuFxL/RB72PRwLxw8XZRhVSH6Fdx/XBLhq6cBzRsFFbDnQ+Bpn61C3rXuuEelveZ+xt11j2Cj1BDItZgyVNrtPHMtNlPP5cwpwGP6T0S77JMSQ6zh5GcXwAiFyMXTLqVGM3egn2dYjatdOrx7k398JLpl6KcKSPTyFRrZ2be75vgJA4CUaFE32SE9dwHBo8OG2fxzrcLq9LtkwYvAlKNN+3sJYNtkCP7NUDEZuG6KOgBW5mx3Sd7YcNoRsLPFxd1VISyakKZBjH7pG4ztvE6uHega2cAYJZTxQ0L/SI/tfoKRrRcXb+qSiMsoq4iNJ0KrhF3s55kyiGGfA5OO/Unsc795PQWkAwr5JEEa7+83HMpeXRHFXizWq/Snzwz0UAvzAh7hYC3pRbmolIfpy43ObPR88BaDM0vE21izpxrvjF0AnJ4XhnFBmz0JwfZ8YdUkHRmFnWOaTTXMbRL2xBw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(39860400002)(136003)(376002)(451199021)(1800799003)(186006)(82310400008)(46966006)(36840700001)(40470700004)(40460700003)(16526019)(2616005)(426003)(1076003)(83380400001)(336012)(26005)(47076005)(8676002)(36860700001)(316002)(2906002)(70206006)(5660300002)(70586007)(4326008)(44832011)(41300700001)(8936002)(6666004)(7696005)(54906003)(478600001)(110136005)(40480700001)(356005)(81166007)(86362001)(36756003)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2023 06:43:32.4609
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28c37a0c-4fb4-49f2-47a6-08db94b61edb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7429

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

Move the logic into the common caller function to simplify the code.

No functional changes intended.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/amd/iommu.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index dd586f69a9d8..c2cb541b0553 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2046,12 +2046,6 @@ static int protection_domain_init_v1(struct protection_domain *domain, int mode)
 
 	BUG_ON(mode < PAGE_MODE_NONE || mode > PAGE_MODE_6_LEVEL);
 
-	spin_lock_init(&domain->lock);
-	domain->id = domain_id_alloc();
-	if (!domain->id)
-		return -ENOMEM;
-	INIT_LIST_HEAD(&domain->dev_list);
-
 	if (mode != PAGE_MODE_NONE) {
 		pt_root = (void *)get_zeroed_page(GFP_KERNEL);
 		if (!pt_root) {
@@ -2067,12 +2061,6 @@ static int protection_domain_init_v1(struct protection_domain *domain, int mode)
 
 static int protection_domain_init_v2(struct protection_domain *domain)
 {
-	spin_lock_init(&domain->lock);
-	domain->id = domain_id_alloc();
-	if (!domain->id)
-		return -ENOMEM;
-	INIT_LIST_HEAD(&domain->dev_list);
-
 	domain->flags |= PD_GIOV_MASK;
 
 	domain->domain.pgsize_bitmap = AMD_IOMMU_PGSIZES_V2;
@@ -2112,6 +2100,13 @@ static struct protection_domain *protection_domain_alloc(unsigned int type)
 	if (!domain)
 		return NULL;
 
+	domain->id = domain_id_alloc();
+	if (!domain->id)
+		goto out_err;
+
+	spin_lock_init(&domain->lock);
+	INIT_LIST_HEAD(&domain->dev_list);
+
 	switch (pgtable) {
 	case AMD_IOMMU_V1:
 		ret = protection_domain_init_v1(domain, mode);
-- 
2.31.1

