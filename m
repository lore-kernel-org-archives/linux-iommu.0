Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2077.outbound.protection.outlook.com [40.107.223.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C5710788
	for <iommu@lists.linux.dev>; Tue, 15 Aug 2023 10:23:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DSrMUniZyFEftQ1B/p3DOWniuYx2xRaVTlenUfeFsTljqUvrMnZZ9quY5kms/z849TTV76akeSwsxfaGFdwnNPXhRfwmCHo4Zq0/eBZUcgw2lZB2JW8RF7c30VFrVRINRChuppu9nL8JTInU7GFbtlIIiJk5kirhgAPtlgogzxP0856c3evHUb63vu4v9PRGu7dGhv2trflZGROpKnLE1x7YtN9CeWaY+gyoBfzkcxJFUy9pcvDEME205tTvdXFx9GW1uy9jPeplHX1ABXq4V3Cf8AQ+FEVm0kl+pbH5WLTHXSnvUfrR7wWEmZbGWInInTaa9RbAE/Y06vHB54MXYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dsarzsZ0z8n/AXF0AYTcvAyDe1eUVjR9vCQw9Q9JpwE=;
 b=iYUTmCihtip9BSOwSFJLbz36LQcwwiIdKi4DLP5DGVBH7a7ZTY+i1R6p2XgwYjptP8X0mdsajQnSShGurjzBIAP9qcQg1QWwQ7RvrOsXzofQr4gpanDiAKORE0yc2t0PHiphVYMb8n8Pugad3xrcbji/MPK8Ee/9vJv1L1moTQeam72PFH+6vD+XuSUAJXlZlU2RiJ5aNnzGE6aFEf/6LSGd2wX99xOl4Lh7Tz5W/wLu3XMWJvny4ofds03uJh3XaRZJY09wMU5nyfRNgLLk67HLKu10lqLMeWB+/He6izmj5QraJadbc86Dx2JaFMWYDBW9KGKEpXUdG5HEtMxcGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dsarzsZ0z8n/AXF0AYTcvAyDe1eUVjR9vCQw9Q9JpwE=;
 b=ILBbc8PuZouYvlZWsUnrsD91zeCgLXJFklx49Ys6R75c9xcZbSMc6JBbXT67NvF8MmgII63+T9aEUuG71E3I44TV4LEntOzFlwkEFNAuTsIVgYwnwfRFXPYcnYj69ugySpCkwRFOirKvxcmoqty0HIAtbWV9jaGtXTHLQh67N3c=
Received: from CH2PR11CA0008.namprd11.prod.outlook.com (2603:10b6:610:54::18)
 by SA1PR12MB8722.namprd12.prod.outlook.com (2603:10b6:806:373::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Tue, 15 Aug
 2023 10:23:42 +0000
Received: from CO1PEPF000044FA.namprd21.prod.outlook.com
 (2603:10b6:610:54:cafe::d1) by CH2PR11CA0008.outlook.office365.com
 (2603:10b6:610:54::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.33 via Frontend
 Transport; Tue, 15 Aug 2023 10:23:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044FA.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6723.3 via Frontend Transport; Tue, 15 Aug 2023 10:23:41 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 15 Aug
 2023 05:23:38 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v4 04/14] iommu/amd: Refactor protection domain allocation code
Date: Tue, 15 Aug 2023 10:21:52 +0000
Message-ID: <20230815102202.565012-5-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FA:EE_|SA1PR12MB8722:EE_
X-MS-Office365-Filtering-Correlation-Id: b3f877bb-658e-4646-885e-08db9d79b2ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xUgNIf7ZUb18TefaqwPBdykb6LI1TSJSEl9Aw/D0j7TOKL5wItjKKdrVp1h/cWI2tZWPnxzFGo3+Pb/jpm5VeEfqBvTK8g8STFgLul3LPBQY0X9eX9+bYgOvRzUgSvZL67QOAk4k1QUfAfXLMJCTS9YO+b1BwkCojn0fK9OBbqpQwiKn1RY2z/j4R51WC5msB5OWCl2tfDsSD2VISodIMK+h7Oe5C6bc7w8lHTMJBis0pw9npbxC9x5cP2TfTY2TdSKjjFu3HOXrrWT9h1YTSdafFUXjUL+sPaf4luhSxc0hNbCiCydWd4rK+wxGrzFjoFRUV4reyuoGjEPIerheC3wbkjxysHgIQt8foivOarprn9SINLed7CST1I9U0b6+Rtx/Tn8kN0tHc/tJGnnuWAh8vGBzQzSr8a3pIcvDZGN5evKwRsX/FvrTWUiTD+mNGg9rRLqlZLOSFK/sOEZ4zgOavsRmu3hj+fp22MMnp794ZLtqisfNpEOxXLk3JNxGbUwkJaiVJr3+nFAY0IYYiNQm5RwUnPMc8MmXs0q9FbQE3egxz/4/jFvfS+aLGndTajHqCZkqn69Mp0kCzVmqQQT6MM+dMuAyins5Kf5gS2oFbXMXPMZTRVAMS+O97viqzpaoXGFhxtYdeF1WJsJnOPJow2Iq13AGywQ4/4dU7eqYcx78PWhBNezrTF7XIMXBhKyIbLDchWhn04GtU3kN7m2MIhUkyREoG9jTDBXIfr5oDHcp2s5XYpck3Muvmtev6UW4TrXcnASqjOAPH12ygQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(136003)(346002)(376002)(451199021)(82310400008)(1800799006)(186006)(46966006)(36840700001)(40470700004)(7696005)(6666004)(110136005)(54906003)(40480700001)(478600001)(16526019)(426003)(2616005)(336012)(1076003)(26005)(2906002)(44832011)(316002)(4326008)(70206006)(70586007)(5660300002)(8676002)(8936002)(41300700001)(40460700003)(86362001)(36756003)(47076005)(83380400001)(36860700001)(81166007)(82740400003)(356005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 10:23:41.6823
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3f877bb-658e-4646-885e-08db9d79b2ba
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044FA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8722

To replace if-else with switch-case statement due to increasing number of
domain types.

No functional changes intended.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
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

