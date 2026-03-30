Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8DC732C92D
	for <iommu@lists.linux.dev>; Mon, 30 Mar 2026 14:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774882314; cv=none; b=uPUh/T/VjHd9pmEzDEo9VZXlZUHAqv/1s2nLZdEY+rD8U77d0mloYooBT2yu79A7IqGwr3F7AAD2AHlOKgWm7lS5Aivss04gPDFpADGJDVapAGDn/kZiOgGTSHNQaG9OTRoW2gXTE6uk2n9I8/xUoKV7B4xEzSF8+BBMqO41QMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774882314; c=relaxed/simple;
	bh=KCuGLCDrnXVXD6TiJbaeXO/0PpT9+aGSay1SncYRiiA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FA5YSzODKvGRdV7WNwD68sM9xrfDE3Jzh6OCbwssC94bQ3AJWw6W9+XaaVXZYwtRFKgowqAEA0/MrkaSrrZzHOcfYwnHolEf/PpIFwotlE/DXVQ9R6T0tNSvdROYq5G5EtPalcIjqedHOP2EHJzsrIaoO7S6KnynbFe4VmNG5x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ep6VkdI2; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ep6VkdI2"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-48535f4d5e1so52052695e9.0
        for <iommu@lists.linux.dev>; Mon, 30 Mar 2026 07:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774882311; x=1775487111; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6tg98HiSUgt/GbbZQxDpMM7Lbcp5/dXhobOqHvI8sRU=;
        b=ep6VkdI2qXtQPDMh3tPKXSjUlaMPJHBdKhyfh9hS3oaruImQhQocgnBivLyuhS88Bl
         la1tEXIaFXyUmWRSPdRJPfTu3ZMX39eXth/hriZ8B1zVNMoD0d/GiNxPx7dgIGW73r3w
         U4f1hIbDbTiPsOgkMLFDHJGwOS2n0tC4UtusMorOBfIuqf6eY7IHjxJrGiEfml/4lUQM
         8DdOoRgts33YK0P0SFLRAXcpzL73NA35pXgLtz/xjI5yK0yuj40lrfkQFQ4+5OCzshux
         ItdBpm8o2wVMqvZfGYT8NxPPeuZ2SGRuO8FYC/9Qk7hvstfBIz6gjbiVkj+stXHwadiz
         59gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774882311; x=1775487111;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6tg98HiSUgt/GbbZQxDpMM7Lbcp5/dXhobOqHvI8sRU=;
        b=pBErwbco4jlpF1y4CWT5qarH5UC1cXS5N7pBkoeRQqZsdr44H6ZXY1J6QK8qrsFYOC
         Uk6fXBlG9IXu0CaEdP2MUlrW7QSshydVQYIjXYeDX2kWhk+poq8ueHOzgio37BTc+DXv
         4Qv6iuWAvE+lXYkvtmNR7YQPapD47em7XMnenZg9ST6Qfm+mnEFdZwnZ+YEU4GcEMuoN
         aY8HSHXzeCLasy63K/8qTQCqpI3jzafI1OCZQLK0AQZKOCVSawqWanunLfH4ETJ8cnRP
         c2EtM2/tfCD7SOIvMDZRY/Cd6xl/nDx5sRdm7LcI1bmnPu9xsvCv2E434TM+W3dA3Q5O
         sU9g==
X-Gm-Message-State: AOJu0YxJbNpzMMF3cSlgMTOKs23zytSmhu0YhMlQL9zAzwr3ifPbWRa8
	7w/TU820/hDqYixPZAS6tNHGQh2+6Fapx8Rr2euSTeohMICUarKhv7ArpxW/N4+DeFAEMLeWz1s
	/bYNZVeM4mlINiim9wySYHJmtGhnsBKd0dGeMiTZlAWkT7hlw4ImWopDXuf4WzMgSOPsNRDuW2i
	wAC/ZtYuyVTcWAECBsb2OU+QFy5GIbai85h/Rk4C3Qr04jnw==
X-Received: from wmbz18.prod.google.com ([2002:a05:600c:c092:b0:487:38f4:95a5])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3d87:b0:486:5f71:5829 with SMTP id 5b1f17b1804b1-48727d5a307mr212298425e9.5.1774882311107;
 Mon, 30 Mar 2026 07:51:51 -0700 (PDT)
Date: Mon, 30 Mar 2026 14:50:43 +0000
In-Reply-To: <20260330145043.1586623-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260330145043.1586623-1-smostafa@google.com>
X-Mailer: git-send-email 2.53.0.1185.g05d4b7b318-goog
Message-ID: <20260330145043.1586623-6-smostafa@google.com>
Subject: [RFC PATCH v2 5/5] dma-mapping: Add doc for memory encryption
From: Mostafa Saleh <smostafa@google.com>
To: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: robin.murphy@arm.com, m.szyprowski@samsung.com, will@kernel.org, 
	maz@kernel.org, suzuki.poulose@arm.com, catalin.marinas@arm.com, 
	jiri@resnulli.us, jgg@ziepe.ca, aneesh.kumar@kernel.org, 
	Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"

Add a document for memory encryption usage with dma-direct.

Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 .../core-api/dma-direct-memory-encryption.rst | 77 +++++++++++++++++++
 1 file changed, 77 insertions(+)
 create mode 100644 Documentation/core-api/dma-direct-memory-encryption.rst

diff --git a/Documentation/core-api/dma-direct-memory-encryption.rst b/Documentation/core-api/dma-direct-memory-encryption.rst
new file mode 100644
index 000000000000..a780279292b5
--- /dev/null
+++ b/Documentation/core-api/dma-direct-memory-encryption.rst
@@ -0,0 +1,77 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+============================================
+DMA Direct and Memory Encryption Integration
+============================================
+
+Introduction
+------------
+Modern platforms introduce memory encryption features (e.g., AMD SEV, Intel TDX,
+ARM CCA, and pKVM) typically for CoCo when running protected virtual machines.
+
+These guests typically boot with their memory encrypted by default.
+
+In some cases this memory needs to be accessed by the untrusted host or the
+VMM which then requires this memory to be decrypted. One typical case is
+dealing with emulated device (e.g., virtio) which are handled by direct-dma
+code as these devices are not behind an IOMMU.
+
+That means, the memory used by these devices must be decrypted before accessed
+by the untrusted host.
+
+It must be clarified that encrypted/decrypted may not always be
+cryptographic; in a broader sense, a decrypted page means that it is
+accessible or "shared" with the untrusted host.
+
+Ownership
+---------
+The direct-dma layer deals with memory encryption in two distinct scenarios:
+
+1. **Externally Managed Decryption (e.g., Restricted DMA Pools)**
+   In some setups (like a device restricted to a specific SWIOTLB pool, i.e.,
+   `DMA_RESTRICTED_POOL`), an entire region of memory is pre-decrypted during
+   boot or pool initialization. The memory is owned by the pool, and the
+   transitions (encryption/decryption) are **not** managed by direct-dma on
+   a per-allocation basis.
+   See Documentation/core-api/swiotlb.rst
+
+2. **DMA Direct Managed Decryption (e.g., `force_dma_unencrypted()`)**
+   For standard coherent DMA allocations the direct-dma layer is explicitly
+   responsible for managing the decryption. It must decrypt the pages upon
+   allocation and re-encrypt them upon freeing.
+
+To cleanly separate these concerns, the core logic is abstracted via three
+internal helpers:
+
+* ``dma_external_decryption(dev)``: Returns true if the pages are decrypted but
+  managed externally. For example, if the device allocates from a restricted
+  DMA pool.
+* ``dma_owns_decryption(dev)``: Returns true if the pages need to be explicitly
+  decrypted and managed by the direct-dma layer (i.e., the architecture forces
+  unencrypted DMA, and it's not handled by an external pool).
+* ``is_dma_decrypted(dev)``: Returns true if the memory being used is in a
+  decrypted state, regardless of who manages it.
+
+Addressing and Page Protections
+-------------------------------
+When memory is decrypted (whether externally or by direct-dma), the layer must
+adjust physical-to-DMA address conversions and page protections:
+
+* **DMA Address Conversion:**
+  Decrypted memory often requires a specific bit to be cleared or set in the DMA
+  address (e.g., stripping the encryption bit). If ``is_dma_decrypted(dev)`` is
+  true, the conversion uses ``phys_to_dma_unencrypted()`` instead of the standard
+  ``phys_to_dma()``.
+
+* **Page Protections (Remap and Mmap):**
+  When remapping decrypted pages into the kernel virtual address space (vmalloc)
+  or mapping them to user space via ``mmap()``, the page protection attributes
+  must reflect the decrypted state. If ``is_dma_decrypted(dev)`` is true, the
+  layer applies ``pgprot_decrypted(prot)`` to ensure the CPU accesses the memory
+  with the correct encryption attributes.
+
+Notes
+-----
+In many cases when memory encryption/decryption fails the page will be leaked,
+that's was added for TDX, where ``set_memory_encrypted()`` or
+``set_memory_decrypted()``may fail while the page remains shared.
-- 
2.53.0.1185.g05d4b7b318-goog

