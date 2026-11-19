Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.113
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795097647;
	b=cVmX5fRMlLv9GtalL2qFNOwM6pULqjZb31bvs9dRmnH1fSk4zHUBP3nFsQOwkUFdn97H
	 +PGllk3lOtrA/HPfYccz7ieUBVlZydovRxBr0VSl10gkLpeGH9lBtCVxsp4i2Isqx0oGB
	 YyMxI7CXrc2ILfQaDmBQ6K4I0Nt61RYvmZMsvqypOfJKYfFdNi8V8npRMSLLrFHYAeS9J
	 t5l7A6oSeaMcpJImcN1pFuP2qx841CSUaHFrXEFiFer/dSzRvm26DvzDrge5djlJlL0f3
	 vBLjtl8zuBxoR6j+/WktQ5pUIFUDQZnizwyUyH7u/pvT99HZkL5pS+SAw4Wb7AEfUHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795097647;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ZogT7/MGl2KEIH3Xo7jtAzMWnJh61ng1b7MVoKSyfzE=;
	b=yiQ/vbKUOtxlTDMakdoBe+0U0Pe+qHehQ4hNj9/PA6dIdMQ4mSZIBBgwfL1ZFdwYcS1s
	 BLmRr0DhTIDAEwjk9KJ2WH+jUHmSIUENMrGlgDALQVFYIN2mUmVwlVbuMQ1ZsYjl8wvMh
	 xhILolFT1irIcN2LoY6XuPg3QqR8+JPUMYDTxMwCweotrHB88raEZ7z/q2AMOdOrfzGpP
	 a3Z6Le5hX/Kw/NUNPFd/yLZ/cWLbQsh/+g9dOyQCxfVQdrjjC83KFMJsmIWwiztlH/G/C
	 POrqieY02vpwy0vd2TFNIjtnXwomgZC5cyUgQJgrQ/8m2b6wTgdVi3KkBAxNLQf+UqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b="ZpL+Nk/D";
	arc=none smtp.remote-ip=115.124.30.113
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83516606A33B
	for <iommu@lists.linux.dev>; Thu, 19 Nov 2026 14:14:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 83516606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=ZpL+Nk/D
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1795097642; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=ZogT7/MGl2KEIH3Xo7jtAzMWnJh61ng1b7MVoKSyfzE=;
	b=ZpL+Nk/DnEmeacXOc6QxB0mp4wu8slMgfOfnWYFzbZdLc6HitbO9aPTBO7eDlNcJzjSzd/zHB8Djr8zYKEOdNQjS+TWGiq8mKhXrm2/7eTE9Pl5PxbIkiIHVX+ka6kPkaZnCgvZzhe5vtBFXmDBxSp2l38qDSmrOEIA4SzAplpE=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=guanghuifeng@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0XF3i-zK_1795097628;
Received: from VM20241011-104.tbsite.net(mailfrom:guanghuifeng@linux.alibaba.com fp:SMTPD_---0XF3i-zK_1795097628 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 19 Nov 2026 22:14:02 +0800
From: Guanghui Feng <guanghuifeng@linux.alibaba.com>
To: ankit.soni@amd.com
Cc: guanghuifeng@linux.alibaba.com,
	iommu@lists.linux.dev,
	joro@8bytes.org,
	linux-kernel@vger.kernel.org,
	robin.murphy@arm.com,
	suravee.suthikulpanit@amd.com,
	vasant.hegde@amd.com,
	will@kernel.org
Subject: [PATCH v2] iommu/amd: Do not clear unobserved log overflow status bits
Date: Thu, 19 Nov 2026 22:13:48 +0800
Message-ID: <20261119141348.1601037-1-guanghuifeng@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <4nnekry6a3q52hsibm7cqrwbtrkr5vp6yuhwucreaz3pckt2a7@rh36fx2u5i3o>
References: <4nnekry6a3q52hsibm7cqrwbtrkr5vp6yuhwucreaz3pckt2a7@rh36fx2u5i3o>
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

amd_iommu_handle_irq() clears the interrupt status with an unconditional
writel(mask, MMIO_STATUS_OFFSET), where mask is int_mask | overflow_mask.
If hardware sets a log overflow bit after the status register is sampled
at the top of the loop but before that write, the write clears the
freshly-set bit while the stale sampled status does not contain it, so
overflow_handler() is skipped for an overflow that really happened.

This is fatal for the GA log: GALOverflow generates no interrupt of its
own (MMIO Offset 2020h bit 9), amd_iommu_restart_ga_log() is the only
recovery path, and per spec section 2.7.4 logging stays halted until
GALogEn is toggled -- a bare W1C of GALOverflow is not part of that
recovery.  The GA log then stays halted, GAInt never re-asserts and the
GA log interrupt line goes permanently silent, losing all AVIC
non-running vCPU wakeups on that IOMMU.

Clear only the bits observed this round by writing status & mask.  An
overflow bit set concurrently is then left asserted and is re-observed by
the existing ERBT1312 status read-back at the bottom of the loop, which
re-enters the loop and runs overflow_handler().

The unconditional write has cleared an overflow bit since commit
5ce97f4ec5e0 ("iommu/amd: Recover from event log overflow"); commit
af47b0a24058 ("iommu/amd: Handle GALog overflows") and commit
274c2218b8b2 ("iommu/amd: Handle PPR log overflow") later added the GA
and PPR overflow bits to the same write.

Fixes: 5ce97f4ec5e0 ("iommu/amd: Recover from event log overflow")
Signed-off-by: Guanghui Feng <guanghuifeng@linux.alibaba.com>
Reviewed-by: Ankit Soni <Ankit.Soni@amd.com>
---
v2:
 - Correct the Fixes tag: 2379f3485239 only moved the existing clear into
   amd_iommu_handle_irq(); the unconditional write started clearing an
   overflow bit in 5ce97f4ec5e0.  Record the GA/PPR follow-up commits.
   (Ankit Soni)
 - Tighten the commit message and the in-code comment: scope the "no
   interrupt of its own" statement to GALOverflow, since EventOverflow
   and PprOverflow do have their own interrupt source.  The functional
   change (writel(status & mask)) is unchanged from v1, so Ankit's
   Reviewed-by still applies.
 - Collect Ankit's Reviewed-by.

 drivers/iommu/amd/iommu.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index d0d55c93a480..530f97729d68 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1168,8 +1168,18 @@ static void amd_iommu_handle_irq(void *data, const char *evt_type,
 	u32 mask = int_mask | overflow_mask;
 
 	while (status & mask) {
-		/* Enable interrupt sources again */
-		writel(mask, iommu->mmio_base + MMIO_STATUS_OFFSET);
+		/*
+		 * Clear only the status bits observed in this round.  The log
+		 * overflow bits are RW1C; clearing one unconditionally here
+		 * would drop an overflow that hardware set between the readl()
+		 * above and this write, without ever running overflow_handler().
+		 * Leaving such a bit asserted lets the existing ERBT1312
+		 * read-back below re-observe it and re-enter the loop so
+		 * overflow_handler() runs.  This matters most for the GA log,
+		 * whose GALOverflow bit generates no interrupt of its own, so a
+		 * dropped overflow can otherwise halt GA logging permanently.
+		 */
+		writel(status & mask, iommu->mmio_base + MMIO_STATUS_OFFSET);
 
 		if (int_handler) {
 			pr_devel("Processing IOMMU (ivhd%d) %s Log\n",
-- 
2.43.7

