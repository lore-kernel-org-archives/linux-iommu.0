Return-Path: <SRS0=5SFN=56=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E06B5C38A30
	for <iommu@archiver.kernel.org>; Tue, 14 Apr 2020 17:05:02 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B164A206A2
	for <iommu@archiver.kernel.org>; Tue, 14 Apr 2020 17:05:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F8zREYkz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B164A206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 81DBE2207F;
	Tue, 14 Apr 2020 17:05:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Rue2F6XZHYZP; Tue, 14 Apr 2020 17:04:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 045D722005;
	Tue, 14 Apr 2020 17:04:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D5798C089E;
	Tue, 14 Apr 2020 17:04:56 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0564AC0172
 for <iommu@lists.linux-foundation.org>; Tue, 14 Apr 2020 17:04:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id E7D0E87E53
 for <iommu@lists.linux-foundation.org>; Tue, 14 Apr 2020 17:04:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GltsONyi111E for <iommu@lists.linux-foundation.org>;
 Tue, 14 Apr 2020 17:04:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com
 [209.85.221.68])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 6E04687E5D
 for <iommu@lists.linux-foundation.org>; Tue, 14 Apr 2020 17:04:49 +0000 (UTC)
Received: by mail-wr1-f68.google.com with SMTP id h9so15238647wrc.8
 for <iommu@lists.linux-foundation.org>; Tue, 14 Apr 2020 10:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ftC8/er1w4cYUOvkGIk6/FxjhZRdex8XjZifggKsOVc=;
 b=F8zREYkzXEOjBIICh52aRBSsx0KYydBsiSeX1vLg3BjO4xVUHlOuGYyrqsAzk0um9g
 3hU3Mthe396hmS7rS6NIcIUl8Y8KnOQtGN0ORHag7JZrgh3uEV356dXEM4xwqqY8Pwze
 ZgNtKerpX4ZsyYd6DLVCLnyGotM1ATwYAczIh0xraXRquNJjV3GlWXMKOjri7lBsWJKF
 9GslApQWbeYRl93+vN13YZV/onxTemXTIrjfGUFMghYYcHdVO5B/9YbOhJhgVpL2U8MP
 LFuuUzzxRxcGmg4CxBLLzH1v25WazSQ9EmXw0gGw5UejA1+P+S/9YYiR3yZFbn2OR5Ms
 1UAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ftC8/er1w4cYUOvkGIk6/FxjhZRdex8XjZifggKsOVc=;
 b=ri9TTb0MDVyVy5n7Z213P+ot8O8krJ3pPDp31MSk5P3iSpH65KECAkG2m/kgPvY7qk
 gIBraEh/Rc6aE/kf4CvxvRUs80Vk+3nEMKLW+M2uOkUdhVSB7A6JBOTYXswHJOa3+MfI
 da/1sZUkEibu5WG6eu5tsI4Vwqw0h/1VqNgdNGx5i6EO+XmogLyQBDVV8XmeRMNdGdlk
 lcMOvfSiff9h2ZTyTfY2bpQkUwpSpmgaXUF0VrotUVUvVUyBPCC8a+KbAsX8I+8q6G22
 Jwtx0dOuhob8QUe4UXbehsaJHaPtfWnvsX3G4L9F0aIhQw235nO7ZVvqGllVPN+pQ6PA
 TOWw==
X-Gm-Message-State: AGi0PuYnHAuftrtJphlwj+2fc0BQ6XF3Jym86dB2pCKb1y4z8wfgMxU6
 vq9u0TnLD497Zpf9oQ8dbQzBdulAy7ounQ==
X-Google-Smtp-Source: APiQypIujMWDDt9womD2KtF8tCtmfig9Jpg4Oo+YzImaXPUr4DRwtpc2ABhB4671zuBVFTAOKxmNLQ==
X-Received: by 2002:a5d:568f:: with SMTP id f15mr23573543wrv.48.1586883887656; 
 Tue, 14 Apr 2020 10:04:47 -0700 (PDT)
Received: from localhost.localdomain
 ([2001:171b:226b:54a0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id x18sm19549147wrs.11.2020.04.14.10.04.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2020 10:04:47 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
 linux-mm@kvack.org
Subject: [PATCH v5 21/25] dt-bindings: document stall property for IOMMU
 masters
Date: Tue, 14 Apr 2020 19:02:49 +0200
Message-Id: <20200414170252.714402-22-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200414170252.714402-1-jean-philippe@linaro.org>
References: <20200414170252.714402-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, kevin.tian@intel.com,
 Rob Herring <robh@kernel.org>, catalin.marinas@arm.com, robin.murphy@arm.com,
 jgg@ziepe.ca, zhangfei.gao@linaro.org, will@kernel.org,
 christian.koenig@amd.com
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
index 3c36334e4f942..26ba9e530f138 100644
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
2.26.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
