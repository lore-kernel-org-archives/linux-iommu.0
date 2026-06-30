Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC423E2ADA
	for <iommu@lists.linux.dev>; Tue, 30 Jun 2026 07:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782805675; cv=none; b=jWVhbqwwWC5haIyuIZKdXA/17+//GyuCk8vUyCfKSri4MIMyScMg22yCKpquNJQoqGupUlZskBDhvwdSyoest9N5lA4xHIEl8mc+DHamDUrZGT3XOnrW+WHWhzRHNT6OHpCc0T1h4qPgPmpfoo5+6aTl955lLgcvQxRBrIaAcjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782805675; c=relaxed/simple;
	bh=8OujZebZaWz43d3tSXQeCWPkY+eLKrfLdaC8H8OV1pc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aZz8L7xFSVb0RD37f/NCLVcb+Ca9VKF8ynJqEX6tU4fOuwFnbEmCVqnVf/T6CXgXRDxCXi0y8BeVuquGr7/ByY+C8lyF1avHaFoje/Q5wtmEO5Wy3cf2q2/2YIVclwG95T6YKlIPmFZuEUc7niGc1eLf/nFuMk4LnzaGRbWfQ5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AIcwwV8o; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AIcwwV8o"
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-2c7c61b5292so36994255ad.0
        for <iommu@lists.linux.dev>; Tue, 30 Jun 2026 00:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782805670; x=1783410470; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VoJbo79rUg5zjWEB3QBIDp68NPxVQaL4/r71+zofbTM=;
        b=AIcwwV8oIb59SY7BSvr0NR4LgllRE21RwB5ZkTOZ9G5ehXu+izHIKbMrH5qX8EDHA6
         2XYQivHkOM4Dr0XKOZJEsHmxCRtuNrDuJW0e2gc6enjNAITrbc2Yw2xFYdvzJluaIHnr
         XN1U4Ka0h4N60qUYw/wbXoVoChBr7LG80p25aLjtDNVdZH6iG9KQsLxPqO9XQdhGCpqM
         Nx1dvmlefSxkcyxRvOGBin9Q3HilGXYxZQtiXi7vENUH+GpMJrXBfn/AuroWdedr76G8
         nvk54vYWUeCJs9DM9J+FLkbO0ejRg1ZZFOJhngdcQ3lrgrfjEDJj3pIWe+Nq0i9paImz
         pMMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782805670; x=1783410470;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VoJbo79rUg5zjWEB3QBIDp68NPxVQaL4/r71+zofbTM=;
        b=Cyttcrw4JHYfi5Isge4/2OKtwbbhkNppTveo5JYfyLvKPiNyhpxtKFv6EZrpgzt1IC
         aqJrfA0L5t7s951mCpUoRyenYmfBfNsgmk62kv/XEgVnaDqIQdxVhNMqxQmhbkvof58t
         dAEoPpxREmF8TPpVYQGUXvzlNUOhO5WvhxyOhunX+jWGd7WfkD+4ELO5kboC912isapK
         colnemLuBmm4jaC9RRUI0lvjpSvXBPCnTZQ9mxIvi3+nz0QmHSROFaiIKbd9+ICIU44y
         vQcZEY3prhlPTomCEEyD/4DXSr38+DZ0X1DMknU3MBMeVtgDmyRIrnmKPS6DNKwzPcSG
         egCQ==
X-Forwarded-Encrypted: i=1; AHgh+Rri5tcNiMxiLUV6ldYGn9uNzkiaz29vI8/4HJpXYuyd3y31YE1m4w1xxuP98KXQXfyuq8qT9w==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw3kcvtMpeOVwIqbMOVLzCBtBqtHB7lsLFGWPsfZP2ex0OeqWZR
	MNbdYo+9/+LrYP51i6nW1kb9qMuq8uEKCb2TP5pr7UXLrdECu77Krhck
X-Gm-Gg: AfdE7ckim2muT7ZMO5J/kMMia4rLM05tsDQGgMY9RlTChA9bjvFZkHKjOiAKIgcUg+H
	pMC14JacEvz0vUHkMHOUJAjId6Iz9e6xQNOZtUj9d0I0infXFh2QKVfT61S/7R1qQsBezgScyJj
	806Y4TvHN2aAekWDWBZ33r2UQLO7jSoVLFCZ5oYIKf5O8tAhmSwBt4gBP7M9j79Yyp3QScagO/L
	0hXCFgtpPMY1TNHaejAOtdvMgd5RGZX11HuRmTl3BAQn+KdLVHcI2YPSkp6RlzH8DA3piY14yyt
	eb1k7Nljki8RVyAthzExOsH5wo2mIDvvR8zP+JPesjtmcRvPvEERU+IkFc3Ticr2d5oTYRtLvxW
	IIngFTJIB4u1lGCT+yYilPI4zgDxMyfqFI43R52a+qt45NIOz3PNkOdGhK9/6ofxIqZjhVg1Y7Y
	z07SEgf1t4gOKVVpnjOPxf0itVbA==
X-Received: by 2002:a17:903:41d1:b0:2c9:97a9:209b with SMTP id d9443c01a7336-2ca2ed32417mr20077795ad.47.1782805669781;
        Tue, 30 Jun 2026 00:47:49 -0700 (PDT)
Received: from intel.company.local ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ca382a2d3dsm7821045ad.55.2026.06.30.00.47.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 00:47:49 -0700 (PDT)
From: Wandun Chen <chenwandun1@gmail.com>
To: chenhuacai@kernel.org,
	kernel@xen0n.name,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	robh@kernel.org,
	saravanak@kernel.org,
	bhe@redhat.com,
	rppt@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	kexec@lists.infradead.org,
	iommu@lists.linux.dev,
	zhaomeijing@lixiang.com
Cc: catalin.marinas@arm.com,
	will@kernel.org,
	alex@ghiti.fr,
	akpm@linux-foundation.org,
	pasha.tatashin@soleen.com,
	pratyush@kernel.org,
	ruirui.yang@linux.dev,
	m.szyprowski@samsung.com,
	robin.murphy@arm.com
Subject: [PATCH v4 02/10] of: reserved_mem: dedup and relocate reserved-memory messages
Date: Tue, 30 Jun 2026 15:47:06 +0800
Message-ID: <20260630074715.4126796-3-chenwandun1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260630074715.4126796-1-chenwandun1@gmail.com>
References: <20260630074715.4126796-1-chenwandun1@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wandun Chen <chenwandun@lixiang.com>

In both fdt_scan_reserved_mem and fdt_scan_reserved_mem_late, there
are identical check-related print messages. Consolidate these messages
by moving them all into the fdt_scan_reserved_mem function.

No functional change.

Signed-off-by: Wandun Chen <chenwandun@lixiang.com>
---
 drivers/of/of_reserved_mem.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
index 82222bd45ac6..42649dc3613f 100644
--- a/drivers/of/of_reserved_mem.c
+++ b/drivers/of/of_reserved_mem.c
@@ -270,19 +270,15 @@ void __init fdt_scan_reserved_mem_late(void)
 		return;
 
 	node = fdt_path_offset(fdt, "/reserved-memory");
-	if (node < 0) {
-		pr_info("Reserved memory: No reserved-memory node in the DT\n");
+	if (node < 0)
 		return;
-	}
 
 	/* Attempt dynamic allocation of a new reserved_mem array */
 	if (alloc_reserved_mem_array())
 		return;
 
-	if (__reserved_mem_check_root(node)) {
-		pr_err("Reserved memory: unsupported node format, ignoring\n");
+	if (__reserved_mem_check_root(node))
 		return;
-	}
 
 	fdt_for_each_subnode(child, fdt, node) {
 		const __be32 *prop;
@@ -337,6 +333,7 @@ int __init fdt_scan_reserved_mem(void)
 
 	node = fdt_path_offset(fdt, "/reserved-memory");
 	if (node < 0) {
+		pr_info("Reserved memory: No reserved-memory node in the DT\n");
 		total_reserved_mem_cnt = 0;
 		return -ENODEV;
 	}
-- 
2.43.0

