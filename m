Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2043.outbound.protection.outlook.com [40.107.223.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B8715B98E
	for <iommu@lists.linux.dev>; Wed, 28 Aug 2024 11:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724843554; cv=fail; b=rECI++JtXxcZXtXw0LfUmqSsSktOe3YhtGs3hxoNni8rdaJ0pzN5/nZnrf5ZryeXPnTgRbF/XzxDspg2afz7HIVv2d1kHHbbWn3jc3b1lN9lE/ifQ7ttU8z+jzglIA6H+XpZxoil5+Wmg/85g96Fq9REw48Kj9RepZp16IkqVao=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724843554; c=relaxed/simple;
	bh=+etphOao3oS6qeukaRdgrtWfDwoOUj24EgjrWB4Nex0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Sr0YQTV+NvNcQR9TcIfMPDBj1ED348rkhQmTALIPniz3TS0EZyphFuQPTEIQ46Q3VfungEiBviLF/80YotgRQi0Usb+wc5oSBP+p3S5mcCRGgDorYstFDRCfldZa9G37dhjHEx1aZRoCejNGyxR9432ssEvTjvZEoLmJBmvbRsk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jKIA7Jcf; arc=fail smtp.client-ip=40.107.223.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jKIA7Jcf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vWRsRy1gv5cJSq8CODIvTKVpje9ZusnHo6JxZzJ8719M+stBGFB2QkFzkojx0QErRTQKkGCy36pV1EQhJqO3n+gOaf7lI9RhYdZ50JNZyH6JmCHtd68ye8XKKHr7ZC0v95qCKGqaJQEjlilNnRNTYRsLrJ0ye0SZG0wPWuTAQGJjBzmhAI3ZIt+nbnuQ8enD4EpmkwNq4cg/BZd0oBR8mmmm16p+JR8bIyfhjUVkN5ZO/9Ij+4Mw2OkuYYa8wENxvhVjyUcOoA9lGZPtYllExXg7q2sN0DSmjWw91/s7Se/0423NaCu/EDsjaiFEy8KZkBlZjvv1R2wtbzM4dom5fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=00DU6WzeIWutDbmmLZ1gMWPuS2Ac8A113T+Sv6R8lDE=;
 b=uf2+rpDFfwVQHUdVnKkw3yGff1vk12KY3nIT+ImlqDIRTEHQN++1c0W3T5Lrz6gVU8193PB8cTYrBt7muDlfzc3Pb2YcvVifKiy6AAHnoQhvfEEou90ri6guTrvq3LnvYR/yj09PN8y67XfY4T3uEF2GZpIqszgCuKP79SSR+iUZzwkLGjl3vwPsRHbLhx2tZI+QCyAnk5Io+RIJJ4PgDuOBit+YIIBkL+Dsh16Z48gP44/vg9j30XlzdCH0alVjqK7BRdui/exMA+0/SOukQYVtOwrqbqXbHRfxJ26c5dNi3ARRjHHdkgOMLuiphPHNxbGQGLf+gkpQc8pUQ7dhxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=00DU6WzeIWutDbmmLZ1gMWPuS2Ac8A113T+Sv6R8lDE=;
 b=jKIA7JcfFV2loqdJ2CjJ4riBR1oErLOjbeqO0hZ6hQqmpg3pbqw7glsCPQlWBgdoznHlbSMrZha1aLposZshPKW08J9Pvq0JZhhR541VDrBLeS/LxKXBlRdryWcV9b+8GI6HE+b5W24E3g+XzrhiUh6Dp1wFjVsJH1hydR8+wxA=
Received: from SJ0PR13CA0116.namprd13.prod.outlook.com (2603:10b6:a03:2c5::31)
 by PH8PR12MB8430.namprd12.prod.outlook.com (2603:10b6:510:259::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Wed, 28 Aug
 2024 11:12:29 +0000
Received: from SJ5PEPF00000207.namprd05.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::43) by SJ0PR13CA0116.outlook.office365.com
 (2603:10b6:a03:2c5::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.19 via Frontend
 Transport; Wed, 28 Aug 2024 11:12:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF00000207.mail.protection.outlook.com (10.167.244.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Wed, 28 Aug 2024 11:12:29 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 28 Aug
 2024 06:12:26 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH 6/8] iommu/amd: Make amd_iommu_domain_flush_complete() static
Date: Wed, 28 Aug 2024 11:10:27 +0000
Message-ID: <20240828111029.5429-7-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000207:EE_|PH8PR12MB8430:EE_
X-MS-Office365-Filtering-Correlation-Id: b753f807-dcd3-4d58-d062-08dcc7524e7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZPOrbyZic1tfubnOdj3oYzKZS/TM9cgXa1HW66yhYdvRWzTPjRkWnHcGOuil?=
 =?us-ascii?Q?YZPpxz+IKFQKq11Ahy35ac+mOGBdBg8DQmssjEb3gmRIRIBZ4W+GIyxxr1OF?=
 =?us-ascii?Q?0N8c2Bs2UdiHqRifZwcE9vKI4P33N+WMlDS3Ec/WMVJmCimeEk4o6W6U/q1x?=
 =?us-ascii?Q?O/hAutKni9izK8hB39mB8lQ8WdAakW6KSl+wQxy46gQUdNOxXJ7bbfAczo7A?=
 =?us-ascii?Q?KI6SNDrM7GC8idjfJyuhx8VUoYw0W5XcYHfXkuV6BxJF7lsO1RtmDT7x5IPA?=
 =?us-ascii?Q?4GGBlAGteNbx4yioQ63PmMOufKA7fJxC+QuQRXpCYwpHUemWvm0ShsgE+fWy?=
 =?us-ascii?Q?wzym8qp4cNDsryIM6Lh5Cg+gvETW8xMwuUy62daY+rmIdPLcf5Q3sLIz8woW?=
 =?us-ascii?Q?Z6ShFgmU+NQLHkepdbItQ+4wthOids92ZEOoi097VjL4xeeriVbDGFZmo7rU?=
 =?us-ascii?Q?d4QJXvOMtmI3LfDx8ymwI2CLtx0EN5vZC1HPlHa+jJk+fhnMQx0iZNOkLH0u?=
 =?us-ascii?Q?aGx7yolpLh41YFPNZP6pz21An5RzqbKeQuKzoYwTmWkzJ7pzNDfTaDvYjf49?=
 =?us-ascii?Q?v3vGU/POK4uxBCiabP5T0fz0Wc2V9nLtQxU7MLAxBNP6NIVBGW87ym73gz/C?=
 =?us-ascii?Q?Fwld8kYVutB0xl4XLnqhePqEVwQUbI/hnnrbEs30yc0lDWFFDZh88Gpa/dQ7?=
 =?us-ascii?Q?+SYve/NVeGlgoJiUbtSRToxpnulsTQKLyST4F4dalZrAOhwtNdqKWe/c+jv0?=
 =?us-ascii?Q?98rakG3wZiVxyJp2c2scxOhL4sinc+MfAOw9CcBAT7lDWljBxDwx6NqySWGK?=
 =?us-ascii?Q?VKQn1v0R3zZwQ8YZ/2Cn9sOQ2Bp9DpDmEOa8XUUhmmm0cwjKL334CpAA+79t?=
 =?us-ascii?Q?WbOS1r6OQxAMxBILyxsP/fwuqrkzkFJwwrFA8kShi8C8a6ACY3gWzHXdpxQA?=
 =?us-ascii?Q?IUkhaHZsgam5I5Sv890FRkHtSOwuYD7KRz09Ksr7Qz9nrSj3jQoGz8fUbNXC?=
 =?us-ascii?Q?giWlv7AEJCQYIsagXgBBCliha+0aT47GUKSnjs6bBaHCqRVq1YeLzlXus4Qo?=
 =?us-ascii?Q?kG0gkhonISPEQDZ6NrhKdzco8N1p760VWdAX8Ccx03vCIOvO/00HRQiOjnuU?=
 =?us-ascii?Q?7zChkvlM+1ic9JIE3giXAPvMK2lgijEgOwYzF5O6QdE7mMdeWI2fCNhEGlD3?=
 =?us-ascii?Q?b2EI7gYlnLEztv3VhECR3qgOmEnvmIjz/FqPNDP2sjTEiAv7BjkYvU6zTH47?=
 =?us-ascii?Q?wCc49/4iNJWxPWQDE9TafBs41LZj1a/0bB+Gcj0+BGfar2eh7dvknzuL+7T1?=
 =?us-ascii?Q?HP+muhTDjnBGOUwmdADajoQ6dWGWHLN6hvTjjdxuKmwSIMnoZlFU8DOICMZd?=
 =?us-ascii?Q?e9RuoPwci7rb1aT36OYYx8GvPEzY3SaSU1PFtYMYHWe0uqZlheKNEzbCl0rR?=
 =?us-ascii?Q?jgl0eg8IqweuALOvFZpjZNVQwlFzkbq7?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 11:12:29.6319
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b753f807-dcd3-4d58-d062-08dcc7524e7d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000207.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB8430

AMD driver uses amd_iommu_domain_flush_complete() function to make sure
IOMMU processed invalidation commands before proceeding. Ideally this
should be called from functions which updates DTE/invalidates caches.
There is no need to call this function explicitly. This patches makes
below changes :

- Rename amd_iommu_domain_flush_complete() -> domain_flush_complete()
  and make it as static function.

- Rearrage domain_flush_complete() to avoid forward declaration.

- Update amd_iommu_update_and_flush_device_table() to call
  domain_flush_complete().

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu.h  |  1 -
 drivers/iommu/amd/io_pgtable.c |  1 -
 drivers/iommu/amd/iommu.c      | 37 +++++++++++++++++-----------------
 3 files changed, 19 insertions(+), 20 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index d0a24ec3ada2..94402b88789d 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -88,7 +88,6 @@ void amd_iommu_flush_all_caches(struct amd_iommu *iommu);
 void amd_iommu_update_and_flush_device_table(struct protection_domain *domain);
 void amd_iommu_domain_update(struct protection_domain *domain);
 void amd_iommu_dev_update_dte(struct iommu_dev_data *dev_data, bool set);
-void amd_iommu_domain_flush_complete(struct protection_domain *domain);
 void amd_iommu_domain_flush_pages(struct protection_domain *domain,
 				  u64 address, size_t size);
 void amd_iommu_dev_flush_pasid_pages(struct iommu_dev_data *dev_data,
diff --git a/drivers/iommu/amd/io_pgtable.c b/drivers/iommu/amd/io_pgtable.c
index 1074ee25064d..bfbcec68efb9 100644
--- a/drivers/iommu/amd/io_pgtable.c
+++ b/drivers/iommu/amd/io_pgtable.c
@@ -175,7 +175,6 @@ static bool increase_address_space(struct protection_domain *domain,
 	domain->iop.root  = pte;
 	domain->iop.mode += 1;
 	amd_iommu_update_and_flush_device_table(domain);
-	amd_iommu_domain_flush_complete(domain);
 
 	/*
 	 * Device Table needs to be updated and flushed before the new root can
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index c06189a811ea..56c51b83ee6b 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1249,6 +1249,22 @@ static int iommu_completion_wait(struct amd_iommu *iommu)
 	return ret;
 }
 
+static void domain_flush_complete(struct protection_domain *domain)
+{
+	int i;
+
+	for (i = 0; i < amd_iommu_get_num_iommus(); ++i) {
+		if (domain && !domain->dev_iommu[i])
+			continue;
+
+		/*
+		 * Devices of this domain are behind this IOMMU
+		 * We need to wait for completion of all commands.
+		 */
+		iommu_completion_wait(amd_iommus[i]);
+	}
+}
+
 static int iommu_flush_dte(struct amd_iommu *iommu, u16 devid)
 {
 	struct iommu_cmd cmd;
@@ -1485,7 +1501,7 @@ void amd_iommu_domain_flush_pages(struct protection_domain *domain,
 		__domain_flush_pages(domain, address, size);
 
 		/* Wait until IOMMU TLB and all device IOTLB flushes are complete */
-		amd_iommu_domain_flush_complete(domain);
+		domain_flush_complete(domain);
 
 		return;
 	}
@@ -1525,7 +1541,7 @@ void amd_iommu_domain_flush_pages(struct protection_domain *domain,
 	}
 
 	/* Wait until IOMMU TLB and all device IOTLB flushes are complete */
-	amd_iommu_domain_flush_complete(domain);
+	domain_flush_complete(domain);
 }
 
 /* Flush the whole IO/TLB for a given protection domain - including PDE */
@@ -1558,22 +1574,6 @@ static void dev_flush_pasid_all(struct iommu_dev_data *dev_data,
 					CMD_INV_IOMMU_ALL_PAGES_ADDRESS, pasid);
 }
 
-void amd_iommu_domain_flush_complete(struct protection_domain *domain)
-{
-	int i;
-
-	for (i = 0; i < amd_iommu_get_num_iommus(); ++i) {
-		if (domain && !domain->dev_iommu[i])
-			continue;
-
-		/*
-		 * Devices of this domain are behind this IOMMU
-		 * We need to wait for completion of all commands.
-		 */
-		iommu_completion_wait(amd_iommus[i]);
-	}
-}
-
 /* Flush the not present cache if it exists */
 static void domain_flush_np_cache(struct protection_domain *domain,
 		dma_addr_t iova, size_t size)
@@ -1615,6 +1615,7 @@ void amd_iommu_update_and_flush_device_table(struct protection_domain *domain)
 {
 	update_device_table(domain);
 	domain_flush_devices(domain);
+	domain_flush_complete(domain);
 }
 
 void amd_iommu_domain_update(struct protection_domain *domain)
-- 
2.31.1

