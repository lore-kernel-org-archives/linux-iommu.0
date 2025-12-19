Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD23D33B6FF
	for <iommu@lists.linux.dev>; Fri, 19 Dec 2025 12:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766146827; cv=none; b=rEh1EU5aFxPz3zhAq1BeXH+2DAkSW0W5sH22SWKFdgtWDA+dhSUrWSBITFHB4vNpnYnbdmLYJNp8dDxWjWj8hgMUsHunN3qH2oimzllfIO/4jsq/qbUlIsQ/z/ehL2VBx6xaUkmyIlUhCw5L1nJm5VYEHVWwlAZpQZ1/gYLBA6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766146827; c=relaxed/simple;
	bh=C7BSrlgKQIj8finaTXILJjQlV7177cLejoNIk+xLSwE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SAXXE2aBRAqjvZb/Pt+kJJhZJg8XoBL4DWRs7MRPnXwoZn9WgGY1zjML2SsNY66WkxabyEk2zXymoyow0BT1qBTgGFtkf/0Zp9elE5kOfHuVR5bQmDYONgUXxb+4aB7CbEUgtrW3D+bjpBNP+mxX+dZzuJUdUHDY/HN/sxTJH28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DAE94FEC;
	Fri, 19 Dec 2025 04:20:16 -0800 (PST)
Received: from [10.57.47.58] (unknown [10.57.47.58])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9571F3F5CA;
	Fri, 19 Dec 2025 04:20:21 -0800 (PST)
Message-ID: <f43286ef-3dea-4637-a34e-b9b70d2741bf@arm.com>
Date: Fri, 19 Dec 2025 12:20:13 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] arm64: Provide dcache_by_myline_op_nosync helper
To: Barry Song <21cnbao@gmail.com>, catalin.marinas@arm.com,
 m.szyprowski@samsung.com, will@kernel.org
Cc: ada.coupriediaz@arm.com, anshuman.khandual@arm.com, ardb@kernel.org,
 iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, maz@kernel.org, ryan.roberts@arm.com,
 surenb@google.com, v-songbaohua@oppo.com, zhengtangquan@oppo.com
References: <20251219053658.84978-1-21cnbao@gmail.com>
 <20251219053658.84978-2-21cnbao@gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20251219053658.84978-2-21cnbao@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-12-19 5:36 am, Barry Song wrote:
> From: Barry Song <v-songbaohua@oppo.com>
> 
> dcache_by_myline_op ensures completion of the data cache operations for a
> region, while dcache_by_myline_op_nosync only issues them without waiting.
> This enables deferred synchronization so completion for multiple regions
> can be handled together later.

This is a super-low-level internal macro with only two users... Frankly I'd
just do as below.

Thanks,
Robin.

----->8-----

diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index f0ca7196f6fa..26e983c331c5 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -367,18 +367,17 @@ alternative_endif
  	.endm
  
  /*
- * Macro to perform a data cache maintenance for the interval
- * [start, end) with dcache line size explicitly provided.
+ * Main loop for a data cache maintenance operation. Caller to provide the
+ * dcache line size and take care of relevant synchronisation afterwards.
   *
   * 	op:		operation passed to dc instruction
- * 	domain:		domain used in dsb instruction
   * 	start:          starting virtual address of the region
   * 	end:            end virtual address of the region
   *	linesz:		dcache line size
   * 	fixup:		optional label to branch to on user fault
   * 	Corrupts:       start, end, tmp
   */
-	.macro dcache_by_myline_op op, domain, start, end, linesz, tmp, fixup
+	.macro raw_dcache_by_line_op op, start, end, linesz, tmp, fixup
  	sub	\tmp, \linesz, #1
  	bic	\start, \start, \tmp
  .Ldcache_op\@:
@@ -402,7 +401,6 @@ alternative_endif
  	add	\start, \start, \linesz
  	cmp	\start, \end
  	b.lo	.Ldcache_op\@
-	dsb	\domain
  
  	_cond_uaccess_extable .Ldcache_op\@, \fixup
  	.endm
@@ -420,7 +418,8 @@ alternative_endif
   */
  	.macro dcache_by_line_op op, domain, start, end, tmp1, tmp2, fixup
  	dcache_line_size \tmp1, \tmp2
-	dcache_by_myline_op \op, \domain, \start, \end, \tmp1, \tmp2, \fixup
+	raw_dcache_by_line_op \op, \start, \end, \tmp1, \tmp2, \fixup
+	dsb \domain
  	.endm
  
  /*
diff --git a/arch/arm64/kernel/relocate_kernel.S b/arch/arm64/kernel/relocate_kernel.S
index 413f899e4ac6..efdb6884058e 100644
--- a/arch/arm64/kernel/relocate_kernel.S
+++ b/arch/arm64/kernel/relocate_kernel.S
@@ -64,7 +64,8 @@ SYM_CODE_START(arm64_relocate_new_kernel)
  	mov	x19, x13
  	copy_page x13, x12, x1, x2, x3, x4, x5, x6, x7, x8
  	add	x1, x19, #PAGE_SIZE
-	dcache_by_myline_op civac, sy, x19, x1, x15, x20
+	raw_dcache_by_line_op civac, x19, x1, x15, x20
+	dsb	sy
  	b	.Lnext
  .Ltest_indirection:
  	tbz	x16, IND_INDIRECTION_BIT, .Ltest_destination

