Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E54748424E
	for <iommu@lists.linux.dev>; Mon,  7 Sep 2026 12:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788782494; cv=none; b=Q4URaABDtKiG3cXY/QLDoV/QrZRXDIUIKldvGgOUhJ6DCDZsrp1Bn5GXdAvDYxk5HzIW2cqqwwGu+6gtA20FOJQDRQw08beKB30rBmCiCalqVtyrpOg5ViZkFsWu5uP8PTbv5Kk+ivjGtG7eHJEAioJ6dmUGslW3sYp0LCa4ryk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788782494; c=relaxed/simple;
	bh=CrlhUJHxSyS7QTCXqZCtb5+kT27E/1q8+f1+oITtvvk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C2pFCR8M0hSZpbTUlzSrSA5x6eazuqoGZb6tncWwb1OZUGkQLVpkk1mM93WEBfv9Tygqd2D9hwfEkfQfELL1lETQJyUeUuzOfiBa/JsfTaxdZ303pFGGayaWddDXwuvSpYYxPOlTsJL1yZi74nm+z16zFbIloJGCFeiC/zT0Ex8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C2sPQq8Y; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C2sPQq8Y"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-853f8c34ba4so4248507b3a.0
        for <iommu@lists.linux.dev>; Mon, 07 Sep 2026 05:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788782492; x=1789387292; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=fGYY8R1XstP8r1J3lVI69+hhzGANnc2NV65GGslrhcI=;
        b=C2sPQq8YlUJuLH8ks9JLxvyBFuCcaNlwqofDwPEw8rNAx/oqBKrC+GM5i/XdW+yXAo
         hx3u8fQMPReY++v2oDuhLSo/3B6NAWwLTtB0QynMYF87S2DzDhrTwgW2B32+8ju+FVJO
         EaBpikb9eTlN2S9jWfsK20nPIFU53IPUGM8YQ71X04zXGXzt7HNt+E+AyHNkeVzwZFeD
         Q30SxQdNVs0ZH5Ju3nhGw7+z4VtA5jcXwGgSMqf5WlKgoggGdmF7X+vALMpdUrmR+WBJ
         LRxu1a9puo0OMdOtzFIT8lx+rKTpsPck1qprDlWuwBQakQFn47muQjOqOQj3Z9+NHZxn
         P/JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788782492; x=1789387292;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fGYY8R1XstP8r1J3lVI69+hhzGANnc2NV65GGslrhcI=;
        b=bkuE0/dBB9ZUVheZaeQVbiWMP1LWUh+lODdGdD7ZN3VEWc0k4dk565us8HAUnk6qzE
         2Ce4x6qlmqd6Bkbc1sHGvZLtnbcAp4uJ4Hx7Fmfq2wkXQ82MQN20p/B6cKnEny7sxjPM
         Kk7Hla6024Fd+kYu/OCV29Dq98ytCwiOGCu4VMt6wsqlTRdlf0xnxjAbSh3JQx1aSVaN
         y0qsLkCxjTlHMb/nXAeRfzsmGi94a5iXA7jWlgPnoRTCvH1k/wNAvIWQeFKKOuQTizeC
         NeTV0s65dInCgx5RY0L3eMIHxFWfMpNQ5O+dnnUP40sGIdIvtuc13oFjBsR24M5ueoWs
         GHxA==
X-Forwarded-Encrypted: i=1; AKwUvBwzZSp8U5Xn5ArIxs51Kn5UaDGqFoekFpQwbI2Pbq3u9Eqt1vtDSpCTeW4woNpb0l/XgdLgiA==@lists.linux.dev
X-Gm-Message-State: AFuF++mgvRt27oLa/PsI2cC4+N5YXc6eHZlgjUPFab9JzScbGHRXLMyD
	/R2Yek88LKiB9QRcVu9hMA8x+HpI8iy6u5KBsyGOy/SC00XsFvAwjAk=
X-Gm-Gg: AYBFou1TE/yZ+z1mzRBrbsRuuFrur0QS0ZsQalTmmW531AuuUg978ydyHbn5q3rB7Ko
	Ua5ZcufxLdHbtGaMAMjQ5W90rWowpMx6uoSmCol/MLkAwhE2BD6i238ap2G5LauxOCs13SvH8g/
	lypH+YkF7GFuaBbar5iA+cq3o94a75nyLGc2GDA/MiQfBByLYeQCiGxenxyVdGDbqXHn+AhaTUO
	rZgluAavIK4saFOL/e6sr/bZAMXJ6yADc7If6W5BjjY0/9vZDeyR+5I9BAzE2vVv/xs3xvD8Dgx
	D6GUjJvSQS/RMqnKf413Qa27M61Ux6tIbECYCO6N5bj8pQX27jk13CqLTL3CTS69YOnwXK636TB
	d0OZ9Djl9IhAcTRSSp1SRI1zkjFSKPw7++rJsfRI1RCHOdeh2OnsIwtmvEfzaV7WDc+2iCChWRc
	mLxkMCMHdK3G4zqWzdXFR7rOVaGkPciSxMOxFM8Ua1a4TPUc3zddxfUPcaqD6b2ZaR3dPyecjWA
	Jyu2f0khOHheoyX
X-Received: by 2002:a05:6a00:ac8b:b0:85f:2f32:7a53 with SMTP id d2e1a72fcca58-8616c546f9dmr33820834b3a.17.1788782491666;
        Mon, 07 Sep 2026 05:01:31 -0700 (PDT)
Received: from ydg-Zenbook-14-UM3406GA ([2001:2d8:6467:d689:c773:5f09:906c:a72b])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-86153f417f2sm4148847b3a.58.2026.09.07.05.01.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 05:01:31 -0700 (PDT)
From: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
To: Marek Szyprowski <m.szyprowski@samsung.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Sean Anderson <sean.anderson@linux.dev>,
	iommu@lists.linux.dev,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	donggeunyoo.kernel@gmail.com
Subject: [PATCH v2] dma-mapping: don't trace the DMA address when the allocation fails
Date: Mon,  7 Sep 2026 21:01:24 +0900
Message-ID: <20260907120124.603373-1-donggeunyoo.kernel@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

dma_alloc_attrs() passes *dma_handle to trace_dma_alloc() without
checking whether the allocation succeeded. No backend writes it on
failure: dma_direct_alloc(), iommu_dma_alloc() and the dma_map_ops
instances assign it only on the path that returns a buffer. Callers
usually pass an uninitialized automatic variable, so a failed allocation
records whatever the stack held, next to the virt_addr=(null) that marks
the record as an error:

 dma_alloc: dmatrace dir=BIDIRECTIONAL dma_addr=deadbeefdeadbeef
 size=1099511627776 virt_addr=0000000000000000

The device coherent pool path reaches the same call: a non-zero return
from dma_alloc_from_dev_coherent() means the request was handled, not
that it succeeded, so cpu_addr is NULL and dma_handle is untouched once
the pool runs out.

For an allocation event a NULL virt_addr already means the request
failed, so the address field carries nothing. Report 0 for it in the
event class rather than at each call site, which covers dma_alloc_pages()
and dma_alloc_sgt_err() as well.

Fixes: 038eb433dc14 ("dma-mapping: add tracing for dma-mapping API calls")
Fixes: 68b6dbf1f441 ("dma-mapping: trace more error paths")
Suggested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
---
v2:
- report 0 in the event class instead of splitting the two call sites,
  as suggested by Marek. kernel/dma/mapping.c is untouched now, so
  debug_dma_alloc_coherent() keeps being called for a failed allocation
  and decides for itself what to do with it.
- tested on x86_64 rather than compile-tested only.
v1: https://lore.kernel.org/linux-iommu/20260905071919.30784-1-donggeunyoo.kernel@gmail.com/

Tested with a module that puts a known value in the caller's handle and
then asks for 1 TiB from a 32-bit capable device, with the dma_alloc
event enabled. Before, the record carries the caller's stale value; after,
it carries 0:

 -dma_addr=deadbeefdeadbeef size=1099511627776 virt_addr=0000000000000000
 +dma_addr=0 size=1099511627776 virt_addr=0000000000000000

A PAGE_SIZE request from the same device, as a control, reports its real
address on both kernels, matching the handle the caller got back.

This changes what the record contains, not what the caller does:
*dma_handle is still read to build the tracepoint arguments, since those
are evaluated before the static branch.

 include/trace/events/dma.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/trace/events/dma.h b/include/trace/events/dma.h
index 9df02c1511de..b06d8f99922d 100644
--- a/include/trace/events/dma.h
+++ b/include/trace/events/dma.h
@@ -134,7 +134,7 @@ DECLARE_EVENT_CLASS(dma_alloc_class,
 	TP_fast_assign(
 		__assign_str(device);
 		__entry->virt_addr = virt_addr;
-		__entry->dma_addr = dma_addr;
+		__entry->dma_addr = virt_addr ? dma_addr : 0;
 		__entry->size = size;
 		__entry->flags = flags;
 		__entry->dir = dir;

base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
-- 
2.53.0

