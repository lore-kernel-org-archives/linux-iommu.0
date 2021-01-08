Return-Path: <SRS0=te8u=GL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02E03C433E0
	for <iommu@archiver.kernel.org>; Fri,  8 Jan 2021 15:02:47 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3DB423A01
	for <iommu@archiver.kernel.org>; Fri,  8 Jan 2021 15:02:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3DB423A01
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 27879204FD;
	Fri,  8 Jan 2021 15:02:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id I3hqQRWjVaod; Fri,  8 Jan 2021 15:02:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id E75AE2E137;
	Fri,  8 Jan 2021 15:02:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CE570C1E6F;
	Fri,  8 Jan 2021 15:02:42 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DB8B7C013A
 for <iommu@lists.linux-foundation.org>; Fri,  8 Jan 2021 15:02:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id CF5CC86DDA
 for <iommu@lists.linux-foundation.org>; Fri,  8 Jan 2021 15:02:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wvW__EJkcdKc for <iommu@lists.linux-foundation.org>;
 Fri,  8 Jan 2021 15:02:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id BACBA86DD2
 for <iommu@lists.linux-foundation.org>; Fri,  8 Jan 2021 15:02:40 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id c133so8051122wme.4
 for <iommu@lists.linux-foundation.org>; Fri, 08 Jan 2021 07:02:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=glgQFW7kM8hmWXtoybiQQhFk+nRduu62qvfDCI4eUuo=;
 b=MG97V7CT/lZ/B9evctCewK363gKZ+3KiM85e7mwnaEFFhfvdmANNctUZMCkWea6m2c
 y9JbDyd83+QZWNebbFl1XohTEAfiymYtPnr8I5QXFNso7vxshtjN+2Kr9XX7XfxRGoVF
 kdqbMiLyEnhELcyFWL33dIF+Z2j3VGFTU9ZwXiiuOzGxVt+wKTfopNOQMbOXSrcuq4G7
 +6zWzaEl3bBn0BXKGW/dKkLgc/pnTUQcYL7XdWY4dOlRa7cMWQLTLb/aivovSNEunw9Y
 iaVGDOQ9FEpEiOktUQU70rzBN9DAl+JxI8MySkT7XOjWQz3KypPDtDfUJFGenPxpQMV9
 XOiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=glgQFW7kM8hmWXtoybiQQhFk+nRduu62qvfDCI4eUuo=;
 b=jpsR1+CdRZMDlHkgPsIbciNreT3sH/I93MOSoH3m3CZSSYHbCqviAPQYFYP7as2aUS
 HpyW4nBCFzTRY5ZucxBcZKs4IEGqRbwD1MMknt98Q/UwP/8Bj0fwYd4i3WaLDGy7sP37
 DfngXGdpfhJm0VQOvF2XEcsF3GU9Y+tnE0+FXuK3GX1onTWcK5fMD4x4o936sr2apqzn
 scmd3zMSLz5ICp9DzzuW1cYS6pPoLosGvGSWg6m8DWuITi27nBCCcG30VoNi4zi2/HRc
 r6ROlb3V/wAafGigTUoCGYB+vivWya5EsJKFeCxXNRqsDaIq2LATlvjWNCPUF2LvFzEi
 b+5Q==
X-Gm-Message-State: AOAM533cYwnYgfvXsq6i76R3uN75zRyN3uvQRTGZzH9rr0LaP46yRCZJ
 xMr43VRaaOWiOgzA2vcHx5moCxzEvZg0dA==
X-Google-Smtp-Source: ABdhPJzqMQ5/Vme0bjJMr2Logxq8jK6Q7oFlWy2kXgzfP9ZlVTQt7eKTUQpSXxby55CCipER5aZqrw==
X-Received: by 2002:a1c:2d6:: with SMTP id 205mr3469208wmc.60.1610118159297;
 Fri, 08 Jan 2021 07:02:39 -0800 (PST)
Received: from localhost.localdomain
 ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id s13sm14258464wra.53.2021.01.08.07.02.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Jan 2021 07:02:38 -0800 (PST)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: joro@8bytes.org,
	will@kernel.org
Subject: [PATCH v9 08/10] dt-bindings: document stall property for IOMMU
 masters
Date: Fri,  8 Jan 2021 15:52:16 +0100
Message-Id: <20210108145217.2254447-9-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210108145217.2254447-1-jean-philippe@linaro.org>
References: <20210108145217.2254447-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Cc: devicetree@vger.kernel.org, linux-acpi@vger.kernel.org,
 Jean-Philippe Brucker <jean-philippe@linaro.org>, guohanjun@huawei.com,
 rjw@rjwysocki.net, iommu@lists.linux-foundation.org, robh+dt@kernel.org,
 linux-accelerators@lists.ozlabs.org, sudeep.holla@arm.com,
 vivek.gautam@arm.com, zhangfei.gao@linaro.org, robin.murphy@arm.com,
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
2.29.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
