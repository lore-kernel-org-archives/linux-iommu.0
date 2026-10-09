Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F6293594A
	for <iommu@lists.linux.dev>; Fri,  9 Oct 2026 00:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791505289; cv=none; b=WjHDbmMn0eWAcv6mmKs3HBPNhTx8xBStFnD82nYQKmbnOPBochex/iMg9hEwsRkVTJ9nCNXXkkF+MZL2U2n3aDHN0IfDJhnjOCuF90JklyQ4AseWIo6nO6vaEX4C+l1V8wmp8s+J4pcluXXKpWxGQnrl/PyHAiKngTHDtsgJuNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791505289; c=relaxed/simple;
	bh=I804m7pGplelst6v9HgcfUOuOhXmNC0zaelJCV9onzA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=g5i193gBc+RlDkww+TQgn8lIuk1V0s3p2Wrq1CCEk9aQ6Ux06x080J/1MHkhG41S72kpv+ESk7hn3WY6Wc9Lc8INBcPWt86ZE4KvvfPIv4QGmNyyd+Y7RWUTdk8MOPPYwqK8wzhybibQUACL52LzXjIcyrxuDq6EyK2mT5sk7xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sthlvPts; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sthlvPts"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-49d05d51553so41173545e9.2
        for <iommu@lists.linux.dev>; Thu, 08 Oct 2026 17:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791505286; x=1792110086; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=WQqOqFaR8S6Kxc8KfBqHhYsGrjh61dZF/m/XQ0uNMYQ=;
        b=sthlvPtsRZ6fx20SNvdQGwOk0G0EbF5nzteReeWPSCL1zhgYxc+/5MqZd8VqKz/WkV
         uxtJS7qEwCPtkEcCDPE06FjaqfYj0aaLHRNXy0kOkSAyU73aujUurLVPoScVuvJ4Rgwy
         RpyDH6eFsMJ3lFx9tn9b9Tt3+4bADS3OCT9uCpbTpp1PtlUh/deiBi+C0VOutYACmX69
         X4vM5B0jskD64sfR4xS1Goo207hSp3w/0TuCDZNxJhTKqwEhzDtcGR5nqL11YUFC8SXp
         i1v2/WxXa1sTAi3MXEJnjrZuZmSEQvqzdWVcd2YlF92+QQ+M6a4PTV6t3rS/bNtWdcZ+
         0/oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791505286; x=1792110086;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WQqOqFaR8S6Kxc8KfBqHhYsGrjh61dZF/m/XQ0uNMYQ=;
        b=V6tSc3Kc9aA494G+tRKFV/JA4ZR2pTtzam4Bjm72SSgnVukcx/ms/YKcxCh1qhFS22
         PJFKt+EFnzP0AmTmpz153RFUfWqB0JEPSHuy1Hr4gLVoM/h5wCB47p1HhxCIsAULkphC
         e9Evr+gXGtmcI8Dr482d74t/rvLoOUQ6Ln1fohRf9WOElGace3PVzlGL2SMJHztq5NBr
         UYysXfeUs006EKlDuzqDT3I+oESMXsvxoB9w9TDGtEmW+/7kc4Xyd45MhPyDg9U44Rst
         /AdKsVfz8dZbWo1Ha7yRCe5MZKQOlVDZMvZVp7iGymIctZcorzJdm/PuuoKpVXEEFaWL
         aDKA==
X-Gm-Message-State: AFuF++kR/DgFfWuLvFaws/bGh8NxZSBA5SzcFdWejr9KPP0B2TqFZ8ls
	iaHISZazJY0yoP/geieok1vwoKJ28OTXd2Wr1jOWLR+bGOB08GI8QLfymgj3pPJZ
X-Gm-Gg: AYBFou10KGiu/q68GnI8VedSio49wZHx/zwy7Hm9FZggLhGiWC6kT5VFPKKRCYLM/Hl
	hbUQkhPGeHOTk2MiS3D1kFjvmvesQYxoQ4C4i68LnRIOwUVWmXiiAmjzcZvC0U01Q9y+DFtGaP0
	ULt8P6HtVwT2/bgUZ5rEJeZruBJN+jzek999EOeUkwcdGQVT3WOPgJusMLIfgKZDswXOVGALpGU
	bhIM2xAAMySIUEP6xq27T/Hpg3F+Jjz2PzrkDB3ck17JHnkVS9oOLWvdhcnE3H9OPWxQSj8fMAo
	RBo5fqD3QtQRyzH2lrw3S9O7dHZBlQhMWNHcMRJ2VZ2GEGFu9dZCZ2q0sN9lJtpAgkrsCTER27w
	VdXfpwjcvgdfoflenq9q7cjbjqTRCFbSwphD2QsCtTv9RC/bF5geqg14oyaZsOID5IthMal7nF8
	6spHxxSiagRp2r5a2E4obOhEFW9xqWHV7S/1dKDxkJ13nXCjKtUzWHfcYoXe7n2uQ6ECrwkt+GC
	7U2O0iqOLWf0ylUMV9oAWv6uUBqqSDIacouG8rwh4ntsEm8Odgsl0R0TRjt3BSyf6YtPZV3qAGt
	9QkD2KLQVRP5to7nuYvvhOB9wJ2QPW+fj4BF37duYCL/RYDvnpGRDJh9Lz1SQwjE4VB36XFO5sM
	te3f8KeY=
X-Received: by 2002:a05:600c:524a:b0:4a1:8824:c9ba with SMTP id 5b1f17b1804b1-4a18e49234fmr2630825e9.18.1791505286061;
        Thu, 08 Oct 2026 17:21:26 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-ad61-5a01-743c-891f-b33c-cae7.310.pool.telefonica.de. [2a02:3100:ad61:5a01:743c:891f:b33c:cae7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18e4987casm3364605e9.1.2026.10.08.17.21.24
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 08 Oct 2026 17:21:25 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: iommu@lists.linux.dev,
	dri-devel@lists.freedesktop.org
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Diederik de Haas <diederik@cknow-tech.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Sandy Huang <hjc@rock-chips.com>,
	=?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
	Andy Yan <andyshrk@163.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Rob Clark <robin.clark@oss.qualcomm.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Jianfeng Liu <liujianfeng1994@gmail.com>,
	linux-media@vger.kernel.org,
	linaro-mm-sig@lists.linaro.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/2] iommu, drm/rockchip: Map private-domain imports from DMA addresses
Date: Fri,  9 Oct 2026 02:21:12 +0200
Message-Id: <20261009002114.67851-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Diederik reported failed video-buffer imports on RK3588 with
DMABUF_DEBUG. The proposed warn-only mode [1] confirmed CPU-side
attachment access in rockchip_gem_iommu_map() during Sway video resizing.

This RFC keeps Rockchip's private scanout domain. Patch 1 copies live
iommu-dma mappings into another domain. Patch 2 uses it for PRIME
imports. Unsupported inputs keep the old page-based path, which remains
unfixed under strict DMABUF_DEBUG.

Rob's MSM approach assumes direct DMA [2]. Rockchip's attachment instead
provides IOVAs from the VOP's default domain, which cannot be mapped
unchanged into the private domain. Each import retains both mappings
and adds one reverse lookup per 4 KiB.

Christian rejected reverse translation in the earlier MSM proposal [3].
Robin NAKed exporting iommu_get_dma_domain() [4]. Keeping the helper in
dma-iommu.c does not resolve the physical-address objection.

Sharing the first VOP's default DMA domain, as Exynos does, would avoid
the translation but also change native-buffer mapping.

Is retaining the private domain and reverse-translating the DMA mappings
an acceptable direction? If so, I'll address the remaining limitations
before posting a non-RFC version.

Base: mainline 602042bf29f6. The warn-only RFC is not a prerequisite.
No stable backport requested. Strict-by-default DMABUF_DEBUG took effect
in v7.3-rc4.

Testing (builds and QEMU only):

- W=1 object and stub builds passed on arm64, ARM32 with/without LPAE,
  x86-64 GCC/Clang, i386, s390, RISC-V and UML, including dynamic SWIOTLB.
- Rockchip strict/warn A/B reproduced the control failure and warning.
  Treatments checked every page and byte in 83 imports each. Primary
  buffers had 1/127/507 DMA segments under the default 64 KiB limit.
- SMMUv3 strict/lazy tests, missing-source, bounds and rollback tests
  passed. Real bounced attachments exercised alignment and pool
  rejection with no target mapping or DMA.
- Invalid forced-SWIOTLB Rockchip provider runs are excluded. Expected
  segment-limit and unsupported-fallback diagnostics remain.

The rig uses a custom Rockchip IOMMU model and the real GEM callback in a
test module, not VOP2, Sway or a real exporter. RK3588 hardware, two-VOP
and 32-bit ARM runtime testing are outstanding.

Hardware testing is welcome, particularly with Diederik's Sway resize
workload. Compare control and both patches on the same base/config,
first with strict DMABUF_DEBUG, then with the warn-only RFC on both.
Please report full dmesg, config, exporter and visible display problems.
Keep a known-good boot kernel. DMABUF_DEBUG=n testing is welcome too.

Developed and tested with LLM assistance.

[1] https://lore.kernel.org/r/20261005064133.7305-1-kmehltretter@gmail.com/
[2] https://lore.kernel.org/r/20261006131000.81501-1-robin.clark@oss.qualcomm.com/
[3] https://lore.kernel.org/r/bd4e5ece-1358-4e0b-bb04-ba9de62d26f6@amd.com/
[4] https://lore.kernel.org/r/47bf9a4c-2a47-4e93-bcdf-8d953c9a5ab8@arm.com/

Reports:
https://lore.kernel.org/r/DLR74W1U9YPC.375IK0HOYHDIG@cknow-tech.com/
https://lore.kernel.org/r/DLYLA3WQNN3X.3FB9MO8ZWBQ5@cknow-tech.com/

Karl Mehltretter (2):
  iommu: Add iommu_map_sgtable_dma()
  drm/rockchip: Map imported buffers from DMA addresses

 drivers/gpu/drm/rockchip/rockchip_drm_gem.c |  19 ++-
 drivers/iommu/dma-iommu.c                   | 131 ++++++++++++++++++++
 include/linux/iommu.h                       |  12 ++
 3 files changed, 157 insertions(+), 5 deletions(-)


base-commit: 602042bf29f6efde39cfb5fdd9289bf4854bc0c5
-- 
2.53.0

