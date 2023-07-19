Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520F017FE9;
	Wed, 19 Jul 2023 22:20:39 +0000 (UTC)
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1b89114266dso1134595ad.0;
        Wed, 19 Jul 2023 15:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689805238; x=1692397238;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+IwjlxlHW+LyjKwbZhGmbSPjjjJ61hnkvbBCUfDjZtk=;
        b=TxVJTnnWETGZjFcjn5k59+Yst4jpK6AajqIApsoMwWanNGNc5/nAkYo98sBAnyYbHB
         68Gscz5i1kKEvbboAtcYODLyRtUOJEJ8LJV9yV4tvsgMlv+SDaoIx0PsxokSPG6bgIxN
         xVNHuyCoFL7Ru+JI9zDXL4HTPRGrIPpfyRewi5FmxuOxiscO+rxJv0JKNcoCa1MmicHL
         o2f+2HXxAgCzhCXlRGeKEnMWUo0s+FQxZ8XN+s3SO/6zIzINitRvXngnBMWZ7VI+qAuQ
         5NxVvObToRQwYOgdu+G6U4O7zHvE9Z+RPJVt6sPk8lHbJIL/dF8PJK7wFVXhfc22Jbms
         ZMwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689805238; x=1692397238;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+IwjlxlHW+LyjKwbZhGmbSPjjjJ61hnkvbBCUfDjZtk=;
        b=aY8DPt0fy8aHE11ryiwyWQm39/i44qXJL5cczIYeJXUNnuMWveiZLc8KXTCnkQN8RI
         v48OPzVPf9rVfA9WlOAXYvaKnOE9bWBhzCRYwyIDHDIWIByMXtczB4JI9Zb2U2FFPYfY
         2ikitHXDFcafKiHEIplpQkEvV0AjVz6U0VTLxZmxSXirA3cyn7iO/Hdh5eQ43u7vHQxc
         hE0DZmo2LhZj/TmcK8cJ0HOiZUTvRoJRAI5vNa4WnhgtAdT3QrZJiiSlsKSZtkVQgipO
         0o3pDfMUoqcGVke16zQtg262kg+4PnuLK8S1pp5hWJvn+tX6hoE+3bGuUTlXVjmkrlZu
         PVQg==
X-Gm-Message-State: ABy/qLao6jQrRBQawK3mL8UOTV1hfSxE/MjWN3Sg32nc/d7ESXb49C7T
	du+GKUyM5lbAQPVHSxMHijk=
X-Google-Smtp-Source: APBJJlGN8EC/OehO6nRLfH5/6Tw0y/ENWnkzpGQDeCVqe7UUiVnMs8jI1TYEvFFKSnPGrkZTGzqY0w==
X-Received: by 2002:a17:903:234c:b0:1b8:4e00:96b with SMTP id c12-20020a170903234c00b001b84e00096bmr4803311plh.9.1689805238376;
        Wed, 19 Jul 2023 15:20:38 -0700 (PDT)
Received: from ubuntu777.domain.name (36-228-69-4.dynamic-ip.hinet.net. [36.228.69.4])
        by smtp.gmail.com with ESMTPSA id i10-20020a170902eb4a00b001b03b7f8adfsm4461150pli.246.2023.07.19.15.20.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 15:20:38 -0700 (PDT)
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
Subject: [PATCH] iommu/apple-dart: mark apple_dart_pm_ops static
Date: Thu, 20 Jul 2023 06:20:32 +0800
Message-Id: <20230719222033.117513-1-minhuadotchen@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch fixes the following sprse warning:

drivers/iommu/apple-dart.c:1279:1: sparse: warning: symbol 'apple_dart_pm_ops' was not declared. Should it be static?

No functional change intended.

Signed-off-by: Min-Hua Chen <minhuadotchen@gmail.com>
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

