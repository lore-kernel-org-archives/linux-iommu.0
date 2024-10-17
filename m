Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2068.outbound.protection.outlook.com [40.107.96.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D7A91DDA39
	for <iommu@lists.linux.dev>; Thu, 17 Oct 2024 14:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729173804; cv=fail; b=UhEdFXZWFu2Ph0shOZZaIrdAgmZ5pgm/9QoL31+JuE/hw57bL+9/rzsOfO1ucKn75ktELSf/3f6884DjKtpPZncxeoKqoSPRZIzhC5Hp8Ts+hZ5kcTJhBoibtcWLFOTqgV3Rl2U496MXbluH1Mih/JGGtrskbLoWF3v0bkU/fkg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729173804; c=relaxed/simple;
	bh=ievQMcnFuKekYfdK2zsw0lj3c38l2LFbb3BdxMlQ2dc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s2Rn1Kpl0HlmXkkJp3vnEO/o+XcIWC+eHRtBItZ0tDUKgZ2lqcR54vJ5WCvO9/7sM9boh3JXnOFQdQrcq2PM4Ci2yXKcu6Jv+IyesxIg/G8CVXkcWN/jKU9eIF+Y/GeMuDAeMS8ca0oIPRIdIyZnr+x7pDLJgCjEWn6Gew30lwU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FC5dGbud; arc=fail smtp.client-ip=40.107.96.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FC5dGbud"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VswT+hkarF7dxzzZ0259GCAsbZrL4lgjKfXAk3EVTGhdRbSJRSBQeJWNCHvxsVzLiFLsnRwAEYxRTGG7px19D95Um7kS9P22CTnc2KpuX+UkIcYTj/rt2LCF1VtYWlOr+dLPNIqJj0p6cxjfH5OY27RGxL54TkIF/gxdmJFCSxdCGvsXHYl9NjoDJs4n7OyN52bDIkgWsKfEAVzwBAcHHHnnlD2VKmQc3+ZBha/PKm+/GWk5DyZRAdLYOJuNqD4aieq682S6tNPrm9IGN1+R1poB0u6Gks2NUYkKPvE/BC8jeKbkNjMXEE6wylrv1cvIX2Bb7iyOCuxmJupzsEGqBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ULmwhrNEEqZORbHsGQ51OZYyji3ZB8A0uSOUfMy1gns=;
 b=hQfzvMy1++qILHQyp1V18Tqz0abdVGOHlmc0TupZKWuDqWF1MFVrdLaa7LDxmyrIN36HcKqrnLSSWLbodYvbjNKJeh6xBjxESCkkudqxSfO1wbFbY17iw6nsyFphhLQcjcvAlMQcUltBsPHax+1kRK/6hruA1DCTVDq7rkqRFbXaIDioIXxQ/OdNvCeEgnrmppc4CezUSeHrMOBnWrTLgU2tpFcIZ8O/xK/rg/awzTW/4goqpMQE5egm0c7qb4hZAWU9fZSq9gPILw3juvi3syuSj7mPRphmFnJzHZE9pNqo0B07RjlC+HFQqhRzAZHTme+8QsCn5iAOH5n6aoB6Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ULmwhrNEEqZORbHsGQ51OZYyji3ZB8A0uSOUfMy1gns=;
 b=FC5dGbud0mRk5k6UxyeziI5JwweZuGkphV8xF4oZ/8DLnmxmH8bBcIJehdnM5T8om2TnKK0Ynbpj6CKC8C5gGC0gvn/ZeO09HqXJx2lZqnRL/xMRIAq76J8TXw3OGinTp9MIhJeqLGf9gGOp+RNfDBr4EbleTCPH9E/zK768Ses=
Received: from CH0P220CA0017.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:ef::34)
 by LV2PR12MB5872.namprd12.prod.outlook.com (2603:10b6:408:173::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17; Thu, 17 Oct
 2024 14:03:11 +0000
Received: from CH1PEPF0000A348.namprd04.prod.outlook.com
 (2603:10b6:610:ef:cafe::82) by CH0P220CA0017.outlook.office365.com
 (2603:10b6:610:ef::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18 via Frontend
 Transport; Thu, 17 Oct 2024 14:03:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A348.mail.protection.outlook.com (10.167.244.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Thu, 17 Oct 2024 14:03:10 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Oct
 2024 09:03:07 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, <jgg@ziepe.ca>, <yi.l.liu@intel.com>,
	<baolu.lu@linux.intel.com>, <kevin.tian@intel.com>,
	<jacob.pan@linux.microsoft.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v3 04/12] iommu/arm-smmu-v3: Enhance domain_alloc_user() to allocate PASID capable domain
Date: Thu, 17 Oct 2024 14:01:29 +0000
Message-ID: <20241017140137.6028-5-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241017140137.6028-1-vasant.hegde@amd.com>
References: <20241017140137.6028-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A348:EE_|LV2PR12MB5872:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f93b2d1-9699-4ef2-8abf-08dceeb46f5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZSFNNOxb9Df1wWxpkMPjS+YOmirjXM8nTwFGjdD8Izp/UvkDiuxs2GRDHHPw?=
 =?us-ascii?Q?RnEd/xXzytErkcP4A+blKtG6bGFWPKBbUCinxHhqCpKl5w7o17ZzXHwvX8hK?=
 =?us-ascii?Q?3lle6rJ5Ffm+GWqRd47XKfQi8wbMm6yruumrGq4c0c07siqfQQpL5ltnyHIl?=
 =?us-ascii?Q?vedvBNPdlTs5xRa+BjEUQ1yvOXNQuZ+9oREA/YOVpUT386xt9ujAwKimWJeg?=
 =?us-ascii?Q?N8ZfGvBQYakJ3YBarqq4sPk9+Zb/PgtuICz9F5kiilCDJkGupXcAJ5nE3fcR?=
 =?us-ascii?Q?zlsmni+BQR+2sGg7JZMREudemfgtuSg2WMFC/SbqeVvG2ZimiubCOUevtj7C?=
 =?us-ascii?Q?XuA9iSaieSQ3TY036h9Jy+CK4etyTVcaBcp28hyy9trdofIPKtjlj85F+SKJ?=
 =?us-ascii?Q?QbnNFacTWODj3EeJrVtywUT7pQMg+eIyZCmEvxJThFSmopUwmeVNK96i0oA7?=
 =?us-ascii?Q?FG/fuFZY2IZgUtTPkhRGZpZKGy6gH0cHsBh7+oxJpLCCHGSqx6xVoUPxQfra?=
 =?us-ascii?Q?swlGQ0z/VOv+AmMlr7tpqAH1sJv91zXuu6IdoQzZMcY3yTteeBPhIPsEwoip?=
 =?us-ascii?Q?IfB4eUw6/elBsO7u1zKDKAfoVi35hMgDIh2J7RS+Hunj7If+QilioSqaEbpV?=
 =?us-ascii?Q?mnNDbygMY7IGsK+Hn83AymGW8suC4EV/1oM8LMdOKuxf0XjgtdPLypslydI/?=
 =?us-ascii?Q?2yQkLmEm6WqqPdEb9cHr6MXuOuypcGnzjzF9ECL1jUkV9GyiYMI3SWXPlVna?=
 =?us-ascii?Q?nM+YqOIhq6KQK98n7jhHMythS+vLNLba5SY+HVV21ICLYX58PaOpIEmmVAom?=
 =?us-ascii?Q?zumBT1N4KzkgTl3G2PjqD/z5XvWZaI8PC/Zc/QXr9cLfey4EaJOL/Obcq79n?=
 =?us-ascii?Q?P9nQpcEwaa4JphoDIU87InXjjiuE6rdt7o5DHYJiLeM0pnCMC8fuEPjj8LpK?=
 =?us-ascii?Q?/t3v/IAPReaeXafQK5M6q4mCyF6risLEBi3EH29F2WvpfxMzGQfAfDjC4k/+?=
 =?us-ascii?Q?OuGPbgjbhIGiMIB1B8+h1vIYMvkTUkJkOaGrGk26f9EpM2uwJVXaJFI9bYwp?=
 =?us-ascii?Q?83L0OBfCOe0mt9kAXHZANxIt620mWaJhhw6vheX+++L+RG7yS4O+rwPXoCkF?=
 =?us-ascii?Q?feCQa9WtbDJ6pp67nkAV1pRh178gJg7D8opoSZMlgtfoHpYGNG0RazuP8kDr?=
 =?us-ascii?Q?rQTG8mNkVqEUB6CZKkQB5XNtlWIRn3aPqG9alZhUSd/rJ+eKTvZ8Xp+2LQWt?=
 =?us-ascii?Q?mqZW1Dna/yQq45XnUXgJ8uPJ98xyzV67T/qp9XUDEe5Byy6E71CUlMylgyDd?=
 =?us-ascii?Q?4dtHNxEtLy05F2GUlQyfi0+28iD2fZ2AJSOOw6LSJ8qRhqZLpWumBtfXRh7Y?=
 =?us-ascii?Q?xYu2XOZ7ZSSGtaPQQiSKaI01sO9spuBimnZbNEnCGV2ZEDntrQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 14:03:10.8846
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f93b2d1-9699-4ef2-8abf-08dceeb46f5c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A348.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5872

Core layer is modified to call domain_alloc_user() to allocate PASID
capable domain. Enhance arm_smmu_domain_alloc_user() to allocate
PASID capable domain based on the 'flags' parameter.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 737c5b882355..4d4af11c5fda 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -3088,6 +3088,9 @@ arm_smmu_domain_alloc_user(struct device *dev, u32 flags,
 	struct arm_smmu_domain *smmu_domain;
 	int ret;
 
+	if (flags & IOMMU_HWPT_ALLOC_PASID)
+		return arm_smmu_domain_alloc_paging(dev);
+
 	if (flags & ~PAGING_FLAGS)
 		return ERR_PTR(-EOPNOTSUPP);
 	if (parent || user_data)
-- 
2.31.1

