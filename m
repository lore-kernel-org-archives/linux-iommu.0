Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D873B27605E
	for <iommu@lists.linux.dev>; Fri, 28 Feb 2025 18:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740767118; cv=none; b=HhXXDjFO5ORtzpXgq7r4YaX2p4L+DjcLslfY8OPmfAMXHcPtA/9ENbRVJO9QNM2YUNB4WbXcVhZP6WVNMkCnxbmnGzLoRhrbpfic/UZUhOEIcDP8rSsMpD1mnkombpQW6fWX40Icwmo7anKJPvwzlzb9SeB2ZHZzC3S04GTzzL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740767118; c=relaxed/simple;
	bh=M8PklyqTdrEX2UOqTvAkAODbiY//AcFQSHqMJTyBN5w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lwlVxfFvRkg3qvABNgUrul6x3Vjsaq31knzJGYZeTe/GUTxHz2vpjPlWwxkvnpHvj4Hq6117LyMHMDOTqJlzgc2Lgi4+R0YQMg+U/fy1aAlwQJAanM6bm3mokHcxKZNmI34GgIreOHAdTBGYANRzgOxb4LoIFg9uPYKurASuQ/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 330C6176A;
	Fri, 28 Feb 2025 10:25:30 -0800 (PST)
Received: from mazurka.cambridge.arm.com (mazurka.cambridge.arm.com [10.2.80.18])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C73F03F6A8;
	Fri, 28 Feb 2025 10:25:11 -0800 (PST)
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
Subject: [PATCH v2 2/4] arm64/mm: Delay tlbi in contpte_convert() under BBML2
Date: Fri, 28 Feb 2025 18:24:02 +0000
Message-ID: <20250228182403.6269-4-miko.lenczewski@arm.com>
X-Mailer: git-send-email 2.45.3
In-Reply-To: <20250228182403.6269-2-miko.lenczewski@arm.com>
References: <20250228182403.6269-2-miko.lenczewski@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When converting a region via contpte_convert() to use mTHP, we have two
different goals. We have to mark each entry as contiguous, and we would
like to smear the dirty and young (access) bits across all entries in
the contiguous block. Currently, we do this by first accumulating the
dirty and young bits in the block, using an atomic
__ptep_get_and_clear() and the relevant pte_{dirty,young}() calls,
performing a tlbi, and finally smearing the correct bits across the
block using __set_ptes().

This approach works fine for BBM level 0, but with support for BBM level
2 we are allowed to reorder the tlbi to after setting the pagetable
entries. This reordering means that other threads will not see an
invalid pagetable entry, instead operating on stale data, until we have
performed our smearing and issued the invalidation. Avoiding this
invalid entry reduces faults in other threads, and thus improves
performance marginally (more so when there are more threads).

Signed-off-by: Mikołaj Lenczewski <miko.lenczewski@arm.com>
Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
---
 arch/arm64/mm/contpte.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/mm/contpte.c b/arch/arm64/mm/contpte.c
index 55107d27d3f8..145530f706a9 100644
--- a/arch/arm64/mm/contpte.c
+++ b/arch/arm64/mm/contpte.c
@@ -68,9 +68,13 @@ static void contpte_convert(struct mm_struct *mm, unsigned long addr,
 			pte = pte_mkyoung(pte);
 	}
 
-	__flush_tlb_range(&vma, start_addr, addr, PAGE_SIZE, true, 3);
+	if (!system_supports_bbml2_noabort())
+		__flush_tlb_range(&vma, start_addr, addr, PAGE_SIZE, true, 3);
 
 	__set_ptes(mm, start_addr, start_ptep, pte, CONT_PTES);
+
+	if (system_supports_bbml2_noabort())
+		__flush_tlb_range(&vma, start_addr, addr, PAGE_SIZE, true, 3);
 }
 
 void __contpte_try_fold(struct mm_struct *mm, unsigned long addr,
-- 
2.45.3

