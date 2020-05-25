Return-Path: <SRS0=eEOj=7H=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 592A3C433DF
	for <iommu@archiver.kernel.org>; Mon, 25 May 2020 19:56:59 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F4A02073B
	for <iommu@archiver.kernel.org>; Mon, 25 May 2020 19:56:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lgLthuD3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F4A02073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id EBB7185F35;
	Mon, 25 May 2020 19:56:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vIIDpuNEJAAa; Mon, 25 May 2020 19:56:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 6F86585EE9;
	Mon, 25 May 2020 19:56:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 52132C088D;
	Mon, 25 May 2020 19:56:57 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B73ECC016F
 for <iommu@lists.linux-foundation.org>; Mon, 25 May 2020 19:56:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 9DF02226D3
 for <iommu@lists.linux-foundation.org>; Mon, 25 May 2020 19:56:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id s4FoWWt7seoh for <iommu@lists.linux-foundation.org>;
 Mon, 25 May 2020 19:56:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-lf1-f68.google.com (mail-lf1-f68.google.com
 [209.85.167.68])
 by silver.osuosl.org (Postfix) with ESMTPS id 3616A20005
 for <iommu@lists.linux-foundation.org>; Mon, 25 May 2020 19:56:55 +0000 (UTC)
Received: by mail-lf1-f68.google.com with SMTP id x27so11050672lfg.9
 for <iommu@lists.linux-foundation.org>; Mon, 25 May 2020 12:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=RfuCHKTNwaWG0c1gzxYwDnFHu5cJwWR/Dhzr/q0GiRw=;
 b=lgLthuD3Ld85JCIhPPZXcc8lF1lDUPUO+ueiGkF5X/sPrWlsszmqCWXWampG6miusl
 2srBFOe/fjJeFzZmwUgt11DY8EbMcLLXXrdQ1G6zKKGZ27Z2pSTMSd4fc5JRHQJOVFDf
 59dDsbf+UBIgFc7MFm6J756ZyXChxi2jkBRBu3VQ9Lee8bqOSih4bu9PbojTTjFSC/A7
 iejiNvUCmFneoMP+Iyf+QH08DCm1Rul7fHjltQQBFeqPE4lruc3ybApD/n2TX21mMc5V
 6JfHsyESU+9A3DlDrryCvFL8zZLvJrZvEB+eSMpyQNWE+fiwvlDqqdv7rQtksK3zrkaR
 hdmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=RfuCHKTNwaWG0c1gzxYwDnFHu5cJwWR/Dhzr/q0GiRw=;
 b=N6uqGt3l0ItLgn5gnHzapPx4KimaXKYict1wephEN1a7asfk9H4zkPeqpL7vM9FFly
 77/BdG3ND/RnVJaPk5r2uUv0ZWP02+wr/INSyZhKPWSHWnTOW71/CAKJ999yxrGCLuCm
 /qkGE/2p3RzHBibEq/vMc/yaXliZ5b8V0SbcELjOiG9zq8qqoBIkt9Up8p0l8Tl4l7yW
 stVsPtmxCP46q9KNQdZ7pWK0JxMdoStvlZ0SzzeijYnO21oc/xvr7QFTN6QJPNC97jbZ
 xQa90IqB2Tf2jvrFtEw2So7TfKLUVTV3tfbYAQ159qIspLKiONmPSaqM/K8C5pC9I/vH
 eTDg==
X-Gm-Message-State: AOAM5324teo2t1lSl9zPuNFl3SfbiLwdQOnPVtDUL/EBxu/NVo9xskpT
 A5hLiYBf7a1lU4GU3kUJXUk=
X-Google-Smtp-Source: ABdhPJx9UAHgWJ2dxnysys+OcIQSSLPgoqP+qo2oC8iiHOzMR+KSp1wVnhO5Hq7jBtEyUsruf78VQg==
X-Received: by 2002:a05:6512:3e7:: with SMTP id
 n7mr15253609lfq.118.1590436613238; 
 Mon, 25 May 2020 12:56:53 -0700 (PDT)
Received: from localhost.localdomain (ppp91-76-17-204.pppoe.mtu-net.ru.
 [91.76.17.204])
 by smtp.gmail.com with ESMTPSA id u4sm2889969lfl.18.2020.05.25.12.56.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2020 12:56:52 -0700 (PDT)
From: Dmitry Osipenko <digetx@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>, Joerg Roedel <joro@8bytes.org>,
 Jonathan Hunter <jonathanh@nvidia.com>
Subject: [PATCH v2] iommu/tegra-smmu: Add missing locks around mapping
 operations
Date: Mon, 25 May 2020 22:54:37 +0300
Message-Id: <20200525195437.14341-1-digetx@gmail.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Cc: linux-tegra@vger.kernel.org, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org
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

The mapping operations of the Tegra SMMU driver are subjected to a race
condition issues because SMMU Address Space isn't allocated and freed
atomically, while it should be. This patch makes the mapping operations
atomic, it fixes an accidentally released Host1x Address Space problem
which happens while running multiple graphics tests in parallel on
Tegra30, i.e. by having multiple threads racing with each other in the
Host1x's submission and completion code paths, performing IOVA mappings
and unmappings in parallel.

Cc: <stable@vger.kernel.org>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---

Changelog:

v2: - Now using mutex instead of spinlock.

    - The _locked postfix is replaced with the underscores prefix.

 drivers/iommu/tegra-smmu.c | 38 ++++++++++++++++++++++++++++++++++----
 1 file changed, 34 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index 7426b7666e2b..9cf06acb00ce 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -49,6 +49,7 @@ struct tegra_smmu_as {
 	struct iommu_domain domain;
 	struct tegra_smmu *smmu;
 	unsigned int use_count;
+	struct mutex lock;
 	u32 *count;
 	struct page **pts;
 	struct page *pd;
@@ -308,6 +309,8 @@ static struct iommu_domain *tegra_smmu_domain_alloc(unsigned type)
 		return NULL;
 	}
 
+	mutex_init(&as->lock);
+
 	/* setup aperture */
 	as->domain.geometry.aperture_start = 0;
 	as->domain.geometry.aperture_end = 0xffffffff;
@@ -655,8 +658,9 @@ static void tegra_smmu_set_pte(struct tegra_smmu_as *as, unsigned long iova,
 	smmu_flush(smmu);
 }
 
-static int tegra_smmu_map(struct iommu_domain *domain, unsigned long iova,
-			  phys_addr_t paddr, size_t size, int prot, gfp_t gfp)
+static int
+__tegra_smmu_map(struct iommu_domain *domain, unsigned long iova,
+		 phys_addr_t paddr, size_t size, int prot, gfp_t gfp)
 {
 	struct tegra_smmu_as *as = to_smmu_as(domain);
 	dma_addr_t pte_dma;
@@ -685,8 +689,9 @@ static int tegra_smmu_map(struct iommu_domain *domain, unsigned long iova,
 	return 0;
 }
 
-static size_t tegra_smmu_unmap(struct iommu_domain *domain, unsigned long iova,
-			       size_t size, struct iommu_iotlb_gather *gather)
+static size_t
+__tegra_smmu_unmap(struct iommu_domain *domain, unsigned long iova,
+		   size_t size, struct iommu_iotlb_gather *gather)
 {
 	struct tegra_smmu_as *as = to_smmu_as(domain);
 	dma_addr_t pte_dma;
@@ -702,6 +707,31 @@ static size_t tegra_smmu_unmap(struct iommu_domain *domain, unsigned long iova,
 	return size;
 }
 
+static int tegra_smmu_map(struct iommu_domain *domain, unsigned long iova,
+			  phys_addr_t paddr, size_t size, int prot, gfp_t gfp)
+{
+	struct tegra_smmu_as *as = to_smmu_as(domain);
+	int ret;
+
+	mutex_lock(&as->lock);
+	ret = __tegra_smmu_map(domain, iova, paddr, size, prot, gfp);
+	mutex_unlock(&as->lock);
+
+	return ret;
+}
+
+static size_t tegra_smmu_unmap(struct iommu_domain *domain, unsigned long iova,
+			       size_t size, struct iommu_iotlb_gather *gather)
+{
+	struct tegra_smmu_as *as = to_smmu_as(domain);
+
+	mutex_lock(&as->lock);
+	size = __tegra_smmu_unmap(domain, iova, size, gather);
+	mutex_unlock(&as->lock);
+
+	return size;
+}
+
 static phys_addr_t tegra_smmu_iova_to_phys(struct iommu_domain *domain,
 					   dma_addr_t iova)
 {
-- 
2.26.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
