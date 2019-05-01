Return-Path: <SRS0=GORt=TB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DCE5C43219
	for <iommu@archiver.kernel.org>; Wed,  1 May 2019 17:37:23 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CA282081C
	for <iommu@archiver.kernel.org>; Wed,  1 May 2019 17:37:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="CEjb4MdJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CA282081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 417912A9B;
	Wed,  1 May 2019 17:37:23 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id CA5422781
	for <iommu@lists.linux-foundation.org>;
	Wed,  1 May 2019 17:36:59 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f67.google.com (mail-ed1-f67.google.com
	[209.85.208.67])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 4AB9B711
	for <iommu@lists.linux-foundation.org>;
	Wed,  1 May 2019 17:36:59 +0000 (UTC)
Received: by mail-ed1-f67.google.com with SMTP id p26so1958593edr.2
	for <iommu@lists.linux-foundation.org>;
	Wed, 01 May 2019 10:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
	h=from:to:cc:subject:date:message-id;
	bh=WQh6+iJ1c5LV37hewjiOUJ2VVaJB8K0iqnjk0rOcMbE=;
	b=CEjb4MdJxi08K/sHDaK0eh5tzCmNnbKo8l7lks3hzoghFBcg/r6yFxaG++ZgfgWdOW
	yhDjocgFxXdRp2TXI0xdQdK5/myMxON+Mu0JLn+NQ1dTx8bFetH/46D3fX3SPvCsbFnq
	MJg+fKzdyXBskAw+hqszBABaL0ctbb+ffQuas=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=WQh6+iJ1c5LV37hewjiOUJ2VVaJB8K0iqnjk0rOcMbE=;
	b=GhfNpGw5SlgnyY/0Qf+Zpd10KOJulfjHbxDRfkzvesJiSyONePrgLo6vezMZlT2H/K
	hh8Oz9JF5eOx9PaC3TUHUGQjSn5VaN5GzCEl2D3ALHTCzkGC8CuwyaEHFqXBZCvaJQsL
	gjkCaANSQVri9iz0wgKLMxpOw03XCNe2dAXWIy+U9fYYc/hX4pDYAyVtmUBAfWzzY+70
	Mw4gJ1DxqUnUmjX+knLbIOmBYchV3F/wAl9pog+Tk2MaBTAOEZsAS6lQJEq83K9MiCLh
	hsUqKX15vdMZCZ0vOf72kyVhKUe+1tZd2o5JXj/KLq0UrAg4NcFW0w5311InMUxnyKKE
	hNGg==
X-Gm-Message-State: APjAAAWxOEhkOGp+jrMgIby9H0zfr6p8uunZo8a6W/sLxr88FYdOprO6
	5tGwHZmRN89bmK/7UfO5FTKohQ==
X-Google-Smtp-Source: APXvYqyT8CYAd7eurrFrFI8PfzHJPMcWdZ7fq9QHDpPRgQBgROfDRCybBxqF9//b4tm21qJoRt4Byg==
X-Received: by 2002:a17:906:e10e:: with SMTP id
	gj14mr15158656ejb.285.1556732217818; 
	Wed, 01 May 2019 10:36:57 -0700 (PDT)
Received: from mannams-OptiPlex-7010.dhcp.broadcom.net ([192.19.234.250])
	by smtp.gmail.com with ESMTPSA id s6sm2462671eji.13.2019.05.01.10.36.51
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Wed, 01 May 2019 10:36:56 -0700 (PDT)
To: Bjorn Helgaas <bhelgaas@google.com>, Robin Murphy <robin.murphy@arm.com>,
	Eric Auger <eric.auger@redhat.com>, Joerg Roedel <joro@8bytes.org>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, poza@codeaurora.org,
	Ray Jui <rjui@broadcom.com>
Subject: [PATCH v5 0/3] PCIe Host request to reserve IOVA
Date: Wed,  1 May 2019 23:06:23 +0530
Message-Id: <1556732186-21630-1-git-send-email-srinath.mannam@broadcom.com>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190501173623.y9PjR_LvYqUfp11k_pD22hpdpGrjxluuYDMblNh_mr0@z>

Few SOCs have limitation that their PCIe host can't allow few inbound
address ranges. Allowed inbound address ranges are listed in dma-ranges
DT property and this address ranges are required to do IOVA mapping.
Remaining address ranges have to be reserved in IOVA mapping.

PCIe Host driver of those SOCs has to list resource entries of allowed
address ranges given in dma-ranges DT property in sorted order. This
sorted list of resources will be processed and reserve IOVA address for
inaccessible address holes while initializing IOMMU domain.

This patch set is based on Linux-5.1-rc3.

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

 drivers/iommu/dma-iommu.c           | 19 ++++++++++++++++
 drivers/pci/controller/pcie-iproc.c | 44 ++++++++++++++++++++++++++++++++++++-
 drivers/pci/probe.c                 |  3 +++
 include/linux/pci.h                 |  1 +
 4 files changed, 66 insertions(+), 1 deletion(-)

-- 
2.7.4

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
