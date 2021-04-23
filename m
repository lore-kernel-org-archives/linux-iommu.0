Return-Path: <SRS0=1bbG=JU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B654C43603
	for <iommu@archiver.kernel.org>; Fri, 23 Apr 2021 16:31:58 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9B41611C1
	for <iommu@archiver.kernel.org>; Fri, 23 Apr 2021 16:31:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9B41611C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 67BC040F4D;
	Fri, 23 Apr 2021 16:31:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dBUSujgqY2jD; Fri, 23 Apr 2021 16:31:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 23E30404AA;
	Fri, 23 Apr 2021 16:31:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F31C7C000E;
	Fri, 23 Apr 2021 16:31:55 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A3FE5C000B
 for <iommu@lists.linux-foundation.org>; Fri, 23 Apr 2021 16:31:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 921D9404AA
 for <iommu@lists.linux-foundation.org>; Fri, 23 Apr 2021 16:31:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iqh9cJhbCSA6 for <iommu@lists.linux-foundation.org>;
 Fri, 23 Apr 2021 16:31:53 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9621B404A9
 for <iommu@lists.linux-foundation.org>; Fri, 23 Apr 2021 16:31:53 +0000 (UTC)
Received: by mail-ej1-x62b.google.com with SMTP id x12so54007011ejc.1
 for <iommu@lists.linux-foundation.org>; Fri, 23 Apr 2021 09:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=O2SVOROkj7hDFGhnBCRYqhSUkByOx1CiX/oPNVqXG98=;
 b=FECThjuMq9dPQDyOW0X9vcyhSNbsn9dO90LdiAg7uh4P9LCGfocsWbmd9JGVREFsO8
 QRofm2fMa9fyVt0yOq0LXvy8kXQO1f9cL2CAJjhkcASMHCQBQFvmFnx7YhgT2C4Dtnje
 kzzKfoEbOw6xJRV8FOpr2bEIMN65YloznMwGyFs2NCVl1K4nAO4nnYrwvtf8jJJGs1ZL
 W31cvHgopE+qjO7cB8C6pA5LAHrqt8jBHdhph/lFGRPjUnS5uJhg0vPqdFn0ok1WO2+T
 UhYuAbfsCDyJkEESigRINetl6de60QiZWftCzZ/vakYMrsxAcO2Whk20WIH7/iKHe3NC
 aX8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=O2SVOROkj7hDFGhnBCRYqhSUkByOx1CiX/oPNVqXG98=;
 b=r8XtjD7guMZW7orKtOBcTfymiz3cHk0w7FHJyAb5WDaRhbn+lYVg6L0tzURN9WmBbY
 NIRfsqMEqilEGjXoFP6KUT/0Hul2vP9LLXMIsCOdFAjeNqTke/c70vpyDwLx/7bymG26
 kJzTgXLfW0d4DH5MWshBstl6Z0wfl1wJbQQWA23w5kTBwnaeEDv3KUZQA4om+A/kwcWB
 uXla3NHSre79F/fVWlmKSxmlq0eC7rvG+h1ZIp53F5qY7J2iG53I/LzCz9PKp8DZR7OV
 iS/uZhKRUsl1CDfhzEnoJ49fepMCFjEAlOYiQFEzjeFlsPP6WX+r0S72QPn2+YLwJWWv
 tzqg==
X-Gm-Message-State: AOAM5328Ym6z2GpsHIZDdhbXMXwaQIHrqfHmAKzm67+E9ML5wSOiai4u
 6c/57X25dxEUsrXH4I8wpUE=
X-Google-Smtp-Source: ABdhPJz9CNXlmBk9nKzg+Z7xoWbtmbCwYfZUQKFyrJz3hL4dHP4CO2jfhRQ9gxqdpjlqwhZchFQgTw==
X-Received: by 2002:a17:906:eb09:: with SMTP id
 mb9mr5094852ejb.452.1619195511868; 
 Fri, 23 Apr 2021 09:31:51 -0700 (PDT)
Received: from localhost ([62.96.65.119])
 by smtp.gmail.com with ESMTPSA id li16sm4252849ejb.101.2021.04.23.09.31.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Apr 2021 09:31:51 -0700 (PDT)
From: Thierry Reding <thierry.reding@gmail.com>
To: Joerg Roedel <joro@8bytes.org>,
	Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v2 1/5] dt-bindings: reserved-memory: Document memory region
 specifier
Date: Fri, 23 Apr 2021 18:32:30 +0200
Message-Id: <20210423163234.3651547-2-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210423163234.3651547-1-thierry.reding@gmail.com>
References: <20210423163234.3651547-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Cc: devicetree@vger.kernel.org, Will Deacon <will@kernel.org>,
 iommu@lists.linux-foundation.org, Nicolin Chen <nicolinc@nvidia.com>,
 linux-tegra@vger.kernel.org, Dmitry Osipenko <digetx@gmail.com>,
 Robin Murphy <robin.murphy@arm.com>
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

Reserved memory region phandle references can be accompanied by a
specifier that provides additional information about how that specific
reference should be treated.

One use-case is to mark a memory region as needing an identity mapping
in the system's IOMMU for the device that references the region. This is
needed for example when the bootloader has set up hardware (such as a
display controller) to actively access a memory region (e.g. a boot
splash screen framebuffer) during boot. The operating system can use the
identity mapping flag from the specifier to make sure an IOMMU identity
mapping is set up for the framebuffer before IOMMU translations are
enabled for the display controller.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 .../reserved-memory/reserved-memory.txt       | 21 +++++++++++++++++++
 include/dt-bindings/reserved-memory.h         |  8 +++++++
 2 files changed, 29 insertions(+)
 create mode 100644 include/dt-bindings/reserved-memory.h

diff --git a/Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt b/Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt
index e8d3096d922c..e9c2f80b441f 100644
--- a/Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt
+++ b/Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt
@@ -52,6 +52,11 @@ compatible (optional) - standard definition
           be used by an operating system to instantiate the necessary pool
           management subsystem if necessary.
         - vendor specific string in the form <vendor>,[<device>-]<usage>
+#memory-region-cells (optional) -
+    - Defines how many cells are used to form the memory region specifier.
+      The memory region specifier contains additional information on how a
+      reserved memory region referenced by the corresponding phandle will
+      be used in a specific context.
 no-map (optional) - empty property
     - Indicates the operating system must not create a virtual mapping
       of the region as part of its standard mapping of system memory,
@@ -83,6 +88,22 @@ memory-region (optional) - phandle, specifier pairs to children of /reserved-mem
 memory-region-names (optional) - a list of names, one for each corresponding
   entry in the memory-region property
 
+Reserved memory region references can be accompanied by a memory region
+specifier, which provides additional information about how the memory region
+will be used in that specific context. If a reserved memory region does not
+have the #memory-region-cells property, 0 is implied and no information
+besides the phandle is conveyed. For reserved memory regions that contain
+#memory-region-cells = <1>, the following encoding applies if not otherwise
+overridden by the bindings selected by the region's compatible string:
+
+  - bit 0: If set, requests that the region be identity mapped if the system
+    uses an IOMMU for I/O virtual address translations. This is used, for
+    example, when a bootloader has configured a display controller to display
+    a boot splash. Once the OS takes over and enables the IOMMU for the given
+    display controller, the IOMMU may fault if the framebuffer hasn't been
+    mapped to the IOMMU at the address that the display controller tries to
+    access.
+
 Example
 -------
 This example defines 3 contiguous regions are defined for Linux kernel:
diff --git a/include/dt-bindings/reserved-memory.h b/include/dt-bindings/reserved-memory.h
new file mode 100644
index 000000000000..174ca3448342
--- /dev/null
+++ b/include/dt-bindings/reserved-memory.h
@@ -0,0 +1,8 @@
+/* SPDX-License-Identifier: (GPL-2.0+ or MIT) */
+
+#ifndef _DT_BINDINGS_RESERVED_MEMORY_H
+#define _DT_BINDINGS_RESERVED_MEMORY_H
+
+#define MEMORY_REGION_IDENTITY_MAPPING 0x1
+
+#endif
-- 
2.30.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
