Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2046.outbound.protection.outlook.com [40.107.93.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43ABE13AC0
	for <iommu@lists.linux.dev>; Mon, 11 Mar 2024 09:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710148250; cv=fail; b=u+qvIzRTn/G140lmopdW+np1puMzfDt3tXvcXLPOCPldatfkhe7pHOlcXYus/4NDwa6d7nL759UVMcxF/gkxc74tcpdaJnsCRZA1vn5tvM5YNj4jCmqwFwIcJyhSFYitmUSejR2x3S7tgtbuGeZBamCac0MQ1UBT0ufMOBMvp5Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710148250; c=relaxed/simple;
	bh=sYgZkvST2Y0l33aYeHCURSzwzAw5By7jdzzIvzcsjQU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m/+YfC43zQqWkZFilKUmtU7/Tymy4TMtEL8DrYmDtR3/yr3NxIJ1+C/1Ht2ORfAHQhBoAzHm9CGxYNykKSZPTmGhxybYthbi8CbMl4j0wbtXUB4vfVKTSU43cqh9pGAQYnyAN1kGqOOcMpOZcI+IxyVt8YWtpuzQB2u3aeQNtiQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5dynoDNK; arc=fail smtp.client-ip=40.107.93.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5dynoDNK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iribU3h05Ug8opN30FfUp23/UXZ7yYaLIdFTuxQwvOLJWliJccFIyD/PlpXL4dvfKwBLTzuaiD5jgPyD2/CfCvF7yNGsrKVq4Z6lGwLOq5NRJOAvnnDyINg32i+0tKUSIinSXteFKgCJgM4EBoW/lgoBbORQWm/ggKGjoTooNCg5bZHoPtPajZAHx7by8G+8d44XcmTwxBFFWEcbHV4OkXtxID6gsLNVeq1M+iCdETdh1hJYQ59HNRdfCZlKiTgDFzzh5fWw/dkWjI/bXWndM9mHFqeTnG1jkunehZA8urSXbb++2BufWCNYMuydzmBY1Rvm1f28EhceyGVSkgs/ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j6mvrfG+Y9KIGpk+Jqiey/gi5zJxXFn7dxZS7O4LRPg=;
 b=GKYCjsF2KlIjOP0VylCA+fr04BgDCg02eMv4sDxOfP/ogPra9j7tKOpkSS1UlXnogYydSCTwMW4M87A56Fmy+K3QJoYK5QmTJmXg9DFrKilP8l/e9Cv0Bc4oRqpqXLg795boilI6AXc1h0y4Pr/48hLZGuKsVOdaTMlPVl9PwqmbtaFOMdQ9NyAH594eILxvK2k8sjXK0hUiv0sN9GVZ4VV34Y8fn0Fb5FRfxD52a9mLNOwjULoE3yYNmJRCwLzBazcrtbIjCnJqgVOwDbrI5gIkGwvUqXmasad0GeOL8wjR+EEwKnRPY4MTjGQqCu6Tn3U7uS4Ty8q9BUEhpfJjUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j6mvrfG+Y9KIGpk+Jqiey/gi5zJxXFn7dxZS7O4LRPg=;
 b=5dynoDNKQpLGCkZ3UUkDsV+BXKMEa2TulccQSUHIb5qoC/rgvSdtQi07gI9hdcndAHnDX0DNSX0ddSc+CUxktwNozvAe2aXyquORLjvxIsFhoFpuHbun0cuyHOqLKkSpHdFvtLYNuhN0dugijNbURrPT531aOnsI7RxPHjvNJlI=
Received: from BL0PR0102CA0064.prod.exchangelabs.com (2603:10b6:208:25::41) by
 SJ0PR12MB7081.namprd12.prod.outlook.com (2603:10b6:a03:4ae::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Mon, 11 Mar
 2024 09:10:47 +0000
Received: from BL02EPF0001A106.namprd05.prod.outlook.com
 (2603:10b6:208:25:cafe::1b) by BL0PR0102CA0064.outlook.office365.com
 (2603:10b6:208:25::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36 via Frontend
 Transport; Mon, 11 Mar 2024 09:10:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A106.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.12 via Frontend Transport; Mon, 11 Mar 2024 09:10:46 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 11 Mar
 2024 04:10:43 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v7 06/15] iommu/amd: Introduce iommu_dev_data.max_pasids
Date: Mon, 11 Mar 2024 09:08:34 +0000
Message-ID: <20240311090843.133455-7-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A106:EE_|SJ0PR12MB7081:EE_
X-MS-Office365-Filtering-Correlation-Id: 9af8b432-5ba9-488c-0af7-08dc41ab2323
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	CUqkz7t1TKSPTIGaCjHhlrIQLO4hHfPwNcCUnT2STxzKyXHj67xQjAC4v2YPiND6B61og5q6cxEnmB+FJt9rVp6yiXceu3X45FePvzC3dcr9HzCSDU/qzqpehg+wvdZRJA2tu6vT3+HhNHymPdzeaqKLTTwbaUsc+ngmliuJW2lyDR6etQHNp0ZAV/+HLh0rRUvMvhh3k5Q5HPas2C3F+HNcRs3Qc6w8JgundXfRr7T9Wjqr4pZLolZ/v5J4M50eYcpXycQqDbTMn5jHl9hqvP8Kdsj3e1dIQyVh0bF0xWbVYqBKyQvngq0c0Kqd5XH/zfCMvCPbk3LWXSqkQylwFjHK32nRgm+0MBM0yAVI1NpJJR7ggKKhXkvIayATrWVrMuxbF6L2z/MTVponBrM0OL/YkO4lr+K4i49W2jJ9TD/qfLxRDEGzN/REVaeCEc/kxf4wE75y7fQlQaQB/eoPA+BH3biJ2rJum8KXaulzJtlIfKUHTGXKBqVcSVcgRz9ubKaAkvBZHr5tb8+2h6n2uTt0smpZn4eOpqWhx3GYl4twt792hibDYGbY8CUTU0SJ2rXrBgGDBOpIvUzHGyTehpJoZ+XU19De5kwwnIPSGbMaCx5VLJaS0n2/beDlTr99fU31my+2NDzn56ZVodC8loaJOioTbCAB+el9Gs1bZEH1sDJmaDMjWllyxNtAgnmLqLc3qZcuqudzfSK0gYxUXRT369Zn1ksgySBtVijXk7AK3veu4uwMizHPSeWgRwYo
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400014)(36860700004)(1800799015)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 09:10:46.4011
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9af8b432-5ba9-488c-0af7-08dc41ab2323
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A106.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7081

This variable will track the number of PASIDs supported by the device.
If IOMMU or device doesn't support PASID then it will be zero.

This will be used while allocating GCR3 table to decide required number
of PASID table levels. Also in PASID bind path it will use this variable
to check whether device supports PASID or not.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/amd/amd_iommu_types.h |  1 +
 drivers/iommu/amd/iommu.c           | 12 ++++++++++++
 2 files changed, 13 insertions(+)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index d1fed5fc219b..03442e86ae44 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -813,6 +813,7 @@ struct iommu_dev_data {
 	struct device *dev;
 	u16 devid;			  /* PCI Device ID */
 
+	u32 max_pasids;			  /* Max supported PASIDs */
 	u32 flags;			  /* Holds AMD_IOMMU_DEVICE_FLAG_<*> */
 	int ats_qdep;
 	u8 ats_enabled  :1;		  /* ATS state */
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index cd968cc1323e..257b86495388 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2101,6 +2101,7 @@ static struct iommu_device *amd_iommu_probe_device(struct device *dev)
 {
 	struct iommu_device *iommu_dev;
 	struct amd_iommu *iommu;
+	struct iommu_dev_data *dev_data;
 	int ret;
 
 	if (!check_device(dev))
@@ -2127,6 +2128,17 @@ static struct iommu_device *amd_iommu_probe_device(struct device *dev)
 		iommu_dev = &iommu->iommu;
 	}
 
+	/*
+	 * If IOMMU and device supports PASID then it will contain max
+	 * supported PASIDs, else it will be zero.
+	 */
+	dev_data = dev_iommu_priv_get(dev);
+	if (amd_iommu_pasid_supported() && dev_is_pci(dev) &&
+	    pdev_pasid_supported(dev_data)) {
+		dev_data->max_pasids = min_t(u32, iommu->iommu.max_pasids,
+					     pci_max_pasids(to_pci_dev(dev)));
+	}
+
 	iommu_completion_wait(iommu);
 
 	return iommu_dev;
-- 
2.31.1

