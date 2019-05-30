Return-Path: <SRS0=ZfVm=T6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 260F1C28CC3
	for <iommu@archiver.kernel.org>; Thu, 30 May 2019 17:12:38 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07B5E25E0E
	for <iommu@archiver.kernel.org>; Thu, 30 May 2019 17:12:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07B5E25E0E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id B3AB9250E;
	Thu, 30 May 2019 17:12:37 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 51DCC15CF;
	Thu, 30 May 2019 17:12:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.101.70])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id BE66E5F4;
	Thu, 30 May 2019 17:12:35 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4F071341;
	Thu, 30 May 2019 10:12:35 -0700 (PDT)
Received: from ostrya.cambridge.arm.com (ostrya.cambridge.arm.com
	[10.1.196.129])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 365663F5AF; 
	Thu, 30 May 2019 10:12:32 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
To: joro@8bytes.org,
	mst@redhat.com
Subject: [PATCH v8 0/7] Add virtio-iommu driver
Date: Thu, 30 May 2019 18:09:22 +0100
Message-Id: <20190530170929.19366-1-jean-philippe.brucker@arm.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Cc: mark.rutland@arm.com, virtio-dev@lists.oasis-open.org, kevin.tian@intel.com,
	tnowicki@caviumnetworks.com, frowand.list@gmail.com,
	devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
	jasowang@redhat.com, virtualization@lists.linux-foundation.org,
	iommu@lists.linux-foundation.org, robh+dt@kernel.org,
	bhelgaas@google.com, robin.murphy@arm.com, kvmarm@lists.cs.columbia.edu
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

Implement the virtio-iommu driver, following specification v0.12 [1].
Since last version [2] we've worked on improving the specification,
which resulted in the following changes to the interface:
* Remove the EXEC flag.
* Add feature bit for the MMIO flag.
* Change domain_bits to domain_range.

Given that there were small changes to patch 5/7, I removed the review
and test tags. Please find the code at [3].

[1] Virtio-iommu specification v0.12, sources and pdf
    git://linux-arm.org/virtio-iommu.git virtio-iommu/v0.12
    http://jpbrucker.net/virtio-iommu/spec/v0.12/virtio-iommu-v0.12.pdf
    http://jpbrucker.net/virtio-iommu/spec/diffs/virtio-iommu-dev-diff-v0.11-v0.12.pdf

[2] [PATCH v7 0/7] Add virtio-iommu driver
    https://lore.kernel.org/linux-pci/0ba215f5-e856-bf31-8dd9-a85710714a7a@arm.com/T/

[3] git://linux-arm.org/linux-jpb.git virtio-iommu/v0.12
    git://linux-arm.org/kvmtool-jpb.git virtio-iommu/v0.12

Jean-Philippe Brucker (7):
  dt-bindings: virtio-mmio: Add IOMMU description
  dt-bindings: virtio: Add virtio-pci-iommu node
  of: Allow the iommu-map property to omit untranslated devices
  PCI: OF: Initialize dev->fwnode appropriately
  iommu: Add virtio-iommu driver
  iommu/virtio: Add probe request
  iommu/virtio: Add event queue

 .../devicetree/bindings/virtio/iommu.txt      |   66 +
 .../devicetree/bindings/virtio/mmio.txt       |   30 +
 MAINTAINERS                                   |    7 +
 drivers/iommu/Kconfig                         |   11 +
 drivers/iommu/Makefile                        |    1 +
 drivers/iommu/virtio-iommu.c                  | 1176 +++++++++++++++++
 drivers/of/base.c                             |   10 +-
 drivers/pci/of.c                              |    6 +
 include/uapi/linux/virtio_ids.h               |    1 +
 include/uapi/linux/virtio_iommu.h             |  165 +++
 10 files changed, 1470 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/virtio/iommu.txt
 create mode 100644 drivers/iommu/virtio-iommu.c
 create mode 100644 include/uapi/linux/virtio_iommu.h

-- 
2.21.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
