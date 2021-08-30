Return-Path: <SRS0=sxdJ=NV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5E04C19F3A
	for <iommu@archiver.kernel.org>; Mon, 30 Aug 2021 14:22:08 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CBF360F46
	for <iommu@archiver.kernel.org>; Mon, 30 Aug 2021 14:22:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8CBF360F46
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6939880F72;
	Mon, 30 Aug 2021 14:22:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qwLfHfSjZ2cJ; Mon, 30 Aug 2021 14:22:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 3D55880F70;
	Mon, 30 Aug 2021 14:22:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 13235C001A;
	Mon, 30 Aug 2021 14:22:04 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7C263C001B
 for <iommu@lists.linux-foundation.org>; Mon, 30 Aug 2021 14:22:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5EF5680F70
 for <iommu@lists.linux-foundation.org>; Mon, 30 Aug 2021 14:22:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xBZhcvfQmit7 for <iommu@lists.linux-foundation.org>;
 Mon, 30 Aug 2021 14:22:01 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com
 [IPv6:2607:f8b0:4864:20::434])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DB6FE80F6E
 for <iommu@lists.linux-foundation.org>; Mon, 30 Aug 2021 14:22:01 +0000 (UTC)
Received: by mail-pf1-x434.google.com with SMTP id u6so11699243pfi.0
 for <iommu@lists.linux-foundation.org>; Mon, 30 Aug 2021 07:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=/Vl3AHwuQDLe0ZGngtEfFx668CIPSygY8Oaw4ZN4vCo=;
 b=rOdETcL4sxH6ECF/nEWQheSNSVqzE5EKTelanx7BQ2PKWpnXFO6rmcX6i+tCUi8Q32
 AYhqQkRrQa8EM7Bg7uRVJpsWguCG/stc4586BP6z6HBxOgZA6tDWfdRMnIhAzki5h5Ae
 A82GZnSP8cgEvspkQScLL8aSkhfVODJdv20wuKYROYhTPUQtHuCZ+ptiQo11dwBrvO6m
 JnbAIlSoMDWh/dofuquvv4s679GbOun0rVEEBVvEugywnej8zFSKmn+WI+VcVePqAa9P
 nSbFhH7u6iJ2ak14mt/Ka7JrjUwobfmDsaC4muwtLv2rse7bm0Cd65KsJK9uWREPsFly
 Kfbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/Vl3AHwuQDLe0ZGngtEfFx668CIPSygY8Oaw4ZN4vCo=;
 b=lW6RiggQqTTezTnbYL3m67Cgivm4zvUc9roskIGKBQfRKWIGvKKaJc1LsYE+6mwDcU
 SahQrbA4+J/YfxqIyA9fPFaqmfDVL3DDmpVzJDz3KMc/7lWOmKxeIiIvOK+G+IwluLLy
 rzJm6ODf25NYvKiuiVi7Tm3opFh4Y44aZO7V0552IgDXbj20Yz+K0ZQlLYhPr+wYp7mE
 WTRJfNAIrixmD5Rt+i5+/O91HpUwGzB9sdFKzjuomh+vPnV6um7g1GM0TYmWuvRC30wD
 W9xC0+sx9K4g14xoNqsBX+iOKjf9XjXRNIxeC5O8gfjxRhATHRqEiPpBrqgmlU2T8qM+
 czYQ==
X-Gm-Message-State: AOAM533hcPtMshIHRWH1GjgGmswEq8BRPTFiK7Tuem+MdRr3nEkAVZe/
 CbH1M6lR+bFTfgguYSSZmVMw
X-Google-Smtp-Source: ABdhPJyuMdXMw+vCPINhRkPdClG/pBGJOxyP0dOUhBuVr8N6XWMqky+vJCs5bkogn8kzhLBwyta7lQ==
X-Received: by 2002:aa7:8014:0:b029:3cd:b6f3:5dd6 with SMTP id
 j20-20020aa780140000b02903cdb6f35dd6mr23512141pfi.39.1630333321384; 
 Mon, 30 Aug 2021 07:22:01 -0700 (PDT)
Received: from localhost ([139.177.225.237])
 by smtp.gmail.com with ESMTPSA id b17sm4424962pfo.98.2021.08.30.07.22.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Aug 2021 07:22:01 -0700 (PDT)
From: Xie Yongji <xieyongji@bytedance.com>
To: mst@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
 sgarzare@redhat.com, parav@nvidia.com, hch@infradead.org,
 christian.brauner@canonical.com, rdunlap@infradead.org,
 willy@infradead.org, viro@zeniv.linux.org.uk, axboe@kernel.dk,
 bcrl@kvack.org, corbet@lwn.net, mika.penttila@nextfour.com,
 dan.carpenter@oracle.com, joro@8bytes.org, gregkh@linuxfoundation.org,
 zhe.he@windriver.com, xiaodong.liu@intel.com, joe@perches.com,
 robin.murphy@arm.com, will@kernel.org, john.garry@huawei.com
Subject: [PATCH v12 02/13] eventfd: Export eventfd_wake_count to modules
Date: Mon, 30 Aug 2021 22:17:26 +0800
Message-Id: <20210830141737.181-3-xieyongji@bytedance.com>
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
