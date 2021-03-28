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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD431C433C1
	for <iommu@archiver.kernel.org>; Mon, 29 Mar 2021 00:10:57 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65D956193E
	for <iommu@archiver.kernel.org>; Mon, 29 Mar 2021 00:10:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65D956193E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2FE4C607A1;
	Mon, 29 Mar 2021 00:10:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id u3KIxUNx1pMh; Mon, 29 Mar 2021 00:10:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 25381607A4;
	Mon, 29 Mar 2021 00:10:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F1225C0020;
	Mon, 29 Mar 2021 00:10:54 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C5C17C000A
 for <iommu@lists.linux-foundation.org>; Sun, 28 Mar 2021 23:56:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C2510605BE
 for <iommu@lists.linux-foundation.org>; Sun, 28 Mar 2021 23:56:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FM2MTRKQDFlt for <iommu@lists.linux-foundation.org>;
 Sun, 28 Mar 2021 23:56:48 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com
 [IPv6:2607:f8b0:4864:20::72f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 343D8605A7
 for <iommu@lists.linux-foundation.org>; Sun, 28 Mar 2021 23:56:48 +0000 (UTC)
Received: by mail-qk1-x72f.google.com with SMTP id 7so10923243qka.7
 for <iommu@lists.linux-foundation.org>; Sun, 28 Mar 2021 16:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=p8tgWIwF1h1UyJsPg+lZdKEi7xs5ze/71DPorsIrKaw=;
 b=QluZ0Za6bZK99BZdD6eZ6JK4FwNMO4t5rMeypTHxnNI3xBR1C2N9OlpcqyHrjbfiG7
 Mq+uCBl35SjAQuc4Cd3qJdRpJ8vzBl4D90dLBtuXnvkjJv+cBZgbaWDnKk0zLxPYIS5s
 yLVuS7nx+qZck+0nJsmLB5ns+K+JwVd6Y6pl1A4EIAd++4AWNUtouvQSF69/S9sHRHtI
 82eWm4rI6oMz57f/q2nVm5TOpV26u7QBwLLqbGpcE8fk9pIhGRBUJPEzl+czndefkZ/p
 YmPsBvQP7Bqq6+uK2YKh2oXukU70f0KR3ysooGwavL9tHQRwV60nHxsIuviiOJDcFJf8
 +KmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=p8tgWIwF1h1UyJsPg+lZdKEi7xs5ze/71DPorsIrKaw=;
 b=mIv3eLe5HLgqiVixy5XqaTpZEzDd1/fwf24NcaaqArqe7a99bQcv//quQIgW1hKG2l
 LgJs4joZeR+Ahe1FoPRphaXy5AeNI3MmPjFmMdbOKjs4STI94EpH3IsK81y6Xkjd2EHA
 GadtsYxh0D44HIGg09xyJUBRST49h9H2c3IuCcP7s3/zLQ6QaoHVomtyato5kQfH/l+G
 rMxHctuz+n7TAZBIWuUtBDIkg81TLkJdRV0/KYHE3UOVvq1j5kRYnu/8n9vw3LNaH1Q/
 +4h/NgxHLHmgYmqK6NfX0B21powd3X2C8Hvgi99Nks4YCKoiSnVSDoNw/FxKS2EkoDKR
 wuMg==
X-Gm-Message-State: AOAM532dvkCwePSiUEae19SvcXDNU9ti6PI7EkPblH0LCf5dqGNXwv/R
 3tK/moNSif/lS6tg+gvj6Jw=
X-Google-Smtp-Source: ABdhPJzpxSRSjtr4pJygkDPBEhRffmMMyfd9P0g2mrERYszZ3+DVR0YWumqOtPLQE4YK+O+8QPuhTQ==
X-Received: by 2002:a05:620a:2915:: with SMTP id
 m21mr22225739qkp.147.1616975807180; 
 Sun, 28 Mar 2021 16:56:47 -0700 (PDT)
Received: from localhost.localdomain ([156.146.58.24])
 by smtp.gmail.com with ESMTPSA id y19sm12153061qky.111.2021.03.28.16.56.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Mar 2021 16:56:46 -0700 (PDT)
From: Bhaskar Chowdhury <unixbhaskar@gmail.com>
To: dmaengine@vger.kernel.org, dri-devel@lists.freedesktop.org, hch@lst.de,
 iommu@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
 dave.jiang@intel.com, dan.j.williams@intel.com
Subject: [PATCH 10/30] mv_xor_v2.c: Fix a typo
Date: Mon, 29 Mar 2021 05:23:06 +0530
Message-Id: <c2a5a94826aa421f14b4ee7cbf99f74b82f91d32.1616971780.git.unixbhaskar@gmail.com>
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

s/assosiated/associated/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 drivers/dma/mv_xor_v2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/mv_xor_v2.c b/drivers/dma/mv_xor_v2.c
index 9b0d463f89bb..8a45861299a0 100644
--- a/drivers/dma/mv_xor_v2.c
+++ b/drivers/dma/mv_xor_v2.c
@@ -175,7 +175,7 @@ struct mv_xor_v2_device {
  * struct mv_xor_v2_sw_desc - implements a xor SW descriptor
  * @idx: descriptor index
  * @async_tx: support for the async_tx api
- * @hw_desc: assosiated HW descriptor
+ * @hw_desc: associated HW descriptor
  * @free_list: node of the free SW descriprots list
 */
 struct mv_xor_v2_sw_desc {
--
2.26.3

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
