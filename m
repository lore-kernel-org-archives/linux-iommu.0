Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2059.outbound.protection.outlook.com [40.107.93.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C4B510788
	for <iommu@lists.linux.dev>; Tue, 15 Aug 2023 10:23:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UbkjZz0sBYcxyddbk+FFTtOsGUaIhFFcqJ2dIMIzDtoGFW43KVP6Yu1VbR3+C1tFinJSFGD67nVO6YSpTxAfPB17ChkpCZKxSpGvixd4dvnPxF+bXuWr7fkYx2AqOKMitY9kgY5AtJT8l6YQQJ6KOJYJstVuAiI8Rg7HVfzpBTE715doUPTb3OVJhD0GIlIjgm/n/CZy+6nJP/UhZK5zZaUXtSDSUQbPdYfSYi0NpvyQUfqIaZh5vk45/JcTOv+47/xUZGsVkLUF+/blWfNB07gOO9398QS7EAbcX5dTJ5Xtfkh+b8v7AN0YRNvdV+MYBvTLfVWduvoLlPu63fFYTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=awuERE5H1a6nnzEUgn8PayH8J21BWnA2ReOab01alAs=;
 b=YsDrp6un8DApxP5F3tqzmP5eIybbMMcXJfecVfW1wUVgTJPh+vl8fP1RQOUOYuOykoTCpJyNoBRbGlIij5169mTSbW62o9mUdTowJj+sTfE5VayZNT71JPBMhjJR2SU9jvXHkB2lkBnJrUZ26+mIrblGkb9VBtdyQCpOVcAc/YA1ht8KIT+couUAca28CJM7dYvFUGKLudt3TtYT5qa+6RnGlK0MLmFuTAaMPCpGsWeGOqY1Z8p7w+MGYIihPjmoiGuOzIFBHbCIGvbISN319+M+gGqt3lHPjQ++wFJ3w5vPpeD8QARy4l1SsrpK36rpKR2gStYOkDckLiGszLAOsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=awuERE5H1a6nnzEUgn8PayH8J21BWnA2ReOab01alAs=;
 b=Cg4SKISaUVk5kG5h8fBzySpr+EobeGV2IX+r1NZrwdtWBv7fqRgGLFDLcx5OcmTtEK9rgagpB2NKrk5teyWK940gPQmvlt5LOoDL4KmDM7SkVgnWy1zJRpaKHf894jRExkF+ppUXHfxHbADH6eKGZwfm1TmqyzLgJajTv+7BHKM=
Received: from MW3PR06CA0006.namprd06.prod.outlook.com (2603:10b6:303:2a::11)
 by SA1PR12MB7174.namprd12.prod.outlook.com (2603:10b6:806:2b1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Tue, 15 Aug
 2023 10:23:57 +0000
Received: from CO1PEPF000044FD.namprd21.prod.outlook.com
 (2603:10b6:303:2a:cafe::4c) by MW3PR06CA0006.outlook.office365.com
 (2603:10b6:303:2a::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.33 via Frontend
 Transport; Tue, 15 Aug 2023 10:23:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044FD.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6723.3 via Frontend Transport; Tue, 15 Aug 2023 10:23:57 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 15 Aug
 2023 05:23:54 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v4 05/14] iommu/amd: Introduce helper functions for managing GCR3 table
Date: Tue, 15 Aug 2023 10:21:53 +0000
Message-ID: <20230815102202.565012-6-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FD:EE_|SA1PR12MB7174:EE_
X-MS-Office365-Filtering-Correlation-Id: 82815a90-51ca-4792-1b59-08db9d79bc18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	So9Yh+dET5ciPAjMDfLXqfSyxHuvt/XC2G6K0z/BdLpOJFZ30BxyBsS8yBZJXPDG12yQco3QUvMN+Q72Qg8jU9BO00+hc2jE+ccuokk7oFWjiB8bUYAXH2p656BacPsBPmVR0BR9zdxVC7+B1hFCps9jEpXe3o3QyY6g7gnOGEtXZ3B395cl165LRu1HTTgeC7Re5yyZtdcV8wypIEJpeodfUQQmpNKllWs/1xtE1E/gcnE1KUBheSJ32HEJESFf9tL5jljrNcBDEUfokLy0Dl4XrrcYLhc4sEHV3rwuXTXA+Pgq+hMF4XMeaJuvvGRs89v9rvmmglBiTlh0u6cl3LO4PGeci8ZpYaASOM6wSTsLzJ+DYBOzzLYUrYDSh7DlikEElufEqhArvnEZlD8YITWcE3fNMobzprCEth5BECNorkn16WJvpuDcn6eX8D6IctN2sJLHiUTXUJW4q5oRl4uxEhhnaK07kQcWsA7GcqMchN+IIFmjCEttyw7i4g+Ensw09S9ck2pAPNm5lTTpzbM1hL9F/nAP6ri1Gxm8Xsn5tPgVszeQkBe95iGRlNOFWLtwuNdC8jZv0aS6egkXeXqzKBwSSmkbbfiTCQtBdLwr+fdokNz6ipSTH8MzrBc7KvgX43nhu8/Mn4r/VKW2xeehaJYu2L6mh5YUw5MyQp2nbvl2MkTORooO038lLExrVLRG/+GgXJvlm9PzbAZVybxuAOCi8QUV9vIkRrqKhd1qpMy48cLOFj0SSVAClorVpQDnpGGPkAOXQjK3NRg4cw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(376002)(396003)(346002)(1800799006)(186006)(82310400008)(451199021)(46966006)(40470700004)(36840700001)(40480700001)(40460700003)(356005)(478600001)(81166007)(82740400003)(8676002)(8936002)(83380400001)(110136005)(70206006)(4326008)(41300700001)(54906003)(316002)(70586007)(36860700001)(47076005)(7696005)(2616005)(1076003)(26005)(426003)(336012)(16526019)(86362001)(2906002)(5660300002)(44832011)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 10:23:57.3638
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 82815a90-51ca-4792-1b59-08db9d79bc18
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044FD.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7174

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

Refactor domain_enable_v2() into helper functions for managing GCR3 table
(i.e. setup_gcr3_table() and get_gcr3_levels()), which will be used in
subsequent patches. Also re-arrange code and remove forward declaration.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Co-developed-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/iommu.c | 65 +++++++++++++++++++++++----------------
 1 file changed, 38 insertions(+), 27 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index d5569eec0fe9..bf1640f4287c 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -77,7 +77,6 @@ struct iommu_cmd {
 struct kmem_cache *amd_iommu_irq_cache;
 
 static void detach_device(struct device *dev);
-static int domain_enable_v2(struct protection_domain *domain, int pasids);
 
 /****************************************************************************
  *
@@ -1575,6 +1574,42 @@ static void free_gcr3_table(struct protection_domain *domain)
 	free_page((unsigned long)domain->gcr3_tbl);
 }
 
+/*
+ * Number of GCR3 table levels required. Level must be 4-Kbyte
+ * page and can contain up to 512 entries.
+ */
+static int get_gcr3_levels(int pasids)
+{
+	int levels;
+
+	if (pasids == -1)
+		return amd_iommu_max_glx_val;
+
+	levels = get_count_order(pasids);
+
+	return levels ? (DIV_ROUND_UP(levels, 9) - 1) : levels;
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
@@ -2065,7 +2100,7 @@ static int protection_domain_init_v2(struct protection_domain *domain)
 
 	domain->domain.pgsize_bitmap = AMD_IOMMU_PGSIZES_V2;
 
-	if (domain_enable_v2(domain, 1)) {
+	if (setup_gcr3_table(domain, 1)) {
 		domain_id_free(domain->id);
 		return -ENOMEM;
 	}
@@ -2514,30 +2549,6 @@ void amd_iommu_domain_direct_map(struct iommu_domain *dom)
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
@@ -2556,7 +2567,7 @@ int amd_iommu_domain_enable_v2(struct iommu_domain *dom, int pasids)
 		goto out;
 
 	if (!pdom->gcr3_tbl)
-		ret = domain_enable_v2(pdom, pasids);
+		ret = setup_gcr3_table(pdom, pasids);
 
 out:
 	spin_unlock_irqrestore(&pdom->lock, flags);
-- 
2.31.1

