Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C959325726
	for <iommu@lists.linux.dev>; Mon, 30 Mar 2026 14:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774882281; cv=none; b=FFhDbnLnCJMTWEDCOSCd65aHAD3WoPtESgriySTu6qLWOcsxfP8oraAlww+EdtUWiqQRCVGw/0BDhMIbK1tdSxq1kVHy8zpEPika2iM5BoOQ7dO+r6jKWjNsC5903jITRkVdj0NT4ZZT0WSMUDihwmFuVZAGet2kWW4mQz/5OhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774882281; c=relaxed/simple;
	bh=Ypn7VsJHNmNpvsEiDQXA8hTHZWc8FmimY/PDF1kujJ0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=CRgA3RCpd0byiMuFvyKqNCYDmrpr8g7FsuEOHWZIa3e9YWy1sQCQATtp0HtU9JGkH6rzeowKpfSg+fufXZMV/WhG0BvOuYMsZgoV2hgAXBC3Up0BWkhSngLgFfDBrzcMPlAA7NensH8GMh7G4odUlPT5GLCfQ22/zm+/Xwo1rVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q3mjT2oR; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q3mjT2oR"
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-43b9a86b9b0so4655690f8f.0
        for <iommu@lists.linux.dev>; Mon, 30 Mar 2026 07:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774882278; x=1775487078; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AzIiOc6BA0REXre6fSe/SWgZG5Uq5hkiPQ2+ZLc7PMw=;
        b=q3mjT2oRRsQ7SlyGFxWThmGxSO/ijvaXLV1HHRxg+1lsGXD1f9nMAj4yTrSylnvoIW
         /VCoNKqfqtFmvHyv3ASlNB00UrMxzbA0MGsa8NMthdKkdepz5RHHLy/K1pbxPc7gBl4B
         kncUojwnKtKGr558U2pd9nN3M2Bclti+uGhpm8VO+Dh2pjmneoahVQb9Gh1csmS0Z5kU
         28cEKZGspKJreil2yPR0l7HlWbGPlv4EB817HE7aUpdYOUu3dxkh2oQIRD3Y6IwC/c6k
         McJpm4vT5WJicfZIgXp3qwpcZZUsP5GEQpSfuzkFNJJBSfpRohSXw9vlLaMG07zbMn7P
         5+XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774882278; x=1775487078;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AzIiOc6BA0REXre6fSe/SWgZG5Uq5hkiPQ2+ZLc7PMw=;
        b=BMJ+0JY4bum3M6XYcJMfQWp679MBI3COw0RKhw1LtEmzAUWItCda/A8LakhkVhiMoK
         VCb1K5r0TFzZEhBuc8M5XBXhwPrGBPz3dF8FwyO+uTKDUHPiNCpcq4CfPeBGzEwUVKXf
         LOpuOgPBSk7xz+k2RnpPPyuiyW6pEukwxbRZ6ibHWgACstv27GKE04mkHNOHL5C+0w7W
         5SmOX1573+TllyL3ty+iZ7/j45OkpwpsBWQd7+uODurOUDLTfV5RqbxY+WkYFYMDDods
         JvyQvbdcH097LjMv4PfaTNAGX1DTzeykKtz6PxshrzR74xAR3z65IsXOs9KsEnm4CHy9
         OKhw==
X-Gm-Message-State: AOJu0YzzzubY1ID0q4Imp4HgvJQ4Vn47NJFtflzxXpiW+1c/yVpmHkfy
	oxczgVCmeypMOfZO47kZjnp2XR8DOAnj5HaMHDSghYn2ptwNpsnxDP45oGkJQjYNCrnwCeN1BaZ
	7ZZzqkLJYMgkIy4Wmy9XlB9gdbdlG4o4NvpaK6ZlNXKd8g1LsC+OX/curKsxLZY1ijyV+zrHuOo
	XnmPlcRgTgJRbTzpl4qPh3K79kdXlTXU8MteAAfTO+zTi6DA==
X-Received: from wmmu1.prod.google.com ([2002:a05:600c:c1:b0:483:7a98:f072])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:a00b:b0:485:34b3:8587 with SMTP id 5b1f17b1804b1-48727d8ffc5mr222050275e9.10.1774882278308;
 Mon, 30 Mar 2026 07:51:18 -0700 (PDT)
Date: Mon, 30 Mar 2026 14:50:38 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.1185.g05d4b7b318-goog
Message-ID: <20260330145043.1586623-1-smostafa@google.com>
Subject: [RFC PATCH v2 0/5] dma-mapping: Fixes for memory encryption
From: Mostafa Saleh <smostafa@google.com>
To: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: robin.murphy@arm.com, m.szyprowski@samsung.com, will@kernel.org, 
	maz@kernel.org, suzuki.poulose@arm.com, catalin.marinas@arm.com, 
	jiri@resnulli.us, jgg@ziepe.ca, aneesh.kumar@kernel.org, 
	Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Introduction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
This is the second version of the fixes for direct-dma dealing with
memory encryption and restricted-dma.

In this version, one more fix is included and I go a step further
and attempt to clean up the code to consolidate it and make it less
error prone.

Especially with more users coming, such as using decrypted dma-bufs [1]
which also interacts with dma-direct.
Lastly I added a new documentation for memory encryption based on my
conclusion (Documentation/core-api/dma-direct-memory-encryption.rst)

Background
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
At the moment the following hypervisor guests will need to deal with
memory encryption:
- pKVM (ARM): Documentation/virt/kvm/arm/hypercalls.rst
- ARM CCA: Documentation/arch/arm64/arm-cca.rst
- Intel TDX: Documentation/arch/x86/tdx.rst
- AMD SEV: Documentation/arch/x86/amd-memory-encryption.rst
- PPC SVM: Documentation/arch/powerpc/ultravisor.rst
- Hyper-V: Documentation/virt/hyperv/coco.rst

AFAICT, all (confidential) guests running under those have the memory
encrypted by default and guests will then explicitly share the memory
back if needed.

The main use cases for decrypting(sharing) memory are:
- Sharing memory back to the host through SWIOTLB (for virtio...)
- Hypervisor specific communication (ex: snp_msg, GHCB, VMBUS...)
- Shared/emulated resources: VGARAM (x86-SEV), GIC ITS tables (arm64)

While encrypting memory is typically used for reverting the
set_memory_decrypted() either in error handling or in freeing shared
resources back to the kernel.

Design
=3D=3D=3D=3D=3D=3D
This series focuses mainly on dma-direct interaction with memory
encryption which is the complicated case.
At the moment memory encryption and dma-direct interacts in 2 ways:
1) force_dma_direct(): if true, memory will be decrypted by default
   on allocation.
2) Restricted DMA: where memory is pre-decrypted and managed by
   SWIOTLB.

With a third possible usage on the way [1] where the DMA-API allows
an attr for decrypted memory.

Instead of open coding many checks with is_swiotlb_for_alloc() and
force_dma_unencrypted() which doesn=E2=80=99t have the same exact semantics=
,
add some helpers to abstract that logic into the code:
* dma_external_decryption(dev): Returns true if the pages are decrypted
  but managed externally.
* dma_owns_decryption(dev): Returns true if the pages need to be
  explicitly decrypted and managed by the `dma-direct` layer (as the
  architecture forces unencrypted DMA).
* is_dma_decrypted(dev): Returns true if the memory being used is in
  a decrypted state, regardless of who manages it.

Testing
=3D=3D=3D=3D=3D=3D=3D
I was able to test this only under pKVM (arm64) as I have no
access to other systems.

Future work
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Two other things I am also looking at which are related to restricted
DMA pools, so they should be a different series.
1) Private pools: Currently all restricted DMA pools are decrypted
   (shared) by default. Having private pools would be useful for
   device assignment when bouncing is needed (as for non-coherent
   devices)
2) Optimizations for memory sharing. In some cases, allocations from
   restricted dma-pools are page aligned. For CoCo cases, that means
   that it will be cheaper to share memory in-place instead of
   bouncing.

Both of these add new semantics which need to be done carefully to
avoid regressions, and might be a good candidate for a topic in the
next LPC.

Patches
=3D=3D=3D=3D=3D=3D=3D
- 1-3 Fixes
- 4 Refactoring
- 5 Documentation

v1: https://lore.kernel.org/all/20260305170335.963568-1-smostafa@google.com=
/

[1] https://lore.kernel.org/all/20260305123641.164164-1-jiri@resnulli.us/

Mostafa Saleh (5):
  dma-mapping: Avoid double decrypting with DMA_RESTRICTED_POOL
  dma-mapping: Use the correct phys_to_dma() for DMA_RESTRICTED_POOL
  dma-mapping: Decrypt memory on remap
  dma-mapping: Refactor memory encryption usage
  dma-mapping: Add doc for memory encryption

 .../core-api/dma-direct-memory-encryption.rst | 77 +++++++++++++++++++
 kernel/dma/direct.c                           | 51 ++++++++----
 2 files changed, 114 insertions(+), 14 deletions(-)
 create mode 100644 Documentation/core-api/dma-direct-memory-encryption.rst

--=20
2.53.0.1185.g05d4b7b318-goog

