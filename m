Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC4A345757
	for <iommu@lists.linux.dev>; Sun,  8 Feb 2026 06:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770532743; cv=none; b=nibS/3fOdYHe725dxfqxXsaRasj4igy2TOgQ5WLjFYFXNA+wGBSOcSQyiVMJY13IgpDoWxSwfda/ttiUa90pGFxPD7228ViCbb0CFqIyaeA6vFEpaKvS6jVCqvm1EkVAN7XzqRpz5pb46WIz1QntMC3OQYRsBYkV5jT6XCmCs+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770532743; c=relaxed/simple;
	bh=wcc9KnVjKdcKm499FqDP7KbpPOAGrVGwzxwJ6V3VrBA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IDy0iB3nZWONUap7lCEeo0NzIZ8zFLkE4FLz3VpCFXbaoDoA9K/Eo7y2HFfqjjOShJXARSZu37eU1+aPfCk06oLmuuG9OuRyFXg+6gvNBYrO9CNMjJGFv11V9fPB0AQEys6rnjKmuKOS2nKM2AHtwhHafc/qVZIpmbMk+TRr9VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=CknIv+zb; arc=none smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="CknIv+zb"
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-124afd03fd1so2703062c88.0
        for <iommu@lists.linux.dev>; Sat, 07 Feb 2026 22:39:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1770532743; x=1771137543; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SqJrVLmLyHXBLluZVvcfbrCnXHVEtGPNlw21Z5ct3vE=;
        b=CknIv+zbb5fnI6SukMg6+u4U1GY0HWsJPnLqAo7N0yy/nmJlA8Y1ybm541zqehQnMW
         tzzmifHQnzP0dEwJWtzx/htAecFzFGqiHe2nLy9XKcnZUmdDwbv5L8nLBwPe7Pp4NxZf
         r0kIUAmPMg9iMFCiCTAyPfi3Izv97urH2MyyHrl1juuHEpF+cnQQqmR+CQ/muFiIA7p8
         LI8gg1q7rmcuUwPkVJZJWK4afkh9v+GaztuqTCzXhzcJcwg9ICVo1g0yp7BYBxu2saXl
         TO/bs0tLOXKEd9+lvyeMi0TVq9smjj5v7seRAFeg1KwrSBg1x62IRAOg85eio7p/fnuy
         594A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770532743; x=1771137543;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SqJrVLmLyHXBLluZVvcfbrCnXHVEtGPNlw21Z5ct3vE=;
        b=fheLotOHAiKg1GJKdS60BUe8tGWpyReQ3jgf9N7PEgQKmVRrP7PJDMQnBkMldc30Co
         d3yig8srRPCuW8CAza6OVhVNrhDI7cZtIW7kuNOCaCBBJBucXwM2dKcxsgVhNNUa0iDG
         6+g2GP/h/0l/kwylGWQzO1PwNT3ns+awnGhVrx3QeoSJFu4aDl5ryYn80d3CFGFNBitD
         ll+oq1/zTIUph7NfMCLPU97zBzin6c8W5NCibG0UPrAGz4mN2fhad3fGto95KaFymjHK
         UIPAmcj1f8cLJA211sxB9dmwYGAde/bB0dFg3biYCZVCd3tEjqf0jHc4ZE+oUC0oCX0H
         EjoA==
X-Forwarded-Encrypted: i=1; AJvYcCWIRwVJ1DeErVErsmxX4qVtSEYWcvMx21+jNOFoNOIRSFmG8RKBdiG/bC8rdMVxpB0hO3bphQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxZVaC9003sEd22oa0u+iMEd7h9ge2gHPaNig6Urjhu32mp9Lf9
	QL8KdvqRGLGOtYP18Nk3zTXon+IzvOM4eADPKj0xgrySf0fRBjGbSNQqy0FgLoGOEak=
X-Gm-Gg: AZuq6aKfukeX65iNCX3jnCko++mwGGmCogBPM2G/JgJRS7rhvHL430rVBi6Z0qNR8Li
	GvSjMplvao1fcZMNymQEiPkbAhwyg9TXOcMn3dIzTX6pKwR1VFGBSFO7b3fGOSHChRbMFdSTaqF
	Bdph3cbgVJA5cW7C7yg8714/Xr+f84E4qTa9Jhp0WY1aB9oG7HsKQP1MX+J8J6fWm6HI2+sR1Ba
	wI2eJZJ/XltoqQC3SajPb57NbGQX2wxpenNLjwmrcyzvhbWD6iOqyKHiGtMEjQzMSGu88BhY4nB
	cL9C4fdZC0XymRPuZHv8/2PcLcZTO1sybCNt5TkC+jyf2XfA1M7rZSXXeotDRnTTITr6pTJiMuT
	UK12aXSN+PlFP91C9k57vq93bkEd/k0/jaK8xUUscocECWtJH+iBrOpBhHKIOh34qvRVSINw4qa
	XfgkunttVbP7RRoHrN5SarQdE=
X-Received: by 2002:a05:7022:2527:b0:123:2d4f:ef1c with SMTP id a92af1059eb24-12703ff4c81mr3247994c88.26.1770532742709;
        Sat, 07 Feb 2026 22:39:02 -0800 (PST)
Received: from sw04.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1270c9ff2bcsm5114647c88.1.2026.02.07.22.38.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Feb 2026 22:39:00 -0800 (PST)
From: Zong Li <zong.li@sifive.com>
To: tjeznach@rivosinc.com,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	robh@kernel.org,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	mark.rutland@arm.com,
	conor+dt@kernel.org,
	krzk@kernel.org,
	guoyaxing@bosc.ac.cn,
	luxu.kernel@bytedance.com,
	lv.zheng@linux.spacemit.com,
	andrew.jones@oss.qualcomm.com,
	linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-perf-users@vger.kernel.org
Cc: Zong Li <zong.li@sifive.com>,
	Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH v2 2/2] iommu/riscv: create a auxiliary device for HPM
Date: Sat,  7 Feb 2026 22:38:36 -0800
Message-ID: <20260208063848.3547817-3-zong.li@sifive.com>
X-Mailer: git-send-email @GIT_VERSION@
In-Reply-To: <20260208063848.3547817-1-zong.li@sifive.com>
References: <20260208063848.3547817-1-zong.li@sifive.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Create an auxiliary device for HPM when the IOMMU supports a
hardware performance monitor.

Suggested-by: Samuel Holland <samuel.holland@sifive.com>
Signed-off-by: Zong Li <zong.li@sifive.com>
---
 drivers/iommu/riscv/iommu.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
index d9429097a2b5..7cdb80d4343d 100644
--- a/drivers/iommu/riscv/iommu.c
+++ b/drivers/iommu/riscv/iommu.c
@@ -14,6 +14,7 @@
 
 #include <linux/acpi.h>
 #include <linux/acpi_rimt.h>
+#include <linux/auxiliary_bus.h>
 #include <linux/compiler.h>
 #include <linux/crash_dump.h>
 #include <linux/init.h>
@@ -559,6 +560,22 @@ static irqreturn_t riscv_iommu_fltq_process(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
+/*
+ * IOMMU Hardware performance monitor
+ */
+static int riscv_iommu_hpm_enable(struct riscv_iommu_device *iommu)
+{
+	struct auxiliary_device *auxdev;
+
+	/* TODO: for custom event support, the modname should come from compatible */
+	auxdev = __devm_auxiliary_device_create(iommu->dev, KBUILD_MODNAME,
+						"pmu", iommu, 0);
+	if (!auxdev)
+		return -ENODEV;
+
+	return 0;
+}
+
 /* Lookup and initialize device context info structure. */
 static struct riscv_iommu_dc *riscv_iommu_get_dc(struct riscv_iommu_device *iommu,
 						 unsigned int devid)
@@ -1669,6 +1686,9 @@ int riscv_iommu_init(struct riscv_iommu_device *iommu)
 		goto err_remove_sysfs;
 	}
 
+	if (iommu->caps & RISCV_IOMMU_CAPABILITIES_HPM)
+		riscv_iommu_hpm_enable(iommu);
+
 	return 0;
 
 err_remove_sysfs:
-- 
2.43.7

