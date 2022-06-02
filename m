Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA341C433EF
	for <iommu@archiver.kernel.org>; Thu,  2 Jun 2022 19:24:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2ADFA83E82;
	Thu,  2 Jun 2022 19:24:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id twyJ4XRFwpIs; Thu,  2 Jun 2022 19:24:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id EC92B83E26;
	Thu,  2 Jun 2022 19:24:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C987FC0032;
	Thu,  2 Jun 2022 19:24:26 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4F2D9C002D
 for <iommu@lists.linux-foundation.org>; Thu,  2 Jun 2022 19:24:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 30F6F83E80
 for <iommu@lists.linux-foundation.org>; Thu,  2 Jun 2022 19:24:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id d4O860c146Gl for <iommu@lists.linux-foundation.org>;
 Thu,  2 Jun 2022 19:24:24 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3C19483E26
 for <iommu@lists.linux-foundation.org>; Thu,  2 Jun 2022 19:24:24 +0000 (UTC)
Received: by mail-ej1-x634.google.com with SMTP id s6so262735eja.0
 for <iommu@lists.linux-foundation.org>; Thu, 02 Jun 2022 12:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=JATYvLe48LS2H6IM0secvITvXQRFYJatDO7tIGdxKew=;
 b=VTT0OBaJLQkU0DXmYjkEMy4pAELAV+jBlguhxMn7A/UqRxOPNmS5CHgPtJ8qEHZ37t
 dJchUBQgCQYu0sVoQ3XZJeZMu/D3NfZmgNzNcTSM6d3mQgW/gfiuwtDFZ3C/zopEft70
 53psImCdfXqfPzsfnsJ0x1WX2TilCTwWqqoFx42M3g540JOK5MIBPNJ4HDu3rtPd0NvR
 Q9zPUyeZA5Hv2CYInUh8MlFvL4nmj/eO1LHolt3AXfJI734JjCLw7bSnIYS5ZeZ4TIuR
 W3MaS7EEAi42acDU5NxK7pTxBgmMuOOT0q63i2Wpbh1F/ySWKn407asxBaQC4EJYFYUB
 ZPxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=JATYvLe48LS2H6IM0secvITvXQRFYJatDO7tIGdxKew=;
 b=U9reKELh6gLF8PmUrU7b2sMdTfL/5E9r8NTUhZ+swwa3rGwm5Ha6VZLmq1iHj+G4U9
 B6I2RYA9DzUBa1BOHYyrN8a9CSMXKydDDtMZG0xA0hXRmqyuDGXUhmxuJh7Vobw+e0Kc
 Vbg7L82ueGCSvegIaIT91RwvBCoyBA0cBAUDV4PwaGp95rFB5C6hDXU8s32m4kqnWWWF
 pRY9VWBxvFBrtdom5/5PWy8nAteJ61awt9c/Uh9k61oKPYE+ADZ+4pkO5XZpiC0fW7mX
 MPgm7H7mgRT4bBZd8ZR+g1Yn6PUn2f26VmLIVDBlWkvVNWUMj4fFHAqTxLZ52Yh/poWw
 Pcfw==
X-Gm-Message-State: AOAM531ZbzwA17y1xuGrjgegyWNIrbrXiulPwTjxnlk42SfAtFu+xPWT
 0Q8/KqdbrCizvZWw4LZrRH0=
X-Google-Smtp-Source: ABdhPJwiCOLciOxN6TBYEcpArcIF1bwM/jhBDOJnBMmkSZAOupAwiR+Hr2XzW8lOBJHN2sRoLEmt4Q==
X-Received: by 2002:a17:906:8146:b0:6ff:119c:881f with SMTP id
 z6-20020a170906814600b006ff119c881fmr5659395ejw.38.1654197862292; 
 Thu, 02 Jun 2022 12:24:22 -0700 (PDT)
Received: from otyshchenko.router ([212.22.223.21])
 by smtp.gmail.com with ESMTPSA id
 eg13-20020a056402288d00b0042dce73168csm2938301edb.13.2022.06.02.12.24.20
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 02 Jun 2022 12:24:21 -0700 (PDT)
From: Oleksandr Tyshchenko <olekstysh@gmail.com>
To: xen-devel@lists.xenproject.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux-foundation.org
Subject: [PATCH V4 5/8] dt-bindings: Add xen,
 grant-dma IOMMU description for xen-grant DMA ops
Date: Thu,  2 Jun 2022 22:23:50 +0300
Message-Id: <1654197833-25362-6-git-send-email-olekstysh@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1654197833-25362-1-git-send-email-olekstysh@gmail.com>
References: <1654197833-25362-1-git-send-email-olekstysh@gmail.com>
Cc: Juergen Gross <jgross@suse.com>,
 Stefano Stabellini <sstabellini@kernel.org>, Julien Grall <julien@xen.org>,
 Arnd Bergmann <arnd@arndb.de>, "Michael S. Tsirkin" <mst@redhat.com>,
 Christoph Hellwig <hch@infradead.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Will Deacon <will@kernel.org>
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

From: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>

The main purpose of this binding is to communicate Xen specific
information using generic IOMMU device tree bindings (which is
a good fit here) rather than introducing a custom property.

Introduce Xen specific IOMMU for the virtualized device (e.g. virtio)
to be used by Xen grant DMA-mapping layer in the subsequent commit.

The reference to Xen specific IOMMU node using "iommus" property
indicates that Xen grant mappings need to be enabled for the device,
and it specifies the ID of the domain where the corresponding backend
resides. The domid (domain ID) is used as an argument to the Xen grant
mapping APIs.

This is needed for the option to restrict memory access using Xen grant
mappings to work which primary goal is to enable using virtio devices
in Xen guests.

Signed-off-by: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
---
Changes RFC -> V1:
   - update commit subject/description and text in description
   - move to devicetree/bindings/arm/

Changes V1 -> V2:
   - update text in description
   - change the maintainer of the binding
   - fix validation issue
   - reference xen,dev-domid.yaml schema from virtio/mmio.yaml

Change V2 -> V3:
   - Stefano already gave his Reviewed-by, I dropped it due to the changes (significant)
   - use generic IOMMU device tree bindings instead of custom property
     "xen,dev-domid"
   - change commit subject and description, was
     "dt-bindings: Add xen,dev-domid property description for xen-grant DMA ops"

Changes V3 -> V4:
   - add Stefano's R-b
   - remove underscore in iommu node name
   - remove consumer example virtio@3000
   - update text for two descriptions
---
 .../devicetree/bindings/iommu/xen,grant-dma.yaml   | 39 ++++++++++++++++++++++
 1 file changed, 39 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iommu/xen,grant-dma.yaml

diff --git a/Documentation/devicetree/bindings/iommu/xen,grant-dma.yaml b/Documentation/devicetree/bindings/iommu/xen,grant-dma.yaml
new file mode 100644
index 00000000..be1539d
--- /dev/null
+++ b/Documentation/devicetree/bindings/iommu/xen,grant-dma.yaml
@@ -0,0 +1,39 @@
+# SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iommu/xen,grant-dma.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Xen specific IOMMU for virtualized devices (e.g. virtio)
+
+maintainers:
+  - Stefano Stabellini <sstabellini@kernel.org>
+
+description:
+  The Xen IOMMU represents the Xen grant table interface. Grant mappings
+  are to be used with devices connected to the Xen IOMMU using the "iommus"
+  property, which also specifies the ID of the backend domain.
+  The binding is required to restrict memory access using Xen grant mappings.
+
+properties:
+  compatible:
+    const: xen,grant-dma
+
+  '#iommu-cells':
+    const: 1
+    description:
+      The single cell is the domid (domain ID) of the domain where the backend
+      is running.
+
+required:
+  - compatible
+  - "#iommu-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    iommu {
+        compatible = "xen,grant-dma";
+        #iommu-cells = <1>;
+    };
-- 
2.7.4

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
