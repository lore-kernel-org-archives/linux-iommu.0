Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166541C5D44;
	Wed, 25 Feb 2026 16:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772037717; cv=none; b=XPclbHWdXTrK6ngJs6ZvkTA4wnRytGGcA2/4ISBdMZhSuh/2M1r+ydobpwnshTrcO/4jOpwHhMQRsfNS355yGWh+os5lkw1pc77TqCdQCnsF+HViJzwcyBz+vXHx6LZpIVnb94EDI2cLzk4XTOwCmbP7uDMXIs9whVrzFaNP3KU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772037717; c=relaxed/simple;
	bh=RsGWTxEf7XecP10VMIRwvUSVG8Qsr83RzrgZ5IzF8FI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ZZIAI6TBWA5XFbl1SLgR2uSdVLbxs3apRgmoaung1N7dKEiD7uBrg4uIdmPCKYgZRehaAvkUTq4Rgz0rCCJaIJL/NoPcfG1Rbg/k4O1zY5GEOr7Ji5hwiPBZWptZLrvl1mGG5CIB0Yp/IDNJHF8kKmOWkY6oijAKJs0DZSjxExY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n+xg12JP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n+xg12JP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3297DC116D0;
	Wed, 25 Feb 2026 16:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772037716;
	bh=RsGWTxEf7XecP10VMIRwvUSVG8Qsr83RzrgZ5IzF8FI=;
	h=From:Subject:Date:To:Cc:From;
	b=n+xg12JPezepMjFSTJolxFs8rNtU/+FapKmNzxdb/yaHfCvOEPJ6mOianSuwJ3HB4
	 jE3Ot5ZU6GHmh11K/S+fwE9WMB6m+Vwp8SokCYu1VmKfKN8aR3eIuhv8R3ybaKjmv0
	 efD4dDCcFNqnMcb/eORXibFrZdR7YGUy+z9AKrSPdZpzcx+qh+1SLmvXULdYsGx3BT
	 lIFy6l+hpnInUBMIomFEw0v7FdyjjUcLg7GjjG3HE2J2UAvtjb9xdMjipwGGgLNiGh
	 XaNqsaakVso0/STbFhI6IO0+eqrYd7vRP3dHDYicVFqkj7cQOyLOoxk5pNOvFOOtw3
	 +vMLUKA5T16mg==
From: Maxime Ripard <mripard@kernel.org>
Subject: [PATCH 0/7] dma-buf: heaps: Turn heaps into modules
Date: Wed, 25 Feb 2026 17:41:48 +0100
Message-Id: <20260225-dma-buf-heaps-as-modules-v1-0-2109225a090d@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MywqEMAxA0V+RrA3U+ADnVwYX0aYa8EVDhwHx3
 y0uz+LeC0yiisGnuCDKT02PPaMqC5gW3mdB9dlAjjpH1KLfGMcUcBE+DdlwO3xaxbBydTPWMvW
 BGHJ+Rgn6f9ff4b4fj1bsG2oAAAA=
X-Change-ID: 20260225-dma-buf-heaps-as-modules-1034b3ec9f2a
To: Sumit Semwal <sumit.semwal@linaro.org>, 
 Benjamin Gaignard <benjamin.gaignard@collabora.com>, 
 Brian Starkey <Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>, 
 "T.J. Mercier" <tjmercier@google.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Robin Murphy <robin.murphy@arm.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, 
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, 
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>
Cc: linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org, 
 iommu@lists.linux.dev, linux-mm@kvack.org, 
 Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1658; i=mripard@kernel.org;
 h=from:subject:message-id; bh=RsGWTxEf7XecP10VMIRwvUSVG8Qsr83RzrgZ5IzF8FI=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDJnz1fxsJSoPiF0/6nFZ8aiH50IR++QHe2acfuV99o3Ur
 b8ySw/bd0xlYRDmZJAVU2R5IhN2enn74ioH+5U/YOawMoEMYeDiFICJmGxgrK+6GlaicfGcTlM7
 j1HSN+2aLWFpC6+58f3Ksl4fWK82++OBaXObyvu/3GDf+lfy4bsblxjrlDyEk+dOmTt1f4tlj+L
 D544WizcUfH6/eWZLdt9O3qyk3guqU24edFvzLdMucMm8krc+AA==
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D

Hi,

The recent introduction of heaps in the optee driver [1] made possible
the creation of heaps as modules.

It's generally a good idea if possible, including for the already
existing system and CMA heaps.

The system one is pretty trivial, the CMA one is a bit more involved,
especially since we have a call from kernel/dma/contiguous.c to the CMA
heap code. This was solved by turning the logic around and making the
CMA heap call into the contiguous DMA code.

Let me know what you think,
Maxime

1: https://lore.kernel.org/dri-devel/20250911135007.1275833-4-jens.wiklander@linaro.org/

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Maxime Ripard (7):
      dma: contiguous: Turn heap registration logic around
      mm: cma: Export cma_alloc and cma_release
      mm: cma: Export cma_get_name
      mm: cma: Export dma_contiguous_default_area
      dma-buf: heaps: Export mem_accounting parameter
      dma-buf: heaps: cma: Turn the heap into a module
      dma-buf: heaps: system: Turn the heap into a module

 drivers/dma-buf/dma-heap.c          |  1 +
 drivers/dma-buf/heaps/Kconfig       |  4 ++--
 drivers/dma-buf/heaps/cma_heap.c    | 21 +++++----------------
 drivers/dma-buf/heaps/system_heap.c |  5 +++++
 include/linux/dma-map-ops.h         |  5 +++++
 kernel/dma/contiguous.c             | 27 +++++++++++++++++++++++++--
 mm/cma.c                            |  3 +++
 7 files changed, 46 insertions(+), 20 deletions(-)
---
base-commit: 499a718536dc0e1c1d1b6211847207d58acd9916
change-id: 20260225-dma-buf-heaps-as-modules-1034b3ec9f2a

Best regards,
-- 
Maxime Ripard <mripard@kernel.org>

