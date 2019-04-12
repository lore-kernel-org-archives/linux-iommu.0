Return-Path: <SRS0=HOzV=SO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEAEBC10F0E
	for <iommu@archiver.kernel.org>; Fri, 12 Apr 2019 03:14:33 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2A342184B
	for <iommu@archiver.kernel.org>; Fri, 12 Apr 2019 03:14:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="YFno93QX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2A342184B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 6BB8D2D08;
	Fri, 12 Apr 2019 03:14:33 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 641762D02
	for <iommu@lists.linux-foundation.org>;
	Fri, 12 Apr 2019 03:13:55 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com
	[209.85.208.66])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id DA1747ED
	for <iommu@lists.linux-foundation.org>;
	Fri, 12 Apr 2019 03:13:54 +0000 (UTC)
Received: by mail-ed1-f66.google.com with SMTP id d46so2218412eda.7
	for <iommu@lists.linux-foundation.org>;
	Thu, 11 Apr 2019 20:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
	h=from:to:cc:subject:date:message-id;
	bh=lSZmLfiTS0tVJgkUC+AaFkmLshmlkzFI4jJrlCOnI6o=;
	b=YFno93QXuTT8g873ob4lzZVYz3tZWm+LfJx0YMpac2uEV9aJ6oZNSx9WOKnOf8lAo1
	+NqfDN8Br13bz4GqPuBdzRpRcU4aHRKhvkkpILIQq8DCmznfx/atr8QKvtlKx36BCQ8b
	DHYXbpmkIT46Gjd93nsMUBag2FEmJGH9PF5Ws=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=lSZmLfiTS0tVJgkUC+AaFkmLshmlkzFI4jJrlCOnI6o=;
	b=rmACM4IRbQ46FfpGJ2zID25mXaODiU4/irTD7ZmoDLjv/PJqDf5wfRgtwvtFn4JjZg
	D4f0BtgQR7kJdJAZm3pT/7uFj2TX3Xo5q6p5FrSl2Xmx0zemdNWl+J5yxIT21zBlvWux
	iHbAxP3jek9ZFvbo8isuCS/uW1hS4A7e+1l7wmHhFq59mAXobK/2t+T3SeVSUMCJDGjW
	G5+ALNFHF1W0shAD7+dr6P/KyG5m/0B6Og3VzcifRu0VaVXW23DKZ9HSfdJ0e+kUUS6Z
	bj9WrOPwHhLLVZouaTX20nP+6lYnASum/jh430cHyRXQBqWlv5LLXjMJy+BPvCubgsjp
	3djw==
X-Gm-Message-State: APjAAAU6k6iQJH50ZK5+Lxrc6Lz2j0Q7CBhSRe4ZYt5ZwTHrH/pN/jwb
	Yebaeb5du59c71+vGEnmY9h1Lg==
X-Google-Smtp-Source: APXvYqz8Z8DBYr6JemK9OQFaobK4cwQGMmE9tVq+z/+aM5UzwZDbxfR2W0WlgQFUXvqBP0mVwT6VEg==
X-Received: by 2002:aa7:dc4d:: with SMTP id g13mr5176207edu.106.1555038833471; 
	Thu, 11 Apr 2019 20:13:53 -0700 (PDT)
Received: from mannams-OptiPlex-7010.dhcp.broadcom.net ([192.19.234.250])
	by smtp.gmail.com with ESMTPSA id
	c7sm11533352edt.70.2019.04.11.20.13.47
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Thu, 11 Apr 2019 20:13:52 -0700 (PDT)
To: Bjorn Helgaas <bhelgaas@google.com>, Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, poza@codeaurora.org,
	Ray Jui <rjui@broadcom.com>
Subject: [PATCH v4 0/3] PCIe Host request to reserve IOVA
Date: Fri, 12 Apr 2019 08:43:32 +0530
Message-Id: <1555038815-31916-1-git-send-email-srinath.mannam@broadcom.com>
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
Message-ID: <20190412031332.oxslffrvZaxFvmoPKpcdB-nEMJoy6IA7yUgLZbTgxT8@z>

Few SOCs have limitation that their PCIe host can't allow few inbound
address ranges. Allowed inbound address ranges are listed in dma-ranges
DT property and this address ranges are required to do IOVA mapping.
Remaining address ranges have to be reserved in IOVA mapping.

PCIe Host driver of those SOCs has to list resource entries of allowed
address ranges given in dma-ranges DT property in sorted order. This
sorted list of resources will be processed and reserve IOVA address for
inaccessible address holes while initializing IOMMU domain.

This patch set is based on Linux-5.0-rc2.

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
