Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD2337DAA9
	for <iommu@lists.linux.dev>; Tue,  7 Jul 2026 03:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783393612; cv=none; b=BTfo0ZdEU+Yks0QDWF2NWnrKij6bExxuonShQe4YTZfnJ/mHY+LCF5udas1YtU6+fR9o1uoQdBqHG/V+1NRpVgYGS52Pxg3Sqs8kppZnwL8iGrDW+hKYu94ogPU+USEo3/lNHV9Fx6ysQcdkcbZWhk04izLcKwvLtsTmNM77iC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783393612; c=relaxed/simple;
	bh=aoKO72l1A+dW3fqW3BzjjnB1+WCcmKxl8/Z+ZRyiK5c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=ecIHW8cET4eNvRSqfQJBORKbpcLQL9iJ9phAbqhWZapQolyGlWt9Bk9mLwpckORg+qjIsu4yvN2EJMqWjQe9fSZCaK1ux+dyKAl7kB0/cTA2makAMGa/XyKaCPP9ARcpRuhfMctGvyZ7lBMwfYcoK5EwXn5+dfEeHJ2put9URx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jWEZl+QN; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jWEZl+QN"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-8eeadbc5e21so26173316d6.3
        for <iommu@lists.linux.dev>; Mon, 06 Jul 2026 20:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783393610; x=1783998410; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DF9/m6/00tuGO47IW671QE4G3CPTVyzUsVi+M5LKDUM=;
        b=jWEZl+QNeLL3B51d4ilzYk4edYXI9fmfoL50UMmLEFM/SmDKt3G8VAPGcz0BwZs45v
         ZbYlcd7lDyTzaIeb//MBU783+w2k1OKSpZV4NnIHELatCqcdywnbzYqkXz7p3+QxSrBg
         8ruj4EZYbBnw0fiCQMLa/5AiM7RwLYOjycehZRC3d7aoYjP3B2NsyBk9kMebM1HxcQYD
         30FMWZnmp1vwJj8CoyGUUfHDUM+Ma3B+QBavWTvhCloHnM8Gm998/aObDzBnbbiD/tAE
         TdX2wRvah8nUGLhDrNBIbfademuivOlk+YFP01ZcRF/WqrOFFK5ZIWOOBzOMxikphh2c
         t3bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783393610; x=1783998410;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DF9/m6/00tuGO47IW671QE4G3CPTVyzUsVi+M5LKDUM=;
        b=mFnYxoXBzSh3uEIlI9shPQNhNKPEdhf2IzTaWvW58eD3AR8DT81dD4C8XJ5Tv1KBmn
         IpEMVGN6nuGXTqSalF1mHtWOd9pUJuMIBTy64hjrmhtbcwHar773TI/vpykE5WsVBUbi
         uh/hC6BcZlgeq2RbQYd6EQYAaoN+m1RB1UL0XCeli2b2ZPdER1BQimWIpPOipISSJdmN
         aea7L0uYKtk9l+8VWR22IZUAop99ZrNEMecxXP1S7hIrsdlIhsUtE//RtdzoqTGkvOyN
         AsFPG4FtqYQwzwM7J38wcSbziC9CF5gs0Ja0Vnj3NusAYgCf+FPKEWhJU+vj/6Ic7zoK
         KINA==
X-Gm-Message-State: AOJu0YzehljFulaDPmG/d8GoD1Z3P+TYg/7hoVI3tRG0UJrew2uCMuUj
	V/xWg3VqjjXtr1Ew7P40CNB8SYSL6jqb/kFo4UL07IPRp27BSigJdx0+
X-Gm-Gg: AfdE7cmbuPOAC07sb/Q9sXRu0nOxH0KdslOTv38skNL1v4cI/ovgj/Ht4JMEEYBodrv
	BmWlZMZtbk+0FYsLYT6FOZ+Jz0v9h84v3pSixJIqonVkJbKFTt+Tou/UJwTHTEgKn8TJSbrjJhG
	D5ZfJIgLO4fqhz3fgzB1UPMks5eQHDrndfLfeJb8jgKAMeLYBrCihz3IJi+GOZWjI48+y2mtEvG
	umUHY4RH1UMhu3gDoWxSPzEV4lDhswLd2WozOkZUceln29GjT8D4X1x9HnoVPkmRngeGJHJ+ZET
	GwjoYDhRSzYyzs94QENSa+FfzOlL2yic6qDwnqnYHT99zM32pRdXbrxRH4/umCt72P0GuHM52lz
	JZV8hdtKKRGibiRUR/UMIO2Zk5LH3Af0QMCsDfphEiRHne3hfgfQlWSxjZLuF0bwU04Km7mzDdV
	s1pX51SRG/wrm3WuInFrLW+DFviO4=
X-Received: by 2002:a05:6214:419b:b0:8ee:ed05:61d5 with SMTP id 6a1803df08f44-8fcb4a06276mr41670976d6.36.1783393609669;
        Mon, 06 Jul 2026 20:06:49 -0700 (PDT)
Received: from localhost.localdomain ([104.28.205.50])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8f4724b9ff8sm148107466d6.40.2026.07.06.20.06.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 20:06:49 -0700 (PDT)
From: YeeLi <seven.yi.lee@gmail.com>
To: jgg@ziepe.ca,
	kevin.tian@intel.com,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	yeeli <seven.yi.lee@gmail.com>
Subject: [PATCH] iommufd/selftest: Fix dmabuf leak in iommufd_test_dmabuf_get()
Date: Tue,  7 Jul 2026 11:06:35 +0800
Message-Id: <20260707030635.221577-1-seven.yi.lee@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: yeeli <seven.yi.lee@gmail.com>

iommufd/selftest: Fix dmabuf leak in iommufd_test_dmabuf_get()

When dma_buf_export() succeeds but dma_buf_fd() fails (e.g. -EMFILE
from fd exhaustion), the dmabuf is leaked with no dma_buf_put() called.

Reproducer: exhaust fd table near RLIMIT_NOFILE, then repeatedly call
IOMMU_TEST_OP_DMABUF_GET — htop shows unbounded memory growth.

Fix by calling dma_buf_put(dmabuf) on error and returning directly.

Signed-off-by: yeeli <seven.yi.lee@gmail.com>
---
 drivers/iommu/iommufd/selftest.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index af07c642a526..7340d9f3c62b 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -2023,7 +2023,12 @@ static int iommufd_test_dmabuf_get(struct iommufd_ucmd *ucmd,
 		goto err_free;
 	}
 
-	return dma_buf_fd(dmabuf, open_flags);
+	rc = dma_buf_fd(dmabuf, open_flags);
+	if (rc < 0) {
+		dma_buf_put(dmabuf);
+		return rc;
+	}
+	return rc;
 
 err_free:
 	kfree(priv->memory);
-- 
2.34.1

