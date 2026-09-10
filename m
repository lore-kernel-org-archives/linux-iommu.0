Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010046.outbound.protection.outlook.com [52.101.85.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E814E37F32D;
	Thu, 10 Sep 2026 03:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789011282; cv=fail; b=CXjFiAO+YLSHsoUagq2uO7mTDIYHejwproDS/qt5S12CxVDwJFMnw9+9nrr1x0SxqT6AMhEGJvjNoIQdNUTUmHF+BwCRgUeS7CknHB6DXjokUSlK9NHNglXiJS/cikCtW5e07rhzxfQvQLDOPsa/QynA0imQHofj4jVCkQYfWzw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789011282; c=relaxed/simple;
	bh=VSlpiOMejjdvUjggnEuZ+y9cCG1SsIHaN7TGkHcmN1g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pwLw32/JWWZm4H5mvk2gmfWgJkLiJxo6TmDC8EqGiLdue8Ek8XECs8Ka+b5bGP7o03prGgPdoLhFIg8iE1ltBoe/5DTEcPdEbzpKWRj5sAm+0QZU1L9pkgI6DsoAVjlLgfC0tmFbaEbrrCIm6PUwam7UvVXvxhrkdyBj1F0o+/o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CiNJiENt; arc=fail smtp.client-ip=52.101.85.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CiNJiENt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LBCX+Zr58bwO9BMcKYj3xS9d/AG5KhqwfRQJl7Rp56JuI9gYnOtnuug8fg79tfSqEJUmLQ5SF57+TvlngO2xytjkFahwaTUfQfqN/+Fg7jahyp/6Mv3mvcUiugMKccrYBW+dhms9K6K3clcuRiJZx6jMyPpQB+/yq2MD1MBP8SmPypX/iueaSfmyue1MdlzPBtCn47QNNF8/le0gkzLK/4svreBxWZsHZzUo2xQszRDTlMh9EQJrpnukfkJiQucUNmfr6UIbvYbk3UYEUwI0P92+GmnW8xLueNHpiyhJPBjcbzcx5A88fTVMku1hyVXIGjFfGIZejTmBxCWp0qcKSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KRgxd35oIwHiXkDjOaH6BgCMwgA2OzF2U7ApjvKEm8Y=;
 b=gXIBDKmSAPYrWispAEIDv2uQKyPREULVEI5eR4HcCRJmcPHuIgy/NuwfiEPPWzCl3BzCP0QSvZAx94VhEVv2MqR47OD6Dxt66I7O1cjtxvnWbGXI7AKX4JSHr9djfsq9BkvvQ9DbE3Obnr5b8OycXPxxHGqEx6u3YEgPcSWviiqgkBQ3q+ZCSTgjRfTWrFQ3FZI4ht2BviD2JSbWTOCBp2yAgdzW1ELlVrgvKPJrDjBrL80uhs35pDtTo5Qw+nF/KxHRPnkv+8o+BNQIF9kovDQO6Th8CIpSA+QxHPeCQzK0xzrJ/hpOdPz2+z0xjYFFcuw+oWw5DIARdxBLpM0QSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KRgxd35oIwHiXkDjOaH6BgCMwgA2OzF2U7ApjvKEm8Y=;
 b=CiNJiENtkbwz/475ewsRq8NzHc0iu9MBEQNXJRaL6LzU4m6F5ra6JBy24JbfaoNw5M5KxY3t5puDb0xHeKLLRQt1ycHqyT+4Sa9as+17nGpo7i5ondmvfGYjTqkbLrya3zDDqG09skXI4wfDfmHez6lYVZANQD4NEmszFC+YCwd+9OtdwDyKsk4l6XxkGQm+PhdeIG59toFUX7E8Rz+Y8tpAzKtTt2TL5xA1+PymTKL5+Yy8XXWXQFFL9SsjmOWTXiAgwjHVgCDz0kaPrAfuwIMroRX3yyTOTPmokiDRlECkMSVVU5y9u4Fim/GFm/+CuBtzvFtHs1jkvjGWrTJ6Og==
Received: from DS2PEPF00004563.namprd21.prod.outlook.com
 (2603:10b6:f:fc00::519) by BN7PPF9E4583E15.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6dc) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Thu, 10 Sep
 2026 03:34:28 +0000
Received: from CY4PEPF0000FCC5.namprd03.prod.outlook.com
 (2603:10b6:92f::1006:0:b) by DS2PEPF00004563.outlook.office365.com
 (2603:10b6:f:fc00::519) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.9 via Frontend Transport; Thu, 10
 Sep 2026 03:34:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CY4PEPF0000FCC5.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Thu, 10 Sep 2026 03:34:27 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 9 Sep
 2026 20:34:14 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 9 Sep 2026 20:34:14 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Wed, 9 Sep 2026 20:34:12 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>, Catalin Marinas
	<catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, <joro@8bytes.org>,
	Robin Murphy <robin.murphy@arm.com>, <rafael@kernel.org>, Danilo Krummrich
	<dakr@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>,
	<aneesh.kumar@kernel.org>
CC: Mark Rutland <mark.rutland@arm.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Suzuki K Poulose <suzuki.poulose@arm.com>,
	Gavin Shan <gshan@redhat.com>, Vikram Sethi <vsethi@nvidia.com>, "Anshuman
 Khandual" <anshuman.khandual@arm.com>, Shanker Donthineni
	<sdonthineni@nvidia.com>, Mostafa Saleh <smostafa@google.com>,
	<rppt@kernel.org>, Thomas Huth <thuth@redhat.com>, Marc Zyngier
	<maz@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>, <kas@kernel.org>,
	Kohei Enju <enju.kohei@fujitsu.com>, Shaopeng Tan
	<tan.shaopeng@jp.fujitsu.com>, Ard Biesheuvel <ardb@kernel.org>, James Morse
	<james.morse@arm.com>, Steven Price <steven.price@arm.com>, Sang-Heon Jeon
	<ekffu200098@gmail.com>, Omar Sandoval <osandov@fb.com>, Andrew Morton
	<akpm@linux-foundation.org>, Jinjie Ruan <ruanjinjie@huawei.com>, Sam Edwards
	<cfsworks@gmail.com>, Douglas Anderson <dianders@chromium.org>, "Florian
 Fainelli" <florian.fainelli@broadcom.com>, Chen-Yu Tsai <wenst@chromium.org>,
	Huacai Chen <chenhuacai@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
	Pranjal Shrivastava <praan@google.com>, Ashish Mhetre <amhetre@nvidia.com>,
	Shameer Kolothum <skolothumtho@nvidia.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<iommu@lists.linux.dev>, <driver-core@lists.linux.dev>, Sonang Patel
	<sonangp@nvidia.com>, Ankit Agrawal <ankita@nvidia.com>
Subject: [PATCH v1 8/8] iommu/arm-smmu-v3: Probe a guest-level Realm VSMMU via RSI commands
Date: Wed, 9 Sep 2026 20:32:51 -0700
Message-ID: <df25452641dc126eb334a1bfbe5eee16cc8a8953.1789010941.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1789010941.git.nicolinc@nvidia.com>
References: <cover.1789010941.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC5:EE_|BN7PPF9E4583E15:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b2db353-7b1c-431a-2440-08df0eec6ad3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|23010399003|1800799024|7416014|82310400026|56012099006|11063799006|10067099003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	AZdwUii2V9mR1lEuv2Aj5/w49KLjDC4KPyV15MmoxlDculnceXlZ5rpFBN6pbha2wYss3BGK6r1d68AgACIm6AWlORIfM9ZjB9NAFjUmNo31SEsuTP3svcG+fIubrgtDCFcIwJ5L6QLWD8z3PhmuKFwl5t7LMnZsYb2iPH4Q08Yi3W69s8s9X0eIAVL6PVVIzAqkY0KW05Fk4tYBxIMcm0G9HVDB6wESN2P+ecI8ljBG083ePiVJCrLqkik4Gy/Vl3S76bTCRkeZCZQ63NoO8cPicK/FcozcZWhqu6UHRrITsn1qWSjDZrskzd5h5Pg1gWrKYrhVD7N+Bpgk+ft4W1OQPNXD4IJLZhyVS+CcW77bKpzgEmt5saNrceTZBoPpjS1gVV+vuaNGIQLCLAlHz5RE7MwDiajfD/+nSS/lLzIZL1a6tRID/MMV8wHRpLtnuor8+d8cUDzbxaMTm854P1PY3u7vVYxcjG+guyKPjlo1GfNZ3ZGk9xTdN+wOlRYYwU7f34cix9faWaDCDx85thCkLU/9+DoPpFkKzSfxGuuJQ+B6I3P4kkV81aSypfEPBmQuHMWQ+/t1Hl+jIKwO8hZX+TV4Nn097Ud7fOJcJYKEznd6CV2FI5lDqF5ZNzMCEtrLrIUrnEjqDH2iIMtmzYgnpLAH83yr5jNx081rlKFrzDa/JqYbX5JCHgJSiRZIEVZ1c4Pdtv5V1TAyVUYREw==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(376014)(23010399003)(1800799024)(7416014)(82310400026)(56012099006)(11063799006)(10067099003)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	5tcXMWB5evienxZfpzwAByGBioR8es5/7wO0wmxHEZYpc1y8WIfYCUdGwMgRSBjVZcTFitFqqTwbEPRCSodmQoSpQCYOxfeAvCk09uUGGvhUSmcP7xFhJ/3unW7zKuPxrMnTCgm6FonZxyqnfMnGxSzEdn/jBhBWbQkR7G3vnV1VaZOypyylSgCLuo/x+8RPJnC5TEYPn9yhLDk1UMPwI1oi5ZelDggnbG8m9Hx5LO35uJBBjc/XhEarvSZ62xhTowCOeBzZWc73jf4cRU7pm9100hEj+0KxoAnVHtvJQJ0OqRLyqaOLV2q7zrOAa9GgmwBeZJGdjsR2yCUctu1hL03XlNx9zrYl63f4jRZz6wTkYMhXBGIkbenlBjl3F5G/Iq7758uVwEGAuLvtWqrbX/+e2yJZW3m6IHl0y7DNzZugT36WwH1bLiP1WMKjd6M2
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 03:34:27.6257
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b2db353-7b1c-431a-2440-08df0eec6ad3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF9E4583E15

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

Assisted-by: Codex:gpt-5.6-sol
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 55 +++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 5732f3ba0122d..972815c54b11f 100644
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
@@ -5507,6 +5509,53 @@ static struct arm_smmu_device *arm_smmu_impl_probe(struct arm_smmu_device *smmu)
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
@@ -5542,6 +5591,12 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
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

