Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010004.outbound.protection.outlook.com [52.101.201.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0689364EA6
	for <iommu@lists.linux.dev>; Mon, 18 May 2026 02:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779071348; cv=fail; b=ICuIVJQpdT1K/J5BC+yKF77txny4iHM52YV8h6Np6/trOUGkfG7eLAJCX2JuyUaiYv/hpjwiwqAiI+r84392EVzzTU9n55kHzhIxOgAX0qCBM4XLDQsGNyLhC/eljpzrU0BFeFg3ARDIHrZcs1CmdPFIbzFxy9P9aTcYX1az+Qo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779071348; c=relaxed/simple;
	bh=t9aN+75LoCQmNmI/zq00Gvtf+oIuHTvx/CUg5uO4F+4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kd4BycFCXQ4v/GbzuY2cjjfJMM4eR0N5Yz2Q8aYFBIu6Yo9bET/EVuxELkZFF8ik9lycUhKROVjsn+6LFRxM6t5SEYi8QMph//KUZ5YLf9zLJzxF+gfSTZ147EGjMjJS5e0XLcW1TiGThO38egV46zG2z+clc3eC7yu6Fm6pAjw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UrlykgTj; arc=fail smtp.client-ip=52.101.201.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UrlykgTj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dlmLEmH0KzddePbhhjmfQgOC8Y/dzedReMnFAikAoihtEcBxLv+Z4aR/7UgTemV/2PbxflFrDm3V/MYSfFDWSF4lDiIgxroA+j8aJazExdMzAtMrotFhgrvbpfG9WNa1wdkzfBf0H2EJen5HGKXzx/qXcYWmxsrhjekKRj5mld8+5yQ9oCO3fBwDwhtcqUSZuOivFV2jTrElDzKMUEOtriBuSlc1eRM7WqkQAZbQLJwplt4pPWGuVr83X7j7/AnzCnPsujIGv58U1LwSkCFmQ6zvTsO74XMc+NhQDUGxn+NC6cG4PIrNKH25v2TfzaQ+aAN4KbmR9jz1ZPD9d+6fIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v+FaMD7Nj2iRy7whmGSA17ZN/ZYnvDmULHUed1hCszQ=;
 b=fJNmO1iz7tsHV+7q0+zSB4AFhKQ4Rucb+0+uYYdT/0eR2f4hJgGZ6X0OQRW7/MVs3DRHTOvXkkgTimfKG62PtGCVClIPrPUZ1qsqj8ig0NZFpDp4CiwRA3GAY2WiGU2PhDNuUSqepuM5HJPq7j/xmWIvR91RoHgKSBEazjVFVKFM+9x8Whis0p/rpKiawAokQHY58CNwj1qanRw0P7xiOmh9QJZZpIWVVfXHhkLzghProg5LHvS6AmMWsuFH+mxafmxJsZooMSBhx9HU/dhqmybWL7CMB+Dd5mclIu0eIsDYDYYsPbSkr99mCsRooCgnozSqPUDpJFOLYD6bLyDsCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v+FaMD7Nj2iRy7whmGSA17ZN/ZYnvDmULHUed1hCszQ=;
 b=UrlykgTjzBYT4V/fscUkOZXcDKQukKA+jOAvRs8mShcMYU4qYb3tefzMO2CJyUeKyxFDQmwdOzsE3g6YMzj0tRORf2yxX+SnoqYes5CUFB+YgHLLDaanvRXazhg+t2pBnA1anQ7siw2yo1Jjzl8ETD+zBYwac+7yxF9tz0x5GENk2wn40lUj5K9A6av0YTq+42DZfSTNxaoDCWtre4WP2SEEcrFWVVGtA+jpBmDMW/JUtlPHcGc4Kx4dV2jUA3ZVrOxg5Ma9Bo97ga3uz8yBPMWBGDoC/ikIfNJLD+VLWiyklPuEQe+b96nEtaFzTUT6M7mRh6IbtBgkU9XppbM4Gg==
Received: from SJ0PR03CA0374.namprd03.prod.outlook.com (2603:10b6:a03:3a1::19)
 by BY5PR12MB4049.namprd12.prod.outlook.com (2603:10b6:a03:201::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Mon, 18 May
 2026 02:29:00 +0000
Received: from SJ1PEPF0000231B.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::6f) by SJ0PR03CA0374.outlook.office365.com
 (2603:10b6:a03:3a1::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.23 via Frontend Transport; Mon, 18
 May 2026 02:29:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ1PEPF0000231B.mail.protection.outlook.com (10.167.242.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Mon, 18 May 2026 02:29:00 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 17 May
 2026 19:28:58 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 17 May 2026 19:28:58 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Sun, 17 May 2026 19:28:57 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>
CC: <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>
Subject: [PATCH rc v1 2/4] iommufd: Set veventq_depth upper bound
Date: Sun, 17 May 2026 19:28:47 -0700
Message-ID: <2bbe94576fc12d852c28d38106f0de4435f4fd4e.1779070992.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1779070992.git.nicolinc@nvidia.com>
References: <cover.1779070992.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231B:EE_|BY5PR12MB4049:EE_
X-MS-Office365-Filtering-Correlation-Id: c836eab9-09a2-4696-7c43-08deb4853897
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700016|1800799024|11063799003|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	JH0aqsSa3PTv06gNuT1UH2DAHnf9dfyDrS9a3qldbRXWJjrydRrJiaDS1lmZ9vqo9HlwQabKK2xjm9efstn+2ou7tdk+kYyzHKJyA/dVhnz2rsnhJkzjtCTsWWXOKY0YIPRQU3lAcSv+WLSMI5Olol+yw258z0Li20nZHAEbPen6wyxsO5CgFcLXeq7pejdbK6Jcc89FgYy2aYLBk08PRp9LB9BFAziVeYBDEuoLN2UTm64nsetnWKLXMdz2poLyAe9/KTyfYFD+Tapaqg1iITBa0sTSa7tbRJIaxgcGQb1Q7HkLYlk5l8HFN9kk+xX3RlFvu5hnstKKP9iU90fxc2CUMZhQ4+HkJvvluBhz8dpVK6tea9gNv25HANGFuN7yE4B6Sx6k+ezcrJqaGNrEd3VTlYtwyZDBrr1HMM96z9MESa4mo1ewiM8EC9Xnf6Jz7JX9N+MNrDnPrUoqpJaR8XHfxrrWaQjeFbJ+zpbDlauvOy8WLfge623XDmfxX81/xMXBcCAhQ8vFMd0dRZlr2CkNOevsjGFGeFOkHtFFcuxubkhySjZ2Rxt++rgt+HXyeBIi7C0NQK8VYrNfFyOviTtifUxzI6DWUSqnaF13th6Ngat/iox7KFrkWdRWq/QIrIlbo1gXSnybehaHDuz1M6dI7k7LTq34zomhB64+j3szJKF117l2JKNzy7aETvGLRqRtMcJzCN0BHXWdde7tupj9mmWbhXYlCQ2MBFiVn5I=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(11063799003)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Krv+9syomwuU7I1lAlQoQe4y+tzOMWi/UogLR6xzEUARM44wW6KgLzG+qQH0UJVrz5KTk5p4+ffDcM4bRj6B6Ys6yRWIMN0CAXLKtJipnL26eTbUczBcswSLG1RiMyJ38IjSmc343eKtTnAoXCTHsksvYY1pFDV5r+8hg05IVufP6dSH1Pr2CuCb6ohcFrx6LEhYDjyv3G7MPEaVQJZDYbITP9TBjBOIelvEGAGO1V8PDEd6cLbfGHwiaBQXw2HUSEkAEdr1gcLcXvcHBEk/X+4+rp2WbZzbKNG7t+1lKlyh6vmUDbPDz0QNA58hmzlLtAVNkvzwvTe4JV2+YYZCkYX8oEmAB1g3KnD2W2f3XKl0TB+/OAfvPIs8V64DquOvZPG6yMhHXx7YbOE2CSvxzM8gpxBk/BObb48HzelojEe7yc3Qw6iS7ehcAJr5EgOm
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 02:29:00.5967
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c836eab9-09a2-4696-7c43-08deb4853897
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF0000231B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4049

iommufd_veventq_alloc() accepts any !0 veventq_depth from userspace, with
an upper bound at U32_MAX.

This leaves a vulnerability where userspace can allocate excessively large
queues to exhaust kernel memory reserves.

Cap the veventq_depth (maximum number of entries) to 1 << 19, matching the
maximum number of entries in the SMMUv3 EVTQ (the largest use case today).

Fixes: e36ba5ab808e ("iommufd: Add IOMMUFD_OBJ_VEVENTQ and IOMMUFD_CMD_VEVENTQ_ALLOC")
Cc: stable@vger.kernel.org
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/eventq.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iommufd/eventq.c b/drivers/iommu/iommufd/eventq.c
index 78689fb52d24c..1f1e415285b1a 100644
--- a/drivers/iommu/iommufd/eventq.c
+++ b/drivers/iommu/iommufd/eventq.c
@@ -473,6 +473,9 @@ int iommufd_fault_iopf_handler(struct iopf_group *group)
 static const struct file_operations iommufd_veventq_fops =
 	INIT_EVENTQ_FOPS(iommufd_veventq_fops_read, NULL);
 
+/* An arbitrary upper bound for veventq_depth that fits all existing HWs */
+#define VEVENTQ_MAX_DEPTH (1U << 19)
+
 int iommufd_veventq_alloc(struct iommufd_ucmd *ucmd)
 {
 	struct iommu_veventq_alloc *cmd = ucmd->cmd;
@@ -484,7 +487,7 @@ int iommufd_veventq_alloc(struct iommufd_ucmd *ucmd)
 	if (cmd->flags || cmd->__reserved ||
 	    cmd->type == IOMMU_VEVENTQ_TYPE_DEFAULT)
 		return -EOPNOTSUPP;
-	if (!cmd->veventq_depth)
+	if (!cmd->veventq_depth || cmd->veventq_depth > VEVENTQ_MAX_DEPTH)
 		return -EINVAL;
 
 	viommu = iommufd_get_viommu(ucmd, cmd->viommu_id);
-- 
2.43.0

