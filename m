Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2053.outbound.protection.outlook.com [40.107.93.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB627101F2
	for <iommu@lists.linux.dev>; Tue, 15 Aug 2023 10:22:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bET1BV7CJbfvUTMHttRmzYXa/GPBXFIebaUsu3S9Io+JmcvLS/Tkj51YM2wiQZRFchVaWhr9Dfok3fLowr1s3Gn1aJptn8tWqrFUEAPRLj62E5EkkNfHRcD8mSNpHgZtsXXNxYOriQLwa2y+agLjVsDPqdnis3WgNxSzRPU4n44HBRFcUbsAzgUO07zPr1OdmxR5lky4483dDZafhRH1MO8T2M+afXk6syNWkYCja9rAE+dsDVLLuVtYG9zwYZgCjSRyVOvZXt6k38e8DFheiwDHtYAuJH/FKlSznWUFbUYYjyfthJ+5qp+cwa7ZoIR03Jljfz1rPaQQ1iNM63QJhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WzFaNlgH6ymd34hhdSvR6uAUEutGw04kpKCeMr+sW6I=;
 b=mdOTAQN0s/vEHKzgarC5WSKD3iptd3/uK+pngjbDid9dOoWOqge0GgeAAx8fesUPeebwFgfU1l38nZuM7AJDDyWsl6/joAWjqwmDH5SG5PL/k2g7YMQU3DYre7oGs9uva1cxwGBAVbttYeDGgH1rsugozCeFig8K2nZKSKQ16WuQdd0e/SfKJrfJBKfIachbu7ztQTSU0BunJRWBIOhAVovMRgPvSjniWwcEiE6DhW6CHgylH3zjzlxiUKjMWain/AOd0xqx/zVJHN8nNubH3brr03gMeOZMCtRTypWCFK8piz+jkQoJFzVH4WEkXzLX/2klWN38ae5pqg1YmsHbxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WzFaNlgH6ymd34hhdSvR6uAUEutGw04kpKCeMr+sW6I=;
 b=X0x39TRcIXINFOT9by1LbX7vVpJ8QjbUM4xaDx8bClIqSVu7mNqTVh7QPLkxd+OXC4W+pExhnVLSbrqGEePI7KHIMH9X+jg3m2jzFGjd4V4PURlkZklmFa+KTXJCMdEEM0ncJjM8jtKQGjOg2qa8G4jXxU0Z9lRQHZUKxiGq4jU=
Received: from MW2PR16CA0023.namprd16.prod.outlook.com (2603:10b6:907::36) by
 SN7PR12MB7179.namprd12.prod.outlook.com (2603:10b6:806:2a7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Tue, 15 Aug
 2023 10:22:21 +0000
Received: from CO1PEPF000044F6.namprd21.prod.outlook.com
 (2603:10b6:907:0:cafe::1f) by MW2PR16CA0023.outlook.office365.com
 (2603:10b6:907::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.33 via Frontend
 Transport; Tue, 15 Aug 2023 10:22:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6723.3 via Frontend Transport; Tue, 15 Aug 2023 10:22:21 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 15 Aug
 2023 05:22:16 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v4 00/14] iommu/amd: SVA Support (Part 1) - cleanup/refactoring
Date: Tue, 15 Aug 2023 10:21:48 +0000
Message-ID: <20230815102202.565012-1-vasant.hegde@amd.com>
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
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F6:EE_|SN7PR12MB7179:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cf408dc-761b-4ee1-6b2c-08db9d7982ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	UYEWTlV0buQ1DJ29GIehlyf0inTzdaWidlY2ZT+jgkWHwMBNFAqXYgBJ8T8XtSrfk8jHjktEMLN5iTtTrknp4FT8DfftXPILxx1QAc/ZOFYcyq20h5iOQMlyoB1AQMCLsACDoBcpoooU6EKCfM3eoFYTVnojr564pvlV3YFB7D+V4C3cJaPCp7XZNI7iP1adgySme6FtokB7CP7IkEeZclijBzxF051puF76EzU0wF/sbicktZvGQ2o1mRqMm3lyhILWL5qOJSKAwSU6UxPaGz0ZPKp/KQ2te6SWY94zwHqh0TB7Hs5GCvQcrajWdehve9C8sqfHA0DBvPraWX9DKKGZKy8BuyEzOMBXhUanuVefSM79Y0To1Sae075YtHlREG3xENlJ5RilOZ3ryQvneVFMVSR+JvzdiRwkmVzolvvX6nrG2BKvqtpu2ZTx48zM6EzhDFbr1sIeLMY+MixGKZSZTVqo8NY1n4dFV9U/4FIUDBlXH/N9KhR5vnBB5HBn2DOZhocYfpZjVwvPB8wYL8M/woMPn9nPueu17I1cd7MKbIZ+pB+Aw+TVOpT8Crlb36mjgz8rwajYkR4FuBJa+3+Dv1+19SYPS4SC2T9fAr5ThzYBwoKyJt/DtNxAxVyUA7ZaVlHcP35qYrpTrUP8Nmq1/LAR6ACKueBdmjWHMD/R6ybvx+tWkf2JCcT3Q2AaPY05t5O6vYdwZTQxZrhE7DNGwSPAjE0yOXEN+7/tKDmuVM//WEG6Pp2IqlbxiAM6LI24VSE84m0F3qAdMJU9HvxlSZUIgXoDbb1QaFI/5J4=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(39860400002)(346002)(136003)(1800799006)(186006)(451199021)(82310400008)(40470700004)(46966006)(36840700001)(1076003)(2616005)(40460700003)(7696005)(6666004)(36860700001)(47076005)(36756003)(86362001)(82740400003)(81166007)(356005)(16526019)(26005)(83380400001)(40480700001)(426003)(336012)(2906002)(41300700001)(44832011)(5660300002)(4326008)(8936002)(8676002)(316002)(70586007)(70206006)(110136005)(54906003)(966005)(478600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 10:22:21.5719
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cf408dc-761b-4ee1-6b2c-08db9d7982ff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F6.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7179

This is part 1 of the 4-part series to introduce Share Virtual Address
(SVA) support, which focuses on cleaning up and refactoring the existing
code in preparation for subsequent series.

It contains the following enhancements:

* Patch 1 - 7:
  Clean up, refactoring and miscellaneous improvements.

* Patch 8 - 9:
  Use global functions to check iommu features.

* Patch 10 - 14:
  Modify logic to independently enable PCI capabilities (ATS/PASID/PRI)
  for devices. This allows more flexibility in preparation for SVA and
  IOPF supports.

This patch series is based on top of iommu/next branch.
Base commit : a5003e75a171

This is also available at github :
  https://github.com/AMDESE/linux/tree/iommu_sva_part1_v4_v6.5_rc1

Thanks Jason for reviewing previous versions and providing valueable
feedbacks.

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
 drivers/iommu/amd/init.c            | 117 +++-----
 drivers/iommu/amd/io_pgtable_v2.c   |   8 +-
 drivers/iommu/amd/iommu.c           | 442 +++++++++++++++-------------
 5 files changed, 323 insertions(+), 303 deletions(-)

-- 
2.31.1

