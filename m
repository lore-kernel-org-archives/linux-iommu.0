Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB5C30AACA
	for <iommu@lists.linux.dev>; Fri, 26 Dec 2025 22:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766789646; cv=none; b=InM7pPK2HAJIqGHoRoXnWGk1DHF4qJNMpajoCrjqvb76dNbpHTL+FAmb4cwrz9i4JEBbcH41e12KLcoq19/14wlsjyHVD5gVKzLwUIWjDJa3IQVCMEvmBX+0A919yJaPGtxaQFjJB9PqZdQ/tsQEqYopkrIfr8E4JQgXg/99IDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766789646; c=relaxed/simple;
	bh=oh176zWXXfoQMYsnxwVsxRFdbjtJrXMltLaE7iC2HWY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fY4c54o75z/rANt18g1EjYILzOhjiBJXlRStYzhcNSPPkQ/N3w6nRDx/2YAQFwpv6zQk2N8qJP+EmN9zt203X+HFHrA1cUgQHK12TZc7Q3QwWkJ8oo9YJ4HX8BrJIM4zBFhKhWLmG7h2OHNbsf5A8lnd0gDbGa+liPMFjKktlYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iZFMebTf; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iZFMebTf"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2a1388cdac3so70187285ad.0
        for <iommu@lists.linux.dev>; Fri, 26 Dec 2025 14:53:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766789637; x=1767394437; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6SwUY+FTc0pZhvaABGOEZvH4DFh2qP62P2nENr8WNe8=;
        b=iZFMebTfMDt48z3R95TUcoBKMLP7aKUohIPN76iHYgzUib6tkRoM99V49QLUHA7o3U
         h3YAP89AW+xngAD0joYp2bZIp4/PpOzzarkLQUCFsYuzDWLaPn4SDuDbpjYiKE2y6voZ
         DsD2X/2iT7BDxqEeP8A7kQeksKNh5HIC5VrYcxHSGtbTyLMDuASFhMY2R6fWPAZJfR+V
         dgNbF4WW13+Xs/ulMdEGN4CmKuoRsLJyZCGPXN36sqQooHLZqp8NomyodR8xHCh/sp3b
         fFSMpi/kok/fBk9licO2YRQQqg0hHImlU/+pTjzLB4bruWm2wPjHq4VUc8CVAtEClp4i
         1huQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766789637; x=1767394437;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6SwUY+FTc0pZhvaABGOEZvH4DFh2qP62P2nENr8WNe8=;
        b=jLkyPMbiy/x8SSDFsUUB5/S+03tjj4JQwtqbG0tXhiEIAoIfZKqPcndvjBSc9nEvzJ
         n91Ag52nPcZIw225bISk/hd6lgURs5n9BY924Uj4jRlU8dK5TMjvECPy+IJnNsF2rgGr
         6Xok2u+WsSi7XITTJBiQdELkK3ySGH1asrjXDTqaTJgCqrjt9SWpMhx+QDzXaYirkqbK
         JK1UT1UqUpkrBCMJXtxHtwJk5puJ2Rw3esXQAqX40BYk37wKuoJew1/bG00EhMf70yvt
         Jb+RXH+bq4z2RQRrZ7o9HxdVRO2kd/9cQk1DDJD3tMxV99azFiucN97UkUYGXl83E9LB
         CgPg==
X-Forwarded-Encrypted: i=1; AJvYcCX72ZbexvX9IpvkiZgQFh2I6M0IHRZeAqmRdBjdMuQIwH5skgPe2npLOcY28utdujch33z4kw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyEoBY1GZOwjkK93L/foryZpQAfUFXmTAYGkPDAwy4ppioawwWj
	fxN6Ym/VBmo4C7ZhkDzq3sfBmJXeUsrZ9X/vgzzLbN5zZBlO24Ky4X+F
X-Gm-Gg: AY/fxX4B9K8oi8vvArJxJ1T6DlTMV26lR+7zRTUyob8ppEu6Bz7rNkHUHQSH8oUPmM5
	7ZplDmsdB5t71g7GkP7o0nMY1GAXSg1jbPLCmUvXekDEMassHM28ONv5OlsPWpD/CS92TxT53LE
	ncCzPStv8lxTLiNmUDGvr+WHIQDFP0dEi+do+JqjlU940DSKNqQGiOPE0o2EUwHhvaE3Q3x0jgt
	GyOfsWvH6j5W8BhuUIA+wcBdO5bi9Ck2TclfHbIOkdsjyLoyEV5f3OxF8w8M8eDdXvSd3iLkXuK
	OXhMOuk9m+uPbh2nKtZotJauGCHvq5Gk6tuM87p5ub/NpwOu8YAZdoiRLEy5bVF3EqDcSzkNI8o
	b7RrZDY6S9MuA9IYAaQ8i0wv4E53AfftORek2snvjy2jojSOAVdT/WxDyWIPqHGrmkvIfpSSnPi
	PiCbxggu0H+E82seTaLMydSJ8=
X-Google-Smtp-Source: AGHT+IHzo7zg63L6IUIixvYNdgE1EhLj43E4LWUqmZi99iaSKAA/lUr+ts9Nayt1nnGWbam/Z3t7Yw==
X-Received: by 2002:a17:903:1670:b0:2a2:bff6:42f2 with SMTP id d9443c01a7336-2a2f222b664mr247962585ad.6.1766789636697;
        Fri, 26 Dec 2025 14:53:56 -0800 (PST)
Received: from barry-desktop.hub ([47.72.129.29])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34e772ac1acsm9981428a91.9.2025.12.26.14.53.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Dec 2025 14:53:55 -0800 (PST)
From: Barry Song <21cnbao@gmail.com>
To: catalin.marinas@arm.com,
	m.szyprowski@samsung.com,
	robin.murphy@arm.com,
	will@kernel.org,
	iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	xen-devel@lists.xenproject.org,
	Barry Song <baohua@kernel.org>,
	Leon Romanovsky <leon@kernel.org>,
	Ada Couprie Diaz <ada.coupriediaz@arm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Tangquan Zheng <zhengtangquan@oppo.com>
Subject: [PATCH v2 5/8] dma-mapping: Support batch mode for dma_direct_sync_sg_for_*
Date: Sat, 27 Dec 2025 11:52:45 +1300
Message-ID: <20251226225254.46197-6-21cnbao@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251226225254.46197-1-21cnbao@gmail.com>
References: <20251226225254.46197-1-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Barry Song <baohua@kernel.org>

Instead of performing a flush per SG entry, issue all cache
operations first and then flush once. This ultimately benefits
__dma_sync_sg_for_cpu() and __dma_sync_sg_for_device().

Cc: Leon Romanovsky <leon@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Ada Couprie Diaz <ada.coupriediaz@arm.com>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Tangquan Zheng <zhengtangquan@oppo.com>
Signed-off-by: Barry Song <baohua@kernel.org>
---
 kernel/dma/direct.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index a219911c7b90..98bacf562ca1 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -402,12 +402,12 @@ void dma_direct_sync_sg_for_device(struct device *dev,
 
 		swiotlb_sync_single_for_device(dev, paddr, sg->length, dir);
 
-		if (!dev_is_dma_coherent(dev)) {
+		if (!dev_is_dma_coherent(dev))
 			arch_sync_dma_for_device(paddr, sg->length,
 					dir);
-			arch_sync_dma_flush();
-		}
 	}
+	if (!dev_is_dma_coherent(dev))
+		arch_sync_dma_flush();
 }
 #endif
 
@@ -423,10 +423,8 @@ void dma_direct_sync_sg_for_cpu(struct device *dev,
 	for_each_sg(sgl, sg, nents, i) {
 		phys_addr_t paddr = dma_to_phys(dev, sg_dma_address(sg));
 
-		if (!dev_is_dma_coherent(dev)) {
+		if (!dev_is_dma_coherent(dev))
 			arch_sync_dma_for_cpu(paddr, sg->length, dir);
-			arch_sync_dma_flush();
-		}
 
 		swiotlb_sync_single_for_cpu(dev, paddr, sg->length, dir);
 
@@ -434,8 +432,10 @@ void dma_direct_sync_sg_for_cpu(struct device *dev,
 			arch_dma_mark_clean(paddr, sg->length);
 	}
 
-	if (!dev_is_dma_coherent(dev))
+	if (!dev_is_dma_coherent(dev)) {
+		arch_sync_dma_flush();
 		arch_sync_dma_for_cpu_all();
+	}
 }
 
 /*
-- 
2.43.0

