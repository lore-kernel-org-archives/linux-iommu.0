Return-Path: <SRS0=c0M2=2J=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9CCFC2D0D1
	for <iommu@archiver.kernel.org>; Thu, 19 Dec 2019 16:31:41 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEAC624672
	for <iommu@archiver.kernel.org>; Thu, 19 Dec 2019 16:31:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W+Iytwj4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEAC624672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 8BC818870B;
	Thu, 19 Dec 2019 16:31:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PhSeL7CMJ13K; Thu, 19 Dec 2019 16:31:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 789E488703;
	Thu, 19 Dec 2019 16:31:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 72E2DC077D;
	Thu, 19 Dec 2019 16:31:40 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F3C7CC077D
 for <iommu@lists.linux-foundation.org>; Thu, 19 Dec 2019 16:31:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id D491A87F83
 for <iommu@lists.linux-foundation.org>; Thu, 19 Dec 2019 16:31:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vGjnwjf5wCJ0 for <iommu@lists.linux-foundation.org>;
 Thu, 19 Dec 2019 16:31:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com
 [209.85.221.66])
 by whitealder.osuosl.org (Postfix) with ESMTPS id D381687FA6
 for <iommu@lists.linux-foundation.org>; Thu, 19 Dec 2019 16:31:36 +0000 (UTC)
Received: by mail-wr1-f66.google.com with SMTP id q6so6597020wro.9
 for <iommu@lists.linux-foundation.org>; Thu, 19 Dec 2019 08:31:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=k0PTgEa8Z2EtxKNp+bXlU3gMIeIQMMd4dvAJJmx7ucE=;
 b=W+Iytwj4wvUZ2mbwDVM7FzjhurcQ7XEm74cJFZdKNOpWZtf7wK2eBP0X8FsMZeSJ6x
 iR0hoMFIuiITseQd974oYuP4t6sCXPRf3CBmd6yCV89pn+xP+xk+w7DoS2RBpcJj2xkt
 9hAy9ONlO9aTHj8k3D5PUqhPlRW8+9sBhjji/UXYjHTc2kU0B/rcTeoqySC1prww1Kh5
 lDK2rbNnj95q+9W/YHUT8aL/yY4xujuGQ3Gqt7+IIi+uCEaUwCmo0aNTuAmGuF4PphBE
 eH7TqxdLwqXapRzKuHr8uFQZKVtKa1+hpBYpYNgTi8ckKxL0EE66EGNi9XNuHJ5DvbFx
 fRpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=k0PTgEa8Z2EtxKNp+bXlU3gMIeIQMMd4dvAJJmx7ucE=;
 b=KnxiiKzvP+y6zCYCDZD7I7c/xtmPYPNBdt9usjFbEX43kbTevaGvsFtw+FXRpXAzEr
 z0vkhRzpy16OFFC/hlBRrMlwQIZ/ZVxraYtWCUtjO+cYCTlG5Qu2t77BCvHk2XsXH5lI
 ixN1Pt9AejAF+JBgrZTuYnzq0KHlHaGpeEHbLZoqiQa8EjwUDPtlIohx0lvfECo5YqmU
 NuVlWGYABYnCsMrsidXxe28XJkx8JiN481bhkOJHQtrzDA7xPprm1DVUUQjvxMzYjLr2
 MsUXbUFcfbxy7irAM2aXLtd+DYWOC5DaySWAdsiXgTVLjmhL60sk1Aa7lnGL7o+LTurP
 wTlg==
X-Gm-Message-State: APjAAAW4cscCWvWl6DuWCouFwPUMKbZHHqaGHfFRV4qzR8XSS8s03f1t
 /4KeYv1q/N55gdBb5jce9acJBA==
X-Google-Smtp-Source: APXvYqydpFFmYvpMjkEfbCXJIymkJAymWbp5K7XBwcoeSyvYywcmv2pSNLmPre/mfuyPhSrLgbG6Lw==
X-Received: by 2002:adf:fcc4:: with SMTP id f4mr10390218wrs.247.1576773095285; 
 Thu, 19 Dec 2019 08:31:35 -0800 (PST)
Received: from localhost.localdomain (adsl-84-227-176-239.adslplus.ch.
 [84.227.176.239])
 by smtp.gmail.com with ESMTPSA id u22sm7092068wru.30.2019.12.19.08.31.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2019 08:31:34 -0800 (PST)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
 iommu@lists.linux-foundation.org
Subject: [PATCH v4 12/13] PCI/ATS: Add PASID stubs
Date: Thu, 19 Dec 2019 17:30:32 +0100
Message-Id: <20191219163033.2608177-13-jean-philippe@linaro.org>
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

The SMMUv3 driver, which may be built without CONFIG_PCI, will soon gain
PASID support.  Partially revert commit c6e9aefbf9db ("PCI/ATS: Remove
unused PRI and PASID stubs") to re-introduce the PASID stubs, and avoid
adding more #ifdefs to the SMMU driver.

Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 include/linux/pci-ats.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/pci-ats.h b/include/linux/pci-ats.h
index 5d62e78946a3..d08f0869f121 100644
--- a/include/linux/pci-ats.h
+++ b/include/linux/pci-ats.h
@@ -33,6 +33,9 @@ void pci_disable_pasid(struct pci_dev *pdev);
 int pci_pasid_features(struct pci_dev *pdev);
 int pci_max_pasids(struct pci_dev *pdev);
 #else /* CONFIG_PCI_PASID */
+static inline int pci_enable_pasid(struct pci_dev *pdev, int features)
+{ return -EINVAL; }
+static inline void pci_disable_pasid(struct pci_dev *pdev) { }
 static inline int pci_pasid_features(struct pci_dev *pdev)
 { return -EINVAL; }
 static inline int pci_max_pasids(struct pci_dev *pdev)
-- 
2.24.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
