Return-Path: <SRS0=xM8W=A2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DB28C433E3
	for <iommu@archiver.kernel.org>; Wed, 15 Jul 2020 07:07:08 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1CCB20663
	for <iommu@archiver.kernel.org>; Wed, 15 Jul 2020 07:07:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=semihalf-com.20150623.gappssmtp.com header.i=@semihalf-com.20150623.gappssmtp.com header.b="ROeZDbiY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1CCB20663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=semihalf.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 4E80B22053;
	Wed, 15 Jul 2020 07:07:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rR7wDKRTqOwH; Wed, 15 Jul 2020 07:07:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 5ED8E20510;
	Wed, 15 Jul 2020 07:07:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 22528C07FF;
	Wed, 15 Jul 2020 07:07:06 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 94FADC0733
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jul 2020 07:07:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 8FB788AB2A
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jul 2020 07:07:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yirwk7vtHU-6 for <iommu@lists.linux-foundation.org>;
 Wed, 15 Jul 2020 07:07:03 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-lj1-f196.google.com (mail-lj1-f196.google.com
 [209.85.208.196])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 075838A868
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jul 2020 07:07:02 +0000 (UTC)
Received: by mail-lj1-f196.google.com with SMTP id b25so1374292ljp.6
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jul 2020 00:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=semihalf-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=rDtvw0IlmYfY+jCdx2Lo57EMXtb9r+H9pF0oFjzHHyo=;
 b=ROeZDbiYc0S1qiJ+zPLW4iZ2xz7bxM4vKz+szew4oa0S3/i4Tsj9Db1Djs8wqhrDPA
 wJVmm30Nnb2KdsbXPrZWchGqSXHO720gjZZkro0giw2+zCmubxZOI5ILdKnQ3th9Xdgz
 l/awUtt1Ygeq4YioavlodnaPxhV7HYI8iIqmhbGdcs1ZMKNyL751oDG7y1lUrJTmJkwj
 0tq+FC77087fb7ayIUN30UuhGJcEX2m20NDwm58NrsDBJIIpNiD8XN94SUyUxYRa3PD1
 4ayfacD0RrkjIymW0xkigMB25F+DaQAQ5F3f4ISektuOrjdIKKU4GzSmG++qj2D1fL7X
 wfEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=rDtvw0IlmYfY+jCdx2Lo57EMXtb9r+H9pF0oFjzHHyo=;
 b=I5oiodMsQU3zrcMlxTVQ5xhc7a7R47TMEuVf2S3u4fYCt8EPo15Op84L8jWRSasdkW
 9+UFoEKYYrOgV60VpBR/eNRhc24zottAOhR/5lnzC7IfBtIyy+jW7mMHqDu7oY/Rykxz
 lDPCgdssiOYhZA/Gai9yuMTlI3FtmLhb0FvFMJ59WIATCE92rr1imX6enMwUsWpIjgi3
 ngOIjZ9TocOySEETIet8Ihk03pjiTQFiC3DzSQoj7zWWrg9VS5m5kvMjm2SNn9iNCX1n
 4rCJZ3k6HnA5oc7V3ZSa0St3VCo7Mr4XvzSotUMgUpy5bGpHTJ1gL65bu6RBKqN8gW2P
 6Hqg==
X-Gm-Message-State: AOAM531edxnOnoEiAHizWxs60huE16HaLSnShlil5plqBznwisFx4CAx
 C6rU5KF0cqNAwQTWOqbBHDZv5w==
X-Google-Smtp-Source: ABdhPJydCAuceNb5bOv6bKj797GCX8yDPnodbrk36mq0CVMxEl0bcpvWYkELgCrKsdNuJMCF/cXNlg==
X-Received: by 2002:a2e:3619:: with SMTP id d25mr4044931lja.204.1594796821024; 
 Wed, 15 Jul 2020 00:07:01 -0700 (PDT)
Received: from localhost.localdomain ([83.68.95.66])
 by smtp.gmail.com with ESMTPSA id 83sm276040ljj.51.2020.07.15.00.06.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2020 00:07:00 -0700 (PDT)
From: Tomasz Nowicki <tn@semihalf.com>
To: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
 gregory.clement@bootlin.com, robh+dt@kernel.org, hannah@marvell.com
Subject: [PATCH v4 1/4] iommu/arm-smmu: Call configuration impl hook before
 consuming features
Date: Wed, 15 Jul 2020 09:06:46 +0200
Message-Id: <20200715070649.18733-2-tn@semihalf.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200715070649.18733-1-tn@semihalf.com>
References: <20200715070649.18733-1-tn@semihalf.com>
Cc: devicetree@vger.kernel.org, catalin.marinas@arm.com,
 linux-kernel@vger.kernel.org, nadavh@marvell.com,
 iommu@lists.linux-foundation.org, mw@semihalf.com,
 linux-arm-kernel@lists.infradead.org
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

'cfg_probe' hook is called at the very end of configuration probing
procedure and therefore features override and workaround may become
complex like for ID register fixups. In preparation for adding Marvell
errata move 'cfg_probe' a bit earlier to have chance to adjust
the detected features before we start consuming them.

Since the Cavium quirk (the only user) does not alter features
it is safe to do so.

Suggested-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
---
 drivers/iommu/arm-smmu.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 243bc4cb2705..19f906de6420 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -1728,7 +1728,7 @@ static int arm_smmu_device_cfg_probe(struct arm_smmu_device *smmu)
 	unsigned int size;
 	u32 id;
 	bool cttw_reg, cttw_fw = smmu->features & ARM_SMMU_FEAT_COHERENT_WALK;
-	int i;
+	int i, ret;
 
 	dev_notice(smmu->dev, "probing hardware configuration...\n");
 	dev_notice(smmu->dev, "SMMUv%d with:\n",
@@ -1891,6 +1891,12 @@ static int arm_smmu_device_cfg_probe(struct arm_smmu_device *smmu)
 			smmu->features |= ARM_SMMU_FEAT_FMT_AARCH64_64K;
 	}
 
+	if (smmu->impl && smmu->impl->cfg_probe) {
+		ret = smmu->impl->cfg_probe(smmu);
+		if (ret)
+			return ret;
+	}
+
 	/* Now we've corralled the various formats, what'll it do? */
 	if (smmu->features & ARM_SMMU_FEAT_FMT_AARCH32_S)
 		smmu->pgsize_bitmap |= SZ_4K | SZ_64K | SZ_1M | SZ_16M;
@@ -1918,9 +1924,6 @@ static int arm_smmu_device_cfg_probe(struct arm_smmu_device *smmu)
 		dev_notice(smmu->dev, "\tStage-2: %lu-bit IPA -> %lu-bit PA\n",
 			   smmu->ipa_size, smmu->pa_size);
 
-	if (smmu->impl && smmu->impl->cfg_probe)
-		return smmu->impl->cfg_probe(smmu);
-
 	return 0;
 }
 
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
