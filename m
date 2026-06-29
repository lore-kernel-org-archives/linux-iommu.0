Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010062.outbound.protection.outlook.com [40.93.198.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 091153C3C16
	for <iommu@lists.linux.dev>; Mon, 29 Jun 2026 21:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782767788; cv=fail; b=BbUiafwOUvtx/tXWDOW3WM68v4T0NqRi7FNAp2WrYfee4u/LtUVAG5pdBNDDOrdNVVIYgCDJW/lUs9bZ7x0viXY+yorqDAeNZ0JBN8wgJLo+xlT7p1/zNhdNz5cn3pm0GL4G8kyQRYZYMHKFjxAulrog7c6UKHWU2no3BsmvyQI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782767788; c=relaxed/simple;
	bh=fg30cedk8y9aGejrHEBF7q79FEDOeczdK4qgkEC4Adw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eFQFp70zsXCEcG5KcmARnaQkUcI4Y1Dr7TYVv0BdfTjfJAasxyQIBfRRlvmaFt8KY2RmZ8ouzDtNxH0viJV9rx1VB2nfCUVNDIEV2xGyYrzeFa2gegPOp719u+lQYhKGIqU4IfOcPur7xwQj5cpwjxD81IMI4UeSlagrDr1jh3M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sKftL+im; arc=fail smtp.client-ip=40.93.198.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sKftL+im"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GuiEUIGhdEanblwf4xFfG8UysAjQXJZOTtffY2xHm/BJUpAVn9yu0jLtfumY3pMsN5csYxb+8T+iNsu8alo5Ym6trpvavE2Befsuu+5nTI7agPSMiT5KgtIMG0qlYF0VXqKrbwwosnoZhH/vSlpAYB2ZRwb0/YIX+BzKmGUy4mjh4IdPiAzZO406Alw3zbjBIjFr0KzHwqo+Xk8g7Y+LTMglKDN1ugN9FQMZqK64q7Qh9PNp0Q/1HNk2GUDc/plJFpdF6OykRvLjWKfBCBJNKmDZuk7IN9ZUUahNqYlYZ5anhorSXjNrAmKi1BCtKthWRUvqPjzqkVek/OJyFIsn7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4GWE4vM7S/dsKZMfvr7Odq6DhUIP+54cTPBb7tgeU/4=;
 b=s3JTcJFTzaEMdf8O3LchcjUa0h6nSKi0aUM/Z6Fkpd3RxSNa8Lz3sLGe0PTOgnsm9gDQ48jRjgZKJJP1BQDgADRXQtxF+eQcTT2PwleFxNgC4+Dbf7vqZgTiy0HcXQc921z70dqf7EwP/k8kotzbMd+o8R3XOEpveLdW0nbxmfTBMFj3qMSdrV1Hens2tU9N5/YEq06YAK7wTclwuTPbNYFNR4P86FRp4rmLGQtI/itHDRbNDCeKScaqQ4KmLVCYclfkUZqslELm85Q65rr18757aBSHaFUGEAkz9se8PxTo8D4ZOJXxZSEz/LjSLTSpKhaDgPAKbGkc6fim1D91gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4GWE4vM7S/dsKZMfvr7Odq6DhUIP+54cTPBb7tgeU/4=;
 b=sKftL+imtIQJNk5T87t5GvW6DccKcQqp7/ndtfexMNF1K4Nuxd5Nc1d9EHAcG2cRP08/ZNJoU9yiBYcYWiBKWbrv7WWR9X2ENOKQBP3HOp9brcpcoP833Ltq3dnqM3BdFCghi4cDTMWqOf+JLqbFs6ckY25j9eQNUz5fcbhlnaVpWhL8sf/t3HsEUZ7mOS/M/hdy/Mj81quRNTq0oPLStQn50UL7B0okT9ZI5Ou6FqN7d6H4dl1Wxx1m3hSn+4sTU1Il9hZLMK6Z6smnieTh5uyp1v9rGRyEdkWlGU/a25AyO0e6CheiX2ws3aivElhT0YSTxE+w+DpmBuXTjDHQNg==
Received: from MN2PR16CA0052.namprd16.prod.outlook.com (2603:10b6:208:234::21)
 by CH2PR12MB4261.namprd12.prod.outlook.com (2603:10b6:610:a9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 21:16:19 +0000
Received: from BL6PEPF0001AB53.namprd02.prod.outlook.com
 (2603:10b6:208:234:cafe::9e) by MN2PR16CA0052.outlook.office365.com
 (2603:10b6:208:234::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.19 via Frontend Transport; Mon,
 29 Jun 2026 21:16:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF0001AB53.mail.protection.outlook.com (10.167.241.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Mon, 29 Jun 2026 21:16:19 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 29 Jun
 2026 14:15:57 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 29 Jun
 2026 14:15:56 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 29 Jun 2026 14:15:55 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>, "Kevin
 Tian" <kevin.tian@intel.com>, Lu Baolu <baolu.lu@linux.intel.com>
CC: Robin Murphy <robin.murphy@arm.com>, <joro@8bytes.org>, David Woodhouse
	<dwmw2@infradead.org>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 1/5] iommu/arm-smmu-v3-iommufd: Reject unsupported bits in invalidation commands
Date: Mon, 29 Jun 2026 14:15:36 -0700
Message-ID: <eb89a1c564956d9a2ba1d56bd76d57defac205aa.1782767398.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1782767398.git.nicolinc@nvidia.com>
References: <cover.1782767398.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB53:EE_|CH2PR12MB4261:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a485536-64c1-40ac-e373-08ded623a9e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|82310400026|36860700016|3023799007|56012099006|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	9eTjLTLh6GA1Ef1jR9stAoUWdBMf3kHfjrFaQepxB0C2L7OK/ng6Dxd5JnO0Madz1rRn7BfJNb81+Yvxt63s/m4+xRaJt77cIhQwA9oFvb2xU9M7GJuVSD/p1uIVaMJyf9Wx+iUSN0BDpAd5CKjjonXF5xs4IVETpJz4EATJfSqn/dIcvJTgIFwfM7efP/QPMjtMfX9GkiXZ0BY1rJqO0i5yjn3R8vvMRTx0U+MrYkLm7E0dS0HFjd2y+LoXy7k5bl5gBeinj3HQ63fHGYyKaTab5NDVOpaeNieUUjLKhf7fYuVOLrnD67oZAHxrkI4mQbkuj0IUjSHrQSl9luroPfiiclqP3M18SNNn2zJuQ3IH1sgPCE98DijeOYGETwfixxEA/fqcRIUrLlTg51MHg9tjVM8l6jofWn5a1SpBGhtscncaSc3nIB9s1hmxUfLzKXAN7ux1dp1ldJ19qoVTV74Rr8oSS21IZyzEUhaXmEn7WROLDubKC4NOvq+hyBSDaWt6Km6G+DBFZjCVjwi4Kj/3GgZH2wUhUcMEqaxeiDJy1P9Ead4q4w6gYdPj/E2mn70MSKxjQYAfYL+O6n0oBqoaWRisv+z17+KQC6jndY7XaKVcBU2IEVzfhrUknFV9fGbGuL+PZtlmKPqRox/vVwe8ktoI7CGoEo3pRD7OuCs2iWhA9yYcBas5Z1LWF5xJQgKCPXwBchl0eIUKtTHASA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(82310400026)(36860700016)(3023799007)(56012099006)(22082099003)(18002099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	tq6KyWon8u4iAF2b0QTGIEeih2j0tZVEp8qZw1LpZZdlGCXAzjtB+jzCs6g9GdFNmq5qtaXeN9NYHSCVJaKcZQkU1LucM3/UpOitzZTTZg8+rY3h/XCSl3/Ou4J2X7ghA5Zlp2siTlarFGJwtP0uS4ICwsqmmxZ7H67AT113Du2xf9LypFaRfwxcCvW8W23q/zX4iazg3EMls3RWknyrLBCHDjPzFCT7yHGYI2sVedp1y8n5plttepWcVD4vQDZYlMnbdd/AvhgyI9u4oQ158MugNC9OvT4CLWnzMbSdFJpmO5tVf0eNZgAjXuoaPeL71XDsvrhx9Smy5ZlP5XGMzwXiElZ+oR4DZc27fCI/2vhjR9sScdAUNB3lpJckOvoN6YpxnyH3WRFucml8p5mS2Clp1y/HRDHtioa+uNcmFMZFNoQGsXGms1zgSbqnYJbl
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 21:16:19.3886
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a485536-64c1-40ac-e373-08ded623a9e4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB53.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4261

The arm_vsmmu_cache_invalidate() op hands a guest's invalidation commands
to the trusted main command queue after enforcing only the VMID or the SID,
and passes the rest of the command through to the queue unchanged.

That lets a guest set bits the host never meant to forward, in two ways. A
bit can take the command out of the guest's own scope: the ATC_INV Global
bit, for one, makes the SMMU ignore the SID and invalidate the ATC of every
device, not just the guest's. A reserved or undefined bit instead makes the
command malformed; per the Arm SMMUv3 specification, in its section 4.1.3
"Command errors", a CERROR_ILL is raised, among other cases, when:

  A valid command opcode is used and a Reserved or undefined field is
  optionally detected as non-zero, which results in the command being
  treated as malformed.

Restrict each opcode to the fields that the driver supports and reject the
command with -EIO if it sets any other bit, before the command reaches the
queue. This keeps a guest scoped to its own devices and stops the host from
forwarding any bit whose meaning it does not control.

Some fields and whole opcodes are legal only on an SMMU that implements the
matching feature, so accept them conditionally. The NUM, SCALE and TG range
fields need FEAT_RANGE_INV. The ATC_INV opcode needs FEAT_ATS. Per the same
specification's section 4.5 "ATS and PRI", CMD_ATC_INV is ILLEGAL when:

  SMMU_IDR0.ATS == 0 and this command is issued on a Non-secure or Secure
  Command queue.

The SSV and SSID substream fields require a non-zero ssid_bits, so without
substream support setting them is not illegal but CONSTRAINED UNPREDICTABLE,
which a guest should not be able to provoke.

Fixes: d68beb276ba2 ("iommu/arm-smmu-v3: Support IOMMU_HWPT_INVALIDATE using a VIOMMU object")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 .../arm/arm-smmu-v3/arm-smmu-v3-iommufd.c     | 58 +++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
index 1e9f7d2de3441..393d69783225c 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
@@ -315,10 +315,64 @@ struct arm_vsmmu_invalidation_cmd {
 static int arm_vsmmu_convert_user_cmd(struct arm_vsmmu *vsmmu,
 				      struct arm_vsmmu_invalidation_cmd *cmd)
 {
+	u64 allowed[2] = { CMDQ_0_OP };
+
 	/* Commands are le64 stored in u64 */
 	cmd->cmd.data[0] = le64_to_cpu(cmd->ucmd.cmd[0]);
 	cmd->cmd.data[1] = le64_to_cpu(cmd->ucmd.cmd[1]);
 
+	/* Collect the fields userspace is allowed to set for each opcode */
+	switch (cmd->cmd.data[0] & CMDQ_0_OP) {
+	case CMDQ_OP_TLBI_NH_VA:
+		allowed[0] |= CMDQ_TLBI_0_ASID;
+		fallthrough;
+	case CMDQ_OP_TLBI_NH_VAA:
+		allowed[0] |= CMDQ_TLBI_0_VMID;
+		allowed[1] |= CMDQ_TLBI_1_LEAF | CMDQ_TLBI_1_TTL |
+			      CMDQ_TLBI_1_VA_MASK;
+		/* NUM/SCALE/TG are range fields gated on FEAT_RANGE_INV */
+		if (vsmmu->smmu->features & ARM_SMMU_FEAT_RANGE_INV) {
+			allowed[0] |= CMDQ_TLBI_0_NUM | CMDQ_TLBI_0_SCALE;
+			allowed[1] |= CMDQ_TLBI_1_TG;
+		}
+		break;
+	case CMDQ_OP_TLBI_NH_ASID:
+		allowed[0] |= CMDQ_TLBI_0_ASID;
+		fallthrough;
+	case CMDQ_OP_TLBI_NH_ALL:
+		allowed[0] |= CMDQ_TLBI_0_VMID;
+		break;
+	case CMDQ_OP_ATC_INV:
+		/*
+		 * Exclude the Global bit: it makes the SMMU ignore the SID and
+		 * invalidate the ATC of every device, not just the guest's.
+		 */
+		allowed[0] |= CMDQ_ATC_0_SID;
+		allowed[1] |= CMDQ_ATC_1_SIZE | CMDQ_ATC_1_ADDR_MASK;
+		/* SSV/SSID require substream support */
+		if (vsmmu->smmu->ssid_bits)
+			allowed[0] |= CMDQ_0_SSV | CMDQ_ATC_0_SSID;
+		break;
+	case CMDQ_OP_CFGI_CD:
+		allowed[1] |= CMDQ_CFGI_1_LEAF;
+		/* No SSV for CFGI_CD; SSID requires substream support */
+		if (vsmmu->smmu->ssid_bits)
+			allowed[0] |= CMDQ_CFGI_0_SSID;
+		fallthrough;
+	case CMDQ_OP_CFGI_CD_ALL:
+		allowed[0] |= CMDQ_CFGI_0_SID;
+		break;
+	}
+
+	/*
+	 * Reject any other bit, e.g. a RES0 bit or a Secure bit, before the
+	 * command reaches the trusted main cmdq, so a guest cannot wedge the
+	 * shared queue for every device with a CERROR_ILL.
+	 */
+	if ((cmd->cmd.data[0] & ~allowed[0]) ||
+	    (cmd->cmd.data[1] & ~allowed[1]))
+		return -EIO;
+
 	switch (cmd->cmd.data[0] & CMDQ_0_OP) {
 	case CMDQ_OP_TLBI_NSNH_ALL:
 		/* Convert to NH_ALL */
@@ -334,6 +388,10 @@ static int arm_vsmmu_convert_user_cmd(struct arm_vsmmu *vsmmu,
 		cmd->cmd.data[0] |= FIELD_PREP(CMDQ_TLBI_0_VMID, vsmmu->vmid);
 		break;
 	case CMDQ_OP_ATC_INV:
+		/* ATC_INV is illegal unless the SMMU implements ATS */
+		if (!(vsmmu->smmu->features & ARM_SMMU_FEAT_ATS))
+			return -EIO;
+		fallthrough;
 	case CMDQ_OP_CFGI_CD:
 	case CMDQ_OP_CFGI_CD_ALL: {
 		u32 sid, vsid = FIELD_GET(CMDQ_CFGI_0_SID, cmd->cmd.data[0]);
-- 
2.43.0

