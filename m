Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2069.outbound.protection.outlook.com [40.107.94.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919981DE3BC
	for <iommu@lists.linux.dev>; Thu, 17 Oct 2024 14:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729173883; cv=fail; b=ZRrutGsmGYOJdyFWYrOA0OD9Bb2syAnMFUIqXMmZKIr9b3kEuVaFJWi1dOLlT/qKJ5rtJU5lZFv674dkBGr9x7P3XJdVM3UmqswCMBoMjDRKI3OWxPjexSbydguJI3+sFdNkDM7cGMa4hi6eGacC+gT1jzP2dg+66Tl+X6aN29U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729173883; c=relaxed/simple;
	bh=ebsaQUAydXy/uw1uC6Q8hAvgS5xbja5Us2jt9feZ5VI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TRNJ4O9b2jngbGl4ngwFfcB+lGj1pt9QPLrlKgWAbxOi4EswyrQXPtIwsJ7HQYaxzFeuYDzVe7QlHsaLjODXzlo/t2+BwOEUKW/kVHO0f17oV9SV7vQO2wiHO2Q/TocjbBJdQacIe72+yfajwKaq0LQsYdaHlUf5yxVDasvu5d8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=r6wr8T9n; arc=fail smtp.client-ip=40.107.94.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="r6wr8T9n"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tgaldP9tqV8g3biU4r50VuyJb6L1a6jbAYfTT5mXWRvKZZ7bzhybJAbKU9Eg1ZvfW+6cpK1QvaCrBpO0n1r5hE4NO+4UufArWP6ckbNP63b+wJSrYVW29IomAQW95W3uTQcRxgJwsFpvOpcE+P0K397N7z+VDtAys255hEdTkcw2j+wKcIqYPfMKC+Owd7LLZLA0/scUAjYVM0odDnOtIPDs2cVzvCMxOWbpnZgqglXZDjiQUViWQ+3n0V99Pesj50Ls5SESb+WNuYLRfpfNZ4O2YVG5A6By14yuSiCkIPDqbC4OCjCP1P3tfqcVr3Ejv/uOUgOCn+5C8XF9J5JS2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BrQu5P/bHtHZDY3NjU3b8CG1uk59HcWm9DFdpW0plRc=;
 b=gAWdu5lbLG2mgti3CtelEaoKQChNmgwmVJksTCCmUe67JcSfuHgTFJVPt0dWBKY1V/z9bg4hJVSrEYydd5YqDciyo0ngVToiVWc93p8gMJg0qTllDLa50DQwmkEaTwUlpiB/FZZyhXsNvZihh856x7WdLmR4wfGwU4Kx1NrDPFzHQgPrkNSXW7YYmGSxanZzTvommeTGzWSsY3J6v+yDGfJ7aHgCFLvie89GnIGEcjVwinv0cg40NZAdowB2ow+tSLtjY/g9ZAsnwJMmHKcBVBSXB1LIq+2dubK267nHz1pqLoe+l1WAsoTpVREvLWFsB4jdzvAMLk1UrCbJM/0JfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BrQu5P/bHtHZDY3NjU3b8CG1uk59HcWm9DFdpW0plRc=;
 b=r6wr8T9nCLKVtIohpN4zCn3uanCCcoCpjOiQDNiyUnuviEDeODVZcECvkORRxNH8LTsjQ8X5kwFFecLZEejdO/KHE3mjV1wf9WdUWEuRF9I/SrFOPhu80fg3zgPUJ4OOVXL89D82HYQApMbIDuuQIum5/Tu/0y4EV7o7S3O8m38=
Received: from CH0PR03CA0288.namprd03.prod.outlook.com (2603:10b6:610:e6::23)
 by DS0PR12MB7704.namprd12.prod.outlook.com (2603:10b6:8:138::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Thu, 17 Oct
 2024 14:04:31 +0000
Received: from CH1PEPF0000A345.namprd04.prod.outlook.com
 (2603:10b6:610:e6:cafe::12) by CH0PR03CA0288.outlook.office365.com
 (2603:10b6:610:e6::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.19 via Frontend
 Transport; Thu, 17 Oct 2024 14:04:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A345.mail.protection.outlook.com (10.167.244.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Thu, 17 Oct 2024 14:04:31 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Oct
 2024 09:04:28 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, <jgg@ziepe.ca>, <yi.l.liu@intel.com>,
	<baolu.lu@linux.intel.com>, <kevin.tian@intel.com>,
	<jacob.pan@linux.microsoft.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v3 09/12] iommu/amd: Enhance amd_iommu_domain_alloc_user()
Date: Thu, 17 Oct 2024 14:01:34 +0000
Message-ID: <20241017140137.6028-10-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A345:EE_|DS0PR12MB7704:EE_
X-MS-Office365-Filtering-Correlation-Id: f3a5ce86-6235-43f3-a7bc-08dceeb49f7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aBlUvrmSu3Ptshi1CUEgASqLvLmyccz9ARuKkKfSjzX9gJHFYQ8O6XEmZKY0?=
 =?us-ascii?Q?t+PHUS79B5MwLKWPYaNXD8cV5z9dAf0v7f5AYnKjxGpn4AH8Ax2k/2+fCPyT?=
 =?us-ascii?Q?9TmbsoriUvqdEmdJaQnXgOMQHMLlCnOqZ2JvokWl/FbPSzkVoUlHHragtQYZ?=
 =?us-ascii?Q?WPNDPGX0vhP3yNQMkKFDQ3rQEvRI9Oo7L0ZLvXB6t5tSVWZjoD0Pndkh6C9I?=
 =?us-ascii?Q?Hiy4TICeH1J9yPNy8VhjGJTwa5ANYtcr757FL6A0BqvC3OwFQ6o18WjDJWso?=
 =?us-ascii?Q?gYIAjRcW7da2uI9ZB4u8HexqXhSqDbNTldXRmk2vH8OmLOQG51BWzXTsLaFR?=
 =?us-ascii?Q?HFtJ8SWwCSkJ6Fh2xhv7pWxfL736gQjbUVI5kAMBm+H9IldrYqzNG+4wlcrN?=
 =?us-ascii?Q?oZVNrOqy6r7M55XnxfpbnSCkBpCwd0mi3wCzV4aSbpmezaBUH09j0n/Fsapf?=
 =?us-ascii?Q?OsswqJ524riL0+4kN/VrUxvi6elyHU2sApotkzdz+cDK0ZHOztLi7aH37ZH3?=
 =?us-ascii?Q?LTa9gijGAfIvDOkMZnzrFB5aW9D1K2O3FWrato57cAqUBi20FLTrrZWxf4qy?=
 =?us-ascii?Q?HRSw0UxVhl2+gLGQU58v7OpwjCxI/OnWytgY2LxnzXvV9TBWXWwIyJJ02LUm?=
 =?us-ascii?Q?0ohPwTPKS6Gf6l2nTFdwnb1+ttDqI/eX5Dog/dS5XfyHXdGlPeZAbdTaDgV/?=
 =?us-ascii?Q?i1NlbFl0EW6W5m/7R+HjuRwqZ/8aHo0fGk0jU2SmJzcABNObt7FYMS9CbQUD?=
 =?us-ascii?Q?VG6fqm8bpb4aFbmIjc9+iaR2s61s3Lw2JcQavTRO9IyqZ3hV4jXoFYrGazIR?=
 =?us-ascii?Q?U8LtkAjLC2h9pS/yo9TIN/bv0TwGW3j8i80i9gXi9YSAM0T/DcPUheSKahuq?=
 =?us-ascii?Q?YREfREdFzbr6g6OVEozmhdMtH0t8ETD9vbzagsw9Ckzrx5bbbbPHAqnGn1P2?=
 =?us-ascii?Q?AZGUqIV4SmTm+QAsSEmxRVBugsW00BvPXRd/vbBgyZVYXRnEGYNeasGBY8UR?=
 =?us-ascii?Q?5lM7ugUBYZqSt5k+QGDisKtSm/dQ/TL4HpS88tLlN01wqClG++ghGERQ33Ce?=
 =?us-ascii?Q?jZoSzR42YUYn/WOcXyMPhb/6VxUNpeiEnWIXd8h4nxKtPBe8jFIssKbT1MNG?=
 =?us-ascii?Q?WsCCPXz+Y3vptC/IR0NbkoO/y8wiE9bdvJClLaiLRE/Kn/uZJII28+sb7zWg?=
 =?us-ascii?Q?RraKEwDcjikbXwQ3r4RSKaw+XLSP1oeQrbzhzhT9/ZwnLR5sC6FG8pxjdO/4?=
 =?us-ascii?Q?cd6c2HYqlGwYxLbsvTtqr+rsXQQsozWhEpXrBaynQaOfKv0+SIoGkwR/SgpQ?=
 =?us-ascii?Q?iERGv2h9Fc0sblRSaJoLkvbeQea3OBcebZiIok/XENNDW/OqOg+cjI7bpdMF?=
 =?us-ascii?Q?TWa7P3XFLuDsH64oNlCC7iGidzw9lyURkWSQNtl9atjcugWPaQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 14:04:31.6035
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f3a5ce86-6235-43f3-a7bc-08dceeb49f7b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A345.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7704

Previous patch enhanced core layer to check device PASID capability and
pass right flags to ops->domain_alloc_user().

Enhance amd_iommu_domain_alloc_user() to allocate domain with
appropriate page table based on flags parameter.
  - If flag is empty then allocate domain with default page table type.
    This will eventually replace ops->domain_alloc().
    For UNMANAGED domain, core will call this interface with flags=0. So
    AMD driver will continue to allocate V1 page table.

  - If IOMMU_HWPT_ALLOC_PASID flag is passed then allocate domain with v2
    page table.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/iommu.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index cb6a72564c23..87eff85c0c23 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2404,6 +2404,20 @@ amd_iommu_domain_alloc_user(struct device *dev, u32 flags,
 {
 	unsigned int type = IOMMU_DOMAIN_UNMANAGED;
 
+	/* Allocate domain with default page table */
+	if (!flags) {
+		return do_iommu_domain_alloc(IOMMU_DOMAIN_DMA,
+					     dev, 0, amd_iommu_pgtable);
+	}
+
+	/* Allocate domain with v2 page table if IOMMU supports PASID. */
+	if (flags & IOMMU_HWPT_ALLOC_PASID) {
+		if (!amd_iommu_pasid_supported())
+			return ERR_PTR(-EINVAL);
+
+		return do_iommu_domain_alloc(type, dev, flags, AMD_IOMMU_V2);
+	}
+
 	if ((flags & ~IOMMU_HWPT_ALLOC_DIRTY_TRACKING) || parent || user_data)
 		return ERR_PTR(-EOPNOTSUPP);
 
-- 
2.31.1

