Return-Path: <SRS0=ZJ+1=4B=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05CBDC3B193
	for <iommu@archiver.kernel.org>; Thu, 13 Feb 2020 16:52:11 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC1D424670
	for <iommu@archiver.kernel.org>; Thu, 13 Feb 2020 16:52:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sq5RPbQM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC1D424670
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id AE63C2151F;
	Thu, 13 Feb 2020 16:52:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GBVsTAI2X-o3; Thu, 13 Feb 2020 16:52:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id B86E5214D2;
	Thu, 13 Feb 2020 16:52:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B1AFDC07FE;
	Thu, 13 Feb 2020 16:52:08 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AD91DC0177
 for <iommu@lists.linux-foundation.org>; Thu, 13 Feb 2020 16:52:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 9C87987F84
 for <iommu@lists.linux-foundation.org>; Thu, 13 Feb 2020 16:52:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6DIu2kGweDkr for <iommu@lists.linux-foundation.org>;
 Thu, 13 Feb 2020 16:52:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com
 [209.85.221.67])
 by hemlock.osuosl.org (Postfix) with ESMTPS id A73EC87E53
 for <iommu@lists.linux-foundation.org>; Thu, 13 Feb 2020 16:52:05 +0000 (UTC)
Received: by mail-wr1-f67.google.com with SMTP id m16so7526740wrx.11
 for <iommu@lists.linux-foundation.org>; Thu, 13 Feb 2020 08:52:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=CfKpna/gHZrKywpyhlfYfrWp7SfpssT14AH9fDnyBhc=;
 b=sq5RPbQMnHdJFKyr0y4rdobfNVfPyioZd4bFmy17jTSnzdOsxyVQCBIzt+dwmj/1hS
 0FEIxdf3kxtor+WLr7kL9Y0vlCfHOur0aEBvo57AoXZfAVKNJX7nVRcpo3gPgBs0J121
 JdAYwRCxxQKun+l1koHxbdXN/njOydBSX0j+Mi2OvJHKT8u6PsEqveyKsSTTNLqATYin
 v3DQfP7nvrGGDS8aYK53MnSe/mxwZRXMScAGeoYNzL/tpe2Xv0I8BGXkzvgDYJ0/HQDv
 JQh2RDF9ivk+TTFAdaGiOzE2CWJp7ONbWUXJKbxdagRIWbTJQpBvhyu2B2bQXibL99eT
 R2rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=CfKpna/gHZrKywpyhlfYfrWp7SfpssT14AH9fDnyBhc=;
 b=VVPjN7QrcMKo+SnFJWxn14RjDuM+bfdmP5/I6IrVpwWYnYMamRRgYfxlcz2PNsauKY
 tmvTCNSZVIhPvGaIPN30KNE9zcjoNkXpUdp6WvqDqkMTPCovDJ99eIRzfaJp/V5VACcp
 yMs+9r0ejBTKr34a1+cAnfiGewB4xSzoOM2mUqQWMMnXqW0Kdf1hHQ7HTVpqok1+cDuI
 YZ27IHndFfN/q3goJbnGGQ2r0CKNzSTJyU5WPKkYeqUlAn/+yNRc33OTlg7TkYnmnTh5
 QTG1MQ+DuFmvKAhA3WV8GPeXYtPDfFkGhV7gscHlSyhXOWqqoaCAO77ANQNKbZWgWKnk
 WZsA==
X-Gm-Message-State: APjAAAVpzIxO8YC2Udi/gkQU1pNHziQqIStDgum9KChYuRbiy0/Az/BL
 sLuiVdibar1WDyzMsKRr+8XXwA==
X-Google-Smtp-Source: APXvYqy3NlA5gvY/i2LUQjbrj98NidF1+ZAccFnC7XtPBVcGfForOTuhwxmW4gsDRqMB842f8yYE+Q==
X-Received: by 2002:a5d:54c1:: with SMTP id x1mr21837119wrv.240.1581612723942; 
 Thu, 13 Feb 2020 08:52:03 -0800 (PST)
Received: from localhost.localdomain ([2001:171b:2276:930:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id y6sm3484807wrl.17.2020.02.13.08.52.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2020 08:52:03 -0800 (PST)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: bhelgaas@google.com, will@kernel.org, robh+dt@kernel.org,
 lorenzo.pieralisi@arm.com, joro@8bytes.org, baolu.lu@linux.intel.com,
 linux-doc@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-acpi@vger.kernel.org, iommu@lists.linux-foundation.org
Subject: [PATCH 00/10] PCI/ATS: Device-tree support and other improvements
Date: Thu, 13 Feb 2020 17:50:38 +0100
Message-Id: <20200213165049.508908-1-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.25.0
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

Enable ATS on device-tree based systems, and factor the common ATS
enablement checks into pci_enable_ats().

ATS support in PCIe endpoints is discovered through the ATS capability,
but there is no common method for discovering whether the host bridge
supports ATS. Each vendor provides their own ACPI method:
* DMAR (Intel) reports ATS support per domain or per root port.
* IVRS (AMD) reports negative ATS support for a range of devices.
* IORT (ARM) reports ATS support for a root complex.

In my opinion it's important that we only enable ATS if the host bridge
supports it, but I don't think a finer granularity is useful. If the
host bridge ignores the Address Translation field of TLP headers, it
could in theory treat a Translation Request as a Memory Read Request,
and a Translated Request as a normal memory access, which could result
in silent memory corruption.

Patches 1-3 add a device-tree property that declares ATS support in host
controllers. We only add it to the generic host, but the property can
easily be reused by other PCI hosts. Alternatively, the host drivers can
directly set the new ats_supported property of the host bridge
introduced in patch 1.

Patch 4 uses the new ats_supported host bridge property for IORT. Patch
9 removes the old method that set a flag in each endpoint's fwspec.

Patches 5-8 put all checks required for enabling ATS in common, along
with the new host bridge check.

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
 drivers/pci/controller/pci-host-common.c      |  1 +
 drivers/pci/of.c                              |  9 +++++
 drivers/pci/probe.c                           |  7 ++++
 include/linux/acpi_iort.h                     |  8 ++++
 include/linux/iommu.h                         |  4 --
 include/linux/of_pci.h                        |  3 ++
 include/linux/pci-ats.h                       |  3 ++
 include/linux/pci.h                           |  1 +
 17 files changed, 110 insertions(+), 47 deletions(-)

-- 
2.25.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
