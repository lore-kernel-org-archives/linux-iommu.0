Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4698A4402;
	Thu, 13 Oct 2022 18:12:52 +0000 (UTC)
Received: by mail-ej1-f48.google.com with SMTP id b2so5664564eja.6;
        Thu, 13 Oct 2022 11:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G/wqfyJKTZ7wwUwifWDTzmNazpZHMfc05QXeSM6TUXI=;
        b=HaWB05RUzvGfW6+QiMaqb8b0VOKKAaUqAEvziPp0WVrpvdqnF7t9V7XIW/Kdd2CgTV
         MWJQpXnB4lJPuCjoPHK4oXZ2a5OmmlJ6mMvRxsbnC+3saJfPtSps5BwSki8CFQMHRPjc
         aDGbMFxIME7O4mmOfGRwjI3kPeu7DB/u64DMUqpxcNLaMBT+EAwQGRC0ySMbeNQ02CKT
         0slQHRidRJ/khi3Tf4mcKVVW7Fdct7kH+myaom2zNvNGPDxIlJv7Xnh/kM8OaXTlNcHJ
         avaPrzAqSGIvo/rdV72eaY6xHH/dvt2g8Slr/UEBbbSwTOQqUJKa7BoJeS5+rc2+i9by
         vLYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G/wqfyJKTZ7wwUwifWDTzmNazpZHMfc05QXeSM6TUXI=;
        b=tqTQmIDv70cz1ZdlfL8Wn/OczHFRnPHumqAlouxcPZkcE9AuKiYPPrYMKPJJPrHUDM
         7lkSv2s+hoDm2m13qq9VJNkrUYt+m3QbsWcbW1enbMvdt2DVAKL3j6VJelWncfUo5+ly
         4fxal4VkDLQ9ULWVzzZ/G82cmAChPl4HnZH2BWAOdZdgKs7f39oybAywtJ39u2n7tqHE
         QnQUT+Kqy2hN8soUulxXT7m9TbSoVP6oEs65uhJLrHNJyx2ZLJAmVNoeTRNy75UYsj8C
         g4vgbP+ftR+OkFGRQ3PjIZhtAPN1T9dJoh4XM530mOI7vbmO8cAiW27mfqirjls2kuaw
         3h2w==
X-Gm-Message-State: ACrzQf2OgB3Gg3v+mQlT5AUG5ND0kbsHgZLTXt03y0MW9JsdEFO5Svvh
	Bm6MvfIu/nM4r0DfrUEiaaw=
X-Google-Smtp-Source: AMsMyM4e5Qp7lIwnRmj6eEtIo1d/yAMzeBAPyESkz/ITsT3lYxT+Mt/6bwUGY7gp+tSLkj/QxDDqXw==
X-Received: by 2002:a17:907:75ed:b0:78d:97ed:2894 with SMTP id jz13-20020a17090775ed00b0078d97ed2894mr698352ejc.739.1665684770605;
        Thu, 13 Oct 2022 11:12:50 -0700 (PDT)
Received: from kista.localdomain (82-149-19-102.dynamic.telemach.net. [82.149.19.102])
        by smtp.gmail.com with ESMTPSA id ku15-20020a170907788f00b0078b551d2fa3sm211109ejc.103.2022.10.13.11.12.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 11:12:50 -0700 (PDT)
From: Jernej Skrabec <jernej.skrabec@gmail.com>
To: maxime@cerno.tech,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	wens@csie.org,
	samuel@sholland.org
Cc: iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH 5/5] iommu/sun50i: Invalidate iova at map and unmap
Date: Thu, 13 Oct 2022 20:12:20 +0200
Message-Id: <20221013181221.3247429-6-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221013181221.3247429-1-jernej.skrabec@gmail.com>
References: <20221013181221.3247429-1-jernej.skrabec@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Mapped and unmapped iova addresses needs to be invalidated immediately
or otherwise they might or might not work when used by master device.

This was discovered when running video decoder conformity test with
Cedrus. Some videos were now and then decoded incorrectly and generated
page faults.

Fixes: 4100b8c229b3 ("iommu: Add Allwinner H6 IOMMU driver")
Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 drivers/iommu/sun50i-iommu.c | 51 ++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/drivers/iommu/sun50i-iommu.c b/drivers/iommu/sun50i-iommu.c
index 7c3b2ac552da..21e47ce6946a 100644
--- a/drivers/iommu/sun50i-iommu.c
+++ b/drivers/iommu/sun50i-iommu.c
@@ -518,6 +518,53 @@ static u32 *sun50i_dte_get_page_table(struct sun50i_iommu_domain *sun50i_domain,
 	return page_table;
 }
 
+static void sun50i_iommu_zap_iova(struct sun50i_iommu *iommu, unsigned long iova)
+{
+	unsigned long flags;
+	u32 reg;
+	int ret;
+
+	spin_lock_irqsave(&iommu->iommu_lock, flags);
+
+	iommu_write(iommu, IOMMU_AUTO_GATING_REG, 0);
+
+	iommu_write(iommu, IOMMU_TLB_IVLD_ADDR_REG, iova);
+	iommu_write(iommu, IOMMU_TLB_IVLD_ADDR_MASK_REG, GENMASK(11, 0));
+	iommu_write(iommu, IOMMU_TLB_IVLD_ENABLE_REG, IOMMU_TLB_IVLD_ENABLE_ENABLE);
+
+	ret = readl_poll_timeout_atomic(iommu->base + IOMMU_TLB_IVLD_ENABLE_REG,
+					reg, !reg, 1, 2000);
+	if (ret)
+		dev_warn(iommu->dev, "TLB invalidation timed out!\n");
+
+	iommu_write(iommu, IOMMU_AUTO_GATING_REG, IOMMU_AUTO_GATING_ENABLE);
+
+	spin_unlock_irqrestore(&iommu->iommu_lock, flags);
+}
+
+static void sun50i_iommu_zap_ptw_cache(struct sun50i_iommu *iommu, unsigned long iova)
+{
+	unsigned long flags;
+	u32 reg;
+	int ret;
+
+	spin_lock_irqsave(&iommu->iommu_lock, flags);
+
+	iommu_write(iommu, IOMMU_AUTO_GATING_REG, 0);
+
+	iommu_write(iommu, IOMMU_PC_IVLD_ADDR_REG, iova);
+	iommu_write(iommu, IOMMU_PC_IVLD_ENABLE_REG, IOMMU_PC_IVLD_ENABLE_ENABLE);
+
+	ret = readl_poll_timeout_atomic(iommu->base + IOMMU_PC_IVLD_ENABLE_REG,
+					reg, !reg, 1, 2000);
+	if (ret)
+		dev_warn(iommu->dev, "PTW cache invalidation timed out!\n");
+
+	iommu_write(iommu, IOMMU_AUTO_GATING_REG, IOMMU_AUTO_GATING_ENABLE);
+
+	spin_unlock_irqrestore(&iommu->iommu_lock, flags);
+}
+
 static int sun50i_iommu_map(struct iommu_domain *domain, unsigned long iova,
 			    phys_addr_t paddr, size_t size, int prot, gfp_t gfp)
 {
@@ -546,6 +593,8 @@ static int sun50i_iommu_map(struct iommu_domain *domain, unsigned long iova,
 
 	*pte_addr = sun50i_mk_pte(paddr, prot);
 	sun50i_table_flush(sun50i_domain, pte_addr, 1);
+	sun50i_iommu_zap_iova(iommu, iova);
+	sun50i_iommu_zap_ptw_cache(iommu, iova);
 
 out:
 	return ret;
@@ -571,6 +620,8 @@ static size_t sun50i_iommu_unmap(struct iommu_domain *domain, unsigned long iova
 
 	memset(pte_addr, 0, sizeof(*pte_addr));
 	sun50i_table_flush(sun50i_domain, pte_addr, 1);
+	sun50i_iommu_zap_iova(sun50i_domain->iommu, iova);
+	sun50i_iommu_zap_ptw_cache(sun50i_domain->iommu, iova);
 
 	return SZ_4K;
 }
-- 
2.38.0

