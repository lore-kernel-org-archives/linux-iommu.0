Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C42D8CA5A
	for <iommu@lists.linux.dev>; Thu,  5 Dec 2024 13:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733406500; cv=none; b=Z7Z81sknmL7lMuJQKS6am5Tcif95LHY3jePe/pLZjJ3htZb8yv1IYBjN9R3KZYJkfgOYlE7pZMHmLSnXYPIybo1JWC/Qom3E/EVqA49fafi9Pq4q4pFUT+qk4N/+EESXvx18sebtg9RloTPy+6fOA8s+Dl3aulu0sLBzhyNH3NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733406500; c=relaxed/simple;
	bh=qbp+8YdUg4k66V8CSlXocOjNzdNFHhifBEQ+PCbu/+o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cakAEIGQag2+AGvDfg6XVOVNl6VWFIpxpIxsCDk7rkzTJ+YK9EmxO03PFbPKbHeILcCRM0gXVQuowtDeY+z1ckk5rwi6YY1SW+k/rHnoCAbmxr2RUaV2WUels5CIAJ9MgDA6DuITgQreyE38tfa9gszZC+FqOAAGyOTL7jBB71g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 82FE9169E;
	Thu,  5 Dec 2024 05:48:45 -0800 (PST)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 44CF03F71E;
	Thu,  5 Dec 2024 05:48:16 -0800 (PST)
From: Robin Murphy <robin.murphy@arm.com>
To: will@kernel.org,
	catalin.marinas@arm.com
Cc: joro@8bytes.org,
	jean-philippe@linaro.org,
	iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	mark.rutland@arm.com,
	joey.gouly@arm.com,
	ryan.roberts@arm.com,
	broonie@kernel.org
Subject: [PATCH 2/2] arm64: cpufeature: Add GCS to cpucap_is_possible()
Date: Thu,  5 Dec 2024 13:48:10 +0000
Message-Id: <416c7369fcdce4ebb2a8f12daae234507be27e38.1733406275.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.39.2.101.g768bb238c484.dirty
In-Reply-To: <68a37b00a720f0827cac0e4f40e4d3a688924054.1733406275.git.robin.murphy@arm.com>
References: <68a37b00a720f0827cac0e4f40e4d3a688924054.1733406275.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since system_supports_gcs() ends up referring to cpucap_is_possible(),
teach the latter about GCS for consistency with similar features.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 arch/arm64/include/asm/cpucaps.h    | 2 ++
 arch/arm64/include/asm/cpufeature.h | 3 +--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/cpucaps.h b/arch/arm64/include/asm/cpucaps.h
index 201a46efd918..cbbf70e0f204 100644
--- a/arch/arm64/include/asm/cpucaps.h
+++ b/arch/arm64/include/asm/cpucaps.h
@@ -44,6 +44,8 @@ cpucap_is_possible(const unsigned int cap)
 		return IS_ENABLED(CONFIG_ARM64_TLB_RANGE);
 	case ARM64_HAS_S1POE:
 		return IS_ENABLED(CONFIG_ARM64_POE);
+	case ARM64_HAS_GCS:
+		return IS_ENABLED(CONFIG_ARM64_GCS);
 	case ARM64_UNMAP_KERNEL_AT_EL0:
 		return IS_ENABLED(CONFIG_UNMAP_KERNEL_AT_EL0);
 	case ARM64_WORKAROUND_843419:
diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index b64e49bd9d10..8b4e5a3cd24c 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -847,8 +847,7 @@ static inline bool system_supports_poe(void)
 
 static inline bool system_supports_gcs(void)
 {
-	return IS_ENABLED(CONFIG_ARM64_GCS) &&
-		alternative_has_cap_unlikely(ARM64_HAS_GCS);
+	return alternative_has_cap_unlikely(ARM64_HAS_GCS);
 }
 
 static inline bool system_supports_haft(void)
-- 
2.39.2.101.g768bb238c484.dirty

