Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 673F71EE00A
	for <iommu@lists.linux.dev>; Wed, 25 Mar 2026 19:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774466639; cv=none; b=GeLm5992kFb9VRV9lFCxWAW5AVkY6VpWvLXrZyybmUi/kofg1UFx4Y0FSCz1kzryYtwFdYwRrXTTRzAdcDAkGngu/CkIv+ga0BD9kXj+F2sdeHTuMZla+mloqdARr1p0nFKnCshf+nfYSfKc/QZkHpjpqlSYZ1O2wNorqA65W5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774466639; c=relaxed/simple;
	bh=5zxzl6uudo5fm3rD4gIEZz87DRY+U9FKt25ekqymGSU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UQ12kA8SWcemjFoUH6MgGIoB0eBbT3TDO5FA8x8ZE+P1nCktuNR3ZJSp35vpVgA5+ZZ1a+SEOZnArAuk0LPme5nk+3ThPs7iPA4CcihKNaEG4imaM6FpNNFEKba8Q3WDkgSERzH/woLBmPEHRY+gqrFd5PA0WKi7I6FZwLMdfF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=hNZ1fLNc; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="hNZ1fLNc"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-486ff3a0fc1so2051455e9.2
        for <iommu@lists.linux.dev>; Wed, 25 Mar 2026 12:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1774466634; x=1775071434; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=q9oYYl5Ubh4Ping1zst+E8em20zAUpauFfgriVu6hpE=;
        b=hNZ1fLNctWXVp2z9G5UhDmM+HsCoGwiHDGxJe2l80wDd9MkfQBtI/ZIHI/+Q4Gs52Y
         gs5sUwW4+flZdC68EExBdKTjmPWAHu8lVAr801DMJt7JwJ8atbcGCFOxS3Htk6W5W+zI
         srFM6tHBO+G5+pm0QOtK9xQ7IaV11jFe6vJKFcOg1RB7BRGmEoUAWVG7gTP7jopBz5VE
         WVewew6B3AsOH5Dv3ZtajahSEttLkNcmMWO3+ixzvtfMTT9TCsJKy/+trYTumjCi/9J6
         ObNTF08euxWqomo4BbUbH2839wjFFlqm2xI0juTDKH2UMNOKB+Kp1TDAuzpFIhMWzaSV
         E6jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774466634; x=1775071434;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q9oYYl5Ubh4Ping1zst+E8em20zAUpauFfgriVu6hpE=;
        b=EPrCAHEu6kPa7lvErqVA7bnwg4Vx9HNH+mWzfAWPctprD1WeBjnFqdVuLGGY0wqJwR
         PglrBklq/P7b7zUAGZTu/peUXihJHYOTv7AYazhRQsY6oUKjZxMk3tNIK1nrG8nslACT
         pB1vSojd2QcrC0nfO4wTCW5Kq8zNuFzyuEpV3gMfd4FbzUjV7OH6bWSTlCVX+Er7ldJf
         ep/B1eyW9001RS3gExSVaSBXctnZdlcMcMTnw4/lAzXDhyGu1gHn8obD3co8UrBh32YO
         yRasKlqpLuQyZoSnGuOYVgy37IsQgYgnkuuyRxMdaGFX6RQcoKNvke0hpWK97HWEIVJ7
         9PcQ==
X-Forwarded-Encrypted: i=1; AJvYcCX0UhXYYPD5nzgrUPsP69XWDBJ2EYQedsw4Wse9mqqPbKGnMz/NBW4tBl992nKpw9BJDsPKVw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwYbx1HWxzYb4ungD6lebUSOlClI6J6jOKFIu5k/DswW9Lpv0fP
	8gfePdhXN76Mims8K62J+6tEKv3Bh3zAxhUA5F2wUE7U4AR3Mt0VW8HRbCU6pkC0WWI=
X-Gm-Gg: ATEYQzwLDlCEVntjICDVsXt8p8VFUgD6r2Ppv+nrmfU2y4crX8H7tp//A5YJui9NmbJ
	PHfFEq7u4NxIE0FQTCcA0Lr9ojSeatSKDOcMUDTCm0s1k39TiPJtgHmip4SFvYbuBiNvWYZosAV
	UntB0qEbbNkQlifx0l4qt4F9fLnAuJAVCTLwnaAMXYTLHLRjMpMaZca2aRrLiHYbf5C0W/B6f1k
	MIjO5sfnnJsG+1JJ6U3YHLLP9w8q1JznyUTeVEoGLA+qNLTVHYrbj/FKWwpKbiGkon4rgBphhNX
	u4zPUYjvrb1EYWF/dQKzA3SJ5aA5EZtrazdO7lNrqJOOmeSWOwaBE0a2dmF6XVB3jFqRok87D0C
	bDpDjWEt6JpZCVGJ6UjqQzIldrH4J8DBNwiFnGA1mgAgSMVZxcOtBKI15h8THYuper5BlpPTE5o
	h722WbBg2bYByB7fe9UqniIchHiQW1
X-Received: by 2002:a05:600c:1f12:b0:485:41c4:e2e5 with SMTP id 5b1f17b1804b1-4871605686dmr70437725e9.27.1774466633448;
        Wed, 25 Mar 2026 12:23:53 -0700 (PDT)
Received: from localhost ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b919e7111sm1855634f8f.37.2026.03.25.12.23.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 12:23:53 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org,
	iommu@lists.linux.dev,
	linux-media@vger.kernel.org
Cc: sumit.semwal@linaro.org,
	benjamin.gaignard@collabora.com,
	Brian.Starkey@arm.com,
	jstultz@google.com,
	tjmercier@google.com,
	christian.koenig@amd.com,
	m.szyprowski@samsung.com,
	robin.murphy@arm.com,
	jgg@ziepe.ca,
	leon@kernel.org,
	sean.anderson@linux.dev,
	ptesarik@suse.com,
	catalin.marinas@arm.com,
	aneesh.kumar@kernel.org,
	suzuki.poulose@arm.com,
	steven.price@arm.com,
	thomas.lendacky@amd.com,
	john.allen@amd.com,
	ashish.kalra@amd.com,
	suravee.suthikulpanit@amd.com,
	linux-coco@lists.linux.dev
Subject: [PATCH v5 0/2] dma-buf: heaps: system: add an option to allocate explicitly shared/decrypted memory
Date: Wed, 25 Mar 2026 20:23:50 +0100
Message-ID: <20260325192352.437608-1-jiri@resnulli.us>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

Confidential computing (CoCo) VMs/guests, such as AMD SEV and Intel TDX,
run with private/encrypted memory which creates a challenge
for devices that do not support DMA to it (no TDISP support).

For kernel-only DMA operations, swiotlb bounce buffering provides a
transparent solution by copying data through shared memory.
However, the only way to get this memory into userspace is via the DMA
API's dma_alloc_pages()/dma_mmap_pages() type interfaces which limits
the use of the memory to a single DMA device, and is incompatible with
pin_user_pages().

These limitations are particularly problematic for the RDMA subsystem
which makes heavy use of pin_user_pages() and expects flexible memory
usage between many different DMA devices.

This patch series enables userspace to explicitly request shared
(decrypted) memory allocations from new dma-buf system_cc_shared heap.
Userspace can mmap this memory and pass the dma-buf fd to other
existing importers such as RDMA or DRM devices to access the
memory. The DMA API is improved to allow the dma heap exporter to DMA
map the shared memory to each importing device.

Based on dma-mapping-for-next e7442a68cd1ee797b585f045d348781e9c0dde0d

Jiri Pirko (2):
  dma-mapping: introduce DMA_ATTR_CC_SHARED for shared memory
  dma-buf: heaps: system: add system_cc_shared heap for explicitly
    shared memory

 drivers/dma-buf/heaps/system_heap.c | 103 ++++++++++++++++++++++++++--
 include/linux/dma-mapping.h         |  10 +++
 include/trace/events/dma.h          |   3 +-
 kernel/dma/direct.h                 |  14 +++-
 kernel/dma/mapping.c                |  13 +++-
 5 files changed, 132 insertions(+), 11 deletions(-)

-- 
2.51.1

