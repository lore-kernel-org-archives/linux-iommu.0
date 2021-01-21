Return-Path: <SRS0=oIyp=GY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82907C433E6
	for <iommu@archiver.kernel.org>; Thu, 21 Jan 2021 12:39:49 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22E59239EF
	for <iommu@archiver.kernel.org>; Thu, 21 Jan 2021 12:39:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22E59239EF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id AB8B786CCC;
	Thu, 21 Jan 2021 12:39:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xd04AvlGYcXq; Thu, 21 Jan 2021 12:39:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id C027286D0B;
	Thu, 21 Jan 2021 12:39:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ACA59C1E6F;
	Thu, 21 Jan 2021 12:39:47 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7589BC013A
 for <iommu@lists.linux-foundation.org>; Thu, 21 Jan 2021 12:39:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 6D7C586D09
 for <iommu@lists.linux-foundation.org>; Thu, 21 Jan 2021 12:39:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BpkTxdJNiJOY for <iommu@lists.linux-foundation.org>;
 Thu, 21 Jan 2021 12:39:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by whitealder.osuosl.org (Postfix) with ESMTPS id BA5CB86CEB
 for <iommu@lists.linux-foundation.org>; Thu, 21 Jan 2021 12:39:42 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id v184so1402801wma.1
 for <iommu@lists.linux-foundation.org>; Thu, 21 Jan 2021 04:39:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Iza7ai+1pJVkOiREPpK3tUFt/+4KEOcT4kmdIoRu1W4=;
 b=ncM2Etu85nnnt1D5R9wUQk3EdfSF9pw+1ijx4nvgrK8oJD23eDuaDfijqTYecFMFyX
 wDn3pvejZJ45AWRW6k6uYvZj0k+50DwmufnS5BpjT5RFasOCp1okzSAfVbHxJTAkpOjR
 bFiaj49TLoUmXz50hHl/5dwzxButCVFM8yeIw6pGwP/VnDadugin6h75nubMSCJcAFqO
 jY17KorelU5Yco4R8uyif+WIeJveoSTMmVpvqNg2IGuEPh6AEA1HXRbFShVjnA2Ncrhu
 uH+qklVmhowQvcKcP5AUrwxWYPH+BSK1kwjb0JAjJKGJmLV9xrQZONTw0SAGUCP+iOuo
 n96A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Iza7ai+1pJVkOiREPpK3tUFt/+4KEOcT4kmdIoRu1W4=;
 b=EGsUDy7mOXji8+GXZ8yjpWnRl6NpBW9aJq/fo1RAlaykNugT7abgIHqZimorkjRo1s
 u+skoMnQQldmkpyGwM1HNTVms6R3LNrV1BF6k92geVIyzhNwhIQ802tJ3vMNrUhR2/z3
 XLtE4aRlHD6YBjcq7rNXvvJxVr0W/MTZhI3vxJ94ColY4n/HomEzunUBb67aQpsQbc6y
 2Xh9tyDJCbIeKdWhdDBsRRdqvZWIPp1xNzbvYMnuT7RmN6Ey+wbaKhDqv/grThqcWKnw
 pBxH4C/QdcyF2t5Pou0UbvrQUVbllFAUqn1pvHe4Vk9Z2fVVXQOFTiWA5cSXipA5npIV
 SaQQ==
X-Gm-Message-State: AOAM531SB/A/BKTNEmW/V4GH+CejR2pavHudEF9oX6VZpT2/SOoAvqnP
 jBTVp8r58KuCkdifc3qmy5LScw==
X-Google-Smtp-Source: ABdhPJyyu67AxXul4I8BEhqNEVWy7+2JiEYaRD6cGbSWv/kOI2QhFIZt2cXoy+7w3p9jk6gaghyMpw==
X-Received: by 2002:a1c:dc83:: with SMTP id t125mr8923805wmg.154.1611232781283; 
 Thu, 21 Jan 2021 04:39:41 -0800 (PST)
Received: from localhost.localdomain
 ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id p18sm7979248wmc.31.2021.01.21.04.39.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Jan 2021 04:39:40 -0800 (PST)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: joro@8bytes.org,
	will@kernel.org
Subject: [PATCH v10 08/10] dt-bindings: document stall property for IOMMU
 masters
Date: Thu, 21 Jan 2021 13:36:22 +0100
Message-Id: <20210121123623.2060416-9-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210121123623.2060416-1-jean-philippe@linaro.org>
References: <20210121123623.2060416-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Cc: vivek.gautam@arm.com, guohanjun@huawei.com,
 Jean-Philippe Brucker <jean-philippe@linaro.org>, linux-acpi@vger.kernel.org,
 zhangfei.gao@linaro.org, lenb@kernel.org, devicetree@vger.kernel.org,
 kevin.tian@intel.com, Rob Herring <robh@kernel.org>, robh+dt@kernel.org,
 linux-arm-kernel@lists.infradead.org, rjw@rjwysocki.net,
 iommu@lists.linux-foundation.org, sudeep.holla@arm.com, robin.murphy@arm.com,
 linux-accelerators@lists.ozlabs.org
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
2.30.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
