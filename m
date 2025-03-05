Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2081.outbound.protection.outlook.com [40.107.101.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA82E1A072C
	for <iommu@lists.linux.dev>; Wed,  5 Mar 2025 05:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741151130; cv=fail; b=eGp2DbzHGmtdCS2RRCRu4itSUaq8neo/VmpINlQti2gTFs29+fmpv6fHqGMfowyEsIfzwxabxfkthdvXM9S2KKkecqam5Hl3hvkHf5vXFuGHSDC31PU1n9kpdez1gChspRNoXDpO+Xn8Nu+QcU2utd7V2JLUrCzPDDImZ7A67C0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741151130; c=relaxed/simple;
	bh=Fm5WyRMLhpTNRDw8hskUdDOfilC/hFepbUqYv8YKF0I=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZiEW73FI6lvhAZicJ5y/B19zKw/GaoMtUHgafGoZPpPtMQLZFFkbrNS3FDpA7YjLNrz7tkZyOTJL9o42F/ig4N7fVko/3SLjkQJmsCzspQjnfM+g2EoSPfql9eXXjqKUy5J3RVmC/AaZemlRNXWm2DCWfQ3Be2yVgmwwDidrmNQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=k6RB4w4D; arc=fail smtp.client-ip=40.107.101.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="k6RB4w4D"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XnfTHNYIsYe5/EMxpDN4BaxskKfdmvuEFDf1KK8rdOk7r5eu/f3iEUfyhyIRqpYLjHuXsBLHvDYqvP1faWNJL0wiiZPK7MuAazLG7LSImOYBzpQgatEzq4oItAHTFIAGJ+IYGZaQ5shCW0EJGCOWNZC6us7ZQYHfDnaMbzpj31hRzAaLwFodmkGV+gtme5SdcGUNy5na2+A1o01wLLybSSneVVRMX/Gg0p2EwsJvKpe+uafy0+dqzFovGTkCSYDA7EkGfEgvuWbBjGgqSAA4qtcMHqEG7WurcOViNkpy2+HD1xxqmPxjrbHrHnHFs1Un5oVx4wlKuw3tKyDr1AL5Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RYa9ziV3fAfLnRoHuRqhSw7BPRwDZKHoXUgzZ5QCvk0=;
 b=N1d6ZsJtKXZZ3BJRfprzSwqYk/LU5XlR5KgDFOe6nBK5JqRiUFoWGcDIYwZcVBp1p7kx1bYzNaksMlnqEWr/T2tTgEfVcyaaxlEhKQx/M9+oD35NVio7FLUmCDO1+F1qeCVLvnCK03mydu1ZsuZ7PYfr7ouV6vrZ9TpUP/zZQP4TX8uaa4bL55HdZQtBTkcKFIEcCiurwGif7k40SUFscdxSFzkD/vHcknPq3V+l1IFTz1HuTzVTm+UssU0mB2T56JJEWLv6TooMhqpv74AKBkkWyxh09kAItOp0DAH8di/d20zw9NdgRy7IUJHV7bigletu7/PE3ZpXURsIOS2g0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RYa9ziV3fAfLnRoHuRqhSw7BPRwDZKHoXUgzZ5QCvk0=;
 b=k6RB4w4DWuKNl7RO3qyB7+c8tm+1V0dkaH+M/fWqxJ1KqS4XqacNvQbIdOlMsfDDHIsHmMlMw3QuGYL+hQxZ+aTFZHR+GN8CPZnl/sOO4b7gWMHxzpMubg9l5XaIQ4csmxElipv2sgNBTGFtzT2d+kuVNS3Gdc65w2nvbD8uEF180xe4xgssMTN4++Cnr4VbHdQl87zpG/tCD/+IQqL3tMpiw1AXiV1KzC5wYPCh7Om/M9EnAigZ0zj7XBPzOg6IwNbRgjW8hZo55dJW7zduBTuzJ2DLHK9ZcoK69N9ZETg+IDMf5HnkdNuiSaNCPDgkWEMeqdbKmDFJ21U9bKsk9A==
Received: from BN9PR03CA0171.namprd03.prod.outlook.com (2603:10b6:408:f4::26)
 by MW6PR12MB8957.namprd12.prod.outlook.com (2603:10b6:303:23a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.18; Wed, 5 Mar
 2025 05:05:22 +0000
Received: from BN2PEPF000044A6.namprd04.prod.outlook.com
 (2603:10b6:408:f4:cafe::9e) by BN9PR03CA0171.outlook.office365.com
 (2603:10b6:408:f4::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.16 via Frontend Transport; Wed,
 5 Mar 2025 05:05:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF000044A6.mail.protection.outlook.com (10.167.243.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.15 via Frontend Transport; Wed, 5 Mar 2025 05:05:21 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 4 Mar 2025
 21:05:08 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 4 Mar
 2025 21:05:07 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Tue, 4 Mar 2025 21:05:07 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>
CC: <joro@8bytes.org>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<shameerali.kolothum.thodi@huawei.com>
Subject: [PATCH v1 0/4] iommu/arm-smmu-v3: Allocate vmid per vsmmu instead of s2_parent
Date: Tue, 4 Mar 2025 21:03:59 -0800
Message-ID: <cover.1741150594.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A6:EE_|MW6PR12MB8957:EE_
X-MS-Office365-Filtering-Correlation-Id: 7699f96f-959d-49d1-9de0-08dd5ba354fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sbZEbjJ8B+Fno9R1v30qvb6qRZwOJug+k3LC0XUiT8A4HuDPtNBs7qKfWuPs?=
 =?us-ascii?Q?CAlC8HQTj/+LO1DGHylzLEombJPxI2nDn2JR0XhmkFUl3T9Dv5+iFBGeYAWn?=
 =?us-ascii?Q?jrYFUFadhLGwbkR9rJtfGB2Hdn7A05sanXOXl1qjIJO3BycI0SqlAQEQq11S?=
 =?us-ascii?Q?6hIz6Ss+Fj+dmAuZtwOGnGWd2hBl+271d49baUi3ngAs4BF5fWvIsTli5CCS?=
 =?us-ascii?Q?3/1ydHTYEsMLkha1D3t16Cg0d1u3e+elER/jD4N+qTtDgsbfDZUHDjhfWclZ?=
 =?us-ascii?Q?aC7dLkxa4JGLVtvh+Z3zW7cxVceC2LiBKCM7YSRPIbppX6/IAdQ1vwmYpZZo?=
 =?us-ascii?Q?CFTi0LEVPMvzyx6Aeo8X0tlov3nLyam6UfZI/EQRKPvxsCzugwGWRub/1b1l?=
 =?us-ascii?Q?7ynTSRDWTUgu37EQa/+2zbKOfs5rruISeeMmvnsxxOczoqhMgYvQV7eRIRoB?=
 =?us-ascii?Q?1IN1iCFJtR5YHTfzOk77swLnYSKeFMuhkThT5HuaaKjbxtKep8+5v9ljNBh0?=
 =?us-ascii?Q?/B0GnbSoPkdX3sHJe9LkuVrQ+WmD8EFdfpCZVNm7YJ4GvEYfqqrftO07mS8v?=
 =?us-ascii?Q?VIj9R0I+JA4aSosa4W1gQ9TFUu6UhY+5Zmm6wxL0Z5fcmXNvGpqjO8z2D+JL?=
 =?us-ascii?Q?t3HZV8tBGbuFEoX2gdmNL6OIPd4gJAytQNL7bTssDdMc3XmDSLoaUgQvxt2R?=
 =?us-ascii?Q?awmQANvsFL7Uuz21Bpg5BLQhaVQU2hdFSTBEQ/nKkWSVIiNiX6iD6AiVT02L?=
 =?us-ascii?Q?4XizN3HHozoYtCVnx0R3NFGoQFoycobPx4NeU78zVwtwZg89o2iMZfhecOHg?=
 =?us-ascii?Q?1mnErVsULNg818hO+zq6t5XScWS+nZpkFdPMfgyqa9dPTXDdzQNvDQFohnzh?=
 =?us-ascii?Q?jdUJszNomNBxQPMDBVq41peLIlhXHVLL7iJbUJHnRw02/j8o1ogCF6Ma+eh3?=
 =?us-ascii?Q?sw1padgxAhooaZf/n/bMplalMAxs3NapKLjAORN5hIhCk/MxAoJcTcVKbc5C?=
 =?us-ascii?Q?q58oXL5AcZxSxB3VHMq1UMCrllYOfX2OdLxKeLIVRY0ShU1Pu0onFwrtehWO?=
 =?us-ascii?Q?kwQOU9j7j39SBWzHHcxtJ8bBi4oV5ZwNsTL8qyvVK0/l14LsO1LT7G2pe4/J?=
 =?us-ascii?Q?tTsc95X5xUNFAMAcoYxYoHdZJxHnRFrU8hQjG4V3W9r93HLOEtYLjENDb7q+?=
 =?us-ascii?Q?5/4ovXdNptbG0/qNwjFpQQO/GyCWLIdQFxYxawvLvrjA99OZHqsf0po35Idm?=
 =?us-ascii?Q?GcBO3gtWzSNY6u447j9kNtyCsVRRRp9G1xMmQ4xjf7OpcD6pUl9P78PmpLk3?=
 =?us-ascii?Q?74ig8Z0z/HMAO/yUZEERQ6aa0cDNFD5X/nV63ptrpkrxbqpmVzaJ8V8Gxlc6?=
 =?us-ascii?Q?NQX0E2uIx8E9Xk+Y3f6K01TKkFhB0d0Hw0WGt8CQ3/mEexZfPZeUlndimBCi?=
 =?us-ascii?Q?3bGtpE/mZc/OM8m2q5yBI7skQgDEQSWN0p3I+l1DXjUeY78VQWYtqMPFT7wm?=
 =?us-ascii?Q?Pxlffv/evbOoN8Y=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 05:05:21.8176
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7699f96f-959d-49d1-9de0-08dd5ba354fb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8957

With a system having multiple SMMU physical instances, multiple vSMMUs can
be allocated for a VM that deivces behind different SMMUs are assigned to.
In such a use case, the IPA->PA mappings (i.e. the stage-2 I/O page table)
can be shared across the vSMMU instances.

With a shareable S2 parent domain, it is more natural to store a vmid per
vSMMU instance v.s. a shared S2 domain, since each physical SMMU instance
maintains its own vmid bitmap.

Have a pair of patches getting the functions ready for the vmid migration.
Decouple the vmid from S2 parent domains and move its allocation to vSMMU
instances. Note that a regular S2 domain (!nest_parent) has to retain the
s2_cfg and vmid for non-nesting use cases, if the SMMU HW doesn't support
stage 1. Then, an S2 invalidation has to be iterated for all the vmids in
the vSMMU list introduced in the S2 parent domain.

This is on Github:
https://github.com/nicolinc/iommufd/commits/smmuv3_vmid-v1

To test it with RMR:
https://github.com/nicolinc/iommufd/commits/smmuv3_vmid-v1-with-rmr
Pairing QEMU branch:
https://github.com/nicolinc/qemu/commits/wip/for_smmuv3_vmid-v1

Thanks
Nicolin

Nicolin Chen (4):
  iommu/arm-smmu-v3: Pass in vmid to arm_smmu_make_s2_domain_ste()
  iommu/arm-smmu-v3: Share arm_smmu_cmdq_issue_cmd_with_sync() with
    vsmmu
  iommu/arm-smmu-v3: Decouple vmid from S2 nest_parent domain
  iommu/arm-smmu-v3-iommufd: Allow a shared s2_parent to allocate vSMMU

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   | 14 ++++-
 .../arm/arm-smmu-v3/arm-smmu-v3-iommufd.c     | 44 +++++++++++---
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c  |  3 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 57 ++++++++++++++-----
 4 files changed, 93 insertions(+), 25 deletions(-)


base-commit: 7eb172143d5508b4da468ed59ee857c6e5e01da6
-- 
2.43.0

