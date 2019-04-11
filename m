Return-Path: <SRS0=HOzV=SO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 856F5C10F13
	for <iommu@archiver.kernel.org>; Fri, 12 Apr 2019 00:03:37 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53ED52184B
	for <iommu@archiver.kernel.org>; Fri, 12 Apr 2019 00:03:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=arista.com header.i=@arista.com header.b="QBMldSGX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53ED52184B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 4B2F32D02;
	Fri, 12 Apr 2019 00:03:21 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 4E9CC241A
	for <iommu@lists.linux-foundation.org>;
	Thu, 11 Apr 2019 18:49:00 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com
	[209.85.208.68])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 1837DF4
	for <iommu@lists.linux-foundation.org>;
	Thu, 11 Apr 2019 18:48:59 +0000 (UTC)
Received: by mail-ed1-f68.google.com with SMTP id d11so6121483edp.11
	for <iommu@lists.linux-foundation.org>;
	Thu, 11 Apr 2019 11:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=arista.com; s=googlenew;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=AUkwsqPqLpOQmNdW6Zo0mGf3wmD2BJmU+zJegMbV/Cw=;
	b=QBMldSGXvc5UwIGLNlY32ptO/VQea8opvEhsRdSzFj4NeN+2G0brH1f/8UVXoDmFzp
	vgXq8kR+NdanSwtvOTUwpCkm2QCKmWJ4W86KO5tQnP14gTIyY6jfmkyqnM3PIjU1mTrt
	RDRIQ3bZewU8rrugmcD7S8kRSviGvRiF9zV4bsr6eB83nCXNebkP2SIudff9lbHkRgMS
	jtauEkPGJgc+fdQv9IWyCVoKtXmY9AvPYOF2tkN2bpTztPvH+bZN2z5g44aD0CJPVIjp
	Jfs1P1M2x6/FXn9kRoiH7d82Jzo159phG6Ce+OItl5XQo6MoCtkdx/N7GlvqiQu50XsS
	3gtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=AUkwsqPqLpOQmNdW6Zo0mGf3wmD2BJmU+zJegMbV/Cw=;
	b=n/6ITY7/KQGr/mgwj3JBjhYoXcs2KIj3Yq0Cy1QLuNd/FJEoCDMRJnuUCNt2A+u9t2
	+m7Ncr+emKe58ykeHZwFmg85cvo0cnm6iQ3kZag36YUxfe7AYkXflOTfeNkI9dTNhhpd
	NZtipkPck1CdEN/+UYmkswH3052M/6C52jGb9CvW7qVrsj3iEnEpqQuK+wr8DdTjyl2M
	b1pHbh0yrOFROiTcKSEIMOthc7q87oO6HXwkR8+42ashIL8cNJWeABZuBRaxliqVxCjk
	fY3FpjtFOEYYgumcURQLlf6c+OJ3akfhmK1+tCqJxauwhgk4bwKQaK3f3WWR9nxIgP9P
	AvCw==
X-Gm-Message-State: APjAAAVKpq441USyExx3PrZCnodaNOIurJxNkaUGfIpwfJmosEgDeA1o
	U5ut4Ibtj/kMenn8Yzgs3iqsT68yfxi/RuDu
X-Google-Smtp-Source: APXvYqzL/CeoYgUz/dL+UCoRPB57kS8k+K0AU3mwSjtkIW0qzE0UGCl3M97UgeKZ/ZqnWNSSEOk5sg==
X-Received: by 2002:a17:906:f0f:: with SMTP id
	z15mr12761935eji.125.1555008537548; 
	Thu, 11 Apr 2019 11:48:57 -0700 (PDT)
Received: from localhost.localdomain ([80.233.32.123])
	by smtp.gmail.com with ESMTPSA id
	b10sm1285130edi.28.2019.04.11.11.48.55
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 11 Apr 2019 11:48:57 -0700 (PDT)
To: iommu@lists.linux-foundation.org
Subject: [PATCH 3/9] iommu/dma-iommu: Add iommu_dma_copy_reserved_iova,
	iommu_dma_apply_resv_region to the dma-iommu api
Date: Thu, 11 Apr 2019 19:47:32 +0100
Message-Id: <20190411184741.27540-4-tmurphy@arista.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190411184741.27540-1-tmurphy@arista.com>
References: <20190411184741.27540-1-tmurphy@arista.com>
X-Mailman-Approved-At: Fri, 12 Apr 2019 00:02:45 +0000
Cc: Heiko Stuebner <heiko@sntech.de>, Will Deacon <will.deacon@arm.com>,
	David Brown <david.brown@linaro.org>,
	linux-samsung-soc@vger.kernel.org, dima@arista.com,
	Krzysztof Kozlowski <krzk@kernel.org>, linux-rockchip@lists.infradead.org,
	Kukjin Kim <kgene@kernel.org>, Andy Gross <andy.gross@linaro.org>,
	Marc Zyngier <marc.zyngier@arm.com>, linux-arm-msm@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org,
	Tom Murphy <tmurphy@arista.com>, linux-kernel@vger.kernel.org,
	murphyt7@tcd.ie, Robin Murphy <robin.murphy@arm.com>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
From: Tom Murphy via iommu <iommu@lists.linux-foundation.org>
Reply-To: Tom Murphy <tmurphy@arista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190411184732.jN-5I_pVvsrxZ1WZCHbfF7mYRJgMOUf3TdfnkgTja2Q@z>

To convert the AMD iommu driver to the dma-iommu we need to wrap some of
the iova reserve functions.

Signed-off-by: Tom Murphy <tmurphy@arista.com>
---
 drivers/iommu/dma-iommu.c | 27 +++++++++++++++++++++++++++
 include/linux/dma-iommu.h |  7 +++++++
 2 files changed, 34 insertions(+)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index cc5da30d6e58..613d181e78a9 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -162,6 +162,33 @@ void iommu_put_dma_cookie(struct iommu_domain *domain)
 }
 EXPORT_SYMBOL(iommu_put_dma_cookie);
 
+static struct iova *iommu_dma_reserve_iova(struct iommu_domain *domain,
+		dma_addr_t iova_lo, dma_addr_t iova_hi)
+{
+	struct iommu_dma_cookie *cookie = domain->iova_cookie;
+	struct iova_domain *iovad = &cookie->iovad;
+	unsigned long order = __ffs(domain->pgsize_bitmap);
+
+	return reserve_iova(iovad, iova_lo >> order, iova_hi >> order);
+}
+
+void iommu_dma_copy_reserved_iova(struct iova_domain *from,
+		struct iommu_domain *to)
+{
+	struct iommu_dma_cookie *cookie = to->iova_cookie;
+	struct iova_domain *to_iovad = &cookie->iovad;
+
+	copy_reserved_iova(from, to_iovad);
+}
+
+void iommu_dma_apply_resv_region(struct device *dev,
+		 struct iommu_domain *domain, struct iommu_resv_region *region)
+{
+	dma_addr_t end = region->start + region->length - 1;
+
+	WARN_ON_ONCE(iommu_dma_reserve_iova(domain, region->start, end) == NULL);
+}
+
 /**
  * iommu_dma_get_resv_regions - Reserved region driver helper
  * @dev: Device from iommu_get_resv_regions()
diff --git a/include/linux/dma-iommu.h b/include/linux/dma-iommu.h
index e760dc5d1fa8..c527ded5c41c 100644
--- a/include/linux/dma-iommu.h
+++ b/include/linux/dma-iommu.h
@@ -23,6 +23,7 @@
 #ifdef CONFIG_IOMMU_DMA
 #include <linux/dma-mapping.h>
 #include <linux/iommu.h>
+#include <linux/iova.h>
 #include <linux/msi.h>
 
 int iommu_dma_init(void);
@@ -57,6 +58,12 @@ dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
 int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
 		int nents, int prot);
 
+/* These are wrappers around some iova functions */
+void iommu_dma_apply_resv_region(struct device *dev,
+		struct iommu_domain *domain, struct iommu_resv_region *region);
+void iommu_dma_copy_reserved_iova(struct iova_domain *from,
+		struct iommu_domain *to);
+
 /*
  * Arch code with no special attribute handling may use these
  * directly as DMA mapping callbacks for simplicity
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
