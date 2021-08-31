Return-Path: <SRS0=eAvY=NW=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04629C432BE
	for <iommu@archiver.kernel.org>; Tue, 31 Aug 2021 10:37:21 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B68C60F42
	for <iommu@archiver.kernel.org>; Tue, 31 Aug 2021 10:37:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8B68C60F42
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 48FFB4052E;
	Tue, 31 Aug 2021 10:37:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MYwngscoWzV0; Tue, 31 Aug 2021 10:37:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 246AF404F9;
	Tue, 31 Aug 2021 10:37:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E9DDCC0023;
	Tue, 31 Aug 2021 10:37:15 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1CE8AC0023
 for <iommu@lists.linux-foundation.org>; Tue, 31 Aug 2021 10:37:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E65E7404F9
 for <iommu@lists.linux-foundation.org>; Tue, 31 Aug 2021 10:37:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HqeOJ5KpkPcg for <iommu@lists.linux-foundation.org>;
 Tue, 31 Aug 2021 10:37:12 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com
 [IPv6:2607:f8b0:4864:20::433])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1600F40504
 for <iommu@lists.linux-foundation.org>; Tue, 31 Aug 2021 10:37:12 +0000 (UTC)
Received: by mail-pf1-x433.google.com with SMTP id y17so1234744pfl.13
 for <iommu@lists.linux-foundation.org>; Tue, 31 Aug 2021 03:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=/Vl3AHwuQDLe0ZGngtEfFx668CIPSygY8Oaw4ZN4vCo=;
 b=wObpuu7touPHyE2FlMtp6j82DVKvgvJGqxVDpQh426PCA4G0/SKGQXKEyHJVZQ8cIm
 L9XkoweTnt+6I4BW0Mn5WMJvosr3G5o8gM7IIYvH3KGm6heQlvcQObzommcU8i7cnUT0
 QRgkYd46omJIk7r6/K6p/cRey3grFpdCYxr0txvNQ+lkyVHC2OMROz/ezIQJEf6W9yvR
 2jeQJkG2XFVufs6nY4wO6FwV8xejE3tq1kLU6PROTvNysrRr7cvUwW3cLlScU5q9AQEA
 thnUcb8QN1ab0y0YDAkUPLMGlydGB6EUB2ANfuVz00VX5Kyh4O6qNPMi5OPi5yf/pyIu
 26kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/Vl3AHwuQDLe0ZGngtEfFx668CIPSygY8Oaw4ZN4vCo=;
 b=sJIBIsx2AApuC4vHRy2VonfV5o/lCNa5+4sXxcePnTEGpvVkxrnx+hXSEE5bwMy2RV
 RRvkDdhjwCF03j2wK1NposxTe8ll7OfQQNxkXrtakhOq/LtVloig2LJC7DOgy/B2N1l9
 4DwK3ugJ479Az351Jl80bGZpEp/ErwrUZ6pmk3nl3rQHnZKRHU04uo3dFzTe+HPpcXm0
 kKRtWQ0RHeVvoh72Nxg2ytbWZGyiZKgQTSDbGrFcLgaSXQrmXkaFtUit8mnrq9gnMxBD
 spFKZJadCSL0F0LqUGB6AQaoOmozxarRRiy/mxT1tBUFjDf0AJdBGTXeW0ggheOKRV1i
 iFzw==
X-Gm-Message-State: AOAM530uJ56KwqTieZkw0Sfr3dICXex+vveqyKyH01fkQcn6ySgdNbSo
 mT18h1mXb8XMEJgZJr478uRr
X-Google-Smtp-Source: ABdhPJypZEfGrqo1WgyHIL6EcT5LWw7WqnAwRGMuQX/YOGdJQ19c5iZukJRXGO5wvdTG9X6CBrVIsA==
X-Received: by 2002:a63:101c:: with SMTP id f28mr26080762pgl.330.1630406231592; 
 Tue, 31 Aug 2021 03:37:11 -0700 (PDT)
Received: from localhost ([139.177.225.253])
 by smtp.gmail.com with ESMTPSA id x15sm6941154pfq.31.2021.08.31.03.37.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Aug 2021 03:37:11 -0700 (PDT)
From: Xie Yongji <xieyongji@bytedance.com>
To: mst@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
 sgarzare@redhat.com, parav@nvidia.com, hch@infradead.org,
 christian.brauner@canonical.com, rdunlap@infradead.org,
 willy@infradead.org, viro@zeniv.linux.org.uk, axboe@kernel.dk,
 bcrl@kvack.org, corbet@lwn.net, mika.penttila@nextfour.com,
 dan.carpenter@oracle.com, joro@8bytes.org, gregkh@linuxfoundation.org,
 zhe.he@windriver.com, xiaodong.liu@intel.com, joe@perches.com,
 robin.murphy@arm.com, will@kernel.org, john.garry@huawei.com
Subject: [PATCH v13 02/13] eventfd: Export eventfd_wake_count to modules
Date: Tue, 31 Aug 2021 18:36:23 +0800
Message-Id: <20210831103634.33-3-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210831103634.33-1-xieyongji@bytedance.com>
References: <20210831103634.33-1-xieyongji@bytedance.com>
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

Export eventfd_wake_count so that some modules can use
the eventfd_signal_count() to check whether the
eventfd_signal() call should be deferred to a safe context.

Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
---
 fs/eventfd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/eventfd.c b/fs/eventfd.c
index e265b6dd4f34..1b3130b8d6c1 100644
--- a/fs/eventfd.c
+++ b/fs/eventfd.c
@@ -26,6 +26,7 @@
 #include <linux/uio.h>
 
 DEFINE_PER_CPU(int, eventfd_wake_count);
+EXPORT_PER_CPU_SYMBOL_GPL(eventfd_wake_count);
 
 static DEFINE_IDA(eventfd_ida);
 
-- 
2.11.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
