Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.28
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794943334;
	b=QCqTggplGGb9DQccZM+lFmg6uNK1497qQoUUnzY41GMPzEUbEDE7JVYAEgZFYepAtdFR
	 hczDy3Ta0MvtU8nG0FR+7jBjxP1aoX5MQcGfU68XGr5KmIg7ysEjdfE0leLGL+5DJ43NG
	 E5fthlE/x8vGfDPsBFvhFG3v94JkJgvGHMqQ8sQEN/5TttEkqPLlV9w/gGYCLc6idHc/y
	 wQ4zPhHF1OAA5DyAVuYQtEA3DBV6FDMa2zZDslclY21pKF39n/ldoi/rB+BltbBy9JHM/
	 IhxXYeSkV+057Hmtrraw65zICkoanlQ4nD+aHf0fbQBMh6623h+Nbyx/HawJXsuy0vA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794943334;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 Content-Type:X-NV-OnPremToCloud:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=H8xvxPNWx8K7zQClODxVjwXVekLlgsGZmhyp+PZSiWs=;
	b=AJHw/fe7Wpeb6I95QQloAgP3FwbhOu/I795o22yotnfExhUrv2KMFZSE6q7FiLyYRq5u
	 Jcan7YeAHa7Zu/38nRkASgnkZChcV1m05EWV3Mi9ZCCaDD4R78kL28NIHhpR63LeSPL44
	 EW/G7djTXvBcKNhfKF7HUUSIsOJJzyhsQHlAY/lGxVTcjCK+13Pzg+xDlNDTldGjgaF/s
	 GB/QxaoxwYAqMEhoVfwSxArFXWMw1oG7sV401xQBy1KtCP+cjxP8N7uKZt9YXJiMQt0ht
	 QMFNnF9vgC7r6pQzTX0sY5KMlKPWUa2M0hfBxUtOXs+ezZVOe33aLjjODWsPJhvVYug==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=KeIZJWkb;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.28
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013028.outbound.protection.outlook.com [40.93.201.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74846606A32F
	for <iommu@lists.linux.dev>; Tue, 17 Nov 2026 19:22:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 74846606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=KeIZJWkb
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=limpiJ9HoET7TEsfjjjN+NHgFitRdTcMXsaHfJSeLJwXWvDYMnNoDif/F9LBhNTQgOqdjgtAO21p6b/A267/MFlGEHL5wghHbmMMfGBDuUZpRDEUa2NG11UqXNaBrvBG+u1tUcPzvHxu05CN+QDI/Y8DMt6YOziYCFlweSPHO1gNX1lTgoQT9zPULs/B/+l6nm7F+NrROFNb7gy7jn3oiZaZCdJ3jV0OAOSqduKPPRwKFUUxfGdIS/VFOB6Zaq8M/f5eMlRq+AfHh2abAu21rNXWOJhjiNUW+WArUvX3T9O4kMfpC8k/Go9C9f2NCynNjjXVNQ9FsRCHhX+yyoaj6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H8xvxPNWx8K7zQClODxVjwXVekLlgsGZmhyp+PZSiWs=;
 b=geAYcw8ojAO6Yyea62ILDGXEFjhTrnT1hIDhBZlRyDyI3rVIrFPUdCHqurqy4PUFFQHaxRdwLPPMs8mocYqIf269SgJOoyaM/QwlVahF+ZcaEi3v+Sy6vCOGSXV+tmvT6SFHrM8SGOhGFAs4jh1XVGRd5xcUzCmU+NDxFOqIAb7GKuMPicpAO8Es4jATgbM4Z0MOdF1iLb5/Nw3QNyDXg0NpwS7sTjuGSuSspTnXHIvRL7fhJmjwqENZs/BTumd1+7hOndbony2PA6ZtO4Mxcg6E2McQXJyePNt0JY2up0Iv91H2c/tkbnrrkMXbbeuNMz+6YowgmJBdBLW53lTc4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H8xvxPNWx8K7zQClODxVjwXVekLlgsGZmhyp+PZSiWs=;
 b=KeIZJWkbAENxaFCPo8SgKYWlqG8LEbUWczysVsk9a4RWPzO9Z4Qsu0DpWgUhgER50Ozn54G2RHRf7kp3dHMyzYKnXGilozL0EVPD1bpfPgXwjYYPs8/mr3W4PREEQkj+Orj0e/IMc/xbxTlVdYjBSoxN6AZfuG1bWD97gO4UK/BrA9/GAl0P0SSQ+ty73QvGIyaml2qNHLYa5JfTg7yssyRXMHofuL5fqtTryOep+Iu94zFpOEnTlvunk1QKRY9qKD4POzz0e/X5jxk1XPEZCrqUrRbGhqx8WH+JyVQifKSxBR7dC977nyXaeC2kOL0kEQmHFImwdFeD4z4f7TnTjg==
Received: from MN0P220CA0024.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:52e::18)
 by IA1PR12MB6020.namprd12.prod.outlook.com (2603:10b6:208:3d4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.13; Tue, 17 Nov
 2026 19:22:03 +0000
Received: from BN7PEPF00000096.namprd03.prod.outlook.com
 (2603:10b6:208:52e:cafe::3a) by MN0P220CA0024.outlook.office365.com
 (2603:10b6:208:52e::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.14 via Frontend Transport; Tue,
 17 Nov 2026 19:22:03 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.118.232) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN7PEPF00000096.mail.protection.outlook.com (10.167.245.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Tue, 17 Nov 2026 19:22:03 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 17 Nov
 2026 11:21:39 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Tue, 17 Nov 2026 11:21:39 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Tue, 17 Nov 2026 11:21:38 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <jgg@nvidia.com>
CC: <robin.murphy@arm.com>, <joro@8bytes.org>, <praan@google.com>,
	<kevin.tian@intel.com>, <smostafa@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <jamien@nvidia.com>, <kas@kernel.org>,
	Cristian Prundeanu <cpru@amazon.com>, Breno Leitao <leitao@kernel.org>,
	<xueshuai@linux.alibaba.com>, <john.garry@arm.com>
Subject: [PATCH v13 04/12] iommu/arm-smmu-v3: Pack the MSI vectors of the used sources
Date: Tue, 17 Nov 2026 11:21:21 -0800
Message-ID: <40570c344d7fce94c4e80316503a9162bb31cb62.1794942324.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1794942324.git.nicolinc@nvidia.com>
References: <cover.1794942324.git.nicolinc@nvidia.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PEPF00000096:EE_|IA1PR12MB6020:EE_
X-MS-Office365-Filtering-Correlation-Id: 5aea77e6-c3d9-472c-15c5-08df44e00fd3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|36860700016|82310400026|10067099003|11063799006|56012099006|261026121527099003|261021121427099003|261022075727099003|261021123027099003|261021135927099003|261102123227099003|261009223027099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	qUvxJW9fwS2uwC7lle9m8K178rEvRBsz/0mNYBuyQx0oWnFoSoFmGf6uYKmml/T07wpgOYi7os3BDeilfyj8lHCbiaDBFeGW4R7eLteSIxIBEgEiET4zBaCtgKR3n47ynUMePn7DTBS81tTDZ6KUCCcMHwneedxmEoIbAsjFkwqX2vLSpskYiTD3lbbQ+aBMwYBMTbBlN/WUXU98bhgr7iuKMszXFKmUsNvnGLOw50Mb5g37V06COyph5Ka6wghBgUzhln29+XQNVrpYRIygAlHRe7NIx/AE+6dA5kdMy/vyqlqj+CKtuIZi0Lq07Alwa9CPsWfuu+xjTgjYXZhT7DUWCEEpOAfR+HtQXcMeM+DGlvj8x7a/FEXDkx6xYUodh9Vf+LSIUPLCrOosu0KZ2+pph7NiIr/thfAAW8g1ynw2ltIY6BFQoujsa/XchaWCOOkVHMPrFVjsiOERzpoynHZC/z4yOqvep5C7vEILlsBQrsCxJy+zNWcXnkNX9iZUt3TBlP6plHqfl8waxg0YIttI514crGf2fRDAnRrUB4+A4VHlmhqtymT7jgb2sCKC60dpHVVfif9Rv4rbFOTEQz5wIHsaqjbMFw448mjc4dsmUEkQ7BrVAsohI0EPjcfASRgdVtDQWcbh/G+r4SPuU8Qu48ZDaLU1qRcsyhLQyEZ4dZNkOGngRk8wtPGpbICb10J9Kqgar54c6y7+6GkLiw==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(36860700016)(82310400026)(10067099003)(11063799006)(56012099006)(261026121527099003)(261021121427099003)(261022075727099003)(261021123027099003)(261021135927099003)(261102123227099003)(261009223027099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	QRtJ+Wg811LT+7CihFK/9YF/plgnCfXieo82HyQIKxVRzAJy2CAdbLg4Fdgv5+4WrMpm8y44wJDFQG7fFlrPCcFh6yimG9C7Z2kbid4Fl3OyK+k7we/Mrq3gpvSaWhsBGXfCP5zfd8TQEqE2EuUAPaIY16K3yC2yPFWmKgfsDNhwFnnVy94g49LfCIz4i7rSQvCJHFWigJ7tzfqISyXk+klIga5ZnGL6n3hzARv1BWv9VqADocLXtz7uWf3BOU0O3okrBp9W+Gl+pqCFguNxF2DvRcJyCyKuMBimSY3KmVoxjt4KkusBIzNS+3Jg5laIwA//fao+EnhA2Tdjghllyds5K5p+ZsPK4LTgNB0MNZn5HDjNd/f4Etlh66/6uhqIq1oVZBBKg/BvaPs0u49sCMg/ptBcAFq3x1kvOay19W28et95i4RuU+0z4ndGRf1z
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 19:22:03.6915
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5aea77e6-c3d9-472c-15c5-08df44e00fd3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN7PEPF00000096.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6020

arm_smmu_setup_msis() skips the PRIQ vector by decreasing nvec, which only
works since PRIQ_MSI_INDEX is the last index. A subsequent change will make
the EVTQ optional for kdump, whose index is 0, so that trick won't work.

Pack the vectors of the used sources instead, and record the source of each
vector in a new msi_map, for arm_smmu_write_msi_msg() to find the register
set, regardless of the sources in use.

No functional change intended.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  9 ++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 46 ++++++++++++---------
 2 files changed, 36 insertions(+), 19 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 8f2c0b1cc4a8d..f6892dd0e5080 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -936,6 +936,13 @@ struct arm_smmu_impl_ops {
 			  const struct iommu_user_data *user_data);
 };
 
+enum arm_smmu_msi_index {
+	EVTQ_MSI_INDEX,
+	GERROR_MSI_INDEX,
+	PRIQ_MSI_INDEX,
+	ARM_SMMU_MAX_MSIS
+};
+
 /* An SMMUv3 instance */
 struct arm_smmu_device {
 	struct device			*dev;
@@ -993,6 +1000,8 @@ struct arm_smmu_device {
 
 	int				gerr_irq;
 	int				combined_irq;
+	/* Indexed by MSI vector */
+	enum arm_smmu_msi_index		msi_map[ARM_SMMU_MAX_MSIS];
 
 	unsigned long			oas; /* PA */
 	unsigned long			pgsize_bitmap;
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index d5938c624c68f..36ca05418f728 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -56,13 +56,6 @@ static struct iommu_dirty_ops arm_smmu_dirty_ops;
  */
 static DEFINE_STATIC_KEY_FALSE(arm_smmu_erratum_repeat_tlbi_cfgi_key);
 
-enum arm_smmu_msi_index {
-	EVTQ_MSI_INDEX,
-	GERROR_MSI_INDEX,
-	PRIQ_MSI_INDEX,
-	ARM_SMMU_MAX_MSIS,
-};
-
 #define NUM_ENTRY_QWORDS 8
 static_assert(sizeof(struct arm_smmu_ste) == NUM_ENTRY_QWORDS * sizeof(u64));
 static_assert(sizeof(struct arm_smmu_cd) == NUM_ENTRY_QWORDS * sizeof(u64));
@@ -4934,7 +4927,7 @@ static void arm_smmu_write_msi_msg(struct msi_desc *desc, struct msi_msg *msg)
 	phys_addr_t doorbell;
 	struct device *dev = msi_desc_to_dev(desc);
 	struct arm_smmu_device *smmu = dev_get_drvdata(dev);
-	phys_addr_t *cfg = arm_smmu_msi_cfg[desc->msi_index];
+	phys_addr_t *cfg = arm_smmu_msi_cfg[smmu->msi_map[desc->msi_index]];
 
 	doorbell = (((u64)msg->address_hi) << 32) | msg->address_lo;
 	doorbell &= MSI_CFG0_ADDR_MASK;
@@ -4944,19 +4937,28 @@ static void arm_smmu_write_msi_msg(struct msi_desc *desc, struct msi_msg *msg)
 	writel_relaxed(ARM_SMMU_MEMATTR_DEVICE_nGnRE, smmu->base + cfg[2]);
 }
 
+static void arm_smmu_setup_msi_vector(struct arm_smmu_device *smmu,
+				      unsigned int *vec, unsigned int *nvec,
+				      enum arm_smmu_msi_index msi_index)
+{
+	writeq_relaxed(0, smmu->base + arm_smmu_msi_cfg[msi_index][0]);
+	vec[msi_index] = (*nvec)++;
+}
+
 static void arm_smmu_setup_msis(struct arm_smmu_device *smmu)
 {
-	int ret, nvec = ARM_SMMU_MAX_MSIS;
+	unsigned int vec[ARM_SMMU_MAX_MSIS] = {
+		/* An unused source maps to a vector past nvec */
+		[0 ... ARM_SMMU_MAX_MSIS - 1] = ARM_SMMU_MAX_MSIS,
+	};
 	struct device *dev = smmu->dev;
+	unsigned int nvec = 0, i;
+	int ret;
 
-	/* Clear the MSI address regs */
-	writeq_relaxed(0, smmu->base + ARM_SMMU_GERROR_IRQ_CFG0);
-	writeq_relaxed(0, smmu->base + ARM_SMMU_EVTQ_IRQ_CFG0);
-
+	arm_smmu_setup_msi_vector(smmu, vec, &nvec, EVTQ_MSI_INDEX);
+	arm_smmu_setup_msi_vector(smmu, vec, &nvec, GERROR_MSI_INDEX);
 	if (smmu->features & ARM_SMMU_FEAT_PRI)
-		writeq_relaxed(0, smmu->base + ARM_SMMU_PRIQ_IRQ_CFG0);
-	else
-		nvec--;
+		arm_smmu_setup_msi_vector(smmu, vec, &nvec, PRIQ_MSI_INDEX);
 
 	if (!(smmu->features & ARM_SMMU_FEAT_MSI))
 		return;
@@ -4966,6 +4968,11 @@ static void arm_smmu_setup_msis(struct arm_smmu_device *smmu)
 		return;
 	}
 
+	/* Map each vector back to its source for arm_smmu_write_msi_msg() */
+	for (i = 0; i < ARM_SMMU_MAX_MSIS; i++)
+		if (vec[i] < nvec)
+			smmu->msi_map[vec[i]] = i;
+
 	/* Allocate MSIs for evtq, gerror and priq. Ignore cmdq */
 	ret = platform_device_msi_init_and_alloc_irqs(dev, nvec, arm_smmu_write_msi_msg);
 	if (ret) {
@@ -4973,9 +4980,10 @@ static void arm_smmu_setup_msis(struct arm_smmu_device *smmu)
 		return;
 	}
 
-	smmu->evtq.q.irq = msi_get_virq(dev, EVTQ_MSI_INDEX);
-	smmu->gerr_irq = msi_get_virq(dev, GERROR_MSI_INDEX);
-	smmu->priq.q.irq = msi_get_virq(dev, PRIQ_MSI_INDEX);
+	/* msi_get_virq() returns 0 for an unused source that has no vector */
+	smmu->evtq.q.irq = msi_get_virq(dev, vec[EVTQ_MSI_INDEX]);
+	smmu->gerr_irq = msi_get_virq(dev, vec[GERROR_MSI_INDEX]);
+	smmu->priq.q.irq = msi_get_virq(dev, vec[PRIQ_MSI_INDEX]);
 
 	/* Add callback to free MSIs on teardown */
 	devm_add_action_or_reset(dev, arm_smmu_free_msis, dev);
-- 
2.43.0

