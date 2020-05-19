Return-Path: <SRS0=kGUL=7B=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66CA4C43600
	for <iommu@archiver.kernel.org>; Tue, 19 May 2020 18:02:14 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E508207D3
	for <iommu@archiver.kernel.org>; Tue, 19 May 2020 18:02:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T73/hci8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E508207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 2A91E88056;
	Tue, 19 May 2020 18:02:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZuW51c6CiAJU; Tue, 19 May 2020 18:02:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id B133187863;
	Tue, 19 May 2020 18:02:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 62A45C0881;
	Tue, 19 May 2020 18:02:13 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 072ABC0176
 for <iommu@lists.linux-foundation.org>; Tue, 19 May 2020 18:02:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id E766A888AE
 for <iommu@lists.linux-foundation.org>; Tue, 19 May 2020 18:02:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iMMO4XBE0IYG for <iommu@lists.linux-foundation.org>;
 Tue, 19 May 2020 18:02:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com
 [209.85.128.66])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 1FA5A88882
 for <iommu@lists.linux-foundation.org>; Tue, 19 May 2020 18:02:10 +0000 (UTC)
Received: by mail-wm1-f66.google.com with SMTP id w64so201463wmg.4
 for <iommu@lists.linux-foundation.org>; Tue, 19 May 2020 11:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ItT+TOPL7iHYDvWhuBPZ37dZIwufOCW7iBxWcHWr4y4=;
 b=T73/hci8m0xaQEonuG+UITtUtGVzOJkMhIY/g1SohiFjmbfVK6w59f+mvqGudusgqn
 KgSK+DNf5H/EQw1G/d66b7N0XokxEarYo8OFVIa3yO4z8ZUf4rBHRzAX2fY5L09vHu1Y
 QQzBlmR3/6FRKXAEejV9+0bzWiW/ndlxSsX7EpdL73Qs3tIfuU7JiQ1JABcUgfVkg84v
 /5x6oY+5isr6RrxYXgLgn/rKf2OVXKo+2aaq/oVwR31vmGqGarJEDUl11onJW/3JsSu6
 L760pJcDstfBWOr3+KHNzLdSHCFEX02NpH3IIwq+RgLPlc9O62wk3XBFgwtfUBP2m/Pl
 pXnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ItT+TOPL7iHYDvWhuBPZ37dZIwufOCW7iBxWcHWr4y4=;
 b=dejly4WjbVtFjkjNI4N6qypbHQYeHKehzL2LPueqNDaE6uuQIjLriYNDVYZlHBRe+3
 53v8jshfmUCSCK57T2mornYv854gzPgxpqjdFXTRMmZBWbng8Ig6VIqlNxlU8ZrB4W+t
 ktn2K7L3LH81PdBZvEkKA0QtlI0hj7j+EsDRbW7xYsGuFvGW7ye295cjgCHHCCWKTKAF
 ORNKd+2Q1XUgUvPhov6gS097nQb4ECI7ZxDqlhO12gucmS0XRNgMyXtHmfH1TZ1tIDS6
 tdkrVL/AXMib9NoSbfvIFkhLABuoi7So5NJmp3AQLuKYTcuiH8eAXwb9Cmny8khXw63M
 cV7w==
X-Gm-Message-State: AOAM532lcGiarDxWM3tUCjPh/WoKxG/T8wk7/DpmciRj1xePmclZTLKA
 pEWamqMn7fXnkmswQxytAV3dZo4gMVmySw==
X-Google-Smtp-Source: ABdhPJyqmxnjyw5ql53tgyxYBbcNmlPhWAlfjLm7SZrRDqOvDmRTlTWmj7mIiYK7YZi2FXhxDTCLEQ==
X-Received: by 2002:a7b:cb96:: with SMTP id m22mr582720wmi.164.1589911327419; 
 Tue, 19 May 2020 11:02:07 -0700 (PDT)
Received: from localhost.localdomain
 ([2001:171b:226e:c200:c43b:ef78:d083:b355])
 by smtp.gmail.com with ESMTPSA id 1sm510496wmz.13.2020.05.19.11.02.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2020 11:02:07 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
 linux-mm@kvack.org
Subject: [PATCH v7 22/24] PCI/ATS: Add PRI stubs
Date: Tue, 19 May 2020 19:55:00 +0200
Message-Id: <20200519175502.2504091-23-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200519175502.2504091-1-jean-philippe@linaro.org>
References: <20200519175502.2504091-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Cc: fenghua.yu@intel.com, kevin.tian@intel.com, jgg@ziepe.ca,
 catalin.marinas@arm.com, robin.murphy@arm.com, hch@infradead.org,
 zhangfei.gao@linaro.org, Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Bjorn Helgaas <bhelgaas@google.com>, felix.kuehling@amd.com, will@kernel.org,
 christian.koenig@amd.com
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
 include/linux/pci-ats.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/linux/pci-ats.h b/include/linux/pci-ats.h
index f75c307f346d..e9e266df9b37 100644
--- a/include/linux/pci-ats.h
+++ b/include/linux/pci-ats.h
@@ -28,6 +28,14 @@ int pci_enable_pri(struct pci_dev *pdev, u32 reqs);
 void pci_disable_pri(struct pci_dev *pdev);
 int pci_reset_pri(struct pci_dev *pdev);
 int pci_prg_resp_pasid_required(struct pci_dev *pdev);
+#else /* CONFIG_PCI_PRI */
+static inline int pci_enable_pri(struct pci_dev *pdev, u32 reqs)
+{ return -ENODEV; }
+static inline void pci_disable_pri(struct pci_dev *pdev) { }
+static inline int pci_reset_pri(struct pci_dev *pdev)
+{ return -ENODEV; }
+static inline int pci_prg_resp_pasid_required(struct pci_dev *pdev)
+{ return 0; }
 #endif /* CONFIG_PCI_PRI */
 
 #ifdef CONFIG_PCI_PASID
-- 
2.26.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
