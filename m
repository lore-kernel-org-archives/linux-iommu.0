Return-Path: <SRS0=VFJV=IA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B692CC433E0
	for <iommu@archiver.kernel.org>; Tue,  2 Mar 2021 09:35:45 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55FFE64F0B
	for <iommu@archiver.kernel.org>; Tue,  2 Mar 2021 09:35:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55FFE64F0B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BE47A83DAE;
	Tue,  2 Mar 2021 09:35:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OinDnR78kl-h; Tue,  2 Mar 2021 09:35:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 26DDC83D7D;
	Tue,  2 Mar 2021 09:35:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0F759C000B;
	Tue,  2 Mar 2021 09:35:43 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B499DC0001
 for <iommu@lists.linux-foundation.org>; Tue,  2 Mar 2021 09:35:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 974186F5D8
 for <iommu@lists.linux-foundation.org>; Tue,  2 Mar 2021 09:35:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IDsC24ugqeLO for <iommu@lists.linux-foundation.org>;
 Tue,  2 Mar 2021 09:35:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C61196F579
 for <iommu@lists.linux-foundation.org>; Tue,  2 Mar 2021 09:35:40 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id n22so1633326wmc.2
 for <iommu@lists.linux-foundation.org>; Tue, 02 Mar 2021 01:35:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Pu6R7mxpT/d03S11wEchY1gMtD/oeS7GHk/CBhJ7EpE=;
 b=YbLVZfDwQ9GXIPCbEkUwwkRMvR9HrAsO5n0LI/djTCnV4nzBzSVle5iAGKlXTtMtiw
 eJHkGdaffqr6fcdMWyE/3WX0bGnq5e4HMkSM+Arqh0al6DVOIOumkUXDUrFHxWMmTAIU
 yTHkxAFLPIlogxWh2jIeXKWWwQMNznjxHFkXDciz8uSvSbZrFZ5654/tP4Y9w+csyJ3K
 8zCuF50cetppan8iAK3X2gRwZu5Sim69K/o5vW7IM0u7Dsl3REevyhsWAtRcmw4PNdUs
 DZmz3vyX8O3JZ05RG3gzWa6Bu0ZHEW+0oNIXUyxi+Is1EL3zHBEwwvKxZRQFSL8503PP
 yKsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Pu6R7mxpT/d03S11wEchY1gMtD/oeS7GHk/CBhJ7EpE=;
 b=rFaRM6yb/gY/R+mftwQnReHeXLzqAV+PCAv1vf16iLqEzt2QhfNPIl/SvlE5kRIKZo
 g3DqUxrzkBKtZQKgqBtVp0f0EQZ7W4gfpUPc1DG5g2zyXArd/H+j3UtsCa1xyp4il4OD
 GIs5TECfoq30NZPM9pDgBRhMbc3vHMH8zUean7qVnKzzNHSncZvNBXO6kLK+GuJyoluk
 oPH5Qc1HQWCqROt+upB5gGaTI8w6SnLU7RF6aXrjaDEA4LVvO27kVlcF5wuNeUUhV5Gm
 OwkBRMlkzp0My9yFJ7/Nq/FQ7G6qkYn5zMXYQdLflb+PI1Lc9kCXQZXiJR0V/Nr8Ht3W
 loxw==
X-Gm-Message-State: AOAM532rRjaQ6G8MkB8PP1I4Jhi3xw3Bf2AG1kjPOYTCQgbBgABsuMQk
 h5by1u8ylpPlMtE1ShztJG7wTg==
X-Google-Smtp-Source: ABdhPJzvB901sQ6CVC/aE5VynwlXzB5fbWdQphQ817qOPVn07dFbENigZBrBQ39ius3dHHfobkewXg==
X-Received: by 2002:a05:600c:350c:: with SMTP id
 h12mr2990865wmq.39.1614677739171; 
 Tue, 02 Mar 2021 01:35:39 -0800 (PST)
Received: from localhost.localdomain
 ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id w131sm1963818wmb.8.2021.03.02.01.35.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Mar 2021 01:35:38 -0800 (PST)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: joro@8bytes.org,
	will@kernel.org
Subject: [PATCH v13 08/10] dt-bindings: document stall property for IOMMU
 masters
Date: Tue,  2 Mar 2021 10:26:44 +0100
Message-Id: <20210302092644.2553014-9-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210302092644.2553014-1-jean-philippe@linaro.org>
References: <20210302092644.2553014-1-jean-philippe@linaro.org>
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
2.30.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
