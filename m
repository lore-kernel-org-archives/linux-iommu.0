Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011063.outbound.protection.outlook.com [40.107.208.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E577A134AB
	for <iommu@lists.linux.dev>; Wed, 10 Dec 2025 02:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765334759; cv=fail; b=B3pJR8usH+ynmOuizvzGrwlwQHXRbAVFobovBgpFNR1p+bIYpj+pLUXhem2R4QMLC4ywHPGH2Wqsc2sbvNYbQw4mETL1wrObik4NKrNUol9BWDJsUs8Cv05OhU03KCaAYAoZQI5O1kWNa51rB6Q9QLIIRT52iWXNM6NYBnGFMqc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765334759; c=relaxed/simple;
	bh=ID1BGbEkwWuTXDrpSviGl2Oj+MkrmQ1dCNT1Fi66OVs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FdLBf40OUI+RrFnCIZXWW/MmW/n3FWeqx20VwAzScINCU8NR3L1k6d0f2+i7TebAfbLm63nijxsMAbozR6iuS3tHAU3QwLepdEgTNSq7iO313PPavafw7Ve2mnmNjGrUME7wWnRRYmt57ZCmNi5jaEq3q5vlitbNc+RUdy9vbck=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=c3KCcLrU; arc=fail smtp.client-ip=40.107.208.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="c3KCcLrU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=unpnr1NksVlKJTj74/jtFSrEmRGKXNJIL/VO0PX6g7rR0FBIHg50MSH6X5K9NYiAlyy2W8pwUOp1SfMxMZgR78vIB7fKlga+++RCccX+bJKq39xNd1jo6khbcOtz1bvdDTt+j2aT0aD53uuK5+60f84X4Okp9tiA5LSPJdvP+/Ltoes3Dqj8uWjUI4ZDL11xvhbV6EMk/SqJZrsfuM9CG1uFKLMHlL1w+A1cM/HVFzM+1qLEsHQUmUYC7nV47xzqrroYgBOGdSHJSgcHV5TogwNjlmUBQZjsSjfRdDieDGUY9OD5Dz2ZjTHKnLPU+7Zs+wsMYg7wOt9A6Yo+qbFdGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8k1L25ZBrJSDO85/sm4B8edQVeyreBHRiG4bnD/M0VQ=;
 b=UjnKfN53q0gBCkpuUJcH3ffEnbtKuB5klrHHItVK5bsICMKvVVum+7WHL4JbpQR5MDlNo+xX6iXupB5rQ1gL7FiL/f2B232GuTtCEBZiOF2nNiP4ghUSq/xZs2tWUFeokRR0O3Lhzg2H4Ax5NNcNnA3FQWO1crXV5KewiwualNpCGvbLn6yI8pLIA6KqFecZaDOLG5OrNN3kCX2QPyEZf/Hzz+WbOPSN9WyKi7QmbdHrsVhX7EJLygiKvcoHPyab9NaEAIGZP4KYTO9UP/fUkqAa547Hab7xN20/BJds/SMJmw98e1yJVj1GaX9tiEL0R7ambyHrOU2dSzMAgIsogw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8k1L25ZBrJSDO85/sm4B8edQVeyreBHRiG4bnD/M0VQ=;
 b=c3KCcLrUTBr7xWvMdlYM7RZ4xWnHYVCy1r7Rj1zu/n9Mr1MWhNylAGPQBhwjQyshTjvTeJt9LCx3vkaeP6oUaieG6Yh5WICmqAuhZ/gUvnUk8i18ZVM+4puozDlnlCstK24iqWXQjke2BW+dfcUpP5AVGkJrL5iQpKDATlveMh+YLi7sOfeLBKh9Jb9mICs7IKUrgIlNOPy3ZLjb557B2j+U7vBCY569GD88BsZn+9K1cM6AfV3sJDdOovpKUUzmXzHyOUShVrJ1gr1wf2yYaVQ73vnSfwF2pO0pFRih6r33LDpu0zgBr0HIUmh1M7oD5ho2CiPg4E0+D9+4wmT4NQ==
Received: from MN2PR01CA0048.prod.exchangelabs.com (2603:10b6:208:23f::17) by
 BY5PR12MB4210.namprd12.prod.outlook.com (2603:10b6:a03:203::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.7; Wed, 10 Dec 2025 02:45:52 +0000
Received: from BL02EPF0001A107.namprd05.prod.outlook.com
 (2603:10b6:208:23f:cafe::2) by MN2PR01CA0048.outlook.office365.com
 (2603:10b6:208:23f::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.6 via Frontend Transport; Wed,
 10 Dec 2025 02:48:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL02EPF0001A107.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Wed, 10 Dec 2025 02:45:52 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 9 Dec
 2025 18:45:51 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 9 Dec 2025 18:45:51 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 9 Dec 2025 18:45:50 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <will@kernel.org>, <robin.murphy@arm.com>
CC: <joro@8bytes.org>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<skolothumtho@nvidia.com>, <praan@google.com>, <xueshuai@linux.alibaba.com>
Subject: [PATCH rc v3 2/4] iommu/arm-smmu-v3: Ignore STE MEV when computing the update sequence
Date: Tue, 9 Dec 2025 18:45:17 -0800
Message-ID: <0066c711b12af33b39a078ce0d0367e2b692f590.1765334526.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1765334526.git.nicolinc@nvidia.com>
References: <cover.1765334526.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A107:EE_|BY5PR12MB4210:EE_
X-MS-Office365-Filtering-Correlation-Id: 15a84c2d-0071-482a-d708-08de37963be7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0Wshuuy37xKxVhrHG+vX8psUkMlQt+3DI+nuwEO23xoEPo0wExRV87KgRr1T?=
 =?us-ascii?Q?sF4zcg8W9PIWkKQJKJFpX2QXbddYJha0X51DHUcpZtrG83/hNLAPNY5IvVmh?=
 =?us-ascii?Q?p/FMS39gVmgGUT9QiYB2lh4LyNKgHPWPTZj+J+QFDRfmw6HE+iDJZSisvVTa?=
 =?us-ascii?Q?+Dd/BOUOHo8+YWzX50xUXHWYRsYCwREgNR1/X7wnuW142S10CUkJDYlrjuNB?=
 =?us-ascii?Q?SttOb+KCa+M2bz+KeZAR3WpYCGZc3XjguffrLdo0SsUre9vnjrrXIPzQ1lFy?=
 =?us-ascii?Q?RIrAxVkhw1Sv21WzySKfllZQ/hSbh/iagoHGG3QR2BgqArW8z8ek7vyAbRxs?=
 =?us-ascii?Q?O8604ufn1BoUTklj8LN6112ZvGff02XgtnzmLKcaQ36llrtuW9WJnPVxbQsZ?=
 =?us-ascii?Q?fQV7tSFG1XPkScPwLw7QhOijWRHFaK8b8b3GF9NQiLYzit+ipq8btIMvzbP6?=
 =?us-ascii?Q?fxBTup1TAn1SVfQYy7EvWC6C1gjCELqEcAOdInYAOTx75jv63fd3wPVnO/cI?=
 =?us-ascii?Q?Kt+9vQdy3aDz7kSM1uKn9OfalSAbSemx12AMt3jZUg2dzXEeKGjal9q5w/IK?=
 =?us-ascii?Q?2xMAWWUjU+irqw52ag34jXvDGC3drRANqHvfaqK/JXjgbpOqkwsSbyNuhDdG?=
 =?us-ascii?Q?UUdrgV31TkwKtXZsHTiZFhxxUN1l3q1+tMkhGKZczrgu1ic1ZcEViCU3ROMj?=
 =?us-ascii?Q?epXWaretSOMD/Ok0/h1/9jWVOT7p0Jdmj/DCyBBmHertgHojXTEpgSgL5kLm?=
 =?us-ascii?Q?QfxD7TG3sptV8TrjVIg8/GwXRf10Kt1fsGwKJxTr7UGNijesHNpJO5dyrKXh?=
 =?us-ascii?Q?hBbKWTBe6/utEJ79MW8i1XNepFBwj1mylRhgOd3ptud1nTR0pUBeT+T6qMMW?=
 =?us-ascii?Q?ATVNSa9qTheTWRBdsgeulho4Yzgjp+n4JkxsOKiu+iT+Y+oT6q6csTN3h8IX?=
 =?us-ascii?Q?MfgherVafP0bK5vQTg3RIvf+gBUsdm7EJysJ+BoiDUuBrzT3truWLQhLD1/I?=
 =?us-ascii?Q?o2Gxn2gd44FH4XG9u3wvNmL+vDo3Col3hMh7Cg8H0nBrB++xDi4VT5WtBZj7?=
 =?us-ascii?Q?/n4kcr7UWMKA9TpRMRI2h0xwUrYF8+2jGzvISAp3/KEQZKLVqsucsDNupiDY?=
 =?us-ascii?Q?rnYUQyI1dOijqWZBuk3CneeZFiWSm78LzJGhtwCr/rASnTq/osxcav1kCaWx?=
 =?us-ascii?Q?A3hPNWvm6bfbIvvj7F5Hx5lnRoJjxFFXKyTTqZcnu6jZjdCTC+sBuAuWwakh?=
 =?us-ascii?Q?eHXcYn86LY2SFTj22Nq+daKxt+hhpeLr+3oEb7uSSZyXQsVQNfs0J/OqazuS?=
 =?us-ascii?Q?WopiD6GdrXbdlg+lDh0eB6VkrbooN8H46RLoE2oOR3rcIMdn8eZ6CFLv6fCw?=
 =?us-ascii?Q?+Zz6ztF4asNuI0I6HW2XKo4vNrKEoFp4hvibTn7TQpEYkFotTpyaHMFWmWTN?=
 =?us-ascii?Q?jnGle4mFcJEQ38U//uRyWTQaS4kD135sIzn95oYg+xMIrJyqqXyxoOfoEmSQ?=
 =?us-ascii?Q?Ig/5R3kqhJ7ed7w1dC0CBvSLU3/OhRgehzUakobE18kPQK+6FNLCQQhW1nlk?=
 =?us-ascii?Q?4O7n9SZivrGwCTx4D/A=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2025 02:45:52.1078
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 15a84c2d-0071-482a-d708-08de37963be7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A107.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4210

From: Jason Gunthorpe <jgg@nvidia.com>

Nested CD tables set the MEV bit to try to reduce multi-fault spamming on
the hypervisor. Since MEV is in STE word 1 this causes a breaking update
sequence that is not required and impacts real workloads.

For the purposes of STE updates the value of MEV doesn't matter, if it is
set/cleared early or late it just results in a change to the fault reports
that must be supported by the kernel anyhow. The spec says:

 Note: Software must expect, and be able to deal with, coalesced fault
 records even when MEV == 0.

So ignore MEV when computing the update sequence to avoid creating a
breaking update.

Fixes: da0c56520e88 ("iommu/arm-smmu-v3: Set MEV bit in nested STE for DoS mitigations")
Cc: stable@vger.kernel.org
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Shuai Xue <xueshuai@linux.alibaba.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index e22c0890041b..3e161d8298d9 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1085,6 +1085,16 @@ EXPORT_SYMBOL_IF_KUNIT(arm_smmu_get_ste_used);
 VISIBLE_IF_KUNIT
 void arm_smmu_get_ste_ignored(__le64 *ignored_bits)
 {
+	/*
+	 * MEV does not meaningfully impact the operation of the HW, it only
+	 * changes how many fault events are generated, thus we can ignore it
+	 * when computing the ordering. The spec notes the device can act like
+	 * MEV=1 anyhow:
+	 *
+	 *  Note: Software must expect, and be able to deal with, coalesced
+	 *  fault records even when MEV == 0.
+	 */
+	ignored_bits[1] |= cpu_to_le64(STRTAB_STE_1_MEV);
 }
 EXPORT_SYMBOL_IF_KUNIT(arm_smmu_get_ste_ignored);
 
-- 
2.43.0

