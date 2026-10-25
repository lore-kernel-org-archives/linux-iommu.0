Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.111
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792935026;
	b=4HHT+Z5BEgiYj4XhaXrmGBFFrPmfo7VFYQDTPTutWv7uAW5GKrYYtUqpmtF1sBSpMXSD
	 7vKlBnDTjAtAuczPm+KRBUhTCrKcyYMuUOfzjk7r1EHyImp/v6hSRpotbSo8kAOlX3K0l
	 SpI+ZMByI09wCh97cf7gGLcmVVD4ikW51DsKikmOsHk9sJrGF5uF+XqfGHVcS+01nF0/x
	 qGISc/3zHU3RSy/WP3dTQmZlVqbsJ8yHJXgYc3CWoW/l5CrudbCnNxH4rqgyd5IDX+vwf
	 vi18U3XHTR0iYvHkvKM5NKzLxd44Jzsj5BVi3zgknn3B2pq56VoDEowSLAXwChCm2Jg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792935026;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=+n8GzFLwIs6kJq4X8aNKy8RDZSwodsQriGPD8H/OFq4=;
	b=Xw297JqXmxI+7wfW95wO6i+IxbrKBUuhvA8PCYZJsVcBNq3pLkjcynJ6KwUQaWJ5SB2+
	 vSMDzHlcgZKgWoVVuJ226iqXpWXK0EOYrarrDtdSSd+XpbOw4apNWIwFaxVj6M5XONii/
	 uNmGxEQx14M54l1xZN3TI3zxI+kn8zy3J2TMEcXRlAkiVcIwkL0yiTxtrMCtAWLuaUtxk
	 070x05vQll4SEyOxLyNwxDq1u4Npjewy5CQPlN4i3VY9U/ioiPfWJJtbmJqt9S1epv/mi
	 X4iYPcI6DCisJcf197b7K/IJ42upVmfJYJFrxU19jqNCmbLRjwfxRaMZYtL6HuLtqVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=T2LAGSJh;
	arc=none smtp.remote-ip=115.124.30.111
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5955606A31D
	for <iommu@lists.linux.dev>; Sun, 25 Oct 2026 13:30:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E5955606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=T2LAGSJh
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1792935022; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=+n8GzFLwIs6kJq4X8aNKy8RDZSwodsQriGPD8H/OFq4=;
	b=T2LAGSJh148jXc6Trzry76hRVOntBti1pxctbiaD9dUIwOoFXRYFpXCl7vTgjzEaROZZdQ7y8bX2YwScvmczsMRbbFxH/CZ0aCLHk9kk0F4Foo/NAyH7bBGnCAX/ZFONysgskWWXpKL4MhBVv/H2VzqKHnNV6OgP8MlzB5hxgnQ=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=guanghuifeng@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0XDQQjHo_1792935000;
Received: from VM20241011-104.tbsite.net(mailfrom:guanghuifeng@linux.alibaba.com fp:SMTPD_---0XDQQjHo_1792935000 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sun, 25 Oct 2026 21:30:21 +0800
From: Guanghui Feng <guanghuifeng@linux.alibaba.com>
To: jgg@ziepe.ca
Cc: alex@shazbot.org,
	iommu@lists.linux.dev,
	joro@8bytes.org,
	kevin.tian@intel.com,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	robin.murphy@arm.com,
	will@kernel.org
Subject: [PATCH v4 0/2] iommu/iommufd: Expose PCI host bridge MMIO windows for opt-in IOVA avoidance
Date: Sun, 25 Oct 2026 21:29:58 +0800
Message-ID: <20261025133000.205508-1-guanghuifeng@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261022193359.GF3381610@ziepe.ca>
References: <20261022193359.GF3381610@ziepe.ca>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a device sits behind a PCIe switch and ACS Upstream Forwarding is
not fully enabled, DMA TLPs whose IOVA happens to fall within a host
bridge MMIO window may be routed peer-to-peer to another downstream
device instead of upstream to the root complex for IOMMU translation.
This can lead to faults, data corruption, or silent misrouting.

The DMA IOVA layer already avoids this via iova_reserve_pci_windows().
However, passthrough paths that let userspace pick IOVAs (VFIO type1,
iommufd) had no mechanism to learn about these ranges.  Commit
cd2c9fcf5c66 ("iommu/dma: Move PCI window region reservation back into
dma specific path.") intentionally keeps this information out of the
IOMMU reserved-region API to avoid pessimistically restricting
userspace.

Following Jason Gunthorpe's suggestion [1], this series takes an opt-in
approach: the kernel reports the information, userspace decides whether
to avoid it.

  Patch 1 adds iommu_for_each_pci_mmio_window(), a callback-based
  iterator in the IOMMU core that enumerates host bridge MMIO windows
  with zero intermediate allocation.  dma-iommu.c is refactored to use
  it, sharing the same algorithm.

  Patch 2 adds the IOMMU_GET_PCI_MMIO_WINDOWS ioctl to iommufd, a
  per-device query that returns these windows to userspace without
  reserving or enforcing them.

[1] https://lore.kernel.org/all/20260921115513.GK11599@ziepe.ca/

v3: https://lore.kernel.org/all/20261004162213.3787623-1-guanghuifeng@linux.alibaba.com/
v2: https://lore.kernel.org/all/20260921103922.1113752-1-guanghuifeng@linux.alibaba.com/
v1: https://lore.kernel.org/all/20260921070234.897736-1-guanghuifeng@linux.alibaba.com/

Changes since v3:
- Patch 1: redesign helper as a callback-based iterator
  (iommu_for_each_pci_mmio_window) per Jason's review [2].  This
  eliminates intermediate iommu_resv_region allocations, avoids size_t
  truncation on 32-bit PAE (callback receives phys_addr_t directly),
  and allows dma-iommu.c to share the same algorithm with zero overhead.
- Patch 1: dma-iommu.c now uses the shared iterator as Jason requested
  ("if you are going to add a function to the iommu core then
  dma-iommu.c should also use it").
- Patch 2: rename 'windows' field to 'out_windows' per iommufd
  convention.
- Patch 2: remove irrelevant 1:1 IOVA discussion from kdoc (iommufd
  only supports identity-mapped devices).
- Patch 2: explicitly state that windows are reported in host bridge
  resource list order, typically non-overlapping but no sorting
  guarantee.
- Patch 2: handler simplified to use callback directly (no linked list
  allocation/cleanup needed).

[2] https://lore.kernel.org/all/20261022193527.GG3381610@ziepe.ca/

Changes since v2:
- Complete redesign from forced reservation to opt-in query (per Robin
  Murphy's and Jason Gunthorpe's v2 review).

Changes since v1:
- (Superseded by later changes.)

Guanghui Feng (2):
  iommu: Add iommu_for_each_pci_mmio_window() iterator
  iommufd: Add IOMMU_GET_PCI_MMIO_WINDOWS ioctl

 drivers/iommu/dma-iommu.c               | 29 +++++++----
 drivers/iommu/iommu-priv.h              | 25 ++++++++++
 drivers/iommu/iommu.c                   | 51 ++++++++++++++++++++
 drivers/iommu/iommufd/device.c          | 64 +++++++++++++++++++++++++
 drivers/iommu/iommufd/iommufd_private.h |  1 +
 drivers/iommu/iommufd/main.c            |  3 ++
 include/uapi/linux/iommufd.h            | 59 +++++++++++++++++++++++
 7 files changed, 224 insertions(+), 8 deletions(-)

-- 
2.43.7

