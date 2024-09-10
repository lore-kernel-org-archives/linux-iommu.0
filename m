Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2079.outbound.protection.outlook.com [40.107.92.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18E11779B1
	for <iommu@lists.linux.dev>; Tue, 10 Sep 2024 06:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725951598; cv=fail; b=luSL2ULLXFSZFkYOZMIJntpV6WI6D55U95pkfbexZ8W7rSPAVzPcEfIoa7rbAzNGBHswYZcS+SkUBteflZQAXFS6aQCYMsBSCqCp9cECCJdUScMGlSuL9hO9GG9Nsq7zQGmzVBLzxy1LjPQPXTY5ZspECntgk89YLhWH850fpK4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725951598; c=relaxed/simple;
	bh=VeTpKBWYtE/WEjD9jazArvPAABt6SC1iOgPZ3yDuTUo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Os1L0K0j3yWeinCvSRPvXiis5goUj3XT8+bCdS9G7Zy1yPtyVcuZPUUzR5PuF+e98ol1mste6zdzLn9KHmwOIbg17a13lgCwcZmWV3Z9Wa94pBgVbLj8q/xASx7wH5MxM4d1Xfb1FeFk/Jvzy9ElZUDIGHkrzy6tRQXh4nwM+DU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lBIGwfhV; arc=fail smtp.client-ip=40.107.92.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lBIGwfhV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e60pBEWJ1/AySDCp2kP5be3ftNtfW/99fIZUNUJdMM+OU75rLB73CzASDeIwf0uLxiBmWGpF4Ig38lE9tj0pY+qJV5ev4fiUSaikpo9adTI6d5aMQMXrs7Vqn+KSMsrwe8we9rN2ZyypDVppKb3fytgmZZrbcQkjcMofbowp+7UDcv32M8vwZd1Mn8ttacAVcoS3QDXnIO1mbN+JlZL8quvWXuds8K7Gj5EqVWkkD6kjgwMBdadNJLvNlaHCYniKgph5EoXvszIdw8JTiQPGIw4V8DsOtJrnMUJoWGWXCo1MLjZToprkQ6Xt0LAmtvma4gD4hWl6F8SAKYbqQon55Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wtbodnYRD8J+Z/30f3GPcX4FPeVopdrrP3HyQNhouhY=;
 b=ug6JsWrX/3VlwLxj84f6BEFHC6kEMz0RTRymy+s5Qz/TKjwtI23SvFmrlIwDzPbpgooeZ3Fw7cfH93RJdaUAphxU+KHqL1TyES63QoZUjHE8hg2oIafK5zcOETy31U/teT6c1mJC9xfoifYafSXSBh9ugF13V3ef8bZWHygtmOTU9c66BQoOsZoj21weIajlFGm0IbP+f8Rwz+zpsUOGpxVoKDuXO8BO5ilkUgicZCd0xPu9f5ViNHQBMulgtUAj6tPNorIiyBs5ft2TG3AEPzzLROl4fwTM6VJHBKrlB1pLjONuoTHA85CfvXrY9Fu/BInDc4RdVwv2NDovOcbTzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wtbodnYRD8J+Z/30f3GPcX4FPeVopdrrP3HyQNhouhY=;
 b=lBIGwfhVRA1l+w8TM04ChxkAbTeuuve8pI4PWuk97XxpCJiPOCNuKkIRC/HPZTCCaVee7+HlVjewH99JlymZhFdHIlWXn5p3ahImFIXUt6kXLyo+y5tEwhzWdI2CA9Gy2e7fiRXGrGJEG4bVyQhLIFR+aGvEj2Vqshch+aZ2c5Q=
Received: from BN0PR03CA0042.namprd03.prod.outlook.com (2603:10b6:408:e7::17)
 by PH7PR12MB7965.namprd12.prod.outlook.com (2603:10b6:510:270::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Tue, 10 Sep
 2024 06:59:50 +0000
Received: from BN2PEPF00004FC1.namprd04.prod.outlook.com
 (2603:10b6:408:e7:cafe::1c) by BN0PR03CA0042.outlook.office365.com
 (2603:10b6:408:e7::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24 via Frontend
 Transport; Tue, 10 Sep 2024 06:59:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN2PEPF00004FC1.mail.protection.outlook.com (10.167.243.187) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Tue, 10 Sep 2024 06:59:50 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 10 Sep
 2024 01:59:46 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v2 05/10] iommu/amd: Do not detach devices in domain free path
Date: Tue, 10 Sep 2024 06:58:07 +0000
Message-ID: <20240910065812.6091-6-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240910065812.6091-1-vasant.hegde@amd.com>
References: <20240910065812.6091-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FC1:EE_|PH7PR12MB7965:EE_
X-MS-Office365-Filtering-Correlation-Id: baa5b9c4-bcc1-4868-d5c4-08dcd1662a2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xH2k8iUMFcxX/iFaTDZRG4/zYF2njvSRmTkuN6/YZoSE5gT7YA/yEbSeGZgw?=
 =?us-ascii?Q?WZC/mb9jQFS6H8WeKpQOfbWCzg4mMdbkBo5ODb40Ad2gfq5VhUi05lBc9w0K?=
 =?us-ascii?Q?UeIgopFDZ0kFJdj0uSDHVoEXJnCPId7WCa4zfEea9vFyQMXVPCs+F/SaTk0W?=
 =?us-ascii?Q?Ri7IAS2F61YFnooSfGKi2S2Gwq/oMxd0OBKd8GiX23HH2xNu0xniHCr0fzzs?=
 =?us-ascii?Q?NTmvuLRAYwhE/THas5ufJePFebSJipu41bijQ0N5xklAJow69zk+bjuzokyU?=
 =?us-ascii?Q?CleMLoxc76plR0t1pS5qJaboGZsL0nfL267BQJGl3xrZhscZ5eqkEnZScJC/?=
 =?us-ascii?Q?EBu9bswziQadXkbhsBtcZoKQbTrwzDRRXCODv9/Dpqw7TVjdH0XMXVVuurK6?=
 =?us-ascii?Q?fW6x35O8zvGrUW0Uk7J5/90INbI0kCIjjrtx3AdnASYUsoQlufhxOTBvi6a8?=
 =?us-ascii?Q?iao0CeyI+318B7sZlMJtKs7hvOmKKowQ2gns/B62JbsIflUEspw0tWro1JK8?=
 =?us-ascii?Q?q1Hn6o/rhFBJYDNE1Tj9jZx2PCLZIybo1AnyG/9eSp/LsoX0q43XMqidZXrz?=
 =?us-ascii?Q?q4sPXNXX7QdJMyXdKmKzxSH8Xmf+77aqU9mRn9PqU15lN77OnH5KtVFf3Rax?=
 =?us-ascii?Q?tpmKs7bNJ4OLySHS7JTCdGUEt471mljp6rtb4fEHtuKesfhVtQ6i9X7fDWDL?=
 =?us-ascii?Q?soXh3boy2pwdLag3ogMfySOBltUxxBUJLsL5KrycnMut4kyEXlYMxkL6Dxqs?=
 =?us-ascii?Q?AuV1gMtE6k+X+pBdTsiN75DZdoRlUWM7mamYk5evSbWA8x5K9Q0NWnVom5Nn?=
 =?us-ascii?Q?2gGFTYhXv7EDyO/xwegZNwFubtcLi3MC7L4+IFvmpOrH0ad5opvHIl6sRfGd?=
 =?us-ascii?Q?+l30bspKXhH7OQi51tiBMtaAzh1B7MAPylLiPwTH2OqEjOgx+fZ5b5KG1w7n?=
 =?us-ascii?Q?0ohWXCGV06zvcQkOlKau0a/5o3Fdq/2LmDgYUmcmHapWQt3BBUxTBUBvJ+Kf?=
 =?us-ascii?Q?CNi7EcoxOBQfDVydZR4tHr3soDkw5P4S4mXg6fGWGgrn2cNay2so056SqRmn?=
 =?us-ascii?Q?nv0ZZfIzsamOxXN6tgBqh1t8q3IA/hD+VauofWXj6jG7xmCzucyWDqS/jtjr?=
 =?us-ascii?Q?5ZQRUA4qL0KMttsweJq/M42Uf1FSHp1DyQdU1FfEYuyd6Q7myrvJH6nuDpWF?=
 =?us-ascii?Q?1vUQtFUVENVZfAXIJSBzR+bri9e6rAWhsJAQIbyqhHdNEdQWe6dl1rEAB4H0?=
 =?us-ascii?Q?RndzGTNk99baj83nPGyEyjN+RgfN1cMWFhb2WaM4RsBHAEO3SD76tj6Scilc?=
 =?us-ascii?Q?J97kGi9HQiSnJhwNRzlUdiJpF7vkJtqPnw2ieJHhmMGJLmXwQcaUzbVvokQS?=
 =?us-ascii?Q?eDQJnACESR6nVRpGWrX8cfZZ06nphQdi5zzEkh+dRlwRrtP+rGYUl1xJuo4i?=
 =?us-ascii?Q?CqmpaVU8itz1ow02Fq/Nxafqh/VPF4S9?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2024 06:59:50.2943
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: baa5b9c4-bcc1-4868-d5c4-08dcd1662a2e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FC1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7965

All devices attached to a protection domain must be freed before
calling domain free. Hence do not try to free devices in domain
free path. Continue to throw warning if pdom->dev_list is not empty
so that any potential issues can be fixed.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/iommu.c | 26 +-------------------------
 1 file changed, 1 insertion(+), 25 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index b9b060219596..a4a4fc7ba689 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2275,21 +2275,6 @@ static struct iommu_group *amd_iommu_device_group(struct device *dev)
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
@@ -2445,16 +2430,7 @@ amd_iommu_domain_alloc_user(struct device *dev, u32 flags,
 
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

