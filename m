Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2068.outbound.protection.outlook.com [40.107.244.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56424184532
	for <iommu@lists.linux.dev>; Wed, 11 Sep 2024 10:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726050099; cv=fail; b=bRBScZaMx62IjbIkrq3nGdLjOygvEUgvXQBWV9KomE0f77zH/kDf5EydKcvf1UB3V6enVI2bOFqN1DtquPxFQsAvoOp03wiI/oSKLvjf7vw2h2NXr5oeL5kIs/+fP+dLhWrU0BCx1RCo/gGxVnYP8ryJGiAOaTGOfvmERAQlb00=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726050099; c=relaxed/simple;
	bh=p6AiADil7rCIPMB3Ked3uJrhpz3wj3EbUyvviE5d1To=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aEaZwceb/3jeWnAZgT/8JBfNv8U0AVw3n7yBLpuY3FGM9cmx5ASbofiI/kgjxUkd3I/dmQh7ayCXxZAeAYKLhyUVdCzhFdbuqdvsHI/8gDA28sMI2eErNXS3+X5CLTncK7LdO7LMS6+oE3YwuJ8FVx6SRcMEfAjlBRnD0oQ8mUI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KAmW08m0; arc=fail smtp.client-ip=40.107.244.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KAmW08m0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yflK1Ht3iouNj4Rsm05cDAU4p9DV4RBBouKfiFNTn9beCJCnlFCPle58IfTB1nYDpNSBJHfTI1Qp9GUhnp1E1hVQQ4MaZPwvoSyjFVE5ZHGev+AxGCk/I6IC2cvyuj1l+XZRILZjhX4cEyB286u5hu4lcG6FLSe7E92BMedbEPHnGxUwp6gKrwdyGmi4uu0Y9ep8VcnmJFbnhHAovD5q0SbrxwXGGQDRO+nrSnDROb7QszgXDnzGRm73aXtWzoieEz5jLHUqHRq+wcpKwaCr11397kG/xxR+RXlQuEpj0P872+5ctcohw9jhpk5gD+H7P708c/e5h+RtkhYOZe6qMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=03/0a+BUSbNvsvXXX6ONKGpItVaIXtj7pqqd4gEb40I=;
 b=szkjXHqdQDhwUXTTy2W6XMmDmR8V4UfT2i6Vz2paJijxuW5r64Uxi44ZYU26K+eSdMyCiI+6TSbGdp/2EdsXHxTlevgt8yp+dEbV51o+1rwBB5CtOzk0eYaADaldeagoPqmX55H7A7mM6CdON6XTK1Qf6T0ijJ/if6C076WGRRxM8MybWzDU3fhLLlZfxo6O4IWLcx8eUL2mJ1d8SW9Y8K63/BZQtqjlQzSqgdDIAFk2PTvrXoVugWsLQk6iNpa/jO3upzvYfThCwKAxeX2luDuk0l73TeD8MuubSQgdKKBr8md6o34cR0P3Olzk9vWhJQP09c4ieAgswkhMNydnHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=03/0a+BUSbNvsvXXX6ONKGpItVaIXtj7pqqd4gEb40I=;
 b=KAmW08m0s9H9H1ApMZFRAes1Sch5BG8RBquJQFkCfObynKqbKxWt8cYYHnkRY8mYwrEfXWLiT3o9XHr7+WLRAuOraygD0gi+SKMmARw8MCod6Oi+lYRPkeyGbUO9jygss5THTz2m9pkcJ/ruMSrqwn8OJvVgkM4dM2yamvjjqzg=
Received: from CH2PR05CA0062.namprd05.prod.outlook.com (2603:10b6:610:38::39)
 by MW4PR12MB6780.namprd12.prod.outlook.com (2603:10b6:303:20e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.25; Wed, 11 Sep
 2024 10:21:35 +0000
Received: from CH2PEPF0000013E.namprd02.prod.outlook.com
 (2603:10b6:610:38:cafe::73) by CH2PR05CA0062.outlook.office365.com
 (2603:10b6:610:38::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24 via Frontend
 Transport; Wed, 11 Sep 2024 10:21:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000013E.mail.protection.outlook.com (10.167.244.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Wed, 11 Sep 2024 10:21:35 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 11 Sep
 2024 05:21:30 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, <jgg@ziepe.ca>, <yi.l.liu@intel.com>,
	<baolu.lu@linux.intel.com>, <kevin.tian@intel.com>,
	<jacob.pan@linux.microsoft.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v2 6/8] iommu/amd: Enhance domain_alloc_user() to allocate PASID capable domain
Date: Wed, 11 Sep 2024 10:19:09 +0000
Message-ID: <20240911101911.6269-7-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240911101911.6269-1-vasant.hegde@amd.com>
References: <20240911101911.6269-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013E:EE_|MW4PR12MB6780:EE_
X-MS-Office365-Filtering-Correlation-Id: 017a3450-acfa-4c8b-4f69-08dcd24b839c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XZGqxSWPx/M8A7DBPvxgLe1kZkSBAKQtPmTwsALeXrNBTpzug2N61kSoBotX?=
 =?us-ascii?Q?kUFrdN5/uY21RIuEDj4AWcvVCTElPkbHAXag3ESNIRByFYrOTAU9ia3oQYrD?=
 =?us-ascii?Q?lEbT+Z77t5+gZNAWI4I3bmSpgCRIBXJrR9HS0Xd6L/u+n+kXS+6zNVhkWsTR?=
 =?us-ascii?Q?bklRbWr+IPTod4f68bROLp/B3S43b2DuhlSjl6V80rgCzcZA4YLDUT2VPIXR?=
 =?us-ascii?Q?6PWb6JKawaKI2kjor1/+Nivv0iNEfFceMwQjrTix5sTfHkDi2mT86hbaWGh0?=
 =?us-ascii?Q?PLhhiVUJuTrizICPUiZj8Q/IwHvHhPTFUbPQ233Oh5zdxHzSZcqGW4wW1Zk9?=
 =?us-ascii?Q?JePOYA+WyREBxYKixY5obuN8/aHTEAjIkhn3eh3Qdp+wYYhKpES65WXb0nh4?=
 =?us-ascii?Q?qU/J0V6G4wvwMJZKDg8bUSGJSFXn8SbLg2ggTWLn+p02fn8gdPB1hEIIZH9w?=
 =?us-ascii?Q?Dry/qHyEvSpDl1vqKpBh8yOdNdxANW6QpCO0S7Igvdsi2Zu9UvfldTmO4LXv?=
 =?us-ascii?Q?OUqwpYlwTURqrHQFem2XEtM9vrvugaoLEv/Jt6GpqSUbE3I9KtTBSpgc9zDd?=
 =?us-ascii?Q?qZvpxqvklj56fCkKa2FsLuX4hEdSAK0uhQs7D90TgXaDwHwloQQGxdQecAH9?=
 =?us-ascii?Q?rVD0316chtdrzN+zEO6qUrVcQAKeqMfUpxOvRPicZ81OibDgUTuSoBn2ejrT?=
 =?us-ascii?Q?JfnQaTGqSRELSmu8alRA6x1F0PvCm4fiBBBDk2MBMw5Nsuf9hVjZh91oVRce?=
 =?us-ascii?Q?LDm+B0ofWp2K67vx+23O2yv5gnsKEdfCp1YtVhFswEJWrPBtH0JLZIH7UY9F?=
 =?us-ascii?Q?ma7MbCZRlN3c6GHZXce7h5DbhpNJa3bZdBpx4w8m7Z1cjbKyVm34yj8NaXeJ?=
 =?us-ascii?Q?eMpxRfmZOfluZSR1Lvg848gOE9YyPJ/ABwuZv+low6MFgOvLUS3LrEZy2kHN?=
 =?us-ascii?Q?kjp93sKYO5csj3+4cl3AAmMr3TZpklgtdItUXdcZQnsanrKGKPqE+8Zdu8av?=
 =?us-ascii?Q?Lxe/7n87gllO0g1k0Zknk1OTGZjH+CKze/Z+Ch7u6hRSsX2D/UnhlqGEHL2N?=
 =?us-ascii?Q?qedMIVYi5kjC42GpbDFjmZpCjWCGWPdWFDrkrF44w7f69tmD6KZTZM9KXQQ4?=
 =?us-ascii?Q?CNj5ZopZX/4VlaK7GPtY/FrbEInsKwZofJb4M8nmyMDn6ZC+9mHsCQ2E4Zsp?=
 =?us-ascii?Q?E8YNSbpURvrS2sE5EdB+OL/S0BjEU8hy56jpuxRanwYqqKxuNV4SLnwxmB54?=
 =?us-ascii?Q?zEw4U9qJrwLoJP96hwycXy/oifJhL1/iOcIk3IUw/N9a02IMURAKfPBWVrYO?=
 =?us-ascii?Q?+50D/L6/DYvUKnWpJfxiTDpeMWySyhxZ/AMKx8bw+k2PidHaj9021DEbts1I?=
 =?us-ascii?Q?aEuGj6YDX7jyqoNmpq0VAt2rZzSK7XIVZM62s5rEKMyOPu9SNfDiEuuF/4ke?=
 =?us-ascii?Q?IKYdC9v4Ik/XZpqfkrYbuj/QmCfE8QRp?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2024 10:21:35.1269
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 017a3450-acfa-4c8b-4f69-08dcd24b839c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000013E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6780

Allocate domain with v2 page table if IOMMU_HWPT_ALLOC_PASID flag is
passed to ops->domain_alloc_user().

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/iommu.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index cfeb3202ceee..1c9e539f15a7 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2401,12 +2401,23 @@ amd_iommu_domain_alloc_user(struct device *dev, u32 flags,
 			    const struct iommu_user_data *user_data)
 
 {
+	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
 	unsigned int type = IOMMU_DOMAIN_UNMANAGED;
+	int pgtable = AMD_IOMMU_V1;
 
 	if ((flags & ~IOMMU_HWPT_ALLOC_DIRTY_TRACKING) || parent || user_data)
 		return ERR_PTR(-EOPNOTSUPP);
 
-	return do_iommu_domain_alloc(type, dev, flags, AMD_IOMMU_V1);
+	/* Allocate v2 page table if IOMMU and device supports PASID. */
+	if (flags & IOMMU_HWPT_ALLOC_PASID) {
+		if (!amd_iommu_pasid_supported() ||
+		    !pdev_pasid_supported(dev_data))
+			return ERR_PTR(-EINVAL);
+
+		pgtable = AMD_IOMMU_V2;
+	}
+
+	return do_iommu_domain_alloc(type, dev, flags, pgtable);
 }
 
 void amd_iommu_domain_free(struct iommu_domain *dom)
-- 
2.31.1

