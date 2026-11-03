Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793677827;
	b=WFRB0mtOcpne4/BHD5r0f6X9DikVT9MDf0jdVM6VjIBQqrTDb5II1CSEu7kClLRHXPRP
	 hRPQZ+pVsmcSLeECffKt9u0ltAwgDvO5DKVKTEImJ5ZhExBFNOAKUhwhYWbkJ4E513oP4
	 6ZTUIBKHqf1XDpmWkMLDFNmkjRXBIUldQTYgf/iCRAlcTtF1Pv74D5ZDh2AFhNePKjFAN
	 eMnQJQPe2hlBNqjpa2W7yKhPnZuMGT+2P3TfstL20viL5OKZ8WR1LMwdlQUL8lANVoXpw
	 mXbh4ep0/gyxywQEfi+gP8ZSvc6ZKt0zWFnswJyCnDpI+g3oJ+2dgAjK0Mb3l5ZbU5g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793677827;
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
	b=w/JvmCut+UEurscBunh/spbrmA0KrCWawRCgFslyc6/PybRIuqm0DfIInMzQCOh2PD/s
	 EAH4dXkyPR7Ct7k1+50neuNJ6JsMr0IwpM5o302X7IMC74TVKGKxLvsW3DYpwSAGqcrRc
	 G2oIhRYxYAijRGTAlqgXsg+zOC7AUaQJC+80SGvOExzIdDMvrTs9bcFCQDryLZRqqz417
	 +Lmf3kwWVT6DYUoPn/X/At/lKUrQSuJyIBxbPAGoS7PBiM7X2n3mV6chniwBDXCZA+VFe
	 kMWp/C6p+rA50w3yss10XElAmbhZpqohjMCN7wmnydDRxegvJ1UgkoiU315pbWBgmlQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=nYfialMo;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.48
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012048.outbound.protection.outlook.com [52.101.53.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E1B606D80F;
	Tue,  3 Nov 2026 03:50:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A8E1B606D80F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=nYfialMo
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cRlNskdNmYFBmP12g9kNCgMMa3xnAsuKheABarWF2MdYhUcp5clIIy17I0VQN8mfNk9QnhTEQb2ECRVVEFHp13xHXJtwe+GlE3pawL615try0S05jr6+i5tx+17DUSAmA6b4kgXSDdvtl+cMnkNjMX/q8sh6lINVPV4eMQv25O5bnZ8rvUdAvT5F1OW6xKGXQclvmDngEJqTIixwAfmbOtT89s846CK8ydq7245zIiMW95116VuPeuH1W27emWq4C96U07Mf+AE1iyvXMaBmS5YNdIUDunw6K8XlQSvu9zdy2S4d0b7CN9kN0IXmSvwfSjXe2MuLOlBGBH9Ii98S4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hWV2eKJixaFamalh3hmqVnbDDqzdegUq0wWEBO4ESOQ=;
 b=FOLIg4BdVGjjqmvSqCHx6mFTMu8eKi2cJm7ytLIK2J+LSMbvGoZdRkO34RuqZDajiogK0vwKF7cW4Q2leMQyWMpeKVXI7CG8+AsYUrtT8YPWLJh1fgLBiMnYMWeNK4dPdlp5PFYy06agrmRpy3cumJmxlO1UYOC50oBMYfVaG8TBm+QLFZDLislJaZ+3wQ8Q7HgFGk5lyEjbHg7q+9xUqFcljlSQPL/xUebTykPBYgEeMgdAoWffDok4etDh+NRiR7a2jPuMJDdto+ERu/IKdONoS7k8we8xZh4uCybpRbbc5l5xmPnwhFCj4A/WyBDzC8FU3LJ81YL+73BbV8AvgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hWV2eKJixaFamalh3hmqVnbDDqzdegUq0wWEBO4ESOQ=;
 b=nYfialMoyLtiY3zif6gf4CH617SPlq75V2gD6c1sRe1663WMJPgJ0h6tC6RN/H5mPX9pLVLDiUbpupyXKLYJXaKl7fJQ83F/KWi8/+YTg+vnoFRb3OsZs+tkPSjCJdQ0btAx7olFdLhQsLiIxkSSe8TncZ7P/oVszo8/kSM9FrRhPwko4Qsq/ueuAJr4z3Y+tb6SzI2G72TAKYuXSj/Hj2gOaWC3zinFdK/zckOJRodasVRTJTnL+34Zu9QBY+isk3EGywCyfxUS4bodqAvTsns1Ef+dYpIC71wXm25p8NOOJBw+n3nvdnFaHXMlJkDUhvQ6maJnTpmMhOBuC7LG5Q==
Received: from MW4PR03CA0116.namprd03.prod.outlook.com (2603:10b6:303:b7::31)
 by LV8PR12MB9084.namprd12.prod.outlook.com (2603:10b6:408:18e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 03:50:20 +0000
Received: from MWH0EPF000D8952.namprd05.prod.outlook.com
 (2603:10b6:303:b7:cafe::5e) by MW4PR03CA0116.outlook.office365.com
 (2603:10b6:303:b7::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.12 via Frontend Transport; Tue, 3
 Nov 2026 03:50:19 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000D8952.mail.protection.outlook.com (10.167.249.218) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Tue, 3 Nov 2026 03:50:19 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 2 Nov
 2026 19:50:08 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 2 Nov
 2026 19:50:07 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.2562.56 via Frontend
 Transport; Mon, 2 Nov 2026 19:50:06 -0800
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
Subject: [PATCH v2 7/7] iommu/arm-smmu-v3: Probe a guest-level Realm VSMMU via RSI commands
Date: Mon, 2 Nov 2026 19:49:50 -0800
Message-ID: <85eab0519df845932a5037127f7acd8294508312.1793676742.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1793676742.git.nicolinc@nvidia.com>
References: <cover.1793676742.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000D8952:EE_|LV8PR12MB9084:EE_
X-MS-Office365-Filtering-Correlation-Id: cc4c64f7-401a-4b96-257b-08df395d9467
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|82310400026|1800799024|376014|23010399003|36860700016|6133799003|22082099003|18002099003|56012099006|261102123227099003|10067099003|261009223027099003|261022105027099003|261021121427099003|261021123027099003|261021135927099003|261022075727099003|11063799006|261028144727099003|261026140227099003|261026121527099003;
X-Microsoft-Antispam-Message-Info:
	G+rqWQnWwq0Wpm1ykjCtM3/7xwh4YN0aanpJdOFyzXEw7uVMAlGqCyRyOmWzNa7SgWUnftBDsCW6roVVJ7/edoYbEWzeIr9AkVaABmo8ugJmcDTo4DYSGY6K9xRXmtqH2TMkAlWJgjby0gyiQGGZaywgwCbuVLnUKZO6paoEFXucQGZAAojqJ9h1uayxByn1TSKFQCNedjZClpB/9Iaq4k0OiSK1WBP+77J5EB1lsOf2yrl9YSUZaoFsqaGoNuOl7ao4uVyGXnqcDNrpA9buaRmTWz2S5CA+0k6IbYzjlRgCqDL4CnQBldI+mfoM90h3P4A82kDwY5UzPeB1dPS0kDDHhbRnd7wFbA2Aehlgr3sFTq5sQg+rU3ujG5NCovdlKfS1lBkPnYP6otplQ0fCZ/rKgFzDFUtu+hf4iKhXhkxyci8Jz9qfozmwNkHS19txrK7A0yfu4saofzvtllh4oTwL3+r8XJz8Xm16ysuJoDaaJuhNCaHldag3kG963HL+KgzLcZdZ9H72ZHCR7lgbMKRzUAjkYBjafNMCJsDZMlUe5d2Gad4QoZReAkPzDCp4PBYXFOPyIjHER1yvw8sQwYewgOdlMRN5yxwoN4znNHU6UyKyE0M0EbhBcmRFMmKtXHF/KT8rTJraMAjKMbsT2dOH/xtKNOuA26vLthmZn/r07rll5k0sPL6tVun9zBpjw6XMyIR7LFT472uD06i+Nw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(82310400026)(1800799024)(376014)(23010399003)(36860700016)(6133799003)(22082099003)(18002099003)(56012099006)(261102123227099003)(10067099003)(261009223027099003)(261022105027099003)(261021121427099003)(261021123027099003)(261021135927099003)(261022075727099003)(11063799006)(261028144727099003)(261026140227099003)(261026121527099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	KaZDEHat58fCMC62JzKR7ZJwQY0yvFYNOBsWlDsgUs5r8J24KntvB3OK47t/C/JI3T6nGXwZoe5s6P28iaX+Cdw4kJrtNK735uSDPEkVxJGeGIsOH1zr3uK1gNnoEyV4y7fb0DAzeslNHyvxhg6PsI9K5DKmJsdy0xaAv4pSkcLi71TtZIvZ5Ysu7ZF05nDVyrF7qFSjHRK2uJrtWbEMV7d1aDb76KianhEJwZbKASKROhJ+6iPp5D6u95uOSguQvIdocL3tasR3L62qHE2UGTeBwYxPxOHtqPCU9Qv9NR29LSTkvYU9TTzCb9fUwLwzGIFRZ3LJvvkowzluxth73iBVH6AShIxOa82sBiZYvDyGx50bc/fwRVq2Ax3b9M9Fk6jkgbeNBU/1qxsin670i9ui6D8dWV/OK+d9aGFxDbMN4BoXtf+imE9k2wt3TrNG
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 03:50:19.2818
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc4c64f7-401a-4b96-257b-08df395d9467
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000D8952.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9084

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

