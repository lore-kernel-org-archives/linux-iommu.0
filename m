Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 907E1C433EF
	for <iommu@archiver.kernel.org>; Wed,  1 Dec 2021 15:58:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3B8874044D;
	Wed,  1 Dec 2021 15:58:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6eVYjevUvxel; Wed,  1 Dec 2021 15:58:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 073454040A;
	Wed,  1 Dec 2021 15:58:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D9BBBC0012;
	Wed,  1 Dec 2021 15:58:26 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B612EC000A
 for <iommu@lists.linux-foundation.org>; Wed,  1 Dec 2021 15:58:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A34784040A
 for <iommu@lists.linux-foundation.org>; Wed,  1 Dec 2021 15:58:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id g4ebOoJ3GHpj for <iommu@lists.linux-foundation.org>;
 Wed,  1 Dec 2021 15:58:22 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2086.outbound.protection.outlook.com [40.107.95.86])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 331A34019D
 for <iommu@lists.linux-foundation.org>; Wed,  1 Dec 2021 15:58:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZyO0wpSm0IHDoxxFtqzZCoipzXpd9hJZVaMFYFwHGCkHJjoNCLAxCXSqv6jCS+AdIdhb7SeoMEluQl7X2yTUAKDJe48k7CDzyGLP9dU8hdZJVtAohzjltOjq+rfTRQkGbQYMqN5DH+/v0xxB5yzluME3crcWmbEBoOspB150s+Qd4Bp6CbHpYpHo5UPQxhl6PGgqjDSrFUI6J1mIbXheUZB+0V09L8C7zsDt/mEIChpPXtI6hhl3h+yl0JR4uYxOsMWAqVIxWnDmWVFK1+eP/o0UJ6N5+zW9LTRngRQ6tLSNZA30iemM9dROH7MbPJoBf0QwtGKxFuVEO9Yr7zZS4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mNWkotrzllGzIok0az6trHY44j17oSTdQuZiGqw6Lq0=;
 b=Dk0XnPsxNkh8JpIksWvttedV0xphz31s1gDE9AXLtGfgFrHnWTsq44wWgyFLxP0sYBW+eoBCMrfiI47bM+QvRANrv5OcUWfyorKgSbm/OYWvXQfEQwXaIINmEzcXQT/1P+3gCBIijopQfPnPdaNtH/1LCPJjPQGWD7oPm4HJJw36OEPTbuOLc2pzmJh1l7EvT7vA3G/9yFCzWflo2eJ/jNUIcGgGgnHURylDcglmnkCxRbTzKDPHwJ3eubHy5vJrpLBS7P5J/Nz/MEsRNYVz63FeRDLTscGcGrUe6aJkHEgEjYMPpzcm6FdMrG7em9cyJ7jxpu/uMu6qTIgv9s5N/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.32) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mNWkotrzllGzIok0az6trHY44j17oSTdQuZiGqw6Lq0=;
 b=kyvVpPA8Ix+b+zrVA3TJE2dSDMl/AQu8U5vEkZFHSnaNm7rxmO1981J1w4W5VGBrKu+nQYHXw9w1b3bZKeUm4AltTfyz2qYlfgELb6sHCSZyZSg00emE4qNtRPxXmt9Kabs8DouEfdb0vGmZGZYAH7kvafzj44jMiUmw61QUP8SMGMiIDgYURA6ZVzirvYMZCeG+xdx38UxfKpjE5WsZF9p82vbtUJlVhoDIrT8VHiuYBeZNcb35FnEQ1wdTgwnpQQFD+hAt/usPDZFIFvc05K5i286Kl/VrrvVkEP/X1Q4nZ5prg0LEQChqVggdzi6YLrICdZ6VcjBonWwNGVd0gQ==
Received: from BN9P221CA0015.NAMP221.PROD.OUTLOOK.COM (2603:10b6:408:10a::20)
 by BN8PR12MB3330.namprd12.prod.outlook.com (2603:10b6:408:43::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11; Wed, 1 Dec
 2021 15:58:17 +0000
Received: from BN8NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10a:cafe::ac) by BN9P221CA0015.outlook.office365.com
 (2603:10b6:408:10a::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23 via Frontend
 Transport; Wed, 1 Dec 2021 15:58:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.32)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.32 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.32; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.32) by
 BN8NAM11FT046.mail.protection.outlook.com (10.13.177.127) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4755.13 via Frontend Transport; Wed, 1 Dec 2021 15:58:17 +0000
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 1 Dec
 2021 07:57:38 -0800
Received: from moonraker.nvidia.com (172.20.187.6) by mail.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Wed, 1 Dec 2021 07:57:36 -0800
To: Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>, Rob Herring
 <robh+dt@kernel.org>, Thierry Reding <thierry.reding@gmail.com>
Subject: [PATCH 2/2] arm64: tegra: Add ISO SMMU controller for Tegra194
Date: Wed, 1 Dec 2021 15:57:16 +0000
Message-ID: <20211201155716.149543-2-jonathanh@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211201155716.149543-1-jonathanh@nvidia.com>
References: <20211201155716.149543-1-jonathanh@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 347301d3-5722-4c33-59f5-08d9b4e363ca
X-MS-TrafficTypeDiagnostic: BN8PR12MB3330:
X-Microsoft-Antispam-PRVS: <BN8PR12MB3330E363E160ECA9B8E980F8D9689@BN8PR12MB3330.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JR+Fa/ZQYDg8UqG7yQvDj2eGVa+ZtFDrR52LEpGPmHnWxQ16up1wR0xX3c4MPKLYZRpxLkiiBUoz8xSYB6Ryu4t/I68DAsj6JcpZZyJ3d2tQj6AUH5T0G7/Viq5RAqDh3Nsz3k43MJZCpk6qFVZvFD7NJD+3M+tu9UH23ihXkiEIptZrKsi4yP/y6Pfa2RMmvnAVWmrV5vHO59q+sNws60gWByXpYMt1fMzh2+EJz44Ml+kyXYd5zTND9MKIa+J4Lgr2v25DQmOBH00do2+By8Js7khpX5OhClP/WQVLFa7xf+i18GGjyMEN4vsWGnZX6f7tp0bVjtvcO24yd+nkPI6dTVF3DP5ERVGuhxnHzlHdI0P0BCOeApSaXEfeDHOn3H+PRcW5uK2xnCRny553RDmNr+K3H7HQJl2uLNkWt0+xgPYlHx91KjYB8/Qje44UWQPy07hjmOoWLDbp0b4jNq685eZx2jkrQoyZXZzMcHihY6m/ln20WOY8pYIiao5vMtmK9R7ip6MHwp0fMGTk//Mlvp1A3wDPHAaZLzezhHUnjXrOwVMl9CQKrtR/sxJJhkox0vAweQjsucv6FnJAF/WVsEVur8u9xCl4cafYIX552Uf8ykzLyq8eaFVm9FonISCkVtqf/vcZ5TsgpgDkjnUGojclJbT39kF0mnn5d2FqWwOxMpO1TZ5ApMqNYFfurYlXHbv/c8zeUfePWJk/mOuLzyyGCzdoiuOo+L8ZGNeWWTFyPnrX7JsCYvZEEjdKcZtsRyqx8Fm0nMNTgm9+5A==
X-Forefront-Antispam-Report: CIP:216.228.112.32; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid01.nvidia.com; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700001)(186003)(82310400004)(8936002)(86362001)(54906003)(4326008)(47076005)(2906002)(508600001)(36860700001)(40460700001)(26005)(110136005)(7696005)(1076003)(6666004)(36756003)(5660300002)(8676002)(336012)(356005)(7636003)(70206006)(316002)(107886003)(2616005)(70586007)(426003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2021 15:58:17.2705 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 347301d3-5722-4c33-59f5-08d9b4e363ca
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.32];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3330
Cc: linux-tegra@vger.kernel.org, devicetree@vger.kernel.org,
 iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org,
 Jon Hunter <jonathanh@nvidia.com>
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
From: Jon Hunter via iommu <iommu@lists.linux-foundation.org>
Reply-To: Jon Hunter <jonathanh@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

The display controllers are attached to a separate ARM SMMU instance
that is dedicated to servicing isochronous memory clients. Add this ISO
instance of the ARM SMMU to device tree.

Please note that the display controllers are not hooked up to this SMMU
yet, because we are still missing a means to transition framebuffers
used by the bootloader to the kernel.

This based upon an initial patch by Thierry Reding <treding@nvidia.com>.

Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra194.dtsi | 76 ++++++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra194.dtsi b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
index d78c9ed08c47..496e31b5c637 100644
--- a/arch/arm64/boot/dts/nvidia/tegra194.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
@@ -1474,6 +1474,82 @@ pmc: pmc@c360000 {
 			interrupt-controller;
 		};
 
+		iommu@10000000 {
+			compatible = "nvidia,tegra194-smmu", "nvidia,smmu-500";
+			reg = <0x10000000 0x800000>;
+			interrupts = <GIC_SPI 240 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 240 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 240 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 240 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 240 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 240 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 240 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 240 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 240 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 240 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 240 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 240 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 240 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 240 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 240 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 240 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 240 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 240 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 240 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 240 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 240 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 240 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 240 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 240 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 240 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 240 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 240 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 240 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 240 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 240 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 240 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 240 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 240 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 240 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 240 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 240 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 240 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 240 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 240 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 240 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 240 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 240 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 240 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 240 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 240 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 240 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 240 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 240 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 240 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 240 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 240 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 240 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 240 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 240 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 240 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 240 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 240 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 240 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 240 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 240 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 240 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 240 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 240 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 240 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 240 IRQ_TYPE_LEVEL_HIGH>;
+			stream-match-mask = <0x7f80>;
+			#global-interrupts = <1>;
+			#iommu-cells = <1>;
+
+			nvidia,memory-controller = <&mc>;
+			status = "okay";
+		};
+
 		smmu: iommu@12000000 {
 			compatible = "nvidia,tegra194-smmu", "nvidia,smmu-500";
 			reg = <0x12000000 0x800000>,
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
