Received: from out203-205-251-66.mail.qq.com (out203-205-251-66.mail.qq.com [203.205.251.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A017415530D
	for <iommu@lists.linux.dev>; Tue,  9 Jul 2024 09:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.251.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720517163; cv=none; b=MBhEhL0jEHZlqqAPr7wJBtNTMG1+I1ECuwt9MvLHKnS+O+K3x1ptThsUxg/XbdlSECmsBLI37MsxAMHSWqPZ2EVX6+Tmkez/xdsr2D8AhgHn/lsjKFHptyFeT3/RD1qfk3Ehy2VMCx1Nr/TkNybrgIvjJHxgNQsThAc8xZA6sJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720517163; c=relaxed/simple;
	bh=fSUbV7tFkBt93VskwmkO/ehBNqtRph/kx9sBJz720M4=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=CykSFgbxaf3MZeC8DLBHwMTz+vxUnvzznRH/Kuf7/0cRZcvqzNZPYwdgChxWu1zMG4E7kLDjbMdpWXzscra3652FgOP1iEhBdsgD9Uqyiue/lXklP1PWAwOu8GvNQnF5a8xlGseVwAXue6AQm1AyV3PTI+wG+SwpNYjwNrvc5DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name; spf=none smtp.mailfrom=cyyself.name; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=tNxLlINK; arc=none smtp.client-ip=203.205.251.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cyyself.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="tNxLlINK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1720517151; bh=tEdSWJRqnHTNHkLT51gYacmV1crsh1EMbihoD9Utpi0=;
	h=From:To:Cc:Subject:Date;
	b=tNxLlINK76oPZcILWawIpisrFMwF/FYAsQ0BuMmgLqsoThAW9RwqouggVkJtZ8PL3
	 He7SaH6Rw0gDMOp/58D2CFlQ3hhp4mkEqyXtw3VTWs1Fmo6BpzLkGUPeTK3+AScLyp
	 TXiO1x5rD1RiHqS3HvUlWJo4nqF17Vp6NGjY6k+k=
Received: from cyy-pc.lan ([240e:379:225e:9b00:b588:778:1f25:bdbe])
	by newxmesmtplogicsvrsza10-0.qq.com (NewEsmtp) with SMTP
	id 66284851; Tue, 09 Jul 2024 17:25:34 +0800
X-QQ-mid: xmsmtpt1720517134th6q0i812
Message-ID: <tencent_A5ED71472ADCAF18F59085464CBE23C12A07@qq.com>
X-QQ-XMAILINFO: NLNuKjcZ2ePXhKs02oEt1D3qgjhaBaAXFbzPbSRY78pCLLTTQijsQCYJer0Tg5
	 pRlmwlx35mIimGnWzWnmHnA8UDn2lELHJDs8ZrseNwisoIVCrD7jHFq06GECRz2RMwJYnzExGauW
	 FBYLiuLzjMmIcORvBf9yPVu24OUWIQYVNj4ILo5HcBXCUd6fcw6oOVyiVFQROk35HB1WcPbHbdc2
	 PjN/5Qt2cgTf0BoS5sFcSDkPFFzt3l/7GFUsuIqBtalQ6ytQ+DPOnS15uCAtyLPQk34ME1/G+fJQ
	 1+Ht/LRVUNlvTS7V8XY1eNB+LzRhpqxvxXHtpd0hH2lItH5+KURA/rhgw2lu/5rxOzvtU7OQi2Px
	 cfS5/gm8DpdvK9bbIXniqCQwdeu5WQQIhfib+ZOUKaeJP2OaOOeQSzyjVbvsgcSOuwJaPIwOWtlQ
	 J8xbFBout6eWAcju1nntFgkW9RFYZRdQUS4NGEr12JpIFKpXlIk98PYwlWG+5A4c6T05NkoG9nH/
	 AZuU8mJ2/wXM0LAj7Rf6DWRZSm4z3t7eUsgHC6dj3dgr2WNXzGaM+qcfHDlLPJItUOnMAa13qaSt
	 TkRNvE5YoHjxDS0vonvBd1Ryv1W2qen1+rcdGHIsvCTmGj6MmLF9ELMBzM5piFNWEVXQGgRHT98Y
	 uNSlqr4tHLxgYxi5z8xZQFBbpcEzE2ZEC6ArA4VIbQibRVmc+WDGyR6Ngb0am+P/ccgRQqIzAwL2
	 m7JuqJTmIzcEHOCiw7Mu0CnRFSG6It6pyjOifmL4X9wyQ8dKHbehkPXicqM1kAs1TRmc47wZp8t2
	 JyTqoynAlalrl4WVZyvV6Ef/7FXUjhiroU9XuCLGqqP0i2ZGOJ8wex03+mVHTGiU21UbAWaPisIK
	 a9C+zTO8AS24sTqIa6/wt27JISxiRGPjLmP4YGOJaKA6YQ4fK7ZwlMGud1MrmdKaksbZAXv0BYBu
	 PEVeStkZijJFJ8IgzYNaqsCVvv8LPAs9/+YgTzIQ8NnMOyxpgaXE6wUD9U2ki8GfCUzLzvOygN/W
	 tBUBLYaw==
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
From: Yangyu Chen <cyy@cyyself.name>
To: iommu@lists.linux.dev
Cc: linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Yangyu Chen <cyy@cyyself.name>
Subject: [PATCH -fixes] dma-mapping: add default implementation to arch_dma_{set|clear}_uncached
Date: Tue,  9 Jul 2024 17:25:29 +0800
X-OQ-MSGID: <20240709092529.3977310-1-cyy@cyyself.name>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, we have some code in kernel/dma/direct.c which references
arch_dma_set_uncached and arch_dma_clear_uncached. However, many
architectures do not provide these symbols, and the code currently
relies on compiler optimization to cut the unnecessary code. When the
compiler fails to optimize it, the code will reference the symbol and
cause a link error. I found this bug when developing some new extensions
for RISC-V on LLVM. The error message is shown below:

```
  LD      .tmp_vmlinux.kallsyms1
ld.lld: error: undefined symbol: arch_dma_set_uncached
>>> referenced by direct.c
>>>               kernel/dma/direct.o:(dma_direct_alloc) in archive
vmlinux.a
make[2]: *** [scripts/Makefile.vmlinux:34: vmlinux] Error 1
```

This patch adds default implementations for arch_dma_set_uncached and
arch_dma_clear_uncached in include/linux/dma-map-ops.h. So that the
code in kernel/dma/direct.c can always reference these symbols to
avoid link errors.

Signed-off-by: Yangyu Chen <cyy@cyyself.name>
---
 include/linux/dma-map-ops.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/linux/dma-map-ops.h b/include/linux/dma-map-ops.h
index 02a1c825896b..92a713557859 100644
--- a/include/linux/dma-map-ops.h
+++ b/include/linux/dma-map-ops.h
@@ -420,8 +420,22 @@ static inline void arch_dma_mark_clean(phys_addr_t paddr, size_t size)
 }
 #endif /* ARCH_HAS_DMA_MARK_CLEAN */
 
+#ifdef CONFIG_ARCH_HAS_DMA_SET_UNCACHED
 void *arch_dma_set_uncached(void *addr, size_t size);
+#else
+static inline void *arch_dma_set_uncached(void *addr, size_t size)
+{
+	return ERR_PTR(-EINVAL);
+}
+#endif /* CONFIG_ARCH_HAS_DMA_SET_UNCACHED */
+
+#ifdef CONFIG_ARCH_HAS_DMA_CLEAR_UNCACHED
 void arch_dma_clear_uncached(void *addr, size_t size);
+#else
+static inline void arch_dma_clear_uncached(void *addr, size_t size)
+{
+}
+#endif /* CONFIG_ARCH_HAS_DMA_CLEAR_UNCACHED */
 
 #ifdef CONFIG_ARCH_HAS_DMA_MAP_DIRECT
 bool arch_dma_map_page_direct(struct device *dev, phys_addr_t addr);
-- 
2.45.2

