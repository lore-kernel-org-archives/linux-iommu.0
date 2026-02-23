Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011038.outbound.protection.outlook.com [52.101.52.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24BC3345751
	for <iommu@lists.linux.dev>; Mon, 23 Feb 2026 06:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771827526; cv=fail; b=MhQnm2Eqg69+42/ihQqfJ5yfEJrhprdV8PiOrSssm4ObnsH2FPH+97rbJw/cjq9RHhEN5xWkwaRJP7d74ziVjTpax3Q8ic6vRZW+AM1CURygwhZokt5pffYesXJq1lp4cefU2BS7cmdlv0bfvti6YkUnpPO4mOXqb0NN8fo5J7I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771827526; c=relaxed/simple;
	bh=V04FaGaI+g/1/VTOSJPWMrkVn2N9iBtimkuxGfGMMig=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ILppLkqSG0yhk7Suxw5s6gUqOrfJCv9/q5ZBWbfAcf8ZKGFrMh4tEir7t5TmD/V13AJbStQ/mGcWMeNCYpRy+NF9AL2cv6WZEneRgFR6OfpflryygLDeZdDLpWCGiAsEfJrMeE5VasGYV2qrNrRU0qr8/ZLDGhiM0M97O/geCx0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LAbzaIuS; arc=fail smtp.client-ip=52.101.52.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LAbzaIuS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w/hgIGnBMeO9PazRQYUDg0BX4BfwIxlvPAt00eCUpS4hYvs/Szg+Vb6ZAd8lOfx5KQrIKaVrXla5A0BPpVxZfZ5dYR2WOW4s73qVePqlPH94VPVzZGsI1HzmapXlRGe9ITLDGYOG0DlA9ev7pykw7rOnskQYrYuqJ15ARBF1Z6SQXpUCSsXZ2QqSkPZImvl/0T2/jG40ZAm+2YiUV/jPJqnUSAUL3AGZV8OQ8yfcQtO3rwf2uQdfR3bX+5Gvkta2iV7IgXY/N5qnVmdqHZyCIoJIc1Duw9qKycAA0pTAkJJHsxYTMp0hl2AhIQXU1VdYXnDriElLT9ckjEvmJkgLNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ymQGXcai2IVo/VzioFKJCpzaIgTPx9PQhVLKTfUKg8I=;
 b=q9Aq5gFOdwpSSqs5NevdeBontLC5HzkbYoMFYODIsM6uEhZCAQZ6hpXvgj23iogeByplubAQdCiOxx45RxmZG2E91/3xXDV3ao+SurniztlyQsDDFSYAIvRIiDe7HebSK2Mwu8Men57YyWU0DClSnAY5qxo5F2CQkD5MP2Math2LsqIX82VF7X6AYuGBIsbfiLGWuB5tJ5i3bpHYyuVi/MWZMYR2hXJYWFHl7+kG1LvS+lcxWylvQ4s1/NUNgsQbM5xjhX/SXEOPQ+5XUoJqWEE3jzIUawUs35thmwZsaRXDlSt5BGqjRZus06+T8Dp+BYwqKL+yn2QnyhmEfPmJrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ymQGXcai2IVo/VzioFKJCpzaIgTPx9PQhVLKTfUKg8I=;
 b=LAbzaIuS2dozK3iOF9luE28QFQdZ9HDZqz4LQZrDcS+td8VmrJNVo3PUG8gFotsdRK1BxxLBrwqL3R3+YYJrenik5Utu8T9vPhIa890GwkBJfamcWHjEuIehjwYhEGcL75M5We2AffkBseGfIUhLQD3SKc/Fdsjzu+QBZpz0jn/EEq2nm8lP6/lJJ6ojAtRSkQEdincqSzbJQX6uOVzfeOSxigZ5mXwGpncTg3WhdLysbTNDdvX4Zi9wS1kYKKff51G1Cq1d7LDhV5oX6aqegqOmHKAt39PpxPRtVtf/hl0KDu/kxMDZtFLtq6yTbHqSJMvRm57pSEckH2pjsm1EvA==
Received: from SJ0PR03CA0227.namprd03.prod.outlook.com (2603:10b6:a03:39f::22)
 by MN2PR12MB4421.namprd12.prod.outlook.com (2603:10b6:208:26c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.20; Mon, 23 Feb
 2026 06:18:39 +0000
Received: from MWH0EPF000A672E.namprd04.prod.outlook.com
 (2603:10b6:a03:39f:cafe::bf) by SJ0PR03CA0227.outlook.office365.com
 (2603:10b6:a03:39f::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.21 via Frontend Transport; Mon,
 23 Feb 2026 06:18:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000A672E.mail.protection.outlook.com (10.167.249.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Mon, 23 Feb 2026 06:18:38 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 22 Feb
 2026 22:18:18 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 22 Feb
 2026 22:18:17 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Sun, 22 Feb 2026 22:18:17 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>
CC: <jean-philippe@linaro.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<jgg@nvidia.com>, <balbirs@nvidia.com>, <miko.lenczewski@arm.com>,
	<peterz@infradead.org>, <kevin.tian@intel.com>, <praan@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v12 1/8] iommu/arm-smmu-v3: Add a missing dma_wmb() for hitless STE update
Date: Sun, 22 Feb 2026 22:18:02 -0800
Message-ID: <0e076722312d903bce71d8e0b963722f458d8df4.1771815709.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1771815709.git.nicolinc@nvidia.com>
References: <cover.1771815709.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A672E:EE_|MN2PR12MB4421:EE_
X-MS-Office365-Filtering-Correlation-Id: 81449a5b-13c1-45ff-2df9-08de72a36269
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|82310400026|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ggi+bVEHmZzgOc7eFXp5VEakLnhrp5rPzSznjX7S7EpuSrNFAQ63ynTay9fk?=
 =?us-ascii?Q?TgUm3/kFbURQg0QnB32ENWezOkK3dtpQwK9M1uDV9nL0ILFJgptgiEPu+4go?=
 =?us-ascii?Q?KZMJxEh1ZPyyOU0kqSWEECoxXNNAK7Kz+vnYd35Vm1bfuCCtrr11TtPCfC/9?=
 =?us-ascii?Q?SmmV8/8VU76R9XYwHWe5NrWZhUYo/yERf/AsgP8BmNF1eRoNibPd+U8fyLY9?=
 =?us-ascii?Q?OIYJfm6NHip86XHvRD0sFR4KxvaAp6hCa5VP5qCBNYshKIX8xuKipe7k39sO?=
 =?us-ascii?Q?DpysF6ChBBSLT/ABG6BRLeo/4KXoydgiOXf/ZjWZXFzUOkmXL6gDir99toWv?=
 =?us-ascii?Q?1CgKJBrmaGde79YtoSG7cosU+e+vFgzdq+DROwucLILJs6pP+BlhPQu+uHXx?=
 =?us-ascii?Q?E7fRRgnK5oU4d+BYKtHtWcfIAAhZuMEndNZjbiQjzgHBtoBf2rOu2HKywfF7?=
 =?us-ascii?Q?qSQrpdHg2o20//YPrfXBeqTMXqS6sPAYdng6okKxey0nwT6wsFuJI6T+7GWv?=
 =?us-ascii?Q?XLBEnHimjxxG9Cx7JLhgvYCAQd+HIIyGmPOME0BFvVA+upS0rI2OcX76kBPw?=
 =?us-ascii?Q?gy2sy/scCOpQbberRVKT8wUA+rJwj/FILM03Z5jVaEaVG+UKeBnpyjL/KCPZ?=
 =?us-ascii?Q?ef0GSv9oNY0CRAJNsIHD8Au7uwq1YA+JIpflWmbk8kfjlwLlp+IPjoSR3M3f?=
 =?us-ascii?Q?9NQ/eVTlUtmvdCt1dqPDatTSJDyjnLm1BPxCwEnpX0j4N0Rw6gJ15QGRrmIP?=
 =?us-ascii?Q?4Wc3Qwu3Y2g2IGTsDfXw/opWKflJHpACFrH1wvzuirlo1aWOeuAletKLNpk2?=
 =?us-ascii?Q?Zqmtd03la4UiLooGbSoaj0r18oL8ok+sITCfUPTuhFK+iI17/7FTtoz1MVif?=
 =?us-ascii?Q?UNvhdfbi3jWTxIouQjB+2z7AX+SbNdf/1cSVwDIwPi4bW3bjjf1hloTYNSAB?=
 =?us-ascii?Q?fLyHwnU6yrz+xAxp/8m+49uHhEoqeC+1L7J/Nyrn6BAnSzQKEkgbwGWg5Al1?=
 =?us-ascii?Q?4tMrm4TFVrns1boypFqbUzSfQF1c8yJSPCu4CiK9LommpJtbGeq2JR18xS09?=
 =?us-ascii?Q?iPABnIUSeJro7trQUyoF0qS1fKCDLq4ykxyrBfpe1sHyzaGW4u6Isa2lnWTH?=
 =?us-ascii?Q?QUHKYDAEdlKuJIMQxQSXoqq1AVQp6MXbmrAhgqqeqpOR1S+mNBmIsNbcJ41I?=
 =?us-ascii?Q?vz0XLnI3VsTV+sUnawpKmb0Ii7KSDMaxdoY+cawk3xEKu4uABy6xTsSp/YO8?=
 =?us-ascii?Q?6qx2olgORUHA7T9GmZ9LlvScN18bninKNqBcDlXDgbUOuswwfugWd9A5Eyzt?=
 =?us-ascii?Q?H8aR9SP6KcrnFu4POv8IkmTR+9bdsMwWk33go2w4HuNDX3is0OWja2aUQ3Y9?=
 =?us-ascii?Q?ECpdzNHVN5qhLk/pFgnURyEcwr7dDldaOhR+CTht5SdHmApQbYc3QJjRYmi1?=
 =?us-ascii?Q?GBFavMzonFWNA8xE/HP4vSzw6QUibBX+fGIue7gVwgB4OqNbR4FCqar1sNBu?=
 =?us-ascii?Q?hbSvpPOPQUVYQrIKzGjXC77wOg8cpkBSW9Yrvwk6C+v/245U1fvpNIDBN9hS?=
 =?us-ascii?Q?7r8aIyVwW1wq8rmmoAcXevt/PclRYpO9SO7kb7QYa9xfgqxdSA4VGQ0DduE7?=
 =?us-ascii?Q?dgNEa/q/Mya0FCiviSMBM1vOfpzaoufanIIkIP28bmWpIlUCktXCDKXmBfeu?=
 =?us-ascii?Q?1d3Qvg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(82310400026)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	fNepU3SyzMNgaH4i27D/AUwuqeyNxrbHopE6DzhNtEt3WRVNv7sKtOX336PzVbSwOHI2A8uvpM793QO0OZOv9UBUd4/a7TVlVFFwOoP4cVAdJLZbh1dXNj+bU+uXD7A+2vlQOEd2umHsnC9T/EjgOxf6LLjw8leeBxntJy8fk5uCxlU8V/SxFTDUAKFBEB7rRfcQXHgdTdm67snpWXOcB3GYlHmgim1hLtv83vMo9IndVrcPwkPqz5wU/nIov2sNU05/reWzZ3W42LGa1xGjfOJhdw2t5leWUpwQY2w+q11sFCD3HnwYMEnef20SaCvgm9olI17/25g7pOnrpo4AS5xEqKGtWOAl3KrFChIxPdf4g4u5gRTEq0e+joVTXXCA5SPy9eOi7D3wt1BQwsnXdBAjsYeI1A/u71E8mA8NCAdiFLJ2AXauXLEYevhPN7qB
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2026 06:18:38.7972
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 81449a5b-13c1-45ff-2df9-08de72a36269
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A672E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4421

When writing a new (previously invalid) valid IOPTE to a page table, then
installing the page table into an STE hitlesslessly (e.g. in S2TTB field),
there is a window before an STE invalidation, where the page-table may be
accessed by SMMU but the new IOPTE is still siting in the CPU cache.

This could occur when we allocate an iommu_domain and immediately install
it hitlessly, while there would be no dma_wmb() for the page table memory
prior to the earliest point of HW reading the STE.

Fix it by adding a dma_wmb() prior to updating the STE.

Fixes: 56e1a4cc2588 ("iommu/arm-smmu-v3: Add unit tests for arm_smmu_write_entry")
Cc: stable@vger.kernel.org
Reported-by: Will Deacon <will@kernel.org>
Closes: https://lore.kernel.org/linux-iommu/aXdlnLLFUBwjT0V5@willie-the-truck/
Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 4d00d796f0783..606abe051e68b 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1236,6 +1236,13 @@ void arm_smmu_write_entry(struct arm_smmu_entry_writer *writer, __le64 *entry,
 	__le64 unused_update[NUM_ENTRY_QWORDS];
 	u8 used_qword_diff;
 
+	/*
+	 * Many of the entry structures have pointers to other structures that
+	 * need to have their updates be visible before any writes of the entry
+	 * happen.
+	 */
+	dma_wmb();
+
 	used_qword_diff =
 		arm_smmu_entry_qword_diff(writer, entry, target, unused_update);
 	if (hweight8(used_qword_diff) == 1) {
-- 
2.43.0

