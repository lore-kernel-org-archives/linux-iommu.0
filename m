Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013045.outbound.protection.outlook.com [40.107.201.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A1D39657D
	for <iommu@lists.linux.dev>; Tue,  3 Mar 2026 20:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772568833; cv=fail; b=g0FOMhuS3huXFffSomC9acpecusedXB2417AkUmuPJKOdudpwR73YLLo/cRpcBKhWzojmTtEYQO9irhY3e36VqLkDKjk71R4VIBMfMN4sD8G+qIV3/M31EyRZG0osi+Xj/GNN5BXBrH835F1a8i3AWjXrte3oiPpNpyDV2XVDUs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772568833; c=relaxed/simple;
	bh=L7+d75mdqwtcNTNxIiWZjiURKgaU1cNMx+XojBAyB7s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sUZrjvWrVUdB7duuwt3b3vi/P2i2HkHW+XFb0H9v2xzl/PcgD6TilUW87NcQCfCUbylHOhyV1ohGVie3VtlWv28TkFIUnRt14cISuEl0K6qpIZZBk+Idc4/bMybMdFKYY+BYLb9j1ot5EXsYPzBe2Kt6aBzA584iGZSUm7PL2vg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=n7i1+vb4; arc=fail smtp.client-ip=40.107.201.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="n7i1+vb4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XSjexfwmxn450YLjBhhhSHZ7EEInWBCyYqW6K8cyxrCGJhV2CbkljBu5nB+9wU+OUW2A77kmtXOFm/0Xz6VfokuJivk5PxUQ8j7TIvuzWhr6ib6E0sJWjN8Oi9nDnmo3aPTBCadrXVBjOPWVrMs6wSetunG+fZch36obuiPTRmje5Hv4opNEL1fUiXxga9hmGxI8DlzMYDej+M/RE0/6XGv28MBSaJxkQ7089RQmxtkY5ibhsMPPormbTvCQiRALjNtS3XavAQToLPb849ryqXzmOwuNgWMzIQwIzRCpUsLABO661QCtw2K63pi+eYfcLJizIjGAan3fHRrdV1ij+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1c3d6cFSt8gmRfKS/lv0LfxlDCoGiAx+ugoDUdZoilY=;
 b=m8blW9uPLTi5g0z0Vmj45GuxNAkVsSYqEKH7K/pGF1zu7kv/2zI+heB9BwbfbwpazZYR/SOZufoGrvTOnoJnDaDM9b+AIHybj+ECMaapIPvHhakvcv3mgsJ2ZaMU0voTVvLPTn2T9krmdb2rXdAEuS0BqN4nRyZSRTleYLBrfu+TJbNFbwyE/GhOHnjhzkMAFQyrRPRTji1ZOhNFzOODTwCCJ8OMFHvtD3i+Qd9T0m92cmjdd9XnrLP1yHWf5UBfz1ftb5I+FbxtvUQLNKyKg7DpBuag2Nd0IXGY6Dc6/AejYiwBN7LoyPYOxk52+TU06w670P00AOUVAKjaHRRzWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1c3d6cFSt8gmRfKS/lv0LfxlDCoGiAx+ugoDUdZoilY=;
 b=n7i1+vb4mjHNUCABl7cQNhwgD6OCSGNNP/CYX5JRQe2bDnvijUEKgcB6M/+T0NQXBd/Qb/Bju+l8jfjXgMXzU0xlZ9EjmI9oLltg+v55VpiA1/t8TklpK5BhQ8JiY63oG1j1dHc2vDVtMCVDEGC1xxMk9RZitb9n0D1s3P4M20rd5jI0HrDYruEjdjIlc8Ad88CqtwePbdyIHnHA1F2Coo6V1pj7qmbLQplJ3IR3NNn5HA/w4F9ys6bKbQ2lZQbqWY6UBk2uBatMk29HTP0jfd1EBfkJZf9vTp0EwB+rblpFCigQC2yFZQGLg8Sr9DO5o4c2fIe8ANvfNqZOZApy7w==
Received: from CH2PR18CA0045.namprd18.prod.outlook.com (2603:10b6:610:55::25)
 by CY1PR12MB9673.namprd12.prod.outlook.com (2603:10b6:930:104::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Tue, 3 Mar
 2026 20:13:45 +0000
Received: from CH2PEPF00000141.namprd02.prod.outlook.com
 (2603:10b6:610:55:cafe::86) by CH2PR18CA0045.outlook.office365.com
 (2603:10b6:610:55::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.22 via Frontend Transport; Tue,
 3 Mar 2026 20:13:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF00000141.mail.protection.outlook.com (10.167.244.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Tue, 3 Mar 2026 20:13:45 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 3 Mar
 2026 12:13:24 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 3 Mar
 2026 12:13:24 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 3 Mar 2026 12:13:23 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>
CC: <joro@8bytes.org>, <praan@google.com>, <mmarrid@nvidia.com>,
	<kees@kernel.org>, <Alexander.Grest@microsoft.com>,
	<baolu.lu@linux.intel.com>, <smostafa@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH RFTv1 3/3] iommu/arm-smmu-v3: Support PRI Page Request
Date: Tue, 3 Mar 2026 12:13:07 -0800
Message-ID: <ae9a953251b46b49bb0ca4289d1f3b614ba5d6d7.1772568590.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1772568590.git.nicolinc@nvidia.com>
References: <cover.1772568590.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000141:EE_|CY1PR12MB9673:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b1cf3a9-ac54-46b0-25a7-08de79615f7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	jcLVYYqkO+781SJrBsYkv1W3YHNUftvhc8JyAElMPiqjZ3EP5KzttW68UoSQ2NsbXBNGcD5rbtONQ24At6yWwakK7sFiHHIcT03CwiPWAyQ9S083we7u59DMgPdlxbSu3u7GG1dDXE01CQXFspVcwkAPwbpFwZcCSQdgAK+TpRCVToIsRhO9m8AtoV3zyeOY3FEg1IEWAt7NrudxGzUpG09V2hMCBV3k4xZnpW4M9KDXjIhV5M621l5n+yY6aL6tM1dgrAAJytLOmPGvOLWK6z9+X+dzvbSNDB0COird4dLNnYG8ZC6zXbxtWw8jjyQ5T3tNjCl7O1tAomcQwM+lEtu7ePotRbWvCA69fOniFlUC/Ybth3/Iv6xhAa3vkKb0DE7d7bORQUFUY+mhRdZ1tzsfesNF6l8fJE+6BtkVpcaftJjkXloJn1zUegFXmerNrhWrVuOBNidhLjKtRnJ+0yW+pBRJsxoYkSq7HRuLaSIE9xVbkk0L1/cG+OLVLfbop5PLMyKn9uFdB9SEWw5iS7JD0VtJHbBk9BdfDqdt+ksmW/DIJsgNvj32Uyl12Q9k/i9JstXB9rTlLufTTwZlD74MMjX9CeOA9X837s1Zun8s8tm1bT1RW/6U1AcrUqdsKlSAjRiV8WDsdWqsTVNAkq9wdiXQoFy9sS84cWgQ+NNy8AA9YmULJqSBA82YftsiRfczd+DdH57GOZvLyD7aG+aTylcPDKWdntTcbuS9yzp7IcXrrE0fhKm+QgvBTaNjLIR6pchkkM0A9ZWJcvspR9tNiuqXHLNwKLaItv5yH+chcLpX7ggY6m5c97ZrjntSJns5dpmhA/0FJ6gY9Ujq6A==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	TwYYtjvFTIabay3Ffn4DOakYG0IRXoYY9B7Nzv9/5gkzyitZ3MQ6zcT4wJzKWQJ72BBGmW8OJIYGV3I+3x0gaTlU8NTQt2nowGc+R2yPbk/5qFFrzEbS7U03tsFklAaqrXnIbLkgAsl2Pnne49+ymworSM8EaJzZUIVN8RLfgYP6HpV7Dfgt97gNdEDJQjwAgrRAVO1y4zjDp1ZN3iDH+xXekAEw7bCUjix2ljEV7DHX3AFmg3ZPegdlsxIjho3Plk8pzNSZqzQIeadJ/UPD3XH/Edsa0mx7/xAc1UPJiVDYSrpxnr2jdbSr2eBEUmVwfUyjV5+jSYm2gmMellXxGwFjmFsbb+K9yvdFOImGEhoZCITZLSa0Sat2zUVE+lXOgriwLjEbFWJQ+6TLiTmKrrH6RljsM5bBwhbVNvheUKKu9As842ARYe45uxCQLvIU
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 20:13:45.2569
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b1cf3a9-ac54-46b0-25a7-08de79615f7d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000141.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9673

From: Malak Marrid <mmarrid@nvidia.com>

Now, arm_smmu_page_response() can issue CMDQ_OP_PRI_RESP for page requests
from the IOPF infrastructure. Decode the page requests from the PRI queue,
and report it to the IOPF infrastructure.

This fills the final piece for PRI support.

Co-developed-by: Barak Biber <bbiber@nvidia.com>
Signed-off-by: Barak Biber <bbiber@nvidia.com>
Co-developed-by: Stefan Kaestle <skaestle@nvidia.com>
Signed-off-by: Stefan Kaestle <skaestle@nvidia.com>
Signed-off-by: Malak Marrid <mmarrid@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 65 +++++++++++----------
 1 file changed, 33 insertions(+), 32 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 055dde5367131..277d753c7675c 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2061,40 +2061,41 @@ static irqreturn_t arm_smmu_evtq_thread(int irq, void *dev)
 
 static void arm_smmu_handle_ppr(struct arm_smmu_device *smmu, u64 *evt)
 {
-	u32 sid, ssid;
-	u16 grpid;
-	bool ssv, last;
-
-	sid = FIELD_GET(PRIQ_0_SID, evt[0]);
-	ssv = FIELD_GET(PRIQ_0_SSID_V, evt[0]);
-	ssid = ssv ? FIELD_GET(PRIQ_0_SSID, evt[0]) : IOMMU_NO_PASID;
-	last = FIELD_GET(PRIQ_0_PRG_LAST, evt[0]);
-	grpid = FIELD_GET(PRIQ_1_PRG_IDX, evt[1]);
-
-	dev_info(smmu->dev, "unexpected PRI request received:\n");
-	dev_info(smmu->dev,
-		 "\tsid 0x%08x.0x%05x: [%u%s] %sprivileged %s%s%s access at iova 0x%016llx\n",
-		 sid, ssid, grpid, last ? "L" : "",
-		 evt[0] & PRIQ_0_PERM_PRIV ? "" : "un",
-		 evt[0] & PRIQ_0_PERM_READ ? "R" : "",
-		 evt[0] & PRIQ_0_PERM_WRITE ? "W" : "",
-		 evt[0] & PRIQ_0_PERM_EXEC ? "X" : "",
-		 evt[1] & PRIQ_1_ADDR_MASK);
-
-	if (last) {
-		struct arm_smmu_cmdq_ent cmd = {
-			.opcode			= CMDQ_OP_PRI_RESP,
-			.substream_valid	= ssv,
-			.pri			= {
-				.sid	= sid,
-				.ssid	= ssid,
-				.grpid	= grpid,
-				.resp	= PRI_RESP_DENY,
-			},
-		};
+	u32 sid = FIELD_GET(PRIQ_0_SID, evt[0]);
+	struct iopf_fault iopf_fault = {0};
+	struct iommu_fault *fault = &iopf_fault.fault;
+	struct arm_smmu_master *master;
+
+	INIT_LIST_HEAD(&iopf_fault.list);
 
-		arm_smmu_cmdq_issue_cmd(smmu, &cmd);
+	fault->type = IOMMU_FAULT_PAGE_REQ;
+
+	if (FIELD_GET(PRIQ_0_PRG_LAST, evt[0]))
+		fault->prm.flags |= IOMMU_FAULT_PAGE_REQUEST_LAST_PAGE;
+	if (FIELD_GET(PRIQ_0_SSID_V, evt[0])) {
+		fault->prm.flags |= IOMMU_FAULT_PAGE_REQUEST_PASID_VALID;
+		fault->prm.pasid = FIELD_GET(PRIQ_0_SSID, evt[0]);
 	}
+
+	fault->prm.grpid = FIELD_GET(PRIQ_1_PRG_IDX, evt[1]);
+
+	if (evt[0] & PRIQ_0_PERM_READ)
+		fault->prm.perm |= IOMMU_FAULT_PERM_READ;
+	if (evt[0] & PRIQ_0_PERM_WRITE)
+		fault->prm.perm |= IOMMU_FAULT_PERM_WRITE;
+	if (evt[0] & PRIQ_0_PERM_EXEC)
+		fault->prm.perm |= IOMMU_FAULT_PERM_EXEC;
+	if (evt[0] & PRIQ_0_PERM_PRIV)
+		fault->prm.perm |= IOMMU_FAULT_PERM_PRIV;
+
+	fault->prm.addr = FIELD_GET(PRIQ_1_ADDR_MASK, evt[1]) << 12;
+
+	guard(mutex)(&smmu->streams_mutex);
+	master = arm_smmu_find_master(smmu, sid);
+	if (master)
+		iommu_report_device_fault(master->dev, &iopf_fault);
+	else
+		dev_warn(smmu->dev, "PPR: unrecognized StreamID 0x%x\n", sid);
 }
 
 static irqreturn_t arm_smmu_priq_thread(int irq, void *dev)
-- 
2.43.0

