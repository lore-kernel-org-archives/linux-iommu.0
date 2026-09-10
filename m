Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012056.outbound.protection.outlook.com [52.101.53.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A938379C39;
	Thu, 10 Sep 2026 03:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789011265; cv=fail; b=Gcvkc2zfjc/OMhMOnLc8+Y6TeoJvXY/7mCtgmHPJQpR2dpnmds+HlpCeCdsmrMd6iLdZ/0RjKGT/3lCBhj4T8Rc8gov6CNQbNI5L+nY1WeY8jJABbHVodby1hblZUKu7gYW4ffFxu9CNx4fkPsfVuAOezSUJ4wpFO7TrMoHIOSo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789011265; c=relaxed/simple;
	bh=Cbf0G2CKzPWjXKsyASrMZy+ImW79Fe+8bMQT2dGZDKE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ajmH7FJn5AfU+/dgT9EMq9zyVKMebwJ2qFk9GJPRZYH3YQIe6d1keNu65rNanQqnJ7XZfO+2g0xqAor/cUv5EJP7YBjPjSVAD/p760XyPV5J/Dtu1GPOU1H8fnml7ax8A4QhvIJrYTEGkUsoJ6AH+hP+n3/7/hNIcVwjKlKfJ8M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=W6S6ZZhv; arc=fail smtp.client-ip=52.101.53.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="W6S6ZZhv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rdHiSE1S1NxhdV+NevHfrhYefOHHer1M09F4VJWhkgTPnyYlF+CGQlcpqFSUEY2s8USu6v2WjC/opZo7aZyMsuiRe6QC1V75t2Z11QvzIu17ZFBUEbi6mDO5PeSebH8Mv489eoEP1NRinkCTE7HzY6cHEai7n1sEtD/dCRfktaHVPv0oegot+Cov+vKIGsjP4V0KyYIFOx9C5kayMhMAwEh800u1z9615cZRbQ9H3csWaOQTF5jsTiUnThKU8hcHs8UfPcTbNjfvkrXC8ihfy+8pv4/Y0ARj54DyX2wuq4Dkcl37YLZ348nLnbZ60AQrp0adJ6dPXyEFqf9hoc/Yow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t+SKy7WQuPqhO0auNrXCQs91OozJyuHZDXrsfTl0CPI=;
 b=Ytwn42lY8PpjyRuhimcRYyh94815eyQZ362GC03fceSriVTOWr7PLsnljrnl7SjlQH5SUkGBgaOjdjtlsWfdG5OHR9lE2y3aKQIA/vt67/ZZ+zYfqQnVSmGqmuRbJ16Tatg4mA2krfVykbde37opnDQ1mZ0AepadnV55CYqYL5QKj0dPOHyPNbifkXeyZb8depMKoiXg9+kRzU/DXINhfJme1sg5s44jFVyBdKjH6KJ7mCimRI+sFA3j3gCcfD0E8QmrN/gjpLUCYR/r23Sihx8RHLylonV4X4WStfVqZb8ht+HJeqZjZpG7jqlyG9ZiFzX3kpeflpodaaSHexJzLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t+SKy7WQuPqhO0auNrXCQs91OozJyuHZDXrsfTl0CPI=;
 b=W6S6ZZhv1qaXAXOi5bq0MdJrV0WAT85BIU1SttmG1hd8memYyx31yiPmzZtz3FcTIA8O5gIFs8ePkO1xyBgn0L1D/0E7ETu71CcaCRjQ5yKV1Mw/KriTMAvrsjGBllhdCpCvQZz5lfHopr9LVAbpF34REDnqVE/y7mD2yqU7oD0O5mqwJ4D6nsGBRbfN8xQgbLok+6PUajHlOdPaZ+hSkGST0I57ufsIunYdM2WFwhMEAMpyUiRpThjDGxS8ML99hiAK84mJgvkLLDKklxbghP2CnrtVI/fh1WQVtAoCUuAp4rk2xy7jomjTDSHJVUp5Iw5QmI5Xqem5J2LxDeHsFQ==
Received: from DS2PEPF00004567.namprd21.prod.outlook.com
 (2603:10b6:f:fc00::509) by BL1PR12MB5827.namprd12.prod.outlook.com
 (2603:10b6:208:396::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Thu, 10 Sep
 2026 03:34:11 +0000
Received: from CY4PEPF0000FCC5.namprd03.prod.outlook.com
 (2603:10b6:92f::1006:0:b) by DS2PEPF00004567.outlook.office365.com
 (2603:10b6:f:fc00::509) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.9 via Frontend Transport; Thu, 10
 Sep 2026 03:34:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CY4PEPF0000FCC5.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Thu, 10 Sep 2026 03:34:11 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 9 Sep
 2026 20:34:01 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 9 Sep 2026 20:34:01 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Wed, 9 Sep 2026 20:33:59 -0700
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
Subject: [PATCH v1 2/8] firmware: arm_rmm: Add VSMMU commands and fields
Date: Wed, 9 Sep 2026 20:32:45 -0700
Message-ID: <0623345baaf550da1339e040b59f1fda902e3390.1789010941.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC5:EE_|BL1PR12MB5827:EE_
X-MS-Office365-Filtering-Correlation-Id: ea30de88-fdb2-4e17-b343-08df0eec612f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|36860700016|82310400026|23010399003|6133799003|3023799007|10067099003|5023799004|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	43iqHOiBy55PMinPvDiJxNMBZ/m+CyahmNtwsmJWCOow3MfzkdDVhioJq89/zgID47SWvJpe+n2+BDzm7PyWQphZZbSlhiRGRiw7dCNuwfX7fuBtw5sa70WhbALNhSglGXgJKCaAc/4IfhhPPWCFrByNMnIsBj5S0vz0WoEWoGY4PIRBCZbT8ZWpX3mtTMdMLQY20zdMKeaIwN+rAHV7Y1WF4tZaVg2hlx8sIhn6MQO4L1uRSmCry1AH91yxIl65PJlIuFtjCn3ABghJNq95HbFrK1ZzWKNKg7EwNs/uwGdtIY6s0uWI8i/fssetNNCXs43+8jFKZGU8VOQwLt99g3H336Zz/1cR2Y7XfQ5rMODp45cBXaN19riF24hCN1yswdPBrYLevSLmVdckczyh0c6CUPGSgn3xHoqtSholVrPWUq0S0ZIAYYAi+KGv4r23kOtUXgso6fW1zLgasOkj+VjweytUERS7/nqqy/pwmyNkkQCAKKSodGjxcZW1JT17Lm8YPYqg9RYPJWr8oUvbc71rgfrwwknRue+o/G9f1ezFN+Y2NC1x5BOc4DrDKW7F3Pinm8e6dpiIS1rBfVvZSZOOLCJhKZQSrAsvLpRcEs/ZA7iO3iwP92htNp1kjOsvybVuuXvvSShUT1WRnDUjNupK0sEXFq9D59Qfjll+V7uVX4b325Bpg1bU9ZVfmCPTQpW+Dar4KHRERcjERDKD+w==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(36860700016)(82310400026)(23010399003)(6133799003)(3023799007)(10067099003)(5023799004)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	MIsdXZm7Ath9JsQ+XO1SJdp4BdnLLda2AyXgD0tV+HFoAq73bLafIGFe3+K8FU4uR5Xl85OqNKNduPXfQkY0/wlPNUb3RwebbticTEHn4BCZhBD98O0n7BCbWamtRe/AeV9lobYbXgsyhahtJmZ9aeW0rUrpEdBlZiC34kalZaueXwV9fPS6pFfLCwcoKNXc4pGnRkguWYqgQWY3GiJJVFkoZ4D6CrpP7SG8rUluKltnSxd3HABObuEnAgjUGXMReHH+t2niT3RgLpHLoX7AWWGfym5+ukFg2zjJmnIksVTJgYaDL0mFYWQVU0lPEHU5G+2bPisat0eyyxuHhMheleb44/dXTR9hlDqZvvT/orn8S0hGgRdr5i+1ePoAVt4iPz13HsTkbODT+v1m5DGCjjMECx7wMMkAar8wqIXz+8pgxZGkglIV2ousrwwwO/qY
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 03:34:11.4558
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea30de88-fdb2-4e17-b343-08df0eec612f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5827

DEN0137 2.0-bet3 adds the RSI_VSMMU_GET_INFO command and replaces the old
RSI_VSMMU_ACTIVATE command with RSI_ARCH_DEV_ACTIVATE.

Add the command IDs, return codes, SMMUv3 device type, and helpers for both
commands.

Assisted-by: Codex:gpt-5.6-sol
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 include/linux/arm-rsi-cmds.h  | 22 ++++++++++++++++++++++
 include/linux/arm-smccc-rsi.h | 20 ++++++++++++++++++++
 2 files changed, 42 insertions(+)

diff --git a/include/linux/arm-rsi-cmds.h b/include/linux/arm-rsi-cmds.h
index 13478e14c4296..548ab0bcac722 100644
--- a/include/linux/arm-rsi-cmds.h
+++ b/include/linux/arm-rsi-cmds.h
@@ -237,4 +237,26 @@ static inline unsigned long rsi_attestation_token_continue(phys_addr_t granule,
 	return res.a0;
 }
 
+static inline unsigned long rsi_vsmmu_get_info(phys_addr_t addr,
+					       phys_addr_t *top)
+{
+	struct arm_smccc_res res;
+
+	arm_smccc_1_1_invoke(SMC_RSI_VSMMU_GET_INFO, addr, &res);
+	if (res.a0 == RSI_SUCCESS && top)
+		*top = res.a1;
+
+	return res.a0;
+}
+
+static inline unsigned long rsi_arch_dev_activate(phys_addr_t base,
+						  unsigned long dev_type)
+{
+	struct arm_smccc_res res;
+
+	arm_smccc_1_1_invoke(SMC_RSI_ARCH_DEV_ACTIVATE, base, dev_type, &res);
+
+	return res.a0;
+}
+
 #endif /* __LINUX_ARM_RSI_CMDS_H_ */
diff --git a/include/linux/arm-smccc-rsi.h b/include/linux/arm-smccc-rsi.h
index fddb77986f706..2c16c23611891 100644
--- a/include/linux/arm-smccc-rsi.h
+++ b/include/linux/arm-smccc-rsi.h
@@ -37,6 +37,7 @@
 #define RSI_ERROR_STATE		UL(2)
 #define RSI_INCOMPLETE		UL(3)
 #define RSI_ERROR_UNKNOWN	UL(4)
+#define RSI_ERROR_DEVICE	UL(5)
 
 #define SMC_RSI_FID(n)		ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL,      \
 						   ARM_SMCCC_SMC_64,         \
@@ -190,4 +191,23 @@ struct realm_config {
  */
 #define SMC_RSI_HOST_CALL			SMC_RSI_FID(0x199)
 
+/*
+ * Get information about a VSMMU.
+ *
+ * arg1 == Base IPA of the VSMMU
+ * ret0 == Status / error
+ * ret1 == Top IPA of the VSMMU
+ */
+#define SMC_RSI_VSMMU_GET_INFO			SMC_RSI_FID(0x19A)
+
+#define RSI_ARCH_DEV_SMMUV3			UL(0)
+
+/*
+ * Activate an architectural device.
+ *
+ * arg1 == Base IPA of the architectural device
+ * arg2 == Architectural device type
+ * ret0 == Status / error
+ */
+#define SMC_RSI_ARCH_DEV_ACTIVATE		SMC_RSI_FID(0x19B)
 #endif /* __LINUX_ARM_SMCCC_RSI_H_ */
-- 
2.43.0

