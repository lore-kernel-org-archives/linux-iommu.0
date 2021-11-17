Return-Path: <SRS0=sOBO=QE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A66EEC433F5
	for <iommu@archiver.kernel.org>; Wed, 17 Nov 2021 21:15:34 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B92661B62
	for <iommu@archiver.kernel.org>; Wed, 17 Nov 2021 21:15:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4B92661B62
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 27C4C60A87;
	Wed, 17 Nov 2021 21:15:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cVRpDXUDoSu6; Wed, 17 Nov 2021 21:15:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 2053960A85;
	Wed, 17 Nov 2021 21:15:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F2B0FC002E;
	Wed, 17 Nov 2021 21:15:32 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F16F6C0012
 for <iommu@lists.linux-foundation.org>; Wed, 17 Nov 2021 21:15:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E1074823E0
 for <iommu@lists.linux-foundation.org>; Wed, 17 Nov 2021 21:15:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=svenpeter.dev header.b="loVGdIYH";
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.b="c62a+hD0"
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6MUzmFVJ1OV2 for <iommu@lists.linux-foundation.org>;
 Wed, 17 Nov 2021 21:15:31 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from new2-smtp.messagingengine.com (new2-smtp.messagingengine.com
 [66.111.4.224])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5DFFC823A0
 for <iommu@lists.linux-foundation.org>; Wed, 17 Nov 2021 21:15:31 +0000 (UTC)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
 by mailnew.nyi.internal (Postfix) with ESMTP id B07525806CF;
 Wed, 17 Nov 2021 16:15:27 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
 by compute5.internal (MEProxy); Wed, 17 Nov 2021 16:15:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm3; bh=6Npdq0g1uutbB
 Z9rJk6TgIsiQnFffMQoa5oYcoXUq4Y=; b=loVGdIYH0RXWcIuL8+DFCdvcL9Ytu
 kWFWTopXKNdJwlCN/9vvounhYbXmDHlKshsvxcS3pQ10iR5efqy/iuyURjo3HbSu
 4/4SQA0LczuBpstNXuC3CHtrJ70seY9rwlWOChyyrei2QZNjr7kzALasLowXDBZP
 iPUw58yiB/34vgvOF3POlYHyEnYxkxwte5vq4RQ90sMCMbxv+llWwIUwKxq+lBok
 M5oDHiVgXmn58Td1y4f7CjdJEO+B/TAlsXpunyBOVspfxrOnaxvMyYO2wBsnwdlF
 vmFH/aWqx2YQC4bPfe1ZNV+JlvOiG/zSxtDygbI9sEhS+Zg9LyienDRmg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm1; bh=6Npdq0g1uutbBZ9rJk6TgIsiQnFffMQoa5oYcoXUq4Y=; b=c62a+hD0
 5cXn2bSqK3hK3xmvXKk4kGZ7PJOjNjACG0KRQhN5zRSElF82P63Jsfe8gt0BUb58
 S4RAmgchW6JQAIfB8zWZsbLC8sVDWT1BlHgpjdgeZXXQPXKkgPMKax5tTN5Heelp
 8NP6vsGPsFPQ8QoQxrUUqeXctcpOujmam362wdDnBXUXaJpKUMpzVcc3zFyXUKxU
 91FfQZZSaebV2KMbEvYHamZ/SlE4fO3pkLp6b3s3eowEgequODNdbCp83lpuMOid
 xy8WysYbfjC4lJP+o3a3kaxdKEeCHrPLCNFg5tqsAP7+vYPh/FckxuDq0RjRqtHa
 OsrwtKlR+I+vRg==
X-ME-Sender: <xms:73CVYa9hRUdz8YCAp5B69Ok-hOEi6s0cTiQtTGgYBfFsz8XrMOIAog>
 <xme:73CVYavtl8UcmR_4lL8OR0YvO_PMuJuct-NsxTHoFFf1gYu0g6Q_VP1UX5ZzkInLa
 qQVZju6ozYtIUI31S0>
X-ME-Received: <xmr:73CVYQAsPPxsYMSfvVW3PGZySsYLSA7rt5_0j9lAMJ07CVCOaNyoQE7f7hZWN3zrCPG3fuQYNDhLEWwRDXXDRdPl7HJeJh7-MbC2puONYrXQV2zehcdZsZ0xfhkhKA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrfeeggddugedtucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefuvhgvnhcu
 rfgvthgvrhcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrfgrthhtvg
 hrnheptedvkeetleeuffffhfekteetffeggffgveehieelueefvddtueffveevlefhfeej
 necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshhvvg
 hnsehsvhgvnhhpvghtvghrrdguvghv
X-ME-Proxy: <xmx:73CVYScoCkox3JemQOqxYIHk01ZYFyTCFejmk2KqUkUgGpPnxsEXBg>
 <xmx:73CVYfPmnbhcDr_g690PZvwP6GKr0uotMBqNus21vQKpdROd3Xa4gA>
 <xmx:73CVYclDpJvFQ5K871bPZWXFOChOR1CFcrFqgMSEneyNiFUFE6R-4g>
 <xmx:73CVYQEcaHLnYp3fyz8bRYGITHIRv_Fqp_lOYdF3lkAel3-ET95Z7Q>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Nov 2021 16:15:25 -0500 (EST)
To: iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
 devicetree@vger.kernel.org
Subject: [PATCH 1/4] dt-bindings: iommu: dart: add t6000 compatible
Date: Wed, 17 Nov 2021 22:15:06 +0100
Message-Id: <20211117211509.28066-2-sven@svenpeter.dev>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20211117211509.28066-1-sven@svenpeter.dev>
References: <20211117211509.28066-1-sven@svenpeter.dev>
MIME-Version: 1.0
Cc: Sven Peter <sven@svenpeter.dev>, Will Deacon <will@kernel.org>,
 Hector Martin <marcan@marcan.st>, Robin Murphy <robin.murphy@arm.com>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Janne Grunau <j@jannau.net>, Alyssa Rosenzweig <alyssa@rosenzweig.io>
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

The M1 Max/Pro SoCs come with a new DART variant that is incompatible with
the previous one. Add a new compatible for those.

Signed-off-by: Sven Peter <sven@svenpeter.dev>
---
 Documentation/devicetree/bindings/iommu/apple,dart.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iommu/apple,dart.yaml b/Documentation/devicetree/bindings/iommu/apple,dart.yaml
index 94aa9e9afa59..ca2cbde9f3c9 100644
--- a/Documentation/devicetree/bindings/iommu/apple,dart.yaml
+++ b/Documentation/devicetree/bindings/iommu/apple,dart.yaml
@@ -22,7 +22,9 @@ description: |+
 
 properties:
   compatible:
-    const: apple,t8103-dart
+    enum:
+      - apple,t8103-dart
+      - apple,t6000-dart
 
   reg:
     maxItems: 1
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
