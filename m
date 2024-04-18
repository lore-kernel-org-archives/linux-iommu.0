Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2083.outbound.protection.outlook.com [40.107.237.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AEE815B984
	for <iommu@lists.linux.dev>; Thu, 18 Apr 2024 10:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713436690; cv=fail; b=Vdz7is+ArFtMbGoOPw1i7HGQC9nnSf1uoONmBlWh7mraSCFtCTWx+czLRt47rcJkMyCzSRfeOfi5u2LzIIvZ0ItvOg9CqSg8BAikwN2aZW3SEtV9yoO9vZcjcZw1i9J4Ij5UFOXwjR55opkBRkCcwL+UUb5hWfIYxgKin5jiwvA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713436690; c=relaxed/simple;
	bh=S/DqCaY2QtBypxxxwvXqCcfxah/OIHvyxN/nXYDWqxs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hPsGUSEz77M4DdzNiLb+0MxT2ouq2aUJTU26NWKZTIOVnDEKJyY2YBO/NsRRNvzCuBFeHhjy6Q8/vWlJMAVCA6f/mS2x54EaUwgAQ1TUMOXDIV2Ja0hLDRDv/hYNz2FRftjy2yoEdlKjH2E6xXQ1XRL+Ko7wKxxoWRd8V+qlW0c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lH2PH0yB; arc=fail smtp.client-ip=40.107.237.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lH2PH0yB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VKD+WuzxBtFr9O4/FbVEMv1joor9NVBbYu+4XBf0X6DDhppBSG1BO/9jiVKB/hrt6tcKN0Kohkyh6jVZcdSoV/shtZbNvKWhxq+44SwECc+b0Rj9hdL1o8FzihBUUa7zwiHm2XwVf29GW8uy8EhJKwfJSoeSDcJFv6Ix9f/mxRXSnQhBmhH7oWFH8oUhU5KkK9NDf3D9EpQXvoBKn6rvyhJYTUnlNc+KEQ5KMkJiijEEZk3dJzVZ5ZwsngNZKyMd10VxNsgiQ3xOr+yTQJpc3IKkuMjgxqwOOfo6fU24SNGhYHILxS0+DpcA0XM60Dqrzh1qGikFwI3WVc2TuoulaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mz7Hh1ZowKZkuiWxnD1UvqR0iZP6D9pFvXALBwsW9hU=;
 b=hD0bblC66iablA6J5UZPQSTyTrkqEOXJGAEBsHdqLV7gdPTD73ZVmG/w2IgK3o0fD9Cibbsvr+7JtHoZZagXGHT1qvLg0Ix07Mu5oFVp1ipjvi55RQNn+IBzKKQmC7Uw/EMMvSUbaj9b8zd3JG5N6aiIFmUyXCZqnedf+PeqpxqmvzMl4opR4I7RrTuz40C6B5OAU4/dkINQ3SiLBl61td+Ty1zY6FebpX2/RaxGfCPeOAsvRFC/nUlS0gthnyVnatKBc3u2NDTa+U6j/Bz54H3l3a1J1Khu/43WWnYh3hVSYiL6fohSIcIPFl4PYnpHclibncgEogjP+vHvnLuHBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mz7Hh1ZowKZkuiWxnD1UvqR0iZP6D9pFvXALBwsW9hU=;
 b=lH2PH0yBxcEi7/4kD/ree5rby8vmCDVVYbIhkokY8S8bOHEFQQvCvJsA6/60mY1BO/S15sR12lBVeSuzyC8ueIeFTsgScKkIdK57Ho/mUXU0DhOWT7QMKEq8ebpt9cD6uTvVBOTpYQRP5phaRIclwBaSQY2nsSYslmGC73+1fsU=
Received: from CH0PR04CA0111.namprd04.prod.outlook.com (2603:10b6:610:75::26)
 by BL3PR12MB6377.namprd12.prod.outlook.com (2603:10b6:208:3b0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Thu, 18 Apr
 2024 10:38:05 +0000
Received: from DS2PEPF00003444.namprd04.prod.outlook.com
 (2603:10b6:610:75:cafe::fe) by CH0PR04CA0111.outlook.office365.com
 (2603:10b6:610:75::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.23 via Frontend
 Transport; Thu, 18 Apr 2024 10:38:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003444.mail.protection.outlook.com (10.167.17.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Thu, 18 Apr 2024 10:38:05 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 18 Apr
 2024 05:37:59 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Jason Gunthorpe <jgg@nvidia.com>,
	Vasant Hegde <vasant.hegde@amd.com>, Tina Zhang <tina.zhang@intel.com>
Subject: [PATCH v8 14/15] iommu: Add ops->domain_alloc_sva()
Date: Thu, 18 Apr 2024 10:33:59 +0000
Message-ID: <20240418103400.6229-15-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003444:EE_|BL3PR12MB6377:EE_
X-MS-Office365-Filtering-Correlation-Id: 55ba6934-f710-437c-b77a-08dc5f93a199
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	DT8lBMkuolx91JxuBic8xcmrEzbPer70BbjwhGoZ0eIGYtLA5Poj17r2IGiUzQQVk8SpR55c4zIGmn/lDjSNsh/ICU2IwaYDdWOnk6JJgHD4MWhSnT23LIC/CncZ/I1P3EWqPzlYWBbsAL0pgoVuEbBAtGk60SbRae4YIliHoJo4Ezhy1CfTC8t0uZwWvOXwIvAQudOeINdz+B0stIIj+SDWEE25WX2qI1fRvVsQXT43UAS2G/duXSFRkQmppyVMzrv9WEdyisbKOnHJeum9oLtYuvH4ePF4IwmDeoSrsfnZ224KypotDEExuaIp/hsS0HtyrH1iU0W2VuiQN0AgDaW6XUPaX6MTAIkR0fVggU9qx7xihJgcWhXw58+mieaJQfdbkLPp+E2UvHs/zYUtCYy5Jd/p1Ka8dyVg29RuFYeVoG9p1Z+fcFeVI3mgpQxPOsqrv86c/EXmJr33GKz/+9rPNaAjdhFKg8PLkSPuFNp628nTU90fGRodfPW5qWlrs9xOZD5iJ4frLZWVdNDI6LofETqZ9v+dzTNIDz+Q6tFRZk9UVstthDIBidwjePUaEunAOHXcjA56iqL/seMHyPgbz7Xay2mS7nqUYUYDbH2Vruo4qO8e6fg0XSD/HiXMl3ZpvPP9MKILVAdE25iDLlreC2KP961KJvMYLOcgDyV151uktQ80y5GveS/gjih3h3qN9wqwlFSefUKAFE+2Fh1T6viwYkU/742/RrFAfLidMJIGthQ3RxHaGAqzw9+8
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400014)(36860700004)(376005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 10:38:05.4867
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 55ba6934-f710-437c-b77a-08dc5f93a199
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003444.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6377

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

