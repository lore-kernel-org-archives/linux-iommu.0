Return-Path: <SRS0=zl4V=TD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A7C5C43219
	for <iommu@archiver.kernel.org>; Fri,  3 May 2019 14:07:04 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B8242087F
	for <iommu@archiver.kernel.org>; Fri,  3 May 2019 14:07:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="XGauRLD7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B8242087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id D7B523852;
	Fri,  3 May 2019 14:07:03 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id A0FFB3962
	for <iommu@lists.linux-foundation.org>;
	Fri,  3 May 2019 14:05:57 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com
	[209.85.208.66])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id C9F5D79
	for <iommu@lists.linux-foundation.org>;
	Fri,  3 May 2019 14:05:54 +0000 (UTC)
Received: by mail-ed1-f66.google.com with SMTP id w33so3811861edb.10
	for <iommu@lists.linux-foundation.org>;
	Fri, 03 May 2019 07:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
	h=from:to:cc:subject:date:message-id;
	bh=aSsQUXFyMzhd3pF3o0br4GImJGSsL3GlveRwHz9b304=;
	b=XGauRLD7je12LIZeipZdHxet383aKHam8Uhf20D3C35uie66+ON4yoVOBUAHb0kvYg
	ZMfqOIZgd/3FltlG9+MpXPWJMneXgFV0VkLGix9soq6yseinjMnyou90w8geicAnioT3
	G8FzZM5uogBdyWA85z8X1BFuCuwbpHWls5O70=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=aSsQUXFyMzhd3pF3o0br4GImJGSsL3GlveRwHz9b304=;
	b=Mk8daeCBlvR8ID49yeYYMG6Tl+ja5TH+ORv6WZ+/i+b5BfTmNq/JULUrr8tw3Vrc31
	oQ8kqE/+X5CPWnHJD8HN6kJiJZFG5BZn9fONvKILDDqgGG3w7SyMUczZJlJqDvksaw/K
	vGZ5QkSJVEfxkRTgIla0AkEQbj7u36Z0WoeDIjQVZ09lNTjIHjbAe9igI2EZYpz4IF3o
	BcrTKkFmnW3Y86yBZ72H3TQ1GcuN/t9lPDzFaVksidN7Rwd2Y8ufCywahfRrtlfsmWjN
	205Hp7dGnfWStA2C0drCZarHaXDXetBgLQz5IEnhnTK9Mb/rJ+px1C6uz3//ReKbS+8g
	8yFw==
X-Gm-Message-State: APjAAAX4+aIdoopKgldEIsynp3wSvqSI8Ie1R2RKFrQyrIlckOXRVj1Q
	DdlrNp28NR/To1W7iA6xdYPOdg==
X-Google-Smtp-Source: APXvYqys1pc2WFq9pcZ+VYTFcRlepbG+istVel36Sx0zs1npV/SpDnsDpQV65SePP6q7OCX1GtSS+g==
X-Received: by 2002:a17:906:1e0f:: with SMTP id
	g15mr6369446ejj.241.1556892353345; 
	Fri, 03 May 2019 07:05:53 -0700 (PDT)
Received: from mannams-OptiPlex-7010.dhcp.broadcom.net ([192.19.234.250])
	by smtp.gmail.com with ESMTPSA id s53sm605472edb.20.2019.05.03.07.05.46
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Fri, 03 May 2019 07:05:51 -0700 (PDT)
To: Bjorn Helgaas <bhelgaas@google.com>, Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Eric Auger <eric.auger@redhat.com>, poza@codeaurora.org,
	Ray Jui <rjui@broadcom.com>
Subject: [PATCH v6 0/3] PCIe Host request to reserve IOVA
Date: Fri,  3 May 2019 19:35:31 +0530
Message-Id: <1556892334-16270-1-git-send-email-srinath.mannam@broadcom.com>
X-Mailer: git-send-email 2.7.4
Cc: linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org,
	Srinath Mannam <srinath.mannam@broadcom.com>,
	bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org
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
From: Srinath Mannam via iommu <iommu@lists.linux-foundation.org>
Reply-To: Srinath Mannam <srinath.mannam@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

This patch set will reserve IOVA addresses for DMA memory holes.

The IPROC host controller allows only a few ranges of physical address
as inbound PCI addresses which are listed through dma-ranges DT property.
Added dma_ranges list field of PCI host bridge structure to hold these
allowed inbound address ranges in sorted order.

Process this list and reserve IOVA addresses that are not present in its
resource entries (ie DMA memory holes) to prevent allocating IOVA
addresses that cannot be allocated as inbound addresses.

This patch set is based on Linux-5.1-rc3.

Changes from v5:
  - Addressed Robin Murphy, Lorenzo review comments.
    - Error handling in dma ranges list processing.
    - Used commit messages given by Lorenzo to all patches.

Changes from v4:
  - Addressed Bjorn, Robin Murphy and Auger Eric review comments.
    - Commit message modification.
    - Change DMA_BIT_MASK to "~(dma_addr_t)0".

Changes from v3:
  - Addressed Robin Murphy review comments.
    - pcie-iproc: parse dma-ranges and make sorted resource list.
    - dma-iommu: process list and reserve gaps between entries

Changes from v2:
  - Patch set rebased to Linux-5.0-rc2

Changes from v1:
  - Addressed Oza review comments.

Srinath Mannam (3):
  PCI: Add dma_ranges window list
  iommu/dma: Reserve IOVA for PCIe inaccessible DMA address
  PCI: iproc: Add sorted dma ranges resource entries to host bridge

 drivers/iommu/dma-iommu.c           | 35 ++++++++++++++++++++++++++---
 drivers/pci/controller/pcie-iproc.c | 44 ++++++++++++++++++++++++++++++++++++-
 drivers/pci/probe.c                 |  3 +++
 include/linux/pci.h                 |  1 +
 4 files changed, 79 insertions(+), 4 deletions(-)

-- 
2.7.4

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
