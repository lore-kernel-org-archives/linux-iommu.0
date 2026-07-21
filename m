Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011049.outbound.protection.outlook.com [52.101.52.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7EBB415F15
	for <iommu@lists.linux.dev>; Tue, 21 Jul 2026 19:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784663347; cv=fail; b=mUKxzz0igXW0S1YvDWVuvXhIZ7F4mYoKucDLVlf5Nr+6qw7Mp7nVQXSRXUO9ihhiAGstd9vboM/Ogpn0D3hyUIf4fTwd5cGMvascKKPsnypvtItKsIO3uuuZ+ZCX9UMBjcdd5OQ9i6KZGZGEKltgG2TF7kszS8vkuK7i9n3ekwA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784663347; c=relaxed/simple;
	bh=f5J1TPEERhRweUYoClF7lnwnjCmUZ43rPG6BSnaSsqg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U2LW135WoO6AZoYx4Insk9jmCVVzHQSGn/0cp1H42S6iDUaofeReQv8jy88kWk7kZm1lXv6Ry9QrOqRA5MvL7f+yjzD6ovIqfVEcdemoVMUxK+tfTDJy+Qu7xfBoeJYLQ9G+Pwg8MKGO56VeKK6tXDzna3PwN+GKBZfeRCqATLk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Z8bZ39XU; arc=fail smtp.client-ip=52.101.52.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Z8bZ39XU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dpQ6ePp11poIutnGMfJgNJYFv/9UflMIwEQve1mxaZRaXyfIYh3Fjnm5ggLrg5ssa5owELjNxtl3U2x+qNxfLqR73DmIQMsxTmG5wgajgyRwvtxyBcEdSRHQYhp56Y71Gyg8FkZ1CWkX6JBf5V9n+gGyY8zSZ40fmL4sEI+NIFyyRCuWEgJhTUb/TzkyjSm9JpNluGb/SaGLjoHa3bvQrzU3KtP+0ZdVlN5f/smSd4jMrJQYmad9G0ndv/6VjjJtNGYnwAN3cH6jOPphajd3dpPyYDOATfNufiJ9WBc4XhTXnBHa5goEyFamZcfgZ6NotZ9cGnfQNj47yOaa7dmrDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mlySgRa3aXx13KatwQ5/JqusdclKYsr1UAq0hIkrSTo=;
 b=rb/2N4xqljJZD7o5syQ+/OMpPq7GjEY9dadRN8TakwKMZHm4+7mL0/bCO7ED6owZnlofb2YWwmffk4n9YV1SaXBtyMldz55Ast23FYkosxRc4RjU6jzUjPk3Tnjyepeio7ys3g2To18Mw9nBa7nswIrTcNmjdlOgeiZ9cb0cVi03apFgjf8RgG3N2+3aXwkzVJZI8v5d6mFMYPmaUnqfE75NYm5V5T/fS9xY2SZCZjueS0hsIoFDds99XcEDGOrhPL0O/3Zr0CGGCwp7F2AKOnlaVwPnR+RDqZgzWkSP/xsqkTeq89m9n42RX9+ELfRBjdB8w2IseqXKYLCjQLCYTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mlySgRa3aXx13KatwQ5/JqusdclKYsr1UAq0hIkrSTo=;
 b=Z8bZ39XUIZmRGm1k7E2UNRRDvluLoWqMpsOqiNk5mE6d86J56AfgEt/dWQmhxi3V1UPZO36yE01NtAAJK4mk+Q02a6YFlSpEaUOmgTv+2gZ7piUAm0ZHnnqNBaXj7ipLGOUq/w65bR1ckY5gZqkhYAt91X2ydjJUUc8OgHX9Hnq2l9+XS1qfxOL0kdH91J/b8k1GmZsnx5Y0px5yryLp3Q5IqKfUahel1uB7m1QK4BYO/FRg+sD6XglWQHt5DwK8FEVEz09wcz4C26Qe0Duj9yCufWo/UPBLPYqfudzndIuV7HZ0vilhtGgeBX7NoiqIxaf0Fm4jORk824VrUdALCQ==
Received: from CH0P221CA0007.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11c::23)
 by SJ0PR12MB5675.namprd12.prod.outlook.com (2603:10b6:a03:42d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Tue, 21 Jul
 2026 19:48:56 +0000
Received: from CH3PEPF00000017.namprd21.prod.outlook.com
 (2603:10b6:610:11c:cafe::2e) by CH0P221CA0007.outlook.office365.com
 (2603:10b6:610:11c::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.10 via Frontend Transport; Tue,
 21 Jul 2026 19:48:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH3PEPF00000017.mail.protection.outlook.com (10.167.244.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.0 via Frontend Transport; Tue, 21 Jul 2026 19:48:56 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 21 Jul
 2026 12:48:36 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 21 Jul
 2026 12:48:35 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 21 Jul 2026 12:48:35 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>
CC: <joro@8bytes.org>, <praan@google.com>, <kevin.tian@intel.com>,
	<smostafa@google.com>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>, <jamien@nvidia.com>
Subject: [PATCH v9 01/12] iommu/arm-smmu-v3: Do not enable EVTQ/PRIQ interrupts in kdump kernel
Date: Tue, 21 Jul 2026 12:48:10 -0700
Message-ID: <35000f29472b5e12114073d614168c251551ff0a.1784663184.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1784663183.git.nicolinc@nvidia.com>
References: <cover.1784663183.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000017:EE_|SJ0PR12MB5675:EE_
X-MS-Office365-Filtering-Correlation-Id: ab9ee0cf-7342-4684-4f03-08dee76119bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|82310400026|1800799024|36860700016|18002099003|22082099003|6133799003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	eaJB+wLkzwDp30umt7NJgEQ/a4EzfbGLov5D9ZYfGPQtYneNTWZQpx+enLs/so1/6lIpjg8VI6u8JzJJn20KRKeEYu2kYMq21yr3OxvHRm7reKJomqGpsY4BVRtGA3RpWTWvTAlt3hToETjjhOLC6Spp/Ic2NIMKDKD4N/S3OmRngrqvGTtfgZXO7Sej5YjrmpK17kvkPxSRV9Uysduu90zu7Snoqmn3W+Gnyra81Be7kdPneFx291k9ydPp0m6xnhtZ1wTcBo4koDbrqeKHYJWxfAwyd3dtO2bqoUbhy3hFnsiY9gAV2YHYrIXym2a57ziKCaZ9Ez7DXHu68aqd7XpAsoAIDt3nO/vaAn2gVplRotjDv+OVYaBBSoLRPFMnqe27yBKOCVc3eRDT+1ah6SOSx7/Wo01kgoDPfhokJvvh2x/YlNyhmuN9KFOIkqLn7shMHJpMRqgfKSKnah4OShBoYDmMrkZHXECvNB18UBzqAaydZFzV3biHGgZfip+8SpL4m5twe1R/jDze/W9sr/GXDIJLuR+7kBaQ6/2k9ZFTvEHHcXuqn2HT1Ixz1wqzyW5ABs8pzeaREpa4gfKQoG7Bm6Yk4Empz/UHq0ju6EPgd7IErI0ouN1k6WiCDKnE7gzcSvEUsKEYZDTc/tHwiMeDpaq8qE7D0kz0HWOhyumnjltY/fdXCTGX2j1CPdgGndUvoAfgyrsFtNMuIk+szw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(23010399003)(82310400026)(1800799024)(36860700016)(18002099003)(22082099003)(6133799003)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	mJPLdTnopqYkAZcM5q9DNaBBaqZ23ADmQKknlQXJJ1jPc1I0ec2KEqWeU+RSW0SQRqxb+kH5nKgwKO7fEQqugW/CbULAaqvd39tGdBdvtZEkOLO+pXxy0AcKnI2XTls+fvZg+9ijkCxjh569/Wi5T6+ddk/7DCChJQyxSNzSlolR3tKq1q1KlHU5gE7+EgIN6aU0jbsaPvDVvvtzcIeefmi6Cu1W+vzVVsKrgnXTa2bnOTsCQYiOxnJ3k4eLo3uRpewu8id0XiTNhHzhveS+v4kiuI8ccntoGw42vam8AqmtHxbkOtSlHPnJCuCh2KMRezaZFvu9cjJZpxo7+oAeSga0IajSoY4rk0RMy33DJRQt+5MMbITP51Fg+FT+KA+Z6Yk9AWJuYsRNgfWdWBxyJQIPkC1NKUtpm/8I0xmR2vMW6uN62vasgGZ2/XQEVh8x
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 19:48:56.1190
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab9ee0cf-7342-4684-4f03-08dee76119bc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000017.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5675

In kdump cases, the crashed kernel's CDs and page tables can be corrupted,
which could trigger event spamming. Also, we cannot serve page requests.

Skip the IRQ setup for EVTQ/PRIQ in arm_smmu_setup_irqs().

Skip their IRQ handler registration in unique-IRQ and combined-IRQ cases.

Note that arm_smmu_device_reset() at this point still enables EVTQEN/PRIQEN
transiently before clearing them. A following change will skip the entire
queue setup, removing that transient enable window.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Pranjal Shrivastava <praan@google.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 58 ++++++++++++++-------
 1 file changed, 39 insertions(+), 19 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index a10affb483a4f..404790d2c7210 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2294,7 +2294,11 @@ static irqreturn_t arm_smmu_combined_irq_thread(int irq, void *dev)
 
 static irqreturn_t arm_smmu_combined_irq_handler(int irq, void *dev)
 {
-	arm_smmu_gerror_handler(irq, dev);
+	irqreturn_t ret = arm_smmu_gerror_handler(irq, dev);
+
+	/* In kdump, EVTQ/PRIQ are disabled and there is no thread to wake */
+	if (is_kdump_kernel())
+		return ret;
 	return IRQ_WAKE_THREAD;
 }
 
@@ -4625,6 +4629,21 @@ static void arm_smmu_setup_unique_irqs(struct arm_smmu_device *smmu)
 	arm_smmu_setup_msis(smmu);
 
 	/* Request interrupt lines */
+	irq = smmu->gerr_irq;
+	if (irq) {
+		ret = devm_request_irq(smmu->dev, irq, arm_smmu_gerror_handler,
+				       0, "arm-smmu-v3-gerror", smmu);
+		if (ret < 0)
+			dev_warn(smmu->dev, "failed to enable gerror irq\n");
+	} else {
+		dev_warn(smmu->dev,
+			 "no gerr irq - errors will not be reported!\n");
+	}
+
+	/* No EVTQ/PRIQ interrupts in kdump -- queues are disabled */
+	if (is_kdump_kernel())
+		return;
+
 	irq = smmu->evtq.q.irq;
 	if (irq) {
 		ret = devm_request_threaded_irq(smmu->dev, irq, NULL,
@@ -4637,16 +4656,6 @@ static void arm_smmu_setup_unique_irqs(struct arm_smmu_device *smmu)
 		dev_warn(smmu->dev, "no evtq irq - events will not be reported!\n");
 	}
 
-	irq = smmu->gerr_irq;
-	if (irq) {
-		ret = devm_request_irq(smmu->dev, irq, arm_smmu_gerror_handler,
-				       0, "arm-smmu-v3-gerror", smmu);
-		if (ret < 0)
-			dev_warn(smmu->dev, "failed to enable gerror irq\n");
-	} else {
-		dev_warn(smmu->dev, "no gerr irq - errors will not be reported!\n");
-	}
-
 	if (smmu->features & ARM_SMMU_FEAT_PRI) {
 		irq = smmu->priq.q.irq;
 		if (irq) {
@@ -4667,7 +4676,7 @@ static void arm_smmu_setup_unique_irqs(struct arm_smmu_device *smmu)
 static int arm_smmu_setup_irqs(struct arm_smmu_device *smmu)
 {
 	int ret, irq;
-	u32 irqen_flags = IRQ_CTRL_EVTQ_IRQEN | IRQ_CTRL_GERROR_IRQEN;
+	u32 irqen_flags = IRQ_CTRL_GERROR_IRQEN;
 
 	/* Disable IRQs first */
 	ret = arm_smmu_write_reg_sync(smmu, 0, ARM_SMMU_IRQ_CTRL,
@@ -4682,19 +4691,30 @@ static int arm_smmu_setup_irqs(struct arm_smmu_device *smmu)
 		/*
 		 * Cavium ThunderX2 implementation doesn't support unique irq
 		 * lines. Use a single irq line for all the SMMUv3 interrupts.
+		 *
+		 * In kdump, EVTQ/PRIQ are disabled, so no threaded handling.
 		 */
-		ret = devm_request_threaded_irq(smmu->dev, irq,
-					arm_smmu_combined_irq_handler,
-					arm_smmu_combined_irq_thread,
-					IRQF_ONESHOT,
-					"arm-smmu-v3-combined-irq", smmu);
+		if (is_kdump_kernel())
+			ret = devm_request_irq(smmu->dev, irq,
+					       arm_smmu_combined_irq_handler, 0,
+					       "arm-smmu-v3-combined-irq",
+					       smmu);
+		else
+			ret = devm_request_threaded_irq(
+				smmu->dev, irq, arm_smmu_combined_irq_handler,
+				arm_smmu_combined_irq_thread, IRQF_ONESHOT,
+				"arm-smmu-v3-combined-irq", smmu);
 		if (ret < 0)
 			dev_warn(smmu->dev, "failed to enable combined irq\n");
 	} else
 		arm_smmu_setup_unique_irqs(smmu);
 
-	if (smmu->features & ARM_SMMU_FEAT_PRI)
-		irqen_flags |= IRQ_CTRL_PRIQ_IRQEN;
+	/* No EVTQ/PRIQ IRQ generation in kdump -- queues are disabled */
+	if (!is_kdump_kernel()) {
+		irqen_flags |= IRQ_CTRL_EVTQ_IRQEN;
+		if (smmu->features & ARM_SMMU_FEAT_PRI)
+			irqen_flags |= IRQ_CTRL_PRIQ_IRQEN;
+	}
 
 	/* Enable interrupt generation on the SMMU */
 	ret = arm_smmu_write_reg_sync(smmu, irqen_flags,
-- 
2.43.0

