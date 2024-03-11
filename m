Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2042.outbound.protection.outlook.com [40.107.237.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C7CF9D8
	for <iommu@lists.linux.dev>; Mon, 11 Mar 2024 09:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710148377; cv=fail; b=h2LRWvuC1f6nwcq/qNc3QYJav76DFQs8lGCiF8ISv4XWPH50t5mIFBvwSKACKtL2IaHxLyrRQSZPcQq2gp+jp4RU20IREBEOGfYopMBUH+kOz1osb+q7yUDwABXxAyVZeEC9tOwvHJIqxGrGbSAtqZ1G/zsqKTEfDKK5FaAbejo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710148377; c=relaxed/simple;
	bh=S/DqCaY2QtBypxxxwvXqCcfxah/OIHvyxN/nXYDWqxs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LXCtH4Iye+p00r3TcbFkCHWUrXcvjgBYYV/56kXWqZ6FtKViYn1Tk0Yay2onrRKOGXI9qGtJbjiteeuXNizxXpMPK5RioSXBZ5CD5oydUl1EWQTj5NbizdmJWWZ6dzMLRulccJSL8B4HtRmkbLwMNjIKWB3zgkpSA5DdYdmQ29k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=S6Q4z6Zh; arc=fail smtp.client-ip=40.107.237.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="S6Q4z6Zh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mHziQtn82138qCNVncefxXJTHGlpM5x9VvijPk7sF6EAbyW8hAswgiIekfWVscc0jXfsUqGCDWsmku9zGPwR9e4aMQya/NYe6CMBCyfpeW+WOPZRJxPI5q791eaJN+Leyaz+2uaC0G1EyFbNd8SV7dOK645Af8OMz/4/ZikFzOkUbQqcFXYcctK2uShzvDBjQf01J5hGENyb/aPeWXwcGsi/SXbl2JscDHcvwTMJgOumTRtLn5QxurfzX8Ub92o3eCUX1roWGFzh1ap8ku3gMHyQjouN4raqebbaDnBfqIHtRECd+fLAJOPfdtFZoVV6Lv3wYWl4nekoXbXhZCp8Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mz7Hh1ZowKZkuiWxnD1UvqR0iZP6D9pFvXALBwsW9hU=;
 b=b75e+4Hfp8i0vC/B6VQUhzTBopB1Wg0c/3ZapPhcrz6f/Gafz/ibc3+sXNvmbyiJmkEZSOvbjlFseb/k5yy9o72E7aJslEkGpM+pqidJ4MhitRn6eGeCsR8G6YLtDD5R+bQAAePFR+VW16p0bfmhpXANP70SYsrYIIiN0XFvrSAjnNvzaD4WzzWs8ED3AbtW3l/zEqjJYOlTfaqxAf/m9Gk28ATjOQP1RXjNIjnnYfCdhMLU85CiaMnplpx+O18evrKvwUpEuwuMTc7DJNL4yyMdSbiH34CAjAfR5P5TOWrFhZxWicdQOaOryCpqfSp5pOlaMuXeN3+yPiSioLeekA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mz7Hh1ZowKZkuiWxnD1UvqR0iZP6D9pFvXALBwsW9hU=;
 b=S6Q4z6ZhShg4PGDo2IRtAAb1OdBwhbjMA0Z6Oiz2XIM7hUCp1trAn954bAsDgRBUPqwKWnn9SFub/UbCMR13jERQhggXFdZfAP9cLGejgZKw69WNcpl/xyYA2IU+GacbJpt+YgkksXt8lH9kTVMryztm6oBmWJcEST1Di0RnAns=
Received: from BL0PR1501CA0033.namprd15.prod.outlook.com
 (2603:10b6:207:17::46) by SA1PR12MB5639.namprd12.prod.outlook.com
 (2603:10b6:806:22b::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Mon, 11 Mar
 2024 09:12:51 +0000
Received: from BL02EPF0001A105.namprd05.prod.outlook.com
 (2603:10b6:207:17:cafe::9a) by BL0PR1501CA0033.outlook.office365.com
 (2603:10b6:207:17::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.34 via Frontend
 Transport; Mon, 11 Mar 2024 09:12:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A105.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.12 via Frontend Transport; Mon, 11 Mar 2024 09:12:51 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 11 Mar
 2024 04:12:48 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Jason Gunthorpe <jgg@nvidia.com>,
	Vasant Hegde <vasant.hegde@amd.com>, Tina Zhang <tina.zhang@intel.com>
Subject: [PATCH v7 14/15] iommu: Add ops->domain_alloc_sva()
Date: Mon, 11 Mar 2024 09:08:42 +0000
Message-ID: <20240311090843.133455-15-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A105:EE_|SA1PR12MB5639:EE_
X-MS-Office365-Filtering-Correlation-Id: e25f3a91-c8d0-4017-2c0e-08dc41ab6da2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	bDNi2KGTDZIoF6AjclLm3qQkEqmyjYJvvwfyUJKKJi9DNBZ0piX2FY2uzAXDKyK6pnVw2QrWlQzPagv0Udrtvm/smT5U9JWipMbj2iD6I9InA+PduCHiOVNFWu8eoU1rOXu66vFhc9JucqLR2JeUhQs63ZsPrd/zZbEwoinm8JnKsiR8uSpFkJWPlhkgeSI2qor7HctRvqrjY9McHph+V4tsxg5KfiIAgJF0wqwJnKzp3gS+SGpb3ZnL+4VY6BWOl9ZV/f4i7mDvzJQ3ZQHTuVRmbqUjWMjJEvz4HPUTmzTRRRyWVcuTkfn23eCQtJn7gg0mBSbN+1rLsJcb3089vKs1sf67zjsfeHD21261Vc/rFEZce2i30Lb5hYjNv7QpQPBud8CUadD4jBNIjxkwkxc7CLaXxChey5n/F14xmcDxqUOACBy72/x/DtdCkARmPR6Kj2GCsPv4N7N6YxcMWkLiP0Ze6dq7rOmsVb8d2v/5y79Nlbib830p6sq0EAAuIK3mTJcuhi0vRvz7/do/ntyfE8Om17APMZYMFcLYNbqylwpigYz+howbGUTks8QeD5gBpSuxVjE/UkD/f9iP8kO0tRNM/p9LJX5JTSvjz7x8NAYS3y4/6BIdNPBT8wMY6yAeQjkwnW0BE7eM5nNW2JtzLLLNQonZUNLbwscfKl7pT0iE3ckVQpNEWR9noiC3KnXsnxqkA9p5QX/0QGsSUJTNerzvu6D9lomldc04MGj9lCsXm8FQFvYdAS0sVLi7
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(36860700004)(82310400014)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 09:12:51.3856
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e25f3a91-c8d0-4017-2c0e-08dc41ab6da2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A105.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5639

From: Jason Gunthorpe <jgg@nvidia.com>

Make a new op that receives the device and the mm_struct that the SVA
domain should be created for. Unlike domain_alloc_paging() the dev
argument is never NULL here.

This allows drivers to fully initialize the SVA domain and allocate the
mmu_notifier during allocation. It allows the notifier lifetime to follow
the lifetime of the iommu_domain.

Since we have only one call site, upgrade the new op to return ERR_PTR
instead of NULL.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
[Removed smmu3 related changes - Vasant]
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Tina Zhang <tina.zhang@intel.com>
---
 drivers/iommu/iommu-sva.c | 16 +++++++++++-----
 include/linux/iommu.h     |  3 +++
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
index 640acc804e8c..18a35e798b72 100644
--- a/drivers/iommu/iommu-sva.c
+++ b/drivers/iommu/iommu-sva.c
@@ -108,8 +108,8 @@ struct iommu_sva *iommu_sva_bind_device(struct device *dev, struct mm_struct *mm
 
 	/* Allocate a new domain and set it on device pasid. */
 	domain = iommu_sva_domain_alloc(dev, mm);
-	if (!domain) {
-		ret = -ENOMEM;
+	if (IS_ERR(domain)) {
+		ret = PTR_ERR(domain);
 		goto out_free_handle;
 	}
 
@@ -283,9 +283,15 @@ struct iommu_domain *iommu_sva_domain_alloc(struct device *dev,
 	const struct iommu_ops *ops = dev_iommu_ops(dev);
 	struct iommu_domain *domain;
 
-	domain = ops->domain_alloc(IOMMU_DOMAIN_SVA);
-	if (!domain)
-		return NULL;
+	if (ops->domain_alloc_sva) {
+		domain = ops->domain_alloc_sva(dev, mm);
+		if (IS_ERR(domain))
+			return domain;
+	} else {
+		domain = ops->domain_alloc(IOMMU_DOMAIN_SVA);
+		if (!domain)
+			return ERR_PTR(-ENOMEM);
+	}
 
 	domain->type = IOMMU_DOMAIN_SVA;
 	mmgrab(mm);
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 2e925b5eba53..8aabe83af8f2 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -518,6 +518,7 @@ static inline int __iommu_copy_struct_from_user_array(
  *                     Upon failure, ERR_PTR must be returned.
  * @domain_alloc_paging: Allocate an iommu_domain that can be used for
  *                       UNMANAGED, DMA, and DMA_FQ domain types.
+ * @domain_alloc_sva: Allocate an iommu_domain for Shared Virtual Addressing.
  * @probe_device: Add device to iommu driver handling
  * @release_device: Remove device from iommu driver handling
  * @probe_finalize: Do final setup work after the device is added to an IOMMU
@@ -558,6 +559,8 @@ struct iommu_ops {
 		struct device *dev, u32 flags, struct iommu_domain *parent,
 		const struct iommu_user_data *user_data);
 	struct iommu_domain *(*domain_alloc_paging)(struct device *dev);
+	struct iommu_domain *(*domain_alloc_sva)(struct device *dev,
+						 struct mm_struct *mm);
 
 	struct iommu_device *(*probe_device)(struct device *dev);
 	void (*release_device)(struct device *dev);
-- 
2.31.1

