Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012005.outbound.protection.outlook.com [52.101.48.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1C31A6839
	for <iommu@lists.linux.dev>; Sat, 25 Apr 2026 01:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777079765; cv=fail; b=H40taCafVFIaksL/lusAfEiBxDum8Wp3KmqW31Z4tyYKjFZ02FiVTwbi/piF37rZf8OxgOiNwWzFprBQVtmFR7jcQBTsv9P83da85XOL00fjvS0vjLS5OQbZvPeivEsY7MnF0WH7mCv0LEooF5lssZgdSma0HYkGiAgKwaSG9SE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777079765; c=relaxed/simple;
	bh=M1bQBtYbLDQP1mIk+FcTTZDq1nMqqvQ4fy5WFeH4AME=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Uya9nQW5XDU04ticCAKfxqtj4jOST7kuTMUBkcKYvOuEEj0yRSb+Y20vE8et9v8Ntt9KUEerWmHOXsoYvWOr0Ov8pzhuyirMCASpNFtWp5B+77aOLNRm7+Q+ullK/NWyKmXOuHbHdbQY5qYkLX2nZRxrILZdlpuGrpupS5Y84+s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FXjwRSAl; arc=fail smtp.client-ip=52.101.48.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FXjwRSAl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hKC9cViuum8FnuzG+Rz8UqhwQ4ySipvF/kZRDS+Dg36pMPnXJZgMnWJWNG1kGMnZ4feLNphhuhbXGBqBSOLsbr5J5+jVC1H5qGEKcPDldj2ZhBrI5FuLSDoL9Zb3fKiallp5pw7M17RrJnTbBZ9xzfZiegVyVy32s7kBkP2q+bu1r3UxCHgJk3amYuuFuvvZCtxEd0k261/le0LgHXixywr+SIId7HZVolcD2tu+n3SZiiP+7Fp0vGGp0UrQsObrpPCT8KK4HavtZw+GnbkvDox0cN8A7yOYNqEzleeQsXEGp9OKEHoK1PosdBas7Zvi+DYnAdSUj73sU0yC5NrU6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k+KLIuHNH1/8GBMdISBNykwHF8bgWOd/5QQF9ME6pRU=;
 b=wy8OixnHu1cosu0zaRYEV2ivLET/UqrWCmGQHygygiEW+v66mIWqN8EW88nMLfoF/FbAXdyNIA1gyvdXftX/1BOcqkzAEkO+5aw/2oFo4kS/SMpYUwjdPTpBlXuMmXtHh4Rg6Suz2IFaZDvmgSYQzXGCm31t69ZzR97gmT8dr0OGjVWN0wYuWPaWFc/dpBHkngF88i/DmdocT3lemo+qrrBMH7MpziPzOXeLuB5tVo6nYDOmwoY9hDaaSxkGjnEYsRnWY97T18xJhgeEEnH7VFEaEL3luj8si/ZrkNlcY1/lRKowqEoNUDOavh4prQ0Q8i4MOTDQzl9pG8a+D0Re9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=8bytes.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k+KLIuHNH1/8GBMdISBNykwHF8bgWOd/5QQF9ME6pRU=;
 b=FXjwRSAlMIIR6mi44R9gTNEEEEn7gME+5IDxuDzKTMvkg1JILbThvBieS+rHZLgOEpw9vnjVoNQYrawXR2gm0TUqaG6vrKYSNR8qJ9cwIAXl5xADIVm3nhookzE2jnS4fhVw3NaC0U/NHgDfjZMbf4s1VoPX+SKI5t0qr5WDfB6/vQ90erS4L/+BNAKCtv4Ho8z9t3PZDbpIm65hCSUsM+MZAm4x9xOpYlTn2y6QpJ2zpprrfOS+fRqmsvMZwTZtscHIewlUbclaZA4lCkbUTtbxH1i1JcbB/lar96CnigssiXcW7Ud5wWyH0ZXGgd8NXxIL1Dcrxq9gCyXa+r+uJQ==
Received: from CH5P222CA0008.NAMP222.PROD.OUTLOOK.COM (2603:10b6:610:1ee::17)
 by DM4PR12MB6158.namprd12.prod.outlook.com (2603:10b6:8:a9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.22; Sat, 25 Apr
 2026 01:15:58 +0000
Received: from CH3PEPF0000000A.namprd04.prod.outlook.com
 (2603:10b6:610:1ee:cafe::4) by CH5P222CA0008.outlook.office365.com
 (2603:10b6:610:1ee::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.23 via Frontend Transport; Sat,
 25 Apr 2026 01:15:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CH3PEPF0000000A.mail.protection.outlook.com (10.167.244.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Sat, 25 Apr 2026 01:15:58 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 24 Apr
 2026 18:15:43 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Fri, 24 Apr 2026 18:15:43 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Fri, 24 Apr 2026 18:15:42 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <joro@8bytes.org>, <kevin.tian@intel.com>, <jgg@nvidia.com>
CC: <will@kernel.org>, <robin.murphy@arm.com>, <baolu.lu@linux.intel.com>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<xueshuai@linux.alibaba.com>
Subject: [PATCH rc v8 6/8] iommu: Fix ATS invalidation timeouts during __iommu_remove_group_pasid()
Date: Fri, 24 Apr 2026 18:15:25 -0700
Message-ID: <628a9ba0cc123023f0d60fefec7b65ecc23f09f6.1777074513.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1777074513.git.nicolinc@nvidia.com>
References: <cover.1777074513.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000A:EE_|DM4PR12MB6158:EE_
X-MS-Office365-Filtering-Correlation-Id: daf5e0bd-487d-4501-1bc5-08dea2683521
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|376014|1800799024|56012099003|22082099003|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	ZJhF+tMPlg+e5ybHEYyF/qREokCj3YcPDtojWeS78DFAtLZPjVET+pBhUoLWsDs+B0aS5mhYnwaWYjxRt2wgwBnCW4kDvMfJTqjO+ztP4Yhr8+YMXBSiGZTazxESuOwd2cbrnme701HtceQvmkfF/j1EPDnS+3fhot11ZRUD3yCRcQUomFRZuLcZS4ONekLmyLyAQW5PQhcfKsHoa0H+W9PqPQJypN0sXsERZOOlqrtj/+in3pBsP1WMytl90ZvhH/5K+cGcBYWtMsTdsaWsveyeghqCN4RhhUHnUXA1ZSDq03RVcHabrFj/BjSl6webhAfVzyCnWCrDR+FgTKvp01GGZPmHcwO3hnpLmYFMoCp3LUEY3n0pHkwzZH/DrW9TCBTdrVYHK5AT8Tz/du+WLYXyJTmOxQpqkTm9xPayNr26gYQjf+kIpujatcdAq8s26ToxuCAJi3hP4qOSWUW111f7PZnmlGClHbbrf27LpuCyKBpZOAypOT+/IcvyL7hUk9fhDI4EHqhDSHwthJYQWPLo7xm2fVHcc/nvkysDYFpwit+S69iBczRmlBBg1pBfN+fq3CAamUYkMfb4X7qVoXh8ZOm5DKphdxDxqNibKaP8HoW+k+pSI+a/wXNDYZ4KkUcOI8gTaJkUEuWbOmW5oLqBT5vhAQLxUMFB3f+uEmvt2262L2QAFA2ikkJzSQtYMhvP7AnMCaht2lMxaaBLAuDqZ5jRpMsKH9ppYV8H7fQIA3mylNKmf6OyrREgJdp1dEJOOhxphR+Xkw2XaTSRug==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(56012099003)(22082099003)(18002099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	qWim3A0+j1I+rtwn0Z+bh3iO1XLtj6baUVVUzfHITHiyOrmvdAPInquPHxPD7Yl8wUUDOziU83CklT6EAA6+kl+iuByOog4vOoTpVG9/ecA0XpTwEOPCgRqnEG+cWjstYdAFX9RrgWfbPq87mFiT58ZIRyUA+L/AV1T3Q5Smvwxxe51fMofOhI/Ba2cF/C85GQbkXO3jOiSepWvqzNsY++bM24oGZT6/TIEaX95YOieCAOC75OkK61C2QVDIDmyainD930pjSMwTND8JR6TpSkRGoqWy4KhmUC6waMcXH2pr0xXVyEIsOzsYJ4KdraV32+nc8RyGcXG0c34pzPXMfwRfZ6R5V9XN4dtMNQjMHi14wtJ4GQleQtQry7oviufyB5+jTcXf5NoZEP+GECJYfupFMsI6dJP9ez8HA6qSRtngC+ms2KKuVYYYjWlvXqu1
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2026 01:15:58.3524
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: daf5e0bd-487d-4501-1bc5-08dea2683521
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6158

If a device is blocked, its PASID domains are already detached. Repeating
iommu_remove_dev_pasid() is unnecessary and might trigger ATS invalidation
timeouts.

Skip the iommu_remove_dev_pasid() call upon gdev->blocked.

Fixes: c279e83953d9 ("iommu: Introduce pci_dev_reset_iommu_prepare/done()")
Cc: stable@vger.kernel.org
Closes: https://sashiko.dev/#/patchset/20260407194644.171304-1-nicolinc%40nvidia.com
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommu.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 7a5a5d3aabb65..d0f32bd954a72 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -3554,7 +3554,12 @@ static void __iommu_remove_group_pasid(struct iommu_group *group,
 	struct group_device *device;
 
 	for_each_group_device(group, device) {
-		if (device->dev->iommu->max_pasids > 0)
+		/*
+		 * A group-level detach cannot fail, even if there is a blocked
+		 * device. In fact, blocked devices must be already detached for
+		 * a pending device recovery.
+		 */
+		if (!device->blocked && device->dev->iommu->max_pasids > 0)
 			iommu_remove_dev_pasid(device->dev, pasid, domain);
 	}
 }
-- 
2.43.0

