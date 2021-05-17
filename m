Return-Path: <SRS0=Mf8z=KM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 801EEC433B4
	for <iommu@archiver.kernel.org>; Mon, 17 May 2021 10:02:02 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26E746008E
	for <iommu@archiver.kernel.org>; Mon, 17 May 2021 10:02:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26E746008E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E0ED283C23;
	Mon, 17 May 2021 10:02:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZkAaRG0uHRaj; Mon, 17 May 2021 10:01:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id A94B483BFB;
	Mon, 17 May 2021 10:01:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 67003C0001;
	Mon, 17 May 2021 10:01:57 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 76C2FC000E
 for <iommu@lists.linux-foundation.org>; Mon, 17 May 2021 09:56:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 53B6560732
 for <iommu@lists.linux-foundation.org>; Mon, 17 May 2021 09:56:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hNkb8orwq9kO for <iommu@lists.linux-foundation.org>;
 Mon, 17 May 2021 09:56:00 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com
 [IPv6:2607:f8b0:4864:20::634])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CDE3C60680
 for <iommu@lists.linux-foundation.org>; Mon, 17 May 2021 09:56:00 +0000 (UTC)
Received: by mail-pl1-x634.google.com with SMTP id t4so2838333plc.6
 for <iommu@lists.linux-foundation.org>; Mon, 17 May 2021 02:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Ygd6Y3pMMIE3RUljThmAuE4r52Kqy5h8O2JQV7ru1VE=;
 b=CfGZ0PIMRYu4HZPQTqyHPr1YCzbRVLXIMfeN4edm7scYV+U9MYChU0jqbjBaSYww8W
 x34cC9/BMlqozDzEDG8ux9bhvujMR9dQUSals7Y5Q6Z1Ic9ux5H7kh6skw81G6vCSEuj
 qvAj7zfktNXLCd1rUIgxI87C26tOnzC7+pVGuD1g/0Lv5qn8oiSuf1+7+eWR6D+6V+Us
 mf1DA4vTKCekvwxQldEXP7DGoACUCXG3tr2GgElhChFw367kHCgwfpQSfxiMYchniS3x
 3QikwhZOKWcBciqgNHjjH9ktT79H4PFjZ9sUPr0lm6w4kGIx2J2u98pIhDIqi7lIhPpV
 gsYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Ygd6Y3pMMIE3RUljThmAuE4r52Kqy5h8O2JQV7ru1VE=;
 b=TIyJYBOsTU0j61XGnnY0zrcT831HINFI8yiCp9FkRFyIFpaRgDLrwX7jvRs1RjPve+
 1j2fi5cvi8XRY9zjehuJPYDeVsMPcJfs3+ZEdEBq43rcV9D1QXvXfGsaIwq4HgENNwWs
 2GPL6C6x0UkTHYwNrKugHVrSZHsq6JG3UXUDzjKZh4JAGZ/YT8EVd4YXiGgIwGkHjsXY
 MFPW86kxSzGZnmZOl40HdBZcm339c2WlikNY6TWZhSH0nzL91Maz7L6ziNaaa3M9swud
 OhzTYbTbD8k5b5SdRTGW4m1RA7ZY2I53mLX0qbmhSujkkKgZ2+tVgSD1iKPZT/WnMV1G
 CFuw==
X-Gm-Message-State: AOAM533nlv9mgfvBj28mZwa/pieb6wrvOm1mTFPk7sx5uLSpjO7W6EEg
 u+hy5nVsgSRN6LcYR+LlCp6D
X-Google-Smtp-Source: ABdhPJxcu8VbEVbQ6UidxIbU5FzeWTHg5acjJx2pdfr2qW4l4EQrVjPUuXEDDezt/Znh1VwtXb7+/w==
X-Received: by 2002:a17:90a:6c23:: with SMTP id
 x32mr30960965pjj.228.1621245360342; 
 Mon, 17 May 2021 02:56:00 -0700 (PDT)
Received: from localhost ([139.177.225.253])
 by smtp.gmail.com with ESMTPSA id q24sm10233373pjp.6.2021.05.17.02.55.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 May 2021 02:56:00 -0700 (PDT)
From: Xie Yongji <xieyongji@bytedance.com>
To: mst@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
 sgarzare@redhat.com, parav@nvidia.com, hch@infradead.org,
 christian.brauner@canonical.com, rdunlap@infradead.org,
 willy@infradead.org, viro@zeniv.linux.org.uk, axboe@kernel.dk,
 bcrl@kvack.org, corbet@lwn.net, mika.penttila@nextfour.com,
 dan.carpenter@oracle.com, joro@8bytes.org
Subject: [PATCH v7 01/12] iova: Export alloc_iova_fast()
Date: Mon, 17 May 2021 17:55:02 +0800
Message-Id: <20210517095513.850-2-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210517095513.850-1-xieyongji@bytedance.com>
References: <20210517095513.850-1-xieyongji@bytedance.com>
MIME-Version: 1.0
X-Mailman-Approved-At: Mon, 17 May 2021 10:01:55 +0000
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, iommu@lists.linux-foundation.org,
 linux-fsdevel@vger.kernel.org
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

Export alloc_iova_fast() so that some modules can use it
to improve iova allocation efficiency.

Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
---
 drivers/iommu/iova.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index e6e2fa85271c..317eef64ffef 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -450,6 +450,7 @@ alloc_iova_fast(struct iova_domain *iovad, unsigned long size,
 
 	return new_iova->pfn_lo;
 }
+EXPORT_SYMBOL_GPL(alloc_iova_fast);
 
 /**
  * free_iova_fast - free iova pfn range into rcache
-- 
2.11.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
