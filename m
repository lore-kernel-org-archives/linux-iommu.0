Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2060.outbound.protection.outlook.com [40.107.236.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A7D13665A
	for <iommu@lists.linux.dev>; Fri, 28 Feb 2025 01:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740706309; cv=fail; b=LyrfcKiLZNMGAT6AnnV7kzSv6Bwpk7PAxOw7z5Ckn8DddXZww0SFnz1bWiaHqPnq1JYyODdYEDMHltzYc9vuAyABktebVVVqOX51a+/l9KDs6YcTEneFGSxwECb4FitrmsMZoK8okIYLGBgGO0GsBJO/erreqvAdEPMU2ik2bGg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740706309; c=relaxed/simple;
	bh=eagQoe4NKTYa2rMA4UocgsRww22jeLoEHe9q/6kC1Q8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o3JRIOKMOCb/n+VuRlSFrHvtll0higvMrpsNBFDf/NvsqzcxRDWC6hu5aqj1Mj0oIBLq+vlKfX5jx3NsX00FgyIojw9WgHXixSdqg7izaLRQ3+c51rLM2oIvzDSm6Qf5h73SNAKwh7d4tAFjLM8NBtML0OpdXC8yfSKx4T1FWGQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ta7l2E6Q; arc=fail smtp.client-ip=40.107.236.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ta7l2E6Q"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=swa2TROXB2jMF5y47ovBcGr7NosJo4WpAj5RueVIrbBZrKFOHVMnh8CoE6gjXglF5nK9cFDYxt5lBilnLrawTInQtU+89ykX2gj3ksd3063CshMbdBnGzGUsbsz2vD/deVHeWLdI11zhT1uGsVByqIYp5f1KGFP2Ep0xM25+DcQLPtq+4EUympAFnPtI1EI1njE8p0MfYih/OyjKvORSONh+ZLUxKKPvQaMeIafPNpa4bsZKR0feWAbbU+Tu0rSjGu+NQjwIb/XUjixQqzwu97wKKcxung3TZ/Mtl8CRqLKCeGoi8cWDsNp3YS0xXBDXfXINj16dWlQ/MVuSFxDYrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5bMlb7joNy3Zm1+YZnt5rFHlLT2OsXQXf6GtL0dvu+Q=;
 b=HnqxCwRTTDK8c2ji6zjo2k0AtN+bQdL+dF+wz723/MJ1czcnwGC+OgwksV6rCiMfWsujYPLKfZTG5BKQDt6bVV3JlVnlKmpJIYFmohuBesKYCCjzcF7mNVvJma+xvNhQzBiX1c30vrFeWMP6Ll1avkene98wbx3eeMMPwChAyGts6MvArxvBnBPTanpGIE6hYhnwT6zBen/FR/+wpOkKWSA/Fj2ou3LYPFFgY2wG5GqORhKwUIE5tgVeHs/ghKxWEknLUhWR5Sl/BCIYCK3Mvta0EbRd8cc2W16nGN5p9CiEGqgcNdKsm4ZiSmqCPSVsJaSjansAVG5AoGX2CQRojQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5bMlb7joNy3Zm1+YZnt5rFHlLT2OsXQXf6GtL0dvu+Q=;
 b=ta7l2E6QbwXg8Ojlx4StvwozcOXaNpjnYF6jOhiVC9UVaWA7KODE8Nuh8t3DM1A+I5k0ZcxiGcrcSOFsELDlHCzvWvSaCuYDGlPtXjQ1FeyuFZaow1eZ+kRvoI3BHDcQwBSgq5nEZGIOREIqlmfpVHgLbK2uv3CQv3CiHZo/yifYZ4VXYc4HUfp3TjfrOGDHKh6mxi7jo6YQD5kPv9ebuE0fUBL/DoZYaN3o1RZaq6oWCD3dNEugjjbzSYS5jEjK3mqPPc4kZyGU4Y4MxE8UI+JpFYM+QkjrThsIban2cRJ0oon2voauLlJmLpEBT+HcB9UrTTjs2CHEZwZre8MYkQ==
Received: from SJ0PR03CA0369.namprd03.prod.outlook.com (2603:10b6:a03:3a1::14)
 by MN2PR12MB4157.namprd12.prod.outlook.com (2603:10b6:208:1db::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Fri, 28 Feb
 2025 01:31:42 +0000
Received: from SJ1PEPF00001CEB.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::dc) by SJ0PR03CA0369.outlook.office365.com
 (2603:10b6:a03:3a1::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.21 via Frontend Transport; Fri,
 28 Feb 2025 01:31:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF00001CEB.mail.protection.outlook.com (10.167.242.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.16 via Frontend Transport; Fri, 28 Feb 2025 01:31:41 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 27 Feb
 2025 17:31:25 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 27 Feb
 2025 17:31:25 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Thu, 27 Feb 2025 17:31:24 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <robin.murphy@arm.com>,
	<joro@8bytes.org>, <will@kernel.org>
CC: <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 4/4] iommu: Turn iova_cookie to dma-iommu private pointer
Date: Thu, 27 Feb 2025 17:31:18 -0800
Message-ID: <e0ec920dd80c3d7e19ef4aa6641eacbe70b11687.1740705776.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1740705776.git.nicolinc@nvidia.com>
References: <cover.1740705776.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CEB:EE_|MN2PR12MB4157:EE_
X-MS-Office365-Filtering-Correlation-Id: 985fc9f3-b877-47d2-6dd2-08dd5797a7ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?txF1lKwXV2476M3ZXXfBHybtRmwTKthOvEnUQ9T9hc4JIglYIOkXbT4GJVlE?=
 =?us-ascii?Q?NKbsk+ODSzQFmhQu84tsQoDuhvavpTUvAEktjI80M5+cMdNtq/vJtvgSFiMX?=
 =?us-ascii?Q?AyPRj//A4rF1ANbDoxpGLTKpdQVWRwBu3BGEazPQmzBrzx07JvZNOh4zIToO?=
 =?us-ascii?Q?WczoD8Or3wpGtmxhLDR3cg6dHzWD13RnrTxHZsuYhEqOq4qBRSCEURVBAODK?=
 =?us-ascii?Q?XvYyRrvUFS0TNwOE3ofSBeHeDZE8IX8Lt24p+GPIFJVPBwP5Yb2NgYEPqA4p?=
 =?us-ascii?Q?qbnuDe7msZpM9Tx+q7lNUNZKuHvSXKIU3Pd29qg9jY/iHmOcZwN7vJIjUhRL?=
 =?us-ascii?Q?S7uZCjrz5ZyosLRcPA5dVyWR2khvrVkKji1SU8uK4t8Ybi1m+b4A+yEQi4Vg?=
 =?us-ascii?Q?QB4wR5q0nEa3m9Vu4oIrFyI0QNupH6LFyOg6V36IgW87VgtiCbO4xVAEfp2N?=
 =?us-ascii?Q?nKAOy7yfTfEIIwCqQotIl98Db86prou0goMv8UuIb2+U4VG5cFwCX3cP/vA2?=
 =?us-ascii?Q?zB+nXgUDNlr9u4/gCVmlSzE7JpaJspB//+TqnUb2Fl0nqUsWco0egrBpVcck?=
 =?us-ascii?Q?lDXMoNjrRL7JUSByPq1zEjJxybRyH73Sodvnqm3shZHM0K8gfoSOFd5NCZDf?=
 =?us-ascii?Q?ZLX2EF8dSlsyt0mbQIF0Gbq899iyRpbedUvzHX0f52/xhQEoGdhqXGwCnB5n?=
 =?us-ascii?Q?3sbygsROI4Q54cVue1xsBQdc2C1Aof6Aj3rzj+L2R3H/D8O7cbm/zfgGAeTy?=
 =?us-ascii?Q?/+TAW3rf0KcGD7OMU9xpezdLghgN6fGZVsh4Z7VzXX9cbTNyzNJD10FUYwIP?=
 =?us-ascii?Q?tzqhkKT7Y8ItuTPohQ4YasXi6dRAaktor5K6KhmShPBJZYmOt3/IHMc2LP6z?=
 =?us-ascii?Q?XcXAkZZ7Q66ydrZ0Gl+AfHvvYBHkbKmGugjLEFLOoKxAblqzj8GaMyZasvas?=
 =?us-ascii?Q?C0WzydZvisqbyxbK584QC6Q1nBH2JRsH1yjnSjiMZ3dnY67d0Tvg3j5IeK2F?=
 =?us-ascii?Q?JK6ZifRRC+IWcDCYVvYl8PY0OqahfsQ/d3R5bJs4+yA/yQiY/8BvAY+7TgHd?=
 =?us-ascii?Q?NaPUueURLhjJKOaA4Y6LfGxmXJOrpxzFmhkZwmvbeCv6a4S7rLGO4o+ve2/9?=
 =?us-ascii?Q?vGoqOW6gxoIIZtDxSWLl0WaGH8XvFJHb7uDx8Ks8PuudTgQn/nzNNh5+Qg9H?=
 =?us-ascii?Q?Men4rTEiJOTRLUMHzQfcLd3dUgbxS2Y6P9KqZ3UZIkmyIdrwHfk4DX+uzXVn?=
 =?us-ascii?Q?HS11+5QsjxXJDZ6i4TxpNOh+Hg55xfusl+h/98Xn0j9+hx5ypCSPebwl9eyE?=
 =?us-ascii?Q?DF4YO6OCgYDizbZ+6vbsvT5QcXuRt4OFPqo2m0p6xO+dG+uiiikKuqcHf7s2?=
 =?us-ascii?Q?bXcTxjpsY1UxA2Q3V9IMCndGylJ4sv6YyRfGQwe5jtjaW05m78kq+yK0FoD6?=
 =?us-ascii?Q?URWyFwek8HnPbfIRhyQAXlyHsmqaSq6GENjrU7+9M8lJixlSzBLSFUVzTjtK?=
 =?us-ascii?Q?Vs0NfJJha5oXkV4=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 01:31:41.9936
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 985fc9f3-b877-47d2-6dd2-08dd5797a7ab
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CEB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4157

Now that iommufd does not rely on dma-iommu.c for any purpose. We can
combine the dma-iommu.c iova_cookie and the iommufd_hwpt under the same
union. This union is effectively 'owner data' and can be used by the
entity that allocated the domain. Note that legacy vfio type1 flows
continue to use dma-iommu.c for sw_msi and still need iova_cookie.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 include/linux/iommu.h     | 2 +-
 drivers/iommu/dma-iommu.c | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 29400060d648..5c6bca1ace27 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -221,10 +221,10 @@ struct iommu_domain {
 	const struct iommu_ops *owner; /* Whose domain_alloc we came from */
 	unsigned long pgsize_bitmap;	/* Bitmap of page sizes in use */
 	struct iommu_domain_geometry geometry;
-	struct iommu_dma_cookie *iova_cookie;
 	int (*iopf_handler)(struct iopf_group *group);
 
 	union { /* Pointer usable by owner of the domain */
+		struct iommu_dma_cookie *iova_cookie; /* dma-iommu */
 		struct iommufd_hw_pagetable *iommufd_hwpt; /* iommufd */
 	};
 	union { /* Fault handler */
diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 7ee71b9c53bd..ee2fcc058aa3 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -443,12 +443,13 @@ EXPORT_SYMBOL(iommu_get_msi_cookie);
  */
 void iommu_put_dma_cookie(struct iommu_domain *domain)
 {
-	struct iommu_dma_cookie *cookie = domain->iova_cookie;
 	struct iommu_dma_msi_page *msi, *tmp;
+	struct iommu_dma_cookie *cookie;
 
 	if (domain->private_data_owner != IOMMU_DOMAIN_DATA_OWNER_DMA)
 		return;
 
+	cookie = domain->iova_cookie;
 	if (!cookie)
 		return;
 
-- 
2.43.0

