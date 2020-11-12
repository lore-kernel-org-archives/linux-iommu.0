Return-Path: <SRS0=2i4G=ES=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68CE6C64E7C
	for <iommu@archiver.kernel.org>; Thu, 12 Nov 2020 13:03:35 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E54BA2224E
	for <iommu@archiver.kernel.org>; Thu, 12 Nov 2020 13:03:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QZfgK97B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E54BA2224E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 73E158778C;
	Thu, 12 Nov 2020 13:03:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id E3JjZ4rBmJhq; Thu, 12 Nov 2020 13:03:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 76AFB87789;
	Thu, 12 Nov 2020 13:03:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 638E8C1AD9;
	Thu, 12 Nov 2020 13:03:33 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8F83DC016F
 for <iommu@lists.linux-foundation.org>; Thu, 12 Nov 2020 13:03:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 7A6732E1E9
 for <iommu@lists.linux-foundation.org>; Thu, 12 Nov 2020 13:03:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vF4f5zQDYcUg for <iommu@lists.linux-foundation.org>;
 Thu, 12 Nov 2020 13:03:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com
 [209.85.128.68])
 by silver.osuosl.org (Postfix) with ESMTPS id F0F652E1E2
 for <iommu@lists.linux-foundation.org>; Thu, 12 Nov 2020 13:03:25 +0000 (UTC)
Received: by mail-wm1-f68.google.com with SMTP id s13so5431501wmh.4
 for <iommu@lists.linux-foundation.org>; Thu, 12 Nov 2020 05:03:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=YNIotbOC7bka5Z9BLnFVmsCtOLB6kJ/rhFA9CsCNoBU=;
 b=QZfgK97B8RvBj1vgMXgdtAlJTXGErNY2MHWaYeZJYcihAKpzxznX+f3QupErxyW+y7
 vl5dFcj/SwiTM7AoiBl8Ekh/VI2I+MV6RRDXOcrbDCGTkeMw66SFzS1DgJvxjcaDuKjk
 2bmfttuRd5KL3r+eSvLlVqZxie8jGCaK6VIEInNDm+bzEK1xUWxTL3t2xMOYv4Bass5p
 gBiBnUXUjVBFvCB1BrWOR56d6TtjFa2TYTFOwxI7fDliFlDQVEIWqgTYl5sIlbDUR1ej
 iCxbPa+0gIBZXHXjDH2ssbGlbO7TSEgUjnx9UYgYtW9ALf/I+qK3xCqik9HnPlfBcF/J
 Vzrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=YNIotbOC7bka5Z9BLnFVmsCtOLB6kJ/rhFA9CsCNoBU=;
 b=Sw2iWx3O31BHYjP7nT0XfegFuUQgZvhBX9+8AgVFqlcQ5RM3FGa7lGdV8Mvyxedo0z
 5ZjwW26lGMU3l4Np6+bNcWodv94OaBftnHDh3lBLRTS4TLj8BOwvzEuZPWzoGYSKom58
 Ft2J6xInN61hUs+jrF2wdADC1ibdsfurmW1u1xuMyItPriAlU93kr3K2/4G2gLY+YeTd
 3T982ANRGuK28jmnwyzb6ucDQzkVNN05d3ETBmj27FwBqm7mOKA9L493mHVWmOGd3luG
 G5NZuWTgh55u9RWHv9Q/bg1uC6fLiXjwkS31N2zGSlbn1Z/E0zWGvgZBkFySmX0WQUwv
 hN0g==
X-Gm-Message-State: AOAM530vEN9hkz4WqWwBwzD1yJJJQfDSAsoLisaOKg5ZPAtbXkzLtqG9
 grrmyEedY+IhS4udxeyA2oTNgg==
X-Google-Smtp-Source: ABdhPJwEuQSW7wZd81DIymTmLqqJtRteXgrSKTo8T+v6vTfsJF7cOILOIkbIrFkOfcCnh2vnSQXfbA==
X-Received: by 2002:a1c:2586:: with SMTP id l128mr9104219wml.149.1605186204490; 
 Thu, 12 Nov 2020 05:03:24 -0800 (PST)
Received: from localhost.localdomain
 ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id m22sm6877508wrb.97.2020.11.12.05.03.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2020 05:03:23 -0800 (PST)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: joro@8bytes.org, will@kernel.org, lorenzo.pieralisi@arm.com,
 robh+dt@kernel.org
Subject: [PATCH v8 7/9] PCI/ATS: Add PRI stubs
Date: Thu, 12 Nov 2020 13:55:19 +0100
Message-Id: <20201112125519.3987595-8-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201112125519.3987595-1-jean-philippe@linaro.org>
References: <20201112125519.3987595-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Cc: devicetree@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-pci@vger.kernel.org, guohanjun@huawei.com, rjw@rjwysocki.net,
 iommu@lists.linux-foundation.org, sudeep.holla@arm.com, bhelgaas@google.com,
 zhangfei.gao@linaro.org, vivek.gautam@arm.com, robin.murphy@arm.com,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
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

The SMMUv3 driver, which can be built without CONFIG_PCI, will soon gain
support for PRI.  Partially revert commit c6e9aefbf9db ("PCI/ATS: Remove
unused PRI and PASID stubs") to re-introduce the PRI stubs, and avoid
adding more #ifdefs to the SMMU driver.

Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 include/linux/pci-ats.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/linux/pci-ats.h b/include/linux/pci-ats.h
index df54cd5b15db..ccfca09fd232 100644
--- a/include/linux/pci-ats.h
+++ b/include/linux/pci-ats.h
@@ -30,6 +30,13 @@ int pci_reset_pri(struct pci_dev *pdev);
 int pci_prg_resp_pasid_required(struct pci_dev *pdev);
 bool pci_pri_supported(struct pci_dev *pdev);
 #else
+static inline int pci_enable_pri(struct pci_dev *pdev, u32 reqs)
+{ return -ENODEV; }
+static inline void pci_disable_pri(struct pci_dev *pdev) { }
+static inline int pci_reset_pri(struct pci_dev *pdev)
+{ return -ENODEV; }
+static inline int pci_prg_resp_pasid_required(struct pci_dev *pdev)
+{ return 0; }
 static inline bool pci_pri_supported(struct pci_dev *pdev)
 { return false; }
 #endif /* CONFIG_PCI_PRI */
-- 
2.29.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
