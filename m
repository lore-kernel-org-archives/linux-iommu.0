Return-Path: <SRS0=Sm7F=2K=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47CEBC2D0D2
	for <iommu@archiver.kernel.org>; Fri, 20 Dec 2019 00:32:37 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C7BA2465E
	for <iommu@archiver.kernel.org>; Fri, 20 Dec 2019 00:32:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gqmnkOWI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C7BA2465E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id F3D4624991;
	Fri, 20 Dec 2019 00:32:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hBUHYx7w4UmN; Fri, 20 Dec 2019 00:32:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 346BD24B6B;
	Fri, 20 Dec 2019 00:32:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1C57EC1AE8;
	Fri, 20 Dec 2019 00:32:36 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CC8A1C077D
 for <iommu@lists.linux-foundation.org>; Fri, 20 Dec 2019 00:32:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id C4E478768B
 for <iommu@lists.linux-foundation.org>; Fri, 20 Dec 2019 00:32:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id u+1JqzWQwA68 for <iommu@lists.linux-foundation.org>;
 Fri, 20 Dec 2019 00:32:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pg1-f194.google.com (mail-pg1-f194.google.com
 [209.85.215.194])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 43016875F4
 for <iommu@lists.linux-foundation.org>; Fri, 20 Dec 2019 00:32:33 +0000 (UTC)
Received: by mail-pg1-f194.google.com with SMTP id l24so4034935pgk.2
 for <iommu@lists.linux-foundation.org>; Thu, 19 Dec 2019 16:32:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=RCTh5+RkVcHHfeVRQucg+CwnAKVBZiOfF164k68a6LU=;
 b=gqmnkOWIqwskobsCM7hMzG4V5zbCceVSTaL3qRCI9EJMbB/K5/CvTJUO5x3q0wRzCi
 4M2o+QHIYdfnXxxYiVCGldx8G4FbDwF6DvT2NVQIo+THjMeywRKUfNUUerqwz6xgPHE1
 t5lG8Qmvdwbd2dBHEDgVXy2qKa0GykKryXpBXyHpLhfCcm2Qh770UMYfMnVXU5jvlozK
 CPc1l7ZVtcZ3S/feuRZiaGzjVhb7XAF4aCOQ0kvvL0V3fmAM2QAn2vxDyztUNM96emHJ
 r1qVBDDbrAkopPe8bSUHA4nj9OAvUCtWFbRk/HrIXYxZhsuq7iZJcZcdGcn+Zd23Qi+4
 Chpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=RCTh5+RkVcHHfeVRQucg+CwnAKVBZiOfF164k68a6LU=;
 b=aWiF3cA3Jx6XDLkuPyAEhefTUZ/+NEfW4JerDs0R9bkBpfUdEoMov6/rWf/gJgV1cf
 4adjz0WkqdXlcjolFxNUty1y7m1xoeBuDstVwRrehfix7k70Ck8Jd26CG5x6EhT17XL2
 dt2kMNFWLkvYpWTZUJggzpO/TuKqIDcs41UNZBexjG48T/INUymyKU2zEwlNCXV6FUbB
 mQJQCv+RMbwqsly1Lllmxkfq2E/Ei9ADP2uuaXvauKOIq6LsYUOO/Loz0OlrYqEF0gv0
 9jodfGiqnBpyJyJKZSDfdjUxiXRtWRv0a9om7O84IWdjF2PkqcV72jm4++SUQq32yRV6
 rw2Q==
X-Gm-Message-State: APjAAAVKB/MBnOKB0lwl+rZEYrk8ZU+6HUBvVS0P7h7AxN6aSbQwqqIJ
 QORsCnSABG+Vf2kItlFYmKA=
X-Google-Smtp-Source: APXvYqyTEohHA9IDpoOAHJBlun53OSwwiCttKkjPXp1sh+v9hL5rBdRt1F0HiyLxbwdezOYcXB6i2w==
X-Received: by 2002:aa7:8699:: with SMTP id d25mr12741708pfo.139.1576801952820; 
 Thu, 19 Dec 2019 16:32:32 -0800 (PST)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com.
 [216.228.112.22])
 by smtp.gmail.com with ESMTPSA id a23sm10145845pfg.82.2019.12.19.16.32.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2019 16:32:32 -0800 (PST)
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: thierry.reding@gmail.com,
	joro@8bytes.org
Subject: [PATCH 1/4] memory: tegra: Correct reset value of xusb_hostr
Date: Thu, 19 Dec 2019 16:29:11 -0800
Message-Id: <20191220002914.19043-2-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191220002914.19043-1-nicoleotsuka@gmail.com>
References: <20191220002914.19043-1-nicoleotsuka@gmail.com>
Cc: linux-tegra@vger.kernel.org, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, jonathanh@nvidia.com
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

According to Tegra X1 (Tegra210) TRM, the reset value of xusb_hostr
field (bit [7:0]) should be 0x7a. So this patch simply corrects it.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
 drivers/memory/tegra/tegra210.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/memory/tegra/tegra210.c b/drivers/memory/tegra/tegra210.c
index a3918a96467f..eab4bc01c8bc 100644
--- a/drivers/memory/tegra/tegra210.c
+++ b/drivers/memory/tegra/tegra210.c
@@ -436,7 +436,7 @@ static const struct tegra_mc_client tegra210_mc_clients[] = {
 			.reg = 0x37c,
 			.shift = 0,
 			.mask = 0xff,
-			.def = 0x39,
+			.def = 0x7a,
 		},
 	}, {
 		.id = 0x4b,
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
