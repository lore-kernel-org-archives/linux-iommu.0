Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5756D2F8
	for <iommu@lists.linux.dev>; Mon, 30 Oct 2023 09:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rn5kRE6u"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-507a62d4788so6366196e87.0
        for <iommu@lists.linux.dev>; Mon, 30 Oct 2023 02:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698656598; x=1699261398; darn=lists.linux.dev;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cYFH7qp0u3X29NywKpoP1IyU1hw7BcleLqoH2m7DO8E=;
        b=rn5kRE6uAduQTT+6KdsMccKVD5W8UKfYDX76apl4XJqOkn7EA79laeMJTPLwU9OYnZ
         O4xdn+56ShJJHx4dvk+sziOdcRUExw3xZCYz3RlrgqPYZvwbjs853m0Mmkh29mTgs9TO
         gkH2qJqcj8Jpz+7ujOiZ9+gg8Hdy2w51Kxsopv8gqwqWZd8gSmDC45QCXQcMuTaSo0qt
         oTChqSDwF5roGcD5//rchBhErmHGN7+B8kSyseIU4Ci/f41OMKoxZv8ZmiAkdBxafURz
         P60wfevLUOhEwBfPOkgntaVlsfYG/rc+kD/t7RffwBYLtj4KQFHPCpp7M7RRNG72Ievn
         tiww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698656598; x=1699261398;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cYFH7qp0u3X29NywKpoP1IyU1hw7BcleLqoH2m7DO8E=;
        b=DvYxve+rfuKj62jYj1a352kTI0aEaKSJ4jJJA0JcoEycTAYpHTfCUROgqdbZ7wstzQ
         EdI0MMRDVTp+38RGrMrnyP2/H+saUcxuLrIzYxu9GQw0XfAqDF44EWEF5GjDQGnGFvTC
         FMBlcm9yMeA/4y0vOk2ARTxtx4Xp9vngolfeAcbCcOtzQCrQJUX+kwqjXZGnRmclKeBL
         J+M2VKB+iv5Lb6jLk5Z2RU7uvmYO4g6ZbboeddOgMEXrGfr1RPxCseTigT05799JwVg7
         OGt58rfjyM4y71M1GIXIpfY+fK7nUq/3JTGEL+9SbmAqaQfKUQ444RUrfyUw4z1AJYPT
         71nw==
X-Gm-Message-State: AOJu0YyOEu97MgR9juyzfKnm4SCvrBsAMV9zKVDZt+Bj1AiBV3LTnM8k
	EO5ieGzGL2ovaMHH26uBcu1JGA==
X-Google-Smtp-Source: AGHT+IEhqt5JyMuDyehB8tfDt0aSGJIzli2DgC7Bp6/VFUQmD21VwzJ1TqPJN1de7TiMAV9dumwFyA==
X-Received: by 2002:a05:6512:6d1:b0:507:c7ae:32cc with SMTP id u17-20020a05651206d100b00507c7ae32ccmr8087977lff.41.1698656597789;
        Mon, 30 Oct 2023 02:03:17 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id s10-20020a05600c45ca00b0040772138bb7sm12176139wmo.2.2023.10.30.02.03.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 02:03:17 -0700 (PDT)
Date: Mon, 30 Oct 2023 12:03:12 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Janne Grunau <j@jannau.net>,
	asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, kernel-janitors@vger.kernel.org
Subject: [PATCH] iommu/dart: Fix return code in
 apple_dart_domain_alloc_paging()
Message-ID: <b85e0715-3224-4f45-ad6b-ebb9f08c015d@moroto.mountain>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The apple_dart_domain_alloc_paging() function is supposed to return NULL
on error.  Returning an error pointer will lead to an Oops in
__iommu_domain_alloc().

Fixes: 482feb5c6492 ("iommu/dart: Call apple_dart_finalize_domain() as part of alloc_paging()")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/iommu/apple-dart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/apple-dart.c b/drivers/iommu/apple-dart.c
index ee05f4824bfa..cb38a7a826dc 100644
--- a/drivers/iommu/apple-dart.c
+++ b/drivers/iommu/apple-dart.c
@@ -761,7 +761,7 @@ static struct iommu_domain *apple_dart_domain_alloc_paging(struct device *dev)
 		ret = apple_dart_finalize_domain(dart_domain, cfg);
 		if (ret) {
 			kfree(dart_domain);
-			return ERR_PTR(ret);
+			return NULL;
 		}
 	}
 	return &dart_domain->domain;
-- 
2.42.0

