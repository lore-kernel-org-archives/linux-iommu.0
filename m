Return-Path: <SRS0=oi3Z=63=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75B29CA90AF
	for <iommu@archiver.kernel.org>; Wed, 13 May 2020 13:21:47 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C78D220639
	for <iommu@archiver.kernel.org>; Wed, 13 May 2020 13:21:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="XlVjIKjT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C78D220639
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 0B19F88D58;
	Wed, 13 May 2020 13:21:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Tbtku4W1q+bj; Wed, 13 May 2020 13:21:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 54AC08848A;
	Wed, 13 May 2020 13:21:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 36511C0178;
	Wed, 13 May 2020 13:21:36 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A5856C016F
 for <iommu@lists.linux-foundation.org>; Wed, 13 May 2020 13:21:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 9B4EC877CE
 for <iommu@lists.linux-foundation.org>; Wed, 13 May 2020 13:21:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id E5pvVV2uxQj5 for <iommu@lists.linux-foundation.org>;
 Wed, 13 May 2020 13:21:31 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com
 [210.118.77.11])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 8180687746
 for <iommu@lists.linux-foundation.org>; Wed, 13 May 2020 13:21:31 +0000 (UTC)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20200513132128euoutp01d97d975973cdb18a4a596e46eb8bbd85~OmSHCv-ZG0989009890euoutp01R
 for <iommu@lists.linux-foundation.org>; Wed, 13 May 2020 13:21:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20200513132128euoutp01d97d975973cdb18a4a596e46eb8bbd85~OmSHCv-ZG0989009890euoutp01R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1589376088;
 bh=oAdWpO0OwDar89lnCe1nXsi9/U2Uqxr7Yci3HUGRsgE=;
 h=From:To:Cc:Subject:Date:References:From;
 b=XlVjIKjTKVjrO+6al/1va0XSqf8GfzHFhvxFnQJEfn92vs+VL98uRGO4Q+VvCo1yA
 n/nJYsaPgq1Wd1jZd7MRomKIHdgh4ZCcOP3i8OQAes7bJOoXI5IOK8FQ3O3dEoScYa
 E4yExYxwyEFHo7EBLZcL/8ZAyFuPiQQg5IuVxrUU=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20200513132128eucas1p2b8e9b1f82b612b9d5192d834a7b6e267~OmSGp5bAo2225522255eucas1p2V;
 Wed, 13 May 2020 13:21:28 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
 eusmges3new.samsung.com (EUCPMTA) with SMTP id 21.F6.60698.854FBBE5; Wed, 13
 May 2020 14:21:28 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20200513132127eucas1p23f6be10bbd627e69e36d2451068b3204~OmSGL_yBk3112531125eucas1p2P;
 Wed, 13 May 2020 13:21:27 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20200513132127eusmtrp144b961a7019ee08baa18612324dad8b0~OmSGLTbWi0221602216eusmtrp1T;
 Wed, 13 May 2020 13:21:27 +0000 (GMT)
X-AuditID: cbfec7f5-a0fff7000001ed1a-c2-5ebbf45832d4
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id EF.45.07950.754FBBE5; Wed, 13
 May 2020 14:21:27 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20200513132127eusmtip1bc53dfd19eb0966af5c64d700e7476a1~OmSFsg8N_2465624656eusmtip1y;
 Wed, 13 May 2020 13:21:27 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 00/38] DRM: fix struct sg_table nents vs. orig_nents misuse
Date: Wed, 13 May 2020 15:21:14 +0200
Message-Id: <20200513132114.6046-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJKsWRmVeSWpSXmKPExsWy7djP87oRX3bHGTQuEbXoPXeSyWLjjPWs
 Fv+3TWS2uPL1PZvFytVHmSwW7Le2+HLlIZPFpsfXWC0u75rDZrH2yF12i4MfnrA6cHusmbeG
 0WPvtwUsHtu/PWD1uN99nMlj85J6j9v/HjN7TL6xnNFj980GNo++LasYPT5vkgvgiuKySUnN
 ySxLLdK3S+DKuLX3LVPB+cCKNf9+MTYwdtt3MXJySAiYSGz43szWxcjFISSwglHixvyf7BDO
 F0aJJXveMkI4nxklpj38xwLTcv7baqjEckaJhn0TWOBaZl5aygRSxSZgKNH1tosNxBYRaGWU
 ONHLA2IzC8xgkjj6uhTEFhYIkJiyYzYjiM0ioCox89s3ZhCbV8BGYtePl1Db5CVWbzgAFReU
 ODnzCQvEHHmJ5q2zmSFqjrFLXN9i28XIAWS7SOyfwgMRFpZ4dXwLO4QtI3F6cg/YnRICzYwS
 D8+tZYdwehglLjfNYISospa4c+4XG8ggZgFNifW79CHCjhIft2xngpjPJ3HjrSDECXwSk7ZN
 Z4YI80p0tAlBVKtJzDq+Dm7twQuXoK70kHhz5h2YLSQQK9G47xvjBEaFWUgem4XksVkINyxg
 ZF7FKJ5aWpybnlpsnJdarlecmFtcmpeul5yfu4kRmMBO/zv+dQfjvj9JhxgFOBiVeHgfXN8d
 J8SaWFZcmXuIUYKDWUmE1289UIg3JbGyKrUoP76oNCe1+BCjNAeLkjiv8aKXsUIC6Yklqdmp
 qQWpRTBZJg5OqQbGI3KPL/4Rmho8TYHrlfuqHvGnn9ZN3b9E7teW88UNxtXLEpO9S4Xkau5d
 /HuKadnuuF13Hlp+FzA/LXZs5mOh+vTb7wqXZzT+mCmY2NdgZT/ZSmAR51z3Q10fSo3srD3i
 o6T4nzb95Wn0z5XN1nD4d1lbal9ncz6vgbObf0B/yfeGOX9l2qcosRRnJBpqMRcVJwIAhSjR
 ElwDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrBIsWRmVeSWpSXmKPExsVy+t/xu7rhX3bHGRzuN7LoPXeSyWLjjPWs
 Fv+3TWS2uPL1PZvFytVHmSwW7Le2+HLlIZPFpsfXWC0u75rDZrH2yF12i4MfnrA6cHusmbeG
 0WPvtwUsHtu/PWD1uN99nMlj85J6j9v/HjN7TL6xnNFj980GNo++LasYPT5vkgvgitKzKcov
 LUlVyMgvLrFVija0MNIztLTQMzKx1DM0No+1MjJV0rezSUnNySxLLdK3S9DLuLX3LVPB+cCK
 Nf9+MTYwdtt3MXJySAiYSJz/tpqxi5GLQ0hgKaPE06O3WSESMhInpzVA2cISf651sUEUfWKU
 WPy+nQUkwSZgKNH1FiIhItDJKDGt+yM7iMMsMI9JYtHDQ+wgVcICfhIXTz8Cs1kEVCVmfvvG
 DGLzCthI7PrxkgVihbzE6g0HoOKCEidnPgGKcwANUpdYP08IJMwMVNK8dTbzBEb+WUiqZiFU
 zUJStYCReRWjSGppcW56brGRXnFibnFpXrpecn7uJkZgrG079nPLDsaud8GHGAU4GJV4eC1u
 7Y4TYk0sK67MPcQowcGsJMLrtx4oxJuSWFmVWpQfX1Sak1p8iNEU6IWJzFKiyfnANJBXEm9o
 amhuYWlobmxubGahJM7bIXAwRkggPbEkNTs1tSC1CKaPiYNTqoFxX+BPTYmZU5kqCgWbvz5O
 bptytdrOePWbfm61Sa4P0xm+tSs0zje9KbNBafnGy3Fl71fMFLhxmmN7rmXjrysm5aJP/auq
 5l49eCMzO+vHhpyLlicu6VV/3rbubuHcgLu8OZ7KDrxvl88o+Ny73/7bvlf37rHMadiyo9pe
 4IBoz0wL6/cz/JbuUWIpzkg01GIuKk4EAI32hcjLAgAA
X-CMS-MailID: 20200513132127eucas1p23f6be10bbd627e69e36d2451068b3204
X-Msg-Generator: CA
X-RootMTR: 20200513132127eucas1p23f6be10bbd627e69e36d2451068b3204
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200513132127eucas1p23f6be10bbd627e69e36d2451068b3204
References: <CGME20200513132127eucas1p23f6be10bbd627e69e36d2451068b3204@eucas1p2.samsung.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>,
 linux-arm-kernel@lists.infradead.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Dear All,

During the Exynos DRM GEM rework and fixing the issues in the.
drm_prime_sg_to_page_addr_arrays() function [1] I've noticed that most
drivers in DRM framework incorrectly use nents and orig_nents entries of
the struct sg_table.

In case of the most DMA-mapping implementations exchanging those two
entries or using nents for all loops on the scatterlist is harmless,
because they both have the same value. There exists however a DMA-mapping
implementations, for which such incorrect usage breaks things. The nents
returned by dma_map_sg() might be lower than the nents passed as its
parameter and this is perfectly fine. DMA framework or IOMMU is allowed
to join consecutive chunks while mapping if such operation is supported
by the underlying HW (bus, bridge, IOMMU, etc). Example of the case
where dma_map_sg() might return 1 'DMA' chunk for the 4 'physical' pages
is described here [2]

The DMA-mapping framework documentation [3] states that dma_map_sg()
returns the numer of the created entries in the DMA address space.
However the subsequent calls to dma_sync_sg_for_{device,cpu} and
dma_unmap_sg must be called with the original number of entries passed to
dma_map_sg. The common pattern in DRM drivers were to assign the
dma_map_sg() return value to sg_table->nents and use that value for
the subsequent calls to dma_sync_sg_* or dma_unmap_sg functions. Also
the code iterated over nents times to access the pages stored in the
processed scatterlist, while it should use orig_nents as the numer of
the page entries.

I've tried to identify all such incorrect usage of sg_table->nents and
this is a result of my research. It looks that the incorrect pattern has
been copied over the many drivers mainly in the DRM subsystem. Too bad in
most cases it even worked correctly if the system used a simple, linear
DMA-mapping implementation, for which swapping nents and orig_nents
doesn't make any difference. To avoid similar issues in the future, I've
introduced a common wrappers for DMA-mapping calls, which operate directly
on the sg_table objects. I've also added wrappers for iterating over the
scatterlists stored in the sg_table objects and applied them where
possible. This, together with some common DRM prime helpers, allowed me
to almost get rid of all nents/orig_nents usage in the drivers. I hope
that such change makes the code robust, easier to follow and copy/paste
safe.

The biggest TODO is DRM/i915 driver and I don't feel brave enough to fix
it fully. The driver creatively uses sg_table->orig_nents to store the
size of the allocate scatterlist and ignores the number of the entries
returned by dma_map_sg function. In this patchset I only fixed the
sg_table objects exported by dmabuf related functions. I hope that I
didn't break anything there.

Patches are based on top of Linux next-20200512.

Christoph Hellwig already offered to take patches 1-3 into his immutable
branch [4]. If possible I would like ask for merging most of the
remaining patches via DRM tree (on top of that immutable branch).

Best regards,
Marek Szyprowski


References:

[1] https://lkml.org/lkml/2020/3/27/555
[2] https://lkml.org/lkml/2020/3/29/65
[3] Documentation/DMA-API-HOWTO.txt
[4] https://lore.kernel.org/linux-iommu/20200512121931.GD20393@lst.de/T/#ma18c958a48c3b241d5409517fa7d192eef87459b

Changelog:

v5:
- fixed some minor style issues and typos
- fixed lack of the attrs argument in ion, dmabuf, rapidio, fastrpc and
  vfio patches

v4: https://lore.kernel.org/linux-iommu/20200512121931.GD20393@lst.de/T/
- added for_each_sgtable_* wrappers and applied where possible
- added drm_prime_get_contiguous_size() and applied where possible
- applied drm_prime_sg_to_page_addr_arrays() where possible to remove page
  extraction from sg_table objects
- added documentation for the introduced wrappers
- improved patches description a bit

v3: https://lore.kernel.org/dri-devel/20200505083926.28503-1-m.szyprowski@samsung.com/
- introduce dma_*_sgtable_* wrappers and use them in all patches

v2: https://lore.kernel.org/linux-iommu/c01c9766-9778-fd1f-f36e-2dc7bd376ba4@arm.com/T/
- dropped most of the changes to drm/i915
- added fixes for rcar-du, xen, media and ion
- fixed a few issues pointed by kbuild test robot
- added wide cc: list for each patch

v1: https://lore.kernel.org/linux-iommu/c01c9766-9778-fd1f-f36e-2dc7bd376ba4@arm.com/T/
- initial version


Patch summary:

Marek Szyprowski (38):
  dma-mapping: add generic helpers for mapping sgtable objects
  scatterlist: add generic wrappers for iterating over sgtable objects
  iommu: add generic helper for mapping sgtable objects
  drm: prime: add common helper to check scatterlist contiguity
  drm: prime: use sgtable iterators in
    drm_prime_sg_to_page_addr_arrays()
  drm: core: fix common struct sg_table related issues
  drm: amdgpu: fix common struct sg_table related issues
  drm: armada: fix common struct sg_table related issues
  drm: etnaviv: fix common struct sg_table related issues
  drm: exynos: use common helper for a scatterlist contiguity check
  drm: exynos: fix common struct sg_table related issues
  drm: i915: fix common struct sg_table related issues
  drm: lima: fix common struct sg_table related issues
  drm: mediatek: use common helper for a scatterlist contiguity check
  drm: mediatek: use common helper for extracting pages array
  drm: msm: fix common struct sg_table related issues
  drm: omapdrm: use common helper for extracting pages array
  drm: omapdrm: fix common struct sg_table related issues
  drm: panfrost: fix common struct sg_table related issues
  drm: radeon: fix common struct sg_table related issues
  drm: rockchip: use common helper for a scatterlist contiguity check
  drm: rockchip: fix common struct sg_table related issues
  drm: tegra: fix common struct sg_table related issues
  drm: v3d: fix common struct sg_table related issues
  drm: virtio: fix common struct sg_table related issues
  drm: vmwgfx: fix common struct sg_table related issues
  xen: gntdev: fix common struct sg_table related issues
  drm: host1x: fix common struct sg_table related issues
  drm: rcar-du: fix common struct sg_table related issues
  dmabuf: fix common struct sg_table related issues
  staging: ion: remove dead code
  staging: ion: fix common struct sg_table related issues
  staging: tegra-vde: fix common struct sg_table related issues
  misc: fastrpc: fix common struct sg_table related issues
  rapidio: fix common struct sg_table related issues
  samples: vfio-mdev/mbochs: fix common struct sg_table related issues
  media: pci: fix common ALSA DMA-mapping related codes
  videobuf2: use sgtable-based scatterlist wrappers

 drivers/dma-buf/heaps/heap-helpers.c               | 13 ++--
 drivers/dma-buf/udmabuf.c                          |  7 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c        |  6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c            |  9 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c       |  8 +-
 drivers/gpu/drm/armada/armada_gem.c                | 12 +--
 drivers/gpu/drm/drm_cache.c                        |  2 +-
 drivers/gpu/drm/drm_gem_cma_helper.c               | 23 +-----
 drivers/gpu/drm/drm_gem_shmem_helper.c             | 14 ++--
 drivers/gpu/drm/drm_prime.c                        | 86 ++++++++++++----------
 drivers/gpu/drm/etnaviv/etnaviv_gem.c              | 12 ++-
 drivers/gpu/drm/etnaviv/etnaviv_mmu.c              | 13 +---
 drivers/gpu/drm/exynos/exynos_drm_g2d.c            | 10 +--
 drivers/gpu/drm/exynos/exynos_drm_gem.c            | 23 +-----
 drivers/gpu/drm/i915/gem/i915_gem_dmabuf.c         | 11 +--
 drivers/gpu/drm/i915/gem/selftests/mock_dmabuf.c   |  7 +-
 drivers/gpu/drm/lima/lima_gem.c                    | 11 ++-
 drivers/gpu/drm/lima/lima_vm.c                     |  5 +-
 drivers/gpu/drm/mediatek/mtk_drm_gem.c             | 34 ++-------
 drivers/gpu/drm/msm/msm_gem.c                      | 13 ++--
 drivers/gpu/drm/msm/msm_gpummu.c                   | 14 ++--
 drivers/gpu/drm/msm/msm_iommu.c                    |  2 +-
 drivers/gpu/drm/omapdrm/omap_gem.c                 | 20 ++---
 drivers/gpu/drm/panfrost/panfrost_gem.c            |  4 +-
 drivers/gpu/drm/panfrost/panfrost_mmu.c            |  7 +-
 drivers/gpu/drm/radeon/radeon_ttm.c                | 11 ++-
 drivers/gpu/drm/rcar-du/rcar_du_vsp.c              |  3 +-
 drivers/gpu/drm/rockchip/rockchip_drm_gem.c        | 42 +++--------
 drivers/gpu/drm/tegra/gem.c                        | 27 +++----
 drivers/gpu/drm/tegra/plane.c                      | 15 ++--
 drivers/gpu/drm/v3d/v3d_mmu.c                      | 17 ++---
 drivers/gpu/drm/virtio/virtgpu_object.c            | 36 +++++----
 drivers/gpu/drm/virtio/virtgpu_vq.c                | 12 ++-
 drivers/gpu/drm/vmwgfx/vmwgfx_ttm_buffer.c         | 17 +----
 drivers/gpu/host1x/job.c                           | 22 ++----
 .../media/common/videobuf2/videobuf2-dma-contig.c  | 41 +++++------
 drivers/media/common/videobuf2/videobuf2-dma-sg.c  | 32 +++-----
 drivers/media/common/videobuf2/videobuf2-vmalloc.c | 12 +--
 drivers/media/pci/cx23885/cx23885-alsa.c           |  2 +-
 drivers/media/pci/cx25821/cx25821-alsa.c           |  2 +-
 drivers/media/pci/cx88/cx88-alsa.c                 |  2 +-
 drivers/media/pci/saa7134/saa7134-alsa.c           |  2 +-
 drivers/media/platform/vsp1/vsp1_drm.c             |  8 +-
 drivers/misc/fastrpc.c                             |  4 +-
 drivers/rapidio/devices/rio_mport_cdev.c           |  8 +-
 drivers/staging/android/ion/ion.c                  | 25 +++----
 drivers/staging/android/ion/ion.h                  |  1 -
 drivers/staging/android/ion/ion_heap.c             | 53 ++++---------
 drivers/staging/android/ion/ion_system_heap.c      |  2 +-
 drivers/staging/media/tegra-vde/iommu.c            |  4 +-
 drivers/xen/gntdev-dmabuf.c                        | 13 ++--
 include/drm/drm_prime.h                            |  2 +
 include/linux/dma-mapping.h                        | 78 ++++++++++++++++++++
 include/linux/iommu.h                              | 16 ++++
 include/linux/scatterlist.h                        | 50 ++++++++++++-
 samples/vfio-mdev/mbochs.c                         |  3 +-
 56 files changed, 451 insertions(+), 477 deletions(-)

-- 
1.9.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
