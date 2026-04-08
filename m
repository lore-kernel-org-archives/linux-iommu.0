Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600B035BDDC
	for <iommu@lists.linux.dev>; Wed,  8 Apr 2026 19:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775677676; cv=none; b=AONko+8ggS8bwut5Sna/Xe7JvZMuDwISAYS5+ScrCixvhvpsO9JUUchhJQ/a2j1kYUDxfI1AEhJv3JrbfUi7V9fMfuuIebUe3vgWV5X6bHVWJI7uOIwaFeGkhX9FP38GhKzAuxxrnb/1lQEcieYDx42JUpIHc5qrmwqo0aEs17c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775677676; c=relaxed/simple;
	bh=++qaUlH60rujL2EeuxAjz55e286IN/ksdts0Ja/DS/A=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=nw3fRxyq+qeFq4/ajvmpsXLcYgGA2jm7vSvnslvd01UK5wmBwlv6fzTwNKx92vxll09y2mru+lskA2+i9DZPEZpvbvQ9/MTj/U5iSla3IE/0J35ad+bnBJ2NTJl/lonx+V75mIdNwajUpyUQE9cA60qB5UVMGwD77OURydqpqwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h91FUtnG; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h91FUtnG"
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-b9c4d923668so5862766b.1
        for <iommu@lists.linux.dev>; Wed, 08 Apr 2026 12:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775677674; x=1776282474; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kB3YVRlQ+vkqxXyCDIXulHB40fkXX98UQ/3NiNm38UU=;
        b=h91FUtnGX2OjXoaNRBxwBAhvXh4wI6OCPbOYKOI0JW7P3WLWH6sEjGsMpcPXo8lhB5
         niGIjyoa5NaaFPmu1VD+PwMJHIHKuMPfBA3bMydiWgpfW9AfdjpzlwwqRJPgov2SbVQR
         wCanoldaQjhL7NaVMreB12tKPaSKzvXiO09fOpmqGz3S7TycHVsRtQ4GMLeBYWtbKt7S
         eF4rhs99oB+4C/bbw+6RMJW4H+YCMCD3+WpMtcnVu6pERg6xRfuN9KYiufZYK9Oy8Kyi
         KRAB6uL/Ll4KNByHHpG5Pjl3xQadWvFquj7Xp/DVhSnjCH0p8KTG9CJ8iUksZvzkFcyY
         JuQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775677674; x=1776282474;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kB3YVRlQ+vkqxXyCDIXulHB40fkXX98UQ/3NiNm38UU=;
        b=K6/5kcBxi4IgbT3KoKQdg8bjhFtg8uYn0sqdhJ2e3hgIG4GYfVQhnlKD/0Y8sF+dPf
         v9kBtZv1cbGdWTLrrbuOo6T+VRN9rYKr/li6cgIigPcZECW3FT2ZKGx2e2JTeopEE2xB
         K2m/hgUlbX9hxt8mfHSAZNjZxaPJU8ZSQ7i427AIeVZxmFZWLftitT9SDYjw+lEO83gq
         4TEHpYZn9goEc1i3SrCzzmkMbRB+426XLFOj4cWDmUKWFtEvLN+3ucIQ9GhEYtlm4m5C
         +4UQk1n07FnOzDibYipi0Gj9xZcGL46GeM0jejfJ2igy0OeFIJWTb+9UE+4oKEiNk7Ul
         fTYQ==
X-Gm-Message-State: AOJu0YzwlWx1ZhSv0dAqf8SpDdzL6Lo6eSq7U6Glb/0rIjCAkt5eZY8s
	5ZEoYSoAXlM+wuBtez/Lbr0MUc13kWJfjdKdcF5hCoOAyFMcmh41sfGfd1ArLgnq4qWHWYJ8Jj5
	djTv2hIJAArsM9B/JXvmJMCHSy+5RCKMfrqUBOjDECk8EYWczqG2I0ClErgNmcSxZERKBv2/3hj
	2X4fD3+NJJcPjDC0H96FaKgeXCvE16wkhRF1CeX2ohJybtmw==
X-Received: from ejcdi15.prod.google.com ([2002:a17:906:730f:b0:b97:9506:7685])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:3f90:b0:b98:cb6:e896 with SMTP id a640c23a62f3a-b9c67b77b14mr1169456266b.38.1775677673415;
 Wed, 08 Apr 2026 12:47:53 -0700 (PDT)
Date: Wed,  8 Apr 2026 19:47:37 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260408194750.2280873-1-smostafa@google.com>
Subject: [RFC PATCH v3 0/5] dma-mapping: Fixes for memory encryption
From: Mostafa Saleh <smostafa@google.com>
To: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: robin.murphy@arm.com, m.szyprowski@samsung.com, will@kernel.org, 
	maz@kernel.org, suzuki.poulose@arm.com, catalin.marinas@arm.com, 
	jiri@resnulli.us, jgg@ziepe.ca, aneesh.kumar@kernel.org, 
	Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="y"
Content-Transfer-Encoding: quoted-printable

Introduction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
This is the third version of the fixes for direct-dma dealing with
memory encryption and restricted-dma.

Changes in v3:
- Instead of extending the logic by using is_swiotlb_for_alloc(),
  follow Jason=E2=80=99s suggestion and propagate the state of the memory
  allocated.
- Remove checks out of dma_set_*() based on Jason suggestion
- Remove documentation for now until we are close to the final
  proposal and add it later if needed.

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
force_dma_unencrypted().
Make __dma_direct_alloc_pages() return the state of allocated memory
encapsulated on the new internal type dma_page.
Then based on the memory state, dma-direct can identify what to do
based on the cases:
- Memory needs to be decrypted but is not: dma-direct will decrypt
  the memory and use the proper phys address conversions and page
  table prot.
- Memory is already decrypted: dma-direct will not decrypt the memory
  but it will use the proper phys address conversions and page table
  prot.

The free part is more tricky as we already lose the information about
allocation, so we have to check with each allocator separately, so
swiotlb_is_decrypted() is added for SWIOTLB which is only allocator
that can return decrypted memory.

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
- 1 Extend swiotlb
- 2-4 Refactoring
- 5 Fixes

v1: https://lore.kernel.org/all/20260305170335.963568-1-smostafa@google.com=
/
v2: https://lore.kernel.org/all/20260330145043.1586623-1-smostafa@google.co=
m/

[1] https://lore.kernel.org/all/20260305123641.164164-1-jiri@resnulli.us/


Mostafa Saleh (5):
  swiotlb: Return state of memory from swiotlb_alloc()
  dma-mapping: Move encryption in __dma_direct_free_pages()
  dma-mapping: Decrypt memory on remap
  dma-mapping: Encapsulate memory state during allocation
  dma-mapping: Fix memory decryption issues

 include/linux/swiotlb.h |  25 +++++++-
 kernel/dma/direct.c     | 134 +++++++++++++++++++++++++++-------------
 kernel/dma/swiotlb.c    |  23 ++++++-
 3 files changed, 135 insertions(+), 47 deletions(-)

--=20
2.53.0.1213.gd9a14994de-goog

