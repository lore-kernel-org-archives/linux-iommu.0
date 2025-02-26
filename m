Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2042.outbound.protection.outlook.com [40.107.236.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95E52185B8
	for <iommu@lists.linux.dev>; Wed, 26 Feb 2025 20:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740601009; cv=fail; b=vEr1QBwuithuBavKv5Fmhvxhfd4Zu2h3YhL0df3ZhJitASJCyCIKckfgZdUC1hSH1ViBO0JvzUwSaLvaO58hLFXjbs0TO9CB2JwcVuOnY06lhpCAQcXAuDGP7M/7g/ENmGKDjVEt5vC5Je6R0k5laNjmbRufDWE8HO85v9UrMfw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740601009; c=relaxed/simple;
	bh=E+XXPk50P1TFk39kELLZm3yFMWWeBEun9cz73gjdLxE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TgHDK+xr5GdXw1jwHXYL6NmXIjjr2KwgpdjcFH00zn2k+R40rdZB3rEK6blLsuu4HZdpNcPKDoSekxS8Ee0R9Q7/g5J6IAWbxYISoV7cov37+dDJzaH91Vrh60ueVFUQcft4UtmikPS6SAevqN22yRFahCmZEXsXXOwd/j4l034=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IAGox5u4; arc=fail smtp.client-ip=40.107.236.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IAGox5u4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hjfZNTVVxrxrXBE/n/UwmfVaINh/ynkHrcpYa7vhjvmaMt7BDp8emLUuA1+GsDiP6LCT1kNPaCY4Cvfb6B/wUBU35fDMk5k6EmuMLHA1kmAir47YxHJhT/wXWM0qsLFyQ374Zh8IrfbphNJpjZVpYKSL+0T8b8BsDatyoOAXurZ6LQNJX4elAw/TBiRssabbAuvm7jhR+gEdBcwLYKZmG9P9CQd1Lren6lsKktQ94/xcAjYS9x8DmLLebYNGfHn4SQSQQP4nQ9RvecnWaB6+AnejqGo2aW1LerYae/HtwmYcwNS3rV3wjw+jKrI+838lyi5CGl9aAz9OQYtIx4tWSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TRWF6PXlJdCKVkhtHcCg8x0EnmDI2wPGtsXoHzb7VaA=;
 b=RH8SrUb54GjJDrdnB90UMn2uh+Sw3bgXFsvqo+xtNNP8Jl069DGF9oii6mapHW/BHGV+1J+Xcg6Kgzt1nizjQbVT1DQGMFHbfPbtWu4wus9dRYOFCq2ESXSOmi7g6V/IwrqVQ/zLx5zLPj9nrl0ig3ap/rbyZDCYwmuAlEdkzFHHp9yrVO53rzPMBTzaCnPM99j5M+6iI1yChwoAzIQ88xLr2SfP/U38eUHymkd8T7EBP//4XNNltp/hUD9EuoRzZWsT5JBIjGGPICG53e+PXsRRqdRmOvTy+KZNJ2/YMnTiIxcPt9PqHAie/DDRVajtbQd6vQtDmZyLz1noXreMJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TRWF6PXlJdCKVkhtHcCg8x0EnmDI2wPGtsXoHzb7VaA=;
 b=IAGox5u4Q4JZKwzduKjum7kHz2VvWZXA1vh89hEtSovuKZ53/gXG2pso/J+EEHbruDfMs+FY1GHGpKHnRYqku10pQSq2TGtPaVd651lmu2z/EO84jJ7OOssdXYOq+kp/8eeTADIoEN/FYhIHqV6Xq1v1oeHWZjCjB8VN86Jx/X5uOcrFbBH6mnwxBGfYe2tSJ+w7CjLZ2c1V7eXzstdsWIWBz7lpVzV4rsMHnj2POWnhwFUEbg7jQVPRNZa4RZQHanwB9KIpBQndN3JrpfBwFI8H+DZ2fXZStK0jlMRdTCN8UEPZ55DKnY6bvUfVude2j34Qf7zONVsMB3qWLBx2RQ==
Received: from PH7P220CA0103.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32d::29)
 by MN2PR12MB4336.namprd12.prod.outlook.com (2603:10b6:208:1df::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.19; Wed, 26 Feb
 2025 20:16:43 +0000
Received: from SJ1PEPF000023D4.namprd21.prod.outlook.com
 (2603:10b6:510:32d:cafe::cf) by PH7P220CA0103.outlook.office365.com
 (2603:10b6:510:32d::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.18 via Frontend Transport; Wed,
 26 Feb 2025 20:16:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ1PEPF000023D4.mail.protection.outlook.com (10.167.244.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.0 via Frontend Transport; Wed, 26 Feb 2025 20:16:42 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 26 Feb
 2025 12:16:29 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 26 Feb 2025 12:16:29 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Wed, 26 Feb 2025 12:16:28 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <robin.murphy@arm.com>, <joro@8bytes.org>, <will@kernel.org>,
	<alex.williamson@redhat.com>
CC: <jgg@nvidia.com>, <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<kvm@vger.kernel.org>
Subject: [PATCH v1 3/4] iommu: Request iova_cookie owner to put cookie explicitly
Date: Wed, 26 Feb 2025 12:16:06 -0800
Message-ID: <510ccddc9f0d0fe5a54954cc879e76670668db19.1740600272.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1740600272.git.nicolinc@nvidia.com>
References: <cover.1740600272.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D4:EE_|MN2PR12MB4336:EE_
X-MS-Office365-Filtering-Correlation-Id: 47392698-bee9-4997-d54a-08dd56a27c65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?p+zY0AbeoYXIL39t9Z2XTY3rOJCfvG8aru+P3m7r3RepKYbPc8+xguvkqG6Q?=
 =?us-ascii?Q?/vgGDb+/uAH4fpLlkyDxAl+TEa/SLtnNinhrqhmvR8IQkEdt3hhFbDF+diSA?=
 =?us-ascii?Q?BqQ463/hgH4jlfXpfwLLzxaXV88g+gtjx0EsBmmAImX6OtKwWE23d7sAntlh?=
 =?us-ascii?Q?biOQgTsdAq4cQ6MsfF+EEBuCUFktQjnG2/So6ARna3e5YUDbL/fmfZHYGHmF?=
 =?us-ascii?Q?MHgRLJ1Ms811Q3NXU/2zkbSGv11yvdDSSe6l4bsjCGqmixGH1b6+f7gqpsqk?=
 =?us-ascii?Q?VpkAAIM+/Cn31VWkaVfV2Zkc3a9d0muFw50IbCdmIaDmwxC2FC5amoPnEeaJ?=
 =?us-ascii?Q?YAZXgKUhP4dM6cWgIBF3vclzGBXWUsWskkDuDOw/tlMIfhJDfsvuALbNhfOE?=
 =?us-ascii?Q?sERMqWAurwqMl4zeWl/HxUOZLn3r3COCnmZ0Pf7lFVorScTD750mKeGxtdM0?=
 =?us-ascii?Q?jKx9EVSolmAX0ObDz/NW+JeZRhE5wJkZypezYPidRFX/0BxDGIGPfKtqtfGd?=
 =?us-ascii?Q?09q9XzufYwFqtR48BFGAlInWCXXSdsi02b/vpEJsFDvBYzCHO4t6eG4y7bv0?=
 =?us-ascii?Q?TtQR9J6HOe3rP94qsQgKt6uMgpy3eR3ViEPxg6DBixWDrf/ZJpjHGxvObFnm?=
 =?us-ascii?Q?arLX/NsGHlu41m0yisIiAZZpRLjSgk1vmvNezflKXNzrdB272lrkeIKxCz7O?=
 =?us-ascii?Q?IHsXyndDy8Wj6Lv41/H0fEBnqEtt4er+iP6+rPqdP9HO5cPe5VUWBXeDIUk1?=
 =?us-ascii?Q?dqQ59ihxOhAk/gQmzm/mk+kQnsguzUecI2pOYnCoVKARQ27bX/QyOwMwwtiM?=
 =?us-ascii?Q?Kvqp+XH/Fpc5fyGQHkSEwy70q6f2d8Mb3PAtopQjHoXb0JI1sfSIE7fMQo7n?=
 =?us-ascii?Q?ILAH/vG53VSfk5/AtXTtLE7RaV7y+CjVNF6rYRa/nAwIWUzPc+rVZNhHqWfd?=
 =?us-ascii?Q?nayqaVpGFv3/fA7Q39/s6F/d+6vV7KVjoOR+OkoNU2op6DdzDnJ0jxu3hcya?=
 =?us-ascii?Q?RTS019nZ6mPRwt7/YOCf0Md3jry8S1OSdeYU1kBcTSNFf6djD4ITtHHkhK4V?=
 =?us-ascii?Q?oxx4C9tT48eAH9M6ElH1BUk672I+eByJ2N57ZbKjU/KGFnyjrVbAf2dKJto9?=
 =?us-ascii?Q?8dQI2n3fiqgK7/Q7IeLVFbDNzKAQzIpqL/1Kj3o8ItCiKkgoOUfObwBm8vId?=
 =?us-ascii?Q?x1DyJ2hPqt4iy0LGPkzAYRgnHtgjUgtxB8pGxq3FtK1roxflmQFsBQYS968d?=
 =?us-ascii?Q?E8hJdnNRtnxK/dgSPRj7ulwne6OIaUHmVkLCE+2J3J4XcayDlTrgrLWDru+p?=
 =?us-ascii?Q?SP91s0qha1Olp0UpbHKrss4kTw7VC1OfUXmwCkGYZDhyOAiT9ZewhVMXYCqg?=
 =?us-ascii?Q?yEYuGJVXRJ4VKUv3J616foEIugxFPxyCSimvGiMrhyfXCoG0Z8o9Ld+ZzjC7?=
 =?us-ascii?Q?Wb+aJTWXuI9CEmVvlShttffF7lJMw9gKedfgyCx+pksTnBxGVVXOqXr/i18Q?=
 =?us-ascii?Q?1wXqyby21LQQ8PE=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 20:16:42.8061
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 47392698-bee9-4997-d54a-08dd56a27c65
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D4.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4336

Not all domain owners need the iova_cookie. To isolate the iova_cookie to
the domain that actually owns it, request the owner to put the DMA or MSI
cookie explicitly, instead of calling the put() in the common path of the
iommu_domain_free().

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommu.c           | 2 +-
 drivers/vfio/vfio_iommu_type1.c | 4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 28cde7007cd7..f07544b290e5 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -458,6 +458,7 @@ static int iommu_init_device(struct device *dev, const struct iommu_ops *ops)
 
 static void iommu_default_domain_free(struct iommu_domain *domain)
 {
+	iommu_put_dma_cookie(domain);
 	iommu_domain_free(domain);
 }
 
@@ -2028,7 +2029,6 @@ void iommu_domain_free(struct iommu_domain *domain)
 {
 	if (domain->type == IOMMU_DOMAIN_SVA)
 		mmdrop(domain->mm);
-	iommu_put_dma_cookie(domain);
 	if (domain->ops->free)
 		domain->ops->free(domain);
 }
diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index 50ebc9593c9d..b5bb946c9c1b 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -2271,6 +2271,7 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
 			if (!iommu_attach_group(d->domain,
 						group->iommu_group)) {
 				list_add(&group->next, &d->group_list);
+				iommu_put_msi_cookie(domain->domain);
 				iommu_domain_free(domain->domain);
 				kfree(domain);
 				goto done;
@@ -2316,6 +2317,7 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
 out_detach:
 	iommu_detach_group(domain->domain, group->iommu_group);
 out_domain:
+	iommu_put_msi_cookie(domain->domain);
 	iommu_domain_free(domain->domain);
 	vfio_iommu_iova_free(&iova_copy);
 	vfio_iommu_resv_free(&group_resv_regions);
@@ -2496,6 +2498,7 @@ static void vfio_iommu_type1_detach_group(void *iommu_data,
 					vfio_iommu_unmap_unpin_reaccount(iommu);
 				}
 			}
+			iommu_put_msi_cookie(domain->domain);
 			iommu_domain_free(domain->domain);
 			list_del(&domain->next);
 			kfree(domain);
@@ -2567,6 +2570,7 @@ static void vfio_release_domain(struct vfio_domain *domain)
 		kfree(group);
 	}
 
+	iommu_put_msi_cookie(domain->domain);
 	iommu_domain_free(domain->domain);
 }
 
-- 
2.43.0

