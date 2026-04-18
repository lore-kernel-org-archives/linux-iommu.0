Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012023.outbound.protection.outlook.com [52.101.48.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5280271A71
	for <iommu@lists.linux.dev>; Sat, 18 Apr 2026 23:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776555731; cv=fail; b=GszPzDR7uFt0AdZ7LVEpIVIne2MlZ+RnOHfFzZzS0FbTNHimDbArYNlSMX0pLoSs34Wja4QFeOiVA4TCSKqFvBWBWiFSAv43KJswleQZNIjRA6giBvhuRF0NNOiMSGc+ZzDyxSDNWwGTJGxMEZp7TcaNR/vi79R1PLKgnrPqwgQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776555731; c=relaxed/simple;
	bh=P0LaOp/tp8CrtLRWKNyexG5H3sdZ8Y/IMpYdzeWIH7k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e5MiTUYZ4JPn/wC/kcZ4PiTkxCrYtzh4XDPlSUDCJ81lsMnLjEs8vUYsIJyGXnc99Dcl93/kj0qQtEu3+Sn3VpMV5mwTrV0AdF1KZJrkney/Pc+1sdUSRWUoN6yGtNiYfle52osIJIseaXMIt6S/FJca3/YXCYYTa3dIrjMS5wo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LJ6GtvQj; arc=fail smtp.client-ip=52.101.48.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LJ6GtvQj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tXZ5GR+CHNGc4B4Ag+Getk+VvzyHGXRwX4eWw1OAVcvz6ljhpcZrxAKGu+d8mLToSeurmLmSXo7p1DjcBXjEZQJj3O/24ulnOpjGButxYwk+9HgKSaZFIt5HCQQz7uT7Bk9sUErMCPWMCHRYswmFoOBOBq4UmHZ2AWsqR24dQsf26qPiBZH2pEqqney9fqJDqXR+vtwEzS0qCzYMmJxA9yXrUkSAaoiLlnYS/duQwnpgVhd3eJq6zHWhAndv0sQYqZ7dPkkhZCqSBt725qCaJ5yQ8aRNnbaFvZ0C3A18g9pYKTmzyc5ow2ON0UOzNpMjn4Ksxk4i+7C4bU+2MbRR8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+W1iG2lxZl6ENO7Tb7ExK1tMkGtliyPSGUa9jNceLvc=;
 b=gZCrIESxzA5NpdlP2OEU9g0AnxUl3vHX3GoIoyKlam3eTq7n3+bcQcadd0AkU/0BEAuYXoRontS18Zw03wIFkYOn9HsYW3sDZ6HSLa0x0MFCckFOyvMDtSSwpFT+Vtxotd7lKSMMtFm30RVPmUDDTwk+KNcViZtxEZlT7kcGOh9H30lslIAjrbwI9VZmUj54t8kjakjEizj9smRp95YtAlLTsb9TBMVCOzKpBFWY85LZgkBdtscnf5htbIJTfum2cs0cI1os4L/YZJ/pOekzY6mRuvoDLkwAyX96Gi6gII4N2LUaAUwwxEkcZLg+t58gwo5JzrCnr2SW6XJ+Pz+ivw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=8bytes.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+W1iG2lxZl6ENO7Tb7ExK1tMkGtliyPSGUa9jNceLvc=;
 b=LJ6GtvQjS5cWsouvD7WjSoj2JqvCV7p3mpF8j2bAPkaT8NAoTnZ5n0EP8r0lCGXT9fuTBKbbGZHEOhlaGgX5ZVl0a1ex62BgQnf6Y+b9wnH3EKaeQwYCxVSmwftf00SZlb7dql+wShJZnrfww8KroLTYVBP4Osmepz1m2kCTdJXoU8MRUxZN889Q3wvUpG0m1lBLqtBPJrrx6w2ubvH0RsgDYSlGPdNqIMQY2oZd/Xd9v3BJ9BmwdOcB94UXOZhiD/F6y2pPPjYk9bx0JPvzG39hMoyEPjlxdeD56I8mJvla9gnNECGIl+II/58OfOgG3wH1/e1Y7A4fdCS4ud+BQA==
Received: from BYAPR03CA0003.namprd03.prod.outlook.com (2603:10b6:a02:a8::16)
 by LV5PR12MB9754.namprd12.prod.outlook.com (2603:10b6:408:305::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.12; Sat, 18 Apr
 2026 23:42:05 +0000
Received: from MWH0EPF000A6734.namprd04.prod.outlook.com
 (2603:10b6:a02:a8:cafe::60) by BYAPR03CA0003.outlook.office365.com
 (2603:10b6:a02:a8::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.55 via Frontend Transport; Sat,
 18 Apr 2026 23:42:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 MWH0EPF000A6734.mail.protection.outlook.com (10.167.249.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9791.48 via Frontend Transport; Sat, 18 Apr 2026 23:42:05 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sat, 18 Apr
 2026 16:41:51 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sat, 18 Apr 2026 16:41:51 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Sat, 18 Apr 2026 16:41:50 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <joro@8bytes.org>, <kevin.tian@intel.com>, <jgg@nvidia.com>
CC: <will@kernel.org>, <robin.murphy@arm.com>, <baolu.lu@linux.intel.com>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<xueshuai@linux.alibaba.com>
Subject: [PATCH rc v7 6/6] iommu: Fix UAF in pci_dev_reset_iommu_done() due to concurrent detach
Date: Sat, 18 Apr 2026 16:41:37 -0700
Message-ID: <96a8ab981d365bdedc5dc705df10414ccf578c9d.1776551790.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6734:EE_|LV5PR12MB9754:EE_
X-MS-Office365-Filtering-Correlation-Id: 710a05e3-0d8f-40a7-7412-08de9da418ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700016|1800799024|13003099007|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	O0CTWstkOmvdlgd8gLD80oT/MaMWuThy1JnnlUYdCXYpAdxAG3w8Hj4Q68Rejfbd92+b13c4GWLP9I2L8pV/AYmMBfptzPF5uhDm3NcILK1aARrLEu6qr3nRCwQnNq4c1Nm30ErYs31BPy5BBN5BEu7b0Wm3zVnRegm3eGJmtoQCiIdIpgfidDQgS0UP6Tw6jki8BvvnRukj3UKw8NGbXT/NY1ZArLSI+v7zMTi+7+FZRUKo44Ljhz4ZCXYnRuXjnttfw2lZYJZCIjVb2Ze+wPeb3HYPAz6YtxJL8CtXIOhy45OlsEMvIWJtqS2WltNtkxFi2w4owYqxYifQdQyl4BbW2v7FQVZ8Wk2TcHEyr2bstJ529RlVBLeqJu9prlqkEi2sHUffKWPv2zYKpil79HnuxHdP1ULWr9iugtNujU8UUo67X/tHCgQBdUn/V2PzGTFOOG7+YmcG3qwhs7FeFeH48xGjxjvbDWJ0Q+M+ZY86UoLX37GLC77FsQW1O4GYxAN+eNgqgP0zUDBEubQcz6gWf2J6a6ucGlJmXv2+ri7GiFV1tARNM1LKY1ysHJGvxOBaX7JkEEfhlAY3mbQwO3TPtT4e9aHPLfNB4lqVbwl2e9B3wGD1AgBl3/KYH7Mozib5I5Dmva3gp3wYP08JQW1SR2GHknLZBePOv/0pO29R8IWhdqxENcfEKFhG7jlcEvJ8XLtq+UlrXieCmiMWyJWMnegQjI/OzH5hwTLQRl/xecS6eHazwdE4fdnFTWeuT5NOk4xljxU3cuioymtV3g==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(13003099007)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	yVtBaWoZW+cv529/Bex9jO0aZGfbz6mcPROQxJtMN5eORUX/jxHepLaK6qql8hPxgejlQYF0t93T/b1Gm6h1W9oYSs1cStHhigkXRnvU8Xs5XNSp51C1qsqy/lLB2cLRVzJ+KFfubp9cxUHKL0nU0Ch1j+K8mkR9/3ee+Vfq5nNL+uoKlL6Cnb7rXGnbKBTX1YOLE0Xvr39L9KkS6GX6PhFPlmSc4Rgx1PkKcwGcMTSkakGeWI/7gII3K3iiVsTObT/t0TG8voVh1er+15vtm+THy7dMnExVT/pnY2Kjl4hXj07GYoIzbbhlmE51mn5VD/DgrCrlBQXs8B8U46HArS4OsNifYARPRtdQWLwZKKQwtpYrVtHjv74dgWrL2M3mQlV3uIz8IjiOOHyZPMRHiRxnK5rmAG9nUnNdmTJdS+ZQhh5Rv3tCksF9yyGFuet5
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2026 23:42:05.0553
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 710a05e3-0d8f-40a7-7412-08de9da418ec
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6734.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR12MB9754

In __iommu_group_set_domain_internal(), concurrent domain attachments are
rejected when any device in the group is recovering. This is necessary to
fence concurrent attachments to a multi-device group where devices might
share the same RID due to PCI DMA alias quirks.

However, IOMMU_SET_DOMAIN_MUST_SUCCEED callers (detach/teardown paths such
as __iommu_group_set_core_domain and __iommu_release_dma_ownership) should
not be rejected, as the domain would be free-ed anyway in this nofail path
while group->domain is still pointing to it. So pci_dev_reset_iommu_done()
could trigger a UAF when re-attaching group->domain.

Honor the IOMMU_SET_DOMAIN_MUST_SUCCEED flag, allowing the callers through
the group->recovery_cnt fence, so as to update the group->domain pointer.
Instead add gdev->blocked checks in the device iteration loop to avoid any
concurrent per-device detachment.

Fixes: c279e83953d9 ("iommu: Introduce pci_dev_reset_iommu_prepare/done()")
Cc: stable@vger.kernel.org
Reported-by: Kevin Tian <kevin.tian@intel.com>
Closes: https://lore.kernel.org/all/BN9PR11MB5276D60096EBF15C5753C4BB8C202@BN9PR11MB5276.namprd11.prod.outlook.com/
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommu.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 30ba18e613faa..fa7b04a77e469 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2470,8 +2470,11 @@ static int __iommu_group_set_domain_internal(struct iommu_group *group,
 	/*
 	 * This is a concurrent attach during device recovery. Reject it until
 	 * pci_dev_reset_iommu_done() attaches the device to group->domain.
+	 *
+	 * Note: still allow MUST_SUCCEED callers (detach/teardown) through to
+	 * avoid UAF on domain release paths.
 	 */
-	if (group->recovery_cnt)
+	if (group->recovery_cnt && !(flags & IOMMU_SET_DOMAIN_MUST_SUCCEED))
 		return -EBUSY;
 
 	/*
@@ -2482,6 +2485,13 @@ static int __iommu_group_set_domain_internal(struct iommu_group *group,
 	 */
 	result = 0;
 	for_each_group_device(group, gdev) {
+		/*
+		 * Device under recovery is attached to group->blocking_domain.
+		 * Don't change that. pci_dev_reset_iommu_done() will re-attach
+		 * its domain to the updated group->domain, after the recovery.
+		 */
+		if (gdev->blocked)
+			continue;
 		ret = __iommu_device_set_domain(group, gdev->dev, new_domain,
 						group->domain, flags);
 		if (ret) {
@@ -2511,6 +2521,8 @@ static int __iommu_group_set_domain_internal(struct iommu_group *group,
 		/* No need to revert the last gdev that failed to set domain */
 		if (gdev == last_gdev)
 			break;
+		if (gdev->blocked)
+			continue;
 		/*
 		 * A NULL domain can happen only for first probe, in which case
 		 * we leave group->domain as NULL and let release clean
-- 
2.43.0

