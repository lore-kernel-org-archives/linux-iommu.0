Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010029.outbound.protection.outlook.com [52.101.46.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F671379C5A;
	Thu, 10 Sep 2026 03:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789011263; cv=fail; b=DhjxqQTYp+QkqX0w3JdndWoF8jF6q5PA4qDLuxI0LgLi1sV1P6F3oLtYeQe4cPwwLMv6mmy7mqETfsQgujw1y1vp2Fzp9n/eGvcfQT/81uZb0T5T1dQtivOym7MNypd3gKgB6e3RGEigLcoauwAzIwZ6rQhRXq45Ao4ALyxr+Bw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789011263; c=relaxed/simple;
	bh=qRZGKKkpkQO5wpSTuJTkY33V4jgkGspvyUpfOO7QugY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qYoqNNq0bVInPZzY9ra12BLBN2asuvSZL1DDATkCdzQ9ztx+DrOUr0pw8j48K5qc6XBHKS0JKGQnXDIVEy+VcZ4Nw3jjOEXnM0CqNGKVG/zUpKhhBa7YZBimpmRdWUa0h9v6DAYxejOYGDpVysKPJdCA7jPBJjwcqMWLAeW3TuM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=k43BJ9TG; arc=fail smtp.client-ip=52.101.46.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="k43BJ9TG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wAfn8euJemwK5JsuPJ6MF3bo9Cy5/gcou9XE1dRF2/G/8R8g6Mk4nEyGWRjvtwD3tB87oGsTn2DR5uttpbI5fYLtx4Vti0JjQ4pLjyeJJBXEPM7prmsrErBB6TDQYT+32v02vl46msZR0hL7Jg4F0cKy+Qf17nD+W1pan+vZLMSW38j/2N8cH3ny9GFcbY9mTy+OpJe/aNwBl4t9hEqfgFN/QJ9AoulmMtHqehV0t6QbmQKLL0xgverwYWatdAsbwspIaXU4JRbLvA7+Xh8HSF2J3dHOmgdiDYiBxrju2z22HVpiCYjC4gYIGun97K/Py0AeVeybsnI16SlOXoNChQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/RT5MEi13NhbvUpXcVj6ZnkJ1EuOtEu5fTTf6U9AFwY=;
 b=HjE4beabFno87b60PZs2f2/qmI69O6i/Fh4lf6D2b3OgS7ERVpgUoc+Z3FTBlPzhLY7Vh91F9WMUTWQyZTuOSR5jGPH5GMaDGetHMzwKwOx64cugPrkFdzZMaCBTMpPHIgNBF0jj77DGmFGBg6Me6bnXaz/JdKLzXWQJn8DCHDoLRmrLlI+zvHBi/OTRDt6aARjJ6aHae7AmXKh1W5ZlCSoiniKX3XUDp/Etx+UaxtHOdMdDTlNhnaW2btw29J+UUBiTG34YOUsaoIV3zfz7s/SdDE4iHq+lzRy7oGUOfOgJedlTBO291fvH4psHyB8nJPEfdpfwGPABZ1E4bz0yvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/RT5MEi13NhbvUpXcVj6ZnkJ1EuOtEu5fTTf6U9AFwY=;
 b=k43BJ9TGviEdVfc0/Er+lkPT/AhcmHh+3qmh+i7ZGaxbB5eMZjBMtFbzNWalRC5orOXrmcxNYSXybQYTCGRUH+A8dOJTZijLyWhRIIFWCMcIkXNGuQbTN9vyrew0cKWkU7Bd+cyHC44VRkmDAkbbPtggIXJxNaR5fw/p2yNYKqn10uAEKOtPLtZgoavrvrAM0WPPqEcEzTcKEGxVy/+awhtoKE5XMoxjI06m/k7YfLrzqSF0mlb+b8lyddpN0as00Scjgq+MEffikKGh6BW0K3yH52w7Gl8I7QXHbzLVwCShSrvB6RHH/P6UMXF3yDjsA1k5zG/euyli0Yo7fGtAeg==
Received: from SJ0PR05CA0183.namprd05.prod.outlook.com (2603:10b6:a03:330::8)
 by SN7PR12MB8025.namprd12.prod.outlook.com (2603:10b6:806:340::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Thu, 10 Sep
 2026 03:34:07 +0000
Received: from SJ1PEPF00002315.namprd03.prod.outlook.com
 (2603:10b6:a03:330:cafe::8) by SJ0PR05CA0183.outlook.office365.com
 (2603:10b6:a03:330::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.7 via Frontend Transport; Thu, 10
 Sep 2026 03:34:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ1PEPF00002315.mail.protection.outlook.com (10.167.242.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Thu, 10 Sep 2026 03:34:07 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 9 Sep
 2026 20:33:59 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 9 Sep 2026 20:33:59 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Wed, 9 Sep 2026 20:33:57 -0700
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
Subject: [PATCH v1 1/8] firmware: arm_rmm: Move RSI support out of arch/arm64
Date: Wed, 9 Sep 2026 20:32:44 -0700
Message-ID: <caa3647d2bf8146678b8a05e3fdd6241b47e1af0.1789010941.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002315:EE_|SN7PR12MB8025:EE_
X-MS-Office365-Filtering-Correlation-Id: ae6d58e8-d2b7-49f4-404d-08df0eec5ebf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|30052699003|7416014|1800799024|376014|82310400026|5023799004|11063799006|56012099006|10067099003|13003099007|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	r/fa+oFUbSNZZs8cyVrrkiL84Je+RJf94CrUveU773Ljs43RzkuNZUTCXKANfi2lzFpKelpN5i7R/16ZagZ5N/Gn5rMEblh7THWGOVtOYNrqj8z9zDYr+iAgF7pab+KpM5UrDK8e67Vor+VkO49wikoRfdWDnEYFg6ck0n+5owrqhYj7G1OyFqFZfe2fejB84RdmUhwedsbLrsyaki6a8IKsnb0khLTWpv/opX3DMv6yljlJwgv1mdl1iIRRC4cEElyF7P24KYnC2NPVOr4DWo3QKVRhTkQ0eV7cPmvGGj4KxQLTf50/6Kgy8PVGf4qZiZiGopOdmAFTkA/92oYFzUgsEiZhZQaisqGOq4+WGWSlsmoOuWH8MRCMGB8Tx1IGQZoPQ8NyKuZvvVXOM+thM+eFxa/6zIX2RlOgmI/gvNeFOVMeDNFwkIad3Y7URiBYfR8eY+n3huCyNuVromIvFeOgFWDxOp0TIGuj5WB6QZR8uNhFVgX3pJQ3+e8MOGaktX8XIgsoCrg+Ny48IitjvfUrDAPCKOfRu76cNfxX+ln54xv8gxAfZnT6HSBDx23Rns6PmvynkYRF2TED568IsJ2XkyYj0z7T/6mg4HYB2RGFaSOUlwjq7G4+KOFcFcLqn03cN5VcC4RSsPKcmcCgOwAS5SzoTqzNiXetya1YwSeec6QN2IUi4ZvgWyRrWnE6Y4kr49RR0aUDLhg5NP5hiw==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(30052699003)(7416014)(1800799024)(376014)(82310400026)(5023799004)(11063799006)(56012099006)(10067099003)(13003099007)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	vCRWX9k8bbnSWTqlZNZIHMyy5v80RqAEb8oYm4+OEq7A/5SlWWgJW6P3VpoVIGjqHsNXXskC97ll+WN1ZJ7njmZUIJ9AC9KVmZhIIANOEHesosmzn1ATo8Kep23VSeW1IdgDwVgqKvuJcxbGAVNxuiqybLx9DByrcYTVDyITKTLg1ZNp9Te61/FAdgD5QwcGzagzV2byZs9EkI799Rwr/5nSpZgiEygZVQCZGwLwRhPQasKbCdb7qCaZatkeh0lgQdsk4nYF/Exv2vGc0NsXt6RqrLsY0j3i5MQccpOGFiv6q8HMFLaPYcmfi6yIs1BW82Su6pbDI8QpVkIPaMr3kLdHRVAc5FHJCxJL0bASLvfeyLzKvGvUKanZgPvvoLosumlfhHiJjpn8eeBqN/3CW5KZaQbvu2TXkMYRY/wMo0d2dpT2XWMB9otUN2kI94C8
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 03:34:07.4253
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae6d58e8-d2b7-49f4-404d-08df0eec5ebf
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002315.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8025

From: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>

The RSI SMCCC function IDs describe a firmware ABI and are not arm64
architecture specific definitions. Follow-up changes need to use them from
non-arch code, including drivers/firmware/smccc and the Arm CCA guest
driver.

Move the complete Realm Service Interface (RSI) implementation from
arch/arm64 to drivers/firmware/arm_rmm. The RSI SMCCC definitions and
command helpers are also moved to include/linux so they can be shared by
architecture code and firmware or driver code. This also keeps the
firmware interface outside architecture code, as requested [1].

[1] https://lore.kernel.org/all/agsNO9cc7H-b0H8L@willie-the-truck

Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 arch/arm64/Kconfig                            |  1 +
 drivers/firmware/Kconfig                      |  1 +
 drivers/firmware/arm_rmm/Kconfig              | 18 +++++
 drivers/virt/coco/arm-cca-guest/Kconfig       |  2 +-
 arch/arm64/kernel/Makefile                    |  2 +-
 drivers/firmware/Makefile                     |  1 +
 drivers/firmware/arm_rmm/Makefile             |  2 +
 arch/arm64/include/asm/io.h                   |  2 +-
 arch/arm64/include/asm/mem_encrypt.h          |  2 +-
 arch/arm64/include/asm/pgtable-prot.h         |  2 +-
 arch/arm64/include/asm/rsi.h                  | 70 -----------------
 .../linux/arm-rsi-cmds.h                      | 77 +++++++++++++++++--
 .../linux/arm-smccc-rsi.h                     |  6 +-
 arch/arm64/kernel/setup.c                     |  2 +-
 arch/arm64/mm/init.c                          |  3 +-
 .../kernel => drivers/firmware/arm_rmm}/rsi.c |  2 +-
 .../virt/coco/arm-cca-guest/arm-cca-guest.c   |  5 +-
 17 files changed, 109 insertions(+), 89 deletions(-)
 create mode 100644 drivers/firmware/arm_rmm/Kconfig
 create mode 100644 drivers/firmware/arm_rmm/Makefile
 delete mode 100644 arch/arm64/include/asm/rsi.h
 rename arch/arm64/include/asm/rsi_cmds.h => include/linux/arm-rsi-cmds.h (69%)
 rename arch/arm64/include/asm/rsi_smc.h => include/linux/arm-smccc-rsi.h (98%)
 rename {arch/arm64/kernel => drivers/firmware/arm_rmm}/rsi.c (99%)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index b5a51b0ef9440..ff9565d3ffa59 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -38,6 +38,7 @@ config ARM64
 	select ARCH_HAS_MEMBARRIER_SYNC_CORE
 	select ARCH_HAS_MEM_ENCRYPT
 	select ARCH_SUPPORTS_MSEAL_SYSTEM_MAPPINGS
+	select ARCH_SUPPORTS_RMM
 	select ARCH_HAS_NMI_SAFE_THIS_CPU_OPS
 	select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
 	select ARCH_HAS_NONLEAF_PMD_YOUNG if ARM64_HAFT
diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
index b7cc11e4fbfa6..62660bf520a8d 100644
--- a/drivers/firmware/Kconfig
+++ b/drivers/firmware/Kconfig
@@ -310,5 +310,6 @@ source "drivers/firmware/samsung/Kconfig"
 source "drivers/firmware/smccc/Kconfig"
 source "drivers/firmware/tegra/Kconfig"
 source "drivers/firmware/xilinx/Kconfig"
+source "drivers/firmware/arm_rmm/Kconfig"
 
 endmenu
diff --git a/drivers/firmware/arm_rmm/Kconfig b/drivers/firmware/arm_rmm/Kconfig
new file mode 100644
index 0000000000000..1322a1447b560
--- /dev/null
+++ b/drivers/firmware/arm_rmm/Kconfig
@@ -0,0 +1,18 @@
+
+config ARCH_SUPPORTS_RMM
+	bool
+
+config ARM_RMM
+	bool "Realm Management Monitor (RMM) Support"
+	depends on ARCH_SUPPORTS_RMM
+	default y
+	help
+	  Support the Realm Management Monitor (RMM) on Arm systems that
+	  implement the Realm Management Extension (RME), as defined by the
+	  Arm Confidential Compute Architecture.
+
+	  The RMM provides the Realm Management Interface (RMI) for use by
+	  the Normal World host and the Realm Service Interface (RSI) for
+	  use by Realm guests. The RSI is used to negotiate the RSI version
+	  and Realm configuration with the RMM and manage the protected
+	  state of memory.
diff --git a/drivers/virt/coco/arm-cca-guest/Kconfig b/drivers/virt/coco/arm-cca-guest/Kconfig
index 3f0f013f03f15..b2c225fd445cf 100644
--- a/drivers/virt/coco/arm-cca-guest/Kconfig
+++ b/drivers/virt/coco/arm-cca-guest/Kconfig
@@ -1,6 +1,6 @@
 config ARM_CCA_GUEST
 	tristate "Arm CCA Guest driver"
-	depends on ARM64
+	depends on ARM_RMM
 	select TSM_REPORTS
 	help
 	  The driver provides userspace interface to request and
diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index d2690c3ec5288..21fc3a3d25c91 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -34,7 +34,7 @@ obj-y			:= debug-monitors.o entry.o irq.o fpsimd.o		\
 			   cpufeature.o alternative.o cacheinfo.o		\
 			   smp.o smp_spin_table.o topology.o smccc-call.o	\
 			   syscall.o proton-pack.o idle.o patching.o pi/	\
-			   rsi.o jump_label.o
+			   jump_label.o
 
 obj-$(CONFIG_COMPAT)			+= sys32.o signal32.o			\
 					   sys_compat.o
diff --git a/drivers/firmware/Makefile b/drivers/firmware/Makefile
index be46f1e1dc77f..196a650ccf025 100644
--- a/drivers/firmware/Makefile
+++ b/drivers/firmware/Makefile
@@ -39,3 +39,4 @@ obj-y				+= samsung/
 obj-y				+= smccc/
 obj-y				+= tegra/
 obj-y				+= xilinx/
+obj-y				+= arm_rmm/
diff --git a/drivers/firmware/arm_rmm/Makefile b/drivers/firmware/arm_rmm/Makefile
new file mode 100644
index 0000000000000..3d8181ae94a7b
--- /dev/null
+++ b/drivers/firmware/arm_rmm/Makefile
@@ -0,0 +1,2 @@
+
+obj-$(CONFIG_ARM_RMM)	= rsi.o
diff --git a/arch/arm64/include/asm/io.h b/arch/arm64/include/asm/io.h
index 49a7002661a92..1620537f0332d 100644
--- a/arch/arm64/include/asm/io.h
+++ b/arch/arm64/include/asm/io.h
@@ -8,6 +8,7 @@
 #ifndef __ASM_IO_H
 #define __ASM_IO_H
 
+#include <linux/arm-rsi-cmds.h>
 #include <linux/types.h>
 #include <linux/pgtable.h>
 
@@ -17,7 +18,6 @@
 #include <asm/early_ioremap.h>
 #include <asm/alternative.h>
 #include <asm/cpufeature.h>
-#include <asm/rsi.h>
 
 /*
  * Generic IO read/write.  These perform native-endian accesses.
diff --git a/arch/arm64/include/asm/mem_encrypt.h b/arch/arm64/include/asm/mem_encrypt.h
index 636f45b4d8afc..f03b9d7b83b43 100644
--- a/arch/arm64/include/asm/mem_encrypt.h
+++ b/arch/arm64/include/asm/mem_encrypt.h
@@ -2,8 +2,8 @@
 #ifndef __ASM_MEM_ENCRYPT_H
 #define __ASM_MEM_ENCRYPT_H
 
+#include <linux/arm-rsi-cmds.h>
 #include <asm/hypervisor.h>
-#include <asm/rsi.h>
 
 struct device;
 
diff --git a/arch/arm64/include/asm/pgtable-prot.h b/arch/arm64/include/asm/pgtable-prot.h
index 09d7c00cf4054..58e71e592175e 100644
--- a/arch/arm64/include/asm/pgtable-prot.h
+++ b/arch/arm64/include/asm/pgtable-prot.h
@@ -66,9 +66,9 @@
 
 #ifndef __ASSEMBLER__
 
+#include <linux/arm-rsi-cmds.h>
 #include <asm/cpufeature.h>
 #include <asm/pgtable-types.h>
-#include <asm/rsi.h>
 
 extern bool arm64_use_ng_mappings;
 extern unsigned long prot_ns_shared;
diff --git a/arch/arm64/include/asm/rsi.h b/arch/arm64/include/asm/rsi.h
deleted file mode 100644
index 88b50d660e85a..0000000000000
--- a/arch/arm64/include/asm/rsi.h
+++ /dev/null
@@ -1,70 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * Copyright (C) 2024 ARM Ltd.
- */
-
-#ifndef __ASM_RSI_H_
-#define __ASM_RSI_H_
-
-#include <linux/errno.h>
-#include <linux/jump_label.h>
-#include <asm/rsi_cmds.h>
-
-#define RSI_PDEV_NAME "arm-cca-dev"
-
-DECLARE_STATIC_KEY_FALSE(rsi_present);
-
-void __init arm64_rsi_init(void);
-
-bool arm64_rsi_is_protected(phys_addr_t base, size_t size);
-
-static inline bool is_realm_world(void)
-{
-	return static_branch_unlikely(&rsi_present);
-}
-
-static inline int rsi_set_memory_range(phys_addr_t start, phys_addr_t end,
-				       enum ripas state, unsigned long flags)
-{
-	unsigned long ret;
-	phys_addr_t top;
-
-	while (start != end) {
-		ret = rsi_set_addr_range_state(start, end, state, flags, &top);
-		if (ret || top < start || top > end)
-			return -EINVAL;
-		start = top;
-	}
-
-	return 0;
-}
-
-/*
- * Convert the specified range to RAM. Do not use this if you rely on the
- * contents of a page that may already be in RAM state.
- */
-static inline int rsi_set_memory_range_protected(phys_addr_t start,
-						 phys_addr_t end)
-{
-	return rsi_set_memory_range(start, end, RSI_RIPAS_RAM,
-				    RSI_CHANGE_DESTROYED);
-}
-
-/*
- * Convert the specified range to RAM. Do not convert any pages that may have
- * been DESTROYED, without our permission.
- */
-static inline int rsi_set_memory_range_protected_safe(phys_addr_t start,
-						      phys_addr_t end)
-{
-	return rsi_set_memory_range(start, end, RSI_RIPAS_RAM,
-				    RSI_NO_CHANGE_DESTROYED);
-}
-
-static inline int rsi_set_memory_range_shared(phys_addr_t start,
-					      phys_addr_t end)
-{
-	return rsi_set_memory_range(start, end, RSI_RIPAS_EMPTY,
-				    RSI_CHANGE_DESTROYED);
-}
-#endif /* __ASM_RSI_H_ */
diff --git a/arch/arm64/include/asm/rsi_cmds.h b/include/linux/arm-rsi-cmds.h
similarity index 69%
rename from arch/arm64/include/asm/rsi_cmds.h
rename to include/linux/arm-rsi-cmds.h
index c1fab41f671ec..13478e14c4296 100644
--- a/arch/arm64/include/asm/rsi_cmds.h
+++ b/include/linux/arm-rsi-cmds.h
@@ -3,14 +3,36 @@
  * Copyright (C) 2023 ARM Ltd.
  */
 
-#ifndef __ASM_RSI_CMDS_H
-#define __ASM_RSI_CMDS_H
+#ifndef __LINUX_ARM_RSI_CMDS_H_
+#define __LINUX_ARM_RSI_CMDS_H_
 
-#include <linux/arm-smccc.h>
+#include <linux/arm-smccc-rsi.h>
+#include <linux/jump_label.h>
 #include <linux/string.h>
 #include <asm/memory.h>
 
-#include <asm/rsi_smc.h>
+#define RSI_PDEV_NAME "arm-cca-dev"
+#ifdef CONFIG_ARM_RMM
+DECLARE_STATIC_KEY_FALSE(rsi_present);
+
+void __init arm64_rsi_init(void);
+
+bool arm64_rsi_is_protected(phys_addr_t base, size_t size);
+
+static inline bool is_realm_world(void)
+{
+	return static_branch_unlikely(&rsi_present);
+}
+#else
+static inline void arm64_rsi_init(void) { }
+
+static inline bool arm64_rsi_is_protected(phys_addr_t base, size_t size)
+{
+	return false;
+}
+
+static inline bool is_realm_world(void) { return false; }
+#endif
 
 #define RSI_GRANULE_SHIFT		12
 #define RSI_GRANULE_SIZE		(_AC(1, UL) << RSI_GRANULE_SHIFT)
@@ -88,6 +110,51 @@ static inline long rsi_set_addr_range_state(phys_addr_t start,
 	return res.a0;
 }
 
+static inline int rsi_set_memory_range(phys_addr_t start, phys_addr_t end,
+				       enum ripas state, unsigned long flags)
+{
+	unsigned long ret;
+	phys_addr_t top;
+
+	while (start != end) {
+		ret = rsi_set_addr_range_state(start, end, state, flags, &top);
+		if (ret || top < start || top > end)
+			return -EINVAL;
+		start = top;
+	}
+
+	return 0;
+}
+
+/*
+ * Convert the specified range to RAM. Do not use this if you rely on the
+ * contents of a page that may already be in RAM state.
+ */
+static inline int rsi_set_memory_range_protected(phys_addr_t start,
+						 phys_addr_t end)
+{
+	return rsi_set_memory_range(start, end, RSI_RIPAS_RAM,
+				    RSI_CHANGE_DESTROYED);
+}
+
+/*
+ * Convert the specified range to RAM. Do not convert any pages that may have
+ * been DESTROYED, without our permission.
+ */
+static inline int rsi_set_memory_range_protected_safe(phys_addr_t start,
+						      phys_addr_t end)
+{
+	return rsi_set_memory_range(start, end, RSI_RIPAS_RAM,
+				    RSI_NO_CHANGE_DESTROYED);
+}
+
+static inline int rsi_set_memory_range_shared(phys_addr_t start,
+					      phys_addr_t end)
+{
+	return rsi_set_memory_range(start, end, RSI_RIPAS_EMPTY,
+				    RSI_CHANGE_DESTROYED);
+}
+
 #define RSI_ATTEST_CHALLENGE_MIN_SIZE	32
 #define RSI_ATTEST_CHALLENGE_MAX_SIZE	64
 
@@ -170,4 +237,4 @@ static inline unsigned long rsi_attestation_token_continue(phys_addr_t granule,
 	return res.a0;
 }
 
-#endif /* __ASM_RSI_CMDS_H */
+#endif /* __LINUX_ARM_RSI_CMDS_H_ */
diff --git a/arch/arm64/include/asm/rsi_smc.h b/include/linux/arm-smccc-rsi.h
similarity index 98%
rename from arch/arm64/include/asm/rsi_smc.h
rename to include/linux/arm-smccc-rsi.h
index e19253f96c940..fddb77986f706 100644
--- a/arch/arm64/include/asm/rsi_smc.h
+++ b/include/linux/arm-smccc-rsi.h
@@ -3,8 +3,8 @@
  * Copyright (C) 2023 ARM Ltd.
  */
 
-#ifndef __ASM_RSI_SMC_H_
-#define __ASM_RSI_SMC_H_
+#ifndef __LINUX_ARM_SMCCC_RSI_H_
+#define __LINUX_ARM_SMCCC_RSI_H_
 
 #include <linux/arm-smccc.h>
 
@@ -190,4 +190,4 @@ struct realm_config {
  */
 #define SMC_RSI_HOST_CALL			SMC_RSI_FID(0x199)
 
-#endif /* __ASM_RSI_SMC_H_ */
+#endif /* __LINUX_ARM_SMCCC_RSI_H_ */
diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index 29c6100f0c50b..a707deba6ae70 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -7,6 +7,7 @@
  */
 
 #include <linux/acpi.h>
+#include <linux/arm-rsi-cmds.h>
 #include <linux/export.h>
 #include <linux/kernel.h>
 #include <linux/stddef.h>
@@ -43,7 +44,6 @@
 #include <asm/cpu_ops.h>
 #include <asm/kasan.h>
 #include <asm/numa.h>
-#include <asm/rsi.h>
 #include <asm/scs.h>
 #include <asm/sections.h>
 #include <asm/setup.h>
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index fbf215ecc7d06..2a8de20d2b447 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -34,6 +34,8 @@
 #include <linux/acpi_iort.h>
 #include <linux/kmemleak.h>
 #include <linux/execmem.h>
+#include <linux/arm-rsi-cmds.h>
+
 
 #include <asm/boot.h>
 #include <asm/fixmap.h>
@@ -43,7 +45,6 @@
 #include <asm/kvm_host.h>
 #include <asm/memory.h>
 #include <asm/numa.h>
-#include <asm/rsi.h>
 #include <asm/sections.h>
 #include <asm/setup.h>
 #include <linux/sizes.h>
diff --git a/arch/arm64/kernel/rsi.c b/drivers/firmware/arm_rmm/rsi.c
similarity index 99%
rename from arch/arm64/kernel/rsi.c
rename to drivers/firmware/arm_rmm/rsi.c
index 25ca75ce1a4df..8e716f1c1e319 100644
--- a/arch/arm64/kernel/rsi.c
+++ b/drivers/firmware/arm_rmm/rsi.c
@@ -8,11 +8,11 @@
 #include <linux/psci.h>
 #include <linux/swiotlb.h>
 #include <linux/platform_device.h>
+#include <linux/arm-rsi-cmds.h>
 
 #include <asm/io.h>
 #include <asm/mem_encrypt.h>
 #include <asm/pgtable.h>
-#include <asm/rsi.h>
 
 static struct realm_config config;
 
diff --git a/drivers/virt/coco/arm-cca-guest/arm-cca-guest.c b/drivers/virt/coco/arm-cca-guest/arm-cca-guest.c
index 0eeddd1ff05b5..b741643d13647 100644
--- a/drivers/virt/coco/arm-cca-guest/arm-cca-guest.c
+++ b/drivers/virt/coco/arm-cca-guest/arm-cca-guest.c
@@ -3,7 +3,8 @@
  * Copyright (C) 2023 ARM Ltd.
  */
 
-#include <linux/arm-smccc.h>
+#include <linux/arm-rsi-cmds.h>
+#include <linux/arm-smccc-rsi.h>
 #include <linux/cc_platform.h>
 #include <linux/kernel.h>
 #include <linux/device-id/platform.h>
@@ -12,8 +13,6 @@
 #include <linux/tsm.h>
 #include <linux/types.h>
 
-#include <asm/rsi.h>
-
 /**
  * struct arm_cca_token_info - a descriptor for the token buffer.
  * @granule:		PA of the granule to which the token will be written
-- 
2.43.0

