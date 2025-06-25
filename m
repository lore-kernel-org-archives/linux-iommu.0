Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 588CD1EF39E
	for <iommu@lists.linux.dev>; Wed, 25 Jun 2025 11:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750851289; cv=none; b=rHTNPFq53b2h84fkzpsQ3k9ZDDxIxpW8wG+4Yr/ilaAogEqxpbmqc1jk+e9gfVuhHnfuczzFaP4BnvfqbFezYMQnaZWJwTd6gvxDtjkTnofnjxzuDDp/PFIFRiXT9sBucY9bRaSDRukHyCe2ENuvlt7kVXSjtbI0eCXYGnQGT4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750851289; c=relaxed/simple;
	bh=ejRT6DM9BeZPl0mRhesDHbqNFch789VSPDhLQOhW+5I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JZccYnT4P6C9lG6J1ms1gYgBSo+ALakCCmJb+yMeqcq3CGOQ0b2cqD4Tp4dlIjujnueH8uaVECZy6h6cvkcybhcz+d4N549R3z3H/aqvAPtV2bFqgLo7Fwt2vTlA91msgfWcOA8rKNzYenWN0HVnYt+rNE67ti4rqhyUi6TsGVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7239B113E;
	Wed, 25 Jun 2025 04:34:28 -0700 (PDT)
Received: from mazurka.cambridge.arm.com (mazurka.cambridge.arm.com [10.2.80.43])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C784B3F58B;
	Wed, 25 Jun 2025 04:34:42 -0700 (PDT)
From: =?UTF-8?q?Miko=C5=82aj=20Lenczewski?= <miko.lenczewski@arm.com>
To: ryan.roberts@arm.com,
	yang@os.amperecomputing.com,
	catalin.marinas@arm.com,
	will@kernel.org,
	jean-philippe@linaro.org,
	robin.murphy@arm.com,
	joro@8bytes.org,
	maz@kernel.org,
	oliver.upton@linux.dev,
	joey.gouly@arm.com,
	james.morse@arm.com,
	broonie@kernel.org,
	ardb@kernel.org,
	baohua@kernel.org,
	suzuki.poulose@arm.com,
	david@redhat.com,
	jgg@ziepe.ca,
	nicolinc@nvidia.com,
	jsnitsel@redhat.com,
	mshavit@google.com,
	kevin.tian@intel.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev
Cc: =?UTF-8?q?Miko=C5=82aj=20Lenczewski?= <miko.lenczewski@arm.com>
Subject: [PATCH v8 0/4] Initial BBML2 support for contpte_convert()
Date: Wed, 25 Jun 2025 11:34:31 +0000
Message-ID: <20250625113435.26849-1-miko.lenczewski@arm.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi All,

This patch series extends the cpufeature framework to add support for
easily matching against all early cpus, and builds on this to add initial
support for eliding Break-Before-Make requirements on systems that support
BBML2 and additionally guarantee to never raise a conflict abort.

This support conceptually reorders and then elides both a TLB invalidation
and a DSB in contpte_convert(), when BBML2 is supported. This leads to
a 12% improvement when executing a microbenchmark designed to force the
pathological path where contpte_convert() gets called. This represents
an 80% reduction in the cost of calling contpte_convert().

We clarify both the correctness and performance benefits of this elision
with respect to the relevant Arm ARM passages, via substantial comments
in the contpte_convert() source.

This series is based on v6.16-rc3 (86731a2a651e).

Notes
======

Patch 1 extends the cpufeature framework machinery as discussed in [1],
to allows checking for the presence of a feature on all early boot cpus
(and on all late cpus when they are brought online).

Patch 2 implements an allow-list of cpus that support BBML2, but with
the additional constraint of never causing TLB conflict aborts. We
settled on this constraint because we will use the feature for kernel
mappings in the future, for which we cannot handle conflict aborts
safely.

Patch 2 implements a MIDR check but does not implement an
ID_AA64MMFR2_EL1 check, as the BBML2_NOABORT MIDR check is stricter (the
idreg check would allow conflict aborts, the MIDR check does not).

Yang Shi has a series at [2] that aims to use BBML2 to enable splitting
the linear map at runtime. This series partially overlaps with it to add
the cpu feature. We believe this series is fully compatible with Yang's
requirements and could go first.

[1]:
  https://lore.kernel.org/all/aCSHESk1DzShD4vt@arm.com/

[2]:
  https://lore.kernel.org/linux-arm-kernel/20250304222018.615808-1-yang@os.amperecomputing.com/

Changelog
=========

v8:
  - restore missing cpucap description
  - fix misspelled documentation
  - rebase onto v6.16-rc3

v7:
  - https://lore.kernel.org/all/20250617095104.6772-1-miko.lenczewski@arm.com/
  - fix up some minor spelling and formatting nits
  - integrate cpufeature framework patch to each bbml2 detection
  - avoid making feature register check, rely on MIDR check
  - rebase onto v6.16-rc2

v6:
  - https://lore.kernel.org/all/20250428153514.55772-2-miko.lenczewski@arm.com/
  - clarify correctness and performance of elision of __tlb_flush_range()
  - rebase onto v6.15-rc3

v5:
  - https://lore.kernel.org/all/20250325093625.55184-1-miko.lenczewski@arm.com/
  - fixup coding style nits
  - document motivation for kernel commandline parameter

v4:
  - https://lore.kernel.org/all/20250319150533.37440-2-miko.lenczewski@arm.com/
  - rebase onto v6.14-rc5
  - switch from arm64 sw feature override to hw feature override
  - reintroduce has_cpuid_feature() check in addition to MIDR check

v3:
  - https://lore.kernel.org/all/20250313104111.24196-2-miko.lenczewski@arm.com/
  - rebase onto v6.14-rc4
  - add arm64.nobbml2 commandline override
  - squash "delay tlbi" and "elide tlbi" patches

v2:
  - https://lore.kernel.org/all/20250228182403.6269-2-miko.lenczewski@arm.com/
  - fix buggy MIDR check to properly account for all boot+late cpus
  - add smmu bbml2 feature check

v1:
  - https://lore.kernel.org/all/20250219143837.44277-3-miko.lenczewski@arm.com/
  - rebase onto v6.14-rc3
  - remove kvm bugfix patches from series
  - strip out conflict abort handler code
  - switch from blocklist to allowlist of bmml2+noabort implementations
  - remove has_cpuid_feature() in favour of MIDR check

rfc-v1:
  - https://lore.kernel.org/all/20241211154611.40395-1-miko.lenczewski@arm.com/
  - https://lore.kernel.org/all/20241211160218.41404-1-miko.lenczewski@arm.com/

Catalin Marinas (1):
  arm64: cpufeature: Introduce MATCH_ALL_EARLY_CPUS capability type

Mikołaj Lenczewski (3):
  arm64: Add BBM Level 2 cpu feature
  iommu/arm: Add BBM Level 2 smmu feature
  arm64/mm: Elide tlbi in contpte_convert() under BBML2

 arch/arm64/include/asm/cpufeature.h           |  28 ++++
 arch/arm64/kernel/cpufeature.c                |  98 ++++++++++--
 arch/arm64/mm/contpte.c                       | 139 +++++++++++++++++-
 arch/arm64/tools/cpucaps                      |   1 +
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   |   3 +
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |   3 +
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |   2 +
 7 files changed, 262 insertions(+), 12 deletions(-)

-- 
2.49.0

