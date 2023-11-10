Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C011D12B88
	for <iommu@lists.linux.dev>; Fri, 10 Nov 2023 09:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="X0Oeosqr"
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by madras.collabora.co.uk (Postfix) with ESMTPSA id 5FF3266073E6;
	Fri, 10 Nov 2023 09:43:56 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1699609437;
	bh=is0ZWawZ7jqZSJcJX0Mc3C68nH2lkPBAPkiqbprBLOY=;
	h=From:To:Cc:Subject:Date:From;
	b=X0OeosqrFuMIeI0Y+dc1G1lRieQ0S7uEnh0zjF9NMIq29TGs1sbEqfEWEB4gLlWE8
	 dD0nBL5MflCxWpv6pVstiQ5X37Au5UvUYVJeH9jQ3wGI3CKqpaAduH033N0lMvHMY2
	 08WaQ9d26p6QBTUnJjYQO9NAbd/2vEex7/Rg2NeLK6GT9dhdTbfMQwzcTp5QZxCiys
	 NS7CHqhXJo7acThWHHgLWegR58F6e6zvOA6+IvSs3kCdecZAboq1eLMRSCiewfaMQ6
	 fZcVJ25T9gPD2oXMSMS7ZvF3G6FqMe30gA/G4UVyfvnrpr56HMwxPT9O6Euo6UkFMZ
	 zvuCjlDhTO2hg==
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Joerg Roedel <joro@8bytes.org>,
	iommu@lists.linux.dev,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	linux-arm-kernel@lists.infradead.org
Cc: Rob Clark <robdclark@gmail.com>,
	Gaurav Kohli <quic_gkohli@quicinc.com>,
	Steven Price <steven.price@arm.com>,
	Boris Brezillon <boris.brezillon@collabora.com>
Subject: [PATCH v2 0/2] iommu: Allow passing custom allocators to pgtable drivers
Date: Fri, 10 Nov 2023 10:43:50 +0100
Message-ID: <20231110094352.565347-1-boris.brezillon@collabora.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

This patchset is an attempt at making page table allocation
customizable. This is useful to some GPU drivers for various reasons:

- speed-up upcoming page table allocations by managing a pool of free
  pages
- batch page table allocation instead of allocating one page at a time
- pre-reserve pages for page tables needed for map/unmap operations and
  return the unused page tables to some pool

The first and last reasons are particularly important for GPU drivers
wanting to implement asynchronous VM_BIND. Asynchronous VM_BIND requires
that any page table needed for a map/unmap operation to succeed be
allocated at VM_BIND job creation time. At the time of the job creation,
we don't know what the VM will look like when we get to execute the
map/unmap, and can't guess how many page tables we will need. Because
of that, we have to over-provision page tables for the worst case
scenario (page table tree is empty), which means we will allocate/free
a lot. Having pool a pool of free pages is crucial if we want to
speed-up VM_BIND requests.

There might also be other good reasons to want custom allocators, like
fine-grained memory accounting and resource limiting.

A real example of how such custom allocators can be used is available
here[1]. v2 of the Panthor driver is approaching submission, and I
figured I'd try to upstream the dependencies separately, which is
why I submit this series now, even though the user of this new API
will come afterwards. If you'd prefer to have those patches submitted
along with the Panthor driver, let me know.

Regards,

Boris

[1]https://gitlab.freedesktop.org/panfrost/linux/-/blob/panthor/drivers/gpu/drm/panthor/panthor_mmu.c#L441

Boris Brezillon (2):
  iommu: Allow passing custom allocators to pgtable drivers
  iommu: Extend LPAE page table format to support custom allocators

 drivers/iommu/io-pgtable-arm.c | 55 ++++++++++++++++++++++++----------
 drivers/iommu/io-pgtable.c     | 23 ++++++++++++++
 include/linux/io-pgtable.h     | 31 +++++++++++++++++++
 3 files changed, 93 insertions(+), 16 deletions(-)

-- 
2.41.0

