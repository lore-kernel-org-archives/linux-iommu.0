Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013032.outbound.protection.outlook.com [40.93.201.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB4335E1A3
	for <iommu@lists.linux.dev>; Fri,  3 Jul 2026 05:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783056743; cv=fail; b=bCN611erZx7RdCiyfbXyiDpfScx4fcnRNNd/Qj/9mMTPuhPXdYQ7nSxvEA+BuwHM41ujfdbGT48Vlm078bRm2K1bady+4eAwERpO/EIj1fdw+rk+8RJZxRrRyNlVtA1rfK+48iBxgWeoGD+VHvhaFnvFoZjCMnKDjFYHN9FeaFQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783056743; c=relaxed/simple;
	bh=7RccDXEjPegTJb3e+CEsefpPRrO6Aw2jvAGoWzoh5UU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sPi5GUUhZ0PqeXQ3aWVabi8+yEfwo5gIs8BWFRTrkpNE1BepjItaF3eAPyPQWgANbSPN3pkr4oitRt0QdbIJ2MzogRgmiU34tDm/vdgq4fUHc0whR9B4a/GOBwJTm28cMgI+mFfcodDWvQ61LDYuE1oI5kvj5+MONGJFK+CmToo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=b4VDI9hB; arc=fail smtp.client-ip=40.93.201.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="b4VDI9hB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bP2/NoTRBgLXl7a/OnSWh2tTvnbrh+u5vvZ/h8s+yqzw7VAWAaGJpvyrjGzkIAckdkAj+e6anTYYSpOmWwKqLBPpVIu56CkRRmHtexeb1kqRmiC8crhPZqqsqCj5igklNWF9i7jWpvED2z5MmIXm6119Op/G/dED9cvsHgdUB52M+rYWPGqw6ilckKWyuH0MMt2OPPwVS5ne0SStMbERT0daJ2PCwwxAFepNC1jRS3KAeI/u54zt4PPTLRiwlzujGcjuQW6Enw5PezxbBQvN6ienrHFF9yJALzWoYDbFZWT1Jqltvt7q4MN7f7qqAd8pcbSxpbhXdQMrM41WhCJOnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ok+ynoNm7HBcA6o57DfDGNfMNYje4Aaelww8xJ0KADI=;
 b=svX36mlca2LhVU/FQsWZ+0JABo5r18snMLWcHFA2FeiB/03a65mexy2uEi+CihuxFy99Pio+zwt8aHJj7nP0i1q5cMJmAM4ZVqe8Z/47jaMoxgFvk1Si21JowVCUoHDd7WTIV6GI3MTnqDk11EtiK9Ly/0bYSYzqg+xJ7T34aQlDJjzWIlhVv+Bs5wzMGvsLcndjiADDut854h4eDyxFH0BxFuKkwYsK7BJqlN36NBIYToxIQ4mTVAij87e/LQVa6Fi8rh+Yof4PGYOqlx149rnZ2AhHQROp8B5WA9ViwLzWTLdTs2GuUg8ncz9ir+V11y3TV6XUTTxHcTrq94XKZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ok+ynoNm7HBcA6o57DfDGNfMNYje4Aaelww8xJ0KADI=;
 b=b4VDI9hBXmk62kw33TIwKD1yZZaUgjHneACua38MahUnEB/N8/86BHTHxyRjA7sa5wOJRWDd3FqX0QZ0Tv9JCOnM3qQNcCA2F/YASKU47JImAWu87AWGyyl+Tj8FKe/ZMu2PZKICjOjocCEeNMdEbf5LY++LR6jMPJJQwk1vygwPZc8cCL2sE0uKmd3B5Rfz4ZIj1KBOj6VyONNorEezS2umQgpNiPaHKVuW1TQ/ijQhAt97lZIZePs7/TC/KiXujU25ZNo2dcB6Wnd50JMtvLBDxEx6dWsvKO9Sxu2pCfHjSlQ/qt5ODZ3volgB6LnrRd8wp0qkujpdbLaWUtVn6w==
Received: from SJ0PR05CA0025.namprd05.prod.outlook.com (2603:10b6:a03:33b::30)
 by MN2PR12MB4440.namprd12.prod.outlook.com (2603:10b6:208:26e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Fri, 3 Jul
 2026 05:32:06 +0000
Received: from BY1PEPF0001AE16.namprd04.prod.outlook.com
 (2603:10b6:a03:33b:cafe::4b) by SJ0PR05CA0025.outlook.office365.com
 (2603:10b6:a03:33b::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.3 via Frontend Transport; Fri, 3
 Jul 2026 05:32:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BY1PEPF0001AE16.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Fri, 3 Jul 2026 05:32:06 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 2 Jul
 2026 22:31:54 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 2 Jul
 2026 22:31:53 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 2 Jul 2026 22:31:52 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Will Deacon <will@kernel.org>
CC: Robin Murphy <robin.murphy@arm.com>, "Joerg Roedel (AMD)"
	<joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
	<linux-tegra@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 11/11] iommu/tegra241-cmdqv: Rate-limit the error ISR's log message
Date: Thu, 2 Jul 2026 22:31:37 -0700
Message-ID: <a9c69105db646f63a97e3d2cec9a5f3d1afd7467.1783054570.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1783054570.git.nicolinc@nvidia.com>
References: <cover.1783054570.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE16:EE_|MN2PR12MB4440:EE_
X-MS-Office365-Filtering-Correlation-Id: 98eeeb6d-2bbe-41b7-7083-08ded8c46b7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|23010399003|376014|36860700016|1800799024|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	Ky5GLqtdYosD7KPhFwz5NqhEvK6LjruP0PKmO1kIgAzOE7PGxyZ8LdHA0HRA6JdyJX1DH6fol2LXTJDbtDU+WZCRnqpJs4h9kPvQLHo7tvIyY93IMf7XYs5q9CZy6EHfHhOodAr+aI9V+qnaP4xg/n43le99F5WmGnR4kKoUNauJqCTyuWIMeFc8UPZKQef8KGplnWvbd4UaR4U83SAY4DJuxppstwLtm+y1KnXK8lzRBpphKFhYNo5FMhivLZYsgLmQhc3zJSEmA2nOWtzC4gAcr2CFl7BAWUamPraYvrUt056vAiq7Qp1vThfxD3184zWt/6pX9CQkPw0slc2yH3XsioxA4NqLHrUAXzKvQlzbCdIfVNDZ8qFbLHlyg7JGMFrC6EfNA8xyXjij9MDHGqbdIi96yqVLJ3IIRTc1p6waOy/tdyiZSa8vuXkUpyzRgDo0G+jm16F8V8Uwe0hhQISS3LvlbN+9Gus3f5LEWeqxcAp4hAuOwjIEvUfOcN4l27pYkdsjFg0OO5MDXtGIFPjtXsbkKgre9yXQYS6bLDRv5+e6GpPyYBTW/eSYQj6K5DEdihRZFRa6XuWl4sjs0e5N7AGIYeyTAI7DBz38k7Ro1zOaAltLxn0MCdc+Ikpq2EZJyORGGdNnAbK4h4xZy/y0KQ9bejigZbTMPCEVO+x4+UHcceE4Xk6in9ij0W5/LcdFeK6xuSDinp2xSff1jQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(376014)(36860700016)(1800799024)(18002099003)(22082099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	R39doLbZSHs261kElms8iH3Vr8ZIYK+7sKJpyWf5mK6QDVyirP51YirieDjwhUH1416wOfnGJTnl4QTYZ+SfWJvjs0T+wdfdHySRilrOcMFsMXZQ6QDH8nBp7V7CxfwivuV237+4TL/1cwCraRa9QHD9U9jHcNV8MaN+k0y5jOMiu2OuUbNC5REbRxTpQ7o1aMRXzBIZcyakNlH9zvops1beSCNIH1xq2e2EfmSdMEvicGaiFcoXw/bs3rx8SweSGPIkDBb/2WNMNqsc8Fz/gsvrAcwFijt7lf0k5Z03lBxhGGMAdDoUi5WAvM3wpl51jQCUXvCcn+k8Hga/Nuf59bhbo6Z+Wk2hexDDcGzqewxwnRZqCGqbLlXJO88h+gk67wloQATF7c/x9pw3adlUISX76T/Yo/dLJLKh/Xi75z4HU01Tv4mv/sZ9jC6nIAer
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 05:32:06.1190
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 98eeeb6d-2bbe-41b7-7083-08ded8c46b7f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF0001AE16.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4440

tegra241_cmdqv_isr() logs the error-map registers on every error interrupt.
A malfunctioning device, or a guest deliberately faulting its own VCMDQs,
can raise these interrupts rapidly, and the unconditional dev_warn() then
floods the kernel log.

Rate-limit the message with dev_warn_ratelimited(), and pass the error-map
registers straight to it so their four MMIO reads run only when the limiter
prints, instead of building the string on every interrupt.

Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
index 41046605de9ca..21a12a20e7436 100644
--- a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
+++ b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
@@ -353,21 +353,19 @@ static irqreturn_t tegra241_cmdqv_isr(int irq, void *devid)
 {
 	struct tegra241_cmdqv *cmdqv = (struct tegra241_cmdqv *)devid;
 	void __iomem *reg_vintf_map = REG_CMDQV(cmdqv, VINTF_ERR_MAP);
-	char err_str[256];
 	u64 vintf_map;
 
 	/* Use readl_relaxed() as register addresses are not 64-bit aligned */
 	vintf_map = (u64)readl_relaxed(reg_vintf_map + 0x4) << 32 |
 		    (u64)readl_relaxed(reg_vintf_map);
 
-	snprintf(err_str, sizeof(err_str),
-		 "vintf_map: %016llx, vcmdq_map %08x:%08x:%08x:%08x", vintf_map,
-		 readl_relaxed(REG_CMDQV(cmdqv, CMDQ_ERR_MAP(3))),
-		 readl_relaxed(REG_CMDQV(cmdqv, CMDQ_ERR_MAP(2))),
-		 readl_relaxed(REG_CMDQV(cmdqv, CMDQ_ERR_MAP(1))),
-		 readl_relaxed(REG_CMDQV(cmdqv, CMDQ_ERR_MAP(0))));
-
-	dev_warn(cmdqv->dev, "unexpected error reported. %s\n", err_str);
+	dev_warn_ratelimited(
+		cmdqv->dev,
+		"unexpected error reported. vintf_map: %016llx, vcmdq_map %08x:%08x:%08x:%08x\n",
+		vintf_map, readl_relaxed(REG_CMDQV(cmdqv, CMDQ_ERR_MAP(3))),
+		readl_relaxed(REG_CMDQV(cmdqv, CMDQ_ERR_MAP(2))),
+		readl_relaxed(REG_CMDQV(cmdqv, CMDQ_ERR_MAP(1))),
+		readl_relaxed(REG_CMDQV(cmdqv, CMDQ_ERR_MAP(0))));
 
 	/* Handle VINTF0 and its LVCMDQs */
 	if (vintf_map & BIT_ULL(0)) {
-- 
2.43.0

