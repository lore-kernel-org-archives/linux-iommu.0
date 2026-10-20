Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792474530;
	b=f9jLxoGWOriEBuTpeTMuyT3iCQEvQyR3CjFCOercAZU45dmOzz7I6X35Jtz429v+5dgl
	 attUMcmkc1xZPKPQGhROVzZhxlv9HDsgisCjazWCzam3+T4Q8qdjjcaWwaRMDz9CRCuoC
	 Oqxs1J1+FD9K7qW0uMyc9PO2MqEoicjzgwDpLeLSMAskZs7+hXJ8zMFJj7l72D1pAhKGK
	 c9F3tJs00MU97CzOs3Ld3mpfAOB/wrlCsKgKXjmF8no+cbt8+OzLgDb1cHS6JvQgYmKas
	 K26gG3kFHZzffrdtaQqToseEootGqD2zQzvT33iyZKD/HCnqOn2ubIGTz6H67XHxuzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792474530;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=UjLNCgx3WekQetaZqMO5VDYLOeTCT6zYxxBPC2GY2rk=;
	b=znM7zQnVBlYOg/BfCC4CZFLjx5hCUcnntqtJ4Ak9q5zt7ECI02mSfKMKDy/UV1Gzm+4t
	 Ekmfs/dOfDVHux9m0koRwwR9Yt4xcCO7c+eA3aVMQiNycfPn265Hbs3oHykHY0o2Xv485
	 Xmt5cTMn0XjKvI7LBz317CpTQARVx38ZeJ0/kmBUA2WI5utSkhPiuXBplStktrqD6wZrN
	 EXJBnDCPP3+4Ua5oVHsUHRZoP8sK1vlYsoRy1Pn9UaDNtdJrxHueD3ZZ4QMavJ4qK4mdo
	 00Lh3/4uTYeUA8xdo3XtStq9v3dTE+v5Gu7nnw3uK3SpBjyacl6zcb0PMpz/J2X2Bnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=HQ+qBJYj;
	arc=none smtp.remote-ip=209.85.222.174
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10E5606A31A
	for <iommu@lists.linux.dev>; Tue, 20 Oct 2026 05:35:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A10E5606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=HQ+qBJYj
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-930c0f9c1b1so275365285a.1
        for <iommu@lists.linux.dev>; Mon, 19 Oct 2026 22:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792474528; x=1793079328; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UjLNCgx3WekQetaZqMO5VDYLOeTCT6zYxxBPC2GY2rk=;
        b=HQ+qBJYjg8Fhal3+tGDGlDd89n8bGXwye9XMgEgT5A/aRXmTWazHgTl59M1Vv7FqKF
         q74LslRBn6gyoUux0dTxMDo8suJwLuJsZNXAswYbmWW9vd8N39nK5hTy7v7/fh0SFFF/
         E03tEmNcNDk92+6lWV3pQzXUVkFNxgnHCdPqkjhcidVAn5vxtDorr5xEdBjE3kd+1b2r
         xcIL5aqGL7k3O8flXFN7nczj11/wUz+jNKnqQzcLgdB6Qvdm3SOA/VhLVHy9MQ7zC66p
         GRpUr7DmpKO0aeKQTQaWDM3gYgwO8khGLrd4GJVKxHg/7NM7lNOUvZqta8ZqPibB/hI0
         CUww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792474529; x=1793079329;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UjLNCgx3WekQetaZqMO5VDYLOeTCT6zYxxBPC2GY2rk=;
        b=T9wmovhswnfrfMdpE3qgrik66YbZ0J5NgIThbcJkeurWH+B0hXf53Gv4eWWZyUt8u+
         7TaNw+jA5SiBVjWqpASOFTgsT7yYHSDgsR8sLgN/p0ri8EFyeKoOoaS3kaXAHQNtMOCz
         f320W8Jr2W78eXnqlR17SlU0zUk0Aqkola7UYbEEJVW/HS5xIZZm13LvMnF+vbwrHodW
         SxL0kltmD+F9aGy76D7VjL4mbRlBlxWCBfEQndvyHNvXi0A/7Cxc+UCIUPefSl4tvEML
         8PBjn2g30NZf/wdIGtVhTC4fS+RcoIpzDAz13wQpMnzWfH8BLO+4esS0HFp9xdzr5Pm8
         C+FQ==
X-Forwarded-Encrypted: i=1; AKwUvBx91Mx2uHhVKyrrA5RMFFjGdLWNTqVtahVQwR+fpuecxXajb+lKMA841FcoSV9AfkofMW77sg==@lists.linux.dev
X-Gm-Message-State: AFq9FYJxdROnFcOY/ip/NBlQ7o/wCCCZeRHtWKcGftY594HzAi4GBO+K
	EgMT5hThpQ3YCo8y0rrmAF0XkrpiZTnb+2JN5BGO6rS2hNywGIrE64ts
X-Gm-Gg: AYBFou3V8E3fhnZilYr3R2kkqXMIhOYPkqtdho0jyzEMFV8cXD8GOfVaj4mwpoJiO8Q
	zLYy9mxKUy2nGqba9aZy3AGf6csqgKN1DlNuqlZfniUBMP7pYCK26nLu/HT6cpbHx6+6RetK47J
	flWjtxJqXpg59xhkU2INCRYpGCn9sQl2nM25ARROlYqVoBiAmA6GReF2xZJsz723ph5ctM1P1QI
	p/jxpcv4TBNz68BLRHfWV0edUaG3ogFBlXUez09XJw+m+ih9T9B25O+xyn4PazBI/1T5l40UrMf
	bAZHLstGr42MCNRiEVE2aLAD1QvlUVPELyUsZ+lsrbRrKKwlgf8aeGO5hbyP9rmRu4/MqHdnwTh
	qrK/g9SARgdgJXLWWDCJY7EIPhLuFY0G8s1HpVHo3y/NUx6eNJxRNTbMoieMr3Tv7oIF8xLe1MM
	gvcqM3e9F/8D3HhEP1ELd6KWmCnMRsdgJQXAd+1uaymdKYdRJlQMnX8WXnnXd1Vm9PvZ8DU48uk
	KrMilGa2zNo5Sm2usHjkK2lo0bTdHea
X-Received: by 2002:a05:620a:2602:b0:93f:5ac:14a3 with SMTP id af79cd13be357-93f29df1d42mr1601610185a.73.1792474528522;
        Mon, 19 Oct 2026 22:35:28 -0700 (PDT)
Received: from i4-gl-tmk5904.ad.psu.edu ([130.203.156.186])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93f4b082168sm139455685a.22.2026.10.19.22.35.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 22:35:27 -0700 (PDT)
From: Yuho Choi <oss.patchbox@gmail.com>
To: Tomasz Jeznach <tomasz.jeznach@linux.dev>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>,
	Fangyu Yu <fangyu.yu@linux.alibaba.com>,
	Zong Li <zong.li@sifive.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	iommu@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Yuho Choi <oss.patchbox@gmail.com>
Subject: [PATCH v1 2/2] iommu/riscv: Do not report a stalled command queue as completed
Date: Tue, 20 Oct 2026 01:34:24 -0400
Message-ID: <20261020053435.1179054-6-oss.patchbox@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261020053435.1179054-4-oss.patchbox@gmail.com>
References: <20261020053435.1179054-4-oss.patchbox@gmail.com>
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

Since commit b2e5684558ed ("iommu/riscv: Stop polling when CQCSR reports
an error"), riscv_iommu_queue_wait() stops polling when CQCSR has cqmf,
cmd_to or cmd_ill set, but then returns 0 as if the waited-for command
had been executed. The hardware stops processing the queue at the
faulting command, so an IOFENCE.C queued behind it has not completed,
yet riscv_iommu_iotlb_sync() goes on to free the page table pages.

Return -EIO when the queue stopped before reaching the waited-for entry,
and keep the "command execution timeout" message for real timeouts; the
interrupt handler already reports the CQCSR error bits.

Fixes: b2e5684558ed ("iommu/riscv: Stop polling when CQCSR reports an error")
Assisted-by: LLM
Signed-off-by: Yuho Choi <oss.patchbox@gmail.com>
---
This was found with a static analysis tool from ongoing, not yet
published research, and confirmed by code inspection. It has not been
reproduced on hardware or in an emulator.

 drivers/iommu/riscv/iommu.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
index 816d50c0f508..2a95cb8c9e4c 100644
--- a/drivers/iommu/riscv/iommu.c
+++ b/drivers/iommu/riscv/iommu.c
@@ -371,15 +371,24 @@ static int riscv_iommu_queue_wait(struct riscv_iommu_queue *queue,
 	unsigned int cons = atomic_read(&queue->head);
 	unsigned int flags = RISCV_IOMMU_CQCSR_CQMF | RISCV_IOMMU_CQCSR_CMD_TO |
 			     RISCV_IOMMU_CQCSR_CMD_ILL;
+	int ret;
 
 	/* Already processed by the consumer */
 	if ((int)(cons - index) > 0)
 		return 0;
 
 	/* Monitor consumer index */
-	return readx_poll_timeout(riscv_iommu_queue_cons, queue, cons,
+	ret = readx_poll_timeout(riscv_iommu_queue_cons, queue, cons,
 				 (riscv_iommu_readl(queue->iommu, queue->qcr) & flags) ||
 				 (int)(cons - index) > 0, 0, timeout_us);
+	if (ret)
+		return ret;
+
+	/* The queue stopped on an error before it reached the item. */
+	if ((int)(cons - index) <= 0)
+		return -EIO;
+
+	return 0;
 }
 
 static int riscv_iommu_queue_wait_for_space(struct riscv_iommu_queue *queue,
@@ -531,7 +540,7 @@ static int riscv_iommu_cmd_sync(struct riscv_iommu_device *iommu,
 		return 0;
 
 	ret = riscv_iommu_queue_wait(&iommu->cmdq, prod, timeout_us);
-	if (ret)
+	if (ret == -ETIMEDOUT)
 		dev_err_once(iommu->dev,
 			     "Hardware error: command execution timeout\n");
 
-- 
2.43.0

