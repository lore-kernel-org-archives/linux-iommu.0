Return-Path: <SRS0=eAvY=NW=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D764C4320A
	for <iommu@archiver.kernel.org>; Tue, 31 Aug 2021 03:07:48 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 079FE6101C
	for <iommu@archiver.kernel.org>; Tue, 31 Aug 2021 03:07:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 079FE6101C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id ADFCD60BB1;
	Tue, 31 Aug 2021 03:07:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id p54an9eWJtfE; Tue, 31 Aug 2021 03:07:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 6BB5460B9C;
	Tue, 31 Aug 2021 03:07:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4A2DDC001A;
	Tue, 31 Aug 2021 03:07:43 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 922E7C000E
 for <iommu@lists.linux-foundation.org>; Tue, 31 Aug 2021 03:07:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 81CD5404FB
 for <iommu@lists.linux-foundation.org>; Tue, 31 Aug 2021 03:07:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7wobkoSyd5Ro for <iommu@lists.linux-foundation.org>;
 Tue, 31 Aug 2021 03:07:35 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2048.outbound.protection.outlook.com [40.107.92.48])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9EB39404F3
 for <iommu@lists.linux-foundation.org>; Tue, 31 Aug 2021 03:07:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G1SjzE4Zrs8muX78i8PXxIO1VFXoLg/XE58HYibrEyjJVJHjBeup8Ku22jU3RZ2+nSIH1DEqVoqtppBY7mjs5/6SzqMdR5C3CM7gSkNX7hfK2UF25e0ty7jIw1bIl7YdA/pxypZndIsK2mqYr4301jxaDrvbfDrWg6OC76S5OX5DHKNdFh/zDjls3Y7uzfl67F/oUkX8y9hi6+MQDchlbLukkRgsHGt3Oelcca3xd0S/coqC6Zs+82WnaVSXeO5/LE+dOPpvjO6YNHvtXxUOow/sNx8AS3mzoXUf1nHWTak1gBeMEHcir8G4bKtupX+JxD6g2sDqWAP0aODiOidpfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MmpWG5lU3Z/z1jgRSunAGrsVONnzzFHu56V3lh7ZSlE=;
 b=fgvCABcRg84/7qsz0USt1blgXUopA2U2wpbtzpJo2iTV65x/V6TLIMnvyQfYWFmaFGmpNZghvST12190pSj61yrK28PUziY91U40HHiIjarbcv7OPBKz+0I9JZpx1HKVzW/v5K6s4ZT29VbwIm0nektX95jGdHqouP8X9qCBTFwc9A2hMCRV6WVixsuE41Rvwonncc1FbDgKpmPu0AfSOSqEQvwqDYPykq9Cai5mGKOl7T5hc+Z1SzezsGAVtoNw73mF9ml7vYKJ1ldJWa5dBrVpatZX/QMSBw/AO6Yb2oIflCQApnIYDQm8H9ShFHDox9dqWNQ3Jc8jBn+MShZcbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.32) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com; 
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MmpWG5lU3Z/z1jgRSunAGrsVONnzzFHu56V3lh7ZSlE=;
 b=Hys5A8YNK8+emWSDDXiOsgnWZsF6wu2/I3kdCdV+YyI5mETE8oJ4sWhRh8DQguBGKZj2Uy17zNymStsw8dwI7YubTZQbrxgRexsdeZ0uTCBP75nColYxR5QeffIG468gdOakRCzBS5rsicjApAnXE7I+c2Uc3x3JZox+p3EnY2L3xvVecPyJ8igZACIOoydMVhQeYnshAazUeKkJxBSmOzDTA2l8Lv69R4g83erCmEoDj7RYDveQHdQPaaKFVC/mElZIQJXWv6OTlQ9grsZ8IWyPKTRWZrCY3Di1K+YtNdCMj0YbFLJHtgxh5bRuGL+zy8X0re/T0JXmeAXDaP9JQw==
Received: from BN6PR16CA0033.namprd16.prod.outlook.com (2603:10b6:405:14::19)
 by BL0PR12MB5537.namprd12.prod.outlook.com (2603:10b6:208:1cc::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.20; Tue, 31 Aug
 2021 03:07:31 +0000
Received: from BN8NAM11FT026.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:14:cafe::14) by BN6PR16CA0033.outlook.office365.com
 (2603:10b6:405:14::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.19 via Frontend
 Transport; Tue, 31 Aug 2021 03:07:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.32)
 smtp.mailfrom=nvidia.com; huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.32 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.32; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.32) by
 BN8NAM11FT026.mail.protection.outlook.com (10.13.177.51) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4457.17 via Frontend Transport; Tue, 31 Aug 2021 03:07:30 +0000
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 30 Aug
 2021 20:07:29 -0700
Received: from Asurada-Nvidia.nvidia.com (172.20.187.5) by mail.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 31 Aug 2021 03:07:29 +0000
To: <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
 <alex.williamson@redhat.com>, <cohuck@redhat.com>, <corbet@lwn.net>
Subject: [RFC][PATCH v2 00/13] iommu/arm-smmu-v3: Add NVIDIA implementation
Date: Mon, 30 Aug 2021 19:59:10 -0700
Message-ID: <20210831025923.15812-1-nicolinc@nvidia.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8c9a6db2-7cb6-499c-410a-08d96c2c78a2
X-MS-TrafficTypeDiagnostic: BL0PR12MB5537:
X-Microsoft-Antispam-PRVS: <BL0PR12MB5537144866A2857CD282CCE5ABCC9@BL0PR12MB5537.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uF4cJC4HyIDZ9di4TBzk+OTY5iBsxQaY6OnepMZ8TQ2aA5oeyAWDn1VeFV2nXkvpgnncvhSX2m2yF7QwIApMc6RCblYAaShEeDTlZ4jTnKsmVEKZPiQufgBt0tnW0gR3j1TDVnGotkn72VAv33T9AGw0blTFdh0gt0VtFutI7+rBdLUlCRIgVFXYVeur793f8S7f1MRf7AxBCqeDz9gQwKU9uA2RIT1avX1UWUd6sp5aJR3iO2o158vmm+mgTuumaXR7EAJNJqHmWQCy+sBTpT4KCbLNRTGEsD9vqqhneiBE5wUamzHtbHh6u8OWbS6T+UHdn9B6QqCPl79yr0zo+F+9ypHeOLrfCjF/EVk/RpKThl5zGWXXhvTzZFwG+HwcUGqu9g2qnUVerCO8BORNqFEqHkLFc2wiiZ0yDEJKZ66DH3JNWqaraKDWSRRTJq2KJ9H+GYmk8odRO1nHCZfrLBrDh8R5FQXbd3pZ2J5F94P3VpRDP5Mnj3sH0A5Ws7ooH3YcvkE+NOVi5ODQogY8tmrfX7w07GDpoeL0HtLXH9S1eeAMREOiL5FUz10C+nWKEsr9ucEZi1hxhrQgNLUVFXCQMiaBwQ6jd2uCaUN6T3RIkUk/rsUyIyuKlnV0qiNsbBT1U7NAfI0hm7PyG3eulG/R0RNknetRoRIcOKL+ci+l8UBhVI3/5bGtWywKMrGElSus8K3yZLdc6SVB2uwx+iugQwj0s2q+Hls8a+JpwxytdSfctvacd8ETWi0dyDoGC3MkrbyQAkPFWDP3FOH7reypBvA8gHVp0fx0sZTEpQIa8nl4Khu/DNFLJp7KLWZF
X-Forefront-Antispam-Report: CIP:216.228.112.32; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid01.nvidia.com; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(110136005)(966005)(36860700001)(508600001)(26005)(82310400003)(83380400001)(4326008)(70206006)(356005)(8676002)(5660300002)(6666004)(2616005)(86362001)(54906003)(316002)(186003)(1076003)(36756003)(336012)(70586007)(7636003)(2906002)(7416002)(426003)(8936002)(47076005)(7696005)(2101003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2021 03:07:30.6257 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c9a6db2-7cb6-499c-410a-08d96c2c78a2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.32];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT026.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5537
Cc: jean-philippe@linaro.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 thierry.reding@gmail.com, linux-tegra@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
From: Nicolin Chen via iommu <iommu@lists.linux-foundation.org>
Reply-To: Nicolin Chen <nicolinc@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

The SMMUv3 devices implemented in the Grace SoC support NVIDIA's custom
CMDQ-Virtualization (CMDQV) hardware. Like the new ECMDQ feature first
introduced in the ARM SMMUv3.3 specification, CMDQV adds multiple VCMDQ
interfaces to supplement the single architected SMMU_CMDQ in an effort
to reduce contention.

This series of patches add CMDQV support with its preparational changes:

* PATCH-1 to PATCH-8 are related to shared VMID feature: they are used
  first to improve TLB utilization, second to bind a shared VMID with a
  VCMDQ interface for hardware configuring requirement.

* PATCH-9 and PATCH-10 are to accommodate the NVIDIA implementation with
  the existing arm-smmu-v3 driver.

* PATCH-11 borrows the "implementation infrastructure" from the arm-smmu
  driver so later change can build upon it.

* PATCH-12 adds an initial NVIDIA implementation related to host feature,
  and also adds implementation specific ->device_reset() and ->get_cmdq()
  callback functions.

* PATCH-13 adds virtualization features using VFIO mdev interface, which
  allows user space hypervisor to map and get access to one of the VCMDQ
  interfaces of CMDQV module.

( Thinking that reviewers can get a better view of this implementation,
  I am attaching QEMU changes here for reference purpose:
      https://github.com/nicolinc/qemu/commits/dev/cmdqv_v6.0.0-rc2
  The branch has all preparational changes, while I'm still integrating
  device model and ARM-VIRT changes, and will push them these two days,
  although they might not be in a good shape of being sent to review yet )

Above all, I marked RFC for this series, as I feel that we may come up
some better solution. So please kindly share your reviews and insights.

Thank you!

Changelog
v1->v2:
 * Added mdev interface support for hypervisor and VMs.
 * Added preparational changes for mdev interface implementation.
 * PATCH-12 Changed ->issue_cmdlist() to ->get_cmdq() for a better
   integration with recently merged ECMDQ-related changes.

Nate Watterson (3):
  iommu/arm-smmu-v3: Add implementation infrastructure
  iommu/arm-smmu-v3: Add support for NVIDIA CMDQ-Virtualization hw
  iommu/nvidia-smmu-v3: Add mdev interface support

Nicolin Chen (10):
  iommu: Add set_nesting_vmid/get_nesting_vmid functions
  vfio: add VFIO_IOMMU_GET_VMID and VFIO_IOMMU_SET_VMID
  vfio: Document VMID control for IOMMU Virtualization
  vfio: add set_vmid and get_vmid for vfio_iommu_type1
  vfio/type1: Implement set_vmid and get_vmid
  vfio/type1: Set/get VMID to/from iommu driver
  iommu/arm-smmu-v3: Add shared VMID support for NESTING
  iommu/arm-smmu-v3: Add VMID alloc/free helpers
  iommu/arm-smmu-v3: Pass dev pointer to arm_smmu_detach_dev
  iommu/arm-smmu-v3: Pass cmdq pointer in arm_smmu_cmdq_issue_cmdlist()

 Documentation/driver-api/vfio.rst             |   34 +
 MAINTAINERS                                   |    2 +
 drivers/iommu/arm/arm-smmu-v3/Makefile        |    2 +-
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-impl.c  |   15 +
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |  121 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |   18 +
 .../iommu/arm/arm-smmu-v3/nvidia-smmu-v3.c    | 1249 +++++++++++++++++
 drivers/iommu/iommu.c                         |   20 +
 drivers/vfio/vfio.c                           |   25 +
 drivers/vfio/vfio_iommu_type1.c               |   37 +
 include/linux/iommu.h                         |    5 +
 include/linux/vfio.h                          |    2 +
 include/uapi/linux/vfio.h                     |   26 +
 13 files changed, 1537 insertions(+), 19 deletions(-)
 create mode 100644 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-impl.c
 create mode 100644 drivers/iommu/arm/arm-smmu-v3/nvidia-smmu-v3.c

-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
