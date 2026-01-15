Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011069.outbound.protection.outlook.com [52.101.62.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04462D8372
	for <iommu@lists.linux.dev>; Thu, 15 Jan 2026 06:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768457323; cv=fail; b=MPQxEbMdOrJ8ZZq/sRmwK/h4mrnS4ZgxDrtX8o8CYsQC1lVVTnDz3/Eb678c3WTJbMpno8tWOzQJjIEuh5pWilO9add5En1XLt6xZ3XhqFMcbxrVHnfdnOAjqPEjNoHXdUB4Bur062YoxCZFz0Pr7xJt/fSzj+rghvPr8lX9OKc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768457323; c=relaxed/simple;
	bh=YEudJCcK0SrfeUBf8wbk1CKlltiwumSqD69cupjfZEI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KFNNLmbgWJZEB9G6pFHkHCBLs6oNqOox7/EeHS8weegzoX2mFKKm9i1BUbfpFC90EWTUw3i3TyamGIao3FjATn25Xe315824ovexDF48gV+Vq7ArENdwgLUnY0lWYAxkAywsOrMyWF3ojU6qFAt+aTiQcUnV0MzM34wrUBTgeu8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gIfCtZwB; arc=fail smtp.client-ip=52.101.62.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gIfCtZwB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r169SBO6KSFeVuqQnJdeOeFhzhicPDcz9MOrphC6/9Tx00Fu7ScrAchlyrqx6GL9tF3QyXtIgjue95LbAxS2OmI1yq3Z+NQJLYLJnNNRJBfcy7FmwQ58IK6FGzCq8P0P3YI4i5PexZVNdlh7wQh5HFX5v4AXBgES6MNeA8cPgH/Xtro7YAY4HkgFR2O9nQt1XuTfCNBLgUfCcH9uBkn+2THhDBJn7O+pbsR7Lykbp41/p8CZU4cAXM7VT6GI8ovCeWAN0hrsEW4rqx1hstNQFtC8NNo/ZzSsrKwyLZ6hNczTzHOLt4hPqcXAmo0qRJyJEC8F1Ma/qBujlq65pSgC3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fuKzKTA2JOiNp0deYocMsV3NpvdUr7Wq5RK7cIvgR80=;
 b=FTZF4Z1iMJCjYrwSCYspz0zVYejoPsLBXOFMNyPjDM7WLiVemOBmcUrhmIy7txxYDt7ijWwybXEGvKuiQewKAlRwxlkTmJ2KAW2I90iJrAFJIgFVWsX8bqJCh19o31LmK0gq8FUCK+NSjVNnH5B+8y21i6o4rbLiSb8K6BoibD/01BoCB0+LvS2O88EjwfADTr3t7wgzYRt9MWaMuwSTkB1jErcDRMZcFtFmkUANP5HoIgZrneflIx0gnbZkRQFRrBM+jxFuCBfq/q4F3qVqQFg8vCmETAihmKOlorXdjxsqQwLBvreKyWDD+iqeEDVxgR4rk5OKEi2g6ek1SvwwPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fuKzKTA2JOiNp0deYocMsV3NpvdUr7Wq5RK7cIvgR80=;
 b=gIfCtZwBjg9UOow8/rRxY5YmfFUsFIGxHgIsGYVbboGLlvXr2DuJ3qqEcAI2lMVem5ypI15VBu7h4p9o2Fh6I7vnvdqu3Bu/E0c1Gmktv1hamIyWKwHCmuwfuqRxvBGm4BXH9Y/97/rV2dO/37TFWv0icqvUImSVeN33X+98FvQ=
Received: from SN1PR12CA0051.namprd12.prod.outlook.com (2603:10b6:802:20::22)
 by IA1PR12MB7687.namprd12.prod.outlook.com (2603:10b6:208:421::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Thu, 15 Jan
 2026 06:08:37 +0000
Received: from SA2PEPF00003F65.namprd04.prod.outlook.com
 (2603:10b6:802:20:cafe::cc) by SN1PR12CA0051.outlook.office365.com
 (2603:10b6:802:20::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.4 via Frontend Transport; Thu,
 15 Jan 2026 06:08:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003F65.mail.protection.outlook.com (10.167.248.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Thu, 15 Jan 2026 06:08:35 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 15 Jan
 2026 00:08:29 -0600
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <jgg@nvidia.com>, <nicolinc@nvidia.com>
CC: <linux-kernel@vger.kernel.org>, <robin.murphy@arm.com>, <will@kernel.org>,
	<joro@8bytes.org>, <kevin.tian@intel.com>, <jsnitsel@redhat.com>,
	<vasant.hegde@amd.com>, <iommu@lists.linux.dev>, <santosh.shukla@amd.com>,
	<sairaj.arunkodilkar@amd.com>, <jon.grimm@amd.com>,
	<prashanthpra@google.com>, <wvw@google.com>, <wnliu@google.com>,
	<gptran@google.com>, <kpsingh@google.com>, <joao.m.martins@oracle.com>,
	<alejandro.j.jimenez@oracle.com>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>
Subject: [PATCH v6 00/13] iommu/amd: Introduce Nested Translation support
Date: Thu, 15 Jan 2026 06:08:01 +0000
Message-ID: <20260115060814.10692-1-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F65:EE_|IA1PR12MB7687:EE_
X-MS-Office365-Filtering-Correlation-Id: 935c5fd3-7edf-432e-99cb-08de53fc84e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024|7416014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cc3dFl8EBX16IS4fdcKAv42VnwK1Bv2g/mfgS4FKGSVahtjqeTsnQekI81//?=
 =?us-ascii?Q?GNR0WiaQ+k98IySdSR1l5KLSBO0LmKp19C3rqfjSovWLEn43r6ORqCZtn1LY?=
 =?us-ascii?Q?sLZ88KnXSrAN3S2krQB8ZTQ6n7kF8GyCIxyys2du/2RLuVdmuWYutln+BwTf?=
 =?us-ascii?Q?q8LKGiGzHcjUtCaCIjS6F4KNwRvLhbhPdNnHo4zeAvtZyr3joiZCjqjMzqWl?=
 =?us-ascii?Q?eh4DOLcWzMSABWxrOq+Yls1C92dTrwvSdEqRRsFfY2brkx9j/el7JAv7i6Fv?=
 =?us-ascii?Q?IgaKjKBeL61UzrMC7JFI9VdS3aQUpws2OisoCNQ9ji5d8/Mpn48Ky5YqTYcu?=
 =?us-ascii?Q?V7EKjJnkucFtyU73kOeJo08o5L9CrD2cW/wQls7LTbe9ZnfrZ3xYw+bBSw0M?=
 =?us-ascii?Q?YRoR5QXYXWdmRj/oZidfSSg4Q6O2ngbZAKUMIWDXjrxzXsz98Qmo64w1a8Hn?=
 =?us-ascii?Q?XqzdZw8Yuejs/7FYBH9vJBgsrkqysxmXSoG4GTtQAqlVvGSJseyVBt2RFKtv?=
 =?us-ascii?Q?7eqeu5IakILMLvacVR4EUqFQLTeir1RTop/6xUxSCvs6TEAppdWqSziDzxto?=
 =?us-ascii?Q?85hkf+WjnxiipBUKsTO3rE4YozDjCcJInbEjVaZ9LFZhqTlU8ofkjJIUDL7q?=
 =?us-ascii?Q?EovP33S8SKONoc9AxHmNlt2Rd7/hB8A5x7EAn4VS6zYNHIDCeLp6RRftdtK7?=
 =?us-ascii?Q?XLa4zgKO7lvOiUOAaHFcZXpR6IzB27sI0BWcv7gzY9QNM+jii8eHLNC0YJts?=
 =?us-ascii?Q?LUOZ7maMfJzQL+6IpCICMXzobptb0Sy3V3k1H56ZTZIkOquSai/ctVO6Lh3I?=
 =?us-ascii?Q?/4pJLHfqc6SGaA3mDDqDnXE/dnC5Tq3bQDe7ZtE5DBBp26ZZFPqukYcjFH5/?=
 =?us-ascii?Q?FtBEZLwk/04Ez/VAorz7mrsScnAoWZIpgJQjyMcymaXtCQ7Hk9t4JXAtqzQJ?=
 =?us-ascii?Q?dufgn+0Sx/lQRLxgKjKjqW21WidMENI+8JfoZaxsb2KP9W4eXMUJ37kKN7rQ?=
 =?us-ascii?Q?DlcgiZbeD3J046wwCyFXVvenYGU6BDrAtcqbws/ppeUFOZ7afVc7guZ9uj59?=
 =?us-ascii?Q?Gu9GuztrpTiCNhMZuhrDNsjY4/xBYDqsUaD1HCZ2hh1hxFP30FGZpG4p4LbL?=
 =?us-ascii?Q?UQDdKhERwfctNKB43+oiYxgnnLCCQUWkSiGPKrkJXUiaEVf/TvhVH6WaPnsS?=
 =?us-ascii?Q?Il7Qlfo+qXv3GxzL7H9n7gg6aeScD+6ajed08g8MnK5ZiVQKrWIGj2TIryXX?=
 =?us-ascii?Q?AWTzLxaINEpo7TUHVcErVay8RQm7tSFQE/BUu9MFTYulgmcEc5IzjW6m3XP3?=
 =?us-ascii?Q?k24RqZHQfhPMRRYoJU5VVD//zHZULRkCamoFBFN/lxXRVqDcH7wRuokC6avc?=
 =?us-ascii?Q?GxKvTCqBvrVWUtZwj7radC9sVRmoN+5oXeDI7STpXE2oARSlvMgtDBa7oYv5?=
 =?us-ascii?Q?9yyX7qQa4M82CInfKAGBuVeXWFVImP8ywS+CpwFgWuL8H86c9gV8HPXR00X3?=
 =?us-ascii?Q?tjsxQZmxdy15IkJB8x0mTlczDksqt262AvX/Q+kc8Ls2lWO6oyhFqrKQroE9?=
 =?us-ascii?Q?M7pIQuaKxssZYghWgLZYm+G1yb0EXDKnVDfJ3KGOHrh1iOusDujspCS94qsA?=
 =?us-ascii?Q?VGY2HS9DgfpboR5yJNhwZQ4jBr7ZZjqnd/QmkIaU0N1PI2DM+k/L2G7bLJqy?=
 =?us-ascii?Q?/UXVo/AX7OZZQeifgAfvK1rO4xo=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024)(7416014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2026 06:08:35.8808
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 935c5fd3-7edf-432e-99cb-08de53fc84e1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F65.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7687

This series introduces support for AMD IOMMU nested page table translation
with the host (v1) and guest (v2) page tables.

In this mode, the AMD IOMMU driver configures the Device Table Entry (DTE)
with host page table root pointer, which is configured by allocating domain
with page table type IOMMU_HWPT_ALLOC_NEST_PARENT.

The guest page tables and Guest CR3 (GCR3) tables are managed by Guest OS,
and stored in the guest DTE (gDTE) in guest memory. VMM is responsible for
passing gDTE information to the host IOMMU driver using struct
iommu_hwpt_amd_guest when allocating a domain type IOMMU_DOMAIN_NESTED.
Then, the gDTE is parsed and program onto host DTE by the AMD IOMMU driver.

In addition, this series introduces base code for IOMMUFD vIOMMU for AMD
IOMMU, and implements vIOMMU-based nested domain allocation interface.
The struct nested_domain to store nested domain information, and
set_dte_nested() helper function to handle DTE programing for the nested
domain.

The series is separated into two parts:
 * Patch 1 adds support for hw_info for AMD IOMMU
 * Patch 2-4 are preparatory patches.
 * Patch 5-13 implement nested translation support

Please note that this is a preparatory series for nested translation w/
AMD vIOMMU support. Currently, the amd_iommu_alloc_domain_nested() has not
been hooked with the struct iommufd_viommu_ops.alloc_domain_nested.
This will be fully enabled in subsequent series, which will introduce
the support for IOMMUFD vIOMMU for AMD.

Changes from V5:
(https://lore.kernel.org/linux-iommu/20251112182506.7165-1-suravee.suthikulpanit@amd.com/)
  * This series is rebased on top of
    Git repo: git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git 
    Branch: next
    Commit: c7fe9384c85d ("amd/iommu: Make protection domain ID functions non-static")

  * Rebase on top of Linux v6.19-rc1, and adopt the new gen_pt framework.

  * Remove patch "iommu/amd: Make amd_iommu_pdom_id_alloc() non-static"
    since it has been accepted from another series.

  * Remove patch "iommu/amd: Make amd_iommu_pdom_id_free() non-static"
    since it has been accepted from another series.

  * Patch 1:
    - Rebase "[PATCH v5] iommu/amd: Add support for hw_info for iommu capability query"
      (https://lore.kernel.org/linux-iommu/20250926141901.511313-1-suravee.suthikulpanit@amd.com/)

  * Patch 10:
    - Fix race condition using xa_lock()/xa_unlock() per Nicolin comment
    - Introduce gdom_info_load_or_alloc_locked() per Jason suggestion

  * Patch 12:
    - Rework logic for set_dte_v1() / amd_iommu_set_dte_v1()
    - Remove check for snp enabled and domid=0 since no longer applicable.

  * Patch 13:
    - Move amd_iommu_update_dte() to nested_attach_device().
    - Add WARN_ON for PASID enabled.

Thanks,
Suravee

Suravee Suthikulpanit (13):
  iommu/amd: Add support for hw_info for iommu capability query
  iommu/amd: Rename DEV_DOMID_MASK to DTE_DOMID_MASK
  iommu/amd: Make amd_iommu_make_clear_dte() non-static inline
  iommu/amd: Introduce helper function amd_iommu_update_dte()
  iommufd: Introduce data struct for AMD nested domain allocation
  iommu/amd: Always enable GCR3TRPMode when supported.
  iommu/amd: Add support for nest parent domain allocation
  iommu/amd: Introduce struct amd_iommu_viommu
  iommu/amd: Add support for nested domain allocation
  iommu/amd: Introduce gDomID-to-hDomID Mapping and handle parent domain
    invalidation
  iommu/amd: Refactor persistent DTE bits programming into
    amd_iommu_make_clear_dte()
  iommu/amd: Refactor logic to program the host page table in DTE
  iommu/amd: Add support for nested domain attach/detach

 drivers/iommu/amd/Kconfig           |  10 +
 drivers/iommu/amd/Makefile          |   1 +
 drivers/iommu/amd/amd_iommu.h       |  33 ++++
 drivers/iommu/amd/amd_iommu_types.h |  48 ++++-
 drivers/iommu/amd/init.c            |  10 +-
 drivers/iommu/amd/iommu.c           | 264 +++++++++++++++----------
 drivers/iommu/amd/iommufd.c         |  78 ++++++++
 drivers/iommu/amd/iommufd.h         |  20 ++
 drivers/iommu/amd/nested.c          | 294 ++++++++++++++++++++++++++++
 include/uapi/linux/iommufd.h        |  39 ++++
 10 files changed, 692 insertions(+), 105 deletions(-)
 create mode 100644 drivers/iommu/amd/iommufd.c
 create mode 100644 drivers/iommu/amd/iommufd.h
 create mode 100644 drivers/iommu/amd/nested.c

-- 
2.34.1

