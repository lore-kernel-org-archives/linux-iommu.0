Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E89D361DB3
	for <iommu@lists.linux.dev>; Thu, 26 Feb 2026 18:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772129440; cv=none; b=nJUxIEbK5P60N6T5y99zJA2snF/gKNoKVYcWC2PSJ9yfpEBuMTCRQyRMs+h9zl+NGiDDfY9nvAQPfGKD1d+BzDQwEP3nMZddvLLfXzTNdKOYJnwMvbNJPmrZhJVwSc/pZNAY8JxsQ/+cNnIcocez6U2FHC4Zth8uWkLTn4o8jXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772129440; c=relaxed/simple;
	bh=hh1taYJORBjyLYf+JIpZJS6foaVYn/nn/MJ8OsOj4XY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=s4Gqzut+/K83C0OCRYOP6QF/bZa+PwL1gFFysN6mL/Gi2U90LATHc373TgUGeXRznVnQXrR3vm7Q0Qo3eXvCl4NRSmna6SxdmzyXACq3jzwj8OtusyENZ6dNvHZJqp1aX2ls3TaUtzkXHW50Cql3LutqhJr778kYqI7moNITu4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5A6D21764;
	Thu, 26 Feb 2026 10:10:26 -0800 (PST)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.85])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 81F4D3F73B;
	Thu, 26 Feb 2026 10:10:31 -0800 (PST)
From: Robin Murphy <robin.murphy@arm.com>
To: will@kernel.org,
	catalin.marinas@arm.com,
	joro@8bytes.org
Cc: iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	daizhiyuan@phytium.com.cn
Subject: [PATCH 3/3] arm64: errata: Sort Arm entries
Date: Thu, 26 Feb 2026 18:10:22 +0000
Message-Id: <e2af5db2f1f41d052cce68bf4518f3cc1c4ea81e.1772125743.git.robin.murphy@arm.com>
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

The Arm errata entries are in a messy sort-of-consistent-but-not order
that's awkward for actual reading, rather than specifically searching.
For the sake of sanity, order them consistently by Component (but
keeping the distinction of CPU vs. system IP) and Erratum ID.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 Documentation/arch/arm64/silicon-errata.rst | 64 ++++++++++-----------
 1 file changed, 32 insertions(+), 32 deletions(-)

diff --git a/Documentation/arch/arm64/silicon-errata.rst b/Documentation/arch/arm64/silicon-errata.rst
index 745ff25f5854..2b8e5c702cf4 100644
--- a/Documentation/arch/arm64/silicon-errata.rst
+++ b/Documentation/arch/arm64/silicon-errata.rst
@@ -60,38 +60,18 @@ stable kernels.
 | Ampere         | AmpereOne AC04  | AC04_CPU_23     | AMPERE_ERRATUM_AC04_CPU_23  |
 +----------------+-----------------+-----------------+-----------------------------+
 +----------------+-----------------+-----------------+-----------------------------+
-| ARM            | Cortex-A510     | #2457168        | ARM64_ERRATUM_2457168       |
+| ARM            | Cortex-A53      | #819472         | ARM64_ERRATUM_819472        |
 +----------------+-----------------+-----------------+-----------------------------+
-| ARM            | Cortex-A510     | #2064142        | ARM64_ERRATUM_2064142       |
-+----------------+-----------------+-----------------+-----------------------------+
-| ARM            | Cortex-A510     | #2038923        | ARM64_ERRATUM_2038923       |
-+----------------+-----------------+-----------------+-----------------------------+
-| ARM            | Cortex-A510     | #1902691        | ARM64_ERRATUM_1902691       |
-+----------------+-----------------+-----------------+-----------------------------+
-| ARM            | Cortex-A510     | #2051678        | ARM64_ERRATUM_2051678       |
-+----------------+-----------------+-----------------+-----------------------------+
-| ARM            | Cortex-A510     | #2077057        | ARM64_ERRATUM_2077057       |
-+----------------+-----------------+-----------------+-----------------------------+
-| ARM            | Cortex-A510     | #2441009        | ARM64_ERRATUM_2441009       |
-+----------------+-----------------+-----------------+-----------------------------+
-| ARM            | Cortex-A510     | #2658417        | ARM64_ERRATUM_2658417       |
-+----------------+-----------------+-----------------+-----------------------------+
-| ARM            | Cortex-A510     | #3117295        | ARM64_ERRATUM_3117295       |
-+----------------+-----------------+-----------------+-----------------------------+
-| ARM            | Cortex-A520     | #2966298        | ARM64_ERRATUM_2966298       |
+| ARM            | Cortex-A53      | #824069         | ARM64_ERRATUM_824069        |
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-A53      | #826319         | ARM64_ERRATUM_826319        |
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-A53      | #827319         | ARM64_ERRATUM_827319        |
 +----------------+-----------------+-----------------+-----------------------------+
-| ARM            | Cortex-A53      | #824069         | ARM64_ERRATUM_824069        |
-+----------------+-----------------+-----------------+-----------------------------+
-| ARM            | Cortex-A53      | #819472         | ARM64_ERRATUM_819472        |
+| ARM            | Cortex-A53      | #843419         | ARM64_ERRATUM_843419        |
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-A53      | #845719         | ARM64_ERRATUM_845719        |
 +----------------+-----------------+-----------------+-----------------------------+
-| ARM            | Cortex-A53      | #843419         | ARM64_ERRATUM_843419        |
-+----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-A55      | #1024718        | ARM64_ERRATUM_1024718       |
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-A55      | #1530923        | ARM64_ERRATUM_1530923       |
@@ -100,10 +80,10 @@ stable kernels.
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-A57      | #832075         | ARM64_ERRATUM_832075        |
 +----------------+-----------------+-----------------+-----------------------------+
-| ARM            | Cortex-A57      | #852523         | N/A                         |
-+----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-A57      | #834220         | ARM64_ERRATUM_834220        |
 +----------------+-----------------+-----------------+-----------------------------+
+| ARM            | Cortex-A57      | #852523         | N/A                         |
++----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-A57      | #1319537        | ARM64_ERRATUM_1319367       |
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-A57      | #1742098        | ARM64_ERRATUM_1742098       |
@@ -116,11 +96,11 @@ stable kernels.
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-A73      | #858921         | ARM64_ERRATUM_858921        |
 +----------------+-----------------+-----------------+-----------------------------+
+| ARM            | Cortex-A76      | #1165522        | ARM64_ERRATUM_1165522       |
++----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-A76      | #1188873,       | ARM64_ERRATUM_1418040       |
 |                |                 | #1418040        |                             |
 +----------------+-----------------+-----------------+-----------------------------+
-| ARM            | Cortex-A76      | #1165522        | ARM64_ERRATUM_1165522       |
-+----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-A76      | #1286807        | ARM64_ERRATUM_1286807       |
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-A76      | #1463225        | ARM64_ERRATUM_1463225       |
@@ -140,10 +120,30 @@ stable kernels.
 | ARM            | Cortex-A78C     | #3324346,       | ARM64_ERRATUM_3194386       |
 |                |                 | #3324347        |                             |
 +----------------+-----------------+-----------------+-----------------------------+
-| ARM            | Cortex-A710     | #2119858        | ARM64_ERRATUM_2119858       |
+| ARM            | Cortex-A510     | #1902691        | ARM64_ERRATUM_1902691       |
++----------------+-----------------+-----------------+-----------------------------+
+| ARM            | Cortex-A510     | #2038923        | ARM64_ERRATUM_2038923       |
++----------------+-----------------+-----------------+-----------------------------+
+| ARM            | Cortex-A510     | #2051678        | ARM64_ERRATUM_2051678       |
++----------------+-----------------+-----------------+-----------------------------+
+| ARM            | Cortex-A510     | #2064142        | ARM64_ERRATUM_2064142       |
++----------------+-----------------+-----------------+-----------------------------+
+| ARM            | Cortex-A510     | #2077057        | ARM64_ERRATUM_2077057       |
++----------------+-----------------+-----------------+-----------------------------+
+| ARM            | Cortex-A510     | #2441009        | ARM64_ERRATUM_2441009       |
++----------------+-----------------+-----------------+-----------------------------+
+| ARM            | Cortex-A510     | #2457168        | ARM64_ERRATUM_2457168       |
++----------------+-----------------+-----------------+-----------------------------+
+| ARM            | Cortex-A510     | #2658417        | ARM64_ERRATUM_2658417       |
++----------------+-----------------+-----------------+-----------------------------+
+| ARM            | Cortex-A510     | #3117295        | ARM64_ERRATUM_3117295       |
++----------------+-----------------+-----------------+-----------------------------+
+| ARM            | Cortex-A520     | #2966298        | ARM64_ERRATUM_2966298       |
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-A710     | #2054223        | ARM64_ERRATUM_2054223       |
 +----------------+-----------------+-----------------+-----------------------------+
+| ARM            | Cortex-A710     | #2119858        | ARM64_ERRATUM_2119858       |
++----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-A710     | #2224489        | ARM64_ERRATUM_2224489       |
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-A710     | #3324338        | ARM64_ERRATUM_3194386       |
@@ -184,10 +184,10 @@ stable kernels.
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Neoverse-N1     | #3324349        | ARM64_ERRATUM_3194386       |
 +----------------+-----------------+-----------------+-----------------------------+
-| ARM            | Neoverse-N2     | #2139208        | ARM64_ERRATUM_2139208       |
-+----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Neoverse-N2     | #2067961        | ARM64_ERRATUM_2067961       |
 +----------------+-----------------+-----------------+-----------------------------+
+| ARM            | Neoverse-N2     | #2139208        | ARM64_ERRATUM_2139208       |
++----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Neoverse-N2     | #2253138        | ARM64_ERRATUM_2253138       |
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Neoverse-N2     | #3324339        | ARM64_ERRATUM_3194386       |
@@ -204,6 +204,8 @@ stable kernels.
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Neoverse-V3AE   | #3312417        | ARM64_ERRATUM_3194386       |
 +----------------+-----------------+-----------------+-----------------------------+
+| ARM            | GIC-700         | #2941627        | ARM64_ERRATUM_2941627       |
++----------------+-----------------+-----------------+-----------------------------+
 | ARM            | MMU-500         | #562869,        | ARM_SMMU_MMU_500_CPRE_ERRATA|
 |                |                 | #841119,        |                             |
 |                |                 | #826419,        |                             |
@@ -221,8 +223,6 @@ stable kernels.
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | MMU S3          | #3995052        | N/A                         |
 +----------------+-----------------+-----------------+-----------------------------+
-| ARM            | GIC-700         | #2941627        | ARM64_ERRATUM_2941627       |
-+----------------+-----------------+-----------------+-----------------------------+
 | ARM            | SI L1           | #4311569        | ARM64_ERRATUM_4311569       |
 +----------------+-----------------+-----------------+-----------------------------+
 +----------------+-----------------+-----------------+-----------------------------+
-- 
2.39.2.101.g768bb238c484.dirty

