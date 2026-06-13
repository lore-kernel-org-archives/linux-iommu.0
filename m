Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230C938239B
	for <iommu@lists.linux.dev>; Sat, 13 Jun 2026 06:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781333918; cv=none; b=JL90YvritDAFEm4UfpIKuU3hYOdTBmJyl1Uc2iBoN3PRTxpdMe1VLk/fkze9UepBLPO+F2qpvYrM/qPTXekMJLIMgUuZhsE/QbN9US63tAHMQcKYWf+R60U8ANJR9y4/m2eaXFc3PKpIXjl2ZRbV3s+RAYEWmf5tUi/SGF4E+YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781333918; c=relaxed/simple;
	bh=tLGf4/Fx611dZ3uiJyqt+wb9ZRWGswCt3ouClEW4dU0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g9eApVWJKtBqUFXS5Kpaut//kOyuspuD0FJ4o4ISvfiG0b4EdiCjFyZhTxq/NUDGOWGaVrRCvWZCjGfq9NKk9QU+yKS4b+xzjTthRIR6CIye/4DePSZ7L+FpjkaXsGftJqrK2+WsaWs2em4PFmRkGhet0fPTPGagp+gvvD0Aq5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N8Rg/ymw; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N8Rg/ymw"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-490cdae130cso8533545e9.0
        for <iommu@lists.linux.dev>; Fri, 12 Jun 2026 23:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781333915; x=1781938715; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VKXNGySjUJiX6/3GllpQ7O9YCp87EzXF/WJp8p9p0Qc=;
        b=N8Rg/ymwSc+RKFDUCttG23cIRNnOxlOCIEhR7piwwu1pFLDWR/3051ArYccfx+c0NS
         w5ASF2SelGi+VpcxAHS3sFkAczoAcBFd5ZsamUynQaTEkdK4Rveh0qO68q7aG5JdD8Jd
         mL9G9YzCAXua/LDBN9CuE0gfPN8+G+RdnryJvpR73YHSTI/84sfE+T4v/6JxESq9oGVE
         ar3HdziUCIClFoMdSY8Bhge9BT5w3IKnTAGiUFLSylNuRkBafdcwj2AGpx7XCkRRQD7x
         90zDrOkhSNXoCfFkunbxvRqgG6ThqtAThdsl2k58FVX93GO/UnTBFVGpQNy9vTbqepyW
         9boA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781333915; x=1781938715;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VKXNGySjUJiX6/3GllpQ7O9YCp87EzXF/WJp8p9p0Qc=;
        b=IFMCF6EuXYGWFPfaq7tWtDup16nPc88L7KHQmN7B2JDddPuk5xZCO2aiIrOsWXubvp
         MEdQyRDZ3eOOpEY94acq7ENVjEJVZE68MqfIGKqQlLXTUso/QmUF/It2pMdE8r1vIRlb
         JFKfFIlePXSIQu+3MGJxD9nBKzpuPcdbPEgDApdyII0PICH6sTbmJGv0elrmYWfNpj9L
         /Gm5xhULOg6NRr4bBzRm6M/ziJNPq9Tur4lQ9wcLJUkx0vXJ4XWqYgBqW3sFkkEoc7dz
         TjY6aYArukxLihoeDgJysPk5HVRUqs7+25AcO7xNXWqi37UHbQEo4zPuzKrOUADsH1Bh
         seyg==
X-Forwarded-Encrypted: i=1; AFNElJ/w0IfBg0//oKlekcj6RWjelcJS+EkwOF0EbG0S5DjRGUiLT6CQVg0EvJIivDSYQCSqDPUspg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyCLbG/2zw8wdqfdmSXwnAtNW0y+cZs9xT0PnVcFjOGb7F/PajD
	Cu006xy4hpeqZqmdqJqTRxKozhGmtomxvnjQZkEUdAGqebo2tRyV2H/F
X-Gm-Gg: Acq92OHmlTxNDurdE6tsPI3wyVC6iNt23rEO4NTiaT2QRtlBDIXqDNfdcx4ACsgN2tu
	VPzkEVSttjuNbq/SedHqs84u0/yJhHmZB5KEsue9zCvCVtY5XSf3gyzBF6K+fUF3sATmYRgJoAJ
	9ZXE+sxyIsLaAcVor0LWOYZOSh+oINs0/BteQqq3u5ysQ6kG0U5VYsnioPuFuHWPjBJNBc/q8bS
	SFjKn1ygrfZczvJbB4BSifn246j/YV18eNTuN2+8sknJFYePAgzSoqAv1GA3DjdO9UMZcIvR54C
	bc6npSM3MTPqUaeEOG4Yvrna+t3s+WHGE6gcV7GX4kCdy7aMBXFkV9RoIJNjg03b9t82uE26dcO
	4Cq08dTeDPqgBSCfgdOJ+cmavK6JRJBldmctF+GXvTnvm+N4kxEnxuLUgtzhLlQWmB69IsNQIdy
	+iDesJFpXWyEGI9HWneEoywpFl6b7f/Fe2EBQurpSvmKwTKw77t84k
X-Received: by 2002:a05:600c:6287:b0:485:9a50:3370 with SMTP id 5b1f17b1804b1-492200516d4mr27804035e9.8.1781333915366;
        Fri, 12 Jun 2026 23:58:35 -0700 (PDT)
Received: from debian.tailb81abf.ts.net ([2a01:e0a:104a:4d80:14c0:9448:1c38:77df])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-492202e5cbasm42917705e9.2.2026.06.12.23.58.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 23:58:34 -0700 (PDT)
From: MidG971 <midgy971@gmail.com>
To: tomeu@tomeuvizoso.net,
	ogabbay@kernel.org,
	heiko@sntech.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	ulf.hansson@linaro.org
Cc: dri-devel@lists.freedesktop.org,
	linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	xxm@rock-chips.com,
	chaoyi.chen@rock-chips.com,
	finley.xiao@rock-chips.com,
	diederik@cknow-tech.com,
	jonas@kwiboo.se,
	Midgy BALON <midgy971@gmail.com>
Subject: [RFC PATCH v4 4/9] accel: rocket: Reset the NPU before detaching the IOMMU on timeout
Date: Sat, 13 Jun 2026 09:01:11 +0200
Message-Id: <20260613070116.438906-5-midgy971@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260613070116.438906-1-midgy971@gmail.com>
References: <20260613070116.438906-1-midgy971@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Midgy BALON <midgy971@gmail.com>

On a job timeout the NPU AXI master can be left wedged with
outstanding transactions. rocket_reset() detached the IOMMU group
before resetting the hardware, so iommu_detach_group() ->
__iommu_group_set_core_domain() asked the rk_iommu to stall and wait
for the in-flight transactions to drain. They never did, the stall
request timed out (-ETIMEDOUT) and the IOMMU core WARNed:

  WARNING: drivers/iommu/iommu.c:157 __iommu_group_set_core_domain
    iommu_detach_group
    rocket_reset
    rocket_job_timedout

Assert the core reset first: it quiesces the AXI master so the
following IOMMU detach completes cleanly. Move the detach after
rocket_core_reset() and out of the job_lock (it does not touch
in_flight_job).

Signed-off-by: Midgy BALON <midgy971@gmail.com>
---
 drivers/accel/rocket/rocket_job.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/rocket_job.c
index ac51bff39833f..e25234261536b 100644
--- a/drivers/accel/rocket/rocket_job.c
+++ b/drivers/accel/rocket/rocket_job.c
@@ -364,14 +364,20 @@ rocket_reset(struct rocket_core *core, struct drm_sched_job *bad)
 		if (core->in_flight_job)
 			pm_runtime_put_noidle(core->dev);
 
-		iommu_detach_group(NULL, core->iommu_group);
-
 		core->in_flight_job = NULL;
 	}
 
-	/* Proceed with reset now. */
+	/*
+	 * Reset the NPU hardware before detaching the IOMMU. A timed-out job
+	 * leaves the NPU AXI master wedged; detaching the IOMMU then issues a
+	 * stall request that never drains and times out (warning in the IOMMU
+	 * core). Asserting the core reset first quiesces the master so the
+	 * detach completes cleanly.
+	 */
 	rocket_core_reset(core);
 
+	iommu_detach_group(NULL, core->iommu_group);
+
 	/* NPU has been reset, we can clear the reset pending bit. */
 	atomic_set(&core->reset.pending, 0);
 
-- 
2.39.5

