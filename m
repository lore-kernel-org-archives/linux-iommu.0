Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2057.outbound.protection.outlook.com [40.107.243.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955928F55
	for <iommu@lists.linux.dev>; Thu, 21 Sep 2023 09:24:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G/fvt1kBgb5JJ7VtchEVM9NLDH+GJhifOOnnVV7fLEaqmiPKt3w6rUdhs0cu6yl8kmM4WZHPfqecLAZAcQTYEFQj1u3ZaMZGxpW80jgHEOaiqkabtc6jB9H0/NdD4iVUSR6rmsE2W4LUIKaMjbhv26E3UNKeuq0glLDTw3qvO0k0qzfP+iRJ6xpnFHXH+iFMQlATl2jsytY7uB6RD63pCAurzfVc/MEJptFBQOjU9gAiBNZl70phS9AuhKBGyM/f2JFSqfJei0bwCUMlPU3QhY5XRM2FjgJjTcNr1FIaTzYHeVLusmPq/i1CoZ0Xl9bZad3LAd21HTH4x2hffgITrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2GXi0KiF7xxO3pXS29fMLe0QZJFHxGM1IninSVmzqw0=;
 b=KX11Wcn1t/gcrJ+luBVnQ7zwBLVLVCgUxJJ3gVg093/0h23dMFtB4BR/N/R85rNeCh2KU3pJHTsxdAPNxo/gWWhoOG4EeVihaDaGxNSK7AOtfKi7qmpGl0X3x/ba5cktPfJUTylDc29bFtFp1F6HMNjD9QaV1HV30xzVHLdjKFDmJf+kou4EW7g1LaHumO/sLcWX9RhaMMvmcT7B39oAQgO/4zJqslYQ3kREJLELjkiv5Z7veJjkaoOQx4UWoN0D4vpPq8a4O2q6HEGhiZBNun3FoQpe9yM0tArw26xanr5s0WLzVbuSCsQleLZXDb//HzLhkrAGsmNjlDFi9vi4Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2GXi0KiF7xxO3pXS29fMLe0QZJFHxGM1IninSVmzqw0=;
 b=L9qaD1GQtx0hVhl9PvTC0mIlBTvKLisAW8+iO1ZsYBA5fTtv7c/ysuH4WBjSiHgi274YwB9/KTw7Y7PFwr4E6zDTGsx0M8CTWgqnJbzHTgfOl9/ze8Ho2CuONAMOAqf9Ujub8vql5y68blnNc3LzicPCWLiAB4E0V1j1wYSbvNY=
Received: from BY3PR04CA0017.namprd04.prod.outlook.com (2603:10b6:a03:217::22)
 by DM4PR12MB6637.namprd12.prod.outlook.com (2603:10b6:8:bb::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Thu, 21 Sep
 2023 09:23:52 +0000
Received: from DS2PEPF00003439.namprd02.prod.outlook.com
 (2603:10b6:a03:217:cafe::65) by BY3PR04CA0017.outlook.office365.com
 (2603:10b6:a03:217::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.30 via Frontend
 Transport; Thu, 21 Sep 2023 09:23:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003439.mail.protection.outlook.com (10.167.18.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.11 via Frontend Transport; Thu, 21 Sep 2023 09:23:51 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 21 Sep
 2023 04:23:48 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v6 04/14] iommu/amd: Refactor protection domain allocation code
Date: Thu, 21 Sep 2023 09:21:37 +0000
Message-ID: <20230921092147.5930-5-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230921092147.5930-1-vasant.hegde@amd.com>
References: <20230921092147.5930-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003439:EE_|DM4PR12MB6637:EE_
X-MS-Office365-Filtering-Correlation-Id: 01fee63f-f534-4391-ddf8-08dbba847859
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	rpK06BroZCyhqR1e1uzsQsA3P1LN3Re/Q+zs/acEuomN8rIT2lzvVi8uJw4XeHFxcusNhreQRyPljHFo8s5gSjWGmGT/5DoApIWwFEMY+jMi9Rjq0H63w2f96BIqMsh6mxzjDOtzJrtVuHSxXwf2mbACQpxbCSPbkRe8yk6ZWGdtMlVWlHREQusaC3e3NEgJ8tXq/Ko972F0cNCzzBVLFI8cRvQh4gYRggN2zM9fj5XTo1GmBCYCt+MxT9dKRa7vmMyga3qP6tM3XEqIs92A1sS0mdLN8SJ6Fftk73Z6yn9zIZIpwuFzU4arkGcqNKJ9qgNrSKIimFTahTBEIYsZlqlp6Z7NmdXgDSxL/FmEjOcJUSww5eD+MqtjHxd+z9FgafVW1WgAXq/iaC9AEzgM1RCR7YPqUTBvfPHrSa8d/nku/8LfLFx3aGeLGSgOAI9uDzB/q+5T6jucuQPS+pblVTnSPSAf8mUGQy9EFmI1QUtI6HNUvkatQG5M0S9edu3JHZgdc702zHMuL+hWc7/dZwcUrLzG+U0VEc01mQu/AesB0TB6ChCXKfBkzIehFj8R3mG9ffj+DNk1hCWtPOfjI2cVEz2H2jrzReEhNkQranMC3Fmx+DkhMdqmGgBu1va1D9mGRGthDHevPRk2NnLqejZrivu97Cz5X1J/zDXOSn6e2CqTXgToDb//8213ZbkyQzgVE0ycpoyB9Si8mDnkhGrNVu+mQetA9FeBpOGW7xyjA5IQj7bxqaV2fu8XrnxgfYo7w6msc+7zSZnosvGc2A==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(39860400002)(136003)(346002)(396003)(186009)(451199024)(1800799009)(82310400011)(46966006)(40470700004)(36840700001)(1076003)(2616005)(336012)(426003)(83380400001)(16526019)(26005)(82740400003)(6666004)(478600001)(81166007)(36860700001)(356005)(7696005)(47076005)(41300700001)(110136005)(70586007)(316002)(8936002)(8676002)(2906002)(5660300002)(40460700003)(4326008)(44832011)(36756003)(70206006)(54906003)(86362001)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2023 09:23:51.9880
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01fee63f-f534-4391-ddf8-08dbba847859
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003439.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6637

To replace if-else with switch-case statement due to increasing number of
domain types.

No functional changes intended.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
---
 drivers/iommu/amd/iommu.c | 45 +++++++++++++++++++--------------------
 1 file changed, 22 insertions(+), 23 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index c99611139ab5..bc1fa6e43794 100644
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

