Return-Path: <SRS0=HOzV=SO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65373C10F13
	for <iommu@archiver.kernel.org>; Fri, 12 Apr 2019 00:03:31 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 333892184B
	for <iommu@archiver.kernel.org>; Fri, 12 Apr 2019 00:03:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=arista.com header.i=@arista.com header.b="LB8fzaJx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 333892184B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 07AA02D00;
	Fri, 12 Apr 2019 00:03:21 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 13AAC241A
	for <iommu@lists.linux-foundation.org>;
	Thu, 11 Apr 2019 18:48:55 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com
	[209.85.208.68])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 6FAB2F4
	for <iommu@lists.linux-foundation.org>;
	Thu, 11 Apr 2019 18:48:54 +0000 (UTC)
Received: by mail-ed1-f68.google.com with SMTP id o26so6112247edv.12
	for <iommu@lists.linux-foundation.org>;
	Thu, 11 Apr 2019 11:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=arista.com; s=googlenew;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=6jV061f41NQwb8JTG8oXH2FoN+EzpljlUI1gqzDD5mU=;
	b=LB8fzaJxGq1UE+kpvHkDhu+B7IYs10PuyLyxZ03R2k40h38528mg8DNtw5CvvGGUEC
	4dNobAdGceLj4W3cf/sfNIbHYYnxPug8x3dHbMQMr2kBWb4l2K/d40OgBWHu7LGBSrMM
	s+LiuJL7CxNF9g9cw4QCmZ7DPjTrADiA+PibC+2h5HaxTFrd/3KF3OxCtBPyIfkaGijI
	w27pVFIysfKxbHH1Oa9xGIwlfToSd/gcWJ+6qScvI3KsfWoRcLhGTSa83G90H5wmgs26
	LzzyBPinYyZ0Vrq04CSUH9OmCRpgSwAiWliiYd80JUgr4JUSA6+IIwLoCw9dkVOlrsoq
	r3CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=6jV061f41NQwb8JTG8oXH2FoN+EzpljlUI1gqzDD5mU=;
	b=hls3s+sY83CSByqnYrqWhm5qDlG9IQnlun8pyNiYoYJStu3yGGGsN3Jm4cmW32eQYv
	60mArxgGsdouxS0yeHODH2DNNS9ITnt04z7NU85dvkRB3/8Xc2mxNdbuBIPEY4zoDOv1
	J+DPt3HqpMqensZxyT00Vg6JYmjIDTcipm/RE/DEnsJwozoY5KnoOuPJ66HQylx0Hc1F
	fQ0nl7t83ObnpjDZ6BBeLnOXRsRPuisSkEa/ydFGQy8HVHx+ACP8Xf44crirZXDqIISC
	cITkOnVrX8J4YBDzEL5AXgb/ALTxgTZNboZ7hFUf331j6JiGgayuONgmuhTlXv9oZ0T4
	g+vg==
X-Gm-Message-State: APjAAAWQAtExy+YolKyx4vSw60TnwHaH1437yRYCVnKzB1p7L18YiYA9
	Ep5t9UBLdv5It271+ZUy1IhO6TD5/9Lj+De7
X-Google-Smtp-Source: APXvYqxuoTpmggkOjj92suBw5a7aMbe3r0ArbtvwTV09yEmPy8J3qtmyATEWD+DKwUJEiX7Kcbu32A==
X-Received: by 2002:a17:906:5e0d:: with SMTP id
	n13mr27817212eju.37.1555008532896; 
	Thu, 11 Apr 2019 11:48:52 -0700 (PDT)
Received: from localhost.localdomain ([80.233.32.123])
	by smtp.gmail.com with ESMTPSA id
	b10sm1285130edi.28.2019.04.11.11.48.50
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 11 Apr 2019 11:48:52 -0700 (PDT)
To: iommu@lists.linux-foundation.org
Subject: [PATCH 2/9] iommu/dma-iommu: Add function to flush any cached not
	present IOTLB entries
Date: Thu, 11 Apr 2019 19:47:31 +0100
Message-Id: <20190411184741.27540-3-tmurphy@arista.com>
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
Message-ID: <20190411184731.CoSWQZyLnCjgydVo8pyFQkxGsJ9MNFYGhP_QGLYEfH8@z>

Both the AMD and Intel drivers can cache not present IOTLB entries. To
convert these drivers to the dma-iommu api we need a generic way to
flush the NP cache. IOMMU drivers which have a NP cache can implement
the .flush_np_cache function in the iommu ops struct. I will implement
.flush_np_cache for both the Intel and AMD drivers in later patches.

The Intel np-cache is described here:
https://software.intel.com/sites/default/files/managed/c5/15/vt-directed-io-spec.pdf#G7.66452

And the AMD np-cache is described here:
https://developer.amd.com/wordpress/media/2012/10/34434-IOMMU-Rev_1.26_2-11-09.pdf#page=63

Signed-off-by: Tom Murphy <tmurphy@arista.com>
---
 drivers/iommu/dma-iommu.c | 10 ++++++++++
 include/linux/iommu.h     |  3 +++
 2 files changed, 13 insertions(+)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 1a4bff3f8427..cc5da30d6e58 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -594,6 +594,9 @@ struct page **iommu_dma_alloc(struct device *dev, size_t size, gfp_t gfp,
 			< size)
 		goto out_free_sg;
 
+	if (domain->ops->flush_np_cache)
+		domain->ops->flush_np_cache(domain, iova, size);
+
 	*handle = iova;
 	sg_free_table(&sgt);
 	return pages;
@@ -652,6 +655,10 @@ static dma_addr_t __iommu_dma_map(struct device *dev, phys_addr_t phys,
 		iommu_dma_free_iova(cookie, iova, size);
 		return DMA_MAPPING_ERROR;
 	}
+
+	if (domain->ops->flush_np_cache)
+		domain->ops->flush_np_cache(domain, iova, size);
+
 	return iova + iova_off;
 }
 
@@ -812,6 +819,9 @@ int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
 	if (iommu_map_sg_atomic(domain, iova, sg, nents, prot) < iova_len)
 		goto out_free_iova;
 
+	if (domain->ops->flush_np_cache)
+		domain->ops->flush_np_cache(domain, iova, iova_len);
+
 	return __finalise_sg(dev, sg, nents, iova);
 
 out_free_iova:
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 75559918d9bd..47ff8d731d6a 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -173,6 +173,7 @@ struct iommu_resv_region {
  * @iotlb_sync_map: Sync mappings created recently using @map to the hardware
  * @iotlb_sync: Flush all queued ranges from the hardware TLBs and empty flush
  *            queue
+ * @flush_np_cache: Flush the non present entry cache
  * @iova_to_phys: translate iova to physical address
  * @add_device: add device to iommu grouping
  * @remove_device: remove device from iommu grouping
@@ -209,6 +210,8 @@ struct iommu_ops {
 				unsigned long iova, size_t size);
 	void (*iotlb_sync_map)(struct iommu_domain *domain);
 	void (*iotlb_sync)(struct iommu_domain *domain);
+	void (*flush_np_cache)(struct iommu_domain *domain,
+				unsigned long iova, size_t size);
 	phys_addr_t (*iova_to_phys)(struct iommu_domain *domain, dma_addr_t iova);
 	int (*add_device)(struct device *dev);
 	void (*remove_device)(struct device *dev);
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
