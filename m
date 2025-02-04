Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF49421CA0C
	for <iommu@lists.linux.dev>; Tue,  4 Feb 2025 23:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738712212; cv=none; b=HTxBVBOBPqKeraXZS8KsBKT2nOfRmRCfdhEdrolrTLVedptDGbbW9fbkbN3P8WjqXgN3EJFhPH+SiHlbEj9LUOrgoWLFUH8yoG9t8EZm3svfklQMHOxurJdLPirhemHvbVy3w2GgicZRoIt4ZwPVXsWfYXh3CVdhQGGCHVOY0WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738712212; c=relaxed/simple;
	bh=Y8LMNQfjvhxYUXrESxSs4UQlq94LLBtKS0HJKG82kbA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=NayXNUCRy/tf76ivSXv2NmtxjSqSDqAINJF1CG+xVR+hJVuVFYTFD5NxiggkXetcWtliCUZxiC7PMmaTsM55Nr7TtJ8ZjSKnH3+LBXWgt8/yP/e0TQHR+RG2WsgEnC6hBU7dGjtVBVgW1D29eWlw/ugWZ2KL7rkRst0PGDy3BOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jxgao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dKfzo8yG; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jxgao.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dKfzo8yG"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2f9da17946fso1512689a91.3
        for <iommu@lists.linux.dev>; Tue, 04 Feb 2025 15:36:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738712210; x=1739317010; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PccTYmsXXMpwJ1Bgt7X14x/KsDA07ItC/HZRh3EEVjg=;
        b=dKfzo8yG4QD7kOJ8fQGYogsySsW68MHC27QQ6XUMEl6w21dYKgIXgtvLiN5tWrL1o+
         oFfDT+rMkX9PO78Z7mdgIVYf6KNBNrglHaaNZoraHlbfbsFFEs9PiUSXXACfDPqELlOj
         S9Bs/LxXhHK2mMY1DVv9GTvsCudRTi3WVdyIUmpLvfEzYET66U9FOshIIUc0ZxwX/df8
         qmN/ZEfu6Fioef8FekULMRJzHGlnduRYCIzcmpOfLjL/ekw95xpTSqdN+Uakvl/UEaGq
         CfdGBrN/zk/xQGiloxfbrkh2/U/uAdx/EdnfLJqtT02k1Bt/8mjD1nBB9VufdvSenkIt
         DYkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738712210; x=1739317010;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PccTYmsXXMpwJ1Bgt7X14x/KsDA07ItC/HZRh3EEVjg=;
        b=jSjSfg+wguotXZt2GT6i5ObVg1oqnFfI37PtebtfN55x2g2UTwC9aYapVEqdsg82mG
         hXAgzUIzC/sSQd15cOny6qTKkpMxVMlF2k9D2EDhA2GErslKQSvkM2woZcfSHqDaj9GO
         2W5F/FXs9WCbwu4Ssu7X0hTk2BkzK2aFODKtvOPR5twvmKqEfCf1CiYSWzIM8DGslpOJ
         j7a8cvKN/vJGFU4v3sCJ7vrNMB0//6uc/Pr0d30InUca6O3013AtvyeuR35OflRpeyqs
         TJ9Kphqgxi6mLX7MRbF9nTwZW1MNWaCipbKBwdbpi9GE9lvLwI/rkSYTxg2iDcG5WYK5
         HWbg==
X-Forwarded-Encrypted: i=1; AJvYcCXh9o0h6GpXqC2FPtR+e8Cs+DQiGjXkJrQ5S1ebnS0zcuA/dICtMlNFGmdCsN81Rsn5IkWn6Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YxgIUs16OL16auwIqcexhiKY2UgGZObQoOMt4RZOF1yYrhi7C2h
	cPv9aIKDzrXpSj/N35SLLYxq3sJLuN0Ng7HrrmjgIysdJYSVqGgFdS31DtNurJVLzGsjKRHk/A=
	=
X-Google-Smtp-Source: AGHT+IEC4cHzAPzitpKUV1aW4FhzQtW/deThYzZUuUEJPKQsSPlMtCwXvC+6+Ut+e7VsBvTV1FZ5l1d7og==
X-Received: from pfey8.prod.google.com ([2002:a62:b508:0:b0:728:958a:e45c])
 (user=jxgao job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:ac8:b0:728:e1e3:3d88
 with SMTP id d2e1a72fcca58-730351257ccmr1028723b3a.7.1738712209843; Tue, 04
 Feb 2025 15:36:49 -0800 (PST)
Date: Tue,  4 Feb 2025 23:36:27 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.362.g079036d154-goog
Message-ID: <20250204233630.3407878-1-jxgao@google.com>
Subject: [RFC PATCH 0/3] Add an option for devices to skip SWIOTLB pre-copy on read.
From: Jianxiong Gao <jxgao@google.com>
To: Keith Busch <kbusch@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Robin Murphy <robin.murphy@arm.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Dan Williams <dan.j.williams@intel.com>, Erdem Aktas <erdemaktas@google.com>, 
	Vishal Annapurve <vannapurve@google.com>, Ryan Afranji <afranji@google.com>, 
	linux-nvme@lists.infradead.org, iommu@lists.linux.dev, 
	Jianxiong Gao <jxgao@google.com>
Content-Type: text/plain; charset="UTF-8"

Removes an extra memory copy that occurs during IO read
operations through the SWIOTLB. During high throughput
read workloads, this extra copy is causing a lot of stress
on the SWIOTLB.

With high performance devices, for example NVMe devices,
the device will be overwriting the entire buffer. In such
cases the entire pre-copy is redundent, only to slow down
the overall bounce buffering.

We propose to add a full_buffer_write flag to the
device_dma_parameters flag. When the flag is set the pre-copy
can be omitted to boost performance.

Jianxiong Gao (3):
  add full_buffer_write flag to struct device_dma_parameters
  skip swiotlb pre copy if the device does full buffer write.
  set full_buffer_write for nvme devices.

 drivers/nvme/host/pci.c     |  1 +
 include/linux/device.h      |  1 +
 include/linux/dma-mapping.h | 15 +++++++++++++++
 kernel/dma/swiotlb.c        |  3 ++-
 4 files changed, 19 insertions(+), 1 deletion(-)

-- 
2.48.1.362.g079036d154-goog

