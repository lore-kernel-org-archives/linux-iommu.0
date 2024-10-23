Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2041.outbound.protection.outlook.com [40.107.93.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7D91990D3
	for <iommu@lists.linux.dev>; Wed, 23 Oct 2024 10:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729680308; cv=fail; b=kXENByChjWcrwJpedCauN7JRyN2vJ/BVcFtEymB3Smb3ofXTV2DJ/AvGJ0AV5U7Tmi4YStF6xWhsc+NqncdJ/1XhNmCztSo+E62WamnWVLeoAkUz8FvAaR7IDBMPbUsTM1uTBE5rD8KgoyAKHe5qzRzutGkSUq1KJjvYyGvkryk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729680308; c=relaxed/simple;
	bh=KWnyuGOnjnE3RHSEIybEk+GFHQJuS2s6wlk3Vse9WUA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V91A0Mwu/jCwatwM7PdcscFAa4s/EyVfQviJ3euDvC+2p9c8Rlb7PhOYrc/Po0602A44zyWmJhZuD9V9FWOJqKtgk8s3ut6OJrmL/yr0W9ewo5fFjKaoXygkphmEX+mNRQDL4qNLGGOGpkhGpbExGcW0QNFsxTHPjSIt/5Q7oXU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fxreh8oO; arc=fail smtp.client-ip=40.107.93.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fxreh8oO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LxnYTt6L3VlRuKv6u2z9euuANZYTHCeUieWCp4yNdpKjMxzwO4cErwZiBVl6elroqcdpIMORj+gLO5EiRdM6fuerLZ9GQAvQuPUY7F7no9pOxCqbo1SDd2INTA9vgtU/7tGfaSUWTD8CBPU6ohNIxR70XDNOtCYjkJiLX0SU0aSXCHkqhwTVoz9FJsB3zseLOhz9NLnUaG5NH0VGxFCSkcXMRr1Dv6YABUEWZ9CBUMa+JtKh6+IRIXY3SjJqpCtOs01Ebq165yr3i+Dp6LSsFOlFjfzei5hjjc1nCzB53ROlChcQITHlpnXZS4VkfmjvWrEF4qaaaFIukekYilaKmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9r2BPGZpLFc7m3IghwGzLEOydFuTPF5e/y2iieQV+GI=;
 b=jHVR/RFPPVM9P/GPNIq+n5uU0ch/iUR18zpfnbPUBM966mypgL6Q6TPcLsKakvB+dV0wgqbQ11WaY32sORk3Yoi3g2gRWEvunjx6OpkPB6rMQFgKwqo0Kw6X3v2dfIHaSLaK68eM3MU2NZJnYgnlbUp5rBvJ2Q8CzauocVM3tXk+PRSUxceS9ApZxlgmJJc1i/7uRVZYxNYirMvdPhszRxGqfzVd9iWcM7ohU20wQNo51+l45Ujr5pKEPJkhOVoqGc/DRG/otZwW4DsOclzyHHgdJxewRrD3Rs2PCubGCz2btsB8sf4obaPzHAPo5MpuE4xkYMPcHtHoh3rf81GW2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9r2BPGZpLFc7m3IghwGzLEOydFuTPF5e/y2iieQV+GI=;
 b=fxreh8oONQ2WzOXU5slHfOy40486OFD1KU5OKGGwgrfsNujOupARfWFOa+GmxK7Lno3KzIUx/v9dlemjdKHnpGirXYYZsR2Ib1t2518Nlq3MZs6G/+vcZkd3Rid1wSThYRYIjBl3QVUs6qBvGAqrGHTiLuIQenW3Eoz9dvAdJEg=
Received: from BN9P223CA0020.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:10b::25)
 by SA3PR12MB9227.namprd12.prod.outlook.com (2603:10b6:806:398::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Wed, 23 Oct
 2024 10:45:03 +0000
Received: from BL6PEPF00020E62.namprd04.prod.outlook.com
 (2603:10b6:408:10b:cafe::8f) by BN9P223CA0020.outlook.office365.com
 (2603:10b6:408:10b::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29 via Frontend
 Transport; Wed, 23 Oct 2024 10:45:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E62.mail.protection.outlook.com (10.167.249.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Wed, 23 Oct 2024 10:45:03 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 23 Oct
 2024 05:44:59 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, <jgg@ziepe.ca>, <yi.l.liu@intel.com>,
	<baolu.lu@linux.intel.com>, <kevin.tian@intel.com>,
	<jacob.pan@linux.microsoft.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v4 09/12] iommu/amd: Enhance amd_iommu_domain_alloc_user()
Date: Wed, 23 Oct 2024 10:42:04 +0000
Message-ID: <20241023104207.5894-10-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241023104207.5894-1-vasant.hegde@amd.com>
References: <20241023104207.5894-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E62:EE_|SA3PR12MB9227:EE_
X-MS-Office365-Filtering-Correlation-Id: cb04448a-8d5f-4717-c38d-08dcf34fc03e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HZ1C/fWIG7AlddRdS69gfNnLiwKOjvoUpSw8W4yRAgxgrOdmpvKvFICuKDs/?=
 =?us-ascii?Q?rw2Sj5uwfFUsCGtxEYYjaaRB9kd8Nwy2hHer4x6MuQ2NLRzKYskdKacyFA7e?=
 =?us-ascii?Q?fvIgJXR/2zKBC7rI0FR47fBb2Hl/U3b1flyjinrKtJXgFAlO9RAv8VwRlp0m?=
 =?us-ascii?Q?9j6EvOBWsu+v1JFgNHySW/fRzhpj6HZqBfhMCZldOQw83PtzrJMjy3ptXaXi?=
 =?us-ascii?Q?wDcNnhUjp8iK+Dhy5VOOQdFKvMsf0LZJVfZ7SJRRVIEWeqy5qRiv2yVXmfvd?=
 =?us-ascii?Q?Fqf64xjPo6Mm9tVIdT+YK6A3VDb0WcTOzNGzzNa7FFJMzz0bvVbIHEdBvMce?=
 =?us-ascii?Q?9mxsgt5IhIbgxzzXLCh4w0ACcJHGqOXSro4Wwil8230MsngOiZSrwIv3w2+e?=
 =?us-ascii?Q?BNnPcQMc5nUEbYjZjPYoIq2ryJVHIAJ0SzWUAe9HnZrRcEtnmifz6nfCt/zr?=
 =?us-ascii?Q?8aV7gaaPNsf8XzfIM2IF/YbDB1wW+OLNptwRHfiNDIz8Z2owDvAZHrCOsfbT?=
 =?us-ascii?Q?UxuRmaRxbYixZe8qJFCp31m8CVyaMBk4UiETGZYhCyOGoB6vIt4jOr75wQOz?=
 =?us-ascii?Q?TyagUwjpp6+ROpP8XMs5Oi8uau87xb90qTpV5kRKqk1oBO5xN9RC2MjCr+SZ?=
 =?us-ascii?Q?f5JWlxfWe5yyjfh0519BVvp78PY1nqzlTq7Zy+rgBaXyxnBc9vPyu1KjR7oq?=
 =?us-ascii?Q?Fej2R5ZlOqIF7Fv+Nsm9zK6mqpM2YEQDTBjUEOVZZzLQEAQAmLvoNxqvXrkh?=
 =?us-ascii?Q?refcDNnhAbIWRcmtqSLyZMDp3UnzOrOVdt06MzDJlqxL+ZPoyTN0PbBI0yjJ?=
 =?us-ascii?Q?Pxk4QDO5176uEoyznFIZCtpadar6UlPvyg8OqgelLx0djyg8CnZvbMrK1fYz?=
 =?us-ascii?Q?rO+UG04O6z6MrQEZqPemJEhxQ39eWZyTS5aMWtDwIWGzk3ARFDSDWhPtLL1z?=
 =?us-ascii?Q?SAthe3M+kWsDkWtN+1qJaDIapu2hcSAVkWST+aNO32Ul5a6/Nxj5CcKHRNFF?=
 =?us-ascii?Q?N9610mjh9TWEsvSyduXg++Jwym4vbMXGbqqyAmc31N+ilDqCZNvudE/czM14?=
 =?us-ascii?Q?KRL5of6z6KQnNnHD2DT8oIB0a8PbDUThbwjjoKWp2C3Y8f9o2P8VUq1DkJT2?=
 =?us-ascii?Q?aEV3xPdy590pQ/nVaS/OV5Zg8dL1JGpIiIZez2tjt3Np59eLIUtfA0dXsavv?=
 =?us-ascii?Q?iJpFaHj4LCYaWWwEtqyCeblRSiowPbTK8XKigxfJSPi50uxEmEaoumhyBalz?=
 =?us-ascii?Q?Ua9mllMpbhz5pmo/CqV6GpBC+fWdOl9CtTI/EEGgJFZ9d65WXEhJGYtOEkFk?=
 =?us-ascii?Q?xXh1peJXXJbs5anlIgIQa7hHSqfmOMn8FjeUVM5LX+3uAyxtsivm40NsCFdr?=
 =?us-ascii?Q?u4EnNliY3qX4rf0wjx/zPQ0J9dWlY6U4zUQwfqzBLbiqQyeRiA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 10:45:03.2291
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb04448a-8d5f-4717-c38d-08dcf34fc03e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E62.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9227

Previous patch enhanced core layer to check device PASID capability and
pass right flags to ops->domain_alloc_user().

Enhance amd_iommu_domain_alloc_user() to allocate domain with
appropriate page table based on flags parameter.
  - If flags is empty then allocate domain with default page table type.
    This will eventually replace ops->domain_alloc().
    For UNMANAGED domain, core will call this interface with flags=0. So
    AMD driver will continue to allocate V1 page table.

  - If IOMMU_HWPT_ALLOC_PASID flags is passed then allocate domain with v2
    page table.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/iommu.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index cb6a72564c23..cdc93c794eff 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2403,10 +2403,26 @@ amd_iommu_domain_alloc_user(struct device *dev, u32 flags,
 
 {
 	unsigned int type = IOMMU_DOMAIN_UNMANAGED;
+	const u32 supported_flags = IOMMU_HWPT_ALLOC_DIRTY_TRACKING |
+						IOMMU_HWPT_ALLOC_PASID;
 
-	if ((flags & ~IOMMU_HWPT_ALLOC_DIRTY_TRACKING) || parent || user_data)
+	if ((flags & ~supported_flags) || parent || user_data)
 		return ERR_PTR(-EOPNOTSUPP);
 
+	/* Allocate domain with default page table */
+	if (!flags) {
+		return do_iommu_domain_alloc(IOMMU_DOMAIN_DMA,
+					     dev, 0, amd_iommu_pgtable);
+	}
+
+	/* Allocate domain with v2 page table if IOMMU supports PASID. */
+	if (flags & IOMMU_HWPT_ALLOC_PASID) {
+		if (!amd_iommu_pasid_supported())
+			return ERR_PTR(-EOPNOTSUPP);
+
+		return do_iommu_domain_alloc(type, dev, flags, AMD_IOMMU_V2);
+	}
+
 	return do_iommu_domain_alloc(type, dev, flags, AMD_IOMMU_V1);
 }
 
-- 
2.31.1

