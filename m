Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010000.outbound.protection.outlook.com [52.101.61.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01AB3A453C
	for <iommu@lists.linux.dev>; Sat, 18 Apr 2026 23:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776555726; cv=fail; b=d1Yjz/Yg84Df5Bp1LK464MT5DiU+pZXwXM2BHkNZ/+/HWn50nl6iPmsDYV+m9YrnQjPyuXXU6D2iV/Tbfa+0S+v/ySwbeeQZiktB5zZXNOZb0Q6DfzHuqMz1/KEg9aGm5a0SJ7dSGZ3C+xUvDEBsVs9NsdAch4dtZ8XHOBMqZ8E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776555726; c=relaxed/simple;
	bh=8sY+pj+T4XgLL3gm8gl1OzHPLl1DZQYuuDz66CU9W3Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o80zHtvzGh/ejbijDxGqtDatP7nEZb7KMScy5boUaQdG7KHqYdgVoDT9Q0a4rPVLmdpbpkG5AajBuQEmSk374fX7MBNN8SkOwjXzII8Nka3wZLz0hMyImi2EdntFXgPveQm5frwlkPkdmo1FwMP9JKzkx+Z9jm7nmVzv9obi9Kk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ol8zNVBa; arc=fail smtp.client-ip=52.101.61.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ol8zNVBa"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hgMmpXwyYmkNBRKZOz4KSe1mOVVb/RW/MB3xjIVCV+um2YcrEf8ZgJFHg+rfhDVgpFoP5UviFMiQOd7Ck5kDjk219HYHyS0aOJvj53iMIySOJHZhJhARq+0yOBsFXGrHgYt7cWNaK+yf7Sn7kGhVHtAYvFDHFR6TgC0Ryg4j9bh53fa9hXKMp/xTA+Wr0ni60s3JJZsDNw3Eps+5SC7L4cS7OaVGt2ntpLLF8BHdKgik+nPWxpZzgp4pv0yNn2WFM9lUbSqjNrRUih2q79CvO1EHcfAsplr+Pi0txrmycs2QUmq8BH/eBA4W5jsyow+z2m7bjJkCy57jESrmJThWhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HA2YYHodJWY/zbHe5c8QA02jtvg8NJ/awoZOgxpKY/s=;
 b=prv69xdGHj4joZ3CDcBnJnDUBoKrc3YIW3S15dw6T2Wo+LWFx12HmWx43P79mVEtD2ewjbejYkfWqhCpHh/g1Hs7hiaesVFYHx89TqNAS3W/KcTbZK1wWFeu8n1vL5d5YnU0dV4y9B9qvmor9/P2pGg1/ixYtCVstKcvuyY5rhgPqHmuLMZZRW5ThZyq5eY5HQXHkzWE1BzxBvlRZ4blT+V2qWTxwffNBCjrg7R6XgT6YIZZ3qYRpkbj7SbtGkU8LtN8Jg7AZNe9aNmLbv72gq9/M7Ad0SOSp3tAyJbezW2jvcBZ+bKY6F5Jk2rSvIZBr5kLNBFB4ff1ZH+vi5YJIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=8bytes.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HA2YYHodJWY/zbHe5c8QA02jtvg8NJ/awoZOgxpKY/s=;
 b=Ol8zNVBaGEniF2PUC7FwR8Nl8EbHj1j/1yUQ019m5ohaXmySS+t5aAz3TO7AQYITphHpprouiH3rZgnYc4VsT78cRDeQvjBxUHrGwMdzqc+3GFSJ4UHUSnJnd5Nl82RmDktwvFU4+GKNWs54fKKvCyRAKK87s9563MmQ37aGfEf9JVrGjRgvLGyT0By7iJ7pHhTyaDadLlpHF6apKFLDc/3+Yf5GxM7Gn6xB0UUgjGRMGx9UDiyVXoPO5IRuaTijM2MYSLq26xTV/99+4Ll/hq52FYMGF/L2MMkD6EKLYl8McMOzjNTmq2GWWSC+GfLXRsic8XHKEJCCyhhVTAt4tA==
Received: from BYAPR03CA0010.namprd03.prod.outlook.com (2603:10b6:a02:a8::23)
 by DM3PR12MB9414.namprd12.prod.outlook.com (2603:10b6:0:47::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Sat, 18 Apr
 2026 23:41:58 +0000
Received: from MWH0EPF000A6734.namprd04.prod.outlook.com
 (2603:10b6:a02:a8:cafe::3e) by BYAPR03CA0010.outlook.office365.com
 (2603:10b6:a02:a8::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.55 via Frontend Transport; Sat,
 18 Apr 2026 23:41:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 MWH0EPF000A6734.mail.protection.outlook.com (10.167.249.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9791.48 via Frontend Transport; Sat, 18 Apr 2026 23:41:57 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sat, 18 Apr
 2026 16:41:49 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sat, 18 Apr 2026 16:41:49 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Sat, 18 Apr 2026 16:41:48 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <joro@8bytes.org>, <kevin.tian@intel.com>, <jgg@nvidia.com>
CC: <will@kernel.org>, <robin.murphy@arm.com>, <baolu.lu@linux.intel.com>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<xueshuai@linux.alibaba.com>
Subject: [PATCH rc v7 4/6] iommu: Fix nested pci_dev_reset_iommu_prepare/done()
Date: Sat, 18 Apr 2026 16:41:35 -0700
Message-ID: <ab6d836f38c31b76275b1372874641a925a136dc.1776551790.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1776551790.git.nicolinc@nvidia.com>
References: <cover.1776551790.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6734:EE_|DM3PR12MB9414:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ba8d2ac-0260-4c52-134f-08de9da4148f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|376014|82310400026|13003099007|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	W1UCXfRlFIdVNJVILb76tDZq5zYtkQVdrBdeIaoLBWTdB3IV25wm1jyo3Qjw/SO6S70WsKoHHv4y7/EyEv1oIKPll977mCJo9XS372+1lNQmuCDby3I0Vz1USxbJBiI48AWmbgOGBewp4Rsud9RdFPtLuMNdH6WwjGhZu/ilF81jjuTQpZ/7dk0O/v86stl1WtKjBDhA7X7u0OGVDcyMFd9Wz5/6dDl91ogYRxS/JNGEhfzEq53Th2KBS9epUkd+KhPI6GatskF+9ExkfVYeofK0tMLpMSIV7nTHKyzO53yXzsRfm1CcIE7hjytsJeqrSJWgte+fmT3LlIoQm3y2MOdrFBbumrLlr2uEiPFJK+KL6dnHRRcZ+x9/3l4iPv4bHrypKpyeBLdTpu87wrk7NScZsdKZtec+1BWj0AuBogB0GMTOFh8ePfv8YbEui+kEo0kmClqxm4cHK6qbCZi8xPkB+oRZZ+S6HuA0hdKZ92I0xew4C8WmxYfsPda2iVlAqQuYosuNq68CDD6ZhqPhPr1x+rrc5B059d97WxWfinEYf9XrB8HD6jGan2cQpk8OarbqBq2Gpqu+RQrMaKCfkhMGQbeuPqB/FKRTYrdPcDL4lLf6xxXf0JX6vBXJnbSCv/Jo7CmVJfWTufcxH6Y0/DLYwJGsbJWb/mYNuZgI9lreu9MYPPYUoWPRSI98egjtJivMW1KEsNDHI2UvYZWPeDUAprbBVtkOlyouvfqdLLC294HZp8uIUK/JwZQN4OpcOOR4X1nLQjezxRVRWe6UyQ==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(13003099007)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	kRPCptcK9x/Y7bzs4HLwvn2RB49QDl8EkwSbyuEtzV8vm4PLPqOZGRgkSm5DZ/RDUrtI4MhG0+J6QQMwtuPOw6orGPniNi59fRRp6t+RFt0dS01E6pQr4tRRVQwQMVxOgwasQdkdMURmrLqz5KG8NRuHb5L0BOsUeVXhCg2bJzretKGeskLBTMJ2zkwdMKd7Vxx51p9eq0sUu4PSUXH7LwDG1QfsDMMgBVSfNFkJud7jPYW6ko7LQ9YelwW2KG9chWt5z6lm64Le1fkYVSXKRB8CrjA8q1nSTEeqoiyrQe0/6hmrMM1fDiwa6O6ogYm1eDTWEHnrMz0GeBFOegN9sObr0Cfgt8Qqej8uHqax7oQuVDb74tWnwz8NIpvR0Ro5N1CGMlmCIju/KegNs7cDia43W4Yg/DjGnppu8YgT4u9SjZizDwYDtqOlkc+k9jXR
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2026 23:41:57.7344
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ba8d2ac-0260-4c52-134f-08de9da4148f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6734.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9414

Shuai found that cxl_reset_bus_function() calls pci_reset_bus_function()
internally while both are calling pci_dev_reset_iommu_prepare/done().

As pci_dev_reset_iommu_prepare() doesn't support re-entry, the inner call
will trigger a WARN_ON and return -EBUSY, resulting in failing the entire
device reset.

On the other hand, removing the outer calls in the PCI callers is unsafe.
As pointed out by Kevin, device-specific quirks like reset_hinic_vf_dev()
execute custom firmware waits after their inner pcie_flr() completes. If
the IOMMU protection relies solely on the inner reset, the IOMMU will be
unblocked prematurely while the device is still resetting.

Instead, fix this by making pci_dev_reset_iommu_prepare/done() reentrant.

Introduce gdev->reset_depth to handle the re-entries on the same device.

Fixes: c279e83953d9 ("iommu: Introduce pci_dev_reset_iommu_prepare/done()")
Cc: stable@vger.kernel.org
Reported-by: Shuai Xue <xueshuai@linux.alibaba.com>
Closes: https://lore.kernel.org/all/absKsk7qQOwzhpzv@Asurada-Nvidia/
Suggested-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Shuai Xue <xueshuai@linux.alibaba.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommu.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index e9ffa562b614f..ff181db687bbf 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -82,6 +82,7 @@ struct group_device {
 	 *  - Device is undergoing a reset
 	 */
 	bool blocked;
+	unsigned int reset_depth;
 };
 
 /* Iterate over each struct group_device in a struct iommu_group */
@@ -3997,20 +3998,19 @@ int pci_dev_reset_iommu_prepare(struct pci_dev *pdev)
 	if (WARN_ON(!gdev))
 		return -ENODEV;
 
-	/* Re-entry is not allowed (will be fixed in a following patch) */
-	if (WARN_ON(gdev->blocked))
-		return -EBUSY;
+	if (gdev->reset_depth++)
+		return 0;
 
 	ret = __iommu_group_alloc_blocking_domain(group);
 	if (ret)
-		return ret;
+		goto err_depth;
 
 	/* Stage RID domain at blocking_domain while retaining group->domain */
 	if (group->domain != group->blocking_domain) {
 		ret = __iommu_attach_device(group->blocking_domain, &pdev->dev,
 					    group->domain);
 		if (ret)
-			return ret;
+			goto err_depth;
 	}
 
 	/*
@@ -4037,6 +4037,10 @@ int pci_dev_reset_iommu_prepare(struct pci_dev *pdev)
 
 	group->recovery_cnt++;
 	return ret;
+
+err_depth:
+	gdev->reset_depth--;
+	return ret;
 }
 EXPORT_SYMBOL_GPL(pci_dev_reset_iommu_prepare);
 
@@ -4070,7 +4074,10 @@ void pci_dev_reset_iommu_done(struct pci_dev *pdev)
 	if (WARN_ON(!gdev))
 		return;
 
-	if (!gdev->blocked)
+	/* Unbalanced done() calls would underflow the counter */
+	if (WARN_ON(gdev->reset_depth == 0))
+		return;
+	if (--gdev->reset_depth)
 		return;
 
 	if (WARN_ON(!group->blocking_domain))
-- 
2.43.0

