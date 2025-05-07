Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2052.outbound.protection.outlook.com [40.107.92.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A10214221
	for <iommu@lists.linux.dev>; Wed,  7 May 2025 10:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746615132; cv=fail; b=D8yjmhas7xfHLh4Ed59GSzuloZJBj2B720aOxmJgLAKEXdGjkgq0zuiYtosmCc40uZ3ABKhsc6+d20xCvjYj0FNzJDFTqmaMH3dlStdqB3TorRzsK+3+qQhyGW50wuWUD9iX4fUL/l2Uw2v2dBxbWEJMGQd70oYvlsq9e/EQFHI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746615132; c=relaxed/simple;
	bh=HlhFmZ8fk8AACTCaZkZx7pXp1Hdpb3v6/Kf4Lk4QPeQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=G9iNEFDoBwAbUSBRLpzqEEGi6snXFDksGDKYL32Sszd8GtjnhoeR+dB9+wVqfho1iXSvCfwyFEAi1MjKZQ1zVRUZyJ6oUITKvbFKsHQGdINFVcuwYDH7Csqeto1PQKYwnZOrkc1OYJbyiBXFZzfvq6pwAePR5NNsUzMwNLJVp2E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DuJSlkVs; arc=fail smtp.client-ip=40.107.92.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DuJSlkVs"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mkwC4ZfNl+1fXBp6XEtm8+pWqNJh7MRiS72uyI8aLjh+EE0dKURS8LGNxShpaxeTWjRwM/Y3iIA++4BuSfml5ae4oeD72Fxu/wc3d2f1H4gWIahYkDdRd3YNLCQWYtAhv+4OINBk0P5sH7sJUYdEcl0roAxzgjD8UMUzTDuJXx3mpEpkIhBTRkxivQ3w/HkF66fbYqEV+xfYxem5NxcekZpZCIpmd5ok3/G1HiVi2Otz+L2S+jpXoYBvp9bIaQuMfL4QtbJ5tSBWb4C8zeGLC4JFqNDSb8QxnjuJjgzyzVWtmn/LXU1PyKnH3DU3FysVFDLvWPEcBP2h7RKXT+4Emg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wOuORt/Vv8K8nWQTwGiow4M7sh+WcOsb01x0Pu0lO34=;
 b=H2JOzrtzu7nirzhXjhBhgrOiNwZrFA3slKPIQDwL+LQJgnVAQjD9Nwv+766qiOp9v54C93hZOLeBr7GAm069oeZZPfWThPmQcj/DhF1qdtZsvottZRuVBaqNDbdO02mYF+Gvw6qj5pLzyVmGj82MKP+KIaZpINn4raCX7RTr8WaenM0JUxrdTRrc5tHHKt9gxF/k1beN6Afgsm8tqjEoqW6P5ye5LGAuH/TnxEhRVCxQTi9dy1kD3HTUEL46GqtvLMZJe1BHoLCKrNF4sG8yMicEuRd3OWk41Ls1ghjiOpgIuDlcfvjt1bv+93hY5B3wBqUyQzqp6Fiy4COfsybulA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wOuORt/Vv8K8nWQTwGiow4M7sh+WcOsb01x0Pu0lO34=;
 b=DuJSlkVsoR7vZXxoGSFlgDUmZ4Tkz2thvR8u0o8N5H61TEINdj+GgQpoTQdTT8xlo1MMhnFzuAMWfQNJ7fmIBR/t0m6A9UM8oF7p5nQ/pHwhpWOkGSuWRacUZDyiFKq5JMlW+32Lt/fI0NZam8mfmk4EX9n1twPi5djlPGqAdq4=
Received: from CH0PR13CA0013.namprd13.prod.outlook.com (2603:10b6:610:b1::18)
 by CYXPR12MB9443.namprd12.prod.outlook.com (2603:10b6:930:db::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Wed, 7 May
 2025 10:52:07 +0000
Received: from CH3PEPF0000000A.namprd04.prod.outlook.com
 (2603:10b6:610:b1:cafe::ac) by CH0PR13CA0013.outlook.office365.com
 (2603:10b6:610:b1::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.16 via Frontend Transport; Wed,
 7 May 2025 10:52:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF0000000A.mail.protection.outlook.com (10.167.244.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Wed, 7 May 2025 10:52:06 +0000
Received: from BLRANKISONI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 7 May
 2025 05:52:02 -0500
From: Ankit Soni <Ankit.Soni@amd.com>
To: <iommu@lists.linux.dev>
CC: <suravee.suthikulpanit@amd.com>, <vasant.hegde@amd.com>,
	<joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/2] iommu/amd: Support for HATdis and HATS features
Date: Wed, 7 May 2025 10:51:46 +0000
Message-ID: <cover.1746613368.git.Ankit.Soni@amd.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000A:EE_|CYXPR12MB9443:EE_
X-MS-Office365-Filtering-Correlation-Id: b32404b2-ce88-4a44-979c-08dd8d5535ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?k5j2R0kxWM6dxl9pAQ2d0B6osw9AvHXd9GQFLFwaqq4J+UiESkeN6/WaVqgM?=
 =?us-ascii?Q?8gECWWRe41Wo2CJIDl0pLzgmPbSuYIozaJJbg27Mi88jiVB62QU+SvwVOtsj?=
 =?us-ascii?Q?IGSRcFcDlH/7ODqZBl60TXuSQ/h4ZdT6xsROwtGWjBfmdAET+HMg4Y6YqOrV?=
 =?us-ascii?Q?AKKKGKEyvlcdfGMFYXvhCnPCUuPpOD/qyH9M4Cu2S8fw4Pk+VZoiVmq41EHX?=
 =?us-ascii?Q?Fz0Z9trNp9G7joTef2SxEhRVWjnk+7FlmzAGa5I4fZgrA+8EdTyvgOrGivbR?=
 =?us-ascii?Q?wEtuOIYGYmGaoQ0sw+yKXz7U6nyjOcumJ+1PXL9Z/Wpptq9GLr70Wr7UIvJB?=
 =?us-ascii?Q?Of7fKFZkvMqLT/kEqATzv1gx8utkoz1wUu9suAAFfnst8uZAOQWw/BIwTfmx?=
 =?us-ascii?Q?HpSIild5+klSy65lucNLZYKpqUsGlWbGW2jt/xPF/r/+KLxGy8/kQUiRmYJK?=
 =?us-ascii?Q?arBnb0MclfywFRiPfBtMffe/PeJpPkpuMwvM7OEiA/bNuWoCnSOvrVP1ucHF?=
 =?us-ascii?Q?bMRR1b+STbHEr68l7E/laliVt1A8L4W4WKqZzR6umCcSFYgQyNnq3sXa56NZ?=
 =?us-ascii?Q?5YTQv+RSfWTlIedbV/+DJ8Ztex4Ar4rTuyteFga/+76QxlTFoYGI3H5yYKmO?=
 =?us-ascii?Q?xjYYdlHhs63ZGgq+s8lK2xGGZ8Je7X4vXDb5i8es4LAJnP4loPZ8KTJtf9l5?=
 =?us-ascii?Q?ay94+wCgxh3ofoAHUOIEDCT68OAR5GEuBc6jM1ZcNkqPCnFDcP+PirowX8xN?=
 =?us-ascii?Q?26uCqxIf7BbgOu8oJQGzvBTV9mAvAS6Wrz2AVwEJxYZOadLA5OfiXL+tlVtB?=
 =?us-ascii?Q?50mxxX3hdAzNVaXsWssLqCRg9PPras/0Xk1FkpHfwWGcLYeJW0xQ4qLpbk1o?=
 =?us-ascii?Q?1W1o80RWuJyc5WgL8cBNAb9shcUfT3Q0DBTEiuKNAjdzeqmECB8wLQc6XKSq?=
 =?us-ascii?Q?toTlXH2aBlrQ8WT9z/UuFEB8+ewbwPn8cVB/e20+0savsykpPnbMb9EN/z0R?=
 =?us-ascii?Q?ewxKOKQ1CuTg+luwugJVSOnDKNZ93YMmYM+h5QNiz34senUum8Y+OZppWPo4?=
 =?us-ascii?Q?8WzETpBJETcbhv4bF4aszF68ReMP4edTUpOi1ElrQ34EF/ABbKXqFiTJOpsN?=
 =?us-ascii?Q?AItsrYGTzwu5qzDhl839zZdLxE71G5GEX8gg9iblQr0YalqBQGJGRouTyCPY?=
 =?us-ascii?Q?nyznMFGQKll5aRWOQy25iwYjcErzE6HSSSAg9QdNXFtd6rsrnWqBiihtSpST?=
 =?us-ascii?Q?cUqECAvGXwhFqmjg44/HdorchCQI93ZeqxoO8tjw+ULNVDqEo7jHOt8sfyvE?=
 =?us-ascii?Q?OjfOEIp2KzMSSqY7+Wp/Q/dKoIPZfnx4awDdg6nImCx6uysat2sx6L6CRerY?=
 =?us-ascii?Q?QXOrV4iJqM+hNRABXnLsvOaG0T44H7tixHvGx+5xzlzHKKfcvpgorFpXoVWh?=
 =?us-ascii?Q?fUg6MWD+++NP9wJ2+c9bDcllI27sz+7OzWsVa+uo8rJ1UyGyunzpiA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 10:52:06.8122
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b32404b2-ce88-4a44-979c-08dd8d5535ad
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9443

This series comprises two features:

HATDis: When host address translation is not supported by the IOMMU,
the IVHD->attr[HATDis] bit is set. For instance, QEMU emulated vIOMMU
does not support DMA translation for VFIO passthrough device.
Support has been added to check this bit and switch to guest page table 
mode, if supported. This feature is useful for cases where only interrupt
remapping is required.

EFR[HATS]: These bits indicate the maximum level supported for host page table
by the IOMMU. Modifications have been made to adjust the maximum host page table
level, starting with level 4. If these bits are set to 11b, the driver will
attempt to use the guest page table.

If guest page table mode is not supported, the driver will fail to probe
devices for DMA translations.
The interrupt remapping will continue to be supported.

---
Changes since v1:
- Addressed comments from Vasant:
	- Added/Modified comments and logs.
	- Removed v1 page table assignment hunk.
- Link: https://lore.kernel.org/linux-iommu/cover.1745389415.git.Ankit.Soni@amd.com/T/#t

Ankit Soni (2):
  iommu/amd: Add HATDis feature support
  iommu/amd: Add efr[HATS] max v1 page table level

 drivers/iommu/amd/amd_iommu.h       |  2 ++
 drivers/iommu/amd/amd_iommu_types.h |  7 +++++-
 drivers/iommu/amd/init.c            | 37 ++++++++++++++++++++++++++++-
 drivers/iommu/amd/io_pgtable.c      |  4 ++--
 drivers/iommu/amd/iommu.c           | 15 +++++++++++-
 5 files changed, 60 insertions(+), 5 deletions(-)

-- 
2.43.0

