Return-Path: <SRS0=s4mY=HE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1763EC433DB
	for <iommu@archiver.kernel.org>; Tue,  2 Feb 2021 20:55:54 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D37964F61
	for <iommu@archiver.kernel.org>; Tue,  2 Feb 2021 20:55:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D37964F61
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 7411A868F4;
	Tue,  2 Feb 2021 20:55:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hDSaM8cari4R; Tue,  2 Feb 2021 20:55:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id EBE55868F1;
	Tue,  2 Feb 2021 20:55:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D4034C0FA7;
	Tue,  2 Feb 2021 20:55:52 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 85890C013A
 for <iommu@lists.linux-foundation.org>; Tue,  2 Feb 2021 20:55:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 7C81A868F1
 for <iommu@lists.linux-foundation.org>; Tue,  2 Feb 2021 20:55:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id olYanx28rI6f for <iommu@lists.linux-foundation.org>;
 Tue,  2 Feb 2021 20:55:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com
 [209.85.210.51])
 by whitealder.osuosl.org (Postfix) with ESMTPS id F4161868EB
 for <iommu@lists.linux-foundation.org>; Tue,  2 Feb 2021 20:55:50 +0000 (UTC)
Received: by mail-ot1-f51.google.com with SMTP id e70so21206137ote.11
 for <iommu@lists.linux-foundation.org>; Tue, 02 Feb 2021 12:55:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=S/rEofJPqnkLlE8GJQFmVM1qahKIfCsQMC9dA4r5GHw=;
 b=e7Vm/jREDsBliv+OGhLG5hVRS4Y5xrZQvjujMri3DQyb2FugOmhe3hnBRSLPfK8cBs
 GgsxflKFbjJUoklWR/33lK+cSFBMVDa5iAPvQs4tLVfOnliN/DLto8XBN4iPurSMF5E6
 YmUdqx2UrTX0de0NHHnLxKlkxC6Q8vTfRutDFbIlQZlHAnI/6VWSx3rJA8OEE0b4avyQ
 qGSCJ65njTzCn6LcAUf33iexKc6gTkWRz389bBUx1SJmxwBkN1rJIswzneBcmM64DQjh
 Kngc+t9lrWUrgf0Z0aNSyfb0hnYlZZuFRvpymngzAXJ0Dl/LFV3dv9vwI1uGCHWOQWYB
 qw0g==
X-Gm-Message-State: AOAM532yjueX7lVsSKSvR3IRc+u/6HxxwqMayzIDo11GfXsdO0diHIyp
 iXMbiWCIwBjyQz/4gIYAPA==
X-Google-Smtp-Source: ABdhPJyTfcE7Idlr0T2ZxzdhnhsjVGP931mbpfLbWa9WxA2Y7K5KDop7bsHZiJVP+WqqddEvlnnecQ==
X-Received: by 2002:a9d:6643:: with SMTP id q3mr11847740otm.63.1612299350248; 
 Tue, 02 Feb 2021 12:55:50 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.googlemail.com with ESMTPSA id k15sm4206otp.10.2021.02.02.12.55.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Feb 2021 12:55:49 -0800 (PST)
From: Rob Herring <robh@kernel.org>
To: devicetree@vger.kernel.org
Subject: [PATCH 2/3] dt-bindings: iommu: renesas,
 ipmmu-vmsa: Make 'power-domains' conditionally required
Date: Tue,  2 Feb 2021 14:55:43 -0600
Message-Id: <20210202205544.24812-2-robh@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210202205544.24812-1-robh@kernel.org>
References: <20210202205544.24812-1-robh@kernel.org>
MIME-Version: 1.0
Cc: Tomer Maimon <tmaimon77@gmail.com>, Andrew Jeffery <andrew@aj.id.au>,
 Linus Walleij <linus.walleij@linaro.org>,
 Vincent Cheng <vincent.cheng.xh@renesas.com>,
 Tali Perry <tali.perry1@gmail.com>, Daniel Palmer <daniel@thingy.jp>,
 linux-i2c@vger.kernel.org, Will Deacon <will@kernel.org>,
 linux-clk@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>, Chen-Yu Tsai <wens@csie.org>,
 Joel Stanley <joel@jms.id.au>, Guenter Roeck <linux@roeck-us.net>,
 linux-watchdog@vger.kernel.org, Maxime Ripard <mripard@kernel.org>,
 linux-gpio@vger.kernel.org, Wim Van Sebroeck <wim@linux-watchdog.org>,
 Avi Fishman <avifishman70@gmail.com>, linux-kernel@vger.kernel.org,
 Stephen Boyd <sboyd@kernel.org>, iommu@lists.linux-foundation.org,
 linux-crypto@vger.kernel.org, "David S. Miller" <davem@davemloft.net>
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

Fixing the compatible string typos results in an error in the example:

Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa.example.dt.yaml:
  iommu@fe951000: 'power-domains' is a required property

Based on the dts files, a 'power-domains' property only exists on Gen 3
which can be conditioned on !renesas,ipmmu-vmsa.

Cc: Joerg Roedel <joro@8bytes.org>
Cc: Will Deacon <will@kernel.org>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: iommu@lists.linux-foundation.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../bindings/iommu/renesas,ipmmu-vmsa.yaml           | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa.yaml b/Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa.yaml
index 349633108bbd..dda44976acc1 100644
--- a/Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa.yaml
+++ b/Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa.yaml
@@ -76,7 +76,6 @@ required:
   - compatible
   - reg
   - '#iommu-cells'
-  - power-domains
 
 oneOf:
   - required:
@@ -86,6 +85,17 @@ oneOf:
 
 additionalProperties: false
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          not:
+            contains:
+              const: renesas,ipmmu-vmsa
+    then:
+      required:
+        - power-domains
+
 examples:
   - |
     #include <dt-bindings/clock/r8a7791-cpg-mssr.h>
-- 
2.27.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
