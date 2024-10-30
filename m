Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2089.outbound.protection.outlook.com [40.107.93.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 578401865E0
	for <iommu@lists.linux.dev>; Wed, 30 Oct 2024 06:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730270541; cv=fail; b=pvrArvDDaRrq+LHOQTeVzThngYeteRhHD3vQxzWztdkT4IZFp6XeQlwaWF9HRMMZdOYqi6qhzJO/l2+LAqrLjJFMaYoEWCw0C77kI5sL+XbvwR1YcVOv/kDYY5E8akxWg8c8pTHTNha5lF50XtgGRdeW1jq9Ki5z9VBvXs7bEzM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730270541; c=relaxed/simple;
	bh=dHFabwK156RKxF7KIlkq/G95bugdfep9RhK2zR2N/kw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qApV1N22r24WWgaBvbO9MoYh4FdMENflAlhF5XmK2NFeJK8bC9zXR7fVrIODE653hFKKUDOlffbEMvN/feSvzh6c9zKjXPurS5/zpoD5UvMGC9bx+56KFAYc886Ix2odUOFDn1JtktZjO5JTS8H15pJPVmazdudv0vy3NElxi8U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bm5eZfLQ; arc=fail smtp.client-ip=40.107.93.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bm5eZfLQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CMyTl8vvo/5WM3ASAdL6h4eNYfu9aCqIaGPeUtYj7ye/l+AsFx/sw3uWoPg+bIrXG9jBeAKMNADwiE9Y8M4hYCZC76FP2aJXydRZmwykzjjgChLYEf/1F5zBO9Y/ktOmrQfbLgSZgnuHJtleH8q+u0AHgZVhT3OYc4f80cX+rrEpKt7N93UBEqrozC4z6ElPNqUSIobN5h66fIZbDjwtaQfDFYjzZUEfSZZmbQVMZbH/Ttdoq8HbocPSqXzOM2ivzYmfi4rgsuuxS1CgWlxxqdJ2/Nbh0MKluSLLexFJA0ps7xpKIEdAqtoc39QYWj1hPVoyTaFVSsd9pCHRFlC7cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WVv3iTZ8x/1k4eQIu+OoB4LnpBd5qM92UR3aT+/Eyrk=;
 b=SOWQWVnqLNd+s2EHnP9940s6lGj42T1KAaSCjNhL9ZN/gtCozto6Qc3gn10u602CgH5jcGwIxMmtRX3cM/KRNdKhW8aD7NekiW+sqKVvElALAwIJlUONHE7f4M8+4hghdg6r5QM+iMijBseDrFl0/2Ux13WO2IenQLsuhqLQ+jIWIgfbc0nK1f4p2bphaUFhbj1CC1G8xLjn4+250MCBqjxYw7t14WovEM/aVRP/OSpxHlOJakbhmMqYoDbIoPUwV0hY0DbVdWggj4QBN5jBh1+pU1xeglfi3u3iIfEGK93wRYVTDpPxxoX+lvbWHO9t9EAwxU4OHZtKgEC0r6Qrqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WVv3iTZ8x/1k4eQIu+OoB4LnpBd5qM92UR3aT+/Eyrk=;
 b=bm5eZfLQJDH2I8m2x5DOx/A/4THoAa3ee/3i52xT5n9hhViatOf4RhYDArUAduYpeMTkccSjzOSgwkZz0ZEBYr8QUOQR7VLmYk3W+O2BZ3jKZMz9fZaDUB57v8SF5nelQoHrvVVTYReNE5FgHqb5XtPDSvInA6scGJOBBSnE5dk=
Received: from MW4PR03CA0065.namprd03.prod.outlook.com (2603:10b6:303:b6::10)
 by MW4PR12MB7481.namprd12.prod.outlook.com (2603:10b6:303:212::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Wed, 30 Oct
 2024 06:42:11 +0000
Received: from SJ1PEPF00002325.namprd03.prod.outlook.com
 (2603:10b6:303:b6:cafe::9e) by MW4PR03CA0065.outlook.office365.com
 (2603:10b6:303:b6::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.26 via Frontend
 Transport; Wed, 30 Oct 2024 06:42:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002325.mail.protection.outlook.com (10.167.242.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Wed, 30 Oct 2024 06:42:11 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 30 Oct
 2024 01:37:43 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, <jgg@ziepe.ca>, Vasant Hegde
	<vasant.hegde@amd.com>, Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v5 01/12] iommu/amd/pgtbl_v2: Take protection domain lock before invalidating TLB
Date: Wed, 30 Oct 2024 06:35:45 +0000
Message-ID: <20241030063556.6104-2-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241030063556.6104-1-vasant.hegde@amd.com>
References: <20241030063556.6104-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002325:EE_|MW4PR12MB7481:EE_
X-MS-Office365-Filtering-Correlation-Id: e6647f55-963c-4dde-f7f9-08dcf8adfb75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rfbPej9XkHNFymhJ/wLoEFwxdH9AXpcS4lEd5sZ8BK1UblTpvRuHcbjxwXVB?=
 =?us-ascii?Q?hSgtLTZxwad+Cn/xLS5yTRfAQzVN1GHC9JZ6zqMVuFs0gi2ATT8fPv2Mznfa?=
 =?us-ascii?Q?HqVTZAr2a5lOId920rtCqv8+7XD4GvB4HBFB3sWK5zYvJtXPD5sII2jBdukC?=
 =?us-ascii?Q?fz2DNPVWbiGXoOZxrcpBhA8OBzuEPTFJ/OthSNFchN3kp5KwoPafDyvVA5P7?=
 =?us-ascii?Q?1Rl8u30pbLwjbfttUPpE3j6teJ5r+XAr2V77KAqS84IeCsVNyVKTOiDpn8F5?=
 =?us-ascii?Q?ulmp+AVhhDmiF0UJ1Uk27xKbpmIcwdOqMmUZ5ZUdR/rTwRWcoCi3SK2JfxAh?=
 =?us-ascii?Q?9UGsmWbz9ldSM8Qa8OuoPKPmI8X6Q8yJP1Ua2umpyU73q8JkJs8+CrNvuQ2l?=
 =?us-ascii?Q?r/rXYO/CRQKaEv4+4/whGAlMDzCSVKpC2B44d+FT6zAdFa9G45th+plg5f5Z?=
 =?us-ascii?Q?c8uUdVgXRcRP8GfcR+CbCVAzi7nDIQ0LyQ3QkvCUDUQohkodBTG8gxKyIgEL?=
 =?us-ascii?Q?q6XKN1ClOqCzqn89ql0Jxd2Tk9gQLTVOvjjhYqjVCCuaIg2zyN0YxmCnclEH?=
 =?us-ascii?Q?vAtatTW9rDbaSOlSqqYWnDQQoT9C+jRoo0nhrWMI3MijM90kBu/PUtjx1c+L?=
 =?us-ascii?Q?bOSha5jI8n3mpxcQHgGOEqizBponYNelk71mMyQaDiGJScJDXY1WOia9CpFw?=
 =?us-ascii?Q?lowWm1n9NN/nawItC5OaC8qQ2AzKdYMRCyVL7LglHOtyv8UR22myfAk1qpzZ?=
 =?us-ascii?Q?a9sLQlOTVOLp7ZUpQZBPlRQgrdfDyV03kpIRVeZYd1RmfWwcUMkQPDqvezGX?=
 =?us-ascii?Q?YVwJEnLC2c8gMNT1ZjrJFRDdpCd9VoEjAbAjmW6VXFeoY40gXq4Zc6vtixpo?=
 =?us-ascii?Q?2/d1bDGdtMSs+/DCxjpdRMARt3ryPNVM+5/1HLoYLe1I58Wz7xNLBxF+Lir2?=
 =?us-ascii?Q?UVz6MA3pn064ummM9q0UbWRxRdRouz58nQXl8ugqHON7dretYcfgM2gLZ4hV?=
 =?us-ascii?Q?/8LMNow9TyyqT2o9rDXOIcy3Y2E+p3Il23b5KUSErXIVuCKvjmTx+RMAJ4Qo?=
 =?us-ascii?Q?zmyODNn8lEGVlSq23ma9uFRRhxXbPpuDspcfs+N2S45qj2AZ6mRJCXs+XoLF?=
 =?us-ascii?Q?QAsierLgWq5nTFexjAIzWns03VTDmE9PnMnq2rPd2QuIYVT3M8+vHb0NOXfd?=
 =?us-ascii?Q?4wBmSEN3y3YhSh1AhSgeETJoO3Q+Kpfhu4vuJ1lnaKp7YJrQr9d1p6Tkg+xL?=
 =?us-ascii?Q?p/5Nn3eUOk4/uyhKUFhYbBKr77xKytiW/4mVY0fEEjCssAG20C0JvIuuy4YR?=
 =?us-ascii?Q?jM+hOJHThoxUT3Ky/K1EOj3R8IDNP9A30RIpguB6UltxJrSn5EH08/Gl2pT5?=
 =?us-ascii?Q?V99Ec1e/rHK8ztyMbwjTSzfnUpsa3ksuYzRZsUr5m77minv4RA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 06:42:11.0049
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6647f55-963c-4dde-f7f9-08dcf8adfb75
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002325.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7481

Commit c7fc12354be0 ("iommu/amd/pgtbl_v2: Invalidate updated page ranges
only") missed to take domain lock before calling
amd_iommu_domain_flush_pages(). Fix this by taking protection domain
lock before calling TLB invalidation function.

Fixes: c7fc12354be0 ("iommu/amd/pgtbl_v2: Invalidate updated page ranges only")
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/amd/io_pgtable_v2.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iommu/amd/io_pgtable_v2.c b/drivers/iommu/amd/io_pgtable_v2.c
index 25b9042fa453..c616de2c5926 100644
--- a/drivers/iommu/amd/io_pgtable_v2.c
+++ b/drivers/iommu/amd/io_pgtable_v2.c
@@ -268,8 +268,11 @@ static int iommu_v2_map_pages(struct io_pgtable_ops *ops, unsigned long iova,
 out:
 	if (updated) {
 		struct protection_domain *pdom = io_pgtable_ops_to_domain(ops);
+		unsigned long flags;
 
+		spin_lock_irqsave(&pdom->lock, flags);
 		amd_iommu_domain_flush_pages(pdom, o_iova, size);
+		spin_unlock_irqrestore(&pdom->lock, flags);
 	}
 
 	if (mapped)
-- 
2.31.1

