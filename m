Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89556245005;
	Tue, 22 Apr 2025 07:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745308580; cv=none; b=VizWeh1mkYu44ghN7BRrpzl9ROjTNfiAWfKhq0hDg6noPy3iBBWfQ1ekegtOY00NU/DxwGJHcFe6mIWMVnfP7ooCdqAv/pTyJ9mY0EBm3cfZFHA/+10HMzdD0pwBghG4otEL6PZTGiTiG1CmtjZytcDUay1qIz6812QE61cL2lM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745308580; c=relaxed/simple;
	bh=5IHVZ518v1tW+/IGWWsuU/FGE1j6f0ia94o/kYtjpEQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Q43ZPW2tFW0uqsES3NW6WJvi0+s/nEkmA5bXuL+8f4n+n2MelHD89vJrdU813mvANBKAYqTTSQ74/zKyNEMuqbq6CFwTpyqpC0gODMpybXtKrYHoTV3iw6cxjvY4gD5wYYOu3hDpqHaCxVyR+Lngctm4nsDmg6fqo6Mi5ePjQlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2B2X1Rzp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2B2X1Rzp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15CB5C4CEE9;
	Tue, 22 Apr 2025 07:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745308580;
	bh=5IHVZ518v1tW+/IGWWsuU/FGE1j6f0ia94o/kYtjpEQ=;
	h=Subject:To:Cc:From:Date:From;
	b=2B2X1RzpmP324+zVeqUaFu/Wi3vwsC1P8OsWEMrCV7nP4pF0Nq/c7y8zDKiZUrtYA
	 MtaKTH1iHckAfuyt5YlztJdUCYrRxHWmLdOgbC8S4guOd921pFRaTcqgR1ftE2uX4J
	 Z3tVGnh3Q8ru1zUbGTD35dPFHWWmxeLWeywOCJEU=
Subject: Patch "Fix mmu notifiers for range-based invalidates" has been added to the 6.6-stable tree
To: apopple@nvidia.com,catalin.marinas@arm.com,gregkh@linuxfoundation.org,iommu@lists.linux.dev,jgg@nvidia.com,jhubbard@nvidia.com,linux-arm-kernel@lists.infradead.org,linux-mm@kvack.org,nicolinc@nvidia.com,pjaroszynski@nvidia.com,rananta@google.com,robin.murphy@arm.com,sj@kernel.org,will@kernel.org
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 22 Apr 2025 09:55:44 +0200
Message-ID: <2025042244-divorcee-haunt-f231@gregkh>
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

to the 6.6-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     fix-mmu-notifiers-for-range-based-invalidates.patch
and it can be found in the queue-6.6 subdirectory.

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
[will: Resolve conflicts due to lack of LPA2 support]
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/include/asm/tlbflush.h |   22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

--- a/arch/arm64/include/asm/tlbflush.h
+++ b/arch/arm64/include/asm/tlbflush.h
@@ -369,31 +369,33 @@ static inline void arch_tlbbatch_flush(s
 #define __flush_tlb_range_op(op, start, pages, stride,			\
 				asid, tlb_level, tlbi_user)		\
 do {									\
+	typeof(start) __flush_start = start;				\
+	typeof(pages) __flush_pages = pages;				\
 	int num = 0;							\
 	int scale = 3;							\
 	unsigned long addr;						\
 									\
-	while (pages > 0) {						\
+	while (__flush_pages > 0) {					\
 		if (!system_supports_tlb_range() ||			\
-		    pages == 1) {					\
-			addr = __TLBI_VADDR(start, asid);		\
+		    __flush_pages == 1) {				\
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
-			addr = __TLBI_VADDR_RANGE(start, asid, scale,	\
-						  num, tlb_level);	\
+			addr = __TLBI_VADDR_RANGE(__flush_start, asid,	\
+						scale, num, tlb_level);	\
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

queue-6.6/fix-mmu-notifiers-for-range-based-invalidates.patch
