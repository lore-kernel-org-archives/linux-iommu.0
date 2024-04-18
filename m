Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2056.outbound.protection.outlook.com [40.107.93.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D58956464
	for <iommu@lists.linux.dev>; Thu, 18 Apr 2024 10:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713436624; cv=fail; b=bFW/dmDaX+akVwkIaMyirPLJRViHME0HdlT8v1YmkHJ2toazq2/4QEuc3sOxudFdCdqXoRNoxsXDt6vu8cP2ywUJVduyf6Nsj140nWgmZPtWJ7csV53VqC8nO/NviSxxWr6vHHcuHO11R+adilZ/qZTzpZUTg9nx/JRpRmvf/98=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713436624; c=relaxed/simple;
	bh=kjEOSgAraLjXNsWILRbN5lWkmSz6tp3LxmXk9/SwAig=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Whn8BjEk3E2hyaT+2sq4wMojQPvnspR4NKRh0hh/TOAuz0Ca8XWyjWOCsAPWbsMZe6MYbQPb3HuSUDd3WPVP+wSTG5N+7Cq2bdcfUiAXaSx3WuvBTtjFvVMtpgS7fKfiiDj0GeXBi9b6l4kfR/V0xfWZ55ylgG0bZcMmHL1jQmc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PC5Zw0Q6; arc=fail smtp.client-ip=40.107.93.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PC5Zw0Q6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eggxioee00B2va/XMg6fOsDCvLYYQr/cLl8RfxkcVrRcUGkP+vlt5AtmRw8QfEXi5jgeiGC1wZmgDDkMDzef+Hn2OCJc0A26WMn/r7Ou0+DNJM5sGhGW242KswOQCNoAtSKtuvpiKh25kZrep15AMq8tPI+uvHKqqdfsjlrXpfKjrYnv8RaGa6rWWJ0FtiOTZ/MB6/X9cFZXi9wbyq0wYg3OPmi5IMkfJCs5shi6d11Lxyhr27vTE0A3V6b6Z74gHxULlTmtC9sSLN9+s5kepDYYCOi4XHPgxYDeouaJLv5HgB0/avboBK1MjN6iESLqrGZ406B0h3o2pmOizhIQIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QmC0gwH2enCBvOr1kFs/FOkkPhbLwmaqYkSAMXs4Pk0=;
 b=Q9HUixmE/w26nLeIeAXHOtWXw7NpB1biTqxee610IjRyWaMgw86jWFuqeM/iFxvtdVvEgXENZh1sw8YSSI5Xg/RVk1BIf77MBRE3AOVi5NLAHt+VYeYFbDGoVPVlZqeEqpcTmpFD5tnXO7q0IxLmnLKKVHeeLBJ/Z0LErantQ+Wdl0Pyu19BoPUW+XCeMecmBOeL7Tz/kP9xAeef+9GcmlocR2+5Q73mVEw0+X4/4GjjPyyO8m9N2JvjkpMB0liJv52jQPdVPSVsGTeJ4mqboTbnbKqVpcl+KGYwQbwQsR3uWvSH+AT6Va40iRXn1oeF7PoAiLO1Uv+zUJXImMMqJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QmC0gwH2enCBvOr1kFs/FOkkPhbLwmaqYkSAMXs4Pk0=;
 b=PC5Zw0Q6toXyZl+J/u50CAngMFy8Ndz8BRhBWB0y8Xl68uiJ660sYOkIpI/N0MG2qOO3MsS+6jSVlbppDAAv+hRz/vgSW2aA91Hl+5hPmVfv5EiSNx/Sloo3ksUYSdCaA6lGgDuOR6oAMDTkEsR3vNHKBimfpQX9kqg4YynkT2M=
Received: from DM6PR08CA0014.namprd08.prod.outlook.com (2603:10b6:5:80::27) by
 MW6PR12MB8916.namprd12.prod.outlook.com (2603:10b6:303:24b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Thu, 18 Apr
 2024 10:36:59 +0000
Received: from DS2PEPF00003446.namprd04.prod.outlook.com
 (2603:10b6:5:80:cafe::41) by DM6PR08CA0014.outlook.office365.com
 (2603:10b6:5:80::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.28 via Frontend
 Transport; Thu, 18 Apr 2024 10:36:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003446.mail.protection.outlook.com (10.167.17.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Thu, 18 Apr 2024 10:36:59 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 18 Apr
 2024 05:36:56 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v8 10/15] iommu/amd: Add support for page response
Date: Thu, 18 Apr 2024 10:33:55 +0000
Message-ID: <20240418103400.6229-11-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240418103400.6229-1-vasant.hegde@amd.com>
References: <20240418103400.6229-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003446:EE_|MW6PR12MB8916:EE_
X-MS-Office365-Filtering-Correlation-Id: e08139fd-c77e-444a-2ea9-08dc5f937a50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	uT1vjZCGbq/qcM96pgiLQeKT3MdiXtv3k4+a4xobLTAt+ZYEMiaF0idHtSKP7NZaj5Qahku1b4c74ltsZXOYfsyNsTVDL9F9hsvoVyry/+xUsr47BJF3I1HtyT282hqlBk4S+o+LYaxp6cEsNe4R8PUsIJje3HLO41miUE9yrGX3HdPsLA5zqbe4iC/SVZbSLEFY8Us70SqoPPik5ZVZYZf06MTbl1jeoSO0KCCUMu2kw/w3HvnRia1drSCy8oujhRbo7wDOmv8J3m1vfKv8omBkVBBNFbNuaY37eus2lSbZ4RQE+SKT95sIZmjLI6N5CsUk6Ky4is9+Vc78mIx4Eldp2VLP3dAcugSyR982ogfX6Lbc2NZDE6KNKtMuQL7Uz0LMr+3vx5BpYen2p2Xy+9RrNdZDA9vuYMC4cdDkH00hIdyiT5zy1JwLY0Yyhs0q0DLVQ1WG6YdP2asbwfMaz2woN1wtIaJx6Yb2dZOClXKO2hHRVlJI7knAluBxHdYTJuLghXoY8cGvCEoIIv4/yvXD+wiGpEjF1Zkhza9fGZ/29WgY2qo0SouKOvNmOGzqsaKcWJL8Xrj+nS6vS2yWmCfrps/B5p6IQhoyVnpmPKcIglTEY796Xjifm2kZXHvNdgHKJe0TytjwCNNAGoADTkX6PeM2x6rhoDzLThWSa6OltkEc4p5QjBedkB/cG0r09Q3YYO4fGiUidv71rEMDbuuJ/BO4JdOIFmCGPnfol4odOersZAaVsB/PMjmA/Rfw
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(36860700004)(1800799015)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 10:36:59.5736
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e08139fd-c77e-444a-2ea9-08dc5f937a50
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003446.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8916

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

This generates AMD IOMMU COMPLETE_PPR_REQUEST for the specified device
with the specified PRI Response Code.

Also update amd_iommu_complete_ppr() to accept 'struct device' instead
of pdev as it just need device reference.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Wei Huang <wei.huang2@amd.com>
Co-developed-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/amd/amd_iommu.h | 5 +++--
 drivers/iommu/amd/iommu.c     | 8 ++++----
 drivers/iommu/amd/ppr.c       | 6 ++++++
 3 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 66bf20d4a91a..bb9a4c2e40da 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -49,6 +49,8 @@ bool amd_iommu_pasid_supported(void);
 /* IOPF */
 int amd_iommu_iopf_init(struct amd_iommu *iommu);
 void amd_iommu_iopf_uninit(struct amd_iommu *iommu);
+void amd_iommu_page_response(struct device *dev, struct iopf_fault *evt,
+			     struct iommu_page_response *resp);
 
 /* GCR3 setup */
 int amd_iommu_set_gcr3(struct iommu_dev_data *dev_data,
@@ -60,8 +62,7 @@ int __init amd_iommu_alloc_ppr_log(struct amd_iommu *iommu);
 void __init amd_iommu_free_ppr_log(struct amd_iommu *iommu);
 void amd_iommu_enable_ppr_log(struct amd_iommu *iommu);
 void amd_iommu_poll_ppr_log(struct amd_iommu *iommu);
-int amd_iommu_complete_ppr(struct pci_dev *pdev, u32 pasid,
-			   int status, int tag);
+int amd_iommu_complete_ppr(struct device *dev, u32 pasid, int status, int tag);
 
 /*
  * This function flushes all internal caches of
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 1319f93bb473..11b50a6c744e 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1628,15 +1628,14 @@ void amd_iommu_domain_update(struct protection_domain *domain)
 	amd_iommu_domain_flush_all(domain);
 }
 
-int amd_iommu_complete_ppr(struct pci_dev *pdev, u32 pasid,
-			   int status, int tag)
+int amd_iommu_complete_ppr(struct device *dev, u32 pasid, int status, int tag)
 {
 	struct iommu_dev_data *dev_data;
 	struct amd_iommu *iommu;
 	struct iommu_cmd cmd;
 
-	dev_data = dev_iommu_priv_get(&pdev->dev);
-	iommu    = get_amd_iommu_from_dev(&pdev->dev);
+	dev_data = dev_iommu_priv_get(dev);
+	iommu    = get_amd_iommu_from_dev(dev);
 
 	build_complete_ppr(&cmd, dev_data->devid, pasid, status,
 			   tag, dev_data->pri_tlp);
@@ -2852,6 +2851,7 @@ const struct iommu_ops amd_iommu_ops = {
 	.def_domain_type = amd_iommu_def_domain_type,
 	.dev_enable_feat = amd_iommu_dev_enable_feature,
 	.dev_disable_feat = amd_iommu_dev_disable_feature,
+	.page_response = amd_iommu_page_response,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.attach_dev	= amd_iommu_attach_device,
 		.map_pages	= amd_iommu_map_pages,
diff --git a/drivers/iommu/amd/ppr.c b/drivers/iommu/amd/ppr.c
index d4e08800beac..a33ce537b76e 100644
--- a/drivers/iommu/amd/ppr.c
+++ b/drivers/iommu/amd/ppr.c
@@ -139,3 +139,9 @@ void amd_iommu_iopf_uninit(struct amd_iommu *iommu)
 	iopf_queue_free(iommu->iopf_queue);
 	iommu->iopf_queue = NULL;
 }
+
+void amd_iommu_page_response(struct device *dev, struct iopf_fault *evt,
+			     struct iommu_page_response *resp)
+{
+	amd_iommu_complete_ppr(dev, resp->pasid, resp->code, resp->grpid);
+}
-- 
2.31.1

