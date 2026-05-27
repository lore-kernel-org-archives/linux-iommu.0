Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E61383C85
	for <iommu@lists.linux.dev>; Wed, 27 May 2026 03:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779852640; cv=none; b=frqQ09jIQxKTBdw+t9u13ex1cy0MHPTrYkdLtnk0APPqh6BKCLk0VzWhSMAjnhyXooEfRK7YjVj6iqxoJkFW1G2txkfqnIOuM9FyY5QhwuCNWC6KIapL3Fvned7eztDm1uKMUaP2uu8nwM4clKVqfUhsCS/OQ8mY1RL2lknGxz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779852640; c=relaxed/simple;
	bh=Da0oBjp44x8BvyVj0AmgQWkstuuP08sX20VzouoaLK4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bf6ju16xZZK60pB63G5I6PHZuRRX8HpQReC6TpbK6A1EScJZ2zsboYisUom7D1cgYO119Jw4aBBA/k9CzgepXb4nOmC60rsI5P9v3tQWPuMRsuleLqGfY6ZoNJQ+eLWcHWERyJNbgGd0XuFo2ebrwm7eXb2uPTAFqVFX/ij7+fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U187RRHV; arc=none smtp.client-ip=209.85.210.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U187RRHV"
Received: by mail-pf1-f194.google.com with SMTP id d2e1a72fcca58-841882f8f4bso1399521b3a.0
        for <iommu@lists.linux.dev>; Tue, 26 May 2026 20:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779852638; x=1780457438; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hKDMR5TAGwiz4Z0dhIjLc6hZgq3gL98geqqMieh10P4=;
        b=U187RRHVKoh7C7Hj0+8R8/dXK16iTNdZLFvc3U1eTYcmTwYVArMtoei9brIrKHNE98
         wzk7ppLy5W8RN17Jk/6nYdGDLHs6H8x4a7wENxhvrb8uNAePPfQBasnefwN+VWK8qtOw
         7lLQ/YH/gFSAA6B3obfpfKm8iylB/+cuygJWzJdXZdcX0GFY1s2F8PdFrz3murON8E+I
         GS0FsZx1jZ8zHB9GUkWcpKNsxu9m2Urohs4ltbhyxnmG09MCoTzo+GgZkzw8yGRTZWxt
         KB/ywGlnDBE64cueeWBLLfarleBsNP7nRi34ViyvppQPc01v9UEFIrV/8HBm/sO6ST9x
         0Kew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779852638; x=1780457438;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hKDMR5TAGwiz4Z0dhIjLc6hZgq3gL98geqqMieh10P4=;
        b=TeZZsbGYO9UhHM+C6yC7YB5hQDEgmYjdh5qTk5GQgmKXPp+epCa/aI/AFWoIj3sGxf
         GW1+n9xH+sr8c/qHj975H5btxZuDOFwBwxkBa3Zw3zlOVw+UQUZGgnIDruruPQ/l2R2q
         cgN9vjD2VPJf3X57IPl9N57YH3SWccvql78iWMTSbpRLbVPPHvVHJP5aMS/VkpCbSpnS
         geyIXbOEi2qNWZoM+oS7Ln3kTeBi65Sn7KFAkKVjg05c5wwrtlqQjbhyS12ksu8HSLuX
         Or4oL/ys1tr4Njg6rnjfACqxSxDFNrLq99qSlwBi5M7PHeGUJGAZ/nMYp9Npa3r9EcH3
         Yv2g==
X-Forwarded-Encrypted: i=1; AFNElJ9QIpLTRO/Jr7hM55FtuewROzyOx7HtbVXMtwUlUEw9OmRtnqp3R47KQDaq5uJWqez/iCYG4w==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx8sBrl3NwFFTSKRbVyB+pT7FnJHY/NpHVr/UJqrMaixVtBVz6X
	nQvO6+EoZsz5Ywbc4md0XbeSqAggZh4/0bvzUEqX9HlWcRTeDgkA8DWq
X-Gm-Gg: Acq92OGjwFpF9R2rJaHzkuCfKnDeKYK50ATw9G6n1eMEUrVV/KLgn5Rt+twMqgEMpNS
	LG2syV+wtG5GXnkRhgPIsS/ShfOYLE2w5Nhqi88hjYD2MuqnaVwS7x88axV/jmp4D5TGD0+nGoH
	KmY8Gg26Xpp7Ur2/a3Ne52fuWqDo3ZO8uDhRX9KhI73kfbb0ksoivuG/1EBbDalaubR4hzaia9B
	RaEp7cZhmbuWkvX5y4knH7kMZc+pxQSHYPv1lbGJtiBiLfBHMGpFvk0VWkusUszRkenJEoaNpS5
	CxpTcd4Ie5sfyEAjfJyMm0FdlzroXLvHQyzlazaaS6ClDk+ydsm6uqBvi28HBUrL7N3gbc2dzk8
	rALdvmS9Zj7HDhnIs4X3MboNHhyqY+8kqUJ676KJMG5rSRDbLvHotg6mplCSOItAgGaVxm5NBfL
	tfKl9HqzgGKRyEvivOckKUI3VnQ6iWkgiRhbf+
X-Received: by 2002:a05:6a00:1d9e:b0:835:38db:82f6 with SMTP id d2e1a72fcca58-8415f69ea9cmr20057592b3a.36.1779852638276;
        Tue, 26 May 2026 20:30:38 -0700 (PDT)
Received: from intel.company.local ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-841d7307596sm749688b3a.59.2026.05.26.20.30.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 20:30:37 -0700 (PDT)
From: Wandun Chen <chenwandun1@gmail.com>
To: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	kexec@lists.infradead.org,
	iommu@lists.linux.dev,
	zhaomeijing@lixiang.com
Cc: catalin.marinas@arm.com,
	will@kernel.org,
	chenhuacai@kernel.org,
	kernel@xen0n.name,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	robh@kernel.org,
	saravanak@kernel.org,
	akpm@linux-foundation.org,
	bhe@redhat.com,
	rppt@kernel.org,
	pasha.tatashin@soleen.com,
	pratyush@kernel.org,
	ruirui.yang@linux.dev,
	m.szyprowski@samsung.com,
	robin.murphy@arm.com,
	quic_obabatun@quicinc.com
Subject: [PATCH v3 06/11] of: reserved_mem: add dumpable flag to opt-in vmcore
Date: Wed, 27 May 2026 11:29:12 +0800
Message-ID: <20260527032917.3385849-7-chenwandun1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260527032917.3385849-1-chenwandun1@gmail.com>
References: <20260527032917.3385849-1-chenwandun1@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wandun Chen <chenwandun@lixiang.com>

Add a 'dumpable' flag to struct reserved_mem so the kernel can decide
whether a reserved area should be included in the kdump vmcore. Most
reserved regions are owned by devices and do not contain data useful
for kernel crash analysis, so excluding them by default is the right
behaviour.

Reusable CMA regions are different: pages in a CMA region are handed
back to the buddy allocator and may contain key data for crash
analysis, so set dumpable to true in rmem_cma_setup().

Suggested-by: Rob Herring <robh@kernel.org>
Signed-off-by: Wandun Chen <chenwandun@lixiang.com>
Tested-by: Meijing Zhao <zhaomeijing@lixiang.com>
Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>
Link: https://lore.kernel.org/all/20260506144542.GA2072596-robh@kernel.org/
---
 include/linux/of_reserved_mem.h | 1 +
 kernel/dma/contiguous.c         | 1 +
 2 files changed, 2 insertions(+)

diff --git a/include/linux/of_reserved_mem.h b/include/linux/of_reserved_mem.h
index e8b20b29fa68..55a67cee41ea 100644
--- a/include/linux/of_reserved_mem.h
+++ b/include/linux/of_reserved_mem.h
@@ -15,6 +15,7 @@ struct reserved_mem {
 	phys_addr_t			base;
 	phys_addr_t			size;
 	void				*priv;
+	bool				dumpable;
 };
 
 struct reserved_mem_ops {
diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
index 03f52bd17120..eddec89eb414 100644
--- a/kernel/dma/contiguous.c
+++ b/kernel/dma/contiguous.c
@@ -579,6 +579,7 @@ static int __init rmem_cma_setup(unsigned long node, struct reserved_mem *rmem)
 		dma_contiguous_default_area = cma;
 
 	rmem->priv = cma;
+	rmem->dumpable = true;
 
 	pr_info("Reserved memory: created CMA memory pool at %pa, size %ld MiB\n",
 		&rmem->base, (unsigned long)rmem->size / SZ_1M);
-- 
2.43.0

