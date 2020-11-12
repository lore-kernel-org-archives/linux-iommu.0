Return-Path: <SRS0=2i4G=ES=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE8E2C56202
	for <iommu@archiver.kernel.org>; Thu, 12 Nov 2020 13:03:26 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A86422252
	for <iommu@archiver.kernel.org>; Thu, 12 Nov 2020 13:03:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oJG4X6CI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A86422252
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 0016E87096;
	Thu, 12 Nov 2020 13:03:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oaNk9SMm3ziR; Thu, 12 Nov 2020 13:03:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id C732D87094;
	Thu, 12 Nov 2020 13:03:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BC0D3C0889;
	Thu, 12 Nov 2020 13:03:24 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1378FC016F
 for <iommu@lists.linux-foundation.org>; Thu, 12 Nov 2020 13:03:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 0B80F8703D
 for <iommu@lists.linux-foundation.org>; Thu, 12 Nov 2020 13:03:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YZysnW+FSIPT for <iommu@lists.linux-foundation.org>;
 Thu, 12 Nov 2020 13:03:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com
 [209.85.221.68])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 2BEDD87092
 for <iommu@lists.linux-foundation.org>; Thu, 12 Nov 2020 13:03:20 +0000 (UTC)
Received: by mail-wr1-f68.google.com with SMTP id p8so5921859wrx.5
 for <iommu@lists.linux-foundation.org>; Thu, 12 Nov 2020 05:03:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Tid3zbIJRKyj0Bgjxj2sf+RSwZO5YPfaeHYqLr0g5iY=;
 b=oJG4X6CI7enblSZUp3EgWunBFmyQv6mCwtptSww+yPpxypkzQpLOkXizEPseu9wI2t
 2uZpYfOj9eUqkc5Mc5tlt3K7jx+TWvIflBQqX1SEYsvTIjIegzyCiXcmEFzhPjxvoA47
 6Dq4ROrha3r07LiOgqCfR01hIVv7++Ib5t5K0yXdpav8K1LR8Zat1PWjsoKfQ809OKnH
 1k5v7fX1Ma0DDtnaTPNqdNu6iefW98IR6j56uIkzclVoD8+TGJgwKYfDHt4NXx+25cGn
 SRyX77nEr1L/nTzdOO1Yo2Myq9+BofVGSodnPeoKBdMbtEUWw45R7NEYQRJNFh3Men13
 MQBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Tid3zbIJRKyj0Bgjxj2sf+RSwZO5YPfaeHYqLr0g5iY=;
 b=GFcTKDs1e2vdwrCndPtmmrXkSudbZIqXOmFFkhe+9+FxG5aJpAt5+28P5riAcE1U7I
 vEwcCzZsBy6SE2gsUyTeNS1DzVk4ym85Yn8UMY++irNeEReA5VpR8iC5XXmWcOe8VckO
 RJs3bKpbVhQQLAmECbYoRkpLxLicokE/B4L4Mn7H8fTZSDd2F8batb6UtY07wiyBfY8z
 HB3CLR5Yac5WeDjiACCMrIo0RGdryZ1l0flHc8csquiMW1+PjpI4aRqQEgkoGM5OYVJA
 KpP3idhcP4eIdvrQzN53g/RXFrNePPokvA9notpDrInSORaDdkJAJv96BkgEBvbuDG9+
 eP4w==
X-Gm-Message-State: AOAM533Ra/85hmT6XdeG683iYEGJf6A+wzSAbs+iSK44+t0HKNJ4LvUF
 sFFBk78///wN7Q1Eo/YX6Dglyw==
X-Google-Smtp-Source: ABdhPJww5aqw0Dh36h3mNuuwHJd8ZSSnPISNulq6oQQhTrIxG8XhHZa3Ym6AO5qFBMZHmbjVR9mCBw==
X-Received: by 2002:adf:df88:: with SMTP id z8mr35234477wrl.113.1605186198680; 
 Thu, 12 Nov 2020 05:03:18 -0800 (PST)
Received: from localhost.localdomain
 ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id m22sm6877508wrb.97.2020.11.12.05.03.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2020 05:03:17 -0800 (PST)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: joro@8bytes.org, will@kernel.org, lorenzo.pieralisi@arm.com,
 robh+dt@kernel.org
Subject: [PATCH v8 3/9] dt-bindings: document stall property for IOMMU masters
Date: Thu, 12 Nov 2020 13:55:15 +0100
Message-Id: <20201112125519.3987595-4-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201112125519.3987595-1-jean-philippe@linaro.org>
References: <20201112125519.3987595-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Cc: Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org, guohanjun@huawei.com,
 rjw@rjwysocki.net, iommu@lists.linux-foundation.org, sudeep.holla@arm.com,
 bhelgaas@google.com, zhangfei.gao@linaro.org, vivek.gautam@arm.com,
 robin.murphy@arm.com, Jean-Philippe Brucker <jean-philippe@linaro.org>,
 linux-arm-kernel@lists.infradead.org, lenb@kernel.org
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

On ARM systems, some platform devices behind an IOMMU may support stall,
which is the ability to recover from page faults. Let the firmware tell us
when a device supports stall.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 .../devicetree/bindings/iommu/iommu.txt        | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/devicetree/bindings/iommu/iommu.txt b/Documentation/devicetree/bindings/iommu/iommu.txt
index 3c36334e4f94..26ba9e530f13 100644
--- a/Documentation/devicetree/bindings/iommu/iommu.txt
+++ b/Documentation/devicetree/bindings/iommu/iommu.txt
@@ -92,6 +92,24 @@ Optional properties:
   tagging DMA transactions with an address space identifier. By default,
   this is 0, which means that the device only has one address space.
 
+- dma-can-stall: When present, the master can wait for a transaction to
+  complete for an indefinite amount of time. Upon translation fault some
+  IOMMUs, instead of aborting the translation immediately, may first
+  notify the driver and keep the transaction in flight. This allows the OS
+  to inspect the fault and, for example, make physical pages resident
+  before updating the mappings and completing the transaction. Such IOMMU
+  accepts a limited number of simultaneous stalled transactions before
+  having to either put back-pressure on the master, or abort new faulting
+  transactions.
+
+  Firmware has to opt-in stalling, because most buses and masters don't
+  support it. In particular it isn't compatible with PCI, where
+  transactions have to complete before a time limit. More generally it
+  won't work in systems and masters that haven't been designed for
+  stalling. For example the OS, in order to handle a stalled transaction,
+  may attempt to retrieve pages from secondary storage in a stalled
+  domain, leading to a deadlock.
+
 
 Notes:
 ======
-- 
2.29.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
