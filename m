Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2056.outbound.protection.outlook.com [40.107.243.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4497410949
	for <iommu@lists.linux.dev>; Wed, 16 Aug 2023 17:40:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ypg4JoO5CeDSasYjz2QyTIhbCqglc+3kJjqH6dyLVjFlQve7/kVtLNxfeOzBGoIPsQsK9qCXA1ov6FLSc4RgBHW21aV0koe7hentnJH01+iszRNBB/zBMesjokoLXl8hRNJFLxoch9yA3kgcB77DMnCDytjhDz5sClgw73AJB/jb1ooh/WstRPrgib2gX92AqidkaX+XSQpROkU1kXoKkSRYKcSQqSFIWkiOHvEx4UT4mH67NptXH6rmxAyhRkv0KlBhqpg+bYETIgm2Kmxn3jerVE3JvdBDkBXpKQ9wT8M/onxnH5M71ew+sNskD1k5WZw8U0oKZZhcydhc8ZIJFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IvEZ6/eYMK039bMrF+oaNdyrWohJDd57XyJkRWYWMyE=;
 b=JfxGBQopNFEsjVD3XT8i8Xsq1q6zHfIU8A5ftrPwmWwP5VQOO9jHdY4OM8mQvtfpeeF7wuzskt8PkwAfSp0n4c8Gi8FANWs6xHXb0i9NajioiLdQX5gWiLlpWKWXvfKDCPpS2JArMUB8UJVmx+k4bSIVf3zesFFdza/+pWwdASt8W8MyIt59pCgr6E6R7+pnlgvWkXlFXKiKVHi/XUs0CLBJVmWxE/vSWhnAev3hAvFY+6h/hOa2TAhMc6XBT0unquA5LVlidUykCTseM0dh2WMIvoPJ7AzLN750RyRleBvHitQ3zH71VpEkG9z7CYxqYWE92R14t0zQ1U2X16KMKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IvEZ6/eYMK039bMrF+oaNdyrWohJDd57XyJkRWYWMyE=;
 b=HIiLVM4EWj60CnTmvqVwr3XwwAA4Re9DrbdmDEEKSJ+UZTvIHSnxqTfDfk8Oe9yE9FuIk6D6xJ0sfzqxEbcU40GzGxcLFOf7mpJYi3VK9L5hHIrrCza2f4vWQueGD8VQ3SR9hWxC0KZHAMSulN5YL7emUSqr7Yp/t4nHUuoPG/w=
Received: from SN4PR0501CA0107.namprd05.prod.outlook.com
 (2603:10b6:803:42::24) by DM6PR12MB4561.namprd12.prod.outlook.com
 (2603:10b6:5:2ac::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.29; Wed, 16 Aug
 2023 17:40:53 +0000
Received: from SA2PEPF0000150B.namprd04.prod.outlook.com
 (2603:10b6:803:42:cafe::5b) by SN4PR0501CA0107.outlook.office365.com
 (2603:10b6:803:42::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.14 via Frontend
 Transport; Wed, 16 Aug 2023 17:40:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF0000150B.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Wed, 16 Aug 2023 17:40:52 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 16 Aug
 2023 12:40:50 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v2 00/10] iommu/amd: SVA Support (part 3) - refactor support for GCR3 table
Date: Wed, 16 Aug 2023 17:40:21 +0000
Message-ID: <20230816174031.634453-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF0000150B:EE_|DM6PR12MB4561:EE_
X-MS-Office365-Filtering-Correlation-Id: ae816370-9e77-44e5-38a7-08db9e7ff024
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	JQStI/5sEJmKeMWJWcOBxA8Lggp/HmgT32BIkJdrXUBk4bmj2vkUyJLAH+Afc8aT1fA6yxisTp6YoSditM31CbaSRoaWNv2jKI0mvSXU8iUMIyO4MtFQ2/fxQ9aSOkUIim91rCVpsGGJaDQfPP+OsVv/1rxdsv0t1rjUnbvPUHb9TnxFLrejrfsDzVl2sZF+W3VtukA3l7xKvEND90UMR5t4fiP1LoinGGCZH7uFs5UfGVfwTnw8a3py101j9PnvbCpauQjHG0ap/z+XJW5uUpPME03kTQuleR1/QisbaPCaLdoHGoNxn034OrWW7cwRdVomoi55qUK2fLaCzVFswlaa5jLKKJnNuuOj7qmwTObEfyV2r85X9uS3VEppR8b09iwT6zqto9KYxIhsx/SfbIPU/qXQVFI3VF0IvnQ3dEmGIXH+ZqA1j7OVA3aK5YsfMp8Wk2mAe2hEn6I+R6w4UYyKLkJLtMDdx6pAD8Cepp8QC+Qec1HKIE5nKkE3oLNtYqtmT53yIO9Ue8sul+jVLhcqANb1Utkhxunu9pObcn9JtAHIbz8JTqTQCWw8lNxJzSIZ36wevlY24OvtssOc/benEacvqZ1zSoXWlfOA9M3f5gF0vHMNKEqSSe1dPHEimA2zMm99KKAU4uD3rQ9wqdCID+Lhm5cnUMNlbRtCcNnPjYy6qkcNsKjRMvoVRATp1WRJPs5ssqeEcYYPTEDlVLZxi/Dux815+oT20a6CB0xbZA2HWdUJK5bLIubmat2MWH8shIOPWE8BdNkM8q2rq3pHUG7ccA32HfVQuj8hHHA=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(39860400002)(396003)(346002)(451199024)(1800799009)(82310400011)(186009)(46966006)(36840700001)(40470700004)(2906002)(40460700003)(83380400001)(86362001)(40480700001)(478600001)(426003)(336012)(36756003)(7696005)(2616005)(6666004)(1076003)(26005)(16526019)(966005)(5660300002)(44832011)(36860700001)(41300700001)(356005)(54906003)(82740400003)(316002)(81166007)(70206006)(70586007)(110136005)(8676002)(8936002)(4326008)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 17:40:52.9373
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae816370-9e77-44e5-38a7-08db9e7ff024
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF0000150B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4561

This is part 3 of the 4-part series to introduce Share Virtual
Address (SVA) support, which focuses on refactoring GCR3 table.
This moves GCR3 related information from protection domain
structure to iommu_dev_data (per device) structure.

It contains the following enhancements:

* Patch 1 - 2:
  Rename helper function

* Patch 3 - 9:
  Introduce per device GCR3 table and code refactoring

* Patch 10:
  Remove unused variable from protection domain structure

This patch series is based on top of SVA Part 2 [1] :
  https://lore.kernel.org/linux-iommu/673b7081-801b-d24b-ea75-33c5847951b4@amd.com/T/#t

This is also available at github :
  https://github.com/AMDESE/linux/tree/iommu_sva_part3_v2_v6.5_rc1

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

Suravee Suthikulpanit (9):
  iommu/amd: Use struct protection_domain in helper functions
  iommu/amd: Introduce get_amd_iommu_from_dev()
  iommu/amd: Introduce struct protection_domain.pd_mode
  iommu/amd: Introduce per-device GCR3 table
  iommu/amd: Refactor helper function for setting / clearing GCR3
  iommu/amd: Refactor helper function for attaching / detaching device
  iommu/amd: Refactor protection_domain helper functions
  iommu/amd: Refactor GCR3 table helper functions
  iommu/amd: Remove unused GCR3 table parameters from struct protection_domain

Vasant Hegde (1):
  iommu/amd: Use protection_domain.flags to check page table mode

 drivers/iommu/amd/amd_iommu.h       |  24 ++-
 drivers/iommu/amd/amd_iommu_types.h |  26 +--
 drivers/iommu/amd/io_pgtable_v2.c   |  24 +--
 drivers/iommu/amd/iommu.c           | 257 +++++++++++++++++-----------
 include/linux/iommu.h               |  14 ++
 5 files changed, 213 insertions(+), 132 deletions(-)

-- 
2.31.1

