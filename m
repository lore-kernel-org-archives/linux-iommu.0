Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2065.outbound.protection.outlook.com [40.107.243.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5F7187B
	for <iommu@lists.linux.dev>; Mon, 21 Aug 2023 10:44:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RGKVjF6dATmAUavfXev43lODDNiEahz/0VJwVv9BxYJccfvQDSdMGWIjcCQD0D0v6GgyPoPWEXtisyq77hxvJFi9wjkZTwWUeunwaCKO945F+EQD5bXKB5gGQakFy7sbKXWS5rHT2GRhLBxP8buEIWNPNvHBkPg8zD1kQNNfw+LUxdt0g3bod+0JEkItgfJ1Gs0iJdyNSqy3vWGFQHTQaaz8hsRtqHPur2mSPpsFsPPn6Xk1AhSyX6QYl+FnqG6gzHW70TQQBvbTkQ5Fuf1RNpJvnUXN0voYNFPmR2uRlgXhZ3V5888r+o7p57jgWQP+eIC8KCnsW12e2ikf33Ig9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=daJtDliaaIznb/mPsfP7DU1XDLwaHTkXNU06aF8JbhU=;
 b=XGfckjK81VyQqEmvGgUNkkcX6Vqfv0snwo6KkgjsyfE5iX2O3WJU9vAl4ajBRFjhE8NAn5SSXPP+GqYo94Cx/L5l3f0+jbTHoGi1CW1ch6M9zQumvzTCTkC5/4T5iEkoogtkhScvkblEobZ+ZKWuJH76Y5XtnHS41fEVTsK2DoPSQFqJLI4gxzpyYyIlliq54rDYXDMJnK1bzVJYSdJOwq36dZCPl2IEqATtqM4ufuObyz97bckBPZKBjo4w8Bd/EkrtKjf+vUI9pojT/AAS3Ah66fXqv29QGpklnON/79orJ9XMpmDLztmVkrDbvGFGxKIkPht0dpjfPpOaOvbm1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=daJtDliaaIznb/mPsfP7DU1XDLwaHTkXNU06aF8JbhU=;
 b=sVKUuniROG4Gj5r6rES0flz3szh6yB7Y6mNcYkJOpllgOxbDIRe58xDSsew0v66C3lVUQzJ2Q63Kqbcl9WUp8eu1sSR0qHdiUpjBDNk1CFGuMbjFXkJWIeC966xRqAlDhJgVuu4lATu/GXvqJGAq3oH1knUj48574zQGWHCiIEM=
Received: from SN7P220CA0008.NAMP220.PROD.OUTLOOK.COM (2603:10b6:806:123::13)
 by PH7PR12MB5927.namprd12.prod.outlook.com (2603:10b6:510:1da::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Mon, 21 Aug
 2023 10:44:32 +0000
Received: from SA2PEPF00001508.namprd04.prod.outlook.com
 (2603:10b6:806:123:cafe::24) by SN7P220CA0008.outlook.office365.com
 (2603:10b6:806:123::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20 via Frontend
 Transport; Mon, 21 Aug 2023 10:44:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001508.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Mon, 21 Aug 2023 10:44:32 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 21 Aug
 2023 05:44:28 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v5 04/14] iommu/amd: Refactor protection domain allocation code
Date: Mon, 21 Aug 2023 10:42:17 +0000
Message-ID: <20230821104227.706997-5-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230821104227.706997-1-vasant.hegde@amd.com>
References: <20230821104227.706997-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00001508:EE_|PH7PR12MB5927:EE_
X-MS-Office365-Filtering-Correlation-Id: c6b73910-4d39-45fc-c170-08dba2339a89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	hChFXBWWyfQRHnwkboo9oDxupVS6GfMhbMNUChmbdGIqmj3xkz3L9zn6JSkxs26e1XAFaJvSKGd3VVjARvUNtiSiEQAruv2104w0//O9+x4r6YPFzZ26IHALm0hiDpOPl9kMlgQjsXZqh5r7LbgTp7r0Z0Zh+nkJlBkG0hJ3gwySW2C/L0sbLbbDMcnzRowxpj1+/kJnUipckncxBpwFJTBqIsP0sSGzxY1ArBYJ7iezkQwazrfLQEBtDwLKGVJaUxIP0R1B+PE45vj1Z8f5scMrRW8ZUl/B8ttwT1t4Iiax842v45qRWkZu0VCSqHEKkWP3XkYwBqJ5aFYwB4bzEzBYiclcKL3EPGjXBHOkpBDsowdgXJXUS38hq4SIa+mm24SLfVnJfhCI+TfTeDyVPmiaFvSxjUCs6UiEKS5xDA8atvtR6KEsd721FddTwGCK7UyxIzc9GDIr/AixgNDaJW+fiSME7+Zyytf8c0SezGb9EYb1cmdCFaGQzbHn1/e/KHbYNkoVeWzTvNeDiZFForiLw1le+zdNL02kc5DfcANdalKzl4o+J/tQIgdETVSx/lPUNc7yUZotssF/3YtTYKL27aXCklRyfnT7ApP/uMhpcAvZsMlyFe2eFhr8Rx4kdY2rCDNWDgL35Zgqhc4ijh/pE1BfGGu+xf+URHnl+HZdhyl4ZyywppIoS6btkbr5xoOGr6BPHMmG3HBeNp7DdonxLzEhciePWOLdOENjn70MEfnDFzE9QawTF6qfSCxGu6ccnDFPxcboSWMcXyGRTA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(136003)(39860400002)(396003)(82310400011)(451199024)(186009)(1800799009)(36840700001)(40470700004)(46966006)(2906002)(83380400001)(7696005)(40480700001)(5660300002)(44832011)(336012)(426003)(16526019)(26005)(86362001)(36860700001)(47076005)(8676002)(2616005)(8936002)(4326008)(70206006)(316002)(54906003)(70586007)(110136005)(478600001)(82740400003)(356005)(81166007)(6666004)(40460700003)(41300700001)(36756003)(1076003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 10:44:32.2183
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c6b73910-4d39-45fc-c170-08dba2339a89
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001508.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5927

To replace if-else with switch-case statement due to increasing number of
domain types.

No functional changes intended.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
---
 drivers/iommu/amd/iommu.c | 45 +++++++++++++++++++--------------------
 1 file changed, 22 insertions(+), 23 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index c2cb541b0553..d5569eec0fe9 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2078,24 +2078,8 @@ static struct protection_domain *protection_domain_alloc(unsigned int type)
 	struct io_pgtable_ops *pgtbl_ops;
 	struct protection_domain *domain;
 	int pgtable;
-	int mode = DEFAULT_PGTABLE_LEVEL;
 	int ret;
 
-	/*
-	 * Force IOMMU v1 page table when iommu=pt and
-	 * when allocating domain for pass-through devices.
-	 */
-	if (type == IOMMU_DOMAIN_IDENTITY) {
-		pgtable = AMD_IOMMU_V1;
-		mode = PAGE_MODE_NONE;
-	} else if (type == IOMMU_DOMAIN_UNMANAGED) {
-		pgtable = AMD_IOMMU_V1;
-	} else if (type == IOMMU_DOMAIN_DMA || type == IOMMU_DOMAIN_DMA_FQ) {
-		pgtable = amd_iommu_pgtable;
-	} else {
-		return NULL;
-	}
-
 	domain = kzalloc(sizeof(*domain), GFP_KERNEL);
 	if (!domain)
 		return NULL;
@@ -2106,27 +2090,42 @@ static struct protection_domain *protection_domain_alloc(unsigned int type)
 
 	spin_lock_init(&domain->lock);
 	INIT_LIST_HEAD(&domain->dev_list);
+	domain->nid = NUMA_NO_NODE;
+
+	switch (type) {
+	/* No need to allocate io pgtable ops in passthrough mode */
+	case IOMMU_DOMAIN_IDENTITY:
+		return domain;
+	case IOMMU_DOMAIN_DMA:
+	case IOMMU_DOMAIN_DMA_FQ:
+		pgtable = amd_iommu_pgtable;
+		break;
+	/*
+	 * Force IOMMU v1 page table when allocating
+	 * domain for pass-through devices.
+	 */
+	case IOMMU_DOMAIN_UNMANAGED:
+		pgtable = AMD_IOMMU_V1;
+		break;
+	default:
+		goto out_err;
+	}
 
 	switch (pgtable) {
 	case AMD_IOMMU_V1:
-		ret = protection_domain_init_v1(domain, mode);
+		ret = protection_domain_init_v1(domain, DEFAULT_PGTABLE_LEVEL);
 		break;
 	case AMD_IOMMU_V2:
 		ret = protection_domain_init_v2(domain);
 		break;
 	default:
 		ret = -EINVAL;
+		break;
 	}
 
 	if (ret)
 		goto out_err;
 
-	/* No need to allocate io pgtable ops in passthrough mode */
-	if (type == IOMMU_DOMAIN_IDENTITY)
-		return domain;
-
-	domain->nid = NUMA_NO_NODE;
-
 	pgtbl_ops = alloc_io_pgtable_ops(pgtable, &domain->iop.pgtbl_cfg, domain);
 	if (!pgtbl_ops) {
 		domain_id_free(domain->id);
-- 
2.31.1

