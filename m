Return-Path: <SRS0=NhDI=NJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 577B1C4320E
	for <iommu@archiver.kernel.org>; Wed, 18 Aug 2021 12:07:56 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1B4560EBC
	for <iommu@archiver.kernel.org>; Wed, 18 Aug 2021 12:07:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E1B4560EBC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9CAA14049D;
	Wed, 18 Aug 2021 12:07:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2zwiwIwvX5SF; Wed, 18 Aug 2021 12:07:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 70041401C7;
	Wed, 18 Aug 2021 12:07:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4AD17C001A;
	Wed, 18 Aug 2021 12:07:51 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3C167C000E
 for <iommu@lists.linux-foundation.org>; Wed, 18 Aug 2021 12:07:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1C4DE607E1
 for <iommu@lists.linux-foundation.org>; Wed, 18 Aug 2021 12:07:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tNNLgsaZmQjE for <iommu@lists.linux-foundation.org>;
 Wed, 18 Aug 2021 12:07:49 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com
 [IPv6:2607:f8b0:4864:20::1034])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 11A01606ED
 for <iommu@lists.linux-foundation.org>; Wed, 18 Aug 2021 12:07:49 +0000 (UTC)
Received: by mail-pj1-x1034.google.com with SMTP id oa17so2495893pjb.1
 for <iommu@lists.linux-foundation.org>; Wed, 18 Aug 2021 05:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=dPJJmxsVnbJuWsaYefx+5ABSk3S/ct0HfhPILPNJBeY=;
 b=Il0dp2rPVUCBMX9KFhOtzGkP3WKDoZ1ZKEgN6kb2agZ8E5jDQdBcduO5z6+043hYpd
 Ufi8v00bjhHrLaYO9v2rUWDcl6NeckWKR50ZAjIC4vGPqrrZlcIMPniKBTLz+M0Ac2wW
 lvt2CQw2pwEwtNNuWnZO45Lx2NonUj7axKrI0LbgxlcXYK2MJA/2Yj/CJqtxZihF5DCw
 5ze/wh02hcvuQ7d/Huk7Si32RAeQhRmnTq9PC//bqKcyMAfDvauBXt0nHLNbXlQDNDnQ
 4Dsqf33aSduXN3Dv/itwrQsG8YwGNPtTScyWKAk0xLEiH1aFKpXXhY26VsmpguruySKm
 AP3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=dPJJmxsVnbJuWsaYefx+5ABSk3S/ct0HfhPILPNJBeY=;
 b=ibeiXdojw58iaO63B6wipOfjMeeJY70VOX5fZGYkYTfIyTmT/7KoGKcUXBkVgU6bDW
 2RNPO91iy3VXYsZk0xUi4l5lC1jmLu0AtovqYKx1g/CKW/G6QxEI/q0Zv7fNumUzu5hY
 cnxTYdLHINLY+R6LTRU27MzDDO23mGXuxY0JiZNG3sURTHnt8QKS7J9qPqN0Ya9pg/Bv
 isswdmnbXfD2pFZ+GFow7+9x9QtYTj9+eteE+hkqUqi2xkY2h1Y+N33RZx90fhwlx5fE
 1N3/kLshwGRxdxzISy9sSgbGQ2rD3JP49THOEVKjs6uJPHJy2eWoXkPHHkI6zG0ieaJP
 tAsw==
X-Gm-Message-State: AOAM531KqabLUCYRAKp4L79tYwWBiCbAJ4MZzHlRb7QIE5w17C+P+AR0
 kDLMJ+T0wG04nvzZjOc0EKU/
X-Google-Smtp-Source: ABdhPJwcXSEuwzRnGhI2y+Q5IbLvbn5O9K+BcqEVJ6ubab8h4kSTKekrk2aFvZ2U2B+Ykcq6j6DPIA==
X-Received: by 2002:a17:90b:378c:: with SMTP id
 mz12mr8802850pjb.187.1629288468662; 
 Wed, 18 Aug 2021 05:07:48 -0700 (PDT)
Received: from localhost ([139.177.225.253])
 by smtp.gmail.com with ESMTPSA id c15sm5205386pjr.22.2021.08.18.05.07.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Aug 2021 05:07:48 -0700 (PDT)
From: Xie Yongji <xieyongji@bytedance.com>
To: mst@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
 sgarzare@redhat.com, parav@nvidia.com, hch@infradead.org,
 christian.brauner@canonical.com, rdunlap@infradead.org,
 willy@infradead.org, viro@zeniv.linux.org.uk, axboe@kernel.dk,
 bcrl@kvack.org, corbet@lwn.net, mika.penttila@nextfour.com,
 dan.carpenter@oracle.com, joro@8bytes.org, gregkh@linuxfoundation.org,
 zhe.he@windriver.com, xiaodong.liu@intel.com, joe@perches.com,
 robin.murphy@arm.com
Subject: [PATCH v11 01/12] iova: Export alloc_iova_fast() and free_iova_fast()
Date: Wed, 18 Aug 2021 20:06:31 +0800
Message-Id: <20210818120642.165-2-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210818120642.165-1-xieyongji@bytedance.com>
References: <20210818120642.165-1-xieyongji@bytedance.com>
MIME-Version: 1.0
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, iommu@lists.linux-foundation.org,
 songmuchun@bytedance.com, linux-fsdevel@vger.kernel.org
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

Export alloc_iova_fast() and free_iova_fast() so that
some modules can make use of the per-CPU cache to get
rid of rbtree spinlock in alloc_iova() and free_iova()
during IOVA allocation.

Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
---
 drivers/iommu/iova.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index b6cf5f16123b..3941ed6bb99b 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -521,6 +521,7 @@ alloc_iova_fast(struct iova_domain *iovad, unsigned long size,
 
 	return new_iova->pfn_lo;
 }
+EXPORT_SYMBOL_GPL(alloc_iova_fast);
 
 /**
  * free_iova_fast - free iova pfn range into rcache
@@ -538,6 +539,7 @@ free_iova_fast(struct iova_domain *iovad, unsigned long pfn, unsigned long size)
 
 	free_iova(iovad, pfn);
 }
+EXPORT_SYMBOL_GPL(free_iova_fast);
 
 #define fq_ring_for_each(i, fq) \
 	for ((i) = (fq)->head; (i) != (fq)->tail; (i) = ((i) + 1) % IOVA_FQ_SIZE)
-- 
2.11.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
