Return-Path: <SRS0=ZJ+1=4B=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A637FC3B18C
	for <iommu@archiver.kernel.org>; Thu, 13 Feb 2020 16:40:15 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7ACF12467C
	for <iommu@archiver.kernel.org>; Thu, 13 Feb 2020 16:40:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EfmemPcp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7ACF12467C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 42DDE8610F;
	Thu, 13 Feb 2020 16:40:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MdxYdk8VyRT6; Thu, 13 Feb 2020 16:40:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id BEA4A86101;
	Thu, 13 Feb 2020 16:40:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A8A4AC07FE;
	Thu, 13 Feb 2020 16:40:14 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5FCD0C0177
 for <iommu@lists.linux-foundation.org>; Thu, 13 Feb 2020 16:40:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 5C75586E33
 for <iommu@lists.linux-foundation.org>; Thu, 13 Feb 2020 16:40:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LjaJieleJXtC for <iommu@lists.linux-foundation.org>;
 Thu, 13 Feb 2020 16:40:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com
 [209.85.221.67])
 by whitealder.osuosl.org (Postfix) with ESMTPS id DE53686E69
 for <iommu@lists.linux-foundation.org>; Thu, 13 Feb 2020 16:40:11 +0000 (UTC)
Received: by mail-wr1-f67.google.com with SMTP id z7so7478657wrl.13
 for <iommu@lists.linux-foundation.org>; Thu, 13 Feb 2020 08:40:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=p2uFK6KKYdYtPUVDDYy0uzQtv76HpgnZNeuTDoj+jDo=;
 b=EfmemPcpI15FP/1eISeFgDAvHIXtZK3NjmSai3nK0kaddNyEb3kwxnYrMueDFUUeu5
 QZXPsxXUeKhm+I1xCUtqKpNbEFUrRG+W0xnv9+iBYhvw1HpaDj0XzuMIuU/41vpkdzJy
 2Zj7VZOOpDYX3rwrl969E0vMCN1vCDTSoomL1riWQ8I/nfkbsyPpQPHk/9t4CKyWXdOt
 8tnkI+e1GwURyuaF0LvmZJ5sU7PJHVxEG0McRg1k/sEyxCUcu6IlSzj+OQI2ZYRB6jLx
 npIlIBX0yaq9tDFy67rke6kHOCkCnJTuIipXoJgzFEzoUgiqxbw9615ulXtKQT3DQhXK
 /EEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=p2uFK6KKYdYtPUVDDYy0uzQtv76HpgnZNeuTDoj+jDo=;
 b=EH0sCWgO949Cg5DKF1ndU8AnaNXP6JWTg2S2CESK7rpJG+n/LDGLT4Gq4bzozAOvEn
 y2pbXpARGGV+fdVgR9OahgcRpo3Ds9+PCW+B8T5gJ1gFMlxnmmeXuR2Tl8uS/jum+nny
 htry47z3DFl7jzhjzoRUkQuF7vjF/gjZJk9KhfRjjPQHP73qH82N0RLxkBF8TDZlQMtt
 2OiswFlDfn3S2+RLpq897gMcZ6M7roJvXxX4mzj8CakpfAonb83sW+xsNXoKEsl2dgEt
 zf1LhpN6lNp0z+DTth29q6mHmo1nPRuOYZIqlNKuSDaWCMFP++02WOMXubq1brqQtzcL
 DOrQ==
X-Gm-Message-State: APjAAAVtdDVNgw1WRemaO32k8yJ6KJ4w80fRzZfck61H8O1eHqJpyH3K
 /fJxizVAdRdOzZVgxsNn084=
X-Google-Smtp-Source: APXvYqx8VQjaga8fOGZZT0G2o0Kvfo0ucpKfM5avVBwqi0khvmBAtSsPumSuFOqEEXt3q4LjhRwyEg==
X-Received: by 2002:a5d:5403:: with SMTP id g3mr23784994wrv.302.1581612010365; 
 Thu, 13 Feb 2020 08:40:10 -0800 (PST)
Received: from localhost (p2E5BEF3F.dip0.t-ipconnect.de. [46.91.239.63])
 by smtp.gmail.com with ESMTPSA id o4sm3454944wrx.25.2020.02.13.08.40.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2020 08:40:08 -0800 (PST)
From: Thierry Reding <thierry.reding@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v4 1/5] dt-bindings: Add memory controller bindings
Date: Thu, 13 Feb 2020 17:39:55 +0100
Message-Id: <20200213163959.819733-2-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200213163959.819733-1-thierry.reding@gmail.com>
References: <20200213163959.819733-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Cc: linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
 iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org
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

Add the DT schema for memory controller and consumer bindings.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 .../bindings/memory-controllers/consumer.yaml | 14 ++++++++
 .../memory-controllers/memory-controller.yaml | 32 +++++++++++++++++++
 2 files changed, 46 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/consumer.yaml
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/memory-controller.yaml

diff --git a/Documentation/devicetree/bindings/memory-controllers/consumer.yaml b/Documentation/devicetree/bindings/memory-controllers/consumer.yaml
new file mode 100644
index 000000000000..7b71a6110c51
--- /dev/null
+++ b/Documentation/devicetree/bindings/memory-controllers/consumer.yaml
@@ -0,0 +1,14 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/memory-controllers/consumer.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Common memory controller consumer binding
+
+maintainers:
+  - Thierry Reding <thierry.reding@gmail.com>
+
+properties:
+  memory-controller:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
diff --git a/Documentation/devicetree/bindings/memory-controllers/memory-controller.yaml b/Documentation/devicetree/bindings/memory-controllers/memory-controller.yaml
new file mode 100644
index 000000000000..26257a666c3c
--- /dev/null
+++ b/Documentation/devicetree/bindings/memory-controllers/memory-controller.yaml
@@ -0,0 +1,32 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/memory-controllers/memory-controller.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Common memory controller binding
+
+maintainers:
+  - Thierry Reding <thierry.reding@gmail.com>
+
+description: |
+  The memory access hierarchy in a modern device can be fairly complicated.
+  Accesses to system memory typically end up going through a memory controller
+  that ensures that data is stored. Along the way, these accesses can undergo
+  classification and be prioritized and/or arbitrated.
+
+  The interconnect bindings (see ../interconnect/interconnect.txt) provides a
+  way of describing the data paths between devices and system memory. However
+  these interconnect paths, in order to be most flexible, describe the paths
+  in a very fine-grained way, so situations can arise where it is no longer
+  possible to derive a unique memory parent for any given device.
+
+  In order to remove such potential ambiguities, a memory controller can be
+  specified in device tree. A memory controller specified in this way will be
+  used as the DMA parent for a given device. The memory controller defines a
+  memory bus via the "dma-ranges" property, which will in turn be used to set
+  the range of memory accessible to DMA children of the memory controller.
+
+properties:
+  "#memory-controller-cells": true
+  dma-ranges: true
-- 
2.24.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
