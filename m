Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0791C433EF
	for <iommu@archiver.kernel.org>; Tue, 12 Apr 2022 16:20:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6809460FDF;
	Tue, 12 Apr 2022 16:20:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8RjKEk6mdPji; Tue, 12 Apr 2022 16:20:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 30C4A61066;
	Tue, 12 Apr 2022 16:20:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 05E89C0033;
	Tue, 12 Apr 2022 16:20:53 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6CEDAC002C
 for <iommu@lists.linux-foundation.org>; Tue, 12 Apr 2022 16:20:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 56EE060FDF
 for <iommu@lists.linux-foundation.org>; Tue, 12 Apr 2022 16:20:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ibBtirVqWG61 for <iommu@lists.linux-foundation.org>;
 Tue, 12 Apr 2022 16:20:51 +0000 (UTC)
X-Greylist: delayed 00:08:24 by SQLgrey-1.8.0
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com
 [64.147.123.19])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9665961066
 for <iommu@lists.linux-foundation.org>; Tue, 12 Apr 2022 16:20:51 +0000 (UTC)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
 by mailout.west.internal (Postfix) with ESMTP id CB0DC3201F88;
 Tue, 12 Apr 2022 12:12:23 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute2.internal (MEProxy); Tue, 12 Apr 2022 12:12:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
 h=cc:cc:content-transfer-encoding:date:date:from:from
 :in-reply-to:message-id:mime-version:reply-to:sender:subject
 :subject:to:to; s=fm1; t=1649779943; x=1649866343; bh=Swq3vULHL4
 0tNAUp4uZ9yWQwrv+6ZS9Mb46odzoBxs8=; b=qgq3EzQjxZkLFJXAe23DqDX97j
 cApfWLkJ86GFRu78qiRsRbjgxOelPJhgKhGAIy5P6mxSOHAn1/O2kMlL2VX9LiVt
 rObPSE/lJTIZYA2Un61Y+unRKlVNVDLz31yrlYgEor1XIBRfldYVPSlAPdU7xC+D
 fV+w6sRB7xQYOqmPvp+JZMBMVKrWvEme0tpcZaH1904sNI+VT5ldjo/L4m81etuU
 fg7BTK8thDBaY3zXMRp2FprVgNij7Gq2qYZY6xPnH+pJCwQmCKcQuz2xU/xeCO7b
 1GvYpsczwQY6TH4IQ8R5QIijk2Mh1FivF/K98bUa5oxsqP7LKkHDYGNoUNPg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
 :from:from:in-reply-to:message-id:mime-version:reply-to:sender
 :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1649779943; x=1649866343; bh=S
 wq3vULHL40tNAUp4uZ9yWQwrv+6ZS9Mb46odzoBxs8=; b=dxcKP8ujyaC/lmnE3
 lu+0Ry0SNoQZVh/3J6BG+wNWs7GfHZ9DI5Z5DaBv/rpGtUsuqX91G6i+VAyIa0wd
 OQA+qogNGOEijg/H6A0sPBrytY3KYCeLt+2anujiOtDKSImuZet+HuEP+lpK4Ikt
 ZLNAZ0koeAw+el63OmlYmxWlkoNt5oXXwGfuRJfzN1aSXXR/CKOd/8WnLbg8KicM
 KWwsn67eEW4plgv2zTSLBGDb7iRZinCUKg4xrGq1M8sAdOJS7AXbBKhpPissdXMZ
 r7eN5gZwF7GhvmLBK4BXJn+gTcTtNY+JzQ4ymIEt1w2ijufm+Xvc9sxbuakzvlS0
 oIFlA==
X-ME-Sender: <xms:5qRVYoardRClJUGUy5AsiTQb2NVf1IZp6yX0o8tvyC3mZAc6-IMYEg>
 <xme:5qRVYjaIslUcQC4gpg46CgxFW7ihnkm9EljGvP0rvrKMsIHalsSzlIuP1yiUcH-T4
 cf0-Bo9mX2siwFbcwA>
X-ME-Received: <xmr:5qRVYi_bjEDCpUxc_-JQH8C3OwS_n65P1TNPSEHWvAdUPCkZyOyGMvnpU-umUZdc2Q00bqwdQsRVjvu-yaYwLex9C_2KP1JD7zTtuBGIgWqJPBHVtY3dwWwUW0hIfC4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudekkedgleeiucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefuvhgvnhcurfgv
 thgvrhcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrfgrthhtvghrnh
 epuefgleekvddtjefffeejheevleefveekgfduudfhgefhfeegtdehveejfefffffgnecu
 vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshhvvghnse
 hsvhgvnhhpvghtvghrrdguvghv
X-ME-Proxy: <xmx:56RVYir5HB9bkQuyYpfFIhNe6VhEpaTwXzU_MeNinHNQc1oG1oIajQ>
 <xmx:56RVYjqXLaLsLCCGFnZ67s6GZ97_cnHnvLuwD76nMScAkJzd71ZClA>
 <xmx:56RVYgQcpjlwMG9qbQODZkz8JtNyLptYRR_frIWWEj9IKtW77P1POw>
 <xmx:56RVYkf-XL0KmkSd8_0GuvHyaqnat9VFq_dNoarc0Wj73pf4JXUiMw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Apr 2022 12:12:21 -0400 (EDT)
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH] MAINTAINERS: merge DART into ARM/APPLE MACHINE
Date: Tue, 12 Apr 2022 18:12:11 +0200
Message-Id: <20220412161211.23162-1-sven@svenpeter.dev>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
MIME-Version: 1.0
Cc: Sven Peter <sven@svenpeter.dev>, Hector Martin <marcan@marcan.st>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Will Deacon <will@kernel.org>,
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
From: Sven Peter via iommu <iommu@lists.linux-foundation.org>
Reply-To: Sven Peter <sven@svenpeter.dev>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

It's the same people anyway.

Signed-off-by: Sven Peter <sven@svenpeter.dev>
---
 MAINTAINERS | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index fd768d43e048..5af879de869c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1375,14 +1375,6 @@ L:	linux-input@vger.kernel.org
 S:	Odd fixes
 F:	drivers/input/mouse/bcm5974.c
 
-APPLE DART IOMMU DRIVER
-M:	Sven Peter <sven@svenpeter.dev>
-R:	Alyssa Rosenzweig <alyssa@rosenzweig.io>
-L:	iommu@lists.linux-foundation.org
-S:	Maintained
-F:	Documentation/devicetree/bindings/iommu/apple,dart.yaml
-F:	drivers/iommu/apple-dart.c
-
 APPLE PCIE CONTROLLER DRIVER
 M:	Alyssa Rosenzweig <alyssa@rosenzweig.io>
 M:	Marc Zyngier <maz@kernel.org>
@@ -1836,6 +1828,7 @@ F:	Documentation/devicetree/bindings/arm/apple/*
 F:	Documentation/devicetree/bindings/clock/apple,nco.yaml
 F:	Documentation/devicetree/bindings/i2c/apple,i2c.yaml
 F:	Documentation/devicetree/bindings/interrupt-controller/apple,*
+F:	Documentation/devicetree/bindings/iommu/apple,dart.yaml
 F:	Documentation/devicetree/bindings/mailbox/apple,mailbox.yaml
 F:	Documentation/devicetree/bindings/pci/apple,pcie.yaml
 F:	Documentation/devicetree/bindings/pinctrl/apple,pinctrl.yaml
@@ -1845,6 +1838,7 @@ F:	arch/arm64/boot/dts/apple/
 F:	drivers/clk/clk-apple-nco.c
 F:	drivers/i2c/busses/i2c-pasemi-core.c
 F:	drivers/i2c/busses/i2c-pasemi-platform.c
+F:	drivers/iommu/apple-dart.c
 F:	drivers/irqchip/irq-apple-aic.c
 F:	drivers/mailbox/apple-mailbox.c
 F:	drivers/pinctrl/pinctrl-apple-gpio.c
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
