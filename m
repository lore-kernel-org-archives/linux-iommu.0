Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2056.outbound.protection.outlook.com [40.107.223.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716C91917E4
	for <iommu@lists.linux.dev>; Wed,  5 Mar 2025 21:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741209577; cv=fail; b=reX5KhiHT6R7CPAdZfbBSiofVJR/HlGJQnekg3ai1EsPWDamvkJ49NRyOh8N8Q5VrMIbRIm+OKMat+VdKhzvDlXoeTv2yvSWL8ivfnSGeJWSt2RpBX4sEUiQUekk5F9Qk5c5A9UXU4/z2Ib4p4EzdtkN9frEVwy5EAPS3XRKpEg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741209577; c=relaxed/simple;
	bh=X/e89u0GFFA3FqxA4WvfBI2j0VFcioFCcbLbvyvMnk4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=b9ISHjV7myxj+3+jeCl8eFrZIhvqNBj8oMDMRKRnqQtBRv7+ciqV9GsIHNr49PQpvv+llwYWnDSwFYVREaGa4JXTFL0n3rh8s4NXB2mKeQYY+OCjCANV/qxgVSCuW0y+Y7Bo6tE/Zl5pUQmCjHaIGfwuoQh1qs1Uqcq2IAUYUnM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pnrxn/5G; arc=fail smtp.client-ip=40.107.223.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pnrxn/5G"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h6zFzqg9qoD/A/T7NS0vmb1e9Z70M5fAgdBGxGiyFpjpBtY5fEMVnl9KugtbfrCD4rwF8/MXe8/8ZWeIXLXVm4obGZlKgqaimVE2o15Ijad3c3BKRGwZQP8f3RI7vp+lUI3xr580hReOa1XFjUgn1lEJ41w9Vn2mTpXOnTJIqvmtTJHylQHkdV9D/biR+VOp0tHJqKNcUhgqoiVGptuE1BtXcjWI6cijdpQaPEJDcmiPjEq7c2vAYsx1anB9joqALbUYCUfV6r4auxrQsZ1ODJIbfb0cGlHqvQgopRA2KNbo6rsjw8xg7QQis3drTE+Nbm0F9HVRSAmVh0aj0dZ0xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MTrX+v2ufu21pC5T9+JXX7Mh94AZHwvQ4M8AVKKgv04=;
 b=Cc/uYhuBQ0Om06E+xR9gvq7qmSLu4+2G+mUrHUq4dmRNOYK9zTSNVD3lfx4oli50B597TgY3dQDMfJIltWmA3A5PKNN74onWk9Z1w0zUUz43Za8FZn2P3FfktsBhiJBYBPhN+ybOu0c1tD+qFL8HDWYf1s9hTXnMqo7TRyhdxeUEIYQANZHTkPUmIVPgI0x4VbivjQ9h1FhkNS+mJO1gEpTO6/pTRCH7XhbSR41Xbpxi+54fsyWoQrOS91yNLdns+7g75SClYtM1wF6/j1WPGttl91QYtZ+z+L5i3dDpHI60yDPqzYoN6Zy4Um2CEjTC15Vi40LOlmqIl5o3niOzJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MTrX+v2ufu21pC5T9+JXX7Mh94AZHwvQ4M8AVKKgv04=;
 b=pnrxn/5G87Rm7CQszD0qK+c4SX9Zep/T/sThk4HHZnefr37y/WuRs3DxUcpo+d2nkFA38Uu8TlraVgsoJYb2eH3+fHusWEg2hd8oA7uYZMC+YKFbZK3IB2mCy3/R5w7T9xMNrp8KTs2V6UKeDzsMk51kAqmoeqzB3w+J4k0VGs7YNVbgYGgF5mmUhqQGWUKYflNKOGqSCxJQgyB1F/B/mBMuCWcAmpEZUbj14FwvNAxf+8EXuYqJLXDcamPdr7whC62feRRlNJDZZqnVoFJ+byw8OMCcHJsJOHnfHwYakmuO4KSOmi4RWvukPH5F6NgHfOO7a8A/qJZgIr0ClOEuDA==
Received: from SJ2PR07CA0023.namprd07.prod.outlook.com (2603:10b6:a03:505::9)
 by DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Wed, 5 Mar
 2025 21:19:32 +0000
Received: from MWH0EPF000989E9.namprd02.prod.outlook.com
 (2603:10b6:a03:505:cafe::c0) by SJ2PR07CA0023.outlook.office365.com
 (2603:10b6:a03:505::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.29 via Frontend Transport; Wed,
 5 Mar 2025 21:19:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 MWH0EPF000989E9.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.15 via Frontend Transport; Wed, 5 Mar 2025 21:19:31 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 5 Mar 2025
 13:19:19 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 5 Mar 2025 13:19:19 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Wed, 5 Mar 2025 13:19:18 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>
CC: <joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <ankita@nvidia.com>
Subject: [PATCH] iommufd: Set domain->iommufd_hwpt in all hwpt->domain allocators
Date: Wed, 5 Mar 2025 13:18:00 -0800
Message-ID: <20250305211800.229465-1-nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E9:EE_|DM6PR12MB4202:EE_
X-MS-Office365-Filtering-Correlation-Id: 16c272dd-2e5b-4503-7946-08dd5c2b6bf1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GfwB/XLeqQ7wZLQxPnpRWbiEJERaEF2I8MkyY4kQwbV9a4NyrxHsFXiQDhKc?=
 =?us-ascii?Q?1kSsXuSx56n7WZb977NQVHEtfEgYERrSwdjYuKkWrU569eg+YU1yLY8nbPJL?=
 =?us-ascii?Q?lE7lCB9mwwQlqXoRCPaesWeBRLObH3qyb/hRaJi9hoHybJLFDV8MN9MyWkKr?=
 =?us-ascii?Q?gkOafHmCLCdibK8jSPI0Mxmcz7aurEby1v4+vgToIYwRh/bTAj8KdD32F4+5?=
 =?us-ascii?Q?EkcA2KZR0UzLqN8dmm41Urs5hz0KsgwrmCRq30me1KEZmkbgYTK3pVXsVNek?=
 =?us-ascii?Q?yYVcNVT0K/lRJPpfW3TcPAqIq48sxX/nQiTVi5l8ZpVFeSXuHIqolyjCHReG?=
 =?us-ascii?Q?VRQ8jDwsUcvn1A9VlO/w5Bu/mq5UuBfDCAm2L7hR5e4qSe6y4AQJeanyf7SC?=
 =?us-ascii?Q?4iQBXKDdWC1C4RwUBJRrXgMA4HtmkU2MAzmQea0akA3Zg0OQm8mut4q9YcNu?=
 =?us-ascii?Q?GqBPp6ueVl+Wj02N3tmvGd7wa+wdfZbTCFykUpx1vkNl9UPzYW/HnrgzyFlT?=
 =?us-ascii?Q?YZh1+2OLh2I0pXYb72bPtcaR41vwKNRQ5Dpr40PGhUU4NKr99cWstsptTViy?=
 =?us-ascii?Q?YF8igrIfUpD7fsFgh3A6N1pL5Nfqg1WQJDbwW2fUolwIyT2AUF5RjtP/IKWg?=
 =?us-ascii?Q?7MbNTHQ1mq0zJ4NsHBKWynsHk6ULOxH1WegfLJKv0IcrYvJBLgJhKb5N9hi4?=
 =?us-ascii?Q?rAO1o4oJRaYpcz3QxvbvowvDj8C2EZrGVLEB6G5/1QRqMgzStYHqhSkhIh+m?=
 =?us-ascii?Q?146ntzz0u06PplJOp+0s2ymYpt8/no5yKjf7MhUotGYgveJFHhD+aqKo+qaA?=
 =?us-ascii?Q?PI1DUv8LHbxELbmfjtzcjVMrh+rqc3cNG+wamsXTjjh7lzU/Wu+H3ywUOKJq?=
 =?us-ascii?Q?iCHEDxBFCaZmopXxeqIgSk9ui640E+vpQB6wZVDfHX1sxasQuqkKoAWkTGUH?=
 =?us-ascii?Q?5rGlV5TA073x7qr+HZolAiOiSRjDMOV9KzNLzN7ZQBRjQbZNs90HgBd5/laW?=
 =?us-ascii?Q?c0jyTRNgBYhGiHwGhm91asjGLgr1rMvk/C8YSvlgqAVAzmFSFRx5dmMYr0se?=
 =?us-ascii?Q?L3XjpFU8YW9DLmJEqP2ES+CP8HIJ+IkMy587z5WfjXpsJtNvApPAJnuOxq4T?=
 =?us-ascii?Q?22xjz1Fb+oWWUrZqNz1m1FR+N5Fi+TP+qvWSwC39N+m75cSjL8qiQ8Cx4O+V?=
 =?us-ascii?Q?6KAA/TUadJJb0J1yEwrVV2L7HTKBytY9ZMY6ZmjlMnuZ4aLQzYKvuRtmLgm8?=
 =?us-ascii?Q?hVrDE996qis5WWldiffcBm7pzLi5Rz3RdO3hnp4lchCvvoennak4WTW15VFD?=
 =?us-ascii?Q?cK+Uji8oKpjUdqJrFJ+biOmJkm+89w7LxbTAXx1E3+M9o1dzXSFHYq3kDXwA?=
 =?us-ascii?Q?x+NTnOMMJohz1MGSMGuoVtf2dh/0sr9yWn4LBlmOVOIZ0c0+9Qb1R+6wDM3E?=
 =?us-ascii?Q?rDkcNLqtoioKhlXt06w7rhN5V8JDQKWNvxSl15nOpTjZDI879DNJHmfc99cY?=
 =?us-ascii?Q?ym5nlxF4HcXBlEg=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 21:19:31.9877
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 16c272dd-2e5b-4503-7946-08dd5c2b6bf1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4202

Setting domain->iommufd_hwpt in iommufd_hwpt_alloc() only covers the HWPT
allocations from user space, but not for an auto domain. This resulted in
a NULL pointer access in the auto domain pathway:
 Unable to handle kernel NULL pointer dereference at
 	virtual address 0000000000000008
 pc : iommufd_sw_msi+0x54/0x2b0
 lr : iommufd_sw_msi+0x40/0x2b0
 Call trace:
  iommufd_sw_msi+0x54/0x2b0 (P)
  iommu_dma_prepare_msi+0x64/0xa8
  its_irq_domain_alloc+0xf0/0x2c0
  irq_domain_alloc_irqs_parent+0x2c/0xa8
  msi_domain_alloc+0xa0/0x1a8

Since iommufd_sw_msi() requires to access the domain->iommufd_hwpt, it is
better to set that explicitly prior to calling iommu_domain_set_sw_msi().

Fixes: 748706d7ca06 ("iommu: Turn fault_data to iommufd private pointer")
Reported-by: Ankit Agrawal <ankita@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/hw_pagetable.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
index 268315b1d8bc..1d4cfe3677dc 100644
--- a/drivers/iommu/iommufd/hw_pagetable.c
+++ b/drivers/iommu/iommufd/hw_pagetable.c
@@ -159,6 +159,7 @@ iommufd_hwpt_paging_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
 			goto out_abort;
 		}
 	}
+	hwpt->domain->iommufd_hwpt = hwpt;
 	iommu_domain_set_sw_msi(hwpt->domain, iommufd_sw_msi);
 
 	/*
@@ -255,6 +256,7 @@ iommufd_hwpt_nested_alloc(struct iommufd_ctx *ictx,
 		goto out_abort;
 	}
 	hwpt->domain->owner = ops;
+	hwpt->domain->iommufd_hwpt = hwpt;
 	iommu_domain_set_sw_msi(hwpt->domain, iommufd_sw_msi);
 
 	if (WARN_ON_ONCE(hwpt->domain->type != IOMMU_DOMAIN_NESTED)) {
@@ -311,6 +313,7 @@ iommufd_viommu_alloc_hwpt_nested(struct iommufd_viommu *viommu, u32 flags,
 		hwpt->domain = NULL;
 		goto out_abort;
 	}
+	hwpt->domain->iommufd_hwpt = hwpt;
 	hwpt->domain->owner = viommu->iommu_dev->ops;
 	iommu_domain_set_sw_msi(hwpt->domain, iommufd_sw_msi);
 
@@ -415,7 +418,6 @@ int iommufd_hwpt_alloc(struct iommufd_ucmd *ucmd)
 		refcount_inc(&fault->obj.users);
 		iommufd_put_object(ucmd->ictx, &fault->obj);
 	}
-	hwpt->domain->iommufd_hwpt = hwpt;
 
 	cmd->out_hwpt_id = hwpt->obj.id;
 	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
-- 
2.43.0

