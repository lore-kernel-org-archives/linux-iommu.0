Return-Path: <SRS0=n9pq=UC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91B16C04AB5
	for <iommu@archiver.kernel.org>; Mon,  3 Jun 2019 13:00:04 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69D6F279DA
	for <iommu@archiver.kernel.org>; Mon,  3 Jun 2019 13:00:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="qRpvohLT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69D6F279DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lca.pw
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 2B4EBDD5;
	Mon,  3 Jun 2019 13:00:04 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 74B04DD4
	for <iommu@lists.linux-foundation.org>;
	Mon,  3 Jun 2019 13:00:02 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-qt1-f195.google.com (mail-qt1-f195.google.com
	[209.85.160.195])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 39E4B83A
	for <iommu@lists.linux-foundation.org>;
	Mon,  3 Jun 2019 13:00:01 +0000 (UTC)
Received: by mail-qt1-f195.google.com with SMTP id 14so9212540qtf.0
	for <iommu@lists.linux-foundation.org>;
	Mon, 03 Jun 2019 06:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lca.pw; s=google;
	h=from:to:cc:subject:date:message-id;
	bh=3GBqMlRpDEXUxoNuOv2KJmSc/xPoPHNnhUlLhJex3iE=;
	b=qRpvohLTlPZJtR683hLmpaceRRjgivOD7Qdxswo9AK3rCsZyhInoMNvg0MsixJln+e
	TlyWuqKIprzhJSBpu7VW7Ai3O0w6md4UFUK9O6p8PFuioGZzP8fe2slXed7viXXwBUq8
	Y8XhSxIXXLpkHTzyNdThVvS7JBLoQF2t7eQhkHaSBZzo1V+1QyNh41EB2/2S7QWNhlAu
	gEpVgNyHuF1hbJabqjrZVSqcB7LnvFpcE3v59DwSKN45RAMxZM45AK1yxE4Ny5eal8aE
	30BD1xGivWvImdcaZ0oq29YyZFCdpj0JvRaTPYCwCeUlXAcalg1fOpkEpPprYyFXYvaL
	z1LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=3GBqMlRpDEXUxoNuOv2KJmSc/xPoPHNnhUlLhJex3iE=;
	b=QAQgP4jzwj7KprIqOJFoFFSuxxgQqLL30vJNLBEWG/EqIS1c95XIHvjrFTQx+5kYPb
	ZPnnDzVLZ033oJB8MpF6A98AZtME0YqKh0DZzHvslsH6YRONZgmml6JXDcRlnxAgoju2
	fR03z7apoe6SB1FhJn9xr3Q680aIrysi8v2u+eHUytJPuJQ9Vgq00euqpdmzk2lmITU1
	iUO/EZyeYNp06uHpfUjjXrUmi6ZtlLuJvbBBfReNcNbohmjwbRjing9wT8a4gP5q8WQv
	7cbOBl3Ep4Y3gSKt36L3A2qdJKo23HjAr2BE95RQWXAHtGMygzNnzqJ3DqO8HBvA7Hdh
	rRUg==
X-Gm-Message-State: APjAAAV8WkbUA1zIuNytUFhdenaoJnVBMpBWGJ1+AefCea4UObeOYxyQ
	8Z//dwU4Gv5EXBxkrQ6RY9ztOg==
X-Google-Smtp-Source: APXvYqxMGyxbNzIAbxCU1eT0jwI7g02vzWvwWUKWs4q4Fiy4qO9njcKSHrfVKSyAcz6xwSSAxcZVTw==
X-Received: by 2002:a0c:a066:: with SMTP id b93mr21181034qva.140.1559566800256;
	Mon, 03 Jun 2019 06:00:00 -0700 (PDT)
Received: from qcai.nay.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
	by smtp.gmail.com with ESMTPSA id i4sm9417138qti.62.2019.06.03.05.59.59
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 03 Jun 2019 05:59:59 -0700 (PDT)
From: Qian Cai <cai@lca.pw>
To: jroedel@suse.de
Subject: [PATCH] iommu: replace single-char identifiers in macros
Date: Mon,  3 Jun 2019 08:59:43 -0400
Message-Id: <1559566783-13627-1-git-send-email-cai@lca.pw>
X-Mailer: git-send-email 1.8.3.1
Cc: akpm@linux-foundation.org, Qian Cai <cai@lca.pw>,
	iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

There are a few macros in IOMMU have single-char identifiers make the
code hard to read and debug. Replace them with meaningful names.

Suggested-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Qian Cai <cai@lca.pw>
---
 include/linux/dmar.h | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/include/linux/dmar.h b/include/linux/dmar.h
index f8af1d770520..eb634912f475 100644
--- a/include/linux/dmar.h
+++ b/include/linux/dmar.h
@@ -104,12 +104,14 @@ static inline bool dmar_rcu_check(void)
 
 #define	dmar_rcu_dereference(p)	rcu_dereference_check((p), dmar_rcu_check())
 
-#define	for_each_dev_scope(a, c, p, d)	\
-	for ((p) = 0; ((d) = (p) < (c) ? dmar_rcu_dereference((a)[(p)].dev) : \
-			NULL, (p) < (c)); (p)++)
-
-#define	for_each_active_dev_scope(a, c, p, d)	\
-	for_each_dev_scope((a), (c), (p), (d))	if (!(d)) { continue; } else
+#define for_each_dev_scope(devs, cnt, i, tmp)				\
+	for ((i) = 0; ((tmp) = (i) < (cnt) ?				\
+	    dmar_rcu_dereference((devs)[(i)].dev) : NULL, (i) < (cnt)); \
+	    (i)++)
+
+#define for_each_active_dev_scope(devs, cnt, i, tmp)			\
+	for_each_dev_scope((devs), (cnt), (i), (tmp))			\
+		if (!(tmp)) { continue; } else
 
 extern int dmar_table_init(void);
 extern int dmar_dev_scope_init(void);
-- 
1.8.3.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
