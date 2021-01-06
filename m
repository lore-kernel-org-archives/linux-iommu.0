Return-Path: <SRS0=DPil=GJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E58F8C433E0
	for <iommu@archiver.kernel.org>; Wed,  6 Jan 2021 03:42:12 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE88122D04
	for <iommu@archiver.kernel.org>; Wed,  6 Jan 2021 03:42:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE88122D04
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 660CB86AF8;
	Wed,  6 Jan 2021 03:42:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8hXv6IAMZxHo; Wed,  6 Jan 2021 03:42:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id D21B686AEF;
	Wed,  6 Jan 2021 03:42:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BEC0AC0891;
	Wed,  6 Jan 2021 03:42:11 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 96368C013A
 for <iommu@lists.linux-foundation.org>; Wed,  6 Jan 2021 03:42:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 9279E855CE
 for <iommu@lists.linux-foundation.org>; Wed,  6 Jan 2021 03:42:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PxKV_k4p5BmX for <iommu@lists.linux-foundation.org>;
 Wed,  6 Jan 2021 03:42:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com
 [209.85.216.52])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 09D5885570
 for <iommu@lists.linux-foundation.org>; Wed,  6 Jan 2021 03:42:10 +0000 (UTC)
Received: by mail-pj1-f52.google.com with SMTP id hk16so886635pjb.4
 for <iommu@lists.linux-foundation.org>; Tue, 05 Jan 2021 19:42:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=FZGRSIKNWZAaAhyn9I46mv2qEvPmwpxpVmXsznFggAw=;
 b=gGxBXOihHsm3ZVDHLv31fDSdj1SXhYQbdn9k5cmAoncGt12QQUfM/c3IHcaEnDkA5J
 ocQxp+U8gmPg/aUt1mhhV6zZJ8VXZG4qoywct4SKLATrpd2CnwkRGzp6iVjwWvWh4uPB
 8z3i8pIB+5J9HuYE/Sxl8iNS0nIPHFjKwJX1c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=FZGRSIKNWZAaAhyn9I46mv2qEvPmwpxpVmXsznFggAw=;
 b=LGoJ2p81i/BugYJ1rudwssIlHcu5G2zbGs+2spUp5jslR+4McH2Up0ZpeZeCiWbmRy
 DDUuC70nWD3ULojU6qKXm58UwtwtfpyzFAAzyOfLeYTm0bp9vN77+wwVuwdwnexxMaU5
 rpb6aLbtFMedawPOCGBd6O7QnFFUIAQeGdqDz1PARS9Zl6cog16GjmOzRjcEIbx6j7hH
 7bDixLFGe8HxW0trMAoh/8YXEriQpUs8yB/BYapFXkq/ln2Xi09HacmW34sTTNpjCuuP
 ZaYpCkDjUiUIPvXwAzcwPJOQFjLAC2VUfIR+cZOsRrCSpdTXSyG6coYe3iEUt/6Zp9J+
 pthw==
X-Gm-Message-State: AOAM533Fc6laJeBgEVRCeoZczVTUSkKVX6Pi2r3jHvgyZTurPj13ePz/
 XxT2q2n+E+JIgsPYThpVsBfbKg==
X-Google-Smtp-Source: ABdhPJz3c69cs7bN5kIpvTYTxsM3wMIyOYfyNKD7ypyEM9IFVwp2OokHNuXw3jIYJjMTgHoQH4pU0Q==
X-Received: by 2002:a17:90a:5802:: with SMTP id
 h2mr2368082pji.68.1609904529594; 
 Tue, 05 Jan 2021 19:42:09 -0800 (PST)
Received: from localhost ([2401:fa00:1:10:3e52:82ff:fe5e:cc9d])
 by smtp.gmail.com with ESMTPSA id f7sm581725pjs.25.2021.01.05.19.42.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Jan 2021 19:42:09 -0800 (PST)
From: Claire Chang <tientzu@chromium.org>
To: robh+dt@kernel.org, mpe@ellerman.id.au, benh@kernel.crashing.org,
 paulus@samba.org, joro@8bytes.org, will@kernel.org, frowand.list@gmail.com,
 konrad.wilk@oracle.com, boris.ostrovsky@oracle.com, jgross@suse.com,
 sstabellini@kernel.org, hch@lst.de, m.szyprowski@samsung.com,
 robin.murphy@arm.com
Subject: [RFC PATCH v3 5/6] dt-bindings: of: Add restricted DMA pool
Date: Wed,  6 Jan 2021 11:41:23 +0800
Message-Id: <20210106034124.30560-6-tientzu@chromium.org>
X-Mailer: git-send-email 2.29.2.729.g45daf8777d-goog
In-Reply-To: <20210106034124.30560-1-tientzu@chromium.org>
References: <20210106034124.30560-1-tientzu@chromium.org>
MIME-Version: 1.0
Cc: heikki.krogerus@linux.intel.com, peterz@infradead.org, grant.likely@arm.com,
 mingo@kernel.org, drinkcat@chromium.org, saravanak@google.com,
 xypron.glpk@gmx.de, rafael.j.wysocki@intel.com, bgolaszewski@baylibre.com,
 xen-devel@lists.xenproject.org, treding@nvidia.com, devicetree@vger.kernel.org,
 Claire Chang <tientzu@chromium.org>, dan.j.williams@intel.com,
 andriy.shevchenko@linux.intel.com, gregkh@linuxfoundation.org,
 rdunlap@infradead.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org
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
region by restricted-dma-pool in the device tree.

Signed-off-by: Claire Chang <tientzu@chromium.org>
---
 .../reserved-memory/reserved-memory.txt       | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt b/Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt
index e8d3096d922c..44975e2a1fd2 100644
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
+          system memory corruption, the system needs to provide way to restrict
+          the DMA to a predefined memory region.
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
2.29.2.729.g45daf8777d-goog

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
