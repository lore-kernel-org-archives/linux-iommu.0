Return-Path: <SRS0=Mf8z=KM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E833C43460
	for <iommu@archiver.kernel.org>; Mon, 17 May 2021 10:02:06 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 068126008E
	for <iommu@archiver.kernel.org>; Mon, 17 May 2021 10:02:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 068126008E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D649283C03;
	Mon, 17 May 2021 10:02:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7dTZG3dxm7Mt; Mon, 17 May 2021 10:02:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 91CC783BFE;
	Mon, 17 May 2021 10:01:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 07976C001C;
	Mon, 17 May 2021 10:01:58 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 76E23C0001
 for <iommu@lists.linux-foundation.org>; Mon, 17 May 2021 09:56:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 58BCE83BDE
 for <iommu@lists.linux-foundation.org>; Mon, 17 May 2021 09:56:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pHTcIacIr5XP for <iommu@lists.linux-foundation.org>;
 Mon, 17 May 2021 09:56:08 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com
 [IPv6:2607:f8b0:4864:20::52c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D76BF83A96
 for <iommu@lists.linux-foundation.org>; Mon, 17 May 2021 09:56:08 +0000 (UTC)
Received: by mail-pg1-x52c.google.com with SMTP id m190so4295791pga.2
 for <iommu@lists.linux-foundation.org>; Mon, 17 May 2021 02:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=b7apvPbQfTG1FYg2uNsocmvMG/QdC7c4RuzNmrGKxtc=;
 b=lXRHbHSIsb1KADw2tX2zKstf7SBlVEY4DtJnDMFT3EHKIWMje067JnmjgrkNReUxPn
 I0z2aIAyJGaL9m4k2OpOD29iaKpNcW4xfR7d14dIuNrPK0hQOvA8kl9rxSPc6f69Mm6p
 R0F2LeWEZA0PPqOKTYoBW3+9nQSkYxFKNz5WUEn2djE6598CZ00wKdFzTggwdy8opqtd
 +LicmUYFz5R2JqJ3r3lQ/vDv0gKToNlIKrKEdVnqYs5TGR2EJsU3XPEKupH3aVQAL9FE
 3exCZ90aL2Cb7tTVwr9v8iYtnhbog2Qo9fEaKaJOYYh61niFj77C/LAndUBtJYYe86bM
 nS5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=b7apvPbQfTG1FYg2uNsocmvMG/QdC7c4RuzNmrGKxtc=;
 b=Gcaj611FdduiY+dL4VGS71qXX8G9wJBy9Fine2/eye1loAUadQJ+8g+L2HlScQ6zAO
 NJ3+UJNZaeOGtobib3AZWliyrT6SFDrDe7CBFsgtuqoFVN6CM0rtCmsB0N+9acrJFvTu
 NcIWsMV1v8967pRdID7uCpFBUiuCpKyzPxsH5koqFeKSjSOYKpiHbQSrF6eexM5BpENm
 U2ynoWQsrajP2wHNZwXk+gv148MOkZHYV/bYF9fsh+NOniSJxiqocZ7q7Wdu/XXLH7lb
 tOViyyiuNvcg+T4MkabU69Fzk7+O8BNGQpK4VyrLE6mELaeugBLaeuCSgt7WdnG+ctjR
 k5TA==
X-Gm-Message-State: AOAM533lC7y9qsZeEp2y/B0V5TOTHSIJmtvVkmnsPmGKy/1TAVTDVB25
 fYE0OdVh2BwUVqsKf+SSWYmj
X-Google-Smtp-Source: ABdhPJwO1N2BTDcGIAdEBE1GwKwtKYl5hxzWv7M8ro+LthKkIXN/GYpMnfpVi6rAWoY6mIGZm1TWzA==
X-Received: by 2002:a63:741e:: with SMTP id p30mr61016414pgc.68.1621245368362; 
 Mon, 17 May 2021 02:56:08 -0700 (PDT)
Received: from localhost ([139.177.225.253])
 by smtp.gmail.com with ESMTPSA id 24sm10063099pgz.77.2021.05.17.02.56.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 May 2021 02:56:07 -0700 (PDT)
From: Xie Yongji <xieyongji@bytedance.com>
To: mst@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
 sgarzare@redhat.com, parav@nvidia.com, hch@infradead.org,
 christian.brauner@canonical.com, rdunlap@infradead.org,
 willy@infradead.org, viro@zeniv.linux.org.uk, axboe@kernel.dk,
 bcrl@kvack.org, corbet@lwn.net, mika.penttila@nextfour.com,
 dan.carpenter@oracle.com, joro@8bytes.org
Subject: [PATCH v7 03/12] eventfd: Increase the recursion depth of
 eventfd_signal()
Date: Mon, 17 May 2021 17:55:04 +0800
Message-Id: <20210517095513.850-4-xieyongji@bytedance.com>
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

Increase the recursion depth of eventfd_signal() to 1. This
is the maximum recursion depth we have found so far, which
can be triggered with the following call chain:

    kvm_io_bus_write                        [kvm]
      --> ioeventfd_write                   [kvm]
        --> eventfd_signal                  [eventfd]
          --> vhost_poll_wakeup             [vhost]
            --> vduse_vdpa_kick_vq          [vduse]
              --> eventfd_signal            [eventfd]

Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 fs/eventfd.c            | 2 +-
 include/linux/eventfd.h | 5 ++++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/eventfd.c b/fs/eventfd.c
index e265b6dd4f34..cc7cd1dbedd3 100644
--- a/fs/eventfd.c
+++ b/fs/eventfd.c
@@ -71,7 +71,7 @@ __u64 eventfd_signal(struct eventfd_ctx *ctx, __u64 n)
 	 * it returns true, the eventfd_signal() call should be deferred to a
 	 * safe context.
 	 */
-	if (WARN_ON_ONCE(this_cpu_read(eventfd_wake_count)))
+	if (WARN_ON_ONCE(this_cpu_read(eventfd_wake_count) > EFD_WAKE_DEPTH))
 		return 0;
 
 	spin_lock_irqsave(&ctx->wqh.lock, flags);
diff --git a/include/linux/eventfd.h b/include/linux/eventfd.h
index fa0a524baed0..886d99cd38ef 100644
--- a/include/linux/eventfd.h
+++ b/include/linux/eventfd.h
@@ -29,6 +29,9 @@
 #define EFD_SHARED_FCNTL_FLAGS (O_CLOEXEC | O_NONBLOCK)
 #define EFD_FLAGS_SET (EFD_SHARED_FCNTL_FLAGS | EFD_SEMAPHORE)
 
+/* Maximum recursion depth */
+#define EFD_WAKE_DEPTH 1
+
 struct eventfd_ctx;
 struct file;
 
@@ -47,7 +50,7 @@ DECLARE_PER_CPU(int, eventfd_wake_count);
 
 static inline bool eventfd_signal_count(void)
 {
-	return this_cpu_read(eventfd_wake_count);
+	return this_cpu_read(eventfd_wake_count) > EFD_WAKE_DEPTH;
 }
 
 #else /* CONFIG_EVENTFD */
-- 
2.11.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
