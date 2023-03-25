Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255C620EE
	for <iommu@lists.linux.dev>; Sat, 25 Mar 2023 11:08:08 +0000 (UTC)
Received: by mail-ed1-f53.google.com with SMTP id h8so17315285ede.8
        for <iommu@lists.linux.dev>; Sat, 25 Mar 2023 04:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679742486;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2XoXtByKh4UOZY04ttKfG8wCst6NLl0jJEghljzhdfk=;
        b=IEXMfmb9swizo0XNpd06KviT6M9g+vLRiVoOXMWKRNd8j2dzefDIaXkpzRucL9Loov
         b+tz39NKvbJErPQ6lUD7hEA0Yd78X4mPY7N44k75VFIizHqjRrwwJ35vkDxhmrM+p55W
         T4IZMvQSAkhpLXTQbsW/bXy/p7Laf21h2e7Cu2Tgm++yr4WxzBSfjdvilDZqJWFK2cCi
         Aa6ITeJDdpjmG8KTGXCa90WBJw/nQxTZyaWj+ADmCW+sKaJWAY0igmT+Pfk8KlgnMqR9
         SerTQOUqK4CizeTHHGctjhKvfhmTROetto4HkkGlV9Z41omJXbEBqNKijmOlfdhi8sbx
         S72Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679742486;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2XoXtByKh4UOZY04ttKfG8wCst6NLl0jJEghljzhdfk=;
        b=khaejbBl7TQHdNXCTAP6o+zal7zaftLzt5YweuUnljaK/MvhiasqJE0QiEvtsqk9vw
         /P19Ce5xvWVDHt9gGJE3fAz/BKFN4g/LLoJCIX/C7wuaJPaW/f49cJf46PEPltUh9Umt
         1iiwdnFjDQoblnaY6Yn9rBVWqonYUu82rC6XgFVbi0iSmdyPWu+0lCadqSKtqITD47vP
         EoLLGTHMrfuIQ0fJD5iie9fbcT3eGC2Kf5LcFx/eJWOMgEhT1YJJr/nicn0zDgIFAdES
         q87girCCapKiJ4sYwq1mbPOxKx+dNaxGZYun21ebZ4qO+dDguvf1YVrmr7tjCnCgrcSm
         esLg==
X-Gm-Message-State: AAQBX9flJcBcJ+eickoMw19iMZzSE8hzCEQvRUBRp7mQbZ/SyVTFB/B3
	038by3qiI+7Xgld3/TL+WEA=
X-Google-Smtp-Source: AKy350blMy+1lSMZfdLLVnHMMW+4npnrGgrb4s+FBpAEMxX72hJtPuTS6wqpGrPl8qCVLeTm6BR8TQ==
X-Received: by 2002:a05:6402:10d7:b0:4fd:2675:3783 with SMTP id p23-20020a05640210d700b004fd26753783mr6216664edu.1.1679742486271;
        Sat, 25 Mar 2023 04:08:06 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id b44-20020a509f2f000000b004c09527d62dsm12077001edf.30.2023.03.25.04.08.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Mar 2023 04:08:05 -0700 (PDT)
Date: Sat, 25 Mar 2023 14:07:52 +0300
From: Dan Carpenter <error27@gmail.com>
To: Yong Wu <yong.wu@mediatek.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"Chengci.Xu" <chengci.xu@mediatek.com>, iommu@lists.linux.dev,
	linux-mediatek@lists.infradead.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] iommu/mediatek: fix a reversed test in probe
Message-ID: <88c83ce7-5d1a-44a8-b9bf-0d01cfea24db@kili.mountain>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The dma_set_mask() function returns negative error codes on failure but
this code is testing for zero instead.

Fixes: f4b49c7c5e67 ("iommu/mediatek: Set dma_mask for PGTABLE_PA_35_EN")
Signed-off-by: Dan Carpenter <error27@gmail.com>
---
 drivers/iommu/mtk_iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 1a75b4382a92..6a00ce208dc2 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -1260,7 +1260,7 @@ static int mtk_iommu_probe(struct platform_device *pdev)
 
 	if (MTK_IOMMU_HAS_FLAG(data->plat_data, PGTABLE_PA_35_EN)) {
 		ret = dma_set_mask(dev, DMA_BIT_MASK(35));
-		if (!ret) {
+		if (ret) {
 			dev_err(dev, "Failed to set dma_mask 35.\n");
 			return ret;
 		}
-- 
2.39.1

