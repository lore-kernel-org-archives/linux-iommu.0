Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634DB14D719
	for <iommu@lists.linux.dev>; Mon, 16 Mar 2026 12:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773665945; cv=none; b=VuoJcmRxwxqGnENETiSlRntb7C8DG9RoURNatjIW6CLLFVx0ZVDnSk7ggtdUUJiiTWlIl1Eu/EFLzD2VrAf7oJRmYiipGD9rXRraSqp34dg1Oy4q4mvoAeLZ7LEL7ITPigLgiJ/t6KZ6vVjKypEX58Nsw5Pg7LOzTiMpQqDLbAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773665945; c=relaxed/simple;
	bh=Lg2AUKdIw2znElHkpszuxWA7eoByATIIPmoC0QDvUj8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EAJHUncktFAG47lixpnNPZghrROzwSUqwZB4vigdBcXgQySlmAEdBP9X5X4rD1ISpbGHQ982pd21DmHFXmhVLoN1g3nHpE0rRbDfA/yVfFEm+ZaFw5Teq4rCvosxasE76dKZtf7bfUjt9jqytE8+LzfTE3BmrNZ1CyKKrdHpEEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=yPDm1WeL; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="yPDm1WeL"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-43b4915161fso161719f8f.2
        for <iommu@lists.linux.dev>; Mon, 16 Mar 2026 05:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1773665940; x=1774270740; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QiV2UgPzDyf2BIxEKlEP0kmveErchJjvWqwkP1nC5aU=;
        b=yPDm1WeLbERctqmJkFrv0XnJJf3Ec9Vx9PbzmC20OespKg/w+R8djD7rL8L6Wq7UOt
         A5dxKgCQFvURSnnMWoLlzsvySAtm3QTkNWCmQkxsuUwPe1MUPwrMnOv1mfMhGlkzkY1/
         92ObUdI5CnzP3H/BsxY9Z4qoiMxQoxTZZKA/7Ro7APqGym+iEXAlc1oEjvEFMjvWLJcO
         6dW/k0GRSBaa2AJwwThuUSydFoNZHQKSI8FPrPJFVHhARcD7TaBWkmALBT3wjhJ3U4F0
         62oulcwIxqFH+s8AeF6vvuk6+CGfr9UW8KP+2jdrNwNMFIn+KXKa3YYK1v/afSVatwqm
         9jtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773665940; x=1774270740;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QiV2UgPzDyf2BIxEKlEP0kmveErchJjvWqwkP1nC5aU=;
        b=Z++ccMIJLE/dNqH3cP+oggi9jcgkn9OYPyE9f/LVcFWIuAnrfcPdh2X0gOYSyN4VqZ
         yUtV8yk7PhrxK4w8Cxizj5RPkRNKcBz5Q+itebUK7LAEzqn/7hlHpACgNsWl62ExL7J7
         e7nW9TYJB4TkDcqfDMqSRWttOQP/9OqWegcjCyJSTxK5kEvUiWYTeOJ+HUNbSkss8i8N
         MDbEmUVVVuzDaRZq0noBYE0PqPaI0UdRlY2MySN4KCOv7PDW2ScOlScqgQhErKo04bfJ
         xRV7dlZgrrCXG+fl28gHt0dFxCjUMnQiFIqu2UDOFU5m6mICM0rYSpd7ol7Kxlbi33i+
         AqQA==
X-Forwarded-Encrypted: i=1; AJvYcCWX0Q9sRUZJXbzZhXTW16QRppy2E6Ijnl2a0UkE0+rrgpUh5n0kWhsSargHfoGGauAxRs2d3g==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz/3JTcYKlUazG6zYLw6Yp6jKC3Zr5FefvrgGjeONC6YT0BfkyT
	0XlPVcKsLtpNWtrYE4m4Yz0Pn3uRxqRBC5zD8lkqOg3nMg9D6Frxm1+FbDGlepGFuqM=
X-Gm-Gg: ATEYQzxp17axrlAOBAQqWX52EpMZrJG0ULQaoGv67cHCnKI7WO0gvmV2OQ1/zu67vCZ
	kyAEUkVpAgV0JiTSy2/TGFrKZ2cv0WYmRdTk+pABmHArQ9SoyIbYDxPOVIIhgV32dTVoVL/sEI4
	vCaua20dpZUMGnxgKA08fNrjMJS+rW1/P69RGRd8MxS8GXwcNx5QYx8tb8S5+nMPs6BYSEqhrn0
	/gkVUPP3Pp4562WI1S3HFQBWTKlw4CWBDWYFKxsVw9AJIwQstFYlqyKc7+DJXoEUCStk5zz7kVq
	QeDizJc/4bI5XwebkuMOBXmts/iJdvbbmVb3UlKdYHu68mtuLhuNn5jh7y1ywohgZ9QxRc9U9Ec
	mMXHxo9afp+gRfa3j8XDRe+GSBtg/sdEfq3QMlv/zl+cB3BetO/waQbK52QlySWHZjg+Speujzk
	/k3aDPkjPwvmETbQ==
X-Received: by 2002:a05:6000:18a8:b0:439:ccec:fcd0 with SMTP id ffacd0b85a97d-43a04db4fb9mr22368246f8f.29.1773665939476;
        Mon, 16 Mar 2026 05:58:59 -0700 (PDT)
Received: from localhost ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b3e9a4fcdsm14591157f8f.8.2026.03.16.05.58.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 05:58:58 -0700 (PDT)
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
Subject: [PATCH v4 0/2] dma-buf: heaps: system: add an option to allocate explicitly decrypted memory
Date: Mon, 16 Mar 2026 13:58:55 +0100
Message-ID: <20260316125857.617836-1-jiri@resnulli.us>
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
(shared) memory allocations from new dma-buf system_cc_decrypted heap.
Userspace can mmap this memory and pass the dma-buf fd to other
existing importers such as RDMA or DRM devices to access the
memory. The DMA API is improved to allow the dma heap exporter to DMA
map the shared memory to each importing device.

Jiri Pirko (2):
  dma-mapping: introduce DMA_ATTR_CC_DECRYPTED for pre-decrypted memory
  dma-buf: heaps: system: add system_cc_decrypted heap for explicitly
    decrypted memory

 drivers/dma-buf/heaps/system_heap.c | 103 ++++++++++++++++++++++++++--
 include/linux/dma-mapping.h         |  10 +++
 include/trace/events/dma.h          |   3 +-
 kernel/dma/direct.h                 |  14 +++-
 kernel/dma/mapping.c                |  13 +++-
 5 files changed, 132 insertions(+), 11 deletions(-)

-- 
2.51.1

