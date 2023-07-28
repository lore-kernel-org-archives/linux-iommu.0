Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2069.outbound.protection.outlook.com [40.107.93.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35EDF23AE
	for <iommu@lists.linux.dev>; Fri, 28 Jul 2023 05:37:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LUF0lGDKDgDUt9vvPF2J8q8RXnoK/rwLo8LITYcbbKo2yV5ijUlf5XiLhUQUaX5YLg+KyZsgz2GRyion3agEehWQFZGtNR/9c6NyuqXj7bHOLd2eQIa/7Khtb7qEvCaOJIglFOzYaB6eWwh/qPRdOv2W3JCBEY2m3K+grdIun9kVduFEH2fQlO/tJCP2OfYwJ9xlq385lnteruurrhLmGXKf8vSbBBdH1D43OtN/430Udlsvn24/3Fru4zpptxSYBEv+G9wpn8bmsTwnq4ZBlbqJ4s8dw464kAg8Ai3JSDZi6DUBTKm4yVgWPrxmyGcVrDR1Stfkzk+F0VPm4u5Xpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/OOdI4GHXCL7CFg1KVkO62Bu1L5IVU0WgHLEoNPnInU=;
 b=I1dpKi8KVrR4YK3lwHlhG6Fj90SN2K7CqjytTvZcqQ4ytTsyxJFV03qcXHdVdv7Oxq40h9rqntRw1yS3CA3MKJ/egNGDxdR1yDZEmataZkv8pAXfy847a/scFWoqIzUXo3LYBJhcV0NfqV3YmnyZ9bpkf1PEey/UrtA1Y3Fdzc8GaAe/iOPSSePvI6fH6GAwothmWshE3a3aCs/RGCH+vLJE6OHRPig/k/VqBIXYaIAaFOSFflkz3Sa1oc1+3+uSYiuWEuljdSA0aIIvFMqpEJ7Bp2R58LjfKjT30aO4TVz0sP8UKq+AYJPWxqKSvlui4QQTNOeNkRDfWemTwekBfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/OOdI4GHXCL7CFg1KVkO62Bu1L5IVU0WgHLEoNPnInU=;
 b=l2DBttRjI1053m8FX53LzX2/GBaRGxeytu6bIxAuCSLa3uOScKH0nFxPEN6mnN9xHs7PV35uP58ZieQUmfP5f63kjZko4GVRwa+rhX3DI0R7aN7f5GauQLsQ/+ui8Ih3ErnO5Vk6EYfpF7DKS4gbbuQt4NaDrnPSKQXMGpOGtFU=
Received: from MW4PR04CA0340.namprd04.prod.outlook.com (2603:10b6:303:8a::15)
 by IA1PR12MB8465.namprd12.prod.outlook.com (2603:10b6:208:457::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 05:37:38 +0000
Received: from CO1NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8a:cafe::25) by MW4PR04CA0340.outlook.office365.com
 (2603:10b6:303:8a::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29 via Frontend
 Transport; Fri, 28 Jul 2023 05:37:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT036.mail.protection.outlook.com (10.13.174.124) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.29 via Frontend Transport; Fri, 28 Jul 2023 05:37:37 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 28 Jul
 2023 00:37:34 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v2 04/16] iommu/amd: Refactor protection domain allocation code
Date: Fri, 28 Jul 2023 05:35:57 +0000
Message-ID: <20230728053609.165183-5-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT036:EE_|IA1PR12MB8465:EE_
X-MS-Office365-Filtering-Correlation-Id: 91df29fb-5d0a-470c-1908-08db8f2cc08b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Kq+1egCjyTG9FynWQsEKw+ORc1x6UekuEFtR7k7x4sEODIFpx4xgBK6/Jy+g3D8hP8ca7Xb/fyPTFDINPcmgtSCp/pubqAVa0zihtyKt+n/6PL8Gur8tEP4ZQlL6veD772OhC1+H5+QTOR44OKGcNXnV3Ma29uH6pIv9o8ZESFY2YqSC8xPbcSiViQjCxbXKuQNn3lcC/vtWyQVBgZvi3VU2CdrzXnYTuQsYyWayYaYVdMghPzzEdlKhCNrL1n8//2pDUs2A1QBz2ZmDUReP0Zx6zF5AiqUcb0w9LLJrFs0r2Hx7Fm61NoezFiJOqh78gT8Y3TMNjnSFXORgQ5Z53oawbBanRwBXCmiLwVvZAPfE9AA4G2pSF88wfy0pUja51GQyb0UhejG8RFfQG9CQV3XIkNc5+8IPVDNFvWAKea7RX9TS56pDKnP2TM9yO3Oob9bOZI2ep+UdRi+OlRaoItXZbOZFKlTXxS479qigbVv8TSsnn47zAXFJsZMxN3FK6t2vIvPPmaxDqHP/En3oO3EkW2brbiqSrO1oWxs0uIdMcxwgYEUkxQykFhzt4wQwEyCaOFsUs0O7xAJJuED+ISzIOqrHVfiuK3H+jL5iE1izbSh71PAQWE6lCbaraF/jUqLd/+iYKeHg36rjZZ+lNJ3zMhCn/n1uib6Fs871coSgimujn8rcjJJ1Pq22zozNPlepiZpt0+3BzrZSP6CRCCdxrbhS/WQCF5SUZqFVPrJ9OmJLd7O97sUWdveM5rVya6IFQwLMfUKIfRagdSwIwA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(39860400002)(396003)(376002)(82310400008)(451199021)(46966006)(36840700001)(40470700004)(2906002)(1076003)(336012)(26005)(186003)(316002)(16526019)(81166007)(426003)(40480700001)(2616005)(83380400001)(47076005)(70206006)(5660300002)(44832011)(40460700003)(356005)(41300700001)(70586007)(36860700001)(8676002)(110136005)(36756003)(8936002)(54906003)(82740400003)(478600001)(6666004)(7696005)(4326008)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2023 05:37:37.3325
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 91df29fb-5d0a-470c-1908-08db8f2cc08b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8465

To replace if-else with switch-case statement due to increasing number of
domain types.

No functional changes intended.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/iommu.c | 46 +++++++++++++++++++--------------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index c2cb541b0553..09749ad4445c 100644
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
@@ -2106,27 +2090,43 @@ static struct protection_domain *protection_domain_alloc(unsigned int type)
 
 	spin_lock_init(&domain->lock);
 	INIT_LIST_HEAD(&domain->dev_list);
+	domain->nid = NUMA_NO_NODE;
+
+	switch (type) {
+	/* No need to allocate io pgtable ops in passthrough mode */
+	case IOMMU_DOMAIN_IDENTITY:
+		return domain;
+	case IOMMU_DOMAIN_DMA:
+		fallthrough;
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

