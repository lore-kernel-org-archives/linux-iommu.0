Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808E522A4E1
	for <iommu@lists.linux.dev>; Tue,  5 May 2026 00:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777940603; cv=none; b=am4D4tfPGApACY78AGB+hsr0fHsY4vgX3jpIhkj0fQKzlvYS+7jL0e8CduNYENr4bm+86FtxcryHHSmZqfkTXfgvdcpYhXZAPKO/oBn1lF32IOadxT5n/0FONa+FEglQT3b3A1ev+389RW7y/VVfVabGhq90EAMa95s0OTIYSlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777940603; c=relaxed/simple;
	bh=xbhTzoI9Yb8krsLvI17n3/N8clqfBJwRv6mertDyy2k=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Hy0JFHnfObjqPtT4MAW5r++eK2dMvOwwF0zB60KIyKo/kZZbq8pUvslo0mXbqEgSjNpIZ1QiXBUIswE4DNwjoF0p6UhViDJIghQRRLT/6MM21qF5Al/ouuol9rXLRbGRbLGtp9rH6OKRTsxNENMRtWG+6P+pr8Pjxv+R/mrGVgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kFKvAG0D; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kFKvAG0D"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2b79f4b35b7so42806495ad.0
        for <iommu@lists.linux.dev>; Mon, 04 May 2026 17:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777940602; x=1778545402; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=P7hLyOAFb/XotDLSfzs07sOc8bnqFDsHZkne19sPDsE=;
        b=kFKvAG0DcsvshVS6OGQlrQ1xcw4p5bMy3Q9oTlER+9vgOmD/YLTRFEhnWs8o8WB/EC
         AiYyJrR058TW+pNCLb6ivYuDef03/ioUR30h8QReMt28Z1d2cSCY9+15xgMEnn3zcM46
         jeOkRDFje5T/FA/iUkJzk0VfM7hn9j/Q0E44N8I90HUas+2QIdDnVl247Xyt0Fru97vK
         YWUAO1SMHENQq+JtCxv3pQaje64mZfi91FADlgi8UmARYnaZjcyn3fVu1tLqcvui0f9s
         7a1QMJEVvAwzb6QW4qH2+LEFeP/t689vRBbERJAia2qHS4zPMflJ39JzS3/60XYcSJdR
         sFRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777940602; x=1778545402;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P7hLyOAFb/XotDLSfzs07sOc8bnqFDsHZkne19sPDsE=;
        b=L/IQ+7B9qpuT8f8xGqnFHoprklT971AYgp/oUz3t+i15tfWluic8ih3L7LlSfvDzFr
         1shLVgQTqpbiOcDV9p23hZDCaaNsIwJpSv01r5bk7kcqxLW6NRY5lqKKSmG/bQuPqIzl
         bUabpf3Yl07agiNo0eO6W3JYdK5uqcS6qF6ltFNWmS7U3azEwB5TOa9DVqgtdOtKbFyF
         SfDjv7+1erBg70t6mjg/lfmgRmXNUZjvEiRFdfj3w0yHm0Zd+X7uqig+A0KSp6ZVLarJ
         unP77PFVI+u8pYNG8XT140eO42FIYd6DbUJSyl/DoCsuh06q57q2RgW9scxq7tHbtauZ
         2urA==
X-Forwarded-Encrypted: i=1; AFNElJ8pMO/YRNr47sX9IJwWt4B3OrnnHDGdvL2167BWV5eacAm+z1RaiesAVrMISj85UDgol0x/ag==@lists.linux.dev
X-Gm-Message-State: AOJu0YyhdqwFaICKf+NP4IoeYRxkxl6w3x5rxxg1BAO+bfaL1SD5LWws
	16YwmmRR1OslpX5eHYqnOIkc/28Lps5Ia3uDH3CjDpQRvhdeb6PhAFD2zCbriZT/uuXBPnCFK9f
	Vy5HgnSu30vDlvA==
X-Received: from pfr4.prod.google.com ([2002:a05:6a00:94c4:b0:836:55e:c2f])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:6a15:b0:3a2:cf6d:a9f7 with SMTP id adf61e73a8af0-3aa3b75b178mr909398637.36.1777940601569;
 Mon, 04 May 2026 17:23:21 -0700 (PDT)
Date: Tue,  5 May 2026 00:23:16 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260505002320.2210067-1-skhawaja@google.com>
Subject: [RFC PATCH 0/4] dma-mapping: Add preservation of direct allocations
From: Samiullah Khawaja <skhawaja@google.com>
To: Marek Szyprowski <m.szyprowski@samsung.com>, Will Deacon <will@kernel.org>, 
	Jason Gunthorpe <jgg@ziepe.ca>
Cc: Samiullah Khawaja <skhawaja@google.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Mike Rapoport <rppt@kernel.org>, Pratyush Yadav <pratyush@kernel.org>, Alexander Graf <graf@amazon.com>, 
	Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>, iommu@lists.linux.dev, 
	kexec@lists.infradead.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	David Matlack <dmatlack@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Pranjal Shrivastava <praan@google.com>, Vipin Sharma <vipinsh@google.com>
Content-Type: text/plain; charset="UTF-8"

This is an RFC to discuss the preservation of DMA allocations for
devices that are using direct allocation mode. Note preservation here
means preservation of physical memory only using KHO. IOVAs and IOMMU
mappings are out of scope.

The complexity and need of this was discussed in the thread mentioned
below. It was proposed to allow preservation of only a subset of
allocations with minimum support.

https://lore.kernel.org/all/aepfYzkI7NsVGCF0@google.com/
https://lore.kernel.org/all/aepRy7Gp7Ng85Zr7@willie-the-truck/

Note DMA allocation allows allocation from various allocators in various
configurations. This RFC supports preservation with,

- Direct Allocation Only.
- Pages allocated through alloc_page (Buddy allocator).
- No CMA support.
- No DMA allocators.

The changes are also pushed here:
https://github.com/samikhawaja/linux/tree/dma-alloc-preserve-direct

Looking forward to your feedback on this.

Thanks

Samiullah Khawaja (4):
  dma: Add DMA allocation preservation KHO ABI
  dma/pool: Add an API to check if DMA allocation is from pool
  dma-direct: Add API to preserve/restore allocations
  dma-mapping: Add API to preserve/restore DMA allocation

 include/linux/dma-direct.h        |  29 ++++++
 include/linux/dma-map-ops.h       |   1 +
 include/linux/dma-mapping.h       |  50 +++++++++
 include/linux/kho/abi/dma_alloc.h |  30 ++++++
 kernel/dma/Kconfig                |   3 +
 kernel/dma/direct.c               | 163 ++++++++++++++++++++++++++++++
 kernel/dma/mapping.c              |  52 ++++++++++
 kernel/dma/pool.c                 |  13 +++
 8 files changed, 341 insertions(+)
 create mode 100644 include/linux/kho/abi/dma_alloc.h


base-commit: 9974969c14031a097d6b45bcb7a06bb4aa525c40
prerequisite-patch-id: 41f13f37cb3b439f17dfa4e3f2d5c767aaef0346
-- 
2.54.0.545.g6539524ca2-goog

