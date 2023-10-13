Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2063.outbound.protection.outlook.com [40.107.94.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE1011CBC
	for <iommu@lists.linux.dev>; Fri, 13 Oct 2023 15:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jxcXAXry"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aX3sXIRjCk5pU7C/5yBcK69AEYisVMvXBZPKCSQ6MSuKqfmI9jHjrfY0rReMJ9kt/l2g/I9mc3L7l7v7bqpTRF1INhj6y9aRAdBm9K76d0Wdy3zdIZ54xpXEduNVy4qkDHWDLi2hBqNKQAeye7b948EWfHaD9unfAesEENPY6G0x/zjqgjDXwVjc3QC+kDlShmake0MnkP/Ps/DyccpsJYq157J63mrCt4C4xMvMA9UmaJRKVYa2IoZJbJoG+tajyEUQB1k1W7wGmCtkPJ79RRU5EmYl3vUB1DLAR2MFuIuGuLGR3PUuzI3m3YDnFS139rIh2o5QrJ3QRypqxm9Vsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A9dX8+iA10d5zYtc2xmitwDE4LLc512IDOHje1Aqwzk=;
 b=ABO8kVhebLIZRr/RcX9aPvrpoSWQCnY+E/VNjdK6/qwm18s098lHgoPYfgXouzzDrz5Sxlt+7pr3mXo/tYn+dN9sTSMrSW3CPchb/2mKqktjq7W8jWQSRQ/+AIwe2TUHMPw7WdPvIO38xBILDBKPypAMMjRgh/Oz9BlTcu1K+KlgJqOpdOBZSlp1pQg1kkqLz6sMTs75ec9h6zs9vmUdesG/twRdkkxQiji1SpzWlUq5opY0aI/58m5ydA9QpTcr1MOr7NG2V3pBKDzgv4mHGksnVSpHpUIoaL+zxENxYaLVRpGUyUu/4YzGXJdNyRSZkloQS4nmb5qQZDjpnzVz+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A9dX8+iA10d5zYtc2xmitwDE4LLc512IDOHje1Aqwzk=;
 b=jxcXAXryr9EV/pZofb8tQyR2phcXeNJvRIAuYgELBt1OW3BncvxlTWFwEDbIe6UTnQo4aqLOcIi3qVP5uHSnjJECbFvdTUxHEYM13EJcA5OYOjJoa4GlZuVF1v78i3peIaiwxvdsKo45AiX8OnVGsDCTQ14QCNWuP7GH8zo0LXw=
Received: from BL1PR13CA0268.namprd13.prod.outlook.com (2603:10b6:208:2ba::33)
 by CH2PR12MB4213.namprd12.prod.outlook.com (2603:10b6:610:a4::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Fri, 13 Oct
 2023 15:17:29 +0000
Received: from BL02EPF0001A0FC.namprd03.prod.outlook.com
 (2603:10b6:208:2ba:cafe::61) by BL1PR13CA0268.outlook.office365.com
 (2603:10b6:208:2ba::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.30 via Frontend
 Transport; Fri, 13 Oct 2023 15:17:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0FC.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Fri, 13 Oct 2023 15:17:29 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 13 Oct
 2023 10:17:24 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v3 00/13] iommu/amd: SVA Support (part 3) - refactor support for GCR3 table
Date: Fri, 13 Oct 2023 15:16:39 +0000
Message-ID: <20231013151652.6008-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FC:EE_|CH2PR12MB4213:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cf8945b-be00-4bcc-6041-08dbcbff83d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Igk1UQHPb81iqWkWieiTnoCkO/LiS34Dopm8PtIx5KNALfE/tAokwE3f2td8cvrLwuTPxUxublZD8oXoBNV/z10H+9o5Xbcw4cGLL8GMe6M7e7OtCqbeRxFT8YiiceuHMk22S0kw+XqyJptrWNFu+HS0X/+bomYCw36spjPMrdNWCN3ac1HXpK32f5XPODsQmzSYidQKShz+zijjK9PWo3Ov3ak0JddMw9oekCzGfgxUzfd6TVrj4YWOrbwmgZsBVU4hvTULb8nO3IZrLZwqYHkX9ma1wTjJbNnmY739VxFF/fU85Olx/UNsyH0XlzH/6i0Y/we2cesBXobrEvpKBW5xXvgbvwC+XKFA0VGr05A6i6eWcXwztY7vf60Qh2hEXngVLvjVAooP4WvEzmfzWWaNTsoPk9yH/ahIrcObTzk4ADGnUC3N7jz0uYjJAAM4U2nTyrWugrqnb6LhvM3KWB9Ry75zA0lTRp2Bqz+6m7yz11JmDt9/SD8EcPT7GbOw7U87ENrAAIeHEMoLFQaQH9ZEuAHdjmIKDjyjue89m1tJSP7qL+AUciBI7Tw6zYzfWeP+ULhrW9Td10PRLPaWCBVIj9IHYeeqARQW4K6DsivBbOTVhvJ7Sl82VdkceUeeUKqLNHgbrCAxF/orW5rTyHaFHtZrXLaUdZam5Icu+Ubnb/3yTU3vrGLjDYeZ4oBQ939O8Xje5QMdgTPMNIZc7TKwff+q87AHTBDQDIHUCJrM5OCuUsTPG9mCuFju0AJDq+vZoF3ipcmFOwIe+RTH4HvHBJo8A6vGgvEJpxklhRU=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(39860400002)(136003)(396003)(230922051799003)(82310400011)(1800799009)(64100799003)(186009)(451199024)(46966006)(36840700001)(40470700004)(356005)(86362001)(36756003)(81166007)(41300700001)(478600001)(40480700001)(47076005)(44832011)(2906002)(8936002)(4326008)(5660300002)(966005)(82740400003)(8676002)(7696005)(6666004)(83380400001)(1076003)(336012)(426003)(40460700003)(70206006)(54906003)(70586007)(110136005)(316002)(36860700001)(2616005)(16526019)(26005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 15:17:29.1224
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cf8945b-be00-4bcc-6041-08dbcbff83d1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4213

This is part 3 of the 4-part series to introduce Share Virtual
Address (SVA) support, which focuses on refactoring GCR3 table.
This moves GCR3 related information from protection domain
structure to iommu_dev_data (per device) structure.

It contains the following enhancements:

* Patch 1 - 2:
  Cleanup and introduce helper function

* Patch 3 - 12:
  Introduce per device GCR3 table, per device domain ID, invalidation based
  on per device and code refactoring

* Patch 13:
  Remove unused variable from protection domain structure

This patch series is based on top of Improve TLB invalidation logic [1] :
  [1] https://lore.kernel.org/linux-iommu/20231006101624.5912-1-vasant.hegde@amd.com/T/#t

This is also available at github :
  https://github.com/AMDESE/linux/tree/iommu_sva_part3_v3_v6.6_rc5


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
  iommu/amd: Refactor helper function for attaching / detaching device
  iommu/amd: Refactor protection_domain helper functions
  iommu/amd: Refactor GCR3 table helper functions
  iommu/amd: Remove unused GCR3 table parameters from struct protection_domain

Vasant Hegde (5):
  iommu/amd: Pass struct iommu_dev_data to set_dte_entry()
  iommu/amd: Use protection_domain.flags to check page table mode
  iommu/amd: Introduce per-device domain ID to workaround potential TLB aliasing issue
  iommu/amd: Add support for device based flush TLB
  iommu/amd: Rearrange GCR3 table setup code

 drivers/iommu/amd/amd_iommu.h       |  27 +-
 drivers/iommu/amd/amd_iommu_types.h |  28 +-
 drivers/iommu/amd/io_pgtable_v2.c   |  21 +-
 drivers/iommu/amd/iommu.c           | 438 ++++++++++++++++++----------
 include/linux/iommu.h               |  13 +
 5 files changed, 336 insertions(+), 191 deletions(-)

-- 
2.31.1

