Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD4F20325
	for <iommu@lists.linux.dev>; Fri,  9 Feb 2024 11:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707478399; cv=fail; b=E+iLNrh5oYT/VFmPuls9220GZBUdvPCbC4n233vO2ePK7jLuMp8CHwtcbwlGLebtwwui0vpmlwYBAo6rKvBbK5MgFluK6jpqM1uUbm3pVG975+qhNNVTTGfkHjNogtJkmy96gVJzrgucgqihpFMxXaUqgkc3rfAIuUs/nFsIUhU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707478399; c=relaxed/simple;
	bh=DPFpSNtZ3MIFxCaa5gkz/i6iEQLVde+HoByhk4jm89I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dcoer0gwSQTIW9pqOqhCdTrnd9OIvGoWlUb4LUK1OGvw55fJZNCfYMFTMBSKjR4f5K03f4PQ4l3FvOn1V7iSC/QmqyNpacvjhHj6+JSyTZFSB80gBqLeG7SdjUtLOtKj2Eh1j3aUgdiMMpz+WhD+G0jnWQs8Q7H4LuD5BCe6644=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Ga3Ex6Dv; arc=fail smtp.client-ip=40.107.236.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Ga3Ex6Dv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tei8aoyy0fDkdcyWc4CailQOZSokn2EPhZMdIu/2xYWsys15KMd/iDDJJ7Wfxithbhifkj1taDMgcbWK9quJQK8oVUS1St3sIKKbXxRzMcuQWj+yU09JWHF0Kl1WORMDULGyju0kEoBe0jlDpV3E7eehw/s48bkMY340unxDwb1lqZt6JCF3dPMxl3ln+H5IID/PEGo8ybywrLUtpmsolrAHvZeX6F22RZvE/AuwtgVQYfyWaEBT+tSw4wlsosuGua+A0+9u3qoaEg8b4qcHA+3N1ufSbR1udF3P9tD+gSRrXV+sw61StEN8jL3rS3QHtHz7+UZZjXk10hgdHLfKxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uJwCwfbgNHjkJNBSrwKvBhYtiaZMH69wNkN9WhCKDSY=;
 b=gHopeguXuOkxFDvIBPmAWC7p40ZlKaa8+yRkgcttOORWgD8Fo1Sim8lAVkeC6FCXxm83I/V/8O+2mvrdzTSfGvOXwxDsRH7Tx6/PG/cFCKks4eKwD9RP1sLN1uosR68bGIhdcDG+3G+k+WGKLFxEH8n1t/xCunCEdejofPqoz4t2K+NjN7WIxiEkcln/DMTTNntQO/R7a85tj8wH8h0mSJczOVROePV5Q3RkCvtZig3RAGi3juxSIE08sOGHR9BzzTD851sjGWZgfQH0OUn1aY7uQSt6F5SyywkfZUx3LI2PFJXuasG5wh2ju1k0bxAb6m8UOMvx5GujoOXl/17XJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uJwCwfbgNHjkJNBSrwKvBhYtiaZMH69wNkN9WhCKDSY=;
 b=Ga3Ex6DvdnsaG/VrzFNJIuVquUNvGo0ygkKHFugZFS8bnEmNUeig2bWQQzaoqvAmb7/56IJ6D3GyfIVWhZyxhs80JaNQRMQHi8Z8M3aFTTgmaCuGXsRDA21bTeVW6l+1lmUs0USlglF1bldbp9II1nnVewC2Qh2QdHEqY3VZE/s=
Received: from DM6PR02CA0078.namprd02.prod.outlook.com (2603:10b6:5:1f4::19)
 by DS0PR12MB8042.namprd12.prod.outlook.com (2603:10b6:8:141::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.16; Fri, 9 Feb
 2024 11:33:09 +0000
Received: from CH1PEPF0000A34B.namprd04.prod.outlook.com
 (2603:10b6:5:1f4:cafe::68) by DM6PR02CA0078.outlook.office365.com
 (2603:10b6:5:1f4::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.24 via Frontend
 Transport; Fri, 9 Feb 2024 11:33:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A34B.mail.protection.outlook.com (10.167.244.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Fri, 9 Feb 2024 11:33:09 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 9 Feb
 2024 05:32:40 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v6 10/15] iommu/amd: Add support for page response
Date: Fri, 9 Feb 2024 11:29:25 +0000
Message-ID: <20240209112930.63663-11-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240209112930.63663-1-vasant.hegde@amd.com>
References: <20240209112930.63663-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34B:EE_|DS0PR12MB8042:EE_
X-MS-Office365-Filtering-Correlation-Id: c2a1fb87-b632-4464-87f4-08dc2962e444
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	h9+o1wRea2aDQncbawCMOB9jOKn4Cfqaf1NNAOl8KymwXYc+iwYG9NCeptxdJofO/d5/m41G+abHtgXQJAJ7XwtQ6Shuj3huX9uXIRGPmngYiALljN+4SRcCWk+ErGu04R97oO+BHGJQ31JBb8Zb2l6BtZfWkwNNnyCSNcBKxu+OYYJL5UOtMa7dNuT71v8rrF8SWs5VDEeuVFNPCDL1rU49KxdC/pGR9ea3JNIrAOD7sznja1UA3Q1PvWQbKk/V/qNdLkFH7NDFDPzKRJSySmi/C9Uy0ubEl4BzbU/05fF4ZhD4/15Xg7gxg3rQbZC/E+Pn0s66UGDl6I3rGVWa4ly1hZIGXA3bSiotup/12fFfkW6jfXmsWjQSq9tpCoowYoyN5FlFGMpz8CGODOMTEHvW4YHwCQIUBP2aL8e8FiP1RKFMvARlRx8q5Lo5hVd7Tn5H+l9ZibXV+tkcRxc4zo5bSn0Kf5yRXVeLMRUhEQOIzblGzFasnBcbPb2G6Q+WY82yjcQCvxdLjerJM359rNcEVD30kp0p775dntjK7El1TAC+L6TEqrKVLBMouuC4hyCXUZ6XznSZvvWrz/oLgZBqXFPnaNd2v9iknf3TnT8=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(136003)(396003)(39860400002)(230922051799003)(82310400011)(186009)(451199024)(1800799012)(64100799003)(46966006)(36840700001)(40470700004)(41300700001)(26005)(356005)(16526019)(2616005)(81166007)(426003)(5660300002)(70206006)(336012)(86362001)(83380400001)(82740400003)(4326008)(6666004)(316002)(70586007)(8936002)(1076003)(44832011)(2906002)(8676002)(110136005)(478600001)(7696005)(54906003)(36756003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2024 11:33:09.2373
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c2a1fb87-b632-4464-87f4-08dc2962e444
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A34B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8042

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

This generates AMD IOMMU COMPLETE_PPR_REQUEST for the specified device
with the specified PRI Response Code.

Also update amd_iommu_complete_ppr() to accept 'struct device' instead
of pdev as it just need device reference.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Wei Huang <wei.huang2@amd.com>
Co-developed-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/amd_iommu.h | 5 +++--
 drivers/iommu/amd/iommu.c     | 8 ++++----
 drivers/iommu/amd/ppr.c       | 6 ++++++
 3 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index f2084f90f056..030a04451599 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -49,6 +49,8 @@ bool amd_iommu_pasid_supported(void);
 /* IOPF */
 int amd_iommu_iopf_init(struct amd_iommu *iommu);
 void amd_iommu_iopf_uninit(struct amd_iommu *iommu);
+void amd_iommu_page_response(struct device *dev, struct iopf_fault *evt,
+			     struct iommu_page_response *resp);
 
 struct amd_iommu *get_amd_iommu(unsigned int idx);
 u8 amd_iommu_pc_get_max_banks(unsigned int idx);
@@ -69,8 +71,7 @@ int __init amd_iommu_alloc_ppr_log(struct amd_iommu *iommu);
 void __init amd_iommu_free_ppr_log(struct amd_iommu *iommu);
 void amd_iommu_enable_ppr_log(struct amd_iommu *iommu);
 void amd_iommu_poll_ppr_log(struct amd_iommu *iommu);
-int amd_iommu_complete_ppr(struct pci_dev *pdev, u32 pasid,
-			   int status, int tag);
+int amd_iommu_complete_ppr(struct device *dev, u32 pasid, int status, int tag);
 
 /*
  * This function flushes all internal caches of
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 1c3a4914cd35..0fa172e0583d 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1632,15 +1632,14 @@ void amd_iommu_domain_update(struct protection_domain *domain)
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
@@ -2854,6 +2853,7 @@ const struct iommu_ops amd_iommu_ops = {
 	.def_domain_type = amd_iommu_def_domain_type,
 	.dev_enable_feat = amd_iommu_dev_enable_feature,
 	.dev_disable_feat = amd_iommu_dev_disable_feature,
+	.page_response = amd_iommu_page_response,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.attach_dev	= amd_iommu_attach_device,
 		.map_pages	= amd_iommu_map_pages,
diff --git a/drivers/iommu/amd/ppr.c b/drivers/iommu/amd/ppr.c
index 39ea979c7134..a6724809753c 100644
--- a/drivers/iommu/amd/ppr.c
+++ b/drivers/iommu/amd/ppr.c
@@ -137,3 +137,9 @@ void amd_iommu_iopf_uninit(struct amd_iommu *iommu)
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

