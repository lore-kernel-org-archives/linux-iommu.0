Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9FC6265CCB
	for <iommu@lists.linux.dev>; Thu, 13 Mar 2025 10:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741862610; cv=none; b=EUdgQ+suBz1IZUguN2eSYXZ9cOGvUeZBf0tZ+xM7fjBJu05QmpoXWbXJ/5ZYXVE6CrbkRNKzsDnu1+IDbJCyhuNIyqec5yDNPH+EiD7Aky8cG30RMGXJfZoC0j0IDNTappCR6oZkutRN73OzvUoFwsQxFP9RllK8h9YhOY3aeLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741862610; c=relaxed/simple;
	bh=oxyMYNDTDzd68AaGHS1tWt3yStPLN3sbLPVLkBdfG3s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K7Mnbnc9t88AT0pdq7HnCnCf8Ddhg0jIlI37cRAghjb6Dg26vwM2JyLzz7eNbLTWrsCyPuv1HHnBbeY//4Aq+pwMx+9STzMzZqvLgO2+xP2yLeqEFVmuuTa0OCmF9HNKEuzLp1VTIUtxxR4xB6yV2tg14nwCBNyhmIf9lZOBUHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 82C4527DC;
	Thu, 13 Mar 2025 03:43:38 -0700 (PDT)
Received: from mazurka.cambridge.arm.com (mazurka.cambridge.arm.com [10.2.80.18])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EC0163F694;
	Thu, 13 Mar 2025 03:43:23 -0700 (PDT)
From: =?UTF-8?q?Miko=C5=82aj=20Lenczewski?= <miko.lenczewski@arm.com>
To: ryan.roberts@arm.com,
	suzuki.poulose@arm.com,
	yang@os.amperecomputing.com,
	corbet@lwn.net,
	catalin.marinas@arm.com,
	will@kernel.org,
	jean-philippe@linaro.org,
	robin.murphy@arm.com,
	joro@8bytes.org,
	akpm@linux-foundation.org,
	mark.rutland@arm.com,
	joey.gouly@arm.com,
	maz@kernel.org,
	james.morse@arm.com,
	broonie@kernel.org,
	anshuman.khandual@arm.com,
	oliver.upton@linux.dev,
	ioworker0@gmail.com,
	baohua@kernel.org,
	david@redhat.com,
	jgg@ziepe.ca,
	shameerali.kolothum.thodi@huawei.com,
	nicolinc@nvidia.com,
	mshavit@google.com,
	jsnitsel@redhat.com,
	smostafa@google.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev
Cc: =?UTF-8?q?Miko=C5=82aj=20Lenczewski?= <miko.lenczewski@arm.com>
Subject: [PATCH v3 3/3] arm64/mm: Elide tlbi in contpte_convert() under BBML2
Date: Thu, 13 Mar 2025 10:41:12 +0000
Message-ID: <20250313104111.24196-5-miko.lenczewski@arm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250313104111.24196-2-miko.lenczewski@arm.com>
References: <20250313104111.24196-2-miko.lenczewski@arm.com>
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
entries. This reordering reduces the likelyhood of a concurrent page
walk finding an invalid (not present) PTE. This reduces the likelyhood
of a fault in other threads, and improves performance marginally
(more so when there are more threads).

If we support bbml2 without conflict aborts however, we can avoid the
final flush altogether and have hardware manage the tlb entries for us.
Avoiding flushes is a win.

Signed-off-by: Mikołaj Lenczewski <miko.lenczewski@arm.com>
---
 arch/arm64/mm/contpte.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/mm/contpte.c b/arch/arm64/mm/contpte.c
index 55107d27d3f8..77ed03b30b72 100644
--- a/arch/arm64/mm/contpte.c
+++ b/arch/arm64/mm/contpte.c
@@ -68,7 +68,8 @@ static void contpte_convert(struct mm_struct *mm, unsigned long addr,
 			pte = pte_mkyoung(pte);
 	}
 
-	__flush_tlb_range(&vma, start_addr, addr, PAGE_SIZE, true, 3);
+	if (!system_supports_bbml2_noabort())
+		__flush_tlb_range(&vma, start_addr, addr, PAGE_SIZE, true, 3);
 
 	__set_ptes(mm, start_addr, start_ptep, pte, CONT_PTES);
 }
-- 
2.48.1

