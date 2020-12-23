Return-Path: <SRS0=5yIV=F3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17325C433E0
	for <iommu@archiver.kernel.org>; Wed, 23 Dec 2020 06:24:29 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6649A20759
	for <iommu@archiver.kernel.org>; Wed, 23 Dec 2020 06:24:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6649A20759
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 76468274E2;
	Wed, 23 Dec 2020 06:24:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id W05J8Vij5cCw; Wed, 23 Dec 2020 06:24:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 86B8E20437;
	Wed, 23 Dec 2020 06:24:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4E395C1825;
	Wed, 23 Dec 2020 06:24:26 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E66D3C0893
 for <iommu@lists.linux-foundation.org>; Wed, 23 Dec 2020 06:24:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 9A9A222926
 for <iommu@lists.linux-foundation.org>; Wed, 23 Dec 2020 06:24:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KJ6z7-fjwDRe for <iommu@lists.linux-foundation.org>;
 Wed, 23 Dec 2020 06:24:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com
 [209.85.214.175])
 by silver.osuosl.org (Postfix) with ESMTPS id 98A1120437
 for <iommu@lists.linux-foundation.org>; Wed, 23 Dec 2020 06:24:23 +0000 (UTC)
Received: by mail-pl1-f175.google.com with SMTP id q4so8621394plr.7
 for <iommu@lists.linux-foundation.org>; Tue, 22 Dec 2020 22:24:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=QiwH8ao3HelKgvVCUMgmqCqlcpNzwtvsd407+B9/1NY=;
 b=eYnQiqzkc8vzQwlMvfZzfj7syy7MJ1XFHJjiVNkeZHNg3jyRjKCiR+TPpvalS6M2Pc
 2xsl6Gln5wx027ZKiQpWimcwigEU0tvBHl2sdCYyWupq0P/uHegXExkviWowQ6WYJqbc
 HnZDPjn7+nTnvg4racg/ahs7PvAhDet12LBwQ5S9DljuYWzxzbdmOKP8UpBlZb2ZMB/2
 czxBL0Ow4GAsTFSR4f4WsKJ1dRYlZJ1FVLB4U/Nv/PrzefztSxTNI6TggEQHGmF65uX6
 AXqzmq5KeNYX1Zp0T8TVIwXBpJX6aMmhAU1R2AC5h6DKxrEFY+HrcLFTxiDkOGEPcWCW
 S0Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=QiwH8ao3HelKgvVCUMgmqCqlcpNzwtvsd407+B9/1NY=;
 b=JzlCLzE7kKxir61rjuwPJotoRsAPac8/ZRJl+gsoT6DNKedPr1nK6gvdqmv7jkN/sG
 nQ7i9Q88uQvNkzs9MAZcmIVsrjQ7AqBs6/aGrtGK65KyScoxzkB9hLRoBJKyDZaoR5Fr
 Lqm9FiFJVrSJxD+q1uOl/1mGDM3rMPDOy0LlPK1gi8YTBCTB2HtEgx8N3QgtKoG8YkY6
 5SFIIN8yA0gmy3olLqz+R+ZQAq4xxZakd7yO1t50fzftlNw5q3vE5F8Pdf5HwoV++cjT
 Y9EuiMSQgP6cSlZE7iasXvvWpFKF2EyidXAZUAaIc4oFLJm1vmMpgjJuOMgPzpMbJWWO
 s8TQ==
X-Gm-Message-State: AOAM530NanOGccLvwTtCqEe4RWmKvh7QbnMlrpBcyFSEBjupgKkJvIfP
 OT+yWPCQ4sR6/gLKhKl1dzs=
X-Google-Smtp-Source: ABdhPJyxNF52FuyNuoJelGOrJq7YmmPv7+afCqw0vLDy2cmpXqIywzuQsCNT2fBLXqgRv5G1GviOnA==
X-Received: by 2002:a17:90a:12c4:: with SMTP id
 b4mr25060313pjg.234.1608704663193; 
 Tue, 22 Dec 2020 22:24:23 -0800 (PST)
Received: from ZB-PF0YQ8ZU.360buyad.local ([137.116.162.235])
 by smtp.gmail.com with ESMTPSA id y6sm1480667pjl.0.2020.12.22.22.24.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Dec 2020 22:24:22 -0800 (PST)
From: Zhenzhong Duan <zhenzhong.duan@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] x86/iommu: Fix two minimal issues in check_iommu_entries()
Date: Wed, 23 Dec 2020 14:24:12 +0800
Message-Id: <20201223062412.343-1-zhenzhong.duan@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Cc: will@kernel.org, konrad.wilk@oracle.com, dwmw2@infradead.org,
 Zhenzhong Duan <zhenzhong.duan@gmail.com>, iommu@lists.linux-foundation.org,
 mingo@redhat.com, bp@alien8.de, joe@perches.com, tglx@linutronix.de,
 zhongjiang@huawei.com
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

check_iommu_entries() checks for cyclic dependency in iommu entries
and fixes the cyclic dependency by setting x->depend to NULL. But
this repairing isn't correct if q is in front of p, there will be
"EXECUTION ORDER INVALID!" report following. Fix it by NULLing
whichever in the front.

The second issue is about the report of exectuion order reverse,
the order is reversed incorrectly in the report, fix it.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@gmail.com>
---
 arch/x86/kernel/pci-iommu_table.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/pci-iommu_table.c b/arch/x86/kernel/pci-iommu_table.c
index 2e9006c..40c8249 100644
--- a/arch/x86/kernel/pci-iommu_table.c
+++ b/arch/x86/kernel/pci-iommu_table.c
@@ -60,7 +60,10 @@ void __init check_iommu_entries(struct iommu_table_entry *start,
 			printk(KERN_ERR "CYCLIC DEPENDENCY FOUND! %pS depends on %pS and vice-versa. BREAKING IT.\n",
 			       p->detect, q->detect);
 			/* Heavy handed way..*/
-			x->depend = NULL;
+			if (p > q)
+				q->depend = NULL;
+			else
+				p->depend = NULL;
 		}
 	}
 
@@ -68,7 +71,7 @@ void __init check_iommu_entries(struct iommu_table_entry *start,
 		q = find_dependents_of(p, finish, p);
 		if (q && q > p) {
 			printk(KERN_ERR "EXECUTION ORDER INVALID! %pS should be called before %pS!\n",
-			       p->detect, q->detect);
+			       q->detect, p->detect);
 		}
 	}
 }
-- 
1.8.3.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
