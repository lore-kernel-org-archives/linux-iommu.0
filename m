Return-Path: <SRS0=pxo5=UG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BD58C2BCA1
	for <iommu@archiver.kernel.org>; Fri,  7 Jun 2019 22:37:47 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D57EF20840
	for <iommu@archiver.kernel.org>; Fri,  7 Jun 2019 22:37:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ftUO1GiC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D57EF20840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 8D5F11ADC;
	Fri,  7 Jun 2019 22:37:46 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 212AB1A2D
	for <iommu@lists.linux-foundation.org>;
	Fri,  7 Jun 2019 22:37:05 +0000 (UTC)
X-Greylist: delayed 03:01:26 by SQLgrey-1.7.6
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 94BAA854
	for <iommu@lists.linux-foundation.org>;
	Fri,  7 Jun 2019 22:37:04 +0000 (UTC)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x57JZSrR112098;
	Fri, 7 Jun 2019 14:35:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1559936128;
	bh=g/jVvEBoDnB0yS/VyPCCLSyiDgGI0r1pNYFm7Vgh5W4=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=ftUO1GiCyMTWmcL2PBwG2RJapxbBdl7GV8N01lcMV1Q/+PAZhZLqqX8pocF3jvANE
	sLspZHpNTm3zo3S14BbDc7Yjsd2RLarzjjXcfnWwaQdO4wdzMqGMR8GoxYIZIhw21s
	mZTmIen92OIBxpNPM1bFK2qXlLmvs1yTD29cwoBk=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x57JZRRk090496
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 7 Jun 2019 14:35:27 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE107.ent.ti.com
	(157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5;
	Fri, 7 Jun 2019 14:35:27 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE102.ent.ti.com
	(157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
	Frontend Transport; Fri, 7 Jun 2019 14:35:27 -0500
Received: from legion.dal.design.ti.com (legion.dal.design.ti.com
	[128.247.22.53])
	by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x57JZR71130539;
	Fri, 7 Jun 2019 14:35:27 -0500
Received: from localhost ([10.250.68.219])
	by legion.dal.design.ti.com (8.11.7p1+Sun/8.11.7) with ESMTP id
	x57JZPm20290; Fri, 7 Jun 2019 14:35:26 -0500 (CDT)
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Santosh Shilimkar <ssantosh@kernel.org>,
	Will Deacon <will.deacon@arm.com>, Robin Murphy <robin.murphy@arm.com>, 
	Joerg Roedel <joro@8bytes.org>, David Airlie <airlied@linux.ie>,
	Daniel Vetter <daniel@ffwll.ch>, Tero Kristo <t-kristo@ti.com>,
	William Mills <wmills@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>,
	Sumit Semwal <sumit.semwal@linaro.org>, John Stultz
	<john.stultz@linaro.org>
Subject: [RFC PATCH 1/2] dt-bindings: soc: ti: Add TI PAT bindings
Date: Fri, 7 Jun 2019 15:35:22 -0400
Message-ID: <20190607193523.25700-2-afd@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190607193523.25700-1-afd@ti.com>
References: <20190607193523.25700-1-afd@ti.com>
MIME-Version: 1.0
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org, "Andrew F . Davis" <afd@ti.com>,
	linaro-mm-sig@lists.linaro.org, iommu@lists.linux-foundation.org,
	linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
From: "Andrew F. Davis via iommu" <iommu@lists.linux-foundation.org>
Reply-To: "Andrew F. Davis" <afd@ti.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

This patch adds the bindings for the Page-based Address Translator (PAT)
present on various TI SoCs. A Page-based Address Translator (PAT) device
performs address translation using tables stored in an internal SRAM.
Each PAT supports a set number of pages, each occupying a programmable
4KB, 16KB, 64KB, or 1MB of addresses in a window for which an incoming
transaction will be translated.

Signed-off-by: Andrew F. Davis <afd@ti.com>
---
 .../devicetree/bindings/misc/ti,pat.txt       | 34 +++++++++++++++++++
 1 file changed, 34 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/ti,pat.txt

diff --git a/Documentation/devicetree/bindings/misc/ti,pat.txt b/Documentation/devicetree/bindings/misc/ti,pat.txt
new file mode 100644
index 000000000000..fac20d45ad4c
--- /dev/null
+++ b/Documentation/devicetree/bindings/misc/ti,pat.txt
@@ -0,0 +1,34 @@
+Texas Instruments Page-based Address Translator (PAT) driver binding
+--------------------------------------------------------------------
+
+A Page-based Address Translator (PAT) device performs address translation
+using tables stored in an internal SRAM. Each PAT supports a set number of
+pages, each occupying a programmable 4KB, 16KB, 64KB, or 1MB of addresses
+in a window for which an incoming transaction will be translated.
+
+TI-PAT controller Device Node
+=============================
+
+The TI-PAT node describes the Texas Instrument's Page-based Address
+Translator (PAT).
+
+Required properties:
+-------------------
+- compatible: should be "ti,j721e-pat"
+- reg-names:
+	mmrs - Memory mapped registers region
+	table - Location of the table of translation pages
+	window - Window of memory addresses translated by this PAT
+- reg: register addresses corresponding to the above
+
+Example:
+
+navss_pat0: pat@31010000 {
+	compatible = "ti,j721e-pat";
+	reg = <0x00 0x31010000 0x00 0x00000100>,
+	      <0x00 0x36400000 0x00 0x00040000>,
+	      <0x48 0x00000000 0x00 0x40000000>;
+	reg-names = "mmrs",
+	            "table",
+	            "window";
+};
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
