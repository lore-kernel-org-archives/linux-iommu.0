Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2084.outbound.protection.outlook.com [40.107.92.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754C21C4612
	for <iommu@lists.linux.dev>; Thu, 31 Oct 2024 18:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730400189; cv=fail; b=jZ1rU7n8ZSLw/Fj8J3aLmA4VGPWfGjW5qApQVbA21k+HBa/ZNIBs921zMFDSMg/iKq3i5biinAqB3od2TEPK8MTl0ziBqlkUD2R5vxvkEGjiZ29fg0IqiXMENDHoPKE0pxVAVhVKwDzHbcWAAQVk9JctYK53NfJXjOpkldBdLdI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730400189; c=relaxed/simple;
	bh=5v+yEW5Ew5qAOr687byExo3BWtOq0GQ/H3woTHYc1yI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FmQMn7xgM2JGQCvwYxvJtDTYo0LOrF+/3g12riTB01NTe3hfFPW/ofb5+bk6RHKcRAuHpCkitYO9y3Ay0qKtALrolUR0t1C9OVRl01ecLZjNac1PDpuv/8UyjB4FSl2rcrx8scCAtEPGcNt2BQZbvEhWe0lo0Slr5fjvBQQ3qy4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rvfi/DcD; arc=fail smtp.client-ip=40.107.92.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rvfi/DcD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nB+aVbaPqdJQAW++t1e5U7+P9hL8ndrt5KcGw/080VpvI0tjEv7SCSAUBdfmI32uENBb4KoEqCKzLYmjanJiEerO/36xxJKdMMU7ocHxXz3ufs7CHifFve7fZuJE+XjpCgnWjqqIK4tzCpYF0LikRsTm5p6e6reSMTcI4BBg9fCrcsRbvWdtrwKzDIgJefEEB+C9WzF69cY9O1EQn9Lj8DLmo2Znw/ZuilyhsdXx9w78Fd7g8TmKx1XfkdW0jJf5JxJS09jCZOppy4QAYblpmXmQyTq6MLud4qx6gz3lgxLqraflkyJAiJCApcl38KcXLllLb8XqkO/Jy8gn0b0QFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h/yCc9AVINxIgEHKGjcNmunMeNpwGhj227RyjEoGLPM=;
 b=s5t4TAJyVcU2HGI3U9/PL/NjusOhwboy3KyHLZTG6Mi3CLBiCo1tKrp3/kcqs+1AXaVmHjIetksct4yxdI4yDXXGykBbmxMxtN20nUo0cqeLB9et5yuOFQvi96OZv4CPRWYhIPO7ntgSsBuhtVrjzWYcpvjrRYU/IOHZc19wTn9nucN4qdXTQIaZKu3GtRTHttRL+RCZTsPHMCQc6vJR1PtR1+M9wABt82sNPZBrl7mWdzkshpalBSsQYOb/v67wm0V0IPSode4hquaGiK0On7fnuSMkNcIfb34H+9crk98RDuyL5qVq/jpGnLZoGpOQeBMYyXfWZtT2k9zB1Up27A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h/yCc9AVINxIgEHKGjcNmunMeNpwGhj227RyjEoGLPM=;
 b=rvfi/DcD60CBSNINoAJDKSHbnOmr0ZGpQ9EyLJcKfaha/FTyNEd/ruooD36pYpuAHY50RDZ2KVjJPVxqaHSiD1bSopktcHkzFQwjXmVzNpa54fFvS1U7Uu1HJfoiY6jh27j206Po+7TcjhqmoQxaqN/cHkR1MwWaTluHVoHjky4=
Received: from CH2PR08CA0002.namprd08.prod.outlook.com (2603:10b6:610:5a::12)
 by DM6PR12MB4465.namprd12.prod.outlook.com (2603:10b6:5:28f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.24; Thu, 31 Oct
 2024 18:43:02 +0000
Received: from CH2PEPF0000013B.namprd02.prod.outlook.com
 (2603:10b6:610:5a:cafe::78) by CH2PR08CA0002.outlook.office365.com
 (2603:10b6:610:5a::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.34 via Frontend
 Transport; Thu, 31 Oct 2024 18:43:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000013B.mail.protection.outlook.com (10.167.244.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Thu, 31 Oct 2024 18:43:02 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 31 Oct
 2024 13:42:58 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>
CC: <joro@8bytes.org>, <robin.murphy@arm.com>, <vasant.hegde@amd.com>,
	<jgg@nvidia.com>, <kevin.tian@intel.com>, <jon.grimm@amd.com>,
	<santosh.shukla@amd.com>, <pandoh@google.com>, <kumaranand@google.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v8 00/10] iommu/amd: Use 128-bit cmpxchg operation to update DTE
Date: Thu, 31 Oct 2024 18:42:33 +0000
Message-ID: <20241031184243.4184-1-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013B:EE_|DM6PR12MB4465:EE_
X-MS-Office365-Filtering-Correlation-Id: 727e9411-3493-4aeb-9507-08dcf9dbd973
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hCExocR1UQ1q+u6ibtRECGkJCc/8DmdpSweEoGf7K28FmmraFs54wAdxo9FL?=
 =?us-ascii?Q?cY8FISD4xl9nxJUvuoiLLu4H45Tg4SDxLgCiY81Rga6mHXhbTufzJrOHq61z?=
 =?us-ascii?Q?WcPj0CbzQiTpY55ZGKRg7LeDbfXt6E1i6XeOF8foPM/88dyxUr4KZG48lJrG?=
 =?us-ascii?Q?WnK3td5B/MFGjrlevTvtD12Y0Vce0awdNB+SPvhPaEk5tSJBijCXlz4ITJde?=
 =?us-ascii?Q?lP7RXBuwdiWA5Rel7fCMoiLy3MihUYhcem/yFsATRwMiYbH4yPWaq2jtQTBg?=
 =?us-ascii?Q?9uGVHPtItLFzLUFJzjdDZ2tQecht6Fp0ToxLggZzc9MrI0Txb4hIfBWrH2r6?=
 =?us-ascii?Q?TLso91Lo6Jd6D9QUMDKceWIDSFlHIbZTuLgch9rrK80Ht4XD7Qdw1l9x82//?=
 =?us-ascii?Q?VxzDFjRhVtPj9eBVg5NEqHsMxh886aUGzmoIFuU/7KfKJ408Gpbyhs7CPXWZ?=
 =?us-ascii?Q?pHFPS4U9HylLCZfoxEcUJ4Scy50LON2NdlbN1wK8MYWtGiMgviYiUAwr7kAi?=
 =?us-ascii?Q?dLmapiV6UP4Yf0KWtU8s8jhKCyT3w3bN8037a/9YlUN46hfQDa35g2t61XYM?=
 =?us-ascii?Q?3iHTpWThpZ7P5USki9z0/OqHUsxd44BhkPvg3+p5OJkJslQg7Mx6nc0sw+eb?=
 =?us-ascii?Q?GTsuTIJ57fjywjaWJz1C+5SJvjwHGnQlXkXSi+im5iwgMLVmj6cfnvjRqKwS?=
 =?us-ascii?Q?8OmiIilc25KQacKQy9+VEpl3UauHwPICksBuqfVnrroQcSWctcyNgWLaQbe/?=
 =?us-ascii?Q?hO0odfrvzitzFq7GGwLWbT3KOvrVwnB0laOJAnr0gBRSqZg/lGIvQI3gMOCu?=
 =?us-ascii?Q?wqNUs05NFXO1AiNJa2lJyvOVK+nLfrRIyTZWpYWKCpOjJIq5IEo1k61s6LL9?=
 =?us-ascii?Q?DuPsvN4Lso4GUlkfAhDNEd4uOAJWJ2lKeLR8WTfFDXe3TttNCDFy1ep+oBCC?=
 =?us-ascii?Q?gXoU2neNUQOvi0GIxv2b0PkY0eqGtFjK0JzTIp68sO0On4tfnmc2bBqAJkGT?=
 =?us-ascii?Q?Xb2xmfEp2YsMcceVHu2HgxK+1HZAH75QrYeclcSnFiKMAtHpIV3CVlQFVRG2?=
 =?us-ascii?Q?XFaptj9kgvlVqI42j1eRmjWzsy4KZVMrTEmVeeGpuJcgofXA9xLo3sHK2qXu?=
 =?us-ascii?Q?/9zqhuSJ+qFYzWpWTRZVnQMcDn8FltMqxxDpb51HP/885QRy2tgbIc40Fy2I?=
 =?us-ascii?Q?E00b7Gap1+jfC4PbKrm0mFWTi0rtolxQpZHXmYg4Mfm4lRQ4q2oi79YoFq0t?=
 =?us-ascii?Q?ItwSI5YjtDZTwR6m+RHqvqEfBfoHY0wQUw2kCP65HIyeclvqoiiCwmNLizSb?=
 =?us-ascii?Q?j46yFI8rSEry37RAZMXxIB2SdJpfeGqGNmEXnLqKdwR4LT06NaeuPChmw0t+?=
 =?us-ascii?Q?Nk5d5NZLeJ5PMVtZAgO/3Ig/P01Pyb3F8LX7P0d0iQdzF7lofCHLlcOlW0Hc?=
 =?us-ascii?Q?i8KMeMIN4M8=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2024 18:43:02.0371
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 727e9411-3493-4aeb-9507-08dcf9dbd973
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000013B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4465

This series modifies current implementation to use 128-bit cmpxchg to
update DTE when needed as specified in the AMD I/O Virtualization
Techonology (IOMMU) Specification.

Please note that I have verified with the hardware designer, and they have
confirmed that the IOMMU hardware has always been implemented with 256-bit
read. The next revision of the IOMMU spec will be updated to correctly
describe this part.  Therefore, I have updated the implementation to avoid
unnecessary flushing.

Changes in v8:
* Patch 4: Add struct ivhd_dte_flags.segid
* Patch 6: Update amd_iommu_get_ivhd_dte_flags()

v7: https://lore.kernel.org/lkml/20241031091624.4895-1-suravee.suthikulpanit@amd.com/
v6: https://lore.kernel.org/lkml/20241016051756.4317-1-suravee.suthikulpanit@amd.com/
v5: https://lore.kernel.org/lkml/20241007041353.4756-1-suravee.suthikulpanit@amd.com/
v4: https://lore.kernel.org/lkml/20240916171805.324292-1-suravee.suthikulpanit@amd.com/
v3: https://lore.kernel.org/lkml/20240906121308.5013-1-suravee.suthikulpanit@amd.com/
v2: https://lore.kernel.org/lkml/20240829180726.5022-1-suravee.suthikulpanit@amd.com/
v1: https://lore.kernel.org/lkml/20240819161839.4657-1-suravee.suthikulpanit@amd.com/

Thanks,
Suravee

Suravee Suthikulpanit (9):
  iommu/amd: Misc ACPI IVRS debug info clean up
  iommu/amd: Disable AMD IOMMU if CMPXCHG16B feature is not supported
  iommu/amd: Introduce struct ivhd_dte_flags to store persistent DTE
    flags
  iommu/amd: Introduce helper function to update 256-bit DTE
  iommu/amd: Modify set_dte_entry() to use 256-bit DTE helpers
  iommu/amd: Introduce helper function get_dte256()
  iommu/amd: Modify clear_dte_entry() to avoid in-place update
  iommu/amd: Lock DTE before updating the entry with WRITE_ONCE()
  iommu/amd: Remove amd_iommu_apply_erratum_63()

Uros Bizjak (1):
  asm/rwonce: Introduce [READ|WRITE]_ONCE() support for __int128

 drivers/iommu/amd/amd_iommu.h       |   4 +-
 drivers/iommu/amd/amd_iommu_types.h |  41 ++-
 drivers/iommu/amd/init.c            | 230 +++++++++--------
 drivers/iommu/amd/iommu.c           | 370 ++++++++++++++++++++--------
 include/asm-generic/rwonce.h        |   2 +-
 include/linux/compiler_types.h      |   8 +-
 6 files changed, 441 insertions(+), 214 deletions(-)

-- 
2.34.1

