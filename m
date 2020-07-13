Return-Path: <SRS0=SFHS=AY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D2EEC433E3
	for <iommu@archiver.kernel.org>; Mon, 13 Jul 2020 09:35:27 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 417372068F
	for <iommu@archiver.kernel.org>; Mon, 13 Jul 2020 09:35:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="e67OPwf1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 417372068F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 195D8873A8;
	Mon, 13 Jul 2020 09:35:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3ykDHchUZU0H; Mon, 13 Jul 2020 09:35:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 9F242873EF;
	Mon, 13 Jul 2020 09:35:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 874DAC08A0;
	Mon, 13 Jul 2020 09:35:25 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B7B06C0733
 for <iommu@lists.linux-foundation.org>; Mon, 13 Jul 2020 09:12:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 99459203C2
 for <iommu@lists.linux-foundation.org>; Mon, 13 Jul 2020 09:12:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nvpCTo4BM340 for <iommu@lists.linux-foundation.org>;
 Mon, 13 Jul 2020 09:12:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com
 [209.85.215.193])
 by silver.osuosl.org (Postfix) with ESMTPS id EC8F8204B1
 for <iommu@lists.linux-foundation.org>; Mon, 13 Jul 2020 09:12:49 +0000 (UTC)
Received: by mail-pg1-f193.google.com with SMTP id o13so5780154pgf.0
 for <iommu@lists.linux-foundation.org>; Mon, 13 Jul 2020 02:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=+P8dd4dsLzR3swPupkVuVT/gmICFutJbXFpV5NolUAQ=;
 b=e67OPwf1HIbj3XR4EOfuTCpxuygeGjjAfXvsgSif0nsuT/tPms6AxxDckXWU9kQ4el
 HVxOOk1iLRoQoAHU1WwmubXO5KyvzzdzXKmHm2RMInBlI1sC1gw6YiMKd4GHMPeZjcyk
 CxiYiu9iHJ53DICoiCsewCTgy6pX9Yf2fElGo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=+P8dd4dsLzR3swPupkVuVT/gmICFutJbXFpV5NolUAQ=;
 b=rsh7Hx8rZpT7X1UCf0xrhcnupXm1dg5ZA/kZQW07X35zBwJwIaGDDHjNCtW706GezK
 x54BQF1JWj0D63q3DlSWJVX6K1ipR15Em1QgBxLJGbagbnwfAya/qhXgATg6FDzH0qzJ
 cgO6ZVkPFWWB/Mpghk8VpwT4r4Xt7zJGcS4x0mY2JpBajP+oG3UAmdo7usz/NY3yKeND
 QJF6na6lCOMXz6F72arWXMQT7pd57OI38o/IGeODcAlVl9hH8KvWLoA6H7pVpv/3cOu9
 d3qmbd0R7ot0cHYmAPpfY5L7fnJTO/aR2RoJ1DTDwhltvMeYugLpu0BVnQkTzg6WrzCF
 qe7Q==
X-Gm-Message-State: AOAM531633X539Qvi/IGSw5goLumjfVe8l6LCB+HZqHabCq2uKCU55A8
 cdFKyglve4B87AbKxWn/otStrg==
X-Google-Smtp-Source: ABdhPJwiVcgRHj8QaLGk5eyRoZthzOPp5a/LkxFv7ElLZgecHc8H4MvmE9E/lcRqY9ykY343uYMmDg==
X-Received: by 2002:a63:1104:: with SMTP id g4mr66811073pgl.369.1594631569568; 
 Mon, 13 Jul 2020 02:12:49 -0700 (PDT)
Received: from localhost ([2401:fa00:1:10:3e52:82ff:fe5e:cc9d])
 by smtp.gmail.com with ESMTPSA id i132sm13807520pfe.9.2020.07.13.02.12.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Jul 2020 02:12:48 -0700 (PDT)
From: Claire Chang <tientzu@chromium.org>
To: robh+dt@kernel.org, frowand.list@gmail.com, hch@lst.de,
 m.szyprowski@samsung.com, robin.murphy@arm.com
Subject: [PATCH 3/4] dt-bindings: of: Add plumbing for bounced DMA pool
Date: Mon, 13 Jul 2020 17:12:10 +0800
Message-Id: <20200713091211.2183368-4-tientzu@chromium.org>
X-Mailer: git-send-email 2.27.0.383.g050319c2ae-goog
In-Reply-To: <20200713091211.2183368-1-tientzu@chromium.org>
References: <20200713091211.2183368-1-tientzu@chromium.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Mon, 13 Jul 2020 09:35:23 +0000
Cc: devicetree@vger.kernel.org, heikki.krogerus@linux.intel.com,
 saravanak@google.com, suzuki.poulose@arm.com, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, bgolaszewski@baylibre.com,
 iommu@lists.linux-foundation.org, drinkcat@chromium.org,
 Claire Chang <tientzu@chromium.org>, dan.j.williams@intel.com,
 treding@nvidia.com
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

Introduce the new compatible string, bounced-dma-pool, for bounced DMA.
One can specify the address and length of the bounced memory region by
bounced-dma-pool in the device tree.

Signed-off-by: Claire Chang <tientzu@chromium.org>
---
 .../reserved-memory/reserved-memory.txt       | 36 +++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt b/Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt
index 4dd20de6977f..45b3134193ea 100644
--- a/Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt
+++ b/Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt
@@ -51,6 +51,24 @@ compatible (optional) - standard definition
           used as a shared pool of DMA buffers for a set of devices. It can
           be used by an operating system to instantiate the necessary pool
           management subsystem if necessary.
+        - bounced-dma-pool: This indicates a region of memory meant to be used
+          as a pool of DMA bounce buffers for a given device. When using this,
+          the no-map and reusable properties must not be set, so the operating
+          system can create a virtual mapping that will be used for
+          synchronization. Also, there must be a bounced-dma property in the
+          device node to specify the indexes of reserved-memory nodes. One can
+          specify two reserved-memory nodes in the device tree. One with
+          shared-dma-pool to handle the coherent DMA buffer allocation, and
+          another one with bounced-dma-pool for regular DMA to/from system
+          memory, which would be subject to bouncing. The main purpose for
+          bounced DMA is to mitigate the lack of DMA access control on systems
+          without an IOMMU, which could result in the DMA accessing the system
+          memory at unexpected times and/or unexpected addresses, possibly
+          leading to data leakage or corruption. The feature on its own provides
+          a basic level of protection against the DMA overwriting buffer
+          contents at unexpected times. However, to protect against general data
+          leakage and system memory corruption, the system needs to provide a
+          way to restrict the DMA to a predefined memory region.
         - vendor specific string in the form <vendor>,[<device>-]<usage>
 no-map (optional) - empty property
     - Indicates the operating system must not create a virtual mapping
@@ -117,6 +135,17 @@ one for multimedia processing (named multimedia-memory@77000000, 64MiB).
 			compatible = "acme,multimedia-memory";
 			reg = <0x77000000 0x4000000>;
 		};
+
+		wifi_bounced_dma_mem_region: wifi_bounced_dma_mem_region {
+			compatible = "bounced-dma-pool";
+			reg = <0x50000000 0x4000000>;
+		};
+
+		wifi_coherent_mem_region: wifi_coherent_mem_region {
+			compatible = "shared-dma-pool";
+			reg = <0x54000000 0x400000>;
+		};
+
 	};
 
 	/* ... */
@@ -135,4 +164,11 @@ one for multimedia processing (named multimedia-memory@77000000, 64MiB).
 		memory-region = <&multimedia_reserved>;
 		/* ... */
 	};
+
+	pcie_wifi: pcie_wifi@0,0 {
+		memory-region = <&wifi_bounced_dma_mem_region>,
+			 <&wifi_coherent_mem_region>;
+		bounced-dma = <0>, <1>;
+		/* ... */
+	};
 };
-- 
2.27.0.383.g050319c2ae-goog

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
