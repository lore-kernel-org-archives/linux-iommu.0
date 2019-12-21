Return-Path: <SRS0=gCe8=2L=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E16AC2D0C0
	for <iommu@archiver.kernel.org>; Sat, 21 Dec 2019 15:11:10 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FD422070B
	for <iommu@archiver.kernel.org>; Sat, 21 Dec 2019 15:11:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tcd-ie.20150623.gappssmtp.com header.i=@tcd-ie.20150623.gappssmtp.com header.b="WkrW4Y9g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FD422070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tcd.ie
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 253C887776;
	Sat, 21 Dec 2019 15:11:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mM0jGnRW2YpM; Sat, 21 Dec 2019 15:11:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id B2CBE87A50;
	Sat, 21 Dec 2019 15:11:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9EF7BC1D7F;
	Sat, 21 Dec 2019 15:11:09 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A47C1C077D
 for <iommu@lists.linux-foundation.org>; Sat, 21 Dec 2019 15:11:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 9150B2048A
 for <iommu@lists.linux-foundation.org>; Sat, 21 Dec 2019 15:11:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DiVtsnlTNzE4 for <iommu@lists.linux-foundation.org>;
 Sat, 21 Dec 2019 15:11:07 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com
 [209.85.208.66])
 by silver.osuosl.org (Postfix) with ESMTPS id 28C3F20483
 for <iommu@lists.linux-foundation.org>; Sat, 21 Dec 2019 15:11:07 +0000 (UTC)
Received: by mail-ed1-f66.google.com with SMTP id j17so11412644edp.3
 for <iommu@lists.linux-foundation.org>; Sat, 21 Dec 2019 07:11:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tcd-ie.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=i4dEmM8P1MkKKnNa6NcbuVyKrLsO9ZvL1WqSkd7MOXA=;
 b=WkrW4Y9gFyG7Qyoell6pvhgdKX7JRReMnuuB9atJoZy04C/ONzngI9MJcZe1C52tLI
 oAbpeUorXN0OuO/Eg0uTEPtK43geQL68lw4o7Ot8H5XsWGNoa1eKf/zWorwqA2LubWhP
 ocpyZSMtNUbr1NWS3tmsbNFojfO0KFn4+WKore4fioT3aEQ4/J+J2uZcNnl0dckx4Wul
 NRwfEfsYHCfN/A/PJf0LwxVas5fBCAxc6UJkeMBPTkWvH4AkfCBijNzpnj6o2cB8Gozf
 5sLHCOhpM/FGuPL/eZWe8ySg2l+HsNgX8TbOePQbTkrzEKNWd/Ih3KEJxTQ88SBthjQ7
 3K5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=i4dEmM8P1MkKKnNa6NcbuVyKrLsO9ZvL1WqSkd7MOXA=;
 b=gGhei847UZcx84tHOa82q1f41LaP8SNGMTqAOsAJRgUkDBq7yIdzqQSMDQVmFY127I
 XI1/u9hbH0J6N2u+TTsv7dazl5wcWrIdtv9+IDWy/RYZpdUen014EYwxXui4O6ke0VA4
 7Dgczre5qvXUDECTYCy3EC3AuGJ9o5k8kULot2CaxyRHj1+6zlOx9tDip538JNM8YVih
 va8MBopZERHb74EZUT15Gdka7WfQTOJ5a6xly+pznt5Hf1D5jW0VYJhpJbUelMk8ol6T
 nmtF2KhWm8MpR859oAybvIO7mxbzgmOz/0TmfZQYNZMPuDS4uE8iBwjliN4Ws9IDC+jV
 KLVw==
X-Gm-Message-State: APjAAAVowmT+nb5zH7D3fG9MTQOaozd1pZy/2aVfByZrFbwDXJxiRRRM
 sz3J/hRnfCruCG5UDM6lTsrKsr5/Ha2toA==
X-Google-Smtp-Source: APXvYqzXACa8CmCe+lm4PqHAgWDF0JjnrRxrrR2y7kN6n1yqsWvuOaXwCLqKegFsZD4yWY1Pcx2X8g==
X-Received: by 2002:a05:6402:2c3:: with SMTP id
 b3mr22084523edx.207.1576940686355; 
 Sat, 21 Dec 2019 07:04:46 -0800 (PST)
Received: from localhost.localdomain ([80.233.37.20])
 by smtp.googlemail.com with ESMTPSA id u13sm1517639ejz.69.2019.12.21.07.04.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Dec 2019 07:04:45 -0800 (PST)
From: Tom Murphy <murphyt7@tcd.ie>
To: iommu@lists.linux-foundation.org
Subject: [PATCH 5/8] iommu: Add iommu_dma_free_cpu_cached_iovas function
Date: Sat, 21 Dec 2019 15:03:57 +0000
Message-Id: <20191221150402.13868-6-murphyt7@tcd.ie>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191221150402.13868-1-murphyt7@tcd.ie>
References: <20191221150402.13868-1-murphyt7@tcd.ie>
MIME-Version: 1.0
Cc: Heiko Stuebner <heiko@sntech.de>, kvm@vger.kernel.org,
 David Airlie <airlied@linux.ie>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 dri-devel@lists.freedesktop.org, Bjorn Andersson <bjorn.andersson@linaro.org>,
 linux-tegra@vger.kernel.org, Julien Grall <julien.grall@arm.com>,
 Thierry Reding <thierry.reding@gmail.com>, Will Deacon <will@kernel.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 linux-samsung-soc@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
 Krzysztof Kozlowski <krzk@kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>,
 linux-rockchip@lists.infradead.org, Andy Gross <agross@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, intel-gfx@lists.freedesktop.org,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 linux-mediatek@lists.infradead.org, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 virtualization@lists.linux-foundation.org,
 Gerald Schaefer <gerald.schaefer@de.ibm.com>,
 David Woodhouse <dwmw2@infradead.org>, Cornelia Huck <cohuck@redhat.com>,
 linux-kernel@vger.kernel.org, Tom Murphy <murphyt7@tcd.ie>,
 Kukjin Kim <kgene@kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
 Robin Murphy <robin.murphy@arm.com>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

to dma-iommu ops

Add a iommu_dma_free_cpu_cached_iovas function to allow drivers which
use the dma-iommu ops to free cached cpu iovas.

Signed-off-by: Tom Murphy <murphyt7@tcd.ie>
---
 drivers/iommu/dma-iommu.c | 9 +++++++++
 include/linux/dma-iommu.h | 3 +++
 2 files changed, 12 insertions(+)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index df28facdfb8b..4eac3cd35443 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -50,6 +50,15 @@ struct iommu_dma_cookie {
 	struct iommu_domain		*fq_domain;
 };
 
+void iommu_dma_free_cpu_cached_iovas(unsigned int cpu,
+		struct iommu_domain *domain)
+{
+	struct iommu_dma_cookie *cookie = domain->iova_cookie;
+	struct iova_domain *iovad = &cookie->iovad;
+
+	free_cpu_cached_iovas(cpu, iovad);
+}
+
 static void iommu_dma_entry_dtor(unsigned long data)
 {
 	struct page *freelist = (struct page *)data;
diff --git a/include/linux/dma-iommu.h b/include/linux/dma-iommu.h
index 2112f21f73d8..316d22a4a860 100644
--- a/include/linux/dma-iommu.h
+++ b/include/linux/dma-iommu.h
@@ -37,6 +37,9 @@ void iommu_dma_compose_msi_msg(struct msi_desc *desc,
 
 void iommu_dma_get_resv_regions(struct device *dev, struct list_head *list);
 
+void iommu_dma_free_cpu_cached_iovas(unsigned int cpu,
+		struct iommu_domain *domain);
+
 #else /* CONFIG_IOMMU_DMA */
 
 struct iommu_domain;
-- 
2.20.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
