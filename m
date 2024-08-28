Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2054.outbound.protection.outlook.com [40.107.244.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB460188CA6
	for <iommu@lists.linux.dev>; Wed, 28 Aug 2024 13:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724852686; cv=fail; b=OtczGgbS7q1FFssYh+oJ/4WD8Ym/Ugac6cZZgtWLQIbP7gVGBWFomK9ioH5HWav5U1jFBg/AUePDvw6zrBC7vCD5eMnGvfe+u3UB+CEo38BDxwbs8Qz+be8gLj35HOcnlmpTcJ1tKcXo//MSNet+KC+U9VSUtaGrpJZO8kb7Sok=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724852686; c=relaxed/simple;
	bh=T+Nsgb96NjzBg1gk1Sb7khqoUAZ2RQtHRcWLm0ykZ9o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iwcG0TDGKEaF0bHmEJlxqx4jgQqeQcTxfNoS5X3xwOJiDCbtwoql/pLVr8UytVR+l17xtFYCDh1UGrlB2yrJF4TRGOS9MRjaOE2NmzqSJ7c+4FvWDS9XXEzT3AhRXmLPfyD1S7OMTvhTgS1EIj9rjT9GrDXH3dqipBOnEIB64QM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3fPxo9hB; arc=fail smtp.client-ip=40.107.244.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3fPxo9hB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FyxN0DK6eSinU3kWegnC72VhlpftYWmc+S6sCN+H+4E57ozdhdpmHOQ6HHYpAHKMk9zLNBIrzxo1uJX4bSJs4fgy3rbxd+TUw1lxtJD4r1/O2dnuZiI4ep8q4FZHu502K8/vyWRRlT8Yq2jvqXlCf/gM/1MXoEHdUUMUppOZzVTxbSsVvuyVV6yg3MA4pQc4Ga46Zy9CVrJolZcuuL4ch/EFEeC7vV2L4f+UlUjlALAZZ14KjYmN7n6aJCm9Q8jzZDNFOMPKaYUKAq5F/L3wZh67b9a+PZBMygde3+JC79ZG97wLnZCc0093ZQnOfPj4g5IlVRrji7dZ2KdTHtUhZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sd3tPkSDaBjhS48hY898t9/RdOV4f0YI3GCo93U2u10=;
 b=fKAnzCiOngb6NiZVhGSDUoHaoMbpHSe4zF5zHo8zOqdGJM60mpp8f5tgubvE7upktbbkAYyKRWDvsAGDSYSlOw4WJW78EXGLX/mKvDErv4SkgkRDA1t2sZpuDFeS4EEkBqWLrZrU4OE4Oei3zBbv57FgcpDMqTPKgPI3vS5YLM8XKSmnPPS2w/Da9iaTFCdnkD/U4h8OhU9Dot8nxAxX0JVwJz/b+Il8Ep7IgjwOe8i+FoxFTPYEnrMYzibt7EOIjt0MtBK5uEn6f33dFnw8SlXL83iv4fqhp1V66fi0DgC10IQ8B4fdjvxWZAOd0XCVyugGYk7RvSwrCVMS5y/KGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sd3tPkSDaBjhS48hY898t9/RdOV4f0YI3GCo93U2u10=;
 b=3fPxo9hBs1M2RwAbU1qyxaIKo8E99alUOgmtJKO5p3BEcIaGQP6sbVlJiwTfNC9kFAEEhYfUZiv4XyTddV9vJO1IQtO2P+4mJYCV4tsNrJYc2SWcVikiGNnG5sNStNXVA/xshksbLfHjmqHuAK/ocxTPRsEr9lhfn1KeaysB9ME=
Received: from BN0PR10CA0021.namprd10.prod.outlook.com (2603:10b6:408:143::24)
 by CH3PR12MB9432.namprd12.prod.outlook.com (2603:10b6:610:1c7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.27; Wed, 28 Aug
 2024 13:44:41 +0000
Received: from BL6PEPF0001AB74.namprd02.prod.outlook.com
 (2603:10b6:408:143:cafe::a1) by BN0PR10CA0021.outlook.office365.com
 (2603:10b6:408:143::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.26 via Frontend
 Transport; Wed, 28 Aug 2024 13:44:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB74.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Wed, 28 Aug 2024 13:44:41 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 28 Aug
 2024 08:44:38 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH 04/10] iommu/amd: Remove unused amd_iommus variable
Date: Wed, 28 Aug 2024 13:43:11 +0000
Message-ID: <20240828134317.6239-5-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240828134317.6239-1-vasant.hegde@amd.com>
References: <20240828134317.6239-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB74:EE_|CH3PR12MB9432:EE_
X-MS-Office365-Filtering-Correlation-Id: fa272f5b-8650-4f26-8707-08dcc767914f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dQleMaPK1IUo34Z/sKLieXkzRjXvOWltl6s4psF379XTjHqKr8oJRhlHKoNi?=
 =?us-ascii?Q?g6hFWCWyw8BPP9oY2yWbIyOXKlHJm15muHUsYeSGAJq6P7XWfE1qxWu0z+AM?=
 =?us-ascii?Q?n7iw9qk0MCPlLB85CpAJo8lO5LxiQUOgy+Nmgizo8nXYapH/iNESaybUp+pp?=
 =?us-ascii?Q?vlC/v5PVyoBtW/vrrZJ7dLo2i+gLQY+dBhamgUsAktkWZmkjhTr2UY16DGmv?=
 =?us-ascii?Q?6GE+rQBqwVjuyCjVhmYhW0ZKiGZRTG6LGp/GuMSyISE/Ovre+enlEPDfKPXu?=
 =?us-ascii?Q?63BmJZ2stwp46eBvf6cIbL/e9/xF1cygUoN1lXSbuCVdSC3dq1TX1yKqYvol?=
 =?us-ascii?Q?MbohN0YwWzLXKKd/CzQiMuCvDcpZGeO1iypN4DmfPgsEGlxcp2Vv91I77NyN?=
 =?us-ascii?Q?WWOKCZ8q6OGGQRep8oM5+kFeUYeDvLOQ8ThWm0Ucu7x7EYW8hkrZ9sjI9tTi?=
 =?us-ascii?Q?Jo4zaZKay0yhPNVuWD+k9vaKCIiwFTHiQz1ufl3EYgrPyEA5OQ/yvODneQSU?=
 =?us-ascii?Q?Zz3fBWcu6Xs3JWVg5v3blfwzwS7knLXwFvI6p98wHO3YcGvBk+QZfvmtwun7?=
 =?us-ascii?Q?W2QcMe8Hxmy43+Kw0sVtWuj8DZ5Gln205xpoCv/Q0Xh5QUVintpS7h5TyfVI?=
 =?us-ascii?Q?tfZZp7KX5Nw7eValzbVjcCp/vZA6vQ3KcI6VYkTR8dMeWtEisDOPx8QBN+2M?=
 =?us-ascii?Q?9NYHgtAvEUvy5kwQSgLmZ7wP7oXBwkc/pXLLhoxmrMP3LKH7x373voXEoq9p?=
 =?us-ascii?Q?Sf2mB3Fcaas1ESPQtEoiViZ7saJt9Q+xO8DHC4/qAtriYfBW+GCL4cO5tBOC?=
 =?us-ascii?Q?SaFSR0vyMJciQLAGiRX7jM2GRzC4rILinhp5rqK+pG5xGOnMzsLFyAKrXE39?=
 =?us-ascii?Q?J60RuEOkcuqngZ32etyD7/fPWY4G0iE3nh6xRd3RgtiH5fA34V2fmf2JDCbW?=
 =?us-ascii?Q?HCsfemWwRDugwRrFF0tdCQ5XlTW2sDSdaSXkdhO4O6a1xZwa9c99QqO2i9G1?=
 =?us-ascii?Q?QAzZutlE5WWo7k0C3ovV9jIwY/fYutgAdQZlyWU5ke5Jxxge/QV33J+1MBiR?=
 =?us-ascii?Q?OjwfauVqgnf0Z2jSCw2bYWcWLdk8HWhHcrsYohtDWMzomMTEYo3RZYTBlgf6?=
 =?us-ascii?Q?aMeepZn0qEIpV6PcprCm+5NmkfaG/LwEVe/mDj0z93jVGAMUhHT0pFEMO0ET?=
 =?us-ascii?Q?A1Do72HeDlOr5k7Bq6Z/PXcik+u5AoaApLBBQVRLz79xrg8ZA6DDJQvgjoFB?=
 =?us-ascii?Q?79cO94pZlu2klhPyH6Zbt0Mj8rEmF6qCZQexCBshTpFdzilA4YK6jpJsAySx?=
 =?us-ascii?Q?EsVtQu6nPRaoBo0/QzGJR+b3DUDXrF3a1KK3JzWoLpOXynB1JplFGkOimBuk?=
 =?us-ascii?Q?w8eRKPU0nxWD+88k0rkqVkOl03/XMW+mBgVaKQn0c17Na+SHGWi0usXHbxDY?=
 =?us-ascii?Q?+W1baRX/nUON+RAL7wxXF6P4bGH49WI0?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 13:44:41.2609
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa272f5b-8650-4f26-8707-08dcc767914f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB74.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9432

protection_domain structure is updated to use xarray to track the IOMMUs
attached to the domain. Now domain flush code is not using amd_iommus.
Hence remove this unused variable.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h | 6 ------
 drivers/iommu/amd/init.c            | 6 ------
 2 files changed, 12 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 7c08325ab644..4ffe87b71caf 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -874,12 +874,6 @@ extern struct list_head amd_iommu_pci_seg_list;
  */
 extern struct list_head amd_iommu_list;
 
-/*
- * Array with pointers to each IOMMU struct
- * The indices are referenced in the protection domains
- */
-extern struct amd_iommu *amd_iommus[MAX_IOMMUS];
-
 /*
  * Structure defining one entry in the device table
  */
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index bc1fecb67687..012a539cfdcb 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -177,9 +177,6 @@ LIST_HEAD(amd_iommu_pci_seg_list);	/* list of all PCI segments */
 LIST_HEAD(amd_iommu_list);		/* list of all AMD IOMMUs in the
 					   system */
 
-/* Array to assign indices to IOMMUs*/
-struct amd_iommu *amd_iommus[MAX_IOMMUS];
-
 /* Number of IOMMUs present in the system */
 static int amd_iommus_present;
 
@@ -1740,9 +1737,6 @@ static int __init init_iommu_one(struct amd_iommu *iommu, struct ivhd_header *h,
 		return -ENOSYS;
 	}
 
-	/* Index is fine - add IOMMU to the array */
-	amd_iommus[iommu->index] = iommu;
-
 	/*
 	 * Copy data from ACPI table entry to the iommu struct
 	 */
-- 
2.31.1

