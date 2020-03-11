Return-Path: <SRS0=4Gp4=44=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B10D7C3F2D1
	for <iommu@archiver.kernel.org>; Wed, 11 Mar 2020 12:47:02 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 856ED22525
	for <iommu@archiver.kernel.org>; Wed, 11 Mar 2020 12:47:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v/Zaf60v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 856ED22525
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 7865E22268;
	Wed, 11 Mar 2020 12:47:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5D8QToXx64GG; Wed, 11 Mar 2020 12:47:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 4763A22618;
	Wed, 11 Mar 2020 12:47:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2CFCAC1D8E;
	Wed, 11 Mar 2020 12:47:01 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D9D7CC0177
 for <iommu@lists.linux-foundation.org>; Wed, 11 Mar 2020 12:46:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id C814322618
 for <iommu@lists.linux-foundation.org>; Wed, 11 Mar 2020 12:46:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BX-EuJIowd0c for <iommu@lists.linux-foundation.org>;
 Wed, 11 Mar 2020 12:46:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54])
 by silver.osuosl.org (Postfix) with ESMTPS id 719DC2077C
 for <iommu@lists.linux-foundation.org>; Wed, 11 Mar 2020 12:46:58 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id 25so1932404wmk.3
 for <iommu@lists.linux-foundation.org>; Wed, 11 Mar 2020 05:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=3krMYkJ5TguiyRWERa/+CMYLcOJYUhlPd6t/ch8qqgQ=;
 b=v/Zaf60vUqEkNfZdt1gJK9VC+hb3PZmmanEVWPvFm7vnZBA5ZwW1m4ZykGbhtwPbxS
 WDb8SaSMRfYNq9MWw8D64WiMIUDABRqX0BpAT4ePCPBmBilmDeqovdmyjQQbeeinzjT3
 dU7ZYFiTiptVbhWvRNSSwkbXuMm85b7zo3+WewNnxbyUAgpAYg6IacX7b8dZIsVjmoPL
 ljKaqQwgtRwTqJbizGpaPcYht4A3xsbwTlrPglZUOAUbUiWXn8f1kPSnUL4oTeXCwx5a
 HVG7oETbPqToLR4mHqQQfeuOcp3PJuFsthzK2H6yoTG+E5ivLt3KD6d/PuIk6kKoxhmV
 ptdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=3krMYkJ5TguiyRWERa/+CMYLcOJYUhlPd6t/ch8qqgQ=;
 b=Lne5ih0FdsYOaX4sC3tpFTeCINIFIGfqiUuW7qZMBo97uvAO3ggbBWF2vXYzcrXvBw
 B6z2PjgeYOjmZPrGEmtAntxZHRAcDs5i9nTHdhixCqSH8xSHzh5AcHzyYXW4yy79L042
 llJR96MOu3ZKYIRJmESuNbJwT7VwOUrNEFBjJOSqQNh6ibAyRlVC8o6d4c44m5PTE2V/
 HtP/gcS5cgVZXRnjtcb0wlrwgLM0AxAZj4PYU3mL3xmPjC6iHw8BOXoF/D5274ZaudsJ
 619INJ0H74YC6B6EJZOPGbmrAwV9G4UNgATVFtCP3rwwGTYhMvUGoiCguyhPIbussmtZ
 tcGw==
X-Gm-Message-State: ANhLgQ0WML3z93OoECfG0DcO2dTcfxpVgSPaB+wuBTYKYbFc23X5Z3aY
 WdIeMC6OpNp9oJ1ZAo1Hghb4rg==
X-Google-Smtp-Source: ADFU+vt+OuMwfLSUXiB+t1SNAG3tC3rRy29ica+E537TLkfPGDuXQo1KUhGf31RO2GY8IfyREARQ2w==
X-Received: by 2002:a1c:c3c3:: with SMTP id t186mr3842975wmf.118.1583930815804; 
 Wed, 11 Mar 2020 05:46:55 -0700 (PDT)
Received: from localhost.localdomain
 ([2001:171b:c9a8:fbc0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id c2sm8380020wma.39.2020.03.11.05.46.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Mar 2020 05:46:55 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: bhelgaas@google.com, will@kernel.org, robh+dt@kernel.org, joro@8bytes.org,
 baolu.lu@linux.intel.com, sudeep.holla@arm.com, linux-doc@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-acpi@vger.kernel.org,
 iommu@lists.linux-foundation.org
Subject: [PATCH v2 01/11] dt-bindings: PCI: generic: Add ats-supported property
Date: Wed, 11 Mar 2020 13:44:56 +0100
Message-Id: <20200311124506.208376-2-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200311124506.208376-1-jean-philippe@linaro.org>
References: <20200311124506.208376-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Cc: mark.rutland@arm.com, Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Rob Herring <robh@kernel.org>, frowand.list@gmail.com, corbet@lwn.net,
 liviu.dudau@arm.com, rjw@rjwysocki.net, guohanjun@huawei.com,
 amurray@thegoodpenguin.co.uk, robin.murphy@arm.com, dwmw2@infradead.org,
 lenb@kernel.org
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

Add a way for firmware to tell the OS that ATS is supported by the PCI
root complex. An endpoint with ATS enabled may send Translation Requests
and Translated Memory Requests, which look just like Normal Memory
Requests with a non-zero AT field. So a root controller that ignores the
AT field may simply forward the request to the IOMMU as a Normal Memory
Request, which could end badly. In any case, the endpoint will be
unusable.

The ats-supported property allows the OS to only enable ATS in endpoints
if the root controller can handle ATS requests. Only add the property to
pcie-host-ecam-generic for the moment. For non-generic root controllers,
availability of ATS can be inferred from the compatible string.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 Documentation/devicetree/bindings/pci/host-generic-pci.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/host-generic-pci.yaml b/Documentation/devicetree/bindings/pci/host-generic-pci.yaml
index 47353d0cd394..7d40edd7f1ef 100644
--- a/Documentation/devicetree/bindings/pci/host-generic-pci.yaml
+++ b/Documentation/devicetree/bindings/pci/host-generic-pci.yaml
@@ -107,6 +107,12 @@ properties:
 
   dma-coherent: true
 
+  ats-supported:
+    description:
+      Indicates that a PCIe host controller supports ATS, and can handle Memory
+      Requests with Address Type (AT).
+    type: boolean
+
 required:
   - compatible
   - reg
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
