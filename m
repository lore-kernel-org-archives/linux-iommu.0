Return-Path: <SRS0=QSWf=I3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDC7EC433E4
	for <iommu@archiver.kernel.org>; Mon, 29 Mar 2021 00:10:57 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87C136192F
	for <iommu@archiver.kernel.org>; Mon, 29 Mar 2021 00:10:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87C136192F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 876744032F;
	Mon, 29 Mar 2021 00:10:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FYZPi4tvKDrR; Mon, 29 Mar 2021 00:10:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id 80DF240335;
	Mon, 29 Mar 2021 00:10:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7DC5BC0012;
	Mon, 29 Mar 2021 00:10:53 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4E2C7C000C
 for <iommu@lists.linux-foundation.org>; Sun, 28 Mar 2021 23:56:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4624D400C4
 for <iommu@lists.linux-foundation.org>; Sun, 28 Mar 2021 23:56:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9WQvJ2JzI9Ou for <iommu@lists.linux-foundation.org>;
 Sun, 28 Mar 2021 23:56:18 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com
 [IPv6:2607:f8b0:4864:20::f36])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8BA1C400C9
 for <iommu@lists.linux-foundation.org>; Sun, 28 Mar 2021 23:56:18 +0000 (UTC)
Received: by mail-qv1-xf36.google.com with SMTP id g8so5711271qvx.1
 for <iommu@lists.linux-foundation.org>; Sun, 28 Mar 2021 16:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=qPii/xX6YhM4hcBO+zp3OVMgz+jDeBjNcGIvzkkQGYk=;
 b=bObaSHbQgF7HnhhFevByLeRAEjwh9Xgx/6poqOyVrhU9nI9SQbKZibaot0nVJHtdHK
 o79A8Sp+Gz79oGtGsF5SxsTYB9AMcZOuDAKRePAi8OQlhWEu8LqzdcK18F1hIKWGpwTt
 +hcuXkQ52IF+FdKd1u3A+2KvczRYSW2FxnhgIJbngK13+y5D665LByLLaOIYq5prJ2BB
 q0KPV1xmQES9uuwOigJWctcX+oM6I0mAu6NH+RzVkz/A8hrPHIr5VI27yaHxNHMRhJ9S
 ZkZNPLNBdVtA2r2vkh1TOiWiTBT+BsXGquBT60jgmW2VoagfFPx16zh5v8S/U1Z6V3eJ
 yCKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=qPii/xX6YhM4hcBO+zp3OVMgz+jDeBjNcGIvzkkQGYk=;
 b=LNKq0LgiON2aTo3dHcE8r55iCo+c5o+2UeeHVT5MIzM1LSdQOiILGzCL+JGwKO8YJL
 d9Vc9zVU0AjnnVeVKdtVgLY+Kyw+JBtcw8UJovMCSjWsZgmwmbNu+GWy0rsP0n9iUo33
 4nbNIbq1Bhzq1bor4ddwOde6jXi8y277I7aEeqiQVb7qjGj4h3JluawQ53RuLw89V30r
 RpyRp7w2ZT47KQLr8Glhxzcf2WcQYWqMgtGyEW6t4npTRMosIuX2g5DqoFbuK9a3bsJi
 q6Hk5mIefxnNOHh6pwWtFRJcxvEvVdfpih4d0NotBlByKd984suo0Xc28RWWBFEDismX
 irmQ==
X-Gm-Message-State: AOAM530iYdzx0UVtYnGvnaFKRAr7lRBuMdWCiMPJc4kBhS2nxIgPgBIk
 RKr7uEsCz498ePMKeiW1/cw=
X-Google-Smtp-Source: ABdhPJyIwQh8O82d8qyrfIuUZz0SqJYcgUURzt27W+q5h1fBWMUvMvJGKHkKfG17NwqDAaW/0JNrSg==
X-Received: by 2002:a05:6214:d85:: with SMTP id
 e5mr22653184qve.36.1616975777547; 
 Sun, 28 Mar 2021 16:56:17 -0700 (PDT)
Received: from localhost.localdomain ([156.146.58.24])
 by smtp.gmail.com with ESMTPSA id y19sm12153061qky.111.2021.03.28.16.56.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Mar 2021 16:56:17 -0700 (PDT)
From: Bhaskar Chowdhury <unixbhaskar@gmail.com>
To: dmaengine@vger.kernel.org, dri-devel@lists.freedesktop.org, hch@lst.de,
 iommu@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
 dave.jiang@intel.com, dan.j.williams@intel.com
Subject: [PATCH 04/30] bcm-sba-raid.c: Few typos fixed
Date: Mon, 29 Mar 2021 05:23:00 +0530
Message-Id: <a421c27ea6dc2808edec25b18238941ab5aefcf4.1616971780.git.unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1616971780.git.unixbhaskar@gmail.com>
References: <cover.1616971780.git.unixbhaskar@gmail.com>
MIME-Version: 1.0
X-Mailman-Approved-At: Mon, 29 Mar 2021 00:10:51 +0000
Cc: rdunlap@infradead.org, Bhaskar Chowdhury <unixbhaskar@gmail.com>,
 linux-kernel@vger.kernel.org
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

s/Maibox/Mailbox/
s/alloced/allocated/
s/atleast/"at least"/
s/parallely/parallel/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 drivers/dma/bcm-sba-raid.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/bcm-sba-raid.c b/drivers/dma/bcm-sba-raid.c
index 64239da02e74..fba1585eb7ad 100644
--- a/drivers/dma/bcm-sba-raid.c
+++ b/drivers/dma/bcm-sba-raid.c
@@ -25,7 +25,7 @@
  * number of hardware rings over one or more SBA hardware devices. By
  * design, the internal buffer size of SBA hardware device is limited
  * but all offload operations supported by SBA can be broken down into
- * multiple small size requests and executed parallely on multiple SBA
+ * multiple small size requests and executed parallel on multiple SBA
  * hardware devices for achieving high through-put.
  *
  * The Broadcom SBA RAID driver does not require any register programming
@@ -143,7 +143,7 @@ struct sba_device {
 	u32 max_xor_srcs;
 	u32 max_resp_pool_size;
 	u32 max_cmds_pool_size;
-	/* Maibox client and Mailbox channels */
+	/* Mailbox client and Mailbox channels */
 	struct mbox_client client;
 	struct mbox_chan *mchan;
 	struct device *mbox_dev;
@@ -328,7 +328,7 @@ static void sba_cleanup_nonpending_requests(struct sba_device *sba)

 	spin_lock_irqsave(&sba->reqs_lock, flags);

-	/* Freeup all alloced request */
+	/* Freeup all allocated request */
 	list_for_each_entry_safe(req, req1, &sba->reqs_alloc_list, node)
 		_sba_free_request(sba, req);

@@ -1633,7 +1633,7 @@ static int sba_probe(struct platform_device *pdev)
 	sba->dev = &pdev->dev;
 	platform_set_drvdata(pdev, sba);

-	/* Number of mailbox channels should be atleast 1 */
+	/* Number of mailbox channels should be at least 1 */
 	ret = of_count_phandle_with_args(pdev->dev.of_node,
 					 "mboxes", "#mbox-cells");
 	if (ret <= 0)
--
2.26.3

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
