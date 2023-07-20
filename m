Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DCCF1DDE9;
	Thu, 20 Jul 2023 23:22:01 +0000 (UTC)
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1b9c5e07c1bso9924105ad.2;
        Thu, 20 Jul 2023 16:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689895320; x=1690500120;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rjCoDcXSzuJEaW1efhPSb3RNSUyxQu5V/Hxq+lz3rlw=;
        b=L4fS7j2fP9Ixp3TUxZ0LXvyn+Awk0N+bglYo1G6/i3mCE3jlY34HTMNCldI7WxMBsQ
         35cLp+dS+mQG3H1znRyLlYZcdXhr1C1S34jqspVjAXjBrN1z0HnI0El3F1jmowVFTK/0
         cyvXCkJerzdjL5cRL4p4mkV1bdx5TxpXxskdWcgUOOzYwplG7++TDRi9zD70vbaAIrVA
         p/i+8dGWCMp2bpKBs26/+MpGdi9wO2Su9FXPtYrP8s5CHiTsuNzkNQNqEVtMQOt7Jnha
         0VCE0G2znj/f9yzzWnlP2OK1gMRKbXT6FSDAg048/irqq3eaT3JXIUOvtl0fh4o4hAYH
         ULDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689895320; x=1690500120;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rjCoDcXSzuJEaW1efhPSb3RNSUyxQu5V/Hxq+lz3rlw=;
        b=MSOUtkX7xoKXeFzq7U7pwMjGnITjfz5wsBCmcyvzYK3KfdOJNqB98rBtFVUU464zjB
         JM46VoTdoq/bpuzWwxJzvGzCLaRNJYSZmzHm23WiHR7wpbMtkEwR7jmXl6fSNv8zqNPh
         u0R/S/wpYzjZ9yK1gOznHrPeS+jVkiVLdk6aDsqq6hrP+zvUplste81EneXKLPC+/kLU
         /OeUxF+PQrxenUfTYGBVL1ShEntwnxxGAcbbxQwR3G/y3fwm4nk3a+M/VlIlk8OmKSIs
         VC2wCiHTIB0hImwLbKVn/SH23yM3R4bFJaAzdqyHBwI916w/UPlvjQOmxxFiLiHTEpRB
         xT+A==
X-Gm-Message-State: ABy/qLZFvbjOO2FqFElPcq19kRL+c/SGmBXZx6iKobgb2wgqLkbdAJUQ
	iVMZ9a15tW51gNtHKDeVsbQ=
X-Google-Smtp-Source: APBJJlHhaKPGvjH/nZHIpKyzPxtoroonfLHzarlmGBQ3jJimUanhdgD+rzgA9NzzZ5cFqKoVBiFd1A==
X-Received: by 2002:a17:902:c103:b0:1b6:9551:e2b8 with SMTP id 3-20020a170902c10300b001b69551e2b8mr376261pli.34.1689895320439;
        Thu, 20 Jul 2023 16:22:00 -0700 (PDT)
Received: from ubuntu777.domain.name (36-228-98-231.dynamic-ip.hinet.net. [36.228.98.231])
        by smtp.gmail.com with ESMTPSA id ik24-20020a170902ab1800b001b7f40a8959sm1986182plb.76.2023.07.20.16.21.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 16:22:00 -0700 (PDT)
From: Min-Hua Chen <minhuadotchen@gmail.com>
To: Hector Martin <marcan@marcan.st>,
	Sven Peter <sven@svenpeter.dev>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>
Cc: Min-Hua Chen <minhuadotchen@gmail.com>,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] iommu/apple-dart: mark apple_dart_pm_ops static
Date: Fri, 21 Jul 2023 07:21:54 +0800
Message-Id: <20230720232155.3923-1-minhuadotchen@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch fixes the following sparse warning:

drivers/iommu/apple-dart.c:1279:1: sparse: warning: symbol 'apple_dart_pm_ops' was not declared. Should it be static?

No functional change intended.

Signed-off-by: Min-Hua Chen <minhuadotchen@gmail.com>
Acked-by: Sven Peter <sven@svenpeter.dev>

---

Change since v1:
fix a typo

---
 drivers/iommu/apple-dart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/apple-dart.c b/drivers/iommu/apple-dart.c
index 8af64b57f048..2082081402d3 100644
--- a/drivers/iommu/apple-dart.c
+++ b/drivers/iommu/apple-dart.c
@@ -1276,7 +1276,7 @@ static __maybe_unused int apple_dart_resume(struct device *dev)
 	return 0;
 }
 
-DEFINE_SIMPLE_DEV_PM_OPS(apple_dart_pm_ops, apple_dart_suspend, apple_dart_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(apple_dart_pm_ops, apple_dart_suspend, apple_dart_resume);
 
 static const struct of_device_id apple_dart_of_match[] = {
 	{ .compatible = "apple,t8103-dart", .data = &apple_dart_hw_t8103 },
-- 
2.34.1

