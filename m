Return-Path: <SRS0=GLpr=2W=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2623FC2D0DE
	for <iommu@archiver.kernel.org>; Wed,  1 Jan 2020 05:37:05 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D80122072A
	for <iommu@archiver.kernel.org>; Wed,  1 Jan 2020 05:37:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D80122072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id AA5252FA5B;
	Wed,  1 Jan 2020 05:37:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CgExVunc1OkU; Wed,  1 Jan 2020 05:37:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id A81922F9B0;
	Wed,  1 Jan 2020 05:37:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8D93CC18DC;
	Wed,  1 Jan 2020 05:37:02 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BF794C077D
 for <iommu@lists.linux-foundation.org>; Wed,  1 Jan 2020 05:28:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id BBF30886A5
 for <iommu@lists.linux-foundation.org>; Wed,  1 Jan 2020 05:28:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id P1KAEZ2P4007 for <iommu@lists.linux-foundation.org>;
 Wed,  1 Jan 2020 05:28:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 876E0886F3
 for <iommu@lists.linux-foundation.org>; Wed,  1 Jan 2020 05:28:22 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 31 Dec 2019 21:28:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,382,1571727600"; d="scan'208";a="244319507"
Received: from allen-box.sh.intel.com ([10.239.159.136])
 by fmsmga004.fm.intel.com with ESMTP; 31 Dec 2019 21:28:19 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Bjorn Helgaas <bhelgaas@google.com>
Subject: [RFC PATCH 0/4] iommu: Per-group default domain type
Date: Wed,  1 Jan 2020 13:26:44 +0800
Message-Id: <20200101052648.14295-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Cc: kevin.tian@intel.com, ashok.raj@intel.com, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, jacob.jun.pan@intel.com,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

An IOMMU group represents the smallest set of devices that are considered
to be isolated. All devices belonging to an IOMMU group share a default
domain for DMA APIs. There are two types of default domain: IOMMU_DOMAIN_DMA
and IOMMU_DOMAIN_IDENTITY. The former means IOMMU translation, while the
latter means IOMMU by-pass.

Currently, the default domain type for the IOMMU groups is determined
globally. All IOMMU groups use a single default domain type. The global
default domain type can be adjusted by kernel build configuration or
kernel parameters.

More and more users are looking forward to a fine grained default domain
type. For example, with the global default domain type set to translation,
the OEM verndors or end users might want some trusted and fast-speed devices
to bypass IOMMU for performance gains. On the other hand, with global
default domain type set to by-pass, some devices with limited system
memory addressing capability might want IOMMU translation to remove the
bounce buffer overhead.

This series proposes per-group default domain type to meet these demands.
It adds a per-device iommu_passthrough attribute. By setting this
attribute, end users or device vendors are able to tell the IOMMU subsystem
that this device is willing to use a default domain of IOMMU_DOMAIN_IDENTITY.
The IOMMU device probe procedure is reformed to pre-allocate groups for
all devices on a specific bus before adding the devices into the groups.
This enables the IOMMU device probe precedure to determine a per-group
default domain type before allocating IOMMU domains and attaching them
to devices.

Please help to review it. Your comments and suggestions are appricated.

Best regards,
baolu 

Lu Baolu (4):
  driver core: Add iommu_passthrough to struct device
  PCI: Add "pci=iommu_passthrough=" parameter for iommu passthrough
  iommu: Preallocate iommu group when probing devices
  iommu: Determine default domain type before allocating domain

 .../admin-guide/kernel-parameters.txt         |   5 +
 drivers/iommu/iommu.c                         | 127 ++++++++++++++----
 drivers/pci/pci.c                             |  34 +++++
 drivers/pci/pci.h                             |   1 +
 drivers/pci/probe.c                           |   2 +
 include/linux/device.h                        |   3 +
 6 files changed, 143 insertions(+), 29 deletions(-)

-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
