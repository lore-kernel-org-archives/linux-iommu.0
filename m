Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56AAE3D9C;
	Thu, 13 Oct 2022 18:12:53 +0000 (UTC)
Received: by mail-ed1-f44.google.com with SMTP id r14so3756233edc.7;
        Thu, 13 Oct 2022 11:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JZtnjkPggA5SjkwbihxQWAD96AH19hj8hGJnqIV/2as=;
        b=h/9B8PjhRL0AdEzegsu1cN+YgPWzL8Yt8OtB9q1nNDhqtQ9BxH7ACySjVV/VeBVhsK
         YEPbewQmKHs4dq4cGsFmL1U83j8NROHxO5ExqKlrc0mBdk5uNoQOogiwnXYdFWZXGn6c
         VQi1BLth7T8fVggZGGh+vH4wQaH8B0d/qIZt/+yGzuhR+W3Vms4FimKOwuByoVAtmLoi
         WcCXELLiL+pB/sgBkYIYeROPfjjLJLAv/mucTGxPWSek5Xn25URUgyr0sCkeFkN3Xoyf
         M7gh6EM9INVsfa2wZbUPd/44s6y6wfRp4U1R5/9tuin5dtIrxDiuSioG+I8OaTONeVJM
         BTCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JZtnjkPggA5SjkwbihxQWAD96AH19hj8hGJnqIV/2as=;
        b=P8nIAtoX7pBGPLLweq0J3ZfLUpFv/yjjkggNUrFuaq2Q4TduEYg9fO5Dlc08XjEUO4
         3JRudoSGan+vOG4gGWLYYFF2DCBOKWBpg9Aq2C6x+FzJxn9KwmT7j/5GUKR+TbxBIttg
         d3pN+sItCj/VcLQ6YSOJv17uzLjKdbvZq6OMxObGHgC831LiaIeXJYrqH53lr05LLFjn
         5QxuvSmgG2dtqcUxK8UUcBSnLBUJ3iIknoPklJIkB2fAouW3gZWhtWoA+XftupFKiP7E
         Z9bloXX2qamoRvuloy2WRSr34yS8BYSJsspgnPD3cSmRUtGD3yyOxBkI2fGI/pEZea1h
         aPAg==
X-Gm-Message-State: ACrzQf3Hrl6iMxSvJ9HkiNKvXHqA8IDyKVjQ509GffH/bHaf+JAskgg7
	wWCxWZyf6fTCmPysdB4lV7M=
X-Google-Smtp-Source: AMsMyM4nF065eBM9sudXyKpRFJ4LcfEKfLKhmQ5xJQh+63T0xHhPiB6dBG8cwR7SmZC8OKOCNNlJIA==
X-Received: by 2002:a05:6402:254f:b0:45a:1799:d8fc with SMTP id l15-20020a056402254f00b0045a1799d8fcmr859345edb.237.1665684771705;
        Thu, 13 Oct 2022 11:12:51 -0700 (PDT)
Received: from kista.localdomain (82-149-19-102.dynamic.telemach.net. [82.149.19.102])
        by smtp.gmail.com with ESMTPSA id ku15-20020a170907788f00b0078b551d2fa3sm211109ejc.103.2022.10.13.11.12.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 11:12:51 -0700 (PDT)
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
Subject: [PATCH 5/5] iommu/sun50i: Invalidate iova in map and unmap callback
Date: Thu, 13 Oct 2022 20:12:21 +0200
Message-Id: <20221013181221.3247429-7-jernej.skrabec@gmail.com>
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
or otherwise they might or might not work when used by master or CPU.

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

