Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013067.outbound.protection.outlook.com [40.107.201.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D41B2D5926
	for <iommu@lists.linux.dev>; Wed, 17 Dec 2025 04:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765945597; cv=fail; b=c9NE3Bflj8pNhuDmigGZZouJHmLFWvN6G8EVrJSxBlOj5+XNsbxEV4jxUkQvgAQ8QQm3hvW0sC7msXKoxmDfMjyDlYwtidm1gc8pw3UefFsXBFb92/erg1rSF6+eHvonoxdFqC0qctZ4e/9qW10DN/5hSyJDAR9myyaMk27J8Fw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765945597; c=relaxed/simple;
	bh=U23+vhl90+PDa2p0w6+2fMCPAkfqVqTHtLgx6BHM0kw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JhgcpnBnUuv1U0cOXcBFkgoc2hn9aWs8jQG3XRdfV1sifUOk/ByJje3QlXlT+lfxemKLp9+jxB3Gi07UEycvlwlqHVc5/lg2wQRWN3WXoGCDGIg/uYvBm2Ywxsv3DP5U5Rb1X5DMThK6/LBpO6VHLezXMwC6JjXSEirvU6/5iEI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rF+1/xQF; arc=fail smtp.client-ip=40.107.201.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rF+1/xQF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tt4zAsB1QlIq18rNuNuqkpLXdVZ2Vyx2F8MKeOISgdb8IPcZhxacKObGAvTHJCAbloBT4PiX+0CbPBM5sYsZxkaL9hr+hb4/D5QP1LJhPT5FZRqcTP0kFkIyRgXIRQ4OXGKWYShD/u/sjgskn+3/AuTD2uawlP7oOOdoinyJjYGCvXsuoSy6qDGd+EE+HYXEgcu3XGAnfW4Rj6waIW+7uWyZTxCTpOcxfFWWJMqeYnNQBdly+hv+8uUNT0G+NjHhY8HAp4vFB2bLuJXiap4ci3Pz44aFREe+vtfO7Z94LNs+NkLFriFyM8WyqyIq5Pzx7U7Zy/Fvbs7D9UB2lwbeyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pyUknLK10IFnRrY1t3LFmdvIDLQA+DUzE+qm0LYlouo=;
 b=C42rZwXji6RNlnstVOMwVX9bVemUtYya4KwuzLHLp5GTNX7/6F8Jb1e+aZfoVfs5psikucgTA5eIO1YLj60lvXk02AFE1FP5P07iiubz1G6GdCRm1rU15rBclRrTGfebR0dUBlmjOf9X/uyGu8vNdap5Hx8nKgXrZp7cQ/IaU8Pei07r94OLpp8v7fFyxKF2kHd/X7scfo9wpRUvynDbAC8HFxBdfE+sw4I0xDu+pmzWPlsF7x7tld6XLVGFI8gKkoQPwBaP7FR82ZdrLPRvJZDudVMdO53q1xjoWvME5faz+JxTf/t0LJY75u8//cCDs1gJ2PAMo7wNAQ87m/lRRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pyUknLK10IFnRrY1t3LFmdvIDLQA+DUzE+qm0LYlouo=;
 b=rF+1/xQF9WUoXcx21lF4rdUr812xDrFnRlIPQP38wan1/DurkmvhcydHMYOpxId5eLLOUTN3HXqQKZk8VUSaa7blLcPRVODNl35ejJnp0AVFhMVT+i9mYDhdTM10wt1PVGRDCCpjH6W19rE+j9++A8WGSSASYdivFhYNDMzI0bNMEnkRQi+1W4KC/IWIkrSNuA+i4fgqA/eOcy9pCUIeSiiqGXpKGl5SehuydanS1hOcAwQzDaGES/sOGFsGLFUbibsIhMc2T8A9q2HlSPkBgg9RUTWTTnqJ2gmJ7QJhRdzx4ShkJIVLYE2RVPosRryEUfANbYXcEziiHfmNRNIVDw==
Received: from SJ0PR03CA0183.namprd03.prod.outlook.com (2603:10b6:a03:2ef::8)
 by SJ5PPF665EE4E73.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::996) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Wed, 17 Dec
 2025 04:26:29 +0000
Received: from SJ1PEPF00001CE8.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::8b) by SJ0PR03CA0183.outlook.office365.com
 (2603:10b6:a03:2ef::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.6 via Frontend Transport; Wed,
 17 Dec 2025 04:26:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00001CE8.mail.protection.outlook.com (10.167.242.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Wed, 17 Dec 2025 04:26:29 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 16 Dec
 2025 20:26:18 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 16 Dec
 2025 20:26:17 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 16 Dec 2025 20:26:16 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <will@kernel.org>, <robin.murphy@arm.com>
CC: <smostafa@google.com>, <joro@8bytes.org>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <skolothumtho@nvidia.com>,
	<praan@google.com>, <xueshuai@linux.alibaba.com>
Subject: [PATCH rc v4 3/4] iommu/arm-smmu-v3: Mark STE EATS safe when computing the update sequence
Date: Tue, 16 Dec 2025 20:26:01 -0800
Message-ID: <adf08c3b9f289188aca4fe80e506dca7aa48aa19.1765945258.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1765945258.git.nicolinc@nvidia.com>
References: <cover.1765945258.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE8:EE_|SJ5PPF665EE4E73:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a96bf26-170e-4262-1071-08de3d24731a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2XiA5bJnxYLLl8j3NzsvGsL5CX084CIH6ZRzEDKk4X0PwDHKzSkMjp4OjDAf?=
 =?us-ascii?Q?kXmR93eeLhJtKn7C7Ni8puPV+fQGZP1Lp3dpU0bYRbZxp5vhhRYyNnHntWUU?=
 =?us-ascii?Q?4OpfTXFiRjNyiw/Jdsof6h+Z9l1f/aMJZHlHxAbUBS8PfpbAlyy1xnk3nft4?=
 =?us-ascii?Q?dm07BplHhTpPkgQZZrd9vqnsNKv7emgwp8tFU7fjmckYLKI2yx15lkjkT+G5?=
 =?us-ascii?Q?TWcjOYGZ/Lb2opgkOb+vZ8ak076jcnM9+RgLHq3xmlQD2WnqWd40ARFIoGCP?=
 =?us-ascii?Q?saan0C+TNXvGzVh5BGEWqXB7/MLr+NNJBp9v8zDelLjAF7U9btrXOY4KRo4q?=
 =?us-ascii?Q?c0HAdNvqYDMqZjenZ+ngp02N0fbzlnEveB4lxCZRsAW9LJWYiqZf2syf3Rvp?=
 =?us-ascii?Q?qhRY85TwKGehvKhfQZSH6g+cQSP0aLRvFzZlqAiC5I7MmL0ki7zvvJIP+7CC?=
 =?us-ascii?Q?269tO5u79/SMRIbpuz67cg4EaREAgiW9rbbgR0ZofW0lc370YSjeyheVqx9g?=
 =?us-ascii?Q?KVEjkjUxdzx/go9mvfcRdkt7kFvQ+qpULWu+q/tJBliffIbLrIsmYKVNSzR2?=
 =?us-ascii?Q?kAGSx4VpqhI03+4jvSiFQYWU3Ux72zj5uawHwjdakDMuVMUfhmRVyeHC0XHz?=
 =?us-ascii?Q?bwP69KDh9ssuMYqpaV5+Ba+c4TgnG1d3L3Oc33PVHDIerdBgY6NUb4rTFBdo?=
 =?us-ascii?Q?mPvVBql86TopGTxKHUL8nrdFykWeSUscRjstjFpTc0WlqojZ/M9lIcBwXKe8?=
 =?us-ascii?Q?uoysJN5+9HDtcqp9mc8ZdpkyRwq1GNkVhJ0ugPx/J24DidEatsfBeYI85idq?=
 =?us-ascii?Q?UyZQWZcu5gB4mRsFxnVtd31garWRBllL6+1CNSzsoPc0oz9QQIwlIETNHk7K?=
 =?us-ascii?Q?K6xEdQgty5j3MuOcjXLQ3mg4Kjr+N9Isn4aT6FrbCMo+a+Ub9FyujrQ3q7Y/?=
 =?us-ascii?Q?Ge//a6ZN6x57duzSJDoZtSf4VSENFZuWlPJa8ERIU8m23Zj3TetMR/iqR8f5?=
 =?us-ascii?Q?c/eHK1xOVY5Z0Rnf6sFTYmBmAPv9Aha7dXYStGrzUMxAXmn3gfJnogjsg4BW?=
 =?us-ascii?Q?F1yCrfTyN+XzJ1YOmFZzVfryRymMlHSFVUCtzQ6/RgEQz8amqrynZzCAoNJf?=
 =?us-ascii?Q?R4ZMcL9z+emH+r5Yo2oilaU3JJy1Bb99zdvdiDMsaIkvdBNSBk6HEeSH9YMu?=
 =?us-ascii?Q?4ElPGHwYrrw0JkhxbDw2CCffHQ1diN4CfmU1dNvH24GGIt7nCR+HBoZxJs5u?=
 =?us-ascii?Q?9Wt7rfkDg6UEekHTKBUFz1SYXlUDR7sIAYEGOLsJCWbaW6HGxqiSOE73RX2j?=
 =?us-ascii?Q?oVImmUbE7h8TKx6guBdv1rXCoidVQ8niBpoqT2QRNBbt78EV8+HFs8L+mG7g?=
 =?us-ascii?Q?lmSwAievQpz9d0ImeslNSMXxabdfoeYEgbZOoqviLOgENkg+6sNmgsZJkdAm?=
 =?us-ascii?Q?YYrEb3cpHlpUYfvwBglrDRsjoTizfpdQuEt3f9IqSKi0dE1YDoCfMpuvvjt5?=
 =?us-ascii?Q?0Zk+QDm5sP9tWxjRX1kOkB7p7XPgqDY/MNGdVt1ssN4JSWEj5EXJd0TpfvgW?=
 =?us-ascii?Q?Z7JVs33yMJ2n9yrRaxI=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 04:26:29.1695
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a96bf26-170e-4262-1071-08de3d24731a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF665EE4E73

From: Jason Gunthorpe <jgg@nvidia.com>

If a VM wants to toggle EATS off at the same time as changing the CFG, the
hypervisor will see EATS change to 0 and insert a V=0 breaking update into
the STE even though the VM did not ask for that.

In bare metal, EATS is ignored by CFG=ABORT/BYPASS, which is why this does
not cause a problem until we have nested where CFG is always a variation of
S2 trans that does use EATS.

Relax the rules for EATS sequencing, we don't need it to be exact because
the enclosing code will always disable ATS at the PCI device if we are
changing EATS. This ensures there are no ATS transactions that can race
with an EATS change so we don't need to carefully sequence these bits.

Fixes: 1e8be08d1c91 ("iommu/arm-smmu-v3: Support IOMMU_DOMAIN_NESTED")
Cc: stable@vger.kernel.org
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Shuai Xue <xueshuai@linux.alibaba.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 12a9669bcc83..a3b29ad20a82 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1095,6 +1095,15 @@ void arm_smmu_get_ste_update_safe(__le64 *safe_bits)
 	 *  fault records even when MEV == 0.
 	 */
 	safe_bits[1] |= cpu_to_le64(STRTAB_STE_1_MEV);
+
+	/*
+	 * EATS is used to reject and control the ATS behavior of the device. If
+	 * we are changing it away from 0 then we already trust the device to
+	 * use ATS properly and we have sequenced the device's ATS enable in PCI
+	 * config space to prevent it from issuing ATS while we are changing
+	 * EATS.
+	 */
+	safe_bits[1] |= cpu_to_le64(STRTAB_STE_1_EATS);
 }
 EXPORT_SYMBOL_IF_KUNIT(arm_smmu_get_ste_update_safe);
 
-- 
2.43.0

