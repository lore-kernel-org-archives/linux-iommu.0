Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E99D73EAC68
	for <iommu@lists.linux.dev>; Mon, 17 Aug 2026 14:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786976910; cv=none; b=TD00rAd5mDiDdd4muBUK3EGjdmSZx++uxDQdHKPOpR6c52HfQI7xYR4O4w7wkvrXTEPix1Klr0bxv7f/8yvJJajw9vcPvEkXvip4mZ7L9vV5zZitQoiMhRPhnkRsERMP8wOEHW3PpeQbcOwM1+hVA9PGSutg3HqggiGpbbV0x8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786976910; c=relaxed/simple;
	bh=X4cKSvx4ZGMjmvdTSxtMik+aWGF09XixVnOhGjAXP6Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ps9OdzukoQ50A1H92OygY9RUtMQGzTeTdNyzopFDlF8VoeOGj2oeKHr1bOEudclF9JnfgaZo7SxMZ1HwDqy/WknRNFmkMKsgH3aFgs2WX+nKjtQa9aDnL7SVrkZRntVHQJfQz6Vwywj92URWA6LIPbf38Al9WFWCHPD7DEidVtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=mus8SQrS; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="mus8SQrS"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1786976903; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=AAVyRRiB6YJw8T+BYBbylAg5P5XU3rF1oitwGGOwwUc=;
	b=mus8SQrSmtp9D2TVL/OuTIABwT2EP7wJkpPdq9FHD5tso4vHR2PYtz02IrEjoZHFzPCsp8E+tDMiDxW+MPLK7psHwjEnSi+AhRtkDdHHQn+3hl/QzVYo8a+Av1m9A1t21wtt+hUCnDwLSh+EzpcXczFZj3Z63ydMZPMWu2SsILo=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=fangyu.yu@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0X9A9H-E_1786976900;
Received: from localhost.localdomain(mailfrom:fangyu.yu@linux.alibaba.com fp:SMTPD_---0X9A9H-E_1786976900 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 17 Aug 2026 22:28:21 +0800
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
	zong.li@sifive.com
Cc: fangyu.yu@linux.alibaba.com,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH 0/3] iommu/riscv: Fix command queue publishing races
Date: Mon, 17 Aug 2026 22:27:25 +0800
Message-Id: <20260817142728.61783-1-fangyu.yu@linux.alibaba.com>
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

Fangyu Yu (3):
  iommu/riscv: Add command queue lock
  iommu/riscv: Serialize command queue publishing
  iommu/riscv: Avoid waiting on failed command enqueue

 drivers/iommu/riscv/iommu.c | 121 ++++++++++++++++++++++--------------
 drivers/iommu/riscv/iommu.h |   2 +
 2 files changed, 76 insertions(+), 47 deletions(-)

-- 
2.50.1

