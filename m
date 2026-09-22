Received: from mail-pj2-f7.google.com (mail-pj2-f7.google.com [74.125.227.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800B95304B4
	for <iommu@lists.linux.dev>; Tue, 22 Sep 2026 08:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790066663; cv=none; b=YfCZTISMEy7rxapHGbvUpLCyFyC/BNZkqQNS14vQdpXLuWDMr8l/9h+HcukD/ETSS4rh85rF9bWGl1VFsTPjxi2J/fkYkfRBcM3RSt9/lC41RD8eqTFgsVEk0YLeU84IsbNypy9EjeOi+SmrrI5i8GmivwwDiijIsFN6NGOKKSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790066663; c=relaxed/simple;
	bh=xXXTEawloLm41fSAr5nA62b6IMDJx8mcRGgEviHUn7w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mXPOMWqy+/GTpD+BjMzVMI1qpnF01Ksdjsdrd5DT6B1wskQeZg/6p8m1yvWhC6L7W2IAbN3YHcmxyXOHodXWd6n5uz1VBDD28IGuxIFlqQearnIzlsqjh2H9Q93vYzXQap0h1rl5WAQ5/XJIkQEjFhQ5gdu27mw2uJZ2WU5Kr5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LQREKB1S; arc=none smtp.client-ip=74.125.227.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LQREKB1S"
Received: by mail-pj2-f7.google.com with SMTP id 98e67ed59e1d1-398da2bdcb9so1798361a91.0
        for <iommu@lists.linux.dev>; Tue, 22 Sep 2026 01:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790066662; x=1790671462; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=S7DrDy5k1cF63oZDGZmuZpMhR9CRSHaszqjBOE8wOFU=;
        b=LQREKB1SW274lItQhO5h1pM6EkKGqcaFCNt2ZuxTbgH7ljWdi/wTorlCERTdBwDkTr
         +FlcBggitQTw843mhwN23xdhw73m2attKv+0LoKqEh/7fr+3ITGTL4LZr2EDXJao+Tjl
         ZxglqgERgftkvFNbeLjotFPG/FAJen5F693AQfcpmmxk3ysAwKLkziEJEtUYoLUaCDfa
         ft+jkw+tbTMRM0K4/aDQqYYhfE80uelFbTItp7rtIfVv08o4Bd43UjcdPvQOMc/mLVGm
         BOpde+WAcLcTZ9aAzExps2dkz9guuLznf+59V7cjI05VkphYqE0GlUU9H5hgHDyZt5Qk
         qLCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790066662; x=1790671462;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=S7DrDy5k1cF63oZDGZmuZpMhR9CRSHaszqjBOE8wOFU=;
        b=q9hZVs/eo5Op/mJwepsVPWKmHr4kpMx+dbx8Dzg8xUtSD8PkvX2BpL+WjUy9xElIq4
         GwtfvVuZOHrO944ZrFD2CD2Ny9MDGGQZ9cL8Bm9dRIExhbXGQZ9v3fwOpu6iumVgrHBf
         0mVIyF1C4eV8OiD5IEaQtFnMbWtFC0m9hXtqxkdh8oJi5WJo4vaQNZejwDSPOJpz4efE
         XeTDlw+p7DIswLS8wz2yOlCSEMeniXi0O2XLfYVbZKYbxzGUBd/CegMLBkpvpRCwDmKQ
         zesOtnF0fB/R2EaoizLetVEt1NDFvHNGiYLWOomgU9LSWQjMYSH7KNSifhKe8Hj1LLhg
         8IFQ==
X-Forwarded-Encrypted: i=1; AKwUvBwM0XPFMAW/zzeeF2i7ShYh2GS6baQij52sRsYwqZJIW/YmaJhYAGQHlddXybEPiorRQwhZlA==@lists.linux.dev
X-Gm-Message-State: AFuF++kkA+eivZvjqadB2R1nQkRdX887FKWttpFsJWw6sZ+Q7OBSpPAG
	XBLDf1UAo3dChwWM5UJI1QCcXcbdsKPVs5L7HmpWeyuI4BBTRLRWUNQa
X-Gm-Gg: AYBFou2USEOW3S7Kyxrf+mtEivyWhh+oj8LX/wVVjMPVULwCSFFWW6Tz9PwuSNf/e9y
	2jKAnVjOc8Qz51TbJvVB4W6ri5okQhr8YrfZB2P5CcckrQUSiFRyYeF5AvkG2esyw35uJWEW7ul
	tkz7caNKnkU1VJPk7eakmQASu40b3naJK+APVF/eHsAU5kFysI7ro44ycsUoG7/M86kK3ewbBL3
	VeEIPkj5iVUcjIQsJzxcMbAmuWf7ViD8mAHQf8kSg2AEC+U0WFMVtpSvr5RfxMKbwHAXV/eR34j
	bpNC1vzPrPS/LxS3dr+XLWuph4iSPg19kkb2lo1NpgP8cNMjxSlX7ypnZmGtaY7DkGaSBIEIz9Q
	pTWOET3whbfVZNyT0Tr/Pu9gkrZV2dDQwyoZ+YoMKLBaDWf5weZUZdC2BXpc3k2MzIufpDbJQSm
	AShpJ3rb77xKr74Rq3GmsLI/BRE5e2VFGOCarFCQcNtCVifEa1V3nUsH4kaS5t5tQEVJi/iQmBQ
	Fwwwl2c84w=
X-Received: by 2002:a17:90b:2ccb:b0:39e:6a81:c921 with SMTP id 98e67ed59e1d1-3a0731e1df7mr452432a91.20.1790066661956;
        Tue, 22 Sep 2026 01:44:21 -0700 (PDT)
Received: from intel.company.local ([122.11.210.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0674a5ae4sm3670016a91.12.2026.09.22.01.44.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 01:44:21 -0700 (PDT)
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
Subject: [PATCH v7 6/9] of: reserved_mem: add dumpable flag to opt-in vmcore
Date: Tue, 22 Sep 2026 16:42:53 +0800
Message-ID: <20260922084256.1515554-7-chenwandun1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260922084256.1515554-1-chenwandun1@gmail.com>
References: <20260922084256.1515554-1-chenwandun1@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wandun Chen <chenwandun@lixiang.com>

Add a 'dumpable' flag to struct reserved_mem to decide whether a
reserved area should be included in the kdump vmcore. Non-dumpable
regions are later marked MEMBLOCK_NODUMP;the filtering itself happens
in memblock, keeping the arch kdump code independent of the DT API.

Most reserved regions are owned by devices and do not contain data
useful for kernel crash analysis, so dumpable default to false.
Reusable CMA regions are different: their pages are handed back to the
buddy allocator and may contain key data for crash analysis, so set
dumpable to true in rmem_cma_setup().

The dumpable flag is also used to check /memreserve/ entries for overlap
with other dumpable regions.

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

