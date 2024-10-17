Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2076.outbound.protection.outlook.com [40.107.220.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408B41DE3AA
	for <iommu@lists.linux.dev>; Thu, 17 Oct 2024 14:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729173833; cv=fail; b=ReNdjwh8Ouaro8fuuTDLhvunutf70C9uV+IIsTZKq1w/tRCOGSlSu6n3ytQQZe33hPusgV4pKconQUpS5ruuu4lmIsmjyt9DJpt2DIDVr1/sBetFiFTsEIOIX+7PaqYk32v9zkGaxbgmr3+muZ8vLG+T9Hz2wFtbeB1vZmK2bik=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729173833; c=relaxed/simple;
	bh=ahfo/BDsJluBSaGFsotX74yZ1naBlWO1SmayFphaRfE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s88ChfnxcNIcKi0XMnjdJHOkiVGwjkdSKAX4SifxNiN5vc9OQoXTt3WYZ1Ep4RRzIIjBXm26ebLaVY3IUv0NebEHbFjiIver/E5BCVcIVcOFEh3H2OQBTPL5bjFZibkFOI9CnAoQoiWCnKZo+puBlbGIVsgHKGUKoyBlStj7b+I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Vp2l1eRn; arc=fail smtp.client-ip=40.107.220.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Vp2l1eRn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c6+UcFWuyH3h9pGp9tO6ti5k/gG135iVnhrIbAb9c7BRwBsYp908H2k15Db2wkkbUZbaEU55O1+/7Z0PgJ5Yvroz3JBLjVtzccBwO8seQQFcqxXOrMMWTmmg+6bLUBmx/XKwvD+x9Bffa2BYQFGv39DaHskoMeTfhKk0DA1SPGKxlMPjy2i2bY+ftEEWiAXLN6EAY+u2uN5M10IcmjBZKldzju9hwZNwRlJJhJ9PhkEqlmBtSUbPdTJgOeRjyEFLYMMI76CbAc84o0gOHWx52gteqAh7uS3OCUNbmGHIa2dvA59eez/ug5crVSgcqot+AC05O1xFp0om3e4RTE3Nvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y1ouKxIsfuEQp2RZdZVYWZ7Oj5ISHmKVCi99I0ouSc0=;
 b=r6qy3a1lXdFprrfmEwFLPjPwvRR3HEm0Vci3hJ+FT1k9MucIbyT1veO/OUU2TkwkWHhZgDvXOfmxi6sN3snJZTD6O0vUwMkIfjehwQMbjFt11mtZINzPVo5XVRgWy1drhuK1AQPytErH+EGVwrfUbbeskA7SAhfbNGS5Igh8tk2yJRLJ8m/Mt2PsUFtsSURXt7FVPEwn1BZaMYUnvAyq4q33eXJiZOnz+/8OF76s24kMCFCj5RLteKspUtfOvcvxFVC7A4RECvt3yMKe3NjIUe7TGj0kJTO+eTxidqCu+AQnpU01ZdiZNmk6sY+y8Bp/6QNd0i0y0NWiXLNzfSzzjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y1ouKxIsfuEQp2RZdZVYWZ7Oj5ISHmKVCi99I0ouSc0=;
 b=Vp2l1eRnbhCZ8KtpZHZ7xjYmvTJe+4UfMpdfeLAObhfje6C3QSoEQnp2LiwOihjevjAt0w8UgiSibgszyDwNiU5YDZn/tL+t7F3RzAoiEhE6BLwjI2qRff92DpeZoM2DrExJLGYF1DIU7iEiIbHQakiWApMXMz2IfAi62pZLRKI=
Received: from CH0PR03CA0281.namprd03.prod.outlook.com (2603:10b6:610:e6::16)
 by MW4PR12MB7032.namprd12.prod.outlook.com (2603:10b6:303:1e9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Thu, 17 Oct
 2024 14:03:44 +0000
Received: from CH1PEPF0000A34B.namprd04.prod.outlook.com
 (2603:10b6:610:e6:cafe::d6) by CH0PR03CA0281.outlook.office365.com
 (2603:10b6:610:e6::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.19 via Frontend
 Transport; Thu, 17 Oct 2024 14:03:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A34B.mail.protection.outlook.com (10.167.244.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Thu, 17 Oct 2024 14:03:43 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Oct
 2024 09:03:39 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, <jgg@ziepe.ca>, <yi.l.liu@intel.com>,
	<baolu.lu@linux.intel.com>, <kevin.tian@intel.com>,
	<jacob.pan@linux.microsoft.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v3 06/12] iommu/amd: Move V2 page table support check to early_amd_iommu_init()
Date: Thu, 17 Oct 2024 14:01:31 +0000
Message-ID: <20241017140137.6028-7-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241017140137.6028-1-vasant.hegde@amd.com>
References: <20241017140137.6028-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34B:EE_|MW4PR12MB7032:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ec09118-83f9-4a9a-b958-08dceeb482d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UAhcw7rLsKXPdeGOOgQEkY7fj6xKXT9DxGP3/az1gZjiiIrGtbf9Qji5TCU6?=
 =?us-ascii?Q?nMHWtBoO3evnYfk6M4wCzip37f0mwoecpkhy6ticvP2Z2RwbSS2lUUcKVpwZ?=
 =?us-ascii?Q?GNbObWmCHtdSrvnd02hjBdHh9z2K9V/a3iAi1Kg/IvZ1JzFdxa+Y+RAu+4Nl?=
 =?us-ascii?Q?s45WT4OXPGVl77+bQdfNBf5hMdf41v8VXi9je5Jks1ZCBZaNlodsyb6esZf8?=
 =?us-ascii?Q?OlQnFlsUp3tTQ59ntsiqFDPiu+f5zhU4kYfiZ0dP2GkAFULwNl6u88F7eyK5?=
 =?us-ascii?Q?3Ftqctl9d5IcgF2kEl7Eeh4lyLAX7G9CXZLG2Hjl5Y0gs9H9YeKBYwy6X93o?=
 =?us-ascii?Q?HhKbtrrHzQAocJ/WB1iXr5LB4wtKpr765pUx+2d32kDQOr8hS1eCGHFAmRY1?=
 =?us-ascii?Q?VKtngDYX8HfuAl8TqcxFPFK6EPekMFTr53JLDcwNDD0nvDuXg+r7wAGQbK95?=
 =?us-ascii?Q?wQ5uDWKi7p4PqHg5ysx4vxo45QC6EKAmU3EhmJD+yAn49r7eBI6UYkHcokyT?=
 =?us-ascii?Q?P5PguGuLzUa59GBEv7ARHGb+l0nPcVkB3R5mkrLsvg1iAw7Gkn0KhQq74H5y?=
 =?us-ascii?Q?sAMBJDcNSldqBUTNf7w0/+xaFIvufnQaEX53KdP3Eqw+HKBLSYbgtjMZNZY3?=
 =?us-ascii?Q?61oWKPzzihyiiKG0lQBbaCp9V7x2Mkfn11OrWsfsdcE9FWygjZ3AJdWz9n9r?=
 =?us-ascii?Q?/MQIaPHMplCXe/b9vq34773cnnf733AS4ZhBUMF1x4jYpqJzn3rZD4ffCjmb?=
 =?us-ascii?Q?kWFzxG7wEWmU9SGGpWBUajUCxVWaBNdms3rCCMhGFDrqtq9KhK5tiW+rX7HE?=
 =?us-ascii?Q?KMNvjOkR7DTsmnleJqPm75LZxKFZOgtVZ+7TQU1dp35UbctDZ976JuLLX/NM?=
 =?us-ascii?Q?Wj1Dqx6cZLiYnVAiNGfzZ2lDTfKb0dLQpH97ZB9AV9PSjDM6fKbfc3ZYHhYp?=
 =?us-ascii?Q?wORq+8f5HiObv80bNX3MQwQ0N4C5A1eFNRttcwJVkjvVijUescla4ZQCxN+G?=
 =?us-ascii?Q?rEzV/8BjSuq0GsogrhOtEs2RGtBsUGesWSTc9bYmAlXLocSvy+egKLBZndwG?=
 =?us-ascii?Q?/wfh+Y5BkKql6AgxlamwuLSPAJGal8GYm9xviuFpKRof1rxk5+5a7qtZgtRG?=
 =?us-ascii?Q?RkOhXIMm78xzAXPgtJMGAvFW7dCkmzF7cpVZxBa4167HH5fwg2EkxBmknW8w?=
 =?us-ascii?Q?tz/9K6CPsZN1DEn22r1kAP0miYa9WDWnI9/KQN8aJHrICGavhyISw68Df2zD?=
 =?us-ascii?Q?avJmMCvD/TjBMGhYdKZuAFfEAfHXlx+nfuOyevnBl2ty/f9a93rEIV8klZ0o?=
 =?us-ascii?Q?GgD0bSoVgBsdejFKIFUb1quWAs+k7LXyVw4BLrmREK14vY5n72UqoOwOKNbc?=
 =?us-ascii?Q?D2sXlGXGL+C8CiPdNAX0vZrG+gHFTcXI5JMTmNHi6G76CWAMlw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 14:03:43.5620
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ec09118-83f9-4a9a-b958-08dceeb482d6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A34B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7032

amd_iommu_pgtable validation has to be done before calling
iommu_snp_enable(). It can be done immediately after reading IOMMU
features. Hence move this check to early_amd_iommu_init().

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/init.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 7ae478d95e2b..7c883be22559 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -2070,13 +2070,6 @@ static int __init iommu_init_pci(struct amd_iommu *iommu)
 
 	init_iommu_perf_ctr(iommu);
 
-	if (amd_iommu_pgtable == AMD_IOMMU_V2) {
-		if (!amd_iommu_v2_pgtbl_supported()) {
-			pr_warn("Cannot enable v2 page table for DMA-API. Fallback to v1.\n");
-			amd_iommu_pgtable = AMD_IOMMU_V1;
-		}
-	}
-
 	if (is_rd890_iommu(iommu->dev)) {
 		int i, j;
 
@@ -3090,6 +3083,13 @@ static int __init early_amd_iommu_init(void)
 	    FIELD_GET(FEATURE_GATS, amd_iommu_efr) == GUEST_PGTABLE_5_LEVEL)
 		amd_iommu_gpt_level = PAGE_MODE_5_LEVEL;
 
+	if (amd_iommu_pgtable == AMD_IOMMU_V2) {
+		if (!amd_iommu_v2_pgtbl_supported()) {
+			pr_warn("Cannot enable v2 page table for DMA-API. Fallback to v1.\n");
+			amd_iommu_pgtable = AMD_IOMMU_V1;
+		}
+	}
+
 	/* Disable any previously enabled IOMMUs */
 	if (!is_kdump_kernel() || amd_iommu_disabled)
 		disable_iommus();
-- 
2.31.1

