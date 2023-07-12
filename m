Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2053.outbound.protection.outlook.com [40.107.95.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD8F100AE
	for <iommu@lists.linux.dev>; Wed, 12 Jul 2023 14:20:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nIUkxcys8u9f7ccNV283rbgEPuCxR4Q/uFLdMJgfwxbhnLnzr+uRh36RLr3H4rcybW39ry9qeOIFFNG+LcGor5tl2a6NSJpDXlODQ+DdJC00yhs/oFBF962+ujUozAk5To9EoMQcD/Ac4f4Ho/bA9ttZaZkWik06nkKqYnMiyveK9tv+b/YxWTrCcqjVrZODC3QV4nWTZnv9Ju+TkVuXS5vFILUbOExLStNHkTOJVLdAUdCQ4k2LClBOwi9Pu/aa27WbiIKjr/4T7bAKoMhuCdorLlmO5x7mg8aH2Ler5wXH+jk79tEB8e2zQbmT0SrHn6K7raAPLsVH2gaUdfPL6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cn6vh2qU5Uj/qQoUGoOuD1ZAeQlDd64g/JAlMLPNfws=;
 b=LTqygCnpmTcSgPTsCPIpuckShuGbmFGYJgzPQFVg5XSkV5D71xRSbqtCovW3A1jb8F0LU4+TaN3jfRXPFSJVnf1JACxmYn0SUbnaqbdp/EJdocpoanotyi3e27Mg2SNkeAJ49dmuxBHTapWac7MHhq/o4gMTj3srbZNcujfIJNwb5spmpih4rsnSsLv++QKTQty1OfSS8i9cAIMTNQX/13+pwOJrE37toSuKmAekXNC9g6Kr9nGZ45O6XlOXQwtmAoGKxoxv2dZffbD0V4sU+0wy1KuHx9xP7BhizUicd3rISdDNbBagrN4nHzzM882QscW+tH2O7HdnEIsuGoU4IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cn6vh2qU5Uj/qQoUGoOuD1ZAeQlDd64g/JAlMLPNfws=;
 b=JlrEHIxjt0QwNA1sLRepEcvngu70AVSLSSDJ1q1/fSrEYmdcAbJi9hjqbhHTddf401znAfKcriYtHxkF2p5T2TRQmRRELD2/wm2ASWiAWagnhlIHCb/M/S8NiQ1HhNICQJHusm874u8Jz0VfZZ9vfWMjasEYFdOXIIAl7dEsBCs=
Received: from BY5PR13CA0027.namprd13.prod.outlook.com (2603:10b6:a03:180::40)
 by MW4PR12MB7165.namprd12.prod.outlook.com (2603:10b6:303:21b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Wed, 12 Jul
 2023 14:20:41 +0000
Received: from CO1NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:180:cafe::a8) by BY5PR13CA0027.outlook.office365.com
 (2603:10b6:a03:180::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20 via Frontend
 Transport; Wed, 12 Jul 2023 14:20:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT017.mail.protection.outlook.com (10.13.175.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.22 via Frontend Transport; Wed, 12 Jul 2023 14:20:40 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 12 Jul
 2023 09:20:38 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH 19/21] iommu/amd: Delay enabling PRI to after initializing domain
Date: Wed, 12 Jul 2023 14:15:14 +0000
Message-ID: <20230712141516.154144-20-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT017:EE_|MW4PR12MB7165:EE_
X-MS-Office365-Filtering-Correlation-Id: 64c4abf7-4f71-4f7d-43d2-08db82e32bcf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	dZddaP9c1bmlZbDKWkJTSj+5Lyb/sXGE3kmj83GA9aKoU2fZHYjFuqH5/qDnRFh11Mludx/z1tKYjqy/piDGTLIo8p+wCSZvLPnYsDUHJsDNyMumUOnx5lJdpR0PFUC0rQHFBgRjwNhrFKWfPRz8GqXiCD3tl6UlFI/87tV3sq0vK2Cl2GrYmTjprJLD5pqC0oIpNQaKOzDb2Qz8iNRukmlOfqCBOr0R5cE0Db/YoIyhcy+el8SYF3uqS2k/DsbsNrlaFLeBgwjfdT/i0YBSJcSISAh/CC8QqSVxHjV6VR6c0QpZNLb6BgHzeuTECYgt3IBMHvCaT09TIQ9lFPv+qc+3jkYQB/iGR0E1qUyLmeDLGSuBsocvxTjJhcPGFUBaU1WYj9Tcyf4cQjPR6J0aUR9WuYeCuFaDqaNMXrBriSFY5xTyacJBC7n0C/mgHiBR7uk+dwCqzlK+B6QU+p0JbFhAFvDbrZK+Z9brzrC0/uN7Q7qc1Ggz0wM5RTpeCxU15PosElL07m0wu2/T5Dxhj/hl/zYFtyZuaBC+AT3r9XtkiDKmozLoYQuUwc05SCNGmODZdgVqc2yLIOd/HBhtS00Ht7Z7RnBffeqyyQKTY+/PX38POCytte7Q/ylQ+V5mV24Sr1impxI8ldFLke2FpcdyfwIbBck3cagG73AiFSwz2YN1Uw8yhkYNTgBLtyUSpVaWQdeEZfumSPKz4hkll6SJW97jEz7CmjHC6TS7nFYUG+bFgR3ufPDlpn7gviTyVpjrHVVEd80SEYm9DZ3tjA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(376002)(396003)(39860400002)(451199021)(46966006)(40470700004)(36840700001)(110136005)(316002)(6666004)(70206006)(70586007)(186003)(16526019)(41300700001)(54906003)(478600001)(7696005)(4326008)(8936002)(8676002)(40460700003)(40480700001)(82310400005)(86362001)(5660300002)(44832011)(1076003)(26005)(83380400001)(36860700001)(47076005)(81166007)(2616005)(356005)(36756003)(2906002)(426003)(336012)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 14:20:40.5529
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64c4abf7-4f71-4f7d-43d2-08db82e32bcf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7165

The PRI capability of a device should be enabled only when the domain is
setup to support it. Hence move PRI enablement to amd_iommu_v2_domain_init.

Co-developed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/iommu.c | 42 +++++++++++++++++++++++++++++++++------
 1 file changed, 36 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index e0fa27aedbc0..62de31cd59ee 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -431,15 +431,12 @@ static void pdev_enable_caps(struct pci_dev *pdev)
 {
 	pdev_enable_cap_ats(pdev);
 	pdev_enable_cap_pasid(pdev);
-	amd_iommu_pdev_enable_cap_pri(pdev);
-
 }
 
 static void pdev_disable_caps(struct pci_dev *pdev)
 {
 	pdev_disable_cap_ats(pdev);
 	pdev_disable_cap_pasid(pdev);
-	amd_iommu_pdev_disable_cap_pri(pdev);
 }
 
 /*
@@ -2106,7 +2103,32 @@ static void protection_domain_free(struct protection_domain *domain)
 	kfree(domain);
 }
 
-static int v2api_domain_init(struct protection_domain *pdom)
+static inline int v2api_pdev_init(struct pci_dev *pdev)
+{
+	struct iommu_dev_data *dev_data = dev_iommu_priv_get(&pdev->dev);
+
+	if (dev_data->pri_enabled)
+		return -EBUSY;
+
+	/* V2API mode needs ATS, PASID and PRI support */
+	if (!dev_data->ats_enabled || !dev_data->pasid_enabled)
+		return -EINVAL;
+
+	return amd_iommu_pdev_enable_cap_pri(pdev);
+}
+
+static inline void v2api_pdev_uninit(struct pci_dev *pdev)
+{
+	struct iommu_dev_data *dev_data = dev_iommu_priv_get(&pdev->dev);
+
+	if (!dev_data->pri_enabled)
+		return;
+
+	amd_iommu_pdev_disable_cap_pri(pdev);
+}
+
+static int v2api_domain_init(struct protection_domain *pdom,
+			     struct pci_dev *pdev)
 {
 	/* V2API is already enabled for this domain */
 	if (!!(pdom->flags & PD_FLAG_V2API))
@@ -2128,7 +2150,7 @@ static int v2api_domain_init(struct protection_domain *pdom)
 	if (pdom->iop.pgtbl_cfg.tlb)
 		free_io_pgtable_ops(&pdom->iop.iop.ops);
 
-	return 0;
+	return v2api_pdev_init(pdev);
 }
 
 int amd_iommu_v2_domain_init(struct protection_domain *pdom,
@@ -2141,7 +2163,7 @@ int amd_iommu_v2_domain_init(struct protection_domain *pdom,
 
 	switch (pd_flags) {
 	case PD_FLAG_V2API:
-		ret = v2api_domain_init(pdom);
+		ret = v2api_domain_init(pdom, pdev);
 		break;
 	/* This gets called from domain allocation path */
 	case PD_FLAG_V2DMA:
@@ -2180,6 +2202,14 @@ void amd_iommu_v2_domain_uninit(struct protection_domain *pdom,
 
 	spin_lock_irqsave(&pdom->lock, flags);
 
+	switch (pd_flags) {
+	case PD_FLAG_V2API:
+		v2api_pdev_uninit(pdev);
+		break;
+	default:
+		break;
+	}
+
 	/*
 	 * If device is booted with passthrough mode then clear guest
 	 * page table.
-- 
2.31.1

