Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012025.outbound.protection.outlook.com [52.101.48.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427442E62AC
	for <iommu@lists.linux.dev>; Mon, 20 Apr 2026 08:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776674557; cv=fail; b=C+F2mys+pI8ajjAxKCZc+bzSDB+Ii28/hFehOku4MckMcje7lREQQvHRW0ZHvk2pLkyMEN0ie6qkpMTEm3uQQ69Xla5fKj0ri7LOeY/lP3FqpVT7qIUDd3L4aY0mqu6KcrrP1hQ2aTCiN1+2f7AsYJ2VW9S29Z2iffUQVsHDu48=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776674557; c=relaxed/simple;
	bh=2ShwBe/3dNyNsmJo0tFed80WyEeyGQIXE4djGKX22Ag=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WmsH3thJFW7T9mJBR7xOXFJbN4Hucx4CMjNN+B07bSD0JieKdEI1vETqZKrX8MjTt8tTCsrrHl+QJ0I2Pw+87go6CO1nFfxwxUjOalzoIrnU96Isb+YCjpwrq9bZaKXWjwLjDG2kAiStQbdgp7+UGoMG0cHU91V7nj8V9qld8Do=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=m4JABd6I; arc=fail smtp.client-ip=52.101.48.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="m4JABd6I"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xpEBcdEWBHJE//Gpeqj+a0sdOiFTw6mthxE9S3b2JiahkamP9tv03r7wnr5G9Ud76+nv7wqA2HXBKUFMmNjAAAcv3CyNeRvA6aZ3SsTE36O94nXS5Ahc7rCy11BAKR+GCiEFei6U4YSuKFKiOc+zJpZMhifzqT7YR1JqRoTgqA+hZMcU8k6p9vAuzFLrY6k8RtMILmEce94y76hO1nti118qVLCCX/IvtIY4h2pxRy394ukt+W2nWeSvEz5+fz42Frsosou9jAiA2Rhn+Pm6aqu/TisZvui9HRflN5cKhczUt7t9zT0h78ktNA1sBy/mevonlwZ3AzJfhwbnzVdqOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sMZ0dk1igrrcs+GXZG75H9nB32UGgnMwGgi8YM926Cs=;
 b=p7r0dlTBLiIFd5QkEQJXM9roSVMysj9BKMG/CKqU8DMn2Ty3Mje5Ie/4vTa3wFskHTRffBPt1xHbUccKdFIrcsv2JrhCLkVidry65YStX9+AzCneepXbROBwEnxUWuEGfQ2adBHSM6EtjsqHT7SSoaxvelASA6014rY7yZGwcCve3PjFHmRA/VztgG1QOyHYzpEpd0f3jmCT/4VNbXcDr9GOn1cLRL6ddiPPr2sOKjRV+N0tEIFBKNHTkGOmX225JPV0B/+B2WxioFICNZo3WewaF6dhVXYf0jICD2dJZCHbwYGRXm++mcIAuTcI4VWlmZ/51Q1xDUHxP7PF7OZl0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sMZ0dk1igrrcs+GXZG75H9nB32UGgnMwGgi8YM926Cs=;
 b=m4JABd6IbxocvZQ6YXsiZc9ZJwixxpw249Ir8Fx+4Phuu29X/Oe6sYKFRK4w6Lzb3INIVo7vKnx3zc2rMq6nHrmn+8bfvv2X+alFpmzWclkj6BQmKn8IjOjmI6viBg1+4euWGY/CaK19dw65PiAIqdVGBNsU+JKTWx5S9v0B34Q=
Received: from CH5PR04CA0019.namprd04.prod.outlook.com (2603:10b6:610:1f4::8)
 by MW4PR12MB6803.namprd12.prod.outlook.com (2603:10b6:303:20e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.12; Mon, 20 Apr
 2026 08:42:32 +0000
Received: from CH1PEPF0000AD76.namprd04.prod.outlook.com
 (2603:10b6:610:1f4:cafe::28) by CH5PR04CA0019.outlook.office365.com
 (2603:10b6:610:1f4::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9791.48 via Frontend Transport; Mon,
 20 Apr 2026 08:42:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD76.mail.protection.outlook.com (10.167.244.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9791.48 via Frontend Transport; Mon, 20 Apr 2026 08:42:31 +0000
Received: from kali.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 20 Apr
 2026 03:42:28 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, <bp@alien8.de>, Vasant Hegde
	<vasant.hegde@amd.com>, Joerg Roedel <joerg.roedel@amd.com>
Subject: [PATCH 0/2] iommu/amd: Use MAX buffer size when SNP is enabled on Family 0x19
Date: Mon, 20 Apr 2026 08:42:02 +0000
Message-ID: <20260420084204.12263-1-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD76:EE_|MW4PR12MB6803:EE_
X-MS-Office365-Filtering-Correlation-Id: 8aa29603-aa82-44a8-7dae-08de9eb8c326
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700016|1800799024|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	O/anaoYY3QmqeeTeTTbaoFmXysDVMZYFVoFFflmv85XijUfoyCHFveN5ss+jY5L1uwZmJCp1HHqiClbwVCZA3Ej2Ib6iRoI4GvHx6Z4oiseLbnOUPQ6HuB9NXCpS/QNQFxqSXblTG/t9pbwFRWhfzl2trY8EfF0U+f9lNX+buov4hmbxrJ/ZWqk/Qd+o0bZ1A71ewRhMIu0C72jXalQUCnotivtnk/z+Myqx56J90mpMkYwfv6Ztqh8RulXsf4dFxfQPMHFMEUxq3a7FrIOPmxp0EgCgj8L/dtcq9pxJT2AgE1zE/Bfg1Dm+B/M/VWolGflY4RUCVGfSjbOmCsKXyuN9TD9/a7XrXp8WFXlHNKuj0fdGjIFmJXLC26Rw6dNP3sjEi7LevDrPME5W9K7YyHS9N0fqKJCJmsA/eDNn2ftFuYwVtmuP+zvdZSbcI9+ZMintoZLQBQIRyrmK56agpvzVPDroG/Ie3/aVlP0MUCV3JAos2d6tuChErGSWwBWQ3v8d6Sc/xL2VG21yHN1m0KmHMU3WjbyW+7JqvfcUCBxRp72tA8rUGG+OslhnqBWCXRjR2hqqWd4ejEumHLMr7ED2Tdgbe7J3z4Ts8G8YWc9RTvsAWmv6/r723Mq+jmlgmhcIz0waEMVOYr8pJ41PX6UgaSJZzgGyrh7I5c65C9LmEEWrVU57EqwYO1prfEuMF87azFy+pdzimmU0fYydNboklYqZR1PlO09XOcUI+DD01RmTiDVtTG4sKe5/IgT5f8VI1igBdWZfz2Xg4CxihCQcaK7KKsCVZlD6pwpanSU=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	7IfRj53ip1vNxqCLMWwjutz8NIy0VGhoT/xM9b/JtPU53OTVcovXMA1EradbAliP3IoPcn30Qav4/ILHBxTae3WXDgByAz8iNeHNawxhe/QtobjMz5ZD4K1SyXf7o4U2gt5JXjr085Q4OpPWLZLMOzc4Brwq3QtVliu44kFbaM+XoSxNeMFWebW4dGKOR0XVL26k9gnQqgKccUAHboWBoTwkUiolY2JGiPEoh++aVZE7cBhncmJ0IvO5pPf4BZJqTUNf/iFGvdqwpOFrgCTxKQy/3uTxiCJ+oVTJsffoHOPm+e//Vdbu2OlBYBtimHMkXUguKMZiEQBpRRtSCqo/pU4ZmEdU/33Bwb+Dq0EiwidVQVJiD/iGj3IwfK55+faXHFlIj0+Em6nNuVMut1AmevihKi2VEfux4iSiSLLMGh8+DlXVpnho/MgReI2yFNyp
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2026 08:42:31.7896
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8aa29603-aa82-44a8-7dae-08de9eb8c326
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD76.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6803

This series addresses CVE-2023-20585 [1] by increasing the AMD IOMMU
Event log and PPR log buffer sizes to the maximum supported value (512K)
on affected CPU families when SNP is enabled.

Use MAX buffer size when SNP is enabled on Milan/Genoa. Impacted buffers:
  - Milan : Event log (PPR/GALog is not supported when SNP is enabled)
  - Genoa : Event and PPR log (GALog is not supported when SNP is enabled)

[1] https://www.amd.com/en/resources/product-security/bulletin/amd-sb-3016.html

Cc: Borislav Petkov <bp@alien8.de>
Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: Joerg Roedel <joerg.roedel@amd.com>

Vasant Hegde (2):
  iommu/amd: Use maximum Event log buffer size when SNP is enabled on Family 0x19
  iommu/amd: Use maximum PPR log buffer size when SNP is enabled on Family 0x19

 drivers/iommu/amd/amd_iommu.h       |   3 +
 drivers/iommu/amd/amd_iommu_types.h |  21 +++--
 drivers/iommu/amd/init.c            | 123 ++++++++++++++++++++--------
 drivers/iommu/amd/iommu.c           |   2 +-
 drivers/iommu/amd/ppr.c             |   8 +-
 5 files changed, 110 insertions(+), 47 deletions(-)

-- 
2.31.1

