Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.228.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792571517;
	b=DxK7NqSljkgK7wvHumxOsVBi2dJuKLIoJk+Kv+E/mE4Uejz+HjtTMUAQk1OrzF9LDhnF
	 IhUbkWqyuq6ZvL+7q1EEbLA6Zdf2u/zokblheB3cuVLnN0yJuenZQpB4VdSWpE4GI+g0c
	 bTVuggq92boDj42X8krLB6LuQjDFbwWZUvkKo5/QMCWuaT4VMMdxkZInsocdvIQaEbP7h
	 Ackse0/DuCrmlkugUdphByji7nhAVMporF7+StEpLcfto1fAf8VGXXnnTtrnqc86ZGfXF
	 YF7g80kXBB25b0XAlHKPOU+na6NhiB182N5pTVeNim2kcMhROkqkTcBrmCNpy9q1eCw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792571517;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=EXuyqgfiF9x7HO7+fbFxeGIrd5nFUV6QECR0sZa4nrg=;
	b=yKOKtC8VDRVlKypzQCkaKJswPAxh3aOlG/oiSMNkKNTVd305ZjF6xvtEpUh+p4b2xLUI
	 l+I3QlmX/MhTHsB6BsONAaoeGi9a+AkyDfM6poVnYVCTay+dJ//T91ZHBLhPmKRTJnXxz
	 7cOiRFHR4FOMBpoCxAMZrZwqQL63NilKtQH+J/wOk7B7Um0yAnIIBPeubWHwDKVkBdDs1
	 g4JLWsYzgr6tPgMOT6CosTcXtnIlfbKZkGSyiX7s4MoK2eVMyvM/BoTYstZNuGT/pkBB5
	 A9rEp8SfRmUNulE9SH4dUIkNQssxeFTmJXV8vnPvWFYCA/OExBYmJsqU+C+mSdRrKMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=c0ajL3lG;
	arc=none smtp.remote-ip=74.125.228.9
Received: from mail-pz2-f9.google.com (mail-pz2-f9.google.com [74.125.228.9])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822F5606A31B
	for <iommu@lists.linux.dev>; Wed, 21 Oct 2026 08:31:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 822F5606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=c0ajL3lG
Received: by mail-pz2-f9.google.com with SMTP id 41be03b00d2f7-cd69ca84740so115871a12.1
        for <iommu@lists.linux.dev>; Wed, 21 Oct 2026 01:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792571516; x=1793176316; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EXuyqgfiF9x7HO7+fbFxeGIrd5nFUV6QECR0sZa4nrg=;
        b=c0ajL3lG7Tfx2mB+vsh+6ReY1Ol6ndXs2v9CEVkGW9uP545ncgF6/6e0hwbYc8GsDF
         +BWLOoi9YDguZclQp/rnmkxRI4svUxuUbumiT6j0ZZT86ow7P8vHuEkH+w53UlhEfvVj
         ktQYgx5YDGMAqeMjv+t3kt+tq91GVwSVqP07Upeu+dHjW9oJ6A7L/f8P7B/Uog/hlvBc
         uOklDsvRJQUevk1viflVdUbVBr3GcI85qn1LYplfRg7zZM9GxUT1oLxzbVn51pLaGQnk
         /XeCIK2veswgv58Z5kGWNM3XUJBc5NRxFyNoiharTANjVeLg2xkc0YZ3WubyiL97IALJ
         pQ1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792571516; x=1793176316;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EXuyqgfiF9x7HO7+fbFxeGIrd5nFUV6QECR0sZa4nrg=;
        b=Y0J+ZwshopnKtiX5hOwbks09x+ki/mxJUMnsszMc73Y6pdQecXEaDYOxhSh46x4sfg
         CqsiMLAyb1dth7i++QUBM2cEnyFp7ZhThuZ3RmnRqLLsGJRXqjqK6hWO0HcGZ4P2McZt
         GE1UZnpo9jQx1m8aiyzo2QPAzmhU1AbwJ2xFh+2SMFHSvxxzFkChlmoUGCCE8xi4taK6
         nQpRDCLT3XQiLBMStLAWAS4FbPlzV87k+Qsh7MuFXAWW5f2zZsIwVLlT/WeogdKatzq2
         r3UDqT7L4fURmtnGeevzIKEWyS2KO8uuwqyKPOtLUmjC3pTUq4o2yHksQcI0iRnwfpCj
         9IPg==
X-Forwarded-Encrypted: i=1; AKwUvByK47o9MTl60YI499nDiARy+Epnyvyk5SDwRSxXcap5KRvJidDPXygKg4XoKuhqW7/s906WLg==@lists.linux.dev
X-Gm-Message-State: AFq9FYL68nwzwQscX15jiA/HcjqOQpENFUMN7NRjpvx7O5BZsG6wS3gr
	AM7aPLFiSEn06iKTtq+AY/xliDui126cqw7k9AoMvbKcm50GpkYBMRw2
X-Gm-Gg: AYBFou0dN6puKbpKpryJlbOjvCnLfnVelLFWSk1SBQlex/MmMuRq1a7Tr2UQyi+j/BC
	d6TAFmbHcHYRdsxKqJdR/uwBhgaTQtrQj8sD23M+uxt9/B1cFC49xSK4wM1MFTcKpjLZU+JWnZu
	k2JaYGw2dgsBUuIhVeQhFyWgaiMmTxXJ4+7tF2Hhk9fakZl0mdSv+U1khjhl85vdBQXAd+ZrIr4
	CSPoMkj1dgiQ7nwFg7ovJJO3mfT6F2hFdz0lyHGCmNa4hfKo6Hb9ulLnrbimVQ0FzDpeV908W5B
	gVvqOfvYkoQiOzE9As8WiOIP8Odx6aH2QeJowv3za7FbLiF1qj23Sc+OAEvIdWHAtqAbqnRHsSj
	7eOG9tvAzaRQIDY0IJhNjPxoOOYsflm6V1g/ZcTnTJa+6YQ0GKeAmQXqu+lcBad4I8k5rpzEwrZ
	1PdVOoqgehrsSLTSt40C9pg3oMCNov5pugLHT1kI1cyYS2vOl9IDEbrgZBt+ENpeY6lj12Nz3e0
	lqDXlmP1tlRecu6Z/l4TOWYsD1xbsOVGdz6RCXVnLAP0D2T7FvZMglW7/kB+u+9GNXNKQ==
X-Received: by 2002:a05:6a00:21d5:b0:876:194e:b8fe with SMTP id d2e1a72fcca58-8a089de73admr1183835b3a.26.1792571515803;
        Wed, 21 Oct 2026 01:31:55 -0700 (PDT)
Received: from intel.company.local ([122.11.210.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a0895e273bsm600653b3a.41.2026.10.21.01.31.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 01:31:54 -0700 (PDT)
From: Wandun Chen <chenwandun1@gmail.com>
To: robh@kernel.org,
	baoquan.he@linux.dev,
	rppt@kernel.org,
	m.szyprowski@samsung.com
Cc: catalin.marinas@arm.com,
	will@kernel.org,
	mark.rutland@arm.com,
	chenhuacai@kernel.org,
	kernel@xen0n.name,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	tglx@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	saravanak@kernel.org,
	akpm@linux-foundation.org,
	pasha.tatashin@soleen.com,
	pratyush@kernel.org,
	ruirui.yang@linux.dev,
	robin.murphy@arm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	kexec@lists.infradead.org,
	linux-mm@kvack.org,
	iommu@lists.linux.dev
Subject: [PATCH v9 6/8] of: reserved_mem: add dumpable flag to opt-in vmcore
Date: Wed, 21 Oct 2026 16:30:09 +0800
Message-ID: <20261021083011.2170525-7-chenwandun1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261021083011.2170525-1-chenwandun1@gmail.com>
References: <20261021083011.2170525-1-chenwandun1@gmail.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wandun Chen <chenwandun@lixiang.com>

Add a 'dumpable' flag to struct reserved_mem to decide whether a
reserved area should be included in the kdump vmcore. Non-dumpable
regions are later marked MEMBLOCK_NODUMP; the filtering itself happens
in memblock, keeping the arch kdump code independent of the DT API.

Most reserved regions are owned by devices and do not contain data
useful for kernel crash analysis, so dumpable default to false.
Reusable CMA regions are different: their pages are handed back to the
buddy allocator and may contain key data for crash analysis, so set
dumpable to true in rmem_cma_setup().

Suggested-by: Rob Herring <robh@kernel.org>
Signed-off-by: Wandun Chen <chenwandun@lixiang.com>
Tested-by: Meijing Zhao <zhaomeijing@lixiang.com>
Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
---
 include/linux/of_reserved_mem.h | 1 +
 kernel/dma/contiguous.c         | 1 +
 2 files changed, 2 insertions(+)

diff --git a/include/linux/of_reserved_mem.h b/include/linux/of_reserved_mem.h
index 49da515859f2..99c0f3ccc297 100644
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
index 90937dc7c627..d7bfc38ac762 100644
--- a/kernel/dma/contiguous.c
+++ b/kernel/dma/contiguous.c
@@ -567,6 +567,7 @@ static int __init rmem_cma_setup(unsigned long node, struct reserved_mem *rmem)
 		dma_contiguous_default_area = cma;
 
 	rmem->priv = cma;
+	rmem->dumpable = true;
 
 	pr_info("Reserved memory: created CMA memory pool at %pa, size %ld MiB\n",
 		&rmem->base, (unsigned long)rmem->size / SZ_1M);
-- 
2.43.0

