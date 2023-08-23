Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2077.outbound.protection.outlook.com [40.107.94.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A7AC131
	for <iommu@lists.linux.dev>; Wed, 23 Aug 2023 14:04:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YE/Sfs7n7/0QU+v3JrRrENsXHzQIU3pzvtlKt4nk6Y17HPcBIvC/3RnrbCeVQrarj9wR/vgazRl0M4XFBdKMDmNcxwCZJfx0Vc4XsMBS2MKtlFmUgx1eFJwzbt7qp6+jIe0A7QPeGlKMuGaUi7aG1LOe3hh1eNSghExAqrUhirGTr6j9wUjLejrW+0rrLmMKMqBL2Zy1wiaF2RfXumB3i6zqkp2W+Mjvc6qoJzCPc+3jKvmnoYPQ8kGffmxx+z385ofNvOovgL+RJ2L8M2/j8yOF0ME0WArx/GXhyYX7wWqG5JVolRIVVfBXAZx3XbMxD5LN7Fw8SRs/jXLEDOgjcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Flj2WOv2QvuO6HHtRYJCpruZl6yRWmhQTQs43mN45kU=;
 b=DvCMfUeGvmoJyrrCfCPJXEuykLNLDJ+QuaPD2yQLMoDk3CeLRpMAUZ4/y52Ie4wGNJfJ4ZVYDjxrar/0VGublcsHFI7YhdsCsK0PsKVOd+kqwIlUmWfXzQy1HTVetAQWmsYy1GjQyVMAEm2sWGlpSpNoO+XziW/diZqbdiwCWijGVZhCsbXMj+HtWbjiaonpeIQER5y/1ksMD9XxZ0Ppnvgs/rY3d6sDYC/YQVBP7FSXQa0RCx8PyTaEuLWWDUla1XnpT0fXemubl7G5NpwNW2PoDMgb0xMQl9gD4YcjnWrHrIUxbTdjYy9KCCKM6VzdJAHzsEGorF1iLScXuohtxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Flj2WOv2QvuO6HHtRYJCpruZl6yRWmhQTQs43mN45kU=;
 b=aPZcpRkwFSpNax/Q1lpYVD+qW+YS+TQ5mw/TvCPcO31GePvLQiIqsLS9aw2RLc8Ua1uXZVGI6Fnv6rcdWr/QdYL/IXDRSsDDFK2deI6wsbAnWNHq3f8A1Qjk3gUpzqjIlierJ7vJEJOZ0QrIBWWe4f0uZ7SCEoLxrwJbhMHJ2hY=
Received: from MW4PR03CA0354.namprd03.prod.outlook.com (2603:10b6:303:dc::29)
 by DM4PR12MB5264.namprd12.prod.outlook.com (2603:10b6:5:39c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.26; Wed, 23 Aug
 2023 14:04:50 +0000
Received: from CO1PEPF000042AE.namprd03.prod.outlook.com
 (2603:10b6:303:dc:cafe::bf) by MW4PR03CA0354.outlook.office365.com
 (2603:10b6:303:dc::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.26 via Frontend
 Transport; Wed, 23 Aug 2023 14:04:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AE.mail.protection.outlook.com (10.167.243.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Wed, 23 Aug 2023 14:04:50 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 23 Aug
 2023 09:04:47 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH RESEND 00/10] iommu/amd: SVA Support (Part 4) - SVA and IOPF
Date: Wed, 23 Aug 2023 14:04:05 +0000
Message-ID: <20230823140415.729050-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AE:EE_|DM4PR12MB5264:EE_
X-MS-Office365-Filtering-Correlation-Id: f8b5dc5d-fb6f-4e85-628a-08dba3e1ea91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	XFKdKZuHw9/CFCy5TY67V4j23S09vrzaiw1n+3wdNQgoBb5h1BNFAgaIwGfUuT4lGset2YqYrEIHrYoEUiYCSX51naSFIQ3VTuAx1Mrx0SeK1L3ha251miH1FyUxl58ntDrpJRf018dyvA9ZQ6sk3dTTJcYMCSfyd6/gMv4xobQPryiQzYdkNhX3WK2m3MaEOXSZcMx+QKizCY5e6YTkVM2jXb1MWxYUx6LR0HCTf5bT4vw/afY6u4V+2uZghh1kbuUYscZmk6cr+63yO/+mFEmFXsdkvV9f8QIEbuP+nRLwutHVUwj13Fbg53f2XJ7Jmao4NrUfYmkqMxPI0Wty/a00ayYPht0FYGLBgPaOQnM3hulQWtcLq0x+cTlYO023QrOmPr+57te49C4wVKy5d4E4Lsv8b4EUIQBLShdcZJXI57HTAiNfFUoPvyZ3kho7/dDD/u22m3G36VGR9hsJgng/JQgBPilhJ28hrz2OfvN2fdZYNHw5gGSstTEN7EEvljU0tBUcPoq9E9i86p2j7rIBjDmWNtHIBn+vwUYqoBgup+/9dWP/S+DlbRLEt9yG2F+9NVkrzKwjoW8VeGcf4QqP3Oe+Gj+zsjYyLNKTx5vwFV7s8uperYvgcQMOH7n6ai1WbOR+tdcxOMQ/X7BTfHR8qiMayqb5HOVIC0CBEesteVqz2kriCwDqnTMFsmQB9/cOMvVmqylMDxrRWIAxZV9vkQrifyODC1M99Qn8UoBHQ/5nA2McE4/q35dnT+xjzJw/bb1WEp/MpD/AIpMcF3AbCqjslQ9PO6+MXzvFZQw=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(136003)(396003)(39860400002)(346002)(451199024)(186009)(82310400011)(1800799009)(40470700004)(46966006)(36840700001)(110136005)(41300700001)(5660300002)(44832011)(2616005)(16526019)(26005)(40480700001)(316002)(2906002)(54906003)(70586007)(70206006)(478600001)(966005)(1076003)(4326008)(8676002)(8936002)(6666004)(7696005)(40460700003)(36756003)(47076005)(36860700001)(83380400001)(336012)(426003)(81166007)(86362001)(356005)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 14:04:50.0016
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f8b5dc5d-fb6f-4e85-628a-08dba3e1ea91
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042AE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5264

This is part 4 of the 4-part series to introduce Share Virtual Address
(SVA) support for devices, which can support PCI ATS, PASID and PRI
capabilities. These devices are referred to as SVA-capable devices in
this series.

It contains the following enhancements:

* Patch 1 - 2:
  Rename / add support to enable/disable features

* Patch 3 - 4:
  Introduce SVA support

* Patch 5 - 10:
  Add IOPF support

This patch series is based on top of SVA Part 3 [1].
  [1] https://lore.kernel.org/linux-iommu/20230816174031.634453-1-vasant.hegde@amd.com/

This is also available at github :
  https://github.com/AMDESE/linux/tree/iommu_sva_part4_v1_v6.5_rc1


Thank you,
Vasant / Suravee


Suravee Suthikulpanit (5):
  iommu/amd: Add support to enable/disable SVA feature
  iommu/amd: Move PPR-related functions into ppr.c
  iommu/amd: Define per-IOMMU iopf_queue
  iommu/amd: Add support for page response
  iommu/amd: Introduce logic to enable/disable IOPF

Vasant Hegde (2):
  iommu/amd: Rename amd_iommu_v2_supported() as amd_iommu_sva_supported()
  iommu/amd: Initial SVA support for AMD IOMMU

Wei Huang (3):
  iommu/amd: Add support for enabling/disabling IOMMU features
  iommu/amd: Add support for add/remove device for IOPF
  iommu/amd: Add IO page fault notifier handler

 drivers/iommu/amd/Kconfig           |   1 +
 drivers/iommu/amd/Makefile          |   2 +-
 drivers/iommu/amd/amd_iommu.h       |  41 ++-
 drivers/iommu/amd/amd_iommu_types.h |  22 ++
 drivers/iommu/amd/init.c            |  72 ++----
 drivers/iommu/amd/iommu.c           | 170 ++++++++-----
 drivers/iommu/amd/ppr.c             | 377 ++++++++++++++++++++++++++++
 drivers/iommu/amd/sva.c             | 328 ++++++++++++++++++++++++
 8 files changed, 894 insertions(+), 119 deletions(-)
 create mode 100644 drivers/iommu/amd/ppr.c
 create mode 100644 drivers/iommu/amd/sva.c

-- 
2.31.1

