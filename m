Return-Path: <SRS0=ms/0=4M=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24869C38BEC
	for <iommu@archiver.kernel.org>; Mon, 24 Feb 2020 18:25:00 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC6E8222D9
	for <iommu@archiver.kernel.org>; Mon, 24 Feb 2020 18:24:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jrea57vR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC6E8222D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id CBD2586CDC;
	Mon, 24 Feb 2020 18:24:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nT0Wi6+b3Ys2; Mon, 24 Feb 2020 18:24:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id A92A88749A;
	Mon, 24 Feb 2020 18:24:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8F10DC1D89;
	Mon, 24 Feb 2020 18:24:58 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AA07BC0177
 for <iommu@lists.linux-foundation.org>; Mon, 24 Feb 2020 18:24:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 995F186055
 for <iommu@lists.linux-foundation.org>; Mon, 24 Feb 2020 18:24:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id C6eLPWp2OMda for <iommu@lists.linux-foundation.org>;
 Mon, 24 Feb 2020 18:24:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id CA19685FEB
 for <iommu@lists.linux-foundation.org>; Mon, 24 Feb 2020 18:24:55 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id a6so353714wme.2
 for <iommu@lists.linux-foundation.org>; Mon, 24 Feb 2020 10:24:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=i0VWA2fvKY7B7aVEb87RbBlKKCbdscLm7wXe7hq9l+o=;
 b=jrea57vRdBhgNK56CGB6FBQaFESTfknRHc96QQ82B0wBh5E8nOIvvqoDp88g21NJms
 vCtpWf4eZMeIPhoNOEnzXNGWUU/L/DIOMIpzlQ/DLRoBlZsRMavpixederXLjWbnWC7P
 VgrsbfWlv0djfGH1aSceYJMSD+h2AEC2octSj5r/52HuAkGcmwSLGFyNX2/RJNR0SEXo
 hjZ4qCxHZra5C4YTiCc/afuFkROLgPCt3wD/HTSI54xo9RGvqdw0v21iw6isZfklwJdL
 qB7285DeYxybLPJvLl7Ham/dtFKMQ20giHlQ9T+3SZtHeP+2yGyfOLAugLIBycvdgB68
 fVnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=i0VWA2fvKY7B7aVEb87RbBlKKCbdscLm7wXe7hq9l+o=;
 b=WoFCY4VwHbwNBMyXOGFlDw08GQnzJlK+gsf3STYM1L6IvUG+/XGa+zo2xYoPyOBPqj
 Ijloul4+HBDBz3ic1GmexER8AfJSuOn5E3iu1Zf9BTsG2f1qnnqkcDkb2uspOgmkNX26
 VSdgfHS2vZPjKdrFdGhyeWYZDL4KF8Pr27Ut3qycA9bFY3e9NOMnYoi+0J5MAXhdGR0p
 aoFW1+n1LcLMvskyO5VLOQybECdRxVDaI4H9XMw4mkSyCsPaWdz9J8ck76x1WujVU242
 4CUo3BpJKaDGhoNaAdUPMKGqZfvPaTh606zcz6OJ+l5GdrE5rnsrwLe+YCXwEMgX2m/Y
 Le1Q==
X-Gm-Message-State: APjAAAW+TpWh/kFM0SDriVHdPLrZpWhm48iQ+H/4Ryz4B3jMWTaYY31m
 2R+uISVEc10l7aoKb3H/lipBFB1uzBs=
X-Google-Smtp-Source: APXvYqzxdf7GnXuxJz22KdsBgghNsJTC0LtjcF0NB8OgJIKAqhQeqkdamrZEnO7kob3vSOk3XbOcTw==
X-Received: by 2002:a7b:c8d2:: with SMTP id f18mr292389wml.47.1582568694023;
 Mon, 24 Feb 2020 10:24:54 -0800 (PST)
Received: from localhost.localdomain
 ([2001:171b:c9a8:fbc0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id n3sm304255wmc.27.2020.02.24.10.24.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2020 10:24:53 -0800 (PST)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
 linux-mm@kvack.org
Subject: [PATCH v4 22/26] dt-bindings: document stall property for IOMMU
 masters
Date: Mon, 24 Feb 2020 19:23:57 +0100
Message-Id: <20200224182401.353359-23-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200224182401.353359-1-jean-philippe@linaro.org>
References: <20200224182401.353359-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Cc: mark.rutland@arm.com, Rob Herring <robh@kernel.org>, kevin.tian@intel.com,
 Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, catalin.marinas@arm.com,
 robin.murphy@arm.com, robh+dt@kernel.org, zhangfei.gao@linaro.org,
 will@kernel.org, christian.koenig@amd.com
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

From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>

On ARM systems, some platform devices behind an IOMMU may support stall,
which is the ability to recover from page faults. Let the firmware tell us
when a device supports stall.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 .../devicetree/bindings/iommu/iommu.txt        | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/devicetree/bindings/iommu/iommu.txt b/Documentation/devicetree/bindings/iommu/iommu.txt
index 3c36334e4f94..26ba9e530f13 100644
--- a/Documentation/devicetree/bindings/iommu/iommu.txt
+++ b/Documentation/devicetree/bindings/iommu/iommu.txt
@@ -92,6 +92,24 @@ Optional properties:
   tagging DMA transactions with an address space identifier. By default,
   this is 0, which means that the device only has one address space.
 
+- dma-can-stall: When present, the master can wait for a transaction to
+  complete for an indefinite amount of time. Upon translation fault some
+  IOMMUs, instead of aborting the translation immediately, may first
+  notify the driver and keep the transaction in flight. This allows the OS
+  to inspect the fault and, for example, make physical pages resident
+  before updating the mappings and completing the transaction. Such IOMMU
+  accepts a limited number of simultaneous stalled transactions before
+  having to either put back-pressure on the master, or abort new faulting
+  transactions.
+
+  Firmware has to opt-in stalling, because most buses and masters don't
+  support it. In particular it isn't compatible with PCI, where
+  transactions have to complete before a time limit. More generally it
+  won't work in systems and masters that haven't been designed for
+  stalling. For example the OS, in order to handle a stalled transaction,
+  may attempt to retrieve pages from secondary storage in a stalled
+  domain, leading to a deadlock.
+
 
 Notes:
 ======
-- 
2.25.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
