Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9843A27715;
	Fri, 14 Mar 2025 23:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741993284; cv=none; b=l2R5g6qo3xce9rkRGxaaJ6cce2khSp7aW5eDcQpIz8d0/MAlI6WyMYZn6O5o4vLfUsQZ4jSOk4FgxRKO7rA3JkTdSRBEBZJnF8a3olI4eNMT97wDdvVl5tY0Tzg5xxWfMRAea1Bf0cwp3UreFOcdEjIP3Wttp3f4H1fcFoZtBo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741993284; c=relaxed/simple;
	bh=Xq8Gl7p54Zigri2Bds+cKPnITS0YnyYVHvHKq98ZbDw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tOEnlER+91ZgK6hJ7nDCZ1mMFbWWg9AwvEf9g6NGEBDjJeA9iBS7kQsdZyzaMIUN8reGnsqRRGzOuEJYk8jLdyLCOyjwmGzGTp34zhgPu6UNn9fR+LNckWWKDIT8/fO/BOSCWkJTWPZDaV6i4YxmNRg24fwHNx2KcqnQgm22k4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CJM6y0a9; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CJM6y0a9"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43d0618746bso1499795e9.2;
        Fri, 14 Mar 2025 16:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741993281; x=1742598081; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vRtPg6oACw1hvTRmuv/RSNk9va89gmS+OSMNWv2jX3U=;
        b=CJM6y0a93znvTMc0sZVwShzWmHNsOW5DnlLGmAYj+GIyzcytP6/57HNnGx/PXkWti+
         VTDyktGjqMsdv9u4lWzg6vESy5CjkFQN2kDRnWmIJ3BTc12sd1AHnfah+JvMsZ1kT/N/
         G26dQjo+NoM3Ig7Ogd9WdV5NjlOoHKS3t3uqKfrafpUq7ecMR/z+rgyrflxZJzJX6We4
         NkiftueiRIqz+dm7mdSQDHCcK1T0rYf11WtsvHIeDdK0cTSbKw+zaHg/zc657F59iUDC
         DiSgXIzG2BbEwN2L+c31yZgPMLvMGF6faZx6KgAvLY2uvCzh71FwGYExoq66FSp/arw+
         e49w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741993281; x=1742598081;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vRtPg6oACw1hvTRmuv/RSNk9va89gmS+OSMNWv2jX3U=;
        b=bbeZCcGQj0RQUKRZy0aIHrP4k6Sl+lM5JmZYj/l8dv5vWzM4W3cbxr6h6BQf494eZZ
         XGfZ9ygzS6Uo7pVWXzn4mePSy6+uZ0CTiNSMweYvA3DduIzf86znZgzXzcUJIPJ5kQfe
         zvYCSv1+R+KCKtm01o/iEoZcw4CA/4r1z6oim0OrEFXFWpHccCoph5GtvsH/qzv05x+3
         qVXqOaWaVwMZYX48OB/XGeGV3UONkF26ux76GM2nQmO2jjQ6qK9zf5Rpbeo3HHNHtI3L
         l4R3TaDMbKbydk3H5mTpJID7dWe4XOUKn8DJYU6qQ0cIyoFGeE2ERvLDKhEAlBovL9DA
         EM4g==
X-Forwarded-Encrypted: i=1; AJvYcCUFA9R2ithVJqEEGft4QAib2NnJhhbkROCKplSkoNFss8VTqLtoi5r42jPHcCHEaKJbV/YOVw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyqz7cG3fqSyrob4qhUIwGkM8xOK0DJ1JEdg4rR/AJSx7Ghfh+H
	UmndDDIo0By1s2Qa7i11gCNKIL5nFMO+Gm6dgUvS7WxAHWw/TP7/
X-Gm-Gg: ASbGnctC8GqQAEvL75NpWINE9U6Gfw83TsxcMdKW9LbO1m09CgnIqYse9OK7Cc6E76w
	sOO6k1M6odp34SG0FjRJ1cyJv3KtI2lffKBVCAjjZtZnejIfkjaqWT7SYBKhl4rhJZchYyn6y2F
	5bz+u/ENzE8/iRmc2NNgITT8E3jlSRFc8E90F1jvWechghgTdtfnv9IBsC9Gz5cuEZ4MfmU1JPa
	jkhByFtUSy6hTxFd+gQOb3QoX7wovXD7h88CjwGbfutEATsqwOvTmKPOrZaadWx90eKcqaud8xJ
	PtDZIomKUMZpP91xyz/q/9/Xz/DPldW+ePv1K1KOOGvo
X-Google-Smtp-Source: AGHT+IE0pax4j7XCryEzABptGEHj97UrueRJkeMrjB7rZqxeTR5+yJpR9Dcqmq7/m6LJKVapTevhJg==
X-Received: by 2002:a05:600c:198c:b0:43d:10c:2f60 with SMTP id 5b1f17b1804b1-43d1ed00016mr53261805e9.24.1741993280384;
        Fri, 14 Mar 2025 16:01:20 -0700 (PDT)
Received: from qasdev.Home ([2a02:c7c:6696:8300:15a:24b1:8146:1068])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d1fe2927fsm30441345e9.18.2025.03.14.16.01.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 16:01:19 -0700 (PDT)
From: Qasim Ijaz <qasdev00@gmail.com>
To: marcan@marcan.st,
	fnkl.kernel@gmail.com,
	Sven Peter <sven@svenpeter.dev>,
	Janne Grunau <j@jannau.net>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>
Cc: asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iommu: apple-dart: fix potential null pointer deref
Date: Fri, 14 Mar 2025 23:01:02 +0000
Message-Id: <20250314230102.11008-1-qasdev00@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If kzalloc() fails, accessing cfg->supports_bypass causes a null pointer dereference. 

Fix by checking for NULL immediately after allocation and returning -ENOMEM.

Fixes: 3bc0102835f6 ("iommu: apple-dart: Allow mismatched bypass support")
Signed-off-by: Qasim Ijaz <qasdev00@gmail.com>
---
 drivers/iommu/apple-dart.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/apple-dart.c b/drivers/iommu/apple-dart.c
index 13ccb801f52a..e13501541fdd 100644
--- a/drivers/iommu/apple-dart.c
+++ b/drivers/iommu/apple-dart.c
@@ -797,12 +797,11 @@ static int apple_dart_of_xlate(struct device *dev,
 
 	if (!cfg) {
 		cfg = kzalloc(sizeof(*cfg), GFP_KERNEL);
-
+		if (!cfg)
+			return -ENOMEM;
 		/* Will be ANDed with DART capabilities */
 		cfg->supports_bypass = true;
 	}
-	if (!cfg)
-		return -ENOMEM;
 	dev_iommu_priv_set(dev, cfg);
 
 	cfg_dart = cfg->stream_maps[0].dart;
-- 
2.39.5

