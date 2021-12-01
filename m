Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77016C433EF
	for <iommu@archiver.kernel.org>; Wed,  1 Dec 2021 15:57:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0A40D61BBA;
	Wed,  1 Dec 2021 15:57:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ksM_eaX3WbJG; Wed,  1 Dec 2021 15:57:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id C5C3061BA8;
	Wed,  1 Dec 2021 15:57:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9FEE7C0012;
	Wed,  1 Dec 2021 15:57:41 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 00B54C000A
 for <iommu@lists.linux-foundation.org>; Wed,  1 Dec 2021 15:57:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D13FA4051D
 for <iommu@lists.linux-foundation.org>; Wed,  1 Dec 2021 15:57:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DtfsNXIhWvqA for <iommu@lists.linux-foundation.org>;
 Wed,  1 Dec 2021 15:57:38 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2041.outbound.protection.outlook.com [40.107.102.41])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6926F401B1
 for <iommu@lists.linux-foundation.org>; Wed,  1 Dec 2021 15:57:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g+RcxtjQ0mKqUm49ZbzOxb+AOfs5gqV/nQYzHGAbUAiyJ7zMzFc8i9YCR0xP8oOFJBX84pynhpQpdaQU1QBXDWbS/dKlbS/PjqNbPxxXvuLHF7Mm65ms3SaVuSctLYIAhqLJlmkyF9/voyxKxJdXgMsqpUUD8AAfboByB7DwPqjlZRhlmYjGNn+BFnSnc4sbKlI8x9XwQkzYMpbAH86t1u7fk/AQwbyWWP3pKS8wxpoJ6tZyEgjWjSOIQpKzW5tI1nnKL4MZ+dx5kF/qL2a68o+WcC1KUordNfTCgbLObwQJOu1bhzaHQHiXopzBc7/2GTvlWwVgVAvXLe5W1k+63A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E10GYidHbL/X4wFfmsJeLLapOG0hz+pXhLhPrDSiz1Q=;
 b=dzko81zSHlwyaUUKoLSQ0SAWdBfpSxfxP33XN2hk/FogaLFGFMp3/n3S4KXiUwgaILWnh+PN6nrVusOaimuEmk1xnoFNWA7/PAmjWqc0cS1Y0+eXfKSIdeMinCrx5FHaq0WvHIxc/cxofFAB8oEEuF7HryffDKB0G8fGj24kjwxYWFzRQvrSwhZL4AGH+cUlIvJ5/i8IPRwlMbdmCN3WxSJZ3uu5R4Pywd91y8vXmFfneBJomA8Hyi2b2ai4o4dfdwEic33TAY4QQ/JUHo0LS1nm0Ih59QYpoVj55bd/xHzLFbhhKNVkeUF05nFZkrC4b0WZ7jOjpZD+KG63115kpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.35) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E10GYidHbL/X4wFfmsJeLLapOG0hz+pXhLhPrDSiz1Q=;
 b=imsQbkF+5GUhgfSoFlQSVKW/99/Q+Rf+272h70OjQDY+NiIBwwsSy7mdsPguWWFxnqWyWvigqnnlDkbrLtCKAuLAgHa4QHAXjphE+oPdr4VincDmxk2Zovh2cYTHzfIPos2pQ8vlJfvvjt0L6EyygczhAZRJApPkYD22bm6e/9FoQ0uW1GRyr5RJkYmpf49A+jvbHS/bUswJh2JX3Sr3dGDXhpkYmJglmer+4ql7GVcHYeHicCIRis8j73MsdmYV0vTbLdhMgeXSTwehjuazJwvyYPYAZPtSFf+aIM/Q5gv/GZ62p77XBgo1qQnp1zZUlAb8fysKSj87w7IA0uOrhg==
Received: from DM6PR13CA0068.namprd13.prod.outlook.com (2603:10b6:5:134::45)
 by SJ0PR12MB5502.namprd12.prod.outlook.com (2603:10b6:a03:300::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.24; Wed, 1 Dec
 2021 15:57:36 +0000
Received: from DM6NAM11FT053.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:134:cafe::c2) by DM6PR13CA0068.outlook.office365.com
 (2603:10b6:5:134::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.10 via Frontend
 Transport; Wed, 1 Dec 2021 15:57:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.35)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.35 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.35; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.35) by
 DM6NAM11FT053.mail.protection.outlook.com (10.13.173.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4755.13 via Frontend Transport; Wed, 1 Dec 2021 15:57:36 +0000
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 1 Dec
 2021 15:57:35 +0000
Received: from moonraker.nvidia.com (172.20.187.6) by mail.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Wed, 1 Dec 2021 07:57:34 -0800
To: Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>, Rob Herring
 <robh+dt@kernel.org>, Thierry Reding <thierry.reding@gmail.com>
Subject: [PATCH 1/2] dt-bindings: arm-smmu: Fix json-schema for Tegra
Date: Wed, 1 Dec 2021 15:57:15 +0000
Message-ID: <20211201155716.149543-1-jonathanh@nvidia.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-NVConfidentiality: public
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1896d26c-a76a-4a26-3f50-08d9b4e34b6f
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5502:
X-Microsoft-Antispam-PRVS: <SJ0PR12MB5502F85B0C5919F4CFAEB67DD9689@SJ0PR12MB5502.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hjQwbSjsfiPKUMv2PR4FGg/MYpreoi9sRg2bnKz0tc1y8BuvnTX0/VMAJcjQWxucG5D8JqB3J+Ih5E7laulHq1MKbsLuuU6vv2WgM/HuLSE9TrTuiWAxrRuKohcPFVy1CsZynwuiCwuHIkeOKUyMTkSGH5Z0eorotFlXqjQjPZbuGuQHLHLBkeVKtY06e17QZ4n1qJ9MZFeu5bGhN0DtQ1h0SCk//Ud9jg/kLIsBa9Zxao/aRkgYAGxWlYLRP3DGcsXtFODDeuzj2RVJhujZiSzc+yxNkCh1lOynY3uDuDdXUW2y7mdKCPyQl4X0HwewGbTGeLHqOvwlu/edWVYvEqjECHQN1wBiUg83Ykv2l0xNpHoC9CJFGvho8Tz7WExJYVZxglGtVzIt0wdHgb9W0t5VPH8Bnn4TNxWiMnAZKvnj7xMyHO3aDgw/6H/Q4v0XUxoFC42lUi2BqEyTjTTydFegCMjQJLR2mN0jQNx2Zvqv8KY0MrZkywyNR5q4bCRQr1aCAQbe9TBKSH0/5lfReVeDsyBmA7SAxga6BSyLPpx5BoVmbak4oFY+an/7cBNUt/JdIutTyWi/fsEPI6qN3fv8+qDHOvGB/BNWoo/BREUlxNrrCVknAU7JWZMPgMZhJO8+qo+jcom/QVfyc5il6f+vZetY9SxFhy/hGMr3COhCBHvih5qNUYTwImedGt8q3CqVMrAph1gvkFDv2B4mqRQQS35ew6EJXv4o6I8Ml8IGUke+S7wVRLJuMjZeLuajwJ9nPxZJ/3Q+dJCNM55M4A==
X-Forefront-Antispam-Report: CIP:216.228.112.35; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid02.nvidia.com; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700001)(36860700001)(7696005)(508600001)(82310400004)(70586007)(6666004)(426003)(4326008)(36756003)(40460700001)(356005)(47076005)(2616005)(336012)(70206006)(110136005)(26005)(2906002)(86362001)(8676002)(83380400001)(316002)(186003)(5660300002)(7636003)(8936002)(107886003)(1076003)(54906003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2021 15:57:36.4699 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1896d26c-a76a-4a26-3f50-08d9b4e34b6f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.35];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT053.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5502
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

The dt_binding_check currently issues the following warnings for the
Tegra186 and Tegra194 SMMUs ...

 arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dt.yaml: iommu@12000000:
  'nvidia,memory-controller' does not match any of the regexes: 'pinctrl-[0-9]+'
 	From schema: Documentation/devicetree/bindings/iommu/arm,smmu.yaml
  DTC     arch/arm64/boot/dts/nvidia/tegra186-p3509-0000+p3636-0001.dt.yaml
  CHECK   arch/arm64/boot/dts/nvidia/tegra186-p3509-0000+p3636-0001.dt.yaml

Add the missing 'nvidia,memory-controller' property to fix the above
warning.

Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
 Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
index f66a3effba73..5dce07b12cd7 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
@@ -155,6 +155,10 @@ properties:
   power-domains:
     maxItems: 1
 
+  nvidia,memory-controller:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: phandle of the memory controller node
+
 required:
   - compatible
   - reg
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
