Return-Path: <SRS0=dGrv=MV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67355C4320A
	for <iommu@archiver.kernel.org>; Thu, 29 Jul 2021 07:36:11 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1179A61074
	for <iommu@archiver.kernel.org>; Thu, 29 Jul 2021 07:36:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1179A61074
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D6BA68355C;
	Thu, 29 Jul 2021 07:36:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cCC0_aAdu7m4; Thu, 29 Jul 2021 07:36:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id D290883546;
	Thu, 29 Jul 2021 07:36:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BD770C0010;
	Thu, 29 Jul 2021 07:36:07 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C23D8C000E
 for <iommu@lists.linux-foundation.org>; Thu, 29 Jul 2021 07:36:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A461D40500
 for <iommu@lists.linux-foundation.org>; Thu, 29 Jul 2021 07:36:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id u83Jrbe-st4c for <iommu@lists.linux-foundation.org>;
 Thu, 29 Jul 2021 07:36:03 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com
 [IPv6:2607:f8b0:4864:20::102b])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C089D40315
 for <iommu@lists.linux-foundation.org>; Thu, 29 Jul 2021 07:36:03 +0000 (UTC)
Received: by mail-pj1-x102b.google.com with SMTP id
 e2-20020a17090a4a02b029016f3020d867so7997885pjh.3
 for <iommu@lists.linux-foundation.org>; Thu, 29 Jul 2021 00:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=omwDqSVrMraB8zPCmbagpNybYhuwUgLxPSaQSPVKs0I=;
 b=naBlQMPkB/0DkelUJr1LWVocrdIW6Peexm/f7/BA/529HP7dXnwA1mEQRpxsTu/nyt
 5tSNHUAPj0I23nUM3cEaLX7W0FcfFZ/nIw/hTE0AbmJOLKU6x4Our6Q4VO6WxlOJJCEK
 v75eCTZ2rkY4QZ4y+7yLjNGET7/dDbliCxmVK70acQ5r5hI7NYOBP6q5q2H55CRB27Yw
 JgDWvRBoG8Q2BXzdSiM0/OI45aNpXQyYEVdGOMn/e2B4DUPsbSxolGo9ZcFYLJ9z3d2g
 n1NF1lN2f4dqSTn2d4cGD5EJW0DwNvhKakHLHdWUFAi1yGntoi8qBSZfWJo845VSX0hW
 z1jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=omwDqSVrMraB8zPCmbagpNybYhuwUgLxPSaQSPVKs0I=;
 b=kUdtYpsuKDuBm3WmRrGZRs8u+IQVh9+Ez0PXnNTHrC70c87j4OJJ8lLnVcHMnJmRaa
 1F2IRGIi+4QnPVG1Yj4i4Au8pNOAyGf5mz4oIIF8Sd/KqQYJaFxdNX1wn6I4hE7WKz9r
 ZEgw5QDx3Xj/mAXqjYpIVslurt3ud46EXIFi3HMrtA/zLK0fGIueLNd53QZ4r7yXn2bK
 EIJ/9Rd05aOBv9FFkw1g8C4P3bpNVg8Ivy6H/qSFoXjKx/FF3Vg60blKTztTiHoHJTF8
 PBmwt4Qn6mCkK53+N9DLtRO5kZuht4zj5ejfeTE5yUnlkyVgvG0xNY8LdcoDKbu1MZ9Y
 vt6A==
X-Gm-Message-State: AOAM532FSuu6SwuZr8vC5ruqMd16NLSTJoPlaS6zWHgG+yexi0rP4BLu
 /k7bopnPir1RZCGk+eE4ILfD
X-Google-Smtp-Source: ABdhPJxHbuy/f6Ntcbrd8G6sqB1/UuTPykG+LdmRwbmQ8qaXm3ieni6kdT8Dl8Ys4/OxQN2NjqkIeA==
X-Received: by 2002:aa7:9a4e:0:b029:32b:34a7:2e4e with SMTP id
 x14-20020aa79a4e0000b029032b34a72e4emr3941364pfj.20.1627544163282; 
 Thu, 29 Jul 2021 00:36:03 -0700 (PDT)
Received: from localhost ([139.177.225.253])
 by smtp.gmail.com with ESMTPSA id k198sm2457702pfd.148.2021.07.29.00.36.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jul 2021 00:36:02 -0700 (PDT)
From: Xie Yongji <xieyongji@bytedance.com>
To: mst@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
 sgarzare@redhat.com, parav@nvidia.com, hch@infradead.org,
 christian.brauner@canonical.com, rdunlap@infradead.org,
 willy@infradead.org, viro@zeniv.linux.org.uk, axboe@kernel.dk,
 bcrl@kvack.org, corbet@lwn.net, mika.penttila@nextfour.com,
 dan.carpenter@oracle.com, joro@8bytes.org, gregkh@linuxfoundation.org,
 zhe.he@windriver.com, xiaodong.liu@intel.com, joe@perches.com
Subject: [PATCH v10 01/17] iova: Export alloc_iova_fast() and free_iova_fast()
Date: Thu, 29 Jul 2021 15:34:47 +0800
Message-Id: <20210729073503.187-2-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210729073503.187-1-xieyongji@bytedance.com>
References: <20210729073503.187-1-xieyongji@bytedance.com>
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
