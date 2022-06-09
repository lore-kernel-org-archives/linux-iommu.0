Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DED05C43334
	for <iommu@archiver.kernel.org>; Thu,  9 Jun 2022 17:04:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8438460F68;
	Thu,  9 Jun 2022 17:04:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JlK_D_D9yIyo; Thu,  9 Jun 2022 17:04:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id E42AC60F5C;
	Thu,  9 Jun 2022 17:04:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C4FD1C0039;
	Thu,  9 Jun 2022 17:04:26 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9E7B9C002D
 for <iommu@lists.linux-foundation.org>; Thu,  9 Jun 2022 17:04:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 87AA683478
 for <iommu@lists.linux-foundation.org>; Thu,  9 Jun 2022 17:04:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BxUci6WmSOuf for <iommu@lists.linux-foundation.org>;
 Thu,  9 Jun 2022 17:04:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 53CC1828F2
 for <iommu@lists.linux-foundation.org>; Thu,  9 Jun 2022 17:04:19 +0000 (UTC)
X-UUID: ea919fc6e7ff46d1ae53f09593b12f95-20220610
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.5, REQID:f3b7cb63-8a22-4c1f-aa9b-47610791aa59, OB:0,
 LO
 B:0,IP:0,URL:5,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
 ON:release,TS:5
X-CID-META: VersionHash:2a19b09, CLOUDID:da00d37e-c8dc-403a-96e8-6237210dceee,
 C
 OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:1,File:nil
 ,QS:0,BEC:nil
X-UUID: ea919fc6e7ff46d1ae53f09593b12f95-20220610
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by
 mailgw01.mediatek.com (envelope-from <miles.chen@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1294950020; Fri, 10 Jun 2022 01:04:13 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Fri, 10 Jun 2022 01:04:12 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Fri, 10 Jun 2022 01:04:12 +0800
To: <yf.wang@mediatek.com>
Subject: Re: [PATCH] iommu/dma: Fix race condition during iova_domain
 initialization
Date: Fri, 10 Jun 2022 01:04:12 +0800
Message-ID: <20220609170412.30690-1-miles.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220530120748.31733-1-yf.wang@mediatek.com>
References: <20220530120748.31733-1-yf.wang@mediatek.com>
MIME-Version: 1.0
X-MTK: N
Cc: miles.chen@mediatek.com, wsd_upstream@mediatek.com,
 linux-kernel@vger.kernel.org, Libo.Kang@mediatek.com,
 iommu@lists.linux-foundation.org, linux-mediatek@lists.infradead.org,
 ning.li@mediatek.com, matthias.bgg@gmail.com, will@kernel.org,
 linux-arm-kernel@lists.infradead.org
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
From: Miles Chen via iommu <iommu@lists.linux-foundation.org>
Reply-To: Miles Chen <miles.chen@mediatek.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Hi YF,

>When many devices share the same iova domain, iommu_dma_init_domain()
>may be called at the same time. The checking of iovad->start_pfn will
>all get false in iommu_dma_init_domain() and both enter init_iova_domain()
>to do iovad initialization.

After reading this patch.
It means that we use iovad->start_pfn as a key to tell if an iovad is already initialized,
but we do not protect iovad->start_pfn from concurrent access.

So what's happening is like:

   cpu0                                    cpu1
of_dma_configure_id()              of_dma_configure_id()
  arch_setup_dma_ops()               arch_setup_dma_ops()
    iommu_setup_dma_ops()              iommu_setup_dma_ops()
      init_iova_domain()	 	 init_iova_domain()
         if (iovad->start_pfn) {           if (iovad->start_pfn) {
         }                                 }
         init_iova_domain()                init_iova_domain()


init_iova_domain() is called at the same time.

>Fix this by protecting init_iova_domain() with iommu_dma_cookie->mutex.

Reviewed-by: Miles Chen <miles.chen@mediatek.com> 

>Exception backtrace:
>rb_insert_color(param1=0xFFFFFF80CD2BDB40, param3=1) + 64
>init_iova_domain() + 180
>iommu_setup_dma_ops() + 260
>arch_setup_dma_ops() + 132
>of_dma_configure_id() + 468
>platform_dma_configure() + 32
>really_probe() + 1168
>driver_probe_device() + 268
>__device_attach_driver() + 524
>__device_attach() + 524
>bus_probe_device() + 64
>deferred_probe_work_func() + 260
>process_one_work() + 580
>worker_thread() + 1076
>kthread() + 332
>ret_from_fork() + 16
>
>Signed-off-by: Ning Li <ning.li@mediatek.com>
>Signed-off-by: Yunfei Wang <yf.wang@mediatek.com>
>---
> drivers/iommu/dma-iommu.c | 17 +++++++++++++----
> 1 file changed, 13 insertions(+), 4 deletions(-)
>
>diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
>index 09f6e1c0f9c0..b38c5041eeab 100644
>--- a/drivers/iommu/dma-iommu.c
>+++ b/drivers/iommu/dma-iommu.c
>@@ -63,6 +63,7 @@ struct iommu_dma_cookie {
> 
> 	/* Domain for flush queue callback; NULL if flush queue not in use */
> 	struct iommu_domain		*fq_domain;
>+	struct mutex			mutex;
> };
> 
> static DEFINE_STATIC_KEY_FALSE(iommu_deferred_attach_enabled);
>@@ -309,6 +310,7 @@ int iommu_get_dma_cookie(struct iommu_domain *domain)
> 	if (!domain->iova_cookie)
> 		return -ENOMEM;
> 
>+	mutex_init(&domain->iova_cookie->mutex);
> 	return 0;
> }
> 
>@@ -549,26 +551,33 @@ static int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base,
> 	}
> 
> 	/* start_pfn is always nonzero for an already-initialised domain */
>+	mutex_lock(&cookie->mutex);
>
> 	if (iovad->start_pfn) {
> 		if (1UL << order != iovad->granule ||
> 		    base_pfn != iovad->start_pfn) {
> 			pr_warn("Incompatible range for DMA domain\n");
>-			return -EFAULT;
>+			ret = -EFAULT;
>+			goto done_unlock;
> 		}
> 
>-		return 0;
>+		ret = 0;
>+		goto done_unlock;
> 	}
> 
> 	init_iova_domain(iovad, 1UL << order, base_pfn);
> 	ret = iova_domain_init_rcaches(iovad);
> 	if (ret)
>-		return ret;
>+		goto done_unlock;
> 
> 	/* If the FQ fails we can simply fall back to strict mode */
> 	if (domain->type == IOMMU_DOMAIN_DMA_FQ && iommu_dma_init_fq(domain))
> 		domain->type = IOMMU_DOMAIN_DMA;
> 
>-	return iova_reserve_iommu_regions(dev, domain);
>+	ret = iova_reserve_iommu_regions(dev, domain);
>+
>+done_unlock:
>+	mutex_unlock(&cookie->mutex);
>+	return ret;
> }
> 
> /**
>-- 
>2.18.0
>
>
>_______________________________________________
>Linux-mediatek mailing list
>Linux-mediatek@lists.infradead.org
>http://lists.infradead.org/mailman/listinfo/linux-mediatek
>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
