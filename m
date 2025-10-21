Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3869522B8CB
	for <iommu@lists.linux.dev>; Tue, 21 Oct 2025 01:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761009075; cv=none; b=cZVGYUc0vERBWXdVA3cxs9QxFbRwXxiDrn/KxsF+OcqD/fcy5P+NCYdS/dNmhphlvtKUcBQvsZiEGbnZyT/dJVTlDyzNdggXbmKLyLmMsRUpX5r2KAGa65u5oo2MYFAWRU2oIlbZ5k7a6QB+R4C3Q2k9sIx/kfxwhywPFRmdR74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761009075; c=relaxed/simple;
	bh=DrL2WwRNEFOK1bJtIv9ky7I7c7G4ou42pOsCGy3RwiM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=takaQldAr7i09krvAbJN6UFRp0i9fabSqrqtyaKqZiREWCazIYqk+fyYmy9OFJ/vUtgi4YLMlHqEiT2zUhuh17uJOJpCO2cV08CPFr6di1JxwBDs0nYtxQKIlCoJmktZh0LDhGrq/tNp9PyRF3wC0ig70hejJMa+wS8SymqdBXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=CEItOGrG; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="CEItOGrG"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1761009063; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=OBImoBy0givvKDy/jG9fhQjUBUsrZdSED+mmJaxLZFs=;
	b=CEItOGrGIYNqWwtFBYvGn83mI7sHF5uBTwX7W4b/V/Tm+fKQhnv0RWCfdTUzTLS/c3fTcYT0hvEjD1lUgDzRJw2VsIPdRNadBtIXY0TwIH3yd8nRozWYL1wBUV+aJa+HClIjwQU9pzXGyKUP5c6EMYo+CO+Ar98Y+ippP5LCzGU=
Received: from localhost.localdomain(mailfrom:fangyu.yu@linux.alibaba.com fp:SMTPD_---0WqgnWHu_1761009059 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 21 Oct 2025 09:11:01 +0800
From: fangyu.yu@linux.alibaba.com
To: ajones@ventanamicro.com
Cc: alex.williamson@redhat.com,
	alex@ghiti.fr,
	anup@brainfault.org,
	atish.patra@linux.dev,
	iommu@lists.linux.dev,
	jgg@nvidia.com,
	joro@8bytes.org,
	kvm-riscv@lists.infradead.org,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	palmer@dabbelt.com,
	paul.walmsley@sifive.com,
	robin.murphy@arm.com,
	tglx@linutronix.de,
	tjeznach@rivosinc.com,
	will@kernel.org,
	zong.li@sifive.com
Subject: Re: [RFC PATCH v2 18/18] DO NOT UPSTREAM: RISC-V: KVM: Workaround kvm_riscv_gstage_ioremap() bug 
Date: Tue, 21 Oct 2025 09:10:58 +0800
Message-Id: <20251021011058.96077-1-fangyu.yu@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20250920203851.2205115-38-ajones@ventanamicro.com>
References: <20250920203851.2205115-38-ajones@ventanamicro.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

>Workaround a bug that breaks guest booting with device assignment that
>was introduced with commit 9bca8be646e0 ("RISC-V: KVM: Fix pte settings
>within kvm_riscv_gstage_ioremap()")

The root cause of the guest booting failure is that an HPA is obtained
in the kvm_arch_prepare_memory_region.

Here [1] might be the correct fixes for this issue.
[1] https://lore.kernel.org/linux-riscv/20251020130801.68356-1-fangyu.yu@linux.alibaba.com/T/#u

>---
> arch/riscv/kvm/mmu.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
>index 525fb5a330c0..994f18b92143 100644
>--- a/arch/riscv/kvm/mmu.c
>+++ b/arch/riscv/kvm/mmu.c
>@@ -56,7 +56,7 @@ int kvm_riscv_mmu_ioremap(struct kvm *kvm, gpa_t gpa, phys_addr_t hpa,
> 
> 	end = (gpa + size + PAGE_SIZE - 1) & PAGE_MASK;
> 	pfn = __phys_to_pfn(hpa);
>-	prot = pgprot_noncached(PAGE_WRITE);
>+	prot = pgprot_noncached(__pgprot(_PAGE_PRESENT | _PAGE_ACCESSED | _PAGE_READ | _PAGE_WRITE));
> 
> 	for (addr = gpa; addr < end; addr += PAGE_SIZE) {
> 		map.addr = addr;
>-- 
>2.49.0

Thanks,
Fangyu
