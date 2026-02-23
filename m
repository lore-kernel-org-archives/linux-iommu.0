Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012058.outbound.protection.outlook.com [40.93.195.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D60346792
	for <iommu@lists.linux.dev>; Mon, 23 Feb 2026 06:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771827534; cv=fail; b=E4ZuwQe5WdOCb599Xfhc7hoi7FAkNlZXegkG3wXDTsKNO6Gl8f7HXbfmJ5B8cgjB48/6M8xZ9gQ+6XiBxbRqxvUwCzb0h6nutmtYG0CWwDFC5r2L5g2am6/IQofIKRmAUZT6a7ySIGCmJ4iDDWiDmf2UddNQ1XdTSOmuDWBFd3o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771827534; c=relaxed/simple;
	bh=whqt+uUSCo2KzmRF/+ytn4UH8s1TzQIDL+FJ+dVLxsE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IH4aTOTZ+ZjQDXtx0mhbggdgtVOMqZlwR28Mq3Vmxo8e1U+w9e3ZPWp9hdpvHfmoJSrrt4Bx3ExL8cWx7Ytiy5VkRDzGGENkGd88yZACBleCzxtRhQT/5liiGdOvPy/MU5JJyzWkAKgPtlu2VtsLcbi+NlGeCmWeN3K/nYmvbH4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HPop4g4v; arc=fail smtp.client-ip=40.93.195.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HPop4g4v"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WdnR9XXc+AoeStmc1RXZsU/M74VVZGJYdLQnnDrC2IAB8Q6nXucM+2jd1mB3CMDLj3DbBbCGYrG2ccYksKscYoZpx0YhZnzFiL0uENKxc1tvbXnGVuBVUNodg0kmy2Jq/uHg3EQgxIfG02Z0DgRmFLoKk7PlsEeZ4ez++IAN9wMfrmduWEx5fQRC5RA2zNq27guRBU9rLOCcJ1YXY+/PaRY/U8sOt/bx3VPZ8W/NC9Fn4fKef8ZPDoChrBzpL28cbGumQQUkTpVTFfzQivLZN8ebtm4h58izauriP2Ji3i1FJTMYgbFu6Z2B1wasvKm6QyDqYy8XdN3So5ZHb/0w7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NfltyhJV0C+4KSmvr153VQf2fKAciav5w/UD9D5Ch64=;
 b=FyjtmuEnAbQiU6K1SW1bryBVE/QQDqNphGmB03Tktds1dMYmrmhPKjVJ3m4vjz2p8IxDlbrfiwhuAiQgxRdkt3BI2x2W18kB9qBCBIl7KL/GudXrO9W8Rcr4bIev/hVUy3lY2tpRRRtfdxL02ODdO1fdv7Z+xu/SXmJGvhbhQbWLogjnM/i83JWxc+YtEtcBBXLQRlLzcRq9MUr7FqNGFLqwXp8jGTJ84lv55CI+Y8r1wvt8Egutm2K9m5rBfpzIfDEmujRf6Rq6DSGaqFRihqzVgYonXilhPpgPud4dlZ+OqHq0FnCYD31cfCXJAKk1cG6EH6sVHjYFtrZlLJZZQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NfltyhJV0C+4KSmvr153VQf2fKAciav5w/UD9D5Ch64=;
 b=HPop4g4vUlqVZir6xvwntW5INm/IbzlSMCu5t9u1Zadq5oCqDNxZQgC1YKKAVYU1BsMmOS6B6VaGoJQSmC6D9FXUcGT5MkQXZauKgM2DWi13WEuxLC/MoWTIGQ8ah2dkG6GKgvqYEYQDtBOLZJ3du6r7j6ZFruR2vw3N0aIQn+B1o9MBHUrtPbrnh228Sl5yb1R/6lEjUfjO4uLU3k+ZMJdKQn2LuoFk3JTKpUj1j63wAXhNcyiozoOVO0AwzNSpWc4QYxKDu8Xk+vlzM8R8jA4fHnvKwwLnwN4lOJNxnWstIUuJTZ04OM+heL6IOwYpWiIdiHB1BflCnax4eyQp4w==
Received: from SA0PR11CA0158.namprd11.prod.outlook.com (2603:10b6:806:1bb::13)
 by CH2PR12MB4309.namprd12.prod.outlook.com (2603:10b6:610:a4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Mon, 23 Feb
 2026 06:18:46 +0000
Received: from SA2PEPF0000150B.namprd04.prod.outlook.com
 (2603:10b6:806:1bb:cafe::92) by SA0PR11CA0158.outlook.office365.com
 (2603:10b6:806:1bb::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.21 via Frontend Transport; Mon,
 23 Feb 2026 06:18:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF0000150B.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Mon, 23 Feb 2026 06:18:45 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 22 Feb
 2026 22:18:26 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 22 Feb
 2026 22:18:26 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Sun, 22 Feb 2026 22:18:25 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>
CC: <jean-philippe@linaro.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<jgg@nvidia.com>, <balbirs@nvidia.com>, <miko.lenczewski@arm.com>,
	<peterz@infradead.org>, <kevin.tian@intel.com>, <praan@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v12 7/8] iommu/arm-smmu-v3: Add arm_smmu_invs based arm_smmu_domain_inv_range()
Date: Sun, 22 Feb 2026 22:18:08 -0800
Message-ID: <23a462668924823793703bc195d736aeaf85cc6a.1771815709.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1771815709.git.nicolinc@nvidia.com>
References: <cover.1771815709.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF0000150B:EE_|CH2PR12MB4309:EE_
X-MS-Office365-Filtering-Correlation-Id: dbc88373-e332-4063-43a4-08de72a36674
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|82310400026|1800799024|3613699012;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ecyRyPe0jaLpOVgpJzB3SYIMP/PnrK9PrxVEhl1N5EsAlrBm1Wt9kHX4eUQ8?=
 =?us-ascii?Q?x84X+YMSc7nyR7IdEzRlT+0kTYdXp4WYf0NNnUi34Xn2Pc1T1U4ovV2VwIPy?=
 =?us-ascii?Q?0eNUEKokaiR+a1WVPtV7OP4NOwzMbcAzqBbEQpXjM+T4npnvwmEq9kHySKoN?=
 =?us-ascii?Q?kNRKILAVTtV8VrQZYSUKgas4PzdjOtJqlM0mpA5NoOUBqOjrl9iSCu/6kgIv?=
 =?us-ascii?Q?03/tMmb+cBzXsFIhfG138yU2rNYqYxxa1ZsugxIYfRsT1ML1IRmlOZiJh/0e?=
 =?us-ascii?Q?ZZo3rm3XtgprNycZUP0lnLypALNchPKzRw977k/UfVr8TPKP/TzPTa91611c?=
 =?us-ascii?Q?a0gsoNZKOwIwWgsKWkg46+fn9xrBMmNWQFypTca2+HETWcyws3nrmRTa/dvm?=
 =?us-ascii?Q?PVB8X1NNvjM9ngMsMZBFgPD3VLtVjX9CxQ8qBran8sDlpUr14TtVEUOCICLI?=
 =?us-ascii?Q?M/aERRDhVSwPRh0Q7rPiMtZMj0z57GGCjuTvJIDTd4iCWGFt4eJgROa3sLX1?=
 =?us-ascii?Q?WDyeYr3phMEnlpE1DugrYE+ay8m2Ja9KrHHdAYeRDvGEPXP0xdzUMx+RFfWa?=
 =?us-ascii?Q?tgdhiAMfpco99CbVOd3VoVyqqEvzViZTL212VAvRxOldNxkZMD0w9NH1bIux?=
 =?us-ascii?Q?zAHjm4HPXvpfsfso4o1HKXaa7lKLNXLlBesseghs4qPqlJWiSpZkEP11WiR5?=
 =?us-ascii?Q?Ual4UO8hmXHQ18JYb30ks9xkykBWJwlilxfkkox8hoiDOVM9tFXbCQL3Ir9I?=
 =?us-ascii?Q?HvG+UIua3Dn3mONtLFDCpaQVSWp4u7E06EskkBUzOCuqHIgah9veVgVgH+rF?=
 =?us-ascii?Q?A/vspTHxFXr8ZP9WKlRVDI7+DGrYyphH0b5676HYW4poTawD+Vko9Ip6RVLK?=
 =?us-ascii?Q?CRQ5SQjK6kKhLnZgwSgnY7y+0eytUvTN8gwxVUQGwEIFnWDCvKafKvjLFXEN?=
 =?us-ascii?Q?ZJl1TYRSpyhB+L4shqsKQVNVX4WFYlvSgS+vkL6Xpni4B5fpPjedPgLFQc6P?=
 =?us-ascii?Q?Imkfg5cxYvS2gaSFSXisBNcOCLpSp6/gnFd3r/ETychVdkmJ1CNpKo8rkS42?=
 =?us-ascii?Q?SJ72ehdm4ivNdM1LXoXkFnAbwR6SYlt7KDoI+8+R2HAesKAPRjXDo1JMiwYy?=
 =?us-ascii?Q?NXkGKK5ICtYCYCEDd5EJyOgUM2wxPRlnXxaQlZY7IptMtkGWal44CopCG+iY?=
 =?us-ascii?Q?KxoZLVejYXhmx8Kxrk0HQJondUpVJnAMW/NgBQs8ljucS3P/ZECTkTKn/46h?=
 =?us-ascii?Q?VZ5KojmnOC8ndjRJko5vlEwb+AlnEPnwYerRZuYDUQNuZlW2tbTwmCAD9yti?=
 =?us-ascii?Q?3z/zsznmAJ6smGjv9MP+mcF9n1yn5J5BGXv9u3fKTO55dfDOHrVtG7X9PBI3?=
 =?us-ascii?Q?C2J1z9A1/n/dEdHxDiNcW2c+lBtyQ2fSf0UHRjUt7nsnAePZdKPv4RF4NRmr?=
 =?us-ascii?Q?AFoOSx5NbvJnp/SsH2QjQEFUgTIYPRHRCwTFOJGePttihJV+dKExtUzQSPsk?=
 =?us-ascii?Q?ltBR6GrD52R+L1na2HrhUz1phw1vV5tdtxkFie69JBBIsd0no5M0USQF80LK?=
 =?us-ascii?Q?TBl5l3aSn8g9ma7N0s12uaBKIP9cU2ljXKeN370UM/fnP5IiSbcESjIHXAsN?=
 =?us-ascii?Q?fPooo59m2PCDbUEkfU2V0uL8F4dob88KCIl4nXDXdvi1rW2NynlbSY0x3mEF?=
 =?us-ascii?Q?NuNzkmdNlvrBKFi49SV7n2SkisU=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(82310400026)(1800799024)(3613699012);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	CThPVuiTwqS5eeLfGp80CaXqnfXqwfJ9gG/+gkdJlf8n3eidMfE5JcfikoQCOEVsR4nJLJ02dyXU0ycaMHA3vQvVXQK413Yp8T5QrFD1rBMCnnqnlxjm/hyOqXC/33Tyavv3P8IgoPdzTZ8XoKBZOYuZ4y5GI0RcS5Kvy3aNqbpsas+/2U4j6vYI6UOK6CqZT83yzDGnMPP8Znw+HigqXtqmpfMZHIVq77RXaiv+fhfdkN3rjAjLOEdtSgC/bBDuxpUixGZNuMcAW1bJLzXi/rtQWcTQv2RRmBXeWc8cyfwIwcxRlTm6nXSCnPita6fI+eYh4TkUCggp2E18cJSJXTwGxSFaQkUQiP4XPufbZcztEI5CckJWdiT5Cvs8ueQgIwEbkZEKi/c2/ZmflnGOBhXHaTfJK4mySrh2gJO1NfGWI9b7K7a3ThCsybnM9elZ
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2026 06:18:45.5894
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dbc88373-e332-4063-43a4-08de72a36674
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF0000150B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4309

Each smmu_domain now has an arm_smmu_invs that specifies the invalidation
steps to perform after any change the IOPTEs. This includes supports for
basic ASID/VMID, the special case for nesting, and ATC invalidations.

Introduce a new arm_smmu_domain_inv helper iterating smmu_domain->invs to
convert the invalidation array to commands. Any invalidation request with
no size specified means an entire flush over a range based one.

Take advantage of the sorted array to compatible batch operations together
to the same SMMU. For instance, ATC invaliations for multiple SIDs can be
pushed as a batch.

ATC invalidations must be completed before the driver disables ATS. Or the
device is permitted to ignore any racing invalidation that would cause an
SMMU timeout. The sequencing is done with a rwlock where holding the write
side of the rwlock means that there are no outstanding ATC invalidations.
If ATS is not used the rwlock is ignored, similar to the existing code.

Co-developed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |   9 +
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 225 ++++++++++++++++++--
 2 files changed, 221 insertions(+), 13 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 83d7e4952dffb..534e9a5ddca31 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -1087,6 +1087,15 @@ void arm_smmu_tlb_inv_range_asid(unsigned long iova, size_t size, int asid,
 int arm_smmu_atc_inv_domain(struct arm_smmu_domain *smmu_domain,
 			    unsigned long iova, size_t size);
 
+void arm_smmu_domain_inv_range(struct arm_smmu_domain *smmu_domain,
+			       unsigned long iova, size_t size,
+			       unsigned int granule, bool leaf);
+
+static inline void arm_smmu_domain_inv(struct arm_smmu_domain *smmu_domain)
+{
+	arm_smmu_domain_inv_range(smmu_domain, 0, 0, 0, false);
+}
+
 void __arm_smmu_cmdq_skip_err(struct arm_smmu_device *smmu,
 			      struct arm_smmu_cmdq *cmdq);
 int arm_smmu_init_one_queue(struct arm_smmu_device *smmu,
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 9e406a57a1dcb..9ec82c0036448 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2590,23 +2590,19 @@ static void arm_smmu_tlb_inv_context(void *cookie)
 	arm_smmu_atc_inv_domain(smmu_domain, 0, 0);
 }
 
-static void __arm_smmu_tlb_inv_range(struct arm_smmu_cmdq_ent *cmd,
-				     unsigned long iova, size_t size,
-				     size_t granule,
-				     struct arm_smmu_domain *smmu_domain)
+static void arm_smmu_cmdq_batch_add_range(struct arm_smmu_device *smmu,
+					  struct arm_smmu_cmdq_batch *cmds,
+					  struct arm_smmu_cmdq_ent *cmd,
+					  unsigned long iova, size_t size,
+					  size_t granule, size_t pgsize)
 {
-	struct arm_smmu_device *smmu = smmu_domain->smmu;
-	unsigned long end = iova + size, num_pages = 0, tg = 0;
+	unsigned long end = iova + size, num_pages = 0, tg = pgsize;
 	size_t inv_range = granule;
-	struct arm_smmu_cmdq_batch cmds;
 
 	if (!size)
 		return;
 
 	if (smmu->features & ARM_SMMU_FEAT_RANGE_INV) {
-		/* Get the leaf page size */
-		tg = __ffs(smmu_domain->domain.pgsize_bitmap);
-
 		num_pages = size >> tg;
 
 		/* Convert page size of 12,14,16 (log2) to 1,2,3 */
@@ -2626,8 +2622,6 @@ static void __arm_smmu_tlb_inv_range(struct arm_smmu_cmdq_ent *cmd,
 			num_pages++;
 	}
 
-	arm_smmu_cmdq_batch_init(smmu, &cmds, cmd);
-
 	while (iova < end) {
 		if (smmu->features & ARM_SMMU_FEAT_RANGE_INV) {
 			/*
@@ -2655,9 +2649,26 @@ static void __arm_smmu_tlb_inv_range(struct arm_smmu_cmdq_ent *cmd,
 		}
 
 		cmd->tlbi.addr = iova;
-		arm_smmu_cmdq_batch_add(smmu, &cmds, cmd);
+		arm_smmu_cmdq_batch_add(smmu, cmds, cmd);
 		iova += inv_range;
 	}
+}
+
+static void __arm_smmu_tlb_inv_range(struct arm_smmu_cmdq_ent *cmd,
+				     unsigned long iova, size_t size,
+				     size_t granule,
+				     struct arm_smmu_domain *smmu_domain)
+{
+	struct arm_smmu_device *smmu = smmu_domain->smmu;
+	struct arm_smmu_cmdq_batch cmds;
+	size_t pgsize;
+
+	/* Get the leaf page size */
+	pgsize = __ffs(smmu_domain->domain.pgsize_bitmap);
+
+	arm_smmu_cmdq_batch_init(smmu, &cmds, cmd);
+	arm_smmu_cmdq_batch_add_range(smmu, &cmds, cmd, iova, size, granule,
+				      pgsize);
 	arm_smmu_cmdq_batch_submit(smmu, &cmds);
 }
 
@@ -2713,6 +2724,194 @@ void arm_smmu_tlb_inv_range_asid(unsigned long iova, size_t size, int asid,
 	__arm_smmu_tlb_inv_range(&cmd, iova, size, granule, smmu_domain);
 }
 
+static bool arm_smmu_inv_size_too_big(struct arm_smmu_device *smmu, size_t size,
+				      size_t granule)
+{
+	size_t max_tlbi_ops;
+
+	/* 0 size means invalidate all */
+	if (!size || size == SIZE_MAX)
+		return true;
+
+	if (smmu->features & ARM_SMMU_FEAT_RANGE_INV)
+		return false;
+
+	/*
+	 * Borrowed from the MAX_TLBI_OPS in arch/arm64/include/asm/tlbflush.h,
+	 * this is used as a threshold to replace "size_opcode" commands with a
+	 * single "nsize_opcode" command, when SMMU doesn't implement the range
+	 * invalidation feature, where there can be too many per-granule TLBIs,
+	 * resulting in a soft lockup.
+	 */
+	max_tlbi_ops = 1 << (ilog2(granule) - 3);
+	return size >= max_tlbi_ops * granule;
+}
+
+/* Used by non INV_TYPE_ATS* invalidations */
+static void arm_smmu_inv_to_cmdq_batch(struct arm_smmu_inv *inv,
+				       struct arm_smmu_cmdq_batch *cmds,
+				       struct arm_smmu_cmdq_ent *cmd,
+				       unsigned long iova, size_t size,
+				       unsigned int granule)
+{
+	if (arm_smmu_inv_size_too_big(inv->smmu, size, granule)) {
+		cmd->opcode = inv->nsize_opcode;
+		arm_smmu_cmdq_batch_add(inv->smmu, cmds, cmd);
+		return;
+	}
+
+	cmd->opcode = inv->size_opcode;
+	arm_smmu_cmdq_batch_add_range(inv->smmu, cmds, cmd, iova, size, granule,
+				      inv->pgsize);
+}
+
+static inline bool arm_smmu_invs_end_batch(struct arm_smmu_inv *cur,
+					   struct arm_smmu_inv *next)
+{
+	/* Changing smmu means changing command queue */
+	if (cur->smmu != next->smmu)
+		return true;
+	/* The batch for S2 TLBI must be done before nested S1 ASIDs */
+	if (cur->type != INV_TYPE_S2_VMID_S1_CLEAR &&
+	    next->type == INV_TYPE_S2_VMID_S1_CLEAR)
+		return true;
+	/* ATS must be after a sync of the S1/S2 invalidations */
+	if (!arm_smmu_inv_is_ats(cur) && arm_smmu_inv_is_ats(next))
+		return true;
+	return false;
+}
+
+static void __arm_smmu_domain_inv_range(struct arm_smmu_invs *invs,
+					unsigned long iova, size_t size,
+					unsigned int granule, bool leaf)
+{
+	struct arm_smmu_cmdq_batch cmds = {};
+	struct arm_smmu_inv *cur;
+	struct arm_smmu_inv *end;
+
+	cur = invs->inv;
+	end = cur + READ_ONCE(invs->num_invs);
+	/* Skip any leading entry marked as a trash */
+	for (; cur != end; cur++)
+		if (READ_ONCE(cur->users))
+			break;
+	while (cur != end) {
+		struct arm_smmu_device *smmu = cur->smmu;
+		struct arm_smmu_cmdq_ent cmd = {
+			/*
+			 * Pick size_opcode to run arm_smmu_get_cmdq(). This can
+			 * be changed to nsize_opcode, which would result in the
+			 * same CMDQ pointer.
+			 */
+			.opcode = cur->size_opcode,
+		};
+		struct arm_smmu_inv *next;
+
+		if (!cmds.num)
+			arm_smmu_cmdq_batch_init(smmu, &cmds, &cmd);
+
+		switch (cur->type) {
+		case INV_TYPE_S1_ASID:
+			cmd.tlbi.asid = cur->id;
+			cmd.tlbi.leaf = leaf;
+			arm_smmu_inv_to_cmdq_batch(cur, &cmds, &cmd, iova, size,
+						   granule);
+			break;
+		case INV_TYPE_S2_VMID:
+			cmd.tlbi.vmid = cur->id;
+			cmd.tlbi.leaf = leaf;
+			arm_smmu_inv_to_cmdq_batch(cur, &cmds, &cmd, iova, size,
+						   granule);
+			break;
+		case INV_TYPE_S2_VMID_S1_CLEAR:
+			/* CMDQ_OP_TLBI_S12_VMALL already flushed S1 entries */
+			if (arm_smmu_inv_size_too_big(cur->smmu, size, granule))
+				continue;
+			cmd.tlbi.vmid = cur->id;
+			arm_smmu_cmdq_batch_add(smmu, &cmds, &cmd);
+			break;
+		case INV_TYPE_ATS:
+			arm_smmu_atc_inv_to_cmd(cur->ssid, iova, size, &cmd);
+			cmd.atc.sid = cur->id;
+			arm_smmu_cmdq_batch_add(smmu, &cmds, &cmd);
+			break;
+		case INV_TYPE_ATS_FULL:
+			arm_smmu_atc_inv_to_cmd(IOMMU_NO_PASID, 0, 0, &cmd);
+			cmd.atc.sid = cur->id;
+			arm_smmu_cmdq_batch_add(smmu, &cmds, &cmd);
+			break;
+		default:
+			WARN_ON_ONCE(1);
+			continue;
+		}
+
+		/* Skip any trash entry in-between */
+		for (next = cur + 1; next != end; next++)
+			if (READ_ONCE(next->users))
+				break;
+
+		if (cmds.num &&
+		    (next == end || arm_smmu_invs_end_batch(cur, next))) {
+			arm_smmu_cmdq_batch_submit(smmu, &cmds);
+			cmds.num = 0;
+		}
+		cur = next;
+	}
+}
+
+void arm_smmu_domain_inv_range(struct arm_smmu_domain *smmu_domain,
+			       unsigned long iova, size_t size,
+			       unsigned int granule, bool leaf)
+{
+	struct arm_smmu_invs *invs;
+
+	/*
+	 * An invalidation request must follow some IOPTE change and then load
+	 * an invalidation array. In the meantime, a domain attachment mutates
+	 * the array and then stores an STE/CD asking SMMU HW to acquire those
+	 * changed IOPTEs.
+	 *
+	 * When running alone, a domain attachment relies on the dma_wmb() in
+	 * arm_smmu_write_entry() used by arm_smmu_install_ste_for_dev().
+	 *
+	 * But in a race, these two can be interdependent, making it a special
+	 * case requiring an additional smp_mb() for the write->read ordering.
+	 * Pairing with the dma_wmb() in arm_smmu_install_ste_for_dev(), this
+	 * makes sure that IOPTE update prior to this point is visable to SMMU
+	 * hardware before we load the updated invalidation array.
+	 *
+	 *  [CPU0]                        | [CPU1]
+	 *  change IOPTE on new domain:   |
+	 *  arm_smmu_domain_inv_range() { | arm_smmu_install_new_domain_invs()
+	 *    smp_mb(); // ensures IOPTE  | arm_smmu_install_ste_for_dev {
+	 *              // seen by SMMU   |   dma_wmb(); // ensures invs update
+	 *    // load the updated invs    |              // before updating STE
+	 *    invs = rcu_dereference();   |   STE = TTB0;
+	 *    ...                         |   ...
+	 *  }                             | }
+	 */
+	smp_mb();
+
+	rcu_read_lock();
+	invs = rcu_dereference(smmu_domain->invs);
+
+	/*
+	 * Avoid locking unless ATS is being used. No ATC invalidation can be
+	 * going on after a domain is detached.
+	 */
+	if (invs->has_ats) {
+		unsigned long flags;
+
+		read_lock_irqsave(&invs->rwlock, flags);
+		__arm_smmu_domain_inv_range(invs, iova, size, granule, leaf);
+		read_unlock_irqrestore(&invs->rwlock, flags);
+	} else {
+		__arm_smmu_domain_inv_range(invs, iova, size, granule, leaf);
+	}
+
+	rcu_read_unlock();
+}
+
 static void arm_smmu_tlb_inv_page_nosync(struct iommu_iotlb_gather *gather,
 					 unsigned long iova, size_t granule,
 					 void *cookie)
-- 
2.43.0

