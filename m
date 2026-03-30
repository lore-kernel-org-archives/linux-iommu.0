Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28FF32572D
	for <iommu@lists.linux.dev>; Mon, 30 Mar 2026 14:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774882295; cv=none; b=h5Mc0YoUyBdwpFiPvvSzHWtRCTvyL2jNr/YtEsH91FOf8EXgDEAOVJZAik0m+ngsXcFuHpgg/sgE9+khRRtaH4M9RWStZaxJy8NwbZc7lIotAvStVhe8UfTYKYZ9eDnF9ApXPejeCC6YPoMcnqw8/GNbCf/WYBBsP43Y6fFKKWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774882295; c=relaxed/simple;
	bh=opY1fUPRtapU04S/fxJwBSImHDWEYci8EXTK7TGZOuw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hAKWj8ML2g6dF5q6u5w+o6B0a6zDMLp74ORJypZAXcsnzoCmxS9DVGRComQdUzYXiTUbtKTmOox6Ab+qnzHXz508M0dsYJC6CrnnwVUCO323kidEpT7N/bGeVR4ndmRwj8QxcjvDwnW2Nw+Xi2Q2APFJURXOIqTFx5gKwyDdOK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HsifSUE5; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HsifSUE5"
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-43cff5ef652so716326f8f.2
        for <iommu@lists.linux.dev>; Mon, 30 Mar 2026 07:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774882292; x=1775487092; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BX6TQo3VfBDX89+YXqbdRt16ZmxOEjXJvCtPOwdDiyI=;
        b=HsifSUE50dx05byk//0M9BipN9Svu1eubi4Pe2WqfhecZeXsYaMyxtY9sh5orlrsYo
         hmCJs2NDvoPxZbg0zbzc1CAlVIjAZR5qKT6sCIcv/JydmTHQRxtO6R3gT6R32K/SZimS
         UnKV5zuccjsv0R+wmHDyVQo84MSKcund1nC5kYTA/6C33yP4C05WzG5TEKGnZUw+NuZv
         f5DLeN5ahDMIgRWHVyRvPk6Okd8VsXAFCuLXjyzkw3Ek7DaK70iFxc7Yu3mJfMEJFMjm
         vDn7mVoNhQbPbLYjLvusebXrt795UywMungJLBe1wJpAJhDmzDD1ev38qK1LlSgJQEF/
         twKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774882292; x=1775487092;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BX6TQo3VfBDX89+YXqbdRt16ZmxOEjXJvCtPOwdDiyI=;
        b=BC4q9VoGvc6lpqGIVDIvT8j04ccPtzy6ZPCJATdBciZER5OwuR1tW0zhEKza1rwv7C
         gyrmneBFZCmc+PXfVg+y289bJE8zs7DbA+xDvBkDxC6QZ2+D3qtAS2PJMaurYJIAy3au
         DNpZE5yHsYSFCHZecO8HkMHH3CPxgWLXQ5oSEY76iWFqWHmByQ346ZGyHVoOGAz3iWI1
         g8uk0o6531Jt50H+3NTSOuih2j3DX1BHOKYYtacU/3iMfhP718nHCks1tvJhblY/AA8d
         d8Yz1sjPtc/N5nuH/QrS04HDjRmx0DJABj2AhM+Ih1z3uR3TpWXpAfc9sqchtQUzNZSP
         b2bQ==
X-Gm-Message-State: AOJu0YyEWfHDTIdC4oo2ANBRq/3j1GtgGYXjx2Pq+5oIKch4UbpBNHiW
	cyGegVmaSLs2DaMQpXQd6mZAeTzPwC5lcs2vufjPTQQoRVdPQDDI2XuRdLkhyH/XLVeHJGl6kFM
	oPHLmEwv4MusVOLndLSX8R16WLfxHEgVvKboaNBc3rAQZbIQAnamuXXQEz7/kIjfqKAhH9tZlDc
	Q44KBQrIUrU/T2qUkapKyjnBXGb2f7fsceK8AN8ODmjUuYOA==
X-Received: from wrpb6.prod.google.com ([2002:adf:f246:0:b0:43c:fd0c:97cf])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:40ca:b0:43c:fe0e:5bc5 with SMTP id ffacd0b85a97d-43cfe0e5dd2mr8630014f8f.4.1774882292005;
 Mon, 30 Mar 2026 07:51:32 -0700 (PDT)
Date: Mon, 30 Mar 2026 14:50:40 +0000
In-Reply-To: <20260330145043.1586623-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260330145043.1586623-1-smostafa@google.com>
X-Mailer: git-send-email 2.53.0.1185.g05d4b7b318-goog
Message-ID: <20260330145043.1586623-3-smostafa@google.com>
Subject: [RFC PATCH v2 2/5] dma-mapping: Use the correct phys_to_dma() for DMA_RESTRICTED_POOL
From: Mostafa Saleh <smostafa@google.com>
To: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: robin.murphy@arm.com, m.szyprowski@samsung.com, will@kernel.org, 
	maz@kernel.org, suzuki.poulose@arm.com, catalin.marinas@arm.com, 
	jiri@resnulli.us, jgg@ziepe.ca, aneesh.kumar@kernel.org, 
	Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"

As restricted dma pools are always decrypted, in swiotlb.c it uses
phys_to_dma_unencrypted() for address conversion.

However, in DMA-direct, calls to phys_to_dma_direct() with
force_dma_unencrypted() returning false, will fallback to
phys_to_dma() which is inconsistent for memory allocated from
restricted dma pools.

Fixes: f4111e39a52a ("swiotlb: Add restricted DMA alloc/free support")
Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 kernel/dma/direct.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 27d804f0473f..1a402bb956d9 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -26,7 +26,7 @@ u64 zone_dma_limit __ro_after_init = DMA_BIT_MASK(24);
 static inline dma_addr_t phys_to_dma_direct(struct device *dev,
 		phys_addr_t phys)
 {
-	if (force_dma_unencrypted(dev))
+	if (force_dma_unencrypted(dev) || is_swiotlb_for_alloc(dev))
 		return phys_to_dma_unencrypted(dev, phys);
 	return phys_to_dma(dev, phys);
 }
-- 
2.53.0.1185.g05d4b7b318-goog

