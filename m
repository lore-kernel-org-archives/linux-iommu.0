Return-Path: <SRS0=mVMG=CN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 246FCC43461
	for <iommu@archiver.kernel.org>; Fri,  4 Sep 2020 13:00:15 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D00352073B
	for <iommu@archiver.kernel.org>; Fri,  4 Sep 2020 13:00:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VRnez5fn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D00352073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 9C81086A16;
	Fri,  4 Sep 2020 13:00:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id L2QcPWg3RyoN; Fri,  4 Sep 2020 13:00:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 142B6869DE;
	Fri,  4 Sep 2020 13:00:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0D2C2C07FF;
	Fri,  4 Sep 2020 13:00:14 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E6E8FC0051
 for <iommu@lists.linux-foundation.org>; Fri,  4 Sep 2020 13:00:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id E3ABB860CF
 for <iommu@lists.linux-foundation.org>; Fri,  4 Sep 2020 13:00:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fCNX2oh3XzSG for <iommu@lists.linux-foundation.org>;
 Fri,  4 Sep 2020 13:00:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f67.google.com (mail-ed1-f67.google.com
 [209.85.208.67])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 867A386D62
 for <iommu@lists.linux-foundation.org>; Fri,  4 Sep 2020 13:00:07 +0000 (UTC)
Received: by mail-ed1-f67.google.com with SMTP id n22so6018737edt.4
 for <iommu@lists.linux-foundation.org>; Fri, 04 Sep 2020 06:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=eoJIkDtT5yIdSXOyl7ZSN/ybf/6ZO2PtqfzMV2ShYXs=;
 b=VRnez5fnDdx4YUTxOQcGHIgidGmKBkEm+asD3J7ZNJR0U26yYQNito/FHsTVC9QD2G
 TgWilTQTk6y65Pl3jvfV4kCh0JVkQI31zt1OAWkm8sLSOuarYbuGbHJC6D6oVSmAewgL
 g3OHoNtWlAF1SNGok1YGYsjQ+oMxxkFaGZxrfDImowRjeeE8IFhSxATxJGLaQbCZqfP2
 HhFmFH2qxDy8cE6xtXfRevpSQY0Z+jikSIIyNsZweyH1Onsyijgmp6EnUxl7VJR1Ot7/
 UPitx57LX3xiP8znCQItX5MnrMHaL6oZauMvAH5WWAXcpN49HgYFTThYPCYW+aCiaAi6
 S3OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=eoJIkDtT5yIdSXOyl7ZSN/ybf/6ZO2PtqfzMV2ShYXs=;
 b=Msdjh8fHpTmdmETgVkEWhAiWcYX8EW/pDXdr8GvdBBtOwmGWz6/SoOcTXnaxkI2xMY
 oW64o1pi6bJpOlR1J50erY18I7CJaCZBYbU60zOm3Rx+5SPFUNV0Fw6im4QcTKgivDsW
 sAYJ56lElOaVo1Jia090tnN3hrh+j/RtKPiypcGMYET8VXACJcEKBq8P1uz0oZlOlw79
 0GjdNGnWJs/Cnlx03Xj2GGOAVBuMSRS+9fHL2lVmo+dXF91iP4CsGyoidc32nBPf/gOX
 gt2ftfZ12eOfoUq8QicnWhOR7ag6WZjqf7hXu3HU8olz1X5rlxmfOh2imXYZ0DiHq/YC
 I6eQ==
X-Gm-Message-State: AOAM533GBv5VhHTcdmORVPSwzPSE8IQWY9DkiTi0zEQS+4n01kjY0Lft
 wCtoqrKVgpGkaB737fOZZ2k=
X-Google-Smtp-Source: ABdhPJyd3GfRiKMW3Hv1SXKOXdFm20VEy4aybXXN4EDdDImnvlQLArlBx5ZgWZXwJPMnMy22iZIX8g==
X-Received: by 2002:a50:fe98:: with SMTP id d24mr2605949edt.223.1599224405833; 
 Fri, 04 Sep 2020 06:00:05 -0700 (PDT)
Received: from localhost ([62.96.65.119])
 by smtp.gmail.com with ESMTPSA id w1sm5839816eds.18.2020.09.04.06.00.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2020 06:00:04 -0700 (PDT)
From: Thierry Reding <thierry.reding@gmail.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH v2 1/4] dt-bindings: reserved-memory: Document "active"
 property
Date: Fri,  4 Sep 2020 14:59:57 +0200
Message-Id: <20200904130000.691933-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Cc: devicetree@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>,
 Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
 Will Deacon <will@kernel.org>
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

From: Thierry Reding <treding@nvidia.com>

Reserved memory regions can be marked as "active" if hardware is
expected to access the regions during boot and before the operating
system can take control. One example where this is useful is for the
operating system to infer whether the region needs to be identity-
mapped through an IOMMU.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 .../bindings/reserved-memory/reserved-memory.txt           | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt b/Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt
index 4dd20de6977f..163d2927e4fc 100644
--- a/Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt
+++ b/Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt
@@ -63,6 +63,13 @@ reusable (optional) - empty property
       able to reclaim it back. Typically that means that the operating
       system can use that region to store volatile or cached data that
       can be otherwise regenerated or migrated elsewhere.
+active (optional) - empty property
+    - If this property is set for a reserved memory region, it indicates
+      that some piece of hardware may be actively accessing this region.
+      Should the operating system want to enable IOMMU protection for a
+      device, all active memory regions must have been identity-mapped
+      in order to ensure that non-quiescent hardware during boot can
+      continue to access the memory.
 
 Linux implementation note:
 - If a "linux,cma-default" property is present, then Linux will use the
-- 
2.28.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
