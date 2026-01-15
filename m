Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010060.outbound.protection.outlook.com [52.101.46.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE388F9D9
	for <iommu@lists.linux.dev>; Thu, 15 Jan 2026 01:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768439599; cv=fail; b=nIxTpUukLDzKpzqKm81sZVck8wT0Yq5OrVDIFe8bAuF8lI4pJY0Eb29ClnocgZXIijLf0KBLMFvgpNPysNi/9WSfJql2hWwB0qgw3Pd0fz5b0y+f9ovcc3uBAziNBfDj6nau1e8+s0ZqPhpTiMBZCFegHFoPFQWHAJjXw/8uCNQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768439599; c=relaxed/simple;
	bh=JG3wcaByGG6gKr7b70YmtXWskqZlje/feriPTiz815c=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GEaPNaNqX24fahqhEgcSHCRVVrPGxD+f2PAZnYx/iIvgc4s7obhIZBf+42zjMULLkQYbirPscO9ltSCYxW/cG9VcZCPSlo6TtuPo3nWhCfyGRsm/3DbnnCVUIa8rVOHPV5zS8tOemJw8usRCXXJJS09ELv1Z7z6ekIreHIoTtxw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DP0L4mFf; arc=fail smtp.client-ip=52.101.46.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DP0L4mFf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rnBIV+hj85+6osW2U3MvLQ8Ev14KVjoie1+jFAas6UyEkZe0cD4+F0PyNwh2cbQ25f5Ip2oeSDiVbSXLfEiObqWWG7C+MvAUy6rwHsNhFQhEGukdkdNgUxDB/rmHlNzAPsAV7uRejBbMkwrDcuZngBE4fEvclnlehrmKJSAMvfF7mao09LnUH1Vd49NrmmUgoPE8URFXiUKBD6ITpI8gYV4u6XkWjd81ahV9+KGrKcHJKTd+Zri4VYtbmpZaNz7HBhkbE0wzxcS6sEsqmLuCsD9jGG0NzqPy2ar/+lxbVASHZs2qvK/i1iRxn/wW7xintiDvltKlrcTyRcR8Wknj5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qLVC1Sx22S+P1rmUYfTfSUmJADen9+YAlvvuMx9b1+o=;
 b=IzD6ffrEYAFMSVEsY3KHtEJiUzbpAppLQ4JXiQHlgqFA3IqgIYiXBhzo0NrCA6oPNKr9DKwvuT4+I6N/cM3jTK2WNfZ5hSjzkjqShP1K0QX2F0AGbakdH1d/49NBVlfne0GTyckftT5X1CVOVUDhZ3mb03gdyhgdjhsxcR/AFj3DTX1FMqjCasbVoqv+BP4/qcACmq/dMp1kCO2Eac/mxdRv+d1ATB10I913C+LpkQuMPr+w7IBkAGtl9pBq12XpblJ6oAYJFpdGfzYb4cW/DKlXIsgQ/qX3b7VlgbYTb5gK/9z7auNjgY/Tp7GoORN0qhWqcHJlf2PyOYqGMYVqJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qLVC1Sx22S+P1rmUYfTfSUmJADen9+YAlvvuMx9b1+o=;
 b=DP0L4mFfNzBVsiz0OJi0cui4JsL5QLVLl18+mARMd224l6xMf2s7EWNSDN+otALZAC4mlh3oYKFZaApKH/MTvb3Uhj1iFu8zQ/B+YBDJ6fX3p3k/jSUV/7he1cyYpt4blhUK8C+ZLa/zoYeJnoPm8OAzEBCtc+64p8bhioM/T8I209X2bwxnZTBLnxfAz5Jpesq5llhDq8LvCSg/EW0L5W/AIWBAFGFN71e6THhPmhT85hQCOig8QILHE9udUo9zyQNkTre2w38BzZmQiKYovagVb9fQjhSP3Ymj0oRwHkf7mFq8B1glLRxcM+vlSTh1AuYF8ElSXWAhKloHL9mAEQ==
Received: from DM6PR02CA0112.namprd02.prod.outlook.com (2603:10b6:5:1b4::14)
 by DM6PR12MB4121.namprd12.prod.outlook.com (2603:10b6:5:220::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.4; Thu, 15 Jan
 2026 01:13:14 +0000
Received: from CH3PEPF00000016.namprd21.prod.outlook.com
 (2603:10b6:5:1b4:cafe::d6) by DM6PR02CA0112.outlook.office365.com
 (2603:10b6:5:1b4::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.6 via Frontend Transport; Thu,
 15 Jan 2026 01:13:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CH3PEPF00000016.mail.protection.outlook.com (10.167.244.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.0 via Frontend Transport; Thu, 15 Jan 2026 01:13:14 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 14 Jan
 2026 17:13:01 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 14 Jan 2026 17:13:01 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 14 Jan 2026 17:13:01 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>
CC: <jgg@nvidia.com>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<praan@google.com>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: [PATCH rc] iommu/arm-smmu-v3: Do not set disable_ats unless vSTE is Translate
Date: Wed, 14 Jan 2026 17:12:43 -0800
Message-ID: <20260115011243.1302402-1-nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000016:EE_|DM6PR12MB4121:EE_
X-MS-Office365-Filtering-Correlation-Id: bcc36d73-74cb-4721-806a-08de53d34235
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nuQUW9qxtICfHhLFpxyUpVVrttt46et7+UZiJGuaIjmtYNc6YDAB/odmv7AP?=
 =?us-ascii?Q?m23T45/tAWG9RimLtZzk0q1Z+0cEl97kj6dn8A1nNJcL4S1lRHbEI524C9Ck?=
 =?us-ascii?Q?2B786yAR7g9seO3U8p6y4F21W28sDvlD/1GcZqkHrogWKOrKtDQ3B69BkLGC?=
 =?us-ascii?Q?xTYY4q0gBWqhc0PpFkA25TSJiERT3JCVaHNQmCaMuVT9ZqV3+BU0RKJqRw32?=
 =?us-ascii?Q?y8l19ahUkC3S4dv0VXCDMfWqoWzXt8251M4xVOHO+iHafB05NzH+ybfvOn+n?=
 =?us-ascii?Q?sRIWIPmVqJcDa9jCUd+gMCC6+1z3lzp3abdtaZND/zhJbrtZWhBPXWZf7NIP?=
 =?us-ascii?Q?H19BKD1f9Hsewg+1nFby1oQVptFW6JVsz0QPq3tWzsvONKeTAgXxtlcqGf+d?=
 =?us-ascii?Q?AMdePMwu/5VxDczMeazdRvncw2d0bmgYdjG4jZEOkbYZPk+RV59ssawkjymx?=
 =?us-ascii?Q?4cBuQop033mwiXMKFNo6IIoSJJn3vN3wBAClWIPSJoq5dbXuujJwK/y2UgeC?=
 =?us-ascii?Q?RlbLXuXQdeNlelj8BLIjWxiKMEI/ft1ypyqAxSZCHoPzsfONyFzAsdhcksb1?=
 =?us-ascii?Q?Pj+IBPqZLM4br5u3UcRWZLORyhiWeH9bz+T9/Z8nY9HKiqS5OX8wbuPK5DMM?=
 =?us-ascii?Q?Tbl6Lxf2GcsdaQ0uUNFWxPzErwDVhDgT67qUjlRmG/1h3NdGo/spwxWPLVto?=
 =?us-ascii?Q?yaVy3KecSQurp5xiPsDkkf7ERRvKyYRttWGRMY/xGdH3EIZ4FpVclKJnb1T1?=
 =?us-ascii?Q?8e+G+6lh3VhjcceJ5JKHRPEEEGh1Uqta1Z//CCN0IdKZ5jYprOoXP/UWAR++?=
 =?us-ascii?Q?kAl9WtlDsYf7QuLcYuGBM5eZyVZOpTWIpb7Z/RdMeQwMOObpyu9PtVHndxu+?=
 =?us-ascii?Q?u3fekIb6HE/Laku3Br0cfR84JIR4dOKuJmWMmZLlXGU2ZgpKaxAGkLvq3zBn?=
 =?us-ascii?Q?qW+snSks+BLV+qypRI7whEX+fxS640xWszxDkaCqFao5gK7Tabpj17FfgOvW?=
 =?us-ascii?Q?49Z48HYzOcUcXafjL0d/UATID2/u/lDQoTnFROnE+2yWcn5JWS6dvDu8YNmO?=
 =?us-ascii?Q?B4ZShSNLqrZ/5wksYnIQoz19Ys0PL7GC39orXN12VW0Lwy5RbScNWNe8RgSI?=
 =?us-ascii?Q?Q32uuZ5RWuXyIqpuj1+rBIzwWCWgiz52AnaYBNUX871bEkmcj4bE2gE3h6SD?=
 =?us-ascii?Q?/IbgiUZF89slEYUQ6/f1OJFRVeiEU1AgtVTC0yzyj4V2VX2CEVHcdGSx7K3x?=
 =?us-ascii?Q?xFqWOLJqyBm+4AprocdObS3LHV3LSuWJzBZvOVGBcew2G/Im+9je6xksF/HC?=
 =?us-ascii?Q?bxT95OImnE/3hUgEiy8dT5hL/2tSddBc2ZHxkLyV9r94/QzMEMthsNHjS8ua?=
 =?us-ascii?Q?GriXYZEfHH0gmC4TtU/IDYe4JB28UT1XIqPcwYS7Q8gprdcD6xUhHg7Tsrxh?=
 =?us-ascii?Q?MWirroPVuQLMQyKudjMCWZCDgZC4UJ9od43Wf1Xi+5r3LZjj4dFdA1yJsroP?=
 =?us-ascii?Q?c02XEpl/2kViqXn4EEIcLpjCX/itlrN0LnNs5tdyP2uodEGlcyJuIFgJ599P?=
 =?us-ascii?Q?erZ9+1uGpxIgE2gUrbPcN9liIZc964TOksb0Fg3F1yIxzfq6BN4RAEzZwPJ6?=
 =?us-ascii?Q?LvEWQPz7yOF53+0s0QN3QQTO1AKBQC9t5bzX6/AxRPnuYrGOlW09p+kqCDPk?=
 =?us-ascii?Q?0hq2fA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2026 01:13:14.5849
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bcc36d73-74cb-4721-806a-08de53d34235
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000016.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4121

A vSTE may have three configuration types: Abort, Bypass, and Translate.

An Abort vSTE wouldn't enable ATS, but the other two might.

It makes sense for a Transalte vSTE to rely on the guest vSTE.EATS field.

For a Bypass vSTE, it would end up with an S2-only physical STE, similar
to an attachment to a regular S2 domain. However, the nested case always
disables ATS following the Bypass vSTE, while the regular S2 case always
enables ATS so long as arm_smmu_ats_supported(master) == true.

Note that ATS is needed for certain VM centric workloads and historically
non-vSMMU cases have relied on this automatic enablement. So, having the
nested case behave differently causes problems.

To fix that, add a condition to disable_ats, so that it might enable ATS
for a Bypass vSTE, aligning with the regular S2 case.

Fixes: f27298a82ba0 ("iommu/arm-smmu-v3: Allow ATS for IOMMU_DOMAIN_NESTED")
Cc: stable@vger.kernel.org
Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
index 93fdadd07431..823461a26659 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
@@ -177,7 +177,9 @@ static int arm_smmu_attach_dev_nested(struct iommu_domain *domain,
 	 * config bit here base this off the EATS value in the STE. If the EATS
 	 * is set then the VM must generate ATC flushes.
 	 */
-	state.disable_ats = !nested_domain->enable_ats;
+	if (FIELD_GET(STRTAB_STE_0_CFG, le64_to_cpu(nested_domain->ste[0])) ==
+	    STRTAB_STE_0_CFG_S1_TRANS)
+		state.disable_ats = !nested_domain->enable_ats;
 	ret = arm_smmu_attach_prepare(&state, domain);
 	if (ret) {
 		mutex_unlock(&arm_smmu_asid_lock);
-- 
2.43.0

