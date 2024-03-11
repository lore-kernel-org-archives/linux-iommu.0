Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2080.outbound.protection.outlook.com [40.107.100.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98ACA17999
	for <iommu@lists.linux.dev>; Mon, 11 Mar 2024 09:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710148313; cv=fail; b=VjjBz7xdJy3vP2DBzAw1gIXCjkuRk1m102guprKdJzLG746ebla2mhCinRZs/WCJsmCzK/+CYay3C+ygg4CMWFmubMkzndApM4luTx91ZaXO6UJPuDAdj0P3mNCt6DRvn7rA1nBiVUqWaJ4Xq1KTMrpM4LqfDofHmVg9h3Jf2qg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710148313; c=relaxed/simple;
	bh=eiiOFiOnobXofKpOGxeq3Wzni0vjBbQdjTw/XQ3jWbU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iXT217JlEz2EFWAV1GPsJAOEZjZiEHRyUBlRKyO0fX4du/AZ0C9bXxIPJSjHxX1wEJig8/h/yN5a2tFyXISHlKQmJ/pUjW2dK4ttMO4VKbfqU++cJo79Wm8D4fWxmTTr14rpVbIIBCvGx3jSqqILExypnQtrlOaP3JMh8hxmvQ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wnw1lM0O; arc=fail smtp.client-ip=40.107.100.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wnw1lM0O"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B15HrCa47TF82DCzo3OR24VFX1cXN8HfwH7/Q2Wkflewm07TVSj0RCZNkBwc+YEMj009q0BpoxNlYjkjtuzzNYPGe21QGiJgPy7vBllK+VYuigtTMF+Eo1ImpUoYAI9aXP3WZ20JQhcjyFgskFW/MplSCHOAqU7jMw8nYwMc3EqzIVpxk/S+qF4jlKVt0wFTpP/H84hZSu7tgq2hSKvt7byjaEG1o94zNqfM2bk5mQCkjt8XP+i8aG2jeccYDFxgNk9A+ufpFMcwm9lZNvZJ6LPh35pq+VY6XDtAoMLsG/cGmaBKnNYKVhC0HzTej/tsU3Vv5bG5S7f9gFxu76mWEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OmpWa1A5ysefAkEFH0QlNdMwTp3AYEqKaEMn0JwCYak=;
 b=n3vE8KUMvrQf3vf2xcbyGworyEzhRwmkm+auPG61mjHikx1x5s7O00EV6E5gfMAZw2h69aPovfKCe3+jK+OMDCC56ZHP0KnuXLvYezn/lSpWNkFE5TYjOB51tKCpeIEgLQpNqH803QswrXrabtduIyf30HI+27M2KLProshwHOvVYYrWATA7RkxluagBqFe4wET1vCYfKnMqQ8FcXb4xFNgKi+vmJIY/75Xm4kObzCVclwzjRyvqPoy8wr4sMxQDxG6H/i6wa6D0zR6N7kdwcrdLYvekdZuyCTRU1qkgh5ksnthfmuRzKZ/8WK/gUuLFk9PCuUrllvkX+FbSvz7MHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OmpWa1A5ysefAkEFH0QlNdMwTp3AYEqKaEMn0JwCYak=;
 b=wnw1lM0OkaQBUucF0eOUwbmMtLWM6kPCaLuAZMJ27KYB8o+7Tu0ttp1bbIMBia5U4ZorBcT5qcfipGR+37Cr/BblHzZk/i6llPyzzOumKgu+YFNvlzFHGGCrpGI7sqW3dew3YZzpIvUOSiZESi/8F9dvPG+hhXbNPZ+ZE6VcVk4=
Received: from BLAPR03CA0012.namprd03.prod.outlook.com (2603:10b6:208:32b::17)
 by CY5PR12MB6273.namprd12.prod.outlook.com (2603:10b6:930:22::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.34; Mon, 11 Mar
 2024 09:11:49 +0000
Received: from BL02EPF0001A103.namprd05.prod.outlook.com
 (2603:10b6:208:32b:cafe::a8) by BLAPR03CA0012.outlook.office365.com
 (2603:10b6:208:32b::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35 via Frontend
 Transport; Mon, 11 Mar 2024 09:11:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A103.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.12 via Frontend Transport; Mon, 11 Mar 2024 09:11:48 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 11 Mar
 2024 04:11:45 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v7 10/15] iommu/amd: Add support for page response
Date: Mon, 11 Mar 2024 09:08:38 +0000
Message-ID: <20240311090843.133455-11-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240311090843.133455-1-vasant.hegde@amd.com>
References: <20240311090843.133455-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A103:EE_|CY5PR12MB6273:EE_
X-MS-Office365-Filtering-Correlation-Id: 62b93b5e-0f84-403e-76f0-08dc41ab483e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Cpc6cshJsvWpJxLdAEZyRFhCSUp5cq4qfFsSwQf0ajs+XOtYAWwTCUOICNM785vwYEyaVE9U3QTPn+/RfEXUB2zAPSdu2a9MM/Escu6NFknNIvMQO+COHb4N/GA453gpuvW4xi1OB3pbIA3Z2dVaYPuMgtekzRi16GkfCCniQekbKh6tH3iv6b7ATFzoUrq/kX4aKvT5zUMU943Ox2eE3FBT8YL1cSuta1wS0W4ESZQyMZHiMWKzntFjug21i1Y9xhrXH5X169LhT0tnAoLvhI3lLzZZODZ9v4eTM6pEacIMHEbCl63yaxHSTEU+hN5XlV6Wr7fYq9npQKptPlrddfnLbHXkLcVlM8KCImpjRIZkIECLrmqFfji6mx+Cqhc9Je/RZYNZDPp6Vp4H32Splh59lHGgRECfDj9Agn7zdQDO62HhbsMdrAHs1ga1H8cb8PnWo3O3WZOJ5pvjrzub8wR4TwPzR+VsGZIdTlNBFSzzlXx6FwUQ1NKCosADACMvg3feP99PDDtD6a5NArrisRyj6V0V0XOoiSJDMPG/g8Qt3X9Y+8p6OeLoHsQPffuokUV3GLFGph0G6V7IrT94wI/L0ZyMR5hEEXDaF5vPNJESNgg9HCcj8QSycqgha9C1HdhMe7KwL9fGqqA8RMppZR1lZFhqPVLFFJ7GJvzXrQ5Wb2wbjeN5M2eEJVldva1eWqDg5MSLSYnCsu4bloiZGM01K1Cos6cgY1L70DeR9oTL9xV5XL/TZio8gNjZjTZo
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(82310400014)(376005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 09:11:48.6721
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 62b93b5e-0f84-403e-76f0-08dc41ab483e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A103.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6273

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
index 264fea716567..8254b7479316 100644
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
index 60a14e184dcc..6a2872b45dde 100644
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
@@ -2849,6 +2848,7 @@ const struct iommu_ops amd_iommu_ops = {
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

