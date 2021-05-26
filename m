Return-Path: <SRS0=mply=KV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9405AC47088
	for <iommu@archiver.kernel.org>; Wed, 26 May 2021 16:21:43 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 523F8613CA
	for <iommu@archiver.kernel.org>; Wed, 26 May 2021 16:21:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 523F8613CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 201CB60B24;
	Wed, 26 May 2021 16:21:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id G7f4UlbqKwd5; Wed, 26 May 2021 16:21:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0D48F60AEF;
	Wed, 26 May 2021 16:21:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DB3CFC000E;
	Wed, 26 May 2021 16:21:41 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C8628C0027
 for <iommu@lists.linux-foundation.org>; Wed, 26 May 2021 16:21:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A17F84050C
 for <iommu@lists.linux-foundation.org>; Wed, 26 May 2021 16:21:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fZb5kd4KgJzH for <iommu@lists.linux-foundation.org>;
 Wed, 26 May 2021 16:21:36 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A5D2E40502
 for <iommu@lists.linux-foundation.org>; Wed, 26 May 2021 16:21:36 +0000 (UTC)
Received: by mail-ed1-x52e.google.com with SMTP id a25so2205441edr.12
 for <iommu@lists.linux-foundation.org>; Wed, 26 May 2021 09:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=qpxpWMnrPJKc07Z7A57L4cT+PGNv1GXXzLI4P6Yd1EE=;
 b=igtqyM//LYjdds1ytHCniCgg8zwXeW+EZ8GUvM0m2FRDNDeVRq9vskLXhwydDfk8I1
 Py+Iv1uCGEMhmYD2qpm+O2OSqMgjpeMutUiLdEcnWGKoeriIt/AE8DKSXYiTUxiyznbe
 FVzBP6qI4Px6bkTjqE0BruPZj/fjxlr0WhZ7KV8kWd9BbRvRG47PkuIFm0nrg1TTkArn
 T6b0IDjr4ltS+qRRAtM2FeMsHX0vCGj0W+xGELgKG65hDbF2uQlsZbnB1i5SVT38WK3o
 72JWxaT5VTxUZBWIrmWxI2hh1HFSn5kD6YQkLSO9vewdxJhgHUS2S/wf0yd5pzk65gzR
 1qZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=qpxpWMnrPJKc07Z7A57L4cT+PGNv1GXXzLI4P6Yd1EE=;
 b=A2HQlt+ucuf9o8wzOMEnpwIype0mxR+B0iVjxuianBmeX82+GLa7AGKWhBJZHxjIUu
 siNfmAMWOh5WsNYpWH1Q6wOMUjzWmy5tpT0Ep7MLz6LfupZllyWbQxm5Er25sZLJP3vK
 pPTw8MRRWWQqUiuiUawKaKte2CCj/s8GoK99GPTwHyZ2huvFB6fvGKiMzx9FQ8spdLoj
 C8fUZ155eVk91qWX/vrnfZPWHw1fJ8v3zoqHD70fxWshrclb3GZPJaQmLRlsHESblvtf
 XQXgUrPLybKwiNB6jk7XHuqSJlY5bcB8aP+cLbrSD/IgJN+M7VkG/E10KXYrridrSiwc
 0AFw==
X-Gm-Message-State: AOAM531pOiLtGJdb6ZhPFJBTidblVFuxdR3/B2j20SJFnTzzx/mKl9ay
 mafyhZNrjgzsRL6i2sGxttVtdQ==
X-Google-Smtp-Source: ABdhPJzV0Ekj4Q8KGq3C6oAPDF07bqX/LfHaYKNeHot9cZ4TZoZePl+V6GNvhy0kwuByEYqcvxu6qg==
X-Received: by 2002:aa7:c152:: with SMTP id r18mr38149878edp.266.1622046094940; 
 Wed, 26 May 2021 09:21:34 -0700 (PDT)
Received: from localhost.localdomain (adsl-84-226-106-126.adslplus.ch.
 [84.226.106.126])
 by smtp.gmail.com with ESMTPSA id e6sm10497145ejd.31.2021.05.26.09.21.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 May 2021 09:21:34 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: joro@8bytes.org,
	will@kernel.org
Subject: [PATCH v15 1/3] dt-bindings: document stall property for IOMMU masters
Date: Wed, 26 May 2021 18:19:26 +0200
Message-Id: <20210526161927.24268-2-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210526161927.24268-1-jean-philippe@linaro.org>
References: <20210526161927.24268-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Cc: devicetree@vger.kernel.org, linux-acpi@vger.kernel.org,
 Jean-Philippe Brucker <jean-philippe@linaro.org>, guohanjun@huawei.com,
 rjw@rjwysocki.net, iommu@lists.linux-foundation.org, robh+dt@kernel.org,
 sudeep.holla@arm.com, zhangfei.gao@linaro.org, robin.murphy@arm.com,
 Rob Herring <robh@kernel.org>, linux-arm-kernel@lists.infradead.org,
 lenb@kernel.org
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

On ARM systems, some platform devices behind an IOMMU may support stall,
which is the ability to recover from page faults. Let the firmware tell us
when a device supports stall.

Reviewed-by: Eric Auger <eric.auger@redhat.com>
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
2.31.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
