Return-Path: <SRS0=c0M2=2J=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 126A1C47409
	for <iommu@archiver.kernel.org>; Thu, 19 Dec 2019 16:31:29 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9F1B2467E
	for <iommu@archiver.kernel.org>; Thu, 19 Dec 2019 16:31:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DZ1mQvkj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9F1B2467E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id BFCE087F94;
	Thu, 19 Dec 2019 16:31:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tpIKXfIUDKu5; Thu, 19 Dec 2019 16:31:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 0405A87F9A;
	Thu, 19 Dec 2019 16:31:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DEE7DC1AE8;
	Thu, 19 Dec 2019 16:31:24 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 51C5FC077D
 for <iommu@lists.linux-foundation.org>; Thu, 19 Dec 2019 16:31:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 404D386FDB
 for <iommu@lists.linux-foundation.org>; Thu, 19 Dec 2019 16:31:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gWECjKKsQNOe for <iommu@lists.linux-foundation.org>;
 Thu, 19 Dec 2019 16:31:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com
 [209.85.221.67])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 79BDE86FD3
 for <iommu@lists.linux-foundation.org>; Thu, 19 Dec 2019 16:31:23 +0000 (UTC)
Received: by mail-wr1-f67.google.com with SMTP id b6so6659763wrq.0
 for <iommu@lists.linux-foundation.org>; Thu, 19 Dec 2019 08:31:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=+Rlh4fuYqJBRp2jOU8B0MlV1M4d0Kd3bn04JlNplJUI=;
 b=DZ1mQvkj39du9c3uvhuc1sVcu9Y0A998X/z1CY268T8u5anFgELkbUT49r7j/FRZcz
 +7ksycnZd2+fQJ6zh90kx8v00yqv95+dvo7vFBGyHIpOdKxZ0pBKHP1Ib58Ky7Fth78Z
 VeRsmVP2kmHmNbga3t9PtcFS9+McrPng62snTWftNTaRLMsUnkTCDDJavYidq4WFXSbY
 4AcOnnyLgLkT3p79PmvIDRKzHsoP0jh32/SQlZwafUWUhVdz4WPCLo+VzqantlSmz8QH
 1+1hoBcCfokGxka6d4wDM3UGxmSx/Ms/zaBIQammeFbf2MG87txqfxqlxOs1Ib7Kb6F6
 gRXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=+Rlh4fuYqJBRp2jOU8B0MlV1M4d0Kd3bn04JlNplJUI=;
 b=bqWkFAuQl91pjx4fBo+I+rnXOgQdspgDLF6onlmQlgmTxQWEp5j8cYGeKRQSjNezhL
 rl952R1Eg5UvANOmFmvvl2yEwYPVFQCkCtqKuwuuSTIjkQcwSl1y9JmJj16sXSPJSV8S
 fwHd2kBIzqpzBqOvNCn3DPMWEjTBAMN2kzH1lMnK87nC7qH+NilqEjZerUqcUAdqOGMg
 FSszcfo6/iHS3AtGMLsAriQa5IejnrunEpO/cIxyMGSyfd8A+ZGwGiIlbyNQF4VcVxgF
 WUruamRRcrc34eWhuusDZptQW1z66kYBdJRVMb4Z8F18HkEFca3dLe0x4gnRPdnX79KA
 s36A==
X-Gm-Message-State: APjAAAWg+Qyv4FDsRxSOrqERGktQlJMRSNfHKWapBDuaFmquyo1o0iA+
 83HcQrUYLEf1sKKF5V088iWmFg==
X-Google-Smtp-Source: APXvYqyam1fWJispp04KzWY3PPXWRuIZpC4LpasQ5BFUWvh/VFFpRwbOR/7kgGSzp2MXQTFfM2Wo2Q==
X-Received: by 2002:adf:f5cb:: with SMTP id k11mr9990514wrp.71.1576773081514; 
 Thu, 19 Dec 2019 08:31:21 -0800 (PST)
Received: from localhost.localdomain (adsl-84-227-176-239.adslplus.ch.
 [84.227.176.239])
 by smtp.gmail.com with ESMTPSA id u22sm7092068wru.30.2019.12.19.08.31.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2019 08:31:20 -0800 (PST)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
 iommu@lists.linux-foundation.org
Subject: [PATCH v4 02/13] dt-bindings: document PASID property for IOMMU
 masters
Date: Thu, 19 Dec 2019 17:30:22 +0100
Message-Id: <20191219163033.2608177-3-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191219163033.2608177-1-jean-philippe@linaro.org>
References: <20191219163033.2608177-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Cc: mark.rutland@arm.com, robin.murphy@arm.com, guohanjun@huawei.com,
 rjw@rjwysocki.net, robh+dt@kernel.org, sudeep.holla@arm.com,
 bhelgaas@google.com, zhangfei.gao@linaro.org, will@kernel.org, lenb@kernel.org
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

On Arm systems, some platform devices behind an SMMU may support the PASID
feature, which offers multiple address space. Let the firmware tell us
when a device supports PASID.

Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 Documentation/devicetree/bindings/iommu/iommu.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/iommu/iommu.txt b/Documentation/devicetree/bindings/iommu/iommu.txt
index 5a8b4624defc..3c36334e4f94 100644
--- a/Documentation/devicetree/bindings/iommu/iommu.txt
+++ b/Documentation/devicetree/bindings/iommu/iommu.txt
@@ -86,6 +86,12 @@ have a means to turn off translation. But it is invalid in such cases to
 disable the IOMMU's device tree node in the first place because it would
 prevent any driver from properly setting up the translations.
 
+Optional properties:
+--------------------
+- pasid-num-bits: Some masters support multiple address spaces for DMA, by
+  tagging DMA transactions with an address space identifier. By default,
+  this is 0, which means that the device only has one address space.
+
 
 Notes:
 ======
-- 
2.24.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
