Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.85.38
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793603250;
	b=NpT3c+mRraYlBzHr6MtUcEqdCcNydJCcLMEI3BO41PkKFCfO4immpTVw+wPdcDpduhYw
	 2ztmUoRO17PSVA3VCHGv4kPcKEc/TAw44w2xOlvG4Fti41sInpdEEdkNMtuIdPWyz4M03
	 PDqxa1MFtYz/RzhhkKlzS26Q2V65jkTT4ggc6/hjiq6HRoenL9QlQIvBQ+imMpoWxMUik
	 lmU2dT8YM6G6axQP6vxgH7KD2PRx2Pq5bvstml0FXg0fBFzi/qsbilbA5gxpPG4izBn60
	 NsMWiI1+K0AZvE7BEUvx3yc9e/nmG3TiLagrjwaZImAa0RoU7NnyvstnBQKbip8GBRA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793603250;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 Content-Type:X-NV-OnPremToCloud:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=nE4mrJzxfhD0QrASwlDPAOHQrtN+wouzFaKvMLKGMe0=;
	b=gZgBIOhOY92wiSa6F9y7VxvyyRlsfglkcDKCiPxOvk6MFivXHsvdsf10UrV7a4kS5zfK
	 guq6+MIwuvjpVcA+XiDbY+0xsWTm2PTUPHMVlFdjDffTeyUQm3GbzKUG+V/wR6sNrk+lD
	 Fgh6QYEwl1JaeuiAUGamFRevnbbWvuKdC5S5+qv/HToeuxLYRaKQWJZ5+bzmeLdAvS1uO
	 ve1ybEScwvovPo9LVmvlSdE6q6WRykiNebLA9cOb7Y6S/DQJGgS3yLvQvbKT+ZWU1Jolb
	 vo/fPhWml3onWk+gEQ6dsae8nDJXEVsln4B2QhuO2lJj4RTPywKsU/g817eS1abDyEw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=gkCxppM1;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.85.38
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010038.outbound.protection.outlook.com [52.101.85.38])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09C1606A324
	for <iommu@lists.linux.dev>; Mon,  2 Nov 2026 07:07:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B09C1606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=gkCxppM1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NAAKMsQryjPgKVNoNIV5bRTtdhI4kCUHXw9EFLgYt0ve/o/9QPIj6ZH04FuGVLrozLyK6So1JkhWbXAU0lWBUx3khoXl4u+lGEcz67PFznH+9fPDq45FAONvObRcfCj69PwltdfAftK9mf3zRlGycTmYFYGuX5vRzMnjD4sZeInQ4qi32sMmiao+iyU7w76NHr37DdZf+cPPvGGpDitQHr6G8eRKGrUa6tIf6LaBfALvQEFY4FYkifu7alLiDCwoFT7MmIOSqWZ2o8RmU4QbPau3FDGUHGpBCoCR4eb9z5Tt6ZvP2mwaG9zLX6NZaCpaJ8SFjyMeMVXK0uzQDsBvPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nE4mrJzxfhD0QrASwlDPAOHQrtN+wouzFaKvMLKGMe0=;
 b=n4Kvm38N0vGiMMAnpP2giSa/nN4ttwQFORiUaW50siuSZ+l7GvS5/2niP0tfMTg5ELrA97Yy4tXhqHs0Ho410DIL6ZOlHjc8fq52iI7+R25o7/DJ/Mmd+X7Ii8dE8n/yIQHNMcDtOQtJFayZsvMp7FGB8w4HGEdrNtEj8HkZpp+0rDfdVUOlPW7SlUF8VSg5zLpeeQdDFMeqbgryjo94L0GrWvLx0shT32QLq9hJu5SRPRtO5iYO+gc4bc1q5STgAv4JfDWVgHrFWNXFFkuRWIT1pAdrpvYCb9JMOAuyzyu8m9MVh08G4wMHSLLJWmz7Qh3JOQNYkrMWtngcKuMcgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=8bytes.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nE4mrJzxfhD0QrASwlDPAOHQrtN+wouzFaKvMLKGMe0=;
 b=gkCxppM1NG9uZm9wq0O+ItdCqs8yOxm2VnCzXaPrpGfzc9p2Dtx2vHNWkKSZukL+wEv2sN1ywNRJY1SSLuCKsx+TKsmtilb949hr4rGbVpzQtj/sifCbdWFjGOfM8rfA7Ryo7BNT5eoW3oAAlIIT5wDIWRvBWZMfhaLgFoQBV4/+dpVuujCD0K9PsfnVgrsJv8oJzh2RGwFB2jdRVlUU5kkwoKLEc4FWlfuUG3fsENnLHkOr1yRQHpOWgDrSec93kYr+Fm25cnB5kC8GkNWHFM5HyaeQCVpmM3nAKrm+Gekl5KzNN2u7GZT/7daLBDje7GRq2pQDDjuhYCR6Lr2+Mg==
Received: from DS1P223CA0021.NAMP223.PROD.OUTLOOK.COM (2603:10b6:8:44e::10) by
 MW4PR12MB7119.namprd12.prod.outlook.com (2603:10b6:303:220::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 07:05:24 +0000
Received: from DS1PEPF00053450.namprd04.prod.outlook.com
 (2603:10b6:8:44e:cafe::69) by DS1P223CA0021.outlook.office365.com
 (2603:10b6:8:44e::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.12 via Frontend Transport; Mon, 2
 Nov 2026 07:05:24 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.118.232) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DS1PEPF00053450.mail.protection.outlook.com (10.167.23.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Mon, 2 Nov 2026 07:05:23 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Sun, 1 Nov
 2026 23:05:13 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Sun, 1 Nov 2026 23:05:12 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.56 via Frontend
 Transport; Sun, 1 Nov 2026 23:05:12 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <joro@8bytes.org>, Lu Baolu <baolu.lu@linux.intel.com>, Kevin Tian
	<kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>
CC: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jpb@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/5] iommu: Unpublish the attach handle before the group detach callback
Date: Sun, 1 Nov 2026 23:04:35 -0800
Message-ID: <80c57662f4e395a7ce8be9aaac4c92591703971c.1793602084.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1793602084.git.nicolinc@nvidia.com>
References: <cover.1793602084.git.nicolinc@nvidia.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00053450:EE_|MW4PR12MB7119:EE_
X-MS-Office365-Filtering-Correlation-Id: 66c71729-c49c-4717-ffad-08df38afaa82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|1800799024|82310400026|36860700016|261021121427099003|11063799006|56012099006|261009223027099003|261028144727099003|261021123027099003|261021135927099003|261026121527099003|261026140227099003|261022105027099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	EvbjphixzOE55WPAOHzirfg20Ulqdql5znLZ/H3bzjmiA3eAZ2YlEFGsom0rayzV4zYlvfQ2r3jS0XfVLShYpSMN1lo5uQvOCmnToWyoRtpE8kSOPcOh+k1DaR6LOnbhaIEy8IWlE2POyyr802mtv9eCnfgNwIoez8JD00l8Ov99gYTAnVTdiQGNWDi4BM9MobDDY8NO0vL9GB7wCKyQrLLdGsw1CxLNAxRw9w8YY+Zw+sO1ThmvklGP++plLe47OaH8BfdRzxmEQxIWLBa//qHXR1hShqHp1ZUftAKgEVMT8mnS5nlbxWzzU/9IDtigMVY36Zof+xQ0PpZfS9A5a0GnB+xfjzMd1v6ilsJacP+TS8GDvHnej8FYBpZpUSbXN5qBiFPe+CSauRMsIu0TgTx8dCiAa7Fn8AQBwUE6kKNdKOdJzMNpvD9smfMMdH/pHCS88lE+i+ALnksELhRbDkmCI8gcy3D7zSnHxiKcc1REPLjzMQlykDagL5AUdqGVsxGqMEMnMH61HJ29EPbXQ/LDy8/R7ryVJPn3xCgke6HgITWmNAxneZg0eCh9qRKt0KnmqRVcd+LIaWqqZ2nCOt5mia0rrKLJwNb0aXwuIeZJFBX67U0sdP5YRLFnDeCU/f5Ewnd3c77M27T2BlD3eklMw34HT4rbCL26mzwRBEKjx/4HQNkAgXXriNpgttZ1+CHPQXFDA+jGiLFvNpSrmg==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(82310400026)(36860700016)(261021121427099003)(11063799006)(56012099006)(261009223027099003)(261028144727099003)(261021123027099003)(261021135927099003)(261026121527099003)(261026140227099003)(261022105027099003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	anzglLBWXL26iVI41mCXUxfouDzZgXVpYoMEH3iMru2eGStOYMX2uazEhTSPEMvDGk/XVRgCGxOVE+sWocnKFowhQRT4v8TF/Ih6NQVLVkHP29BijqZ8H3FJJ3hJ8vMt1F4v0nHHWoHYh2GIcVxQrQu1YLSGD0WbT5h1KKEganhotu8kyCCVp5mVCq6fTi3b6khBVaTfzHLvJb4avFBLCC/BBUSIm1O/sxMWYue0yQOv2Wo/iypl6ykRJkX0eFjGQ6szHV95v9PMbvJvkS/dnn+3z66dcOVj+9kBH9o87qmNhxq/oK9GSaj3oIZjjTwtMcNkFBlgztvkOSpZxfQxKeOF03KKDymn1FgBEoct5Ipcpg63SRKf89SxupQGuzwVV25VuU2ORY6RKCQ7mLRYRm8LXzXYHeqcmILG2siQuF/hmaiXN4y63BJu4RkZmm33
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 07:05:23.9527
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66c71729-c49c-4717-ffad-08df38afaa82
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00053450.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7119

The group->pasid_array entry is erased only after the detach callback has
returned, so the outgoing attach handle stays published for the whole of
that call. iommu_attach_handle_get() reads it under the xa_lock alone, not
under the group mutex, so a fault raised in the meantime still finds that
handle and the domain being detached, both of which the caller frees the
moment that detach returns.

Commit 5e9f822c9c68 ("iommu: Swap the order of setting group->pasid_array
and calling attach op of iommu drivers") has fixed the attach path, while
the detach path never got the symmetric change.

Erase the entry ahead of the callback instead. A missing entry reads back
as NULL from xa_load(), so that iommu_attach_handle_get() returns -ENOENT
and the fault gets rejected rather than delivered against a domain that is
on its way out.

Fixes: 8519e689834a ("iommu: Extend domain attach group with handle support")
Cc: stable@vger.kernel.org
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Yi Liu <yi.l.liu@intel.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommu.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index b486b8bbd1fcd..0f9d49a5c3fa2 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -3951,8 +3951,12 @@ void iommu_detach_group_handle(struct iommu_domain *domain,
 			       struct iommu_group *group)
 {
 	mutex_lock(&group->mutex);
-	__iommu_group_set_core_domain(group);
+	/*
+	 * Unpublish the handle first, so it would not resolve to the detaching
+	 * domain once the driver is detaching it.
+	 */
 	xa_erase(&group->pasid_array, IOMMU_NO_PASID);
+	__iommu_group_set_core_domain(group);
 	mutex_unlock(&group->mutex);
 }
 EXPORT_SYMBOL_NS_GPL(iommu_detach_group_handle, "IOMMUFD_INTERNAL");
-- 
2.43.0

