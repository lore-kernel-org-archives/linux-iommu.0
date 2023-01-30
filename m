Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B10569C
	for <iommu@lists.linux.dev>; Mon, 30 Jan 2023 16:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1675097639;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=kkgm+GawpEMj0/b8bomXaQOPdUfNkg30jmt/yNSamL8=;
	b=I/PTD/HO/odMpBQg8MHIbVICTCL8a7s3F4GAZ1H37W4tN69osO+U/ojBrF8VTyJXflCqkV
	v3vJj0MyneNg6kkcsYzMPC1RkipEnI/zDQDdPk1cZ8zBW9e1tdJKAn+WEWMT/0MNwbL1CB
	11sm3mHPMXimxM4ow+89jUxs2ndDIRY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-74-xK1nFR9JMb2ZCYRCA7xfhg-1; Mon, 30 Jan 2023 11:53:55 -0500
X-MC-Unique: xK1nFR9JMb2ZCYRCA7xfhg-1
Received: by mail-wm1-f70.google.com with SMTP id o42-20020a05600c512a00b003dc5341afbaso2276689wms.7
        for <iommu@lists.linux.dev>; Mon, 30 Jan 2023 08:53:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kkgm+GawpEMj0/b8bomXaQOPdUfNkg30jmt/yNSamL8=;
        b=H4kUpVvbacAPr+zi635aK+M5y5QNcVZ0GCdqY8Y9uEjJSbsaV58M0C7Ila5izc0WaF
         cJMwnmbJUglQ4vD96Ra956/tukS5fq1EABr16IE5hnd0YhgBe2yCJUji4wfOY5f/+6+c
         pkztElg8tVv1vBrXjFUuLeUCrx3gT3tKF07piryKowRGVfsZ/hLFSbqsvdfL++Fy0cKD
         tsKHnhKTToOc2VS7nyoCjbZtSIkTmZjSkWapag2tgDpMwvqFEHKpLCXhc6IsVMaUu5mm
         8ETOwTGo5Tgm4fTwylL8cJMuT8f13c5q3S66n7STJSKmT0ffKOLc1MAC4O6TvWGKh2sN
         w3RQ==
X-Gm-Message-State: AFqh2kpQqe4j35y7x22X2On922S03Lu8NsR2E6tHGQFUxJ7ya+Ez4bbV
	oos/UV69oiCZZGNkLJscNfmNcsDztJjOCHw/ydn5oOMkgb7yMkvihatWL8WGZ/ScSGZYge6J98e
	qAMeyEfCjBWW6p5s=
X-Received: by 2002:a05:600c:3586:b0:3da:fb3c:c1ab with SMTP id p6-20020a05600c358600b003dafb3cc1abmr48909707wmq.0.1675097634459;
        Mon, 30 Jan 2023 08:53:54 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtAfoRcm7NT4ZYC0o5cofJixnO/hgW2tQbP0lBvYL7zDDtE7psgWTMQUvqDIedKwjr+ouHdog==
X-Received: by 2002:a05:600c:3586:b0:3da:fb3c:c1ab with SMTP id p6-20020a05600c358600b003dafb3cc1abmr48909693wmq.0.1675097634291;
        Mon, 30 Jan 2023 08:53:54 -0800 (PST)
Received: from p1.. ([77.75.244.146])
        by smtp.gmail.com with ESMTPSA id n20-20020a05600c465400b003dc43a10fa5sm8677422wmo.13.2023.01.30.08.53.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 08:53:53 -0800 (PST)
From: Eric Curtin <ecurtin@redhat.com>
To: asahi@lists.linux.dev
Cc: Eric Curtin <ecurtin@redhat.com>,
	Dan Carpenter <error27@gmail.com>,
	Hector Martin <marcan@marcan.st>,
	Sven Peter <sven@svenpeter.dev>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/APPLE MACHINE SUPPORT),
	iommu@lists.linux.dev (open list:IOMMU SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] iommu: dart: DART_T8110_ERROR range should be 0 to 5
Date: Mon, 30 Jan 2023 16:53:50 +0000
Message-Id: <20230130165350.58533-1-ecurtin@redhat.com>
X-Mailer: git-send-email 2.39.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

This was detected by smatch as one "else if" statement could never be
reached. Confirmed bit order by comparing with python implementation [1].

drivers/iommu/apple-dart.c:991 apple_dart_t8110_irq()
warn: duplicate check 'error_code == ((((1))) << (3))'
  (previous on line 989)

Link: https://github.com/AsahiLinux/m1n1/commit/96b2d584feec1e3f7bfa [1]

Fixes: d8bcc870d99d ("iommu: dart: Add t8110 DART support")
Reported-by: Dan Carpenter <error27@gmail.com>
Signed-off-by: Eric Curtin <ecurtin@redhat.com>
---
 drivers/iommu/apple-dart.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/apple-dart.c b/drivers/iommu/apple-dart.c
index efe877842f72..3adacf4094d7 100644
--- a/drivers/iommu/apple-dart.c
+++ b/drivers/iommu/apple-dart.c
@@ -112,15 +112,15 @@
 
 #define DART_T8110_ERROR_MASK 0x104
 
-#define DART_T8110_ERROR_READ_FAULT BIT(4)
-#define DART_T8110_ERROR_WRITE_FAULT BIT(3)
+#define DART_T8110_ERROR_READ_FAULT BIT(5)
+#define DART_T8110_ERROR_WRITE_FAULT BIT(4)
 #define DART_T8110_ERROR_NO_PTE BIT(3)
 #define DART_T8110_ERROR_NO_PMD BIT(2)
 #define DART_T8110_ERROR_NO_PGD BIT(1)
 #define DART_T8110_ERROR_NO_TTBR BIT(0)
 
 #define DART_T8110_ERROR_ADDR_LO 0x170
-#define DART_T8110_ERROR_ADDR_HI 0x174
+#define DART_T8110_ERROR_ADDR_HI 0x175
 
 #define DART_T8110_PROTECT 0x200
 #define DART_T8110_UNPROTECT 0x204
-- 
2.39.1

