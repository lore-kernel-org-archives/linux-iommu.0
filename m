Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844C638C2C0
	for <iommu@lists.linux.dev>; Mon, 28 Sep 2026 05:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790573958; cv=none; b=on6njWygck5cxWSG6sSEwQRTy9cETmgayIdudVHN5k5Wau0PE+CaV+zvsCqMOU/R391axoJzim+JJITe4e7i/NV938+d/UBMQL6tr2AMzO5W426vqvLKq3Zexwq5LnWgPF47/OYCSk/GGCpZApgDaVdiv0sVn27jWlOPug8P72w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790573958; c=relaxed/simple;
	bh=PAtF/PNKxtMzgWanGm0UJ8I09oPtXYVfYF1UgrzHWr0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bwobTOOaJEVrDtREVMoYzD+qgIxLmqqJPpriKLAan9z+sbyIyqWOpP5ikXrP6IESimWhH20qm4gPg9I5YFsPcTsXSQNDDy8VQqek4JOP8QwjtyFSIEtktzklFBo+Xdqul/mHGD5UESeExc/fgObvbPt8q2WXXrjy/tWtmQX21W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cmtcg0zA; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cmtcg0zA"
Received: by mail-pz2-f12.google.com with SMTP id d2e1a72fcca58-8523cc41f3aso58885b3a.3
        for <iommu@lists.linux.dev>; Sun, 27 Sep 2026 22:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790573950; x=1791178750; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=e1GfyXNzZ7U9i0Z+Tk5I9ck9dnyRvvtvnuEFHqewoGY=;
        b=cmtcg0zAR7MSDXEB06TrVv/imDHSoMaSMubnb0+v0b45a2j0o74PqN5C6Puu7h9Sgc
         loxtGQQkOYezSHXcgySUit05swnj0fFng8fRd7RjEbj35DAcZQrLmrxKmYjonqnyOBxy
         iY6/Z1ytZsZUeWhhwbcavgZDUNmdhOOp0UZP3yLBr3YcqrnH6I7xsfTc6wXAbmGIbXRU
         a3etYvmFRzexv0SX/3YGa+Bkp1LjzDxK0d8w8H6GgH/ctYiBXnMeoTIpEQKTTRmSswpw
         9ahsx1btPTbwNCOG6W83LWBqCihlp5W1OdqbKP6Ebko1pMjPMCTJZSfyff1J85SmmwBH
         9SGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790573950; x=1791178750;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=e1GfyXNzZ7U9i0Z+Tk5I9ck9dnyRvvtvnuEFHqewoGY=;
        b=BpZ0yXU6NQ2Qo6WgzYS3wVcg5QfZ9HXxyZwe0/9waL062Yh8zNz45lTbAI70JhtqTH
         f+dKhHJidTqUDvu2mBKBQFyhyr4shCOBmLN3jWX3XP8lPqNpYvhEekznI/ktKhKoVpjS
         M475yCZKryXmJA2kmco7UZnbj29Iy6SiTaAEgN3BPdOo+u81SEzcK2J/9xJrXg+b6dQA
         uFlMTMCjCklXQujVHI7OmkYgQ0qz+ZEj1C2Xw5bW5GkNIwLllhQTQv3RAmMtLVYhdGEU
         LMdLYvTsKeSQkslabj1N7TKN1GACsA3ruwysu1Ybeua4BxJHnZXi3CVoMTtauusp4LMv
         9MeA==
X-Forwarded-Encrypted: i=1; AKwUvBwNY9Bd8pXMxcUq9qAU/LM7G49ntOJpJEt5QNMzvmYfxv9ScRtLaau8x9/1LBWrROrMpKWr7A==@lists.linux.dev
X-Gm-Message-State: AFuF++ltXmM/a+nELbY6SD+iHEsgcwTCZWL3VtP618kR9CzLN+t4qGR1
	gGaO0Ob0p7A7iHf0muT0FtuNyA4c+vJ/bkiw+IL6baRvArsF+WuZER1o
X-Gm-Gg: AYBFou0dFERx7BjieMC8PhIytAfac197Ba/Zuv4AykSLRgN0N5nyF7x4LzOnvmROVQe
	WlyA8yH2Qcl6ZekLBsLGa2JioLGGilWsxQyXxm41at/KWi5C8s0l4ZwaIuXw60VjaLKEWOOHizZ
	b9rX8E+JDhIhwz5dLrQU4379yYnnQZRGyw0Dd6YORw0OYpylMhP64NBe4lQh0SjEj9fdqZmBRZ5
	IT6uDkfpnt1z0pqF5KgAU+arui5z85k3P2AhjcG26v1RoC6UfocQX9tL+5hiRocqXTOhXmjV9Ye
	TnjLXBUwwKizOYGz4uNMYBPXeXfWXJEJdeHv/Dfh2fRUWfEud3peVJwiBQClnwuK88rBnN//jpZ
	c+tJhalLq0DeLsx+4am4gUsmAzZ3C0zgLGt2TOB37IS16PIMIrUc09u8A7B3QfNmdUzkgL2GxBk
	39F86liLQxLVn8iJoANDRF1CfXj1hAW2qv4SNQVA9Am/CLEqShn6rnJVvv07125ge18Usamd3Jr
	JWiUd7zVWHwkQ==
X-Received: by 2002:a05:6a00:4807:b0:864:59e2:2968 with SMTP id d2e1a72fcca58-87fd0d8cbc6mr6922416b3a.0.1790573950242;
        Sun, 27 Sep 2026 22:39:10 -0700 (PDT)
Received: from jfliu-sfa1411.. ([129.227.183.200])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-87febb82357sm3591121b3a.61.2026.09.27.22.39.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 22:39:09 -0700 (PDT)
From: Jianfeng Liu <liujianfeng1994@gmail.com>
To: dri-devel@lists.freedesktop.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
	freedreno@lists.freedesktop.org,
	iommu@lists.linux.dev,
	Dmitry Baryshkov <lumag@kernel.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	linux-media@vger.kernel.org,
	Bryan O'Donoghue <bod.linux@nxsw.ie>,
	Jianfeng Liu <liujianfeng1994@gmail.com>,
	Abhinav Kumar <abhinav.kumar@linux.dev>,
	David Airlie <airlied@gmail.com>,
	Jessica Zhang <jesszhan0024@gmail.com>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Sean Paul <sean@poorly.run>,
	Simona Vetter <simona@ffwll.ch>,
	Will Deacon <will@kernel.org>
Subject: [PATCH v1 0/2] drm/msm: followup - map page-less imported sg_tables
Date: Mon, 28 Sep 2026 13:38:49 +0800
Message-ID: <20260928053901.7270-1-liujianfeng1994@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


Hi Rob,

this is the follow-up I promised: it fixes the two remaining map
paths that still consume struct page/sg->length of imported
sg_tables, and therefore completes the DMABUF_DEBUG=y story when
applied on top of your series [1].

Test results on x1e78100 (Snapdragon X1E78100, DMABUF_DEBUG=y,
kernel v7.3-rc4 based), which is the machine that originally
reported the UCHE translation faults and the one hardware test
environment for imports of buffers not first exported by drm/msm:

 - v7.3-rc4 stock: arm-smmu UCHE translation faults during hardware
   video decode in clapper/chromium (bisected to 143755bdabaa9)

 - your series alone: video plays via the userspace copy fallback,
   zero GPU faults, but a WARN storm from __arm_lpae_unmap()
   (472 traces within a minute of video playback) - every map of a
   page-less sg_table silently maps nothing, so the matching unmap
   finds no PTE and WARNs.  This matches your cover letter saying
   the map paths are not addressed by the series.  Your patch 2
   ("mmap imported dma-bufs via the exporter") in particular works:
   a test importing a linux,cma-heap buffer via
   DRM_IOCTL_PRIME_FD_TO_HANDLE and mmaps it both through the heap
   fd and through msm's GEM mmap sees the same memory through both
   mappings, including writes visible in both directions.

 - your series + this series: zero arm-smmu faults, zero io-pgtable
   WARNs, and hardware video decode displays correctly in clapper
   and chromium.  The GPU per-process pagetable path is exercised
   with real decoder capture buffers (videobuf2-dma-contig, 2MB
   frames) and maps them from their DMA addresses.

Patch 1 exports iommu_get_dma_domain(), which msm needs to look up
the dma_addr -> phys mapping of imported buffers through the msm
drm device's DMA-API domain.  On platforms where the drm device is
direct mapped (like mine: ae01000.display-controller is in no
iommu_group) the lookup degenerates to the identity; on platforms
where it sits behind a translated IOMMU the translation is needed.

Happy to rebase on whatever your tree looks like - and I can rerun
the full test matrix (WARN count, fault count, kmssink scanout of
real V4L2 frames, chromium/clapper hardware decode) on any revision.

[1] <20260926183051.25754-1-robin.clark@oss.qualcomm.com>



Jianfeng Liu (2):
  iommu: export iommu_get_dma_domain()
  drm/msm: map page-less imported sg_tables from their DMA addresses

 drivers/gpu/drm/msm/msm_gem_vma.c |  9 ++++
 drivers/gpu/drm/msm/msm_iommu.c   | 90 ++++++++++++++++++++++++++++++-
 drivers/gpu/drm/msm/msm_mmu.h     | 13 +++++
 drivers/iommu/iommu.c             |  1 +
 4 files changed, 111 insertions(+), 2 deletions(-)

---
base-commit: d6882ed4e5b3970a13d721a07d2737c4831cdced
branch: msm-map-followup-v1

-- 
2.47.3

