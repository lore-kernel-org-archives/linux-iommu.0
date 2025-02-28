Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2046.outbound.protection.outlook.com [40.107.244.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD34C2F2
	for <iommu@lists.linux.dev>; Fri, 28 Feb 2025 01:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740706305; cv=fail; b=ZfIfh7a2lUt+Il3bhqVg3HuSmQlG7Rcp0kCBeIuGqe3x3v9jF0263TTfAit3U7JGil4UTsebHUqJ1y5pSFJWhNReZa8u6rPLCONXoSMF2ZS6i8irEMWDE6T18Ql2j7sm7ekcZMO/OMfCB3jnMYTLboOIGdqgZzOfvVbKy8ZLTHI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740706305; c=relaxed/simple;
	bh=SqlQwimpXLNW4dRUCH3dWKCvBI8S8fYxDt6zoPFkJ+s=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CNiwJs2harLagQeonsRyeG/oBYhAnNbSKorBHmsWVysKRR8x3cyOGthAn67+ZJTFaJAxuZ+AymfDqoUGrJgEJ12IwrnuDuCRY5dhzzEfdWv2NdWwwMmQ1iL0m4c73dxoRRRiyDZfWtIQQrKf4TzEqAzncD+DNMK+fTCpLFrTmuM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tpSwR25F; arc=fail smtp.client-ip=40.107.244.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tpSwR25F"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FXpq/nef50W89pDLerX4CYFHCK8AIzkvh9DI0FRHs/2qe0HfjpYkwpGhkp3HjKrkBPjyXzPDT7CEgi9Iu906xDSveYl9fdQC0c7FeSEk9on1KzbLb4qO1wjxXq+p5FW6fEFespssruO6GqRlkuUZcqrYPyZDf+bBPV0O9yqXYeDaPQ19QtLFOpDVpmUVwsbYe9cI78XTb+P8sWY72fuo7rfvmyVkmw4T19wtJmlwRTWyoZNylTFaajuiCkzjQ8OjlNz0D4h50r3meoJl3SpP00Pc+Gk0z5VctES6lW3FWl7RH9wtdNGiqXhFzjJdNfdtLYdRLPem7dySOEbQNul84Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8t85Fka3xDPRPCICTR+E2dOQzdPtkqxfEyVtF+LOPPg=;
 b=vXfjxG8B4lP/z+48Zd0Ewj016CKAgAgv0DoJ+cNa7o6cMaN615a11QG6YhzKmpF0pO9cEq/2N/haVQg/W15rgATUD90Y6EKA3je2JUCHeRZYdnVJbj1sONncvMGzqhNP5PbJeGSJSHlwbdpb+ubDZu9t7zjMwWfx0+SHoafXTS7Lo0RNoV75N8OCUXdf08TEEDRhQkE2E3/w+HE0Op5CGt2XzjX2jDoa/cznvD0wgYaJqni0cCaiia35ryqIPryrguaYw0mlZWs/1OD0jXibrNVcH/2BmRGAyCYO2kWSks33xIHiu3DCRKM3JdKGd7pWBAdFQrSh2kB7NTASeZIXOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8t85Fka3xDPRPCICTR+E2dOQzdPtkqxfEyVtF+LOPPg=;
 b=tpSwR25FeAbO+felXkU+abv777OOzt1retumVNY81suAiIp8WeModvZHSNDuAsshJsunKTML11nfoeKCblv984u2r8WjALmioDJXH1lA7NBo3HuWMsE8Hiw+7eHFsZDhp2gEVbAwMwXFH3pQh/PlUI7dooQ5X5iOKlFtQh6uGRic7Ul1WbDy6frWiUb1Olv+pJR7l+5g+h9l+uzaFE0pD38sQe2U5ntRD+AD1FfWnN8mZ7kiGECDJ7FSWhAKJsNpS/1r4d1oe6iQfIj2r4lJo4J5/QKAib7V4Sdlu3afu//BJUel3xbxQNF9ymbl7gk5tYv623sDv+tjMeqhS2RLuQ==
Received: from MW4PR04CA0346.namprd04.prod.outlook.com (2603:10b6:303:8a::21)
 by SJ2PR12MB8159.namprd12.prod.outlook.com (2603:10b6:a03:4f9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Fri, 28 Feb
 2025 01:31:40 +0000
Received: from SJ1PEPF00001CE5.namprd03.prod.outlook.com
 (2603:10b6:303:8a:cafe::e) by MW4PR04CA0346.outlook.office365.com
 (2603:10b6:303:8a::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.23 via Frontend Transport; Fri,
 28 Feb 2025 01:31:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF00001CE5.mail.protection.outlook.com (10.167.242.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.16 via Frontend Transport; Fri, 28 Feb 2025 01:31:40 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 27 Feb
 2025 17:31:22 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 27 Feb
 2025 17:31:22 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Thu, 27 Feb 2025 17:31:22 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <robin.murphy@arm.com>,
	<joro@8bytes.org>, <will@kernel.org>
CC: <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/4] iommu: Isolate iova_cookie to actual owners
Date: Thu, 27 Feb 2025 17:31:14 -0800
Message-ID: <cover.1740705776.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE5:EE_|SJ2PR12MB8159:EE_
X-MS-Office365-Filtering-Correlation-Id: e97c9204-3e8a-41b6-39d8-08dd5797a686
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?atTAOSwT3FLF93Q/Xq6syQedExjxzbFh+6xSP8pOLizxIm7glugXpEt3EUWb?=
 =?us-ascii?Q?HZsk/Vit/Jmki/QAPAQF+HmKDXADHrmZFQfUyDoxC2NloIW4deiAMHQivhTX?=
 =?us-ascii?Q?YWpSSppYeZ559w/YQwWtXe8pMsg/gIYEumCwc3yHmxWj71CXTI2OQ7UVNvN0?=
 =?us-ascii?Q?J8n9zhL/bYH96XGoddxZpgRtAyTAgeEdyvXn4RmhzyG5psR1xWf3+o4Yf7+M?=
 =?us-ascii?Q?qrvpH2CzZ5R3jzH/2S7ZDCJ6vscdCTMW0suUNtxdw2TA0jB8KZ15N4wn6agy?=
 =?us-ascii?Q?yGVmKFejrAyOf3iy/7xtoZbqvA8v0ixWBSSMwQUtMkdH1yvXmRBu1gXc6SOw?=
 =?us-ascii?Q?fFloJOE+6KCQfKQ3GTQd9fkHj7MKyDDg56FA2rsVZrv9Vm428efJMfdbjnj2?=
 =?us-ascii?Q?ivm+IF8wNFad3nwgARxXO6lIOSCGgmALbvmRM9EN0BMIpa80O7oQHmCJPwsi?=
 =?us-ascii?Q?ngfdyS+gvQZsYBn+sfdnmLa2y8AxExbPnN5Pn673J7I3XYq+V6wvIzfzMddp?=
 =?us-ascii?Q?w/25X1hdgOD93pJa0Lc5PXH+IclWo41ljh6fR9+Claby+sU2dYcGgOyyU34L?=
 =?us-ascii?Q?0MWi+dIF7TnWur1mSI9xiSnQbONB2+xbbc4nGHA/sSGOGBpBsd6PA2PNWuch?=
 =?us-ascii?Q?Nqvj0arxNcj0mFSko54BqZ3RFnvKW8c1oMBe+rA0BAYhDcMfLtUkSmzyHE8g?=
 =?us-ascii?Q?uI2OUCukYGpTGhDb3H1Pum0RAQ2BbJc4SnTLW5EAC1LooE8Bxln5/Vsx3/Wo?=
 =?us-ascii?Q?dCfO2MT/D0cbnOluNCB6D8R5XSG0EaiIgEv2Aedv1huW4oFTRBDkuzepYRIt?=
 =?us-ascii?Q?C9inMI0bM5bAs7w5UL9JiSf7253QrfrNwr8jnf0qwpeu//bsvEzs9eNkQaez?=
 =?us-ascii?Q?zU99jba7eumypdzAwb69C3WuJPWgziB6aHfR+63ispJBxgaYAkVslrXkqRTN?=
 =?us-ascii?Q?haQI8coC9HmzdYJ0Y0CYuC1zIK92qOTJaEC0G6hOMAOoTywc4UIrKRs5mILi?=
 =?us-ascii?Q?nksm2urvLxuIHS3HzWEcdiI2KTO16ARThtk5AEzWnjtJ8kQZQ91x/gCiwONG?=
 =?us-ascii?Q?fFQox7j2FN2s/v14EGXXfplYYxn0LGJil27V/NgTMQZUcofLYGXEoJIZlZNl?=
 =?us-ascii?Q?ZY31XB2yUvjJ5pePBn7+MJPf1kfn90/8qxUDr/N/7+wSvjhHQKc4Ray4diiU?=
 =?us-ascii?Q?PPZDxbDp6vi+jw3TJJin3GJif/wC8ISD7AEBf9ehDPMMnpVE+ikKHAAIR+fr?=
 =?us-ascii?Q?7rxicXTO1RynhYlSR2Kq5cgCqWktiXX0JVav4e+cIvR+3+dxUKRSV4tclJKX?=
 =?us-ascii?Q?ONqdqu9dxMzWKQLeeGoRcbh6mAaSPNPpAWU5V5x+A4fonfJP9wzgVdH1lK+V?=
 =?us-ascii?Q?5gaTfES+kWxsSSp7k3kBz0B1VBKIZxNNEU4bxlwUrvPs7uWk48sDQPcMIS2b?=
 =?us-ascii?Q?QzztaYzuO2U2lPEl2qSjBTOFGZ1jjtbOVdSumtlLvLwTtiTq4aRQxwgLi5uV?=
 =?us-ascii?Q?Dul2kTxgIXFd0is=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 01:31:40.1189
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e97c9204-3e8a-41b6-39d8-08dd5797a686
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8159

Now, iommufd implements its own sw_msi function that does not touch the
domain->iova_cookie but domain->iommufd_hwpt, as a domain owner pointer.

Isolate the iova_cookie from iommufd by putting it into the union where
the iommufd_hwpt is located.

This requires a set of preparations for iommu core to know what module
owns the domain private data. Since there are only two implementations
of the sw_msi function pointer, take an easier approach by calling the
two implementations directly according to a new private_data_owner tag.

This is a clean-up series for the sw_msi Part-1 core series, prior to
the Part-2/3 series. It's on github:
https://github.com/nicolinc/iommufd/commits/iommufd_msi_cleanup-v2

Changelog
v2
 * Drop sw_msi function pointer
 * Add a new private_data_owner tag in iommu_domain
 * Let iommu core call the two sw_msi implementations directly
v1
 https://lore.kernel.org/all/cover.1740600272.git.nicolinc@nvidia.com/

Thanks
Nicolin

Nicolin Chen (4):
  iommu: Add private_data_owner to iommu_domain
  iommufd: Move iommufd_sw_msi and related functions to driver.c
  iommu: Drop sw_msi from iommu_domain
  iommu: Turn iova_cookie to dma-iommu private pointer

 drivers/iommu/dma-iommu.h               |   9 ++
 drivers/iommu/iommufd/iommufd_private.h |   5 +-
 include/linux/iommu.h                   |  24 ++---
 include/linux/iommufd.h                 |   9 ++
 drivers/iommu/dma-iommu.c               |  18 ++--
 drivers/iommu/iommu.c                   |  16 ++-
 drivers/iommu/iommufd/device.c          | 122 -----------------------
 drivers/iommu/iommufd/driver.c          | 124 ++++++++++++++++++++++++
 drivers/iommu/iommufd/hw_pagetable.c    |   6 +-
 9 files changed, 176 insertions(+), 157 deletions(-)


base-commit: 598749522d4254afb33b8a6c1bea614a95896868
-- 
2.43.0

