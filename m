Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011051.outbound.protection.outlook.com [40.107.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56921A6839
	for <iommu@lists.linux.dev>; Sat, 25 Apr 2026 01:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777079761; cv=fail; b=UF3SxjyxqJLfdoSPGedksO+Y7dr3WxgGmT4f2zNr+24LKUyT9dUMmu59qySr1+v5L7nyAtsW+uirnEUaL5pLZy42nsvkknYyFZXwJCEy0/3aztOT+m8pr9IfbSDev3F3TW1C/8fzWCpMJP2PWwDVa8i6oGmYKh3cw+3sRA9Vz6E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777079761; c=relaxed/simple;
	bh=Ji+Me6Ebh8qx3UDXUw+EU1E2Bq6+UamXvtty1jyNN+M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xjukr2MarTHGzZRQMmatc1koI+j7uRp+UV83avulGIn0iFp7GrqY+Z9ztK4KW+diTx4MXUDUBwA+ljAwcIi1QNZXlYcYAAN5k1TeaoZ3GNQDEM/xmP1VgvgAlmFuSPYY/tytmQFJt0jR0W5WZGSWQfaRPT811i0PgPGHovpCVGU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LxQqAM9w; arc=fail smtp.client-ip=40.107.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LxQqAM9w"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M2plIX4IUV0V9ylkL50nQZYxW6PtqrWQPRWnV2NjyTRvuaTA3X9z5pIDS6+ATJ6zFT44N0ZdpBSA0l5lg+vZp4FBv9bSC33z5rO9eTmirnhkemAGRKSOWyJJWlhvWAL4pXAnW0NywNUQqy9pc16Z/DnOT1A6c7XJxqywiAsz10jgJezeosuF9pwHFDIsmPVcKCisyKQvSvwgrKS63KPj3C9WNa55BgccsP0c1wnC5lpko1P4n8jk3D5VYZK0+0x0+bs+8x3jctBFwFKCb0Vnuvii0uw4sfjZz7ZJ0d2iAma/GWUOyP7mzwrxJKhsjGmBuDYPdmWDLRoxFfXBq/v3JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gxdipz34r/Q6s19GQI8j+GedKjPLy9C6Qz4s329AXPo=;
 b=fWdDPYSVR0HOeQcTJ9O8eInShJYg+2LgU22NTHY2bXh7PNHYxjL20r+Fex8Czm6WHe1XtheRcG/n3pVQ1uVmxbQ5EGid5AWvvEwgCs7TDajTvpqEKE2obwZaD++D4u0mZ+BkO+NSqp1LWDJ8/VrBMBoJJgLmzmJGJlzDThLEdoK93awNAlTSXhBPRNVar5VvJlI7WfYcNfppBTnktg8qMbmNZQfPC0Re/dMSfYRCqzWPIA20xd6pEZF07zb2eYuIpLmtnTYKNTXXMdst7mi0M4uZqDfb6/1gaNsg7z8011AZVS1e6H0WC4t6gJkhmWy+IxwXcU1TFlxnoqUEBGcOqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=8bytes.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gxdipz34r/Q6s19GQI8j+GedKjPLy9C6Qz4s329AXPo=;
 b=LxQqAM9wExRF+zMNMO8fKZqC9HQUSe9Qe41nO+WA+C9KLLZacJjXTZrff5ena10WW+CtrqYf6YktJ6uxlWT7QOwjY4PUQTuT37T0cEaNayNPIbBeSK6HM44B6PxFHYapQu4fSJpDQBvIyPX+/sewRWtEn6Dc/wiKsnk2B9MGm9C4y7CFkzJYTV7EcXmW5MADcnO8HVwxdNPS15ZHa/vtGnHgNz4Tg/GdjxRvxFRzlmzchn9cnB5n8odkhkpFc5c0Ap+8ulRVNFGhJb4+n5T2XnsfvRWa1D6FXTdXAmrdo9BjjjSmYdV+uTSTZB17k5nIEha218vTfGq3ON+84iM0og==
Received: from DS7PR03CA0322.namprd03.prod.outlook.com (2603:10b6:8:2b::29) by
 MN0PR12MB6080.namprd12.prod.outlook.com (2603:10b6:208:3c8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.22; Sat, 25 Apr
 2026 01:15:51 +0000
Received: from CH3PEPF00000013.namprd21.prod.outlook.com
 (2603:10b6:8:2b:cafe::2c) by DS7PR03CA0322.outlook.office365.com
 (2603:10b6:8:2b::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.23 via Frontend Transport; Sat,
 25 Apr 2026 01:15:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH3PEPF00000013.mail.protection.outlook.com (10.167.244.118) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9870.4 via Frontend Transport; Sat, 25 Apr 2026 01:15:49 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 24 Apr
 2026 18:15:39 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Fri, 24 Apr 2026 18:15:39 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Fri, 24 Apr 2026 18:15:39 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <joro@8bytes.org>, <kevin.tian@intel.com>, <jgg@nvidia.com>
CC: <will@kernel.org>, <robin.murphy@arm.com>, <baolu.lu@linux.intel.com>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<xueshuai@linux.alibaba.com>
Subject: [PATCH rc v8 1/8] iommu: Fix NULL group->domain dereference in pci_dev_reset_iommu_done()
Date: Fri, 24 Apr 2026 18:15:20 -0700
Message-ID: <c5bc84ee72651ce22b69bce3cb731a721a3d057a.1777074513.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1777074513.git.nicolinc@nvidia.com>
References: <cover.1777074513.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000013:EE_|MN0PR12MB6080:EE_
X-MS-Office365-Filtering-Correlation-Id: 892d456f-04c3-4e07-c3c3-08dea2682ffb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	kIyZoUzbUSYhZQtNZwf4RQ5ruQBGwi7sWmOFRz9UHqZfZY9tGl8RIRx3DcpgSVdJG9NgsPHPn1t/KtHWYU/QI1arHSdyEjIFRntK3lPM3eyuZQpUYWDMB/KLi18BKoU0M1gSRUnG/J0EYv4j6nanijR4rUgDaFpfoyJJPfS3Fxa6os5HpGtmDYZRM7eW8LNUleT+g798ZVNpuNLjmyd//y68MR6ToA39iT24hO4rVYAH9ETl+2ow/4zSw51lCkB/nvktuSGUmuco1Str3XTGfhw9EKZanlHwSLeBrZqtH83C4SSITDByeRb1fQhwL6VSyfxcra6+v8PZP7P2WckdsQ9ke/CBVn0MwQGiZvaFTSID3oQKmlTg444ccaqfqrZKIpHm8zMhdgWOhQh8Ut9canXjdmkkoGzJ8VOGZkXDT2aLqqjw0V15xNnDn9kcFhoa/1DQxz+3rv/AmK/sZsptMXjoui+3gbuvKAt7UwJWJ2F9EBToZPPXOLRUjm2ElxZAXtM+2i9hXT++pcPqyaFLZy8JVU0gtcMi0vBDgBbJc9JnqMVEuYZH5kYeq/VpvF+I8W2+UKX6jT/YrCVwsACMftC93ccCysgk+yd7HR8u46RloLXUkx+QXEC3FY5ILuUvZKZlCwPrdzsfkvUABjQ3ZOjJlV6mY2JIAhsvzEkOKZ4hiewNu3OM/D8b7M3iO4wSEa8BamNnWqRw2S0FeJtGX/vh/hSduGqNqIsk7lF37lXyy+VpTPah53W8JGIOOwubtJ73uyjqhJH15qvpHzX6bw==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	tSbMHudK9dAqAH5YJkPyGiHc1+blr4ubfTClNrjBU6ze9CBlxmGJW+5/dQZ0OjfTTP88VhHwvH3v9ppzbCX8UPHNNnX4qZJG9LjrHkcuPLJfOg+2DSLeH/9zll+cVgw41RZu6clh/ypNXGDTbwZLrtT1SeVr8vVRtEOloAdRDwBJ2Joj7W4w4XwhLSFTfnBZ/NvW/XG2hw++81lvkVSEYUZbXl5RmxvMWCbEEWxGD6UjXTthCA1kh44wOwpCcA89c1oGQOACyH46qgP4Ed7jY137iGJDALduGbKF7OqTQBz0ydx6uaU70RQv5nx720aVKQpMFoHgMtow4a2rKZc52xmkJA4fs72SEG9KoiAQG7rxHhoeUhLpuC8LOkMYoN9oB+wJ8z0pirb0sAaa8sXwFVGleF2Lp9vZBeyP1EYAg0Cm6kTxaMUG1pgRoRNeKb37
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2026 01:15:49.7017
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 892d456f-04c3-4e07-c3c3-08dea2682ffb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000013.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6080

Local sashiko review pointed it out that group->domain could be NULL when
a default domain fails to allocate during the first probe, which can crash
at domain->ops->attach_dev dereference in __iommu_attach_device() invoked
by pci_dev_reset_iommu_done().

pci_dev_reset_iommu_prepare() is fine as an old_domain pointer can be NULL.

Skip the re-attach in pci_dev_reset_iommu_done() to fix the bug.

Fixes: c279e83953d9 ("iommu: Introduce pci_dev_reset_iommu_prepare/done()")
Cc: stable@vger.kernel.org
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommu.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 35db517809540..00b6a33515398 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -4025,8 +4025,13 @@ void pci_dev_reset_iommu_done(struct pci_dev *pdev)
 	if (WARN_ON(!group->blocking_domain))
 		return;
 
-	/* Re-attach RID domain back to group->domain */
-	if (group->domain != group->blocking_domain) {
+	/*
+	 * Re-attach RID domain back to group->domain
+	 *
+	 * Leave the device parked in the blocking_domain if group->domain isn't
+	 * initialized yet
+	 */
+	if (group->domain && group->domain != group->blocking_domain) {
 		WARN_ON(__iommu_attach_device(group->domain, &pdev->dev,
 					      group->blocking_domain));
 	}
-- 
2.43.0

