Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2076.outbound.protection.outlook.com [40.107.212.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8ED5322C66
	for <iommu@lists.linux.dev>; Thu, 11 Sep 2025 13:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757596476; cv=fail; b=g7cHEBW8iVACFHUirmMNYys23Zu391QQpg0oR0kY+BW0SHDuj1nxZUqHr4x4OXkXTZflBDpnllep327bAPmrsAmaRpDzRpPsgwJuAbC08rHFHyFse6SHx4hOytFekHjYzOwtsSnVE88uOFykr2EpVq0Jz+gDYYJVZVxr7VYP2V0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757596476; c=relaxed/simple;
	bh=5M7exGptW0WhTO+CVUfoO03631iz4z2XiZHxFSqzwlU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OQOs81xQfz4kjYS8QcGoqeW6UoPkN8HMRvSOsNQ8CbtxbFGDiXDdeDUAqMEtaojXwV6OuAp5WdpgeT/p5iulHW0ls2QcSHJFLClrDgiUfpxwy9SoVfcfyDw3+VsPMaL3TuICgnX10lDSBQIEEXflUMz3gr4ECuSADn46bTqRuuw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=aiwdY0pM; arc=fail smtp.client-ip=40.107.212.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="aiwdY0pM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V30NPdrV6kO9aDTGHwqPoSFNgadqlAZir3+HweU5Qw2zs/zrhmQZ1nHGyJpTj5/OAXdjnq60aECIyNW064NJgHSJP/c6QZGwM+ptywyMnJ5sfs6Esvoc99nv9dtmX8TRKk5uqeBeplAizstKbvLye+xh8GiRnvuKnXVAUYY3S+iC9WD/bxJ18H1dkFw8ayLT9cExp20lusKMaLH+VucXaszaaALnIrRaB6kUYjXbrHj0kVw9ijgSr+HL3By1/5+Px/rFvbPU7uEZ9oH9R5lbxCz/qz7pzkofApyIgsOdYV+E75t5+itDNoRK6bL91yHaSIuK4NzTnBYJIZyo1cM10A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m8vWLDXhJHduHjCz1EUBv5vGOJydIOd4y5FlDSdIZUM=;
 b=CTh6NS1+jdVvRJcaue9yy8wU/OGQ9BV+pSbwEN7w+cCT4TLcShil5I99zxiWcs9Q/aKdE5tuduRYXJoBpvttUR5aej/GxNkHla9B5vz8NIlQvdJ53yd0nctfRVWUYRqNWyGTxCu87Mk/dN2CSJ2CW/d3NCn9mQvlZFWWX6vr5SyPp2GwKmxpGXvwL9Yyq4e5R9Qs93ZUJ3F1aK6KjJGb6pbIz54A9peH6K0wKl3X7antqe6ejcRMNpyzMDr2f/MY/Fn/6ggFaHSkrNaWifvJ8yK4b7hmg068j9s34gHlycwsDDPvHdrY6YB91q4KdV75iyoyPmJSsXz5ZefjB2POrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m8vWLDXhJHduHjCz1EUBv5vGOJydIOd4y5FlDSdIZUM=;
 b=aiwdY0pMoM/mlc38Yq0PYsA8F3y7MJoSwEZecWlpYbvwDdAMDbEZWozKiftwApYgrTsCvnlT6SmkN3KQ6MCuoa2gJTh6PHZMO3tcri7K4tYFjw6c9lw5fz0CN62dQnC2G0A/KIA8kYo3IZhdyIQGJJ3e7MrxRwfUo2tsCjNNBEw=
Received: from CY5PR13CA0061.namprd13.prod.outlook.com (2603:10b6:930:a::23)
 by PH8PR12MB7279.namprd12.prod.outlook.com (2603:10b6:510:221::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 11 Sep
 2025 13:14:28 +0000
Received: from CY4PEPF0000EDD4.namprd03.prod.outlook.com
 (2603:10b6:930:a:cafe::1a) by CY5PR13CA0061.outlook.office365.com
 (2603:10b6:930:a::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.6 via Frontend Transport; Thu,
 11 Sep 2025 13:14:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EDD4.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Thu, 11 Sep 2025 13:14:27 +0000
Received: from kali.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 11 Sep
 2025 06:14:24 -0700
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH] iommu/amd: Fix alias device DTE setting
Date: Thu, 11 Sep 2025 13:14:06 +0000
Message-ID: <20250911131406.633549-1-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD4:EE_|PH8PR12MB7279:EE_
X-MS-Office365-Filtering-Correlation-Id: a3615efe-f924-4d08-a216-08ddf13522fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QWllMaRpSmYT0/ax8yFjpiqGKRDIRz9Ndrl5vLlrlKr8+TtK+9KBt5kX07+B?=
 =?us-ascii?Q?RSA2z9RuAC1qkQyAGzgT1MQrjv2vGSJCNx4qHgRecbzGWmlOstTHCdlxUVN1?=
 =?us-ascii?Q?Ti7NvWCn3mLKl5Y8zlVErbakD+kfcoNZmtZ7HzG5WxERwCMRPJ5/QvnCL4fQ?=
 =?us-ascii?Q?Dgaz8Ii6m6uQiEtx89uh5f93VbPdoxWG0r3FNRgUIg4ypqC2Uj0X9lPqDKkI?=
 =?us-ascii?Q?D3NG6gIqt7cwLukeCWdVSE3RTCLDsKFi5MEnV2bXE0KgCKQl7XRtli8asEU2?=
 =?us-ascii?Q?mLiTfZ1zlDHWKwdZrX3GSXBSEtd6Mxlm1DsaffdPNk/OI+YTR3Nx7ucmSobB?=
 =?us-ascii?Q?UV5LfwxU28M2ZX4BPR4hGq9mP6cQjV1+NV1KRTCFQb9B8OzPzILGOHiH1gmY?=
 =?us-ascii?Q?P23uGeT4CwIpjI4buactUhFyISwIPEHM8YsqnluNSJqEJsBK77erNbqeMjnJ?=
 =?us-ascii?Q?qtL6p5cCF/Ds5S/zEwr8iJV0+lbvhT4qp0k+4rC+w54DuLuJ8oosfqbdnN66?=
 =?us-ascii?Q?79RMMdLcvJ2NCFmXo4Gt7BC6I2U9KzxP8yaQba5G22MriCgBQSrIKzpvfLiv?=
 =?us-ascii?Q?Sdqq4VjfRB4VA6Udmb8wjDHx/05Oas3f9dSKtDesbWm5p5QBY5D+mIsQvAZg?=
 =?us-ascii?Q?uiV7rPkK8yFkrDYNrCdsFLtkWTHq84cZz/JDNO7V5druZpR1wRXoHu82QIti?=
 =?us-ascii?Q?kDY9vnrgDjnetr89Jz2KiUuA1/FnWhMqc/NN5qONUtN7q5fRJcY40a8xoHcg?=
 =?us-ascii?Q?wPH60s+PMYu0P5Xak3OQ/xco3+HOQ6eWP7xfDPsmM9uyhMN9RrUvlm572a+y?=
 =?us-ascii?Q?xfvVvlJ9N8RivN3T6+mMSLTO2h77x23Mxjil5fGaSRssTOfrf/AOnTKTihEe?=
 =?us-ascii?Q?s4bIC7lYvhs3ZlZ9uqFfYc+J+4z7jDUI5Kub/ew9ytCWPkQ+mUIOypdclfb2?=
 =?us-ascii?Q?ZvkKjryMAmjmj13ypSzNOSwI1JTDqkQeMqCe8769+xbcK8igC2JKrqbUfUIa?=
 =?us-ascii?Q?B1vWufqk4B7HidZDlwAuD8nPa2NLIt0QNpy5qmDdi9BEMqR527DK9LGR5bpI?=
 =?us-ascii?Q?pUnF6m5JmjYUDWd0HEDMI2t2LDpAOUhlwoJ07aWEukBoGsUavkQCHyuiNNNW?=
 =?us-ascii?Q?3y00MsdiK4mTtFFyztBy3ipdvRNbR3jUST2ecpKuoEbYDkR2KxS7gQFbPSAs?=
 =?us-ascii?Q?f/3/DRyyWhwltkAfKRLobb99J+MVN6LTcMaj6hYoOD1Dc1669rxokyVHx3G5?=
 =?us-ascii?Q?ttrqGiEaDJ+gVBkoWrR7cfQgs/iAa0jbiLE19ekTRBr5PX6+B0GbCkoRCNCb?=
 =?us-ascii?Q?AXqvIVmYtM8Gl27AToHyqn6vkMEyNV4u6T0ni4Iyjo9RVhqurUk37lLooxpZ?=
 =?us-ascii?Q?vaumVHU/VDOLvNJCxNusWPa329MJDjXfO4/d8K0hC8xe/rUzkYz1pxlZPyib?=
 =?us-ascii?Q?zOJ/O+Ful9rpdwml1m4dBczdTKrMFSE2XkX+M83R9IB08bQjsjYuN5CCX3Tk?=
 =?us-ascii?Q?9E2oQSYUgVTCjGqqyzUALE2jf9msv/oPfHMT?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 13:14:27.8026
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a3615efe-f924-4d08-a216-08ddf13522fa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7279

Commit 7bea695ada0 restructured DTE flag handling but inadvertently changed
the alias device configuration logic. This may cause incorrect DTE settings
for certain devices.

Add alias flag check before calling set_dev_entry_from_acpi(). Also move the
device iteration loop inside the alias check to restrict execution to cases
where alias devices are present.

Fixes: 7bea695ada0 ("iommu/amd: Introduce struct ivhd_dte_flags to store persistent DTE flags")
Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/init.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 8de689b2c5ed..205dc587b89b 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -1455,12 +1455,12 @@ static int __init init_iommu_from_acpi(struct amd_iommu *iommu,
 				    PCI_FUNC(e->devid));
 
 			devid = e->devid;
-			for (dev_i = devid_start; dev_i <= devid; ++dev_i) {
-				if (alias)
+			if (alias) {
+				for (dev_i = devid_start; dev_i <= devid; ++dev_i)
 					pci_seg->alias_table[dev_i] = devid_to;
+				set_dev_entry_from_acpi(iommu, devid_to, flags, ext_flags);
 			}
 			set_dev_entry_from_acpi_range(iommu, devid_start, devid, flags, ext_flags);
-			set_dev_entry_from_acpi(iommu, devid_to, flags, ext_flags);
 			break;
 		case IVHD_DEV_SPECIAL: {
 			u8 handle, type;
-- 
2.31.1

