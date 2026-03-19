Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010054.outbound.protection.outlook.com [52.101.46.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0620323EABC
	for <iommu@lists.linux.dev>; Thu, 19 Mar 2026 04:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773894892; cv=fail; b=QyhSk7GISkiTc+Fo1aqqqwH+694JWQzO1+y72ukmOP/10KrnVnmieyaWVBNVkMteRsWIDm2w4j49uGtOCSp7mhSe28k/MEe06qy7Q+RLENXB0IAeqcyNjluS7Srdd4tQkWYC7yAE39aO/4xnibF1feVYNJGeZrSwvRYA2DuzsMk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773894892; c=relaxed/simple;
	bh=mmkNGiSZ/oz+u4HDd5VhyLDs7fJP93wclVps+M343oY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tHPJZ/7mKtSSwPj9wI5x3mbCuV9/3F3fLdEBdFkU3DoksvqSqJ6KBTnFpjobjAeW5RgeqVXiRXb651m5ebfQUWQsnebG/8BjfcyM/OtXF0pwtHKSaGv8H+C38eTrY3u7b0wUDOfDRMw+7BEXKYTJi9cZoW1Y27eyOpKB4tSIDpw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NvENZjpi; arc=fail smtp.client-ip=52.101.46.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NvENZjpi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x14pRYpn0d2oswqxCwMmlq9Tr3vqySe9oY6fJYQqOYHrkdSDdqb5INvQ/MxIkGHSMkWn4J0sAaB9MzFVDkZI8uh04305KJl91JFtZOGPDfv/cZ3riYIAJbx40y1YaSWoVvwxnBatuOIJkp7mZFmOUZbXSetpUdJM+mp98sT9WVX21xu3jrA/usWpaJjPBO/KIzaz7a3hm/cb26m/pisRGakIgHAJ2kvRUvtSpRFqPDseP9ua4Zzay4NWvGRgfJmAe/yBcNsjCSblguuPUunZybZ/2AwNy78nOeepRVHHMtAEzQxhptoSq5PCa5JrN1FngENK5vxmU/kORFOG5OMRGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vPj/qWSJQHZr2v2llMYQD9cFvsfJrMdan75N7+kXGJk=;
 b=Z/oJUUWo45nD444Z4qk378wR6IdSY9EFO0d2ysdg1m/zzFzDxKG+vNLKtSKWvaYgoJFg2Rn3SVcttb4lPYAFVCwQ47r0JOa5ZX7hWRTw6X2stV1n9P0HzsO1YEIBsEmaDh5KjBhpV6LkvsGUGEFiaFBJHBd6aaNM869zqHuodZWCA17d/ZzF6FaYV3bWIgTRdjRjA6cEV+t6fRj4yk0EUrZ9wCJrtst0mx2YsJqFmXhEEjy6acegZpTYxgVFT1ZWdnMjwJj0bul98lZBDuqdzf1c+nPEOBH3n+h6o4d05t77d/xUbDpoH180D3SOIcRQOADOSMx5Qvtj816p6oIYrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=8bytes.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vPj/qWSJQHZr2v2llMYQD9cFvsfJrMdan75N7+kXGJk=;
 b=NvENZjpiKQSlGF7lOW0EoumYX9ZurzrlC4FlvI3WlsqduCc7pNi/uaYRQRHXiU07ue65iQXcMkQXTQEwO3sVI3KgIkkWQ7SMUJaDWdl38wb9bbEh26N2zAzdcFojAYeugpL1mn2kUTX+L5mrFAUhBl1pLjlhQ08ZxCfteexV4yjN8KPMK5VHtGMrJdqpyg8Jw938JxTFwjyNxiSPVxk2pJcsAv1fPbREOYvuGySKIgrwp4F/zCFhjnlCIxCG0Ynq1Yrwe9C/TlnvhFte2Yc70kMYYTS1MXm7ZkFHd/Zh/ZHbew8KDb1+72hvC2eEpgDm+w7bGZ4307qXxhDC0iKN9g==
Received: from BN0PR02CA0044.namprd02.prod.outlook.com (2603:10b6:408:e5::19)
 by MW4PR12MB7120.namprd12.prod.outlook.com (2603:10b6:303:222::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.17; Thu, 19 Mar
 2026 04:34:46 +0000
Received: from BN1PEPF0000468A.namprd05.prod.outlook.com
 (2603:10b6:408:e5:cafe::5d) by BN0PR02CA0044.outlook.office365.com
 (2603:10b6:408:e5::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.19 via Frontend Transport; Thu,
 19 Mar 2026 04:34:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN1PEPF0000468A.mail.protection.outlook.com (10.167.243.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Thu, 19 Mar 2026 04:34:45 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 18 Mar
 2026 21:34:33 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 18 Mar 2026 21:34:33 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 18 Mar 2026 21:34:32 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <joro@8bytes.org>, <kevin.tian@intel.com>
CC: <will@kernel.org>, <robin.murphy@arm.com>, <baolu.lu@linux.intel.com>,
	<jgg@nvidia.com>, <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<xueshuai@linux.alibaba.com>
Subject: [PATCH rc v2] iommu: Fix nested pci_dev_reset_iommu_prepare/done()
Date: Wed, 18 Mar 2026 21:31:35 -0700
Message-ID: <20260319043135.1153534-1-nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468A:EE_|MW4PR12MB7120:EE_
X-MS-Office365-Filtering-Correlation-Id: b5afdd2e-ea20-4205-30d2-08de8570d8cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700016|18002099003|56012099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	2WQdI28iy5qmw2i8YJJnl/MvEVEYP3U1GZRSPRfOS/75tDHqJcz5Cr8PsHe/0SOod0/2id97IRCOKl1JaAOJJHji36c4Mm0dDiOYyfUlT1jw6ztDYNWYdq9ZRf3FAlMIkZd8L3skkk78/b7zjxRuYgCeo+e3DqXlQr9O5jdskyYTlL8dUiFMMPhqKdtL02RFTYmN78X6ut++r7bGU/3Nu5i8tFMYxDZzu0bNZcYawH3Key9oMZEymUjKrrw3bE5jz5GhvMWkDarWvWAaMNNWbNZdUjbcd77Zz+OgZJAoMJSfbx1zFvjF0LfNxrBB4VXXhtWOdYB2veobtulzBY06VS5vC9quveb+2vvp0N67IBI5bjsBmP0vasGSrF1op+NbLunA+ATXqwVDejhBtux7B8wdZdaabJwc66oXGccNeRGLrX7lUmaZnmb5Ae4POkG1x1HAki9lnjO3c+Our2PIgbJqB+97JbSFkj8rJDtJL0VEIP+4zXHZmvSzD8Z3QdZxz0y9UYt3HAtdN7P+z/dHKx8g2+GYd5iU7PqIrO82p6uomxTkDtglXACzCan/6P3HN7KgSP4yPYwyDvZw4u4SIzqGdBTjjeiSIfQRSb2CjTORZraFBIypPxIBQNrH+WdMP11zI4ZKWVQBX2jk052LQlm+TLsx1hg9nGZI6kvwd18VmCW+Uud9suUbXEL/4IfPVgOiByc6s8YyWJACnFrRR3UzLSVMds4MpRz2Gpu6rk4gxk6oJwtRk1IEfU5Ud8zfDJruwGW7a6g46cUi0jWuww==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700016)(18002099003)(56012099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	TQ1RobPKQYSm7LoqWWf3ik2YQGK6DSV/8U3dF3q2/l4LYuuz8icASiEcHsdfOaCqKazSEyvIuKtAdBKH23Yy/WNx1MZH2ovMFVPG4vDYnSYaVdOQuHTh6/NRk4ovZpabPyUbViC4+hdiZgzOvtDnTAwTW9E/ljF+NrMwsHcN6Aahtjw8oksrsODX/JPHJ4r7fEcrBUHzsfmSYfOIzGQOCR551xPb0IlnxvSkc4mRQtpg3SerMqxsxDRYTdomMa0VZgksaArlhZVcShgF/8X7FgKHppTVo0FPViCPmP1hCxxtB8UexseevSuAplK9Rtwup5mvw0D2vnV5kKFizoJ//u9cPa6lxNLQ7/ItaN95qWbyq7fSwu1TNcnx5KvAbSlESIrBxcu9lL2No+VyzSFRraQkhvDvotZMfG8XIY1oJpy+dx0Kyh5vsYlY02JQ8VAX
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 04:34:45.1525
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b5afdd2e-ea20-4205-30d2-08de8570d8cc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000468A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7120

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

Introduce a 'reset_cnt' in struct iommu_group. Safely increment/decrement
the reference counter in the nested calls, ensuring the IOMMU domains are
only restored when the outermost reset finally completes.

Fixes: c279e83953d9 ("iommu: Introduce pci_dev_reset_iommu_prepare/done()")
Cc: stable@vger.kernel.org
Reported-by: Shuai Xue <xueshuai@linux.alibaba.com>
Closes: https://lore.kernel.org/all/absKsk7qQOwzhpzv@Asurada-Nvidia/
Suggested-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
Changelog
 v2:
 * Fix in the helpers by allowing re-entry
 v1:
 https://lore.kernel.org/all/20260318220028.1146905-1-nicolinc@nvidia.com/

 drivers/iommu/iommu.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 35db51780954..16155097b27c 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -68,6 +68,7 @@ struct iommu_group {
 	struct iommu_domain *resetting_domain;
 	struct iommu_domain *domain;
 	struct list_head entry;
+	unsigned int reset_cnt;
 	unsigned int owner_cnt;
 	void *owner;
 };
@@ -3961,9 +3962,10 @@ int pci_dev_reset_iommu_prepare(struct pci_dev *pdev)
 
 	guard(mutex)(&group->mutex);
 
-	/* Re-entry is not allowed */
-	if (WARN_ON(group->resetting_domain))
-		return -EBUSY;
+	if (group->resetting_domain) {
+		group->reset_cnt++;
+		return 0;
+	}
 
 	ret = __iommu_group_alloc_blocking_domain(group);
 	if (ret)
@@ -3988,6 +3990,7 @@ int pci_dev_reset_iommu_prepare(struct pci_dev *pdev)
 				       pasid_array_entry_to_domain(entry));
 
 	group->resetting_domain = group->blocking_domain;
+	group->reset_cnt = 1;
 	return ret;
 }
 EXPORT_SYMBOL_GPL(pci_dev_reset_iommu_prepare);
@@ -4021,6 +4024,12 @@ void pci_dev_reset_iommu_done(struct pci_dev *pdev)
 	if (!group->resetting_domain)
 		return;
 
+	/* Unbalanced done() calls that would underflow the counter */
+	if (WARN_ON(group->reset_cnt == 0))
+		return;
+	if (--group->reset_cnt > 0)
+		return;
+
 	/* pci_dev_reset_iommu_prepare() was not successfully called */
 	if (WARN_ON(!group->blocking_domain))
 		return;
-- 
2.34.1

