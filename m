Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.85.5
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794343863;
	b=5eH1bSe2PqHJ28aRaUjLgdnkhuDyAsMIPZBczi4WcU7cSACo0llJrBSEK6Kp8SwcbuEH
	 kHNMHeNa97TlJUV1oj1TA51MlKFvrDIB5t4dvHj39Mq51JJmwZhInhydRNrM/YauSSGL4
	 aVnEhClX3m/by53tt/PNB2+90Ap7cQ2QfCA2UthS6miLwGw011N+P6wGHKdRYCeauuKCU
	 4dGnVQA3LM1QXWqx/eg3I0IrcZs+CIPChJzu8oEHouxEas4f0cB6r1ejmSW47v4Zd6S1h
	 IX0GCR7Oru7thG3SamGkwZOcsEmfkZqYWnPZeB9vlqgQFE+NbMWHGCjzZacUhrzfssw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794343863;
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
	bh=hWV2eKJixaFamalh3hmqVnbDDqzdegUq0wWEBO4ESOQ=;
	b=rV5YQSQVe7c0BzptHuVBDL5tqav5vfDOHYmFtmbPxyICeEev+AKtWdqcB/4ztxJ7n2v7
	 Cw8LSb10lzlu13a5dnmNgpCdnb7/H4HWhpXeBRnXucERXE5T6mnmGOoS9f2+hgzfL2ufv
	 xVPBud/9nBdzQTJz6mggby5hDNyYIs4pbcx4QtsrBsajT3Wxbc7VWwmh8LRPyWlGdld78
	 GMsuO575oeF//uspyrNhq0c7Jn9e8TqYlGfZkAmI9G7fWGQRh6Vl8GR0dCDOVeszg8PXX
	 n/jLAGJ4Cqccboe3XX+L7Zv4hSgMhHWq49DCx55hMMfNZb8AWtxu84ZoaNCzX01+seg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=eOlhfSFa;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.85.5
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010005.outbound.protection.outlook.com [52.101.85.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C1B606A33C;
	Tue, 10 Nov 2026 20:51:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 08C1B606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=eOlhfSFa
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LYlPsYsv1Mlw4VQUrpSM5POKqfxyZ5B4I6ksN0KlJkme80/i2BjVo21I/Z4QqlMwo8kLj2AnnInG+TPimtyQ1/YMnnrFzM+yZtK93jMY0UGX2KzEk7zun1UQ0ei550SfjpzAVY9s68VF+7k9ehmzMppuIWmPH9bI6G0DoLDARg3mvgZG2rrLT4k1xE7WpMAoV3gDBqYdM/Z3IHs5rghwp+moCW+wMecxmi4gJxZphTDMiMMx/fIvUWD6idAryYs+plib19+l8i2tM9bCbbkBtnEiAsh0UWPfckgLoeuECzahVMBfx/Get5fm8BN7mUxnIOWeOk2aYn9OUNZUe/kI8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hWV2eKJixaFamalh3hmqVnbDDqzdegUq0wWEBO4ESOQ=;
 b=doYX0/KuI6eTemG/QXLzuyhnp0LirCOtSnecsx/niPFVATI/JYzbA9AGuM+xS1WoMj3g+3we4KOVy0I+cH/fexWAnYTsipgkQZ03jqft2kF/XqMnZLFXWXC2H8I6x5AfdGkJ9mqH3ZWdO/yHPW+4P2/UdnjjMpI9jAWf5epLJD6RHWWI1zPvQj9youffphwuN4McOkk5Mjz1sWkLLOV3AcgZzzQgQOcQD+lhu9zwX0C1VTd4X3V71pbPrmpJEBW7QnLgUVB7qoG/LwHCGx3TiJljdFMKJFxg2J+Tlu8t4rbQWbNNZUiJhDgfK0ZNAyR8uWhmjKgsdYhdr8ekuBUhSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hWV2eKJixaFamalh3hmqVnbDDqzdegUq0wWEBO4ESOQ=;
 b=eOlhfSFaDbdknXCJKgyOtHHznnAaAPN0b4xJQML19bPIVKQDXRWZTcdw6p9GmEn3nDrJYWRq+r4WLjidzyZYsLBtNzvdRApxnKtLjRUAs6Ruj4WnLBTPpE9rhRt3SDKLXus5CwaFYdFrC9sYyWUtd2IALBn1IjKz8isl/Q5oDVrLSsP4JzNElOq/iluOtjGGrzBf64WxBq8X27tzUlth3K8nNSyCDB5dMbYsPrZ2xdYGKmt7U9YnkcMA+1VhiYgfZBWH4fbNYODJhlSWOOMw4i0KnpKCTAOjymtkd7yhmDzs5dNoKBctQHjj9suK/0y7wNZ+6HXeK0UJmD2tHDWniA==
Received: from BY3PR03CA0010.namprd03.prod.outlook.com (2603:10b6:a03:39a::15)
 by IA1PR12MB8239.namprd12.prod.outlook.com (2603:10b6:208:3f7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 20:50:57 +0000
Received: from SJ1PEPF000037B4.namprd05.prod.outlook.com
 (2603:10b6:a03:39a:cafe::3a) by BY3PR03CA0010.outlook.office365.com
 (2603:10b6:a03:39a::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Tue, 10
 Nov 2026 20:50:56 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF000037B4.mail.protection.outlook.com (10.167.244.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Tue, 10 Nov 2026 20:50:56 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Tue, 10 Nov
 2026 12:50:36 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Tue, 10 Nov
 2026 12:50:35 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.2562.56 via Frontend
 Transport; Tue, 10 Nov 2026 12:50:34 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>, <joro@8bytes.org>, Will Deacon
	<will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Catalin Marinas
	<catalin.marinas@arm.com>, <rafael@kernel.org>, Danilo Krummrich
	<dakr@kernel.org>, Johan Hovold <johan@kernel.org>, Marek Szyprowski
	<m.szyprowski@samsung.com>
CC: Mark Rutland <mark.rutland@arm.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Pranjal Shrivastava <praan@google.com>,
	"Mostafa Saleh" <smostafa@google.com>, <linux-kernel@vger.kernel.org>,
	<iommu@lists.linux.dev>, <driver-core@lists.linux.dev>, Sonang Patel
	<sonangp@nvidia.com>, Ankit Agrawal <ankita@nvidia.com>,
	<shameerali.kolothum.thodi@huawei.com>
Subject: [PATCH v3 7/7] iommu/arm-smmu-v3: Probe a guest-level Realm VSMMU via RSI commands
Date: Tue, 10 Nov 2026 12:50:12 -0800
Message-ID: <6872b2febdeda2990731fa6946cb4e00c7899185.1794343501.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1794343501.git.nicolinc@nvidia.com>
References: <cover.1794343501.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037B4:EE_|IA1PR12MB8239:EE_
X-MS-Office365-Filtering-Correlation-Id: a2b806ab-e072-48a6-0edd-08df3f6c5155
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|7416014|23010399003|36860700016|6133799003|261009223027099003|10067099003|261026121527099003|261026140227099003|261022075727099003|261022105027099003|261021135927099003|261028144727099003|261021123027099003|261021121427099003|261102123227099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	LcSHuVLaPGSOIdp4F6sBMVtBFdAyRjORexpbj83XrBlc1W/ecjZM/F09botmSL2MlsQPVVucekcTvQKtUD1JeSZUiY4Tz/CvXx7KdBKK6dbEfG/6GyZvi6dnp/c44b2VZhoUOwxkIAUjOJqCQAl7YnVGVz3oMMcGfrYOL4TIhfvxcFquELGgPmpV/OChDq01/fpf7DVtQ/2IpISZBXJnT36NH3DVXNnvgekflOKCE/fR25wgrvjzeDoF5vCR2mgI+oMytb5k1pQEFHHuPqocYufzKjZCsgyWBao1ipVaxa6m7X1Dt1EtQyNTTLqW1AO/gHtbCZxfR/+CmFAnxytsKfs639DlJsFSL1ikuYsQn2iq+DlCxGVWlRxdRfr8BlIrqY7L5zHko+ckyPAqIHMJsmN88fbguMjUSYzKb1Z1Ai2yu28ksaBlmTvU7qXylPhwCEbN73dW8HRH1Yib674JKbmjurKv6Bp0qdOufkLNY18sCi5P8OnS/M+b5KfCK22taYk8+3bu1lb7OAlwVi3C4ESJS3uJLWYHFTMCLuBsfxmbG+vOf/PDLV22wjA1bcPLYmgi4n22noEgZ0ZLci3OHSV2vjYJoXxZFIAXn6C3YH/tGORyKBsPv109m9lzGw4zjTNwSXNevlY8lcQDAnO5x5vgmf66hypQlI5oEw637MHT4rYWZMuxSl7LgK+ny9wvn2CJ+MxhvTHKfibnggUsbw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(7416014)(23010399003)(36860700016)(6133799003)(261009223027099003)(10067099003)(261026121527099003)(261026140227099003)(261022075727099003)(261022105027099003)(261021135927099003)(261028144727099003)(261021123027099003)(261021121427099003)(261102123227099003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Um/IKVFj53j7O5ZfcgDXl2NK4l/6qmx5M1Wa0L81Am78oVjWKeQ+Q595ePWhKibtBd2N59S75OMR/GgD0/HYUZli8TO9356n8osZDm0JjjW/5KHSSCtB7U2tkrWyQO9fMwgQqxJDPkLy5R83+MrxLEM5AYB1+C/5Z4lvy9/j9mbNY1+5kZ7aE35m/BA/K69JRyqrv1XsoPgjAE1tQVrBIluac3+GVPXSHcDbzjeFQ/TrjlNRBe8Jd3voyT4FeHDRHNpgYISjVzdB5xmiqtSsQixGyqmm3Ce2Znj5n4vi6F+GAsj3UM+3b+/nWFp3r2eTxkVUKMPo2YIy2xs3ZSnedEksdqWWLv9eEnxS2nk3mPRsbEVKoKxeO+9yDjTfQ05MrH/ntN5mFaITO6l9want0asDqh9H+SM6L2gaSVsq6DUwL+ipxIuCVDIbA8smdXHT
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 20:50:56.3123
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a2b806ab-e072-48a6-0edd-08df3f6c5155
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000037B4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8239

In CCA, the ACPI/etc doesn't tell the OS whether the SMMU is a confidential
T=1 instance or a normal T=0 one. Instead, it has to be learned by issuing
a trusted RSI. Before the kernel can operate the trusted T=1 IOMMU, it also
has to validate all the information that it gets from ACPI against the true
information that it gets from the RSI call, to ensure the ACPI is correct
and prevent substitution attacks.

Use RSI_VSMMU_GET_INFO during probe and require the returned register range
to match firmware. Then use RSI_ARCH_DEV_ACTIVATE before mapping registers.

Currently the driver doesn't support a T=0 SMMU inside a realm. For example
it doesn't make the page table allocations into shared memory. If we are in
a realm reject any SMMU that is not T=1.

Once the SMMU is activated, its DMA will follow the DEV_FLAG_DMA_CC_PRIVATE
rules. It must set that flag to ensure its coherent allocations for its own
structures are allocated from private memory, not the SWIOTLB shared pool.

Also skip Tegra241 CMDQV implementation in the realm world, since realm has
the support only for a standard SMMU for now.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 64 ++++++++++++++++++++-
 1 file changed, 62 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 6d4520c473086..f3a9436db15e4 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -11,9 +11,11 @@
 
 #include <linux/acpi.h>
 #include <linux/acpi_iort.h>
+#include <linux/arm-rsi-cmds.h>
 #include <linux/bitops.h>
 #include <linux/crash_dump.h>
 #include <linux/delay.h>
+#include <linux/dma-mapping.h>
 #include <linux/err.h>
 #include <linux/interrupt.h>
 #include <linux/io-pgtable.h>
@@ -5611,8 +5613,11 @@ static int acpi_smmu_iort_probe_model(struct acpi_iort_node *node,
 		/*
 		 * Tegra241 implementation stores its SMMU options and impl_dev
 		 * in DSDT. Thus, go through the ACPI tables unconditionally.
+		 *
+		 * Realm doesn't support Tegra CMDQV yet.
 		 */
-		acpi_smmu_dsdt_probe_tegra241_cmdqv(node, smmu);
+		if (!is_realm_world())
+			acpi_smmu_dsdt_probe_tegra241_cmdqv(node, smmu);
 		break;
 	}
 
@@ -5676,7 +5681,9 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev,
 		smmu->features |= ARM_SMMU_FEAT_COHERENCY;
 
 	if (of_device_is_compatible(dev->of_node, "nvidia,tegra264-smmu")) {
-		tegra_cmdqv_dt_probe(dev->of_node, smmu);
+		/* Realm doesn't support Tegra CMDQV yet */
+		if (!is_realm_world())
+			tegra_cmdqv_dt_probe(dev->of_node, smmu);
 		static_branch_enable(&arm_smmu_erratum_repeat_tlbi_cfgi_key);
 	}
 
@@ -5779,6 +5786,53 @@ static struct arm_smmu_device *arm_smmu_impl_probe(struct arm_smmu_device *smmu)
 	return ERR_PTR(ret);
 }
 
+static void arm_smmu_clear_realm_private(void *dev)
+{
+	dma_set_cc_private(dev, false);
+}
+
+static int arm_smmu_probe_realm_vsmmu(struct arm_smmu_device *smmu,
+				      const struct resource *res)
+{
+	struct device *dev = smmu->dev;
+	unsigned long rsi_ret;
+	phys_addr_t top;
+
+	/*
+	 * Currently the driver does not support a T=0 SMMU inside a realm. For
+	 * instance it does not make the page table allocations into shared
+	 * memory. If we are in a realm reject any SMMU that is not T=1.
+	 */
+	rsi_ret = rsi_vsmmu_get_info(res->start, &top);
+	if (rsi_ret != RSI_SUCCESS) {
+		dev_err(dev, "RSI_VSMMU_GET_INFO failed for %pr: %lu\n", res,
+			rsi_ret);
+		return -ENODEV;
+	}
+
+	if (top != res->end + 1) {
+		dev_err(dev, "VSMMU range %pr ends at %pa\n", res, &top);
+		return -EINVAL;
+	}
+
+	rsi_ret = rsi_arch_dev_activate(res->start, RSI_ARCH_DEV_SMMUV3);
+	if (rsi_ret != RSI_SUCCESS) {
+		dev_err(dev, "RSI_ARCH_DEV_ACTIVATE failed for %pr: %lu\n", res,
+			rsi_ret);
+		return -EIO;
+	}
+
+	/*
+	 * Once activated, the SMMU DMA follows DEV_FLAG_DMA_CC_PRIVATE so its
+	 * queues and tables are allocated from private memory, not the SWIOTLB
+	 * shared pool. It only translates for a device we've requested the RMM
+	 * to put into T=1.
+	 */
+	iommu_device_set_confidential(&smmu->iommu, dev);
+
+	return devm_add_action_or_reset(dev, arm_smmu_clear_realm_private, dev);
+}
+
 static int arm_smmu_device_probe(struct platform_device *pdev)
 {
 	int irq, ret;
@@ -5814,6 +5868,12 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 	}
 	ioaddr = res->start;
 
+	if (is_realm_world()) {
+		ret = arm_smmu_probe_realm_vsmmu(smmu, res);
+		if (ret)
+			return ret;
+	}
+
 	/*
 	 * Don't map the IMPLEMENTATION DEFINED regions, since they may contain
 	 * the PMCG registers which are reserved by the PMU driver.
-- 
2.43.0

