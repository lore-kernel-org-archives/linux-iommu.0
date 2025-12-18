Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012044.outbound.protection.outlook.com [52.101.48.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD138242D7F
	for <iommu@lists.linux.dev>; Thu, 18 Dec 2025 21:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766094228; cv=fail; b=j1SnloCetBv2s99YTYFVIiewc7EmKJcZbuKViYYn9SVxcx4w4JtNAiX6qi9Aim6JxpiJXsvWCSnFnimRudnZRnQE7g/+ueWXJcCFgGwbtuDN24zOPeHeonE4PDWMBl8a+KHpSCSALgqxeUSZbypamYIvbgboL834xpn2xKIoQdQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766094228; c=relaxed/simple;
	bh=TJyp+2atbb6/OxZ1bqNSgfqN98HXC+yjb83QPhS4Hq0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NVcOzuYjEHvIB/MF33j2mAZty3CSVYgUKUGGmAjb9ENMooXMjvkPON9YpPGzvRUSelcBDqc/NaXKlI66nkmaloAP1/yWd3FZaAC11sBXBlaDPOofEM0rdb/0of8ur95sjxLZQOG5LeG3Flfe3CUQYtmpoAj/Ex3aVS4oUPxCIrM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=U5XuBDRN; arc=fail smtp.client-ip=52.101.48.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="U5XuBDRN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RsPaAPTWc5gvMCqLfkKAbYoxXulpDkLVWFz+hG8wW8S389/LNMfwAHe0oqlqgxTQSBV35HBmrGjveBlXh8v/Y6yAimivZavln9/CuxHFZRhIfRQgZociQ+PeoZk7Sw5FYAHDG1jELc6CZlzF1oZjDEeriBqxk6ytGvn3okRt9L2nfCue3/WK74hiH1P9ImEDRcRejaeZqBLRWn+JvIngY3Mhm8A2IX9SfrgJ0dWI779RGjsVUrQPujlEQZJQEiUeBoKq5zCnUVTFGD6r9DC9DZe3u6rY4IdpyVBxFUv2OxST3lZSCuHp9VACj+ITKxmOyaY9HIG7EMLrZun05+fPvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZiaPBoE73/jFjOA0sVsz83u9ncpjE5JbJ94bFYxcGVQ=;
 b=ErMf2q1vJPyyjezKX4Z6EqzHhn5TdCpE0dmXPD0loNh73fI3ozFQffz6SINT4YbwaM5Nu7XIKgIm7hwCCW3Wqjj6h5/yneTbxYJYsnQshemm8UHDgNaL9r1uDTXyfgnOFFK9dFdsfVM1FHa+BwEfGQP7vQX5hLdnIUT6QVd1URcnSLeSF82jlA0/oX1Vjnm4c7o0ax/Bz/4JEvdMmeVKqeVoNiPFuDn3BZQBZMFIiXZbCtipnnbY1EIlC6cGYdNvzzANsWJaROuNrDYANn3gCqNKFXSn3OKbJ+Y3xSe3C+g20FuaLvEjqG5tQmh/OBy4G/D6mAoh8nEXELvF7AhONA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZiaPBoE73/jFjOA0sVsz83u9ncpjE5JbJ94bFYxcGVQ=;
 b=U5XuBDRNoaxihluxiCmoe9xRDpE/+SAWwqICz+YapQ5lErMGciQzjoWG76+L3GJUl9QypKmUt1H/dfEOEsnouw01kK7sKE8/R6H7Zqz4h9DXZjhIAQEKckB5WOmUPY2aM/7feWeRzDe5DxJZDOpoZbwSuPwuWoi2iHZnxAj1hgLAhy2GTragAdJBzgrNhqtGL7KQX+Ml9XS/q6/XNqCuuhGchMe551Z5a5wdmTIjJJ3anhY0SD/7cJ65kqagUE6gqwvZxl73Beh/+GtOHr8pzz39kmdlrq/jmaO1MvXI8GDYzAQ5uCQi5zUPEaWmN5FEnPYAYM2O5pW9Fl7rVt6q4w==
Received: from SA9P223CA0005.NAMP223.PROD.OUTLOOK.COM (2603:10b6:806:26::10)
 by MW4PR12MB5627.namprd12.prod.outlook.com (2603:10b6:303:16a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Thu, 18 Dec
 2025 21:43:39 +0000
Received: from SN1PEPF0002636A.namprd02.prod.outlook.com
 (2603:10b6:806:26:cafe::78) by SA9P223CA0005.outlook.office365.com
 (2603:10b6:806:26::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.7 via Frontend Transport; Thu,
 18 Dec 2025 21:43:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SN1PEPF0002636A.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Thu, 18 Dec 2025 21:43:38 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 18 Dec
 2025 13:43:24 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 18 Dec 2025 13:43:23 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 18 Dec 2025 13:43:23 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>
CC: <jgg@nvidia.com>, <joro@8bytes.org>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <skolothumtho@nvidia.com>,
	<praan@google.com>, <xueshuai@linux.alibaba.com>, <smostafa@google.com>
Subject: [PATCH rc v5 0/4] iommu/arm-smmu-v3: Fix hitless STE update in nesting cases
Date: Thu, 18 Dec 2025 13:41:55 -0800
Message-ID: <cover.1766093909.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636A:EE_|MW4PR12MB5627:EE_
X-MS-Office365-Filtering-Correlation-Id: 947a7481-62f4-4ec8-82a1-08de3e7e814e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CXOXU+iN+4qkQlDuMEzu4k17pxJc+0QeQVm6eET3vLKprbPXC4ZzqcjoeDJ0?=
 =?us-ascii?Q?2JzNPMFKD6/nzsIuNd9loP0bZlji0ONh5+cu6dVDPXjBzmy5cC22w0gsOQ/J?=
 =?us-ascii?Q?JWrhFJKIwXlRJ57erTu5bjZcqk9XKiILrlqNtkV0rC3htxMqhwk9vHbY+Upk?=
 =?us-ascii?Q?RQVU+59au3ZL2Jo7icF4rF2Xb8Q4NP3PMI9Er8/kwXSDxiqJMQMCyqMiqoft?=
 =?us-ascii?Q?VaRNowHiVVwqRvZb9qbTWNorCHaFshbpXvK/PWIT0VGU2T7Qt62Our3IhVau?=
 =?us-ascii?Q?8EifgpXGle4+llXCRLkdQi/pk5rRJ22Y3qSpZbuHWBlIFy0SrTS2AsS1es72?=
 =?us-ascii?Q?beS2flaqSg8u4r+7mLHRf9HINWRUEcYM0sPfz3rtwvlgTqOkco/3UELyWqUw?=
 =?us-ascii?Q?MbCRhxsnP1zPFvjflQ71Ch8xYBh2eZdKESECKN9P5otX7lbVdqjWAVGl+QVh?=
 =?us-ascii?Q?M/zAemRZBU8gKbZRR9pWl3cNnCofl4eBcgIrwY3aT4flMcYt7F0SaXaZuOF1?=
 =?us-ascii?Q?IWFUSsD9gedlBhqDP9df4E4HNj8u83oc7XiaAOqYkkRftwa4HXLL9FSOLTcT?=
 =?us-ascii?Q?5gkb3a2l1O90TpG0+MCF5UiQnlb+LkuPk03mmUtr71vXfkMEz1Xys8oQSlZ+?=
 =?us-ascii?Q?LVcP1s7PZkVr+W2jGJI0V5mjnuq2zuo3g7V0eE3D+mVtHV80uW/6Zx3xF6ep?=
 =?us-ascii?Q?YwiSHe/+jGNIK3F1jsahL2j9yvWR07TXmHeRkJI/H9ZO3O+jmnGbV8iM8e/H?=
 =?us-ascii?Q?uXQRygUHsndoGN6oY739ZnLV5AxVeEb4xskg6PuTlyBZGFHS9Lb0gYmjCysZ?=
 =?us-ascii?Q?LNL/FHKGjSggcFfTb1LjA9rAEI930dQ0ySQSqQKkVyjd7FCk0hrhDOdJwVnd?=
 =?us-ascii?Q?uksAN5vuHC1YyhDlCIABRvHOwytRSK2Jk0XbSNwHZHROci/15t8lcN/p6jGD?=
 =?us-ascii?Q?hG2wt/PHYZFJtIW7vJKA/BLcU6izAtdZT+RC61xhUy7flCsH7nna3IMLHDWS?=
 =?us-ascii?Q?22XHbPvSE1SX6srGDEO/US6w4cnnD/fkGg8EofMI5r0qJwbAjPVXRYJAoaZg?=
 =?us-ascii?Q?06rZ+IuSv5UyYcMK4XVWWXw09BVb8I7zq+7t6W19hkhLe4gDxpZMrpdpdpir?=
 =?us-ascii?Q?F7jgKlTueBsY0lMAkclNDh8sqyix7EP8nq6VpjVmVyPEd/3E7+kCKFEdX6mZ?=
 =?us-ascii?Q?eLBEiJgAi3Dke0BYcDlHlKlRVnely8NMuwxlRmnnrPEuLtuySeIk064jLy/J?=
 =?us-ascii?Q?PsdeQxPnYO+jEKbVwNXIJX2Dr7mWBBWCLvAACYj+yf4176Us1jYj1MH1fdIS?=
 =?us-ascii?Q?EIoxiXugfrh4KeB1Ca2wsXK8J7/pUcZpyO4NeGUn8yA4Q0M4c3zYY/zNhWFH?=
 =?us-ascii?Q?yY58TIwvVrKKAB4AiEY1fZ6237M4lML5vG9T32D620plglDEr1hhffMw4nFc?=
 =?us-ascii?Q?eV2JYLQnwj4JS4DVk2gVsu9BkBZYZWeguBI7/CZ6PuS27E5vG825Y1ud4jZ+?=
 =?us-ascii?Q?C6DREE/WiuzEHy2wpmwWMm5dEDTOBWKpBGXBoTY/8/0I4ckX1DLSrnzdypfM?=
 =?us-ascii?Q?oMxwbWpeQm27ZB9Uce0=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2025 21:43:38.8148
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 947a7481-62f4-4ec8-82a1-08de3e7e814e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5627

Occasional C_BAD_STE errors were observed in nesting setups where a device
attached to a nested bypass/identity domain enables PASID.

This occurred when the physical STE was updated from S2-only mode to S1+S2
nesting mode, but the update failed to use the hitless routine that it was
supposed to use. Instead, it cleared STE.V bit to load the CD table, while
the default substream was still actively performing DMA.

It was later found that the diff algorithm in arm_smmu_entry_qword_diff()
enforced an additional critical word due to misaligned MEV and EATS fields
between S2-only and S1+S2 modes.

Both fields are either well-managed or non-critical, so move them to the
"ignored" list to relax the qword diff algorithm.

Additionally, add KUnit test coverage for these nesting STE cases.

This is on Github:
https://github.com/nicolinc/iommufd/commits/smmuv3_ste_fixes/

A host kernel must apply this to fix the bug.

Changelog
v5:
 * Pass in feat to arm_smmu_test_make_s2_ste()
v4:
 https://lore.kernel.org/all/cover.1765945258.git.nicolinc@nvidia.com/
 * s/ignored/update_safe
 * Change entry_set to void
v3:
 https://lore.kernel.org/all/cover.1765334526.git.nicolinc@nvidia.com/
 * Add Reviewed-by from Shuai
 * Add an inline comments in nested test cases
 * Reuse arm_smmu_test_make_cdtable_ste() for nested test cases
v2:
 https://lore.kernel.org/all/cover.1765140287.git.nicolinc@nvidia.com/
 * Fix kunit tests
 * Update commit message and inline comments
 * Keep MEV/EATS in used list by masking them away using ignored_bits
v1:
 https://lore.kernel.org/all/cover.1764982046.git.nicolinc@nvidia.com/

Jason Gunthorpe (3):
  iommu/arm-smmu-v3: Add update_safe bits to fix STE update sequence
  iommu/arm-smmu-v3: Mark STE MEV safe when computing the update
    sequence
  iommu/arm-smmu-v3: Mark STE EATS safe when computing the update
    sequence

Nicolin Chen (1):
  iommu/arm-smmu-v3-test: Add nested s1bypass/s1dssbypass coverage

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  2 +
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c  | 65 ++++++++++++++++++-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 46 +++++++++++--
 3 files changed, 103 insertions(+), 10 deletions(-)

-- 
2.43.0

