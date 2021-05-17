Return-Path: <SRS0=Mf8z=KM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48792C433B4
	for <iommu@archiver.kernel.org>; Mon, 17 May 2021 10:02:05 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2EAF6008E
	for <iommu@archiver.kernel.org>; Mon, 17 May 2021 10:02:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2EAF6008E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B159460803;
	Mon, 17 May 2021 10:02:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TD977oMqCnyJ; Mon, 17 May 2021 10:02:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 608AC608BA;
	Mon, 17 May 2021 10:01:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9D97EC0029;
	Mon, 17 May 2021 10:01:57 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1A20FC0001
 for <iommu@lists.linux-foundation.org>; Mon, 17 May 2021 09:56:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 066D560732
 for <iommu@lists.linux-foundation.org>; Mon, 17 May 2021 09:56:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OfuK48mQawtZ for <iommu@lists.linux-foundation.org>;
 Mon, 17 May 2021 09:56:04 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com
 [IPv6:2607:f8b0:4864:20::52f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7DEB460680
 for <iommu@lists.linux-foundation.org>; Mon, 17 May 2021 09:56:04 +0000 (UTC)
Received: by mail-pg1-x52f.google.com with SMTP id k15so4265911pgb.10
 for <iommu@lists.linux-foundation.org>; Mon, 17 May 2021 02:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=b2jCEx8mi3vXgkJ9kkatzIPCmNDeaAe/ogyF3BNTwbw=;
 b=BIAa64R4y9k3Eg3WHj2S666iigdAlamttMFasFKl0/os5LVtgYGUotdFoSEHugW/Eu
 bPRzaxAW284e8L8yo2K3DDL0/T8tA/l8wgLVMmAmo6+IhFLW/GYToPaLLl355N+97G5L
 XexcA5aHvM9w2PGt9fWa2k/dVGxtVldmNsYPnqawOun42Yk2znLlV60hSNjDq7IYxrSR
 /MfnGeT4tFvQVkSyH11nQ65tEhzqJ/jZPaGxLuLbESIf2R6H7QaYs485JdPrsXqE7dOf
 I4DwWEpiBqfQ6lw4Z+Sbeqdk137WXiyVzbQGXwJPtZ+TTYkfwjFV4U35eCpK8JW0Dmto
 ErvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=b2jCEx8mi3vXgkJ9kkatzIPCmNDeaAe/ogyF3BNTwbw=;
 b=hz1kBaXlJExB95r4zdFUxMnPkxyxGqnyVAarJKd/LnYFxDRwjc6cWWpTpkRrZ53pPe
 SH/rwbmCQgVDZoKhJMTEHRmirjQKb7tfg1+Zmhm8k4La/lDqjE857XXIY5udWT0siCE9
 BnXqCUdszfMa/anLfVyluzxaxiIYL8CVq4TyjI6/nGTijpHFWmW/vXR03MoEQusSSdOr
 faF4ciWTR6Tjni5EN59n7Oo1JWmrQ1lbV/lmyBkSt4Bjcb54f3XKX7VuR+yWOZ2TRml9
 hn17YxiEYo/JgtjZgyHmhe4XqxupljKMuhGzOHzChgIie6xz76/8ahyn5bVNzp0jGg0S
 LvwA==
X-Gm-Message-State: AOAM53301MpYfGcssoADdYth6GbDk/Q3IrA+qXIg5/1/5/7jkcqPfwmo
 51txVhZHz/EHW4INrKUWwN2V
X-Google-Smtp-Source: ABdhPJxMHtpizSq6PPRichE5BBR0ifuwPYTxOEXD/Wu/CUyxhwu/aKM7AbIbvC3ahRVJo9npK3SCVw==
X-Received: by 2002:a63:d45:: with SMTP id 5mr1321436pgn.72.1621245363924;
 Mon, 17 May 2021 02:56:03 -0700 (PDT)
Received: from localhost ([139.177.225.253])
 by smtp.gmail.com with ESMTPSA id gz18sm8486949pjb.19.2021.05.17.02.56.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 May 2021 02:56:03 -0700 (PDT)
From: Xie Yongji <xieyongji@bytedance.com>
To: mst@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
 sgarzare@redhat.com, parav@nvidia.com, hch@infradead.org,
 christian.brauner@canonical.com, rdunlap@infradead.org,
 willy@infradead.org, viro@zeniv.linux.org.uk, axboe@kernel.dk,
 bcrl@kvack.org, corbet@lwn.net, mika.penttila@nextfour.com,
 dan.carpenter@oracle.com, joro@8bytes.org
Subject: [PATCH v7 02/12] file: Export receive_fd() to modules
Date: Mon, 17 May 2021 17:55:03 +0800
Message-Id: <20210517095513.850-3-xieyongji@bytedance.com>
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

Export receive_fd() so that some modules can use
it to pass file descriptor between processes without
missing any security stuffs.

Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
---
 fs/file.c            | 6 ++++++
 include/linux/file.h | 7 +++----
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/fs/file.c b/fs/file.c
index f633348029a5..ef4da2eaf25b 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -1135,6 +1135,12 @@ int __receive_fd(int fd, struct file *file, int __user *ufd, unsigned int o_flag
 	return new_fd;
 }
 
+int receive_fd(struct file *file, unsigned int o_flags)
+{
+	return __receive_fd(-1, file, NULL, o_flags);
+}
+EXPORT_SYMBOL_GPL(receive_fd);
+
 static int ksys_dup3(unsigned int oldfd, unsigned int newfd, int flags)
 {
 	int err = -EBADF;
diff --git a/include/linux/file.h b/include/linux/file.h
index 225982792fa2..4667f9567d3e 100644
--- a/include/linux/file.h
+++ b/include/linux/file.h
@@ -94,6 +94,9 @@ extern void fd_install(unsigned int fd, struct file *file);
 
 extern int __receive_fd(int fd, struct file *file, int __user *ufd,
 			unsigned int o_flags);
+
+extern int receive_fd(struct file *file, unsigned int o_flags);
+
 static inline int receive_fd_user(struct file *file, int __user *ufd,
 				  unsigned int o_flags)
 {
@@ -101,10 +104,6 @@ static inline int receive_fd_user(struct file *file, int __user *ufd,
 		return -EFAULT;
 	return __receive_fd(-1, file, ufd, o_flags);
 }
-static inline int receive_fd(struct file *file, unsigned int o_flags)
-{
-	return __receive_fd(-1, file, NULL, o_flags);
-}
 static inline int receive_fd_replace(int fd, struct file *file, unsigned int o_flags)
 {
 	return __receive_fd(fd, file, NULL, o_flags);
-- 
2.11.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
