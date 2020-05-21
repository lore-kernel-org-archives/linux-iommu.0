Return-Path: <SRS0=DnMm=7D=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56804C433E1
	for <iommu@archiver.kernel.org>; Thu, 21 May 2020 21:50:46 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAB492072C
	for <iommu@archiver.kernel.org>; Thu, 21 May 2020 21:50:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="LQ7iQVlb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAB492072C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lca.pw
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 934C3203ED;
	Thu, 21 May 2020 21:50:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ke6N6+CTjF1g; Thu, 21 May 2020 21:50:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id A7A7E20031;
	Thu, 21 May 2020 21:50:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 83923C088A;
	Thu, 21 May 2020 21:50:44 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B3F04C0176
 for <iommu@lists.linux-foundation.org>; Thu, 21 May 2020 21:50:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id A66AC8858F
 for <iommu@lists.linux-foundation.org>; Thu, 21 May 2020 21:50:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id C97vdu1ssrvM for <iommu@lists.linux-foundation.org>;
 Thu, 21 May 2020 21:50:42 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-qk1-f196.google.com (mail-qk1-f196.google.com
 [209.85.222.196])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 00EB386A0B
 for <iommu@lists.linux-foundation.org>; Thu, 21 May 2020 21:50:41 +0000 (UTC)
Received: by mail-qk1-f196.google.com with SMTP id f13so8894377qkh.2
 for <iommu@lists.linux-foundation.org>; Thu, 21 May 2020 14:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lca.pw; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=0JGejAkD+7qrrtavSgAF90fR3bzb3rcFP1ihXQ8LxTY=;
 b=LQ7iQVlbYxCXH3hmKUL/SJehnc2Ik5GGdDuWeTT9p/roUvarRoeY7kzVbH95FSKxLJ
 TXbsKBA5iNFt3ZxRkFpY6A1f3avdB3OrQMJMwr9OqoZ5gfmerP/SDx34E35N2JZ3PeBC
 YpA9DUuJpQq9GRSfIbol/+2wXVsFJm7lQQBH3qfJkCbdgzIN3LKUAUNltQAOxTkDVjMW
 NNAVMN28x2H2RdgRPchhpxWYj/6b1UOZtVY/RjuX2GO3vYn9dUtbpyoLaJy1S7SsEMkw
 mSSkezM4FSF1mvWAbDBSamTp5Lirz+tS7KmhrqGZgUOwwUYkPToRDvsL2EiZZzC0GE6C
 Mrgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=0JGejAkD+7qrrtavSgAF90fR3bzb3rcFP1ihXQ8LxTY=;
 b=LM6KLDlJ5zYMEz4joGKQe5yhGQs7WzPAErHKwBUsAG1chIm8ayPD2/v3kbrAt42NQl
 KYgDYA6qQ+uEDBsKKYr1DJgzS8rHdRL5wqE7RFdTjSLA05nSrZZqn+RRZVhmNk6naGfC
 kExyxwbSj7ma61fVgONl8llXjTstcCKo9VrqlX1k0e3gtPeN90BZxORN8ryqXCuD+8Tz
 c1/vCQ4OBck08AHNZANMCP+ZoVBEC42s6WTifaH1t9TmflGgTW/Y205aPhOP/a1H1cgW
 xpyOs5raCffg+Ek39+V8CZLe4MZFhjMfJWa5h6+hwANXcgwxEjoOjtXpJxtSU/oFwLxA
 SjRQ==
X-Gm-Message-State: AOAM530JJAscz5SCebq3bG0Fum5z3MotAj5FXht0maYm9fRPOOecTwln
 sFGkOi3gQpVoJFSiYxtahAaaKg==
X-Google-Smtp-Source: ABdhPJzEVmJYgUyMq25WuP/d5wyqW/jaKxMoP0xw4pkSX2jhBu33EjHjLJ/QbjVmE+CfXVldi1v5+A==
X-Received: by 2002:a37:a1c7:: with SMTP id
 k190mr12288348qke.166.1590097841090; 
 Thu, 21 May 2020 14:50:41 -0700 (PDT)
Received: from ovpn-112-192.phx2.redhat.com
 (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
 by smtp.gmail.com with ESMTPSA id m33sm6334180qtb.88.2020.05.21.14.50.40
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 21 May 2020 14:50:40 -0700 (PDT)
From: Qian Cai <cai@lca.pw>
To: jroedel@suse.de
Subject: [PATCH -next] iommu/vt-d: fix a GCC warning
Date: Thu, 21 May 2020 17:50:30 -0400
Message-Id: <20200521215030.16938-1-cai@lca.pw>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
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

The commit 6ee1b77ba3ac ("iommu/vt-d: Add svm/sva invalidate function")
introduced a GCC warning,

drivers/iommu/intel-iommu.c:5330:1: warning: 'static' is not at beginning of
declaration [-Wold-style-declaration]
 const static int
 ^~~~~

Signed-off-by: Qian Cai <cai@lca.pw>
---
 drivers/iommu/intel-iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index f75d7d9c231f..ff5a30a94679 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -5327,7 +5327,7 @@ static void intel_iommu_aux_detach_device(struct iommu_domain *domain,
  * [IOMMU_CACHE_INV_TYPE_IOTLB][IOMMU_INV_GRANU_ADDR]
  */
 
-const static int
+static const int
 inv_type_granu_table[IOMMU_CACHE_INV_TYPE_NR][IOMMU_INV_GRANU_NR] = {
 	/*
 	 * PASID based IOTLB invalidation: PASID selective (per PASID),
-- 
2.17.2 (Apple Git-113)

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
