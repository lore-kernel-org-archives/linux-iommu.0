Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2072.outbound.protection.outlook.com [40.107.100.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5F3944C
	for <iommu@lists.linux.dev>; Thu, 21 Sep 2023 09:33:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mx2PZJ+HrORul8m2Ew/6sM2NhuJY7KL3ma5bieZQgg/mpddffcEgWGQGVYS27zTvdaPU2pG4mBBJUgSUVRCLo6j1NvgfOt/l2Ht9b/zeqTF5LbG8/6vRbtAcv6gOzVpbxem32/xx5btltdb5A9jgPu7u8dFlLVcKfUTXms6o6wz5Bs9m+qhW+d5ZBQNI8IQaEN1QkIazPvAlz/TacPDM/wcDmIzBfBkcPzbpaBWS+5yeJp/PmnrX8Uo+CdxZ93B6wSaIVwDgNfI/p7bzNfsHy5LLEbdY8ihtdac7IJAiA9wu4x0Nbz0wl/1kYKsdoIqHH+KRzVGGpJLG9zUE7NPc0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fUzJnJ/blsZ9LOVamD2EhpEMQWULz3OXmRTuKsjkESo=;
 b=QX0BiwPIYoRfrD5Pa1LlkLOBTmDgcM4aF0XaW3aghsEEAkeKQKhIkgYbWyOB4KQnj7eypb8hL0dzpc2t8O/BoWvcNL3FQ4cLugaoNRfPZhVM+jNEBb8BMjDPUjQuBUiu6soJbN1HIfHiiSZhD5JBFiGFQTIW67lzxb0WrFnNzwsWWYgTkAJ/aHgjtMYAMKeidgcP3nHwht3Oxzwxmkc8pgDv9KvHiDJQIxsd/yKFxtBYTetQvfcsikBkZdX7WUzhWG4xQK/1UhE/2KqMRGMuOQoFKh0u1VO+8/lgNgHsyEcbwYl0tniARea9fLMem/Py3MAMpO/adWcSSijnducl7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fUzJnJ/blsZ9LOVamD2EhpEMQWULz3OXmRTuKsjkESo=;
 b=BtdjYM/0xdx8ZoLE1i0ueHBMbGdfHeJCHuiv6TWdNpsZDpHd75xe1PHliHgtcPMPuO9b+6Kgt0wACjphv9opf9w3xK6H6SbVOlbdCN0vmRL1iaItSiFcCXj5Cjhci4SRB1LdL1+z7zwLUoSE5m0a3WfosJ0cNRnOhvl55CW0W1s=
Received: from CH0PR04CA0077.namprd04.prod.outlook.com (2603:10b6:610:74::22)
 by MN0PR12MB5907.namprd12.prod.outlook.com (2603:10b6:208:37b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.23; Thu, 21 Sep
 2023 09:33:26 +0000
Received: from DS2PEPF0000343D.namprd02.prod.outlook.com
 (2603:10b6:610:74:cafe::5d) by CH0PR04CA0077.outlook.office365.com
 (2603:10b6:610:74::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.30 via Frontend
 Transport; Thu, 21 Sep 2023 09:33:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343D.mail.protection.outlook.com (10.167.18.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Thu, 21 Sep 2023 09:33:26 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 21 Sep
 2023 04:33:16 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v3 4/5] iommu/amd: Remove unused EXPORT_SYMBOLS
Date: Thu, 21 Sep 2023 09:31:39 +0000
Message-ID: <20230921093140.6162-5-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230921093140.6162-1-vasant.hegde@amd.com>
References: <20230921093140.6162-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343D:EE_|MN0PR12MB5907:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f59100b-6979-48b2-5404-08dbba85ceb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	rmvStCZCEOehXu95FZr+UBBP9W4/CWMRVoRXmnt+rR3y02g8CC9PPbtU5SWzW7RdenwQkRA3j0klZgD07yrcnm+g6qJt0ea+GClEXZ6+tlk1gJzPWMa+Nfu1Ns9f1orBICCj6veeJkMEDUEl5QD6gch1D/8fMvz3BPOgl66TClAmmI33JRaEwk8c5udj1gEczBgomtwm8wey0vz8Tpj/YQM74AXRZwTJb1rHi+2raDKQ/EhD2YVihl+uVtyJjGV9dIH4nRbFIPV8Q+oGMVLJUxYD3r4k5A0Nn/NY7JeOJAv3ub06BxZwbsyMuvluOaE6XXHHsiYYEFmd5r7K+S2IiCJUVfkWGpF3I50FxfkofZlXXzS4/nXDnozNn69qWnFlHV/7hMk18WZHxv17O2JocR49W6eNC8Pe0ADxshauDR++YnS3DitqSA8ojNAyX3tfMNZ/F7KJiZAXdkb6nmyG6Jlt6DWBbledUOkgD7bCPaZe9SXm1+zA11+Ne3yORPRtJscEa6faSlcOXcBDn0B/UZGEeTf7rIFmXCe25Uj4HMb2xyqlbhLlxUFiefWEN+OPJtnCCPx8hP9srVbNM72qxnI2WAvt/Rmk1qHHRLKIywdynwnnelJS4bo07fACIcXQDSKj6X+t0A8SZxcqz5PyAplcPCwYtn+GpnnLBZW2V/LBpL7/+WapGJNdVWNYe6x02WQGS2XQ8caZa4xce4JOhje1B2CYl4b6mDAH940Msygc6aOPRDJ9swcOdm5qalBuAFSgzCmbjFl+Y05JR+eZQA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(376002)(39860400002)(346002)(82310400011)(1800799009)(186009)(451199024)(46966006)(40470700004)(36840700001)(356005)(81166007)(26005)(82740400003)(8936002)(16526019)(8676002)(36860700001)(2616005)(1076003)(426003)(4326008)(40460700003)(83380400001)(47076005)(2906002)(36756003)(336012)(40480700001)(44832011)(86362001)(7696005)(6666004)(478600001)(316002)(5660300002)(54906003)(110136005)(70206006)(41300700001)(70586007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2023 09:33:26.3813
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f59100b-6979-48b2-5404-08dbba85ceb7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5907

Drop EXPORT_SYMBOLS for the functions that are not used by any modules.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
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
index 8f43d89a98db..d996a6f22a5f 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2446,7 +2446,6 @@ bool amd_iommu_is_attach_deferred(struct device *dev)
 
 	return dev_data->defer_attach;
 }
-EXPORT_SYMBOL_GPL(amd_iommu_is_attach_deferred);
 
 static void amd_iommu_flush_iotlb_all(struct iommu_domain *domain)
 {
@@ -2606,7 +2605,6 @@ int amd_iommu_flush_page(struct iommu_domain *dom, u32 pasid,
 
 	return ret;
 }
-EXPORT_SYMBOL(amd_iommu_flush_page);
 
 static int __amd_iommu_flush_tlb(struct protection_domain *domain, u32 pasid)
 {
@@ -2626,7 +2624,6 @@ int amd_iommu_flush_tlb(struct iommu_domain *dom, u32 pasid)
 
 	return ret;
 }
-EXPORT_SYMBOL(amd_iommu_flush_tlb);
 
 static u64 *__get_gcr3_pte(u64 *root, int level, u32 pasid, bool alloc)
 {
@@ -2706,7 +2703,6 @@ int amd_iommu_domain_set_gcr3(struct iommu_domain *dom, u32 pasid,
 
 	return ret;
 }
-EXPORT_SYMBOL(amd_iommu_domain_set_gcr3);
 
 int amd_iommu_domain_clear_gcr3(struct iommu_domain *dom, u32 pasid)
 {
@@ -2720,7 +2716,6 @@ int amd_iommu_domain_clear_gcr3(struct iommu_domain *dom, u32 pasid)
 
 	return ret;
 }
-EXPORT_SYMBOL(amd_iommu_domain_clear_gcr3);
 
 int amd_iommu_complete_ppr(struct pci_dev *pdev, u32 pasid,
 			   int status, int tag)
@@ -2739,7 +2734,6 @@ int amd_iommu_complete_ppr(struct pci_dev *pdev, u32 pasid,
 
 	return iommu_queue_command(iommu, &cmd);
 }
-EXPORT_SYMBOL(amd_iommu_complete_ppr);
 
 #ifdef CONFIG_IRQ_REMAP
 
-- 
2.31.1

