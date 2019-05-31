Return-Path: <SRS0=mJb0=T7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7058AC04AB6
	for <iommu@archiver.kernel.org>; Fri, 31 May 2019 20:17:47 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1254A247B6
	for <iommu@archiver.kernel.org>; Fri, 31 May 2019 20:17:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="tCjkZ8iy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1254A247B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lca.pw
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id D26D31931;
	Fri, 31 May 2019 20:17:46 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 7F3CC192F
	for <iommu@lists.linux-foundation.org>;
	Fri, 31 May 2019 20:16:22 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-qk1-f195.google.com (mail-qk1-f195.google.com
	[209.85.222.195])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 1258589C
	for <iommu@lists.linux-foundation.org>;
	Fri, 31 May 2019 20:16:21 +0000 (UTC)
Received: by mail-qk1-f195.google.com with SMTP id l128so7182847qke.2
	for <iommu@lists.linux-foundation.org>;
	Fri, 31 May 2019 13:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lca.pw; s=google;
	h=from:to:cc:subject:date:message-id;
	bh=r1ZINiqMC0wxlld9QMTJmz5jWV4jlbebAasegE3Ledc=;
	b=tCjkZ8iytNNlII4EhkPmrM+JWWmfhjRRm/cYg2PDXqGZe2bQr8lQ5AEqWds671Sq41
	/Z7dEJHPjarRv7wcDPjxybrFlpZxgsRkWVUrhealG2hZolvmWH7u/AyiZSgupmtq1pbk
	dBnve1MTt+rsCQQAjP5UTERnPqXgT1fLduR/qkwfbwEsFN3ti1dh0kmdO0GHDVV4aXEs
	N03LovIZ0/2Ewk86i75/1bnMI+Mu1PyAVy62tKxZDFLbLxk7UzFvJi42apXFyJ0jaE8Z
	Oyj6uZqxrdGCA01rRzhooRnA4BtGtm187DhH0VnmBSedMl1Y5UEs+JE+Lqs4mXaeiMEt
	z47A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=r1ZINiqMC0wxlld9QMTJmz5jWV4jlbebAasegE3Ledc=;
	b=gPpLUrrG3TAP/QICFrCSfXkF9eWLPHBi/TruFIlmg8Yn91/m4vemPMfJq85qJ7p4Fq
	iUTrg5/IJe+eLdPE3oGkPdLhOp68REAd4Kr6yBxqCtI2czmGtRXWpJnBXYcttf+ZKd/7
	eEFuG9s2xj1/9D4MBL1zx3+V6HD4o4TSYsIDi7pv0qgFl8HLc38tNJtydalVwRh6EZrM
	YCPMor0LITmgMLEw5SAfPiObOPtfSADMnOBSUEFJSYevC9uqA+C7AjfUfUYedYkaq3uk
	ZUpMknXB+VCxgxMG8ZVwMsbyHJxk5ngB4kXh0cn+0iyYwbtBw4DD7webzGxTyA32i+vz
	B+kw==
X-Gm-Message-State: APjAAAUah15miYQOGrFmPrg3EcHvyeqWlJflHH2Tr3CxKlu+ngSbtSav
	Y6npgBfOMtt/a5jSRSafSK/GYA==
X-Google-Smtp-Source: APXvYqyoBBIeLIKPc7eNaHX572ejYUeQ95Q9RZYT/nFVi4qNHT150g2pb0ZRKfhpbfnCvP5ZclDTXA==
X-Received: by 2002:a37:8105:: with SMTP id c5mr9932705qkd.192.1559333781173; 
	Fri, 31 May 2019 13:16:21 -0700 (PDT)
Received: from qcai.nay.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
	by smtp.gmail.com with ESMTPSA id
	z20sm4842639qtz.34.2019.05.31.13.16.19
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 31 May 2019 13:16:20 -0700 (PDT)
From: Qian Cai <cai@lca.pw>
To: jroedel@suse.de
Subject: [PATCH -next] intel-iommu: fix a variable set but not used
Date: Fri, 31 May 2019 16:16:02 -0400
Message-Id: <1559333762-2436-1-git-send-email-cai@lca.pw>
X-Mailer: git-send-email 1.8.3.1
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
	Qian Cai <cai@lca.pw>, dwmw2@infradead.org
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

The commit "iommu/vt-d: Delegate the dma domain to upper layer" left an
unused variable,

drivers/iommu/intel-iommu.c: In function 'disable_dmar_iommu':
drivers/iommu/intel-iommu.c:1652:23: warning: variable 'domain' set but
not used [-Wunused-but-set-variable]

Signed-off-by: Qian Cai <cai@lca.pw>
---
 drivers/iommu/intel-iommu.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index b431cc6f6ba4..073c547f247a 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -1649,16 +1649,12 @@ static void disable_dmar_iommu(struct intel_iommu *iommu)
 
 	spin_lock_irqsave(&device_domain_lock, flags);
 	list_for_each_entry_safe(info, tmp, &device_domain_list, global) {
-		struct dmar_domain *domain;
-
 		if (info->iommu != iommu)
 			continue;
 
 		if (!info->dev || !info->domain)
 			continue;
 
-		domain = info->domain;
-
 		__dmar_remove_one_dev_info(info);
 	}
 	spin_unlock_irqrestore(&device_domain_lock, flags);
-- 
1.8.3.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
