Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73AE11CA84
	for <iommu@lists.linux.dev>; Tue, 16 Jan 2024 16:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PK175Q3y"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mIgkYzpnNA7bx30LLE2WEg7RRtjmomPLNZjoTzEBzxB9I9N4dlQpPA0IFvvMtojt8cGn3XonPKGKjcJ5NRw3yNAwuegxqLmNWUkX5fbK9XTkE2z9SGqOmgoFNosUtKupgj1PPo56k9xpJEMAEXZddVdwJNBFMgxbpdGgn2GrdhvA8Il2ZUT+eQEyudBBmovNFSwMnqbYdgQO9wNq0SBCrEZsWtr7uwj4C1t3ux9r1KAuRsGxcIUYdbtkzmITM+KJrthnSIJCyJ/7+Niv29zPd51Dm95ngKdOm8O1uf0J4gAXx8DFnDKYh0pTPkEPGjnD1dT72nWv43mqYKxwqYiY9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z7P2OGoBeZ4MIw6v0nTQMezL+usCRZXHEjU4Yi+LVGQ=;
 b=NrN821AEj/1iz5kEh3zxNJPGMTj2BQ8UEPKz4La+qGy0xTM+eilsJyZCGuMdhD+LNiS2x8pzcfOhm///ajgcJXZRXP7SXpdW3bxBHddTNMf7hls0erb9L7H6DJ+XhOeGxIzRONgop9GQD+2wFi61xEFZZXO7kWQqU4OeiT/NRpWijmnS1MrLFTCqd+H5NDDGpTJf+5xkfBlBI6WZsdHKPoj9DjnDRV4GHIVDJ5cPcfltkwMvVDIojQkupLqpHwH7/V+wYsoY1SofpZEaRiSjbtWVzdPMGZll5fudQ2jtxeym8Mz4Lojbx0jdsbjBUyAADrwumssxuJTY88JJ83MeRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z7P2OGoBeZ4MIw6v0nTQMezL+usCRZXHEjU4Yi+LVGQ=;
 b=PK175Q3yZ1Praag/yqQI/IpfE4q/dnLlf70NikCGqB5C0caXe+X6Am/BSgSiCKdiH0iZZigdOmdv1ED88hhUx+dOIs9ITNBgZqpKSwRI2ZTriHsejHGUGv9o5nzJ/kpT8UIOPOuSicB7tfEQEyInRc9WSfVe4ViqKboY2TfNt2U=
Received: from DM6PR08CA0023.namprd08.prod.outlook.com (2603:10b6:5:80::36) by
 DM4PR12MB5198.namprd12.prod.outlook.com (2603:10b6:5:395::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7181.23; Tue, 16 Jan 2024 16:53:58 +0000
Received: from CO1PEPF000042AA.namprd03.prod.outlook.com
 (2603:10b6:5:80:cafe::e1) by DM6PR08CA0023.outlook.office365.com
 (2603:10b6:5:80::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.26 via Frontend
 Transport; Tue, 16 Jan 2024 16:53:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AA.mail.protection.outlook.com (10.167.243.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Tue, 16 Jan 2024 16:53:58 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 16 Jan
 2024 10:53:55 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v5 00/17] iommu/amd: SVA Support (part 3) - refactor support for GCR3 table
Date: Tue, 16 Jan 2024 16:53:18 +0000
Message-ID: <20240116165335.6043-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AA:EE_|DM4PR12MB5198:EE_
X-MS-Office365-Filtering-Correlation-Id: 610eb7a1-8ccd-4d42-136f-08dc16b3bba8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	9jN4O3Tk0QpO9f0pznfP96ByjS4DDeFQgJE/Kvji6F5Gx0VrUcwY32vp8OZti//y6eQcSsLTgS1J36yt75fgFYDGRzJLxTNPtfc7x7tcK7ToMgiprs7wBYhNxQJdJkDe5Bb0eZC+2hwnt5kUmrIV9+MaQ5zFiIkgEJ5nSu7gR7kRfXuYxvm84HNBoBcbCBkM9/uVpRgH/nzSPE7QvhAdILqVjCFLmMIdRDoQTd6tTHHRdfsjGDMJRzI5RfqhORqs3A7KZC6xDA0qJDaUtW/NbgRshj2D2QgyNrnHEcrUNGzaR3YtTdRKJi5ZABJXygUgmuqTk+X3xobkuAYy70HaaXL+M8DyhzgWtmMn6Q31voYSUGyp7BBPhMUBhPh5VLi2pFbrnFH5WODWfdy9iTZJFq2n3p+qmlkNW/kFhlJh/ERZ/BDDDHzYfq+w7MHMjkwMGsUgyEAV3BeOF2kwrPOfFjc++0wIvVnJvjb94Ww692rhRWBmWA3f6U8xNcmimYlHpqKCISHi4wS+xuFi83eBwYh264DBQRQ6vQcJyrOEUOu0lM/DtuzhUtlW7AJsdeJBd6gaTPJojUPnhm8BWVQ/GRNnlBpJIPerF935VincVhEAT3tP9ebophXZY+nk8WqWiBQ12+VPjzCnXn3DscWArV6QGptvNXSvLWGzFJor8i+r4fYs/KnEQzeXkn681jfGmCyaH0w9fgkZumLqrnvD6aYJin+2zjQG0BeZj+JMhIqmET035LYngGJc8xJtI8Yg1Y3S8jDmzsRvO5+gduFaO0P6Ddx2hQobhy1FJF7373s=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(376002)(39860400002)(346002)(136003)(230922051799003)(186009)(64100799003)(82310400011)(451199024)(1800799012)(36840700001)(40470700004)(46966006)(336012)(26005)(16526019)(83380400001)(426003)(1076003)(2616005)(82740400003)(110136005)(36860700001)(5660300002)(44832011)(4326008)(47076005)(7696005)(2906002)(966005)(41300700001)(6666004)(316002)(478600001)(70586007)(8936002)(70206006)(8676002)(54906003)(36756003)(86362001)(356005)(81166007)(40460700003)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2024 16:53:58.1516
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 610eb7a1-8ccd-4d42-136f-08dc16b3bba8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042AA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5198

This is part 3 of the 4-part series to introduce Share Virtual
Address (SVA) support, which focuses on refactoring GCR3 table.
This moves GCR3 related information from protection domain
structure to iommu_dev_data (per device) structure.

It contains the following enhancements:

* Patch 1 - 3:
  Cleanup and introduce helper function

* Patch 4 - 14:
  Introduce per device GCR3 table, per device domain ID, invalidation based
  on per device and code refactoring

* Patch 15 - 17:
  Remove unused variable, rearrange functions to make it easy to maintain

This patch series is based on top of iommu/next branch (commit 75f74f85a42e).

This is also available at github :
  https://github.com/AMDESE/linux/tree/iommu_sva_part3_v5_v6.7_rc8

Thanks Jason for reviewing previous versions and providing valuable feedbacks.

Changes from v4 -> v5:
  - Added get_amd_iommu_from_dev_data()
  - pass gcr3_info instead of dev_data to setup/free_gcr3_table()
  - Added path to EXPORT iommu_group_mutex_assert
  - Moved dev_data->domid to gcr3_info->domid


v4: https://lore.kernel.org/linux-iommu/20231212085224.6985-1-vasant.hegde@amd.com/T/#t

Changes from v3 -> v4:
  - Added new patch to enable IOMMU GT feature early
  - Fixed dirty tracking path to use get_amd_iommu_from_dev()
  - Fixed duplicate flush issue in do_attach() path
  - Removed gcr3_info->giov variable. Instead we use domain page table mode to decide
    DTE[GIOV] bit.
  - Free gcr3_table before calling set_dte_entry (otherwise there is a possibility
    of its setting up gcr3 table with glx 0)
  - Adjusted gfp_t flag for GCR3 table allocation (GPF_ATOMIC -> GFP_KERNEL)
  - Moved below patches from invalidation improvement series to this series
    * Remove unused flush_pasid() related functions
      (Originally it was part of Invalidation improvement series, I had to push it to
       this series as set_gcr3() was still using __amd_iommu_flush_tlb()).
    * Added patch to Rearrange device flush code

v3 : https://lore.kernel.org/linux-iommu/20231013151652.6008-1-vasant.hegde@amd.com/T/#t

Changes from v2 -> v3:
  - Dropped "iommu/amd: Use struct protection_domain in helper functions" as flush related
    functions are already fixed and set_gcr3 related functions is reworked in this series.
  - Removed moving to_pdomain() function from this series. It will be introduced
    in SVA series where it will be used.
  - Added per device domain ID and per device invalidation functions
  - Added functions to flush TLB for the given device
  - Added Review-by tags

v2 : https://lore.kernel.org/linux-iommu/20230816174031.634453-1-vasant.hegde@amd.com/T/#t

Changes from v1 - v2:
  - Dropped iommu_v2 module related support as newly introduced Part2
    removed iommu_v2 module.
  - Moved Patch 'Use struct protection_domain in helper functions' from Part1 to
    Part3
  - Updated get_amd_iommu_from_dev() to retrieve iommu from device structure
  - Removed 'PD_MODE_PT'

v1 : https://lore.kernel.org/linux-iommu/20230808100232.5977-1-vasant.hegde@amd.com/T/#t

Thank you,
Vasant / Suravee

Suravee Suthikulpanit (8):
  iommu/amd: Introduce get_amd_iommu_from_dev()
  iommu/amd: Introduce struct protection_domain.pd_mode
  iommu/amd: Introduce per-device GCR3 table
  iommu/amd: Refactor helper function for setting / clearing GCR3
  iommu/amd: Refactor attaching / detaching device functions
  iommu/amd: Refactor protection_domain helper functions
  iommu/amd: Refactor GCR3 table helper functions
  iommu/amd: Remove unused GCR3 table parameters from struct protection_domain

Vasant Hegde (9):
  iommu/amd: Pass struct iommu_dev_data to set_dte_entry()
  iommu/amd: Enable Guest Translation before registering devices
  iommu/amd: Use protection_domain.flags to check page table mode
  iommu/amd: Introduce per-device domain ID to workaround potential TLB aliasing issue
  iommu/amd: Add support for device based TLB invalidation
  iommu/amd: Rearrange GCR3 table setup code
  iommu: Introduce iommu_group_mutex_assert()
  iommu/amd: Remove unused flush pasid functions
  iommu/amd: Rearrange device flush code

 drivers/iommu/amd/amd_iommu.h       |  29 +-
 drivers/iommu/amd/amd_iommu_types.h |  26 +-
 drivers/iommu/amd/init.c            |   6 +-
 drivers/iommu/amd/io_pgtable_v2.c   |  21 +-
 drivers/iommu/amd/iommu.c           | 633 +++++++++++++---------------
 drivers/iommu/iommu.c               |  17 +
 include/linux/iommu.h               |  21 +
 7 files changed, 377 insertions(+), 376 deletions(-)

-- 
2.31.1

