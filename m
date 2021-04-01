Return-Path: <SRS0=bVsO=I6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88564C433B4
	for <iommu@archiver.kernel.org>; Thu,  1 Apr 2021 15:48:28 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44B8E6137B
	for <iommu@archiver.kernel.org>; Thu,  1 Apr 2021 15:48:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44B8E6137B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 17C3A60BE3;
	Thu,  1 Apr 2021 15:48:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yTn_OA6_ZH1Z; Thu,  1 Apr 2021 15:48:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id E808C60720;
	Thu,  1 Apr 2021 15:48:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C8F62C000B;
	Thu,  1 Apr 2021 15:48:26 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AEFEDC0017
 for <iommu@lists.linux-foundation.org>; Thu,  1 Apr 2021 15:48:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8723641848
 for <iommu@lists.linux-foundation.org>; Thu,  1 Apr 2021 15:48:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id d50iF9oPtqQO for <iommu@lists.linux-foundation.org>;
 Thu,  1 Apr 2021 15:48:23 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5597241561
 for <iommu@lists.linux-foundation.org>; Thu,  1 Apr 2021 15:48:23 +0000 (UTC)
Received: by mail-wr1-x42a.google.com with SMTP id v11so2281435wro.7
 for <iommu@lists.linux-foundation.org>; Thu, 01 Apr 2021 08:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=qpxpWMnrPJKc07Z7A57L4cT+PGNv1GXXzLI4P6Yd1EE=;
 b=jFGB9GSoGXYX3K+nuYC/3qk1ccHgek4JlpJBTapcg1kGDi0EdR05JaD/W+kS5Ry4r/
 9jACVmw8RpTQJ6aOuJgcb6f+gsjrqmWJus8aUSvQ+3uHqKAmIezP63nLwJXSJphZ76J4
 PwfJzOX9u5yhYHyn3trzzAPq2lI9dQCuJfTjmP+h+DmS1Ij9KW7MP8j+A5EckrmP6ymW
 YLSf8FR6eUJaHuhk19X4uDd50R2umQSPSWMTVVCqs4CNs5DLQYoQ/VwCDQlAYkUSjA1E
 OoCkNJREzAOO7+BOlLztBFnSlSDBqlYwLDudahJeNKDwIFxCDvl72kvfg2Q+AXBGz/pP
 kMGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=qpxpWMnrPJKc07Z7A57L4cT+PGNv1GXXzLI4P6Yd1EE=;
 b=pVlcO6fE6fPAINQ3S7q+A4owEl21JTP1nBG6DY9ba4I684pVZ0jOhLVHtqx5UzZ8px
 Mqh6G65gZuMPIaUPLxUogtcBg1eNdcOplFUm/RYC4/OPR34KINBy55W+b67z4qZ61w2a
 o3vgI2ryVvWyVlHGvfomtUcXoqaHc/2/QKZHVtzQLQGlufgvqz2o/Pjb+7MfUxQO2Gtf
 z9qnybeMJA3s7U37NrnZrIk2KkGcwipm5Vzuc8cQ8YdUy895AMYsmDppjTq8kpI0OTil
 HH6xgW8o/0N705KNzt+tHWKYLWQX008b/2UmoVzH3QmZWQ4fX4Lrv5IlkXdOckwJjZFr
 Vu6Q==
X-Gm-Message-State: AOAM531oIIoTSdVbkxlTJcRyty2jIP19R4LxIPsjLM5GIuHTXosGOfCF
 E6kdNVHrxpwocRsBv61RQP3X2w==
X-Google-Smtp-Source: ABdhPJz+lVV+B3QqYA925zNmgNgDtjaPx5BumLqk3WkRdxQ7T/gWYzEU6np11tFENpxunZ9tvcBFyg==
X-Received: by 2002:adf:fb0e:: with SMTP id c14mr10678009wrr.140.1617292101697; 
 Thu, 01 Apr 2021 08:48:21 -0700 (PDT)
Received: from localhost.localdomain
 ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id y8sm8722505wmi.46.2021.04.01.08.48.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Apr 2021 08:48:21 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: joro@8bytes.org,
	will@kernel.org
Subject: [PATCH v14 08/10] dt-bindings: document stall property for IOMMU
 masters
Date: Thu,  1 Apr 2021 17:47:17 +0200
Message-Id: <20210401154718.307519-9-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210401154718.307519-1-jean-philippe@linaro.org>
References: <20210401154718.307519-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Cc: vivek.gautam@arm.com, guohanjun@huawei.com,
 Jean-Philippe Brucker <jean-philippe@linaro.org>, linux-acpi@vger.kernel.org,
 zhangfei.gao@linaro.org, lenb@kernel.org, devicetree@vger.kernel.org,
 kevin.tian@intel.com, Rob Herring <robh@kernel.org>, robh+dt@kernel.org,
 linux-arm-kernel@lists.infradead.org, rjw@rjwysocki.net,
 iommu@lists.linux-foundation.org, sudeep.holla@arm.com, robin.murphy@arm.com,
 linux-accelerators@lists.ozlabs.org
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

Reviewed-by: Eric Auger <eric.auger@redhat.com>
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
2.31.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
