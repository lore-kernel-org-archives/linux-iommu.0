Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC03635B12B
	for <iommu@lists.linux.dev>; Fri,  6 Mar 2026 10:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772793434; cv=none; b=oQY0ibqnqFzUPzyqH140f8yA2MOXTULupHZZsTbKX7/LJjt6Vdpy22hpYobJXvmSKZOdM5+ZpQCs/HAxTtkqTDG2iM8OZvdf/aXWgVG/zsDOlthe9hmg9JIgF8MqjZ9fs6OaVT3zHPSqd36qrvoFhocGgAHmUY1+hGkrIqoC5SI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772793434; c=relaxed/simple;
	bh=ExZnC7goEKWKM6Rtl+U4JqZvVGyaRn8TBOjYWQsS5l0=;
	h=From:Subject:Date:Message-Id:MIME-Version:To:Cc:Content-Type; b=jiy+BvgtkoNB/YQKKiO5NTQc3UV17O/Ha8xDdlcS9LWIhs7ENgLoI8Wg3rybeDsBEzok2dN7ftK7CqblNFNzuWivZ56c6y6BP/iN6+yP+7qObleqvO+dXWa4rmAIV6VKhWlfctDBLc2CQPwGSobCL7FvNHYxCYfYnXI6oHxo5PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WoTkBhZB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WoTkBhZB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772793431;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=CNok9dmrehJj085xLfY0Qs/d7XMY0KJw2lUvqcVr7uo=;
	b=WoTkBhZBelYn4qeju9Uyfw2oC7UTqp0UAlI3RrsTnVtKj3NgPFbxiXcAIWJd7aKzmTfF6P
	xzdSZCAkrcnms72dzAAUyZiJn3gZJHOURHghL/NuTrWpVy31c/S8MCyc5R1ofB9sTA0y6r
	QLLtkMwiGk7AvGwPKanIUwZFRqTeMi8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-96-fZ85QXqmMvy5WsYgpsd6pQ-1; Fri,
 06 Mar 2026 05:37:08 -0500
X-MC-Unique: fZ85QXqmMvy5WsYgpsd6pQ-1
X-Mimecast-MFC-AGG-ID: fZ85QXqmMvy5WsYgpsd6pQ_1772793425
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6B9FC1956089;
	Fri,  6 Mar 2026 10:37:05 +0000 (UTC)
Received: from [192.168.1.153] (unknown [10.45.226.103])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 38DB11800576;
	Fri,  6 Mar 2026 10:36:57 +0000 (UTC)
From: Albert Esteve <aesteve@redhat.com>
Subject: [PATCH v3 0/6] dma-buf: heaps: add coherent reserved-memory heap
Date: Fri, 06 Mar 2026 11:36:31 +0100
Message-Id: <20260306-b4-dmabuf-heap-coherent-rmem-v3-0-3d00d36c9bc4@redhat.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4XOTQ7CIBCG4as0rB1DhxatK+9hXFAYhEV/ApVom
 t5d2sQYN7p8Z/F8M7NIwVNkp2JmgZKPfuhziF3BtFP9jcCb3Aw5So4ooK3AdKq9W3CkRtCDo0D
 9BKGjDprSGtGgVJYalokxkPWPjb9cczsfpyE8t7VUrtc3XP2GUwklGGvJVgKbo9LnQMapaa+Hj
 q1ywo8m+J83EwIHWatK1qIV4nD80pZleQFHSBIuFwEAAA==
X-Change-ID: 20260223-b4-dmabuf-heap-coherent-rmem-91fd3926afe9
To: Sumit Semwal <sumit.semwal@linaro.org>, 
 Benjamin Gaignard <benjamin.gaignard@collabora.com>, 
 Brian Starkey <Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>, 
 "T.J. Mercier" <tjmercier@google.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh@kernel.org>, 
 Saravana Kannan <saravanak@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
 iommu@lists.linux.dev, devicetree@vger.kernel.org, 
 Albert Esteve <aesteve@redhat.com>, mripard@redhat.com, echanude@redhat.com, 
 John Stultz <john.stultz@linaro.org>, Maxime Ripard <mripard@kernel.org>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772793417; l=4098;
 i=aesteve@redhat.com; s=20260303; h=from:subject:message-id;
 bh=ExZnC7goEKWKM6Rtl+U4JqZvVGyaRn8TBOjYWQsS5l0=;
 b=UNGgoXKmH542rSOqPbjXTgBDaWRdkdTQo0EoW9KZ1vE/PiAG6Zcb1qM/GgwOycyhucLQJuOwG
 Mtb4/HsYkEWDLTZxjMPx0QbPMjLBfxdVBdXHDeL+WLZ6QFhoR4GGmXF
X-Developer-Key: i=aesteve@redhat.com; a=ed25519;
 pk=YSFz6sOHd2L45+Fr8DIvHTi6lSIjhLZ5T+rkxspJt1s=
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: 0p5nsTNz0eB0YIMExSNFU0OC2mhKhqBuT1DidK5GVwI_1772793425
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

This patch series adds a new dma-buf heap driver that exposes coherent,
non‑reusable reserved-memory regions as named heaps, so userspace can
explicitly allocate buffers from those device‑specific pools.

Motivation: we want cgroup accounting for all userspace‑visible buffer
allocations (DRM, v4l2, dma‑buf heaps, etc.). That’s hard to do when
drivers call dma_alloc_attrs() directly because the accounting controller
(memcg vs dmem) is ambiguous. The long‑term plan is to steer those paths
toward dma‑buf heaps, where each heap can unambiguously charge a single
controller. To reach that goal, we need a heap backend for each
dma_alloc_attrs() memory type. CMA and system heaps already exist;
coherent reserved‑memory was the missing piece, since many SoCs define
dedicated, device‑local coherent pools in DT under /reserved-memory using
"shared-dma-pool" with non‑reusable regions (i.e., not CMA) that are
carved out exclusively for coherent DMA and are currently only usable by
in‑kernel drivers.

Because these regions are device‑dependent, each heap instance binds a
heap device to its reserved‑mem region via a newly introduced helper
function -namely, of_reserved_mem_device_init_with_mem()- so coherent
allocations use the correct dev->dma_mem.

Charging to cgroups for these buffers is intentionally left out to keep
review focused on the new heap; I plan to follow up based on Eric’s [1]
and Maxime’s [2] work on dmem charging from userspace.

This series also makes the new heap driver modular, in line with the CMA
heap change in [3].

[1] https://lore.kernel.org/all/20260218-dmabuf-heap-cma-dmem-v2-0-b249886fb7b2@redhat.com/
[2] https://lore.kernel.org/all/20250310-dmem-cgroups-v1-0-2984c1bc9312@kernel.org/
[3] https://lore.kernel.org/all/20260303-dma-buf-heaps-as-modules-v3-0-24344812c707@kernel.org/

Signed-off-by: Albert Esteve <aesteve@redhat.com>
---
Changes in v3:
- Reorganized changesets among patches to ensure bisectability
- Removed unused dma_heap_coherent_register() leftover
- Removed fallback when setting mask in coherent heap dev, since
  dma_set_mask() already truncates to supported masks
- Moved struct rmem_assigned_device (rd) logic to
  of_reserved_mem_device_init_with_mem() to allow listing the device
- Link to v2: https://lore.kernel.org/r/20260303-b4-dmabuf-heap-coherent-rmem-v2-0-65a4653b3378@redhat.com

Changes in v2:
- Removed dmem charging parts
- Moved coherent heap registering logic to coherent.c
- Made heap device a member of struct dma_heap
- Split dma_heap_add logic into create/register, to be able to
  access the stored heap device before registered.
- Avoid platform device in favour of heap device
- Added a wrapper to rmem device_init() op
- Switched from late_initcall() to module_init()
- Made the coherent heap driver modular
- Link to v1: https://lore.kernel.org/r/20260224-b4-dmabuf-heap-coherent-rmem-v1-1-dffef43298ac@redhat.com

---
Albert Esteve (5):
      dma-buf: dma-heap: split dma_heap_add
      of_reserved_mem: add a helper for rmem device_init op
      dma: coherent: store reserved memory coherent regions
      dma-buf: heaps: Add Coherent heap to dmabuf heaps
      dma-buf: heaps: coherent: Turn heap into a module

John Stultz (1):
      dma-buf: dma-heap: Keep track of the heap device struct

 drivers/dma-buf/dma-heap.c            | 138 +++++++++--
 drivers/dma-buf/heaps/Kconfig         |   9 +
 drivers/dma-buf/heaps/Makefile        |   1 +
 drivers/dma-buf/heaps/coherent_heap.c | 417 ++++++++++++++++++++++++++++++++++
 drivers/of/of_reserved_mem.c          |  68 ++++--
 include/linux/dma-heap.h              |   5 +
 include/linux/dma-map-ops.h           |   7 +
 include/linux/of_reserved_mem.h       |   8 +
 kernel/dma/coherent.c                 |  34 +++
 9 files changed, 640 insertions(+), 47 deletions(-)
---
base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
change-id: 20260223-b4-dmabuf-heap-coherent-rmem-91fd3926afe9

Best regards,
-- 
Albert Esteve <aesteve@redhat.com>

