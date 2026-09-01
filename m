Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65CD82F3C18
	for <iommu@lists.linux.dev>; Tue,  1 Sep 2026 13:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788269971; cv=none; b=hHRoF51QvBth7UOtnXeKA3MS9cvkCXdGiuf+WxC34uAHgrzv9xY5Ij/YIbhtdiRGmlxKoPmNybUSX3wEWUIbrYWFWX+LxhhmLwpSZAtnVUBxAjNgYIdB4hPAJD08hJW6tqWcp8hLfF+WEwGSRzMzhH5e/NxPWL68r9ugeNV46IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788269971; c=relaxed/simple;
	bh=GETv14Dpfp5sEawaBob7toQBWXgFrpyikggq3YNNmkg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JBLbIQrWsTHrCDJ5b7inScAiVu5ZakGi/sHAUyfMyrQYJXOD1ao0uU7VsV1DKS53rbmIKpeh006ED8f9DwPaZYmVjuHDio3GftUzkRiTQqvLuoaJFTOTncjmQrzRdxtH/PZ5/unRWMjObM1cPXPXWxbfHihQgVLvhFn7XrXoqGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=f8DxVwFu; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="f8DxVwFu"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1788269965; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=rjZG1oum5ouwIyghJAvrKRp+c0uDhrzvhztsrMAS+V4=;
	b=f8DxVwFu1I1zMWp+9TwoNs1EYCWd/M2eIv0Tl1RQBGDwfL5gSxdEVrHThKMeAkzBsX8stfdewhgyTDCJFq8t2h3AYF0qETIjTBJ+GwlwcC617IvZWnIyGTwJtHIqdY88zGQkrJCmlDEEqHUw0HvT7MveiQzawciilNMEfvhAB58=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=fangyu.yu@linux.alibaba.com;NM=1;PH=DS;RN=20;SR=0;TI=SMTPD_---0XA9NaXm_1788269962;
Received: from localhost.localdomain(mailfrom:fangyu.yu@linux.alibaba.com fp:SMTPD_---0XA9NaXm_1788269962 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 01 Sep 2026 21:39:23 +0800
From: fangyu.yu@linux.alibaba.com
To: tomasz.jeznach@linux.dev,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	baolu.lu@linux.intel.com,
	jroedel@suse.de,
	zong.li@sifive.com,
	andrew.jones@oss.qualcomm.com,
	anup@brainfault.org,
	jgg@nvidia.com,
	jgg@ziepe.ca
Cc: fangyu.yu@linux.alibaba.com,
	guoren@kernel.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH v2 0/3] iommu/riscv: Fix command queue publishing races
Date: Tue,  1 Sep 2026 21:39:17 +0800
Message-Id: <20260901133920.14550-1-fangyu.yu@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fangyu Yu <fangyu.yu@linux.alibaba.com>

This series fixes races in the RISC-V IOMMU command queue submission
path.

The current command queue code reserves a producer index before the
command is written and before the hardware tail is updated. Multiple CPUs
can therefore reserve different producer indexes concurrently and then
wait for the software tail to reach their index before publishing their
own command.

That model is fragile when a command submission fails after reserving an
index. The failed producer index is never published, so later submitters
can wait behind a hole in the software producer stream. This can also
lead to misleading IOFENCE.C completion timeouts, because the sync path
may wait for a producer index whose command was never actually enqueued.

Fix this by serializing command queue publishing with a raw spinlock.
Instead of reserving producer indexes ahead of time, the submission path
uses the current software tail as the next command index, writes the
command, publishes the hardware tail, and then advances the software tail
while holding the lock. When the command queue is full, the code drops
the lock and waits for hardware consumption before retrying, so other CPUs
are not blocked behind a long hardware poll.

The final patch changes the queue submission helper to return an error 
when enqueue fails. The IOFENCE.C sync path then avoids waiting for a
command that was never published to hardware.

This series does not attempt to add full RAS/error recovery for command 
queue failures. It keeps the existing local error reporting behavior and
only fixes the software queue state and wait semantics.

---
Changes in v2:
    - Avoid reacquiring the command queue lock after waiting for space
      times out.
    - Link to v1:
      https://lore.kernel.org/linux-riscv/20260817142728.61783-1-fangyu.yu@linux.alibaba.com/

Fangyu Yu (3):
  iommu/riscv: Add command queue lock
  iommu/riscv: Serialize command queue publishing
  iommu/riscv: Avoid waiting on failed command enqueue

 drivers/iommu/riscv/iommu.c | 117 +++++++++++++++++++++---------------
 drivers/iommu/riscv/iommu.h |   2 +
 2 files changed, 72 insertions(+), 47 deletions(-)

-- 
2.50.1

