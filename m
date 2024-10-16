Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2062.outbound.protection.outlook.com [40.107.223.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493AF5221
	for <iommu@lists.linux.dev>; Wed, 16 Oct 2024 05:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729057006; cv=fail; b=evXBTqC3fECyKbP5ZgIiATZM5Oy9hVc9AZ5Xc/a0CI2rRReu49keMYEtY3yB2xDPG3IlwsTq0UOzeCyDMrmN9r5JdhEhOX2clkqXBk9wj1jkfnUSvx18ujfMJpa99OZI441Vck7rOkPg8032rZ+NUyJ2sTQ+IhnWASZ/WyKa7cM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729057006; c=relaxed/simple;
	bh=tr/SqvSgXekhvGBqxYdGKlq0NTa+O/S9RF/GZsfmQDM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Du0FnncJDXesmCA0i0htzBpzQc99cXfMnE2Ig2jDLmJnCRFP7p1iM8QcKQmfauarzFMEyqgzUsXkJYvO1CZJWI4SQMVeqy81mBIrhmhjNfD/YHcq1aFJ3gvuxi9P0BL9Y6j9Hb27f54N4JXyaCmp3bRiR7REmKbAo2RpFQwm8EI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FZnmDMAF; arc=fail smtp.client-ip=40.107.223.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FZnmDMAF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rEDUnXmOvyti+YJHHtWl7MbKVo6jquCq4PZ5Xdc+fjuroSoKIOaWhzBvNKn/Iz32Dk7BcwDV1lhHqjvu80HnS/bYeD+9lFgxiAsqy8LYipzVupdHCm6CoUCWiNbTnkP4G3iBV37bdsDdNPDZpvtbZeKYaJkDwLG7Dtbx80/WEMA1Fer92bZxDVPsvzPLWdgRPmHC0uttI1m0paMBYFQNnjcXf/Ko3dScRRdf0OGpDDdBuJXnw15syz+uvKvijiW9GZPi/Br0FrBPTm3ujfBtQfYjN9LbHYMycNOyERraPPXgkto4g6OZOnJh39hGV7OlKLcAvtkm2tsWsb9Ulrkhng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xyx+368qNk5lSBpxCDGAwsugEVa+4HRtRXCc4TXJ4xQ=;
 b=BO8TQ6SsCUnX4evS5DdmADamY8jmhFOs6EhVZoHFj96OLg3YR7yToVJ7I7D5Q1B/T7oSsnZEeQgdpCPegFP0iapsaV6VRIRJv8x/Oskp2GEU3ow1lrRIEgE65BYgOzEfq8gPF6sWJ4kAk9Fu/pirVkNPPU9uOLUSrZPquuUlm6y4G4pvfcPLRf/aIHeZHNTKtSGHVJwSJt1nRcvkAtYSlRY4PQEFzuNu2Ghqj5RQ3UF4ZpQV5nqS1lH7jRPtcY9R/lyvAqIGQrPxOuM03IzGvkxVOcPoFtFrHM4zwJ44BKvOsqLmBRC8yMQWWQtVtRuTuASg7QXklCMgRTAjGdoNlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xyx+368qNk5lSBpxCDGAwsugEVa+4HRtRXCc4TXJ4xQ=;
 b=FZnmDMAFO3oDJh+bO5qdxgUYWQoImG5BOtrNLPfHIq+xgvcNer5ENEIhxeSglVx94Kww5UBRalwciGqVHjHFI4fOUbugrGr4K9dLCz5Kme1hYAvhaxD0HCnc5YPvKE4ACB46t4gbjth4UTpi4QriuU88Gs60K/g1E+32Kz1vp/g=
Received: from BN0PR07CA0005.namprd07.prod.outlook.com (2603:10b6:408:141::20)
 by PH7PR12MB5879.namprd12.prod.outlook.com (2603:10b6:510:1d7::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Wed, 16 Oct
 2024 05:36:37 +0000
Received: from BN3PEPF0000B078.namprd04.prod.outlook.com
 (2603:10b6:408:141:cafe::51) by BN0PR07CA0005.outlook.office365.com
 (2603:10b6:408:141::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.19 via Frontend
 Transport; Wed, 16 Oct 2024 05:36:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B078.mail.protection.outlook.com (10.167.243.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Wed, 16 Oct 2024 05:36:37 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 16 Oct
 2024 00:36:34 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>, "Joerg
 Roedel" <jroedel@suse.de>
Subject: [PATCH v3 02/10] iommu/amd: Remove protection_domain.dev_cnt variable
Date: Wed, 16 Oct 2024 05:34:53 +0000
Message-ID: <20241016053501.97497-3-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241016053501.97497-1-vasant.hegde@amd.com>
References: <20241016053501.97497-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B078:EE_|PH7PR12MB5879:EE_
X-MS-Office365-Filtering-Correlation-Id: 629dd4cb-2f5f-45de-6950-08dceda480f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ixzWDtbkU7CSPOqEF51msyrXxKOEi4AOe+mxDqBHk/Bdd95ayo/mv6x4vXpJ?=
 =?us-ascii?Q?NucqrCyfyNADFqML6obQPsjntyyHN/LEtUBfQ2VZfw1g4LjVIW9WDMdvSNfw?=
 =?us-ascii?Q?ub1x/Qdfjzh3wBExRgOttMzzM7YFO9vQ50wt9lb7e6qZQPB/zDx83NP0/tRs?=
 =?us-ascii?Q?YHMiC1IAtbOS+dw6WYwJ4WBWXB4j0opt2wM05wJIXcnwpJDzD6CuOGCZ8eBq?=
 =?us-ascii?Q?LJ05Jfa4N+bPjK4W753tithVR3v1k/rGj5/T0ruIIZUjberpGPcMJ+oIhn99?=
 =?us-ascii?Q?9WX93IydiQ1Hgf94zb8E+yDtDFFeAXmg3X3zRhVntEnUtZK8g4Rp/CG7OhxX?=
 =?us-ascii?Q?jUVxUcQC8WawiQcsgc6Jb9c9zFKmfQQoFBYwyLE5roCKG1dQ765m62fr3IM0?=
 =?us-ascii?Q?1RzrQ02WQpzPqf0UVqhjaImkpIEostSew0Jhto2oqE1pFEeETNxlizSB93Iw?=
 =?us-ascii?Q?BXR3zh56IhaXfgwBzaopKSnlQ8seiS3FP4y5p6dYWNc7isQEJdNlAMC+UoCz?=
 =?us-ascii?Q?d4Dwewq4XMqF3vtojJjEMOvJxDGqNfFRF2197wcrA2p2SIfphU8JEUtb941V?=
 =?us-ascii?Q?PYL1isAKI03TVdenG+DwO6r+0K5MXj1sziBmAHEiHnPOxYXdsz/HdxfKWQl/?=
 =?us-ascii?Q?EWM3PHUmztEWwyekZe5IWRaKPyUV396ARHzeJZcWk78ZJITMHWB1qatWoo89?=
 =?us-ascii?Q?Be2yfE8U9ExxaG6fxLA0Ed3+14t3kBNLpfmMMauzutI9Kr/KPtoa+68YdPFN?=
 =?us-ascii?Q?dP8LO6khLgxq04+US32xaCRfwMqDAhCaBRA2g1SlfkemLKzLP/SVWu5Rmb9v?=
 =?us-ascii?Q?VoJGMPgvEvVxV++p20yJ0tWvpbtnsTeAEUltU9xzRf+pmAkM8r6EFYmYJfW1?=
 =?us-ascii?Q?iXYAhBCKvnysv6Zy6CMTjwguxtrzXpkUFF2v7s6QawUjWWsiXnrPrRi8tNxK?=
 =?us-ascii?Q?UWLsr/cpK+mc1qB/b0eR8Jb68cDDJ3QVTihUsupxLQJDVu3TfyRzshoyo9U0?=
 =?us-ascii?Q?p/DgU1faGwvEZbhJ+EgnVoCJfrQ1wTI7VoHCiSin042+hZOWv/J+TNU/DCoh?=
 =?us-ascii?Q?PWVluSO7kPX3bx3ElMSVehfA/olScNz1XSZF4V3ad8lg0OlHpTkJelUU++kE?=
 =?us-ascii?Q?FN34UWW9ii6mPH2RMQOvQvbHmfb7QCno0FOVC1CEgzbBSMtKFbJFyi10DfJ2?=
 =?us-ascii?Q?BRiDaUQUz3R1xaShK3iz4/5rq8jQ22xh0XoxFb/hbTsOe3XMGiYGarlaIKd+?=
 =?us-ascii?Q?TKlNFsT3GeQjQmeHqU7SXj9zZio1pWh2IfF52H3M5NzCjcGRtmwb3KDTAlO0?=
 =?us-ascii?Q?zGhNeHmW3lkiYO/JJCuYPMi/tjKcKYaeq0yB3dmZa7EdFEDq/g1KlC8FetjF?=
 =?us-ascii?Q?b4W/Pev5K5eY8Lm2NBdT7+NEsBUd?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 05:36:37.2710
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 629dd4cb-2f5f-45de-6950-08dceda480f1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B078.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5879

protection_domain->dev_list tracks list of attached devices to
domain. We can use list_* functions on dev_list to get device count.
Hence remove 'dev_cnt' variable.

No functional change intended.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Reviewed-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/amd/amd_iommu_types.h | 1 -
 drivers/iommu/amd/iommu.c           | 7 +------
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index d32a86434de3..418c14aa4ec9 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -578,7 +578,6 @@ struct protection_domain {
 	u16 id;			/* the domain id written to the device table */
 	enum protection_domain_mode pd_mode; /* Track page table type */
 	bool dirty_tracking;	/* dirty tracking is enabled in the domain */
-	unsigned dev_cnt;	/* devices assigned to this domain */
 	unsigned dev_iommu[MAX_IOMMUS]; /* per-IOMMU reference count */
 
 	struct mmu_notifier mn;	/* mmu notifier for the SVA domain */
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 3a8a77bcd2c1..c9514284382e 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2033,7 +2033,6 @@ static int do_attach(struct iommu_dev_data *dev_data,
 
 	/* Do reference counting */
 	domain->dev_iommu[iommu->index] += 1;
-	domain->dev_cnt                 += 1;
 
 	/* Setup GCR3 table */
 	if (pdom_is_sva_capable(domain)) {
@@ -2066,7 +2065,6 @@ static void do_detach(struct iommu_dev_data *dev_data)
 
 	/* decrease reference counters - needs to happen after the flushes */
 	domain->dev_iommu[iommu->index] -= 1;
-	domain->dev_cnt                 -= 1;
 }
 
 /*
@@ -2239,16 +2237,13 @@ static void cleanup_domain(struct protection_domain *domain)
 
 	lockdep_assert_held(&domain->lock);
 
-	if (!domain->dev_cnt)
-		return;
-
 	while (!list_empty(&domain->dev_list)) {
 		entry = list_first_entry(&domain->dev_list,
 					 struct iommu_dev_data, list);
 		BUG_ON(!entry->domain);
 		do_detach(entry);
 	}
-	WARN_ON(domain->dev_cnt != 0);
+	WARN_ON(!list_empty(&domain->dev_list));
 }
 
 void protection_domain_free(struct protection_domain *domain)
-- 
2.31.1

