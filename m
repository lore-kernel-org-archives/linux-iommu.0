Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2042.outbound.protection.outlook.com [40.107.92.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418B154670
	for <iommu@lists.linux.dev>; Tue, 18 Mar 2025 06:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742279503; cv=fail; b=duStNVgXtpa65YGaAFWoc4GuF/AUrqNw8c8h9kdD1DV/9igJqeVrFPZB3cq+IMBgmKRgKcj5rp+SqF/iZCmC7afoSSku7dHY2pAUJ7dE/OM7S7ntAZhUmW2CadPJVP0TFCOX8aZIMEB4XdUgpGpM/X5ZiyESGkYkPh5/A8YrrNg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742279503; c=relaxed/simple;
	bh=AUSEeb+pXRfW7wTD6zMH4Fqv3XQjXGAIjivNLjxzr/I=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XpG4Mv9tJn6z2mqDtF9do7PbZ14Zm1buu2dWsXn2+23c9S1U8FaCSFsCOGcwJr7OF73w6JxkcgPZEA/jdEn26UkcJOt+N6MdpqKE7/aK2tl+EDFUDN+0e5y4BW9hZ1VFrR+ef5zvcI2j56ndHn85RTNelpLKm+tejBC/rrhs8zg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1mPbVuXX; arc=fail smtp.client-ip=40.107.92.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1mPbVuXX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wNAZDmKMyCx19uYZbmKZAxFneKbZMWPAXyVIZL8KN6KjAHVV89NpnJ5UG1tGB9lHWD8u/Thf8BwsRdfIhLQ/xmWdbbyBY6GeAZj+3bSRO6+nSIvzerkHjv5u/k7OK6/q/BQgh/MSsP6HFZI9/6evpcNhNnyLRceqx0F+/f25+Au/9wD8LsXlu4twkbnqvvQD6NpBwjatr7bxZ/ZasZjOdd3eJzxSzYGJQNkRl+7t5SZpkt3hFjRfALFqXQ39+eFnOXYal5rtbfrdWq5JKHvApYmAX2dqhMamzsPiEvtjFDrM+w0gfILgC7fsKFupTaUCPBfxMH0TNdG9+ZE0iP+79g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WynyiaIUWpSOMOQ5oBQbzp82rRr6vFNuGvWm7zD8h7A=;
 b=gp6dMlwCVGLou/r+oo6fFK6zOdNVEWxfgZkHuWGo2Cc/wqIUbvbP6/4AkzwIua3es2Y996g2huJyE3KiFAFewmCFUcEXa7vuuBCkCCmDurhaJfM3FieQRU6njjSyeChQ6eD/2Njn4v4LIOuoiepNAKYUpf+IBNLBAc30dhnU23GHRecg5OlcwmTmdhcEqyLvnvFM1j93a3mgIlFlmenIcuPDb99mvol5yUA0OVybu39R7YI/ZzUNVq7BIhpuVRganZ5nleK31Tjc/HXwWTA81nk0t6WmrH8vBWqRfnPCKl4HkoV3S+f99VPXhaAMmCSkoVQ34KVBwSGOH61CD03Byg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=8bytes.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WynyiaIUWpSOMOQ5oBQbzp82rRr6vFNuGvWm7zD8h7A=;
 b=1mPbVuXXhO1H6eReRrVLj1xkzKpH5M4ABSjO+NcNjhyNoHE4VzBdVhahwAplkDkPnzRX6gbgVKAvSM2Edltn1IRtMVHDpQidtYieBd+voArlbdMJhUtVRp0mSnIlvlohQzGOuzt6wJvHFoVcygXcCZx6quGdmdMsDMJGdyDC2sI=
Received: from DM6PR03CA0088.namprd03.prod.outlook.com (2603:10b6:5:333::21)
 by DM4PR12MB7525.namprd12.prod.outlook.com (2603:10b6:8:113::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 06:31:36 +0000
Received: from CY4PEPF0000EE3B.namprd03.prod.outlook.com
 (2603:10b6:5:333:cafe::40) by DM6PR03CA0088.outlook.office365.com
 (2603:10b6:5:333::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.33 via Frontend Transport; Tue,
 18 Mar 2025 06:31:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3B.mail.protection.outlook.com (10.167.242.14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Tue, 18 Mar 2025 06:31:35 +0000
Received: from BLR-L1-SARUNKOD.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 18 Mar
 2025 01:31:31 -0500
From: Sairaj Kodilkar <sarunkod@amd.com>
To: <joro@8bytes.org>, <iommu@lists.linux.dev>
CC: <suravee.suthikulpanit@amd.com>, <will@kernel.org>,
	<robin.murphy@arm.com>, <vasant.hegde@amd.com>, <sarunkod@amd.com>
Subject: [PATCH v2 0/4] iommu/amd: Enable support for up to 2K interrupts per function
Date: Tue, 18 Mar 2025 12:01:19 +0530
Message-ID: <20250318063123.2556-1-sarunkod@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3B:EE_|DM4PR12MB7525:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bf4ad88-47c2-4ffc-9eb5-08dd65e6885c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3aaHXMPsK4BmsMDi8FJJ9rhOebYSEQVzZoMm2qJta+JwZH2OwNkHCqqAMOhr?=
 =?us-ascii?Q?FhtXcIsRF9gLDq5e0oLRHS17/G0e4PcFFTOZNhIHC77GgjAjw5p4E+M1EEWe?=
 =?us-ascii?Q?pqRhxXeBUSVFFmU6Mt51eHiNedFwUsvwljIfNhcXQLFenaj98gXYq3iJ+oTA?=
 =?us-ascii?Q?DwkDa0QYhwOC11z2Y+XCuE+BNZLExwhf1WCnDVIn00BSKGv5PhaA/qoAkX14?=
 =?us-ascii?Q?hR51kONQ/NPTNnTJLFZ5VhStaCRFX+ZiPvwBa7K92sSjOwWzNEIrPl+/18RP?=
 =?us-ascii?Q?9bupKQ5ljUj9ZkaxABrnvC6sJ8ltvQuQ9MFHL2illovig6eYp8eB7Xp9Qu5d?=
 =?us-ascii?Q?Dg/EdtT0zJokjXI+69BLzDJEdSj7WIp8IVEKc8CHztLjHYt1EyPzhQvs/L8S?=
 =?us-ascii?Q?HgFlqzakdkftHLsLrxSZezGxcxBRLP9KXMO7Yrp1fPLApU1qqpAVaZ0P1sq7?=
 =?us-ascii?Q?0SA06NsQVEiUXxjP3dJdy2mjVPqPV3QB609pdFhXTUIEh5LC5v6NHNrTWze7?=
 =?us-ascii?Q?dzXt7eRlhknZwHAhGejBIyuh1ul4GBhYwIPczJG1GEVefHrwzlGpzPny1MbL?=
 =?us-ascii?Q?78pGX8FMqWQoDBu9D9L9s25Nb6zTIIXv8JyZFSNnW6NAm8vvudYq/6cvAF8M?=
 =?us-ascii?Q?DJ2fBej/87fZTIPdqBgoS3UxHM2FpL+Owvv9jSM+XAruCrKjcqDBdp+bwY4R?=
 =?us-ascii?Q?QPya1BALUcIFRGV823BJA2TJd0Yi3d4h7RE34yskLjbbI7i25ibhShphrRR4?=
 =?us-ascii?Q?VJTTVVhsHfZw7MMbRRN9s2XO5VT9eFU/5wKM8Pp6rERCv1HomNKjya8LV8n4?=
 =?us-ascii?Q?Jx43495umv3C34Lvo5zZ9pc+CdFdZ2kg0xe93HfllEbmAFjBm7HLneMerIKQ?=
 =?us-ascii?Q?uqizTuYYkOeUg/Yn55cSTkqn7P9YiAQEC/2dEwQie3QZIDB0EMtxux9w7KEh?=
 =?us-ascii?Q?L6iMTHoHTctvdRFBJl64P86/t3Ne4jp5MQjbhVDWjde95P5f555JAam2x8ba?=
 =?us-ascii?Q?m9T+GwP7ugk4GFMze1Dkf/ilmq2ETrxbfoozEZBCgffI/+96uWlRVGlp6v/O?=
 =?us-ascii?Q?u28c6EhDiIxxDfXjzNiLTCJf13zCZvBwbWLZOOTSHBd+ahjjQ3oC8DcQRgFl?=
 =?us-ascii?Q?NYF1voQHwM+RgxLbDdjtvQBNto3awVtBIN6E+eTFEdSj7shhWLtjJJQvniP/?=
 =?us-ascii?Q?fB52kGJ5nq+okpS+tsNYFBWEA6x+sPd2E7mVJm9b5zxD5WgFFItCpVbAEh39?=
 =?us-ascii?Q?f6ge2xW+ZL9ROSO4NxIX83JAPwnBLnQqiDu8x7Y/im9ZqWaXD+ny4KdAs3gZ?=
 =?us-ascii?Q?u1esnFvkxCZj1+lUg8u4Mu0YpOuNrqLALnQEjZRdXNweJUP4gn8zvE27Wb0o?=
 =?us-ascii?Q?wNCQNXFDVMvScnRPjRIbkhT0XZjIopY6H3V4oEp87uZqjeN7uESS9PQvLveX?=
 =?us-ascii?Q?zg6y/1z08DD2OPLpANIl71LlrWxkIuhKHIM6N7Yu5sPBmfYdy9pMkON75kXm?=
 =?us-ascii?Q?ql8JnOyr/uMnZXM=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 06:31:35.9570
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bf4ad88-47c2-4ffc-9eb5-08dd65e6885c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7525

Newer versions of the AMD platform can support up to 2K interrupts per
function. This support can be enabled via field NumIntRemapMode in IOMMU
control register (MMIO offset 0x0018).

This series adds support to enable 2K interrupts per function on top of
v6.14-rc5.

Please see more details in [1]

[1] https://www.amd.com/content/dam/amd/en/documents/processor-tech-docs/specifications/48882_IOMMU.pdf

Changes since v1:
* Fixed compilation failure for patch 3, which was breaking bisect.
https://lore.kernel.org/all/20250307095822.2274-1-sarunkod@amd.com/

Hi Jorge,

currently queued series (950865c1b88 from iommu/next tree),
breaks the compilation. this is because I missed to verify individual
patches after making minor change in last version. Hence can you please
revert that series and pick this one? Sorry for the trouble.

I have fixed my workflow and  will try to make sure similar issues won't
happenin future.

Kishon Vijay Abraham I (1):
  iommu/amd: Enable support for up to 2K interrupts per function

Sairaj Kodilkar (3):
  iommu/amd: Introduce generic function to set multibit feature value
  iommu/amd: Replace slab cache allocator with page allocator
  iommu/amd: Rename DTE_INTTABLEN* and MAX_IRQS_PER_TABLE macro

 drivers/iommu/amd/amd_iommu_types.h | 27 ++++++-----
 drivers/iommu/amd/init.c            | 64 +++++++++++--------------
 drivers/iommu/amd/iommu.c           | 72 +++++++++++++++++++++--------
 3 files changed, 93 insertions(+), 70 deletions(-)

-- 
2.34.1

