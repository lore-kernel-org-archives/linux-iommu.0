Return-Path: <SRS0=kZfo=MF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC348C07E96
	for <iommu@archiver.kernel.org>; Tue, 13 Jul 2021 08:47:30 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD68660725
	for <iommu@archiver.kernel.org>; Tue, 13 Jul 2021 08:47:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD68660725
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 84AE5400FE;
	Tue, 13 Jul 2021 08:47:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id a7mi4cU6zVWO; Tue, 13 Jul 2021 08:47:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 6D89E401C7;
	Tue, 13 Jul 2021 08:47:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5729CC001A;
	Tue, 13 Jul 2021 08:47:29 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B3B59C000E
 for <iommu@lists.linux-foundation.org>; Tue, 13 Jul 2021 08:47:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9DC534045F
 for <iommu@lists.linux-foundation.org>; Tue, 13 Jul 2021 08:47:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lc7loZHdWlQr for <iommu@lists.linux-foundation.org>;
 Tue, 13 Jul 2021 08:47:27 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com
 [IPv6:2607:f8b0:4864:20::52b])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 10791400FE
 for <iommu@lists.linux-foundation.org>; Tue, 13 Jul 2021 08:47:27 +0000 (UTC)
Received: by mail-pg1-x52b.google.com with SMTP id d12so20981521pgd.9
 for <iommu@lists.linux-foundation.org>; Tue, 13 Jul 2021 01:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=omwDqSVrMraB8zPCmbagpNybYhuwUgLxPSaQSPVKs0I=;
 b=NFS9sf7oZs6OfC3ePyWxWOFYPRWYuHJEmSuowU4+A/AN9SkO5oklzsdY2KXu8XLaK/
 RtjCDzBNyMsdIgaq+gdMB7X3iSEzGHSn43PT3yYRI1O50eXo3lcMJohxW+FjS73Fgzhz
 cByWfSfvdlPZnHSM2paax8FVHByTKAKS59DKXws2obexLNMYBSz4JwJpnlbAFJbXemnl
 muonmUyFpQcCa6tNLtEtmhQrzdudI5qv9lDhSdlcAC7ix0U02RmFBKcz7hR6i8/sr/Il
 miY9BiEVBFNOzq9HdHWN3Ltqrr/qolEO7tzr92l33+PTeqr/Mh3jyfO+z8sDGyszPXwg
 lRGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=omwDqSVrMraB8zPCmbagpNybYhuwUgLxPSaQSPVKs0I=;
 b=Tpi0YySmB+pZdaZrR3Cdk45nerElbsT/5Vwp1OYUouUHPRb7E+qYPDLgfOAa5XNNIO
 iiwpsyvTnyfHm2QLQlTcKHAVC7kqZGjQRaEfK5Ioz6JE4LRiTCCSynigcxdNyctPRMQw
 rF+D0j2JwNuJx1EUm6vrIX2qkzEZv4JUt4pR4nY6ashEdolCWyBxGF0Bme3u+Pmg43BO
 zAC2oQV8b6u7Rlx3+QzbFMRKVUOwsaTeiObrxbdE+4qzn1nJIi4LvGk3kVHGvh+l5n2L
 94JgPHDtDLsOZ3bg7JsyIFW0aDehRvMyvfKvIXhMpYdrqkYnswTKVQBVT2K78XDTxkR1
 xA/g==
X-Gm-Message-State: AOAM532PfGyWavwRGhbb2rVEJaeAIAg+Ix4c59N0hK+VFCc1i31yWIoR
 OpQ7z1/oN60AUPEuR2fbLbMR
X-Google-Smtp-Source: ABdhPJy1XC0KnBeCN6bWa8CB2iE99dOa7TYAMnl/f4lHXuMSNKXTJU6n9g1wg0BApWWsX8PXSpPEXw==
X-Received: by 2002:a63:1266:: with SMTP id 38mr3331831pgs.154.1626166046577; 
 Tue, 13 Jul 2021 01:47:26 -0700 (PDT)
Received: from localhost ([139.177.225.253])
 by smtp.gmail.com with ESMTPSA id j21sm18231301pfn.35.2021.07.13.01.47.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jul 2021 01:47:26 -0700 (PDT)
From: Xie Yongji <xieyongji@bytedance.com>
To: mst@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
 sgarzare@redhat.com, parav@nvidia.com, hch@infradead.org,
 christian.brauner@canonical.com, rdunlap@infradead.org,
 willy@infradead.org, viro@zeniv.linux.org.uk, axboe@kernel.dk,
 bcrl@kvack.org, corbet@lwn.net, mika.penttila@nextfour.com,
 dan.carpenter@oracle.com, joro@8bytes.org, gregkh@linuxfoundation.org,
 zhe.he@windriver.com, xiaodong.liu@intel.com
Subject: [PATCH v9 01/17] iova: Export alloc_iova_fast() and free_iova_fast()
Date: Tue, 13 Jul 2021 16:46:40 +0800
Message-Id: <20210713084656.232-2-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210713084656.232-1-xieyongji@bytedance.com>
References: <20210713084656.232-1-xieyongji@bytedance.com>
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
some modules can use it to improve iova allocation efficiency.

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
