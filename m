Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E6C2D03C
	for <iommu@lists.linux.dev>; Fri, 24 Nov 2023 14:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="AUwvAkV/"
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by madras.collabora.co.uk (Postfix) with ESMTPSA id 6A3FF66073A5;
	Fri, 24 Nov 2023 14:24:38 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1700835879;
	bh=iIcP5WIQDPTMQgE5CZyRYxBziIRXARrefGPO4u4vmlU=;
	h=From:To:Cc:Subject:Date:From;
	b=AUwvAkV/wwlMGQ5z3glRc9Z45EUS8ANCaKGdVqI4SETixm6CVHFyjnaWVcM3AAVxD
	 RxMEbQ1FeBK3wjgd1LiH8+A0c8RcJQnWzccT+zmFqonkPI0adZ08671yjkuPsIWbX7
	 oCMw0V/pRQylxsp0uvNumC9HQjafPcz0+vshN5dEyWhqxlac6s9hMHz/jzBI6GqgRe
	 /n/ZQCqkpxqo9ArpGKlCSLmJgQR5uyg//+Wlaf2NCqeDe6/885fO0XvjJW7Y+LW/Z+
	 jdZ0BJp6btMZf8ywgBWepw6RKgxMgNv7zDptiGEvpitIjaJ5qgJ5eJlTKix6PLQHTe
	 GGWD2J829m/Cw==
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Joerg Roedel <joro@8bytes.org>,
	iommu@lists.linux.dev,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	linux-arm-kernel@lists.infradead.org
Cc: Rob Clark <robdclark@gmail.com>,
	Gaurav Kohli <quic_gkohli@quicinc.com>,
	Steven Price <steven.price@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	kernel@collabora.com,
	Boris Brezillon <boris.brezillon@collabora.com>
Subject: [PATCH v3 0/2] iommu: Allow passing custom allocators to pgtable drivers
Date: Fri, 24 Nov 2023 15:24:32 +0100
Message-ID: <20231124142434.1577550-1-boris.brezillon@collabora.com>
X-Mailer: git-send-email 2.42.0
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

Regards,

Boris

Changes in v3:
- Add Robin's R-b
- Cosmetic changes
- Improve the allocator doc
- Stop passing GFP_ZERO to custom allocators

Changes in v2:
- Add Steven's R-b
- Expand on possible use-cases for custom allocators
- Add a caps field to io_pgtable_init_fns

Boris Brezillon (2):
  iommu: Allow passing custom allocators to pgtable drivers
  iommu: Extend LPAE page table format to support custom allocators

 drivers/iommu/io-pgtable-arm.c | 55 ++++++++++++++++++++++++----------
 drivers/iommu/io-pgtable.c     | 23 ++++++++++++++
 include/linux/io-pgtable.h     | 34 +++++++++++++++++++++
 3 files changed, 96 insertions(+), 16 deletions(-)

-- 
2.42.0

