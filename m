Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80078A937;
	Sun, 21 Dec 2025 16:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766333397; cv=none; b=JSfIoaHj8je0bko37VwHPofLpWBk97OSuCXXR/Mu+2UVcIZPguarW1pKTzD6GgQtjT786ip21v+NIn0I4tY3TydK2x4MdJLAYbd2cJjkb4/yCCqzRkzKFK1xKDRR44y6RzaJvhJ0UCnCb22wvOd8Zr+gOPKC40PsJkhQqvwZpl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766333397; c=relaxed/simple;
	bh=XybqZP7cmiAYNe2uf7S47H4qA/eEEwpDX2+g1lrD2oI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=s8TgtORM3qgO3f54EVA0YZmV0t46Ohfgx/Mk66d+pghbPxw7xFZ1w+cd4MI5/tlosV0z2giGNsuYnbwxqveuzHXIRYTKv3NPO/GswGvKklMgLaOkC1/juQVtrYPCwaZshFfXUPFY2NZNQeO6zYdw0Rpcr7eDucKqVzE4w1LZQMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AfLATI2A; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AfLATI2A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 800D5C4CEFB;
	Sun, 21 Dec 2025 16:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766333397;
	bh=XybqZP7cmiAYNe2uf7S47H4qA/eEEwpDX2+g1lrD2oI=;
	h=From:To:Cc:Subject:Date:From;
	b=AfLATI2AnH4HID5mnjeSzClTyK84Ht6md4P1gHhwFD2S0NdEa1SNGI0TBNwP4Wt7P
	 zq7f/FsIf5Qe35RJWOuUDrwbU6CnHlcfGzTjE3wkZxVNeY6u22rI86HJiJao9FGeMP
	 Yg0CBacNKqyCTVHBa8favZsxKaIEnvLAgZKn64yrVnXGYuGRSavjAyABXb1Le8F2JW
	 WwrmUe7Bxxv+ty0axKsWbFBEHuoNMDQT7hXRbaomuFYqhamph9OSmuupk559mcUxAS
	 Q4VEctRHGqUwDnmavYGyC+Mu1fvkxJT5U8gNjTG07eZhMRx0he8wXFvrvQY75rPQl5
	 TDQgQez3DJwlw==
From: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
To: linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-coco@lists.linux.dev
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	will@kernel.org,
	maz@kernel.org,
	tglx@linutronix.de,
	robin.murphy@arm.com,
	suzuki.poulose@arm.com,
	akpm@linux-foundation.org,
	jgg@ziepe.ca,
	steven.price@arm.com,
	"Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Subject: [PATCH v2 0/4] Enforce host page-size alignment for shared buffers
Date: Sun, 21 Dec 2025 21:39:16 +0530
Message-ID: <20251221160920.297689-1-aneesh.kumar@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi all,

This patch series addresses alignment requirements for buffers shared between
private-memory guests and the host.

When running private-memory guests, the guest kernel must apply additional
constraints when allocating buffers that are shared with the hypervisor. These
shared buffers are also accessed by the host kernel and therefore must be
aligned to the host’s page size.

Architectures such as Arm can tolerate realm physical address space PFNs being
mapped as shared memory, as incorrect accesses are detected and reported as GPC
faults. However, relying on this mechanism alone is unsafe and can still lead to
kernel crashes.

This is particularly likely when guest_memfd allocations are mmapped and
accessed from userspace. Once exposed to userspace, it is not possible to
guarantee that applications will only access the intended 4K shared region
rather than the full 64K page mapped into their address space. Such userspace
addresses may also be passed back into the kernel and accessed via the linear
map, potentially resulting in a GPC fault and a kernel crash.

To address this, the series introduces a new helper, `mem_encrypt_align()`,
which allows callers to enforce the required alignment for shared buffers.

The series is based on:
https://gitlab.arm.com/linux-arm/linux-cca.git cca/topics/cca-tdisp-integration-v2

It includes both arm64 guest and host changes to demonstrate a sample
implementation of `mem_encrypt_align()`, with the goal of making the intent and
usage clear for review.

I also included a fix for direct dma remapped coherent allocations related
memory encryption becuse it is also touching the same area. Based on feedback
here I will split that as a separate patch and can send that out

The series also includes a fix for direct DMA remapped allocations related to
memory encryption, as it touches the same code paths. Based on feedback, I can
split this fix into a separate patch and send it out independently.

Feedback and suggestions are welcome.

Changes from v1:
* Rename the helper to mem_encrypt_align
* Improve the commit message
* Handle DMA allocations from contiguous memory
* Handle DMA allocations from the pool
* swiotlb is still considered unencrypted. Support for an encrypted swiotlb pool
  is left as TODO and is independent of this series.

Aneesh Kumar K.V (Arm) (4):
  swiotlb: dma: its: Enforce host page-size alignment for shared buffers
  coco: guest: arm64: Fetch host IPA change alignment via RHI hostconf
  coco: host: arm64: Handle hostconf RHI calls in kernel
  dma: direct: set decrypted flag for remapped coherent allocations

 arch/arm64/include/asm/mem_encrypt.h |  3 ++
 arch/arm64/include/asm/rhi.h         |  7 ++++
 arch/arm64/include/asm/rsi.h         |  1 +
 arch/arm64/kernel/Makefile           |  2 +-
 arch/arm64/kernel/rhi.c              | 54 ++++++++++++++++++++++++++++
 arch/arm64/kernel/rsi.c              | 13 +++++++
 arch/arm64/kvm/hypercalls.c          | 23 +++++++++++-
 arch/arm64/kvm/rmi.c                 |  4 ---
 arch/arm64/mm/mem_encrypt.c          | 14 ++++++++
 drivers/irqchip/irq-gic-v3-its.c     |  7 ++--
 include/linux/mem_encrypt.h          |  7 ++++
 kernel/dma/contiguous.c              | 10 ++++++
 kernel/dma/direct.c                  | 14 +++++---
 kernel/dma/pool.c                    |  6 ++--
 kernel/dma/swiotlb.c                 | 18 ++++++----
 15 files changed, 161 insertions(+), 22 deletions(-)
 create mode 100644 arch/arm64/kernel/rhi.c

-- 
2.43.0

