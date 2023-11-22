Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2043.outbound.protection.outlook.com [40.107.223.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6013B2BE
	for <iommu@lists.linux.dev>; Wed, 22 Nov 2023 09:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Eb9+JE+B"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G9KMJ/Jki2gF6KaWBH8ILqpoV3pKBemxq06Yn/ccAdZupN8EJgYbxdhKMeFj48p3gxuHzd6YEZvQwwlDWZ9rmQMhNz91+m3992arG85imfzk79A4jfvLk2AWRzNf5NaUJf2XdO1BPdMQKUSmvgTYF/L8Hf/4+3PgtB89BnmuCuXZBYtKJaXfVD1XkJ0SlqiigVKrzbaaVtlOE8E/MWELkb/1DAARRote5RG5ZLgPTgqKVFA5g1L2SBwZld4ci49bdoUJjqb7Rz1nn2dPCTagFfYPQtlRCCkSz8iF850HtDhzL8DOdfdtNBxOpzQdkSGxyqR7oj0Px73eNbFP7qX3hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=inzuTS0i5R/Hj4eg/EmxhZY5hjBzYTTsp7xTBUcqNJs=;
 b=ImdAADl9dKOMhG71WlZKH4l0XcnQnZRPqMx72LuRzZUjCew8U32UFazZR6BFsYmzbIeVaCS/mt34sYrehatiupNFipQjghqSxE5nCl1r9ulNTNtg6XYqa3nvEVkpbt6fd8E0+r9fD9P4AJhQmgCaRr7yWP/OpHNuZgCwvUTnwIUe/IKMpciPaQC3zunrkr6a+E/vt1vHQsOf8RyY3OIKbElxZXjDC1qkONBKXcHYL38LQsmXmqC66lSDfXslTwwL3Tvr4yGBIrw0T2RSOVaP34ejLJJzDEWHr8DURDEeA9C2OeYv+DpcuOgqdFD7WE/aA5Ihyl1RB1UKfC93HdRNpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=inzuTS0i5R/Hj4eg/EmxhZY5hjBzYTTsp7xTBUcqNJs=;
 b=Eb9+JE+BgGkp25P8W4feD9NAcdQuv/Y7axtNMbYOw222ndCK2DDwqz3boXk8I04bQxcmEZt3EtLR31EmsAuyrSMdm0PYYHhwbTR2/lS8c02RicAPuGjbR1zKSkYfdGd4FpcaUW8qy61yHbj/KTA3uWWS/J+gDRRVL3skRcFpDjc=
Received: from SA9PR03CA0021.namprd03.prod.outlook.com (2603:10b6:806:20::26)
 by MN6PR12MB8542.namprd12.prod.outlook.com (2603:10b6:208:477::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.18; Wed, 22 Nov
 2023 09:02:42 +0000
Received: from SN1PEPF0002BA4D.namprd03.prod.outlook.com
 (2603:10b6:806:20:cafe::ff) by SA9PR03CA0021.outlook.office365.com
 (2603:10b6:806:20::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.28 via Frontend
 Transport; Wed, 22 Nov 2023 09:02:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF0002BA4D.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7025.12 via Frontend Transport; Wed, 22 Nov 2023 09:02:41 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 22 Nov
 2023 03:02:39 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <jgg@ziepe.ca>, Vasant Hegde
	<vasant.hegde@amd.com>
Subject: [PATCH v2 0/9] Improve TLB invalidation logic
Date: Wed, 22 Nov 2023 09:02:06 +0000
Message-ID: <20231122090215.6191-1-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4D:EE_|MN6PR12MB8542:EE_
X-MS-Office365-Filtering-Correlation-Id: 910438fd-6a80-4ac8-e342-08dbeb39c8f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	thy8ECxAGOwAcYZ6Odik4Vd+hPiHymf06379DWKfrBNA9ud5SLbwbzcIq4bHynTY1imBP9KDnWDBSXeNLl1fmDjIiglw46M2N5O9KCN+pbBJZ0XZaHmePfR2pz2k1KQWZ87lDtq20V8NshE31v3P4jqUkOtj4V0rFpSN8WHKcyZL+ZTW298XiBaH1+OqKv7ApSyWMdsHJ9dzXzFwL46ow36GfkJPCsSZanZ5qR8Upv9Q/gAV4a443yoOhuDVyUpjUsleZzj5ckzXJexGj+/dX64nHRiU0nQU06FFBMmOQMLoejpExd1Y2L4rL8sL6BzuuSZdiD9zJIGtFs/XgY4itPXaGmLye5TLCrd/T9DLYOGrEWCaVOjCGqSV7jaJFKyHds5NzofaDmr8DfOZqyAFrt9VJFpfnM8BZCGgH1tJT0+SoGbCw4foidCjhQNhj6G/AlIzRulcBpbNCkfCY4mtV12aSnwFH6bmvEIYNSGYyvxdgtu3N1uBaHtyFLY8fdj+DwefkLz9XjixgvbIgNJuWCvnWmCNlud4K36Ec1P/GsMzCsAFbxP58Pvl34yQeO7uawYIrj4eeTho2YUjnxwM0vFNqb+HCemVYjQ56HwBRGRcjfJl097JdCIxi/xorDWvn/pIsEDJQ2/0fH3GijqhFAPVWTpOpwdpohF+4/K0nf64kXD95YJES7RsxKgPRTsFrxYpj1LtqDZrYFsKvvvyh4rhuTPYQQB1quvMpB2HUMXgY2IAGCdK50008iwwKIvlQ7pA/hHJInHkYVb4FYurehpyQW/mBTIHrCWI+xiLgQI=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(136003)(376002)(346002)(230922051799003)(82310400011)(64100799003)(1800799012)(186009)(451199024)(36840700001)(46966006)(40470700004)(41300700001)(4326008)(2906002)(8676002)(36860700001)(8936002)(44832011)(16526019)(966005)(426003)(336012)(26005)(316002)(1076003)(2616005)(70586007)(110136005)(70206006)(54906003)(5660300002)(7696005)(6666004)(478600001)(83380400001)(47076005)(40480700001)(356005)(81166007)(82740400003)(86362001)(40460700003)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 09:02:41.9849
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 910438fd-6a80-4ac8-e342-08dbeb39c8f8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8542

Current code invalidates single page or entire range for the given
domain ID. IOMMU hardware supports multiple page invalidation.
This series adds support to invalidate range of pages. Also consolidate
various invalidation functions.

Note that this series doesn't add support for PASID based invalidation.
We will include necessary changes in SVA series.

Testing:
  - This series is tested with v1 and v2 page table and it works fine.

This patch series is based on top of upstream v6.7-rc2.

This is also available at github :
   https://github.com/AMDESE/linux/tree/iommu_flush_improvement_v2_v6.7_rc2

Thanks Jason for reviewing previous versions and providing valuable feedbacks.

Changes from v1 -> v2:
  - Rebased on top of v6.7-rc2
  - Based on review comments removed PASID related helper functions
  - Reworked domain_flush_pages() code path to detect/handle v2 page table flush.
  - Re-organized code made it difficult to fix __set_gcr3() code path. It
    still uses __amd_iommu_flush_tlb(). Also as part of SVA part3, we are
    reworking this code path. Hence dropped __flush_pasid() removal
    patch from this series. It will be added to SVA part3 series.
  - Dropped code re-arragement patch as I think it should be done after removing
    flush_pasid() related code. It will be added to SVA part3.


v1: https://lore.kernel.org/linux-iommu/20231006101624.5912-1-vasant.hegde@amd.com/T/#t

Thank you,
Vasant

Vasant Hegde (9):
  iommu/amd: Rename iommu_flush_all_caches() -> amd_iommu_flush_all_caches()
  iommu/amd: Remove redundant domain flush from attach_device()
  iommu/amd: Remove redundant passing of PDE bit
  iommu/amd: Add support to invalidate multiple guest pages
  iommu/amd: Refactor IOMMU tlb invalidation code
  iommu/amd: Refactor device iotlb invalidation code
  iommu/amd: Consolidate amd_iommu_domain_flush_complete() call
  iommu/amd: Make domain_flush_pages as global function
  iommu/amd/pgtbl_v2: Invalidate updated page ranges only

 drivers/iommu/amd/amd_iommu.h       |   8 +-
 drivers/iommu/amd/amd_iommu_types.h |   6 -
 drivers/iommu/amd/init.c            |   8 +-
 drivers/iommu/amd/io_pgtable.c      |   5 +-
 drivers/iommu/amd/io_pgtable_v2.c   |  10 +-
 drivers/iommu/amd/iommu.c           | 163 ++++++++++++----------------
 6 files changed, 88 insertions(+), 112 deletions(-)

-- 
2.31.1

