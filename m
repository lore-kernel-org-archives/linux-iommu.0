Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2077.outbound.protection.outlook.com [40.107.92.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21FE100AE
	for <iommu@lists.linux.dev>; Wed, 12 Jul 2023 14:17:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DkCLqJCBJE6xekH6tmvM1TAQjqJXmVMPDdL1jEV8z6PYS6wwjBuSivb4NtVQmYzW5kqDRd3ug0uquteg+zTEDvU/mBpRHyY57tJA93iRWbAhNCsjxn0O9aj3EIr8eo0jVBigwpNnk3meXJEx3n4w+u5kNXMnp8+yeApebOgqupXrGq+Oo5UPo4pAdvRSO0isIye29+96zeqdjeT6y2s2lNVddpfizukN2b9kyDOcVREoXiQjiJmzgmUXQMo9ruqCERnubzZ6A8zOfre8rDceMJKMWl5VScxBp1IspQnaqF/CNwI6paSbeVWClaL8FsOKBNPhkdMnjOM/a3JSE154QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KjmoFO4K4BApcvd64z+yzhcDcH5y8oL8EDZbZcNrZBw=;
 b=KNIX10lCPZEptig4Rli0etZeLJNsu97yoQdofNndHRteUT48j+ow1XINFr1i3LkogNjE+LN/mgRwBcQ2D2ZTuxlr2vMBqBVbD9NRoAj1J8+8G7EZ14ko9MNx+4H+ZbHyP5NXg57e9sNYyNE8dzC7onhxwjJJKOIjAWt+JDN1Fj8v443cX3dlSgZf0dYVh0XoJuvASyIwKy/sKE0NHi8skpyLVX9+rtKovab+5/Mk8SIElNOZ9ZC0M8NzqevAATVfJecxyKHabPPAsR/aPCKXks3XDXAnykTVrYCo5cJjtDkj8f+pIkj3itGAzuWAcHMA8X4tzTpHXepOm6stN2WyuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KjmoFO4K4BApcvd64z+yzhcDcH5y8oL8EDZbZcNrZBw=;
 b=E4tpwyjP5uIs+nCvL+5TnjcGD1J1jzNp+2Go4dSFR1TRKsur31pHG/jLsKZDbykidrr7OWqGRwwDWVJp4vEIv2gdbX553rYnwLqd3dro1HoiL2e19NLCu8dK9EJUxKXX6WyTTwYwxhDSJV0sKFcnhZ/NbNuCbnwRrHLJYKKOnzo=
Received: from DS7PR03CA0254.namprd03.prod.outlook.com (2603:10b6:5:3b3::19)
 by DM4PR12MB5184.namprd12.prod.outlook.com (2603:10b6:5:397::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.22; Wed, 12 Jul
 2023 14:17:24 +0000
Received: from DM6NAM11FT113.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b3:cafe::5d) by DS7PR03CA0254.outlook.office365.com
 (2603:10b6:5:3b3::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.22 via Frontend
 Transport; Wed, 12 Jul 2023 14:17:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT113.mail.protection.outlook.com (10.13.173.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.22 via Frontend Transport; Wed, 12 Jul 2023 14:17:24 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 12 Jul
 2023 09:17:21 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH 06/21] iommu/amd: Introduce helper functions for managing GCR3 table
Date: Wed, 12 Jul 2023 14:15:01 +0000
Message-ID: <20230712141516.154144-7-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT113:EE_|DM4PR12MB5184:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ffb4cbb-d127-4910-05f2-08db82e2b6bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	AnOlRWPX2/YwmGPZF3p+La1mada7uZQyEMISrYmraN68Fhr9+QO5UFtYuKaUFaNnT7IjQGhKIbOc7Hue7rvP+eVyPVh1i/E2EiKcKEpzCFwUXhcV2K/Ciu4chLbUlfK/9txFet6BTcalCtkcHqe1B1ORV4RGCtWtrNd64JoBaN1yC00pacMjRS/XbF4YC1Kree0U2vR87k7Z30zSm/PlWQn/4GL7cN3Bq5n0o7Y2vHJ6eJAW7Bwwnamh/GDQ+y3DtTfLEfBvgTa2P/r8uiFVW4pFnU+ycAPNPjybrI9FvkX3spzLfG/yPI55xE9mrEpXfTFIRTC5s86hA9rQtlCd/z53rFg/Jlf7oPJ7So4cwu8nsvwiAQmE3HJ+SoQyqDimHKjZuFDYi8q3BOERLCDxo0bUMiSxr+vOsKFi/P+VttC1XDhNKN94ykCddpDZh2OJgyel8CeS57lkOUi56jKauaRuvolzS5+ZVZt4uVYpZ6XPOUvIRgCYHI87G8mTb1neSkdutvVn6cG/j2t69ohhxGivSPPzqBFAz1HfxppdQLJhffV0UCZhNg2qa7BZPkadVzsVvWTAdkxYmDvIx4qzx3GSQf/cQoXOuBZ1DAKwgzcXssqbickB8DItRYPQzrWWNwR0u30h/PCA8gp6Zg3m6uv5FhftUoWCh7+Rsl6OJYXr+osx4ueQ55OwI9bdmcI9U7JzZhhkciGUW7li/DZrmeR5wrUXxQZ9bgB52x+mn36HTqIHffo314XpNxbixhXAtexau3TYN0neO5gC1DFfSg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(396003)(376002)(39860400002)(451199021)(46966006)(36840700001)(40470700004)(82310400005)(478600001)(356005)(81166007)(82740400003)(4326008)(86362001)(6666004)(54906003)(110136005)(7696005)(70586007)(70206006)(316002)(83380400001)(41300700001)(36860700001)(47076005)(426003)(2906002)(336012)(36756003)(2616005)(8936002)(8676002)(40460700003)(26005)(16526019)(1076003)(40480700001)(5660300002)(44832011)(186003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 14:17:24.2271
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ffb4cbb-d127-4910-05f2-08db82e2b6bc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM6NAM11FT113.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5184

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

Refactor domain_enable_v2() into helper functions for managing GCR3 table
(i.e. setup_gcr3_table() and get_gcr3_levels()), which will be used in
subsequent patches. Also re-arrange code and remove forward declaration.

No functional changes intended.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Co-developed-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/iommu.c | 63 ++++++++++++++++++++++-----------------
 1 file changed, 36 insertions(+), 27 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 287c979239c3..a278bd9aa9e6 100644
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
@@ -2514,30 +2547,6 @@ void amd_iommu_domain_direct_map(struct iommu_domain *dom)
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
@@ -2556,7 +2565,7 @@ int amd_iommu_domain_enable_v2(struct iommu_domain *dom, int pasids)
 		goto out;
 
 	if (!pdom->gcr3_tbl)
-		ret = domain_enable_v2(pdom, pasids);
+		ret = setup_gcr3_table(pdom, pasids);
 
 out:
 	spin_unlock_irqrestore(&pdom->lock, flags);
-- 
2.31.1

