Return-Path: <SRS0=nJTY=HL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 965A1C433E0
	for <iommu@archiver.kernel.org>; Tue,  9 Feb 2021 06:23:20 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 401FF64EB9
	for <iommu@archiver.kernel.org>; Tue,  9 Feb 2021 06:23:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 401FF64EB9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 17D93861C8;
	Tue,  9 Feb 2021 06:23:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id y3P4JTKuLDGA; Tue,  9 Feb 2021 06:23:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 8D6CB85FE4;
	Tue,  9 Feb 2021 06:23:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 77F42C0174;
	Tue,  9 Feb 2021 06:23:19 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6F0A0C013A
 for <iommu@lists.linux-foundation.org>; Tue,  9 Feb 2021 06:23:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 6114986F93
 for <iommu@lists.linux-foundation.org>; Tue,  9 Feb 2021 06:23:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Isxf3LejMqCY for <iommu@lists.linux-foundation.org>;
 Tue,  9 Feb 2021 06:23:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com
 [209.85.210.170])
 by hemlock.osuosl.org (Postfix) with ESMTPS id CB2C086F8D
 for <iommu@lists.linux-foundation.org>; Tue,  9 Feb 2021 06:23:17 +0000 (UTC)
Received: by mail-pf1-f170.google.com with SMTP id b145so11261993pfb.4
 for <iommu@lists.linux-foundation.org>; Mon, 08 Feb 2021 22:23:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=eRi8Yzf5Y8qG5991xxXPsSC5LTyacs0FIIEghf5qlqE=;
 b=I1pOI9d2uMAOj25XXD6wAuAIs02PiqHn3vYbrTGQfRLUalLAaaWHj4AP66p1gZRw6c
 B3Fs+yS4m4TscPVDCU+jECnoKxyq5OcojOQ3UlsKgJX/2bKZw0g3cUyt8Lb9tyEzB+I7
 d4RC5Ezyz3o4oj5hhy8N+DKnKQ48mOYCkG1WM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=eRi8Yzf5Y8qG5991xxXPsSC5LTyacs0FIIEghf5qlqE=;
 b=DCyTeIpPCPuiFAIetMEAFlZG7OOjYOHIevza48kefOwfWOAwM9xDXsucc4t00Pw4Fz
 rNz0IHobes+G/x6IRJQWPyedi7ousRw9+uf1xz7cNDsPI02cLCHwruxfFbjJaCRThjZw
 seP+TLvK5g/DsKDVjut3RlO5D+d6IKmzcu1X3JfjsjHJBJEzBN78q4ErErPifJirAYlD
 2pjjmS8RYzbN3EwOA0uoGcLJqyDAAcs6gb4kiHPrc5T4EUEGxDSv5Vcd/+hiV+7rgx4S
 158xYuKC1Oig338ObaY/22MZP+jiL9K1nGa8gXG3fQL1uOw2s4UDjX8i5bgvOkK841rV
 YKCg==
X-Gm-Message-State: AOAM533VRZvUjB7As9E1ZrcObmn6O9E+1+tAgKY7xOHWsWNp64DueN/c
 T08oRjXK0uJPtisl+SHLpi9Lm8O/fyOwJQ==
X-Google-Smtp-Source: ABdhPJxkt3Ed7T7cJDKzmZe4wszjCxFAf1leiOQT2ICOasIg3V/FKQTBEDaG8y6oYK6K58aSdM216A==
X-Received: by 2002:a05:6a00:a8d:b029:1ba:71d1:fe3c with SMTP id
 b13-20020a056a000a8db02901ba71d1fe3cmr21262398pfl.51.1612851797444; 
 Mon, 08 Feb 2021 22:23:17 -0800 (PST)
Received: from localhost ([2401:fa00:1:10:a106:46e1:a999:81df])
 by smtp.gmail.com with UTF8SMTPSA id a8sm1160332pjs.40.2021.02.08.22.23.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Feb 2021 22:23:16 -0800 (PST)
From: Claire Chang <tientzu@chromium.org>
To: Rob Herring <robh+dt@kernel.org>, mpe@ellerman.id.au,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Frank Rowand <frowand.list@gmail.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, boris.ostrovsky@oracle.com,
 jgross@suse.com, Christoph Hellwig <hch@lst.de>,
 Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH v4 13/14] dt-bindings: of: Add restricted DMA pool
Date: Tue,  9 Feb 2021 14:21:30 +0800
Message-Id: <20210209062131.2300005-14-tientzu@chromium.org>
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
In-Reply-To: <20210209062131.2300005-1-tientzu@chromium.org>
References: <20210209062131.2300005-1-tientzu@chromium.org>
MIME-Version: 1.0
Cc: heikki.krogerus@linux.intel.com, peterz@infradead.org,
 benh@kernel.crashing.org, grant.likely@arm.com, paulus@samba.org,
 mingo@kernel.org, sstabellini@kernel.org,
 Saravana Kannan <saravanak@google.com>, xypron.glpk@gmx.de,
 "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 xen-devel@lists.xenproject.org, Thierry Reding <treding@nvidia.com>,
 linux-devicetree <devicetree@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org,
 Nicolas Boichat <drinkcat@chromium.org>, Claire Chang <tientzu@chromium.org>,
 Dan Williams <dan.j.williams@intel.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Greg KH <gregkh@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>,
 lkml <linux-kernel@vger.kernel.org>,
 "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 Jim Quinlan <james.quinlan@broadcom.com>, Robin Murphy <robin.murphy@arm.com>
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

Introduce the new compatible string, restricted-dma-pool, for restricted
DMA. One can specify the address and length of the restricted DMA memory
region by restricted-dma-pool in the reserved-memory node.

Signed-off-by: Claire Chang <tientzu@chromium.org>
---
 .../reserved-memory/reserved-memory.txt       | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt b/Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt
index e8d3096d922c..fc9a12c2f679 100644
--- a/Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt
+++ b/Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt
@@ -51,6 +51,20 @@ compatible (optional) - standard definition
           used as a shared pool of DMA buffers for a set of devices. It can
           be used by an operating system to instantiate the necessary pool
           management subsystem if necessary.
+        - restricted-dma-pool: This indicates a region of memory meant to be
+          used as a pool of restricted DMA buffers for a set of devices. The
+          memory region would be the only region accessible to those devices.
+          When using this, the no-map and reusable properties must not be set,
+          so the operating system can create a virtual mapping that will be used
+          for synchronization. The main purpose for restricted DMA is to
+          mitigate the lack of DMA access control on systems without an IOMMU,
+          which could result in the DMA accessing the system memory at
+          unexpected times and/or unexpected addresses, possibly leading to data
+          leakage or corruption. The feature on its own provides a basic level
+          of protection against the DMA overwriting buffer contents at
+          unexpected times. However, to protect against general data leakage and
+          system memory corruption, the system needs to provide way to lock down
+          the memory access, e.g., MPU.
         - vendor specific string in the form <vendor>,[<device>-]<usage>
 no-map (optional) - empty property
     - Indicates the operating system must not create a virtual mapping
@@ -120,6 +134,11 @@ one for multimedia processing (named multimedia-memory@77000000, 64MiB).
 			compatible = "acme,multimedia-memory";
 			reg = <0x77000000 0x4000000>;
 		};
+
+		restricted_dma_mem_reserved: restricted_dma_mem_reserved {
+			compatible = "restricted-dma-pool";
+			reg = <0x50000000 0x400000>;
+		};
 	};
 
 	/* ... */
@@ -138,4 +157,9 @@ one for multimedia processing (named multimedia-memory@77000000, 64MiB).
 		memory-region = <&multimedia_reserved>;
 		/* ... */
 	};
+
+	pcie_device: pcie_device@0,0 {
+		memory-region = <&restricted_dma_mem_reserved>;
+		/* ... */
+	};
 };
-- 
2.30.0.478.g8a0d178c01-goog

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
