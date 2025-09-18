Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A3230C35D;
	Thu, 18 Sep 2025 14:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758204600; cv=none; b=R1wP0zPrzYBi7oyWcLx9QvLgz/3sqcykvzBJnmqcxSnAgo+Fb5fSoY/ZJ2h3wsIKnZVhf1uTLwZyeVN8R3YkBTJuNX8t+w9T4ZOK8rQthqzf1ML6GI3hLtx/9n3Q36MZy6ci5QV4Y0OWfZScRjC0we6HpBHetfSQspSs2ZulWs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758204600; c=relaxed/simple;
	bh=Pi5T819TFc2iqtg/dEe1hcW6EHD16i+UrHXuy/WzDOY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fJU7NvwB7PvekmrNEsGw9SuGdojPFnOAT0WVsTKWHJrYbT58CnrbJBmsvZw/Dhw0p8Y4EQ3q/XGC8sPC/tPJhh7QWHplseIikKhLpfel+Ge2XmpBNZNKZ/PAynJdl7xHMv8JlZV9Gl2PZQmp9HDm9IjkPxdWKIzCVLs39wzVIXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N6hq4IZi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N6hq4IZi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AE6CC4CEE7;
	Thu, 18 Sep 2025 14:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758204600;
	bh=Pi5T819TFc2iqtg/dEe1hcW6EHD16i+UrHXuy/WzDOY=;
	h=From:To:Cc:Subject:Date:From;
	b=N6hq4IZioMzxZVLrqPxIN1sDeyN1/MixcEr36decDtSa4WNTO48EIzoRtCfHURiTP
	 XMufzHtXGUQWyG32ltphrXys4JlT2/nPQzRJUepSs7aIKZ4Dt/Ss1EyEAK8QkC8zc3
	 vIl5lD0WF4qeZn8Z3KGVbFo72DRy50Klk5ZEVPZ2yeHGy8hIMfUDG6YgqbV6WFZxca
	 4kV/RF3TSWU8WIaiPtXWJzI2gXYl0Crd2VqYcMMNL6jc66qQmehT4vZSRFKtxGw7Jr
	 cRVkT6eGVn1SU0m0y41HUKDXp21LxO+guGGu3EyXnpZKW4XO6cr0Q6FOwPLQ0JkSJE
	 62ET1qQlR3oRw==
From: Leon Romanovsky <leon@kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>,
	iommu@lists.linux.dev,
	Juergen Gross <jgross@suse.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>,
	Stefano Stabellini <sstabellini@kernel.org>,
	xen-devel@lists.xenproject.org
Subject: [PATCH v4 0/6] Preparation to .map_page and .unmap_page removal
Date: Thu, 18 Sep 2025 17:09:23 +0300
Message-ID: <cover.1758203802.git.leon@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changelog:
v4:
 * Added Jason's ROB tags
 * Added "xen: swiotlb ..." patch to the list of patches which had .map_resource
 * Added extra patch "ARM: dma-mapping: Reduce ..." to remove struct
   page as much as possible.
 * Added call to .map_phys/.unmap_phys to dma_common_*_pages() functions.
v3: https://lore.kernel.org/all/cover.1758006942.git.leon@kernel.org
 * Rewrote the series to allow combination of .map_resource and
 * .map_page
   to one flow.
 * Added two new patches to convert and remove .map_resource.
v2: https://lore.kernel.org/all/cover.1752734252.git.leon@kernel.org/
 * Added default "else" section without map_phys and map_page
   callbacks (impossible).
v1: https://lore.kernel.org/all/cover.1753003879.git.leon@kernel.org
 * Changed "else if" instead of "if".
v0: https://lore.kernel.org/all/cover.1752734252.git.leon@kernel.org
---------------------------------------------------------------------

This is followup to "dma-mapping: migrate to physical address-based API" series
https://lore.kernel.org/all/cover.1757423202.git.leonro@nvidia.com

Thanks

Leon Romanovsky (6):
  dma-mapping: prepare dma_map_ops to conversion to physical address
  dma-mapping: convert dummy ops to physical address mapping
  ARM: dma-mapping: Reduce struct page exposure in arch_sync_dma*()
  ARM: dma-mapping: Switch to physical address mapping callbacks
  xen: swiotlb: Switch to physical address mapping callbacks
  dma-mapping: remove unused mapping resource callbacks

 arch/arm/mm/dma-mapping.c   | 180 +++++++++++-------------------------
 drivers/xen/swiotlb-xen.c   |  63 ++++++-------
 include/linux/dma-map-ops.h |  13 +--
 kernel/dma/dummy.c          |  13 ++-
 kernel/dma/mapping.c        |  20 ++--
 kernel/dma/ops_helpers.c    |  12 ++-
 6 files changed, 113 insertions(+), 188 deletions(-)

-- 
2.51.0

