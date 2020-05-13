Return-Path: <SRS0=oi3Z=63=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C648CA90AF
	for <iommu@archiver.kernel.org>; Wed, 13 May 2020 14:07:37 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B384A20659
	for <iommu@archiver.kernel.org>; Wed, 13 May 2020 14:07:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="JimAHOWA";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RmkUne46"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B384A20659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cerno.tech
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id E0DA088222;
	Wed, 13 May 2020 14:07:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id D2e44wsVUdIl; Wed, 13 May 2020 14:07:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 3FDCE88216;
	Wed, 13 May 2020 14:07:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2D7CAC0178;
	Wed, 13 May 2020 14:07:36 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 67794C016F
 for <iommu@lists.linux-foundation.org>; Wed, 13 May 2020 14:07:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 571F98825F
 for <iommu@lists.linux-foundation.org>; Wed, 13 May 2020 14:07:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BEu5x91fSN8y for <iommu@lists.linux-foundation.org>;
 Wed, 13 May 2020 14:07:33 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from new3-smtp.messagingengine.com (new3-smtp.messagingengine.com
 [66.111.4.229])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 4DABE876E3
 for <iommu@lists.linux-foundation.org>; Wed, 13 May 2020 14:07:33 +0000 (UTC)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailnew.nyi.internal (Postfix) with ESMTP id BA4485802AE;
 Wed, 13 May 2020 10:07:32 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute4.internal (MEProxy); Wed, 13 May 2020 10:07:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm2; bh=b/ssnOsTjUq2R
 zP/XjI8iXE51bGs8OKIIZRLrDvrIL4=; b=JimAHOWAf8Zvovx+Me9X3M6GHlEk8
 o2doqTBycrlQj6hRRLkVD1H2VEzCGRpIeW8m9GaJmZ2rgFMUrkwPvEl7miIK6QKr
 M4T/hZ/Alov7ipTRt0hsNoW6TAVFBBaABsWkaw2rxiyl9Cpy+vIG813y7WK8bDJn
 fVWTGB6NFbFQM5S1IpH1GvlgP7BpRt8efuID+3t0fLcnVG0vBFe8Dlr4IzWLI634
 5rHEJAPRgFjAckb7r9o0Qnskl4o0gaJopb10ndSCgP+uRoFLNeUMA7O7j9n2Bo/o
 gb/YLHe4rfloCkC7PiQkOSJLsFEoZer+4eTTsmtkyAT09djew7WOshMxA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm2; bh=b/ssnOsTjUq2RzP/XjI8iXE51bGs8OKIIZRLrDvrIL4=; b=RmkUne46
 PZZBfpur1zHaRZzp2Kl/I8F7p6FLCr/ENc/Dob0Td7HkIvi4G1Vr6luEde1K6V1I
 kqjeDwq++Xo9eGY1bmPqa9f7yrJ/VAbT+mxEEmPgLIR7qRDRCO/+0Bl2jGQfzalD
 EYsUgQzxyB5mFnsYV6OJlA8EdD1Y9A7Vad95aVvaHZuwEbd78lt/mNN5s/7DkfTI
 bByWlH+os5Dcoi+JodWp0e/r5pWtfMh/XhtNStu53fcRCtSLm/NfUEIQTRamsuoZ
 PZ4LXqpC8NCdlfHAOA8NEtDowAwxSK2gHDK8TlJ5deVurp00aQmajnybs4xMKV6S
 T83yeFjELqcJng==
X-ME-Sender: <xms:JP-7XuuQn-PDaGEJFoRwNen8quhkea4xU68KVJxJahq4HuqL3DMT3Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrleeggdejvdcutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepofgrgihimhgv
 ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
 gvrhhnpedvkeelveefffekjefhffeuleetleefudeifeehuddugffghffhffehveevheeh
 vdenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtnecurf
 grrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:JP-7XjfyvfF__tsugRhtoVMIE6ncCHOgJHiOJZiWquFwJXnrNXGtAQ>
 <xmx:JP-7XpzjkYls_53y6mCA0vZhnFOYIM8q3_VtJAkQ7p0enZhW4mxH3w>
 <xmx:JP-7XpN9TwZL6ldZnp8vm4lyh9JfEyAU-4VxqmMdmNQpARbsq1WzDA>
 <xmx:JP-7XjN4dDAdypIxEhoHMAK8kf9exfHuSUFirRtKY1YfvBqP123cZg>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr
 [90.89.68.76])
 by mail.messagingengine.com (Postfix) with ESMTPA id 1A2533280060;
 Wed, 13 May 2020 10:07:31 -0400 (EDT)
From: Maxime Ripard <maxime@cerno.tech>
To: Joerg Roedel <joro@8bytes.org>, Chen-Yu Tsai <wens@csie.org>,
 Maxime Ripard <mripard@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>
Subject: [PATCH v4 2/5] dt-bindings: display: sun8i-mixer: Allow for an iommu
 property
Date: Wed, 13 May 2020 16:07:21 +0200
Message-Id: <7941e0c02794e6336da75fcac950ecd43be7fd97.1589378833.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.b27dedd61e008ffcf55a028ccddda3bb4d21dfc8.1589378833.git-series.maxime@cerno.tech>
References: <cover.b27dedd61e008ffcf55a028ccddda3bb4d21dfc8.1589378833.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Cc: devicetree@vger.kernel.org, iommu@lists.linux-foundation.org,
 Maxime Ripard <maxime@cerno.tech>, linux-arm-kernel@lists.infradead.org,
 Rob Herring <robh@kernel.org>
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

Reviewed-by: Rob Herring <robh@kernel.org>
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
