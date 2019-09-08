Return-Path: <SRS0=24kn=XD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7D51C4332F
	for <iommu@archiver.kernel.org>; Sun,  8 Sep 2019 16:57:25 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8EBB21479
	for <iommu@archiver.kernel.org>; Sun,  8 Sep 2019 16:57:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tcd-ie.20150623.gappssmtp.com header.i=@tcd-ie.20150623.gappssmtp.com header.b="DmYpORWJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8EBB21479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tcd.ie
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 0140BC4E;
	Sun,  8 Sep 2019 16:57:04 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 3531FBA9
	for <iommu@lists.linux-foundation.org>;
	Sun,  8 Sep 2019 16:57:03 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com
	[209.85.210.195])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id C00DA832
	for <iommu@lists.linux-foundation.org>;
	Sun,  8 Sep 2019 16:57:01 +0000 (UTC)
Received: by mail-pf1-f195.google.com with SMTP id r12so7675860pfh.1
	for <iommu@lists.linux-foundation.org>;
	Sun, 08 Sep 2019 09:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=tcd-ie.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=RfHmYWiMThI6XBXa2YE269JhY5zyIOLGivfX/oOORWs=;
	b=DmYpORWJqyzijh72UcrIWdFFAa+ww/GFK6qzQZmnCCIq+YOTGiYhGxXGAJUM66+ViZ
	biwANpSj16S/IWvPLXicptTlojpKqRsl76xoCqv73zpCCmI3Ry414D3qf2XQVJbLRkYz
	MKnJeO0BCQbCSPBcJvHk9ZwcjQJmI1fqHAOJBw/kpdeXEc9zDiUH7BWR7nt5hq2VV4VR
	TAj4QqkEciqMizmYpSv4Bxfifj1yjQ+HWcpbGVpdYl9a40kDFvNZUQAn1t+nqa9RKoq8
	fG0I7ETsqgdcF+2BV6wQGXzS4yhP6Cp/jMrleb7Yt2880pcKUcT3rXZGljbub+Wz2vpU
	Y6Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=RfHmYWiMThI6XBXa2YE269JhY5zyIOLGivfX/oOORWs=;
	b=qoI/kVyPMHnjriRmDqGJQfGHyKa1WDme0+nQPMe8Dms9zf/FpayA7kE1d/edopSkYv
	oULtFMf04We7o/z6mYb+niVJvetJlFPlya0ujgnvkytdYO1//ygfx9qS5v01fa1Pwsux
	8Iii6uYBu9KFx/tzMCL+ZeXMm3hrsXE/VWlW+yw8v3iU5/+eTZOp1S9n2HcWhsO0KVdt
	x2DPv4vZy5zOnAYatVTZ17dDWL1TBoaaF6Xw+4KPSrVnIfWhkAngsaVy6GPNUadJUkR0
	FqxKcvUq2NlfgU+gTmddITjCI9g5/U+wjXtKveuoKgITHAJdOotXzas8+52ZIOB9FcAf
	UQOQ==
X-Gm-Message-State: APjAAAUgHk7u5kyib3d/XQXSwiveIUxkKeLG5Vc34sVUElLG0ILyYkqA
	caWESZEQezjaLDAi+bGDNedi+qJGxgYQAA==
X-Google-Smtp-Source: APXvYqwb14B4be5Dly+SGA8/U+UtNd3CILzif54GYTzQtR0eqj4U9DtUfUiUL561KlrtajOkqtGwTA==
X-Received: by 2002:a17:90a:28c5:: with SMTP id
	f63mr11263462pjd.67.1567961821142; 
	Sun, 08 Sep 2019 09:57:01 -0700 (PDT)
Received: from localhost.localdomain ([24.244.23.109])
	by smtp.googlemail.com with ESMTPSA id
	f188sm13834631pfa.170.2019.09.08.09.56.59
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Sun, 08 Sep 2019 09:57:00 -0700 (PDT)
From: Tom Murphy <murphyt7@tcd.ie>
To: iommu@lists.linux-foundation.org
Subject: [PATCH V6 1/5] iommu/amd: Remove unnecessary locking from AMD iommu
	driver
Date: Sun,  8 Sep 2019 09:56:37 -0700
Message-Id: <20190908165642.22253-2-murphyt7@tcd.ie>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190908165642.22253-1-murphyt7@tcd.ie>
References: <20190908165642.22253-1-murphyt7@tcd.ie>
MIME-Version: 1.0
Cc: Heiko Stuebner <heiko@sntech.de>, virtualization@lists.linux-foundation.org,
	linux-tegra@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>,
	Will Deacon <will@kernel.org>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	linux-samsung-soc@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>, linux-rockchip@lists.infradead.org,
	Andy Gross <agross@kernel.org>,
	Gerald Schaefer <gerald.schaefer@de.ibm.com>,
	linux-s390@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Matthias Brugger <matthias.bgg@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	David Woodhouse <dwmw2@infradead.org>,
	linux-kernel@vger.kernel.org, Tom Murphy <murphyt7@tcd.ie>,
	Kukjin Kim <kgene@kernel.org>, Robin Murphy <robin.murphy@arm.com>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

With or without locking it doesn't make sense for two writers to be
writing to the same IOVA range at the same time. Even with locking we
still have a race condition, whoever gets the lock first, so we still
can't be sure what the result will be. With locking the result will be
more sane, it will be correct for the last writer, but still useless
because we can't be sure which writer will get the lock last. It's a
fundamentally broken design to have two writers writing to the same
IOVA range at the same time.

So we can remove the locking and work on the assumption that no two
writers will be writing to the same IOVA range at the same time.

The only exception is when we have to allocate a middle page in the page
tables, the middle page can cover more than just the IOVA range a writer
has been allocated. However this isn't an issue in the AMD driver
because it can atomically allocate middle pages using "cmpxchg64()".

Signed-off-by: Tom Murphy <murphyt7@tcd.ie>
---
 drivers/iommu/amd_iommu.c       | 10 +---------
 drivers/iommu/amd_iommu_types.h |  1 -
 2 files changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 008da21a2592..1948be7ac8f8 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -2858,7 +2858,6 @@ static void protection_domain_free(struct protection_domain *domain)
 static int protection_domain_init(struct protection_domain *domain)
 {
 	spin_lock_init(&domain->lock);
-	mutex_init(&domain->api_lock);
 	domain->id = domain_id_alloc();
 	if (!domain->id)
 		return -ENOMEM;
@@ -3045,9 +3044,7 @@ static int amd_iommu_map(struct iommu_domain *dom, unsigned long iova,
 	if (iommu_prot & IOMMU_WRITE)
 		prot |= IOMMU_PROT_IW;
 
-	mutex_lock(&domain->api_lock);
 	ret = iommu_map_page(domain, iova, paddr, page_size, prot, GFP_KERNEL);
-	mutex_unlock(&domain->api_lock);
 
 	domain_flush_np_cache(domain, iova, page_size);
 
@@ -3058,16 +3055,11 @@ static size_t amd_iommu_unmap(struct iommu_domain *dom, unsigned long iova,
 			   size_t page_size)
 {
 	struct protection_domain *domain = to_pdomain(dom);
-	size_t unmap_size;
 
 	if (domain->mode == PAGE_MODE_NONE)
 		return 0;
 
-	mutex_lock(&domain->api_lock);
-	unmap_size = iommu_unmap_page(domain, iova, page_size);
-	mutex_unlock(&domain->api_lock);
-
-	return unmap_size;
+	return iommu_unmap_page(domain, iova, page_size);
 }
 
 static phys_addr_t amd_iommu_iova_to_phys(struct iommu_domain *dom,
diff --git a/drivers/iommu/amd_iommu_types.h b/drivers/iommu/amd_iommu_types.h
index 9ac229e92b07..b764e1a73dcf 100644
--- a/drivers/iommu/amd_iommu_types.h
+++ b/drivers/iommu/amd_iommu_types.h
@@ -468,7 +468,6 @@ struct protection_domain {
 	struct iommu_domain domain; /* generic domain handle used by
 				       iommu core code */
 	spinlock_t lock;	/* mostly used to lock the page table*/
-	struct mutex api_lock;	/* protect page tables in the iommu-api path */
 	u16 id;			/* the domain id written to the device table */
 	int mode;		/* paging mode (0-6 levels) */
 	u64 *pt_root;		/* page table root pointer */
-- 
2.20.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
