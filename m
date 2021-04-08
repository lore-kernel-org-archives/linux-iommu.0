Return-Path: <SRS0=d8dU=JF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45ACBC433B4
	for <iommu@archiver.kernel.org>; Thu,  8 Apr 2021 09:44:43 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4C4961178
	for <iommu@archiver.kernel.org>; Thu,  8 Apr 2021 09:44:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4C4961178
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7EB5484CB4;
	Thu,  8 Apr 2021 09:44:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fpjFsCgZOKSI; Thu,  8 Apr 2021 09:44:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5986384C9C;
	Thu,  8 Apr 2021 09:44:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3F144C000B;
	Thu,  8 Apr 2021 09:44:41 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8BF96C000A
 for <iommu@lists.linux-foundation.org>; Thu,  8 Apr 2021 09:44:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6D6464191C
 for <iommu@lists.linux-foundation.org>; Thu,  8 Apr 2021 09:44:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IeaxCl_XDlSt for <iommu@lists.linux-foundation.org>;
 Thu,  8 Apr 2021 09:44:38 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com
 [IPv6:2607:f8b0:4864:20::102b])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 45C744191B
 for <iommu@lists.linux-foundation.org>; Thu,  8 Apr 2021 09:44:38 +0000 (UTC)
Received: by mail-pj1-x102b.google.com with SMTP id
 il9-20020a17090b1649b0290114bcb0d6c2so2864055pjb.0
 for <iommu@lists.linux-foundation.org>; Thu, 08 Apr 2021 02:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=w0yqOdK8TBIxTW5Ne7zhHMEvG5YRSgyD3ci2CbuX1Ko=;
 b=pHOLGF3r/chGXK0P6mFv3kNaPTdxQbCMF1E4ZKSOPtLEIAP7yDW7n1MZsex/JMuAsA
 sW84iwhTNe023cGfCYgknO68RlmliNDx1GtLrBJ0TjDJsd9f4aFOHnqDvKELaMSZd6mZ
 Bsj3LYpvL/EJk9c7eUIgYNC5Urk16VI+jb8XgaFwiOw2zodMCGcia+kSm5eA5Bu4w2+d
 lzZ2sc/jfJ24ccdSucWLBtd9NNAkRbNA3yMvWKEEy8X23G+8FVl9Xn551rmMO8uKBnaX
 e5kb9MChPY29OHIhd33YHpkKwPU4k7PwJHsot1vrkz4gTHrBKySEUKNtZVcPCjORZreH
 zokg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=w0yqOdK8TBIxTW5Ne7zhHMEvG5YRSgyD3ci2CbuX1Ko=;
 b=eQs8jBmFRLR+dcIp/KLDF7X2Bu0EhMSICcVm29j7QKI3zrSxBt7D92iyHyloZ+58qE
 bez7cgXlcBdHMn7Y6jAmn9YnKgPpUTiT0TCP97c53zA1RX3U/xCX4GuUe40DxTtqAXnq
 T/uqS6LbxAFOqsZsS0O/dIQ4+EozrIT0c4HTwubf9YzOyQyzO014KAaA0WxwqD/uNp0q
 rkoMCV8LSDSofV02HQhkfxe1ah6FbOZ6d10zyusuvRuguI7mlMUyuVLj2G6MOhRVUSlJ
 GHHRLGeeHSWs0EMizitxUBxsYkTDFsc9TC0yXzdn6U9kfRU+UqOXwPGBLZqEutpMXxWl
 8rbQ==
X-Gm-Message-State: AOAM530IxtDzOk4HIHMLaYbed3fDSKr6FjvdR62AGLausPltd6yqYRau
 U9ltQXJUanvrW1xhzopftZo=
X-Google-Smtp-Source: ABdhPJyThhKs3YsHYUCK2VFV5t62Dyf3WEmdRWyX2YlXwLsJGlE7MZkHGU/FUqEkoU00wPLzrjBP7g==
X-Received: by 2002:a17:90a:8813:: with SMTP id
 s19mr7340659pjn.94.1617875077668; 
 Thu, 08 Apr 2021 02:44:37 -0700 (PDT)
Received: from Asurada-Nvidia (thunderhill.nvidia.com. [216.228.112.22])
 by smtp.gmail.com with ESMTPSA id q2sm4269469pfh.65.2021.04.08.02.44.36
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 08 Apr 2021 02:44:37 -0700 (PDT)
Date: Thu, 8 Apr 2021 02:42:42 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Dmitry Osipenko <digetx@gmail.com>
Subject: Re: [PATCH v1 1/2] iommu/tegra-smmu: Defer attachment of display
 clients
Message-ID: <20210408094241.GA31714@Asurada-Nvidia>
References: <20210328233256.20494-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="OgqxwSJOaUobr8KG"
Content-Disposition: inline
In-Reply-To: <20210328233256.20494-1-digetx@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Thierry Reding <thierry.reding@gmail.com>, linux-tegra@vger.kernel.org,
 Will Deacon <will@kernel.org>
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
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 29, 2021 at 02:32:55AM +0300, Dmitry Osipenko wrote:
> All consumer-grade Android and Chromebook devices show a splash screen
> on boot and then display is left enabled when kernel is booted. This
> behaviour is unacceptable in a case of implicit IOMMU domains to which
> devices are attached during kernel boot since devices, like display
> controller, may perform DMA at that time. We can work around this problem
> by deferring the enable of SMMU translation for a specific devices,
> like a display controller, until the first IOMMU mapping is created,
> which works good enough in practice because by that time h/w is already
> stopped.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>

For both patches:
Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
Tested-by: Nicolin Chen <nicoleotsuka@gmail.com>

The WAR looks good to me. Perhaps Thierry would give some input.

Another topic:
I think this may help work around the mc-errors, which we have
been facing on Tegra210 also when we enable IOMMU_DOMAIN_DMA.
(attached a test patch rebasing on these two)

However, GPU would also report errors using DMA domain:

 nouveau 57000000.gpu: acr: firmware unavailable
 nouveau 57000000.gpu: pmu: firmware unavailable
 nouveau 57000000.gpu: gr: firmware unavailable
 tegra-mc 70019000.memory-controller: gpusrd: read @0x00000000fffbe200: Security violation (TrustZone violation)
 nouveau 57000000.gpu: DRM: failed to create kernel channel, -22
 tegra-mc 70019000.memory-controller: gpusrd: read @0x00000000fffad000: Security violation (TrustZone violation)
 nouveau 57000000.gpu: fifo: SCHED_ERROR 20 []
 nouveau 57000000.gpu: fifo: SCHED_ERROR 20 []

Looking at the address, seems that GPU allocated memory in 32-bit
physical address space behind SMMU, so a violation happened after
turning on DMA domain I guess... 

--OgqxwSJOaUobr8KG
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="dma_domain.patch"

From 20b58a74fee0c7b961b92f9118ad69a12199e6a5 Mon Sep 17 00:00:00 2001
From: Nicolin Chen <nicolinc@nvidia.com>
Date: Thu, 12 Dec 2019 17:46:50 -0800
Subject: [PATCH 6/7] iommu/tegra-smmu: Add IOMMU_DOMAIN_DMA

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/tegra-smmu.c | 39 ++++++++++++++++++++++----------------
 1 file changed, 23 insertions(+), 16 deletions(-)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index 8104f001e679..eff10d1ec568 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -15,6 +15,7 @@
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/dma-mapping.h>
+#include <linux/dma-iommu.h>
 
 #include <soc/tegra/ahb.h>
 #include <soc/tegra/mc.h>
@@ -297,35 +298,29 @@ static struct iommu_domain *tegra_smmu_domain_alloc(unsigned type)
 {
 	struct tegra_smmu_as *as;
 
-	if (type != IOMMU_DOMAIN_UNMANAGED)
+	if (type != IOMMU_DOMAIN_UNMANAGED && type != IOMMU_DOMAIN_DMA)
 		return NULL;
 
 	as = kzalloc(sizeof(*as), GFP_KERNEL);
 	if (!as)
 		return NULL;
 
+	if (type == IOMMU_DOMAIN_DMA && iommu_get_dma_cookie(&as->domain))
+		goto free_as;
+
 	as->attr = SMMU_PD_READABLE | SMMU_PD_WRITABLE | SMMU_PD_NONSECURE;
 
 	as->pd = alloc_page(GFP_KERNEL | __GFP_DMA | __GFP_ZERO);
-	if (!as->pd) {
-		kfree(as);
-		return NULL;
-	}
+	if (!as->pd)
+		goto put_dma_cookie;
 
 	as->count = kcalloc(SMMU_NUM_PDE, sizeof(u32), GFP_KERNEL);
-	if (!as->count) {
-		__free_page(as->pd);
-		kfree(as);
-		return NULL;
-	}
+	if (!as->count)
+		goto free_pd_range;
 
 	as->pts = kcalloc(SMMU_NUM_PDE, sizeof(*as->pts), GFP_KERNEL);
-	if (!as->pts) {
-		kfree(as->count);
-		__free_page(as->pd);
-		kfree(as);
-		return NULL;
-	}
+	if (!as->pts)
+		goto free_pts;
 
 	spin_lock_init(&as->lock);
 
@@ -335,6 +330,17 @@ static struct iommu_domain *tegra_smmu_domain_alloc(unsigned type)
 	as->attached_devices_need_sync = true;
 
 	return &as->domain;
+
+free_pts:
+	kfree(as->pts);
+free_pd_range:
+	__free_page(as->pd);
+put_dma_cookie:
+	iommu_put_dma_cookie(&as->domain);
+free_as:
+	kfree(as);
+
+	return NULL;
 }
 
 static void tegra_smmu_domain_free(struct iommu_domain *domain)
@@ -346,6 +352,7 @@ static void tegra_smmu_domain_free(struct iommu_domain *domain)
 	WARN_ON_ONCE(as->use_count);
 	kfree(as->count);
 	kfree(as->pts);
+	iommu_put_dma_cookie(domain);
 	kfree(as);
 }
 
-- 
2.17.1


--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--OgqxwSJOaUobr8KG--
