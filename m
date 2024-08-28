Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2052.outbound.protection.outlook.com [40.107.92.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 457C1282E1
	for <iommu@lists.linux.dev>; Wed, 28 Aug 2024 13:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724852784; cv=fail; b=eJ4g4U5ZxoN7GjQMt0qJ4kHNj283BMv/Hq+ZeRbzQCt5Ehgr0Yowoa6T3YM3WxXkTMVCmKa5i9Be+7A2RjZEciSKKmbXuBwy7OwgdAMURPDS5zi3/DyvFD0d2VtI5Q2gKDsBDa8s0jk43RYr9fpYHW+13KEwF00E4IrhmaMt6jw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724852784; c=relaxed/simple;
	bh=jE1hxwxDUaIbQLIdPtKm6s6kd4RKEDcA9wZCyQwJEu4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LLtkPRujjl6YGKvj87d7T/g+O/Kh3auWJHfTEhiKtEblLFGDHlUWj5co0nfuUD89n1kemzYieZu79geH4HSSurHOpxTiaZt48tXuc66mZ5oCvkVIe3YRrHE0pSDTu06rkHDuW3pGM83TkmD3dHcAQ4gbodu+L0jCdAPDMe/2QdM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=24DZ97ww; arc=fail smtp.client-ip=40.107.92.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="24DZ97ww"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hs7+QAjQJ2LducnY2CxIcH/vlT+xI8Y/Ba32KqxP+ZW1TZEeAezYCluu1y/ZZCA/WFx7WW+0BspyaVAUO9YHGufXfEWfk5o5XWk5+a/tQPM3K8bhztU4HQFtFKgrkl3luDYZPnThJrygXidx8OHTJz9L2R+VN5FjEcFooH4HhGdjV+pv/tm4o/JTlHfPbbfVHC9WWv4l/TG4VHQKZWMqpVo3DRd98Eg9THYsZKP9P736JgQ324l9kxe7lKfw/d8wxMBIfJVbxoXSI0kqqQAYKvTVaQ9nsR8sfk7xlREyXFTbv/jHVcxyBvgLSwOq9XvpgtkkhaM8in2Atj+OnF2SXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xAmlfB7M0kGJ6IZBzjBDKcSYAZxRLdiMjfPhAqizoEI=;
 b=lmbtPvI8NR2SCdWTjx+bydT9/LrOYhzj19uGt/mZtF9I+Kfd99Ot3RM/fRfpEHHb0gU6kwFeZryJfWpc2iCE8eLC8pzTsyvMTP+Tm2kuw4K9xgylZHoxwof1UHHScPH67XA5aBF7qdAJD61Mpo2TceBjVbc8L4VDmqxf/WUnmlEO+NyiNe8AmMz780+b+15If7YZ6vrJxEJTxoKg/XlSggs5LhqFOJF8ud6ehgHgOqfWsbN6PK+NhWAPQyh5FJIH13MMKmFS120F1oBPCr5zy96OrrWdv4zUCAdgkBbdTtzTo64/uzv1a7J4/MdsiRmoyFEK3LYG6qnAd33BmXfL4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xAmlfB7M0kGJ6IZBzjBDKcSYAZxRLdiMjfPhAqizoEI=;
 b=24DZ97wwd9iPSUb/o/K3NYSlJyLgubhyZ5nZ4yGRfYVlieLiFwrz1nFfmfBVwnIT2KsNHdfrB9Ve8rDnBrZKGhNErgewboG1aDbLxD0iJxQDljJHpApNg3ErGohIIFgTQIxhW5e+A0MqHopnpuoNN1QTxMHE+l39y6VcRfBCV2E=
Received: from BN0PR04CA0102.namprd04.prod.outlook.com (2603:10b6:408:ec::17)
 by LV2PR12MB5920.namprd12.prod.outlook.com (2603:10b6:408:172::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.27; Wed, 28 Aug
 2024 13:46:18 +0000
Received: from BL6PEPF0001AB71.namprd02.prod.outlook.com
 (2603:10b6:408:ec:cafe::8e) by BN0PR04CA0102.outlook.office365.com
 (2603:10b6:408:ec::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.27 via Frontend
 Transport; Wed, 28 Aug 2024 13:46:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB71.mail.protection.outlook.com (10.167.242.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Wed, 28 Aug 2024 13:46:17 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 28 Aug
 2024 08:46:12 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH 10/10] iommu/amd: Improve amd_iommu_release_device()
Date: Wed, 28 Aug 2024 13:43:17 +0000
Message-ID: <20240828134317.6239-11-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240828134317.6239-1-vasant.hegde@amd.com>
References: <20240828134317.6239-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB71:EE_|LV2PR12MB5920:EE_
X-MS-Office365-Filtering-Correlation-Id: bb222adf-53ee-487e-cfbe-08dcc767cafa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FKFM27Ag69OlgICyaIry7ual619F6UpFHEVevAVXVHGS6vsUsafK1ctuNu/V?=
 =?us-ascii?Q?ZA9fW1gwvWixq0+GXnVx1frkFR/WOt4RAeISreyPOgERtAW36YybXx9JECO2?=
 =?us-ascii?Q?+WLE1uAFKeaMVBzHyKzI7SxjwhUVkFostu64Risn05bAmi3C0CxToFCuPJZn?=
 =?us-ascii?Q?/tgjaSJjYNe5Ktj7wdqNnAcRwVhMHK8OOpT1/MzhRaUGo+EdMqpUISLLQ2pV?=
 =?us-ascii?Q?CXcRD1AUP02H6MGwMEgYpXY93x0E2TsAAXrfmtXbkm20JHhYvago0/9GJk2+?=
 =?us-ascii?Q?D2AS6ec4SB8jWj8wmB0Kre0RBWAAYtJHLVpAKKg7GUBA6w62xMUXSlVhJJAC?=
 =?us-ascii?Q?BPtQ9uG8a7bX9ClXXLscPv1abnpHtBn4v/YATMC+GWnfk7i+tMTiFTQeFvsy?=
 =?us-ascii?Q?xfMR7V+xeiZeJn1egZDDIvf2N1Gfa4qgtFvX7s5KypVilJOt5ibedQGxfXtb?=
 =?us-ascii?Q?tgMdyXWfo3GnPHbXh9+p5easIbNhb+VZ1D5KBsTcR8ZfPJCMkw8NuzLsXcB5?=
 =?us-ascii?Q?MQJIhc/5jPHIDoNdmzB0+yIc28lUDsvbDDG0764ZMMIaWjsbfdNEBXKzUv+S?=
 =?us-ascii?Q?JZJ8o0KHBjt7kjF9QXk2ybr1J9ZBfhQRG4UJeV6Fgj5VRJOeUyH8TpOADMyc?=
 =?us-ascii?Q?n9nG1nIb3Ow8kLYrX7oOv4l3NbfPmrpQFYQCO1x3rWlfeXC7NASPlV/8fYwV?=
 =?us-ascii?Q?B/o/EP6uQLlaySukQu2KubE8exqtVQM/A/kVwzMzSM4nDSnv0DHM/Y6Ehe+S?=
 =?us-ascii?Q?l6ezjR1cnqt6oBst8dm1Pw+lepnXd+Djo7YjRvlhD2oPYwfBVuqTBkh1SrWR?=
 =?us-ascii?Q?oytuIYq1eEVVdPMMjT9KglnBYLxEq8/B8Mkos20V/KHN6I3hmti0xIOJBjU8?=
 =?us-ascii?Q?eiYQD0du0hTS1oPNR/GXncRh8pixhwKVj4+CCcFeNHjrg5AnKaZ2AGXkI+W4?=
 =?us-ascii?Q?q3s7d1R4JHC3CEZ8h2qjHMG//Gft2WadPzWkMKJEA7LNdFlwRtg1VhGsxyXJ?=
 =?us-ascii?Q?MQIfLhhabU12q10X801fQkd3tqUp9wTT/fHKvVtwBTJSa2UMoAKyJvXdf1+3?=
 =?us-ascii?Q?/E0WPP6oxJ3LI4C8nxSRKz9s9GjEp7Z/6tER2AW2rLp4Nv62YNbhra79PSaS?=
 =?us-ascii?Q?maLIYit7AlUwmdt9F6wCDD+TvCNA9XUa9aPNWJocVufjibmaQ0CxJT2HDSWl?=
 =?us-ascii?Q?nOrWoWoxa44X4Rwk85O3SavkOMxTCZi8hDHudqbVeiwmH4mBhKhTiTeufikn?=
 =?us-ascii?Q?j/EIOw5SH0MHQK3IuQzyXaBDUWil8fyy3IU6r/qOr4RisRPSH2pHw8tvKVUN?=
 =?us-ascii?Q?aytq8QDegpsXzjE3EaM6N9z8clURUeZpK84iHX1GDx7kAFywm2DKPCB9Sh3C?=
 =?us-ascii?Q?dyRHgN0YuOqA58l42m6iz6G5+WfYAbERNB3bpFywyj4ZE2wUUsI2QQkNDdyV?=
 =?us-ascii?Q?nXHKHCtGChAaLJ4h7P0q8IqPVBHZg4js?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 13:46:17.9980
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb222adf-53ee-487e-cfbe-08dcc767cafa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB71.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5920

No need to have separate amd_iommu_uninit_device() just to check
dev_data and call detach domain. Hence move these checks to
amd_iommu_release_device() itself.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/iommu.c | 31 ++++++++++++-------------------
 1 file changed, 12 insertions(+), 19 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 21e5a894e0f6..0286f987f7af 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -79,8 +79,6 @@ static DEFINE_IDA(pdom_ids);
 
 struct kmem_cache *amd_iommu_irq_cache;
 
-static void detach_device(struct device *dev);
-
 static void set_dte_entry(struct amd_iommu *iommu,
 			  struct iommu_dev_data *dev_data);
 
@@ -562,22 +560,6 @@ static void iommu_ignore_device(struct amd_iommu *iommu, struct device *dev)
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
@@ -2243,6 +2225,7 @@ static struct iommu_device *amd_iommu_probe_device(struct device *dev)
 
 static void amd_iommu_release_device(struct device *dev)
 {
+	struct iommu_dev_data *dev_data;
 	struct amd_iommu *iommu;
 
 	if (!check_device(dev))
@@ -2252,7 +2235,17 @@ static void amd_iommu_release_device(struct device *dev)
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
 	iommu_completion_wait(iommu);
 }
 
-- 
2.31.1

