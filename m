Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6D32588
	for <iommu@lists.linux.dev>; Wed,  1 Feb 2023 12:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1675255546;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=P5+/TE6LzKC07Kx1pXnv9JC6SnXItOhhp/p3/pfSlio=;
	b=YcMibXPnF+AHWK9WePLRk2jCvwGRvuPGejJwwfK+x5LzbSsjJShq62BVLoLC19xPuVAg+2
	gRqk5wmHSiTgQ4Ra9TGyhuYTcKFXgy1NqE66gU1KuhMXRxk1FlNiVrIjMG583FA7/+OYxT
	T8OdABZkAdel2VYwavtT7tiM45yRr+Y=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-613-xQpeaQ5PMyuL2CKEWHSPFA-1; Wed, 01 Feb 2023 07:45:45 -0500
X-MC-Unique: xQpeaQ5PMyuL2CKEWHSPFA-1
Received: by mail-wm1-f72.google.com with SMTP id k17-20020a05600c1c9100b003dd41ad974bso933770wms.3
        for <iommu@lists.linux.dev>; Wed, 01 Feb 2023 04:45:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P5+/TE6LzKC07Kx1pXnv9JC6SnXItOhhp/p3/pfSlio=;
        b=QnO4Cl4u/cYpun7y/Cvigz0UZgSxSWbJwCzCpIKnmic5Du5nzU8+u/Geo3EKvL2DSY
         FVQUFf5UFPvZtnv2uvCrcEJX7uK3KfDbGCnQi01CM8N9euchUCdlNuhutuN/4K5wmtnl
         O09ne0a9ullMgiXC2g4wSbQCZxEYB0k+f0ivpZ2S3eiOYh91Yy9x+Yembc+kLgFO8NBA
         svcrSEJGPc87ly+UrPKFI0Ic6+r4GfVHy8AtmLSKQaA0pX511iU5DXJsiP2XUNAolPMo
         Wt5oTbhhBP7XV2wdn5kES4RtgGTFel21Q95veKcf+YJHqWbXpuxhSdbvuAcCiA7QPxy0
         8uXQ==
X-Gm-Message-State: AO0yUKU+vFnWvPY48X2r32x2FrZWCdIEBP6OvTSXbXneMEGBtkgJikNn
	sDdA17v+4j2SWe1Bw1OEwcE3zMHNPQ7MTa9W8GWBnza60Js8Qrh3RiVn0BpbGeTCeL/Fx+5Wnsi
	pCJ9L001HpRu4+vE=
X-Received: by 2002:a05:600c:314d:b0:3dc:5bd7:62ec with SMTP id h13-20020a05600c314d00b003dc5bd762ecmr1867371wmo.32.1675255544927;
        Wed, 01 Feb 2023 04:45:44 -0800 (PST)
X-Google-Smtp-Source: AK7set8X93HL3Pr+6m4ySC12znD+8GoeAtT14ExdjxV3jscGlmPBNCPHqUqxLTGT8qb1RFXrdrgjLw==
X-Received: by 2002:a05:600c:314d:b0:3dc:5bd7:62ec with SMTP id h13-20020a05600c314d00b003dc5bd762ecmr1867352wmo.32.1675255544695;
        Wed, 01 Feb 2023 04:45:44 -0800 (PST)
Received: from localhost.localdomain ([2001:bb6:963d:9e00:7585:fe90:1658:512f])
        by smtp.gmail.com with ESMTPSA id k27-20020a05600c081b00b003de77597f16sm1626333wmp.21.2023.02.01.04.45.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 04:45:44 -0800 (PST)
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
Subject: [PATCH v2] iommu: dart: DART_T8110_ERROR range should be 0 to 5
Date: Wed,  1 Feb 2023 12:42:58 +0000
Message-Id: <20230201124257.7801-1-ecurtin@redhat.com>
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
Signed-off-by: Eric Curtin <ecurtin@redhat.com
---
Changes in v2: Remove DART_T8110_ERROR_ADDR_HI change
---
 drivers/iommu/apple-dart.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/apple-dart.c b/drivers/iommu/apple-dart.c
index 42666617803d..fd09abe8d29e 100644
--- a/drivers/iommu/apple-dart.c
+++ b/drivers/iommu/apple-dart.c
@@ -111,8 +111,8 @@
 
 #define DART_T8110_ERROR_MASK 0x104
 
-#define DART_T8110_ERROR_READ_FAULT BIT(4)
-#define DART_T8110_ERROR_WRITE_FAULT BIT(3)
+#define DART_T8110_ERROR_READ_FAULT BIT(5)
+#define DART_T8110_ERROR_WRITE_FAULT BIT(4)
 #define DART_T8110_ERROR_NO_PTE BIT(3)
 #define DART_T8110_ERROR_NO_PMD BIT(2)
 #define DART_T8110_ERROR_NO_PGD BIT(1)
-- 
2.39.1

