Return-Path: <SRS0=4TkS=7K=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39756C433DF
	for <iommu@archiver.kernel.org>; Thu, 28 May 2020 08:03:25 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D56E52063A
	for <iommu@archiver.kernel.org>; Thu, 28 May 2020 08:03:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="OVZd9pGw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D56E52063A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 9922188B47;
	Thu, 28 May 2020 08:03:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Oo20sXhs5Jx8; Thu, 28 May 2020 08:03:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id F0A7988B33;
	Thu, 28 May 2020 08:03:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D8ED9C07FF;
	Thu, 28 May 2020 08:03:23 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E45E1C016F
 for <iommu@lists.linux-foundation.org>; Wed, 27 May 2020 21:10:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id E01BE86EDE
 for <iommu@lists.linux-foundation.org>; Wed, 27 May 2020 21:10:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JE0DjYoRlpme for <iommu@lists.linux-foundation.org>;
 Wed, 27 May 2020 21:10:17 +0000 (UTC)
X-Greylist: delayed 00:09:48 by SQLgrey-1.7.6
Received: from mta-p6.oit.umn.edu (mta-p6.oit.umn.edu [134.84.196.206])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 70E59845AA
 for <iommu@lists.linux-foundation.org>; Wed, 27 May 2020 21:10:17 +0000 (UTC)
Received: from localhost (unknown [127.0.0.1])
 by mta-p6.oit.umn.edu (Postfix) with ESMTP id 49XNWw4j30z9vZ6Z
 for <iommu@lists.linux-foundation.org>; Wed, 27 May 2020 21:00:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p6.oit.umn.edu ([127.0.0.1])
 by localhost (mta-p6.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UuGbKFaeLFS3 for <iommu@lists.linux-foundation.org>;
 Wed, 27 May 2020 16:00:28 -0500 (CDT)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mta-p6.oit.umn.edu (Postfix) with ESMTPS id 49XNWw31QKz9vZ2s
 for <iommu@lists.linux-foundation.org>; Wed, 27 May 2020 16:00:28 -0500 (CDT)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p6.oit.umn.edu 49XNWw31QKz9vZ2s
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p6.oit.umn.edu 49XNWw31QKz9vZ2s
Received: by mail-io1-f71.google.com with SMTP id p8so5302567ios.19
 for <iommu@lists.linux-foundation.org>; Wed, 27 May 2020 14:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=umn.edu; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=HUfddYaBDcQ1QFr6cz0pOekNbdRK7nMNiK7RoAnFctQ=;
 b=OVZd9pGw7a7FtLUoDlyqoKQRPkb4QEIFCuj9r1b3w32QVRGgZFh5etltRHQZ9pckuj
 bQ8XwVKasUGKFmtLOa0tmIFQj/vQ6EztlbZr5XDxCAxp74DMxkZN9zeoRRzxdPQayYTz
 fHHoVYAyb9ontJDCSfHtt0JmjCGSPQdphgwSBghRZUuFVPlyisvqdtRz+zLI+63AqeMw
 Sc35eiWj2Je/MM75T6xXotPeaOXTATxORSfeZhWbjJeucB/KEmNXe5KFMwQJbRLpNsJq
 h/w5K2WBpVsGz1RprHf5gfMDOL/gxJWuBV/1U+tFQ0lUslgGWYBe88rajbMw6IDu4vrp
 DWXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=HUfddYaBDcQ1QFr6cz0pOekNbdRK7nMNiK7RoAnFctQ=;
 b=Nds66FcgZ9orhvvAf5AOicD4AtcZbCr67lGprK+d+U95q8dyxJQ4tLCdtsPm8bwSva
 kH8726nO9NGDGSZCKT/KI+iXSF4vc09ghapuGYEbeS1ggCm5rb753MUVhPFs7zX+z/eL
 uPnehjbPA++1Q3WElXP0LNIcvhiCdC00I8HQoJMA/P37cCP3kywPgYNywXIjd1fM+oEv
 2Ygge+O3gc8xztFam4aIC0fFqnlRHPTYP+gmkFaMMZGUXe2vw9Q0WG7/cFaw02780l1h
 vvzI5ciI/UtecaHs1X2sZM1N1J64WNnS+ctFbQv6avvDEOTNo3ShzSSbP3fpdId1sF03
 csKA==
X-Gm-Message-State: AOAM533s7B6aBK+zix8TGC5YpxBKxEF2ZgMVfl+degnd7m8rtr73UBj0
 qAIsZTgFjrLfmSQyeD0xRykJhpOC4aYUUYsS6TyfpoS23rrh641/oi0f+4t+W5UJkyPCGBeEPR1
 t93gMD94uDer2OmTSOPMpL2jlVuFAzJux2w==
X-Received: by 2002:a5d:9a87:: with SMTP id c7mr10986366iom.152.1590613227949; 
 Wed, 27 May 2020 14:00:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxYzzsZr67+NLlaukFPS7WCxvFJ71Vx5yVwL4woKj59hxFx7OukcGbcZtO43XVWAP+Pn1Z8wQ==
X-Received: by 2002:a5d:9a87:: with SMTP id c7mr10986340iom.152.1590613227572; 
 Wed, 27 May 2020 14:00:27 -0700 (PDT)
Received: from qiushi.dtc.umn.edu (cs-kh5248-02-umh.cs.umn.edu.
 [128.101.106.4])
 by smtp.gmail.com with ESMTPSA id o18sm2078369ils.30.2020.05.27.14.00.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 May 2020 14:00:26 -0700 (PDT)
To: kjlu@umn.edu
Subject: [PATCH] iommu: Fix reference count leak in iommu_group_alloc.
Date: Wed, 27 May 2020 16:00:19 -0500
Message-Id: <20200527210020.6522-1-wu000273@umn.edu>
X-Mailer: git-send-email 2.17.1
X-Mailman-Approved-At: Thu, 28 May 2020 08:03:22 +0000
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Alex Williamson <alex.williamson@redhat.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, wu000273@umn.edu
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
From: wu000273--- via iommu <iommu@lists.linux-foundation.org>
Reply-To: wu000273@umn.edu
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

From: Qiushi Wu <wu000273@umn.edu>

kobject_init_and_add() takes reference even when it fails.
Thus, when kobject_init_and_add() returns an error,
kobject_put() must be called to properly clean up the kobject.

Fixes: d72e31c93746 ("iommu: IOMMU Groups")
Signed-off-by: Qiushi Wu <wu000273@umn.edu>
---
 drivers/iommu/iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 1faa08c8bbb4..03d6a26687bc 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -510,7 +510,7 @@ struct iommu_group *iommu_group_alloc(void)
 				   NULL, "%d", group->id);
 	if (ret) {
 		ida_simple_remove(&iommu_group_ida, group->id);
-		kfree(group);
+		kobject_put(&group->kobj);
 		return ERR_PTR(ret);
 	}
 
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
