Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F218264602
	for <iommu@lists.linux.dev>; Wed, 26 Nov 2025 11:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764157277; cv=none; b=Nl//aGEqjjyTn4Pwyu4FwlaL0wHDyULPJ0yCZ1lY4E4FCjQJnUnY9vcGbFpEsLZ8P+aKMmOxDBuPXzbeNGUW8IrxBInO7fPqhDrR0DQGjHMazt2mBsA/eNvRD3wd2zKfjbigZD1lDbbDxtyJv/M5GL+gKhNfCLvk4Bo4k9bSLfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764157277; c=relaxed/simple;
	bh=s58FSaivnOn/XkWsDs6QSr+yJK5Lt/JIVFxm+BHBJnE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=IZBqrggHN9DhXfIdjDaMH74qEJhLLCGsPjZuxq0fSXqrJU/HAl5fPMKh/SdpouYIArgsGqIcjTvaI+Qh/ZjrcSrnJ49RUKLXJPibil1y92wCB2+zLGj8GaMwrjpDgcoxR567CrsC1pOpPdJ4pF8XtqgAWowrzDPAyCFdMZwkGDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yopLrQy9; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yopLrQy9"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-34176460924so5652478a91.3
        for <iommu@lists.linux.dev>; Wed, 26 Nov 2025 03:41:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764157276; x=1764762076; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=u/D6La18D7tfn+oDIMQbXBTv2i70gpQtEaxWg2HWqPE=;
        b=yopLrQy9MX6XRJrWkN66jbv2dIiUmeHc9mkcLkH3PC/MTaBFKCz1rhk/ze9G41OjHI
         gbChZzXYW69zU/2UMbHolL8b41RNwp96ggzP/asgSTtPcbC9C7MqartQxJ2AJOMklnzl
         qwqs1xNTTq3bpoaMLInEBrpR7wfvHm6am/D9+iBbN7h8jnuHzXNTGma7YGa8XAquG/Vq
         p/BVCZDYEkiCMJ1it4xIQPc0ea97tydNveivzvbwdMMf1WdndXymD/ErmED9N8Xelp0D
         fAb889hE1wmy7gF50dU+khLJEHB7WlOOGsbfBM84sRQH1nPcg5flt5gnROQa1+E3FMfh
         w2YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764157276; x=1764762076;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u/D6La18D7tfn+oDIMQbXBTv2i70gpQtEaxWg2HWqPE=;
        b=qHHjmIRHx/Btb1tbNbAkGJNZdwdJCILMh2c0l6UkU9kasA7tud3g89JDaGeWjWX8Ui
         FlekJOVC0DtZOdE0W4Xkp8ZGUv6GEjIN9v+GzYou8JPPuujMt0Rv8ml67sEnlvisH6te
         R4XN5C0zYSc6cG1w9dg+vPxogXatalacn7KXwMFqrUHnMmukeFVSOnuIJsIZUGnPj25k
         mDd1BEfLdAuZZeJVWQ0RU9ZYuBQi79MaRZEDpqIYY7GWw8ghvzmTNra87nRdMQ0UCkxW
         2KBBSyDTjQNdkljCrkE9a/a6gGN+jtWVSrvUPoA+UuRlblCOxztwYVeFo6FpkAi56LuW
         NWIA==
X-Gm-Message-State: AOJu0YxvVUkgOgzPGx+ghbwZVu8Z+JgkQeSsU2GF5vq9jmzkvS+jozD8
	LFJFeUH0nVzgJnUwTN7dycSJFaUn00L/iLiGWEWnRA6otibuIEyRlqaCrUm+bnkxTLCT5RmWXv1
	CxjmLX7sj3/rqf8kKGbqXbq6Q6n15dwiWUHwDY5I0YhxsOTjH6QHXcD+xYkxn56+iz+2dx0h213
	mifXjD8gLJmn9mE8LeMfDvil1nKYuLzQ==
X-Google-Smtp-Source: AGHT+IEXMwtKEendwo/Z2E9I6d+ZSwSu3nr3oY7s7PCF47HbVR3Vf2ytkLXapK5jVKfMBkucUePjF9PjTQ==
X-Received: from pjkv8.prod.google.com ([2002:a17:90a:7788:b0:343:5259:2292])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4ec7:b0:341:88d5:a74e
 with SMTP id 98e67ed59e1d1-34733f4ac35mr16817423a91.29.1764157275278; Wed, 26
 Nov 2025 03:41:15 -0800 (PST)
Date: Wed, 26 Nov 2025 11:41:12 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.487.g5c8c507ade-goog
Message-ID: <20251126114112.3694469-1-praan@google.com>
Subject: [PATCH] dma-direct: Fix missing sg_dma_len assignment in P2PDMA bus mappings
From: Pranjal Shrivastava <praan@google.com>
To: iommu@lists.linux.dev
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, 
	Christoph Hellwig <hch@lst.de>, Leon Romanovsky <leon@kernel.org>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Logan Gunthorpe <logang@deltatee.com>, Will Deacon <will@kernel.org>, 
	Shivaji Kant <shivajikant@google.com>, Pranjal Shrivastava <praan@google.com>, 
	Jacob Moroni <jmoroni@google.com>
Content-Type: text/plain; charset="UTF-8"

Prior to commit a25e7962db0d7 ("PCI/P2PDMA: Refactor the p2pdma mapping
helpers"), P2P segments were mapped using the pci_p2pdma_map_segment()
helper. This helper was responsible for populating sg->dma_address,
marking the bus address, and also setting sg_dma_len(sg).

The refactor[1] removed this helper and moved the mapping logic directly
into the callers. While iommu_dma_map_sg() was correctly updated to set
the length in the new flow, it was missed in dma_direct_map_sg().

Thus, in dma_direct_map_sg(), the PCI_P2PDMA_MAP_BUS_ADDR case sets the
dma_address and marks the segment, but immediately executes 'continue',
which causes the loop to skip the standard assignment logic at the end:

    sg_dma_len(sg) = sg->length;

As a result, when CONFIG_NEED_SG_DMA_LENGTH is enabled, the dma_length
field remains uninitialized (zero) for P2P bus address mappings. This
breaks upper-layer drivers (for e.g. RDMA/IB) that rely on sg_dma_len()
to determine the transfer size.

Fix this by explicitly setting the DMA length in the
PCI_P2PDMA_MAP_BUS_ADDR case before continuing to the next scatterlist
entry.

Fixes: a25e7962db0d7 ("PCI/P2PDMA: Refactor the p2pdma mapping helpers")
Reported-by: Jacob Moroni <jmoroni@google.com>
Signed-off-by: Pranjal Shrivastava <praan@google.com>

[1]
https://lore.kernel.org/all/ac14a0e94355bf898de65d023ccf8a2ad22a3ece.1746424934.git.leon@kernel.org/
---
 kernel/dma/direct.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 1f9ee9759426..f973e7e73c90 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -481,6 +481,7 @@ int dma_direct_map_sg(struct device *dev, struct scatterlist *sgl, int nents,
 		case PCI_P2PDMA_MAP_BUS_ADDR:
 			sg->dma_address = pci_p2pdma_bus_addr_map(&p2pdma_state,
 					sg_phys(sg));
+			sg_dma_len(sg) = sg->length;
 			sg_dma_mark_bus_address(sg);
 			continue;
 		default:
-- 
2.52.0.487.g5c8c507ade-goog

