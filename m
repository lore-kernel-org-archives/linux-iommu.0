Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A1EFC433F5
	for <iommu@archiver.kernel.org>; Tue, 23 Nov 2021 11:21:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C0F206065D;
	Tue, 23 Nov 2021 11:21:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id asxVOJq9VzOG; Tue, 23 Nov 2021 11:21:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id B8D3A606EE;
	Tue, 23 Nov 2021 11:21:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A5AF4C002E;
	Tue, 23 Nov 2021 11:21:18 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DD98DC0012
 for <iommu@lists.linux-foundation.org>; Tue, 23 Nov 2021 11:21:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C4AFF4025C
 for <iommu@lists.linux-foundation.org>; Tue, 23 Nov 2021 11:21:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=chromium.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NWf9IqTGJmTa for <iommu@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 11:21:16 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com
 [IPv6:2607:f8b0:4864:20::52f])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 190C4401E2
 for <iommu@lists.linux-foundation.org>; Tue, 23 Nov 2021 11:21:16 +0000 (UTC)
Received: by mail-pg1-x52f.google.com with SMTP id t4so10721715pgn.9
 for <iommu@lists.linux-foundation.org>; Tue, 23 Nov 2021 03:21:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=z+/tM6AGO8qVa/0Ves95KRNhzSUdOxRaqnGgKB5D++M=;
 b=XpXqNAebRwgXhworSNtt028SsP5KTorBtVnPQ2NDJ5AqE0w8IT8BOg6T3ewnDOxn0x
 QaNyBlTudA5wA6HUsP3tTtdlTWjvrE8GuQPbTwT1fW+w1gEOlQN/lkvuxJNQ4SJKqEYn
 we3ePUFjfo44/HkRFeRMoGLKvp+vx0wcGlvTA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=z+/tM6AGO8qVa/0Ves95KRNhzSUdOxRaqnGgKB5D++M=;
 b=6QGiY1z6hW8PLJQ2E5hMJCMfgBvT+OkiFCAJu6twoE3LzIy1cKGFz55S9w+Ked1Kpb
 /UeLPZU4Z/eEA7lobEWCLv/czkCEEhNCeSXnd+hH3ear3IyuiCrfbStcRHVoC3XOCJcd
 voRcCtkAUkqO504ZGOwikPpvD8Z4geZEFrcwxTZhkDyWZRunYLVpV1uCBEZmT0R3QCBS
 +WIvMho5EsqSxEPxLM6NDqyZJ7VfgKz8BhoHbVH3q+w+YWYutdD2G9CrIToZi7H12Ezv
 3vQ3Vdvm/ER1GaHXErg9yRu8kNmHOzK0wcgN2rjL/DUivlttUVqMCRK7T8shGFD8hdzz
 Zp1g==
X-Gm-Message-State: AOAM530eCzq99pY+pOpFsFtYyTbFqQcbyQlWg9IEhGaPwmhFtbdz6K2T
 sNxxVaM+bVqVgBVXM/v/gxdBkA==
X-Google-Smtp-Source: ABdhPJxETkQVjZ/TElThsyh1V0RdLsnWog1QFLXL9SdSSg23n2Tff5mZqtPLZT8Oh2DPEEUzXXmy1w==
X-Received: by 2002:a63:f64:: with SMTP id 36mr3117696pgp.464.1637666475417;
 Tue, 23 Nov 2021 03:21:15 -0800 (PST)
Received: from hsinyi-z840.tpe.corp.google.com
 ([2401:fa00:1:10:d1ae:c331:ed2a:15e9])
 by smtp.gmail.com with ESMTPSA id 63sm11093914pfz.119.2021.11.23.03.21.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Nov 2021 03:21:15 -0800 (PST)
From: Hsin-Yi Wang <hsinyi@chromium.org>
To: Christoph Hellwig <hch@infradead.org>
Subject: [PATCH 2/3] dt-bindings: Add io-tlb-segsize property for
 restricted-dma-pool
Date: Tue, 23 Nov 2021 19:21:03 +0800
Message-Id: <20211123112104.3530135-3-hsinyi@chromium.org>
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
In-Reply-To: <20211123112104.3530135-1-hsinyi@chromium.org>
References: <20211123112104.3530135-1-hsinyi@chromium.org>
MIME-Version: 1.0
Cc: devicetree@vger.kernel.org, - <devicetree-spec@vger.kernel.org>,
 linux-kernel@vger.kernel.org, senozhatsky@chromium.org,
 iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
 linux-mediatek@lists.infradead.org, Maxime Ripard <maxime@cerno.tech>,
 Matthias Brugger <matthias.bgg@gmail.com>, Robin Murphy <robin.murphy@arm.com>,
 linux-arm-kernel@lists.infradead.org
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

Add a io-tlb-segsize property that each restricted-dma-pool can set its
own io_tlb_segsize since some use cases require slabs larger than default
value (128).

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
 .../bindings/reserved-memory/shared-dma-pool.yaml         | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/reserved-memory/shared-dma-pool.yaml b/Documentation/devicetree/bindings/reserved-memory/shared-dma-pool.yaml
index a4bf757d6881de..6198bf6b76f0b2 100644
--- a/Documentation/devicetree/bindings/reserved-memory/shared-dma-pool.yaml
+++ b/Documentation/devicetree/bindings/reserved-memory/shared-dma-pool.yaml
@@ -56,6 +56,14 @@ properties:
       If this property is present, then Linux will use the region for
       the default pool of the consistent DMA allocator.
 
+  io-tlb-segsize:
+    type: u32
+    description: >
+      Each restricted-dma-pool can use this property to set its own
+      io_tlb_segsize. If not set, it will use the default value
+      IO_TLB_SEGSIZE defined in include/linux/swiotlb.h. The value has
+      to be a power of 2, otherwise it will fall back to IO_TLB_SEGSIZE.
+
 unevaluatedProperties: false
 
 examples:
-- 
2.34.0.rc2.393.gf8c9666880-goog

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
