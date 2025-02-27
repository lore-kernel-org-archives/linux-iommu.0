Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2055.outbound.protection.outlook.com [40.107.212.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177331B0424
	for <iommu@lists.linux.dev>; Thu, 27 Feb 2025 16:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740673985; cv=fail; b=IL3IqN/ABZWYFr7VBNB5FYviER/y8/SdRmt4wq92pFTVpEfwASif7z2Blcy7C6OYGAcwZqGnQOizO1hidDjtAJyeTPo4kOQRuBB/k9X8lpK5dFFJpIQthpj1Wp6aZnxwMjmBqqwme8g9st34BQgWlPfh5O7AxVWspe8Itog9Tb8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740673985; c=relaxed/simple;
	bh=aRWGxSXrjiRh13hF3HYcVsr409Cw1dWTbyLoKawZoyY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SlsX74MhBVOfz7iBjgpgiwqZO0Be/sUj5H+JTK9ZQFZsOi+iVdDB8IYg+iYHc5V4a9bx3d8GZfSMUTO9eE6Spyos15ycJebXaskXVBAABIrlT0Sj/Z8wG/5NaViUHxTcxxgKIbyoExiTxms6bJIzTgKsvrvkpAHoM18XArIdw2o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UX5JupM8; arc=fail smtp.client-ip=40.107.212.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UX5JupM8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zUWcfLXdB/b7J9elJrVtnSd9JeO+V7cAZ6LmyXxAgoEToac3YPs6eBJ0jkD6CiILNSHI3oz3uzvQXGWGkAl/dbyjGFX0epzyg4s3XB8bhE8paoT9ZQPwbalB2v1h+DiXXmWtbEkR5LczkdhW8J1S9/N7ke2mRMF+x/3iMVWO8rDvB44R10iovM3fyTFSUfRQhzIawZsSvtAlZy/LSXWQbCvjf0llztBGixusN+xnhfskxzN0MOp8IS+g4RZgvYyYUhpwYS0ayX8uXumyct4eDNlLN3CELPzqHbtai5Lou6asa22TGtpfdWMAq4nKhS2cun0BsAaZ69kYqF9LvH2+zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xl4b0f1EWoib8nhZfJr8TtyYqX62l126HIhc5IgzXqk=;
 b=OygZlMoiaNF1fQzh7djNK/kiD/063WXeMYSZVstc0xuINkY7LJ7Sk17JOdLs6AZQmcHL72ieJzxXbs+Jd7AL8nYpN603aWM5/9lknupoVUVSRY+1FMwhEZFptrw/6hET5fU7976o+cLB7ytEGlSM0ofwk2QETZXMMaWpWREoT55FdUnc1boKuYXIgJo5zMhmtWg64yuoRHBa3dFgYrTmEAFnm56eaBwWFet+iMw/K7ZAAIWC+7iqVRwBSaCkaUltH+XknI6gBOd85F2yGuQk9ZQ6Ae+/zxdaonMcMphWCtPJCnj6N5CFgiRx4O1MMRwcqne27GOIjbbXB+zGQHTChw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xl4b0f1EWoib8nhZfJr8TtyYqX62l126HIhc5IgzXqk=;
 b=UX5JupM8pde5KOax+jBIkUNU7qYcoUZJdgYaKCraiPoqOer6HOEHrQtDvMaozm1IeJ2eZE3DvmkfI9uAROMNEcW6hSFiI4LxcKOA7RQaqthZqQKw6XBbc6BvdmqDpHGrNnWVH7PaFvfzqrIjYV9kTc5AWxxLQ+vkd/M/sxrnEyw=
Received: from BL1PR13CA0436.namprd13.prod.outlook.com (2603:10b6:208:2c3::21)
 by SA1PR12MB9516.namprd12.prod.outlook.com (2603:10b6:806:45b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.18; Thu, 27 Feb
 2025 16:33:00 +0000
Received: from BL02EPF0002992D.namprd02.prod.outlook.com
 (2603:10b6:208:2c3:cafe::1e) by BL1PR13CA0436.outlook.office365.com
 (2603:10b6:208:2c3::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.10 via Frontend Transport; Thu,
 27 Feb 2025 16:33:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0002992D.mail.protection.outlook.com (10.167.249.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Thu, 27 Feb 2025 16:33:00 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 27 Feb
 2025 10:32:29 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, <jgg@nvidia.com>, Vasant Hegde
	<vasant.hegde@amd.com>
Subject: [PATCH v2 5/7] iommu/amd: Fix header file
Date: Thu, 27 Feb 2025 16:23:18 +0000
Message-ID: <20250227162320.5805-6-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250227162320.5805-1-vasant.hegde@amd.com>
References: <20250227162320.5805-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0002992D:EE_|SA1PR12MB9516:EE_
X-MS-Office365-Filtering-Correlation-Id: c7632f80-bda0-4046-6be5-08dd574c6647
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+meJHb1TXTOfn0pnzzYDjdOiVOljxZjjqf+Mg2EYL2knUEThpJNcKh5aIGvx?=
 =?us-ascii?Q?2Il+mCo3liaY9V2G6nyJTQrGHMeTETCvlnk13+xIr5I61Wji8y+RRCUEz61v?=
 =?us-ascii?Q?IjqafHy1rF7/Y+H7IkUVaTAtMrNXcGV/Uop804MTRaHS+ryivim7uA4V/u9T?=
 =?us-ascii?Q?75kfZ7xRJJ+mf6k8+/bVXUYobLe0Kkc9ESGi88rDo368aeElH1/7sfeOPO+W?=
 =?us-ascii?Q?LwUvfrSlbJ7u2DNqT1HgAlls4Q2EmpmRcYyn3g6+nqwDA6SUFR5wo7pFLs49?=
 =?us-ascii?Q?t0lBFIMBl0b/2iDbbrqI4urIqirVctS2giaqhiXC+MEIVYFWRCbsSw9wqzol?=
 =?us-ascii?Q?Qe2sJ6iO0VRTQUdOMx+SJaHGzZlZNpiTseMRT8kyV/w5xY5jiUn2QRhRDVRy?=
 =?us-ascii?Q?FqC112VgjWNvrj1C+eXbhumKzRz1EzyqZxwDDWw3kGhWT73QHqk6/8mUBf5T?=
 =?us-ascii?Q?kcXs/G3omjUDZSSPp+BuM/M/2AyE6lRCke3NhxxkLoz4lTniJbr1K2Bzxtm8?=
 =?us-ascii?Q?CVH7LYK52q2ElmZD6mUJPP54/Kzi/7+LtisYDJ0OUsESJQymrkNiufJtNp2K?=
 =?us-ascii?Q?qO4DAyRpksjKJ4v99X4d5aYFi7yPuP9ENu+dlOuC5rw/EteW8KMkqBTrWA7L?=
 =?us-ascii?Q?9WKBe2uIThe4YWF4kNngQRmPWa3Pz5K/AwnNvfI0B/V608nF8Kmjt/4uM8Zl?=
 =?us-ascii?Q?R24waNqf0svDcgE11kA0dCkp9effzx8KZ3Bi8DXVyjtOhYDQi5V8j9RALVCu?=
 =?us-ascii?Q?F/0i5QgA4996MOFjGOBPS2J+/XEEQaO/jUa3p2McyAsTCSW7zIZhyH14wF8M?=
 =?us-ascii?Q?ILHx4ac3V2/8EwyejScq/WyNZk9E0CzERj4pIiXPeXhNJvMgziv95aaW3hxh?=
 =?us-ascii?Q?XTLEdlOoAnzarYfBfEhmhcp7g0jbsYmGXkofnwrhftSmRSAUUvNdXYMh+0rB?=
 =?us-ascii?Q?ROpTejKJtLBzj5Cl/IHJXOPdps5CcGYpZk7MH1XjyBye/0I07s+KakHtENae?=
 =?us-ascii?Q?SVFQdLkioENgPdBiqZ3XOUNtDFg7NrGtwi06AAfcRfSEv2gCjwnMKZ9/2rVv?=
 =?us-ascii?Q?aEjBjASFBSSB7CzxVh/AALJdfoePHW6fo1EkwB47Dm6iA/YuVP3qZ4JpguCg?=
 =?us-ascii?Q?qA9V997n8XGohsd4zP/ZCKBXiv9nuowx6tp8qjRWL2W+0P2R1QkPJDaiXRA6?=
 =?us-ascii?Q?54hKLlZBhQqV2vsuPqVuNMtrDGLEo2MLnmu1ijWRZlCRJzhzFrNHKh2TI9P1?=
 =?us-ascii?Q?zw/rt9D2LjEx6c22i0RoNLTuszrTz2uj8KqCMQlVGegxCgynorzUxTuX9Gss?=
 =?us-ascii?Q?p97YTQUZwM8maNcNx/5SVA5haRl47wpKv8Hbqa2Qt/nxfVkprKcU2J0nrR6L?=
 =?us-ascii?Q?ho5+l+f1rbkr5u14EKTiSEP6zJhSLJarhe12uTKdvQMW4NrRxcEnDmgc6RVy?=
 =?us-ascii?Q?+KzSJHZFE+weAe69guRWd2TZnOvABvRNmXFB9ADZmmzhqry0gOxhjbS7vS3t?=
 =?us-ascii?Q?opLsMPadgYDH7/A=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 16:33:00.1253
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c7632f80-bda0-4046-6be5-08dd574c6647
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0002992D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9516

Move function declaration inside AMD_IOMMU_H defination.

Fixes: fd5dff9de4be ("iommu/amd: Modify set_dte_entry() to use 256-bit DTE helpers")
Fixes: 457da5764668 ("iommu/amd: Lock DTE before updating the entry with WRITE_ONCE()")
Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/amd/amd_iommu.h | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 68debf5ee2d7..e3bf27da1339 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -176,12 +176,11 @@ void amd_iommu_apply_ivrs_quirks(void);
 #else
 static inline void amd_iommu_apply_ivrs_quirks(void) { }
 #endif
+struct dev_table_entry *amd_iommu_get_ivhd_dte_flags(u16 segid, u16 devid);
 
 void amd_iommu_domain_set_pgtable(struct protection_domain *domain,
 				  u64 *root, int mode);
 struct dev_table_entry *get_dev_table(struct amd_iommu *iommu);
-
-#endif
-
-struct dev_table_entry *amd_iommu_get_ivhd_dte_flags(u16 segid, u16 devid);
 struct iommu_dev_data *search_dev_data(struct amd_iommu *iommu, u16 devid);
+
+#endif /* AMD_IOMMU_H */
-- 
2.31.1

