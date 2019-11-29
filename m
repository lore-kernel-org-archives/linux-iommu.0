Return-Path: <SRS0=o1xy=ZV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47D2EC432C3
	for <iommu@archiver.kernel.org>; Fri, 29 Nov 2019 00:49:23 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07C2721774
	for <iommu@archiver.kernel.org>; Fri, 29 Nov 2019 00:49:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KJSvsdf/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07C2721774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id CFF1F20380;
	Fri, 29 Nov 2019 00:49:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WflsN-0D6v5Y; Fri, 29 Nov 2019 00:49:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id DE9C2203F4;
	Fri, 29 Nov 2019 00:49:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C5229C1DC9;
	Fri, 29 Nov 2019 00:49:21 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 154D4C0881
 for <iommu@lists.linux-foundation.org>; Fri, 29 Nov 2019 00:49:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id EF131203F4
 for <iommu@lists.linux-foundation.org>; Fri, 29 Nov 2019 00:49:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YGx2JbWwTPaq for <iommu@lists.linux-foundation.org>;
 Fri, 29 Nov 2019 00:49:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com
 [209.85.210.193])
 by silver.osuosl.org (Postfix) with ESMTPS id 6A4C220380
 for <iommu@lists.linux-foundation.org>; Fri, 29 Nov 2019 00:49:19 +0000 (UTC)
Received: by mail-pf1-f193.google.com with SMTP id x28so13831004pfo.6
 for <iommu@lists.linux-foundation.org>; Thu, 28 Nov 2019 16:49:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Er0BveApuGpZcCQ7MJvTFXGgSFZgN3u+8yAIisXO87k=;
 b=KJSvsdf/0VvkENZRJVgDMQrRC+eIsYDs5/nOxYRpDi/NLvNxd3TKM324hYHW/yrlWl
 4JsY9BDUGZtjvXHId+SaDNc4pVBQ+Gmi0v8mswcl6zDhYkEDK4gFRkbNwhe8SXNoe6P0
 heiQSIcALpjL3aVz1ZVdTvvsHgLrjJBOplBQXSX8BikLjuAlkLoBHcjdi49J/52uWfOs
 nXRQUCSm3c4BXU+7SRY8pL1rGg3zxcayX1oxs8KRnBF/yROeKJVHEP/xkPRA4LihuRkY
 aCeWiHbhJuG1ZfEw84K4aHjUwVmDQ8VToBfJ87kQROx4bgG7/ouUjJjuSzVYHzqiXO8h
 88JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Er0BveApuGpZcCQ7MJvTFXGgSFZgN3u+8yAIisXO87k=;
 b=fkZNhVM3HZ2XTXzr4S+NPbUBGzmImuZK2BcqJIFPjGpqX394xnZEVh6VGNipg3zdHq
 mbG11MTaq5A6lrYNPS0eVwuhFHHWmvUK5r2cqPiZZ9TGgFwekSEUk0XQxb59B/SMR6Ec
 MJ03JCFvkQQpnKAUvvNoiwnt0TabSe2iACUo/cicPPU1dQumWnUn4pJRTDWosMbUrLXT
 C4hRsA76TAxuRRe8KRXo+xnYmieEsh/zCB280I316Am8+FAYeXLR1h+qBpBuFVrRGsws
 UM+9wKbxlUcOHawaYeZMNFLM7zikuUOChGufVXYwTZTUmURcfa44cLzabC4hb/XOjGpL
 6qBg==
X-Gm-Message-State: APjAAAVsTgv2V57iOCIIutBw/KQmbUuPd+MnUG10zwJ0xiZF/+H2Klim
 xtfATHhX1P4/JS4jtE53lpr9LZBL/pQ=
X-Google-Smtp-Source: APXvYqyApdPpftN+vV2nvmBBowUli4X7V/J8sYEkkUmC4LcmBfkr4EU4ECpWEHmh1EQEAxffn9W5nQ==
X-Received: by 2002:a63:334f:: with SMTP id z76mr13701756pgz.277.1574988558791; 
 Thu, 28 Nov 2019 16:49:18 -0800 (PST)
Received: from tw-172-25-31-76.office.twttr.net ([8.25.197.24])
 by smtp.gmail.com with ESMTPSA id 64sm22418202pfe.147.2019.11.28.16.49.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Nov 2019 16:49:18 -0800 (PST)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: iommu@lists.linux-foundation.org
Subject: [Patch v2 0/3] iommu: reduce spinlock contention on fast path
Date: Thu, 28 Nov 2019 16:48:52 -0800
Message-Id: <20191129004855.18506-1-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Cc: Cong Wang <xiyou.wangcong@gmail.com>, linux-kernel@vger.kernel.org
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

This patchset contains three small optimizations for the global spinlock
contention in IOVA cache. Our memcache perf test shows this reduced its
p999 latency down by 45% on AMD when IOMMU is enabled.

Cong Wang (3):
  iommu: match the original algorithm
  iommu: optimize iova_magazine_free_pfns()
  iommu: avoid taking iova_rbtree_lock twice

---
 drivers/iommu/iova.c | 75 ++++++++++++++++++++++++++------------------
 1 file changed, 45 insertions(+), 30 deletions(-)

-- 
2.21.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
