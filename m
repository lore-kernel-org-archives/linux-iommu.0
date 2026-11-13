Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.100
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794563443;
	b=JNppl/nE/C/YBS0RwNPdHjLbKzO6sJS/5VBpdOWvXf2HicY8m44C8NRiSkro42QMLGh4
	 Mf0UQ+EULTlvdPbs81sPsCFU+DTNut9siOG5qvu3V0gjbjrsydqphZbgz2Ka0okpzXu+U
	 BO67vKAHQypZt9mz2NHEoSWDRGF6zvSPsMNuxDgL4cbz60lYGYqDWMBR0mAKMxQ+1CHax
	 AbtAhVNznPFOmShpMclZL/ggDRBvhy9mATx6uYa0Vbbjp/VPra5YaGtxddcVpl5baaoLx
	 722wo+cMNI0SnLYN04a2kirFZJzYEdACHgG0qeHxbZNL0TjeGg8HhXh07n7XWqmM4nw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794563443;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=qjJLQNicWLL6vQv4ufCop78f1wmYUYGwLXgPCg0B6qI=;
	b=kQrxvUJHvFRCX/JLutVOtXRZDLctl2zritZnLVIo2LCfgsSuCgKwwQKk3drjSv2ALWnQ
	 y1b7uFo4PIEIydmAwY3mtu+1vd5yUmwcCWN8HzTSSzwyqgal/WylXd7vO1KnAOl0LE8eG
	 vaBu8AGS22mcZ+ccl/+iKu2HBCqC9wXnK7Mdx0lTnfc+n198o6InSyK784+J+9LtbzZ3j
	 5798SnoZYFH7jbBnhmkFCeDjt/nwQ6g1nRtkN5I/asvWX5XO5LGb9RsKjIGyCz/T9gjK4
	 T77K3YyUeAfPlEdMQFo41EXTNjzKGVaTxZr4HEPij6p6Lu0NYzrUbkQO+Vw+y55L9qA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=l8wMKfHF;
	arc=none smtp.remote-ip=115.124.30.100
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED007606A32E
	for <iommu@lists.linux.dev>; Fri, 13 Nov 2026 09:50:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ED007606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=l8wMKfHF
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1794563434; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=qjJLQNicWLL6vQv4ufCop78f1wmYUYGwLXgPCg0B6qI=;
	b=l8wMKfHF458HfRoNluvh9FIUF6GyLIRMZLgmR6e7eu1k6xxnu9Lojz+bGcNo0uy0Dtfd7BTeZ1z3vEhQnpSa3BKgoHtSs5Azjp6r3y/lM/B4OGt13RmGvhSbpJxNTmeBACTQc4eRVdTsECghUVSER5Hf/xjMfhxIHmH7i+GGgLU=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R351e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=guanghuifeng@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0XEefznJ_1794563417;
Received: from VM20241011-104.tbsite.net(mailfrom:guanghuifeng@linux.alibaba.com fp:SMTPD_---0XEefznJ_1794563417 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 13 Nov 2026 17:50:33 +0800
From: Guanghui Feng <guanghuifeng@linux.alibaba.com>
To: joro@8bytes.org,
	vasant.hegde@amd.com,
	suravee.suthikulpanit@amd.com,
	will@kernel.org,
	robin.murphy@arm.com
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] iommu/amd: Optimize IRT cache invalidation for nested VM workloads
Date: Fri, 13 Nov 2026 17:50:15 +0800
Message-ID: <20261113095017.1835921-1-guanghuifeng@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
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

This series optimizes the AMD IOMMU interrupt remapping table (IRT)
cache invalidation path for nested virtualization workloads.

When IOMMU AVIC is enabled, every nested VM entry/exit that switches
interrupt routes between guest and remapping modes calls into
iommu_flush_irt_and_complete().  A reported workload with 4334 device
entries shows median lookup latencies of 22-33 us per invocation due
to a linear search_dev_data() walk, even when IRT caching is disabled
and the lookup result is unused.

Patch 1 moves the device lookup after the irtcachedis_enabled early
return, eliminating the unnecessary walk when IRT caching is off.

Patch 2 caches the device data pointer (resolved at IRQ allocation
time) in struct amd_ir_data and threads it through all IRTE update
paths: guest-mode toggle, affinity change, IRQ enable/disable, and
IRTE free.  The amd_irte_ops interface is extended to carry the
pointer, eliminating all search_dev_data() calls at runtime.

Both patches preserve DMA-alias invalidation, command ordering,
locking, and completion-wait semantics when IRT caching is enabled.

Guanghui Feng (2):
  iommu/amd: Skip device lookup when IRT caching is disabled
  iommu/amd: Reuse device data for IRTE cache invalidation

 drivers/iommu/amd/amd_iommu_types.h | 10 ++--
 drivers/iommu/amd/iommu.c           | 73 ++++++++++++++++-------------
 2 files changed, 48 insertions(+), 35 deletions(-)

-- 
2.43.7

