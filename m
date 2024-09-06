Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2077.outbound.protection.outlook.com [40.107.237.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44BAF15530C
	for <iommu@lists.linux.dev>; Fri,  6 Sep 2024 12:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725624826; cv=fail; b=c0/Cs+6GHzk+9w13HtWxwmOhoHy8TpRR9J7YSHlQX2eziPGALfkj1qVCfvKkxPmCLxFxsKWUIUaIJRvgnwRgWljnahYqFW247Nc3Z25LhdHqKxxGPYYka9DjWf6iv/Rc+6PKIwI4j0EHqgb+MwHt6OVxRbtN3JJG6H1SraSY5nc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725624826; c=relaxed/simple;
	bh=kp6iJDWuF0bXT1fVo3lD231uTNC9dY5bBUW1E0cQUTs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RrEEkg4bK6N+Jbj0YK//uxG3QCey8Qkdh9LXy6Leslt2epSvS3ZyC6yTg/eygscd3riZa5MZxz/Lw7mlp6GLULyHIhRuXufsrNiscJ6+1cBBUp96A3H2t4EVZVTM5IxORvuBpyW51ZmDP3L8ytPBFZcC4ac4DukcC0w60i8HaI8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=aE1hdCoT; arc=fail smtp.client-ip=40.107.237.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="aE1hdCoT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rYNYDbD1d/H9/ma84tTxjXisUgy+jkB40QlFY1F3NbMboZhJcqPnWEkgqT31Ls4VfJClUzVzkg3mUAhOe2jBR9pltoRGZngpIkj1V1do8+wyyuwJhDudmzX+SN+eWOzerxKANtvjSmqABXGlDP0yAm4sZ5r0sN+Mf0+m4aHU2uSCsBW+T4mCx+V0x6wlsQRcqcID3pneez7didsckkEsJ7P7+l/lbcY9oHiRKwBHi1m8xcyb2zyTxH1G6LwV9ElISCojIvG6O1tuxGMbk92uo+WJnvO9j/qLcRVOwkt2tUivQ4k3pfrXcmCxrxfHrjqgQoYGluPNR6Wv+r/XzvbZ8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HRFNkcAx66McAtYgPd+yM5+jbcG8m5ZU9v3gBEzRKl8=;
 b=UzqZopzlJUArmsw7JGbxqlOVN/BDMBWj5RcCSaPB+qOdcEedkYrufzQA+15Xsfb765Xo7ITFJr0Zy9m4oR7bw9I6cTy2hYhNAaTLGCa06yl1WYl2wtFFsWr/UsX7/UiQhnJ4GMitxrvbqL50PKZGzwh+8PukWDe09t9jtpLqkNtJn/oN+TCr7YU+ATc/ApBIzO2FBHkVBlvSxa1d/bfGLm6ikRNXh4aE8FPr42jPkzMibaJpAEREOgLNQCltmdE6ohUsbmoutHYEmjZMzG4CKNyCwHAyflYIUH0jhis/PXoC8KCMFzLir3iP1tQecKIF4UKJWTjvKRYbzdyVPKog6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HRFNkcAx66McAtYgPd+yM5+jbcG8m5ZU9v3gBEzRKl8=;
 b=aE1hdCoTUHfuQLl8rTIBcQIEgAu/9Dh8gVBhGMwVR8x3icuDJO3wVlSa/5TGlra0HJSPY7IriW9pPzYmTvEkVmHFt2g3MIYHDn39o8l33HkheJfv4ocMLPcK2C6tKcUJwkl3pYsQzaX+O4zfn9la1f8FWKrAWrxSsTVj1XGs+NY=
Received: from MN0PR05CA0003.namprd05.prod.outlook.com (2603:10b6:208:52c::33)
 by SN7PR12MB7180.namprd12.prod.outlook.com (2603:10b6:806:2a8::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Fri, 6 Sep
 2024 12:13:41 +0000
Received: from BL6PEPF0001AB57.namprd02.prod.outlook.com
 (2603:10b6:208:52c:cafe::4) by MN0PR05CA0003.outlook.office365.com
 (2603:10b6:208:52c::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.19 via Frontend
 Transport; Fri, 6 Sep 2024 12:13:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF0001AB57.mail.protection.outlook.com (10.167.241.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Fri, 6 Sep 2024 12:13:40 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 6 Sep
 2024 07:13:36 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>
CC: <joro@8bytes.org>, <robin.murphy@arm.com>, <vasant.hegde@amd.com>,
	<ubizjak@gmail.com>, <jgg@nvidia.com>, <jon.grimm@amd.com>,
	<santosh.shukla@amd.com>, <pandoh@google.com>, <kumaranand@google.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v3 0/5] iommu/amd: Use 128-bit cmpxchg operation to update DTE
Date: Fri, 6 Sep 2024 12:13:03 +0000
Message-ID: <20240906121308.5013-1-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB57:EE_|SN7PR12MB7180:EE_
X-MS-Office365-Filtering-Correlation-Id: 6144539e-42c7-457c-8ce4-08dcce6d5853
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?W7FNpcZAHCpadxWCIKNPj1zNSrQGqjxTgpxh8luP/7CeyDGXsvS+PHUIfs6g?=
 =?us-ascii?Q?QvAaE9qp0NKiBrBwu9IcF8q+nKY2Asv7tUXviBhQyTTKyxiwXNMRAWe4JNa2?=
 =?us-ascii?Q?vAlBwsucjbuL9tgvowIcJWX/h0CCMed2qoH0E8Y7LsQFIP9uDqGLW5956/a3?=
 =?us-ascii?Q?ubJKM7KkxyBMzGj4RtaB6Rjz8oUsQKpCF/jj8JfTX1qvgkefbz5bG++ilVNX?=
 =?us-ascii?Q?NlhGGXrIi1l5sz2TUCrt7ojgcdAKJjqzuJ2lzEP77c0PtPEWpwN3gYebzCxo?=
 =?us-ascii?Q?pYHHM958E2zHB6FDZFRtdeTNaFD6LC3ANnpatoOMzHRKc+ifv+1Zum8LaxN6?=
 =?us-ascii?Q?EuXDLUmAF16rGmjfMzCFiJpsPRyz5JkrbLdSrF9whbzyMmXYm1C0HLvE9d0B?=
 =?us-ascii?Q?XMJg79/rnzOkpU0ONrrgMZImO90JM2/cQE0aRYl3B89zW6wutQHFWmBEcK4Q?=
 =?us-ascii?Q?QDTgGFq9sC82SZwGFArLpgC9tp3jqphAquxONC7ERZ5jpLZw5+/deJ+CnAWa?=
 =?us-ascii?Q?clhZ/33K+HCajI+5sAXbyrDcM7AnpwslPR5qVajjaQD5KkEpQD62bI/NUrN4?=
 =?us-ascii?Q?aBkfiwH1btjH50e7QB8Ph4TkhHCtgw0p6C/b2ukfnrGKz+guzqwRWmEjjnqv?=
 =?us-ascii?Q?5FJ19JvvrMChQbocSLqoLCBU2DmhzBQKRRP+8JIKjtr/2EkJkgE0KPb9ugvd?=
 =?us-ascii?Q?JFeEA+BUc3FjFWbGoBmnzOpwErOxUdoJMAYUlGL2wUZmChmPK2VBycSd9MTs?=
 =?us-ascii?Q?iN2hEL1LDU2uDMPkiM/ZXMCl6/2LahO56wab4rjoL03W+bUJKDA017VrfR4c?=
 =?us-ascii?Q?KAhDlqjeyH/ZYNCmhN/rY5//omZy1qopv7fir6GKDaL3x5+6uanqWPGskO5d?=
 =?us-ascii?Q?4tcX28ZAn/XVcevj/tGg9t8aqVq5fX8Je/brmFsd4GcXXN/rRS466bMpcAt+?=
 =?us-ascii?Q?eOT5c597V1+Mwe8VG3Y2eHIBZcejtAqmlHJE/BHbqB9kkh85aAE/NELZTf1+?=
 =?us-ascii?Q?V93W0pwbPLURoRKGHB8tOKONo09eAUMrbKcfaTR8tl7Ups9U7wzJtiD8349Y?=
 =?us-ascii?Q?4cHyWir9stlKnWYp36AgNluJBmD/nWhvV9kXBEQDKpe8td3HTlvp/zBL03QK?=
 =?us-ascii?Q?Y6g9mYuFuS0XogZHmali7JHAwDC+66XHwJyapJtPMfKiaRp2OIlx9e3q9J+W?=
 =?us-ascii?Q?ygBTxjDmbX1bhuD2GdWucpAw7DmBnaWMalWX1oAfUNd/HD/EiJw6QZqZty38?=
 =?us-ascii?Q?hAA0dh49jlDV7fCa4tnHXLBWR4t5AU5NuRFDQljSo/XwHLJfVqAw8eyjBlgN?=
 =?us-ascii?Q?rebuhZh0H4vCqvpFgkyUKPQVD3Ai5S4eJNw4nITTqnEb/SYUQXrfVCBlwbuK?=
 =?us-ascii?Q?rIXL2Eg6wWFF4C5wD8s54MTQMRs+Atz2qD3k0ZW03crwGUtcna0qVinreS41?=
 =?us-ascii?Q?CpgF6oB/2pSLGIWIws+dsdYQO7L1aGGN?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2024 12:13:40.7614
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6144539e-42c7-457c-8ce4-08dcce6d5853
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB57.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7180

This series modifies current implementation to use 128-bit cmpxchg to update DTE
when needed as specified in the AMD I/O Virtualization Techonology (IOMMU)
Specification.

Changes in V3:
  * Patch 2:
    - Consolidate patch 2 and 3
    - Change rw_semaphore to spin_lock
  * Patch 3: Expand locking across 256-bit DTE read and update
  * Patch 4: Fix clear_dte_entry()
  * Patch 5: Consolidate amd_iommu_set_dirty_tracking() and set_dte_irq_entry() fixes

v2: https://lore.kernel.org/lkml/20240829180726.5022-1-suravee.suthikulpanit@amd.com/
v1 :https://lore.kernel.org/lkml/e937e26f-038a-6d01-76a9-76c86760ca4a@gmail.com/T/

Thanks,
Suravee

Suravee Suthikulpanit (5):
  iommu/amd: Disable AMD IOMMU if CMPXCHG16B feature is not supported
  iommu/amd: Introduce helper functions to access and update 256-bit DTE
  iommu/amd: Modify set_dte_entry() to use 256-bit DTE helpers
  iommu/amd: Modify clear_dte_entry() to avoid in-place update
  iommu/amd: Do not update DTE in-place in amd_iommu_set_dirty_tracking
    and set_dte_irq_entry

 drivers/iommu/amd/amd_iommu_types.h |   8 +-
 drivers/iommu/amd/init.c            |  23 +--
 drivers/iommu/amd/iommu.c           | 272 +++++++++++++++++++---------
 3 files changed, 201 insertions(+), 102 deletions(-)

-- 
2.34.1

