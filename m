Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F63361
	for <iommu@lists.linux.dev>; Tue,  4 Apr 2023 00:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1680567803;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=hzpxcJajz08AV0XDrocS4qLOzlh9DO1qut/0bGgwnKs=;
	b=Ye5DUIKbHfbdRbpbozlXuKtqqYoMY7+KR/iSbgX+dThmVNuEomh2rSL/MDNrxFOP3BT+de
	223nNa/bxE+PhRSDhMCxywMz6bH2iqe0ZmoJym/N6OHSVqgl8iE7tXvY4K2Fao3KiEQQC2
	VjfSXYBitb1o5s07WtHBxnBNcgj9q5I=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-187-n1JyzpKDNNW_Pk56JfRFzg-1; Mon, 03 Apr 2023 20:23:22 -0400
X-MC-Unique: n1JyzpKDNNW_Pk56JfRFzg-1
Received: by mail-qk1-f197.google.com with SMTP id 187-20020a3707c4000000b007468d9a30faso13964659qkh.23
        for <iommu@lists.linux.dev>; Mon, 03 Apr 2023 17:23:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680567801;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hzpxcJajz08AV0XDrocS4qLOzlh9DO1qut/0bGgwnKs=;
        b=i5TYM6vxTiN7PAskUVWLcxfOTM+78Gv36/BU4pMcIQL81DMorGYQxsjwJ5GqbrhBjA
         HSxj6uzW0vZlq8UdjAqbIRT5d7DhZLHoI8guA3ElaipBm7c7zUStQAWGuNGUiBaKYYeJ
         37Wa+FRMt6LCQyzzcuaEDF9/A4rik6NkI6KpfxNdw+3JEzzkd6H62nKXu17j61KKQWbU
         c3ey0WE10hitSWKgKu3imdEM3ekbfCXUQM7EummQocbD06FgPESIS7GM5oL78RZLWa3M
         1mmYs1J557KwneitGMKSC4CU6tuKzkXJqDwViSIWafrngWtze84pONpFEnXAdPk/Gnsc
         578Q==
X-Gm-Message-State: AAQBX9cbvelfcEt5D4I10iaWw/DVaTU4d1D/b8wpW9uu38F7lC19jg4/
	fgT9dWLAMR3Dh6D9EHvMccHFAC4T1+gxfy3WKYD+GUmEMvYHg/ryajfdrk8Ew1YuFCXw/bWf/6U
	0xUucPFNrfIJL/vE=
X-Received: by 2002:a05:6214:27c4:b0:5d1:d9f3:dd8c with SMTP id ge4-20020a05621427c400b005d1d9f3dd8cmr824018qvb.46.1680567801631;
        Mon, 03 Apr 2023 17:23:21 -0700 (PDT)
X-Google-Smtp-Source: AKy350YdPb8V+zEe8tO8QV/HpoZCorP5igbv0p/6JHM8en2t+h4oeCDRExu1nGN6FXBGC/7qUud/UQ==
X-Received: by 2002:a05:6214:27c4:b0:5d1:d9f3:dd8c with SMTP id ge4-20020a05621427c400b005d1d9f3dd8cmr824001qvb.46.1680567801386;
        Mon, 03 Apr 2023 17:23:21 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id d1-20020a0cc681000000b005dd8b934579sm3016236qvj.17.2023.04.03.17.23.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 17:23:21 -0700 (PDT)
From: Tom Rix <trix@redhat.com>
To: jgg@ziepe.ca,
	kevin.tian@intel.com,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tom Rix <trix@redhat.com>
Subject: [PATCH] iommufd/selftest: set varaiable mock_iommu_device storage-class-specifier to static
Date: Mon,  3 Apr 2023 20:23:17 -0400
Message-Id: <20230404002317.1912530-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
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

smatch reports
drivers/iommu/iommufd/selftest.c:295:21: warning: symbol
  'mock_iommu_device' was not declared. Should it be static?

This variable is only used in one file so it should be static.
Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/iommu/iommufd/selftest.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index 2deda489a934..9d43334e4faf 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -292,7 +292,7 @@ static const struct iommu_ops mock_ops = {
 		},
 };
 
-struct iommu_device mock_iommu_device = {
+static struct iommu_device mock_iommu_device = {
 	.ops = &mock_ops,
 };
 
-- 
2.27.0

