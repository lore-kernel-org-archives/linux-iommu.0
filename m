Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2073.outbound.protection.outlook.com [40.107.93.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014A012B81
	for <iommu@lists.linux.dev>; Mon, 11 Mar 2024 09:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710148202; cv=fail; b=rDApHA64a46asTNPkUYzOouw2d22t2dFJfCepKUHrOQm3PCFhmXowlyeqhbo2FiSnjCLpJf013oPQF1HGpVXGiOZeltV5b2RB7hJT8p6T+/1sqdTMyUfvjxR0rM9n2U3ok01/WuoPo58zglFO2AtDbp7/lcFepB/e+jgzP73L/o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710148202; c=relaxed/simple;
	bh=+EAEcPK1eb+yMItHVUsELbaFKMku4OeojtRLI2SiEOQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Osflb3TvIS9UeiWMCZytTnxlOtEeJCet8409t/QA0Zi8uG8phbYuYHvI2puesjQ41/pSCvKWoICX151smAkl+tf+LYoZY3wS/+wFUtRFzpyyBxfTKrOTVn8j6Y6eTLdiIujSRtPXtf3zvrIn4Wj6mWM88ps3y9Y2lqob6OxOmI8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=beAGxHac; arc=fail smtp.client-ip=40.107.93.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="beAGxHac"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f7a1KqeO+IctDwP0jDnOBYFyhp24SF4aXx4l1rY/O1HfO60JhkY6WLvU5tlSjqfcOo8tUvgYLzVx9EaL0HpnlQTxgfbNjUu9IieR0A8AQg7Guhjz+cu5R/6idkNnFq+RoSGAp6yMfHFKV2tfDVwAP/bjHaHA5Wz//uFjit76MyT/cABirTjVrGFuGJRDE9CkBMrwyKMY0Qb+TSsn/LJjsGra+O6+ctD8VZaA+N3CumESc4XguYxdhJNYiBpcTwnOGfoO22i6+mQD/LB1gdIxZYXkIG53/mu6S+nc79eIRs/ZPWNOZmA0MyK6FGqW6O5Pmw2ySav5iqDMjiaK8ywGsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cHSOD2E7c8iSp5GWbXdTeBVJMwIyOpIyvgYXmGNv3pI=;
 b=R9Av7teR+oKIl0Wno0q64qMA3Nf3NUeOYKfr/k7+FdYsxGJecQ362lK+J49oOOda0E5yKu5QhlNbVTbBZ6co3i44OQhAR+Hp3NQ+FgL+mZ6ecn7+CSv5h6f65L34qmVGJU9Sak0B1lWT8g4M7HP+gawtpBLIOHOqBvhMJ0nc5OU9UsgrFd9H6p7j5IIqOFgbvltvMSz8Hx3YXszlD4x4hIVeIwctVtfPgggijO+KrcpkhNhkCE0ty8cnAxLpXLbUONM1ISDIqNVW6EuPIxT2lpXaF4mi0eP6ywRUE3KwgAomH3bJ6gK4VsK+07Qc+WDDCCMbdtm4quFNRWu4fYnHTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cHSOD2E7c8iSp5GWbXdTeBVJMwIyOpIyvgYXmGNv3pI=;
 b=beAGxHacOkhs7ci6Hw2gZlsMgPyciWeRW0h44vfqk/B+scn8UL2vTvYmjiFeN7uHEx5MnIC3PbmAWrpG3KLnEnAZt/9U/R/o2VZLr9wkreUqRy+Z+J/SQyqxzeuPCiRpMLnL+g32KUuVb6kbCyS4ulQ6bk/Lj8AWMlbIqa+QnuU=
Received: from MN2PR01CA0034.prod.exchangelabs.com (2603:10b6:208:10c::47) by
 DM4PR12MB5771.namprd12.prod.outlook.com (2603:10b6:8:62::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7362.35; Mon, 11 Mar 2024 09:09:58 +0000
Received: from BL02EPF0001A101.namprd05.prod.outlook.com
 (2603:10b6:208:10c:cafe::89) by MN2PR01CA0034.outlook.office365.com
 (2603:10b6:208:10c::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36 via Frontend
 Transport; Mon, 11 Mar 2024 09:09:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A101.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.12 via Frontend Transport; Mon, 11 Mar 2024 09:09:58 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 11 Mar
 2024 04:09:55 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v7 03/15] iommu/amd: Add support for enabling/disabling IOMMU features
Date: Mon, 11 Mar 2024 09:08:31 +0000
Message-ID: <20240311090843.133455-4-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240311090843.133455-1-vasant.hegde@amd.com>
References: <20240311090843.133455-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A101:EE_|DM4PR12MB5771:EE_
X-MS-Office365-Filtering-Correlation-Id: 57d870a4-2ba9-49ff-f65b-08dc41ab0692
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	wb1El+i+VzsDUsrr9f9EDqFTwuNKBSe3KNPC9nV5CfStYSs/mlC0Du1kUrKsZt4TdOaJTQ1bK03whq0fU32avtA1RGMqihEcstjAGT+wkjF4DSCoYaAQHZPrckUYutlS5HlLDtVbaLtvKwtrPfzUHYJrrQY08JQ8Q0PBzdfARoggd+1P8Y9EJGmFOYto6xHzKLnwKwW5ToUyZvUoHR0fhaVs9SshWA0gMKDtkfJ0k2c47GsxZgfSJIO7PfXVwIVtLL/EE+WUiegJw0BLgQYDKrk/X2BAjVdv8p/NJ8AXbt7Nrg/2RQ1pMMeetU8sCpxYEBuVT4VjPY06mt3/GBj1kB/d9SydkTTayyB40qEm2DZJHYkBk57iZI0JIYgKEX/iTwWZ9702xZM4V7iHEo9Yqb2pqtWwq3xvfepCwq7ZjJY4CKW1kUmkmpqHTW5C3aqTbpWV94eRbnTEizGFTgb6ys5n22O+uoCtzFlIUL+JvWSg32NlYJ1pmrTPNRXWL6S3X1e7j5E/K8OjuOCWkEcXAi5T7gv4qCyJ01R6SJ6zPWK1oiLegQiRr/4Tx7/5axMJr/rAVAwmneADVE6GuN1SzterIamjnlugzPdSWWSdNkSJlRIDL+UdHgtwdvKYuguVsEJkrh2SLO1Q9PdEX50NuVepy9j5FHp142WxmkM3jNfZRTnzD/EmbWfpe+FbYfm3B3dsv6OFbmx6jGD/d5TjpIr1q7o554Bnp5+g5L4wO22KZIkMu3eY9nn2vWKX/u4m
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400014)(36860700004)(1800799015)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 09:09:58.4806
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57d870a4-2ba9-49ff-f65b-08dc41ab0692
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A101.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5771

From: Wei Huang <wei.huang2@amd.com>

Add support for struct iommu_ops.dev_{enable/disable}_feat. Please note
that the empty feature switches will be populated by subsequent patches.

Signed-off-by: Wei Huang <wei.huang2@amd.com>
Co-developed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/amd/iommu.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index c61a4a33f8de..e54750c676e7 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2788,6 +2788,32 @@ static const struct iommu_dirty_ops amd_dirty_ops = {
 	.read_and_clear_dirty = amd_iommu_read_and_clear_dirty,
 };
 
+static int amd_iommu_dev_enable_feature(struct device *dev,
+					enum iommu_dev_features feat)
+{
+	int ret;
+
+	switch (feat) {
+	default:
+		ret = -EINVAL;
+		break;
+	}
+	return ret;
+}
+
+static int amd_iommu_dev_disable_feature(struct device *dev,
+					 enum iommu_dev_features feat)
+{
+	int ret;
+
+	switch (feat) {
+	default:
+		ret = -EINVAL;
+		break;
+	}
+	return ret;
+}
+
 const struct iommu_ops amd_iommu_ops = {
 	.capable = amd_iommu_capable,
 	.domain_alloc = amd_iommu_domain_alloc,
@@ -2800,6 +2826,8 @@ const struct iommu_ops amd_iommu_ops = {
 	.is_attach_deferred = amd_iommu_is_attach_deferred,
 	.pgsize_bitmap	= AMD_IOMMU_PGSIZES,
 	.def_domain_type = amd_iommu_def_domain_type,
+	.dev_enable_feat = amd_iommu_dev_enable_feature,
+	.dev_disable_feat = amd_iommu_dev_disable_feature,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.attach_dev	= amd_iommu_attach_device,
 		.map_pages	= amd_iommu_map_pages,
-- 
2.31.1

