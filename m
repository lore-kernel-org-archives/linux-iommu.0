Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2042.outbound.protection.outlook.com [40.107.237.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E871A23AE
	for <iommu@lists.linux.dev>; Fri, 28 Jul 2023 05:37:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WDfwUuNRqwnbwemjTKIxOMFN4TfQpyJcjijzN7j85Qs+GWinPpM8mPbGotrCQccHNr2yFAndWFZIjiqn1N8JAzjhLsltAH5sS1yVpJ92QZ1z3dQIboRVHey7Z9WK8qFX4K6o5250ZuFE/wXLEzjXTPtZW9nzBjBBKaP8IP5eDLBFMfrLlOQUpBpRIgRXFFNq8zbsI5jBtwBVK9LQORvDGTl+afuDVDBHRc9vc0nL6xsA4oJs8Y4gjRwPLNoVotysK9BHYTwGncYc+EyZKWzOuYgcRcHath+9r5NDpQnuNZ7dgslLQ3MW5CAGhf8JIadxCTNJ0ftEaBXseNkzADJlFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4dc5a2j8esorDdzFblw93HfrSVojihGxMaNMRSx0dRY=;
 b=MS9h7YgkPhmCgV8Pw6LaQWtgnoM+Yxz5FfPlLTNdaYCPOZglZ5CLXBaBi1Tf/AemjcQ6OK+t2ylb3R2MGJYuUag+7WWW2m2hGvjsuVdRC7b/p5DYHeLcbeQSetFJtPyX8TO77wD82S8c3kvTqO+kauyexfVQKLPtk7Gg1Cs02v8BFaHaArwwLwcS4+4paCXl1aDAH8atkmMOtP4TWHZr6BTr2Mc557rV57GK4R2hgi3BG8PyF2OwfLoEUAJ0vRIAJCL/Ds4jVAG/Us+iD1Y1X9oCcf4lpm59oyJoRpDXFWCOTlOp/8d3nICC3IfAz5Gzau0mkEA3RVKbNE8VNgPpRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4dc5a2j8esorDdzFblw93HfrSVojihGxMaNMRSx0dRY=;
 b=QcXx+Dl30MOx9BILpiYBeo3G3w/1PE0HjLOE4qGLzP50izV4F0ORoFK1nAq1N7E8WA871Y93w5qOsTMuGP09d6RAgKAw9pqziS8IkC1WxfLfO4sDbw4mbjZGbFcWSiYpHFeHqVE+Q9tkX4thK31qgZT0IeAdtHrJ29f73keH5mc=
Received: from MW4PR03CA0162.namprd03.prod.outlook.com (2603:10b6:303:8d::17)
 by MN2PR12MB4392.namprd12.prod.outlook.com (2603:10b6:208:264::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 05:37:22 +0000
Received: from CO1NAM11FT086.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8d:cafe::f1) by MW4PR03CA0162.outlook.office365.com
 (2603:10b6:303:8d::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29 via Frontend
 Transport; Fri, 28 Jul 2023 05:37:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT086.mail.protection.outlook.com (10.13.175.73) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.29 via Frontend Transport; Fri, 28 Jul 2023 05:37:21 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 28 Jul
 2023 00:37:18 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v2 03/16] iommu/amd: Consolidate logic to allocate protection domain
Date: Fri, 28 Jul 2023 05:35:56 +0000
Message-ID: <20230728053609.165183-4-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230728053609.165183-1-vasant.hegde@amd.com>
References: <20230728053609.165183-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT086:EE_|MN2PR12MB4392:EE_
X-MS-Office365-Filtering-Correlation-Id: 2de58cff-010d-4bfb-24c8-08db8f2cb730
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	927wamgEnzDZnPjZXlvAhF9X1UsAmJ1Zny3hIBt1QcdHlWhoLPmEH6gjOy4z2nP9DHhbEfA0jT3c0TExciXFzfjrU74n9VZUv1pJ6XAUHflzZrCaRBRBnCYYKtywSKht7SGwDpzErffI/2NQzlNndDYKxP75o1GsQ+3W3090GScfAtxzNihp4IY4WtlHwkU71eD+6zlLH4hq5/Cq2iA61LuVcxNfblSliDX4sUSbZGNKvKa/dNJ2xG9p5SZRLD8tl85UfCbiXDgrm3amJnqFHzq3dT24KO4eF/UWfCbkaOntaIxTxzKfgu8zmw+8mgCi2gHVBzhBUhkpTiY0Njr6rfi9wIvKzuRzBCQ7IxsSLGFnM+kmXS1xR7qzvohhzU8YGzmbBbRKuReNmx6q7Z6bs+V1Yien00dSY/S+kjTEY7UZbDQFlNg2jdVaRu3+P9j0D833sv1CA/rxx7qFD1/B90cbHiBLRI6bc1nb+cQB9sYnMmu2MIcWwdYiGQCZGF21ngs2eblGUp42CrpZoEtkU4j8zMwrJw+upN4iqxyzdpf3NIUUlnYkY7duPPvSAnf+K3sg6iR3U+UiCnHRmSbotbO2lTSOAoMzq98oDLdBwyWSkH+GnJ4b8ucw9clonvihhcwZblRWOZR/axrZ2fum2df5knOuCaR9s1Z/Q6VASDEOEbUTueMqovzo193n/xkjp127dsYVDLTNhVVLYsg1jNO/o3M8GM+M5LPowmos5f2vMdA4pvLYvaoJAJii9rwRI9drI5+L4U7KtXT8HO4Y5A==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(136003)(396003)(346002)(82310400008)(451199021)(46966006)(36840700001)(40470700004)(2906002)(316002)(8936002)(8676002)(5660300002)(44832011)(41300700001)(40460700003)(36756003)(40480700001)(86362001)(426003)(7696005)(6666004)(81166007)(110136005)(54906003)(82740400003)(26005)(478600001)(1076003)(356005)(336012)(16526019)(186003)(70586007)(2616005)(83380400001)(70206006)(36860700001)(47076005)(4326008)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2023 05:37:21.6213
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2de58cff-010d-4bfb-24c8-08db8f2cb730
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1NAM11FT086.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4392

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

Move the logic into the common caller function to simplify the code.

No functional changes intended.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
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

