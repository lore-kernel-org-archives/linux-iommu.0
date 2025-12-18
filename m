Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012023.outbound.protection.outlook.com [52.101.53.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7282D877B
	for <iommu@lists.linux.dev>; Thu, 18 Dec 2025 21:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766094228; cv=fail; b=SJB71ZIB1oOeAHtO5kdoSeb/Sg7ABa7ai6/XHR7imJTiYvE0MHrPdMxt16K8TRKK1ZIKZAlkWYWVaZWj2CiuOoT16bIWSkFJ3qe9b6ZDRpuPYdEsdejxkb8kkA12N/byYgwXJ/0WkRKHPZK/qguKLtxSFQ85sZklZpEWbvl52Ag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766094228; c=relaxed/simple;
	bh=U23+vhl90+PDa2p0w6+2fMCPAkfqVqTHtLgx6BHM0kw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EXywhIvzxTkyzVeFSVC8S7VEhdc8Q60p00qOY6AqfZNvfRWQDu0QtH8uyFS1M7SMtVlhmvZoJ4M5/aVJQhOCpEXQTvxVcitMl/hdzOzSq2KeAdGAwt9Co2sVVDrmvhnRCrxTnVZ+REVirLWPIyx4zTVetgL/4lvtrWNijot3B/o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ERUj0nnM; arc=fail smtp.client-ip=52.101.53.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ERUj0nnM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j7aTstZPzkzH9adfca9vUqLYgQXLBSHCRCzHGHzBRj9Op0tD7QzVa6PeqziRH6xW7F1WUVGYA+r/7MegSRfUk2pxFD/q/ToB6+1nhruBYcTtpaedx5Wy8a05+of7GQ4ECSiZDIXLmXschdfp9wQp1V8dp+Jfpd+0X/rGAdjN5o+qatfTQDJwwF/kHSA413XV8cR15H/BBHfT+lZ9IJf1SXNQLlgsrLkgp2AH9UOgET1k4ulH80/hqww1dLD7weM2q554tdNaUcvkAra5H5xm1jAK/V0aZfx7JqoFEWjSV0kKp/K3C2J633L3BNyyNpJIr5l++dmPNc69qIHQ1rA1Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pyUknLK10IFnRrY1t3LFmdvIDLQA+DUzE+qm0LYlouo=;
 b=QDR5vQUs1CLDMHYuYe2zucDXZQ3/U20qg6t7a5mkerBVzaGQVbw7Bh1w8lnomwJtmr1K/zBOqqspxqq1L/NXaDTX9gY0gr89EEZyEONgZwqxnHvlQivFJyLTLri0yYani0AZEo9yPakzfVgmg3bdQUTvB5Ot3IiBEM/hzsowtNseVJiyhGb9Z0o13jQtDj6JGbsoRtwbyB0GRxbufWJFMmII8RpmOkMC1wA8Brv2ipTclI6HUjlrE+MIKktxmG708jPaic8eV5P3js7lqJ6cXy9k1jxjH5K8BMbVpQPdLZeZnT4KAU2fAHHvJNBsLyOwed2FHfswOlkPR4VbVfEv4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pyUknLK10IFnRrY1t3LFmdvIDLQA+DUzE+qm0LYlouo=;
 b=ERUj0nnM4N66VGi78/oD2R1hZ2DpFqQlBOfsqVd45e264xejV1huLu96/kP5k/KK6qwulg36a18UIfmYqwiqnyPBY07+82tXEZMPttqgHC3WXECaweZDH6gxD94YgxZ9JH3vrw5xobMmAGoICiidb6a2ET17xqEXxwfToUGIj2Tk7SwZNSmN4n0ZkWo5sUAhhKeNt3rvQ4dOvfnM3ydvnL8fry9xz4irPZiPpZ6VwrxnwFuPBmeqLNj1zNCP0fN9S8D5Avc4zOBPDujktCBn+8PO0TT8CNzi19x0OoBozY/u8ZB8H9a1IQGQFKPH3TBKHt+51mxUbI3aAuEr061Vsg==
Received: from SA9P223CA0010.NAMP223.PROD.OUTLOOK.COM (2603:10b6:806:26::15)
 by SN7PR12MB7452.namprd12.prod.outlook.com (2603:10b6:806:299::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.8; Thu, 18 Dec
 2025 21:43:43 +0000
Received: from SN1PEPF0002636A.namprd02.prod.outlook.com
 (2603:10b6:806:26:cafe::c2) by SA9P223CA0010.outlook.office365.com
 (2603:10b6:806:26::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.7 via Frontend Transport; Thu,
 18 Dec 2025 21:43:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SN1PEPF0002636A.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Thu, 18 Dec 2025 21:43:42 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 18 Dec
 2025 13:43:27 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 18 Dec 2025 13:43:26 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 18 Dec 2025 13:43:26 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>
CC: <jgg@nvidia.com>, <joro@8bytes.org>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <skolothumtho@nvidia.com>,
	<praan@google.com>, <xueshuai@linux.alibaba.com>, <smostafa@google.com>
Subject: [PATCH rc v5 3/4] iommu/arm-smmu-v3: Mark STE EATS safe when computing the update sequence
Date: Thu, 18 Dec 2025 13:41:58 -0800
Message-ID: <adf08c3b9f289188aca4fe80e506dca7aa48aa19.1766093909.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1766093909.git.nicolinc@nvidia.com>
References: <cover.1766093909.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636A:EE_|SN7PR12MB7452:EE_
X-MS-Office365-Filtering-Correlation-Id: 1902e70b-7476-4845-c8d7-08de3e7e83b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SwsXRwKk9aw5FdDrk1061a24v5kjgxHvkGVuZpWGlJhiDWJ+18aQrNM8Ry+a?=
 =?us-ascii?Q?LLHHdhwd7GUboHPQFxmJIEcyJCG0KLRuete0MuJDPl/cy6QSVdmqo5hzJN3j?=
 =?us-ascii?Q?HyB8G9eThzpzpZW88Xp/2l/zMrSPs+x2u3h+VE540F9P2LVBWLTgcnJV/Wyh?=
 =?us-ascii?Q?msNrHRp6KzWaXuOer1+u3dCXlrkbShnJPf1tE1rAAySQLYBh/vr0pHOUKRDD?=
 =?us-ascii?Q?crOXoJWUSRgzvMfmSE+Jzip/DDALRLR4QxZLyFLFZc6Z2CaCLHkgLkYv+FuG?=
 =?us-ascii?Q?GTSsyTeqhW0mvMjKVJ3RPQwqDPfbf1pvWbYkEkixglXPLXQCiEgdnpyfoEPJ?=
 =?us-ascii?Q?Ugm0/w4FaXWNGkX/oo+AX3lc4OXEOd1uKjxW6n5RE650QQdNUZMYCv4aNnX8?=
 =?us-ascii?Q?000h03koAQbkrk+rwsLGNyndfAx8InWlfgh7DeJLhhDJOe6nqV1fO02lYXtF?=
 =?us-ascii?Q?DfqOeV4X3dgqck6yMcIh/16hKw31f7k2SdOMch7v5pu9Bu0ILh4T1bEuyC/I?=
 =?us-ascii?Q?M+odp2sQ4clUQIvoml9Kg6AUQC16jVl1htjRjJ5N10GFNj0XbSCtHgEglQ0w?=
 =?us-ascii?Q?47ne/saAv4HyFQGutR+wBATGI1NGIpozYVJCFW5I6yIJbRJZ/b1TPlSn77zj?=
 =?us-ascii?Q?ohsl3zcacM/tmNDMaR04wzjbMLLFpwt+kA1AuCANGhjpx5N3MtfBnYFVCc71?=
 =?us-ascii?Q?OYb59HPFz0e4E/6vMKV3lzF+PQZyxfKyqTMuewdltKy2zBbXOKCpUXYTX+7e?=
 =?us-ascii?Q?N76e3WdTAeXtdIeJXC7Jk85mVwxmC/c/SBq/qvQ2WqpEo9Qx3wniGt7Lr8EA?=
 =?us-ascii?Q?KkgXwNBktbJO3ApsIgOjHgxfiPpHYumkVXFa/YK7qVqkZTt92JaqjGY8E7r+?=
 =?us-ascii?Q?SEcY8uRFc6rG85+XI1zpB5A1bNZ7F88aq8bx1m3ufaDljWBN2L6w6wnpdg7c?=
 =?us-ascii?Q?V/csgerP/hDLpl6K9EZXz/mNXLvaNHI5R3AZ2E5aEJK4HpFSlDs/N1Q+T7sP?=
 =?us-ascii?Q?QPFAZKcGIngcolwzSnH8OcSBiahIS0PGzkk7hU/JjPe3OpTqXqKS76wd1/Vm?=
 =?us-ascii?Q?PN/hTAElQ9a57aKKVddke5EQGXbgQyrbyDsDXS4Z9rK/v5NjqzKeVKBsujf/?=
 =?us-ascii?Q?sZykU48L2XEm4mwxscEwIxbRtvyKvm/DYSfoVvLWJcrj6ZVmzjZ0tfYfEWWx?=
 =?us-ascii?Q?1boT4iPmi2ZmSBHgz/sqZFSo1W6wK9oUyoYp90ZEe+ZVOk4as19UKx2nCnTi?=
 =?us-ascii?Q?dIBElJ9tt6XsgSsy6Vplnd/kyUdSygbJDr7mmO6sEU4W5Q2UaaxSQdocn1d7?=
 =?us-ascii?Q?QdJ4AgJ60JFhdbRZecRPdKsDVxnPv7oY3iY0EN7IfZM2h4sXir68+Yiy5HkE?=
 =?us-ascii?Q?XAIlFSvLyvku5HSYgDhxqe6wXLcb/gQyWdVzIfV2vqGv+io5i9SuRPSgFQYf?=
 =?us-ascii?Q?KFTTRENbVSmkaDOZWGzJEtHxlu9C6OxVQistd+apU0+FAM+BDXXK9U61caFM?=
 =?us-ascii?Q?gIMav3MKzaE8JQcYtdBI2Z1b49fDocPgvUER4Q06tYRSuuVJnvYe49nw+0bJ?=
 =?us-ascii?Q?HDzGqTHMWYnMVG39jdQ=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2025 21:43:42.8320
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1902e70b-7476-4845-c8d7-08de3e7e83b3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7452

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

