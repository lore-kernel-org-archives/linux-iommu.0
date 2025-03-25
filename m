Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2079.outbound.protection.outlook.com [40.107.92.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB01542A82
	for <iommu@lists.linux.dev>; Tue, 25 Mar 2025 04:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742875548; cv=fail; b=RyMYOMuhPO5pfEMckvuW47NysLs378868J/P+5JvHyXv8t8qkAamf+s8nJhauztQz6ZhRVL+7n+pk2tywllH7rv/kO+SI1beWHk7sVV4y6HzYSr+sgTcfguj+K0vtHDCawkhgyErCAVYsbI7Q8ovsEaVf+L084ofE9HSzUCxPVc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742875548; c=relaxed/simple;
	bh=KKsL9KqRpDgg3l0i9b/87N3l/48tWkhXhSHOTtEfETY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aYr52uh+z/e5HYh1VeGLnjymu8nBUTR2ob6qeAKXOnHR5/SfS6O0wJ0xGn/n01adpdSLrcBo99iPzDGL98XmrvkAXGqNq7chRTC9CjkxoZIcizzSR6xqyNyseyS93t9/owkuiLPjBrpgSAVAQgUMFa7i2YdPI4uRocWVT3quyYo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ssvXJiv4; arc=fail smtp.client-ip=40.107.92.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ssvXJiv4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rN0EnEF13GGxU/F44sTN3FKBEieOD7U4qheNlQQztxJYkddZWd2FG34J5NUaac27yq6Y1QAwQOIqO4wPPlldgluWDIsbvnbPTxOlDWONsIQsX8b8C3K6gFMrLDmfZpj/CgGXDzeMLIFuuDCcm8cpXGzlwwA0vCLW8UAf1e9Q6vQ0aZjLeaDWk+aXzLuKY5BZ4BRR1qC9fJeiHP1gIp7V1I1KIk7u1Y/huMIFIsq1phmtm4ziCPbkcBwP0V/rqSVhzOc8IXOcKfmJI4q6hIQHq1XpsDvd2xuSSICSyu9bDd454/e9FDpd3IAZUJhTIOvWiR73M+Qm9vgvR5a4QozCKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2PyghMy124BY7OKKZEmlMo2Q2t36iU//mkJt1OoH/DA=;
 b=FTnmrV75Vgag6EA0LBAjUEz2CoMIM6DrbAIogWMLwTcBssSvE2Kna9dlpneqsIfz9mNepIE7+08QShMNpeKConeJpjES8YNaQazkA493w7OlNzCHcSFhl8DOH257NR7Dwf42p/3VKwQF2/7OahvGBi1H0O74pNs+hh7w9WFDDcw3ppjPkQ8Oi7Y4axsEghydNm6EvSAGGqjtAh2+5PbVHb8rQYSW26vokZBpWCrrqAP3RMQgwKClIYXqsGdeUe7mvUfIb43FgSJ7dCO2+WatakxontfbOBW0ntUxInNN9Orw4G8CViAzK9LG39U3+3xcXNRNtw8vHRdWsFV0+0ET3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2PyghMy124BY7OKKZEmlMo2Q2t36iU//mkJt1OoH/DA=;
 b=ssvXJiv4PNQNaLMI0kJj7lo4uXKH/PZc2XlRgT2lZykqNoRbtI2Og0PnAFnQjc2kEvOXsP79wSwwF7wb7zFSXgyLJkiuBwRP4BkYSbKlg+ZUuFRWXb87MtSBgLcr5olWUnYosOKqyYsgB/rh9PZorb3MQplQkDqedEI68RD0LKX3L9cjsRff24Z2UflY8VZgSEilvisQwQgrpHdmghBp1hbSh8gycRKHKrT1rBNm3A7Ziw2SnjcT+FYomSo1RstvFloaFPiHRIoskeMAwZ7jQGFYh/zCyxSyX05puWN6UJ4znpc7tG4oW7EdOh4xO0qpBGk4sw24U3okNWBiY2zvww==
Received: from BY5PR20CA0033.namprd20.prod.outlook.com (2603:10b6:a03:1f4::46)
 by DS0PR12MB7852.namprd12.prod.outlook.com (2603:10b6:8:147::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Tue, 25 Mar
 2025 04:05:41 +0000
Received: from CO1PEPF000075F4.namprd03.prod.outlook.com
 (2603:10b6:a03:1f4:cafe::4d) by BY5PR20CA0033.outlook.office365.com
 (2603:10b6:a03:1f4::46) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.42 via Frontend Transport; Tue,
 25 Mar 2025 04:05:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000075F4.mail.protection.outlook.com (10.167.249.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Tue, 25 Mar 2025 04:05:41 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 24 Mar
 2025 21:05:26 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 24 Mar
 2025 21:05:26 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Mon, 24 Mar 2025 21:05:25 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>
CC: <robin.murphy@arm.com>, <joro@8bytes.org>, <will@kernel.org>,
	<kevin.tian@intel.com>, <baolu.lu@linux.intel.com>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <nathan@kernel.org>, <arnd@arndb.de>
Subject: [PATCH v5 0/3] iommu: Clean up cookie and sw_msi in struct iommu_domain
Date: Mon, 24 Mar 2025 21:05:14 -0700
Message-ID: <cover.1742871535.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F4:EE_|DS0PR12MB7852:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c762a29-a0a5-404d-c3e7-08dd6b524ef8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026|7053199007|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sHFlg5z15xnwQ4imkn7bbRu//RC8uP5Z0GJzhUCbw3QlcUOtm6sqzgSv9iat?=
 =?us-ascii?Q?IydER9Ev5Lt0PR9RwDhcDnUyPQQgZQAYZP2fLaPj51Wl2OaUpmOOM/jJ677O?=
 =?us-ascii?Q?nX1Onf5GFhPiVWOIkEpDi2LQfCHnZEQ/MJbdaYqdwNzyeWWG8w+NzU6cSxjq?=
 =?us-ascii?Q?Ruce4CvHikkd8NL9b5ScqPFssXJ8gyKFx6IkA0J3v6eQj8epcD+0lezL8k7+?=
 =?us-ascii?Q?wu+97ZSHPskqn9TeqcV5QdBYSnEdVyjzpEG1su6ljkZu2H157/P+pFQUcQgY?=
 =?us-ascii?Q?hGYSgFI49od8jqOXFgHDLUylfTw1aTARXjMYu+CqGoX/KP9xPDtFmnnp7zQH?=
 =?us-ascii?Q?+3unzJuh8s3AeZJcRUGvbQp2Eu7JR8OBEqMgPtKP5nyzM0GhuA57Jm3wSeL8?=
 =?us-ascii?Q?Auuxu4ODqFDTBEuMHgOanOWVqP/ML3j2DOTaq+kGCe3cXurOB9A1W+oO2Nqy?=
 =?us-ascii?Q?H9SdKDhzwv/t1TXeLc21lEM0HmDR2EbrNi8+zF7nZcTX0Mq0er9IurpaC+a+?=
 =?us-ascii?Q?tco4j5MdiRlTM/fRpVB+hcg+wDrl58P3x+z9LIUzzKE9bdaj+x5aKWmCleya?=
 =?us-ascii?Q?m1KvgLi7QMy9TpcpFm0reChGIbPt+DPOgK3GfWBRtKOHJJ4/+PZLTQY9S9l2?=
 =?us-ascii?Q?zwQpFyTYcA1SlyCYkcqPmVFKjWTofmqp/GWqbVRuvLRYZipgxw1sUBVudDgH?=
 =?us-ascii?Q?ZcT+AXwLSYYNxVRNKQl/EhaOZuVNP/e1t3uMWeixag6e8b30XG/6L/A12/ac?=
 =?us-ascii?Q?jrmptMoVbmlHn/4jE/h897icAIVpA5NQLQp6q2TQtnMPoMTcFiQupwbDKTx3?=
 =?us-ascii?Q?d9xGo12KgsLgd1DX56NOp0Uw+zc3mU1zrHlZSXuRbz+C9FFW5kUEfyOrcarT?=
 =?us-ascii?Q?26VQSrILsqwZ2YPoySjFMMidCpXQXhfy4i8uZ1uIe12dNJsBcrVFjkbSI0xR?=
 =?us-ascii?Q?xu37Y4tubEgfD3ntiQJ4VEEimFDwsSA0pe9bDhdLEEbsvmyGhFcEzRDTLKXS?=
 =?us-ascii?Q?JcnucQKAQOTeQDQ7Y6YDfQqKBFC26ewGjMsoGbZAK3Nyt2Z5WkK51BBIJXGu?=
 =?us-ascii?Q?JA/0NffBxQxJ7AaB8OL2OYbvM5BPZBEJa/L7DDK7e6aiVBTfcBUufSe4lVaP?=
 =?us-ascii?Q?UkzEoxqe9129v02MD681A5DeoZY0TYAIh75fTkNRK21bg6GHSxHHWSLk0mQn?=
 =?us-ascii?Q?2uB43gV4oBy8KqU0oupDgMK986vzY/GPbIXqstWn7GwPvw5zLH7CKjpPud+C?=
 =?us-ascii?Q?GxokOiMzd37BKClUPSeQIy55KB46eRjWuG23EtRM8uUh/O7i697074reyb0T?=
 =?us-ascii?Q?wBpENl+lPewIHXTDPWPeNrMWwHvcY9sjsEenDRAOp7Tj89jf38mDm6wwNeqk?=
 =?us-ascii?Q?cMd9ceYfJIO6uQKjhJ0u128VaK+LdQWbi/OaJyaO2AzwINZrbTG03x940kZc?=
 =?us-ascii?Q?jaWOrcCzrahUyg+RBCKugJdIi/rCe1+o0WllMxNeNANib6m4ndbRrlY8uDmL?=
 =?us-ascii?Q?hVtH6fs2BMWuD9w=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026)(7053199007)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2025 04:05:41.1957
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c762a29-a0a5-404d-c3e7-08dd6b524ef8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075F4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7852

A few things in iommu_domain structure (such as iova_cookie, iommufd_hwpt,
fault handler, and etc) are exclusive to certain types of iommu_domains.
So, all of them can be seen as domain cookies in different cookie types.

Furthermore, iova_cookie is shared with the msi_cookie use case. It could
be cleaner by decoupling these too.

Define an enum iommu_domain_cookie_type to fit all those cookies in.

Since there are only two sw_msi implementations, check domain->cookie_type
in iommu_dma_prepare_msi() to call the corresponding sw_msi function.

This is a clean-up series for the previous sw_msi Part-1 core series. It's
on github:
https://github.com/nicolinc/iommufd/commits/iommufd_msi_cleanup-v5

Changelog
v5
 * Add IMPORT line for IOMMUFD_INTERNAL and change IOMMUFD_DRIVER_CORE
   to a "bool" module, fixing build module errors reported by Arnd:
   https://lore.kernel.org/all/20250324210329.2809869-1-arnd@kernel.org/
 * In iommu_dma_prepare_msi(), let all IDENTITY DOMAINs pass through,
   fixing the regression with IDENTITY domains reported by Nathan:
   https://lore.kernel.org/linux-iommu/20250324162558.GA198799@ax162/
v4
 https://lore.kernel.org/all/cover.1741294235.git.nicolinc@nvidia.com/
 * Rebase on top of a bug fix for hwpt_iommufd cookie
   https://lore.kernel.org/all/20250305211800.229465-1-nicolinc@nvidia.com/
 * Add Reviewed-by from Robin and Kevin
 * Add missing "break;" in iommu_domain_free()
 * Drop "linux/msi.h" header from the iommufd/device code
 * Set iommufd_sw_msi_install's SYMBOL to "IOMMUFD_INTERNAL"
 * Update commit messages for typo fixing and size comparison
 * Add a local msi_page_list to cache cookie_msi_pages(domain) return
 * Add an inline iommufd_group_setup_msi() for !CONFIG_IRQ_MSI_IOMMU
v3
 https://lore.kernel.org/all/cover.1741034885.git.nicolinc@nvidia.com/
 * Integrate Robin's patch
   https://lore.kernel.org/linux-iommu/4e68d5820be06adc1b34fc0d1c9399481151daee.1740742271.git.robin.murphy@arm.com/
   replacing private_data_owner with the new cookie_type
 * Move iommu_sw_msi stub from the public header to iommu-priv.h
v2
 https://lore.kernel.org/all/cover.1740705776.git.nicolinc@nvidia.com/
 * Drop sw_msi function pointer
 * Add a new private_data_owner tag in iommu_domain
 * Let iommu core call the two sw_msi implementations directly
v1
 https://lore.kernel.org/all/cover.1740600272.git.nicolinc@nvidia.com/

Thanks
Nicolin

Nicolin Chen (2):
  iommufd: Move iommufd_sw_msi and related functions to driver.c
  iommu: Drop sw_msi from iommu_domain

Robin Murphy (1):
  iommu: Sort out domain user data

 drivers/iommu/iommufd/Kconfig           |   2 +-
 drivers/iommu/dma-iommu.h               |  14 ++
 drivers/iommu/iommu-priv.h              |  13 ++
 drivers/iommu/iommufd/iommufd_private.h |   7 +-
 include/linux/iommu.h                   |  35 ++--
 drivers/iommu/dma-iommu.c               | 208 ++++++++++++------------
 drivers/iommu/iommu-sva.c               |   1 +
 drivers/iommu/iommu.c                   |  36 +++-
 drivers/iommu/iommufd/device.c          | 131 +--------------
 drivers/iommu/iommufd/driver.c          | 126 ++++++++++++++
 drivers/iommu/iommufd/hw_pagetable.c    |   6 +-
 11 files changed, 323 insertions(+), 256 deletions(-)


base-commit: da0c56520e880441d0503d0cf0d6853dcfb5f1a4
-- 
2.43.0

