Received: from mail-pj2-f5.google.com (mail-pj2-f5.google.com [74.125.227.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185B55304CA
	for <iommu@lists.linux.dev>; Tue, 22 Sep 2026 08:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790066678; cv=none; b=BJIILclp/qpZ8Pyeeozvsg6YHneIzuU06Tmc3TfYFRyAp5pi8g0honhr6Rg3wVhFl0RPEYmcZIjCZ8ELEmInb1v7jgRoEM6vXtxnojOHqDyTj7uQrrfSDcZF1Qf1SVxLvCR2DYw9P8Klb98ZebeKMXefIooRKIP8kn73TQJulxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790066678; c=relaxed/simple;
	bh=A4RBzJL9im7c/Ccl2wKHTfjmKax8oE4qb4M8Jusp82s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X5Ml9V1RlYQ3l9/k2JxhzHUkbN9Srd7ZgJldAvaOWfUKf97Yo4bnf4R2cawVakC8T2H9I8AaQ4O9g91qbqA5qpjd92KBfITQXhFCwKSza5YZ4sm0mYWCz4t2dG6yLz85OvgyFB+jIPG9BIoYuWLqyFCJ+e77vP6Imv8HKZ04ix4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qhaWmpmT; arc=none smtp.client-ip=74.125.227.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qhaWmpmT"
Received: by mail-pj2-f5.google.com with SMTP id d9443c01a7336-2d6fbdc8772so22919365ad.0
        for <iommu@lists.linux.dev>; Tue, 22 Sep 2026 01:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790066676; x=1790671476; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JU/OT6l28quZrPrYfN7XUOSpOrASPsDzS2PQ3ztfmsA=;
        b=qhaWmpmTSEm+pS5cBwbsVaUC5VObVXG+uCF5+sduErtbm3+krTXae5YpBGpTvz5BvS
         PS3k0CRuKqKKJU3lx1nbSs6WazxSmcjbRVwzIze7cnyiIpMQlgPuOug+bxgDiyJudAe5
         hVjlOaIAsVDCB/zVcCkSKMeukadN1r8iu/sJyBRxthgYk1Oq+Dto67o9fvYQUEnrtVVW
         iQ6lIAIPVXA66Go3ZZVGCxSFXsC20CueXmFtbM2N/Rs9pmDGdSdjPWBjdp+W9Nseqhsm
         cfbkKwMFB0QjS70nV4dDuGqA4Tg6jI02INqT926JqfaHabQ9d+fSxA1czI78ripODx81
         6Sng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790066676; x=1790671476;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JU/OT6l28quZrPrYfN7XUOSpOrASPsDzS2PQ3ztfmsA=;
        b=AJKYMmxLdaENn4dIRyfajLQ+a/Xz0yws1Y7NZjTXR0KEYnuJ6YmDRT1tYV8q55KYXB
         A28Y/9cIO2uAZWeQxyXR/jdDsRbzOPOMU7Vbdunz+nD0fKrkBOPbjdLR2ysKeQtjS351
         ckwH57F/v638SKMuqAo6TmvN9kDp4tdJGL5BEdWltCaXa6AUzo3s/biN6PggBlMyxwMx
         TBzmIWZ/rMHfd4zC9D0kLEmc3/uw3bTrIe00xE717U0CSRstppJ3Z3N77K+evcE3OB8t
         dHBIp0EjGHMhfn6LQ7d1Cvn5BaRUKtBvA9gFdXGiHSu+ujDYLKRVxUbRh07o+uPMHUgm
         gCFw==
X-Forwarded-Encrypted: i=1; AKwUvBztDhMX22JbFptk+dS0G1dkQEf5Su55YeuiY5q2iRTXUztNRtckZrUCBkz7DPqoJd97D1M7gw==@lists.linux.dev
X-Gm-Message-State: AFuF++mldEPagpecDp6MPi6X1yHPFbKBBvWPgr8oAOl3j8qZJcHAv1Hv
	4lQlsvIj0xjGeDNSJNB1YyN5bhtZ0h9NV87/D7TNOsi/rXD1bbW+zpWh
X-Gm-Gg: AYBFou3NefARgPLsXmYj4bee0ADNVWD65Elx9aIhzDRw13WhAUmhxMR8k5LCafcMdoh
	IaA6JgFCS/Dq/d3X9EMOmB/UfNCMJjcdNVxKJKAG5N5NUV8+Vgz8MvFkU8MMJ8nyiorr91lupm7
	862SMh2dhmCNysmAjHCl4aHHMn2OnwGXunWWjrCl8+TV40env6hGk9HE5ESqdkmuwSZqL6nCtly
	bHlR+uLLH8Lwid9TRMmwP8cpWeYK1VimCKIaMlfCphfotRL3iW+BQg6wYGCR2clAfkeHfRtNT6j
	yeewrnRJGGywNhrMvjCIdn1GIm84jl6TlqOBgLUSHY0Q8RM1+RZUC6/iJUYkHvrSH/JkzSCOGgg
	4VSh34TSgXC8AHvKdY0HeBynS9Z+K3FsFhPuT/A6JQiQQa4/fxQwVBIEK99jRqv9tQeVntSOkJV
	GzRllnC9KqmJ3baAifH9k4gNC/o2K9udiydlOjY28n9U31c+r8LohHgEtujCwy+Qrddtb8osZ2u
	w/NLoO+3GE=
X-Received: by 2002:a17:90b:5408:b0:39e:6a81:f34d with SMTP id 98e67ed59e1d1-3a07320077dmr483552a91.39.1790066676289;
        Tue, 22 Sep 2026 01:44:36 -0700 (PDT)
Received: from intel.company.local ([122.11.210.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0674a5ae4sm3670016a91.12.2026.09.22.01.44.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 01:44:34 -0700 (PDT)
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
Subject: [PATCH v7 7/9] of: reserved_mem: mark /reserved-memory entries with MEMBLOCK_NODUMP
Date: Tue, 22 Sep 2026 16:42:54 +0800
Message-ID: <20260922084256.1515554-8-chenwandun1@gmail.com>
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

Mark non-dumpable reserved-memory regions with MEMBLOCK_NODUMP so
kdump can omit them from the vmcore.

The marking is guarded by CONFIG_CRASH_DUMP so non-kdump kernels do not
pay the cost of splitting memblock.memory entries at NODUMP boundaries.

Signed-off-by: Wandun Chen <chenwandun@lixiang.com>
Tested-by: Meijing Zhao <zhaomeijing@lixiang.com>
Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
 drivers/of/fdt.c             |  1 +
 drivers/of/of_private.h      |  1 +
 drivers/of/of_reserved_mem.c | 15 +++++++++++++++
 3 files changed, 17 insertions(+)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index a64afc3ded3d..286fd4db6312 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -1285,6 +1285,7 @@ void __init unflatten_device_tree(void)
 
 	/* Save the statically-placed regions in the reserved_mem array */
 	fdt_scan_reserved_mem_late();
+	fdt_mark_reserve_mem_nodump();
 
 	/* Populate an empty root node when bootloader doesn't provide one */
 	if (!fdt) {
diff --git a/drivers/of/of_private.h b/drivers/of/of_private.h
index 0ae16da066e2..505735732c13 100644
--- a/drivers/of/of_private.h
+++ b/drivers/of/of_private.h
@@ -187,6 +187,7 @@ static inline struct device_node *__of_get_dma_parent(const struct device_node *
 
 int fdt_scan_reserved_mem(void);
 void __init fdt_scan_reserved_mem_late(void);
+void __init fdt_mark_reserve_mem_nodump(void);
 
 bool of_fdt_device_is_available(const void *blob, unsigned long node);
 
diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
index 8c9d6395d6a3..f29a07e8fb23 100644
--- a/drivers/of/of_reserved_mem.c
+++ b/drivers/of/of_reserved_mem.c
@@ -677,6 +677,21 @@ static void __init fdt_init_reserved_mem_node(unsigned long node, const char *un
 	reserved_mem_count++;
 }
 
+void __init fdt_mark_reserve_mem_nodump(void)
+{
+	struct reserved_mem *rmem;
+	int i;
+
+	if (!IS_ENABLED(CONFIG_CRASH_DUMP))
+		return;
+
+	for (i = 0; i < reserved_mem_count; i++) {
+		rmem = &reserved_mem[i];
+		if (rmem->size && !rmem->dumpable)
+			memblock_mark_nodump(rmem->base, rmem->size);
+	}
+}
+
 struct rmem_assigned_device {
 	struct device *dev;
 	struct reserved_mem *rmem;
-- 
2.43.0

