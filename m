Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B21EC5;
	Thu, 22 Aug 2024 18:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724351867; cv=none; b=aXbtkmuLRqoNP/XAoVbDzOhDvGYyAuPULaxGOLYlNEpoYHyhQcR2JLSSpBxaVZtE3MDRlybH5uNoakXGVktUi8UAjJnvPKZ5xQHzXZ1TupE6CZrGIRhrUtFJUOqdFkypoPHIsQ676A4AdIpDZSQwOfxAJ0KfxQTvT8dYgAEfnuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724351867; c=relaxed/simple;
	bh=P19DGvRJHfXvmgQ7mc0QBm4YZAqPf12PUHoT4LyDy0Q=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=ekqnLfTTExnkcwZPisCbmywFfBil7P2WXhM6obk1sFGZrHxP9bPVt1POnkPysdG1ZTfxcC95KcPpptH83T4hzoG1dsvkq0e+7JIx3ojGDmEh24tz8PAXFXR7/NkRo2HGlonllmUCVVmzKlIUGnxcm8RdCKtDUrQT6gHws9Xr/io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ikv4W3vE; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ikv4W3vE"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2023dd9b86aso9557815ad.1;
        Thu, 22 Aug 2024 11:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724351865; x=1724956665; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VOaQTtxsk58SbDoLn+PAUGwK+8hE4FRojXrJ9dN8wyI=;
        b=Ikv4W3vE4D1eaRZ5Khp9E45k9KkSU+hkyFm7JZSetGJTMTy7Tbz59+ymF+b0vqKQID
         emTj2MdTdWhODC51I1KbNx6lnr7hh1+gEtul3bIcuNdunisV3MKIOquIedh6bV+VJCs/
         qGh6bYbVoZ04CjIUfOa7aVBszQG28CER6k3R7w2y3IJjVCTwNcXB/1Icjj9ecrQ1W1iv
         D9vsLpLWxrxm1DhT0ZucUpfR3O5WTdBURiwpUq+IJLgeKcQApa5tzOVw+HsZ+0sV//UV
         cnOyXvsubU7Z5CJ0txlPcZVk3MO4B691mw6/yZAS+1eI2+wpSP2iEnR2SLIv1tVwyE4X
         Z8Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724351865; x=1724956665;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VOaQTtxsk58SbDoLn+PAUGwK+8hE4FRojXrJ9dN8wyI=;
        b=cCnVdzvB3mds0WJNVfpc4WSBcTbtomArgAn4olN2GZCd16DCbVSxhj6JDdyX3j9NHa
         VCQvz9ea1MdCLIU2dsBirtP5eQup1fanBCVCfcKieg4OXTeW0CkJXdp/PBaBFuVxbRuO
         3XTwC7khS1Xct+ol8dfJ0CAcoB7a1ZldsYTnTUQKgo1naQrWvKczJFhPntb9tc5MCZL/
         hIOnpVBiqJdctIVO1Q5ne+MNRUofYleHVSfwsY2Gy9YfWtV2xo1yDL6KFA9Pri6qu8ga
         cajPmzdj21ayG78MQ3WonDBVwYbWquQfggt/76qI7+bos9Yun/IIMVSjIepNOhHmwQtx
         dvuA==
X-Forwarded-Encrypted: i=1; AJvYcCXFDnx7BXsV/aQgYfBY/4wFdBVU7jcNio+Bk6f/0nXIbYkWW9qSW4ULFxMrey8U8cFnmPG++mGkfd1khg==@lists.linux.dev, AJvYcCXWevlyJDEbAR3UlWSbvBNN+0dP+hRki8K729JE2AEc8SeZ00BI7HjnE+9a89KXQP8SQxLHLQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxadaf6cTWQ1D5+UtQl1Ku+/Gd3g9CWiC52mK9pcMwUnfXW+ejC
	Nuj1SVpfyqmlBiv/6uYz/sZotRt5TpXQ3ANaOlylZ/Rh4t0U5gNR
X-Google-Smtp-Source: AGHT+IEl3He9Aim4HWajrK80+KqOIG9qzlUskCayv41SgJM9s3grubdRM7QHgHTRWUeXewRIkkN6lw==
X-Received: by 2002:a17:902:d48c:b0:202:32cf:5db1 with SMTP id d9443c01a7336-20388b6a84cmr38489205ad.44.1724351865300;
        Thu, 22 Aug 2024 11:37:45 -0700 (PDT)
Received: from localhost.localdomain (c-67-160-120-253.hsd1.wa.comcast.net. [67.160.120.253])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2038557e4f9sm15667145ad.65.2024.08.22.11.37.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 11:37:44 -0700 (PDT)
From: mhkelley58@gmail.com
X-Google-Original-From: mhklinux@outlook.com
To: kbusch@kernel.org,
	axboe@kernel.dk,
	sagi@grimberg.me,
	James.Bottomley@HansenPartnership.com,
	martin.petersen@oracle.com,
	kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	robin.murphy@arm.com,
	hch@lst.de,
	m.szyprowski@samsung.com,
	petr@tesarici.cz,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-coco@lists.linux.dev
Subject: [RFC 0/7] Introduce swiotlb throttling
Date: Thu, 22 Aug 2024 11:37:11 -0700
Message-Id: <20240822183718.1234-1-mhklinux@outlook.com>
X-Mailer: git-send-email 2.25.1
Reply-To: mhklinux@outlook.com
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michael Kelley <mhklinux@outlook.com>

Background
==========
Linux device drivers may make DMA map/unmap calls in contexts that
cannot block, such as in an interrupt handler. Consequently, when a
DMA map call must use a bounce buffer, the allocation of swiotlb
memory must always succeed immediately. If swiotlb memory is
exhausted, the DMA map call cannot wait for memory to be released. The
call fails, which usually results in an I/O error.

Bounce buffers are usually used infrequently for a few corner cases,
so the default swiotlb memory allocation of 64 MiB is more than
sufficient to avoid running out and causing errors. However, recently
introduced Confidential Computing (CoCo) VMs must use bounce buffers
for all DMA I/O because the VM's memory is encrypted. In CoCo VMs
a new heuristic allocates ~6% of the VM's memory, up to 1 GiB, for
swiotlb memory. This large allocation reduces the likelihood of a
spike in usage causing DMA map failures. Unfortunately for most
workloads, this insurance against spikes comes at the cost of
potentially "wasting" hundreds of MiB's of the VM's memory, as swiotlb
memory can't be used for other purposes.

Approach
========
The goal is to significantly reduce the amount of memory reserved as
swiotlb memory in CoCo VMs, while not unduly increasing the risk of
DMA map failures due to memory exhaustion.

To reach this goal, this patch set introduces the concept of swiotlb
throttling, which can delay swiotlb allocation requests when swiotlb
memory usage is high. This approach depends on the fact that some
DMA map requests are made from contexts where it's OK to block.
Throttling such requests is acceptable to spread out a spike in usage.

Because it's not possible to detect at runtime whether a DMA map call
is made in a context that can block, the calls in key device drivers
must be updated with a MAY_BLOCK attribute, if appropriate. When this
attribute is set and swiotlb memory usage is above a threshold, the
swiotlb allocation code can serialize swiotlb memory usage to help
ensure that it is not exhausted.

In general, storage device drivers can take advantage of the MAY_BLOCK
option, while network device drivers cannot. The Linux block layer
already allows storage requests to block when the BLK_MQ_F_BLOCKING
flag is present on the request queue. In a CoCo VM environment,
relatively few device types are used for storage devices, and updating
these drivers is feasible. This patch set updates the NVMe driver and
the Hyper-V storvsc synthetic storage driver. A few other drivers
might also need to be updated to handle the key CoCo VM storage
devices.

Because network drivers generally cannot use swiotlb throttling, it is
still possible for swiotlb memory to become exhausted. But blunting
the maximum swiotlb memory used by storage devices can significantly
reduce the peak usage, and a smaller amount of swiotlb memory can be
allocated in a CoCo VM. Also, usage by storage drivers is likely to
overall be larger than for network drivers, especially when large
numbers of disk devices are in use, each with many I/O requests in-
flight.

swiotlb throttling does not affect the context requirements of DMA
unmap calls. These always complete without blocking, even if the
corresponding DMA map call was throttled.

Patches
=======
Patches 1 and 2 implement the core of swiotlb throttling. They define
DMA attribute flag DMA_ATTR_MAY_BLOCK that device drivers use to
indicate that a DMA map call is allowed to block, and therefore can be
throttled. They update swiotlb_tbl_map_single() to detect this flag and
implement the throttling. Similarly, swiotlb_tbl_unmap_single() is
updated to handle a previously throttled request that has now freed
its swiotlb memory.

Patch 3 adds the dma_recommend_may_block() call that device drivers
can use to know if there's benefit in using the MAY_BLOCK option on
DMA map calls. If not in a CoCo VM, this call returns "false" because
swiotlb is not being used for all DMA I/O. This allows the driver to
set the BLK_MQ_F_BLOCKING flag on blk-mq request queues only when
there is benefit.

Patch 4 updates the SCSI-specific DMA map calls to add a "_attrs"
variant to allow passing the MAY_BLOCK attribute.

Patch 5 adds the MAY_BLOCK option to the Hyper-V storvsc driver, which
is used for storage in CoCo VMs in the Azure public cloud.

Patches 6 and 7 add the MAY_BLOCK option to the NVMe PCI host driver.

Discussion
==========
* Since swiotlb isn't visible to device drivers, I've specifically
named the DMA attribute as MAY_BLOCK instead of MAY_THROTTLE or
something swiotlb specific. While this patch set consumes MAY_BLOCK
only on the DMA direct path to do throttling in the swiotlb code,
there might be other uses in the future outside of CoCo VMs, or
perhaps on the IOMMU path.

* The swiotlb throttling code in this patch set throttles by
serializing the use of swiotlb memory when usage is above a designated
threshold: i.e., only one new swiotlb request is allowed to proceed at
a time. When the corresponding unmap is done to release its swiotlb
memory, the next request is allowed to proceed. This serialization is
global and without knowledge of swiotlb areas. From a storage I/O
performance standpoint, the serialization is a bit restrictive, but
the code isn't trying to optimize for being above the threshold. If a
workload regularly runs above the threshold, the size of the swiotlb
memory should be increased.

* Except for knowing how much swiotlb memory is currently allocated,
throttle accounting is done without locking or atomic operations. For
example, multiple requests could proceed in parallel when usage is
just under the threshold, putting usage above the threshold by the
aggregate size of the parallel requests. The threshold must already be
set relatively conservatively because of drivers that can't enable
throttling, so this slop in the accounting shouldn't be a problem.
It's better than the potential bottleneck of a globally synchronized
reservation mechanism.

* In a CoCo VM, mapping a scatter/gather list makes an independent
swiotlb request for each entry. Throttling each independent request
wouldn't really work, so the code throttles only the first SGL entry.
Once that entry passes any throttle, subsequent entries in the SGL
proceed without throttling. When the SGL is unmapped, entries 1 thru
N-1 are unmapped first, then entry 0 is unmapped, allowing the next
serialized request to proceed.

Open Topics
===========
1. swiotlb allocations from Xen and the IOMMU code don't make use of
throttling. This could be added if beneficial.

2. The throttling values are currently exposed and adjustable in
/sys/kernel/debug/swiotlb. Should any of this be moved so it is
visible even without CONFIG_DEBUG_FS?

3. I have not changed the current heuristic for the swiotlb memory
size in CoCo VMs. It's not clear to me how to link this to whether the
key storage drivers have been updated to allow throttling. For now,
the benefit of reduced swiotlb memory size must be realized using the
swiotlb= kernel boot line option.

4. I need to update the swiotlb documentation to describe throttling.

This patch set is built against linux-next-20240816.

Michael Kelley (7):
  swiotlb: Introduce swiotlb throttling
  dma: Handle swiotlb throttling for SGLs
  dma: Add function for drivers to know if allowing blocking is useful
  scsi_lib_dma: Add _attrs variant of scsi_dma_map()
  scsi: storvsc: Enable swiotlb throttling
  nvme: Move BLK_MQ_F_BLOCKING indicator to struct nvme_ctrl
  nvme: Enable swiotlb throttling for NVMe PCI devices

 drivers/nvme/host/core.c    |   4 +-
 drivers/nvme/host/nvme.h    |   2 +-
 drivers/nvme/host/pci.c     |  18 ++++--
 drivers/nvme/host/tcp.c     |   3 +-
 drivers/scsi/scsi_lib_dma.c |  13 ++--
 drivers/scsi/storvsc_drv.c  |   9 ++-
 include/linux/dma-mapping.h |  13 ++++
 include/linux/swiotlb.h     |  15 ++++-
 include/scsi/scsi_cmnd.h    |   7 ++-
 kernel/dma/Kconfig          |  13 ++++
 kernel/dma/direct.c         |  41 +++++++++++--
 kernel/dma/direct.h         |   1 +
 kernel/dma/mapping.c        |  10 ++++
 kernel/dma/swiotlb.c        | 114 ++++++++++++++++++++++++++++++++----
 14 files changed, 227 insertions(+), 36 deletions(-)

-- 
2.25.1

