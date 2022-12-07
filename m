Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F282102
	for <iommu@lists.linux.dev>; Wed,  7 Dec 2022 15:56:15 +0000 (UTC)
Received: by mail-ej1-f53.google.com with SMTP id fc4so14976252ejc.12
        for <iommu@lists.linux.dev>; Wed, 07 Dec 2022 07:56:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8UWo2XovqgYHs1QY4JjTgk1+oCej6jXzZZznbbgyuDY=;
        b=NIcT+iuluektAZ43nD5zND2pW7Pc6Jne9R/wMULrDfJFGi3VEUvXX1rJXafGRDitnM
         kAET1yXrKXXyXo40lWfPfDkxnEtfANlOJL5MmHgH0r6E9/38BKXryJbKsifW12TiEs7i
         98JieEasaAgLxnXWwA7NnJDAiByLxFAMPFq8U0OG4WSnCVLVf5EVzJ1OY67vdNOvYWLA
         5YKlMoY52hlo7l2oELGnElAn9yRysk2OLsDB6fDMtmZVyPOerYAqnufkgnCJsyjDEdu5
         RY2JqW33Cl10HzlsabUkgZXKxuqZZqRtz0b62+7Qi2b/BnFwZpD5Q7cIR7QIHPs2fvo2
         5oSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8UWo2XovqgYHs1QY4JjTgk1+oCej6jXzZZznbbgyuDY=;
        b=4eaQtAz/BjCjy5MWJLfH7BRBmKu5RMmw8Jnr5k2AR4S8X1+CnNAb7IjrNddCW8T5mg
         SLILUDG1sboaFhGzJ/DRXknnQBfBkPd+xvzBVXNsbIzA0fNhconID2K92zCLNnYcp9+D
         RKLERk3vzYzzZC2/vOPOC7ELT+Y5n9FJsI90M7lr57GIe0N82XNd+Xemlu6lkEHNICNS
         vOM6scwEgb1bZRcRgxdFTzFbD1PjzzMakU/NkKjqtUUbskKGe4f3xE4AhzkzlYySWCfZ
         en1XFajRA1B1ChbX+MJSTB5oVp1In4XUcZlrmhzxite8jlUGrMPej/ONpQl0LYu6uFUg
         na1w==
X-Gm-Message-State: ANoB5pm3pmd3fKbFnFpQZYn47e2A1uEst2p4s4VybgWeQntYHWe6PpHf
	Hm44qzRltQaeu6VDlYsmiMM=
X-Google-Smtp-Source: AA0mqf5WSh1ldUWiKlJTCUx19cpUJYc2SS9QTb71YZMoHc1TB56et+PDXLAokItPHooMeJ9Aa04teA==
X-Received: by 2002:a17:906:ca0e:b0:78c:1f2f:233e with SMTP id jt14-20020a170906ca0e00b0078c1f2f233emr64572621ejb.307.1670428574062;
        Wed, 07 Dec 2022 07:56:14 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id q18-20020a1709066b1200b007bf988ce9f7sm8715501ejr.38.2022.12.07.07.56.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 07:56:13 -0800 (PST)
Date: Wed, 7 Dec 2022 18:56:09 +0300
From: Dan Carpenter <error27@gmail.com>
To: Yong Wu <yong.wu@mediatek.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	iommu@lists.linux.dev, linux-mediatek@lists.infradead.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] iommu/mediatek: Fix forever loop in error handling
Message-ID: <Y5C3mTam2nkbaz6o@kili>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

There is a typo so this loop does i++ where i-- was intended.  It will
result in looping until the kernel crashes.

Fixes: 26593928564c ("iommu/mediatek: Add error path for loop of mm_dts_parse")
Signed-off-by: Dan Carpenter <error27@gmail.com>
---
 drivers/iommu/mtk_iommu.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 3e46bc8b0714..2badd6acfb23 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -1160,8 +1160,7 @@ static int mtk_iommu_mm_dts_parse(struct device *dev, struct component_match **m
 	return 0;
 
 err_larbdev_put:
-	/* id may be not linear mapping, loop whole the array */
-	for (i = MTK_LARB_NR_MAX - 1; i >= 0; i++) {
+	for (i = MTK_LARB_NR_MAX - 1; i >= 0; i--) {
 		if (!data->larb_imu[i].dev)
 			continue;
 		put_device(data->larb_imu[i].dev);
-- 
2.35.1

