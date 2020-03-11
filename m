Return-Path: <SRS0=4Gp4=44=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 990A8C3F2D0
	for <iommu@archiver.kernel.org>; Wed, 11 Mar 2020 12:47:00 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AB05208E4
	for <iommu@archiver.kernel.org>; Wed, 11 Mar 2020 12:47:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FXsN33Jo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AB05208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 1436522610;
	Wed, 11 Mar 2020 12:47:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cfF+fAByqflR; Wed, 11 Mar 2020 12:46:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id EBE5C22264;
	Wed, 11 Mar 2020 12:46:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D1882C18D3;
	Wed, 11 Mar 2020 12:46:58 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 37457C0177
 for <iommu@lists.linux-foundation.org>; Wed, 11 Mar 2020 12:46:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 30C4087592
 for <iommu@lists.linux-foundation.org>; Wed, 11 Mar 2020 12:46:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uVNysPsFEFQi for <iommu@lists.linux-foundation.org>;
 Wed, 11 Mar 2020 12:46:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com
 [209.85.221.66])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 13D738758B
 for <iommu@lists.linux-foundation.org>; Wed, 11 Mar 2020 12:46:56 +0000 (UTC)
Received: by mail-wr1-f66.google.com with SMTP id v11so2423218wrm.9
 for <iommu@lists.linux-foundation.org>; Wed, 11 Mar 2020 05:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=9aHr7/EWopa+d5MVT7UWPgRiU9Syfo6iTheTFisLSBg=;
 b=FXsN33JoJealTXC3dRRue6HkzhWSIRjvlNRUP49llb/Tp1/P6LLbWK2WENByBzb932
 Vi1Fg8Ri+qgxJrwy5zjp/NXrbWtEhuMkRTQj1X4R9I44S53W3vZuVYp8IrCbYVblbQ3t
 O28JXtBnjgkZqXtJcIVINkr/xuwcmJ4AcO+2ctUVBEJKMuSZEV7wYUoSaD3Zco3ZO7q/
 ujjg+wfK4m1DiebSFJn9cbZqflg/q7DAWj/98GahfRpw7xqn470ERyL3IPCqRQQaQIB0
 0zSlrkdrriSBVsPOQ4i+h5gPOwW+U83Jz9SjjpEDyMiKdpx/YTRM4O6K6sHqODrD7YCC
 shxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=9aHr7/EWopa+d5MVT7UWPgRiU9Syfo6iTheTFisLSBg=;
 b=P2DpjkjXM0p1/pbTG1pAF4xG7sEeWW4QgYaBK+vN3wtJD6jvYM8G/A8LWKpFeTDJVa
 jMC9cC5ewVigfQbc5Hmm+oJrsuD9J+zSBneX6hYiFoSjLSKYypdaTDJtXl4/m7P/jxdK
 2dQSwyAzymjZKCSHUyFMI6KUfWm09fr1KlGdayzQMv3qdsPglWhmNzcMp7L0EAmxoztC
 95MJk1G2G4PGTvsOZkmnPKm/JaD6sYh8Se07gnVSJbSkxYd/c46LLDMwfNCAhWFE6Z51
 rnmNVJirY97kLN+wxB3MsNHGC5a66gsk4ndXnGYPY+N+Ma8F9HR6/j75clw4+IPHaj3b
 oXjw==
X-Gm-Message-State: ANhLgQ3qg6qifTv9bF0WzhAiCKmWOG7jYVmRT54S2xnE7eMkorHGMnn3
 swb3JV2+hfkQXNmnYiifzHFG8w==
X-Google-Smtp-Source: ADFU+vvLjmlfZFee1kgQb0ezvJQIIb3y7DZjOUpYxqDYvVtYVhI9wjUkV+NDFpgxKBOntX41muaOsw==
X-Received: by 2002:adf:bb81:: with SMTP id q1mr4344011wrg.110.1583930814354; 
 Wed, 11 Mar 2020 05:46:54 -0700 (PDT)
Received: from localhost.localdomain
 ([2001:171b:c9a8:fbc0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id c2sm8380020wma.39.2020.03.11.05.46.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Mar 2020 05:46:53 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: bhelgaas@google.com, will@kernel.org, robh+dt@kernel.org, joro@8bytes.org,
 baolu.lu@linux.intel.com, sudeep.holla@arm.com, linux-doc@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-acpi@vger.kernel.org,
 iommu@lists.linux-foundation.org
Subject: [PATCH v2 00/11] PCI/ATS: Device-tree support and other improvements
Date: Wed, 11 Mar 2020 13:44:55 +0100
Message-Id: <20200311124506.208376-1-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.25.1
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

Enable ATS on device-tree based systems, and factor the common ATS
enablement checks into pci_enable_ats().

Since v1 [1] I added acks and review tags, simplified patch 3 and tried
to clarify the comment in patch 2.

I'd like acks or comments on the following patches:
* PCI on patches 2, 3 and 5
* Arm SMMUv3 on patch 7
* Intel VT-d on patch 8
* arm64 DT on patch 10 

Thanks,
Jean

[1] https://lore.kernel.org/linux-iommu/20200213165049.508908-1-jean-philippe@linaro.org/

Jean-Philippe Brucker (11):
  dt-bindings: PCI: generic: Add ats-supported property
  PCI: Add ats_supported host bridge flag
  PCI: OF: Check whether the host bridge supports ATS
  ACPI/IORT: Check ATS capability in root complex node
  PCI/ATS: Gather checks into pci_ats_supported()
  iommu/amd: Use pci_ats_supported()
  iommu/arm-smmu-v3: Use pci_ats_supported()
  iommu/vt-d: Use pci_ats_supported()
  ACPI/IORT: Drop ATS fwspec flag
  arm64: dts: fast models: Enable PCIe ATS for Base RevC FVP
  Documentation: Generalize the "pci=noats" boot parameter

 .../admin-guide/kernel-parameters.txt         |  4 +-
 .../bindings/pci/host-generic-pci.yaml        |  6 +++
 arch/arm64/boot/dts/arm/fvp-base-revc.dts     |  1 +
 drivers/acpi/arm64/iort.c                     | 38 +++++++++++++------
 drivers/acpi/pci_root.c                       |  3 ++
 drivers/iommu/amd_iommu.c                     | 12 ++----
 drivers/iommu/arm-smmu-v3.c                   | 18 ++-------
 drivers/iommu/intel-iommu.c                   |  9 ++---
 drivers/pci/ats.c                             | 30 ++++++++++++++-
 drivers/pci/controller/pci-host-common.c      | 11 ++++++
 drivers/pci/probe.c                           |  8 ++++
 include/linux/acpi_iort.h                     |  8 ++++
 include/linux/iommu.h                         |  4 --
 include/linux/pci-ats.h                       |  3 ++
 include/linux/pci.h                           |  1 +
 15 files changed, 109 insertions(+), 47 deletions(-)

-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
