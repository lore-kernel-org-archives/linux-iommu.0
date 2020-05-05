Return-Path: <SRS0=kPPe=6T=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E95D3C47254
	for <iommu@archiver.kernel.org>; Tue,  5 May 2020 10:10:19 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC5CD206E6
	for <iommu@archiver.kernel.org>; Tue,  5 May 2020 10:10:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="sWtGjDr0";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RDd86n/8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC5CD206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cerno.tech
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 5F9FC204DA;
	Tue,  5 May 2020 10:10:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zQEiuaBVL7RS; Tue,  5 May 2020 10:10:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 5D705204BC;
	Tue,  5 May 2020 10:10:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3DC07C0890;
	Tue,  5 May 2020 10:10:17 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A885EC088B
 for <iommu@lists.linux-foundation.org>; Tue,  5 May 2020 10:10:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id E848687859
 for <iommu@lists.linux-foundation.org>; Tue,  5 May 2020 10:10:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fHvpC0ltuETo for <iommu@lists.linux-foundation.org>;
 Tue,  5 May 2020 10:09:43 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com
 [66.111.4.27])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id B2E21876AD
 for <iommu@lists.linux-foundation.org>; Tue,  5 May 2020 10:09:42 +0000 (UTC)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.nyi.internal (Postfix) with ESMTP id 238115C00CB;
 Tue,  5 May 2020 06:09:42 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute4.internal (MEProxy); Tue, 05 May 2020 06:09:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm2; bh=kxz6dVnKinrsF
 EyoSwmLmcaIKY2++Ip3fyKHn+I7HeI=; b=sWtGjDr00xMO3OAuhCR5Uf1uNS1mF
 XPcIoWSnz7UPFr6PjLuNQ5k2Q9Y/vRVTv6eX8p1ygcJHFcDbg44fhllqNp/z5Bjb
 Wgsszwhuvn4VuLvyNJkU/aRwVcSsrTaGCUB61mzQGMsVWnPWFZrtCluukXPk8r/t
 Z55wOneR/4iir9tmks/2gXZGV99SO8PhaCJIILshBL+jdDNpn46FkkHAOMnfk2+M
 8fOJGyD4Vw/A9aTFhIIQdyCdj0kvxMGT9C5uok9Kp1HMcuSzO86YTriCvywfZ6bS
 hCq0CjuZXLJ7EfSoAQkCc7camX10PoylIN4Yc62y7sjYu+QTpszmztBVQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm2; bh=kxz6dVnKinrsFEyoSwmLmcaIKY2++Ip3fyKHn+I7HeI=; b=RDd86n/8
 3kW/DV7CJTIvyUuPBfjEdW9pKE+GbJxN5/6/wZ2iyWoiHFVQfbNKkjr+3Q7CkY/c
 43Bwxw1k+GOWD1XmUK4wBpwtU7B1Kj62Thgqpx7733zJfiB+ddueptgno5FqyPQA
 u+CU8osIS+6KNRt4zKKMXFk+wy9XQVzdGPOr4i012eIJ9YprgkBQLv24MEJehkSp
 oRP54ki+GTjSLpED8q7Vrb7FusuUdTayts3eZPhzSkIfgBkY938zX1MITLwoUQz5
 PGy8VnVU2ej9sEbmqpXKdXSh8ivRlSxy7UxZaCRY61ADT9+0lf4S2at2TcnuW5BG
 UO0ZPG3jRqt+PA==
X-ME-Sender: <xms:ZjuxXvPQUZdGJG919kPZZ1pqbBkLp5LzBO5Bn_oZlBQYFu2qqFxgqg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrjeeigddvgecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepofgrgihimhgv
 ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
 gvrhhnpedvkeelveefffekjefhffeuleetleefudeifeehuddugffghffhffehveevheeh
 vdenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtnecurf
 grrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:ZjuxXkFnmWBEdc6k0orXS39qmuHXaH9qXVwcqMBQUHpzBptMkWY-mw>
 <xmx:ZjuxXv_l2lXsX7GF7PaYxC1BO-cAgvvGW1CkVkipPQTcPcQseWePbA>
 <xmx:ZjuxXibZJuSskFNhzb8jzgDlZV6eH3r1kcu8k_XtmfYGeCIReW4Zkg>
 <xmx:ZjuxXsT5TOfCa0Gcup5G2IoABNUx6Wkm7RLeXZZnzl7U0980Jraj1g>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr
 [90.89.68.76])
 by mail.messagingengine.com (Postfix) with ESMTPA id B149F328005D;
 Tue,  5 May 2020 06:09:41 -0400 (EDT)
From: Maxime Ripard <maxime@cerno.tech>
To: Joerg Roedel <joro@8bytes.org>, Chen-Yu Tsai <wens@csie.org>,
 Maxime Ripard <mripard@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>
Subject: [PATCH v3 2/5] dt-bindings: display: sun8i-mixer: Allow for an iommu
 property
Date: Tue,  5 May 2020 12:09:31 +0200
Message-Id: <ef88e9d96eafe3f921cfbe087c5f0a25a5dd41ac.1588673353.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.70f96f9afd2e04161ebece593ae6cd7e17eca41b.1588673353.git-series.maxime@cerno.tech>
References: <cover.70f96f9afd2e04161ebece593ae6cd7e17eca41b.1588673353.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Cc: devicetree@vger.kernel.org, iommu@lists.linux-foundation.org,
 Maxime Ripard <maxime@cerno.tech>, linux-arm-kernel@lists.infradead.org
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

The H6 mixer is attached to an IOMMU, so let's allow that property to be
set in the bindings.

Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 Documentation/devicetree/bindings/display/allwinner,sun8i-a83t-de2-mixer.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/allwinner,sun8i-a83t-de2-mixer.yaml b/Documentation/devicetree/bindings/display/allwinner,sun8i-a83t-de2-mixer.yaml
index 1dee641e3ea1..c040eef56518 100644
--- a/Documentation/devicetree/bindings/display/allwinner,sun8i-a83t-de2-mixer.yaml
+++ b/Documentation/devicetree/bindings/display/allwinner,sun8i-a83t-de2-mixer.yaml
@@ -36,6 +36,9 @@ properties:
       - const: bus
       - const: mod
 
+  iommus:
+    maxItems: 1
+
   resets:
     maxItems: 1
 
-- 
git-series 0.9.1
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
