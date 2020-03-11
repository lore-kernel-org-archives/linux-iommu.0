Return-Path: <SRS0=4Gp4=44=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CCAFC3F2D6
	for <iommu@archiver.kernel.org>; Wed, 11 Mar 2020 12:47:14 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52A1521D56
	for <iommu@archiver.kernel.org>; Wed, 11 Mar 2020 12:47:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IMq0GOgl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52A1521D56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 2CDAC87B1D;
	Wed, 11 Mar 2020 12:47:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Tpabd3rNyLpy; Wed, 11 Mar 2020 12:47:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 804998753F;
	Wed, 11 Mar 2020 12:47:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6BF42C18D3;
	Wed, 11 Mar 2020 12:47:13 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 43E72C1D8E
 for <iommu@lists.linux-foundation.org>; Wed, 11 Mar 2020 12:47:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 3FBC887EB5
 for <iommu@lists.linux-foundation.org>; Wed, 11 Mar 2020 12:47:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8EhaO2b+qq33 for <iommu@lists.linux-foundation.org>;
 Wed, 11 Mar 2020 12:47:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com
 [209.85.128.67])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 27B8B87ED2
 for <iommu@lists.linux-foundation.org>; Wed, 11 Mar 2020 12:47:11 +0000 (UTC)
Received: by mail-wm1-f67.google.com with SMTP id g62so1978659wme.1
 for <iommu@lists.linux-foundation.org>; Wed, 11 Mar 2020 05:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=d0rLUPpWc9LKXF0i9+CPpLN+OwQQCuUUQ2gfv2HulHQ=;
 b=IMq0GOglrv9AJ7IWePlqPKh+g5vEP7KPGWHNuTRmuqqvl++Phj5Ie3+A+QfEKkME3h
 q0vWho6oLDy9c22giASuCH1G1T6he+iSuHY/0OPrxfchkouzillYMOGGlzBA9bwKR7Yg
 +I0CgBIjKYUYCNZqgojagWqC+afKYcAZQQapMTNAk/850hRMXduZJO1Etpt2EYWQCcUy
 n3ofi2ltjHGzGZBjILh2yTVAHr185N6iaj4H1T9AvACvPv+DIvL+M85edL84HEByBf8K
 uVCJ+BkBjMVx15RAWG7GqnxYs9Z1XwTzh1D54MLnPmoo3LAkRQYN2UwFDW+zLVcZypwF
 ZfOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=d0rLUPpWc9LKXF0i9+CPpLN+OwQQCuUUQ2gfv2HulHQ=;
 b=QITcXq8L338h5ofewyhLzl4dbRM88fI+I4rkVugmjl3p2h0dIE9lo0fNs7iK0QwQ6H
 Zx+fehbPGJ/KO4tVApnqAgXLgPS5Q1/pEcmjUMhDPne1JDm65YwjrDRrv6U6vJcrCt3P
 BXcGx2OiDSxYkahFej58YCMbGwJtwlfwksoyvo5Tse4R/qZsOH6JBYJTXqYpleYi95n/
 R9RN8dVthih55Z179EM3hdN/cAitKgJRziUJZV6QOIC+JWAl93/SWltjzZG9TpM/OnRj
 RpyveCP5NlrCuA6CU9c6Brw3psGIw+arelfawMFatjY5v6RuRUnMBq3QsakqO14vRy65
 vGVA==
X-Gm-Message-State: ANhLgQ1V5c0zyatyN6e86k2tyoEooNc53GgWJQ3lstyx3hnttizOd9OD
 l619//rinKg6GjcuBD8TFxYtcQ==
X-Google-Smtp-Source: ADFU+vtSp3bp4YHfuXWS38IAA5q6tgH8hB5aWJ3nzhD3eOkPVBueydoPmuaFZUj0SnvU9SNNjQlTgg==
X-Received: by 2002:a7b:c414:: with SMTP id k20mr3678319wmi.119.1583930829492; 
 Wed, 11 Mar 2020 05:47:09 -0700 (PDT)
Received: from localhost.localdomain
 ([2001:171b:c9a8:fbc0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id c2sm8380020wma.39.2020.03.11.05.47.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Mar 2020 05:47:09 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: bhelgaas@google.com, will@kernel.org, robh+dt@kernel.org, joro@8bytes.org,
 baolu.lu@linux.intel.com, sudeep.holla@arm.com, linux-doc@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-acpi@vger.kernel.org,
 iommu@lists.linux-foundation.org
Subject: [PATCH v2 11/11] Documentation: Generalize the "pci=noats" boot
 parameter
Date: Wed, 11 Mar 2020 13:45:06 +0100
Message-Id: <20200311124506.208376-12-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200311124506.208376-1-jean-philippe@linaro.org>
References: <20200311124506.208376-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Cc: mark.rutland@arm.com, Jean-Philippe Brucker <jean-philippe@linaro.org>,
 frowand.list@gmail.com, corbet@lwn.net, liviu.dudau@arm.com, rjw@rjwysocki.net,
 guohanjun@huawei.com, amurray@thegoodpenguin.co.uk, robin.murphy@arm.com,
 dwmw2@infradead.org, lenb@kernel.org
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

The "pci=noats" kernel parameter disables PCIe ATS globally, and affects
any ATS-capable IOMMU driver. So rather than adding Arm SMMUv3, which
recently gained ATS support, to the list of relevant build options,
simplify the noats description.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 Documentation/admin-guide/kernel-parameters.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index c07815d230bc..3e17ddb76731 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3610,8 +3610,8 @@
 				on: Turn realloc on
 		realloc		same as realloc=on
 		noari		do not use PCIe ARI.
-		noats		[PCIE, Intel-IOMMU, AMD-IOMMU]
-				do not use PCIe ATS (and IOMMU device IOTLB).
+		noats		[PCIE] Do not use PCIe ATS (and IOMMU device
+				IOTLB).
 		pcie_scan_all	Scan all possible PCIe devices.  Otherwise we
 				only look for one device below a PCIe downstream
 				port.
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
