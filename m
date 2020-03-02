Return-Path: <SRS0=ZrTS=4T=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07374C3F2CD
	for <iommu@archiver.kernel.org>; Mon,  2 Mar 2020 00:05:31 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBAE3246A1
	for <iommu@archiver.kernel.org>; Mon,  2 Mar 2020 00:05:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="jCcOCzMo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBAE3246A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id BB2FA850E0;
	Mon,  2 Mar 2020 00:05:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lJ8Gv8tprFMh; Mon,  2 Mar 2020 00:05:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 5CE16850AD;
	Mon,  2 Mar 2020 00:05:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4AAF3C1D74;
	Mon,  2 Mar 2020 00:05:30 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B52AFC013E
 for <iommu@lists.linux-foundation.org>; Mon,  2 Mar 2020 00:05:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id A4B1D850DC
 for <iommu@lists.linux-foundation.org>; Mon,  2 Mar 2020 00:05:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aXqATJL89dQ5 for <iommu@lists.linux-foundation.org>;
 Mon,  2 Mar 2020 00:05:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com
 [209.85.214.194])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 49FD8850AD
 for <iommu@lists.linux-foundation.org>; Mon,  2 Mar 2020 00:05:29 +0000 (UTC)
Received: by mail-pl1-f194.google.com with SMTP id b22so3455760pls.12
 for <iommu@lists.linux-foundation.org>; Sun, 01 Mar 2020 16:05:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:from:to:cc:subject:in-reply-to:message-id:references
 :user-agent:mime-version;
 bh=VL/26nrsiNq7DuIRWSkkYww+xvM85UOTiZtGPRjHpNk=;
 b=jCcOCzMoAkxXO+a3yWBfOiJ45Uf6bESOwIkL0nuReQm+hXnoJwd7QNZ95iQfEwf5FS
 WDMU+u651Q4nSYiMAm/0Ch3j097L+dqdbcR31evCgWTwULhVye/8jN3qTlzIHyhWPwJu
 6xUPh3PHJkODxQRc8C/UfjU76yJ2NInhCAgHQe4py8NJBxKXJci9b5h5Xb/WzNciCZU9
 dLlMhG28C6RkaL7YiovEpJnGm2sgg27WuFd+cJqOLibTFDx5dxfYqgEaBhOZoCeg2Fv8
 iL8SVfJLrpEwEPdgkDiBTC1OpG5PRYqxpL1dOmG63t9l8NzL7KTifBuJixO7irce2jiW
 Tyxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
 :references:user-agent:mime-version;
 bh=VL/26nrsiNq7DuIRWSkkYww+xvM85UOTiZtGPRjHpNk=;
 b=b2A7djsZsuE+FNBIhXPdlbE3vhd8m7V5BVbvx/5mlj6MJqBhN6pVQVn61A9fxI6gtZ
 1ZswN89hI208dFDdQQjS57JIpa331AlSPCJIUEWHZX/eRk+XpIoytDuRB2a5ptgFlOm0
 zZvT3sMOR+m56e2FvHcqeuxP5eZ5bqfnR62/LAbVeBL8Nn30zNoihBUuAVRIRUt+bEem
 pXDdCs++5nWM1AnismB9XTIRo9IYS8AUTmlOFJWIcWFQUqD7uB7olcT//z7th6ztSZQc
 jMo+qkcglJgMFkgQqUMepfTeMeqQS4DRqZywiS/HqArmpNryjtK+bqkLWm8UKsrN9lmK
 J4Nw==
X-Gm-Message-State: APjAAAWc2yHkgFXi8MmwWLIBGhnc036XsF2RAWeMxicrznCmgUXIW+qo
 lWvYERLOy/Bd6EFGsT4f1QjFfg==
X-Google-Smtp-Source: APXvYqzqeaKgu+c5hg3xiux6d/gAKzclk0nAOi5btZcltM3q4Pmip+LPzmAcInXe2EcrK9zDHpR/MQ==
X-Received: by 2002:a17:902:6ac3:: with SMTP id
 i3mr15245429plt.111.1583107528727; 
 Sun, 01 Mar 2020 16:05:28 -0800 (PST)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598]
 ([2620:15c:17:3:3a5:23a7:5e32:4598])
 by smtp.gmail.com with ESMTPSA id l25sm18140080pgn.47.2020.03.01.16.05.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Mar 2020 16:05:28 -0800 (PST)
Date: Sun, 1 Mar 2020 16:05:27 -0800 (PST)
X-X-Sender: rientjes@chino.kir.corp.google.com
To: Christoph Hellwig <hch@lst.de>, Tom Lendacky <thomas.lendacky@amd.com>
Subject: [rfc 6/6] dma-remap: double the default DMA coherent pool size
In-Reply-To: <alpine.DEB.2.21.2003011535510.213582@chino.kir.corp.google.com>
Message-ID: <alpine.DEB.2.21.2003011538260.213582@chino.kir.corp.google.com>
References: <alpine.DEB.2.21.1912311738130.68206@chino.kir.corp.google.com>
 <b22416ec-cc28-3fd2-3a10-89840be173fa@amd.com>
 <alpine.DEB.2.21.2002280118461.165532@chino.kir.corp.google.com>
 <alpine.DEB.2.21.2003011535510.213582@chino.kir.corp.google.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Cc: "Singh, Brijesh" <brijesh.singh@amd.com>, "Grimm, Jon" <jon.grimm@amd.com>,
 baekhw@google.com,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
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
From: David Rientjes via iommu <iommu@lists.linux-foundation.org>
Reply-To: David Rientjes <rientjes@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

When AMD memory encryption is enabled, some devices may used more than
256KB/sec from the atomic pools.  Double the default size to make the
original size and expansion more appropriate.

This provides a slight optimization on initial expansion and is deemed
appropriate for all configs with CONFIG_DMA_REMAP enabled because of the
increased reliance on the atomic pools.

Alternatively, this could be done only when CONFIG_AMD_MEM_ENCRYPT is
enabled.

Signed-off-by: David Rientjes <rientjes@google.com>
---
 kernel/dma/remap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/dma/remap.c b/kernel/dma/remap.c
--- a/kernel/dma/remap.c
+++ b/kernel/dma/remap.c
@@ -105,7 +105,7 @@ static struct gen_pool *atomic_pool __ro_after_init;
 static struct gen_pool *atomic_pool_dma32 __ro_after_init;
 static struct gen_pool *atomic_pool_normal __ro_after_init;
 
-#define DEFAULT_DMA_COHERENT_POOL_SIZE  SZ_256K
+#define DEFAULT_DMA_COHERENT_POOL_SIZE  SZ_512K
 static size_t atomic_pool_size = DEFAULT_DMA_COHERENT_POOL_SIZE;
 
 /* Dynamic background expansion when the atomic pool is near capacity */
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
