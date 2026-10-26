Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792984816;
	b=BzO/ioVAEgZKfnK0tSr7UemlW0SJrIlss0rCqjliVdcKoghjfvkf8FzjkxKlljCW5tLx
	 IQ6oNOW8DrkjNTm1EaNksVckPa5ZZ4usSSL7oD3zbR0RxMyoY/Nk4h/cXA4hnUc5ZTpQK
	 +ZKtDv1aWoVjVL/jC9LjLVCb1sVtpj95noLiK69k47TdlGUBNwgxVVxtHBEWTrQwJryCO
	 QxmStq6AVBKVt2FStNQfbjOmlv82AZwu9VF+VDZsPUyHr6uhe/OYflwNX3aw9jf4o9UdF
	 KBP2ADBJZ6VE7pbIHDfCGFIVYI/tksGRKFAh13KztSEmBDskI4y3JgQCqI2665UbERQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792984816;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=WTKZttgdr/SAexmQekzblCSc0QECF1tZsnrq/gh32Uw=;
	b=Hoy7flixNU88220PZ8Px1nwQQ6Pwz2MFd2rJCnndtUEYM2Sm4Djp19NUMB9cjulfO168
	 qjeXNHaizJYZeBLXFNOMpqKKA51f9dAbbK/Oh1HkDiJGXWp1F8dgPkpKGkm/fMpfDgVJ3
	 dtmFzKpvO2x015Apc29R6D66yeSFMDMVfY9EOIOl9ZlBNb3X5VRH4cUuJmYoogMy4E3NP
	 FBrn3W4+YoeO1420K+UVBs2Vf4csvY3o2A99xAvW3E41rXSzQQDydyJqFCoM1VSf8r7Ts
	 gQiaaMscCf7X2X2WKmEGetChsbBRxRPllHNJwfKgVrd1TrAs5VrCj9OgjV19YaKeJFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=asu.edu;
	spf=pass smtp.mailfrom=asu.edu;
	dkim=pass header.d=asu.edu header.i=@asu.edu header.a=rsa-sha256 header.s=google header.b=MiKde4G6;
	arc=none smtp.remote-ip=74.125.82.176
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4246E606A31B
	for <iommu@lists.linux.dev>; Mon, 26 Oct 2026 03:20:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4246E606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=asu.edu header.i=@asu.edu header.a=rsa-sha256 header.s=google header.b=MiKde4G6
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-35943f55c06so3500240eec.0
        for <iommu@lists.linux.dev>; Sun, 25 Oct 2026 20:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1792984814; x=1793589614; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=WTKZttgdr/SAexmQekzblCSc0QECF1tZsnrq/gh32Uw=;
        b=MiKde4G6VQfIDWyS5Ia9BbAhGiyNh9YxNzMvgp0tsEU2Snbl9Qe+Ei4Xvy9wp5iqbK
         hPZd2W7CQAyP5/tf/MiK3l09jGBIscxTyzmrLtcHBJY4q4rwS1i0JH6L9reWDs5M/d61
         I5esbt4NL66/8YJqD/55n6B1DSabkQO6Tb9ORzfJ6ouC8ZvMGTQu+TZ6X6S8HX/10jRv
         50Lvj1CZATbtFXYUEmwkC6+UxRe3+LznaHG+oz6kWEoP5hvtSiD5Pxpkjhv7P+aPatvX
         3BwG7VYR1c3Rh1zoTzpFExl5M5hxqECDIEiaiHNh5E5+h3l+igRpl4WtBHIz2aZJH7Tu
         jr5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792984814; x=1793589614;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WTKZttgdr/SAexmQekzblCSc0QECF1tZsnrq/gh32Uw=;
        b=dIPrh4Wg03eZtGSGMb+17f1hsQxVPx93pBDC/C3pUrstVQlhdoD/xVUl9SkMvgzenX
         irU41j+t+QHYTjApKidIJmV4SdEMQFJ/G/mQEbQWxLJ1cbE5NboimRoW4oHCzgsxTskZ
         D9dRHiZfR2NRp/tIGl/2amdEMF90Soxt2el/IYvGhfeTWR74edg/1yzy+oP4LZ8HMxUC
         0OWgCVbqqLjWzSpin/vgEnPQvV6iwEnyM829ttcHBzq3Yi0+ZFloIkPCUXnxa3iR+oGA
         yD+GKZgmKfHPatIAJB2tDzWTb90uUMJlLwK4EvSUU4xKZUmcsPnp2C3W+ZR2/5cQmN1a
         9rhw==
X-Gm-Message-State: AFq9FYKMeJKK9PoV1qecbi5RFJT0kvdUyFWc2ctzAw6Br0N5aWH7ByT9
	p5QgjzxzduC80IJAzVJKUWz9dQ9RsUNFrPfTJk5kGsgtIaYEBp8c+rql5bpknDnzPQ==
X-Gm-Gg: AYBFou0QhH4Z/VxzbtPem8tDXebeqbRBTmhqiKsrO21YNZ6RWrJOsJ3fqze6po4bq2P
	tSEA68iG1mCd3uTw23pKDpgb54zVQck6Nhp5ab/5R/cz/aVZUiuOIYIGyI8ARyuYWj/O/lu3smC
	zFUtY4REltgAfNxcz+VIQpt0xW7HHkwU+nuvwAosACl/p17mTiWhN305khvZotjOW9ZgrGnyAba
	+NLGPyC8KLJOd+fEDSm2FYKeHRcrxFDl+Mh0+nXhak6+I7EgqTAK7DJPDp8uDKXcxNZUzbEqeFP
	260G/9DuVYgcHP9h1OHjT/Y8EDcX3eo8I9zis30HUgZxZ1956ZQCC/WQ/hOuG1sLSr8bD7TN7Mk
	S7UnD8O4HLvEhXMP64xdKS998QfNqFCn4nGYgDvQ/r/628HYZwO5tpfvxrEEMU1j0sY8j7Z3tj3
	ZEhua8a9J1VMJA89ikVwAdtdo+d0gSFkIzBLVLviM1OU3Ds6ggZIG3NV60titq/atBVClVx3XaU
	kkznIWMr/IMpVPNV7G6jMfCPVhvSDmWaAMtg9zq8HP707XE09H+TzQezSatKu9muTjxq0OHdEU/
	UPIMhAvh+EBC
X-Received: by 2002:a05:693c:6093:b0:369:fe82:8d3f with SMTP id 5a478bee46e88-369fe828ebamr3830262eec.14.1792984814156;
        Sun, 25 Oct 2026 20:20:14 -0700 (PDT)
Received: from gio.localdomain (ip68-109-140-205.ph.ph.cox.net. [68.109.140.205])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369e8db7e73sm21439295eec.20.2026.10.25.20.20.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 20:20:13 -0700 (PDT)
From: Giorgi Kobakhia <gkobakhi@asu.edu>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Xiang Mei <xmei5@asu.edu>,
	Giorgi Kobakhia <gkobakhi@asu.edu>,
	stable@vger.kernel.org
Subject: [PATCH] swiotlb: fix out-of-bounds read in swiotlb_release_slots()
Date: Sun, 25 Oct 2026 20:20:07 -0700
Message-ID: <20261026032007.1957949-1-gkobakhi@asu.edu>
X-Mailer: git-send-email 2.43.0
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

When buffer is freed, swiotlb_release_slots() tries to merge it with the
following free space by reading the list value of the next slot.

    if (index + nslots < ALIGN(index + 1, IO_TLB_SEGSIZE))
        count = mem->slots[index + nslots].list;
    else
        count = 0;

If index is in the last segment of the pool and the pool size is not
multiple of IO_TLB_SEGSIZE, index + nslots becomes equal to mem->nslabs
leading to out of bound read.

 BUG: KASAN: slab-out-of-bounds in swiotlb_release_slots
 Read of size 2

 Call trace:
  swiotlb_release_slots (kernel/dma/swiotlb.c:1653)
  __swiotlb_tbl_unmap_single (kernel/dma/swiotlb.c:1734)
  dma_unmap_phys (./include/linux/swiotlb.h:262 kernel/dma/direct.h:102
                    kernel/dma/mapping.c:218)
  dma_unmap_page_attrs (kernel/dma/mapping.c:236)

The commit 0b84e4f8b793 ("swiotlb: Add restricted DMA pool
initialization") makes it possible to initialize a pool with an
arbitrary size. Before it nslabs was multiple of IO_TLB_SEGSIZE and no
OOB occurred.

Add overflow check.

Fixes: 0b84e4f8b793 ("swiotlb: Add restricted DMA pool initialization")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Tested-by: Xiang Mei <xmei5@asu.edu>
Signed-off-by: Giorgi Kobakhia <gkobakhi@asu.edu>
---
 kernel/dma/swiotlb.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index ded7016a46a7..1f18003be343 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -1649,7 +1649,8 @@ static void swiotlb_release_slots(struct device *dev, phys_addr_t tlb_addr,
 	BUG_ON(aindex >= mem->nareas);
 
 	spin_lock_irqsave(&area->lock, flags);
-	if (index + nslots < ALIGN(index + 1, IO_TLB_SEGSIZE))
+	if (index + nslots < ALIGN(index + 1, IO_TLB_SEGSIZE) &&
+	    index + nslots < mem->nslabs)
 		count = mem->slots[index + nslots].list;
 	else
 		count = 0;
-- 
2.43.0

