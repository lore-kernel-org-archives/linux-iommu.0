Return-Path: <SRS0=qghM=VB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8C39C0650E
	for <iommu@archiver.kernel.org>; Thu,  4 Jul 2019 03:33:12 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B51982082E
	for <iommu@archiver.kernel.org>; Thu,  4 Jul 2019 03:33:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j8/08T8J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B51982082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 54437C4E;
	Thu,  4 Jul 2019 03:33:12 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id B9144C9F
	for <iommu@lists.linux-foundation.org>;
	Thu,  4 Jul 2019 02:36:27 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com
	[209.85.215.195])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id B9A3087C
	for <iommu@lists.linux-foundation.org>;
	Thu,  4 Jul 2019 02:36:26 +0000 (UTC)
Received: by mail-pg1-f195.google.com with SMTP id i18so2140346pgl.11
	for <iommu@lists.linux-foundation.org>;
	Wed, 03 Jul 2019 19:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id;
	bh=3tmiZiCH2XBVN5DuJQwuRPNtjxIcwvAWUQCPl8nlFS8=;
	b=j8/08T8J4krcY8oeDaG8iVVGo9lDUlLhT7nM08zXXc+dclnwsab6iqduH7tHilXg1g
	iSLsCS3QNXdkfi1FhjmW4M+qjeb6irGtZkh2B23TfRkOwhSRUjIrxy49y5Jortjk3bqM
	F4tnycg+yEFACC1trpDUiej9M3IDJ8sncAwMfoeeVJlMNr+FfVENXns0vMOLK09IAINS
	mJAG107H+F/holFUJnJS+bcpCZXn+xtxxC9qXA20WHYLRo/ss977B1Hi8tqclnGhOH/D
	0UGxKsT3xi1+00z5+8m9DpbHsWYLYfvacof4ISc52xEy3N6v3wwpAlomqt3mtmo/Ey+n
	Q6tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=3tmiZiCH2XBVN5DuJQwuRPNtjxIcwvAWUQCPl8nlFS8=;
	b=eOdQn9kuf/7+4nxJD2ZQNvjVNRusS+P8JuB31qkFYOp/Rh6dGwQo7Qej5GGY8k/xKw
	ShxoWrMDfi3qVPb0Ry6Guo170RNvY4D1nrNn/Sv06x+sAs8q2xZd147jvpRTm1XyvgRy
	xYkQ6dzH9Nspgo1JvA4aNP3/Z4rEVLsg4RRCuc4e1iQG0MJ81HO6pcn9LPPdkj+xTehP
	QMAwjGmPLXuPTYdZbG5r/DtCnzU53fQ2G1SDyYB8TmOgrtObFuxuiwMDaPgZlUN2rvxv
	zTovOst7b1eifmVVg5PWbGudFO1Qv+nXSyyBkFZhLOO70d9m/5EaTmxd6N3VayutiZCv
	plbA==
X-Gm-Message-State: APjAAAXe9DdKC54F+m7xdP3EHwYZfHHrqV9BE0EENLnTfXrTa9aQYY+8
	XTo9NMBFbWRq++nG07IYpX0=
X-Google-Smtp-Source: APXvYqyk5Nfr9mkfmlo0wPAAUjVe5OCh9aS4oDX9RYtz0TWt4Psr0aPBzYiylWf+ahi1WXDd32HvNA==
X-Received: by 2002:a63:d512:: with SMTP id c18mr42063797pgg.239.1562207786341;
	Wed, 03 Jul 2019 19:36:26 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
	by smtp.googlemail.com with ESMTPSA id
	t96sm3105193pjb.1.2019.07.03.19.36.24
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 03 Jul 2019 19:36:25 -0700 (PDT)
From: Fuqian Huang <huangfq.daxian@gmail.com>
To: 
Subject: [Patch v2 06/10] iommu: using dev_get_drvdata directly
Date: Thu,  4 Jul 2019 10:36:20 +0800
Message-Id: <20190704023620.4689-1-huangfq.daxian@gmail.com>
X-Mailer: git-send-email 2.11.0
X-Mailman-Approved-At: Thu, 04 Jul 2019 03:33:10 +0000
Cc: Fuqian Huang <huangfq.daxian@gmail.com>, iommu@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org
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

Several drivers cast a struct device pointer to a struct
platform_device pointer only to then call platform_get_drvdata().
To improve readability, these constructs can be simplified
by using dev_get_drvdata() directly.

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
Changes in v2:
  - Make the commit message more clearly.

 drivers/iommu/omap-iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
index 62f9c61338a5..c638f7795735 100644
--- a/drivers/iommu/omap-iommu.c
+++ b/drivers/iommu/omap-iommu.c
@@ -36,7 +36,7 @@
 static const struct iommu_ops omap_iommu_ops;
 
 #define to_iommu(dev)							\
-	((struct omap_iommu *)platform_get_drvdata(to_platform_device(dev)))
+	((struct omap_iommu *)dev_get_drvdata(dev))
 
 /* bitmap of the page sizes currently supported */
 #define OMAP_IOMMU_PGSIZES	(SZ_4K | SZ_64K | SZ_1M | SZ_16M)
-- 
2.11.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
