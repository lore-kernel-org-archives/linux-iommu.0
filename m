Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2059.outbound.protection.outlook.com [40.107.243.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0341FC8
	for <iommu@lists.linux.dev>; Fri,  4 Aug 2023 06:43:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jL6cZ/rBOZFNJKNYePNWnyZkmkBzOhMN1xEHloQzoYIjpxSb3tCaCtopowZktES5eXe0H7Rz3UYMApOoKhkCc1K0eUXKIeiyLZmXl5d0f/tDRI/fnuPBzI+j+g/fWAvGDKfmayuKK5Llh2xmCs8wp5XxB5e2d09dH4hdMRcTqXJRuWK6hem+CqqXwmKvhuh0ET+LIIRuZl6Xc6SwV3BXvH8oqOcl6dPS82LrVQPZHarJV4K9sahoGlxJfa8AA6Ahv4BwsPK08TkhHRPhhHdZRo4TDJYPmSG6P+SMtSRK5dtwRXZlCySOxd4CyvaFLfzrzwKC3PqHHSrPLs2S4umUng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dsarzsZ0z8n/AXF0AYTcvAyDe1eUVjR9vCQw9Q9JpwE=;
 b=CdS5Y8r/zXwAHbaxM6npbXhXOwc8i2u0Vlzj1JffPii4W+C2rJULb/Y581BoAdETi6srBVpi3WPMf74B5zr0WC9l0NaQMlVuPDfMRAVsl4MJvZ4/sF+h+bmycWU7QaVUGVi0cL4IddwJya8Mb+YACdzbSS8YAYKZGAMGW1bTJf8fY1fAQdCkB91DVJldQNObai7K5jYnO7UvOABaNMaMAQCrvT8Qcse4/9FbNeIgIX5c7pFSXWOBUSr9RwPVkJUMVj/O8wkNXqsngWhqSDlwBGZNoZtObG2U77ZiaGcO63XZml2cupBAsg/1oLGub8L6O5btJjx0gM7CnFCGzBx+xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dsarzsZ0z8n/AXF0AYTcvAyDe1eUVjR9vCQw9Q9JpwE=;
 b=xECa0ME1qtvABfJ+9AOk7JPu6Qac0QxbA71/wPF5Da9OoFznegQ5n0TOmXfHtkuhnDDeAuyM8tHlyZvQmRqxikz2v3bVL8lPFqbvkza3b+uzSNem+tV5a69b01KF6dQggOLLPwq5YO9ctOGPjwtphx4pOlJf5mp69peOa24Ljcc=
Received: from CY5PR15CA0036.namprd15.prod.outlook.com (2603:10b6:930:1b::21)
 by SJ2PR12MB8955.namprd12.prod.outlook.com (2603:10b6:a03:542::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.20; Fri, 4 Aug
 2023 06:43:48 +0000
Received: from CY4PEPF0000E9CF.namprd03.prod.outlook.com
 (2603:10b6:930:1b:cafe::e4) by CY5PR15CA0036.outlook.office365.com
 (2603:10b6:930:1b::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.21 via Frontend
 Transport; Fri, 4 Aug 2023 06:43:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9CF.mail.protection.outlook.com (10.167.241.142) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Fri, 4 Aug 2023 06:43:48 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 4 Aug
 2023 01:43:45 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v3 04/16] iommu/amd: Refactor protection domain allocation code
Date: Fri, 4 Aug 2023 06:42:04 +0000
Message-ID: <20230804064216.835544-5-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CF:EE_|SJ2PR12MB8955:EE_
X-MS-Office365-Filtering-Correlation-Id: f73e258f-b791-4058-a95f-08db94b6286d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	q0TUR9rJ/Oqn00pA+ZokMLzzNVyrFU9VcpHZHfQdFU15wS1y9UM7zJ784IIuiMTXncx47cPPGI9yyeHnJDKSVBcxpkBvrLH7HNTUjqq5E4SxBWzL+4ThKqVsfUv2zwjSbcS/pNan8ooGRNzk8GbfE3m83yt0+MimvCB+YRYWNiF8jYFG3KicPl+ojXN4aO3aYwuPeNbpJtPyUs2zAw7OOPKeuZQFeuIHBSN1JIkeQl2avYJGOV5CDumMSlofmHoKW90SX3NtT8M7ILHKxnobmxFyEF1Cm9uiMfCMc+6HGvrIti3dVhsmwiFK7CU5Egp9E3MDepJTS6xplG5lX2yEQQRBrBItMzBvwyttI+yGshCcxEZ7Q1TRIDORc5RVSK96x97PLSxbL5A8We6lIijmRphtwwa9XHhhDKDTK1qQq63cFR55p3002auP+/gysX0s0v1egSj5ighin6sRvgIzn30q6n0xdprywzNwy66edENKzNqbOIwJlzwkT2HpccwCIoZVrHEtfRPg3aw/6vfldO7cB97HOs/HhIUG4x30RBEGvQNbw6TuCyPUwJQVY/4mLY9UrGX+tHyvJU6FXXigNyoHL2ND4v5Zo5FDr0hJZHv2wntShiiF6ogSPWrn6xRtZxe+C5gcN5KcTVPWwUADpGZ2TAUsFPDrd1rRFYXg0pAbG4ukMI6HGUMMNSjRe1RKuNJYWCd+ZQ7AVEkxM93grEaezJ3uGuqaCSwlJLFSsBPOSO3ZatYFlCpXXDHNDCqlMiIr91kvA2oMUlsTpTCBPQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(396003)(346002)(376002)(451199021)(1800799003)(82310400008)(186006)(40470700004)(36840700001)(46966006)(41300700001)(40460700003)(8936002)(8676002)(36860700001)(83380400001)(47076005)(336012)(16526019)(26005)(1076003)(426003)(2616005)(86362001)(81166007)(356005)(82740400003)(316002)(110136005)(478600001)(7696005)(40480700001)(54906003)(36756003)(4326008)(6666004)(70206006)(70586007)(2906002)(5660300002)(44832011)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2023 06:43:48.5353
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f73e258f-b791-4058-a95f-08db94b6286d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9CF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8955

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

