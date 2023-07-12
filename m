Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2041.outbound.protection.outlook.com [40.107.100.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC3F100AE
	for <iommu@lists.linux.dev>; Wed, 12 Jul 2023 14:16:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h2m6Xb1DFIFj1VH1O398Ip5Wy+RE3qZ5gxPiHfIboiLwpIbzpgAZ+Vu3ePfB1g8fVWBLE317mxZBWFehx/XSSFUIFf4YMpE3/LsAa6uXlZtp1wc2NkPWY/o7Pi/nV7a/eGCf/NXiZxQzeECq1ovxpJJMwX2dyTKvfaJwAIfUdy9p49W8DFa3uF8Vt7aSgxhqROkNU2ooi5dFi6bhXqLsGVXq9A90IBPfsJc//p2NSxS8BAbyblbbIyj4MlzOnSVp00WD3EnHTH6GmdbvXIIZcIYdUqcSJLPxTXjzMmW8f7pAx2ywlL4720Wkmsp6Q6j23GI49NjdzovSFYfVl/GNfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4dc5a2j8esorDdzFblw93HfrSVojihGxMaNMRSx0dRY=;
 b=CSTMT7grpb3Df7F5JQ7XyM9I/slRyvhxpVEUfI1nr7ZRSlyxJjUYhYwGASsgahvbQWbKVThCD3Pqc8hT4SaaVrKOFo5SRu2fJ7guKBVoC1CV92K8VJxwT66oj7x/ZZHZuwrrynpQTq9kHTbumSqXnM6NF/Ye2t5UDIBwOvxiX/vrmJCaD2121QGhMyq0BR5UtVvxLLdWr/elprx/nyWklEe7MRwwRF560I1iAkT1tVa380tDVEBrge+lM9Q4SA0RLRpaeK+t7RTEKlvTEzOQ/nxsLmNi2qlQI8tyxlLL5zPZ06cSbvJG5xE5Oftl8uli6RWGM+mhkJci9j+8iME56g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4dc5a2j8esorDdzFblw93HfrSVojihGxMaNMRSx0dRY=;
 b=2sXBb8FReaDy35A1fLZ9styjG6OOMQqCeMEr6O4h0qHrXnYj1Gb6robDt43SoPrfMcl/QpI9xCPiMQuCs2m8AcXbr1/ITpTWn1+jVtQOw94Jr6tc8kcUfVyjE5tXjKyJJDjU1Mjdy/Vii5wI2BsEo4zEw89QBo1wOBavD6oZLBg=
Received: from DM6PR12CA0010.namprd12.prod.outlook.com (2603:10b6:5:1c0::23)
 by SJ1PR12MB6027.namprd12.prod.outlook.com (2603:10b6:a03:48a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.22; Wed, 12 Jul
 2023 14:16:38 +0000
Received: from DM6NAM11FT026.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1c0:cafe::6c) by DM6PR12CA0010.outlook.office365.com
 (2603:10b6:5:1c0::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20 via Frontend
 Transport; Wed, 12 Jul 2023 14:16:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT026.mail.protection.outlook.com (10.13.172.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.22 via Frontend Transport; Wed, 12 Jul 2023 14:16:38 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 12 Jul
 2023 09:16:36 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH 03/21] iommu/amd: Consolidate logic to allocate protection domain
Date: Wed, 12 Jul 2023 14:14:58 +0000
Message-ID: <20230712141516.154144-4-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230712141516.154144-1-vasant.hegde@amd.com>
References: <20230712141516.154144-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT026:EE_|SJ1PR12MB6027:EE_
X-MS-Office365-Filtering-Correlation-Id: e01b648e-309b-48e5-4dbe-08db82e29b4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	YvSyxOTl5FbdceNrpfqXEOWXltPgvnxbbT8CkH2BTE5CClBzoL//z5i37vC+VlygXC9Dj2Sh3+h60smOgeIYPI35Sk2/cWoO/OW6iv3dBAHuAalcKBWTXMA4lzif73WUl09hJLJY0SsVUH5EOUkj1C/Yvg1Hz/dG0ziPZ3a0zLRA2QOqUH0tnaKtkPXoK5dzXGxAMwqUzsgwOfF2AP53OfUK7LUcDHf+Bu5Vhy6CBWfykewYPHrv11866le9sBuQbyipH0oRCpbCU3i41COo26tTH8X2UnK/hkQowbWNO1JGdipXCNPUlkmeVTYGt4tYPXP5d4X/8JO/6tHxz2nNMZCWLHE6F90fY+15xH10qsCdxraBaftAiGVfc/Edk+9QptOhcxwnuqIvA60L+g7cxLReKuvdeQw8CETAX5cLSVtEOLm/u6C9qaU196pK2e2LNeHVcOOkucEZJAPkcXwcxc/74AOb87UaNc4eALOvZN7126d6qGbEAvd9eFAME20r4rXQqEX5cpIh1iMQrsLksLqjUKnXAfTkH0hv7WZDOKLnuXYXW9lGzm1bFJPaSL+6zU2RWz8ey6Ci8NIgllScQDJGmKsceQa3TS8ET3f7vrqRpiR88bfK0nrppGQBIEON4FrSybnTelPg0aJos6lNnZpykqcphyvKSv47WnuCSLw4HdhDn4xxjd9XyoukKHLvHJ8AAAx99sz6JsoVwrrHInCdpRXqq4ulmsMhqEfwE0RspWnv0D+7Fp7oBRH+mtNn5mcvWzHLRe76SDfLu3pb0g==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(346002)(396003)(39860400002)(451199021)(46966006)(40470700004)(36840700001)(6666004)(7696005)(478600001)(110136005)(54906003)(186003)(26005)(1076003)(16526019)(82310400005)(2906002)(70206006)(41300700001)(316002)(4326008)(5660300002)(44832011)(70586007)(8936002)(8676002)(82740400003)(356005)(81166007)(40460700003)(86362001)(36756003)(36860700001)(47076005)(426003)(336012)(2616005)(83380400001)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 14:16:38.2005
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e01b648e-309b-48e5-4dbe-08db82e29b4f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM6NAM11FT026.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6027

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

