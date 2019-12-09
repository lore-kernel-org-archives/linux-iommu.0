Return-Path: <SRS0=4RPJ=Z7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D3BBC00454
	for <iommu@archiver.kernel.org>; Mon,  9 Dec 2019 18:12:02 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1545021556
	for <iommu@archiver.kernel.org>; Mon,  9 Dec 2019 18:12:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eChG24Hv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1545021556
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 8F0DF877D0;
	Mon,  9 Dec 2019 18:12:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EPzO9WsDB90Q; Mon,  9 Dec 2019 18:12:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 41B2F877A7;
	Mon,  9 Dec 2019 18:12:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2AB1FC1D7F;
	Mon,  9 Dec 2019 18:12:00 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B32C4C0881
 for <iommu@lists.linux-foundation.org>; Mon,  9 Dec 2019 18:11:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id AEB6187C41
 for <iommu@lists.linux-foundation.org>; Mon,  9 Dec 2019 18:11:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1zcVrxg6ANIU for <iommu@lists.linux-foundation.org>;
 Mon,  9 Dec 2019 18:11:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com
 [209.85.221.66])
 by hemlock.osuosl.org (Postfix) with ESMTPS id B387887C20
 for <iommu@lists.linux-foundation.org>; Mon,  9 Dec 2019 18:11:57 +0000 (UTC)
Received: by mail-wr1-f66.google.com with SMTP id z7so17177197wrl.13
 for <iommu@lists.linux-foundation.org>; Mon, 09 Dec 2019 10:11:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=EPZYuKzuHS01ypbpAypAPWL2i1nnzUw0mtei/SOU8FI=;
 b=eChG24HveCLJr1w7htcnEaSdvHwWYy3dopCe7PzKjFIohfKepun/JzeHDOVtJdhFBX
 krj9dCfZna5uDRah00TO6hMrC5CxJ839KjvhzTUWqxzJ0nzCKaHhF508qHSSy0GZtoSx
 KJKhRNuYym1oZf7HWKmhQjbPY2WwKkqcLV/aEZnMdOGhN7+MIwQiCiCZ6KKFGROEzZxL
 Htj1QWdRJqh6WeQx5GUmgHJil8TmhNhDhDAyvl7+sHEzB6M95GtfmZ/PLcNOaeZEdyGj
 IBWYXgi+wPjUJZNb7Xjum2/nBvekCA934r8JznZDGI55yX51UEARM1sRTsF7H8bRaJoC
 7XyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=EPZYuKzuHS01ypbpAypAPWL2i1nnzUw0mtei/SOU8FI=;
 b=gCoTWXUx5fkmDmsrw0mZHRZcmX5RYPq9z0Nrfg9IQiUdwlf1fAXdoIdjgq5iLj/Aen
 stoMknkn1pyh/rFDjHR55Yh3i7XOhUzTDw1fdPltOx1JG2YvBs3d2QEkSP/m2gUPY1uL
 Oy/c5GtOUn1uW34r3laA24Ew4ygofXcS7Zc8l/UflQO4P6734ZcIawQtH7z82/cQOlwx
 yx6adMmJnzSd49jK4z/958G+nwD9+4pBHqSrEKlmD3LuC/fRWqOBvVNVZ1lTlPGYD0I5
 tqYF5f/RMtuJE18au9rdKoCXIRwXHsBO7d2VaJHFYIHQY9bE6U11snZrqqBJ39dJ+PoA
 eG9w==
X-Gm-Message-State: APjAAAWP4Qxdn9QqNTN5gESXOdDf7jY4sTW4oxOusghDaltmO1RrVYpY
 FTB28LhygD3H9hFJdaZ/4+igEw==
X-Google-Smtp-Source: APXvYqzT1ymN3phudM5XMKZ/AIHs5aojcXL1B8J2G48oy5R7vLLmgXJx0GUEWH2l1syk1oV2bTStlA==
X-Received: by 2002:a5d:5704:: with SMTP id a4mr3593884wrv.198.1575915116081; 
 Mon, 09 Dec 2019 10:11:56 -0800 (PST)
Received: from localhost.localdomain (adsl-62-167-101-88.adslplus.ch.
 [62.167.101.88])
 by smtp.gmail.com with ESMTPSA id h2sm309838wrv.66.2019.12.09.10.11.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Dec 2019 10:11:55 -0800 (PST)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
 iommu@lists.linux-foundation.org
Subject: [PATCH v3 00/13] iommu: Add PASID support to Arm SMMUv3
Date: Mon,  9 Dec 2019 19:05:01 +0100
Message-Id: <20191209180514.272727-1-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.24.0
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

Add support for Substream ID and PASIDs to the SMMUv3 driver.
Changes since v2 [1]:

* Split preparatory work into patches 5, 6, 8 and 9.

* Added patch 1. Not strictly relevant, but since we're moving the DMA
  allocations and adding a new one, we might as well clean the flags
  first.

* Fixed a double free reported by Jonathan, and other small
  issues.

* Added patch 12. Upstream commit c6e9aefbf9db ("PCI/ATS: Remove unused
  PRI and PASID stubs") removed the unused PASID stubs. Since the SMMU
  driver can be built without PCI, the stubs are now needed.

[1] https://lore.kernel.org/linux-iommu/20191108152508.4039168-1-jean-philippe@linaro.org/

Jean-Philippe Brucker (13):
  iommu/arm-smmu-v3: Drop __GFP_ZERO flag from DMA allocation
  dt-bindings: document PASID property for IOMMU masters
  iommu/arm-smmu-v3: Support platform SSID
  ACPI/IORT: Support PASID for platform devices
  iommu/arm-smmu-v3: Prepare arm_smmu_s1_cfg for SSID support
  iommu/arm-smmu-v3: Add context descriptor tables allocators
  iommu/arm-smmu-v3: Add support for Substream IDs
  iommu/arm-smmu-v3: Propate ssid_bits
  iommu/arm-smmu-v3: Handle failure of arm_smmu_write_ctx_desc()
  iommu/arm-smmu-v3: Add second level of context descriptor table
  iommu/arm-smmu-v3: Improve add_device() error handling
  PCI/ATS: Add PASID stubs
  iommu/arm-smmu-v3: Add support for PCI PASID

 .../devicetree/bindings/iommu/iommu.txt       |   6 +
 drivers/acpi/arm64/iort.c                     |  18 +
 drivers/iommu/arm-smmu-v3.c                   | 462 +++++++++++++++---
 drivers/iommu/of_iommu.c                      |   6 +-
 include/linux/iommu.h                         |   2 +
 include/linux/pci-ats.h                       |   3 +
 6 files changed, 437 insertions(+), 60 deletions(-)

-- 
2.24.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
