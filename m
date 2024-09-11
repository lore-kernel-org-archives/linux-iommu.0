Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2063.outbound.protection.outlook.com [40.107.220.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DBBE42AB4
	for <iommu@lists.linux.dev>; Wed, 11 Sep 2024 10:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726049993; cv=fail; b=V/JvMlltIoTem+RZbG7bYZF2n5GrKlnwQumhyzOFMHKEQZlVG2N9Ia5E1n4JK832gQWJbKbxRUCp4xM0sqO886vsnuzEhuguOAo13H0nwkGzsJ2h9jRXyknJaemPmK/k7qPL4ithXduK1pmxM57D7CjLKUt2k57OWKWq6KHKi6Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726049993; c=relaxed/simple;
	bh=Z7O6ijKI7n/I3NVmrQce7XVkC0uukOdW8DMAS4IkHl8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fDmh4wVCvhJ1UHqRf7wJiO2RIvyTn2Fpl/jf3zYOx16emuLOOq0cOi3FP15QDtkDZ6Vw1i21gNX+6b57Zf03nxpXOGwxI/Fa5lgmnN9+DESImJly02CWzjCvFq++gGa5YgR7bhkm5gIXHtpP5k5nC4cKLVTpgmNG2UH9ap2/fro=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=aJDwCToo; arc=fail smtp.client-ip=40.107.220.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="aJDwCToo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jYDK1573fAkUmUB96zMepRKQyQ9FhEvUAIi+plKazCQmG9bv+hEf56yd5Y3XRydWwpZ4pppZxf7OtzdP0+cdGdsaA2XHwkyao0tive7h0fAJg3zi7aa5qQYey5BY5JdiIOcTamylEKfU/dn3kklWW1RbEP57s8zTwokcMJbGkegH+zwvIiiEqg4m2QvHmN65G2ub0pSOE8ar9B0+MGD4yfa8AvmhAnDCtWb+QWKXpmHQYFBbl3+venmJv947OgUwPjfBoHmg+stJnhqspF907kMUIkR5VldzibMCW/X8XDlGL2mk3Tw69CpdKNNXOTmc8g5sQkGBLxhVR5EAi6AHaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W6lJJKBxAJqeQjJzPnAlOHYI9AljPKCAeGMyv/vNuLg=;
 b=q+YIf5o5e16W4PWCFkuyRwJiu9YwCsWovVdhAnbDjcEUQCBCAi1oIu/svWk46nqG2805wrksn3jUrkTL72aRjtCjyQdxecrMtCAJDv5wHX2bQZfO69KtD9SGvKtKQ9m7KtJySoi9G0eGlF/udF4h41N8Xc8nokTqguj9lMrR9Y61Ei2p1PCpjkPTKlORTMoaUx/yJV1yzPAc23OhDkYdcx/DSxF9IReceHYAANtAVvkW9vnWuZhs5+3aZXwdGp7uHRRox2il9ZdiOfJ+cHvd72UNhyiooLMbuxOhwyCP6GUw+71TwTHVOop9SqmeSAGNDJGzGNxClyhuTpWroyvpHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W6lJJKBxAJqeQjJzPnAlOHYI9AljPKCAeGMyv/vNuLg=;
 b=aJDwCTooTJr/gL2v5QNWjlOn1DX5Rg1XBNQI0OZpKswChvWssN+RcZ+qC/pU4CUjHqPGyzh68dmoaIyTfBXKdeq5cSE12CSLbjvxQHOd8IfMZ28VPSgyLKP54S1OtsgexjOTs7pO2BuZv7MSyio/9vM11Ia/LPX5FFmaI0DxJv4=
Received: from CH2PR19CA0018.namprd19.prod.outlook.com (2603:10b6:610:4d::28)
 by PH7PR12MB7455.namprd12.prod.outlook.com (2603:10b6:510:20e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.18; Wed, 11 Sep
 2024 10:19:47 +0000
Received: from CH2PEPF0000013C.namprd02.prod.outlook.com
 (2603:10b6:610:4d:cafe::57) by CH2PR19CA0018.outlook.office365.com
 (2603:10b6:610:4d::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24 via Frontend
 Transport; Wed, 11 Sep 2024 10:19:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000013C.mail.protection.outlook.com (10.167.244.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Wed, 11 Sep 2024 10:19:47 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 11 Sep
 2024 05:19:43 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, <jgg@ziepe.ca>, <yi.l.liu@intel.com>,
	<baolu.lu@linux.intel.com>, <kevin.tian@intel.com>,
	<jacob.pan@linux.microsoft.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v2 0/8] iommu: Domain allocation enhancements
Date: Wed, 11 Sep 2024 10:19:03 +0000
Message-ID: <20240911101911.6269-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013C:EE_|PH7PR12MB7455:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f687381-1d59-4aa0-25a0-08dcd24b435d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6gIjdbgBCMcnnIx5ZCr/33rOMtXg1rSM+QAIRfM13fBi3a9FjTrgXDuR/Inf?=
 =?us-ascii?Q?7C7N3G3cs9LGlSfymEXadlntBbbLjFAFx+MOP/tJfIVbEkbEhE0MH3biIu2m?=
 =?us-ascii?Q?6M7mvzeraIltzM8AvXS4xYtZ3K+EzIZUZ5n0Q6RGckDXPfOChl8tEhyoBZ08?=
 =?us-ascii?Q?gwwBVPnfTqQW8czXzBLLzkXu8LF9zhghrHUs5/+pm2WB3qMwXNfFsRBnNl+o?=
 =?us-ascii?Q?Q2+iDFbOPepABzXh5CF2wrXq05pIyHP0NDM5Xkgqp2fFCx4SPTgkSwYvRO/0?=
 =?us-ascii?Q?vEb9u1th495THYkCkVW69bFgJXCY6vSCfuvp3lA0S0vPHplWxUHGoW6NHoRf?=
 =?us-ascii?Q?N7jXEYpuu9csg5IMhEro7YWWjMUp68b0E7l5P8HtGeOPqmOmR9elVVCKxaKB?=
 =?us-ascii?Q?MrLoq+Wwzro730Q+VLhFztehdTIs2ZCpxWBTfwTwW8IwZZKdZamCezpfbi+X?=
 =?us-ascii?Q?AKT29c4E+l7RvkE6gPCegJ2ZIoqNdqz/bEQBwiiaNO4cL20/YVI2/Xe4QcX/?=
 =?us-ascii?Q?McWftUb2Kgd+lYufRpuFAm6GBQ/SAih8dZ/rF9NlRCQAr+xqrS1hhaydX565?=
 =?us-ascii?Q?JQ3tweTNqqBO1kdozLAfKgAAf+y5/PAKHirqLoOP9JlGLsA/VXZ861hfFpc9?=
 =?us-ascii?Q?L4vtsZuT2mUURaJ7sqgSres0qsK1ngAxknoXUcnGC6ef687VZrALc1yJiE+j?=
 =?us-ascii?Q?QwlBsj9vVQglurqoRjFizzIYYsRcCfip/oqoszKbUmb84CVintt0yesdhf0M?=
 =?us-ascii?Q?mLQahmUFHCuto7zF1CpAg0yWMBvdrpljhL3B+Nl+zbea0+WWoaG3GDx8+JEx?=
 =?us-ascii?Q?XygKsFRC7Yo0KnJOhEwd3fitE6KDuC36Cl3o5s4/eHnGpdcGHrGvN0hawNFw?=
 =?us-ascii?Q?YOVP7hCb9LUgwF4pYsqkMQkplY1Se2vyLfyIZyupFKKhdotU6etyJ0woKLGq?=
 =?us-ascii?Q?EH2E5K635Qmmg+bXFz40rjKazRBWBXpsnt/JLF9k8yzhQnbaMN27lZ/Jv1Rw?=
 =?us-ascii?Q?rohnJZIwKz0Nzn8dKL89sFdxXj/geduaF8EWOvJ2KUvbcowK/XmuUVnsKJKP?=
 =?us-ascii?Q?tmfFlXryI6DGWvd+CKVFpp9ENwHPOqqzIxFqU2UjY245Xemq1cQucrlvtSQJ?=
 =?us-ascii?Q?Rwn3dMMnF2yEYLJNIABoMpN9+DMZ2mbysvzULRTvZgK289G5OuCQJz8Mgm8l?=
 =?us-ascii?Q?JAd8xKr76q5Xx9cgFJmiYGr/p8XQhSc2G+ens07DwQPOUTTgI9APjFWr3kIa?=
 =?us-ascii?Q?1+s1o2rDHmu3B6dJ4ar+AqH6jgg/IRdGRFr7EF990hSNW2x43pI0POxDHO2R?=
 =?us-ascii?Q?q12ZaU6VPnMnvsZHr0gWo00/ZXOj6NP3BIbwB5DrXb2cM9dqnynxntjv52ll?=
 =?us-ascii?Q?W/Dqu+sYIiEk04NjSdyWKCkpOCmT20VjOEkxAX1j+sVmMtX1FWiahGmGx71R?=
 =?us-ascii?Q?4va8sBq8CF05FFxJM3dBcUHQhqqXfLa9PcqVGJpPUxqo2ZUOGCLHRA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2024 10:19:47.3388
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f687381-1d59-4aa0-25a0-08dcd24b435d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000013C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7455

This series adds iommu_paging_domain_alloc_flags() which takes flags to
pass additional details for domain allocation (like domain with PASID
support).

Also updates AMD IOMMU driver domain allocation code. With this by
default it will allocate domain with V2 page table for PASID capable
device and v1 page table for rest of the devices.

@Baolu,
  With this changes (patch 1), to allocate PASID capable device core
  will call domain_alloc_user() interface. Do we need any changes to
  intel driver?

@Jason,
  Do we need any changes to arm-smm-v3 driver?


Thanks everyone who reviewed previous version and provided valuable feedbacks.

This series is based on top of iommu/next and protection domain free fix [1].
[1] https://lore.kernel.org/linux-iommu/0-v1-ad9884ee5f5b+da-amd_iopgtbl_fix_jgg@nvidia.com/

This is also available at github :
  https://github.com/AMDESE/linux-iommu/tree/iommu_paging_domain_v2

Changes from v1 -> v2:
  - Rebased on top of iommu/next
  - Split patches into smaller patches
  - Added global static identity domain support

V1 : https://lore.kernel.org/linux-iommu/20240821133554.7405-1-vasant.hegde@amd.com/

RFC v2: https://lore.kernel.org/linux-iommu/fc8715e4-fb44-433b-a42a-7804118ebc57@amd.com/T/#t

RFC v1 : https://lore.kernel.org/linux-iommu/7e249bc6-c578-40f0-aca7-835149a0ad39@amd.com/

Jason Gunthorpe (3):
  iommu: Refactor __iommu_domain_alloc()
  iommu: Introduce iommu_paging_domain_alloc_flags()
  iommu: Add new flag to explictly request PASID capable domain

Vasant Hegde (5):
  iommu/amd: Separate page table setup from domain allocation
  iommu/amd: Pass page table type as param to pdom_setup_pgtable()
  iommu/amd: Enhance domain_alloc_user() to allocate PASID capable
    domain
  iommu/amd: Add iommu_ops->domain_alloc_paging support
  iommu/amd: Implement global identity domain

 drivers/iommu/amd/amd_iommu.h |   1 +
 drivers/iommu/amd/init.c      |   3 +
 drivers/iommu/amd/iommu.c     | 133 ++++++++++++++++++++++++----------
 drivers/iommu/iommu.c         | 105 ++++++++++++++++++++-------
 include/linux/iommu.h         |  16 +++-
 include/uapi/linux/iommufd.h  |   6 ++
 6 files changed, 194 insertions(+), 70 deletions(-)

-- 
2.31.1

