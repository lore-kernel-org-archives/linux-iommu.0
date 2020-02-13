Return-Path: <SRS0=ZJ+1=4B=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04BBBC2BA83
	for <iommu@archiver.kernel.org>; Thu, 13 Feb 2020 16:52:22 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C37D324650
	for <iommu@archiver.kernel.org>; Thu, 13 Feb 2020 16:52:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FRxKsOeY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C37D324650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 9A1DE21546;
	Thu, 13 Feb 2020 16:52:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Iw3DYfdpA5ur; Thu, 13 Feb 2020 16:52:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 0B4892154A;
	Thu, 13 Feb 2020 16:52:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EBA02C1D8E;
	Thu, 13 Feb 2020 16:52:19 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 10421C0177
 for <iommu@lists.linux-foundation.org>; Thu, 13 Feb 2020 16:52:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id F3E6286130
 for <iommu@lists.linux-foundation.org>; Thu, 13 Feb 2020 16:52:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KbZ-QhGkd4Mt for <iommu@lists.linux-foundation.org>;
 Thu, 13 Feb 2020 16:52:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com
 [209.85.221.68])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 3CC2A86119
 for <iommu@lists.linux-foundation.org>; Thu, 13 Feb 2020 16:52:18 +0000 (UTC)
Received: by mail-wr1-f68.google.com with SMTP id g3so7534163wrs.12
 for <iommu@lists.linux-foundation.org>; Thu, 13 Feb 2020 08:52:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=UJQuvs9RpncXIyFZgaHy4qfH2MXeX4KRcKSd32KW02I=;
 b=FRxKsOeYxspq/g5ZXQF5hEOTsVmnm1UDJ/kf7q2GeDWRw12p5AWgkElZS1ols7kw+s
 dzR64m9v0kLvMIAf98898PxAp+rZRaCMiXSRy4brZInJjJ6/VxxLBWM/9lwa8d1fjk3H
 yrBRTY7uPwUlO475tyPxQAhFP+xtWiu24oAsL9T1/3ejakQNp4NhRXjorbqBjDQvC2x+
 umWUy9HFmYG09ozyz8p/qxPi9s9GL84tQk3qVBpVhVK7pttVl9Or84knSQx1xMAHhIfz
 CLWA+FU1t1lS2HAZfQlHELEJoCgFDSyhJVnwQLLH58Q5mnxUj/vQkHn9bAHIS8WU9hNU
 k79w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=UJQuvs9RpncXIyFZgaHy4qfH2MXeX4KRcKSd32KW02I=;
 b=BnqywEeADLD89zmleP9RThEZDJcHcG+B3WCAM797I6C3TXi0PJ8rKxoICsYwZfqHSr
 p57uphcW3JVnBjvuqk/dRz/G4/tJGtswfLN9fD6yb1Qwi0bZFrDCQ8+K073BVZ635MY7
 duc7wsC2IIATo2FPFQMjSQymo7GYUCr5NAxzAQk15cxZrsEK6cnzYzdOGrVylXi8VPzd
 Ji7QjRECUSvev5HcsvTUbeJEavEGZgBnYj62A/zmLFZbVlzltBQSdjApx+1rced3zHqc
 zYE1UcRxqeZdJ9+U8tXXC2/3rPc0MjdOtlbdN9TRguZVer71T+YF3ICUSZGHTvQ1H56N
 vUxA==
X-Gm-Message-State: APjAAAWGjyGoSd83BVgC15xMbE1qTYGgMg6nMMtKiRnyOe32bdHuUdI4
 R6FPwlZ31lc0nZyuX/3VZiPJ6Q==
X-Google-Smtp-Source: APXvYqzeNhwO1ySgCH6GebdW+o3FuDqODOSO5w28TGumAGZvm+dXwumkzW+9YyKVQhWGqXpnMT98kw==
X-Received: by 2002:a5d:4b8f:: with SMTP id b15mr22595338wrt.100.1581612736660; 
 Thu, 13 Feb 2020 08:52:16 -0800 (PST)
Received: from localhost.localdomain ([2001:171b:2276:930:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id y6sm3484807wrl.17.2020.02.13.08.52.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2020 08:52:16 -0800 (PST)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: bhelgaas@google.com, will@kernel.org, robh+dt@kernel.org,
 lorenzo.pieralisi@arm.com, joro@8bytes.org, baolu.lu@linux.intel.com,
 linux-doc@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-acpi@vger.kernel.org, iommu@lists.linux-foundation.org
Subject: [PATCH 11/11] Documentation: Generalize the "pci=noats" boot parameter
Date: Thu, 13 Feb 2020 17:50:49 +0100
Message-Id: <20200213165049.508908-12-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200213165049.508908-1-jean-philippe@linaro.org>
References: <20200213165049.508908-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Cc: mark.rutland@arm.com, frowand.list@gmail.com, corbet@lwn.net,
 liviu.dudau@arm.com, sudeep.holla@arm.com, rjw@rjwysocki.net,
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
index dbc22d684627..e5fa8d057a3c 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3606,8 +3606,8 @@
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
2.25.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
