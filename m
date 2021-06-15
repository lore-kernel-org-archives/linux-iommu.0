Return-Path: <SRS0=7V87=LJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE4A6C48BDF
	for <iommu@archiver.kernel.org>; Tue, 15 Jun 2021 14:14:06 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6414B61450
	for <iommu@archiver.kernel.org>; Tue, 15 Jun 2021 14:14:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6414B61450
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 353066088F;
	Tue, 15 Jun 2021 14:14:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZVp3ev46_xpw; Tue, 15 Jun 2021 14:14:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 5E608607C9;
	Tue, 15 Jun 2021 14:14:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3B10AC000E;
	Tue, 15 Jun 2021 14:14:04 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0455EC0022
 for <iommu@lists.linux-foundation.org>; Tue, 15 Jun 2021 14:14:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C3CEB40134
 for <iommu@lists.linux-foundation.org>; Tue, 15 Jun 2021 14:14:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kQqRBYlMzAHo for <iommu@lists.linux-foundation.org>;
 Tue, 15 Jun 2021 14:13:58 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com
 [IPv6:2607:f8b0:4864:20::1034])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 32C60402EF
 for <iommu@lists.linux-foundation.org>; Tue, 15 Jun 2021 14:13:58 +0000 (UTC)
Received: by mail-pj1-x1034.google.com with SMTP id
 k22-20020a17090aef16b0290163512accedso1890409pjz.0
 for <iommu@lists.linux-foundation.org>; Tue, 15 Jun 2021 07:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=uqLi4n/sYt1V7zlXO7PEWrtyAjrct3aaeB0JWe6pldc=;
 b=hdxih8MIuJMG7DQ8ZmQrXh42xZ0vXefzPJ9Is4yeGeXwK9ruXKC6EBFn8DHqD+qX4B
 mXWvCicjq9IAlBh5wT9cKgIXtBv2V1Jt8Ml734PbO5KZR6ZfwAOwp2HqEzKJFVZ6LEjc
 jpr3DR3C7jV6q+xycSeDEyiUG5tdTsrQyhBszjQhllpSC6ihPrnYO3rbVtT0URaBUp8J
 Cbzhv1Hxb4BR27Ug0G/lD303gI6VNhL+3mm6r0pj60g/Lc5g3jB3iCJcKlWZyawmvu9X
 Mql527KcPIDMqPFgJV5a0yXFc8HVrjnBAmxl4aFB4nfYUtPTjOuU1i+1kYhrIB4V+EUy
 44+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=uqLi4n/sYt1V7zlXO7PEWrtyAjrct3aaeB0JWe6pldc=;
 b=AMQPa7cg8DOv4+zj+htTZxuZ3te1RFe7JHBHQJb+CBYV4h9loiJ2932ylZDB9XfPog
 IO59NgLz+3IAGiqlBfnasVd//cSgZawcRwCmyPgxJQ60FHyIsfU2NwJAwLqSbYwyjaLa
 vY3sx6RaqPmY65+EYyleSfdoNIqJ7H+IcX840OsBDRKMHo1C6FL/EZWJgDxFOnRPZfnq
 ZEPClU+TKvGjLBHupZiPJPH0IEtamUfl/Qwlh0BZpLhQgxCiB07vzmfWFYZa1L2MIxML
 AgbPiQva6NKrKnrwCRv3FsXTlFuUTYloqvxIWE9Wi83lisWtV7jvjZ/RjgoJDFPBojJS
 zlEw==
X-Gm-Message-State: AOAM5316a0cbcKxYU6kULjh6S2dLu9vckjMlcXTAb3QoRrw4hJZebBnj
 UXkvnL7owACqnr/u63lIBUeQ
X-Google-Smtp-Source: ABdhPJwxO854wUtIh12JMTHVMysUOJZdmysPCLLcn5itcs7UedE9FRLaM9NJQ6d/dAmz1Dc2dO9hng==
X-Received: by 2002:a17:903:152:b029:10f:f6f7:ede5 with SMTP id
 r18-20020a1709030152b029010ff6f7ede5mr4636909plc.20.1623766437651; 
 Tue, 15 Jun 2021 07:13:57 -0700 (PDT)
Received: from localhost ([139.177.225.241])
 by smtp.gmail.com with ESMTPSA id t14sm17322236pgm.9.2021.06.15.07.13.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Jun 2021 07:13:57 -0700 (PDT)
From: Xie Yongji <xieyongji@bytedance.com>
To: mst@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
 sgarzare@redhat.com, parav@nvidia.com, hch@infradead.org,
 christian.brauner@canonical.com, rdunlap@infradead.org,
 willy@infradead.org, viro@zeniv.linux.org.uk, axboe@kernel.dk,
 bcrl@kvack.org, corbet@lwn.net, mika.penttila@nextfour.com,
 dan.carpenter@oracle.com, joro@8bytes.org, gregkh@linuxfoundation.org
Subject: [PATCH v8 01/10] iova: Export alloc_iova_fast() and free_iova_fast(); 
Date: Tue, 15 Jun 2021 22:13:22 +0800
Message-Id: <20210615141331.407-2-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210615141331.407-1-xieyongji@bytedance.com>
References: <20210615141331.407-1-xieyongji@bytedance.com>
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
index b7ecd5b08039..59916b4b7fe9 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -518,6 +518,7 @@ alloc_iova_fast(struct iova_domain *iovad, unsigned long size,
 
 	return new_iova->pfn_lo;
 }
+EXPORT_SYMBOL_GPL(alloc_iova_fast);
 
 /**
  * free_iova_fast - free iova pfn range into rcache
@@ -535,6 +536,7 @@ free_iova_fast(struct iova_domain *iovad, unsigned long pfn, unsigned long size)
 
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
