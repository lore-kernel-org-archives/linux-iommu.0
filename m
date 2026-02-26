Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75A00361DB3
	for <iommu@lists.linux.dev>; Thu, 26 Feb 2026 18:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772129438; cv=none; b=UCxoUU6Cx5iVMc5Gzr1KDlqx0sDA+9JMOjyHf39lek6tCxRWrbV2Ym4YxYtRS/IUKbDCWkUhnVbz55p872JJuBcLWA+RCZzv1M7LPqXRmBYOMTx7/4hQkaENJmZm9JDoM1IFgINW6R+yB9uTCQFdSN918Sv7mTlRxaoOw1qZaTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772129438; c=relaxed/simple;
	bh=ilYBTXbmpQSxNEh25Ppsgvs0wOlsj2LVh9LftKeKSSw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tkVRbt7nA17EY4ckXJEXwomtFvLJ4xg/G5FYVrPv/Qjt3AGfhHSjBaTKoHygTpXYDXwt/hy1E7MkHsGxj4FEHHycNI81m+Q+i0w6gTMtFaINZv+7zLoMKdRR+onxFfq6KqtBWoTDJEhfQuVKaJXkos3us4+na3zcpcXyWH0kjqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 66A461688;
	Thu, 26 Feb 2026 10:10:23 -0800 (PST)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.85])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8E2443F73B;
	Thu, 26 Feb 2026 10:10:28 -0800 (PST)
From: Robin Murphy <robin.murphy@arm.com>
To: will@kernel.org,
	catalin.marinas@arm.com,
	joro@8bytes.org
Cc: iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	daizhiyuan@phytium.com.cn
Subject: [PATCH 1/3] arm64: errata: Reformat table for IDs
Date: Thu, 26 Feb 2026 18:10:20 +0000
Message-Id: <3adc16d4d035cf76803e706e325822b99c13e977.1772125743.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.39.2.101.g768bb238c484.dirty
In-Reply-To: <cover.1772125743.git.robin.murphy@arm.com>
References: <cover.1772125743.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We have some inconsistency where multiple errata for the same component
share the same Kconfig workaround; some are one ID per line, some are
smooshed together, and some are entirely separate entries. Standardise
on the single entry, one ID per line format so that things render nice
and consistently in the HTML docs, and it's simple and clear to add new
IDs to existing workarounds without churning the table too much.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 Documentation/arch/arm64/silicon-errata.rst | 44 ++++++++++++---------
 1 file changed, 25 insertions(+), 19 deletions(-)

diff --git a/Documentation/arch/arm64/silicon-errata.rst b/Documentation/arch/arm64/silicon-errata.rst
index 4c300caad901..2e8f57657de7 100644
--- a/Documentation/arch/arm64/silicon-errata.rst
+++ b/Documentation/arch/arm64/silicon-errata.rst
@@ -116,7 +116,8 @@ stable kernels.
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-A73      | #858921         | ARM64_ERRATUM_858921        |
 +----------------+-----------------+-----------------+-----------------------------+
-| ARM            | Cortex-A76      | #1188873,1418040| ARM64_ERRATUM_1418040       |
+| ARM            | Cortex-A76      | #1188873,       | ARM64_ERRATUM_1418040       |
+|                |                 | #1418040        |                             |
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-A76      | #1165522        | ARM64_ERRATUM_1165522       |
 +----------------+-----------------+-----------------+-----------------------------+
@@ -136,7 +137,8 @@ stable kernels.
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-A78      | #3324344        | ARM64_ERRATUM_3194386       |
 +----------------+-----------------+-----------------+-----------------------------+
-| ARM            | Cortex-A78C     | #3324346,3324347| ARM64_ERRATUM_3194386       |
+| ARM            | Cortex-A78C     | #3324346,       | ARM64_ERRATUM_3194386       |
+|                |                 | #3324347        |                             |
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-A710     | #2119858        | ARM64_ERRATUM_2119858       |
 +----------------+-----------------+-----------------+-----------------------------+
@@ -172,11 +174,11 @@ stable kernels.
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-X925     | #3324334        | ARM64_ERRATUM_3194386       |
 +----------------+-----------------+-----------------+-----------------------------+
-| ARM            | Neoverse-N1     | #1188873,1418040| ARM64_ERRATUM_1418040       |
+| ARM            | Neoverse-N1     | #1188873,       | ARM64_ERRATUM_1418040       |
+|                |                 | #1418040        |                             |
 +----------------+-----------------+-----------------+-----------------------------+
-| ARM            | Neoverse-N1     | #1349291        | N/A                         |
-+----------------+-----------------+-----------------+-----------------------------+
-| ARM            | Neoverse-N1     | #1490853        | N/A                         |
+| ARM            | Neoverse-N1     | #1349291,       | N/A                         |
+|                |                 | #1490853        |                             |
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Neoverse-N1     | #1542419        | ARM64_ERRATUM_1542419       |
 +----------------+-----------------+-----------------+-----------------------------+
@@ -202,28 +204,34 @@ stable kernels.
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Neoverse-V3AE   | #3312417        | ARM64_ERRATUM_3194386       |
 +----------------+-----------------+-----------------+-----------------------------+
-| ARM            | MMU-500         | #841119,826419  | ARM_SMMU_MMU_500_CPRE_ERRATA|
-|                |                 | #562869,1047329 |                             |
+| ARM            | MMU-500         | #562869,        | ARM_SMMU_MMU_500_CPRE_ERRATA|
+|                |                 | #841119,        |                             |
+|                |                 | #826419,        |                             |
+|                |                 | #1047329        |                             |
 +----------------+-----------------+-----------------+-----------------------------+
-| ARM            | MMU-600         | #1076982,1209401| N/A                         |
-+----------------+-----------------+-----------------+-----------------------------+
-| ARM            | MMU-700         | #2268618,2812531| N/A                         |
+| ARM            | MMU-600         | #1076982,       | N/A                         |
+|                |                 | #1209401        |                             |
 +----------------+-----------------+-----------------+-----------------------------+
+| ARM            | MMU-700         | #2268618,       | N/A                         |
+|                |                 | #2812531        |                             |
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | GIC-700         | #2941627        | ARM64_ERRATUM_2941627       |
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | SI L1           | #4311569        | ARM64_ERRATUM_4311569       |
 +----------------+-----------------+-----------------+-----------------------------+
++----------------+-----------------+-----------------+-----------------------------+
 | Broadcom       | Brahma-B53      | N/A             | ARM64_ERRATUM_845719        |
 +----------------+-----------------+-----------------+-----------------------------+
 | Broadcom       | Brahma-B53      | N/A             | ARM64_ERRATUM_843419        |
 +----------------+-----------------+-----------------+-----------------------------+
 +----------------+-----------------+-----------------+-----------------------------+
-| Cavium         | ThunderX ITS    | #22375,24313    | CAVIUM_ERRATUM_22375        |
+| Cavium         | ThunderX ITS    | #22375,         | CAVIUM_ERRATUM_22375        |
+|                |                 | #24313          |                             |
 +----------------+-----------------+-----------------+-----------------------------+
 | Cavium         | ThunderX ITS    | #23144          | CAVIUM_ERRATUM_23144        |
 +----------------+-----------------+-----------------+-----------------------------+
-| Cavium         | ThunderX GICv3  | #23154,38545    | CAVIUM_ERRATUM_23154        |
+| Cavium         | ThunderX GICv3  | #23154,         | CAVIUM_ERRATUM_23154        |
+|                |                 | #38545          |                             |
 +----------------+-----------------+-----------------+-----------------------------+
 | Cavium         | ThunderX GICv3  | #38539          | N/A                         |
 +----------------+-----------------+-----------------+-----------------------------+
@@ -233,9 +241,8 @@ stable kernels.
 +----------------+-----------------+-----------------+-----------------------------+
 | Cavium         | ThunderX SMMUv2 | #27704          | N/A                         |
 +----------------+-----------------+-----------------+-----------------------------+
-| Cavium         | ThunderX2 SMMUv3| #74             | N/A                         |
-+----------------+-----------------+-----------------+-----------------------------+
-| Cavium         | ThunderX2 SMMUv3| #126            | N/A                         |
+| Cavium         | ThunderX2 SMMUv3| #74,            | N/A                         |
+|                |                 | #126            |                             |
 +----------------+-----------------+-----------------+-----------------------------+
 | Cavium         | ThunderX2 Core  | #219            | CAVIUM_TX2_ERRATUM_219      |
 +----------------+-----------------+-----------------+-----------------------------+
@@ -253,9 +260,8 @@ stable kernels.
 +----------------+-----------------+-----------------+-----------------------------+
 | Hisilicon      | Hip0{5,6,7}     | #161010101      | HISILICON_ERRATUM_161010101 |
 +----------------+-----------------+-----------------+-----------------------------+
-| Hisilicon      | Hip0{6,7}       | #161010701      | N/A                         |
-+----------------+-----------------+-----------------+-----------------------------+
-| Hisilicon      | Hip0{6,7}       | #161010803      | N/A                         |
+| Hisilicon      | Hip0{6,7}       | #161010701,     | N/A                         |
+|                |                 | #161010803      |                             |
 +----------------+-----------------+-----------------+-----------------------------+
 | Hisilicon      | Hip07           | #161600802      | HISILICON_ERRATUM_161600802 |
 +----------------+-----------------+-----------------+-----------------------------+
-- 
2.39.2.101.g768bb238c484.dirty

