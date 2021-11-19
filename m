Return-Path: <SRS0=KWJS=QG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8092BC4332F
	for <iommu@archiver.kernel.org>; Fri, 19 Nov 2021 07:27:49 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A4FE61AFB
	for <iommu@archiver.kernel.org>; Fri, 19 Nov 2021 07:27:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3A4FE61AFB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E81B7409B7;
	Fri, 19 Nov 2021 07:27:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id q-F6G6KZHLTz; Fri, 19 Nov 2021 07:27:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 20896409AD;
	Fri, 19 Nov 2021 07:27:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EF5F1C002E;
	Fri, 19 Nov 2021 07:27:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 96750C0012
 for <iommu@lists.linux-foundation.org>; Fri, 19 Nov 2021 07:27:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 76BF781CAD
 for <iommu@lists.linux-foundation.org>; Fri, 19 Nov 2021 07:27:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BtxzAr-XcDN4 for <iommu@lists.linux-foundation.org>;
 Fri, 19 Nov 2021 07:27:41 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2081.outbound.protection.outlook.com [40.107.94.81])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B936C81C56
 for <iommu@lists.linux-foundation.org>; Fri, 19 Nov 2021 07:27:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bmUhppMY/Vre4LWbhXft0ZHYT+Hp9F9sx4XuSf/Lyjk1aO+/AAQM4l7AFA16ZeoP6s6OKo2B8XvlgO7x5LcBY4QxR42KOD1b7D9OcZTFq9XybnIeZVyGcJapAS1d6P4uZl5VgMFZn2USBd4m4MqoprEO4j/9ubvf4EVRJ6/6fswLyVI4vlCtMIwFiSxmVFHrEnkDIYS2ERC+jcOXSNg1mLKj4GJfYVCW0SBuOFZfMzu/egVttPqI34mwr6zn36o2hpD4RQGTH0gVRdzQl6aBAaNA7r2jta7QiowPMYfOlOtPcwWsT92JHoAKmHOLkz+7i6Hi/3vh6s8KpDanAVKtWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iWxjoXw0evaRr6lqTRZyGZVAYAp4Wey+Heeu1jQzDA0=;
 b=WF5rRul8ztR/j05fabAy3gFtbEb2566bBNpsRCTEFTKkdsfVqfhnjL+52btQ5zfMksKT2PEVTlPMhuJnk5YU+2sw1TrmnH4yhEJzjVGnREptj94rpFAf0dVtia51qOYn4FWDBzWlNsw2Z/JwPFwHH1Vvc2W9qiapkyiHFi8ai2WKeKSTG8SwBNA0bclqAS+r9tTxMJn7aWcdlahIZPaCYTBkqtBe7TPssP41AjAGCDrdEsph7nxRILC7OPJlCQlMfo2SaEGre8hqzEkPNUppbEBfBdk3wnCxaOQxeryRtwPTaF5+oWEasV4v1jIUKM3OnqjiZysq+4YPoL9b5E45Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.36) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iWxjoXw0evaRr6lqTRZyGZVAYAp4Wey+Heeu1jQzDA0=;
 b=me3bC2FbhJoqJBRhI8rFI11k4z+ZILPg0OwkaFGNswemGykQFyhSlS9CE3mAPRcGCi5869259CwcLb3BoI/+UMIsIwfIa+V6PitbFBdTZdad9RD/Wtb7zaNtzQBNBr8995Ac33xRcG4MBuh1i3BRcRzrWxfwy5IYiTlCTEqqCutJPOhp9O+DtCXFnHf4X/XA/NAfIJMRVbloweVzz8O5S9BOvlq7Azjakgt3BzXPmAf0bOZB8HioP5IzHjTLNgEYqnTrE/O0sHaK9F9zspbY3ivfQbXcmMPSU9ZtIsXv2TbfbtvDLdLN8zH+k53crCagkcPEY6uBgVoXbFS0pjpkFQ==
Received: from DM6PR08CA0062.namprd08.prod.outlook.com (2603:10b6:5:1e0::36)
 by DM6PR12MB4879.namprd12.prod.outlook.com (2603:10b6:5:1b5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Fri, 19 Nov
 2021 07:27:38 +0000
Received: from DM6NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1e0:cafe::26) by DM6PR08CA0062.outlook.office365.com
 (2603:10b6:5:1e0::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19 via Frontend
 Transport; Fri, 19 Nov 2021 07:27:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.36)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.36 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.36; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.36) by
 DM6NAM11FT068.mail.protection.outlook.com (10.13.173.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4713.20 via Frontend Transport; Fri, 19 Nov 2021 07:27:38 +0000
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Fri, 19 Nov
 2021 07:27:36 +0000
Received: from Asurada-Nvidia.nvidia.com (172.20.187.6) by mail.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Fri, 19 Nov 2021 07:27:36 +0000
To: <joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>
Subject: [PATCH v3 4/5] iommu/arm-smmu-v3: Add host support for NVIDIA Grace
 CMDQ-V
Date: Thu, 18 Nov 2021 23:19:58 -0800
Message-ID: <20211119071959.16706-5-nicolinc@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211119071959.16706-1-nicolinc@nvidia.com>
References: <20211119071959.16706-1-nicolinc@nvidia.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 185b7249-ccc7-4f90-481f-08d9ab2e106c
X-MS-TrafficTypeDiagnostic: DM6PR12MB4879:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4879E386AA3C0778B1F2A839AB9C9@DM6PR12MB4879.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hCm+fgFtu38T3JZWNRf+u/F0iuc3wgSLnDfKbd0f7QHqR9iTpKGkkQLrzymNr94zF+gpjiOnEPL5NOVEXibQDxrAR1etqihaOumMr5flu7ZS4JDy4yIHogOYTjA1N6DJAc/xg/iZqR6HhhkiOxTxjJVDPx/cGQ6AehzsV+8couYwrgHdUCDfPqWtCGMfNYUVAS0dAJsBTcr92FOquBphiM99STvnzGJF4nXOcrqnWByaUChMQGEIHgBg3R6Kgmz7sVDKYgbBPbFx8YZ4C2NNnftOnVzwMse5Dk4jHhFNsGYyfHF20sGx+AOr9koix6RE9pWzl71NMuVgO5cfJD1r36gZr0PcsJoxBr5o+FYOpeQyr4yQec5gWqC/GCxt0E17+nfx7wjF1ykoK3J78RL7vpog3gKN04M2OfPBzPG75hdUO54Y5W9i8izQ+NdVD/NUUjPOfSvMoiUaLZmqWY66y1Ivv6j+2sLtNj+YjNODoKJVegfk3o2f2hlrLTxZ8Z/JbylKGUquo5wSsg1gFCjhVScQyJI+cJWXAJG/s9ugVRSXCVpjO6FYtbqa0cHCwALRZS+WRGvWnqVutZrz2F1h4lAOa64C08LFXV2AFBqtDjNGwfyr6vdDleOaiW0fjQ+fU9tdlE+dzG25klXqnI6kTcQJfCtofO/IIW1KQW6nOsX/Rv6k0xxMptTamPdS1RlIVnij34byIp7NfHj9U/F6ew==
X-Forefront-Antispam-Report: CIP:216.228.112.36; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid05.nvidia.com; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(110136005)(2906002)(82310400003)(86362001)(7696005)(356005)(54906003)(107886003)(6666004)(83380400001)(4326008)(26005)(316002)(30864003)(7416002)(186003)(70586007)(336012)(70206006)(36906005)(426003)(2616005)(7636003)(5660300002)(508600001)(36756003)(8676002)(47076005)(1076003)(36860700001)(8936002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2021 07:27:38.0443 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 185b7249-ccc7-4f90-481f-08d9ab2e106c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.36];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4879
Cc: jean-philippe@linaro.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, linux-tegra@vger.kernel.org,
 thierry.reding@gmail.com, jgg@nvidia.com, linux-arm-kernel@lists.infradead.org
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

From: Nate Watterson <nwatterson@nvidia.com>

NVIDIA's Grace Soc has a CMDQ-Virtualization (CMDQV) hardware,
which extends the standard ARM SMMU v3 IP to support multiple
VCMDQs with virtualization capabilities. In-kernel of host OS,
they're used to reduce contention on a single queue. In terms
of command queue, they are very like the standard CMDQ/ECMDQs,
but only support CS_NONE in the CS field of CMD_SYNC command.

This patch adds a new nvidia-grace-cmdqv file and inserts its
structure pointer into the existing arm_smmu_device, and then
adds related function calls in the arm-smmu-v3 driver.

In the CMDQV driver itself, this patch only adds minimal part
for host kernel support. Upon probe(), VINTF0 is reserved for
in-kernel use. And some of the VCMDQs are assigned to VINTF0.
Then the driver will select one of VCMDQs in the VINTF0 based
on the CPU currently executing, to issue commands.

Note that for the current plan the CMDQV driver only supports
ACPI configuration.

Signed-off-by: Nate Watterson <nwatterson@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
Changelog:
v2->v3:
 * Replaced impl design with simpler "nvidia_grace_cmdqv" pointer
 * Aligned all the namings to "nvidia_grace_cmdqv" or "cmdqv"
 * Changed VINTF_ENABLED check in get_cmdq() to VINTF_STATUS
 * Dropped overrides at smmu->features and smmu->options
 * Inlined hw_probe() to acpi_probe() for simplification
 * Added a new CMDQV CONFIG depending on CONFIG_ACPI
 * Removed additional platform_device involvement
 * Switched krealloc to kzalloc for cmdqv Pointer
 * Moved devm_request_irq() out of device_reset()
 * Dropped IRQF_SHARED flag at devm_request_irq()
 * Reused acpi_iort_node pointer from SMMU driver
 * Reused existing smmu functions to init vcmdqs
 * Changed writel_relaxed to writel to be safe
 * Removed pointless comments and prints
 * Updated Copyright lines

 MAINTAINERS                                   |   1 +
 drivers/iommu/Kconfig                         |  12 +
 drivers/iommu/arm/arm-smmu-v3/Makefile        |   1 +
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |  21 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  41 ++
 .../arm/arm-smmu-v3/nvidia-grace-cmdqv.c      | 418 ++++++++++++++++++
 6 files changed, 488 insertions(+), 6 deletions(-)
 create mode 100644 drivers/iommu/arm/arm-smmu-v3/nvidia-grace-cmdqv.c

diff --git a/MAINTAINERS b/MAINTAINERS
index f32c7d733255..0314ee1edf62 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18726,6 +18726,7 @@ M:	Thierry Reding <thierry.reding@gmail.com>
 R:	Krishna Reddy <vdumpa@nvidia.com>
 L:	linux-tegra@vger.kernel.org
 S:	Supported
+F:	drivers/iommu/arm/arm-smmu-v3/nvidia-grace-cmdqv.c
 F:	drivers/iommu/arm/arm-smmu/arm-smmu-nvidia.c
 F:	drivers/iommu/tegra*
 
diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index 3eb68fa1b8cc..290af9c7b2a5 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -388,6 +388,18 @@ config ARM_SMMU_V3_SVA
 	  Say Y here if your system supports SVA extensions such as PCIe PASID
 	  and PRI.
 
+config NVIDIA_GRACE_CMDQV
+	bool "NVIDIA Grace CMDQ-V extension support for ARM SMMUv3"
+	depends on ARM_SMMU_V3
+	depends on ACPI
+	help
+	  Support for NVIDIA Grace CMDQ-Virtualization extension for ARM SMMUv3.
+	  The CMDQ-V extension is similar to v3.3 ECMDQ for multi command queues
+	  support, except with virtualization capabilities.
+
+	  Say Y here if your system is NVIDIA Grace or it has the same CMDQ-V
+	  extension.
+
 config S390_IOMMU
 	def_bool y if S390 && PCI
 	depends on S390 && PCI
diff --git a/drivers/iommu/arm/arm-smmu-v3/Makefile b/drivers/iommu/arm/arm-smmu-v3/Makefile
index 54feb1ecccad..a083019de68a 100644
--- a/drivers/iommu/arm/arm-smmu-v3/Makefile
+++ b/drivers/iommu/arm/arm-smmu-v3/Makefile
@@ -2,4 +2,5 @@
 obj-$(CONFIG_ARM_SMMU_V3) += arm_smmu_v3.o
 arm_smmu_v3-objs-y += arm-smmu-v3.o
 arm_smmu_v3-objs-$(CONFIG_ARM_SMMU_V3_SVA) += arm-smmu-v3-sva.o
+arm_smmu_v3-objs-$(CONFIG_NVIDIA_GRACE_CMDQV) += nvidia-grace-cmdqv.o
 arm_smmu_v3-objs := $(arm_smmu_v3-objs-y)
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 188865ec9a33..b1182dd825fd 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -339,6 +339,9 @@ static int arm_smmu_cmdq_build_cmd(u64 *cmd, struct arm_smmu_cmdq_ent *ent)
 
 static struct arm_smmu_cmdq *arm_smmu_get_cmdq(struct arm_smmu_device *smmu)
 {
+	if (smmu->nvidia_grace_cmdqv)
+		return nvidia_grace_cmdqv_get_cmdq(smmu);
+
 	return &smmu->cmdq;
 }
 
@@ -2874,12 +2877,10 @@ static struct iommu_ops arm_smmu_ops = {
 };
 
 /* Probing and initialisation functions */
-static int arm_smmu_init_one_queue(struct arm_smmu_device *smmu,
-				   struct arm_smmu_queue *q,
-				   void __iomem *page,
-				   unsigned long prod_off,
-				   unsigned long cons_off,
-				   size_t dwords, const char *name)
+int arm_smmu_init_one_queue(struct arm_smmu_device *smmu,
+			    struct arm_smmu_queue *q, void __iomem *page,
+			    unsigned long prod_off, unsigned long cons_off,
+			    size_t dwords, const char *name)
 {
 	size_t qsz;
 
@@ -3438,6 +3439,12 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu, bool bypass)
 		return ret;
 	}
 
+	if (smmu->nvidia_grace_cmdqv) {
+		ret = nvidia_grace_cmdqv_device_reset(smmu);
+		if (ret)
+			return ret;
+	}
+
 	return 0;
 }
 
@@ -3686,6 +3693,8 @@ static int arm_smmu_device_acpi_probe(struct platform_device *pdev,
 	if (iort_smmu->flags & ACPI_IORT_SMMU_V3_COHACC_OVERRIDE)
 		smmu->features |= ARM_SMMU_FEAT_COHERENCY;
 
+	smmu->nvidia_grace_cmdqv = nvidia_grace_cmdqv_acpi_probe(smmu, node);
+
 	return 0;
 }
 #else
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 475f004ccbe4..24f93444aeeb 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -619,6 +619,8 @@ struct arm_smmu_strtab_cfg {
 	u32				strtab_base_cfg;
 };
 
+struct nvidia_grace_cmdqv;
+
 /* An SMMUv3 instance */
 struct arm_smmu_device {
 	struct device			*dev;
@@ -679,6 +681,12 @@ struct arm_smmu_device {
 
 	struct rb_root			streams;
 	struct mutex			streams_mutex;
+
+	/*
+	 * Pointer to NVIDIA Grace CMDQ-Virtualization Extension support,
+	 * similar to v3.3 ECMDQ except with virtualization capabilities.
+	 */
+	struct nvidia_grace_cmdqv	*nvidia_grace_cmdqv;
 };
 
 struct arm_smmu_stream {
@@ -753,6 +761,10 @@ int arm_smmu_atc_inv_domain(struct arm_smmu_domain *smmu_domain, int ssid,
 			    unsigned long iova, size_t size);
 int arm_smmu_cmdq_init(struct arm_smmu_device *smmu,
 		       struct arm_smmu_cmdq *cmdq);
+int arm_smmu_init_one_queue(struct arm_smmu_device *smmu,
+			    struct arm_smmu_queue *q, void __iomem *page,
+			    unsigned long prod_off, unsigned long cons_off,
+			    size_t dwords, const char *name);
 
 #ifdef CONFIG_ARM_SMMU_V3_SVA
 bool arm_smmu_sva_supported(struct arm_smmu_device *smmu);
@@ -812,4 +824,33 @@ static inline u32 arm_smmu_sva_get_pasid(struct iommu_sva *handle)
 
 static inline void arm_smmu_sva_notifier_synchronize(void) {}
 #endif /* CONFIG_ARM_SMMU_V3_SVA */
+
+struct acpi_iort_node;
+
+#ifdef CONFIG_NVIDIA_GRACE_CMDQV
+struct nvidia_grace_cmdqv *
+nvidia_grace_cmdqv_acpi_probe(struct arm_smmu_device *smmu,
+			      struct acpi_iort_node *node);
+int nvidia_grace_cmdqv_device_reset(struct arm_smmu_device *smmu);
+struct arm_smmu_cmdq *nvidia_grace_cmdqv_get_cmdq(struct arm_smmu_device *smmu);
+#else /* CONFIG_NVIDIA_GRACE_CMDQV */
+static inline struct nvidia_grace_cmdqv *
+nvidia_grace_cmdqv_acpi_probe(struct arm_smmu_device *smmu,
+			      struct acpi_iort_node *node)
+{
+	return NULL;
+}
+
+static inline int nvidia_grace_cmdqv_device_reset(struct arm_smmu_device *smmu)
+{
+	return -ENODEV;
+}
+
+static inline struct arm_smmu_cmdq *
+nvidia_grace_cmdqv_get_cmdq(struct arm_smmu_device *smmu)
+{
+	return NULL;
+}
+#endif /* CONFIG_NVIDIA_GRACE_CMDQV */
+
 #endif /* _ARM_SMMU_V3_H */
diff --git a/drivers/iommu/arm/arm-smmu-v3/nvidia-grace-cmdqv.c b/drivers/iommu/arm/arm-smmu-v3/nvidia-grace-cmdqv.c
new file mode 100644
index 000000000000..c0d7351f13e2
--- /dev/null
+++ b/drivers/iommu/arm/arm-smmu-v3/nvidia-grace-cmdqv.c
@@ -0,0 +1,418 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (C) 2021 NVIDIA CORPORATION & AFFILIATES */
+
+#define dev_fmt(fmt) "nvidia_grace_cmdqv: " fmt
+
+#include <linux/acpi.h>
+#include <linux/dma-mapping.h>
+#include <linux/interrupt.h>
+#include <linux/iommu.h>
+#include <linux/iopoll.h>
+
+#include <acpi/acpixf.h>
+
+#include "arm-smmu-v3.h"
+
+#define NVIDIA_CMDQV_HID		"NVDA0600"
+
+/* CMDQV register page base and size defines */
+#define NVIDIA_CMDQV_CONFIG_BASE	(0)
+#define NVIDIA_CMDQV_CONFIG_SIZE	(SZ_64K)
+#define NVIDIA_VCMDQ_BASE		(0 + SZ_64K)
+#define NVIDIA_VCMDQ_SIZE		(SZ_64K * 2) /* PAGE0 and PAGE1 */
+
+/* CMDQV global config regs */
+#define NVIDIA_CMDQV_CONFIG		0x0000
+#define  CMDQV_EN			BIT(0)
+
+#define NVIDIA_CMDQV_PARAM		0x0004
+#define  CMDQV_NUM_VINTF_LOG2		GENMASK(11, 8)
+#define  CMDQV_NUM_VCMDQ_LOG2		GENMASK(7, 4)
+
+#define NVIDIA_CMDQV_STATUS		0x0008
+#define  CMDQV_STATUS			GENMASK(2, 1)
+#define  CMDQV_ENABLED			BIT(0)
+
+#define NVIDIA_CMDQV_VINTF_ERR_MAP	0x000C
+#define NVIDIA_CMDQV_VINTF_INT_MASK	0x0014
+#define NVIDIA_CMDQV_VCMDQ_ERR_MAP	0x001C
+
+#define NVIDIA_CMDQV_CMDQ_ALLOC(q)	(0x0200 + 0x4*(q))
+#define  CMDQV_CMDQ_ALLOC_VINTF		GENMASK(20, 15)
+#define  CMDQV_CMDQ_ALLOC_LVCMDQ	GENMASK(7, 1)
+#define  CMDQV_CMDQ_ALLOCATED		BIT(0)
+
+/* VINTF config regs */
+#define NVIDIA_CMDQV_VINTF(v)		(0x1000 + 0x100*(v))
+
+#define NVIDIA_VINTF_CONFIG		0x0000
+#define  VINTF_HYP_OWN			BIT(17)
+#define  VINTF_VMID			GENMASK(16, 1)
+#define  VINTF_EN			BIT(0)
+
+#define NVIDIA_VINTF_STATUS		0x0004
+#define  VINTF_STATUS			GENMASK(3, 1)
+#define  VINTF_ENABLED			BIT(0)
+
+/* VCMDQ config regs */
+/* -- PAGE0 -- */
+#define NVIDIA_CMDQV_VCMDQ(q)		(NVIDIA_VCMDQ_BASE + 0x80*(q))
+
+#define NVIDIA_VCMDQ_CONS		0x00000
+#define  VCMDQ_CONS_ERR			GENMASK(30, 24)
+
+#define NVIDIA_VCMDQ_PROD		0x00004
+
+#define NVIDIA_VCMDQ_CONFIG		0x00008
+#define  VCMDQ_EN			BIT(0)
+
+#define NVIDIA_VCMDQ_STATUS		0x0000C
+#define  VCMDQ_ENABLED			BIT(0)
+
+#define NVIDIA_VCMDQ_GERROR		0x00010
+#define NVIDIA_VCMDQ_GERRORN		0x00014
+
+/* -- PAGE1 -- */
+#define NVIDIA_VCMDQ_BASE_L(q)		(NVIDIA_CMDQV_VCMDQ(q) + SZ_64K)
+#define  VCMDQ_ADDR			GENMASK(47, 5)
+#define  VCMDQ_LOG2SIZE			GENMASK(4, 0)
+
+struct nvidia_grace_cmdqv_vintf {
+	u16			idx;
+	u32			cfg;
+	u32			status;
+
+	void __iomem		*base;
+	struct arm_smmu_cmdq	*vcmdqs;
+};
+
+struct nvidia_grace_cmdqv {
+	struct arm_smmu_device	*smmu;
+
+	struct device		*dev;
+	struct resource		*res;
+	void __iomem		*base;
+	int			irq;
+
+	/* CMDQV Hardware Params */
+	u16			num_total_vintfs;
+	u16			num_total_vcmdqs;
+	u16			num_vcmdqs_per_vintf;
+
+	/* CMDQV_VINTF(0) reserved for host kernel use */
+	struct nvidia_grace_cmdqv_vintf vintf0;
+};
+
+static irqreturn_t nvidia_grace_cmdqv_isr(int irq, void *devid)
+{
+	struct nvidia_grace_cmdqv *cmdqv = (struct nvidia_grace_cmdqv *)devid;
+	struct nvidia_grace_cmdqv_vintf *vintf0 = &cmdqv->vintf0;
+	u32 vintf_err_map[2];
+	u32 vcmdq_err_map[4];
+
+	vintf_err_map[0] = readl_relaxed(cmdqv->base + NVIDIA_CMDQV_VINTF_ERR_MAP);
+	vintf_err_map[1] = readl_relaxed(cmdqv->base + NVIDIA_CMDQV_VINTF_ERR_MAP + 0x4);
+
+	vcmdq_err_map[0] = readl_relaxed(cmdqv->base + NVIDIA_CMDQV_VCMDQ_ERR_MAP);
+	vcmdq_err_map[1] = readl_relaxed(cmdqv->base + NVIDIA_CMDQV_VCMDQ_ERR_MAP + 0x4);
+	vcmdq_err_map[2] = readl_relaxed(cmdqv->base + NVIDIA_CMDQV_VCMDQ_ERR_MAP + 0x8);
+	vcmdq_err_map[3] = readl_relaxed(cmdqv->base + NVIDIA_CMDQV_VCMDQ_ERR_MAP + 0xC);
+
+	dev_warn(cmdqv->dev,
+		 "unexpected cmdqv error reported: vintf_map %08X %08X, vcmdq_map %08X %08X %08X %08X\n",
+		 vintf_err_map[0], vintf_err_map[1], vcmdq_err_map[0], vcmdq_err_map[1],
+		 vcmdq_err_map[2], vcmdq_err_map[3]);
+
+	/* If the error was reported by vintf0, avoid using any of its VCMDQs */
+	if (vintf_err_map[vintf0->idx / 32] & (1 << (vintf0->idx % 32))) {
+		vintf0->status = readl_relaxed(vintf0->base + NVIDIA_VINTF_STATUS);
+
+		dev_warn(cmdqv->dev, "error (0x%lX) reported by host vintf0 - disabling its vcmdqs\n",
+			 FIELD_GET(VINTF_STATUS, vintf0->status));
+	} else if (vintf_err_map[0] || vintf_err_map[1]) {
+		dev_err(cmdqv->dev, "cmdqv error interrupt triggered by unassigned vintf!\n");
+	}
+
+	return IRQ_HANDLED;
+}
+
+/* Adapt struct arm_smmu_cmdq init sequences from arm-smmu-v3.c for VCMDQs */
+static int nvidia_grace_cmdqv_init_one_vcmdq(struct nvidia_grace_cmdqv *cmdqv,
+					     struct arm_smmu_cmdq *cmdq,
+					     void __iomem *vcmdq_base, u16 qidx)
+{
+	struct arm_smmu_queue *q = &cmdq->q;
+	char name[16];
+	int ret;
+
+	sprintf(name, "vcmdq%u", qidx);
+
+	q->llq.max_n_shift = ilog2(SZ_64K >> CMDQ_ENT_SZ_SHIFT);
+
+	/* Use the common helper to init the VCMDQ, and then... */
+	ret = arm_smmu_init_one_queue(cmdqv->smmu, q, vcmdq_base,
+				      NVIDIA_VCMDQ_PROD, NVIDIA_VCMDQ_CONS,
+				      CMDQ_ENT_DWORDS, name);
+	if (ret)
+		return ret;
+
+	/* ...override q_base for VCMDQ_BASE_L/H registers */
+	q->q_base  = q->base_dma & VCMDQ_ADDR;
+	q->q_base |= FIELD_PREP(VCMDQ_LOG2SIZE, q->llq.max_n_shift);
+
+	/* All VCMDQs support CS_NONE only for CMD_SYNC */
+	q->quirks = CMDQ_QUIRK_SYNC_CS_NONE_ONLY;
+
+	return arm_smmu_cmdq_init(cmdqv->smmu, cmdq);
+}
+
+struct arm_smmu_cmdq *nvidia_grace_cmdqv_get_cmdq(struct arm_smmu_device *smmu)
+{
+	struct nvidia_grace_cmdqv *cmdqv = smmu->nvidia_grace_cmdqv;
+	struct nvidia_grace_cmdqv_vintf *vintf0 = &cmdqv->vintf0;
+	u16 qidx;
+
+	/* Check error status of vintf0 */
+	if (!FIELD_GET(VINTF_STATUS, vintf0->status))
+		return &smmu->cmdq;
+
+	/*
+	 * Select a vcmdq to use. Here we use a temporal solution to
+	 * balance out traffic on cmdq issuing: each cmdq has its own
+	 * lock, if all cpus issue cmdlist using the same cmdq, only
+	 * one CPU at a time can enter the process, while the others
+	 * will be spinning at the same lock.
+	 */
+	qidx = smp_processor_id() % cmdqv->num_vcmdqs_per_vintf;
+	return &vintf0->vcmdqs[qidx];
+}
+
+int nvidia_grace_cmdqv_device_reset(struct arm_smmu_device *smmu)
+{
+	struct nvidia_grace_cmdqv *cmdqv = smmu->nvidia_grace_cmdqv;
+	struct nvidia_grace_cmdqv_vintf *vintf0 = &cmdqv->vintf0;
+	u32 regval;
+	u16 qidx;
+	int ret;
+
+	/* Setup vintf0 for host kernel */
+	vintf0->idx = 0;
+	vintf0->base = cmdqv->base + NVIDIA_CMDQV_VINTF(0);
+
+	regval = FIELD_PREP(VINTF_HYP_OWN, 1);
+	writel(regval, vintf0->base + NVIDIA_VINTF_CONFIG);
+
+	regval |= FIELD_PREP(VINTF_EN, 1);
+	writel(regval, vintf0->base + NVIDIA_VINTF_CONFIG);
+
+	vintf0->cfg = regval;
+
+	ret = readl_relaxed_poll_timeout(vintf0->base + NVIDIA_VINTF_STATUS,
+					 regval, regval == VINTF_ENABLED,
+					 1, ARM_SMMU_POLL_TIMEOUT_US);
+	vintf0->status = regval;
+	if (ret) {
+		dev_err(cmdqv->dev, "failed to enable VINTF%u: STATUS = 0x%08X\n",
+			vintf0->idx, regval);
+		return ret;
+	}
+
+	/* Allocate vcmdqs to vintf0 */
+	for (qidx = 0; qidx < cmdqv->num_vcmdqs_per_vintf; qidx++) {
+		regval  = FIELD_PREP(CMDQV_CMDQ_ALLOC_VINTF, vintf0->idx);
+		regval |= FIELD_PREP(CMDQV_CMDQ_ALLOC_LVCMDQ, qidx);
+		regval |= CMDQV_CMDQ_ALLOCATED;
+		writel_relaxed(regval, cmdqv->base + NVIDIA_CMDQV_CMDQ_ALLOC(qidx));
+	}
+
+	/* Build an arm_smmu_cmdq for each vcmdq allocated to vintf0 */
+	vintf0->vcmdqs = devm_kcalloc(cmdqv->dev, cmdqv->num_vcmdqs_per_vintf,
+				      sizeof(*vintf0->vcmdqs), GFP_KERNEL);
+	if (!vintf0->vcmdqs)
+		return -ENOMEM;
+
+	for (qidx = 0; qidx < cmdqv->num_vcmdqs_per_vintf; qidx++) {
+		void __iomem *vcmdq_base = cmdqv->base + NVIDIA_CMDQV_VCMDQ(qidx);
+		struct arm_smmu_cmdq *cmdq = &vintf0->vcmdqs[qidx];
+
+		/* Setup struct arm_smmu_cmdq data members */
+		nvidia_grace_cmdqv_init_one_vcmdq(cmdqv, cmdq, vcmdq_base, qidx);
+
+		/* Configure and enable the vcmdq */
+		writel_relaxed(0, vcmdq_base + NVIDIA_VCMDQ_PROD);
+		writel_relaxed(0, vcmdq_base + NVIDIA_VCMDQ_CONS);
+
+		writeq_relaxed(cmdq->q.q_base, cmdqv->base + NVIDIA_VCMDQ_BASE_L(qidx));
+
+		writel(VCMDQ_EN, vcmdq_base + NVIDIA_VCMDQ_CONFIG);
+		ret = readl_poll_timeout(vcmdq_base + NVIDIA_VCMDQ_STATUS,
+					 regval, regval == VCMDQ_ENABLED,
+					 1, ARM_SMMU_POLL_TIMEOUT_US);
+		if (ret) {
+			u32 gerror = readl_relaxed(vcmdq_base + NVIDIA_VCMDQ_GERROR);
+			u32 gerrorn = readl_relaxed(vcmdq_base + NVIDIA_VCMDQ_GERRORN);
+			u32 cons = readl_relaxed(vcmdq_base + NVIDIA_VCMDQ_CONS);
+
+			dev_err(cmdqv->dev,
+				"failed to enable VCMDQ%u: GERROR=0x%X, GERRORN=0x%X, CONS=0x%X\n",
+				qidx, gerror, gerrorn, cons);
+			return ret;
+		}
+
+		dev_info(cmdqv->dev, "VCMDQ%u allocated to VINTF%u as logical-VCMDQ%u\n",
+			 qidx, vintf0->idx, qidx);
+	}
+
+	return 0;
+}
+
+static int nvidia_grace_cmdqv_acpi_is_memory(struct acpi_resource *res, void *data)
+{
+	struct resource r;
+
+	return !acpi_dev_resource_memory(res, &r);
+}
+
+static int nvidia_grace_cmdqv_acpi_get_irqs(struct acpi_resource *ares, void *data)
+{
+	struct resource r;
+	int *irq = data;
+
+	if (*irq <= 0 && acpi_dev_resource_interrupt(ares, 0, &r))
+		*irq = r.start;
+
+	return 1; /* No need to add resource to the list */
+}
+
+/*
+ * Function taking care of all ACPI resource probings and according allocations
+ *
+ * Note that it uses devm_* functions for resource allocations here so that smmu
+ * driver can roll back cmdqv resources automatically without additional cleanup
+ * routine, if any further error happens there. Yet this means all error unwinds
+ * here will have to go with devm_* too.
+ */
+static struct nvidia_grace_cmdqv *
+nvidia_grace_cmdqv_find_resource(struct arm_smmu_device *smmu,
+				 struct acpi_iort_node *node)
+{
+	struct nvidia_grace_cmdqv *cmdqv = NULL;
+	struct list_head resource_list;
+	struct resource_entry *rentry;
+	struct acpi_device *adev;
+	const char *match_uid;
+	int ret;
+
+	if (acpi_disabled)
+		return NULL;
+
+	/* Look for a device in the DSDT whose _UID matches the SMMU's iort_node identifier */
+	match_uid = kasprintf(GFP_KERNEL, "%u", node->identifier);
+	adev = acpi_dev_get_first_match_dev(NVIDIA_CMDQV_HID, match_uid, -1);
+	kfree(match_uid);
+
+	if (!adev)
+		return NULL;
+
+	dev_info(smmu->dev, "found companion CMDQV device, %s\n", dev_name(&adev->dev));
+
+	INIT_LIST_HEAD(&resource_list);
+	ret = acpi_dev_get_resources(adev, &resource_list,
+				     nvidia_grace_cmdqv_acpi_is_memory, NULL);
+	if (ret < 0) {
+		dev_err(smmu->dev, "failed to get memory resource: %d\n", ret);
+		goto put_dev;
+	}
+
+	cmdqv = devm_kzalloc(smmu->dev, sizeof(*cmdqv), GFP_KERNEL);
+	if (!cmdqv)
+		goto free_list;
+
+	rentry = list_first_entry_or_null(&resource_list, struct resource_entry, node);
+	if (!rentry) {
+		dev_err(smmu->dev, "failed to get memory resource entry\n");
+		goto free_cmdqv;
+	}
+
+	cmdqv->smmu = smmu;
+	cmdqv->dev = smmu->dev;
+	cmdqv->res = rentry->res;
+
+	cmdqv->base = devm_ioremap_resource(smmu->dev, rentry->res);
+	if (IS_ERR(cmdqv->base)) {
+		dev_err(smmu->dev, "failed to ioremap: %ld\n", PTR_ERR(cmdqv->base));
+		goto free_cmdqv;
+	}
+
+	ret = acpi_dev_get_resources(adev, &resource_list,
+				     nvidia_grace_cmdqv_acpi_get_irqs, &cmdqv->irq);
+	if (ret < 0) {
+		dev_warn(smmu->dev, "no cmdqv interrupt - errors will not be reported\n");
+		cmdqv->irq = 0;
+	} else {
+		ret = devm_request_irq(smmu->dev, cmdqv->irq, nvidia_grace_cmdqv_isr,
+				       0, "nvidia-grace-cmdqv", cmdqv);
+		if (ret) {
+			dev_err(smmu->dev, "failed to request irq (%d): %d\n",
+				cmdqv->irq, ret);
+			goto iounmap;
+		}
+	}
+
+	goto free_list;
+
+iounmap:
+	devm_iounmap(smmu->dev, cmdqv->base);
+	devm_release_mem_region(smmu->dev, cmdqv->res->start,
+				resource_size(cmdqv->res));
+free_cmdqv:
+	devm_kfree(smmu->dev, cmdqv);
+	cmdqv = NULL;
+free_list:
+	acpi_dev_free_resource_list(&resource_list);
+put_dev:
+	put_device(&adev->dev);
+
+	return cmdqv;
+}
+
+struct nvidia_grace_cmdqv *
+nvidia_grace_cmdqv_acpi_probe(struct arm_smmu_device *smmu,
+			      struct acpi_iort_node *node)
+{
+	struct nvidia_grace_cmdqv *cmdqv;
+	u32 regval;
+
+	cmdqv = nvidia_grace_cmdqv_find_resource(smmu, node);
+	if (!cmdqv)
+		return NULL;
+
+	regval = readl_relaxed(cmdqv->base + NVIDIA_CMDQV_CONFIG);
+	if (!FIELD_GET(CMDQV_EN, regval)) {
+		dev_err(cmdqv->dev, "CMDQV h/w is disabled: CMDQV_CONFIG=0x%08X\n", regval);
+		goto free_res;
+	}
+
+	regval = readl_relaxed(cmdqv->base + NVIDIA_CMDQV_STATUS);
+	if (!FIELD_GET(CMDQV_ENABLED, regval) || FIELD_GET(CMDQV_STATUS, regval)) {
+		dev_err(cmdqv->dev, "CMDQV h/w not ready: CMDQV_STATUS=0x%08X\n", regval);
+		goto free_res;
+	}
+
+	regval = readl_relaxed(cmdqv->base + NVIDIA_CMDQV_PARAM);
+	cmdqv->num_total_vintfs = 1 << FIELD_GET(CMDQV_NUM_VINTF_LOG2, regval);
+	cmdqv->num_total_vcmdqs = 1 << FIELD_GET(CMDQV_NUM_VCMDQ_LOG2, regval);
+	cmdqv->num_vcmdqs_per_vintf = cmdqv->num_total_vcmdqs / cmdqv->num_total_vintfs;
+
+	return cmdqv;
+
+free_res:
+	if (cmdqv->irq)
+		devm_free_irq(smmu->dev, cmdqv->irq, cmdqv);
+	devm_iounmap(smmu->dev, cmdqv->base);
+	devm_release_mem_region(smmu->dev, cmdqv->res->start,
+				resource_size(cmdqv->res));
+	devm_kfree(smmu->dev, cmdqv);
+
+	return NULL;
+}
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
