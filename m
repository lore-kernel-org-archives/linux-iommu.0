Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2079.outbound.protection.outlook.com [40.107.243.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D73134C0
	for <iommu@lists.linux.dev>; Mon, 11 Mar 2024 09:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710148157; cv=fail; b=kiirPtD+xNqTAq+VqKrVH6ltWbtjSpOMK8W3r6zhKh3m3zRPuYSFmw1+HOPt2xNK1vVs4k7RnaNxYEjQ4/rD/IS/rFnUUl9zE17+x4ogR6YpjYq5aCZbkZfGsO12gyxmexR6AkEm5SH6vkexFdNEqsf9oQmXoL3MP1rvNxrTF4k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710148157; c=relaxed/simple;
	bh=jwOTOAN0XoL8Opb+znt4rAKZiZd6qwJDp7TY3G7bmto=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=k2OXPhTA/cNZ1uVKyIxV83IxSwQVogqLriuF9dLfK/m+gPghMfeS3kioUD1LSGy3VF+FCejERJuO85/Vi2nvCwYHEbM6ql2rgUUSO5aTAo8DWb4EWNLxrFclNr+LqbWKthVJQzIKbkRDSDL+2ezxVTamcqc5nV6imlLferZ+bog=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uPuSC2ob; arc=fail smtp.client-ip=40.107.243.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uPuSC2ob"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ke6io6mU+Mf+dW+3J9w7gf/CrXkm9JW7IFDBIFdw4VmOO2mtg2QmGcecA8GARk4rUfzJq0ygDrHbxN6QUM5nqhDlooGH1qLY7AZ61md4VU7hTZt2rLIEaiAtXcQALyPTY4K4ZSeLrCFRONRgSX6N41skhPVwmsIKkfx1dJcjGRQGABiysdJMg4YWJbq1SiNdCbveTWu0WbrUS5MAJgl/akvWf2t6u39WMN+Fch5wlp+4FoTWxUwQcnm6edB5PBqY4Wh7uTfTGcyxHow6eTDEeZN16Cvz5xzV8pblQXtbOGEnzt6HV0SU3JlJ55BGknHWUEBcFnBriBv6+i2Wt9kKSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mCTjODeoXcwU8h50PZQBUge4BjG6JSe89pOObJy4u4M=;
 b=bgJyHoe8r4vjvjwnBzo6sfIocz8bvOMAMFWd+oX9bke8kxi96yaEPiiSaDU5iE0C0wcydedW0+27+b3/qObSgh+1pE2y3UOGhmA24RHR3o4zrcK2i0Kj+V0Xa8zVWO5ZHMtpZhsAixQO/QFBFCf+2Itsd31s9J6t3vruI7Re+0pQoYL5gXOpASD2CY90rush9wgpY4gSE3P1ekBmrJdqpPSeH+xYSw2vs8yDQl8qmebOf1RlM/W8XJMWnh3Yr5o/34H1u8n0Ess95ltQQgZsOS4sDoQJESbYjy/xwOFd3hljwEfSX3YqmsTfHCk9cMVW8IYf5vYsVzFVcCqhBg1FHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mCTjODeoXcwU8h50PZQBUge4BjG6JSe89pOObJy4u4M=;
 b=uPuSC2obx1Vbeazue4lMbOYYjV9je5AY34mldT5E/jiRPJL2i5GxJEW2C1dfmt74hE2dxmCLjkVYrcCNzVyGM67Cj5qvWBx7hT9TWWpIVkZM99pQVlkiSc5ELHHSxyFbSzni2tFVHY2UmXEUdjTYwsSjdxGUrKI9eqOQs6kWysA=
Received: from BN8PR04CA0061.namprd04.prod.outlook.com (2603:10b6:408:d4::35)
 by CH3PR12MB9430.namprd12.prod.outlook.com (2603:10b6:610:1cd::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Mon, 11 Mar
 2024 09:09:11 +0000
Received: from BN3PEPF0000B078.namprd04.prod.outlook.com
 (2603:10b6:408:d4:cafe::26) by BN8PR04CA0061.outlook.office365.com
 (2603:10b6:408:d4::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35 via Frontend
 Transport; Mon, 11 Mar 2024 09:09:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B078.mail.protection.outlook.com (10.167.243.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.12 via Frontend Transport; Mon, 11 Mar 2024 09:09:11 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 11 Mar
 2024 04:09:08 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v7 00/15] iommu/amd: SVA Support (Part 4) - SVA and IOPF
Date: Mon, 11 Mar 2024 09:08:28 +0000
Message-ID: <20240311090843.133455-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B078:EE_|CH3PR12MB9430:EE_
X-MS-Office365-Filtering-Correlation-Id: e44eeaef-52a5-4b87-791e-08dc41aaea60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Ys7HlaAu8QSrHjQ18aS79ShAJStV0jW4sAT4ynE0mJR2Hx3102Hz9tL/K+naNDoRifM8z237eJ9dPddVlP9EWrQNoeu3mLuX8KrpMf4q4cu9EVa+9wPPKPOQ4PAWY2zlcLnSMTkoKTBd61X/CcNr7lJ2OkCOIViTZ6r0E5AiYjujECQW6f88WCY1TQ/KFLzAofvledOkZFmIWOlKFbBX+b7ELnTrJ8ot6O52F4QFQbDxXiuooAS67QjwvidPngFIYUireg2qGw98ijIOJrHtgO1L/n/VvbKuhFsV0MwskqWQRTbqh+Sjb4OWCxqTwWb1+HqhUtkZnPtKJfiZEUePA5GRV/JCgbqd/3/JSDp3cjqWObMvOTsgUDFz/tKO9+/t+3TNeiKVv+wMMGVEBYMm3o3yTu0bi4R3B/lTDPTLoDBQDYmUpxkAerI5M31PP8WC/4ykXh8/iaO0bbRJgFtQR2gcxMzj1N4tjRw7cA++ptM+LKvHdCg/UC8UM9xCA+2IKX1ct5T9W2tanrpVVP4Mg5BPq8JcqjSWrcHPzhy7EUMpZDAEXvQCkD3jazL5f8ue6vcDfLaxH/uI2KDAVmyg77J7oNPwXddbhPzWexPTfdsQgNT7trBkY4vZAeWw7BYWmgR/8x6BFSC+FtghCN8zi6MroCVCSWvYVgvMFXY7Afym0V9QvctDZTBQnDnjo+tLYbsMqD6Pnz84YcMrB78Ksg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(376005)(1800799015)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 09:09:11.1892
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e44eeaef-52a5-4b87-791e-08dc41aaea60
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B078.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9430

This is part 4 of the 4-part series to introduce Share Virtual Address
(SVA) support for devices, which can support PCI ATS, PASID and PRI
capabilities. These devices are referred to as SVA-capable devices in
this series.

It contains the following enhancements:

* Patch 1 - 3:
  Rename, add support to enable/disable features, update DTE etc.

* Patch 4 - 12:
  Add IOPF support

* Patch 13 - 15:
  Introduce SVA support


This patch series is based on top of iommu/next (Commit f379a7e9c3b5).

This is also available at github :
  https://github.com/AMDESE/linux-iommu/tree/iommu_sva_part4_v7_v6.8_rc7


Thanks everyone who reviewed previous version and provided valuable feedbacks.

Changes from v6 -> v7:
  - Rebased on top of iommu/next
  - Trivial white space fix
  - Added Reviewed-by tag


v6: https://lore.kernel.org/linux-iommu/20240209112930.63663-1-vasant.hegde@amd.com/T/#t

Changes from v5 -> v6:
  - Rebased on top of SVA Part3 v7
  - Reorganized, added few patches
    - Patch to track per device max PASIDs
    - Patch to setup GCR3 table for SVA capable domain
    - Patch to enable PASID/PRI only when domain is capable of PRI support
  - Dropped below patches as they are not needed anymore
    - iommu/amd: Add GCR3 [un]initialization function
    - iommu/amd: Add support for add/remove device for IOPF
  - Rework sev[/remove_dev]_dev_pasid() functions
  - Dropped late gcr3 setup patch

v5: https://lore.kernel.org/linux-iommu/20240118073339.6978-1-vasant.hegde@amd.com/T/#t


Changes from v4 -> v5:
  - Rebased on top of v6.7-rc8 + SVA Part3 patches
  - Few minor improvements like renaming structure name for better, introducing macros, etc


V4: https://lore.kernel.org/linux-iommu/20231221111558.64652-1-vasant.hegde@amd.com/

Changes from v3 -> v4:
  - Moved amd_iommu_dev_update_dte() after set/clear_dte() so that we can avoid
    forward declaration
  - Dropped "iommu/amd: Do not override PASID entry in GCR3 table"
  - Added patch to fix PPR interrupt processing logic
  - Renamed enable_iommus_v2() -> enable_iommus_ppr()
  - Added ops->domain_alloc_sva()
  - Added domain_alloc_sva() support and reorganize SVA patches
  - In error path iommu_call_iopf_notifier() calls amd_iommu_complete_ppr()
    instead of amd_iommu_page_response()


v3: https://lore.kernel.org/linux-iommu/20231016104351.5749-1-vasant.hegde@amd.com/T/#t

Changes from v2 -> v3:
  - Rename sva.c -> pasid.c
  - Changed amd_iommu_sva_supported() -> amd_iommu_pasid_supported()
  - Added patch to update/flush DTE
  - Rework part of SVA support
  - Move IOPF enablement to PASID bind time

v2: https://lore.kernel.org/linux-iommu/20230911121046.1025732-1-vasant.hegde@amd.com/T/#u

Changes from v1 -> v2:
  - Added new patch to fix PASID override issue in GCR3 table
  - Complete rework of SVA code on top of Tina's SVA series.
  - Rework SVA enable code
  - Reworked IOPF handler code on top of Baolu's IOPF improvement series.


v1: https://lore.kernel.org/linux-iommu/20230823140415.729050-1-vasant.hegde@amd.com/T/#t


Jason Gunthorpe (1):
  iommu: Add ops->domain_alloc_sva()

Suravee Suthikulpanit (3):
  iommu/amd: Move PPR-related functions into ppr.c
  iommu/amd: Define per-IOMMU iopf_queue
  iommu/amd: Add support for page response

Vasant Hegde (9):
  iommu/amd: Rename amd_iommu_v2_supported() as
    amd_iommu_pasid_supported()
  iommu/amd: Introduce per device DTE update function
  iommu/amd: Fix PPR interrupt processing logic
  iommu/amd: Introduce iommu_dev_data.max_pasids
  iommu/amd: Setup GCR3 table in advance if domain is SVA capable
  iommu/amd: Enable PCI features based on attached domain capability
  iommu/amd: Add support for enable/disable IOPF
  iommu/amd: Initial SVA support for AMD IOMMU
  iommu/amd: Add SVA domain support

Wei Huang (2):
  iommu/amd: Add support for enabling/disabling IOMMU features
  iommu/amd: Add IO page fault notifier handler

 drivers/iommu/amd/Kconfig           |   2 +
 drivers/iommu/amd/Makefile          |   2 +-
 drivers/iommu/amd/amd_iommu.h       |  49 ++++-
 drivers/iommu/amd/amd_iommu_types.h |  33 ++++
 drivers/iommu/amd/init.c            |  85 +++------
 drivers/iommu/amd/iommu.c           | 283 +++++++++++++++++----------
 drivers/iommu/amd/pasid.c           | 202 ++++++++++++++++++++
 drivers/iommu/amd/ppr.c             | 284 ++++++++++++++++++++++++++++
 drivers/iommu/iommu-sva.c           |  16 +-
 include/linux/iommu.h               |   3 +
 10 files changed, 786 insertions(+), 173 deletions(-)
 create mode 100644 drivers/iommu/amd/pasid.c
 create mode 100644 drivers/iommu/amd/ppr.c

-- 
2.31.1

