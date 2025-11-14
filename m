Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013011.outbound.protection.outlook.com [40.93.196.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46EAE3090E2
	for <iommu@lists.linux.dev>; Fri, 14 Nov 2025 10:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763117124; cv=fail; b=e55y/57CEdr1WH3GciVnDNTjVTdeoKCkMd6gXFy1Yfm/L43FCODTkB9dunFQaFKRr9e5SjmMXCKazEibfJSMCJrj8Rtw9Yw4dlvnGYZUy+twj/S/TMHl7G6b0rpaO0C6sNVSmlWT+Yi4r5Aj7Kkh4EzWGXSibaiOuvUjLOqCxrw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763117124; c=relaxed/simple;
	bh=EBYU+Mbl05C5aGNvx7fnF4ZduYeQksHSBkjz4L7WASQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TkqbnOjTxWODis5KSnKL7yYXls2FgfzeUU6zjqjVd9BVFIC81/6z8aW6z1WZusO87nwP+QtvhR/0GBpsENp/h/t7AkJiwKQwbAjcbg1fcdC8XyxnozwcUx60t5JzW0/XBc9fwd0Q256kfgBJZF31TZBY3T6Nx3FrTCnMcF/GbAI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=v4Mb7lNt; arc=fail smtp.client-ip=40.93.196.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="v4Mb7lNt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X2z8bZGRqq0WJXbPpUJFHotLPHhlIecEG0ePW54xJcUQaAu6R6xpSgt7xj584tIAFow0vXEM5YMNuOgsSmg7yMeD8xInIfCFUvXVWNfWFoLkYdjbYUTOrJTA0gk5YidRAh86ZSqcUPmnTEPBS2RXSkOFBJ7/PKNMembNNwpNRaaIoYe8smHyTMiOMtjMvc9SQwEJ5ddr1cxWmWGXPBNm/yOmBDz72kvKbmpJMw86kz8XRRT9a+bYQDLYscl5Hz0KPfwXHZpq9w9KAKeydG0VHT6SyC/P+isgYQHlW6Q1HHbVakRm0uzZiVItHMI296jO4fFGB16GsvL42bafsUFeYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NrQ5/Ss1UsrYxwEr/oHahdmym5akk827eJ0ynCFanGg=;
 b=UaumyjIoQpp/qKCWOlIQVZrn5w9kA1uKfJVHWHesZL0YittfbeKBEzhwAUYG2sKVvnzXuci8FxkdQS7E2Xv5Z3TMTMiY9Ns8SkMPqV0+ionZW/C+jZzGjPFIvrQmRFOM3SbrIK5oGSPtYu/4doM3wrovicFLQKThZvi3eNmRhYkSJLWF+rpyfNfjA/Bgaavu4hhxSfnLA2m7fkPeUZrUCuZ4tNCEYH71LW8i+UamRtG0laYx9urbFY7Aw0ReTNVwJEa8nu8QZ+G9dwtC1mvUVdTtpJ9axd0WJvBehVvMk00dgN0nTjgJSuti/aOXcOtesXUw226pA+5+2o8rHpLH/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NrQ5/Ss1UsrYxwEr/oHahdmym5akk827eJ0ynCFanGg=;
 b=v4Mb7lNtvgqmXWiwO1DWIYYKkyOMWu7jRBXqWcn4hLrnWVRMs4rocVx+n1lLPtPf+0oslwAHK13IpP0s7FtDvxO9vrHbjs7leSStwWvRU9ONyNUY6csX+91zrBUWQEs3hvO+/A7m3UcsGtUGuqD4bvP+1Dm1BIJx0UwoNIt2GqI=
Received: from CY8PR12CA0027.namprd12.prod.outlook.com (2603:10b6:930:49::6)
 by IA1PR12MB6258.namprd12.prod.outlook.com (2603:10b6:208:3e6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.18; Fri, 14 Nov
 2025 10:45:16 +0000
Received: from CY4PEPF0000EDD5.namprd03.prod.outlook.com
 (2603:10b6:930:49:cafe::d1) by CY8PR12CA0027.outlook.office365.com
 (2603:10b6:930:49::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.18 via Frontend Transport; Fri,
 14 Nov 2025 10:45:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EDD5.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Fri, 14 Nov 2025 10:45:15 +0000
Received: from BLR-L1-SARUNKOD.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 14 Nov
 2025 02:45:03 -0800
From: Sairaj Kodilkar <sarunkod@amd.com>
To: <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
CC: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
	<vasant.hegde@amd.com>, <ashish.kalra@amd.com>, <robin.murphy@arm.com>,
	<will@kernel.org>, Sairaj Kodilkar <sarunkod@amd.com>
Subject: [PATCH 0/2] amd/iommu: Preserve domain ids inside the kdump kernel
Date: Fri, 14 Nov 2025 16:14:40 +0530
Message-ID: <20251114104442.23296-1-sarunkod@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD5:EE_|IA1PR12MB6258:EE_
X-MS-Office365-Filtering-Correlation-Id: 3dab3089-dff6-43eb-f085-08de236ae595
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/TvbjqOsLAxmEWSIWLxvVnI6b0zneTrGWAW/dOFhgI0dFpZA6ORHiobZqbc5?=
 =?us-ascii?Q?BphDF+Pk8JoQ3Y7W6nyFs/YvhYaVh/DTrxOYUwDr7y+J5bEJn/H5GBaMw/2I?=
 =?us-ascii?Q?V2S6K7W1tIZ5O9uC88YPbxyZfnKTk/MU6RTQmwMGP1+kinop/s92UMXriH1P?=
 =?us-ascii?Q?3UA4PmyxLqKcbW3O4USc22Wge1iEWyMIrohCLih/cBd0SwE/e0dwbaDjsn3h?=
 =?us-ascii?Q?ZhSCtN8CGbOp9X1T2novDjWkXGEx5jTQgkI6wTCdvsd8CdkdtHpRj33qLDPk?=
 =?us-ascii?Q?kAyKH0aJ0o+7wt34eebgjWqzafuucBowXHAKEoz8l5yWHP9F6OBPHv7crFJd?=
 =?us-ascii?Q?83m2+nSpnMpwvrTxsjbahMlI9Sy7AAu+gI8FXjlwCIJh/Vt+EBe4FSrTE00Z?=
 =?us-ascii?Q?anrpTxB1DF739M3QksxweD5kLgeLnsqe2KNahesqnp1JTTgp4IUMkt1wGWrQ?=
 =?us-ascii?Q?xCqQTtHcZhMZfExnpfXlgA7cM4LyjSwax8YmLrHZz7ilbDQ/PzpLjBJM6g/L?=
 =?us-ascii?Q?tTu/gcVBlizfyErnb0+JW+txsgQCpmJAdVKcQrhqRjjqpSorTkBmjjnmI7am?=
 =?us-ascii?Q?Hp1opRx4lkFXlappvBHb6WaGl/l3atRHk+OPSTqpxv6793UHKcv3pNhs3KvN?=
 =?us-ascii?Q?NwIOfbc2Hj3OvuLIBntdHXb1euvuFiPaPgOWLJF+9rjJUdfYn/aiMe/mIdZ1?=
 =?us-ascii?Q?jdV3642oxQVvDuxE9nhmqUKAzYLLqzSRdWQnzbPznc1qqA1HGA3THySGTtko?=
 =?us-ascii?Q?gxKI0IbezzYbLZVsMpVDu9sEUSoAqBfwYqGFtoDrqtKFEP5NjGRHsVYBk4Dd?=
 =?us-ascii?Q?sbwiOpU99XIg20v/EdT+TR2pgPriC6bDlfQr7mZ9xg+faj71KTFrYQAiecvw?=
 =?us-ascii?Q?DoblESDWt3jbPsBSMRtjwEh1CQNn6MwfgkyihalcszIMvCGE6dJyINubXUa2?=
 =?us-ascii?Q?gjk/jWTPrwx6uZqN71Cj2/T2ptdP567v74vlJrQcp92/e+vK4s1Hocsih46M?=
 =?us-ascii?Q?/J8wbnU969CUZ8wdOYSfVq4mBhZM4K2hIDaevp8FBX06He52b6Li9eZxCMTo?=
 =?us-ascii?Q?7NGfDyNW5SZ/59JLSK/2QcdxV4NojEMgprIEsFQmUJfcCViu2WtoWnX27egQ?=
 =?us-ascii?Q?s9Url4CaPxWpbm/KqAAYAd55lwyNBoEDCnKwCL9YVqO7fCJh9CtfOlHVcz0U?=
 =?us-ascii?Q?PIeiXP8UJ07LZxUBQ/w5PaLOx4rERWn18wZyKyD7dzf6vNKFvhP7cK59W1fB?=
 =?us-ascii?Q?PTeT8IcPWitlGLZA4NsDIfIiK0ZUBhE/t8WapNnxGWrZYPwAl23HNMjcwTVw?=
 =?us-ascii?Q?iBI6ZPNWTA40MQceZKb6CKlyOj/neLZ+1rsTepgnU7bV/cr+9pjxjx6ONSUo?=
 =?us-ascii?Q?KKwF/QYDpr+ySGgCad4ZWDXI5XFyJl0/yCMRUVbOTFIkVRU6yF4ErfuSqyrY?=
 =?us-ascii?Q?m1Ljb1XndzNFYycfQCfe2nkV+65G3bZ/LgobmqzX5dDdg+mgLonrB0vS+CkN?=
 =?us-ascii?Q?6uyo8w7BsuoI/aN0RSgx6P6Ud3sGjVtPWn2OBYw1oJoJJk4gKch9edgFjjn5?=
 =?us-ascii?Q?u++3lzXM1kjK76lsIcc=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 10:45:15.7632
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dab3089-dff6-43eb-f085-08de236ae595
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6258

Patch 1: Reserves the Domain IDs allocated by the host kernel while reusing its
	 device table inside kdump kernel
Patch 2: Cleanup around pdom allocation

Fixes: 38e5f33ee359 ("iommu/amd: Reuse device table for kdump")
Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>

Sairaj Kodilkar (2):
  amd/iommu: Preserve domain ids inside the kdump kernel
  amd/iommu: Make protection domain ID functions non-static

 drivers/iommu/amd/amd_iommu.h |  5 +++++
 drivers/iommu/amd/init.c      | 26 +++++++++++++++++++++++---
 drivers/iommu/amd/iommu.c     | 27 ++++++++++++++++++---------
 3 files changed, 46 insertions(+), 12 deletions(-)

-- 
2.34.1

