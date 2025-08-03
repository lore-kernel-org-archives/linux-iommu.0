Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9352621422B
	for <iommu@lists.linux.dev>; Sun,  3 Aug 2025 11:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754218927; cv=none; b=Sapf9betYlsfVwo97aMT2+7uGYBZwaefSJFIFGJknG5K7UNHvEZo7PrN0IuhuJgh067lIptWm8vUBIFcac7FtW+BFK+h238sYEtT5f29TdAPjTG6zTYaMaa3Nm+0BcYfMMiFkUCneVHFwMO3WwMAX9v1891ZToe8Sa6LRCTd1Fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754218927; c=relaxed/simple;
	bh=C7Z58OC7OFNFczmgKyOLcQXgEOfSXmydWhhPa+vt0B4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=Pt6NLhWNoX+ptpbHEgA2mDeEnajenlzHPZlrFMsLbKhn3p9UdobvgiEgQn+5Yhw6mnSy/2IlYGkEbiHBY+/LEUD7De3x9KsFs63jF2wqBdS+lCPJmMEWbTPO5WU+BCQC/vguxmQUnoURD1wb9R3w9+y2uBwwPPgIcp/va5eRGro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=infinidat.com; spf=pass smtp.mailfrom=infinidat.com; dkim=pass (2048-bit key) header.d=infinidat.com header.i=@infinidat.com header.b=cm4v49Qd; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=infinidat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infinidat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infinidat.com header.i=@infinidat.com header.b="cm4v49Qd"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-7076b55460eso31116306d6.0
        for <iommu@lists.linux.dev>; Sun, 03 Aug 2025 04:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=infinidat.com; s=google; t=1754218924; x=1754823724; darn=lists.linux.dev;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sHJHFI8hYd2LP/vvUObzJgvGzX/H7h58j8T4oERKROw=;
        b=cm4v49Qd8l7bQjCWyqCl8Z2VoW+0pTWiQVXAVN7wvXtF2Qx4KGdp/5w/qh/USJHOxV
         01Di+XP+AYQ66JVe7Tsq4RzryIJPGej5dG7+e0nrU3NOxsR8T2uC24xnTLzwyxy+/1pK
         RW+gEsiff5IfzSgZhQlRdIzCgSAm3sbT7KgpXexdLfB8gMbwk8HZBrUDX8y6y9eW+VYZ
         +blNhARJIb9gX7O7+tNYwvQUzccKWFfT/1bKj9TO4JrCkwoT+8QYXKqDcZJojdPvAtA5
         CNFEjkGBKU5OMGd/dCd73u+PcQtdj0HBJQ67PM94lCZGTPL5N7ISqgJBeAivuk3m8xDv
         eq2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754218924; x=1754823724;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sHJHFI8hYd2LP/vvUObzJgvGzX/H7h58j8T4oERKROw=;
        b=oe9y//IKYjHyw9rOPjUmeKCvMreaT6ObZR0TnoGlB0ABdxBsKt1dHzLqXr4JVSD8WB
         zjZOOpR99nIjcp/DffVJmmDMJ6prvgjJ0Dxtoqam1uHwnSJP3pSEuhnDjF8y6XNVQYZZ
         WZWatcYZIPHN0+gaw0sLv5feXwtMzXQHZ0F985IfY0TkLs+klX3vYm6A4/lRM3rU7ND+
         6o18LAW/njSfR+hQYOKpA3sYIeQqXlVO4XyZ449KdyXKqNA+Md50HX+w2WU+0pGCNC5J
         0/9aCIH8v5k+zYXxggxoBdcR2q7hyqrf+dzd5amcAhHtJlTN64uJ1kUtikAMCtgZSqIq
         oGGQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmsWGzkTi4ZUnygO3JaN3WCMZB4Njw4Ne5qaDNtfcBQfnJag+DpjGme5jP9vDu+ERpNUYY+g==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw0GX9vY3/NktlzL6kt4295veCWm1qHtC4aDjff8hx740Lf35c9
	dOLMIsMotQDTjHpiYbeQWiWcaciwFGPz+QA8JWZOHZDEiLBHKVg6EA2FDxK8t2lNlNN2eTslZQ0
	Do52zrGV1UwhfIVSkBoP4HsrzG4DM1cThR1ig6DDnnQ==
X-Gm-Gg: ASbGncvU6Ez+1v4y79yz1slTuCASALlm8sKug39XkAm3bkFU6Y34d/lCZGfydgIbV87
	yZm99KSmk23DCe5dQchzJTfACA7scGc1ym2if2y/aMUjDRHXPBAyGLz2CRRYMPTbIQFqU3dJaZU
	zZM9GUfknbFYp5+Fw8ymL5ss5uObjgZwd21GuiqQE/rQIxsV4raYka01wqIbxTqPTAo0ue70hSs
	aw8KQD+ww==
X-Google-Smtp-Source: AGHT+IGRy/xMzqtf4koj2JD4SaY51BoAsV5pFfiAe7ZJi9SAx8UHLoLsdUibItxHFatFC+CPQoG6khb8yDFziTpbfMc=
X-Received: by 2002:a05:6214:f2e:b0:707:7695:eaa0 with SMTP id
 6a1803df08f44-7093629a381mr85992156d6.32.1754218924413; Sun, 03 Aug 2025
 04:02:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAEHaoC2BWe+0Ps2oU-0xPDLFYYKG-o9+_ynFgh7u3qqyRDtrTg@mail.gmail.com>
In-Reply-To: <CAEHaoC2BWe+0Ps2oU-0xPDLFYYKG-o9+_ynFgh7u3qqyRDtrTg@mail.gmail.com>
From: Constantine Gavrilov <cgavrilov@infinidat.com>
Date: Sun, 3 Aug 2025 14:01:53 +0300
X-Gm-Features: Ac12FXxHIPP0kSwrKnrZ-6DQ9avAY_dlG0jN8mCC9KfQKZ-xZ_IbcCwwk9ACooQ
Message-ID: <CAEHaoC22NDpHUWovJChCx_XqchkEvUPYrFFe_L1PH9Mw2e386A@mail.gmail.com>
Subject: [PATCH 0/8] Large DMA alloc/skip 32-bit alloc if size > 32-bit
To: linux-kernel@vger.kernel.org, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

This is the first patch from the set of patches that enable large IOMMU
DMA registrations. Entire work is available at the master branch of the
master branch of git@github.com:cgavrilov/linux.git repo.

Do not consider 32-bit range allocation and skip iterating the rbtree,
if the allocation size exceeds 32-bit.

commit 1c21c64befe18d626855a828c721eb786dbb69b8
Author: Constantine Gavrilov <cgavrilov@infinidat.com>
Date:   Sun Jun 22 13:05:26 2025 +0300

    iommu_dma_alloc_iova(): do not try to allocate 32-bit address if
the size is above 32-bit.

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index ea2ef53bd4fe..8280e8864ef3 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -772,7 +772,7 @@ static dma_addr_t iommu_dma_alloc_iova(struct
iommu_domain *domain,
      * some inherent bug in handling >32-bit addresses, or not all the
      * expected address bits are wired up between the device and the IOMMU.
      */
-    if (dma_limit > DMA_BIT_MASK(32) && dev->iommu->pci_32bit_workaround) {
+    if (dma_limit > DMA_BIT_MASK(32) && (size - 1) <=
DMA_BIT_MASK(32) && dev->iommu->pci_32bit_workaround) {
         iova = alloc_iova_fast(iovad, iova_len,
                        DMA_BIT_MASK(32) >> shift, false);
         if (iova)

-- 
----------------------------------------
Constantine Gavrilov
System Architect and Platform Engineer
Infinidat
----------------------------------------
