Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9C0B15ECDF
	for <iommu@lists.linux.dev>; Fri, 28 Feb 2025 18:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740767110; cv=none; b=a+5e03CtYEH3eV8p7g9KGpZiviFQ0GFkbmOUqjrKgo6RCrBillnPDHsJdsjmFTOzOFse45Tg7NfqK2vP3O7Y6boKa0eNUdNGtD+0ZnlClZOd2qA11I7UxZOpEaQ+ewWGSymeAjJKetuD2IebQqFXKESJTX5AqCAcN5b8KSbqx+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740767110; c=relaxed/simple;
	bh=++IkG/xXIGhDbp8KRvadIkvYiaOMvEk/i8GTf4NrEgo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ipTrBei940GKP2bo50fd63JiCvqc1oPS1+aGJUFtdcs2DMAUBQ73T48KJjBE91qZ3XrshgchmdLfqNei8Le7uI3xCuz5UfCXSK+fqbFBnUawrDzGu1zDwIBHQ71skbe4Dzfd2ZZeLV9tgjyfgzsuXA1m/54QVwlMUneRNvGYFLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 192F5150C;
	Fri, 28 Feb 2025 10:25:23 -0800 (PST)
Received: from mazurka.cambridge.arm.com (mazurka.cambridge.arm.com [10.2.80.18])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ADCA33F6A8;
	Fri, 28 Feb 2025 10:25:04 -0800 (PST)
From: =?UTF-8?q?Miko=C5=82aj=20Lenczewski?= <miko.lenczewski@arm.com>
To: ryan.roberts@arm.com,
	suzuki.poulose@arm.com,
	yang@os.amperecomputing.com,
	catalin.marinas@arm.com,
	will@kernel.org,
	joro@8bytes.org,
	jean-philippe@linaro.org,
	mark.rutland@arm.com,
	joey.gouly@arm.com,
	oliver.upton@linux.dev,
	james.morse@arm.com,
	broonie@kernel.org,
	maz@kernel.org,
	david@redhat.com,
	akpm@linux-foundation.org,
	jgg@ziepe.ca,
	nicolinc@nvidia.com,
	mshavit@google.com,
	jsnitsel@redhat.com,
	smostafa@google.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev
Cc: =?UTF-8?q?Miko=C5=82aj=20Lenczewski?= <miko.lenczewski@arm.com>
Subject: [PATCH v2 0/4] Initial BBML2 support for contpte_convert()
Date: Fri, 28 Feb 2025 18:24:00 +0000
Message-ID: <20250228182403.6269-2-miko.lenczewski@arm.com>
X-Mailer: git-send-email 2.45.3
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi All,

This patch series adds adding initial support for eliding
break-before-make requirements on systems that support BBML2 and
additionally guarantee to never raise a conflict abort.

This support reorders and optionally elides a TLB invalidation in
contpte_convert(). The elision of said invalidation leads to a 12%
improvement when executing a microbenchmark designed to force the
pathological path where contpte_convert() gets called. This
represents an 80% reduction in the cost of calling contpte_convert().

However, even without the elision, the reodering represents a
performance improvement due to reducing thread contention, as there is
a smaller time window for racing threads to see an invalid pagetable
entry (especially if they already have a cached entry in their TLB
that they are working off of).

This series is based on v6.14-rc3 (0ad2507d5d93).

Patch 1 implements an allow-list of cpus that support BBML2, but with
the additional constraint of never causing TLB conflict aborts. We
settled on this constraint because we will use the feature for kernel
mappings in the future, for which we cannot handle conflict aborts
safely.

Yang Shi has a series at [1] that aims to use BBML2 to enable splitting
the linear map at runtime. This series partially overlaps with it to add
the cpu feature. We beleive this series is fully compatible with Yang's
requirements and could go first, given there is still a lot of discussion
around the best way to manage the mechanics of splitting/collapsing the
linear map.

[1]:
  https://lore.kernel.org/linux-arm-kernel/20250103011822.1257189-1-yang@os.amperecomputing.com/

Mikołaj Lenczewski (4):
  arm64: Add BBM Level 2 cpu feature
  arm64/mm: Delay tlbi in contpte_convert() under BBML2
  arm64/mm: Elide tlbi in contpte_convert() under BBML2
  iommu/arm: Add BBM Level 2 smmu feature

 arch/arm64/Kconfig                            | 11 +++
 arch/arm64/include/asm/cpucaps.h              |  2 +
 arch/arm64/include/asm/cpufeature.h           |  5 ++
 arch/arm64/kernel/cpufeature.c                | 68 +++++++++++++++++++
 arch/arm64/mm/contpte.c                       |  3 +-
 arch/arm64/tools/cpucaps                      |  1 +
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   |  3 +
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |  3 +
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  4 ++
 9 files changed, 99 insertions(+), 1 deletion(-)

-- 
2.45.3

