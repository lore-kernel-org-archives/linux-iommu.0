Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2040.outbound.protection.outlook.com [40.107.93.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A4F1ADFE4
	for <iommu@lists.linux.dev>; Thu, 27 Feb 2025 16:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740673956; cv=fail; b=A+BH3umUkk+/ZNI2r7bTtIEEkAAI2GdWDxBoSEizoXs4vcSqMYylp/A6hCtRy/tLUH0dCPHdFVztX4edq6pK+BbZhEpiyx259KpMZHQCReWd61Nb3cYIugCuy9IqVHeuPePdOX5NXBYqJS+pj5CcaToskJbQhqtwj2rG1SZg1EQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740673956; c=relaxed/simple;
	bh=Kx0eYkxOKBMSNMULDtkNfBJyNS2x5W7mUbl4nmNc8Bo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T1+99w3Gb7LvAuoNtdR/T7fr5dFxEXsPLzAbbwnjTAxezqEYZbLd7nzMz2FNFkIhekbYeY4hClrjTvdecaLVeMKKbfsxNGM2nEVwmLPMpFc1i9cfuG/9ICQaxSlC6nGqJNIm1nSb5CQ7L0exiiYK16UsvmJPZj32YTFTeBxziP8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=psyXesxI; arc=fail smtp.client-ip=40.107.93.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="psyXesxI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RKMXLq9wKiX7VUxkSAFHqxipHVSs+PaFHiLXOOcq6unIIqs0bilQ3H6+PHfIwjAeD7n5auzgi+vlTL9qj5wTIkWj30cCXrLW/8MatJ1ceukXWlzvY9VAKTg5FtZfzTb4k6UjyYXaNrTm6YJqOFcrUHG72O0mFm+5JgVgmK1JmKjrUFEDjoeyp+kFTPpawzy9SyktL0Pdw0WGsljYCjLoPbvvwMEl04qDMUj0xrs+grrhJXbuS8P4dhYlMFZI8x3DYSac8xBXKOdcK0casKS5N7ZJQcVyJcFrDPy4fyQz/aTmtn+/wdTubwr0BZ7+VEyHa7OMbfDMekAkaVzbj3mA5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7o/hW5qSDv/ce8ShY4zs06NOrk4fYkLyW7dXuBouLUo=;
 b=oMebUaJutKmq5YjRzDRh2i6V7922p/ihth5IOLtIABgCtKMdF2PEalDPNWc34gY13ASgqwT2Xun3z+nYLVmWs3QozbVNm/kWACGH7DsLtfX4HjQlTd2iC8Ro9XJZC3Gio9R+nNDbdOM6eYcnmE+kKLgwp+toGuonxkpa2dT9YtL73Hr0dNWiRVewotRH0J4e7NuU/bxEj8/sshF4iUDt4pZK7ZaCAmHV1qKVPdAmisZxl19xJqKMscX4obGaCFXOX7iX67OKb7ek8dNdEu6FFB5tQ4AEWxpOvVf8YfCBjHr841z7r51hnwYCHg6FWUfEIWN2Z95rKAPZdvhTgPmNNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7o/hW5qSDv/ce8ShY4zs06NOrk4fYkLyW7dXuBouLUo=;
 b=psyXesxIyJICKS0X/KV1Fk7O1QO0Xvxp+jr5huIxys8EEuWDCe1EgrP4u1JmvYa3MbCO8iZEnL/7/o7Yw9mNRGQ01sq3902h19k4uSUDIAEXMOaqVIzGAVhsN9RA1p6mP2fQ8CpoEsi62HTJDHLu0dtgpqWp90gCowRYHZW7Id0=
Received: from BN0PR04CA0086.namprd04.prod.outlook.com (2603:10b6:408:ea::31)
 by PH7PR12MB7114.namprd12.prod.outlook.com (2603:10b6:510:1ed::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.21; Thu, 27 Feb
 2025 16:32:31 +0000
Received: from BL02EPF0002992C.namprd02.prod.outlook.com
 (2603:10b6:408:ea:cafe::49) by BN0PR04CA0086.outlook.office365.com
 (2603:10b6:408:ea::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.20 via Frontend Transport; Thu,
 27 Feb 2025 16:32:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0002992C.mail.protection.outlook.com (10.167.249.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Thu, 27 Feb 2025 16:32:29 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 27 Feb
 2025 10:30:36 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, <jgg@nvidia.com>, Vasant Hegde
	<vasant.hegde@amd.com>
Subject: [PATCH v2 4/7] iommu/amd: Remove outdated comment
Date: Thu, 27 Feb 2025 16:23:17 +0000
Message-ID: <20250227162320.5805-5-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250227162320.5805-1-vasant.hegde@amd.com>
References: <20250227162320.5805-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0002992C:EE_|PH7PR12MB7114:EE_
X-MS-Office365-Filtering-Correlation-Id: 34fb04e4-411d-4e85-ce74-08dd574c5439
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jM0zJsDWGnA+2kdICONrKwv01r3ABiU1x9TH7w2SF5WowL4p8keADmeT6urx?=
 =?us-ascii?Q?zd4raxgR+97qeFH7A7JukvvAhNd/afP53r4e7xUg8Gxq62PwtkfU9/TC7Ndx?=
 =?us-ascii?Q?tJh8FQ6TcR/VFhybDr5cEGa2DJf1DD/i3e5VQV5QVbUghFUbieUAgGw+XgOC?=
 =?us-ascii?Q?cpFEZqFoTUMQruzC0vdn71s132n0dbMvOsSR1Cw5PU4dFDGLuOERBmQsbL7V?=
 =?us-ascii?Q?vs63g6xudNcbM/k/YG8QTbRd9M/8BGwhW6Kfbw2U67qYElOfwb0eu546W1si?=
 =?us-ascii?Q?jtp1c7EKzFfltCjBTT5dMBbAJDqVycMKMUfvf5qFPvkl2EFENaCR+pXyFNvc?=
 =?us-ascii?Q?dhVsIONApJ2/LX6X2ns2QvcGbU5gUmpTIPUCJnGAPIXmDZXC3/cRwAbDW6cx?=
 =?us-ascii?Q?pkyCUvFcz6/zC9HFPVTDgXhJEVtPH6aoM/VIFObUaLSLn5WkssjQOaaedrM8?=
 =?us-ascii?Q?jfTOixpNNX9ZMI0mtmHVyWUMRGFEHsptVLhJZfmGz2PQ1U9+g353n7nxjoiY?=
 =?us-ascii?Q?UHfgizcPveN5lKmuDL394VkNUXp4YOZyINVOHLAfBjaHvJzhJZI78VLU8QeT?=
 =?us-ascii?Q?20vJKobvXRyzdmVmqxxa/+5ZMP7lC/BikyUIjxv7MCTklKgjUFfSJDCwLC93?=
 =?us-ascii?Q?d2wPFZKs/ekWw+5CUxHetYu6vCTdxJHMmX/u+IBrfn2JD63fkRDJuYRodMyx?=
 =?us-ascii?Q?Q/6zwqy/+TeDiDR1H0FZ06P7yT2eEWFQHgEtPM7JLNbiPbAqrW7k0/lj0mC3?=
 =?us-ascii?Q?xFW1HL9Ez5uilM3+0bdv45PptRifxdeGGScHAtrJdEBz/8PZa2kB3SOyqZaS?=
 =?us-ascii?Q?lmIZc8arze8zztaEVR9e5UOqJKVxRotzOxk4zx1edTDZsBXH7/TerurcGdb1?=
 =?us-ascii?Q?SsrbfOvvr0ED6NcGHmTB267IwmHDsTT+IWyN+gxdTOlY9erV+KW1bhOP8+8b?=
 =?us-ascii?Q?7Zvv8W4RpqRUEfc6xOBvXSw91cq6XjbWZc13oxEwRnTbAJDnY4HrvYby+hNc?=
 =?us-ascii?Q?PloOxDQ/0tukBR0YNkck2QzvsrCkbv5SyX8yt82rJyiuCyOS34RBd3xMaS0p?=
 =?us-ascii?Q?dU4gr7MF1E9Wzm/Ctf2K5bN4IRxLkPc9RRSL2PCHj0BC5HPeFLkg4pO49HgV?=
 =?us-ascii?Q?04hEYskb7k37w4Z9+Jc+3TSvNrnUhvXdTXcBsaWml7oeH0Ry8SK6G/dAIYw5?=
 =?us-ascii?Q?pguH/Bo/JRgb0LoVG+fIVVKT66NwTDdjlpE3LBmRo9fkxp59TUdobjkGYIwO?=
 =?us-ascii?Q?gvvNhEdSYyihQVHZJdwY6pmpRdjOh+AigYu251upUuVsFcvZCekOf0k88+QU?=
 =?us-ascii?Q?89EmYIwG4iIdrv4OtbLOIu0Vk+uOngqA/r0M+8LUmXn+0JSoCK45fuH894q8?=
 =?us-ascii?Q?1AhGJnGV9Q6bdzIy22fuDMl5ep9FaEiF1N5mt6rnk73kS14vO0l87XBti/FH?=
 =?us-ascii?Q?f82aHHYmRFZP3F2zpumpUBIG/MxEPwKJ8Lqb80luZmge2I27rtl/7zBJQ6OX?=
 =?us-ascii?Q?OLOtxZ89wvQ0QFc=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 16:32:29.7902
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34fb04e4-411d-4e85-ce74-08dd574c5439
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0002992C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7114

Remove outdated comment.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/amd/io_pgtable.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/iommu/amd/io_pgtable.c b/drivers/iommu/amd/io_pgtable.c
index f3399087859f..26cf562dde11 100644
--- a/drivers/iommu/amd/io_pgtable.c
+++ b/drivers/iommu/amd/io_pgtable.c
@@ -47,13 +47,6 @@ static u64 *first_pte_l7(u64 *pte, unsigned long *page_size,
 	return fpte;
 }
 
-/****************************************************************************
- *
- * The functions below are used the create the page table mappings for
- * unity mapped regions.
- *
- ****************************************************************************/
-
 static void free_pt_page(u64 *pt, struct list_head *freelist)
 {
 	struct page *p = virt_to_page(pt);
-- 
2.31.1

