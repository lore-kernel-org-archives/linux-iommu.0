Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2065.outbound.protection.outlook.com [40.107.243.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937A316C687
	for <iommu@lists.linux.dev>; Wed, 16 Oct 2024 05:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729057148; cv=fail; b=fKdOoyOUaAcxRSJvOzH/KnUS/zgW1zJXwVFZQD9z/ZkTJ5zGLA3vc2EON69AmZ+uKhJwzFIFiGcSerCM48R6w1FsoF9As71UKdRCfPdmuXRwStfgmzWac/Shk6eOxo3i2qMk12+pKr7AFCpQOAJlEZJ6XLpUvnjo265xxxj6rj4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729057148; c=relaxed/simple;
	bh=GrfhGlzMzdESMIB123UpsJ4EnKmb11e44UAZgf0GDi0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BLrD/pvpacnl6SxkDl1J7qwF5P9R+duWZch/vphj4gdISViIm2gSH0oBjybwj74Y4nO674WinLCtsd9l6wd21L8ROs9GQxP3gpYI1ub3xiov0URGvAp1PaU3hgJtavKw0Ede8MyNydbjfAt9lc16y+vxAmXfT5JfO+ieg2wmsL0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xpZeI38V; arc=fail smtp.client-ip=40.107.243.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xpZeI38V"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fcazelz6DNgGMOPnt63Z+17yQQh+r/0m4/4UkojC6cSKESgY83P338w+oy0iemXIph7Emw1PExcV+ShjEoDI8AGNRNQvcClvVpnyMEI3/XqW4Zmhie9oaXjQvjrBEf65DOkRcAtBc/sD6+tsPZDxLmbRf2u+ZrPvcg4Jln9Zz9RLnBTpKcf4PkzulLXUSIty0AKetNIl9Cw2tNsd5lol56VUbQ0mgmLdLgGxsE4ZUU7DAgZrvmFEVh1zx8wz5dVtWRZcZk8Qo+sZiHq8BxYU725Y/bf3s7OCai+SH5NPMi21w02jnEjmTEnitiwDAdYAdAFHEI1sE5bnDCovkrIBLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F0/L+7FTv7K2d6Vb9zxDdGVfw62QuTcVBTvz/sTxenw=;
 b=frvUDmiYNMCY87+qntXFt5vxmGP7K+rY+asWhPrHgxRRmXeAz/FX/1OUqDb0+ujTy4dGyPTkuu2QzZzvVZ6ksCpVhKvSqzZFo+AQK09MGCQ3WpR0W5lncLiA4H4RlSo4us+qwBjaEq7H6itmk3taoPXcR4rFgqNgUNJDHffscHiKhZxLnNjuTGXIiwcdccV9lpclO7/8Z5A5mcKpF48vcuEdwc0LpuqZmjZaQl0QSPcIqRMdNvxS8qebYmC7AcSS83ZVBTCtkUPHp2ZvRRVadfg/46pn9/RjN7gf9DFCaCzyEjDdT5S+50IeMWQ+1V6qN/Elb5HhXMkgWAqofwP0ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F0/L+7FTv7K2d6Vb9zxDdGVfw62QuTcVBTvz/sTxenw=;
 b=xpZeI38VG1VAFymLeCLKEnD3bBupKs+/d1k8HGQKkPWERCZt7vz2HXGD3oGq1QYemVcmHjQu9ptmPaD/Q2bZi9f2a3HpONDe+0zq69pKdHXuOoWvYtTdh12e4J4EWcAfWVPvvjfAzcH+MukY0ZtLmM1pMIMWZLCqzgAIF2u8bts=
Received: from BN8PR12CA0010.namprd12.prod.outlook.com (2603:10b6:408:60::23)
 by PH8PR12MB6913.namprd12.prod.outlook.com (2603:10b6:510:1ca::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Wed, 16 Oct
 2024 05:38:59 +0000
Received: from BN3PEPF0000B072.namprd04.prod.outlook.com
 (2603:10b6:408:60:cafe::7a) by BN8PR12CA0010.outlook.office365.com
 (2603:10b6:408:60::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18 via Frontend
 Transport; Wed, 16 Oct 2024 05:38:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B072.mail.protection.outlook.com (10.167.243.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Wed, 16 Oct 2024 05:38:58 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 16 Oct
 2024 00:38:55 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>, "Joerg
 Roedel" <jroedel@suse.de>
Subject: [PATCH v3 10/10] iommu/amd: Improve amd_iommu_release_device()
Date: Wed, 16 Oct 2024 05:35:01 +0000
Message-ID: <20241016053501.97497-11-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241016053501.97497-1-vasant.hegde@amd.com>
References: <20241016053501.97497-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B072:EE_|PH8PR12MB6913:EE_
X-MS-Office365-Filtering-Correlation-Id: e79d47eb-fb49-4651-29e3-08dceda4d51f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DRHeKpg42v+jzQJgswvjKd+SznU0ki25rrxRoM+XXnicI2v6gp8t8sOK+gLj?=
 =?us-ascii?Q?Bmz0TVql8gbeilL2nHGm6nwbkfT93x1HNUueNKoBg5fj/a4TE0khL+TK/50Y?=
 =?us-ascii?Q?idHqv1CCcJ6bn3fNTXpIFOjqk9SCo+eSfTk+HLU4o3TmhzA7H/7CJfSZ0Q9u?=
 =?us-ascii?Q?K59jbbV1BqpgjdK1Wds2qULlVjaVYtUAJB4HtnUyH1o05BzQ0dAe/iTEKEC4?=
 =?us-ascii?Q?aRLjsM5m5pSzuRnFCm/MozbLzJzHlFrgxUNmPOmTy0w7yzWETiuFpRJ3fvst?=
 =?us-ascii?Q?34nIG0kn4qaSgUbXH6XDykXMXGnj294H1gzCVFlgNf0rxN0ef3x3X+aDYnQi?=
 =?us-ascii?Q?cBGyE9CwvKQ/eKBHP72bSO6vHkazaYsc+8HzPafymsivGSn8+0RxYfC6xdbT?=
 =?us-ascii?Q?S9IdNFs6fA8+9Ej445itu4Q1e/1q6Kjs0219WE7bpDrPuY+sqlUgM0Cwu+eT?=
 =?us-ascii?Q?UEdjDAoVNk/iYoxfKfteIyVkMNvTSHUQLg0QCaVTy5Vyis0w+V/yjax4zvSf?=
 =?us-ascii?Q?+9w8iVaf1cgSB+CEmzbJWZoLIEPECkdm2FmCJgM7BB50X+CgpmbhfuxmX76C?=
 =?us-ascii?Q?KM9lu1ZePmOZTDYlsBSR13ldpdMNdg7696qc1HuhgaDwYQ+KASy8IQeN2404?=
 =?us-ascii?Q?K22RGLM7qXy/3oAmoekkPtYe3gYsaG/0v2HRYT0GBPkJtlGWlO8qk4VIbpu7?=
 =?us-ascii?Q?2yg6tDcqXu0aTnb4OnIyu2S7jIQrB9kM8+Gn4o/iIYoXNTUaYL7jAx5zYwvi?=
 =?us-ascii?Q?LJo5eHT2QvsBD3BhNEdTRbgMZreAr0RZ86slNS6Gdq1GmfYRdjSwml7XPbu3?=
 =?us-ascii?Q?t/imjAdPswOiDqEUqIGKcCpxYZ4Xl9DzxaKYRX/kHtxyqCAeSQB96/UAZx6i?=
 =?us-ascii?Q?HjhelUuktWLUfWVA5M1Gh2+RwPLoxYnhQasR8pXyLVQhELiKSXgsSdweV+0W?=
 =?us-ascii?Q?7qHAmRc7xceoGbsBK6qpblJAASxRSd/aYWiXg8+pHZkLIDoIEg5iDgrT0gQ+?=
 =?us-ascii?Q?c628PzSbCmCH9xv/scMv5b0KyAkKDJ1OkWzdgsLC/Xxk7v/9M9gezQE3Yj8F?=
 =?us-ascii?Q?Vr0EcyznCQ1C2+mDcceJgu9cOFQuEgOXOLCJXZmGThcpZQx1CfPyBn/Aisvg?=
 =?us-ascii?Q?EoRupVA71O2q+RILMUr3B9p/i13akRlQqMxvsXy6Gc3ZHlIv3tQRDuIJ3BEn?=
 =?us-ascii?Q?Z3xy0uUsL9sCKugNPMg6Zr9bcoNXKrSZYo/pkTpefRdhoIDwNcnyOQHUka2H?=
 =?us-ascii?Q?iuTRbgKbYrBfru3Yw4JURhpb6fbMCBVk+OJZhJTxLBwfGMXmXDBoAbnB8FD6?=
 =?us-ascii?Q?kdoVB480S3md4Qy1fV7nCf5M5hswW6dhiKy3FbUGRqZWWg95CyLrb2cMFY6Y?=
 =?us-ascii?Q?6BT2l8GHtPq3rigYfosnJMzczOsh?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 05:38:58.4995
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e79d47eb-fb49-4651-29e3-08dceda4d51f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B072.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6913

No need to have separate amd_iommu_uninit_device() just to check
dev_data and call detach domain. Hence move these checks to
amd_iommu_release_device() itself.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Reviewed-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/amd/iommu.c | 32 +++++++++++++-------------------
 1 file changed, 13 insertions(+), 19 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index cd2371819635..34a3b5eb8153 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -77,8 +77,6 @@ static DEFINE_IDA(pdom_ids);
 
 struct kmem_cache *amd_iommu_irq_cache;
 
-static void detach_device(struct device *dev);
-
 static void set_dte_entry(struct amd_iommu *iommu,
 			  struct iommu_dev_data *dev_data);
 
@@ -560,22 +558,6 @@ static void iommu_ignore_device(struct amd_iommu *iommu, struct device *dev)
 	setup_aliases(iommu, dev);
 }
 
-static void amd_iommu_uninit_device(struct device *dev)
-{
-	struct iommu_dev_data *dev_data;
-
-	dev_data = dev_iommu_priv_get(dev);
-	if (!dev_data)
-		return;
-
-	if (dev_data->domain)
-		detach_device(dev);
-
-	/*
-	 * We keep dev_data around for unplugged devices and reuse it when the
-	 * device is re-plugged - not doing so would introduce a ton of races.
-	 */
-}
 
 /****************************************************************************
  *
@@ -2242,6 +2224,7 @@ static struct iommu_device *amd_iommu_probe_device(struct device *dev)
 
 static void amd_iommu_release_device(struct device *dev)
 {
+	struct iommu_dev_data *dev_data;
 	struct amd_iommu *iommu;
 
 	if (!check_device(dev))
@@ -2251,7 +2234,18 @@ static void amd_iommu_release_device(struct device *dev)
 	if (!iommu)
 		return;
 
-	amd_iommu_uninit_device(dev);
+	dev_data = dev_iommu_priv_get(dev);
+	if (!dev_data)
+		return;
+
+	if (dev_data->domain)
+		detach_device(dev);
+
+	/*
+	 * We keep dev_data around for unplugged devices and reuse it when the
+	 * device is re-plugged - not doing so would introduce a ton of races.
+	 */
+
 	iommu_completion_wait(iommu);
 }
 
-- 
2.31.1

