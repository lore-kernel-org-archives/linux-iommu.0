Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2074.outbound.protection.outlook.com [40.107.220.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CDEE187B
	for <iommu@lists.linux.dev>; Mon, 21 Aug 2023 10:42:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RbntM5uzzh6enBEo3tQPHNxdjpktF3TtlaoBtvb+T4A2aTzukGqF5BOcIVJCNXhObqBgfBhfEGRC+sgaW4uDKlZ6OvsSz5k8qLV1RjJUczoMJYAHqi9Jz0ddSexxZbr8qbFpWVXNd/CGxhu4A0i3Nc1VIWVUxVcMjFE0siDEbn5bnxq5yu0gvqptBewMTSDyEOYRaxk09nSepBnGXkWD4nNF1hHuFq+CA0KGPbTUqByWvs1CnNY9vK2tjhrRxBOqNUXe2pcEmhgq3PY5ZKTfTllQ9A3tVJcN9xRQTKGE02oDbr7MY0Mf6y9kxZbI3UGSXHNYb5rhpg3DNdEvcUtJdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qii+P5o1hhQ7Ap1f1xHxhmnu0ddH/iSAVEgaXyphsuw=;
 b=Gi/StPfY68LznSiVc0yFhAVaYD050RcI0giuQ11JAJ49AqJHItAOdJdFu/GG3BHs/qeBeplx03fXjY9LWg2vP4hPvXfk7BkXtQm22pls/YB4GdFUYzjzNDcjP922kcodAgSFAonzXn3nhY7OHKdx8I+4tO04dr8ZmygvY3jLifdJrRj4WIs+akhAgVOGDuuNHac83pOnpgnAvXrA244cnLkl+YK592SchzRXj3ar4TMuv+bQY9SKIh5vEhOYkTmcTRvyK3nxRtKX3jMUahfpzabW/+qP+aQ+JICROHJ31UuKQH+Y1Ekc0cpdC+jUeiyhGxeIAc/COYxjjifXoOS5CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qii+P5o1hhQ7Ap1f1xHxhmnu0ddH/iSAVEgaXyphsuw=;
 b=OBKV6MwPJqWzCkcuGCItVQfKkDmpxXnmweSdIJw+OT1MEwJzUCaZ0aTt03d5TP9pREBF+BvdkBxcmIKDt7CC5Tj3oJeZaDtvHeYKASXoUTirDZ8aPrMKMMdLaY6n1wBfgXAZsqgAVUSdFb7nGprIQrSWUuSvt1I2aY0KvzBzcuw=
Received: from SA0PR11CA0199.namprd11.prod.outlook.com (2603:10b6:806:1bc::24)
 by LV3PR12MB9438.namprd12.prod.outlook.com (2603:10b6:408:212::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Mon, 21 Aug
 2023 10:42:52 +0000
Received: from SA2PEPF00001506.namprd04.prod.outlook.com
 (2603:10b6:806:1bc:cafe::b9) by SA0PR11CA0199.outlook.office365.com
 (2603:10b6:806:1bc::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20 via Frontend
 Transport; Mon, 21 Aug 2023 10:42:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001506.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Mon, 21 Aug 2023 10:42:52 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 21 Aug
 2023 05:42:49 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v5 00/14] iommu/amd: SVA Support (Part 1) - cleanup/refactoring
Date: Mon, 21 Aug 2023 10:42:13 +0000
Message-ID: <20230821104227.706997-1-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001506:EE_|LV3PR12MB9438:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c4278fd-8514-410b-c4c6-08dba2335ee1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	aXfgR8dyR/cLGQOm4u7+owBjZUVaDXJRnt9XUIQcsk8HBCRcIRCH7MxCuc+t/jgILmIJ9yAc0ergZAUeXmhF4mk/kLi7UuAOQ4ADTLq7dWKzPy0l8+9U8vJj/xQU5CYof47QNJ3Dj8nx49B/MwtX7rDn+JmgqSc2jLe8jSwYOCH4Ijq1vBHbLznjiQ17jfrqUqB+7VLn/YSO/xPfXxY+9+5K2Rf95H6p6x87qk8YFCav7baCL8HGtrzBdbNlu6c7cyYGgt75K17N1d2jOHc6dp5Vz/H/ZhEM9H9dL3THn4k8377TxucBruB+EbCh/dQ+ueBsHbgUJYqF5Rz/2RozGgKrjYJpo+W3z7pztaXMakwH/ezVbHaCMf5EiPtj8qaPHlnoXe0l8fbP7NG0dF4t6/G6eT07SLxQb3RxiqWV/8yd1fCN4l+WFfhbaoB0c1EuBGFnqo74E8vBeHb8VsYoVlHnbSEBI91cV2V9m4sUwVoj2oGcBEbGNt8UltWf2kG840t+0sJUdhyiKV/uo22GIoYGHv8PXSyKkmFPi9sVy8e71XZoL4tckLaEj2VCgda9A5pc8FOjbTVgR3OGw9gmQaw9PBl9GnqIxhbU1H59upZtgHnSqRopS2WegeC5KybNROjTDZLCR0WkQla6JUKSJ108qrPREvwNuH8KriBU5BtQXYckPLjU1vMuwYZiZb2HMG9FTg2GNWcjk4oiT0a6cip1sgj1V/WbEAibGLaqqeZd0/DSWnAlBEQ8kwhiforCjYXbWmoYSwugzuYS7OOHPz3ocYJpoZ37TR6vbpMfmgw=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(136003)(39860400002)(396003)(82310400011)(451199024)(186009)(1800799009)(36840700001)(40470700004)(46966006)(2906002)(83380400001)(7696005)(40480700001)(5660300002)(44832011)(336012)(426003)(16526019)(26005)(86362001)(36860700001)(47076005)(8676002)(2616005)(8936002)(4326008)(70206006)(316002)(54906003)(70586007)(110136005)(966005)(478600001)(82740400003)(356005)(81166007)(6666004)(40460700003)(41300700001)(36756003)(1076003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 10:42:52.1318
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c4278fd-8514-410b-c4c6-08dba2335ee1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001506.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9438

This is part 1 of the 4-part series to introduce Share Virtual Address
(SVA) support, which focuses on cleaning up and refactoring the existing
code in preparation for subsequent series.

It contains the following enhancements:

* Patch 1 - 7:
  Clean up, refactoring and miscellaneous improvements.

* Patch 8 - 9:
  Use global functions to check iommu features

* Patch 10 - 14:
  Modify logic to independently enable PCI capabilities (ATS/PASID/PRI)
  for devices. This allows more flexibility in preparation for SVA and
  IOPF supports.

This patch series is based on top of iommu/next branch.
Base commit : 8d3740021d5d

This is also available at github :
  https://github.com/AMDESE/linux/tree/iommu_sva_part1_v5_v6.5_rc1

Thanks Jason, Jerry for reviewing previous versions and providing valuable
feedbacks.


Changes from v4 -> v5:
  - Changed dev_data.ppr from bool to bit field
  - Reverted sysfs_emit that was changing existing behaviour

v4 : https://lore.kernel.org/linux-iommu/20230815102202.565012-1-vasant.hegde@amd.com/T/#t

Changes from v3 -> v4:
  - Dropped patches that were touching iommu_v2.c as we will be deprecating
    iommu_v2 module.
  - Dropped Review-by tags for the patches which got modified (mostly the
    patches that were touching iommu_v2.c code).
  - Introduced new patch to use global EFR/EFR2 to check the iommu features
  - Pass enum to set_dte_entry() instead of bool
  - Used DIV_ROUND_UP instead of loop to calculate gcr3 levels

v3 : https://lore.kernel.org/linux-iommu/20230804064216.835544-1-vasant.hegde@amd.com/T/#t

Changes from v2 -> v3:
  - Removed fallthrough from switch-case
  - Added lockdep_assert_held() instead of comment on top of the function
  - Moved macro defination (PPR_HANDLER_IOPF) to the patch where its
    actually used
  - Use helper function to allocate memory instead of get_zeroed_page()
  - Converted boolean to bit fields

v2 : https://lore.kernel.org/linux-iommu/20230728053609.165183-1-vasant.hegde@amd.com/T/#t

Changes from v1 -> v2:
  - Dropped GCR3 related changes from Part1. We are reworking
    GCR3 management based on Jason's comment. We will post them
    as separate part.
  - Addressed review comment from Jason
  - Added iommu_dev_data.ppr to track PPR status

v1 : https://lore.kernel.org/linux-iommu/20230712141516.154144-1-vasant.hegde@amd.com/


Thank you,
Vasant / Suravee

Suravee Suthikulpanit (8):
  iommu/amd: Remove unused amd_io_pgtable.pt_root variable
  iommu/amd: Consolidate timeout pre-define to amd_iommu_type.h
  iommu/amd: Consolidate logic to allocate protection domain
  iommu/amd: Introduce helper functions for managing GCR3 table
  iommu/amd: Miscellaneous clean up when free domain
  iommu/amd: Consolidate feature detection and reporting logic
  iommu/amd: Modify logic for checking GT and PPR features
  iommu/amd: Introduce iommu_dev_data.ppr

Vasant Hegde (6):
  iommu/amd: Refactor protection domain allocation code
  iommu/amd: Do not set amd_iommu_pgtable in pass-through mode
  iommu/amd: Rename ats related variables
  iommu/amd: Introduce iommu_dev_data.flags to track device capabilities
  iommu/amd: Enable device ATS/PASID/PRI capabilities independently
  iommu/amd: Initialize iommu_device->max_pasids

 drivers/iommu/amd/amd_iommu.h       |  28 +-
 drivers/iommu/amd/amd_iommu_types.h |  31 +-
 drivers/iommu/amd/init.c            | 116 +++-----
 drivers/iommu/amd/io_pgtable_v2.c   |   8 +-
 drivers/iommu/amd/iommu.c           | 442 +++++++++++++++-------------
 5 files changed, 322 insertions(+), 303 deletions(-)

-- 
2.31.1

