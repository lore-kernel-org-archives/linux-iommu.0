Return-Path: <SRS0=eEOj=7H=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9641FC433E2
	for <iommu@archiver.kernel.org>; Mon, 25 May 2020 23:26:30 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FEFA2071A
	for <iommu@archiver.kernel.org>; Mon, 25 May 2020 23:26:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F0Dm69Md"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FEFA2071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 55DFE8593F;
	Mon, 25 May 2020 23:26:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wIK9yzS_ki0U; Mon, 25 May 2020 23:26:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 8D4BF859CF;
	Mon, 25 May 2020 23:26:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6DEDAC0891;
	Mon, 25 May 2020 23:26:28 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 95A72C016F
 for <iommu@lists.linux-foundation.org>; Mon, 25 May 2020 21:50:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 9248586B47
 for <iommu@lists.linux-foundation.org>; Mon, 25 May 2020 21:50:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SRyYC2nhqsV4 for <iommu@lists.linux-foundation.org>;
 Mon, 25 May 2020 21:50:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-lj1-f193.google.com (mail-lj1-f193.google.com
 [209.85.208.193])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id C1FCA86B3B
 for <iommu@lists.linux-foundation.org>; Mon, 25 May 2020 21:50:11 +0000 (UTC)
Received: by mail-lj1-f193.google.com with SMTP id q2so22121766ljm.10
 for <iommu@lists.linux-foundation.org>; Mon, 25 May 2020 14:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=iEiJkh8NOisGzIdjA2H8Ok8XHFo6aNWnpKwvRPxnlbI=;
 b=F0Dm69MdRLl1SxBsFc77E4osmjMTyNBL9fquMX9me9JytXqkrntX0IB1ESMq2khzr5
 yLJvt9nWa+eIDZ6fzdHAf82L5UJYn06C4sRahqCU0cBjfLoCgHmNaxq0KFTJFaRCvXhc
 Ftu6ItywBCl7PQFZY6hSErjbpHd5VzG+rqhCvHoAHTZ7BarMhuHbAH4mXP8hZ4WgYUZW
 2VgnUpRQ+CXevOpYJQNKZiTj+SRdLTbMIa8E98zZl0B6You97hjFSK3purxPAfsjk5b0
 qrLy3Fs+ur2e3NrQEFbAmjpBlKFq1GiP59sap03Fh4plngauYBQh0O0lzlGnB4lwMdw3
 vavA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=iEiJkh8NOisGzIdjA2H8Ok8XHFo6aNWnpKwvRPxnlbI=;
 b=Ykglgk+8cdnyPHaFE64HYCLW4mQEru9iYQnOVUSsSPOe8yN4236hov1AymRmVBHMlg
 iEKg6TNx9JHPdlkp/soFC/rHgQ9qNsDqM7naTHk1qIzt58sB1LH3bzX0berbOPqCGBhW
 xuf3J+0kK7XSQUJM9p0zHELNELVpCt7I3bAO1o3W/IizfBJghX2wK76GqVnKpHuh6kUu
 bsOMMZZbrhYfBFAjQpfOHSDDZkB9iX7Got9obXA7s9o3Z+cZrWEfnWgy8gPQptT0sQuI
 hM2xNISWdWZAl6vna2dEp8dgQNz1VcCHOnm4kqgyFKNHSvwtBYyrSzMMg7ofSSbbC34A
 vFbw==
X-Gm-Message-State: AOAM532JapiNTPzBXhKQTM9v8fGCMoYPBnh1a1XslpROsJ41gH9H5fyn
 KKcdkUnmneaXmmJ7M2DCh9g=
X-Google-Smtp-Source: ABdhPJyP8HJlSTai+vcBxS4V7LXTWrEOfp1rNKWJ8hrEnvT9KdNn/GE2gqtjW3JuXID/TJTQaI/afw==
X-Received: by 2002:a2e:8e28:: with SMTP id r8mr13086965ljk.460.1590443409926; 
 Mon, 25 May 2020 14:50:09 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-22.NA.cust.bahnhof.se.
 [158.174.22.22])
 by smtp.gmail.com with ESMTPSA id e21sm3893338ljj.86.2020.05.25.14.50.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2020 14:50:09 -0700 (PDT)
From: Rikard Falkeborn <rikard.falkeborn@gmail.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 2/2] iommu/sun50i: Constify sun50i_iommu_ops
Date: Mon, 25 May 2020 23:49:58 +0200
Message-Id: <20200525214958.30015-3-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200525214958.30015-1-rikard.falkeborn@gmail.com>
References: <20200525214958.30015-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
X-Mailman-Approved-At: Mon, 25 May 2020 23:26:27 +0000
Cc: Chen-Yu Tsai <wens@csie.org>, Maxime Ripard <mripard@kernel.org>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Rikard Falkeborn <rikard.falkeborn@gmail.com>,
 linux-arm-kernel@lists.infradead.org
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

The struct sun50i_iommu_ops is not modified and can be made const to
allow the compiler to put it in read-only memory.

Before:
   text    data     bss     dec     hex filename
  14358    2501      64   16923    421b drivers/iommu/sun50i-iommu.o

After:
   text    data     bss     dec     hex filename
  14726    2117      64   16907    420b drivers/iommu/sun50i-iommu.o

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 drivers/iommu/sun50i-iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/sun50i-iommu.c b/drivers/iommu/sun50i-iommu.c
index 1fa09ddcebd4..fce605e96aa2 100644
--- a/drivers/iommu/sun50i-iommu.c
+++ b/drivers/iommu/sun50i-iommu.c
@@ -771,7 +771,7 @@ static int sun50i_iommu_of_xlate(struct device *dev,
 	return iommu_fwspec_add_ids(dev, &id, 1);
 }
 
-static struct iommu_ops sun50i_iommu_ops = {
+static const struct iommu_ops sun50i_iommu_ops = {
 	.pgsize_bitmap	= SZ_4K,
 	.attach_dev	= sun50i_iommu_attach_device,
 	.detach_dev	= sun50i_iommu_detach_device,
-- 
2.26.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
