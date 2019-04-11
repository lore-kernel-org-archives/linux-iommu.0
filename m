Return-Path: <SRS0=HOzV=SO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2636C10F13
	for <iommu@archiver.kernel.org>; Fri, 12 Apr 2019 00:03:44 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A11BD2184B
	for <iommu@archiver.kernel.org>; Fri, 12 Apr 2019 00:03:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=arista.com header.i=@arista.com header.b="ZqsZwWNr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A11BD2184B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 8BD082D05;
	Fri, 12 Apr 2019 00:03:21 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 814F0241A
	for <iommu@lists.linux-foundation.org>;
	Thu, 11 Apr 2019 18:49:04 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com
	[209.85.208.66])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id CD480854
	for <iommu@lists.linux-foundation.org>;
	Thu, 11 Apr 2019 18:49:03 +0000 (UTC)
Received: by mail-ed1-f66.google.com with SMTP id x14so6169412eds.1
	for <iommu@lists.linux-foundation.org>;
	Thu, 11 Apr 2019 11:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=arista.com; s=googlenew;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=yoJ8L21VfG+7EiXp/r/AWsB982DfY9O3RZBK5Kp8sB8=;
	b=ZqsZwWNrSw+xqySh9ZjBwb+L6eYpx0X4qksRNIOZU8mg1TOpLf9O0fXmV0r6aHL2fZ
	3MfvzFGrJstIHcy1Po8voTQFYh8EpRq1/E82o6IVwvbNi70AX9ZsnmIDFYU6mz9IgKtS
	dYq2HbKPb0HAXgobjaNdmeDR8NvJmumSeiwwulVBya5cl5NYPDrIwZ2Tv3gVZLFW7Ova
	tsj1dT55hh6+YaiULDGzVztJQZPedQIn3i7JLnjvyt1OWAKoMUr4a3U/hvmoA6UDpVts
	xZLLAyc0d3/bS++XMrG4Q+Bewl65uvasxMRMjuBIQJx//ij8nSqueitAqBQHl/yYVNfY
	09hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=yoJ8L21VfG+7EiXp/r/AWsB982DfY9O3RZBK5Kp8sB8=;
	b=Wtubs7iVCN1+J0iFf6J4B3t2AT3+INMMdo7YqyK+H9twIuqqziZiucUfNVY9SUSaT4
	DuZVFzx5+j1Dz3+OsbhHuXaMJJa2oYfF+B59fg+vtDGKTQDqxAtEuff7OjguGfj6ivas
	BG9sl8HWYj2OyPBKU03nkeCZFpLgolVDPAS0nCFkfjNkZCdMvjdunlqWfLaJvpwyev3i
	2rflpa00YKvsUbe0cNCOMfM0FR8iIYzALIyZnm7Dfcb0oGX/eo+5FVZy13wI7JZJfPw4
	+UEskqMkfqHA2xSLIHiwH6mgBx238+wGMswCeKpMAq5vp4IpMrnIN4j9hQDDmVL44eFJ
	oS6w==
X-Gm-Message-State: APjAAAU+uNF7h41b0hpdJ8R5hAf7FrbVbsdpPRH9IrLc9qRxEk0VeY4K
	VMkzDcuOG9uJkZ4Hc4EFm6BTNp80LFVAIc6a
X-Google-Smtp-Source: APXvYqzhcIOArLgPaFIotHVPB4LMHAtfaoxhteXVLtNCkA9H3EacRfD1/rKtcbt7o0ew6bGKIbXfPg==
X-Received: by 2002:a17:906:d1da:: with SMTP id
	bs26mr28530697ejb.149.1555008542329; 
	Thu, 11 Apr 2019 11:49:02 -0700 (PDT)
Received: from localhost.localdomain ([80.233.32.123])
	by smtp.gmail.com with ESMTPSA id
	b10sm1285130edi.28.2019.04.11.11.49.00
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 11 Apr 2019 11:49:01 -0700 (PDT)
To: iommu@lists.linux-foundation.org
Subject: [PATCH 4/9] iommu/dma-iommu: Add iommu_dma_map_page_coherent
Date: Thu, 11 Apr 2019 19:47:33 +0100
Message-Id: <20190411184741.27540-5-tmurphy@arista.com>
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
Message-ID: <20190411184733.HFxQgxEjAAdUWtQBOmzXqfHviZJNxa-j60Z7AYE73d0@z>

Add iommu_dma_map_page_coherent function to allow mapping pages through
the dma-iommu api using the dev->coherent_dma_mask mask instead of the
dev->dma_mask mask

Signed-off-by: Tom Murphy <tmurphy@arista.com>
---
 drivers/iommu/dma-iommu.c | 25 ++++++++++++++++++++-----
 include/linux/dma-iommu.h |  3 +++
 2 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 613d181e78a9..0128370f8b88 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -663,7 +663,8 @@ int iommu_dma_mmap(struct page **pages, size_t size, struct vm_area_struct *vma)
 }
 
 static dma_addr_t __iommu_dma_map(struct device *dev, phys_addr_t phys,
-		size_t size, int prot, struct iommu_domain *domain)
+		size_t size, int prot, struct iommu_domain *domain,
+		dma_addr_t dma_limit)
 {
 	struct iommu_dma_cookie *cookie = domain->iova_cookie;
 	size_t iova_off = 0;
@@ -674,7 +675,7 @@ static dma_addr_t __iommu_dma_map(struct device *dev, phys_addr_t phys,
 		size = iova_align(&cookie->iovad, size + iova_off);
 	}
 
-	iova = iommu_dma_alloc_iova(domain, size, dma_get_mask(dev), dev);
+	iova = iommu_dma_alloc_iova(domain, size, dma_limit, dev);
 	if (!iova)
 		return DMA_MAPPING_ERROR;
 
@@ -693,7 +694,19 @@ dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
 		unsigned long offset, size_t size, int prot)
 {
 	return __iommu_dma_map(dev, page_to_phys(page) + offset, size, prot,
-			iommu_get_dma_domain(dev));
+			iommu_get_dma_domain(dev), dma_get_mask(dev));
+}
+
+dma_addr_t iommu_dma_map_page_coherent(struct device *dev, struct page *page,
+		unsigned long offset, size_t size, int prot)
+{
+	dma_addr_t dma_mask = dev->coherent_dma_mask;
+
+	if (!dma_mask)
+		dma_mask = dma_get_mask(dev);
+
+	return __iommu_dma_map(dev, page_to_phys(page) + offset, size, prot,
+			iommu_get_dma_domain(dev), dma_mask);
 }
 
 void iommu_dma_unmap_page(struct device *dev, dma_addr_t handle, size_t size,
@@ -883,7 +896,7 @@ dma_addr_t iommu_dma_map_resource(struct device *dev, phys_addr_t phys,
 {
 	return __iommu_dma_map(dev, phys, size,
 			dma_info_to_prot(dir, false, attrs) | IOMMU_MMIO,
-			iommu_get_dma_domain(dev));
+			iommu_get_dma_domain(dev), dma_get_mask(dev));
 }
 
 void iommu_dma_unmap_resource(struct device *dev, dma_addr_t handle,
@@ -910,7 +923,9 @@ static struct iommu_dma_msi_page *iommu_dma_get_msi_page(struct device *dev,
 	if (!msi_page)
 		return NULL;
 
-	iova = __iommu_dma_map(dev, msi_addr, size, prot, domain);
+	iova = __iommu_dma_map(dev, msi_addr, size, prot, domain,
+			dma_get_mask(dev));
+
 	if (iova == DMA_MAPPING_ERROR)
 		goto out_free_page;
 
diff --git a/include/linux/dma-iommu.h b/include/linux/dma-iommu.h
index c527ded5c41c..185ff8500841 100644
--- a/include/linux/dma-iommu.h
+++ b/include/linux/dma-iommu.h
@@ -55,6 +55,9 @@ int iommu_dma_mmap(struct page **pages, size_t size, struct vm_area_struct *vma)
 
 dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
 		unsigned long offset, size_t size, int prot);
+dma_addr_t iommu_dma_map_page_coherent(struct device *dev,
+		struct page *page, unsigned long offset,
+		size_t size, int prot);
 int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
 		int nents, int prot);
 
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
