Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C293037882B
	for <iommu@lists.linux.dev>; Thu, 23 Apr 2026 10:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776938963; cv=none; b=o8H4XT92QqDYJiLDSN5rJZmijaggzGi3MZeu6rcFg84AQ1QealyY1BjI5zGjXnuJLzDSQfD75G2N5bQn1bnCg3QHaX+/Y7dnMXg4bdg7RU6vilVGmca4MDnUEtE1S72rYQgyEAuuUM9ifcyWYEZARl2JH+7leOXdz6I8wgiELzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776938963; c=relaxed/simple;
	bh=EiYD+auU7T86T0M9WDiOvQ9Vuoydls3BzM6AwDu+XGk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Tw4LT4MA20K7pMQN3IqoA1M4IKpxBaQpKgxH3GQvwg/yRIP0GxfNQZADr00E38OyRv+cZ9CrjuyIU8+sPQ9qDWfo9mKhNhbXdtBkvFxjgEhxXxJvAqiRxw/NsI7mFsMGk4j3gwUPtQ4BFd+evQr2n87G+cWLDPymJaMBCWkUmpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D2LF66Bz; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D2LF66Bz"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3585ec417f6so3513151a91.1
        for <iommu@lists.linux.dev>; Thu, 23 Apr 2026 03:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776938962; x=1777543762; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IIyEuNNu5zTG4lMLqGXtVa8tjcYDo3Ze6J4csLjrIb8=;
        b=D2LF66BzoHJmOXPB5tLSt5hztiAxX5ZQ430H2EjiPXmcpm00Fm57/z8E2aBBfkQ7Oe
         SV9v2FiW+6epv4tJ40XLC5E/Lh4Yxbix06iR0c+BRqhP0etEV68WeEvJFBlwE3R7CKk7
         +RL3riEjfP2639ExBS1T+kLqoQAPQ/Bl6ofuu2I7DHTaFhqLk5sPCnj6uugcLFRAH9q8
         8RBZfkth1d8IJG5wTFeNL9jag9LnRWr21TGt7emFzjLh6ZsllsYUCbRaxzhn+d67lPXX
         xeetBIChwuwLwmqHqUArVkv2WBcyAzCQ08lkn0SXC5g8gvGXQobwKLrcCkzmLxc3PNqm
         ojIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776938962; x=1777543762;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IIyEuNNu5zTG4lMLqGXtVa8tjcYDo3Ze6J4csLjrIb8=;
        b=WrF+ZcS5vLWPmFhSQYN4TUjVdpeLQOP25e0NSQMIZ37xUXLygPtFDSgZOI83DPaVjp
         dbAMquDcMQ5RtZjC8g6snTueiFbhf72Na1zSaxCZ4yXcmKUZXVyMqXKUHWwhmd8tP9iB
         5mmfT+x1RDXBfomInVcQkQ024F21mK0laUI+8npBR54By99xYPNIbw9k2CPq15oOaVm3
         rpEdQOnM3OEijHyTYQ+92+Pr//MsvNraiQLjRRFQMhY9KOeKIKcMvV91jZbOWFz3rNP2
         v2e6FV8J/f2tADEECyuH30KOdQ4OYpGo0kJ/847KxblY5e8/fKXEIG9kN3BUlO+CyPPi
         QIyQ==
X-Forwarded-Encrypted: i=1; AFNElJ8dwMSNmng6S5LXFO2GsV0SEyVaNjlpmGgt2lXwBEJO5FCQG8ARp4kJiFYfYSj4bZlK1U+vbQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyKYqLwgRf7fSgOyPkd4hT8Wnt7KiPeWhTvrU7Qwni7x6vB3ifI
	1esxzmtdhWYx4P/TkdzTdDqIu2LiPmO02XgwAtCYfNvlP5JYeZ3gTE0Z
X-Gm-Gg: AeBDievZZu5GjCyodBWwrrlpZPHr4G70B4XpnQ6Dke0SsuM4PWARR69k2QEbpVH+ENe
	ilx8sRIGGC8qkgrUwqZDBFKKaejd4PQtlDSWgvZuIcwckDM+5HhZUwwZJduiuL5WtFcQt58S5E7
	lHW88XZwV31Fr5Z0LMh2P6kLyZKZfnZwbgYstozvP1HlUDYUIyN3oKyofD5p8DR1mTKHnZZRMaQ
	w6/w6p6Fm+fpqx9Rbn4ZmpKc7kmFGDryxEFEPFtN4ovBOi56vtHQEM2blucxgvuiB4FCMef+dr6
	3AslKrFnc9zrbiiS6vMou+iGOP6/JXwhncPu7NUgGKvnbVIm2VL8OFsnG4KtMzQbYQLGYRJM3UT
	2XE3WdeeJSBDskE0noOY4ysZflp0//wlO2SmFlx5MmcY0oTRwZ7RPGZqtUQGRW4C2l8pipZ7q3A
	WfwX1lxBX/t774F5kTOdzMV32L3FC6lGvh3w==
X-Received: by 2002:a17:90b:3d8e:b0:35f:b9ba:45b4 with SMTP id 98e67ed59e1d1-3613feec4d7mr20584096a91.0.1776938961918;
        Thu, 23 Apr 2026 03:09:21 -0700 (PDT)
Received: from fedora ([2401:4900:1cbc:314:9667:4972:a94c:125a])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36140fc5d94sm25275714a91.2.2026.04.23.03.09.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 03:09:21 -0700 (PDT)
From: avinash pal <avinashpal441@gmail.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Lu Baolu <baolu.lu@linux.intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	avinash pal <avinashpal441@gmail.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH stable 6.12 0/2] iommu/vt-d+dma: fix stale DMA PTE WARN on IOVA reuse (regression v6.12.75)
Date: Thu, 23 Apr 2026 15:39:02 +0530
Message-ID: <20260423100904.5966-1-avinashpal441@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Two-patch series addressing the stale-DMA-PTE WARN_ON regression that
hits kernels 6.12.75 and 6.12.76 when Intel IOMMU is enabled.

  Bugzilla : https://bugzilla.kernel.org/show_bug.cgi?id=221389
  Unaffected: v6.12.74   (confirmed: Giovanni Pancotti, 2026-04-22)
  Affected  : v6.12.76   (WARN on ATA/SCSI DMA workloads)
  Workaround: intel_iommu=off

Root cause
==========
The lazy-flush path in __iommu_dma_unmap_sg() releases an IOVA back to
the allocator via free_iova_fast() before iommu_iotlb_sync() drains the
hardware TLB.  A concurrent map() on the same domain receives the same
IOVA and hits a live PTE in __domain_mapping():

  CPU 0 (unmap, lazy path)        CPU 1 (concurrent map)
  ──────────────────────────      ───────────────────────────────
  iommu_unmap(iova)
  free_iova_fast(iova)  ← live
                                  alloc_iova_fast() → same iova
                                  __domain_mapping()
                                    dma_pte_present() == true
                                    WARN_ON_ONCE()          ← hit

Patches
=======
1/2  iommu/vt-d: fail map loudly on stale DMA PTE
     - Replaces bare WARN(1,...) with pr_err_ratelimited + WARN_ON_ONCE
     - Prints vPFN + old PTE value for debugging
     - Returns -EEXIST; no silent double-map

2/2  iommu/dma: sync IOTLB before releasing IOVA on sg unmap
     - Adds iommu_iotlb_sync() before free_iova_fast() on lazy path
     - Closes the race window; strict-mode path already does this

ACTION NEEDED by reviewer: run
  git log v6.12.74..v6.12.76 -- drivers/iommu/dma-iommu.c
to identify the offending commit for the Fixes: tag in patch 2/2.

avinash pal (2):
  iommu/vt-d: fail map loudly on stale DMA PTE
  iommu/dma: sync IOTLB before releasing IOVA on sg unmap

 drivers/iommu/dma-iommu.c   |  9 +++++++
 drivers/iommu/intel/iommu.c | 50 ++++++++++++++++++++++++++++---------
 2 files changed, 47 insertions(+), 12 deletions(-)


base-commit: 444b39ef6108313e8452010b22aaba588e8fb92b
-- 
2.53.0

