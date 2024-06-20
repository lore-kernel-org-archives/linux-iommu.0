Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2062.outbound.protection.outlook.com [40.107.94.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96AB811CA1
	for <iommu@lists.linux.dev>; Thu, 20 Jun 2024 06:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718863582; cv=fail; b=dFFHI3f+C4ZBIEe9ua5U18JPWzt7jSm70Qi1vIp7HCjuH55f/bCLjKPS49y9NtdX/KyyRx7EZ/lgO98HLs4wpVnNpRFoX+fg+Pj6rmdKRq4WQlkSULj087CntaZ/12reMBD23EzU+Is3BFLzRjKYg0a6ah90x5N15jfYoNY1VIg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718863582; c=relaxed/simple;
	bh=+ANRZVYXyMPcMg2XYjRZIfTCAcrgBbOMrSN7n/rYmyQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=h1HnoP9FfOnqivTXzE+TzKlepXL5pKw2shI4YV6ksRBWYoARnqsf7Y8t0QyyOlIyltBV3Z0tvIPtMAULzxg4nJNUTMwsDdvp5LzGxuo7D76ep+9UQ8ytD9z0TnqxP/EEUc9ryPK+ViDDddH/n6H1SMupV0JnjAOvt6ggpYLUtJo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=K5KYHgyk; arc=fail smtp.client-ip=40.107.94.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="K5KYHgyk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BqSLljft7B51TTQV/7ijXrjC3TxU24bZbIkJHdhIKNBp5PK+P5JV0zC02l24xkW7ONPDOMaceypUcfc7ODWhiHchDBMqvHC5f1yKlWhpg7zv0HebCEo6AJfL/fcO345MIJqkiWgKcg/iHlnWofkpP7JQ0SoJHlQIBJ8RLLGvtZMTJhytuypvHFZXw27VrfmQ/T7Da2285Q0yoLVbm3HRo01M/sOl34Z4GlZcULpomGQBda+Z/sBTyQMTFKRvdtNxFFOsndWMQvBUIH1/j53CY4uBX9KuH3zzaEhFmldr+PyZIhdW0gpLUsbc7679yxqK0mVfz4C3nqN2/++U2ekpLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nEAPgUjPwG6e1VnfnZ9LPv4svMb8P/opzYyU4Ua0K2I=;
 b=XUP3QPs/81lBzyqIkfGGjTZFtdIscrJFs+E8+uo4Uwtu3oYTROclkxRrMUZR4WTcfQuUZVbSB9GSVwIQsCk8dxhZdg6QIApkbrceAqQlWxeDY7hfhPDlPCCGdE+IjAfIZ7JJQ8+2VQRDr3s+RjHsPhPY/Y8dE/qUr3vB1TCQ/B3sYpHke0TXkRdWRax12MwCl0PYCuWXY5ol3ies8Tbz2nk0XySWIybFmpI6zFpcAgtR2NomM7GWHkatJ7jFsyPEbenU7Jzqdgfe2sSANHedcYiqfhHmGSecgk7xGZVfFVQ/JXpmdWepUahGHR2hecBWRL43IzCD90VZCW579HEW+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nEAPgUjPwG6e1VnfnZ9LPv4svMb8P/opzYyU4Ua0K2I=;
 b=K5KYHgykWDwQTqGHXQS+9WaFys5xmNZoL1sDlUdxK60AU+AwsY4uKl1cVhlklThOUDqNo40PHyydlzWeYwK8Tlok7zhicMpG6oAkQ4DReXhkmHxSStl2+YtXMdwbikYRz83nUWKHk7AZOl3m4tnh0FeHxW+5vsCMpGU+DBnGvyw=
Received: from DS7PR03CA0015.namprd03.prod.outlook.com (2603:10b6:5:3b8::20)
 by DM4PR12MB6565.namprd12.prod.outlook.com (2603:10b6:8:8c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.18; Thu, 20 Jun
 2024 06:06:17 +0000
Received: from DS3PEPF0000C37C.namprd04.prod.outlook.com
 (2603:10b6:5:3b8:cafe::d8) by DS7PR03CA0015.outlook.office365.com
 (2603:10b6:5:3b8::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.33 via Frontend
 Transport; Thu, 20 Jun 2024 06:06:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF0000C37C.mail.protection.outlook.com (10.167.23.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Thu, 20 Jun 2024 06:06:16 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 20 Jun
 2024 01:06:13 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>,
	FahHean Lee <fahhean.lee@amd.com>, Dheeraj Kumar Srivastava
	<dheerajkumar.srivastava@amd.com>, Sairaj Arun Kodilkar
	<sairaj.arunkodilkar@amd.com>
Subject: [PATCH rc] iommu/amd: Invalidate cache before removing device from domain list
Date: Thu, 20 Jun 2024 06:05:52 +0000
Message-ID: <20240620060552.13984-1-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37C:EE_|DM4PR12MB6565:EE_
X-MS-Office365-Filtering-Correlation-Id: e070ba88-7db5-46fd-59fc-08dc90ef1884
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|1800799021|376011|36860700010|82310400023;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VHkUFFmXjkHQ1v0xn/GvkZ16bgUVEjChHpML/3Gx/5ydn8C2QMMD6TD3CWho?=
 =?us-ascii?Q?j2l7JjgoT0E0VhLa4vpFdFKAv0oKqYOLPlokQ365v9zBQv6SrhmbOwFFbJ2E?=
 =?us-ascii?Q?jmoXi4yKvXGjuel2NqTN0vwWMjCV60fwWfEMbY95zTVMXKJKN1N6eZnVf0wS?=
 =?us-ascii?Q?LFj69EfG49xhbaHHjqyTSNKesj1LmMhvs7Sf37PfexbdT3gbsQsqupbc47CY?=
 =?us-ascii?Q?H1tibQcsceRp+yfhc/lQJQr+9v5r6A/TUIirD/Eyhb/eMgNirav6W/5TaUzB?=
 =?us-ascii?Q?/+oBUymxEoSTL/zVDuSigAsyu/1ldeUJIl7/xLkEwHfpql7BozganyvrsL2R?=
 =?us-ascii?Q?y91pO+CYPCzqwoga7GRPtZ2e9V6RDFHHmgczwK2/3gkYR0OrkZBflNe1koIH?=
 =?us-ascii?Q?pghlY1ea6IdMKeUQnjjJ/91l8fRPufBDesAv94LJ5vOWvVUzQwYPSsxEQ2M6?=
 =?us-ascii?Q?Huh16gf+HV4WVKqn860VmXXJqoouZbkFH3Lkg/E+H8E4QAIXQCFebDeRQv5T?=
 =?us-ascii?Q?Av/htoE86/4GHwKMyNlJaPiKD+2MwZWYp5Ggl9d+uWuwaOmBHlbWuX+s1/KT?=
 =?us-ascii?Q?diIxX6Ko2vPQymrYzb/j7cV1G4YV9t7bthHSawwhDhNHyIKOCFPt+r6BRRy7?=
 =?us-ascii?Q?T8XpPEUs4sW0NrvE2zKbJQa1wfTiarsoRomMJw78NPPVh9Cc8GDdME2DA1ym?=
 =?us-ascii?Q?FiKMWQv6rv8IPj0yOiRcbpvGn3rG8vv3D5jNmJ1jvILY9U0cbM6+FCtKkIyc?=
 =?us-ascii?Q?wQgXnlNYKjAV+dX6DL+q8flP9sRVQ+3yvIcF+Yd3qIVj3dQ0OjZrCVoM+C+l?=
 =?us-ascii?Q?t+3N90i9JwEAYuaVFPYAP32xcnEUylW6jCE30KQPRKJUBc9HYUJ0xQ25jxzh?=
 =?us-ascii?Q?XcZFRMKJMVdJqym7WXCsVwZvZAKv17+CRsJT3xhnwr/szs4/WjYH5oNDj6Tx?=
 =?us-ascii?Q?8kdXJXfm6xi2Py4zRPkPSDE2aLlxqus/OiHCC6klZ7lCP4ApQjGiXFnFQmtY?=
 =?us-ascii?Q?bzqXesVVqpQEe1PF2JccatTAMoT8O0I7RD6WIw3DQkWdAFi+Gh0TfTKQznO5?=
 =?us-ascii?Q?XZjaRgCGgfONrasVQlxiG0Px1G2yInfZDQcKob75Ua3Srv6YVa1SL6x+Rm18?=
 =?us-ascii?Q?AAAiEcpBcRTB2w8o3kaJofMQKGjAhxmzPQmLjNj2yzSsTvJF17oOwhU2pqOc?=
 =?us-ascii?Q?SGpFrnGuUV+iJAVr1zHp8S4yUwhij2WjNhMKWNVkN1LT2tRjNiSK3q3ycYYw?=
 =?us-ascii?Q?P3dnMsTkGrxVcWZKCXQvwP2VZMUwTFga7ubSLrlV7HlxEYokXTNXEp5eaQyT?=
 =?us-ascii?Q?BtyReqyDgPmfLdliK8XbxsS0W+VTMB+GYwKyJv0pvtftueF1v4fuljWZfCJ3?=
 =?us-ascii?Q?RTBIEY0o0Y9/UQqsy+0hfUjg9GGDpe4U0IkBrjI/4y2k+9O26Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(1800799021)(376011)(36860700010)(82310400023);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2024 06:06:16.1584
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e070ba88-7db5-46fd-59fc-08dc90ef1884
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C37C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6565

Commit 87a6f1f22c97 ("iommu/amd: Introduce per-device domain ID to fix
potential TLB aliasing issue") introduced per device domain ID when
domain is configured with v2 page table. And in invalidation path, it
uses per device structure (dev_data->gcr3_info.domid) to get the domain ID.

In detach_device() path, current code tries to invalidate IOMMU cache
after removing dev_data from domain device list. This means when domain
is configured with v2 page table, amd_iommu_domain_flush_all() will not be
able to invalidate cache as device is already removed from domain device
list.

This is causing change domain tests (changing domain type from identity to DMA)
to fail with IO_PAGE_FAULT issue.

Hence invalidate cache and update DTE before updating data structures.

Reported-by: FahHean Lee <fahhean.lee@amd.com>
Reported-by: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
Fixes: 87a6f1f22c97 ("iommu/amd: Introduce per-device domain ID to fix potential TLB aliasing issue")
Tested-by: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
Tested-by: Sairaj Arun Kodilkar <sairaj.arunkodilkar@amd.com>
Tested-by: FahHean Lee <fahhean.lee@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/iommu.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index c2703599bb16..b19e8c0f48fa 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2061,6 +2061,12 @@ static void do_detach(struct iommu_dev_data *dev_data)
 	struct protection_domain *domain = dev_data->domain;
 	struct amd_iommu *iommu = get_amd_iommu_from_dev_data(dev_data);
 
+	/* Clear DTE and flush the entry */
+	amd_iommu_dev_update_dte(dev_data, false);
+
+	/* Flush IOTLB and wait for the flushes to finish */
+	amd_iommu_domain_flush_all(domain);
+
 	/* Clear GCR3 table */
 	if (pdom_is_sva_capable(domain))
 		destroy_gcr3_table(dev_data, domain);
@@ -2069,12 +2075,6 @@ static void do_detach(struct iommu_dev_data *dev_data)
 	dev_data->domain = NULL;
 	list_del(&dev_data->list);
 
-	/* Clear DTE and flush the entry */
-	amd_iommu_dev_update_dte(dev_data, false);
-
-	/* Flush IOTLB and wait for the flushes to finish */
-	amd_iommu_domain_flush_all(domain);
-
 	/* decrease reference counters - needs to happen after the flushes */
 	domain->dev_iommu[iommu->index] -= 1;
 	domain->dev_cnt                 -= 1;
-- 
2.31.1

