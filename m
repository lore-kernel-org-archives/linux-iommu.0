Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4EBA3502AC
	for <iommu@lists.linux.dev>; Mon, 23 Feb 2026 09:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771840302; cv=none; b=hNOSWI3MqIgGh6dTzD97hoMtm1MaYH3k1pbmXS+eKwdNcZFQMHMPIrJ1EnQAVxYm98eP7axolEa5va6Cu/9YjQn/zuKDdF+yykcU4f0blloiWDe2w8BM2qa5SbYAR1LL6ZGO4ryH1uBGsMcSYExzrLXSeDAajdJ7cMJNELIE1LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771840302; c=relaxed/simple;
	bh=KfFRfouRKPdjO8QdYp354wLUw4VwaWEdMEKo3LWxlW0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XaIWsUu/ftfmrujaDKcyMXSTubyRvZ4nIE1RzTUnk1QcLEQ1RcceLIXVszzAizkivqZ0sHvrvl5Xg7w77HckVqQzC6f8vjTkEuuJsl6ohPdXF9ZmlG2pErof5rEqe0SdrOsIavd7lySG1POWQVcrdnwWwNvgq5eoKY7GS0UpkjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=KhMQ+SVd; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="KhMQ+SVd"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-483703e4b08so32467625e9.1
        for <iommu@lists.linux.dev>; Mon, 23 Feb 2026 01:51:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1771840298; x=1772445098; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=J9P/hiUK/l/iV+NBMdNBP19LQ/+lioTm29Bruktj9zQ=;
        b=KhMQ+SVdeY1LQC8J0BF84xDkvkdNdFCLKSN1fRl8on3dQdL5OdA9+wmi+ffsbXDi6U
         vrtWJGqoUc66n1LVR0FsnEEE0uCN32LjWekil9RBBNpdF4SrumPcO3uHc+vaLmdgl1HG
         ceEwfG0goL8GS6Rsq9R4rcF0npa3PQ2xZUpNS9aWUZzET7yaS5J3luur4acuAMmG9KPH
         CN46C7sgemMFC9bX0Gdd0TPjVeWyue//DaiZWhxn1ZoewmPoPEyzSmbuQhjYPVAMqnKG
         DXH7oEKEh04MTuA9DGyoEj4QdQOevTCpzJoVR9GF8mNW/m6sAbH19kFQxb5u4AZkNDB/
         YXZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771840298; x=1772445098;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J9P/hiUK/l/iV+NBMdNBP19LQ/+lioTm29Bruktj9zQ=;
        b=r8Gj/ojDJ39719+FeQzze5c/VlXfTHKm8cWri9FZVGGpcyabQ4ssKLjzsko/UnPI+E
         +iMbL5OgdOYU5s7fnb6dP8UmMNtp4QVcoaV6TAktCgNu8jBLa2ffaSCj5yshY9GXwl1C
         iNH9p4vqw5cIyBw8qBNNmetYXQurBama2SEIF+XqUWibAXOlNU7kv8raMoBmOe86G4t+
         4qwVqNaWSjeFuhWvLaHywjjso7Zy0F6M7uUx3eccM7jwByhqcByZ5Cnso+JmTUFEZBQO
         rrmXpQKMLh6PvW8AUOXjWc04O1TDuFlqDusV1NS/RnNFcAtUfB5GZLCApT7DKOKDs7aA
         ewSw==
X-Forwarded-Encrypted: i=1; AJvYcCW2OuAnDBAlXOkQVucY6FAGKslq2QEYTubJYLqHq4FN3cn4CY1n4ndru7TTwRmP7RgPgH0gPA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxPOYfB982o7PMjEe7BcLxrHjbZjOC8xUnnPHErXbopISM/ItcE
	dFMGexBhLtMerhjXohN6hi/Tzl4Dl3HZhgJWM0WECbxOaTCcC7nsG/zs/LV+KTgxiYA=
X-Gm-Gg: AZuq6aIvuzY2Ou48+Xgd9NPL6RZqcUYrlwZsrGiT87Nm2cAfAZKlJsY6GY89lPKFcDO
	pOq7F/oKdYBTT7f8T5fm2HjEpUHVxFOeHuP5VyfRJpEtpfjDQ/oTsDc+IRMHqfcL6msErwZMUKW
	Bml/nVa9FTuSIcNzmFVmotYFWfWlQdzIGagTbUQG0/vU5E+EsZ3yudc9/11xxvUE5CKBZBtsC/b
	TixSJtQnb4XXlf3CBnMIosNcFtBY3XDbRjOwERX0VJk4gHyS3x9MbJY3dwF2Fg4TGkEP6wZguy5
	awSgl8pZnVqW+8J3ur2699JGMU8gah/58jqkUGP/oV+CtIvpON7bNZNn5NAwK5vzRKsO2mnCMWp
	U7+Sya+rDVewiSpIJRP7vKFgUnzbcjDAhmRvP4zvayf5oRrScrUeDteP7RE48OqUDCfOnQumdFA
	87/NDDRAgW/NTaGQ==
X-Received: by 2002:a05:600c:8b5b:b0:483:a352:b4e4 with SMTP id 5b1f17b1804b1-483a949e600mr141861245e9.6.1771840297668;
        Mon, 23 Feb 2026 01:51:37 -0800 (PST)
Received: from localhost ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483a9caadedsm152601835e9.10.2026.02.23.01.51.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 01:51:37 -0800 (PST)
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
Subject: [PATCH v2 0/2] dma-buf: heaps: system: add an option to allocate explicitly decrypted memory
Date: Mon, 23 Feb 2026 10:51:34 +0100
Message-ID: <20260223095136.225277-1-jiri@resnulli.us>
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

---
v1->v2:
 patch1:
  - rebased on top of recent dma-mapping-fixes
 patch2:
  - fixed build errors on s390 by including mem_encrypt.h
  - converted system heap flag implementation to a separate heap

Based on dma-mapping-fixes HEAD d5b5e8149af0f5efed58653cbebf1cb3258ce49a

Jiri Pirko (2):
  dma-mapping: introduce DMA_ATTR_CC_DECRYPTED for pre-decrypted memory
  dma-buf: heaps: system: add system_cc_decrypted heap for explicitly
    decrypted memory

 drivers/dma-buf/heaps/system_heap.c | 103 ++++++++++++++++++++++++++--
 include/linux/dma-heap.h            |   1 +
 include/linux/dma-mapping.h         |   6 ++
 include/trace/events/dma.h          |   3 +-
 include/uapi/linux/dma-heap.h       |   3 +-
 kernel/dma/direct.h                 |  14 +++-
 6 files changed, 119 insertions(+), 11 deletions(-)

-- 
2.51.1

