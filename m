Return-Path: <SRS0=2i4G=ES=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8779C61DD8
	for <iommu@archiver.kernel.org>; Thu, 12 Nov 2020 13:03:25 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C19422250
	for <iommu@archiver.kernel.org>; Thu, 12 Nov 2020 13:03:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UphNYMQS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C19422250
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 418CC86F0C;
	Thu, 12 Nov 2020 13:03:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Gor8FozYkJDe; Thu, 12 Nov 2020 13:03:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 0732886DF7;
	Thu, 12 Nov 2020 13:03:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C6AD2C0889;
	Thu, 12 Nov 2020 13:03:21 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3288BC016F
 for <iommu@lists.linux-foundation.org>; Thu, 12 Nov 2020 13:03:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 17DF48777C
 for <iommu@lists.linux-foundation.org>; Thu, 12 Nov 2020 13:03:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rib3DKmDPPuJ for <iommu@lists.linux-foundation.org>;
 Thu, 12 Nov 2020 13:03:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com
 [209.85.221.66])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 8A98F876BD
 for <iommu@lists.linux-foundation.org>; Thu, 12 Nov 2020 13:03:15 +0000 (UTC)
Received: by mail-wr1-f66.google.com with SMTP id b6so5921300wrt.4
 for <iommu@lists.linux-foundation.org>; Thu, 12 Nov 2020 05:03:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=XoAG1pru+t0E0RGbZFAgVVNe78IlOrfO4ZdEb2/m39k=;
 b=UphNYMQS/LN28Yxb1McSQM05xn0X1V0x7rJ0PnNKfQvzO7zSoSBhZ9CLBwJKzAgh16
 17BMyTB6gytjqNUMMUrH82FFJY2PEIruw0bKT5P4mlmuWOAislyFW6xOumTDMAcADDJ/
 3I+1KO/GAtkaunGBQ3cAe+TPQ8lRQuZK1Uk3iHPKADw+iRsHWUINdXk0j0p0aLmHWSQD
 Lar/biWGCcmxYMOxn5/aO0uFOlgWdelEDWUgUAG103fCjfzlpWK4j4svUJKEmpdBgdzE
 qnbdv6qFgKnizUAGgssYpzF9v1UwcuGMLi2IRXc/YY0k9b1cqi77VreSmTVMP/3andg7
 tthQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=XoAG1pru+t0E0RGbZFAgVVNe78IlOrfO4ZdEb2/m39k=;
 b=A2p6Db17AcxG7kTsUG9hygqVLcXODtvqtQAgrpJWnwQPhYMKTUzSI2gtBqyVOAfqhF
 ssPFDEfGvAg7TWtQ78arTyvf2RnmbvmxSQCaXCQf68fBLP9m/XOLdN8oidYK/kA1u2/G
 cvBcvSWWEaZOTU+b5H1S0t8A/JtZFfZ2LvAJul7QIEHksK8x762urlaSnAx+k5hS2u+S
 LOTa91DMx0elFWve3eQHc5YPCCvmP+34GEcG3ErXoqqVUdBfqguGhjm9BAMoZpWEqRmj
 El3xdlnPTULlTeiNo+WlS9vV3Y+6W5pEIm3uFJHPLrL/GRBu61YwfzuUpW/opWMoKhKx
 PApQ==
X-Gm-Message-State: AOAM53068ah0AcWn+nys7Y6inYJB44cCGgO1/vEU2rtiVwPe1T5TT15h
 7v7JEff+yYCQcC8zidD3qZ3Ydg==
X-Google-Smtp-Source: ABdhPJxMBUohVh2fAAvMFdY17a6lP3nz140iaaxKiNjcDkvE3A2fsz0yM/aFafAdvuPkFa1NZKXESQ==
X-Received: by 2002:adf:ce87:: with SMTP id r7mr4434152wrn.212.1605186194089; 
 Thu, 12 Nov 2020 05:03:14 -0800 (PST)
Received: from localhost.localdomain
 ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id m22sm6877508wrb.97.2020.11.12.05.03.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2020 05:03:13 -0800 (PST)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: joro@8bytes.org, will@kernel.org, lorenzo.pieralisi@arm.com,
 robh+dt@kernel.org
Subject: [PATCH v8 0/9] iommu: I/O page faults for SMMUv3
Date: Thu, 12 Nov 2020 13:55:12 +0100
Message-Id: <20201112125519.3987595-1-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.29.1
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

Add support for stall and PRI to the SMMUv3 driver, along with a common
I/O Page Fault handler.

These patches were last sent as part of v7 of the larger SVA series [1].
Main changes since v7:
* Dropped CONFIG_IOMMU_PAGE_FAULT, reuse CONFIG_IOMMU_SVA_LIB instead.
* Extracted devicetree support into patch 4.
* Added patch 5 for ACPI support.
* Dropped event queue flush on unbind(). Since device drivers must
  complete DMA transactions before calling unbind(), there cannot be any
  pending stalled event.
* A few small fixes.

The series depends on "iommu/sva: Add PASID helpers" [2], since it
provides the function to search an mm_struct by PASID.

Has anyone been testing the PRI patches on hardware? I still only have a
software model to test them, so as much as I'd like to cross this off my
list, we could leave out patches 7-9 for now.

[1] https://lore.kernel.org/linux-iommu/20200519175502.2504091-1-jean-philippe@linaro.org/
[2] https://lore.kernel.org/linux-iommu/20201106155048.997886-1-jean-philippe@linaro.org/

Jean-Philippe Brucker (9):
  iommu: Add a page fault handler
  iommu/arm-smmu-v3: Maintain a SID->device structure
  dt-bindings: document stall property for IOMMU masters
  of/iommu: Support dma-can-stall property
  ACPI/IORT: Enable stall support for platform devices
  iommu/arm-smmu-v3: Add stall support for platform devices
  PCI/ATS: Add PRI stubs
  PCI/ATS: Export PRI functions
  iommu/arm-smmu-v3: Add support for PRI

 drivers/iommu/Makefile                        |   1 +
 .../devicetree/bindings/iommu/iommu.txt       |  18 +
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  69 +-
 drivers/iommu/iommu-sva-lib.h                 |  53 ++
 include/linux/iommu.h                         |   4 +
 include/linux/pci-ats.h                       |   7 +
 drivers/acpi/arm64/iort.c                     |   1 +
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   |  52 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 605 +++++++++++++++---
 drivers/iommu/io-pgfault.c                    | 462 +++++++++++++
 drivers/iommu/of_iommu.c                      |   5 +-
 drivers/pci/ats.c                             |   4 +
 12 files changed, 1191 insertions(+), 90 deletions(-)
 create mode 100644 drivers/iommu/io-pgfault.c

-- 
2.29.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
