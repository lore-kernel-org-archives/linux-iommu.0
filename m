Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C8C39C632
	for <iommu@lists.linux.dev>; Thu,  5 Mar 2026 12:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772714210; cv=none; b=CoLZ/31vHu/Ia9zjehE/ti81hj3Iuqd6dM30hUGK5/b2+oPL4KNz3hDKFjn/Dg40XuRBv/KlEeKjss0wjfzl9zRwY6j1myrW1PpI7E6iIX/oB0jG6zXizSSNjSxGGSeey15lfwf4ozFnGpQoAJweEfar6pLdVjlUe+rpu+i0p+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772714210; c=relaxed/simple;
	bh=BH57nnIaE9i3N95p4Q0UsDprhOQ63o6bys4TWubRZV0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fd5wIkwNm0Eu8Vl0UMCZs6u3XHMTuPZ4xk531h5y1orreuK3POOVIRnxQobqKTRfVo5lt1Hr5n9fmtGIMulAw5gUmABdDG0pdQGsGHfL0N1KSRxxM+zxemS25D8cjW/pdU4qkQINEl2l0aove8jMZfVIEOHzxq67TAFPF0ArPOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=dqxNRCRg; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="dqxNRCRg"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-439b790af67so2668367f8f.0
        for <iommu@lists.linux.dev>; Thu, 05 Mar 2026 04:36:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1772714203; x=1773319003; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=y3f86hD8zd8MmrDtQjkoOiWVtBZ+fmRfNZDECEzXgGc=;
        b=dqxNRCRg1uKrqG11CnGStL+bH50LVC3Pvu4uzOxMFc/ElHHyp6ymPWtH/XdRV4gxEr
         nJSp85gS5Htz/M9v8PDeGdDvcGqV65tVRq+kLKCjmD+U21407nMvvcsVJQ0hQuHJa1j5
         yy7NehYrecnBdhBbW0kNliHtjmrg7oqKPZMeIw1dFrjN7IPTvVXnYNEHzck7gT5LndO6
         f3QH2i7EIJzQHwXEyh0LYzAbm/Z3/+pG8mjXAHQvbARlrsLiNx56UQebauOOlSF/dqxL
         9LR5ku4MIyPlgN4cppYaJJ4lZ4vU0z8jAoaiHQg+ltMmSzCNWV4tSu83JJppIIANuBwD
         T1ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772714203; x=1773319003;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y3f86hD8zd8MmrDtQjkoOiWVtBZ+fmRfNZDECEzXgGc=;
        b=tNFGUC1C4lLl607Sge9fB0tFmRwsC6dqgSbjHl5D2ktcRP2U7ZkwW36kiCC+dYsTnG
         +TQBo/0xk2H/vW8Qw3g5DpUy8TnM5tQYiEMhree4AO0cBFQxjFb2gDlp7wXWc6QBjcQY
         RyAS+fVOWALdm7Ws1XNLFmgqUwHC0eUsukOqxWWkpGowCwROlnLRjjj5roeIuPZ4VZGD
         Uv2AABYKaglYLh+W0EkIGbfP7T9pWOk+FwhYN0sqA1GsNrQfwmpfoFYzVPIGXKlv2i9l
         J5erp8LO3vIvHfhIaXJJOixITcQ1Xius4rB2ShzTN/bAX9sunCqRx2HA30/TF22UdIF3
         Dsag==
X-Forwarded-Encrypted: i=1; AJvYcCVCov7x5gQ6bYSYu1kv4lgDwHvV5as1AGnMDYbLZt32axgxumfj/PKseRzy3GCNTF8iiyiETw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz+mO6s+w/3dWn2hlndcHoi0fZcN0ja6i2lQnBhE48of7qEIXv7
	5vkfZbLTd1wTqxDaXax8SGXdU8ol83pPOwUbNrt07h/CFxj6AGlIWZoljxiEA7OjwD8=
X-Gm-Gg: ATEYQzw3gZXZzFVWT2MW9bpXJjvdXgfuFKst1ksoyUBeL75o5WMawlSDmjXjqdeuNSf
	xih5jijHGhkDz8I7HoAztMx82ge7y+U8J62RReB4pvgIEN9M+OHvvfb29cty/vt2fQtvxoSVJkz
	a9nawUedCSLsiM+85K2CFkSOZlbSJbBxSvWCu3MuuJBNM2Q/b3EidUacnW8gyqEBn1AcFtJ+QSs
	64v+ox81WGYTsykOoiX9MhkfeDt6DaxSPc0qGTZvJHUd+UP24tWXR0LfdbR0TBW38mNAt4ea6u0
	7bm7gNwGKHOkdxPCyGiuFZOyt9c0DoKhn+VSC+ZVUzyDqiqzhDX3wk4XNmYvQD7SOI1mRweNyGu
	grnXbO2ZH1sb4UhpjUjwfESWLYB5H2q97DggeuUGWyTVN6wG6Hr90ISNE/1l1by6Oe1r0NIIuOZ
	JGrrLfr9hbc0trbw==
X-Received: by 2002:a05:6000:1845:b0:439:afc5:dd0d with SMTP id ffacd0b85a97d-439cfd76cf6mr3945058f8f.25.1772714202770;
        Thu, 05 Mar 2026 04:36:42 -0800 (PST)
Received: from localhost ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439af926c53sm43701820f8f.8.2026.03.05.04.36.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 04:36:42 -0800 (PST)
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
Subject: [PATCH net-next v3 0/2] dma-buf: heaps: system: add an option to allocate explicitly decrypted memory
Date: Thu,  5 Mar 2026 13:36:39 +0100
Message-ID: <20260305123641.164164-1-jiri@resnulli.us>
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
run with encrypted/protected memory which creates a challenge
for devices that do not support DMA to it (no TDISP support).

For kernel-only DMA operations, swiotlb bounce buffering provides a
transparent solution by copying data through decrypted memory.
However, the only way to get this memory into userspace is via the DMA
API's dma_alloc_pages()/dma_mmap_pages() type interfaces which limits
the use of the memory to a single DMA device, and is incompatible with
pin_user_pages().

These limitations are particularly problematic for the RDMA subsystem
which makes heavy use of pin_user_pages() and expects flexible memory
usage between many different DMA devices.

This patch series enables userspace to explicitly request decrypted
(shared) memory allocations from the dma-buf system heap.
Userspace can mmap this memory and pass the dma-buf fd to other
existing importers such as RDMA or DRM devices to access the
memory. The DMA API is improved to allow the dma heap exporter to DMA
map the shared memory to each importing device.

Jiri Pirko (2):
  dma-mapping: introduce DMA_ATTR_CC_DECRYPTED for pre-decrypted memory
  dma-buf: heaps: system: add system_cc_decrypted heap for explicitly
    decrypted memory

 drivers/dma-buf/heaps/system_heap.c | 103 ++++++++++++++++++++++++++--
 include/linux/dma-mapping.h         |   6 ++
 include/trace/events/dma.h          |   3 +-
 kernel/dma/direct.h                 |  14 +++-
 4 files changed, 117 insertions(+), 9 deletions(-)

-- 
2.51.1

