Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2043.outbound.protection.outlook.com [40.107.223.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A23113AA5D
	for <iommu@lists.linux.dev>; Wed, 30 Oct 2024 06:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730270823; cv=fail; b=JbpXGvq+VPSZ6Ae6GtMdSrqZULn931f3VZNUE0C/qONvdXx/uoLCYAbAbonGKgMP0EX4YgnuYuldK6IMIf9MOrBM0fPLdnIRMY5AfApt/09wx0RvFV9XXO40lzUblRKDKvpXvQA3dlciiwP71L1iQyCRXlfVrjgXDhZsPAMQGyM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730270823; c=relaxed/simple;
	bh=QFsHOpBehy/XI00OyqOP5FM+1Md2xU+z/frRzdtUfZY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m0KU0BZFy/LBBKTKXQC5OvoS2QLGmzM0S4k9onVonDqnbHCLjgzKcEGsmWL/wexGD441/64FPtW/DQKGOdesE9nCCIOFtueqrUFOKKW8JqQJTQ0RSltzl0OXYnu2qG82tcUX9WHKQ2v1ycx7HagyP3RnhDKRyTcbAz6CUKE71Po=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vYHJZ9Bi; arc=fail smtp.client-ip=40.107.223.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vYHJZ9Bi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mI3+COziVYq5e5ifd/SbXvKMFbjWhJQgE0kT99CtXdvn2PxThvRHogMljTjEarm1ZOd39ExonHjY016SLEL0x73/jEGs0VfMz8FToHhWUOVu5yDY39d9Yu6BW6vY4ruIvVPI87NJfR+yrwU02IOh7eRutSyoutB35sJwu7hvU5LdCQ0e/gMh5kSC3xyhVjXu4HX/6TpvcHaEd9EMR5MYTw8si27acZkodFZyfzmFbunWojZC9sB96KM9eVMLwN3TUn2aFHogScVRwnPuKWUOuawZC9QOfa7m7trHf4qHpj2uaZY1Gu+92KNX3W8ywFJ72UV6GIZLeGl6a+9C9F048A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VuF4eWufMWTRL9rHqUxh3uljDJOeb191kJdNNMALkCA=;
 b=GpqO3ObLLQ6hZFjD+OHhQ/+5A6Tqvo3pOEg9iQW7mlHo2/CHiuwx+C8QxHrtLzQRNxzog9/3qHMHlJwStGI2gIeUS7XEiTC6sX7KmnCxsnt9EUBDFcR/jozEUzV1vzi1m4bAzSZVN2h4IZ9xCFqMpQgXGJo6zQjbTQoIgmO+5uNlOc3BmHr0xb4Q/Kp/hPyo/ESZQbCw9We20h6hN6+9ECwL6fCJxy8gL+BIBl0XXsLZPoRzN+rWnyh/z0YhOc+j3Tn/APYMGeAgmVHPe5QmWe7kdPntzAMGoSS5iR4OPJl2ccrBpz9+hI3eJWKAFeUe0TLym1ki2SN6xYOk+sMRdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VuF4eWufMWTRL9rHqUxh3uljDJOeb191kJdNNMALkCA=;
 b=vYHJZ9Bibnw33H/pFADFLAdezLQofA3VNvG8oyauxwFaIRymU6A2S39azsh8mRow92GocqP1OXUCKgtrjEomV0XV9TVTtVui1BzuGCHlGNIZyGcx/wqXLlsQza04Z8Li8BJ5VpApNusI6VWdAP5LrKzS4bXjLFOelTrfDLMfNAQ=
Received: from MN2PR05CA0059.namprd05.prod.outlook.com (2603:10b6:208:236::28)
 by IA0PR12MB8227.namprd12.prod.outlook.com (2603:10b6:208:406::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Wed, 30 Oct
 2024 06:46:47 +0000
Received: from BL6PEPF00020E60.namprd04.prod.outlook.com
 (2603:10b6:208:236:cafe::cf) by MN2PR05CA0059.outlook.office365.com
 (2603:10b6:208:236::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.17 via Frontend
 Transport; Wed, 30 Oct 2024 06:46:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E60.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Wed, 30 Oct 2024 06:46:47 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 30 Oct
 2024 01:44:55 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, <jgg@ziepe.ca>, Vasant Hegde
	<vasant.hegde@amd.com>, Joerg Roedel <jroedel@suse.de>, Jason Gunthorpe
	<jgg@nvidia.com>
Subject: [PATCH v5 06/12] iommu/amd: Do not detach devices in domain free path
Date: Wed, 30 Oct 2024 06:35:50 +0000
Message-ID: <20241030063556.6104-7-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241030063556.6104-1-vasant.hegde@amd.com>
References: <20241030063556.6104-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E60:EE_|IA0PR12MB8227:EE_
X-MS-Office365-Filtering-Correlation-Id: 01efa712-91e5-4726-c60c-08dcf8aea061
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?R53ZbeaGIZQ6J+eDltuH+a2MdbTxL8QHB8rrc3R4MM51427i729sW6pjJVHB?=
 =?us-ascii?Q?/y+zrTUDT1yu2d4xsRjRl3Um3KFPSQBtCaWQddCYKNrKU/ushiUVQFf4E15l?=
 =?us-ascii?Q?kXyyjrKMEkBFTmnwFE8pGAZjAdBgtEAdC+TxOBMBFryyCWB2wWPWMupZM7D/?=
 =?us-ascii?Q?pQ0kCtEks8W9BeGK0b/tlVtUzuKBWwHXBTPmbn7JFi1px02PzWkZLKi8T32G?=
 =?us-ascii?Q?8Phkxf+Q5lydsf3GGdYSsgUit2c0hCnHH9bZd+1SNbo6WO1hwJUjUvWFVGlf?=
 =?us-ascii?Q?5cxAzJoPerA1roXKkkIN+3Yi/UZRLzqWfu7QXc0PCkECp/1jXqXhgwrMOoUZ?=
 =?us-ascii?Q?S9QEH3nexKbbUpRGJG0LarIoD19KcFlWKvrCnHuKiqjdT7XdczXW2wYhUC1I?=
 =?us-ascii?Q?FZsqUpmnc+/L06qjbnNPygiTYI1L5dBum6vt0EedticDcGIiKT7qfChKofna?=
 =?us-ascii?Q?T/xpGMRTZgSlrG081nKNR0zxl/cESHj6HTeThyul6mnQw70CSisRLFoFiF2y?=
 =?us-ascii?Q?XZyqdpuCZmpFN8dY7kYOBmu4iVlmcXMTkEYG0t+9dj/TfSL+KNB1A/u4dLXV?=
 =?us-ascii?Q?y8L1KTI82qSNHhOHTmak3b8H47GhoCjDrztXDxLmQQyTbera/816NAX7xdm8?=
 =?us-ascii?Q?Fs/oFKTxaJGZFR2OvWLbX3jtQdFHP3DbMGJecu6fwQuwZcMgl00wr2nx/9Hx?=
 =?us-ascii?Q?VgMbS1ux0bHcwr0Ys/yTpTjsEpoAP9utv5DeEUsHtoBhsMIEgWIUD/Hv6dw9?=
 =?us-ascii?Q?+HWfa780XwhdW9X6qzLI8M1meYZE3VyZCZ6/GMTwaB6bqafYXlZJRfcrmvr+?=
 =?us-ascii?Q?tGEesItdX+QdEUX8XIWvQB61M+3HTu0k+6bOjnYCnM7ptV+M+xOAjdeunMtS?=
 =?us-ascii?Q?SnYUcHgW2T9ckuD/r+nTuicCy9tIFdAwAar7G4bGVmVDgXl39NQ6/mqmGqsX?=
 =?us-ascii?Q?ZN6Uh/mT5WmRPJN95rZZwtrtSpXK6O9D+Lj764TujoORB45Cb4A2SpXz5vMa?=
 =?us-ascii?Q?AyuKicLwyv73RncpF5eqpNtD5qcLnc5tdeCeG6kTr84AFKLerDr9TcHkNGJS?=
 =?us-ascii?Q?NYeX2IimaHGmyxuNyRQG8o8VG4XA5GE2HTjT7NDpv8qbIKT/N911+8fIDvnO?=
 =?us-ascii?Q?+McqXY73jqtz0EubiAdv6yjVHfkAE7/1HknoUvQyWw88cr1DnkAOz5U+7JNg?=
 =?us-ascii?Q?liht3uK4p+Ca17FNwThahJezGwSglF3faTGUyUqfgoucDJOT7h/H0FQVuHva?=
 =?us-ascii?Q?geC7nce7zLDtbHkwtWb8Ay8sWuUvGFqM9NPADpluwB1UQtRtm80Tkp7HFd9M?=
 =?us-ascii?Q?mE0kEN6Yiaa/KkHLuk76FX7H/mMppRvgnPz0tDPbZUewkiNBWn/aV4OdNiYj?=
 =?us-ascii?Q?zlzoM1wcldbGZiNVAjQEOzY8x1RTKBiVG2JKKDPdanl6AAl0Vw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 06:46:47.7746
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01efa712-91e5-4726-c60c-08dcf8aea061
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E60.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8227

All devices attached to a protection domain must be freed before
calling domain free. Hence do not try to free devices in domain
free path. Continue to throw warning if pdom->dev_list is not empty
so that any potential issues can be fixed.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Joerg Roedel <jroedel@suse.de>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/amd/iommu.c | 26 +-------------------------
 1 file changed, 1 insertion(+), 25 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 0bbe22c3544a..8f0fe2c70adf 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2279,21 +2279,6 @@ static struct iommu_group *amd_iommu_device_group(struct device *dev)
  *
  *****************************************************************************/
 
-static void cleanup_domain(struct protection_domain *domain)
-{
-	struct iommu_dev_data *entry;
-
-	lockdep_assert_held(&domain->lock);
-
-	while (!list_empty(&domain->dev_list)) {
-		entry = list_first_entry(&domain->dev_list,
-					 struct iommu_dev_data, list);
-		BUG_ON(!entry->domain);
-		do_detach(entry);
-	}
-	WARN_ON(!list_empty(&domain->dev_list));
-}
-
 void protection_domain_free(struct protection_domain *domain)
 {
 	WARN_ON(!list_empty(&domain->dev_list));
@@ -2482,16 +2467,7 @@ amd_iommu_domain_alloc_user(struct device *dev, u32 flags,
 
 void amd_iommu_domain_free(struct iommu_domain *dom)
 {
-	struct protection_domain *domain;
-	unsigned long flags;
-
-	domain = to_pdomain(dom);
-
-	spin_lock_irqsave(&domain->lock, flags);
-
-	cleanup_domain(domain);
-
-	spin_unlock_irqrestore(&domain->lock, flags);
+	struct protection_domain *domain = to_pdomain(dom);
 
 	protection_domain_free(domain);
 }
-- 
2.31.1

