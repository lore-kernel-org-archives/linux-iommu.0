Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3504D3B47E3
	for <iommu@lists.linux.dev>; Wed, 20 May 2026 09:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779268773; cv=none; b=j418/dErZyQSQumj6010Qgvr7BkpvVkj1zIwAUUngi0K+/qfeoMilGKvpWECfgw7zlTAT6VTseRyd8ZWjXdHH+7MI5I0/dPfCfIkEN+RheC4i9R3w5TXl8gfRiiEfzi0zLvLfrdaBjDZOW31Vl+r6vKVfmS8x8i+/mkb88vES44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779268773; c=relaxed/simple;
	bh=25Wos8h+kuVxYdWnXQjvGbC62TvhYYtucbzUo5/jn3s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SjO0MsDk9g25wW9GL2p6Ih+3bWXkg5UAIYtnbJrOb+FgumWngtURi9styIFdsi6hw4oi9o/Nwr0xi321QCPcvAd5uIa8MaNyyGM0nBkmb4N/Zt3RwHld3pQmVsJxwuOtPlCBkjW8jn8Rf15dTGuZLHpRsWSDLb6rpfSsiEEEUAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qVxG9lQ4; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qVxG9lQ4"
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-83659d38e38so1838297b3a.1
        for <iommu@lists.linux.dev>; Wed, 20 May 2026 02:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779268771; x=1779873571; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ciQnv+j7sn9Iwh07+rP7odEwkTvIV/Tmpz7NteXq2I8=;
        b=qVxG9lQ4LQ+JMLm7Zxp7FN69i67NaB9tRfGX35uZmA0tq+mFyEPZKyEpYiyEs7V3Zu
         BqzdOBWq75OW82BQWwcR4/Y/nYWRNjgOeOqQ5sydAO3MF2YPU8+1FPPZiTkeWqH709Sm
         qEIYiXWX+CnirUdWTy3kpb6JCauibrv2YY81C+g2PTzyTP+NgIejQQpZpUbbv0FtFNox
         JL9++KWzr822RsSl7Md+Cm0wcIfE4EAbqua3QfaoZpksevAX+8wS7W2xgIsUa2RMW8IS
         yy3UkvYkaBxITf9Yvv16xSRZZ3CTNu1vZiI7qfuQbrjSTpcMOC/2sEN44bMHpNPRjChw
         x1Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779268771; x=1779873571;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ciQnv+j7sn9Iwh07+rP7odEwkTvIV/Tmpz7NteXq2I8=;
        b=R/GJI9Cny6oPQ96LSjGHhaiVrqLrpCO/6kpqB22QhTAksB4IcWs6fUuOD++1qdpL7Z
         2O49MndWKIZoEAuLjefTvyBm7jSH3FmqSWjpWlRsMuEpsvmXaCHG6ZvFablyl0r0fmAd
         SINQMAAuNCSA9abflO4Cpj7pcsSyCwXi0DgGvhGFyMpmVjrd0dYIxUoP7lvZZuoHghBx
         Fw36544/aFeF3eFdgNHjlxB8PDeVUDXrh7+cGTXSvBJ7N7PSaHoRAeMRf7quudeIoxCP
         aZ6bR0r7TiF0qb5QPKUP96nJ1PAu05WnQfCT6Ya1OOQMCMBcbWvVvTzzkDI0Y8uQztg0
         1mUA==
X-Forwarded-Encrypted: i=1; AFNElJ/y3yDCfvf4sLmvCvdK6vVocIKoIVIciq16JwrkQZOO9Q+nu77pgD6K+ahVDMwxhCa3UCgrRA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz6J6TrxGCmtN+iyM5kJyiwEJKoWg3qpfXBFfuRQRL/Po1wOFOj
	h3Z4TKaBrKLRton7g1MWz7oMGxIEkhx1jHwdO0dWulOdd9Dl0517zL0x
X-Gm-Gg: Acq92OGf02dU3HfOGn0ql9+2pH/RmJKbRO/OpZZNK1mTATjeXgn/7FaPWq3JWugXt23
	3ZCoLCwDvvftG4FOGcob5P2iNU/XMKFfqj/brl2spJxtxcMXlJqRpDMO5IJ1lmG2hXY6Rob2x46
	1xfG1B6xFrI791yuleLsIQEJAfI3N+QgQTqmQRzN2REJD4OnRpwr41xrwE00vuNffbAbQHSxnuv
	0UIN37kkSl7N5HaxxjYlIdAYVmEMGsWQ43i8W9SMqHwHdIV/Q48SX/QkQPyQdoyOAAr5/Wi03nX
	gT1Lynh/t12/MtCxl6ZR+yOamht+eK7PzXJ+Gsa1/fhb1+i0ZiyzvvmckJqR5dpxzMJXhe3Mrzr
	AQiLLEC4+2TKZAdw+PfygaKYOTu33HhjwP3VPhp82FrasE3E699DJ++eYzNDrFm52ZZCzbWMEYl
	1bQS7l+4oZ4+GcGO9TUOuCUULapmWslUKbLTRgkRvkup3G8djo
X-Received: by 2002:a05:6a00:90aa:b0:829:8c08:d1f4 with SMTP id d2e1a72fcca58-83f33ccd856mr24019073b3a.39.1779268771454;
        Wed, 20 May 2026 02:19:31 -0700 (PDT)
Received: from intel.company.local ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f63bb986dsm10208967b3a.48.2026.05.20.02.19.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 02:19:30 -0700 (PDT)
From: Wandun Chen <chenwandun1@gmail.com>
X-Google-Original-From: Wandun Chen <chenwandun@lixiang.com>
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
	leitao@debian.org,
	kees@kernel.org,
	coxu@redhat.com,
	tangyouling@kylinos.cn,
	songshuaishuai@tinylab.org
Subject: [PATCH v2 3/8] of: reserved_mem: add dumpable flag to opt-in vmcore
Date: Wed, 20 May 2026 17:18:39 +0800
Message-ID: <20260520091844.592753-4-chenwandun@lixiang.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260520091844.592753-1-chenwandun@lixiang.com>
References: <20260520091844.592753-1-chenwandun@lixiang.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wandun Chen <chenwandun1@gmail.com>

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

