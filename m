Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B2B7E110
	for <iommu@lists.linux.dev>; Mon,  1 Jul 2024 07:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719818965; cv=none; b=YivodAjBGzZvx+X8FsENEjsxQARbQZqju4C98dd9YvrcMTcQI0+Y+mBfS24O9U3sU0x1nmAPy6d6VNxE7R86O5+AMpMJwgnaY9ECaIJ16747rzOzXYltPhGZG13K6fvnFiliYlnRyDj8a8ElQtLGPmDVkLImPNAH21gUd+AGGXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719818965; c=relaxed/simple;
	bh=o4IG1Ydtzsj6A/FLUwqxoG7igH8yPVKoxmt7Uos0s40=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gKdbyAwBz44k9BP8l49fAnWKcN1pCKfxyw37j6T6v+NEZhsRe5pav5WkR4LOmVWaXulV3Ok/VIQ2T3tM/9L1pFlTDJftR3j2YxcCM2xq46+EZ8WBDjqfOSanM8Nrj4Ytm+uKcWkPOeZJEvA4knRhqtQXjbc1A3YhXet78nmdGN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=edpBQ9KC; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="edpBQ9KC"
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3d561d685e7so2003155b6e.1
        for <iommu@lists.linux.dev>; Mon, 01 Jul 2024 00:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1719818963; x=1720423763; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WIwvidCJhYXXjv9fs8E48O/N337p1plrTXtjqFhBKIQ=;
        b=edpBQ9KCQSgwEcCM+DkACTqscDc9ZNLdBo9ReL+czUT8h88A/ukV24lNVwHqOubRlF
         ILfF1dP6h9KQIiTi5i5GR5Hk91YgDMgs2NsrGrKN93IrTMntsO9Bt91LnW+rGFCc5gL2
         wlutzu9gKhggmdlOqQp1r/SsnPaCBXODHKyJWn9e/VrNLcQAto2wxS8/Y4MWd6VnE7+K
         RB1qQTBrWrViLjh11kYGA2siHc9hXba1bTEfxdEAEA9tL7BGoZuohifweUneITStCgd0
         7OTd58iCRefosTRjf876pUc3aKHqIc4aYhV4ZVSkwexh0RdiADQr/clAZjkVqxo2A6EX
         qs2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719818963; x=1720423763;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WIwvidCJhYXXjv9fs8E48O/N337p1plrTXtjqFhBKIQ=;
        b=SPHsgG1ASoOhK1BdCYY+DQx7D0sp3nJQ7qW3f7pfNE526Dvpmd9UN6un4T8BJPxSOF
         ui4+PGOFq3VZFGe7gBgg5RZZgA1n8W7WCsSRsG0gt86pHy70y0C6h/zzW+Z9JymOk9B+
         SeQ8o2/CHDQlJE3FgTbRypWXPEWX41pcuozTBmSCd0g8L1EZ4V6A4DcL/ze17WW7rp83
         b3kVDeDtkEd82QoH86FPOrknpFYMri0urEDPhypQfB3XxAadtyC4OAs5XyU95OlanbK6
         grobX53dHt2vE3qVvscWPxqGx6qFxLFjRSo3ftGWMpck4TQWqOco62cPjSI3WLau2677
         4SWA==
X-Forwarded-Encrypted: i=1; AJvYcCUsoW0gSfXSD41DdA3QD2QR/n/GEkwyT6yAepMh/+zKJKrtNh8q8x9EJb5kIgF8V1Qp8RIVmJDzkKADyyIiRzDDB1oRWmA=
X-Gm-Message-State: AOJu0Yw0DCfKwDiUyWC0FRFKys4zIFhQBKQ6lIgtzOMzeCYm87tzcAvY
	RYgG4VIoys9/Znuq5Au0pGfhbpSTYGaQ0DBc/zOVTEoxmzs8RsZO27noEbpTJG4=
X-Google-Smtp-Source: AGHT+IHRz1SHHY+TmlIy6IZBZFwaBFuAJ4rZWriiRFCwuK0Ao+rNzMBXMsAGPD3T1rYs7tmFaCwRjQ==
X-Received: by 2002:a05:6808:159c:b0:3d6:324b:ddc7 with SMTP id 5614622812f47-3d6b35ca407mr8326356b6e.28.1719818963388;
        Mon, 01 Jul 2024 00:29:23 -0700 (PDT)
Received: from J9GPGXL7NT.bytedance.net ([61.213.176.58])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70803ecf757sm5779337b3a.104.2024.07.01.00.29.18
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 01 Jul 2024 00:29:23 -0700 (PDT)
From: Xu Lu <luxu.kernel@bytedance.com>
To: tjeznach@rivosinc.com,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	paul.walmsley@sifive.com
Cc: palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	apatel@ventanamicro.com,
	sunilvl@ventanamicro.com,
	iommu@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux@rivosinc.com,
	baolu.lu@linux.intel.com,
	lihangjing@bytedance.com,
	xieyongji@bytedance.com,
	Xu Lu <luxu.kernel@bytedance.com>
Subject: [PATCH 1/1] iommu/riscv: Support sharing irq lines between iommu queues
Date: Mon,  1 Jul 2024 15:29:08 +0800
Message-Id: <20240701072908.25503-2-luxu.kernel@bytedance.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20240701072908.25503-1-luxu.kernel@bytedance.com>
References: <20240701072908.25503-1-luxu.kernel@bytedance.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the number of wired interrupt lines is less than the number of
iommu queues, we should assign one irq line for several queues and
configure csr icvec accordingly.

Signed-off-by: Xu Lu <luxu.kernel@bytedance.com>
---
 drivers/iommu/riscv/iommu-platform.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/iommu/riscv/iommu-platform.c b/drivers/iommu/riscv/iommu-platform.c
index da336863f152..1d0af1260d5b 100644
--- a/drivers/iommu/riscv/iommu-platform.c
+++ b/drivers/iommu/riscv/iommu-platform.c
@@ -60,6 +60,10 @@ static int riscv_iommu_platform_probe(struct platform_device *pdev)
 	for (vec = 0; vec < iommu->irqs_count; vec++)
 		iommu->irqs[vec] = platform_get_irq(pdev, vec);
 
+	for (vec = iommu->irqs_count; vec < RISCV_IOMMU_INTR_COUNT; vec++)
+		iommu->irqs[vec] = platform_get_irq(pdev,
+						    (vec % iommu->irqs_count));
+
 	/* Enable wire-signaled interrupts, fctl.WSI */
 	if (!(iommu->fctl & RISCV_IOMMU_FCTL_WSI)) {
 		iommu->fctl |= RISCV_IOMMU_FCTL_WSI;
-- 
2.20.1

