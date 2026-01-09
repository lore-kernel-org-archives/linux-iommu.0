Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013063.outbound.protection.outlook.com [40.93.201.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A4842050
	for <iommu@lists.linux.dev>; Fri,  9 Jan 2026 05:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767936066; cv=fail; b=dOmJXypHKzzTOmlebFaZ6FUK/I5w7B9cOGmKOrtjKdXWhjicAPKny6AoBPfjvvAB0GXFOn3QTP4xaxYur3VZLjBIj9GAr/+OOW0HRcmDTkFGi/FscivmYrmeg+mLd/m3b6GKtcOIpDQpaGxcnPf5lM1QDgtL2v54k1AmwbVYB/k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767936066; c=relaxed/simple;
	bh=rTAgBjkyqQ8bcgqfqheIo6tfy3911almMaUEqRI0yaE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MhaPNAJg6UFYXVA3uNqGvnS/vhuTVwJ03aeZSHvU+ydTHQnbA0s5Zi5c5/1B9547BiL149mhkwCkL1QFWvfwdMg24lq0RJHk5YrSOhPw7KW0h2eLWZkH9aoSDSykScaJrLLNw2k2Vni/JQdEx6WGDvKduxU0mF1Ysqa7PPGbMt8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qgHg81kJ; arc=fail smtp.client-ip=40.93.201.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qgHg81kJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eDHxxPNbAhvoG6f6VBnTIsAJ6yET5UBiLN5AWrcVDeIMSeolMG5ylFcPrE6ibONXqAYOpgbN7ohZ6lI9rZ4Uk8h7C5+9TC83ecUNYmMPFglxBqArR8lUmK6Zxl8Ngu3V9o4o01I10GCiwGlDHCBTUc2xzXGdhQpkku5Gh/MxjU6fmodArqaHDW0k0acqNfzupk26tgsafK2IN7ndxAqAYXIYMzk/FfYXjHJHbzK0mKiX8b9hQSyLBiA4G5twCWYf0H5s6tia2HQcvPXHe+6GcaKfcwnknyiOLkX0fluLVY/+daK6p11MPsqb920GOv7fF6gY9ObqFKr4ZuPGCsngWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BtoahyoenzKSIA6f9jk2ZKSa1IDHUgSPuF6qx2BteBM=;
 b=ex6I00puHTtrqEMHbyl6pjXdCO4l5r9cEP+TJuo2gKlRkGHzMRh+4/VoxRd844SxfEemahvVbpeM8YkrOpMCvFopzku46LcN1ZJMc/Uk5GhRePDNaV6YvLWH0pAWwwKy9b+L5hIjlDnEnNECYzBG82/zY4uu0bi7RxavG3dw51wDugZRhEsjdZnQ0dVw8+4/DvSuRxvXMuK56dZ8IaWvLw/RJbeTOM736AFc1dVoWQYyzE06aTqphkUP3Ty82Qxj24ZnXs+NZ4rLirrp+fU0shGE0/mXOnjR+bQvZYtkU5z9929xWGS8s9TGXxsNXEjV+IzrSmKZxTa0bkVxF8JH4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=8bytes.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BtoahyoenzKSIA6f9jk2ZKSa1IDHUgSPuF6qx2BteBM=;
 b=qgHg81kJN91f3iUPXLa3Dzxed1NGAodmXLCyejgrAnqpcifXCdQ9wkoU/fmk7CfrO8A+Rza2pu10mCooMP8GFSD9y81ib7V5crOG0zjLpqsspwEDPn/WxM0QzJtk0etCNc3JN5D3YS/UAZAyC/7e3kLOrTrHebnHJW4c/V5QtPs=
Received: from CH2PR14CA0036.namprd14.prod.outlook.com (2603:10b6:610:56::16)
 by DM4PR12MB5746.namprd12.prod.outlook.com (2603:10b6:8:5d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.3; Fri, 9 Jan
 2026 05:21:01 +0000
Received: from CH3PEPF0000000A.namprd04.prod.outlook.com
 (2603:10b6:610:56:cafe::76) by CH2PR14CA0036.outlook.office365.com
 (2603:10b6:610:56::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.4 via Frontend Transport; Fri, 9
 Jan 2026 05:20:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF0000000A.mail.protection.outlook.com (10.167.244.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Fri, 9 Jan 2026 05:21:00 +0000
Received: from BLRDHSRIVAS.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 8 Jan
 2026 23:20:57 -0600
From: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
To: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>, <will@kernel.org>,
	<robin.murphy@arm.com>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
CC: <Vasant.Hegde@amd.com>, Dheeraj Kumar Srivastava
	<dheerajkumar.srivastava@amd.com>, Sairaj Kodilkar
	<Sairaj.ArunKodilkar@amd.com>, kernel test robot <lkp@intel.com>, "Dan
 Carpenter" <error27@gmail.com>
Subject: [PATCH] iommu/amd: Use array_index_nospec() for rlookup_table index
Date: Fri, 9 Jan 2026 10:50:40 +0530
Message-ID: <20260109052040.938-1-dheerajkumar.srivastava@amd.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000A:EE_|DM4PR12MB5746:EE_
X-MS-Office365-Filtering-Correlation-Id: b2633549-877e-4710-81ce-08de4f3ee0b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?T24xFROHdfKCv/QPxOjFtksYyVla0m0i27R5P3n6AqVQAiJlRn1RHnSGGnOO?=
 =?us-ascii?Q?0p5HI+ofLBNhOo6e0aRZ8v8rRfZPaYTEngO5D+cNj0tZxjrt8r/jXNpYN1p8?=
 =?us-ascii?Q?tmphrKNPnbJSAxig3CrIYHmT2j4L+o9YFdwOXmCnDJdKrpi9sOiqAn7jsILY?=
 =?us-ascii?Q?hflKHy1Xt0tk2jaSvA3WaVO0cmGb3Adz/xCqlYOzmg2ONINYrBArwFolawMm?=
 =?us-ascii?Q?HuZ+9BJhiGHgAXu0cU1hcpF0Hnx/idS4leQz153cYDExasVVzzB4RkCLy525?=
 =?us-ascii?Q?O39JT9VN5qWy4jhkVQQKCMuNlhGJRA6ECAk1u4qAbbrl2QBkoslzInhyFGGg?=
 =?us-ascii?Q?be857efRjHjrT/NFwTtyqqTrVZq6JN0aHQ00odxzkph9NqH5wt6MRGLOalfo?=
 =?us-ascii?Q?Mwm4OymS6JCZcHwGUFYjp+r6JAtB6gJlJDsX+rf/S+XaLQhFNTH1ewMV5UbP?=
 =?us-ascii?Q?sB4XBVmWJ9Cg5JnGOikFnKix0Ut3E9zXx8Fl7lFqHx4lzrX/bWJKBCUUH7en?=
 =?us-ascii?Q?Nr2E9SDGq1tZqrAQ3kerwc412hLV1ZTjV0P7XxeZtYUK0v+SnNPRFkUMII/0?=
 =?us-ascii?Q?6FM8P8Twb1F2xgkk+vgJdrz2+DUi24o3r8csDeEWJkl7nIJaaU5tpGg00T+q?=
 =?us-ascii?Q?T6hi5Wbeoh+zfor14irDDWMreYHPo1PY2xRyLPndw7kxWv1ws0lY69c5z58L?=
 =?us-ascii?Q?xae/KA9xF6kSMEszkVA2YJZA1u1F5sA/NpBLLEkPZlUDR86NBV7Nz1CQUU7G?=
 =?us-ascii?Q?M7UB4t3jj4qmDyTWes3CY9I3Iy47djLboQtnkwmo40TQWCTiDeomL0E33S+X?=
 =?us-ascii?Q?utyisc0cNld1uTO7suGyA+2l673SgzNlkNEF5XXGUZ3uCy7K1QPySG8074/K?=
 =?us-ascii?Q?6kw6pnb2QV18/2DZzlWnBAAsRxx2rZya2YzhNSkDLXyaPqBikGPRZApT4OTh?=
 =?us-ascii?Q?xtoyAZYMCNVSq0CNe+p3pbjnh/E9fQz5zIOThipB5vPdsQy5Q7VPWhLEGWzv?=
 =?us-ascii?Q?dvCEX/smlv44aq4SzAMNKV2Iqf2ONZqMbacXD4lyJd/iMvwC0uaudKKvGzGl?=
 =?us-ascii?Q?1+uQKo4e7nNrfzPA8rWkaMQXtAE7dTMCqi7cNEEdnDyulIsD3+eHI87toXan?=
 =?us-ascii?Q?AirFvgIsm7+gW86IUKceZUeObDgxp4dXU4JF+T8SgekeR9IogfcK45odYatT?=
 =?us-ascii?Q?l3rv6Fk7yRZSvnw3PwEKcJNy2dtGDOmyGwmQ/Cd2GP4y/IMzw3BCGvlfLpMx?=
 =?us-ascii?Q?Z0ZA20ndsEM4UaUdVd1Jvzp/9283+pTWjPo8VjE+II4wi2k5o9bIVJW+zm0N?=
 =?us-ascii?Q?5qnPxPpgOYsu2ishLRel7pcZkvTuMfTeJ8hqOw7Qd/ERGgIze3h8CTomoXOF?=
 =?us-ascii?Q?YfATHdPEMRIg8itrg5OyHVauWqQFh3GQmqx/RS3+CkApyju/hjedRdnjjHgm?=
 =?us-ascii?Q?RuwbkFPL3+UMy7lli1WmH8IX2DjV2Tze/tqbL48ZViRXnflS7F3RG5x4b4Xk?=
 =?us-ascii?Q?qmvETCzbhnWTn6G0eGRtdpPiRyQSlxMdrm5ImFLIThZ09EC0e307x7TiGUrU?=
 =?us-ascii?Q?SNIE3AIBVGcCvK31CGU=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2026 05:21:00.9017
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b2633549-877e-4710-81ce-08de4f3ee0b2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5746

Use array_index_nospec() to prevent speculative out-of-bounds
access when indexing pci_seg->rlookup_table with a user provided
device id.

Signed-off-by: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
Reviewed-by: Sairaj Kodilkar <Sairaj.ArunKodilkar@amd.com>
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <error27@gmail.com>
Closes: https://lore.kernel.org/r/202510281233.q4cBnp3z-lkp@intel.com/
---
 drivers/iommu/amd/debugfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/amd/debugfs.c b/drivers/iommu/amd/debugfs.c
index 10fa217a7119..4990f6db99ef 100644
--- a/drivers/iommu/amd/debugfs.c
+++ b/drivers/iommu/amd/debugfs.c
@@ -174,6 +174,7 @@ static ssize_t devid_write(struct file *filp, const char __user *ubuf,
 			kfree(srcid_ptr);
 			return -EINVAL;
 		}
+		devid = array_index_nospec(devid, (u32)pci_seg->last_bdf + 1);
 		iommu = pci_seg->rlookup_table[devid];
 		if (!iommu) {
 			kfree(srcid_ptr);
-- 
2.25.1

