Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2042.outbound.protection.outlook.com [40.107.236.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D0E54765
	for <iommu@lists.linux.dev>; Mon, 28 Oct 2024 11:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730115189; cv=fail; b=VUw73yPDFcpoyLczwi3JSmz8VG4xmvF+WzL0WTdwkrTrqXAjSQ3yp40e5eqR55mOzSoEF4BfpCIovMSU7gj70IBJn9m8Y3LNftUwXvNvIp9kRnzbcYnwN2WvWz5g48NY+Ye/QMVVLyBgn/emqea/YMP6/TmmYmFhnLn+WWim4S0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730115189; c=relaxed/simple;
	bh=YQpIaldQICL7NvlHiC6NLjiI/D/8Bbid2rdqYWM85q4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GHnJJkQWYRfLOtJeCKc8CRPmvW+oHNPDUWuhsrcqJHL3DF3b+EjJzxhceDXig1cw8S+9UH3raKWmPzVZuI4C2OtIYpOJ0AUZmbXqZjfXl1H2jFAk20klP72cpBCwELx14KcaNIvcthSKctCA9Ylp9eMlXVytMeT0lRDsGcLI4SU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=r+XmaOZ0; arc=fail smtp.client-ip=40.107.236.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="r+XmaOZ0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gir2b/GWAop56uXXcExyzBZg0u41suTR4xhdXRCV9MQKlQ94CHTIH/G5U9d1uh4mSu1eGfV9kONUOSq7ZfVZ2+o5kjj1vrbgJzllWzdsmSdjLyZKY9BnnnPr3kvsplEHZFT10xRihVSwzjgvZf9AMv3hk3Pn5GV/i/IuzHQa/sCgyT5s+VVD9B/58G+u8xaesXAMezQfZ3Xfo7oWQeHikbTkeZEIJe7m32p0V8qFa9o/SEjJgUECKqXmG+nuhUUeG1wQE7Plt+znA/cva/WOVQeG+ujDaL0l0pcjhED14/y27sFKR9+/pILM06ysF4hVcxZUuSEHksoCJmx8Ulil8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qfdb6xpfqi5ipgJynoSmvkk1HWXS+EOfvDCfOsECBOM=;
 b=PdAwivZSF5EJTdroQMG/TfBdPdaeN7g8Yi4pYj88g2ncGm+NW9i9zz9GrUp7v3xFRBmjI8fHWyPbA49qBqG4ee0G1RVWEpjsDrsH18T/gvPP8gEJ/pzPh6BsgqgNQmqTrOp1wzcYBPnNqpEGDk2Y28mc2k7Fre9XcLzF7rjrY64CgD9OhfTRS8xo/4rmpK0Fr9huRZEMS91O8u4F+vZQHWG0nuPflMx6/lZ8g5TEUgVq0nlhbJCU01iykb23mQsnGpbKBhl54Dpyp8AszQnnKXtVUJ8DO6R2PgCAx3+dcNtJk1n8XXa5C4qaWS6x0EH23pubc85T7tBR97i/frO2KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qfdb6xpfqi5ipgJynoSmvkk1HWXS+EOfvDCfOsECBOM=;
 b=r+XmaOZ0v5Q2k2zf7AFYBsD8YQ8sULcnwgscguRUFY7atlw81W00hdYkSqeMRh8l0WCUBZq6pV4H/Xl1X2R27lPrbUJuebicAzWE1y3gf76+NfcvydsWbsIklF+lu6oLbBJHw/gOo8T28WrJXLyIXSG12z1zp3ilwv+W9I0o6D0=
Received: from SN7PR04CA0044.namprd04.prod.outlook.com (2603:10b6:806:120::19)
 by PH7PR12MB7186.namprd12.prod.outlook.com (2603:10b6:510:202::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.23; Mon, 28 Oct
 2024 11:33:00 +0000
Received: from SN1PEPF000397B4.namprd05.prod.outlook.com
 (2603:10b6:806:120:cafe::1a) by SN7PR04CA0044.outlook.office365.com
 (2603:10b6:806:120::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.26 via Frontend
 Transport; Mon, 28 Oct 2024 11:33:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000397B4.mail.protection.outlook.com (10.167.248.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Mon, 28 Oct 2024 11:33:00 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Oct
 2024 06:32:57 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, <jgg@ziepe.ca>, Vasant Hegde
	<vasant.hegde@amd.com>, Joerg Roedel <jroedel@suse.de>, Jason Gunthorpe
	<jgg@nvidia.com>
Subject: [PATCH v4 03/12] iommu/amd: Remove protection_domain.dev_cnt variable
Date: Mon, 28 Oct 2024 11:31:39 +0000
Message-ID: <20241028113148.5774-4-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241028113148.5774-1-vasant.hegde@amd.com>
References: <20241028113148.5774-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B4:EE_|PH7PR12MB7186:EE_
X-MS-Office365-Filtering-Correlation-Id: d3ad63b7-16b8-40eb-b48b-08dcf744474e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?evVjguVEhAXjFALPBrJkxyLcAi/YV/wtePdU/Jh6UhjXcTTlZgo88HPtmNsG?=
 =?us-ascii?Q?CtYkKv65SDp5Sdhbx5ubcRmPbEy87SRGEFEMpKtU4bsm9pbVVC5g1qhbEg+D?=
 =?us-ascii?Q?RjT74pzz6kMJj74WPORClsTqFUaznRqKH0q8W2fNXSwq1+XxlfJ78NKcdA2j?=
 =?us-ascii?Q?AciFbIpWQy4eQUiz1oETX3wEerAYLWRIkFeqaSFbM/BoEHmbUE28l+poc2tl?=
 =?us-ascii?Q?kiiZ017yo6EajbvlLlqOnfFQe87v6fdEB+uEjVNqIpFJzBp9Jb2jyVyyUG44?=
 =?us-ascii?Q?Y7lIm7Cz3qheo9KWkoHtXCSjGVi5B6TeAkoRKydPkZx6lUoDBgP1TW/nkpK0?=
 =?us-ascii?Q?lu4yQz0mIyvYkvMJho5ZVH6vfx4Xa8aqJHjPeZYebVd1EsB5JqBj1ZV9aVws?=
 =?us-ascii?Q?BKJ1klO/ytN2ClXZvVFO+QvXJxXo+234xO+9d1j3HcGBqa7OWlsa9Ykg/SNv?=
 =?us-ascii?Q?9we5QgPVgipqkXgds/qN5CiTzR0I0gvcDNLIR1YgTQLzKDCvOnTcEXNcZwDY?=
 =?us-ascii?Q?YyEh1+vM3Gw3CRfHOF/jjGYlL27fFN/qfsTb2+eE1D8FOGiZYrl0FOCXHo0+?=
 =?us-ascii?Q?/KigCQ/CJtGZ+BHAOax2JaKknJOWDHeC4U5cpN5L87vhFITqoHB/N2J3F5d2?=
 =?us-ascii?Q?iPJ03gRNSTwIQFD03rJizxdmZMdjLqUEq8ylkExeinbIH3TW0zQgdZBxfYxm?=
 =?us-ascii?Q?XRHEq0YZ+oH8j9PV4psqK8AHuLI23J9jVEEsHkOPbi/x5kwLjxR8PKiNmbu1?=
 =?us-ascii?Q?jUrgMzGpdQQ/FR8EknQmwivWNVW5kI15MrU+SlZrs3G+VsjJO3vwX1G5fBcv?=
 =?us-ascii?Q?LUCu48eUqGpFfYpNkdjZpKVzcLGTcrwAm1WSRa8jZWAEKVugpc1Ijhbgz6ng?=
 =?us-ascii?Q?NH6TV6PEaXN1p2TOm7hGB4k5M9TKzbNmTrkRi2H9zic+/Ys/WQHhwBM5t3S4?=
 =?us-ascii?Q?y9jkvIIjXGrre9g7Q6EC5YhbIixAxLkIdTV7bksF0saejx3CrbFBmPEXXWbK?=
 =?us-ascii?Q?QjoVOgVNm9tugXWGF/D4BlMo0AKLc3sGa0NJMJegrtlD52Fj6UFyg+1NJq68?=
 =?us-ascii?Q?5kKrTq5rJOxDmBQqMsWimxVdRLc754y4ZU+JUqyTg3c3wV3acfvXiA3aYQTU?=
 =?us-ascii?Q?JnfbaoOze5rdWPzrGfsqBUCV5BitM0n3A6UmZB3A6tujfEDd3oPWVEWNPHEf?=
 =?us-ascii?Q?dVal/0cVZI5Lvo+S1iASc7jSb9HgKR2UGOekoCHIzeRx5WDfy8SotxJI7HGz?=
 =?us-ascii?Q?8EI2iq89Q7BzVTmt4b1kTA9OCOG5wWnbx/RgWFdAvP2r0sxqGn06MqiocF26?=
 =?us-ascii?Q?cf94GW8+5MOevGdZIIOT+L5ERZSNdxJSHrY2qY1wPxbGc+ftrzbdYCH7RqwK?=
 =?us-ascii?Q?WOtxWoJKW98AYWN8Vqc8ydW9DSm8muZ/00khGw8pG8CAqIV6cA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 11:33:00.5163
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d3ad63b7-16b8-40eb-b48b-08dcf744474e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7186

protection_domain->dev_list tracks list of attached devices to
domain. We can use list_* functions on dev_list to get device count.
Hence remove 'dev_cnt' variable.

No functional change intended.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Reviewed-by: Joerg Roedel <jroedel@suse.de>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/amd/amd_iommu_types.h | 1 -
 drivers/iommu/amd/iommu.c           | 7 +------
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index e70f6299f765..90a752f57463 100644
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
index 1b2175fb3877..2411b79cbba7 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2028,7 +2028,6 @@ static int do_attach(struct iommu_dev_data *dev_data,
 
 	/* Do reference counting */
 	domain->dev_iommu[iommu->index] += 1;
-	domain->dev_cnt                 += 1;
 
 	/* Setup GCR3 table */
 	if (pdom_is_sva_capable(domain)) {
@@ -2061,7 +2060,6 @@ static void do_detach(struct iommu_dev_data *dev_data)
 
 	/* decrease reference counters - needs to happen after the flushes */
 	domain->dev_iommu[iommu->index] -= 1;
-	domain->dev_cnt                 -= 1;
 }
 
 /*
@@ -2234,16 +2232,13 @@ static void cleanup_domain(struct protection_domain *domain)
 
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

