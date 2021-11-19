Return-Path: <SRS0=KWJS=QG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E1E4C43217
	for <iommu@archiver.kernel.org>; Fri, 19 Nov 2021 07:27:50 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23C71617E3
	for <iommu@archiver.kernel.org>; Fri, 19 Nov 2021 07:27:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 23C71617E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9CE5D81D5A;
	Fri, 19 Nov 2021 07:27:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9jTxZ9nV_ef9; Fri, 19 Nov 2021 07:27:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 5661C81D16;
	Fri, 19 Nov 2021 07:27:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6E230C003E;
	Fri, 19 Nov 2021 07:27:47 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 93C54C003C
 for <iommu@lists.linux-foundation.org>; Fri, 19 Nov 2021 07:27:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 618CD81CAD
 for <iommu@lists.linux-foundation.org>; Fri, 19 Nov 2021 07:27:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xxwX1j5hPliY for <iommu@lists.linux-foundation.org>;
 Fri, 19 Nov 2021 07:27:43 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2057.outbound.protection.outlook.com [40.107.220.57])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 921CF81C56
 for <iommu@lists.linux-foundation.org>; Fri, 19 Nov 2021 07:27:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BnzLdI+gdjRA1AMmAUbOCL1APraF6QkvuHPJG3x/JvD0/yIu6Uqu2EaNM9ENxE7PVCkgD9t6ZmlQU1SAy9ikr4iR3KEqxQwUqyzx3MsZA1K+8Ngnl3mhVjYZgXe0K96sC6XoACk+szpAdJMjxT5g1frkYgfPFRCm3U7M2RX6WVx+p5UWAzzn5OazwIYSxMbKyWgJt83+/XbnW/6/i3+QaJ9MitlSdSPpb6Jd75Fcr0jM6D1bdSWdsZGu2CIasjbKHG01v4D+IeFmTlEwLVxbo1Eg9CfxluXMCVroQsTnRntRw4Zct4isdyNrCUiJ+ZuvoAZ9ja8hivqFl92fPd/aDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KqVazHekPsNWX39MMNHQ2+i+FphwKMZ2tdNIoHcP+iM=;
 b=RMn0nfoTUdPIUnPPCQxT+zEJSdsFNhEMEvGtdp3KdbjVU7OB5mju2xDOBXS2MY849ho2dM2J47WvsX3zVmGY+t8F8eKetWsRICfQawP04t0FW8xPQj1sLdht1n5gN+N6E2zwxyLf6H5QzSqqJvRRNuI6OS8kTdnL0BhnWoNd7605qdeOnENox4zKtwASu+qvX7XXK4tTP3JjwynzbcQnvx65O6vPrrfZu4XQLtSzdHegoWmi3EfSHmJEXRyywyzS557rhHuF1JaTMuWGZyuxN0GUn7zKNGXXmUeHP2WBsQfPobfRq4Qw+V+634Iyp3A0+kp2rgFi4E7SrHibW3gldA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.36) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KqVazHekPsNWX39MMNHQ2+i+FphwKMZ2tdNIoHcP+iM=;
 b=h9oiv6b1HqKD4ynvtJgT24PX/Dhqsz7u2LRv9YI2JVLVGsH//y/mw0dqL6pH0wJfIoxKsnbWXg/E3SeyIh8GAbWCe+hQnVtEMJu4446ExFVKQ7yelM6FV/xCn/YlqmYP+oreK3nUeQRc3Bl6t2Da4+7WiFuGgccPLhiIt13w59HWnggxwmdJv0DxYXaCdhqDEdoc9Bidt+q3RaW2DeiwhOt8hwJcw77ci9Om/r3CDu3iXavFM1YbIDBNW2NhcPaW9FZJ2Dv7KTQ6OtIDiOQLmT0WIIvghk3ev+Wg0OAqgbcz515GaCIGiLe+jxGo1bqAntE3sFKPJMb0mxufs7rZRA==
Received: from DM6PR08CA0051.namprd08.prod.outlook.com (2603:10b6:5:1e0::25)
 by MWHPR12MB1230.namprd12.prod.outlook.com (2603:10b6:300:f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.27; Fri, 19 Nov
 2021 07:27:38 +0000
Received: from DM6NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1e0:cafe::5d) by DM6PR08CA0051.outlook.office365.com
 (2603:10b6:5:1e0::25) with Microsoft SMTP Server (version=TLS1_2,
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
 2021 07:27:37 +0000
Received: from Asurada-Nvidia.nvidia.com (172.20.187.6) by mail.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Fri, 19 Nov 2021 07:27:36 +0000
To: <joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>
Subject: [PATCH v3 5/5] iommu/nvidia-grace-cmdqv: Limit CMDs for guest owned
 VINTF
Date: Thu, 18 Nov 2021 23:19:59 -0800
Message-ID: <20211119071959.16706-6-nicolinc@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211119071959.16706-1-nicolinc@nvidia.com>
References: <20211119071959.16706-1-nicolinc@nvidia.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 974e3c5a-ffdb-463c-f895-08d9ab2e10ba
X-MS-TrafficTypeDiagnostic: MWHPR12MB1230:
X-Microsoft-Antispam-PRVS: <MWHPR12MB1230CB3BB837C39733A33CBBAB9C9@MWHPR12MB1230.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1850;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9Y/URpi5lr6qdUQp52/7sFoRMNrVrxsxfPs8VhbI6Z9VfnMjmwVgPDTV06oaCqEUu6A49/zeD5S4UCD3cuANb3dloPDYDCS59iVNFaTg4U1j1oluWjcImHBAd9ml+3VB6My55NPrN1MuekCL6UhBJNXoTGyH+mP8Hh3UyR2NMJ+EC8pWVG//Vumbe6o240RKaPuxHvSz36Bu/CrgeNEr1P57nPy2TEU8JhJCLWjQm3InUgA1TvRXDRXec6uMSmHbakB0nNXIrWDU1IrKV5M3X1JD3gxrI1Y4UzsarEaNOIPtr6koZP+/8wBIN/ZvUUD8HBuf4/IND+LOJodCHmkXVO/07Y3DzV/MRTVTLUSWxv4RXUzsp9U7aop36DZOcu4vlTxapsMIpJJLMxZ0iliRRFUxovIG0dXip1Q3M9BK+2IEHWOLcVaUM7/VYJEM5WSFn0T93QNHxh+Da7QvVRz6eINkPnRa4cdwwxpU6yEtVpuoMw4R5dsPMpcF2z94QoYJcRzEkNO1Vh4aVQcU3X4FdE0wnArtOYDnwSiULcThGxrCDWUc0TCa+aq/jGigyAIhBKUD8NFg9+FWboY8Ep9dpS2KKEM7DJePxy7k7UzEP/V7RqsrzlEId4UnQ3jSK/Ybaa9KxU+7O3t14eUZCKnNqrX7I2OGYl+p5N7GpEC2FTVz9SPG0dIwwWrbS1EnMqOxxru1Rzkhr6cNiQ2Oz076Rw==
X-Forefront-Antispam-Report: CIP:216.228.112.36; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid05.nvidia.com; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(86362001)(110136005)(54906003)(7636003)(316002)(1076003)(356005)(70586007)(70206006)(2906002)(36906005)(36860700001)(36756003)(4326008)(5660300002)(186003)(26005)(7696005)(2616005)(107886003)(336012)(6666004)(47076005)(8936002)(426003)(8676002)(508600001)(7416002)(83380400001)(82310400003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2021 07:27:38.4651 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 974e3c5a-ffdb-463c-f895-08d9ab2e10ba
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.36];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1230
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

When VCMDQs are assigned to a VINTF that is owned by a guest, not
hypervisor (HYP_OWN bit is unset), only TLB invalidation commands
are supported. This requires get_cmd() function to scan the input
cmd before selecting cmdq between smmu->cmdq and vintf->vcmdq, so
unsupported commands can still go through emulated smmu->cmdq.

Also the guest shouldn't have HYP_OWN bit being set regardless of
guest kernel driver writing it or not, i.e. the user space driver
running in the host OS should wire this bit to zero when trapping
a write access to this VINTF_CONFIG register from a guest kernel.
So instead of using the existing regval, this patch reads out the
register value explicitly to cache in vintf->cfg.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |  6 ++--
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  5 +--
 .../arm/arm-smmu-v3/nvidia-grace-cmdqv.c      | 32 +++++++++++++++++--
 3 files changed, 36 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index b1182dd825fd..73941ccc1a3e 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -337,10 +337,10 @@ static int arm_smmu_cmdq_build_cmd(u64 *cmd, struct arm_smmu_cmdq_ent *ent)
 	return 0;
 }
 
-static struct arm_smmu_cmdq *arm_smmu_get_cmdq(struct arm_smmu_device *smmu)
+static struct arm_smmu_cmdq *arm_smmu_get_cmdq(struct arm_smmu_device *smmu, u64 *cmds, int n)
 {
 	if (smmu->nvidia_grace_cmdqv)
-		return nvidia_grace_cmdqv_get_cmdq(smmu);
+		return nvidia_grace_cmdqv_get_cmdq(smmu, cmds, n);
 
 	return &smmu->cmdq;
 }
@@ -747,7 +747,7 @@ static int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
 	u32 prod;
 	unsigned long flags;
 	bool owner;
-	struct arm_smmu_cmdq *cmdq = arm_smmu_get_cmdq(smmu);
+	struct arm_smmu_cmdq *cmdq = arm_smmu_get_cmdq(smmu, cmds, n);
 	struct arm_smmu_ll_queue llq, head;
 	int ret = 0;
 
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 24f93444aeeb..085c775c2eea 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -832,7 +832,8 @@ struct nvidia_grace_cmdqv *
 nvidia_grace_cmdqv_acpi_probe(struct arm_smmu_device *smmu,
 			      struct acpi_iort_node *node);
 int nvidia_grace_cmdqv_device_reset(struct arm_smmu_device *smmu);
-struct arm_smmu_cmdq *nvidia_grace_cmdqv_get_cmdq(struct arm_smmu_device *smmu);
+struct arm_smmu_cmdq *nvidia_grace_cmdqv_get_cmdq(struct arm_smmu_device *smmu,
+						  u64 *cmds, int n);
 #else /* CONFIG_NVIDIA_GRACE_CMDQV */
 static inline struct nvidia_grace_cmdqv *
 nvidia_grace_cmdqv_acpi_probe(struct arm_smmu_device *smmu,
@@ -847,7 +848,7 @@ static inline int nvidia_grace_cmdqv_device_reset(struct arm_smmu_device *smmu)
 }
 
 static inline struct arm_smmu_cmdq *
-nvidia_grace_cmdqv_get_cmdq(struct arm_smmu_device *smmu)
+nvidia_grace_cmdqv_get_cmdq(struct arm_smmu_device *smmu, u64 *cmds, int n)
 {
 	return NULL;
 }
diff --git a/drivers/iommu/arm/arm-smmu-v3/nvidia-grace-cmdqv.c b/drivers/iommu/arm/arm-smmu-v3/nvidia-grace-cmdqv.c
index c0d7351f13e2..71f6bc684e64 100644
--- a/drivers/iommu/arm/arm-smmu-v3/nvidia-grace-cmdqv.c
+++ b/drivers/iommu/arm/arm-smmu-v3/nvidia-grace-cmdqv.c
@@ -166,7 +166,8 @@ static int nvidia_grace_cmdqv_init_one_vcmdq(struct nvidia_grace_cmdqv *cmdqv,
 	return arm_smmu_cmdq_init(cmdqv->smmu, cmdq);
 }
 
-struct arm_smmu_cmdq *nvidia_grace_cmdqv_get_cmdq(struct arm_smmu_device *smmu)
+struct arm_smmu_cmdq *
+nvidia_grace_cmdqv_get_cmdq(struct arm_smmu_device *smmu, u64 *cmds, int n)
 {
 	struct nvidia_grace_cmdqv *cmdqv = smmu->nvidia_grace_cmdqv;
 	struct nvidia_grace_cmdqv_vintf *vintf0 = &cmdqv->vintf0;
@@ -176,6 +177,24 @@ struct arm_smmu_cmdq *nvidia_grace_cmdqv_get_cmdq(struct arm_smmu_device *smmu)
 	if (!FIELD_GET(VINTF_STATUS, vintf0->status))
 		return &smmu->cmdq;
 
+	/* Check for supported CMDs if VINTF is owned by guest (not hypervisor) */
+	if (!FIELD_GET(VINTF_HYP_OWN, vintf0->cfg)) {
+		u64 opcode = (n) ? FIELD_GET(CMDQ_0_OP, cmds[0]) : CMDQ_OP_CMD_SYNC;
+
+		/* List all supported CMDs for vintf->cmdq pathway */
+		switch (opcode) {
+		case CMDQ_OP_TLBI_NH_ASID:
+		case CMDQ_OP_TLBI_NH_VA:
+		case CMDQ_OP_TLBI_S12_VMALL:
+		case CMDQ_OP_TLBI_S2_IPA:
+		case CMDQ_OP_ATC_INV:
+			break;
+		default:
+			/* Unsupported CMDs go for smmu->cmdq pathway */
+			return &smmu->cmdq;
+		}
+	}
+
 	/*
 	 * Select a vcmdq to use. Here we use a temporal solution to
 	 * balance out traffic on cmdq issuing: each cmdq has its own
@@ -199,13 +218,22 @@ int nvidia_grace_cmdqv_device_reset(struct arm_smmu_device *smmu)
 	vintf0->idx = 0;
 	vintf0->base = cmdqv->base + NVIDIA_CMDQV_VINTF(0);
 
+	/*
+	 * Note that HYP_OWN bit is wired to zero when running in guest kernel
+	 * regardless of enabling it here, as !HYP_OWN cmdqs have a restricted
+	 * set of supported commands, by following the HW design.
+	 */
 	regval = FIELD_PREP(VINTF_HYP_OWN, 1);
 	writel(regval, vintf0->base + NVIDIA_VINTF_CONFIG);
 
 	regval |= FIELD_PREP(VINTF_EN, 1);
 	writel(regval, vintf0->base + NVIDIA_VINTF_CONFIG);
 
-	vintf0->cfg = regval;
+	/*
+	 * As being mentioned above, HYP_OWN bit is wired to zero for a guest
+	 * kernel, so read back regval from HW to ensure that reflects in cfg
+	 */
+	vintf0->cfg = readl(vintf0->base + NVIDIA_VINTF_CONFIG);
 
 	ret = readl_relaxed_poll_timeout(vintf0->base + NVIDIA_VINTF_STATUS,
 					 regval, regval == VINTF_ENABLED,
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
