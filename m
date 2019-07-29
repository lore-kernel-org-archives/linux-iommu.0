Return-Path: <SRS0=zE+z=V2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F34DCC433FF
	for <iommu@archiver.kernel.org>; Mon, 29 Jul 2019 18:29:42 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C927C2073F
	for <iommu@archiver.kernel.org>; Mon, 29 Jul 2019 18:29:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bwRQRbSz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C927C2073F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 0290C1D06;
	Mon, 29 Jul 2019 18:29:39 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id B672518FE
	for <iommu@lists.linux-foundation.org>;
	Mon, 29 Jul 2019 15:14:22 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com
	[209.85.210.193])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 8518F5E4
	for <iommu@lists.linux-foundation.org>;
	Mon, 29 Jul 2019 15:14:22 +0000 (UTC)
Received: by mail-pf1-f193.google.com with SMTP id f17so24202395pfn.6
	for <iommu@lists.linux-foundation.org>;
	Mon, 29 Jul 2019 08:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=ID3S8AXMaqtPd62+34tqU+I1K0sOrkCK8bonK/JaG1E=;
	b=bwRQRbSzvwE3OKuWwSi4Minic0ZtZcaBDU7DYRPLNzeTAghIwyhd55QnlibgdAPiHH
	PDQA/qN+TwhHa/4KNIh6pII9/Qs0PUwS3ctw++P88wFXXLaeFBdVIkH8jP4i15yHF23T
	2aSgUFnvF0+mmKhBn0QvmUXHXTf2IJa+6qmvJZzanVsHdrRs0WdXZgaDgdQ1ophmZB0G
	P4ocTQ3Ld+6ggzTZuSZlvoL45/xvU2ttcOtuWe0Yp0SPfrY65fZZ5uRy1fdKNXFEh+Tt
	FmT2ZAgxnM03PmaEELkpY45q6+lQkvF3sBPbpHEXU8QvmX9qlahZGIc3csRgDS68qg/D
	DOWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=ID3S8AXMaqtPd62+34tqU+I1K0sOrkCK8bonK/JaG1E=;
	b=DVNyEGr1R5dZly81SaUn8wA/kw4sjJTfEi3pRmI4q6VkjItFrwn24pOOqgAJwFu7UG
	vA6LkVq3bCZ3kJm1udx3VI7th+B7q2BfXp4prRUfICYxXUpf/sqmqEiARJfjQMqNmoyK
	lqx0H+SfgSej51y7e6QcKCRIhI39FdWvLjr6U1RG/wwqFsRD/661i+nt8Utlf7B+Q+fn
	d5XjTkRrgjGHMGgIQ8kA1Pndzy4HyC0RKjzRJJuzQTJMg0gP1eBzHAGUj12aAI5cSIgM
	z2VfN9BfAFRPWVOvcqMJliswKCY/o9alqpau09FksB3W3kQDDk6uh8Y/I9vZSdN8CMYa
	62Sg==
X-Gm-Message-State: APjAAAUeDBTgQuwWCpW7tuZtBhVRiyzcydLkgQAsZmF1gt8XtU1V4aPG
	cPmkUqeqqOAHA7oTtStVHNo=
X-Google-Smtp-Source: APXvYqyxOpnuo6B46j6hiILBzbb8bZpVvSU/EkvTH0t/U8btGjZnuqiCdoQ6+7qTGZCU2KpsQUJISA==
X-Received: by 2002:a65:6081:: with SMTP id t1mr106125219pgu.9.1564413262031; 
	Mon, 29 Jul 2019 08:14:22 -0700 (PDT)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([89.31.126.54])
	by smtp.gmail.com with ESMTPSA id
	a12sm104957041pje.3.2019.07.29.08.14.19
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Mon, 29 Jul 2019 08:14:21 -0700 (PDT)
From: Chuhong Yuan <hslester96@gmail.com>
To: 
Subject: [PATCH 03/12] dma-debug: Replace strncmp with str_has_prefix
Date: Mon, 29 Jul 2019 23:14:16 +0800
Message-Id: <20190729151416.9388-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-Mailman-Approved-At: Mon, 29 Jul 2019 18:26:30 +0000
Cc: Chuhong Yuan <hslester96@gmail.com>, linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>,
	Christoph Hellwig <hch@lst.de>
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

strncmp(str, const, len) is error-prone.
We had better use newly introduced
str_has_prefix() instead of it.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
 kernel/dma/debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
index 099002d84f46..0f9e1aba3e1a 100644
--- a/kernel/dma/debug.c
+++ b/kernel/dma/debug.c
@@ -970,7 +970,7 @@ static __init int dma_debug_cmdline(char *str)
 	if (!str)
 		return -EINVAL;
 
-	if (strncmp(str, "off", 3) == 0) {
+	if (str_has_prefix(str, "off")) {
 		pr_info("debugging disabled on kernel command line\n");
 		global_disable = true;
 	}
-- 
2.20.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
