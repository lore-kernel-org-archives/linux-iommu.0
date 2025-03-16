Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B8A1953AD;
	Sun, 16 Mar 2025 08:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742112405; cv=none; b=lYeIxsqZuHh4bdoHLUXnWQoHS3o8KHe5Nkt9YcKpJBcJ4jafBAMLOM9wMY0BaBOMmyIsV0srxiv/a9usQvxtbV8tdiS2Wnof4QnFrYY1mVwbICLISK7WhUx68nd3Nko17Ug7ViflS7KnC2al2qi/6ljlTwe2jdu2IgB5NOwhh+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742112405; c=relaxed/simple;
	bh=27+d26U2EgjkRb+/BT+lpoDb+IcFbQOkCFlWNoVpp8k=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=sx6CZd9hOqA3bPgxCqnBenwCbv2R7nZngR96jS8IWj30+Yfab7dZQUK/AkNxOwtRgSxsKIDNhniEi4Iys+mk7t4WhZ9dfSpkCUxPxqaSV4LoXQvSkvrGNI0K4HkkuRERmKnYt+SXjA5TYIYpw+pRcnPVWXqzmY4fw0+QrwwXyWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yTsydWov; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yTsydWov"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 442FAC4CEDD;
	Sun, 16 Mar 2025 08:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742112405;
	bh=27+d26U2EgjkRb+/BT+lpoDb+IcFbQOkCFlWNoVpp8k=;
	h=Subject:To:Cc:From:Date:From;
	b=yTsydWovv4as9xpofeKGiUxd2SQNB6E/ZpLTfcH+rM70JM1xdsxNPh+EAEp95zfPj
	 nABNoxMV+bl5ND7gx6lFQa1bbqxYlTckmGdmKZw/ZW6LNKaFsLy8FQcsqiBJD+u568
	 hqjjqD1s3b5E3BoyEzne1JWKCfz3c2sP4V2XrGiE=
Subject: Patch "Fix mmu notifiers for range-based invalidates" has been added to the 6.13-stable tree
To: apopple@nvidia.com,catalin.marinas@arm.com,gregkh@linuxfoundation.org,iommu@lists.linux.dev,jgg@nvidia.com,jhubbard@nvidia.com,linux-arm-kernel@lists.infradead.org,linux-mm@kvack.org,nicolinc@nvidia.com,pjaroszynski@nvidia.com,rananta@google.com,robin.murphy@arm.com,sj@kernel.org,will@kernel.org
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 16 Mar 2025 09:02:17 +0100
Message-ID: <2025031617-swept-encounter-c305@gregkh>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-stable: commit
X-Patchwork-Hint: ignore


This is a note to let you know that I've just added the patch titled

    Fix mmu notifiers for range-based invalidates

to the 6.13-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     fix-mmu-notifiers-for-range-based-invalidates.patch
and it can be found in the queue-6.13 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From f7edb07ad7c66eab3dce57384f33b9799d579133 Mon Sep 17 00:00:00 2001
From: Piotr Jaroszynski <pjaroszynski@nvidia.com>
Date: Tue, 4 Mar 2025 00:51:27 -0800
Subject: Fix mmu notifiers for range-based invalidates

From: Piotr Jaroszynski <pjaroszynski@nvidia.com>

commit f7edb07ad7c66eab3dce57384f33b9799d579133 upstream.

Update the __flush_tlb_range_op macro not to modify its parameters as
these are unexepcted semantics. In practice, this fixes the call to
mmu_notifier_arch_invalidate_secondary_tlbs() in
__flush_tlb_range_nosync() to use the correct range instead of an empty
range with start=end. The empty range was (un)lucky as it results in
taking the invalidate-all path that doesn't cause correctness issues,
but can certainly result in suboptimal perf.

This has been broken since commit 6bbd42e2df8f ("mmu_notifiers: call
invalidate_range() when invalidating TLBs") when the call to the
notifiers was added to __flush_tlb_range(). It predates the addition of
the __flush_tlb_range_op() macro from commit 360839027a6e ("arm64: tlb:
Refactor the core flush algorithm of __flush_tlb_range") that made the
bug hard to spot.

Fixes: 6bbd42e2df8f ("mmu_notifiers: call invalidate_range() when invalidating TLBs")

Signed-off-by: Piotr Jaroszynski <pjaroszynski@nvidia.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Alistair Popple <apopple@nvidia.com>
Cc: Raghavendra Rao Ananta <rananta@google.com>
Cc: SeongJae Park <sj@kernel.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: iommu@lists.linux.dev
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Reviewed-by: Alistair Popple <apopple@nvidia.com>
Link: https://lore.kernel.org/r/20250304085127.2238030-1-pjaroszynski@nvidia.com
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/include/asm/tlbflush.h |   22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

--- a/arch/arm64/include/asm/tlbflush.h
+++ b/arch/arm64/include/asm/tlbflush.h
@@ -396,33 +396,35 @@ static inline void arch_tlbbatch_flush(s
 #define __flush_tlb_range_op(op, start, pages, stride,			\
 				asid, tlb_level, tlbi_user, lpa2)	\
 do {									\
+	typeof(start) __flush_start = start;				\
+	typeof(pages) __flush_pages = pages;				\
 	int num = 0;							\
 	int scale = 3;							\
 	int shift = lpa2 ? 16 : PAGE_SHIFT;				\
 	unsigned long addr;						\
 									\
-	while (pages > 0) {						\
+	while (__flush_pages > 0) {					\
 		if (!system_supports_tlb_range() ||			\
-		    pages == 1 ||					\
-		    (lpa2 && start != ALIGN(start, SZ_64K))) {		\
-			addr = __TLBI_VADDR(start, asid);		\
+		    __flush_pages == 1 ||				\
+		    (lpa2 && __flush_start != ALIGN(__flush_start, SZ_64K))) {	\
+			addr = __TLBI_VADDR(__flush_start, asid);	\
 			__tlbi_level(op, addr, tlb_level);		\
 			if (tlbi_user)					\
 				__tlbi_user_level(op, addr, tlb_level);	\
-			start += stride;				\
-			pages -= stride >> PAGE_SHIFT;			\
+			__flush_start += stride;			\
+			__flush_pages -= stride >> PAGE_SHIFT;		\
 			continue;					\
 		}							\
 									\
-		num = __TLBI_RANGE_NUM(pages, scale);			\
+		num = __TLBI_RANGE_NUM(__flush_pages, scale);		\
 		if (num >= 0) {						\
-			addr = __TLBI_VADDR_RANGE(start >> shift, asid, \
+			addr = __TLBI_VADDR_RANGE(__flush_start >> shift, asid, \
 						scale, num, tlb_level);	\
 			__tlbi(r##op, addr);				\
 			if (tlbi_user)					\
 				__tlbi_user(r##op, addr);		\
-			start += __TLBI_RANGE_PAGES(num, scale) << PAGE_SHIFT; \
-			pages -= __TLBI_RANGE_PAGES(num, scale);	\
+			__flush_start += __TLBI_RANGE_PAGES(num, scale) << PAGE_SHIFT; \
+			__flush_pages -= __TLBI_RANGE_PAGES(num, scale);\
 		}							\
 		scale--;						\
 	}								\


Patches currently in stable-queue which might be from pjaroszynski@nvidia.com are

queue-6.13/fix-mmu-notifiers-for-range-based-invalidates.patch
