Return-Path: <SRS0=cSHS=77=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DF4DC433E2
	for <iommu@archiver.kernel.org>; Thu, 18 Jun 2020 15:40:28 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 646E420890
	for <iommu@archiver.kernel.org>; Thu, 18 Jun 2020 15:40:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Ag9q+tFW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 646E420890
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 4D0E288893;
	Thu, 18 Jun 2020 15:40:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ph3Lu2kY0S0y; Thu, 18 Jun 2020 15:40:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id E4AA98890A;
	Thu, 18 Jun 2020 15:40:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CB90FC089E;
	Thu, 18 Jun 2020 15:40:20 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1C4B8C088C
 for <iommu@lists.linux-foundation.org>; Thu, 18 Jun 2020 15:40:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 1133688882
 for <iommu@lists.linux-foundation.org>; Thu, 18 Jun 2020 15:40:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YkktkxI-xGS4 for <iommu@lists.linux-foundation.org>;
 Thu, 18 Jun 2020 15:40:17 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com
 [210.118.77.12])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 9867D88847
 for <iommu@lists.linux-foundation.org>; Thu, 18 Jun 2020 15:40:17 +0000 (UTC)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20200618154014euoutp025739162ad91f7467463d78a8137d9273~ZrZjAmSkt1314813148euoutp02s
 for <iommu@lists.linux-foundation.org>; Thu, 18 Jun 2020 15:40:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20200618154014euoutp025739162ad91f7467463d78a8137d9273~ZrZjAmSkt1314813148euoutp02s
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1592494814;
 bh=wHz+1oT1mS/67aiyQy0jjk1GsbyT14KOgyDUgQzHDZU=;
 h=From:To:Cc:Subject:Date:References:From;
 b=Ag9q+tFWmDXhDm2cIUIZjsvXfGhdYVHowynuAxfDQ8wtbhFc6ftvZtjuBJsH2AQjj
 ELn5z6fTZnb8tkdkejgLfKWe2woE+MTd2DIGBO8Rkx7ckrUMsrUuQcOlUz3+TKNwZe
 zLr5cwUZ8/9+m4+ACGXbBzGjaeH3zzVCKzNL1lKA=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTP id
 20200618154014eucas1p1750552d5d5fd172efdc4726bcfe4d745~ZrZitQfH_0074000740eucas1p1t;
 Thu, 18 Jun 2020 15:40:14 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges2new.samsung.com (EUCPMTA) with SMTP id 4A.CE.60679.EDA8BEE5; Thu, 18
 Jun 2020 16:40:14 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20200618154014eucas1p236960ab27d628f94d68a6b8ddb8b07ff~ZrZiS_kei0608806088eucas1p2J;
 Thu, 18 Jun 2020 15:40:14 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20200618154014eusmtrp29d2b3c5366f970ed2dd895b043a9f389~ZrZiSTB2S0399203992eusmtrp2O;
 Thu, 18 Jun 2020 15:40:14 +0000 (GMT)
X-AuditID: cbfec7f4-0e5ff7000001ed07-16-5eeb8ade86ee
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
 eusmgms1.samsung.com (EUCPMTA) with SMTP id AE.DE.08375.DDA8BEE5; Thu, 18
 Jun 2020 16:40:13 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20200618154013eusmtip14d3be64110190393ab466c1b0ffef720~ZrZhr5eCw0864308643eusmtip1E;
 Thu, 18 Jun 2020 15:40:13 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 00/36] DRM: fix struct sg_table nents vs. orig_nents misuse
Date: Thu, 18 Jun 2020 17:39:21 +0200
Message-Id: <20200618153956.29558-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrBKsWRmVeSWpSXmKPExsWy7djPc7r3ul7HGfycKGXRe+4kk8XGGetZ
 Lf5vm8hsceXrezaLlauPMlks2G9t8eXKQyaLTY+vsVpc3jWHzWLtkbvsFgc/PGF14PZYM28N
 o8febwtYPLZ/e8Dqcb/7OJPH5iX1Hrf/PWb2mHxjOaPH7psNbB59W1YxenzeJBfAFcVlk5Ka
 k1mWWqRvl8CV8ejLVdaCNr+Kc5+9Gxgn2HUxcnJICJhIHHm9k6mLkYtDSGAFo0Tz6RlMIAkh
 gS+MEvMP5kIkPjNKHDuzmAWm4337RmaIxHJGiZO370G1A3Ucub+bGaSKTcBQouttFxuILSLQ
 yihxopcHxGYWmMEkcfR1KYgtLBAgMWfBVLB6FgFViTUPvoKt5hWwlWjc8ZwJYpu8xOoNB5gh
 4oISJ2c+YYGYIy/RvHU22BUSAqfYJV5++88I0eAice7jVahmYYlXx7ewQ9gyEv93zmeCaGhm
 lHh4bi07hNPDKHG5aQZUt7XEnXO/gM7mAFqhKbF+lz6IKSHgKLH7gxSEySdx460gxA18EpO2
 TWeGCPNKdLQJQcxQk5h1fB3c1oMXLjFD2B4SZ3d1s0BCN1Zi9fNm9gmMCrOQfDYLyWezEE5Y
 wMi8ilE8tbQ4Nz212CgvtVyvODG3uDQvXS85P3cTIzB9nf53/MsOxl1/kg4xCnAwKvHwvgh5
 HSfEmlhWXJl7iFGCg1lJhNfp7Ok4Id6UxMqq1KL8+KLSnNTiQ4zSHCxK4rzGi17GCgmkJ5ak
 ZqemFqQWwWSZODilGhjzm25PVC1mr8r4pbtG6I/+90wbFaYnHFN4L7Sp3Iv8Lz5/7Q/7iXJ6
 u0T/r9+nFu/d+Ep9VuW/Q17acnrGDaFqPs0FbhZtbcIelmou7PaF77b7+v1UKy9YJroj4Jrw
 S/5N/+5cX7s2v3OCubZA3pv/MpIqzDZNfaxXXn9endn082UQs6TeNyWW4oxEQy3mouJEAH47
 1ANbAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrOIsWRmVeSWpSXmKPExsVy+t/xu7p3u17HGSzbZGXRe+4kk8XGGetZ
 Lf5vm8hsceXrezaLlauPMlks2G9t8eXKQyaLTY+vsVpc3jWHzWLtkbvsFgc/PGF14PZYM28N
 o8febwtYPLZ/e8Dqcb/7OJPH5iX1Hrf/PWb2mHxjOaPH7psNbB59W1YxenzeJBfAFaVnU5Rf
 WpKqkJFfXGKrFG1oYaRnaGmhZ2RiqWdobB5rZWSqpG9nk5Kak1mWWqRvl6CX8ejLVdaCNr+K
 c5+9Gxgn2HUxcnJICJhIvG/fyNzFyMUhJLCUUaLtwgVmiISMxMlpDawQtrDEn2tdbBBFnxgl
 9na+ZwNJsAkYSnS9hUiICHQySkzr/sgO4jALzGOSWPTwEDtIlbCAn8THbQ/BxrIIqEqsefCV
 CcTmFbCVaNzxnAlihbzE6g0HmCHighInZz5h6WLkABqkLrF+nhBImBmopHnrbOYJjPyzkFTN
 QqiahaRqASPzKkaR1NLi3PTcYkO94sTc4tK8dL3k/NxNjMBI23bs5+YdjJc2Bh9iFOBgVOLh
 fRHyOk6INbGsuDL3EKMEB7OSCK/T2dNxQrwpiZVVqUX58UWlOanFhxhNgV6YyCwlmpwPTAJ5
 JfGGpobmFpaG5sbmxmYWSuK8HQIHY4QE0hNLUrNTUwtSi2D6mDg4pRoY+Xvypjz8yL1jizJv
 uUT+Yt73029yXVxvejBv1U4e6VevtRVuhs6abJKoW9Xeq6+1NujC750dJZzeBjxek+NVJkZX
 1B8S8QsXa/jo/Gb++74JnR7lKzm/1sxRfbGoW+lmkcNZiamhbv1tFvz/JjoLaVTquPyIie0U
 eb20m29jmVgMZ9tZ/kIlluKMREMt5qLiRAC9LcEoygIAAA==
X-CMS-MailID: 20200618154014eucas1p236960ab27d628f94d68a6b8ddb8b07ff
X-Msg-Generator: CA
X-RootMTR: 20200618154014eucas1p236960ab27d628f94d68a6b8ddb8b07ff
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200618154014eucas1p236960ab27d628f94d68a6b8ddb8b07ff
References: <CGME20200618154014eucas1p236960ab27d628f94d68a6b8ddb8b07ff@eucas1p2.samsung.com>
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

Patches are based on top of Linux next-20200618. The required changes to
DMA-mapping framework has been already merged to v5.8-rc1.

If possible I would like ask for merging most of the patches via DRM
tree.

Best regards,
Marek Szyprowski


References:

[1] https://lkml.org/lkml/2020/3/27/555
[2] https://lkml.org/lkml/2020/3/29/65
[3] Documentation/DMA-API-HOWTO.txt
[4] https://lore.kernel.org/linux-iommu/20200512121931.GD20393@lst.de/T/#ma18c958a48c3b241d5409517fa7d192eef87459b

Changelog:

v6:
- rebased onto Linux next-20200618, which is based on v5.8-rc1; fixed conflicts

v5: https://lore.kernel.org/linux-iommu/20200513132114.6046-1-m.szyprowski@samsung.com/T/
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

Marek Szyprowski (36):
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
  drm: xen: fix common struct sg_table related issues

 drivers/dma-buf/heaps/heap-helpers.c          | 13 ++-
 drivers/dma-buf/udmabuf.c                     |  7 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c   |  6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       |  9 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c  |  8 +-
 drivers/gpu/drm/armada/armada_gem.c           | 12 +--
 drivers/gpu/drm/drm_cache.c                   |  2 +-
 drivers/gpu/drm/drm_gem_cma_helper.c          | 23 +----
 drivers/gpu/drm/drm_gem_shmem_helper.c        | 14 +--
 drivers/gpu/drm/drm_prime.c                   | 86 ++++++++++---------
 drivers/gpu/drm/etnaviv/etnaviv_gem.c         | 12 ++-
 drivers/gpu/drm/etnaviv/etnaviv_mmu.c         | 13 +--
 drivers/gpu/drm/exynos/exynos_drm_g2d.c       | 10 +--
 drivers/gpu/drm/exynos/exynos_drm_gem.c       | 23 +----
 drivers/gpu/drm/i915/gem/i915_gem_dmabuf.c    | 11 +--
 .../gpu/drm/i915/gem/selftests/mock_dmabuf.c  |  7 +-
 drivers/gpu/drm/lima/lima_gem.c               | 11 ++-
 drivers/gpu/drm/lima/lima_vm.c                |  5 +-
 drivers/gpu/drm/mediatek/mtk_drm_gem.c        | 37 ++------
 drivers/gpu/drm/msm/msm_gem.c                 | 13 ++-
 drivers/gpu/drm/msm/msm_gpummu.c              | 14 ++-
 drivers/gpu/drm/msm/msm_iommu.c               |  2 +-
 drivers/gpu/drm/omapdrm/omap_gem.c            | 20 ++---
 drivers/gpu/drm/panfrost/panfrost_gem.c       |  4 +-
 drivers/gpu/drm/panfrost/panfrost_mmu.c       |  7 +-
 drivers/gpu/drm/radeon/radeon_ttm.c           | 11 ++-
 drivers/gpu/drm/rcar-du/rcar_du_vsp.c         |  3 +-
 drivers/gpu/drm/rockchip/rockchip_drm_gem.c   | 42 +++------
 drivers/gpu/drm/tegra/gem.c                   | 27 +++---
 drivers/gpu/drm/tegra/plane.c                 | 15 ++--
 drivers/gpu/drm/v3d/v3d_mmu.c                 | 17 ++--
 drivers/gpu/drm/virtio/virtgpu_object.c       | 36 ++++----
 drivers/gpu/drm/virtio/virtgpu_vq.c           | 12 ++-
 drivers/gpu/drm/vmwgfx/vmwgfx_ttm_buffer.c    | 17 +---
 drivers/gpu/drm/xen/xen_drm_front_gem.c       |  2 +-
 drivers/gpu/host1x/job.c                      | 22 ++---
 .../common/videobuf2/videobuf2-dma-contig.c   | 41 ++++-----
 .../media/common/videobuf2/videobuf2-dma-sg.c | 32 +++----
 .../common/videobuf2/videobuf2-vmalloc.c      | 12 +--
 drivers/media/pci/cx23885/cx23885-alsa.c      |  2 +-
 drivers/media/pci/cx25821/cx25821-alsa.c      |  2 +-
 drivers/media/pci/cx88/cx88-alsa.c            |  2 +-
 drivers/media/pci/saa7134/saa7134-alsa.c      |  2 +-
 drivers/media/platform/vsp1/vsp1_drm.c        |  8 +-
 drivers/misc/fastrpc.c                        |  4 +-
 drivers/rapidio/devices/rio_mport_cdev.c      |  8 +-
 drivers/staging/android/ion/ion.c             | 25 +++---
 drivers/staging/android/ion/ion.h             |  1 -
 drivers/staging/android/ion/ion_heap.c        | 53 +++---------
 drivers/staging/android/ion/ion_system_heap.c |  2 +-
 drivers/staging/media/tegra-vde/iommu.c       |  4 +-
 drivers/xen/gntdev-dmabuf.c                   | 13 ++-
 include/drm/drm_prime.h                       |  2 +
 samples/vfio-mdev/mbochs.c                    |  3 +-
 54 files changed, 311 insertions(+), 478 deletions(-)

-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
