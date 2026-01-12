Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010014.outbound.protection.outlook.com [52.101.56.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA31B32D7F0
	for <iommu@lists.linux.dev>; Mon, 12 Jan 2026 20:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768249261; cv=fail; b=iiOzK9m0YpPb8O6HEu9L3cz1D5JebjkKkdsUuWKqekWRRYr5J3V/vKIWSzIuc5vvQPVVsimUK3QAATMnh4lKPDFRNjDX5HQklkk0iMy0KUXo2V8tZROdG0TPnaZo7E2q+3Rat01rMNk13Ms95btwUCLekCXckzhhmBX2ygs1YHY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768249261; c=relaxed/simple;
	bh=sIXYXw98vX1QR/Bwovf8MWvY60Gb/AjOeQHjUCsWA5A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P60L7mLbs2lFjmqmBXtiVVbN2L+naLsjk4oWj5tXpRB+OapzT2Fh5Eiwsq8xgcxwGdcdpONkjv75fUQnQmILTwOQ/dbgLvTgl1z/1VN0mUq7R+WueenA6lYYtsw3T0tW2UAx0g3AS+mlYfD5PlLhi7p7vdaaVX+5i71j/z0V9I4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=J/Rn6LNb; arc=fail smtp.client-ip=52.101.56.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="J/Rn6LNb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pNDbiJuo0vJNLDi60AoBW45ftTlapoWdEUQz/e4HD5U75vI6NlNmTMltLBJgdjTzPIbMz2OjA/BIygb1SFNYaZNhZdEC7gB4Flj/nsshmGYZlCH0yS5uDputEBEh4tHFZdkQXazyZ3u/XtkRlQQYrw7/VK64mZTrZOKbDViQ5j81KHIYSs61c5H/gGeQZuUc6xpBCysmHkvnjBoU0M3Cye2K6barp+KogdWvU+R5onUlCe61D/JhEbJGHy+veODmSUXV3UXVtx1izfIupJpFvOS6+wl0MxEBtKvRyJ9JAkN/bDonS3w/x7Ej72oO6cAeFZqZT1Jx6Q9hFnnY00A8/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pM2HVj0IbRzyr5LO4i8EzepH8lDcFhvxqihJ5sWzB1A=;
 b=s1vx2pEc+H/ms5oG6SrBQVHLxt5U60K68LUZOSgl6xwODsgbFBVzGI4i4NaY1YZsIxllUkqPQ2Vd334K8yHZLkNez/u6dOhUEsnplgoXjX6ZaRioot6yfQ/9oq4gX+3cPG5amDhAC/LKdMC/EDfzx3pR7rui808lSdwDTy9G2OXRew7cjdRH6fqC/wzJ0sx9X8LJPrS3MNQuDRvP/J5dDvYXXp9LrFoULfUAquKwUM9aOABEqO5WTkn49paUnFh/2P71v4LQHp3S5dNDzTGbfeaL3YaKO46LEeJD9ZJ8ch3DSHrI0bktqcue3CvDsz8LzcozImr6YiJiggFvY7ZDUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pM2HVj0IbRzyr5LO4i8EzepH8lDcFhvxqihJ5sWzB1A=;
 b=J/Rn6LNbFT4FfC4Z1Eqnraf+yxt+h4bO0oKDtXfuYkvjcAvcg4CMdG2g25Y8dhIvwLVHtSUYeJpp76hfv3maBzFf01J1obDO3tlBfbYwFO9DpTF8cYGOeVOjmLxzZEfATjvmg3i6withHvevXjDjI3dJteUXZ/jaauq1w8eKFRtAB07QOlDTEbkFaTmMin/LYZA23RbSMmZdvqJLwgt3BoWYIirBv4oCeo+RhZ/ROcsS5P55FE/cSzldO3EjwzMgV34Gy0myQxH8Vc6qNXBGxaWs53iKh2oudir3QrFzlIcGz7LOQQ5Ml5NUgWJtN3/kRMOQjYNNvifdzuASlr8c8g==
Received: from BN9PR03CA0426.namprd03.prod.outlook.com (2603:10b6:408:113::11)
 by MW4PR12MB6900.namprd12.prod.outlook.com (2603:10b6:303:20e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 12 Jan
 2026 20:20:54 +0000
Received: from BN3PEPF0000B071.namprd04.prod.outlook.com
 (2603:10b6:408:113:cafe::ad) by BN9PR03CA0426.outlook.office365.com
 (2603:10b6:408:113::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.6 via Frontend Transport; Mon,
 12 Jan 2026 20:20:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN3PEPF0000B071.mail.protection.outlook.com (10.167.243.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Mon, 12 Jan 2026 20:20:53 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 12 Jan
 2026 12:20:33 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 12 Jan
 2026 12:20:32 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 12 Jan 2026 12:20:32 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>
CC: <jgg@nvidia.com>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <skolothumtho@nvidia.com>,
	<praan@google.com>, <xueshuai@linux.alibaba.com>, <smostafa@google.com>
Subject: [PATCH rc v6 2/4] iommu/arm-smmu-v3: Mark STE MEV safe when computing the update sequence
Date: Mon, 12 Jan 2026 12:20:15 -0800
Message-ID: <f560881df101d76de95c942cdbeab149eae3d581.1768248467.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1768248467.git.nicolinc@nvidia.com>
References: <cover.1768248467.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B071:EE_|MW4PR12MB6900:EE_
X-MS-Office365-Filtering-Correlation-Id: 55a3890d-660d-4a7e-08cd-08de521815df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WZtck/FjalrY55J0VREGIrngHR0jBot5TRXzHmZdOscxUrnaNkhhKmaVgVEk?=
 =?us-ascii?Q?EHxYUYClk1Pj20SPxhhzEprfgqgJ+0LDDZhRdKPTss791qmMD8mFkc06HZS5?=
 =?us-ascii?Q?mFPOYQrgM9XbK4IPFV4xtIZZa+CM9k/STHRbwfBiifqY6SZzLHzKXy0zhf3P?=
 =?us-ascii?Q?63rf5tAi9+uHqhAXVzv1U7cfoQkuteeU0RadS+Zg83aotuGTbpMrnn7QLG+8?=
 =?us-ascii?Q?UPJl/iDE8UG6PAb6uNVsGi28jHt5cQwD1feKMTScFsvqpl46P4rhtZL6hTjD?=
 =?us-ascii?Q?UGQwJKim7LGBhX9QXdi00+mQ5T/VCoRO9Pnp4/ujrt8E+TEQXXsLmShIybLi?=
 =?us-ascii?Q?4EuU3VlXXBrg9L27o/Tzj5Jy5W+zjZP4vVQwQB6+JdC2WnyhszzW6ewbHDz/?=
 =?us-ascii?Q?lSVq26+TrUSau7FpU0O0gBehMIN5k/WV3PJYbdHn8dEoJrCyWX/5RJYkvLP7?=
 =?us-ascii?Q?DDL6CVQGAUeC3towBPZ99eOvZAiEHH+/5hoopPFHqZc47w3B9So2e+6hC+CJ?=
 =?us-ascii?Q?iFXGlZDFjpkrsIyHt8py2wOOMgwa6Hwpsgaidj9K1oMunPFyAsqWXHIWRmQH?=
 =?us-ascii?Q?EauzyZ7loyn22bPnLoYtJhu6dPOVYoWNgPommC6VrAaWvoKdZY9GLt+kJMqE?=
 =?us-ascii?Q?amBZRJU1TKeuOTE9wPKhtE0YAnoBtN/xR8zEIjeoTpKmUhd3tDeWK5S1tNkr?=
 =?us-ascii?Q?j/x+rxiTHmswyJeaeN6aDnaJalMg/jqRZdkgusJpbWySqSl1aw4Mx4MrE5lI?=
 =?us-ascii?Q?3aeLDJBSQtejc7gXFmPujQ7+XoBvBE78GBDjHRwtpUNQL+i3auHKqm6tXAx5?=
 =?us-ascii?Q?pCxJ1qt233lFqE7Sc8D18r8ug0nWbCEAhphpx2Lq/Ho7lFRJkBbW4sizpMQm?=
 =?us-ascii?Q?nxVc5JcUslh6BGgytZO8/9sPnjaFzHLW4y3ewZAA5ZUm2znDp/WPrQpwJOvk?=
 =?us-ascii?Q?mTh2cHnhLfq6TmUEVAhf1Xo1fCDnxGWLuPrV+/VsqL3PhCCofgGUTXfOCYXN?=
 =?us-ascii?Q?+ARKfMa2o9OWQUySb7U/qj6eo+x7X9Wy2wQqnLLgmCzSt1ASnauXoEp+xbVx?=
 =?us-ascii?Q?Se8AP2GpdAWzRETi3t5AUSCwbRL4EFgNdIX3RuNJy7DB9UGHTkkuCgm80XHE?=
 =?us-ascii?Q?L13izmuk2Y8il4dBws7Jv+TN0PRfKrxdc+dM5HUBPq4T//7k5Gy4g78tMaxv?=
 =?us-ascii?Q?mLNruHDdYf1aonA4RndhSoWS8Uitws30Jg++VxtHcGQzgZMGlZ1gUVJr5cfG?=
 =?us-ascii?Q?Xd02ItLWY65zjSvcQGHrHnsYRCAoT4iXLw8RFL0mFCQs+/b6Gy2Awg2ZfsGB?=
 =?us-ascii?Q?WHAVp8q16841YP2mj4X9Cfy+NkQgGTvcD9ly2e4eSf0E700Hjvdoh7tgg0p1?=
 =?us-ascii?Q?Uz6NiF3chkiKfEg/6pAv2nOcKmbfqqu9y2V1wVDnZTVY6pHBazl9hWUoE5Sb?=
 =?us-ascii?Q?p5hchosISTVqIEF/khUHcxac8HSWJHRC1x44We4gJRY/7rcy8MiT6wQDGVAb?=
 =?us-ascii?Q?bCLjbUBTJA8WbrAWiABRLZ6CD7l2d3kRzvCqXjwM+/DYnsWLyszC2nTDbeiG?=
 =?us-ascii?Q?ekIaRRUgFZ9AVJd2Zzs=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2026 20:20:53.0751
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 55a3890d-660d-4a7e-08cd-08de521815df
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B071.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6900

From: Jason Gunthorpe <jgg@nvidia.com>

Nested CD tables set the MEV bit to try to reduce multi-fault spamming on
the hypervisor. Since MEV is in STE word 1 this causes a breaking update
sequence that is not required and impacts real workloads.

For the purposes of STE updates the value of MEV doesn't matter, if it is
set/cleared early or late it just results in a change to the fault reports
that must be supported by the kernel anyhow. The spec says:

 Note: Software must expect, and be able to deal with, coalesced fault
 records even when MEV == 0.

So mark STE MEV safe when computing the update sequence, to avoid creating
a breaking update.

Fixes: da0c56520e88 ("iommu/arm-smmu-v3: Set MEV bit in nested STE for DoS mitigations")
Cc: stable@vger.kernel.org
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Shuai Xue <xueshuai@linux.alibaba.com>
Reviewed-by: Mostafa Saleh <smostafa@google.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 390446d259ab..ccd6357fa5a8 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1086,6 +1086,16 @@ VISIBLE_IF_KUNIT
 void arm_smmu_get_ste_update_safe(const __le64 *cur, const __le64 *target,
 				  __le64 *safe_bits)
 {
+	/*
+	 * MEV does not meaningfully impact the operation of the HW, it only
+	 * changes how many fault events are generated, thus we can relax it
+	 * when computing the ordering. The spec notes the device can act like
+	 * MEV=1 anyhow:
+	 *
+	 *  Note: Software must expect, and be able to deal with, coalesced
+	 *  fault records even when MEV == 0.
+	 */
+	safe_bits[1] |= cpu_to_le64(STRTAB_STE_1_MEV);
 }
 EXPORT_SYMBOL_IF_KUNIT(arm_smmu_get_ste_update_safe);
 
-- 
2.43.0

