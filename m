Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2076.outbound.protection.outlook.com [40.107.96.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C697B23AE
	for <iommu@lists.linux.dev>; Fri, 28 Jul 2023 05:38:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OaE2+97ldvokEyEPE1gJ2MhEiZMc7BsKLq2IpgXJ7F/AvWO2MS09LXgQCbqtQceYBnTAVYDYA1aQToQpOp4yEVOcURvNl0sAPTtLdZd4/jfInSLQq5cMryhUCzkUyGaQfQ/+US26xw8VsCkylOB2KrCBK/PAwIN2tTbTMVrsC8eaRwtcLDWwnmlCiSezL+Cn0FW4+v2L8NdW9wsj9f3xUbDrIMklICuql9CspXzCLRYIftuy9MVP15NEyiWNDj9w7y98WdR/ACRwgigezj4/KnZCs/qY4G6HxlfDjjPCtlZTPbh/EC1EaBojNdriL3bwUbDczMedlTghfr+E9yEw1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xyAHIaX174fjqoC105gE4EewG6Q67fpv0n94iOy9QU0=;
 b=BN34amqOUPU1xW8/nIfvZZwR6+R2LRJIQpeXxM9OXAss11GsDZAf6rXiPGnOaK0+I8sEx2OM4auabz1nrbgKB5H8ZhDcXwNutaffN0REjufYa0UKB8Bi1JLVmQjZuDnFLocQ5Tubu4cysrLr6xStJOlVnXFR8q3UfLRmGXJWZcGtBVqS8wNjj3/6mr+e8kXm/ENezHjwHhWgvGGwq60Ong1xhLBIxMk7UazUAjA1erFvG6s+/pa+djWQl/7yqktwY7BZb9ex+a0QuKB3AeDBAxgrlz9uOX/q774uZIxTBvPiOxvf4WfBTuZI6U3fsJSNWFPGuSD8I3+Q4Po+eAvTeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xyAHIaX174fjqoC105gE4EewG6Q67fpv0n94iOy9QU0=;
 b=Bu8uWAaWW6uOiDQlwYxHVSLxpQrHT2GoJC4DoFvDvJOLlLb9LmO1L/h3umh5bLO5g8QYBlEyrKRIUmZKyYAgKu8Oh3qqV7X2kJXW8dJrOhVgVRlr+cZVWy5bR+g/IfzXSwklTSROz2g5C+bC5Ev71n6XCLhjzUkIq3t1Ypo+IdQ=
Received: from MW4PR04CA0286.namprd04.prod.outlook.com (2603:10b6:303:89::21)
 by DS0PR12MB8365.namprd12.prod.outlook.com (2603:10b6:8:f8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 05:38:14 +0000
Received: from CO1NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:89:cafe::6d) by MW4PR04CA0286.outlook.office365.com
 (2603:10b6:303:89::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29 via Frontend
 Transport; Fri, 28 Jul 2023 05:38:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT032.mail.protection.outlook.com (10.13.174.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.29 via Frontend Transport; Fri, 28 Jul 2023 05:38:13 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 28 Jul
 2023 00:38:10 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v2 06/16] iommu/amd: Introduce helper functions for managing GCR3 table
Date: Fri, 28 Jul 2023 05:35:59 +0000
Message-ID: <20230728053609.165183-7-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT032:EE_|DS0PR12MB8365:EE_
X-MS-Office365-Filtering-Correlation-Id: 46c50fe9-6daa-4e25-e12b-08db8f2cd65b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	e9FAZGd2rY4tKgTCOclaWQarhazjgZ682/X9BzmPPxMl+bzAb7GmU7Q2YzzOiq0MhNNtjdxobGMXxzww9S3Q8WFoX3j36lyA/66jl0S77RX0aqy1ognKPJUALjDK4h2nrqWPW2+ZLWOyeHjYroh+14h0LnqCkvw6LlnqquVXlmMsPnmJYtJGgp0SxniR0V4eokihzf0coYOzhJfSCHbxjZMBW6PXAhrMRg7qdZ0bsqit8FOjKsZ9Zl7jvGS2rK1Fwc4S22lKCMJoOVyv3143B4Z5C5qwdTx22jLhYV7HpJSN/A26pFrbE//dro/lruccs2nknz/Pn1jDCdQgdBnHl+V3ZuwfW/u0XlnFAHzKCwud+cL3RDSNxRNh67D4Ajh0WyVUNMkHc9xjR/Ts2cXnsItGcfcPuQrgGVXNw89wR+9ICwGihnwLNzdG2w1FOTwZurQ9hFz0mVqBoXkSUJo0CQuG0qaCZm240YepDIlq7HEFgk85PE7x97JPos4wdls8aTlgVj185DP6CrA4cLg7+dYO69aYio+91rJauPaGLdgk93WqYbrFAi/pHrOY7Zj7TmYjH7GWDFn/77kZnEEvXifZzsgUsfH3DpHzbbXEdV36xiSqWhogw1pOxztLs1Y+QiEYtOunyrPbwahR35u0tgGmCqdd15qqCZMo98jhZZcawuHePygc+12JFXb/XtdOQMCF/zWs847v5dUXfPYxk/a27wTvjJg8jeM8RkP0Jhm1DL6A1j0CeyrwhyQBWaXIXALV1hCxLWJNJnML8eIpPA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(136003)(376002)(346002)(82310400008)(451199021)(40470700004)(36840700001)(46966006)(2906002)(316002)(8936002)(8676002)(5660300002)(86362001)(41300700001)(40460700003)(44832011)(36756003)(40480700001)(1076003)(26005)(82740400003)(478600001)(356005)(6666004)(7696005)(47076005)(83380400001)(16526019)(36860700001)(336012)(426003)(186003)(2616005)(4326008)(70586007)(70206006)(110136005)(54906003)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2023 05:38:13.9329
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46c50fe9-6daa-4e25-e12b-08db8f2cd65b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8365

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

Refactor domain_enable_v2() into helper functions for managing GCR3 table
(i.e. setup_gcr3_table() and get_gcr3_levels()), which will be used in
subsequent patches. Also re-arrange code and remove forward declaration.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Co-developed-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/iommu.c | 63 ++++++++++++++++++++++-----------------
 1 file changed, 36 insertions(+), 27 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 09749ad4445c..3c14c49d6d72 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -77,7 +77,6 @@ struct iommu_cmd {
 struct kmem_cache *amd_iommu_irq_cache;
 
 static void detach_device(struct device *dev);
-static int domain_enable_v2(struct protection_domain *domain, int pasids);
 
 /****************************************************************************
  *
@@ -1575,6 +1574,40 @@ static void free_gcr3_table(struct protection_domain *domain)
 	free_page((unsigned long)domain->gcr3_tbl);
 }
 
+static int get_gcr3_levels(int pasids)
+{
+	int levels = 0;
+
+	if (pasids == -1)
+		return amd_iommu_max_glx_val;
+
+	/* Number of GCR3 table levels required */
+	for ( ; (pasids != 0) && ((pasids - 1) & ~0x1ff); pasids >>= 9)
+		levels += 1;
+
+	return levels;
+}
+
+/* Note: This function expects iommu_domain->lock to be held prior calling the function. */
+static int setup_gcr3_table(struct protection_domain *domain, int pasids)
+{
+	int levels = get_gcr3_levels(pasids);
+
+	if (levels > amd_iommu_max_glx_val)
+		return -EINVAL;
+
+	domain->gcr3_tbl = (void *)get_zeroed_page(GFP_ATOMIC);
+	if (domain->gcr3_tbl == NULL)
+		return -ENOMEM;
+
+	domain->glx      = levels;
+	domain->flags   |= PD_IOMMUV2_MASK;
+
+	amd_iommu_domain_update(domain);
+
+	return 0;
+}
+
 static void set_dte_entry(struct amd_iommu *iommu, u16 devid,
 			  struct protection_domain *domain, bool ats, bool ppr)
 {
@@ -2065,7 +2098,7 @@ static int protection_domain_init_v2(struct protection_domain *domain)
 
 	domain->domain.pgsize_bitmap = AMD_IOMMU_PGSIZES_V2;
 
-	if (domain_enable_v2(domain, 1)) {
+	if (setup_gcr3_table(domain, 1)) {
 		domain_id_free(domain->id);
 		return -ENOMEM;
 	}
@@ -2515,30 +2548,6 @@ void amd_iommu_domain_direct_map(struct iommu_domain *dom)
 }
 EXPORT_SYMBOL(amd_iommu_domain_direct_map);
 
-/* Note: This function expects iommu_domain->lock to be held prior calling the function. */
-static int domain_enable_v2(struct protection_domain *domain, int pasids)
-{
-	int levels;
-
-	/* Number of GCR3 table levels required */
-	for (levels = 0; (pasids - 1) & ~0x1ff; pasids >>= 9)
-		levels += 1;
-
-	if (levels > amd_iommu_max_glx_val)
-		return -EINVAL;
-
-	domain->gcr3_tbl = (void *)get_zeroed_page(GFP_ATOMIC);
-	if (domain->gcr3_tbl == NULL)
-		return -ENOMEM;
-
-	domain->glx      = levels;
-	domain->flags   |= PD_IOMMUV2_MASK;
-
-	amd_iommu_domain_update(domain);
-
-	return 0;
-}
-
 int amd_iommu_domain_enable_v2(struct iommu_domain *dom, int pasids)
 {
 	struct protection_domain *pdom = to_pdomain(dom);
@@ -2557,7 +2566,7 @@ int amd_iommu_domain_enable_v2(struct iommu_domain *dom, int pasids)
 		goto out;
 
 	if (!pdom->gcr3_tbl)
-		ret = domain_enable_v2(pdom, pasids);
+		ret = setup_gcr3_table(pdom, pasids);
 
 out:
 	spin_unlock_irqrestore(&pdom->lock, flags);
-- 
2.31.1

