Return-Path: <SRS0=UphA=BH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 161CEC433FE
	for <iommu@archiver.kernel.org>; Tue, 28 Jul 2020 05:02:09 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC07121744
	for <iommu@archiver.kernel.org>; Tue, 28 Jul 2020 05:02:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FFJEqir1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC07121744
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id CDA698788B;
	Tue, 28 Jul 2020 05:02:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mr2gqWk8kmR3; Tue, 28 Jul 2020 05:02:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 4980E8780F;
	Tue, 28 Jul 2020 05:02:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2556EC004F;
	Tue, 28 Jul 2020 05:02:08 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4D905C004D
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jul 2020 05:02:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 482DE881B7
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jul 2020 05:02:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lWJ+rxqOByek for <iommu@lists.linux-foundation.org>;
 Tue, 28 Jul 2020 05:02:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com
 [209.85.210.195])
 by hemlock.osuosl.org (Postfix) with ESMTPS id B38C687158
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jul 2020 05:02:06 +0000 (UTC)
Received: by mail-pf1-f195.google.com with SMTP id d188so4223944pfd.2
 for <iommu@lists.linux-foundation.org>; Mon, 27 Jul 2020 22:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=quJpJ8MFVCXxN2uUe5uCTDrzupsmhmPuwJ3x/xpP/Nw=;
 b=FFJEqir1hVkStEtfk+rEgzo8ZUuB5JUH7sJuO0JVeZhFlRfq6eDnq0M4SOi7xAzJNL
 Lg/B3hHFlX31yqXoVUvS53JbUcgSOfKFc9jlDruvAYag4p2p8uxI5CayvTuyOTxTzb2Y
 CmbNlaHf7A4Fl7V3TquMd4DohiBBSI7zhVcCs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=quJpJ8MFVCXxN2uUe5uCTDrzupsmhmPuwJ3x/xpP/Nw=;
 b=PGizq0rPEybWNeSBNUsHc2/OiGJsHCb8s6RomU8rc5TGFPR2AkAAnbiDJobEOsPoyj
 35k2aM/gLbCupM/hGvenPNGssm0qhp8ebG6PDJgGNhGqiUEyWJTFmoo9KJ+RhlAq2NTV
 fPVVKLZCsaf/rk0FpHCcXvruftfEdAM2Tj5RGQd92SEGjNSZ+h3wo7yiEgIJzRwZmOmS
 9/3Q3unkFokWZQdp41rB0w6nlHZKm9X5gqNe3+nMZBdYy0cgJXYaemSOAXcvuDrk7VdZ
 1LQDQyToGx4AiwcudgtWBKGsggM01MNaIguxgnfLr4WL1OZzjGv6dAgaGgKcB6xLVm8J
 VeKA==
X-Gm-Message-State: AOAM533/VmytyXJU26yUAj3k9gSJbFwG6sFIQ/IoyjJ2Dy9ZiK+pIJVf
 E8EDB1+6UM19S4GKzqJdkTygLw==
X-Google-Smtp-Source: ABdhPJxRMJ3gCBUPChJ2eZ/7cp0FgFLdngDiw44ugrhRF2b1gUjV2mSJdfqzvUQMjkMMzXOG1e/voQ==
X-Received: by 2002:a65:428d:: with SMTP id j13mr23297111pgp.211.1595912526277; 
 Mon, 27 Jul 2020 22:02:06 -0700 (PDT)
Received: from localhost ([2401:fa00:1:10:3e52:82ff:fe5e:cc9d])
 by smtp.gmail.com with ESMTPSA id a26sm17578156pgm.20.2020.07.27.22.02.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Jul 2020 22:02:05 -0700 (PDT)
From: Claire Chang <tientzu@chromium.org>
To: robh+dt@kernel.org, frowand.list@gmail.com, hch@lst.de,
 m.szyprowski@samsung.com, robin.murphy@arm.com
Subject: [RFC v2 4/5] dt-bindings: of: Add plumbing for restricted DMA pool
Date: Tue, 28 Jul 2020 13:01:39 +0800
Message-Id: <20200728050140.996974-5-tientzu@chromium.org>
X-Mailer: git-send-email 2.28.0.rc0.142.g3c755180ce-goog
In-Reply-To: <20200728050140.996974-1-tientzu@chromium.org>
References: <20200728050140.996974-1-tientzu@chromium.org>
MIME-Version: 1.0
Cc: devicetree@vger.kernel.org, heikki.krogerus@linux.intel.com,
 saravanak@google.com, suzuki.poulose@arm.com, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, bgolaszewski@baylibre.com,
 iommu@lists.linux-foundation.org, drinkcat@chromium.org, tientzu@chromium.org,
 dan.j.williams@intel.com, treding@nvidia.com
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

Introduce the new compatible string, device-swiotlb-pool, for restricted
DMA. One can specify the address and length of the device swiotlb memory
region by device-swiotlb-pool in the device tree.

Signed-off-by: Claire Chang <tientzu@chromium.org>
---
 .../reserved-memory/reserved-memory.txt       | 35 +++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt b/Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt
index 4dd20de6977f..78850896e1d0 100644
--- a/Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt
+++ b/Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt
@@ -51,6 +51,24 @@ compatible (optional) - standard definition
           used as a shared pool of DMA buffers for a set of devices. It can
           be used by an operating system to instantiate the necessary pool
           management subsystem if necessary.
+        - device-swiotlb-pool: This indicates a region of memory meant to be
+          used as a pool of device swiotlb buffers for a given device. When
+          using this, the no-map and reusable properties must not be set, so the
+          operating system can create a virtual mapping that will be used for
+          synchronization. Also, there must be a restricted-dma property in the
+          device node to specify the indexes of reserved-memory nodes. One can
+          specify two reserved-memory nodes in the device tree. One with
+          shared-dma-pool to handle the coherent DMA buffer allocation, and
+          another one with device-swiotlb-pool for regular DMA to/from system
+          memory, which would be subject to bouncing. The main purpose for
+          restricted DMA is to mitigate the lack of DMA access control on
+          systems without an IOMMU, which could result in the DMA accessing the
+          system memory at unexpected times and/or unexpected addresses,
+          possibly leading to data leakage or corruption. The feature on its own
+          provides a basic level of protection against the DMA overwriting buffer
+          contents at unexpected times. However, to protect against general data
+          leakage and system memory corruption, the system needs to provide a
+          way to restrict the DMA to a predefined memory region.
         - vendor specific string in the form <vendor>,[<device>-]<usage>
 no-map (optional) - empty property
     - Indicates the operating system must not create a virtual mapping
@@ -117,6 +135,16 @@ one for multimedia processing (named multimedia-memory@77000000, 64MiB).
 			compatible = "acme,multimedia-memory";
 			reg = <0x77000000 0x4000000>;
 		};
+
+		wifi_coherent_mem_region: wifi_coherent_mem_region {
+			compatible = "shared-dma-pool";
+			reg = <0x50000000 0x400000>;
+		};
+
+		wifi_device_swiotlb_region: wifi_device_swiotlb_region {
+			compatible = "device-swiotlb-pool";
+			reg = <0x50400000 0x4000000>;
+		};
 	};
 
 	/* ... */
@@ -135,4 +163,11 @@ one for multimedia processing (named multimedia-memory@77000000, 64MiB).
 		memory-region = <&multimedia_reserved>;
 		/* ... */
 	};
+
+	pcie_wifi: pcie_wifi@0,0 {
+		memory-region = <&wifi_coherent_mem_region>,
+			 <&wifi_device_swiotlb_region>;
+		restricted-dma = <0>, <1>;
+		/* ... */
+	};
 };
-- 
2.28.0.rc0.142.g3c755180ce-goog

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
