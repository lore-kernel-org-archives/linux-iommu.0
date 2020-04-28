Return-Path: <SRS0=7g3a=6M=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DABAC83006
	for <iommu@archiver.kernel.org>; Tue, 28 Apr 2020 13:22:00 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 229AC206D7
	for <iommu@archiver.kernel.org>; Tue, 28 Apr 2020 13:22:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="q18JgevK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 229AC206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id E4864880D9;
	Tue, 28 Apr 2020 13:21:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nm4y5WbFCf-t; Tue, 28 Apr 2020 13:21:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 71B018815D;
	Tue, 28 Apr 2020 13:21:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5A6A3C0863;
	Tue, 28 Apr 2020 13:21:58 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DBE51C0172
 for <iommu@lists.linux-foundation.org>; Tue, 28 Apr 2020 13:21:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id B97222281E
 for <iommu@lists.linux-foundation.org>; Tue, 28 Apr 2020 13:21:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id d0G3hxT03xyh for <iommu@lists.linux-foundation.org>;
 Tue, 28 Apr 2020 13:20:25 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com
 [210.118.77.12])
 by silver.osuosl.org (Postfix) with ESMTPS id 7736422797
 for <iommu@lists.linux-foundation.org>; Tue, 28 Apr 2020 13:20:25 +0000 (UTC)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20200428132022euoutp02ae74b5ed90c87853d519e86a4e38b22e~J-l3rKM1s2883528835euoutp02F
 for <iommu@lists.linux-foundation.org>; Tue, 28 Apr 2020 13:20:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20200428132022euoutp02ae74b5ed90c87853d519e86a4e38b22e~J-l3rKM1s2883528835euoutp02F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1588080022;
 bh=M+a2IJHYb0toPVb1vAnuWVCTaP9GKRurjtQwh8AYvLw=;
 h=From:To:Cc:Subject:Date:References:From;
 b=q18JgevKqhOJFVQbq854H7EZCG5G834Ju2OsSoTZ6Bnetp9hSuSml1XgbTuO7TgP4
 R5AsmC7f+5FBYPH96fNBvK8niWEZSnBsTkYTk4AwGipw8rtIwP1p5At68Edy0CqVed
 3WAneSpyCm6lxuYsAezA6HhFWzXMWhbZPqCd2+ac=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTP id
 20200428132022eucas1p197a0e0088bb95f4bbe04e9e58b9ec827~J-l3P0VJS1366113661eucas1p1C;
 Tue, 28 Apr 2020 13:20:22 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
 eusmges3new.samsung.com (EUCPMTA) with SMTP id CE.16.60698.69D28AE5; Tue, 28
 Apr 2020 14:20:22 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20200428132022eucas1p2aa4716cbaca61c432ee8028be15fef7a~J-l2zrH2Z2655426554eucas1p2J;
 Tue, 28 Apr 2020 13:20:22 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20200428132022eusmtrp180c18efbf17c909e49ded70dd6d7a26d~J-l2y51qv1743317433eusmtrp1s;
 Tue, 28 Apr 2020 13:20:22 +0000 (GMT)
X-AuditID: cbfec7f5-a0fff7000001ed1a-6e-5ea82d96013d
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id 67.D3.07950.59D28AE5; Tue, 28
 Apr 2020 14:20:21 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
 eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20200428132021eusmtip254bc6d36e65ea6888afab346da0ccde0~J-l2NHB3X1062310623eusmtip2h;
 Tue, 28 Apr 2020 13:20:21 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: [RFC 00/17] DRM: fix struct sg_table nents vs. orig_nents misuse
Date: Tue, 28 Apr 2020 15:19:48 +0200
Message-Id: <20200428132005.21424-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSWUwTURSGc2emM8NSHKcI17qmiSSSsAWIExGiBM3gg+HJByLVCiOLtJCW
 RfBBQBQsS1AiIBJTkX0rAlYERahAESISQECWsMYEApGEVUNQhgF9+85//nP+k5tLonSdSEqG
 qqI4tUoRLsPNMUPnr68OOQ5lcufkXCmT0fsZYYr1iQTzOk8vYpKM3Tjzx/AYZQbXfuJMeWUH
 wjzPqkcY3UcPZnVwGmHqZodEzEBTAc5Ut08QTNvynIjpnlghzh9gq15UAfbDug5jx4fe4+zb
 9SkRO5lmQtj6onvs2PYsymaPlAK2+XsCzmY2VAB2pe64n4W/+bkgLjw0hlM7ed0wDykq7EEi
 k13uDBXOYgmgyE4LzEhIucGx/BVMC8xJmioD0PhoFhWKVQCHsox7xQqAqYvfsP2RjvVJlGea
 KgUwbeGQwDsTZVoLnnHKBWqXtDjP1tQDALsyLPlFKGVA4VxpO6EFJCmhfGGrPp73YNQpmF77
 cnenmPKErz5t4kLWCVhZ27p7BKRaCFi1mYgIDR+o69bumSRwwdRACHwU9mSnY8LAfQCne6sJ
 oUgHcCApDwguDzje+xvnr0Cp01Df5CTIF2BOQS3Gy5CygiNLB3kZ3cEnhlxUkMUw9SEtuO1g
 vqnmX2xbXz8qMAufjS4TwpsEwOnBEiILHM//n6UDoALYctEaZTCncVVxsY4ahVITrQp2DIxQ
 1oGdn9SzbVprBC1bN42AIoHMUlxrWSanRYoYTZzSCCCJyqzFMyElclocpIiL59QR19XR4ZzG
 CI6QmMxW7Fo4H0BTwYoo7jbHRXLq/S5CmkkTQIh4o4S2Kj0sc8+9eKbHOXu+3vdppn/K0pbS
 cbJ4Tu1ZEPbGxn7LK7B907lruKV1uDPli6vU52SjW4mNt859yl3S94472xzWu2RdnuZ3q1ke
 TM94XzGz4DInG9hjFRvXoMSrryY+1q8x7cfiaMp4R//VhEvyZWlozl1baaXDZb0M04QoXOxR
 tUbxF8W9urRFAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupikeLIzCtJLcpLzFFi42I5/e/4Pd2puiviDLZPtrboPXeSyWLp+kZ2
 i40z1rNaNB06xWbxf9tEZosrX9+zWaxcfZTJYvaEzUwWC/ZbW3y58pDJYtPja6wWl3fNYbNY
 e+Quu8XBD09YLU7d/czuwO+xZt4aRo+93xaweNy5tofNY/u3B6we97uPM3lsXlLvcfvfY2aP
 yTeWM3rsvtnA5tG3ZRWjx+dNcgHcUXo2RfmlJakKGfnFJbZK0YYWRnqGlhZ6RiaWeobG5rFW
 RqZK+nY2Kak5mWWpRfp2CXoZSxadZipoMay4tugxSwPjErUuRk4OCQETiaPf7jN3MXJxCAks
 ZZQ4MGU5E0RCRuLktAZWCFtY4s+1LjaIok+MErsPvmQHSbAJGEp0vYVIiAh0MkpM6/7IDuIw
 Cxxglug+fxJoFAeHsICnxIH1VSANLAKqEj0bFjKD2LwCthKLD/9gg9ggL7F6wwHmCYw8CxgZ
 VjGKpJYW56bnFhvpFSfmFpfmpesl5+duYgTGw7ZjP7fsYOx6F3yIUYCDUYmHdwPPijgh1sSy
 4srcQ4wSHMxKIryPMpbFCfGmJFZWpRblxxeV5qQWH2I0BVo+kVlKNDkfGKt5JfGGpobmFpaG
 5sbmxmYWSuK8HQIHY4QE0hNLUrNTUwtSi2D6mDg4pRoYhXk/zvWJKDx1vkLkWfHZ818iX3NW
 ZKbWSza8WzYh/4KNtC+z/4bQzU9msTd9msDdGH70I4vtD82ZP/fYT5ptVexQyRVSK9l54VrY
 VJGpzts6z9zh6l3cuU1XX7N3vqn6jJb9C1k/vuJ3kHsjsnUO27OTMjtsW2784ngufm3TxguO
 0y/ZWP5hVWIpzkg01GIuKk4EAF3VAt+dAgAA
X-CMS-MailID: 20200428132022eucas1p2aa4716cbaca61c432ee8028be15fef7a
X-Msg-Generator: CA
X-RootMTR: 20200428132022eucas1p2aa4716cbaca61c432ee8028be15fef7a
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200428132022eucas1p2aa4716cbaca61c432ee8028be15fef7a
References: <CGME20200428132022eucas1p2aa4716cbaca61c432ee8028be15fef7a@eucas1p2.samsung.com>
Cc: Daniel Vetter <daniel@ffwll.ch>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 David Airlie <airlied@linux.ie>, intel-gfx@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, Christoph Hellwig <hch@lst.de>,
 Benjamin Gaignard <benjamin.gaignard@linaro.org>,
 Robin Murphy <robin.murphy@arm.com>, Sumit Semwal <sumit.semwal@linaro.org>,
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Dear All,

During the Exynos DRM GEM rework and fixing the issues in the 
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

I've tried to identify all such incorrect usage of sg_table->nents in the
DRM subsystem and this is a result of my research. It looks that the
incorrect pattern has been copied over the many drivers. Too bad in most
cases it even worked correctly if the system used simple, linear
DMA-mapping implementation, for which swapping nents and orig_nents
doesn't make any difference.

I wonder what to do to avoid such misuse in the future, as this case
clearly shows that the current sg_table structure is a bit hard to
understand. I have the following ideas and I would like to know your
opinion before I prepare more patches and check sg_table usage all over
the kernel:

1. introduce a dma_{map,sync,unmap}_sgtable() wrappers, which will use
   a proper sg_table entries and call respective DMA-mapping functions
   and adapt current code to it

2. rename nents and orig_nents to nr_pages, nr_dmas to clearly state
   which one refers to which part of the scatterlist; I'm open for
   other names for those entries

I will appreciate your comments.

Patches are based on top of Linux next-20200428. I've reduced the
recipients list mainly to mailing lists, the next version I will try to
send to the maintainers of the respective drivers.

Best regards,
Marek Szyprowski


References:

[1] https://lkml.org/lkml/2020/3/27/555 
[2] https://lkml.org/lkml/2020/3/29/65
[3] Documentation/DMA-API-HOWTO.txt


Patch summary:

Marek Szyprowski (17):
  drm: core: fix sg_table nents vs. orig_nents usage
  drm: amdgpu: fix sg_table nents vs. orig_nents usage
  drm: armada: fix sg_table nents vs. orig_nents usage
  drm: etnaviv: fix sg_table nents vs. orig_nents usage
  drm: exynos: fix sg_table nents vs. orig_nents usage
  drm: i915: fix sg_table nents vs. orig_nents usage
  drm: lima: fix sg_table nents vs. orig_nents usage
  drm: msm: fix sg_table nents vs. orig_nents usage
  drm: panfrost: fix sg_table nents vs. orig_nents usage
  drm: radeon: fix sg_table nents vs. orig_nents usage
  drm: rockchip: fix sg_table nents vs. orig_nents usage
  drm: tegra: fix sg_table nents vs. orig_nents usage
  drm: virtio: fix sg_table nents vs. orig_nents usage
  drm: vmwgfx: fix sg_table nents vs. orig_nents usage
  drm: xen: fix sg_table nents vs. orig_nents usage
  drm: host1x: fix sg_table nents vs. orig_nents usage
  dmabuf: fix sg_table nents vs. orig_nents usage

 drivers/dma-buf/heaps/heap-helpers.c             |  7 ++++---
 drivers/dma-buf/udmabuf.c                        |  5 +++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c      |  7 ++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c          |  8 ++++----
 drivers/gpu/drm/armada/armada_gem.c              | 14 ++++++++-----
 drivers/gpu/drm/drm_cache.c                      |  2 +-
 drivers/gpu/drm/drm_gem_shmem_helper.c           |  7 ++++---
 drivers/gpu/drm/drm_prime.c                      |  9 +++++----
 drivers/gpu/drm/etnaviv/etnaviv_gem.c            | 10 ++++++----
 drivers/gpu/drm/exynos/exynos_drm_g2d.c          |  7 ++++---
 drivers/gpu/drm/i915/gem/i915_gem_dmabuf.c       | 13 ++++++------
 drivers/gpu/drm/i915/gem/i915_gem_internal.c     |  4 ++--
 drivers/gpu/drm/i915/gem/i915_gem_region.c       |  4 ++--
 drivers/gpu/drm/i915/gem/i915_gem_shmem.c        |  5 +++--
 drivers/gpu/drm/i915/gem/selftests/huge_pages.c  | 10 +++++-----
 drivers/gpu/drm/i915/gem/selftests/mock_dmabuf.c |  5 +++--
 drivers/gpu/drm/i915/gt/intel_ggtt.c             | 12 ++++++------
 drivers/gpu/drm/i915/i915_gem_gtt.c              | 12 +++++++-----
 drivers/gpu/drm/i915/i915_scatterlist.c          |  4 ++--
 drivers/gpu/drm/i915/selftests/scatterlist.c     |  8 ++++----
 drivers/gpu/drm/lima/lima_gem.c                  |  4 ++--
 drivers/gpu/drm/msm/msm_gem.c                    |  8 ++++----
 drivers/gpu/drm/msm/msm_iommu.c                  |  3 ++-
 drivers/gpu/drm/panfrost/panfrost_gem.c          |  3 ++-
 drivers/gpu/drm/panfrost/panfrost_mmu.c          |  4 +++-
 drivers/gpu/drm/radeon/radeon_ttm.c              | 10 +++++-----
 drivers/gpu/drm/rockchip/rockchip_drm_gem.c      | 15 +++++++-------
 drivers/gpu/drm/tegra/gem.c                      | 25 ++++++++++++------------
 drivers/gpu/drm/tegra/plane.c                    | 13 ++++++------
 drivers/gpu/drm/virtio/virtgpu_object.c          | 11 ++++++-----
 drivers/gpu/drm/virtio/virtgpu_vq.c              |  8 ++++----
 drivers/gpu/drm/vmwgfx/vmwgfx_ttm_buffer.c       |  6 +++---
 drivers/gpu/drm/xen/xen_drm_front_gem.c          |  2 +-
 drivers/gpu/host1x/job.c                         | 17 ++++++++--------
 34 files changed, 154 insertions(+), 128 deletions(-)

-- 
1.9.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
