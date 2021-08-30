Return-Path: <SRS0=sxdJ=NV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BD8FC432BE
	for <iommu@archiver.kernel.org>; Mon, 30 Aug 2021 14:22:06 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1695160E98
	for <iommu@archiver.kernel.org>; Mon, 30 Aug 2021 14:22:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1695160E98
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DBC5D607C0;
	Mon, 30 Aug 2021 14:22:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mX8sVfYt3iXl; Mon, 30 Aug 2021 14:22:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id C0172605E1;
	Mon, 30 Aug 2021 14:22:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 95151C000E;
	Mon, 30 Aug 2021 14:22:01 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 16392C001A
 for <iommu@lists.linux-foundation.org>; Mon, 30 Aug 2021 14:22:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id EB4EF403CE
 for <iommu@lists.linux-foundation.org>; Mon, 30 Aug 2021 14:21:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LqO3Vtqc6wwF for <iommu@lists.linux-foundation.org>;
 Mon, 30 Aug 2021 14:21:58 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com
 [IPv6:2607:f8b0:4864:20::433])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6AE77403C3
 for <iommu@lists.linux-foundation.org>; Mon, 30 Aug 2021 14:21:58 +0000 (UTC)
Received: by mail-pf1-x433.google.com with SMTP id 2so12308096pfo.8
 for <iommu@lists.linux-foundation.org>; Mon, 30 Aug 2021 07:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=9VYKP4BtY52G/QfxOL4ci9LsSwqIuUiAxga6ojIUWhM=;
 b=rX/n04t3hwSmIEK5sY0o788rpIpjsNj/ric5w+RL9Y5fd/jrKYfgCowq9OT4EPJXpk
 WSehnR/Xk3PPjq51bpOHzx0/XcgTsukhRVdAIRbRcmIJAPf8qutfloXIY/3jQ53FkcVL
 uwGwFmQP21tYDGlvAxMdHr7T41mY372Mjmfup9xPngYq8Z43+grlgY7MS7s1iD4/p0Te
 +8mY7L2idpk4uVCt/dNg0r1w6tzsrVR+1eRlwcIdxQ3ekrh6djsf+qArQ9r5h2HE9vv5
 jsSLq/DZd1qxkCzIjIlZR4dqRACGMiEOp+BtamDSNL5nugEl97bDkHPo0M8LPanXAhNC
 JTmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=9VYKP4BtY52G/QfxOL4ci9LsSwqIuUiAxga6ojIUWhM=;
 b=UOzmLyBMqnLCYoi1TC2DQPbHzR6ZFYMyDr0yGmSVR0+XWdh1WFjz/PTq4TJr98iRid
 0ejLvvERPgn/diVQSDq6Nu7Ea3vxNAv/oe7uJyMYQNpmTZ+JYTN2obTgfb0iUM2ePZ+k
 shRCxfbpNZ1MA+mNhXdsYm5wrgphh7cwhy7q/7jH9x4bS4wZ+QYvwfAPeuzF8RcXBDp8
 siBeb3twbJKD/ysDRfRjgwNnHPYNJ10tv2NbMxBLE50cDBxGjDEjyFvdBjmv6VGPFCtq
 pjAaLRik1Dmr8rgv4WFch6K0ul/eP+f7f3K/gOSRZNPjuoO3VvqUFeViBV4xHq3j+kLW
 +tdw==
X-Gm-Message-State: AOAM5311ZXyCWtPMzLUkwYSFJKIDXsoIP3XsGZptFd7RwoDkzDy/zd5e
 l6Rzm4wCLDtdquTxxSRvXcSQ
X-Google-Smtp-Source: ABdhPJxsbkcgJHKC9l8Nzp6aGuWpGOLQSR5SX63hdPPAsp+Np9TJgCk3tFS4YemV8vWYWRm1YrsWxw==
X-Received: by 2002:a63:4cd:: with SMTP id 196mr22087854pge.239.1630333317896; 
 Mon, 30 Aug 2021 07:21:57 -0700 (PDT)
Received: from localhost ([139.177.225.237])
 by smtp.gmail.com with ESMTPSA id gc20sm10539505pjb.17.2021.08.30.07.21.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Aug 2021 07:21:57 -0700 (PDT)
From: Xie Yongji <xieyongji@bytedance.com>
To: mst@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
 sgarzare@redhat.com, parav@nvidia.com, hch@infradead.org,
 christian.brauner@canonical.com, rdunlap@infradead.org,
 willy@infradead.org, viro@zeniv.linux.org.uk, axboe@kernel.dk,
 bcrl@kvack.org, corbet@lwn.net, mika.penttila@nextfour.com,
 dan.carpenter@oracle.com, joro@8bytes.org, gregkh@linuxfoundation.org,
 zhe.he@windriver.com, xiaodong.liu@intel.com, joe@perches.com,
 robin.murphy@arm.com, will@kernel.org, john.garry@huawei.com
Subject: [PATCH v12 01/13] iova: Export alloc_iova_fast() and free_iova_fast()
Date: Mon, 30 Aug 2021 22:17:25 +0800
Message-Id: <20210830141737.181-2-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210830141737.181-1-xieyongji@bytedance.com>
References: <20210830141737.181-1-xieyongji@bytedance.com>
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
Acked-by: Jason Wang <jasowang@redhat.com>
Acked-by: Will Deacon <will@kernel.org>
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
