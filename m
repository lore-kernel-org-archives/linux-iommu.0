Return-Path: <SRS0=sxdJ=NV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6505C4320A
	for <iommu@archiver.kernel.org>; Mon, 30 Aug 2021 14:22:12 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8ABDA60F25
	for <iommu@archiver.kernel.org>; Mon, 30 Aug 2021 14:22:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8ABDA60F25
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 4D8C7402F6;
	Mon, 30 Aug 2021 14:22:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EHpCGLVJNJJI; Mon, 30 Aug 2021 14:22:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 78795402E3;
	Mon, 30 Aug 2021 14:22:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 62223C001A;
	Mon, 30 Aug 2021 14:22:07 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E5DE1C000E
 for <iommu@lists.linux-foundation.org>; Mon, 30 Aug 2021 14:22:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D620380F73
 for <iommu@lists.linux-foundation.org>; Mon, 30 Aug 2021 14:22:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id a4BLzsHhSHLH for <iommu@lists.linux-foundation.org>;
 Mon, 30 Aug 2021 14:22:05 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com
 [IPv6:2607:f8b0:4864:20::52b])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 522B780F6D
 for <iommu@lists.linux-foundation.org>; Mon, 30 Aug 2021 14:22:05 +0000 (UTC)
Received: by mail-pg1-x52b.google.com with SMTP id y23so13586275pgi.7
 for <iommu@lists.linux-foundation.org>; Mon, 30 Aug 2021 07:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=CkhRtVDUgb41zlq5OfgVAHJFRMwL0PptQO/kVg6fccA=;
 b=PtF0MmvzQ3aNxBPG1DhD6uEui9rZ2X7xOJKS7RoGdzb1WNZ0Paezvg4hjgjTDi9L9E
 tmINiWUlulvd8FBlNdqzf3yLgsPpaaYvV2hHbRT1Tx4U2t05e3QTUFQ9c+Bc9xPI9u1M
 LV16Rw80XJKCMtLWBy4cKOIoXoGf3lTmhWNH3JHXNwHB7TmPcEtrur4lP4dijYAMj5de
 LCFrSj/HHwcU+Tx1Se/wO+59+ogmNHkzjq4KZIpC9+LnJH68BtyEw00md2A0eqqSwOM2
 GwirGPhAkMn1fhn6zl9S8XW5A8HJ0NynS8yR0T6sVGuPh4JuNKRlokpKqEh8eIQQatSJ
 UtMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=CkhRtVDUgb41zlq5OfgVAHJFRMwL0PptQO/kVg6fccA=;
 b=USisJMJQDd4M0yRZyIv9xzD0m1t1ufNOo11IRgs0VXDFR40ujNM9Xt3+GJYykIj9Nz
 NMaCTU9MK9vp4+4EbcXUULlNpi5Sktq3xub96ynTYQ9p2mWnFJV0fMWGcWtfTZEV/U5O
 oOuA6KNfcIXCuMlPuP1LK80PQq4pjUFKhPpw6xKf7PJJOuZOIXFU5IHR+00+HeFD9Phg
 lJ2EukIzzCEYXqZJPZfrNC34S3h1Frie4H3nvk4maatV3Mja1I001PsrqeGWkmyggPXe
 JK+MI0eGBwsOxm9/Z+1pFI+gN+lQyPsQYSQmQY+5bra3Sn/7aqNb3uIXD9NqD5l78WdY
 czDw==
X-Gm-Message-State: AOAM533Dg0sFlNApPJ5lDGB3YtKX3oix622dTzW2RdO9Bv/tTEAe5iM1
 bkBsePLM53iK00JxKnr+rFOB
X-Google-Smtp-Source: ABdhPJxm7cudNHvI9FsL63eCLI5rNFAX3FYOQEJSl53ZSWaAz0jzpso6pnHbFXng3EkPeZB4X8SZQA==
X-Received: by 2002:aa7:83d0:0:b029:3c6:7261:ecb with SMTP id
 j16-20020aa783d00000b02903c672610ecbmr23747850pfn.61.1630333324827; 
 Mon, 30 Aug 2021 07:22:04 -0700 (PDT)
Received: from localhost ([139.177.225.237])
 by smtp.gmail.com with ESMTPSA id i14sm14892396pfd.112.2021.08.30.07.22.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Aug 2021 07:22:04 -0700 (PDT)
From: Xie Yongji <xieyongji@bytedance.com>
To: mst@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
 sgarzare@redhat.com, parav@nvidia.com, hch@infradead.org,
 christian.brauner@canonical.com, rdunlap@infradead.org,
 willy@infradead.org, viro@zeniv.linux.org.uk, axboe@kernel.dk,
 bcrl@kvack.org, corbet@lwn.net, mika.penttila@nextfour.com,
 dan.carpenter@oracle.com, joro@8bytes.org, gregkh@linuxfoundation.org,
 zhe.he@windriver.com, xiaodong.liu@intel.com, joe@perches.com,
 robin.murphy@arm.com, will@kernel.org, john.garry@huawei.com
Subject: [PATCH v12 03/13] file: Export receive_fd() to modules
Date: Mon, 30 Aug 2021 22:17:27 +0800
Message-Id: <20210830141737.181-4-xieyongji@bytedance.com>
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

Export receive_fd() so that some modules can use
it to pass file descriptor between processes without
missing any security stuffs.

Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 fs/file.c            | 6 ++++++
 include/linux/file.h | 7 +++----
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/fs/file.c b/fs/file.c
index 86dc9956af32..210e540672aa 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -1134,6 +1134,12 @@ int receive_fd_replace(int new_fd, struct file *file, unsigned int o_flags)
 	return new_fd;
 }
 
+int receive_fd(struct file *file, unsigned int o_flags)
+{
+	return __receive_fd(file, NULL, o_flags);
+}
+EXPORT_SYMBOL_GPL(receive_fd);
+
 static int ksys_dup3(unsigned int oldfd, unsigned int newfd, int flags)
 {
 	int err = -EBADF;
diff --git a/include/linux/file.h b/include/linux/file.h
index 2de2e4613d7b..51e830b4fe3a 100644
--- a/include/linux/file.h
+++ b/include/linux/file.h
@@ -94,6 +94,9 @@ extern void fd_install(unsigned int fd, struct file *file);
 
 extern int __receive_fd(struct file *file, int __user *ufd,
 			unsigned int o_flags);
+
+extern int receive_fd(struct file *file, unsigned int o_flags);
+
 static inline int receive_fd_user(struct file *file, int __user *ufd,
 				  unsigned int o_flags)
 {
@@ -101,10 +104,6 @@ static inline int receive_fd_user(struct file *file, int __user *ufd,
 		return -EFAULT;
 	return __receive_fd(file, ufd, o_flags);
 }
-static inline int receive_fd(struct file *file, unsigned int o_flags)
-{
-	return __receive_fd(file, NULL, o_flags);
-}
 int receive_fd_replace(int new_fd, struct file *file, unsigned int o_flags);
 
 extern void flush_delayed_fput(void);
-- 
2.11.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
