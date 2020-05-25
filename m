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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0A85C433E0
	for <iommu@archiver.kernel.org>; Mon, 25 May 2020 23:26:29 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 434D62071A
	for <iommu@archiver.kernel.org>; Mon, 25 May 2020 23:26:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UGNcoda8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 434D62071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 0DDC187535;
	Mon, 25 May 2020 23:26:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nxRZS9DDCMBI; Mon, 25 May 2020 23:26:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 4110B8738A;
	Mon, 25 May 2020 23:26:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2DFAAC0892;
	Mon, 25 May 2020 23:26:28 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AB285C088D
 for <iommu@lists.linux-foundation.org>; Mon, 25 May 2020 21:50:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 8919187E5F
 for <iommu@lists.linux-foundation.org>; Mon, 25 May 2020 21:50:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id q7opXIB32KCp for <iommu@lists.linux-foundation.org>;
 Mon, 25 May 2020 21:50:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-lj1-f195.google.com (mail-lj1-f195.google.com
 [209.85.208.195])
 by hemlock.osuosl.org (Postfix) with ESMTPS id A2B3487E2E
 for <iommu@lists.linux-foundation.org>; Mon, 25 May 2020 21:50:10 +0000 (UTC)
Received: by mail-lj1-f195.google.com with SMTP id c11so20003320ljn.2
 for <iommu@lists.linux-foundation.org>; Mon, 25 May 2020 14:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=e3gzvIrCtH9Df/NLmyQMD/XYXqiL8jSn2MtUonIxWb8=;
 b=UGNcoda8+SrBWS7eulpI4+FnLj5J6/Qee9MfQ+/mv07vDKuYqIwXG98ShBDrOQze8u
 wR3LZYyo+cv6CWB20fqbmm0i5XxQxg84cgG0STwWelmCH+AvvzlSrHryTMvNsP+GqCvO
 sJSMKKYhR8bNrwiw3PT9zWgeG6pFhpLB3Mw6+vfIfVz6VJGqCOE0EkToek2TMphmPbcv
 W/1OTgvsrHvlvnhB6hyLES6yYtCPZYafElc3zm1f64n/pcBEzdJ2XVwI0H9RYCpVjsTM
 H41UnbpToNdVYqt9gD0D5tGHycJmlNxCdFbgzMtR9cy9Wtj0LNeNfOt0db2/9QDedjUQ
 AQ4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=e3gzvIrCtH9Df/NLmyQMD/XYXqiL8jSn2MtUonIxWb8=;
 b=lZzHIglX20x5p5CRkaPt8FKOKBGtkhOFP/KZXd6tx1ZH1Eqx36chk6MeaB5HcTcnvH
 JhCrEad6flOjUnnYpVXSssfISDIGJSMC34DAGFmSd+nFuf6NNj0OGR1nX7ND+9n+LXQi
 UdD2Fb8K9+8fzKUoc8tbUGTy9/O1rZd1u+4H1CMYPNnkePjBMNH88Mot7ClGX20uIR9+
 J0I3EP98gjWRswQlXFLt0IjZ9VsnTwciZ0/D2ug60p9RSN2t8Sh1nR1cXR/r/icVay8P
 5vJ+mtupKnbSpOqU05bh7Rh7RzUwHQ/p2rkYep5untBta7wUuwX5WZESLV4Thmk+I2bo
 NX1A==
X-Gm-Message-State: AOAM5338jLohFBNmoPflpEJ9mpBDp8b8/syjGxWIVr74BQJEiWfNtdYn
 ybjivPSwOVW/chnlp3IHF3w=
X-Google-Smtp-Source: ABdhPJx9X4aZu61ScTGP3NPyoUfBhL/rS1/qN/91Xs7Cn5s8cR7dXu4bbV3uTG/t0k31ksONuNAa/w==
X-Received: by 2002:a05:651c:1211:: with SMTP id
 i17mr14646090lja.56.1590443408808; 
 Mon, 25 May 2020 14:50:08 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-22.NA.cust.bahnhof.se.
 [158.174.22.22])
 by smtp.gmail.com with ESMTPSA id e21sm3893338ljj.86.2020.05.25.14.50.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2020 14:50:08 -0700 (PDT)
From: Rikard Falkeborn <rikard.falkeborn@gmail.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 1/2] iommu/hyper-v: Constify hyperv_ir_domain_ops
Date: Mon, 25 May 2020 23:49:57 +0200
Message-Id: <20200525214958.30015-2-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200525214958.30015-1-rikard.falkeborn@gmail.com>
References: <20200525214958.30015-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
X-Mailman-Approved-At: Mon, 25 May 2020 23:26:27 +0000
Cc: Wei Liu <wei.liu@kernel.org>, Stephen Hemminger <sthemmin@microsoft.com>,
 linux-hyperv@vger.kernel.org, Haiyang Zhang <haiyangz@microsoft.com>,
 linux-kernel@vger.kernel.org, Rikard Falkeborn <rikard.falkeborn@gmail.com>,
 iommu@lists.linux-foundation.org, "K. Y. Srinivasan" <kys@microsoft.com>
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

The struct hyperv_ir_domain_ops is not modified and can be made const to
allow the compiler to put it in read-only memory.

Before:
   text    data     bss     dec     hex filename
   2916    1180    1120    5216    1460 drivers/iommu/hyperv-iommu.o

After:
   text    data     bss     dec     hex filename
   3044    1052    1120    5216    1460 drivers/iommu/hyperv-iommu.o

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 drivers/iommu/hyperv-iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/hyperv-iommu.c b/drivers/iommu/hyperv-iommu.c
index a386b83e0e34..3c0c67a99c7b 100644
--- a/drivers/iommu/hyperv-iommu.c
+++ b/drivers/iommu/hyperv-iommu.c
@@ -131,7 +131,7 @@ static int hyperv_irq_remapping_activate(struct irq_domain *domain,
 	return 0;
 }
 
-static struct irq_domain_ops hyperv_ir_domain_ops = {
+static const struct irq_domain_ops hyperv_ir_domain_ops = {
 	.alloc = hyperv_irq_remapping_alloc,
 	.free = hyperv_irq_remapping_free,
 	.activate = hyperv_irq_remapping_activate,
-- 
2.26.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
