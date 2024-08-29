Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2040.outbound.protection.outlook.com [40.107.243.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D8151BD4F1
	for <iommu@lists.linux.dev>; Thu, 29 Aug 2024 22:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724970916; cv=fail; b=mQDs+hQouD1PP3pmcq5Z0zMH8U95+TA81GST8LaWhCy1FLmOcXnySHXsvrCidgsKwtkQz+DiEA5dE22yI4r0uCcoY9MRbbBkD1k7+YsVnKtqjznahdrbk9z7sAzRI0FpRQiUdIByqdovAL5qFnoQue0qVl7KUbGHOe0+CMRXhbM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724970916; c=relaxed/simple;
	bh=FmrJB/2IXwcwHIS1emqRLcnPCD42YdIhkq9FA/NR69Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jTCpx5mwSPk4GkhrZRwsI2jhVdV2IurU6Se6QJvNe1JiF8xjtuXHAzir2pvlP6trkGb+k+Yl7uggbpBe0plJrhQtZERTq7wMUJLSZ1nq3lRChrJIylP9jBUTqULBgrzaxBzg9Fbnkkalyg2Nyj8Aw8kOJt2H5Giohhrh8ohfQ3I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NTWUnn2a; arc=fail smtp.client-ip=40.107.243.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NTWUnn2a"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yCo81Luk9OrR+T37GQjxfsX9Lt0fYfEDw8RmrmvfKtNpO73sP6u5aojNfz+/MAUr1dx15/HnsxYBk93o+oSpdWca70fuDyXGFKKFydF3ej1DMe+bWMOwyYcKK19Uy7KW0VN0uX0ynSkeEtZiv4vabFaReenXapKFRON88bXrlDWiJp/AsglPZ+dwwoyrgDor5l8oj+z0+kVVymQtCqQ+RXf66cYY6tC69JKeBmh/B8sNIP16ogmOvgy2NlwaELTqCdYWtdAHjX5o5XNF5+ZemfDPv73FH3QROLhtVYVfeBt9HrW1HpXYOtHZd5OYO4Mepa1Gi73QUTD5iw5tKOs8Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Mhq3CecHinKMUbkh0GhnuXYEuTQ+kWywBHUHzQu1Lo=;
 b=uvcMOlgIVAlahCgVOt3K501MvVURIb0y+JfZYnpfNFh98cBKa8Zr1Hg3vnA3zVU8z6dzM3rFJOthe4PSaDK0lfyPRkbJaFS26xRrKBw9IJKoKxK/dhFeqFKJwj1iqDLyoy9Ogw7Z4ittLlfk/VGM8oAf4GEAAsD//lfsgefM56VA8OJkc23C3YfFdQETzbjM60DAO3o98xT2Tci1NEe4FehbnTrVpE6DamNleMx6zQGcHQoWKm/1bZLztI4e6K3aZ0Lvr2Edws/UVPQY6Jm2dcmdGgVuJihbL/D6OvXLDvyrRRYkRRn8SJ3oSD2JY6nLTwL4lYAy9zgfPrMXNm8/Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Mhq3CecHinKMUbkh0GhnuXYEuTQ+kWywBHUHzQu1Lo=;
 b=NTWUnn2aN1ORDRYR+xO8Xj6ecv8h4jv9eyj8U2SVqMXPZ6NmE7Q3P1pHQz7pphSKOTOVDYCxS/XSnaxp9QlMlQmiKfhz0X3BZKNy98T8XiFT+dcahQlwQuQbbgWK0kPSf1Owl1hkWcFmmPQs7D28LeJjMvkVPmgQx7GtJraE5M+Oq9JLUphpXD0AnvyilmcydK7J0t0e23PqEawsKnugZ/yvNBuANn6EaRzphoU4N2iiIpLCvRwJ/ut9Xn+jlvNsmg1pt/t4IfOBfe+IhobaQVFdTSvvsjnLaM8slcf++VyJWZ9PDlnHUFAvCjveGSYVX34DP87HEbKBv1AsUw99MA==
Received: from CH2PR12CA0011.namprd12.prod.outlook.com (2603:10b6:610:57::21)
 by IA1PR12MB6625.namprd12.prod.outlook.com (2603:10b6:208:3a3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.27; Thu, 29 Aug
 2024 22:35:01 +0000
Received: from CH3PEPF00000009.namprd04.prod.outlook.com
 (2603:10b6:610:57:cafe::32) by CH2PR12CA0011.outlook.office365.com
 (2603:10b6:610:57::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.28 via Frontend
 Transport; Thu, 29 Aug 2024 22:34:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH3PEPF00000009.mail.protection.outlook.com (10.167.244.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Thu, 29 Aug 2024 22:34:59 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 29 Aug
 2024 15:34:47 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 29 Aug
 2024 15:34:47 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 29 Aug 2024 15:34:46 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>
CC: <robin.murphy@arm.com>, <joro@8bytes.org>, <jgg@nvidia.com>,
	<thierry.reding@gmail.com>, <vdumpa@nvidia.com>, <jonathanh@nvidia.com>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>
Subject: [PATCH v14 04/10] iommu/arm-smmu-v3: Make symbols public for CONFIG_TEGRA241_CMDQV
Date: Thu, 29 Aug 2024 15:34:33 -0700
Message-ID: <c4f2aa5f5f40a2e7c68b132c6d3171d6403de57a.1724970714.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1724970714.git.nicolinc@nvidia.com>
References: <cover.1724970714.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000009:EE_|IA1PR12MB6625:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d40c392-0c5e-4b74-dc54-08dcc87ad0d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?McyFWzE7cv1GiUv0L2E7qciaPgh4boemlfJsnVqOhyJeAsv8mfgV9SbqGfZf?=
 =?us-ascii?Q?QcE2eBuD26YLrhVE0nholWyd+4VXaM6G1BWCeZjyQUt5BA2MYzeB6+9DzF7L?=
 =?us-ascii?Q?HfEQiw6e+GK+pSUuFNkg9pMhhZAqCzQ1PnqKQhQHyn4SGr+PcsvThvPRy1hZ?=
 =?us-ascii?Q?jRzaTlFwcmWlU3dyrGXGyyJM4JVdD2AxBI/R7H1/XBeHcMjVogSMCVb1wo1N?=
 =?us-ascii?Q?oR+yZ0AnFkPKrY4wDtwLRBmZ1aevXqANoBTdzvAKw/DYgDlyWfVH6gEEeero?=
 =?us-ascii?Q?SKwsKLPD+7Q313CsnumTaL1AoSJdIJlAhRfJ+x8Enpl3CGWcP7bWOphA7Y0B?=
 =?us-ascii?Q?yZ0ZSnkYTF7Ssrizml+JupA0RVSLSSOFiV2biw3OGWURtfjwwFyHUuZPp+jg?=
 =?us-ascii?Q?UbeUGEfBm9KBWAru1ZB5JQR7RmP317BpQZ1ks3gtxdo+RvIvcyQD65tAyP3Q?=
 =?us-ascii?Q?rCSvoRoVLKG6pZy+okeRcrJt49nrmEaN3fw92bLxupA9efnIwOhq+ZVR/HRE?=
 =?us-ascii?Q?WHrhZB9pLQuSfvgGroAWerp/QC/6dW+LBHNFT0PuUzrMFJxp76wr/X11dX/P?=
 =?us-ascii?Q?W9Nl8D6Tj2EExeKRH3ykWzGxmaMDalWEkDf6JFO2dvQUp2mU5+WDXqJyMuP/?=
 =?us-ascii?Q?C4326lpOHZK57X3owVZTxdfh8Tn/zx4CEx8mqP+KujxsahewDlDlxzJXYhYr?=
 =?us-ascii?Q?+olAWqojW5he8vrtSk2WjczXAi80lzULfUA+spm67yZjLKALI57XMNkABOXe?=
 =?us-ascii?Q?DvoIYJMsdZujn84DfRWwtHV7TC91yTF2utBfZzBCeXoP+6vnzuxa18sG+1xK?=
 =?us-ascii?Q?VF11X+aruFrQxQJyS0p0ZCAw7p6rwZOGHkrHr1dgPWDx1HGx6UdAQyWQWDah?=
 =?us-ascii?Q?lyqdSCZ2+Emqf2Xs3cfONSBb+n1U+DTqFlFtzcqdeepXXsZI5jhkE0+1i/zr?=
 =?us-ascii?Q?WbpK8aoZE13GYpj/0saORnHsGisxOiO2TYdd8IBAhzblxjnEOivjKN/YVXnX?=
 =?us-ascii?Q?dYppwSC8Xd0WkXHAkJWRB9jPYbgfs60k+1m07rHu+C5IDIe72xyjggJyW0m3?=
 =?us-ascii?Q?wut696sJ5I88MAgfDFXbCWKAIeKWrUVCLyTmevmDKCen0AQ+RT0WsntSgSNl?=
 =?us-ascii?Q?lJ0aaFjS3UaEPE4qlDLNq1mivf1hN4QQ0RRmtMjB1D0QwA9tiGGmpqJDvQSH?=
 =?us-ascii?Q?oOW5Uj7PjYH5NJeOKWAHYBBH/hGRGJFk+UYrwDk0UTuHn0ETs97kVyH900cY?=
 =?us-ascii?Q?GbJO9iF9FufEt4E37CEX4kQo9b+KpuzDYYG13YeZ5aH5yZtRxRmxXrtbcTGA?=
 =?us-ascii?Q?+nnsmmB3EcJmiavTYhd1F0kOC76quEp1BD1P7u8X3WsrcrLD1QfNx/QccJtX?=
 =?us-ascii?Q?uO4fxp2mrer/4XeStAZ82o16MBWOlBWSyyQPzliSK8u8oV6vqKSn0o+nLkaR?=
 =?us-ascii?Q?e7+lPEU9Yqy/7VbpxEDRa2oJhLkUTZYC?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 22:34:59.3553
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d40c392-0c5e-4b74-dc54-08dcc87ad0d9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000009.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6625

The symbols __arm_smmu_cmdq_skip_err(), arm_smmu_init_one_queue(), and
arm_smmu_cmdq_init() need to be used by the tegra241-cmdqv compilation
unit in a following patch.

Remove the static and put prototypes in the header.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 18 ++++++++----------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  9 +++++++++
 2 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 22578d1aa268..061a61f4ff0a 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -371,8 +371,8 @@ static void arm_smmu_cmdq_build_sync_cmd(u64 *cmd, struct arm_smmu_device *smmu,
 	arm_smmu_cmdq_build_cmd(cmd, &ent);
 }
 
-static void __arm_smmu_cmdq_skip_err(struct arm_smmu_device *smmu,
-				     struct arm_smmu_cmdq *cmdq)
+void __arm_smmu_cmdq_skip_err(struct arm_smmu_device *smmu,
+			      struct arm_smmu_cmdq *cmdq)
 {
 	static const char * const cerror_str[] = {
 		[CMDQ_ERR_CERROR_NONE_IDX]	= "No error",
@@ -3521,12 +3521,10 @@ static struct iommu_dirty_ops arm_smmu_dirty_ops = {
 };
 
 /* Probing and initialisation functions */
-static int arm_smmu_init_one_queue(struct arm_smmu_device *smmu,
-				   struct arm_smmu_queue *q,
-				   void __iomem *page,
-				   unsigned long prod_off,
-				   unsigned long cons_off,
-				   size_t dwords, const char *name)
+int arm_smmu_init_one_queue(struct arm_smmu_device *smmu,
+			    struct arm_smmu_queue *q, void __iomem *page,
+			    unsigned long prod_off, unsigned long cons_off,
+			    size_t dwords, const char *name)
 {
 	size_t qsz;
 
@@ -3564,8 +3562,8 @@ static int arm_smmu_init_one_queue(struct arm_smmu_device *smmu,
 	return 0;
 }
 
-static int arm_smmu_cmdq_init(struct arm_smmu_device *smmu,
-			      struct arm_smmu_cmdq *cmdq)
+int arm_smmu_cmdq_init(struct arm_smmu_device *smmu,
+		       struct arm_smmu_cmdq *cmdq)
 {
 	unsigned int nents = 1 << cmdq->q.llq.max_n_shift;
 
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index ba24f9efc5c9..50efc804f91c 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -816,6 +816,15 @@ void arm_smmu_tlb_inv_range_asid(unsigned long iova, size_t size, int asid,
 int arm_smmu_atc_inv_domain(struct arm_smmu_domain *smmu_domain,
 			    unsigned long iova, size_t size);
 
+void __arm_smmu_cmdq_skip_err(struct arm_smmu_device *smmu,
+			      struct arm_smmu_cmdq *cmdq);
+int arm_smmu_init_one_queue(struct arm_smmu_device *smmu,
+			    struct arm_smmu_queue *q, void __iomem *page,
+			    unsigned long prod_off, unsigned long cons_off,
+			    size_t dwords, const char *name);
+int arm_smmu_cmdq_init(struct arm_smmu_device *smmu,
+		       struct arm_smmu_cmdq *cmdq);
+
 #ifdef CONFIG_ARM_SMMU_V3_SVA
 bool arm_smmu_sva_supported(struct arm_smmu_device *smmu);
 bool arm_smmu_master_sva_supported(struct arm_smmu_master *master);
-- 
2.43.0

