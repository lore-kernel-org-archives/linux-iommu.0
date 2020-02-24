Return-Path: <SRS0=ms/0=4M=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13B64C38C08
	for <iommu@archiver.kernel.org>; Mon, 24 Feb 2020 18:25:01 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE26C20838
	for <iommu@archiver.kernel.org>; Mon, 24 Feb 2020 18:25:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OnFOZtrZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE26C20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id D4AB485DCF;
	Mon, 24 Feb 2020 18:25:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pcmxSPMYOcta; Mon, 24 Feb 2020 18:25:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 7B78A85F98;
	Mon, 24 Feb 2020 18:25:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 691B6C18DA;
	Mon, 24 Feb 2020 18:25:00 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AAE64C0177
 for <iommu@lists.linux-foundation.org>; Mon, 24 Feb 2020 18:24:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id A575684AE1
 for <iommu@lists.linux-foundation.org>; Mon, 24 Feb 2020 18:24:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ce6w72waGt0X for <iommu@lists.linux-foundation.org>;
 Mon, 24 Feb 2020 18:24:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com
 [209.85.221.65])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 00FF285F7E
 for <iommu@lists.linux-foundation.org>; Mon, 24 Feb 2020 18:24:57 +0000 (UTC)
Received: by mail-wr1-f65.google.com with SMTP id y17so2769602wrn.6
 for <iommu@lists.linux-foundation.org>; Mon, 24 Feb 2020 10:24:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=oVPY2SNV/SUayab6VGyitFWrI9RILHKqjSrcDOg3sBg=;
 b=OnFOZtrZEFufL7rTBOmlZ40Hq224mutQ/5o0VAFHjr/9ZW5PBMJ0Y7/GDS3/xR/dnD
 TEsPyQ+iLNysIg1dKsUqwcdOSjQuqzH7iLV5knh5wCpz5/PmbdVT8KcjMEYbg24is9zH
 t6ACUI7hhk9FGQPHZTGMTb2NY4PcnI9R5MLG1z3wtZTl3ODyonISTbNRfmBpEMohHa92
 CKN1L7n6QuxpTjQJxuOJ4Ho23RxS2Njg7SP7AcfdcAfbOXg6vAiEfIa4WG7H9/SStdt+
 Gm1dU1ozzhGu8153BnWCyrRxnsfeTzwGIutPWQZPh3v8U2NHd1wgZo4SDlNKF9ic1rWv
 Y4DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=oVPY2SNV/SUayab6VGyitFWrI9RILHKqjSrcDOg3sBg=;
 b=G4P5PkzGrM4p4fiXaW6e+v4KFFolW5YMRjCgE3SwgHLHc3vLVU8WOAFrB1myv7hUg/
 6iqM8M5OJFo6qGrU85UhDmjh3yFD9j7i8TRcEaHUwyoTzOjiek7bYQEA11G67bMfsPKl
 nNxjDI/hlpXGqfLslCT6hN4ilLaNaUuY0dx46qR46k79Vgag/B8zFR/M0pEJ1uOY3hq0
 rCHUweLgdIHpyeCegTlHlJwNjOWN7aJMxQldKxOOUDw39Yb5uC8JjHOU8EJHNJag4Oh+
 xeI7DTicTclb43iF7TDqNtJmnKTHLNHN7PDruvFBZEhbO6e9+5XhjmDRO54axZNeap+D
 E+1Q==
X-Gm-Message-State: APjAAAVWEo6PBinfXuNhEtUUihJpuWk1CtLmJR2XgfzfZNM9zr6VsylG
 DZNsEySgbWpeQNsSNdCWzovOpswOAcE=
X-Google-Smtp-Source: APXvYqxjjLnHOC5PFDeOpyj527vO7u0PGvC49hWOgOh7ytPa88sYjcO6Bg19gqIDQUy51J2OFlu0Ew==
X-Received: by 2002:a5d:4c52:: with SMTP id n18mr2796517wrt.403.1582568696322; 
 Mon, 24 Feb 2020 10:24:56 -0800 (PST)
Received: from localhost.localdomain
 ([2001:171b:c9a8:fbc0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id n3sm304255wmc.27.2020.02.24.10.24.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2020 10:24:55 -0800 (PST)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
 linux-mm@kvack.org
Subject: [PATCH v4 24/26] PCI/ATS: Add PRI stubs
Date: Mon, 24 Feb 2020 19:23:59 +0100
Message-Id: <20200224182401.353359-25-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200224182401.353359-1-jean-philippe@linaro.org>
References: <20200224182401.353359-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Cc: mark.rutland@arm.com, kevin.tian@intel.com, catalin.marinas@arm.com,
 robin.murphy@arm.com, robh+dt@kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 zhangfei.gao@linaro.org, will@kernel.org, christian.koenig@amd.com
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

Cc: Bjorn Helgaas <bhelgaas@google.com>
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
2.25.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
