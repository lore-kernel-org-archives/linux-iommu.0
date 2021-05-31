Return-Path: <SRS0=AF0h=K2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EB71C47082
	for <iommu@archiver.kernel.org>; Mon, 31 May 2021 10:07:03 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF1F0611CB
	for <iommu@archiver.kernel.org>; Mon, 31 May 2021 10:07:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF1F0611CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A6C7D60678;
	Mon, 31 May 2021 10:07:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fC__-7znWskX; Mon, 31 May 2021 10:07:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 374BA6060A;
	Mon, 31 May 2021 10:07:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 06B7EC000D;
	Mon, 31 May 2021 10:07:01 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9E300C0001
 for <iommu@lists.linux-foundation.org>; Mon, 31 May 2021 10:06:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8C5ED402C2
 for <iommu@lists.linux-foundation.org>; Mon, 31 May 2021 10:06:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2wp8qUUrGxXt for <iommu@lists.linux-foundation.org>;
 Mon, 31 May 2021 10:06:57 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 372C64016F
 for <iommu@lists.linux-foundation.org>; Mon, 31 May 2021 10:06:57 +0000 (UTC)
Received: by mail-ej1-x635.google.com with SMTP id gb17so15842817ejc.8
 for <iommu@lists.linux-foundation.org>; Mon, 31 May 2021 03:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=t/wTF3aZ4LiYhQeO0iZ2OggKy7Af73zdHd6rVMfq7tg=;
 b=DtQvl3aaZos10i23U1s9VJkKVoW4djjaM/fzjvHJEyCuVz8icft3/jfwyoSkP1GkE0
 /Pe9dNqDw1w9NwQcxAPe07PLsC/9yzA/KGcqpuX6ie/jf4EMK1UJmi9Eyt0SpOPDKO5k
 eeIjtl06gSRzn7fPNSaEnL52LzmqvF8jxjyY/o0ZMx1yNvUt1zs7ynjCPPm089f94q3n
 z/anVALvVOf1iMlj1ZOZBQqKx78MycLif9RxzDrCJlIMM3TLkCnqXa6+962wtuidDo1S
 IZSglN2J8mk29YJmFyeLSOB5QUwtgZpjhXOY+Xr7MSkYQrcKidZ+CEsOCh37leFT0i6B
 WfPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=t/wTF3aZ4LiYhQeO0iZ2OggKy7Af73zdHd6rVMfq7tg=;
 b=Pm+fLTab75ghMGoBneGi0GGoRtkWfmTTayNXksjriyUDsz9WL5r99pqf9KQipY21Fh
 etMtGeMyFJEjtDbeWFmQHKG71Biw3vdayZGSo+AyuOZIssEMAMl3sfFSgLEq0XBWe4+j
 XB5CRhRPwkL28tkjIVtI3otTYZ7CMY1ZDEqszxs954qQzkIpbLY9J1pwRa2zsU8mw1KR
 bOM5Pp0a/1h/Cv8azNqZtt0Wa8SuSajPjZGxdUUWwh2cfG9/BJXziYUpfu3XfsDrNfSS
 8fpVGrJ8QqoSn/qLXcYwgg2plfR3QL2goroTW+irzwgkaYzjNl5/OUYJrZh1oMe1d1Rt
 YIaA==
X-Gm-Message-State: AOAM533q4Me7Y2DWM5awIjoRiznx493a7qVNsga3UDIeX5Ao1N7avv53
 13KyFiOurKN3M/K+a2kNbxH2hQ==
X-Google-Smtp-Source: ABdhPJxGCry3uYPtRONdFpilkA9nOhyxcczcEsRaO2bhHJ92T+Lb29yOaQxG0ci6j6Q7zA7P6X8fYA==
X-Received: by 2002:a17:906:e210:: with SMTP id
 gf16mr22255513ejb.472.1622455615116; 
 Mon, 31 May 2021 03:06:55 -0700 (PDT)
Received: from localhost.localdomain (adsl-84-226-106-126.adslplus.ch.
 [84.226.106.126])
 by smtp.gmail.com with ESMTPSA id cx7sm53898edb.65.2021.05.31.03.06.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 May 2021 03:06:54 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: will@kernel.org,
	joro@8bytes.org
Subject: [PATCH] iommu/arm-smmu-v3: Ratelimit event dump
Date: Mon, 31 May 2021 11:56:50 +0200
Message-Id: <20210531095648.118282-1-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 iommu@lists.linux-foundation.org, robin.murphy@arm.com,
 linux-arm-kernel@lists.infradead.org, Aaro Koskinen <aaro.koskinen@nokia.com>
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

When a device or driver misbehaves, it is possible to receive DMA fault
events much faster than we can print them out, causing a lock up of the
system and inability to cancel the source of the problem. Ratelimit
printing of events to help recovery.

Tested-by: Aaro Koskinen <aaro.koskinen@nokia.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---

Aiming for v5.14 rather than 5.13, since it mainly fixes a nuisance
during development/debug. Conflicts with "iommu/arm-smmu-v3: Add stall
support for platform devices" currently on the list [1], because they
both change arm_smmu_evtq_thread(). This patch is based onto [1].

I encountered this while developing SVA on hardware, although the
problem is not specific to SVA or stall. The device driver didn't
properly stop DMA, and the SMMU would flood the event queue with
translation faults. Without rate limiting I was unable to even reset the
device. Note that this is not a problem for normal SVA operations, since
userspace cannot cause DMA to print kernel messages.

Aaro Koskinen reported a similar problem [2]

[1] https://lore.kernel.org/linux-iommu/20210526161927.24268-4-jean-philippe@linaro.org/
[2] https://lore.kernel.org/linux-iommu/20210528080958.GA60351@darkstar.musicnaut.iki.fi/
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 39bdb4264248..2792382ad3bd 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1518,6 +1518,8 @@ static irqreturn_t arm_smmu_evtq_thread(int irq, void *dev)
 	struct arm_smmu_device *smmu = dev;
 	struct arm_smmu_queue *q = &smmu->evtq.q;
 	struct arm_smmu_ll_queue *llq = &q->llq;
+	static DEFINE_RATELIMIT_STATE(rs, DEFAULT_RATELIMIT_INTERVAL,
+				      DEFAULT_RATELIMIT_BURST);
 	u64 evt[EVTQ_ENT_DWORDS];
 
 	do {
@@ -1525,7 +1527,7 @@ static irqreturn_t arm_smmu_evtq_thread(int irq, void *dev)
 			u8 id = FIELD_GET(EVTQ_0_ID, evt[0]);
 
 			ret = arm_smmu_handle_evt(smmu, evt);
-			if (!ret)
+			if (!ret || !__ratelimit(&rs))
 				continue;
 
 			dev_info(smmu->dev, "event 0x%02x received:\n", id);
-- 
2.31.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
