Return-Path: <SRS0=3/wr=6X=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B04BC38A2A
	for <iommu@archiver.kernel.org>; Sat,  9 May 2020 02:02:17 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F001B218AC
	for <iommu@archiver.kernel.org>; Sat,  9 May 2020 02:02:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="M/H3SK/Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F001B218AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lca.pw
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id BB830896D0;
	Sat,  9 May 2020 02:02:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LcVkBNfEjdzL; Sat,  9 May 2020 02:02:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 3D56E88D93;
	Sat,  9 May 2020 02:02:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 18D44C0865;
	Sat,  9 May 2020 02:02:16 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 59B2BC07FF
 for <iommu@lists.linux-foundation.org>; Sat,  9 May 2020 02:02:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 471A5872FF
 for <iommu@lists.linux-foundation.org>; Sat,  9 May 2020 02:02:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wKDAsv5xHTMq for <iommu@lists.linux-foundation.org>;
 Sat,  9 May 2020 02:02:14 +0000 (UTC)
X-Greylist: delayed 00:05:21 by SQLgrey-1.7.6
Received: from mail-qk1-f196.google.com (mail-qk1-f196.google.com
 [209.85.222.196])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 80727872DC
 for <iommu@lists.linux-foundation.org>; Sat,  9 May 2020 02:02:14 +0000 (UTC)
Received: by mail-qk1-f196.google.com with SMTP id g185so3900500qke.7
 for <iommu@lists.linux-foundation.org>; Fri, 08 May 2020 19:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lca.pw; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=O6aNrpLgarISzda+xo8JJ01KVr07p8YFJB55nCgXOUg=;
 b=M/H3SK/QI764fDKa50a73fqtS9IfCk2173bwOb54DjMcvfCK4GJaMddC2pZSoiOCr5
 gaVYd+CZW+bvd014XbtNGcPkHvUesahxWTXu83v9h8GQy9pD7YA+/VtygJNkLVwKwu2W
 3mH1DQX5JNaz5btdocptRtiPjjLnfIWUF29feDg5W391AbWPx6kh3APuZ1gJXdD+Cpp8
 60jvnS+n3jEEDx01NHqBIAFIQCUwdTsCN2KddgcruNvZARMc1lQfjDuZG2Z3IsZZfrCO
 DLNLqufNpnhd6fsZx81smmmtpWa8+Kj1A9YLe17udKkeIM31Uwizpwzf6S9dqGNmBQsW
 UO8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=O6aNrpLgarISzda+xo8JJ01KVr07p8YFJB55nCgXOUg=;
 b=tv7pucSQAHnVvlmJq457Wv2CpTW983AjH8A37/Tl6ntAzk3+P+Y5Mo2f82zST1NA6K
 zG/mcaf6fD9C6ZmEP0Hs/VIlvffP8F1lWsYcM6mxefveEYGifkQOAMvGT5UeWL1I0YBP
 DPgu/R9H2DqHmkJViLUjlKY9ZsmUybngq38G8yqQNVH6fZxRpiHVu6eU7KymhviG5nRk
 kxtu6XUVBwn7Xs515m94i5NOY5yMAbqW0AwZyylwpdRKyA6+nCIvTQEMjETmbhzN0Z4n
 jEK+iCBzckVY9et0EF3n+FGaHsYrU8FQIQRIwv2rInNeZgZPxhMmrzCLD+DB30+mFE1m
 j4XQ==
X-Gm-Message-State: AGi0PuazSbGzOesZC0tZVLeYKPumbNQr6HnoZAvxF24axXXRID+ADpNF
 lqhRowXeuq4WZI7mzujZAMKSgcQdmIz8jw==
X-Google-Smtp-Source: APiQypLkpVuPG2duq9fDZJmd5Lg1XiTR/9OSoq/UcFdtjZrghmKWDw1/OYWw2ix1GTyeRKcCizl09A==
X-Received: by 2002:a37:7ac2:: with SMTP id v185mr5419583qkc.386.1588989412051; 
 Fri, 08 May 2020 18:56:52 -0700 (PDT)
Received: from ovpn-66-195.rdu2.redhat.com
 (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
 by smtp.gmail.com with ESMTPSA id p22sm3079186qte.2.2020.05.08.18.56.51
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 08 May 2020 18:56:51 -0700 (PDT)
From: Qian Cai <cai@lca.pw>
To: joro@8bytes.org
Subject: [PATCH -next] iommu/amd: fix variable "iommu" set but not used
Date: Fri,  8 May 2020 21:56:45 -0400
Message-Id: <20200509015645.3236-1-cai@lca.pw>
X-Mailer: git-send-email 2.21.0 (Apple Git-122.2)
MIME-Version: 1.0
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
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

The commit dce8d6964ebd ("iommu/amd: Convert to probe/release_device()
call-backs") introduced an unused variable,

drivers/iommu/amd_iommu.c: In function 'amd_iommu_uninit_device':
drivers/iommu/amd_iommu.c:422:20: warning: variable 'iommu' set but not
used [-Wunused-but-set-variable]
  struct amd_iommu *iommu;
                    ^~~~~

Signed-off-by: Qian Cai <cai@lca.pw>
---
 drivers/iommu/amd_iommu.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index fef3689ee535..2b8eb58d2bea 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -419,15 +419,12 @@ static void iommu_ignore_device(struct device *dev)
 static void amd_iommu_uninit_device(struct device *dev)
 {
 	struct iommu_dev_data *dev_data;
-	struct amd_iommu *iommu;
 	int devid;
 
 	devid = get_device_id(dev);
 	if (devid < 0)
 		return;
 
-	iommu = amd_iommu_rlookup_table[devid];
-
 	dev_data = search_dev_data(devid);
 	if (!dev_data)
 		return;
-- 
2.21.0 (Apple Git-122.2)

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
