Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2078.outbound.protection.outlook.com [40.107.220.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E988125B3
	for <iommu@lists.linux.dev>; Fri,  6 Oct 2023 09:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="m0ribfPS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jwEqE5xMb3/EGkNY6OaQLHnsSz5MtVIXEjOekJJd75UdWAnxFgO3VRlg/lUYve2ZLtkUhjXCl4Bv0qKoNkEOGwoOCClLi88z8CuIAvOYvrDEm2xbd0XAtQBbvLIfdABAeJel9kIFjUu0YL+snOu8waadljpE4/3dF7otaXC8sCMheRTreJ2nOKaoFZfj89lgg/NIFQwE+NJe2U+Gmcf8AImN523F2wZfJ/9zJ2qjuDI+1FcckMaQil9M32sgHCGz2gx+RPoejGKllSoYIrGCh9P9fHWBsDQ59zqCTDMpOzoY1QXIK8aVC1C2IR7K/QGNtulrYSt8cspDkzG4ioE5aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uw+cvyIqhLBWqSj8kjX8UnDjxfig2Qyf+s0WAWprldQ=;
 b=BZX7zwNGgKhkockHOdqog1Y/JZ4qL+9z4IqE1E96wBJLPgpBXBvt8919hzAlNgngMp+/ud0On6SJwg4tCjDemwPHOCYJpBZVEIyOxvvquMc///MFxkJs4AWpH0cnA/0iXWR0Cx8eQZ/CQpy2xTSfZSPcFjne30HH8NUiUMjZjlAbiOw0Gi+V8ar4PdBpxsgkkrbjbBUJNnG9R7pGjFkVHraQ2hOVwxZPINmCJf+7Mxm+bCTJWL7TpuqWS/gamj5Ss1YntWccv0x/sSFKThMj4BhuSHQR3DY+BPy5pTb/YD2pVySVff3Aawrrj6En3MdD9FgAEYUEpX06cx6qTJs8Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uw+cvyIqhLBWqSj8kjX8UnDjxfig2Qyf+s0WAWprldQ=;
 b=m0ribfPSJAWHHizHU0wjy7R71DMxknzvSdjGhLlUtEVQSIK8UXbFqckBPoHGOjlK/rGIpfczZu9CIAVuFRpPyQiGDxqCZbKmZTF5cgq6Myuxi3UF9viJm6KQOSwxq8+sOoj+UFiOzQ4L3+I1Rxfxq1Zcd6lbhNTPgSB3jptEEp8=
Received: from DM6PR07CA0053.namprd07.prod.outlook.com (2603:10b6:5:74::30) by
 SN7PR12MB7371.namprd12.prod.outlook.com (2603:10b6:806:29a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.22; Fri, 6 Oct
 2023 09:58:41 +0000
Received: from DS2PEPF00003443.namprd04.prod.outlook.com
 (2603:10b6:5:74:cafe::de) by DM6PR07CA0053.outlook.office365.com
 (2603:10b6:5:74::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.31 via Frontend
 Transport; Fri, 6 Oct 2023 09:58:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003443.mail.protection.outlook.com (10.167.17.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Fri, 6 Oct 2023 09:58:41 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 6 Oct
 2023 04:58:38 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH v4 4/5] iommu/amd: Remove unused EXPORT_SYMBOLS
Date: Fri, 6 Oct 2023 09:57:05 +0000
Message-ID: <20231006095706.5694-5-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231006095706.5694-1-vasant.hegde@amd.com>
References: <20231006095706.5694-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003443:EE_|SN7PR12MB7371:EE_
X-MS-Office365-Filtering-Correlation-Id: d048bd38-ad24-4db6-c819-08dbc652d1ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Qlme+qSBRSIpA6AXotnUvAfkDkdcGY/5EJq3TUgthfdXgCoia5BnDYdoYJJUhyOdxk4cm7adnorlb8U0+JfQqC4w0fDJeNeco9W+Tg6vqQs7YJTe3eyWw4+880a0fLeV/fZr+zxFkv7RqAzsnarIHRTWmh6+hywGhSbPVVeRTQQvDsosHbpjPikDHqxuRvw0tsQb0LLXOsHcpiS2nWPrOCuece6ooFVOkhjPU+/w86JBZFwS7U8ihRqPsgwzB34SEcdOupDzvYJyNgwfYLxOJ7Pn+hj8ivWm6OZJ0ka1LaMhVVzUoiyVqC/XDg0og7kcxbj80u5q49IUq52y7aLTtzk16C3EyrFeJ1q56NjTkAHoibq1uFyarxxk08FHrTY2prEKclN1DAZhqdc21mviQj+XOT5Rl7CGH0zP4y3yklO58acGdnFbXcrAlJknwsFdVeVWrQxwn/TvcunMpWrxEkwpXnoXLFY+EnAnDFDxoD41t+QBcIL6ZOSw8aWoytq1d21dDOW7cnYo1sgoTFehRpPivnJ3i5gLcD+mghW1YKOeymaSFVjWE2DqecdBIXlCj8PlEP1LKsEqsDyw0XkSqNtot7/GKCb1ZyfVqJuhZb6h+kGb/nRMJyKm9tmHd1ZXl6Wl2efiRqZ4dkaD7+uN+LGuh0ois3vGY+WmVaYbtlS28HSoaRdu7y4+ja9ICnDGkeV5mQdroybyksf1xqs3eAxH12G0yhYed/zNh6xvrkVvSZ8ONS8mhACw5gRKyHzDER7bh+Alp54LU2zk71vHdg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(346002)(396003)(136003)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(82310400011)(36840700001)(40470700004)(46966006)(2616005)(1076003)(16526019)(82740400003)(7696005)(26005)(40480700001)(83380400001)(47076005)(86362001)(36756003)(36860700001)(40460700003)(54906003)(336012)(81166007)(426003)(316002)(356005)(5660300002)(8936002)(110136005)(4326008)(44832011)(70206006)(2906002)(478600001)(70586007)(6666004)(8676002)(41300700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2023 09:58:41.3718
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d048bd38-ad24-4db6-c819-08dbc652d1ea
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003443.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7371

Drop EXPORT_SYMBOLS for the functions that are not used by any modules.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
Tested-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/iommu/amd/init.c  | 1 -
 drivers/iommu/amd/iommu.c | 6 ------
 2 files changed, 7 deletions(-)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 463e68a88b17..64bcf3df37ee 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -3666,7 +3666,6 @@ bool amd_iommu_v2_supported(void)
 	 */
 	return amd_iommu_gt_ppr_supported() && !amd_iommu_snp_en;
 }
-EXPORT_SYMBOL(amd_iommu_v2_supported);
 
 struct amd_iommu *get_amd_iommu(unsigned int idx)
 {
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 45ef9bc0cc84..45b74dfedce9 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2447,7 +2447,6 @@ bool amd_iommu_is_attach_deferred(struct device *dev)
 
 	return dev_data->defer_attach;
 }
-EXPORT_SYMBOL_GPL(amd_iommu_is_attach_deferred);
 
 static void amd_iommu_flush_iotlb_all(struct iommu_domain *domain)
 {
@@ -2607,7 +2606,6 @@ int amd_iommu_flush_page(struct iommu_domain *dom, u32 pasid,
 
 	return ret;
 }
-EXPORT_SYMBOL(amd_iommu_flush_page);
 
 static int __amd_iommu_flush_tlb(struct protection_domain *domain, u32 pasid)
 {
@@ -2627,7 +2625,6 @@ int amd_iommu_flush_tlb(struct iommu_domain *dom, u32 pasid)
 
 	return ret;
 }
-EXPORT_SYMBOL(amd_iommu_flush_tlb);
 
 static u64 *__get_gcr3_pte(u64 *root, int level, u32 pasid, bool alloc)
 {
@@ -2707,7 +2704,6 @@ int amd_iommu_domain_set_gcr3(struct iommu_domain *dom, u32 pasid,
 
 	return ret;
 }
-EXPORT_SYMBOL(amd_iommu_domain_set_gcr3);
 
 int amd_iommu_domain_clear_gcr3(struct iommu_domain *dom, u32 pasid)
 {
@@ -2721,7 +2717,6 @@ int amd_iommu_domain_clear_gcr3(struct iommu_domain *dom, u32 pasid)
 
 	return ret;
 }
-EXPORT_SYMBOL(amd_iommu_domain_clear_gcr3);
 
 int amd_iommu_complete_ppr(struct pci_dev *pdev, u32 pasid,
 			   int status, int tag)
@@ -2740,7 +2735,6 @@ int amd_iommu_complete_ppr(struct pci_dev *pdev, u32 pasid,
 
 	return iommu_queue_command(iommu, &cmd);
 }
-EXPORT_SYMBOL(amd_iommu_complete_ppr);
 
 #ifdef CONFIG_IRQ_REMAP
 
-- 
2.31.1

