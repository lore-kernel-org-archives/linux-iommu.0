Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C75749D;
	Sat,  9 Dec 2023 23:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eChTRoem"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-40c256ffdbcso35488035e9.2;
        Sat, 09 Dec 2023 15:12:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702163561; x=1702768361; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fyY7xuerRfmnEXL+mjQb56JPNlX5ZA5VFzoyWh1LMIk=;
        b=eChTRoemshcH9kCclcJrI2LEp2U0ax2taKpJNZK2CNTuwvAxCr2Gj+ZPSgXredSFxe
         tTEifgm9s4yXas/VEqZZitOwlZU+QMTk1eRaQWNCqARK/gpG4PsXYDGtuX5PiHDjDa3Y
         G77lXm1RlPH2WbFaDtq8JHPuUR2opPh0k4/NYclF50vrT1RB3kZkIVm+CE0sfkAmSyHN
         FRk9l1fYxQb/xHGbqSu0GvHFDXGrU3YKO0qfYPGzGtUfZSys8IcRbK199Mz+9HvPmD7o
         4vKon0Tgjx6Mv0HjJOa4z5IWc/0lTr4/ntQT4EoPTp6Tvwp5ItXypv/e+x0Alv4yeWPF
         HBCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702163561; x=1702768361;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fyY7xuerRfmnEXL+mjQb56JPNlX5ZA5VFzoyWh1LMIk=;
        b=Zh1W4JMg3B/Dx+VytBYX3Md4pgdRMkMGGON96s2oVL9Kci4Yn5fqIjLKhn0AWEgN0x
         DpwMpNiVy4+9npxVR08Yi+5KOlMCKIppTG5v9TO5rgeBLk8qaJvmqif/GPUaNd21z5h/
         75qMTUPWOfMr7IdUaQ2QpcRdy+zYe/bOwbJQPcEfTAlFerMADAiq+fPaWgMKUO+Szvql
         dBU70ENjyhY29/iIWEQGpK89aC99OXIVTEQS1aZW0CTWCxok+rSAjK6763vVDBhUGR48
         sDM5OjRI5ForhfPoMPDNxDS+HzVxtx9u0nYep8ED/yGV8m7q4gVeSbQ5VmtH3ssnrWjw
         BTIQ==
X-Gm-Message-State: AOJu0Yx2ZmYkO2k++FdGzrUy4zSI349l25c+tGmD8CGxN8bE8aRCCZS3
	qUji6siES+/QV4jNzC0px8Y=
X-Google-Smtp-Source: AGHT+IFdQhHVp2q3+OtY4B0AVXmBxuggoKt0nW2hBV9K4p3VmS1uZOxsooZUrel6k9hnzvgD0bYoDg==
X-Received: by 2002:a1c:6a16:0:b0:40c:25f6:4585 with SMTP id f22-20020a1c6a16000000b0040c25f64585mr991729wmc.73.1702163561253;
        Sat, 09 Dec 2023 15:12:41 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id w10-20020a05600c474a00b0040b2c195523sm10130953wmo.31.2023.12.09.15.12.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Dec 2023 15:12:40 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: Hector Martin <marcan@marcan.st>,
	Sven Peter <sven@svenpeter.dev>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] iommu/apple-dart: Fix spelling mistake "grups" -> "groups"
Date: Sat,  9 Dec 2023 23:12:40 +0000
Message-Id: <20231209231240.4056082-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There is a spelling mistake in a dev_err message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/iommu/apple-dart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/apple-dart.c b/drivers/iommu/apple-dart.c
index 7438e9c82ba9..497a516747bd 100644
--- a/drivers/iommu/apple-dart.c
+++ b/drivers/iommu/apple-dart.c
@@ -911,7 +911,7 @@ static struct iommu_group *apple_dart_device_group(struct device *dev)
 
 		ret = apple_dart_merge_master_cfg(group_master_cfg, cfg);
 		if (ret) {
-			dev_err(dev, "Failed to merge DART IOMMU grups.\n");
+			dev_err(dev, "Failed to merge DART IOMMU groups.\n");
 			iommu_group_put(group);
 			res = ERR_PTR(ret);
 			goto out;
-- 
2.39.2

