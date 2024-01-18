Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2061.outbound.protection.outlook.com [40.107.92.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9972BB645
	for <iommu@lists.linux.dev>; Thu, 18 Jan 2024 07:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705563253; cv=fail; b=RBgROuSjbKaF8UTkTFvL+rvTcgeZoz2v/Hgcn0su9jkvfc1ggPTXeaKnSwQ/wRSMo4IPB6bgaETzkTZd1CCqcXhAWSby3jbpBoLcSuYxkMbGdwx27c4yOuTVsnGVOF34ROrH/VKtlOkFoXtQvpjqt5PStYwKROblQTSLefe1ymM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705563253; c=relaxed/simple;
	bh=1ynk49l8PGOgbOqtfClu9RNoA1Z3uL4SwqMG+q4G9GM=;
	h=ARC-Message-Signature:ARC-Authentication-Results:DKIM-Signature:
	 Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:From:To:CC:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:Content-Type:
	 X-Originating-IP:X-ClientProxiedBy:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped; b=mCMjkYhh/JgarkzBGrE66xJNhl++AaEkz1FU1BzR353W18Rs02HiA4QVXWND7d6U+AM92P/HgOx0dxjIzShsiaSPD2h9ZWf7jLI627IsxmJkg9CmokgNS/p/aEpnq4vMSTP/+3g4KQJCO8yinMOLuuhI2ymlADzg9dLm2B5paEc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=aYa7x1UF; arc=fail smtp.client-ip=40.107.92.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="aYa7x1UF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J84HVT9km4FVClp6aG0yUchdhsFlbCeyGLK/KUAmi1dtLCruwoHrkQtXZW5NiihPGTt4SQcdidUoKEEkgNDdy9nvvJqssbZ9wfPSgFIzJ5BAeIiMTEWK58IeVVnI01KQs953FOH5p+HXx1CHD1IjSFOgX5AHpi8s3/5+FmIf0JRFJOi24VQrv2pS5swmDwpSPcN/ftpnGqL+IF5KKKtRmwFuBwtjaqQSLuvMP5jxg46+92hRqPcyI/rreE7P10MeJ33qBbNQ2WE2psaqmYP6exgVV6L5HCDjLP0ZvvnnWuXblbZZVE/l2XYzYf20Qli0NrHgjciwDAUZlP4gRVhPFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BpeFZql5tABwpOtvLUk3/kDPVHGkyZso2QUxM+62Ez4=;
 b=nP899kj70KFDd5sA6K4GX2xFiSabdsfh7h94ohKzb8gJS3U69ZvL7raVS5NX/IuscW6panm5MRkII4JOn/h4k92xPNj6uJ/sOJqJnz0lguT24IFCcUI3lDE1MUm5cmigMYc1xFPaTiedrk3zxH04RhrUCU7JwEJmEd6jHoxE7cz3Ut731g0ff/U8lZSbL6GO+QQPBTNRudNJX62tXfCrWcVdkpRW2pUEnfuFpOAFMHydQs8MCgJOnpAHu/5J8eEXdg6DRpvGhgQoAtEW1IFkE4JY4hkuhL+m1qREL4SOYp2EsEQPXuOmHOkgN1SUlHFaWg2XsLRyRvz+njEeD3Oqkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BpeFZql5tABwpOtvLUk3/kDPVHGkyZso2QUxM+62Ez4=;
 b=aYa7x1UFLkaKlE4B6k4hnxHzN4Kcrp0AEUB5XC/CRaZ8z44R308au1Gp6fuKzFLjujPXC0iOO/drV3fGndqiWQTA5vvu30F9v96wODx1LWBbdy54w2PpMNMB6zBKVgO10ZM2rUyOI3nrW/W2pj6WLB1Xek/f1GgN0eaqUq5mbsc=
Received: from SA9PR13CA0100.namprd13.prod.outlook.com (2603:10b6:806:24::15)
 by DS0PR12MB8269.namprd12.prod.outlook.com (2603:10b6:8:fd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.23; Thu, 18 Jan
 2024 07:34:08 +0000
Received: from SA2PEPF00001507.namprd04.prod.outlook.com
 (2603:10b6:806:24:cafe::1) by SA9PR13CA0100.outlook.office365.com
 (2603:10b6:806:24::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.8 via Frontend
 Transport; Thu, 18 Jan 2024 07:34:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001507.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Thu, 18 Jan 2024 07:34:08 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 18 Jan
 2024 01:34:04 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v5 00/14] iommu/amd: SVA Support (Part 4) - SVA and IOPF
Date: Thu, 18 Jan 2024 07:33:25 +0000
Message-ID: <20240118073339.6978-1-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00001507:EE_|DS0PR12MB8269:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f2aede9-f65b-43a6-ee29-08dc17f7db4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	vR/4oHJoli8J+TnOmM/SVzU+NkcpD21Ip3oic7vBvZC2Cisc1f7lb9ksF7xu7+hDFPOOVF3GGM6RBWyPm+6i4NSqwwNcOg5bf0tp29KZm/ZOUzfWxwSLQdxhjPtpqZ/wl7OnIlXb+Xd936JMHuGcZ/hrd9F+NyQvRu3wLqkIx3x1r2d7jpiU/iyQ4DUMTQPRiGMOLm0XF4rlU2oTzhANsrrNBWoQOdc10fEGVT56XsW4vOVTHY7p0EXNO27GnxDPW0gEfQ9iWpjyjLFOY5tdX5J40X/7HvtdQWo6wx0tGwCaTXwZGn32v6oAkXi98OjnXY2oS8kHu7U+2gXm9x+j+KtM/xaOrCYUoY2cxle5Hit394v3EHWAY7Fd2ThL2tGDo8IC9bLUb+sh+RF5VsPICIvFjK/TbfyulE2vWP7RFdrPj2E3q180BKXLhtzWZGo6LcSVHfvOt215pL9XOojcdEO7MlX/cWO6m6LXUpifeEfI4aCQKL/rKzqQHLMkuYQs0uuS5hBde9zQVy19yuRQtfnTSpgB5XImgaKd0uZVgn3frtb5yJh6c1L4HkgYEGZp/Yg5IiY/dNIN7QKKHquYDsQCq4QJRZk/t1UZsrSUuY53w0CDPuUczuLtXAFfK9neix2H/bJIWL9yUYtTSIHBh46kC9L7L6BmtZzFKy574xBe8fcAq9pYLBBXh5Z7L1W/59pCX3wv7JgyUW9omHgmqysaat7eZszKGpOzZcrtVon+ECUlr24L2BqHgKgVwtugxM5QpuD8+O5LKin3QTDj4MIhujP6MLv8Lp9v0n3RCns=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(396003)(39860400002)(136003)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(82310400011)(36840700001)(40470700004)(46966006)(26005)(1076003)(2616005)(36860700001)(336012)(7696005)(16526019)(6666004)(426003)(83380400001)(47076005)(8676002)(4326008)(44832011)(41300700001)(8936002)(966005)(70206006)(478600001)(316002)(110136005)(70586007)(54906003)(2906002)(5660300002)(86362001)(36756003)(81166007)(82740400003)(356005)(40480700001)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2024 07:34:08.2624
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f2aede9-f65b-43a6-ee29-08dc17f7db4a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001507.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8269

This is part 4 of the 4-part series to introduce Share Virtual Address
(SVA) support for devices, which can support PCI ATS, PASID and PRI
capabilities. These devices are referred to as SVA-capable devices in
this series.

It contains the following enhancements:

* Patch 1 - 3:
  Rename, add support to enable/disable features, update DTE etc.

* Patch 4 - 10:
  Add IOPF support

* Patch 11 - 14:
  Introduce SVA support


This patch series is based on top of SVA Part 3 v5.
  https://lore.kernel.org/linux-iommu/20240116165335.6043-1-vasant.hegde@amd.com/T/#t

Also depends on :
  1) Baolu's IOPF improvement
     https://lore.kernel.org/linux-iommu/20231220012332.168188-1-baolu.lu@linux.intel.com/

This is also available at github :
  https://github.com/AMDESE/linux/tree/iommu_sva_part4_v4_v6.7_rc8

Thanks everyone who reviewed previous version and provided valuable feedbacks.


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

Thank you,
Vasant / Suravee

Jason Gunthorpe (1):
  iommu: Add ops->domain_alloc_sva()

Suravee Suthikulpanit (5):
  iommu/amd: Move PPR-related functions into ppr.c
  iommu/amd: Define per-IOMMU iopf_queue
  iommu/amd: Add support for page response
  iommu/amd: Introduce logic to enable/disable IOPF
  iommu/amd: Add GCR3 [un]initialization function

Vasant Hegde (5):
  iommu/amd: Rename amd_iommu_v2_supported() as
    amd_iommu_pasid_supported()
  iommu/amd: Introduce per device DTE update function
  iommu/amd: Fix PPR interrupt processing logic
  iommu/amd: Initial SVA support for AMD IOMMU
  iommu/amd: Add SVA domain support

Wei Huang (3):
  iommu/amd: Add support for enabling/disabling IOMMU features
  iommu/amd: Add support for add/remove device for IOPF
  iommu/amd: Add IO page fault notifier handler

 drivers/iommu/amd/Kconfig           |   2 +
 drivers/iommu/amd/Makefile          |   2 +-
 drivers/iommu/amd/amd_iommu.h       |  51 +++-
 drivers/iommu/amd/amd_iommu_types.h |  32 +++
 drivers/iommu/amd/init.c            |  79 ++-----
 drivers/iommu/amd/iommu.c           | 190 +++++++++------
 drivers/iommu/amd/pasid.c           | 271 +++++++++++++++++++++
 drivers/iommu/amd/ppr.c             | 354 ++++++++++++++++++++++++++++
 drivers/iommu/iommu-sva.c           |  16 +-
 include/linux/iommu.h               |   3 +
 10 files changed, 858 insertions(+), 142 deletions(-)
 create mode 100644 drivers/iommu/amd/pasid.c
 create mode 100644 drivers/iommu/amd/ppr.c

-- 
2.31.1

