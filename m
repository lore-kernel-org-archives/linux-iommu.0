Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010010.outbound.protection.outlook.com [40.93.198.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64B63F889E
	for <iommu@lists.linux.dev>; Mon,  1 Jun 2026 20:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780346604; cv=fail; b=SQIOTj9LVdDAT5+50238GfZesyvVEbb0aWmh4gqdL//ybqbPQu3axT9FOOgWn2Ups5Zyg84vQjE2KLKK+s6265Xv+AK/O81C6wH5MsUJ4+FM/sZgGSABr4KdlcsTRE0jEZc4H/wjafQUD/EEniv00XGasvN25Ab5ZJ9qnJf5eUY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780346604; c=relaxed/simple;
	bh=rPGbpREEvX5MFJ1AoA5JgjDtiKDNwdgdFchwkAMM9z0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=haes+VggTlG+pFwYIdaYTkdfoAvwLip3E4FpCSoTtFD/W10pELMzXjiVeAv7pyuMDrH1UOSAf+PLJhyNeqDOu0OTwmrQXKjDKasxq6SBqpiUSb5aZPw3GCITMrs8j0dGJtYocS10tzAIQplHahNrZ6RyKHyPDOTIdqFCCqqo/XQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tvRxdu+X; arc=fail smtp.client-ip=40.93.198.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tvRxdu+X"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hFZ0DlppBZEgWFYedKLGD/4DOmaERn2CjXuS7e1+noDIwNP9QOzCTADIUILjp8SasATEjYY7JORczq2dWJUVjz6DOs4j6dCzwVPmh0qrq+V/zcrSGAG2x9/KrmdWgUjOIrgFmcrt88uDv55xYuMn3pR+kQqyhkCSnlVR9U+m1BhOp/SqPgbuDmaIT2O8I6FfPMTUKUZUPkNyBMOqnFTXxKDA1nju/+Gwi1sXVdBSHTLYayQBB1atWHUNNuBPqHT+U+6sE/qTOLyvGpVTg1xx0FwfXGhpdLMzSEWt1A5XEzZDpAKEErbNdbObN/wto43MVu56k3wK/WQDp8sJqFDpVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RvlLflHmi9rUB9ew7g0FmtJN6C60Cy0U+0eItX7Oslg=;
 b=LAvZH49hzoOx9cDLHT2vOlFF+z3kYirXrDQVOOQcR9kHdq8Pu4Pr6rGA8Xi6X4c1XJNor7VCzVEJCR7Wi4rGSoU91vNYKYRaeTwT6379n0/0PFFOIDAejGY3VdQ5DgPWhBvXkW2AFiIsVui8w0UWT145kchnj/8JDwPrQzr75KkUJK5L4mwSFXybnjCvGZz7iS7IZ5xH4cfsZGxSx9F6fEr2vZG3kA1Q2G8MOhRak8LtuJS32gaXAF6QiuuBsOL6owLXsDymCD0bQKYUMuq2/dV+dGfmH3N5pF8++66y1FWlmR75M60eZz/aL/OeWu4y5YDkGj9m4R43SPBcOL7Njw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RvlLflHmi9rUB9ew7g0FmtJN6C60Cy0U+0eItX7Oslg=;
 b=tvRxdu+X9iLgCWngg/BF0B6gt0KCR7tAgZqa+0ASI2MXxsBIltV3AnBXR/3QUN9vDpLXwJbhdo2qZUxJ52Xm46NqJ9EnDYPy4UydTHRqFCxKIcxnmE+tuDXkHtO++sJKXrhv04U+YcjtX2QraT4qyljDQoZ0K6Eafe/DAl7L/UTO0Voe+K6msFpjwN3ezr9jDz1e3/aaDOLiVmimWFy4F0c34IaktT/OT+hzelISbu6vkgyDm7KbzOvgdAU5F7XbxI6FmpS2tyjyqvEZ2cdvBVuZeAbB7/N/8fOAk0gVsJRoH4QCQ03ZJBDJ6SH1hewykCrOsOlWTk/cLw9GNwi5rQ==
Received: from MN2PR22CA0018.namprd22.prod.outlook.com (2603:10b6:208:238::23)
 by MN0PR12MB5857.namprd12.prod.outlook.com (2603:10b6:208:378::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Mon, 1 Jun 2026
 20:43:17 +0000
Received: from MN1PEPF0000ECD6.namprd02.prod.outlook.com
 (2603:10b6:208:238:cafe::d) by MN2PR22CA0018.outlook.office365.com
 (2603:10b6:208:238::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.16 via Frontend Transport; Mon, 1
 Jun 2026 20:43:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MN1PEPF0000ECD6.mail.protection.outlook.com (10.167.242.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Mon, 1 Jun 2026 20:43:17 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 1 Jun
 2026 13:42:54 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 1 Jun
 2026 13:42:53 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 1 Jun 2026 13:42:52 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>
CC: <joro@8bytes.org>, <baolu.lu@linux.intel.com>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
Subject: [PATCH v1 2/7] iommufd: Reject invalid read count in iommufd_veventq_fops_read()
Date: Mon, 1 Jun 2026 13:42:33 -0700
Message-ID: <e1111adcc8a8882fbfd84accd6674dc846dc5689.1780343944.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1780343944.git.nicolinc@nvidia.com>
References: <cover.1780343944.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD6:EE_|MN0PR12MB5857:EE_
X-MS-Office365-Filtering-Correlation-Id: 95be754d-99c9-4ba4-8ff4-08dec01e6903
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|376014|82310400026|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	Qr2py/xouE7yDWcyodq1iDIqX7gTQJ99TMk8aoDiLmpRVMoYr4pWlg/O86nVPk5roBCiFbZOcLQISVWiISEsFgcVmC1mVgRkzstY7ajIhfq0E97viR67Ft1dWfNTmplMRAO8mT1hIYPYPgS9un7SP+EFiXQoIOjclzMlg5NS3INo1fCDDCvALKuMP9MIsDydl0QoAQFqDfjy/NzoIedb/UvGpByYHpTUzdGTZEKqYu8YXvnl51FnkB6HJQG33TDeD8MZcltmMK9K2uhQOdGmKjTFScuzfe1qgjMwdfSIihswKCuOSu3OfdGY74bOqhpejD4A0nfMKGwouXDyJCw2u/larLRFwVU9idTEQ6mnYP4EeQGbxBGAY2SuPqaqQkNFtg9F+BUW6aS/NDytMlnW14rrmlnhD88PtoSGNxwrEPuatKCTOEn1MiwAJoEHfDch/+Sp8QWiFjHST3fOyQHiQ1e8ygm6dL9qrbJhA9hWGzJb5qBjditkENBSjjg3RyMqYnw1JyKBtr4N/MvIaMNNfnxLCqIvAUuHe59VKjslDqq9FosmMTPb+ws4fkEOBkB+zoyjPflIS33nRAlhbFPMWz5TQSSMoic/L2/gt8m+oqSze2LDYZ9Do4hPaagfcuqZUwjHUZBP78sZpeA3h+UcRIrB9OBDqJ8Qn0jLoIbnMBvN3eRyc7OARHxuOcEI1cYc/KIWRHkuMq0XJMi5eQgtITvz43Ea2lgzejzSunbwx50=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(22082099003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	JMk5uyafn2pM4Dc2hNas5X2BXQOy6A/bEL5TUuoeS7lUuayvcXAKITB/MQDGPEX0fUtUT//EucKRBBP9R1alvkTnN+g7YVIggVylxWS16XDL94KL5/1MqxkapoMOXv4CFW1ogAhnKVQJ7MYEUOm89G/WkNOciutA4+eE87stMtTWOjNEsjTuWm1uowKA1EOygfq/1zFdMnLsl7B/c9HzlVmtiH0A26L0ayWmTn9LTdC2lDL6wA0QCy5S9GlIIVgBGawFyORvzPOi71EidGq/9pJ+jcc8mVKpBVd+MoMm7RANAKvsYrE6ar/cnyYK5kkq7WjxvsDxouJVvG949eEUCMtHvMKJ2wbww/5WUFKMqiyPR7juBhIwyB1uoZ/RLWXpn1a9IjrdfbOjZVyM8QnihuxhsslYnt2kvVJRraq5Owt0bo4eAUYxfgAGvn5Ptc7x
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 20:43:17.4655
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 95be754d-99c9-4ba4-8ff4-08dec01e6903
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5857

The read count must be large enough to hold a vEVENT header. For a normal
vEVENT, it must also hold the trailing data following the header.

iommufd_veventq_fops_read() does not validate the count, but returns 0 as
if the read had succeeded while leaving the pending event in the queue.

Return -EINVAL in both undersize cases.

Fixes: e36ba5ab808e ("iommufd: Add IOMMUFD_OBJ_VEVENTQ and IOMMUFD_CMD_VEVENTQ_ALLOC")
Cc: stable@vger.kernel.org
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/eventq.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/iommu/iommufd/eventq.c b/drivers/iommu/iommufd/eventq.c
index 896f45be0d2ee..ac485d010a439 100644
--- a/drivers/iommu/iommufd/eventq.c
+++ b/drivers/iommu/iommufd/eventq.c
@@ -310,6 +310,9 @@ static ssize_t iommufd_veventq_fops_read(struct file *filep, char __user *buf,
 
 	if (*ppos)
 		return -ESPIPE;
+	/* Minimum read count is a vEVENT header */
+	if (count < sizeof(*hdr))
+		return -EINVAL;
 
 	while ((cur = iommufd_veventq_deliver_fetch(veventq))) {
 		/* Validate the remaining bytes against the header size */
@@ -323,6 +326,9 @@ static ssize_t iommufd_veventq_fops_read(struct file *filep, char __user *buf,
 		if (!vevent_for_lost_events_header(cur) &&
 		    sizeof(*hdr) + cur->data_len > count - done) {
 			iommufd_veventq_deliver_restore(veventq, cur);
+			/* Read count doesn't fit a single normal vEVENT */
+			if (done == 0)
+				rc = -EINVAL;
 			break;
 		}
 
-- 
2.43.0

