Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2055.outbound.protection.outlook.com [40.107.94.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8FCB1FC8
	for <iommu@lists.linux.dev>; Fri,  4 Aug 2023 06:44:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cnQjeRKYtHhohgbRLIPHWZDdQqQG5eewFn307PTlB5sJsxxmNAi/mwVNmZ8IK3yjbPJk6rTGzwlPwK9c3ljHHUlIHPAdVj25SgeBefzeSX1j1KDj16uvRRYenhQuOIVt3m+9TDUnjsMwHkt27W0pmGmTX/mkXRVtv7oVg2np6SHpakYEamspl6i4PGs2FZgBWjwornyyrjrQS6fmZxjeWt2jHHx/JHXwNEk3mt+Ql+tq4YYM2SZNvLZfG9TXCEaDa4hE2cuLHBZl24A0Drl2lFHwlQ8O1GTqeKzCQaaYBM1Vu7nKlBZS95sfpkht1fpwOuIk/wkSiomtXRRA/09ftA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CNYzZwhK8L7PYX1jHKtb4hhBAiTdL9xmwJZcnxZzjYk=;
 b=Vq2jbEy+CQ6jZL4fKhscHhBUW2jgKCLMwj15CsI5JC7002paOEgoy+1R16rISD8Lw404bLH3nj++CBCs4YxysjGanRbY1dMT6iF836qx6qbf96lpZP925P21DcchQKb5RfSHL6Jl0Wlgsfuk3i6g+yw3GgCykEF/NzBBl3fwh5bxbJvEz+xq/RL/VAYApvcU0rpySthe3tb5qHyi+5Pytg+WEcsrifVHo3O1Eg9vsEzr9HMNcaBGn8m5ITBxeMl9OJpG/cj0HNCN6V0yyuDOXJ75zorESf7qmmvlu4BDLJaAU+YKf70EnHzyZbdwJsBTCnS5lfw91+gG84vHeBmAqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CNYzZwhK8L7PYX1jHKtb4hhBAiTdL9xmwJZcnxZzjYk=;
 b=mhMlPeFVebjTGeMZiuJ4yc8BB+EniDesK/xoOWHFehTXBFyu1dc6x1FT6Ep5SoL3l+MUibIKJsPH2P4gBG+rI6NstuyWsWURv3accyxUlEWRheT2m1L5FudpHalo0t8JjLatscw9wJD7tANLVZQHAU9vIivvVRWeulgYjXcSFuA=
Received: from CYZPR14CA0032.namprd14.prod.outlook.com (2603:10b6:930:a0::9)
 by CY5PR12MB6381.namprd12.prod.outlook.com (2603:10b6:930:3f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.21; Fri, 4 Aug
 2023 06:44:28 +0000
Received: from CY4PEPF0000E9D3.namprd03.prod.outlook.com
 (2603:10b6:930:a0:cafe::1c) by CYZPR14CA0032.outlook.office365.com
 (2603:10b6:930:a0::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.21 via Frontend
 Transport; Fri, 4 Aug 2023 06:44:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D3.mail.protection.outlook.com (10.167.241.146) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Fri, 4 Aug 2023 06:44:27 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 4 Aug
 2023 01:44:25 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v3 06/16] iommu/amd: Introduce helper functions for managing GCR3 table
Date: Fri, 4 Aug 2023 06:42:06 +0000
Message-ID: <20230804064216.835544-7-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D3:EE_|CY5PR12MB6381:EE_
X-MS-Office365-Filtering-Correlation-Id: 66106281-ad08-4f08-1444-08db94b63fed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/dt/aSWPZx6gVqTGkdlFJR4D4b4oIuuFRJ/+e+KiaAsxnTzjQOoPxXrsDTDD+Icn4XSnvdvrBzLm04JUIw1hk3olbOv6fijanyLCqDp3D2HMXDlT1O1r6N3b18NPH2vjhD1kiUwlzXn6Dt+PhL/7Cf0cw249q6soeqSfZGDdWIs7n/pGZYc0/rJu7nttQ4L+BAZCZGaOkgwcLtsGZswDDgzhugngI4TEB4+AfRE1Ffbwlva406yjiWslbYDWhBO+a5LRuGr0Ne3T7JiLErIQIjc9HfETvqSfm/7lBHcoOzzY6rIjSK7MnXKBqHWSHuzFuk8/RHD/At1uF504UweDQBfSpogixZxWZYxzWkdlmoRCHgS9VhigMw+gMQjBpEdu8FFk4xZ1JQl2cYrLWwAskCtMv3lo0wUlpbUqWqkGUIWDJSLn6LU9NxCTBN0ofYoDeDiZySx0S0V1L2Enor7lu+ijRHgNHWpIHzLM6VcFJTSN86CbvjGX4F5yE2vQZHqwcFhMecrMAtK6zaBK4I+DYivrpoLPWvB0xOqaNJup52LshuebSff9nnDkkOopQMfWtOkky2NI2aXFoXWTWQtRNFmQn/zur/C4uLW8007zO6ABQeDhrpjFcAm38Meu8NEHGjGvciRmF92Un8LHaSBZ9dcsY8cU+6bi0zCqaSbnAlFlkyv1B4+Q3p6YjbmcIdgRluys22Fum1fDgRhD4nE8mgouL3FKMYmJ0lpuho1ITYE6/NzCOEWoLTQ5GC6MMW7nGupdVhxsFPLBi/GLZiqoJQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(376002)(39860400002)(396003)(186006)(82310400008)(451199021)(1800799003)(46966006)(40470700004)(36840700001)(44832011)(4326008)(40460700003)(70586007)(70206006)(2906002)(82740400003)(356005)(426003)(81166007)(2616005)(1076003)(16526019)(336012)(47076005)(83380400001)(36860700001)(54906003)(110136005)(40480700001)(86362001)(26005)(478600001)(36756003)(7696005)(6666004)(8936002)(8676002)(5660300002)(41300700001)(316002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2023 06:44:27.9423
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66106281-ad08-4f08-1444-08db94b63fed
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6381

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

Refactor domain_enable_v2() into helper functions for managing GCR3 table
(i.e. setup_gcr3_table() and get_gcr3_levels()), which will be used in
subsequent patches. Also re-arrange code and remove forward declaration.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Co-developed-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/iommu.c | 66 +++++++++++++++++++++++----------------
 1 file changed, 39 insertions(+), 27 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index d5569eec0fe9..135fa087ce47 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -77,7 +77,6 @@ struct iommu_cmd {
 struct kmem_cache *amd_iommu_irq_cache;
 
 static void detach_device(struct device *dev);
-static int domain_enable_v2(struct protection_domain *domain, int pasids);
 
 /****************************************************************************
  *
@@ -1575,6 +1574,43 @@ static void free_gcr3_table(struct protection_domain *domain)
 	free_page((unsigned long)domain->gcr3_tbl);
 }
 
+static int get_gcr3_levels(int pasids)
+{
+	int levels = 0;
+
+	if (pasids == -1)
+		return amd_iommu_max_glx_val;
+
+	/*
+	 * Number of GCR3 table levels required. Level must be 4-Kbyte
+	 * page and can contain upto 512 entries.
+	 */
+	for ( ; get_count_order(pasids) >= 9; pasids >>= 9)
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
+	domain->gcr3_tbl = alloc_pgtable_page(domain->nid, GFP_ATOMIC);
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
@@ -2065,7 +2101,7 @@ static int protection_domain_init_v2(struct protection_domain *domain)
 
 	domain->domain.pgsize_bitmap = AMD_IOMMU_PGSIZES_V2;
 
-	if (domain_enable_v2(domain, 1)) {
+	if (setup_gcr3_table(domain, 1)) {
 		domain_id_free(domain->id);
 		return -ENOMEM;
 	}
@@ -2514,30 +2550,6 @@ void amd_iommu_domain_direct_map(struct iommu_domain *dom)
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
@@ -2556,7 +2568,7 @@ int amd_iommu_domain_enable_v2(struct iommu_domain *dom, int pasids)
 		goto out;
 
 	if (!pdom->gcr3_tbl)
-		ret = domain_enable_v2(pdom, pasids);
+		ret = setup_gcr3_table(pdom, pasids);
 
 out:
 	spin_unlock_irqrestore(&pdom->lock, flags);
-- 
2.31.1

