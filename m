Return-Path: <SRS0=eKRE=6H=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33C3CC54FCB
	for <iommu@archiver.kernel.org>; Thu, 23 Apr 2020 17:48:05 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5D1B20781
	for <iommu@archiver.kernel.org>; Thu, 23 Apr 2020 17:48:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="fuvjwaAR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5D1B20781
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id A37908769A;
	Thu, 23 Apr 2020 17:48:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0FVLT0C3eeoy; Thu, 23 Apr 2020 17:48:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id D4BFA8764B;
	Thu, 23 Apr 2020 17:48:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C8CBAC1AE2;
	Thu, 23 Apr 2020 17:48:03 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3B42CC0175
 for <iommu@lists.linux-foundation.org>; Thu, 23 Apr 2020 17:39:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 311FA86DA6
 for <iommu@lists.linux-foundation.org>; Thu, 23 Apr 2020 17:39:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZztDmkDEJQQX for <iommu@lists.linux-foundation.org>;
 Thu, 23 Apr 2020 17:39:24 +0000 (UTC)
X-Greylist: delayed 00:59:54 by SQLgrey-1.7.6
Received: from mail-il1-f202.google.com (mail-il1-f202.google.com
 [209.85.166.202])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 97BF086DA3
 for <iommu@lists.linux-foundation.org>; Thu, 23 Apr 2020 17:39:24 +0000 (UTC)
Received: by mail-il1-f202.google.com with SMTP id l16so6379487ilf.9
 for <iommu@lists.linux-foundation.org>; Thu, 23 Apr 2020 10:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:message-id:mime-version:subject:from:to:cc;
 bh=ikhwXMnlwGzrquO4bB2D9mZhD1eHpr5ZuB09BqCbiIo=;
 b=fuvjwaAR86dSg8zxHkeLK7Nt9sICRGh4ZO78KP7vpmeVUL3rHN3OkbVyeT6IgLtD2m
 lwigeF4Y6AMZ4tbmIy44/imJGiqHUhE9fIf2Nm40sGjHunfz2HdYK2CNDCq54fURCT2A
 Edwux2IjdHEO9ML8ngWHt6DB1sD5hxBwwzCywN9EYEncbJbmTMyUb1sSKypV5ZavJ7ea
 RsMMiZMRR+ZYgFi0eNPWVZbt+5a3HmD5NbBhgxTCwy0qH/MLnJCN3yZzv/cgfpXhfN6M
 /cDE1hxtKbs+jbD4Ym6hwOA3ZjZBA7HAbeP3o6Hc0Gx7+jB8fuUd8o7FWkkQDK0Il4Yq
 30cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
 bh=ikhwXMnlwGzrquO4bB2D9mZhD1eHpr5ZuB09BqCbiIo=;
 b=aqN0QwxGz3hNbvF3so/HCD28udyRWugV5SB+Fxn2kaniL2TQzC6ZE9cel7MtLaQ5A3
 3K1nid0XH+0d0dS89hGTN6t3UsiX6FSrNehIoJfs7Nbi8Lq8X+g4B2ML8w2wozXygLSq
 t55L4+Mdsj8RYyZVA2qVqTny+8YzddX2V+OXSsaLw6KoYLb7av96zLpW/BYXhbE/HuEU
 h2g0R3sJX/uOhhnr0u5hrQlJIkGSsMxqe2TvzIPp30NEUUPh7dC74ivCmM390ukGqQJU
 zL6gfdkD3GpOFSaV9QVChItcW+P3fJa0bTjIXJaRveMPw7OVxIq22NprwLnxXQFKhRWW
 pp+A==
X-Gm-Message-State: AGi0PuYWfHEqTItWnLuoYKGsTIZ2adtTmQHW7Z8+BK4qM99vdkz7B2uh
 FuNnUhm+hJRG3HfT9N1eYydoM2Y=
X-Google-Smtp-Source: APiQypJR6w8eTc3wDP8A/BF0ks/5eADi/JCdBlgG8YJy/2fYfKm+FAEUJovtGytKLIwo8CikGFt8iig=
X-Received: by 2002:a65:5846:: with SMTP id s6mr4695772pgr.370.1587659499009; 
 Thu, 23 Apr 2020 09:31:39 -0700 (PDT)
Date: Thu, 23 Apr 2020 09:31:31 -0700
Message-Id: <20200423163131.12896-1-pcc@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.2.303.gf8c07b1a785-goog
Subject: [PATCH] dma-contiguous: fix comment for dma_release_from_contiguous
To: Christoph Hellwig <hch@lst.de>
X-Mailman-Approved-At: Thu, 23 Apr 2020 17:48:02 +0000
Cc: iommu@lists.linux-foundation.org, Peter Collingbourne <pcc@google.com>
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
From: Peter Collingbourne via iommu <iommu@lists.linux-foundation.org>
Reply-To: Peter Collingbourne <pcc@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Commit 90ae409f9eb3 ("dma-direct: fix zone selection
after an unaddressable CMA allocation") changed the logic in
dma_release_from_contiguous to remove the normal pages fallback path,
but did not update the comment. Fix that.

Signed-off-by: Peter Collingbourne <pcc@google.com>
---
 kernel/dma/contiguous.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
index 8bc6f2d670f9..15bc5026c485 100644
--- a/kernel/dma/contiguous.c
+++ b/kernel/dma/contiguous.c
@@ -222,8 +222,8 @@ bool dma_release_from_contiguous(struct device *dev, struct page *pages,
  * @gfp:   Allocation flags.
  *
  * This function allocates contiguous memory buffer for specified device. It
- * first tries to use device specific contiguous memory area if available or
- * the default global one, then tries a fallback allocation of normal pages.
+ * tries to use device specific contiguous memory area if available, or the
+ * default global one.
  *
  * Note that it byapss one-page size of allocations from the global area as
  * the addresses within one page are always contiguous, so there is no need
-- 
2.26.2.303.gf8c07b1a785-goog

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
