Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2057.outbound.protection.outlook.com [40.107.212.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFAD810788
	for <iommu@lists.linux.dev>; Tue, 15 Aug 2023 10:23:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EPSMD5uGITyONNABsT47G1WmDcBCuHQuClz6gpBWZzGgzE1dIplgD82ZAT2km6HIF22FglREUTPzjpsp69LOSurTBnMYNZbG2QKbrezIsXvokVM7TZr3KeoroPXjtJyOtdytAK1HfmoULknOj7zq/XTo/1+zntfAfOCWW4oybHnvz40WaMUYyRr5sC70g3BcdUzshpLKUC9ty+gjZJkkLLurZj8GyurqaVY1h6FSpsmGUcgK0FlKMf/t6QBHQvg2PjSfoPCRfoYATZwuoTNKqU3dBHXA1cnwpii9FU3ve04K6mga9esknkwWDIc6QElN8fezoyzWHvOcUVlG/fszIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ObUTDdk50+dpJECC6QHvpc97zJzYYVMffTd7m0Meol4=;
 b=h/+iMj3xpQUruj5OV6IIQOQ/r1QGrmuSenI4XCrg+Ys1GqUCFUxfHyGmhAvJjNRj7qE9GpAOmJEen/FHvUOqkAQAvARuof414yIAqrXX+QhpNgbV4X08BhyRUtn6h0Kr/BJ5u3llc5xoChxY4b2iDOdLi4/XqxtMEZef2cNIeb2Q46wluNouOM6eh/j85ZoKglXOoPgEckqKpVsAjOjH9aPkf0XDRgt+j0bLL5QR8vdmDHf9wvLp2HmUXeMn1RblrX1aJxRpBjp1u1docI8QeKiyvZgt7KVEvBznQTCLQuvx7rQVGKYvjoTJ8f+Wiaic8e7jRbu3VEt16Gk5RKJPIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ObUTDdk50+dpJECC6QHvpc97zJzYYVMffTd7m0Meol4=;
 b=VKkCndQoBzp/2vEC/edBgz3JQofyXtNiOFbjaypHiLYedZmPQakkVas6x6i9/pMLbQoMTvX6e9qMm1ZX3sxrbkbUxQqfVJ+UIiJiSjewUKSAfMB5ilXhaD95HMo4BBHDxj4LZcuQ7S0/z+Bco+fU5jPeOV5JJnzmTnp1i+P+9yk=
Received: from CH2PR11CA0029.namprd11.prod.outlook.com (2603:10b6:610:54::39)
 by CH3PR12MB8076.namprd12.prod.outlook.com (2603:10b6:610:127::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Tue, 15 Aug
 2023 10:23:26 +0000
Received: from CO1PEPF000044FA.namprd21.prod.outlook.com
 (2603:10b6:610:54:cafe::5c) by CH2PR11CA0029.outlook.office365.com
 (2603:10b6:610:54::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.33 via Frontend
 Transport; Tue, 15 Aug 2023 10:23:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044FA.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6723.3 via Frontend Transport; Tue, 15 Aug 2023 10:23:25 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 15 Aug
 2023 05:23:22 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v4 03/14] iommu/amd: Consolidate logic to allocate protection domain
Date: Tue, 15 Aug 2023 10:21:51 +0000
Message-ID: <20230815102202.565012-4-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230815102202.565012-1-vasant.hegde@amd.com>
References: <20230815102202.565012-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FA:EE_|CH3PR12MB8076:EE_
X-MS-Office365-Filtering-Correlation-Id: 4dc6c7c5-daac-4fd6-31dd-08db9d79a925
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	DfkKs3tkJQKdLR7pI757YtDFUWYxs1eAJZX0Xl8WHVPEHK0nSDb5DH/NtypquEdZHfGq5WCxTUroCK6iOq6X7wv6tqlfVHqIQBRlX4mebDHppodyu0iNunpO0xkg3nYBHB6uDDVhHzBWsvt0EI6TzuprBIq0Vx+haJkMU/NZmoReaYpW0bX4nLd3i7faUMj49eijJ/BfQK9ElmXSYdlHzEXdOy+ZDgByutCqM4QuulpLEkDtMVNpVNd5XbOaQDRL0a0qpPQtN+GY3e5L43iARIlP+lGW9RDJ9tCoKbpigWpTleQM/StMovOREnwZnzwmtNGXnchMHslSb5oelBOBPTXJ9t+78jpPuTFYVudAJsC1irMLDDXm9MXiYnKjXPFZSY2uA01RbahokWnIYvhq5OQA3e1V2EW/X/G1W1YTOCACQaBCShOOygc09I+7Mi9ISMJjMmKrJuoqFEgdfPPuSUIFCeRzj9vZ7JSYXtyqRp0Mom1QpzZfcNFqmvzUb2k5EpJTW7Zx7OSxqlcgmuw4EnIUrYhOlkfCbPSgKKKd4eX+QEEEytx8byWGg8ea+6NfX1c71HvhG48HU12/PBh/0ehBk/KD4EqxOnM1d9uWLiee3eOEoBuW2Iqciq5YIiTvYnyoivDKW2h5RSwqYbYRuKxm6Jxu1TGLxYoTyf/LiwagkTrhW3Qd90PBydUNxOqwJO+OaWlq87dRTUqcJh/eykm6M+ImORSARj4a1aoziSRdMJ00OO/m3W1bt9WFV5Jpd77cyGv1ROmFFx2aVk3KDw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(136003)(376002)(346002)(82310400008)(186006)(1800799006)(451199021)(46966006)(40470700004)(36840700001)(40480700001)(82740400003)(356005)(81166007)(36756003)(86362001)(40460700003)(16526019)(44832011)(478600001)(6666004)(2906002)(7696005)(1076003)(2616005)(26005)(70206006)(426003)(336012)(83380400001)(316002)(54906003)(41300700001)(110136005)(70586007)(5660300002)(8676002)(8936002)(4326008)(36860700001)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 10:23:25.5729
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dc6c7c5-daac-4fd6-31dd-08db9d79a925
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044FA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8076

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

