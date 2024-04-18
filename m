Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2045.outbound.protection.outlook.com [40.107.236.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45078821
	for <iommu@lists.linux.dev>; Thu, 18 Apr 2024 10:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713436513; cv=fail; b=aEJ6OD5tfNMd21U7nerl8xKqs10RdK5+hJtNG+Arr+wDN7j0D2+cmE2f8GNoFUof5Vy6tavg3p8wI69cA7BvJhS86BLaXTjHBhWBzyh8BLjzHjO7MbheTQV/8CxMiA97GEEv0KoRwm+Rjf/xNy1qZtg41Wtz1LxzY/iWqFEbCPY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713436513; c=relaxed/simple;
	bh=S5o1GZxuujNTkimdDN2u3OAVZh8P8Oq78fniD6F0/9s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OQ5nfrLTM2C89WvX+pokY6wn69Iv5D0QsC47lgkqDinx0kMZvSfZPTTzfhxQa9bDMckYHQ+wDbioSrXTsPM1c7jcolwTNTvxfNNmQbOfNkah2IN+gsfMaKyqBshkt+OqYsi0WmzlJf4vrd5t0uTgiu/dnUPfP1TPLxarxGowcSg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=q5g0nlxg; arc=fail smtp.client-ip=40.107.236.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="q5g0nlxg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cXAzQvQPtEUUl65zDT7i5FfikB07GTXeMz+4Dv2XSCwx2M7zCQ5H0vJA9aWICKCjmK0M6rdEQJhkAdn9yaypv0ZRsBIVOEF2wTUl4wMzsyiq9OGouszC4TS6eVO98iSZX8rMEN8Ehek0/YnWZes2Qkid04jdboqcggdjt9zFGt6eTXmrPwXB+CORuRPqrNYfLDCN6KEZAyEGDFnPcIyBrUboEgbmXOs1x0xtFxyda4oXHfYiqcVgyv6TDt/N4LPlyx/Ymx8DixwnyI4N1tf56dmNo9FfANzD8dGzFe/zOMxyKXR0KoAoPyIqUuJ2KJXG2v5t9mpWfdNnsE+hq1K9zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dl+0Oy+4m90XaaFucQ/DO6skzyjpLD8XHiq/JzLTFCs=;
 b=GydkQgmB+4U1qsT9+r7mTqTbdVsjM1GhxM9GVa/D9fQjAAWHCZNiPh+qvjxVLfWl9T9m4IULo4uzwghRkmG8DK8veFjYp8ckbAhs/u1/binltM2jNGVK7Dcl0fKXyxmdXC3VFjkNixCa7uG9isxzMSHYx493tb5Jw279hFo2Ztizgg7q5cNLZCS9rS3vepd5AMBj22QzpR6tjCmnIf1M/8IjIN042SnRBZyPO/cmt7Tp+TP69SdSDwTPo2y0CAFKIBXePTs1uIVfrVjGUARzxXCU035QGDg6+RxNWbHMsrFgXngfZo0SW+q1l480uoyhzQjidvliM3pYZFXCESwyZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dl+0Oy+4m90XaaFucQ/DO6skzyjpLD8XHiq/JzLTFCs=;
 b=q5g0nlxgU3t+yYZCCE8lUrwXsaATRBl7CqN0AfqBrZTrhEb1ov8fBrZ5p0OffSG3skdiI/b4gbGfxYhiM1ar8AZJija8WwLB9uyl+apljPNZdrHcO/ww6mM314Jr+BrHgaLxrbQU6w+TY7cs9+nxxYyqGxz6JWN+RosdTk0GEF0=
Received: from DM6PR08CA0015.namprd08.prod.outlook.com (2603:10b6:5:80::28) by
 SN7PR12MB7156.namprd12.prod.outlook.com (2603:10b6:806:2a7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.55; Thu, 18 Apr
 2024 10:35:09 +0000
Received: from DS2PEPF00003446.namprd04.prod.outlook.com
 (2603:10b6:5:80:cafe::20) by DM6PR08CA0015.outlook.office365.com
 (2603:10b6:5:80::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.28 via Frontend
 Transport; Thu, 18 Apr 2024 10:35:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003446.mail.protection.outlook.com (10.167.17.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Thu, 18 Apr 2024 10:35:09 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 18 Apr
 2024 05:35:06 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v8 03/15] iommu/amd: Add support for enabling/disabling IOMMU features
Date: Thu, 18 Apr 2024 10:33:48 +0000
Message-ID: <20240418103400.6229-4-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240418103400.6229-1-vasant.hegde@amd.com>
References: <20240418103400.6229-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003446:EE_|SN7PR12MB7156:EE_
X-MS-Office365-Filtering-Correlation-Id: d81fb9d8-9904-47d4-6d5e-08dc5f933888
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	49nvkjcITF0q9FAnTSN987CqABtrq168PS8ljaenCoMPdJ1Wp+3rRVHz/RCTUWrxRVCVr0/fInDzqJx/WVCCLkLZttkiIrsBevSh1lJ4BIsXs/6Dr+trabGdIN2RpCas+XLAaWVJpIDEd49JYKa0Y0mgcOKE54Pj2SxwybMPWR9an1IPKYJsyYETJyOPN0bEMkSccWG1xWc4Ag10OYqZq5TMP+2+HH811xqfW2U7q2WleiU9fZky7h4Gssi+WDSKmMLk2UlV2vrCJ2u5BUFGAObmVBF3aGhH1CR6qchsDdx06OfbShrtpaXShlqZBrCDV0Wo31tHIFXqSw3d2yCrgqO6wyFDoRclmm3c9CwdQniJVM6GztJcIJEE8V0A76b6HEDljrj6zUlDl4dnGHgmKR4nd6EP3fFOnQNiJBjBlPhZbrHk3QMwegfzVx8kIj7GzC2xthqnkVu4l8lfR/KoHImZ2dbg2zdcg/9Kp+/yYNlWb+G8FJ+pQxr1X3koQ+VJmleyDzvQ18i8JhssSv4geTrzp+We8YPedAXqn38bugcCkR8vaVeZGnBqzzaqxtkixJeqor9YzRprdf/XvuQg6Y06/0sQtBMJ3yzycMXMeAVh87xXNk/HntlyqopOX3EfLDBTa6VoCnuwmdsDmcoOOUiD057nvar9MtjO+ipkZ6EWDZtfe1dxMDNAzoiXSgiTSuJmIEXef8lIXCRZcQk4XoJGYdS0b+VZ7kssEDzKPZZhbsP2QoBpx2qI6StHktIx
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(376005)(82310400014)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 10:35:09.2282
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d81fb9d8-9904-47d4-6d5e-08dc5f933888
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003446.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7156

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
index 394623abbaa4..a22ecd8479db 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2791,6 +2791,32 @@ static const struct iommu_dirty_ops amd_dirty_ops = {
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
@@ -2803,6 +2829,8 @@ const struct iommu_ops amd_iommu_ops = {
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

