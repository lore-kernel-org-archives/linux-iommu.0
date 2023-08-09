Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 827A117FE2
	for <iommu@lists.linux.dev>; Wed,  9 Aug 2023 12:17:56 +0000 (UTC)
Received: from localhost.localdomain (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by madras.collabora.co.uk (Postfix) with ESMTPSA id 1506C66071A7;
	Wed,  9 Aug 2023 13:17:49 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1691583469;
	bh=7wciAx6Fe66k/xC939VdtxHN9VH10TtN7BBc+jsI0Jc=;
	h=From:To:Cc:Subject:Date:From;
	b=R4KIhq4EZqpm0AJ7cB7vYdZLkyQZm5YeSfL2S0X/7hnq+q8V3lcM+D8l3AFgjAZiy
	 4mpUAyITmvInWvni0NwpsIl7GT21b3uf3GB+uLcOAb7bop4wTS+Ybr9FXsuRxmZ4V5
	 oCyLtLv16UVnv40dCd7qgr5Xezq++M7WgZrVuObzTHsVpAECnaVADxzSvbGRhs/y37
	 d8Po9E9qLXqecgKEcYs2I0eejtcu4ayw8EHI2fb/dCWbPSYIVvYPU/RjOZqgzs/OGW
	 jO7YDq5cd99cmkneJ2gpiOcezXYf/4gwaKB2PQMcpNO9k+nOcBOqYOA/g7xeNNuFxO
	 3wrbOXCqqW48w==
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Joerg Roedel <joro@8bytes.org>,
	iommu@lists.linux.dev,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	linux-arm-kernel@lists.infradead.org
Cc: Rob Clark <robdclark@gmail.com>,
	Boris Brezillon <boris.brezillon@collabora.com>
Subject: [PATCH 0/2] iommu: Allow passing custom allocators to pgtable drivers
Date: Wed,  9 Aug 2023 14:17:42 +0200
Message-ID: <20230809121744.2341454-1-boris.brezillon@collabora.com>
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

A real example of how such custom allocators can be used is available
here[1]. v2 of the Panthor driver is approaching submission, and I
figured I'd try to upstream the dependencies separately, which is
why I submit this series now, even though the user of this new API
will come afterwards. If you'd prefer to have those patches submitted
along with the Panthor driver, let me know.

This approach has been discussed with Robin, and is hopefully not too
far from what he had in mind.

Regards,

Boris

[1]https://gitlab.freedesktop.org/panfrost/linux/-/blob/panthor/drivers/gpu/drm/panthor/panthor_mmu.c#L441

Boris Brezillon (2):
  iommu: Allow passing custom allocators to pgtable drivers
  iommu: Extend LPAE page table format to support custom allocators

 drivers/iommu/io-pgtable-arm.c | 50 +++++++++++++++++++++++-----------
 drivers/iommu/io-pgtable.c     | 31 +++++++++++++++++++++
 include/linux/io-pgtable.h     | 21 ++++++++++++++
 3 files changed, 86 insertions(+), 16 deletions(-)

-- 
2.41.0

