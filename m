Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2073.outbound.protection.outlook.com [40.107.102.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24A01ADFE4
	for <iommu@lists.linux.dev>; Thu, 27 Feb 2025 16:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740673579; cv=fail; b=GglJael8AfJ8eTVFEG2It3Oy0m/0G7b19ZLeHWAXnzug/PCA7JD8ZAhExC/cVS6nEjRIuWHSFAO5E0iUo3JhwiFe1pn6YkHLn0xGN7kpDTPoZO2n8k4aRwNkM7LnOB9DjNXO8bewCCEdGQ/acdJio4wo+w8Slq2zTRo2dNPbdhQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740673579; c=relaxed/simple;
	bh=Q08kb6NxZu3laVFjhdqoWHH1dhnTh8UR+sCoyXCtOUI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bvxsRxiAvglRcXjaGexT8lcybNSa6NRbOh1tIgUmbqyase/cFvNf4GVAiZv5aNoC4Dvuu+7p26EO+wIYrKEXuxsniLpPGJ8MMhDG6/0IipmLeV73JoAZXClvu5tyaf6mFUV5R8eODApn5TZGzXSkGM1lbCDKQLomVG2iTyFqPes=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dB3Efth4; arc=fail smtp.client-ip=40.107.102.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dB3Efth4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tKpgCfjrTt81TamONnDIJa/V9Pfn3sYuH3xKI1AUrQgehPYKcLdDPEWXIlTp4rRoD7ApXaLN2Gl/ah4EiIsn/fBOCEe5/huqevtMEraEO/7GmMXJskBrhnMnPzdRiE8sugbA2TESHfsjBdguVWvzCvEWTV1XcDsbSeJ0ng9idZdgjirMqvf5a/JW/WTKw1Q882FlpR+cKBQm9qSoWWG4raBUdk4waTHRkJcuVilZSnazIY7HbCMGHXHiBtaSZZ6nBbiYCcZfDoarzbNi4EKaQ1GAkLYE6q/17jq2swUbUG68SttekmsqRTjNunGh2bJ/GQOBJtne7hnDHAKzaynL4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e9oHC6pExNRd6FuJY5bx7Dj7ClorJA5nXs3pdt4YyrU=;
 b=F1Ne0v1fu3Yrhe4Pof7RVyP1CnhMEJWMHHcrWNQl+Ie5nTn4fgFRPwZ45Fo1rm28aktiKkhORkmB7aYsgHiS9EIHaxzjQwFK/geLnR/8Fw++mWjKTR29PyzzNMYRkeU4gS3S6Z5LUmOcXJmRbDKEyLQ1jyoZSjpvTVG8FRNxZgq7pVFw8Tx739280m6MdHlObunsUKIK8ctns4O6k7bxSlHjxHCyy1TcEA6yfVqcBQJ3nyolvaAifARjm2kaD6EHORdM1Ik5w9Ye4zPX54CEiXXRlHrYQm77/vGr9kdhScU9YXD/A4aKPTFJoR9RqfeV6OZ93lavfQCVr8R00OUeuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e9oHC6pExNRd6FuJY5bx7Dj7ClorJA5nXs3pdt4YyrU=;
 b=dB3Efth4DQPEUTbwCTgfiPDKtTK7z7YHbWCP1f9vVaDkCZyI3YZoPoSqH/q6BzME8DMZh63xsorfBEhUmziCiC3nKkXgDa1iijfzh8IVstG45/q6U7cWcWUQ7NCDh39IdVUvyWa553D/R9mLGe3w+WnMqbmRFr5+Blul6ZR9+HU=
Received: from BN0PR03CA0019.namprd03.prod.outlook.com (2603:10b6:408:e6::24)
 by MW4PR12MB7357.namprd12.prod.outlook.com (2603:10b6:303:219::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.18; Thu, 27 Feb
 2025 16:26:13 +0000
Received: from BN2PEPF00004FBF.namprd04.prod.outlook.com
 (2603:10b6:408:e6:cafe::2d) by BN0PR03CA0019.outlook.office365.com
 (2603:10b6:408:e6::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.20 via Frontend Transport; Thu,
 27 Feb 2025 16:26:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF00004FBF.mail.protection.outlook.com (10.167.243.185) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Thu, 27 Feb 2025 16:26:12 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 27 Feb
 2025 10:24:34 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, <jgg@nvidia.com>, Vasant Hegde
	<vasant.hegde@amd.com>
Subject: [PATCH v2 0/7] iommu/amd: Trivial fixes
Date: Thu, 27 Feb 2025 16:23:13 +0000
Message-ID: <20250227162320.5805-1-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBF:EE_|MW4PR12MB7357:EE_
X-MS-Office365-Filtering-Correlation-Id: 568272df-5717-46a4-4534-08dd574b73a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?52U12rgOKz0I4rZC2YUxoymrf+opVVYS5sAzzRtvGyEjIEt+B/75mskEUnXC?=
 =?us-ascii?Q?1rRN7IxT9WZywyGRFZVqSZ97j0U1goNFrTF6AT8sd1misSbM2/yNovhu2rTj?=
 =?us-ascii?Q?5pRAH8KGSp8ciBtreJQsviscpJ9BPghuTPExHZnuXNWOyYGzz/7ssja4hTDg?=
 =?us-ascii?Q?vTToNeO4K5nLkiBKThU7Ei1eK2MV9deVXLXGkIObDZmkrsbUEgB5vE6/Z9gI?=
 =?us-ascii?Q?o93l7aYfd53g4zC5IWKHqCm39mxxmZ6y+Z+kz0AscSStUDunpAdgSoMBWkK4?=
 =?us-ascii?Q?FlSOZSG4WaMlq8YN7d8R90RhAMwqOWyBiHnp/+moCNE3TaliO2L+kywV4g/y?=
 =?us-ascii?Q?UvRdbnip8OyJ+VbA9xP/9fDo5aeZS7TID5fyarDzvXbtqVWNHqNuuo8LPOTO?=
 =?us-ascii?Q?pKaHsLAu3YqXFSItgv7GWpECmW9gpSEZYQjmtavKP+Be3bTAgyZ8ImsvJu3D?=
 =?us-ascii?Q?uhGk/9lfOpCNDvxbJkfnOWzOxBIq9cWeMVj0qda3VkG4DvQF3CLfeKdlPkHl?=
 =?us-ascii?Q?DejJ+1XKCWh2xk5lttOIHRJ+gJ1HxKcqyzLx/5Kz9eVQEOGf36shlG+2Q8cY?=
 =?us-ascii?Q?JXzWnG7wqWwy+vJ/J7ara4MxUlHpRh2KMejhrjMk+8AWDOcE4cXO5mRQlX0N?=
 =?us-ascii?Q?FbJhLdoc4g4PRwORn1VdvlAS06uqz6EZbWxewJOx/MmOqT4LGMWGSk7xgoBX?=
 =?us-ascii?Q?4c93T7CIJoO/6SWAOsSe0PW4NM06Z1UGMJCa78lSs1FxFaqGSCg0qSHb4NaX?=
 =?us-ascii?Q?N1LMeSXAPRHiLJwV5ypBq4aGvf8FyLBbIT8vIKAZE9GZMYQVzrxBoXdzs8TI?=
 =?us-ascii?Q?EWLSD/w3+gy2y2p9PBC4M2kYhnWCRxfn0mvqIrp2h7+TL/bSVFu0RkrQ0Vr7?=
 =?us-ascii?Q?eHbA1sHzkfCZgHRY2EALdVFp0ZOPkQ+NAiVKkXiC0+cSZV8M+yPFC4wDvCcx?=
 =?us-ascii?Q?a3m5s2Cwfpdf6Sq/uS30VBtIqeBLevrI3f6nRjjvA2CQK8ki+fE2LqA9UIqh?=
 =?us-ascii?Q?/y3njFqvFE8McvGyIM3oDEpT/TlwegF423d71QvlAPmKidVvaRcXD2RISFyF?=
 =?us-ascii?Q?JX+T4rag6ycr1lIjxphofpbmnh49Mqucp4ppDypaNkiiqtrT92BQnYrqDk8U?=
 =?us-ascii?Q?UuQ9cWIYOsjIIl47VMCKBJxOvEoBhQ18nQLsIbxC8UrEtG0zfND4OdU73sX7?=
 =?us-ascii?Q?oQUhyVOJjbk9o9stlYPfp2nHN7AiiAMlvnTaaWqz7uuG0AOAZcgh5XZJxGu4?=
 =?us-ascii?Q?QiYwB7RTfzZzQEX7qN5pNUtHtghn/0rzd7Zs80AMCNUiF5ZBSoWcZbjXFOqU?=
 =?us-ascii?Q?MEdMuE1anMM3Mn2oVYUYxQvrpahl2SSK4pMRu1Kv+UdgJKsDVCALqOlOz7WX?=
 =?us-ascii?Q?QFpDOoRENq0Nv10eCjLfeJRRqE5ESFELDvIvWC5OSljb4fYfbFmZmYAodYjb?=
 =?us-ascii?Q?smgSySIDoEdG6uKLchhpZnuImj5w3xbB?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 16:26:12.9900
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 568272df-5717-46a4-4534-08dd574b73a0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FBF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7357

This series contains minor cleanup and trivial fixes.

Changes from v1 -> v2:
  - Consolidated protection domain free code and removed
    protection_domain_free()
  - Added Reviewed-by tags


v1: https://lore.kernel.org/linux-iommu/20250225105345.52143-1-vasant.hegde@amd.com/T/#t


Vasant Hegde (7):
  iommu/amd: Log IOMMU control register in event log path
  iommu/amd: Remove unused variable
  iommu/amd/pgtbl_v2: Improve error handling
  iommu/amd: Remove outdated comment
  iommu/amd: Fix header file
  iommu/amd: Remove unused forward declaration
  iommu/amd: Consolidate protection domain free code

 drivers/iommu/amd/amd_iommu.h       |  8 +++-----
 drivers/iommu/amd/amd_iommu_types.h |  3 ---
 drivers/iommu/amd/init.c            |  1 -
 drivers/iommu/amd/io_pgtable.c      |  7 -------
 drivers/iommu/amd/io_pgtable_v2.c   |  2 +-
 drivers/iommu/amd/iommu.c           | 19 ++++++++-----------
 drivers/iommu/amd/pasid.c           |  2 +-
 7 files changed, 13 insertions(+), 29 deletions(-)

-- 
2.31.1

