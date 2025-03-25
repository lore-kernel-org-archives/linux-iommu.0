Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE355254AF7
	for <iommu@lists.linux.dev>; Tue, 25 Mar 2025 09:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742895412; cv=none; b=hhkueFklnUxBasdm2ZnFLkqNzzWvMrHwyMRDi2WZQv+wXTJvJEQAGTuRYNjD0qE9E9u7hCkNE3TE9JeAsOzWjTJt7DjLWGiiwD56SuY1qA0yqW3Uh8npMEQfqAU+ZUCSDRxTs3v7LGNDIZSJw9FEZMB72UJvoDNEpxzsL5anCPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742895412; c=relaxed/simple;
	bh=3D/MuSsp/QPxF75tlglyjKVX1UunnNhbd+JZHVymTjI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hBmdSBBzQpt2YdRqfmv3fpByVscE3Sg15f/u5RKrQFCg+VUZLqLRHvUTymihk/V1Ez1bIFNuidxbIcE1lLxriDabQNMvYhcSMBYrwGHsHHXmDT1UWP6JHef23/I3rLyc5FYvppnVFJM6GSYFSO2X8d+uK3C7W+Qfv+e/hPo3AEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6AC851E8D;
	Tue, 25 Mar 2025 02:36:56 -0700 (PDT)
Received: from mazurka.cambridge.arm.com (mazurka.cambridge.arm.com [10.2.80.18])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 60A083F63F;
	Tue, 25 Mar 2025 02:36:46 -0700 (PDT)
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
	ardb@kernel.org,
	mark.rutland@arm.com,
	joey.gouly@arm.com,
	maz@kernel.org,
	james.morse@arm.com,
	broonie@kernel.org,
	oliver.upton@linux.dev,
	baohua@kernel.org,
	david@redhat.com,
	ioworker0@gmail.com,
	jgg@ziepe.ca,
	nicolinc@nvidia.com,
	mshavit@google.com,
	jsnitsel@redhat.com,
	smostafa@google.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev
Cc: =?UTF-8?q?Miko=C5=82aj=20Lenczewski?= <miko.lenczewski@arm.com>
Subject: [PATCH v5 3/3] arm64/mm: Elide tlbi in contpte_convert() under BBML2
Date: Tue, 25 Mar 2025 09:36:25 +0000
Message-ID: <20250325093625.55184-4-miko.lenczewski@arm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250325093625.55184-1-miko.lenczewski@arm.com>
References: <20250325093625.55184-1-miko.lenczewski@arm.com>
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
entries. We expect the time cost of a tlbi to be much greater than the
cost of clearing and resetting the PTEs. As such, this reordering of the
tlbi outside the window where our PTEs are invalid greatly reduces the
duration the PTE are visibly invalid for other threads. This reduces the
likelyhood of a concurrent page walk finding an invalid PTE, reducing
the likelyhood of a fault in other threads, and improving performance
(more so when there are more threads).

Because we support via allowlist only bbml2 implementations that never
raise conflict aborts and instead invalidate the tlb entries
automatically in hardware, we can avoid the final flush altogether.
Avoiding flushes is a win.

Signed-off-by: Mikołaj Lenczewski <miko.lenczewski@arm.com>
Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
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

