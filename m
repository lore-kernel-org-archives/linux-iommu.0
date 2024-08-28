Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2088.outbound.protection.outlook.com [40.107.101.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA7E16B74F
	for <iommu@lists.linux.dev>; Wed, 28 Aug 2024 11:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724843573; cv=fail; b=oJ71/IdE/k6T1Tmr8n5CUd9VO6K/mkNMGfAKxh4ASf8apePCeIyXuHAlI2YUcnYxa/oKjr09oXvPPVtePLZBFniPpQ+u0Res4hXuAtyQtY9NQwg7g9Qe9c2kEw77xnGakt7oOOz2D2A0pqNVETpzcFbIb2gdbxDiyZMCmjhExCw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724843573; c=relaxed/simple;
	bh=yh+Ovxcy4u1MKkn4jjszfnudoHyYzcn+QH/iiFXFwCI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BkHrEqDDV0W7zGUrtqaAumSgcBzI/DE6X03zcpSqQWqVvmovA0pqcTWM4aHHxfFWZZFt/Njvs8QBUeJ0478GZEQolJ7ed1t3Exkp8QadzKT9xHzo0ZIv8XjQOI61HiDS0BeQQz0Blhyn7kX1di7Js7/9n1mXnpZGqFxBfY2xSRM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3NHepgz9; arc=fail smtp.client-ip=40.107.101.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3NHepgz9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SM3UHOH0Z/fbSudahznHiT/OnhyktFnxn8GJwiQAmyAlJZ0P6SDzWOwmBS2opg4A4sjoPcuLB04jslAa0T0IVr6EyHPCyntZJ/fiY8DBswbIda7C9fXlg0ov7STvUB9n3dOz1uqXpYVU3Ggp/dZu9ddiJdwkKN2x700tJfLnCvQJFyvBoUtDz+rx2qSmJX+ICExLuNC8klrqERZv13FbCDvlz5tbmqJR/B7e5TKyyWU6F9wQerJqwoIKYq9UMee3jKncFEXX8jt6/dd5Vv75RmEzmRGW2u0ADb2ErUDfENb0ClZpWVjSr3dPZo1RTp3foSvVBwmOKPbFEEvH/80Jpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z7ERFJXE/5IcU7t0Zuok7z5j7BtasBYePYI3Bfk9nSk=;
 b=WZfA7rd5PiUmEpmmMtP0tJOm0OxQsGMyCSrpahn+XPTL7abt+MtqzXTjcpQR3d4cwC6kYNICpnKgKMyht+nlRwCG1MS0C95VRMbsELpMZH5F0K+Zvqs1wGlpLQLmRd7WgmB39tiHQPxQWH355QVG3f9ONxyJ6V/voisrPphZA9HxLsaXvPQdmsjdNcETbq3H54S+/gNQkzI5syVQ5+ClAz1ASznEMD5567oQLMNxRArZI83PEwMckcQuni0w7H6rbzC5prZBVOkAr85hscfyOFTIHRwrAJB/a3w8w9YxyrLFyrufCqeje9kZT9m4y1e1d17/Xls/PNBULo0eixsxvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z7ERFJXE/5IcU7t0Zuok7z5j7BtasBYePYI3Bfk9nSk=;
 b=3NHepgz97VKtxJSgOExiEgLpNqhf9RnplFjOARDTrFN9+izTsCN9J6jNJ/IT1qWbzmrJvY8AOn0xm51fyoCmh8lfh6mxolQ01Rf9UOkFjuYuqI2oMnAMzGLeHOvnmYWLkTitPNJOIG4Q3pWYi+CJPV2F6zky1ry0z4PTYtwIF14=
Received: from BYAPR01CA0054.prod.exchangelabs.com (2603:10b6:a03:94::31) by
 DM6PR12MB4060.namprd12.prod.outlook.com (2603:10b6:5:216::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.28; Wed, 28 Aug 2024 11:12:45 +0000
Received: from SJ5PEPF00000208.namprd05.prod.outlook.com
 (2603:10b6:a03:94:cafe::2b) by BYAPR01CA0054.outlook.office365.com
 (2603:10b6:a03:94::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25 via Frontend
 Transport; Wed, 28 Aug 2024 11:12:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF00000208.mail.protection.outlook.com (10.167.244.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Wed, 28 Aug 2024 11:12:45 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 28 Aug
 2024 06:12:42 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH 7/8] iommu/amd: Rework amd_iommu_update_and_flush_device_table()
Date: Wed, 28 Aug 2024 11:10:28 +0000
Message-ID: <20240828111029.5429-8-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240828111029.5429-1-vasant.hegde@amd.com>
References: <20240828111029.5429-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000208:EE_|DM6PR12MB4060:EE_
X-MS-Office365-Filtering-Correlation-Id: fb0ff7fd-68fb-4dd6-dbf5-08dcc75257d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XbSlLFKHv34NcrGSm4frpfFD9g/LpzY5x9KN4+mo1f0qwsDEmJu5qdO0Oij/?=
 =?us-ascii?Q?3LiCCQqrAYfiAAaDcdGjbLaYC8JbPHryahpuAQuSr9TbN4OUIjy/UDc7zR3W?=
 =?us-ascii?Q?R1JGc8ukJJQjSYqSD1Ai0hopIaVZZUI1AMPmYARhtW2rNXaNeytocfPJ3YB+?=
 =?us-ascii?Q?QtC+8I2RQhSd2ZtQ9Yr3130uvNjHgFw8So+g+99b3RnIMEjfUpiKYYYfTQFh?=
 =?us-ascii?Q?xkrHKxF/R+MHrp9hIfynYrJ6BQSykpC2/DGYAVNf9Zr6Nd2aqfDvH98+Oypt?=
 =?us-ascii?Q?BBajwHIOUc8UZl9Z1s2KZMIJoqvOe2me7+01vdN+iTBpVHgq+nQkivgkZGtU?=
 =?us-ascii?Q?G02ewYwGsA/dQfa1caOk4t6Ppugc9AhunmEaoEQJVBfs7P6OjfU3Gveuct0U?=
 =?us-ascii?Q?K+owFqyvXGL4S66a2EWmHseIMATIZS8IqrSK2GD6sWGKu1cawuW3ydIrXEIu?=
 =?us-ascii?Q?NPhvYgFcVgue7EQhN01p8VHKcINK5QVI4XX5izB1gGJ7EFLVnDiFuqCNa7FL?=
 =?us-ascii?Q?sE6i4/3joAqeQCsxOqYe7mM8mgfxCqjFd1eEK37VesekiNZ9/UT6Z62qS8iA?=
 =?us-ascii?Q?RI9adm8GwU7p+3GL2IXNk/IUk4rq+sP8TGL8i0fQvUmaQ0+/8jS6sVtHXjff?=
 =?us-ascii?Q?AR+bEJzD0Z6VJhoH1DOwQskCECespx2qVGTcCQ5doxxjtXcvPzDZ5YPcXCGx?=
 =?us-ascii?Q?u8k6Yj/yUoGCBKI9wQqEUlEA6CYhco/Wn9+qtZeoUtRZXhvC6mzvNqKj5nBU?=
 =?us-ascii?Q?IfCFZMI78IW2IBovW+DLO/1nZ0xqmd0yCxkZ8nPiycN3Kg/9Xcr6u4oDdxf0?=
 =?us-ascii?Q?zybBEnpQllJ3UatRNT2170wMtX9DZPEZWNw+Nn7AM5COxu6J/5e3aGDWEAXr?=
 =?us-ascii?Q?TI/qgnIJBesKSDUVVq3GpNtfno76qzjUkwDZV61v6Hbo9Czz2wSVq+YJzHK2?=
 =?us-ascii?Q?NdteiTo40VOz3a5W+O6NWDAmOuEopD1acwuLS9Ky5cXoQz/UTYMZ9oHTsW5+?=
 =?us-ascii?Q?uI7GQtte3uo9rELepcMT7PavqFMy9i+/UN3tK0UtmQrKHJvW7wqf5CFCjxs0?=
 =?us-ascii?Q?2yjVZoNAB4ycS3vQIjZ0PYH8P3Q22zlyxR2IObCz4GcsiZ+fEZnHnRMWOJL9?=
 =?us-ascii?Q?/BuLF4wC1lm8Khmsgf9ZmyiDqmqmKhIVxriDX9/JVE3GfIE9PQ8pYQvgpJdT?=
 =?us-ascii?Q?TSWEjfx/tZokV61SXZ3axeTfa4URjcuFQ9srUABLYf4VOqtdN7p9OBOwzm7X?=
 =?us-ascii?Q?4rAWsUs6/7sxwRPLl56sRaMiRAC1yL97+Kl/2G0WRy+5nz+u1uWiI1csBcAz?=
 =?us-ascii?Q?IgaKUaCMj3aC+O8XqnB3v1ypKgVsSYfJRtyeYm1GNSrIkgqv1xJ/ayO5Jpau?=
 =?us-ascii?Q?FLN9Eu6ZAJYEzmq2uH0hY2eThKgSGfZ3JRudGTEJsd+3eT3OhKIJd4iL0Z8y?=
 =?us-ascii?Q?VED05v1KTDltgV5iJ18woxy4Z/dbrr4a?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 11:12:45.3174
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb0ff7fd-68fb-4dd6-dbf5-08dcc75257d4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000208.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4060

Remove separate function to update and flush the device table as only
amd_iommu_update_and_flush_device_table() calls these functions.

No functional changes intended.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/iommu.c | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 56c51b83ee6b..808959be0902 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1591,15 +1591,7 @@ static void domain_flush_np_cache(struct protection_domain *domain,
 /*
  * This function flushes the DTEs for all devices in domain
  */
-static void domain_flush_devices(struct protection_domain *domain)
-{
-	struct iommu_dev_data *dev_data;
-
-	list_for_each_entry(dev_data, &domain->dev_list, list)
-		device_flush_dte(dev_data);
-}
-
-static void update_device_table(struct protection_domain *domain)
+void amd_iommu_update_and_flush_device_table(struct protection_domain *domain)
 {
 	struct iommu_dev_data *dev_data;
 
@@ -1609,12 +1601,10 @@ static void update_device_table(struct protection_domain *domain)
 		set_dte_entry(iommu, dev_data);
 		clone_aliases(iommu, dev_data->dev);
 	}
-}
 
-void amd_iommu_update_and_flush_device_table(struct protection_domain *domain)
-{
-	update_device_table(domain);
-	domain_flush_devices(domain);
+	list_for_each_entry(dev_data, &domain->dev_list, list)
+		device_flush_dte(dev_data);
+
 	domain_flush_complete(domain);
 }
 
-- 
2.31.1

