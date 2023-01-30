Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540A11840
	for <iommu@lists.linux.dev>; Mon, 30 Jan 2023 10:26:40 +0000 (UTC)
Received: by mail-wr1-f44.google.com with SMTP id y1so10571210wru.2
        for <iommu@lists.linux.dev>; Mon, 30 Jan 2023 02:26:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mNpd3roa5gv6troS6TLhHBAaJw7HpklMLo5JJSNOuFM=;
        b=HvVgNisJ1GOros7sTO0b7jt6wckJtww8GE0pYFh/mdrEOLAcdKo8vPknDwup16osyM
         116amBTSkKUkZ8ekVMYLvfeqfw5qoBdXOLh4SHUHOOcBkstUcLJjw95obMk6rJSVbKjS
         jHAE6s5PzQaftkaFWBDvZ1Y32Am60WjAZ4zjvWjfB6KlK/GbXWqaBDgX+ZUj+kieeJ3N
         xlZglbm8ucQewISN4rZyw375sWGlYOOpp9mK5o81r+L+y9Nu5mUB36mXBzJdTCCW4/1Q
         NXgBjgb+wtTtDdgBkmjtDiARGJcZK4ENi17cLkZgpm92XEUBp+mW6HAo5xVLPYkbLeXk
         SXOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mNpd3roa5gv6troS6TLhHBAaJw7HpklMLo5JJSNOuFM=;
        b=VN6QVh16kGvV1OeDmsJtnNwopG8KhfDWIttU4p1o2CV+hlbedXy09F9+by6RqLahte
         o8QO9YZLwa6O+AX+tv2QQAe7LK+7+XUQlELLhkE6xoa4FsVozILXhwyHC53cY3ydHYcq
         IEO7btjIjpwUvHSXfBjkowqmJ7t8W61mTI8Io1hsTNkUZF04kKQcmBHBD5+nUsVDKyko
         /Uv0YOgqHT24zcCaNUeYGD7lmiJ7A6i8cdZwdD7EfphBkdDDZLmODJ3oCACbzA3Od1kr
         +4z3YRJgE2fIxyUqifAfuURWHNBosWDK1rCI9b3PuwhRaS9eLYHhNq1zDkVW1GrpQqJa
         6clg==
X-Gm-Message-State: AO0yUKXbmX/80i4dAikHvW4E+0IkmZtAokiHVsH00bbeoegbTlYlMQOp
	QrjAg2xDUkz4vz6TDP8a6UMKgg==
X-Google-Smtp-Source: AK7set9AyBy9CX25oVJxOx8ewKugRbpLcfdp5pWqnHAyLQivzN79VIqqC6uSU+2kFVMMMrl1nKkKlA==
X-Received: by 2002:a5d:5c08:0:b0:2bf:b775:babd with SMTP id cc8-20020a5d5c08000000b002bfb775babdmr21396377wrb.28.1675074398562;
        Mon, 30 Jan 2023 02:26:38 -0800 (PST)
Received: from alex-T14.baylibre (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id s5-20020a5d5105000000b002bdfcd8c77csm11426785wrt.101.2023.01.30.02.26.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 02:26:38 -0800 (PST)
From: Alexandre Bailon <abailon@baylibre.com>
To: yong.wu@mediatek.com,
	joro@8bytes.org,
	will@kernel.org
Cc: robin.murphy@arm.com,
	matthias.bgg@gmail.com,
	krzysztof.kozlowski@linaro.org,
	robh+dt@kernel.org,
	iommu@lists.linux.dev,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Alexandre Bailon <abailon@baylibre.com>
Subject: [PATCH 2/3] iommu: mediatek: Add support of unmanaged iommu domain
Date: Mon, 30 Jan 2023 11:27:21 +0100
Message-Id: <20230130102722.133271-3-abailon@baylibre.com>
X-Mailer: git-send-email 2.38.2
In-Reply-To: <20230130102722.133271-1-abailon@baylibre.com>
References: <20230130102722.133271-1-abailon@baylibre.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, the driver can allocate an unmanaged iommu domain.
But, this only works for SoC having multiple bank or multiple iova region.
This updates the driver to also support unmanaged iommu domain if
MTK_UNMANAGED_DEVICE is set in the iommu id.

Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
---
 drivers/iommu/mtk_iommu.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 2badd6acfb23d..5884a1ad409a0 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -858,9 +858,15 @@ static int mtk_iommu_get_group_id(struct device *dev, const struct mtk_iommu_pla
 static struct iommu_group *mtk_iommu_device_group(struct device *dev)
 {
 	struct mtk_iommu_data *c_data = dev_iommu_priv_get(dev), *data;
+	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
 	struct list_head *hw_list = c_data->hw_list;
 	struct iommu_group *group;
 	int groupid;
+	int i;
+
+	for (i = 0; i < fwspec->num_ids; i++)
+		if (MTK_M4U_UNMANAGED(fwspec->ids[i]))
+			return iommu_group_alloc();
 
 	data = mtk_iommu_get_frst_data(hw_list);
 	if (!data)
-- 
2.38.2

