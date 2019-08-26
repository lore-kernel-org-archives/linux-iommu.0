Return-Path: <SRS0=vyM6=WW=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C542C3A59E
	for <iommu@archiver.kernel.org>; Mon, 26 Aug 2019 04:48:51 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12DA8217F4
	for <iommu@archiver.kernel.org>; Mon, 26 Aug 2019 04:48:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tcd-ie.20150623.gappssmtp.com header.i=@tcd-ie.20150623.gappssmtp.com header.b="BsO0/bHV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12DA8217F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tcd.ie
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id EF1FD18FD;
	Mon, 26 Aug 2019 04:48:49 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id D8C7118F7
	for <iommu@lists.linux-foundation.org>;
	Mon, 26 Aug 2019 04:48:31 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com
	[209.85.221.65])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id BE1891FB
	for <iommu@lists.linux-foundation.org>;
	Mon, 26 Aug 2019 04:48:30 +0000 (UTC)
Received: by mail-wr1-f65.google.com with SMTP id c3so13910135wrd.7
	for <iommu@lists.linux-foundation.org>;
	Sun, 25 Aug 2019 21:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=tcd-ie.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=I1X3WOpXG5XCDr09buC6cHm1zmHyPqzvS2NgnTCXAzY=;
	b=BsO0/bHVOCA6KrgOFcyhpwuwM0sXDhof1v9dGcGxaQRPyLQI1w0E3UOjivetqc6jkM
	kss2brU/g8NmgjGFUs42UGbwzNgjMBU5Kr1fS1YmGuSiRX+EzqKSaXJv2ggy5DNs00nq
	c/uM8KuuYKdSaFYBwUJ9UVInJr0FEA0NWClfF45ew6OX5wLg47V3wivuwulCiqu0+xzl
	yS4bCm+fQClVVelO+FtuxWyAb9/NOMf3rJzJ/9VhZEW72zCIOyka7LCKKeFg95HmMaOo
	LyjqSlurgShPx4UpuIsoWuflvAN13w6F0PlhkVoKrd8Tu89H3/RXhqqzFZtlCJHWlBGJ
	yhLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=I1X3WOpXG5XCDr09buC6cHm1zmHyPqzvS2NgnTCXAzY=;
	b=HVUZju248n6fFbFF4yTLKW4KYY+WJ6s419y2YjYAodFz2/WYQFAbionz/n0vrpLhXN
	TpMyAWSZqvWRM/AV2SUY1uvPEmZK3xgGZG3uqOHPhb4QG/yt+Hrwn4SlBbQiUytckRbg
	bkBbr3x0rzO6r5mK/MWZTJjIgs/tg2Bu3yq2zT8ZiLnR+manYaE2qACAjND5MxqRTkml
	N/D+wBzLkKcFrNLGQ/4lQflIExshw+Vqz+qQ3/Y3HFs8N8oQ+kkL8CTtQnIhYJFuaQ7I
	V4jrm83xp9yNJydU/GhYvvJlmCtYxrFB5dFBqKlgdUDMtWzTLHMSwfwrboXXLGTIHCfC
	rRPw==
X-Gm-Message-State: APjAAAVLia6x2l/BNWSCavncQUI1ie8fikgGb7i5wT4TsyiEIT2L0WfC
	NxqsCVvDvRyjgq8sspYBuau0WnIBVP98sw==
X-Google-Smtp-Source: APXvYqwDsITf3mbd65loamqP7b0Ty+DNRnFPz243wljEeyIXMr7T5Da9pRhckNq3wv/+LrtBaJb1oQ==
X-Received: by 2002:a5d:500c:: with SMTP id e12mr18225920wrt.213.1566794908961;
	Sun, 25 Aug 2019 21:48:28 -0700 (PDT)
Received: from localhost.localdomain (ip-89-102-174-174.net.upcbroadband.cz.
	[89.102.174.174]) by smtp.googlemail.com with ESMTPSA id
	n9sm11799010wrp.54.2019.08.25.21.48.27
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Sun, 25 Aug 2019 21:48:28 -0700 (PDT)
From: Tom Murphy <murphyt7@tcd.ie>
To: iommu@lists.linux-foundation.org
Subject: [PATCH] Remove wrong default domain comments
Date: Mon, 26 Aug 2019 05:48:21 +0100
Message-Id: <20190826044821.27017-1-murphyt7@tcd.ie>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Cc: linux-kernel@vger.kernel.org, Tom Murphy <murphyt7@tcd.ie>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

These comments are wrong. request_default_domain_for_dev doesn't just
handle direct mapped domains.

Signed-off-by: Tom Murphy <murphyt7@tcd.ie>
---
 drivers/iommu/iommu.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index ea95080372e7..3b6807e7a2d8 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2179,7 +2179,6 @@ request_default_domain_for_dev(struct device *dev, unsigned long type)
 
 	mutex_lock(&group->mutex);
 
-	/* Check if the default domain is already direct mapped */
 	ret = 0;
 	if (group->default_domain && group->default_domain->type == type)
 		goto out;
@@ -2189,7 +2188,6 @@ request_default_domain_for_dev(struct device *dev, unsigned long type)
 	if (iommu_group_device_count(group) != 1)
 		goto out;
 
-	/* Allocate a direct mapped domain */
 	ret = -ENOMEM;
 	domain = __iommu_domain_alloc(dev->bus, type);
 	if (!domain)
@@ -2204,7 +2202,7 @@ request_default_domain_for_dev(struct device *dev, unsigned long type)
 
 	iommu_group_create_direct_mappings(group, dev);
 
-	/* Make the direct mapped domain the default for this group */
+	/* Make the domain the default for this group */
 	if (group->default_domain)
 		iommu_domain_free(group->default_domain);
 	group->default_domain = domain;
-- 
2.20.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
