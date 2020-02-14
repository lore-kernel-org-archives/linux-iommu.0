Return-Path: <SRS0=UfLp=4C=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2E63C3B19F
	for <iommu@archiver.kernel.org>; Fri, 14 Feb 2020 16:07:13 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA58924654
	for <iommu@archiver.kernel.org>; Fri, 14 Feb 2020 16:07:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hE7o6Gpo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA58924654
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 6F55B86A9B;
	Fri, 14 Feb 2020 16:07:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DllDf4fCQilh; Fri, 14 Feb 2020 16:07:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id C744585EA2;
	Fri, 14 Feb 2020 16:07:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BC625C1D8D;
	Fri, 14 Feb 2020 16:07:12 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id ADDF8C08A4
 for <iommu@lists.linux-foundation.org>; Fri, 14 Feb 2020 16:07:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 244958621D
 for <iommu@lists.linux-foundation.org>; Fri, 14 Feb 2020 16:07:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id P67orUPMjEAC for <iommu@lists.linux-foundation.org>;
 Fri, 14 Feb 2020 16:07:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com
 [209.85.221.65])
 by hemlock.osuosl.org (Postfix) with ESMTPS id EA8BF85EF2
 for <iommu@lists.linux-foundation.org>; Fri, 14 Feb 2020 16:06:54 +0000 (UTC)
Received: by mail-wr1-f65.google.com with SMTP id w12so11502458wrt.2
 for <iommu@lists.linux-foundation.org>; Fri, 14 Feb 2020 08:06:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=QZOdeYob0unxBnNaicbQBgm32/JrXg0BrJwyt1f7elc=;
 b=hE7o6GpoP5twPWF3gKHH23ktUStiNlbQBAVgFayAEV72YEEKY6SRWo90uFcpbYe+kC
 6RbWy5ms1zZkbB9VCUseGI/evxbiBmVjK1QmpgMOT+917SK1z6TAn3nnyk/AwiiXXhMb
 Ju3cC7ma+PzAfxt782ZNHMdnCRZYvBKtwMc6IbgNhA8YAav7wgLvKExz4tY6lpGOyNXg
 ePOuQprWiaTOVQG/W0G4gN1qfmLIx8OsjSLs/uXTWDCSko91iQGGnY7iwrfJAAR1PA0s
 BOEM/+H0YT1ukQw7u5irxo8Zi8P0BvZjomyaiZRRIBGjUY9IBtq+ZKIqq3H00OEErZmF
 tquw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=QZOdeYob0unxBnNaicbQBgm32/JrXg0BrJwyt1f7elc=;
 b=h3gu3fFnJtOpvHD8bBJx6/qF9r14CPtuI+V8IPiciLIpPmLby1QMJgmL3vhHWzwk2E
 5k2nXAyFS1+k4JVNMpY9ALoWPuzult4qC1rJ5WKfSU72AIkAAC4vZ9aaDSr9Grlu4X6o
 FfT+e8a5xDTrYodWuzm8rio5Jbgg9Q6E5jWYiuxguqvQUMZEmiHModXnMySrSCIwNaUr
 oxioSL0p8OnGdsVHrdhmDxZ7p24lVh6N316gzk+CgsmbmMgOuWarLRZZjgiXBVABsEVH
 fb+GvuoSONFPVkZihDjKi0V3P9l60CK6enq0VE2EOe/VvVUzYCQCgr2Cycmxd4MVbaB+
 bA3Q==
X-Gm-Message-State: APjAAAXMuSJZY/o96dvm64GC+/tq7XXpoovAQBqoTR5JLEztezqmSEEt
 Qu53UJ9JRjLgCArtpbDKCc9Xm6xdzs8=
X-Google-Smtp-Source: APXvYqztazK/xQKzvZjH67m157XVvrLPuUSe39hdz1bzjgRY06ZpdyvXZn13dt99dLDQvA9pCyj3tw==
X-Received: by 2002:adf:f382:: with SMTP id m2mr4668894wro.163.1581696412999; 
 Fri, 14 Feb 2020 08:06:52 -0800 (PST)
Received: from localhost.localdomain ([2001:171b:2276:930:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id s139sm8133213wme.35.2020.02.14.08.06.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Feb 2020 08:06:51 -0800 (PST)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: iommu@lists.linux-foundation.org,
 virtualization@lists.linux-foundation.org, linux-pci@vger.kernel.org
Subject: [PATCH 0/3] virtio-iommu on non-devicetree platforms
Date: Fri, 14 Feb 2020 17:04:10 +0100
Message-Id: <20200214160413.1475396-1-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Cc: kevin.tian@intel.com, mst@redhat.com, sebastien.boeuf@intel.com,
 jacob.jun.pan@intel.com, bhelgaas@google.com, jasowang@redhat.com
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

Add topology description to the virtio-iommu driver and enable x86
platforms. Since the RFC [1] I've mostly given up on ACPI tables, since
the internal discussions seem to have reached a dead end. The built-in
topology description presented here isn't ideal, but it is simple to
implement and doesn't impose a dependency on ACPI or device-tree, which
can be beneficial to lightweight hypervisors.

The built-in description is an array in the virtio config space. The
driver parses the config space early and postpones endpoint probe until
the virtio-iommu device is ready. Each element in the array describes
either a PCI range or a single MMIO endpoint, and their associated
endpoint IDs:

struct virtio_iommu_topo_pci_range {
	__le16 type;			/* 1: PCI range */
	__le16 hierarchy;		/* PCI domain number */
	__le16 requester_start;		/* First BDF */
	__le16 requester_end;		/* Last BDF */
	__le32 endpoint_start;		/* First endpoint ID */
};

struct virtio_iommu_topo_endpoint {
	__le16 type;			/* 2: Endpoint */
	__le16 reserved;		/* 0 */
	__le32 endpoint;		/* Endpoint ID */
	__le64 address;			/* First MMIO address */
};

You can find the QEMU patches based on Eric's latest device on my
virtio-iommu/devel branch [2]. I test on both x86 q35, and aarch64 virt
machine with edk2.

[1] https://lore.kernel.org/linux-iommu/20191122105000.800410-1-jean-philippe@linaro.org/
[2] https://jpbrucker.net/git/qemu virtio-iommu/devel

Jean-Philippe Brucker (3):
  iommu/virtio: Add topology description to virtio-iommu config space
  PCI: Add DMA configuration for virtual platforms
  iommu/virtio: Enable x86 support

 MAINTAINERS                           |   2 +
 drivers/iommu/Kconfig                 |  13 +-
 drivers/iommu/Makefile                |   1 +
 drivers/iommu/virtio-iommu-topology.c | 343 ++++++++++++++++++++++++++
 drivers/iommu/virtio-iommu.c          |   3 +
 drivers/pci/pci-driver.c              |   5 +
 include/linux/virt_iommu.h            |  19 ++
 include/uapi/linux/virtio_iommu.h     |  26 ++
 8 files changed, 411 insertions(+), 1 deletion(-)
 create mode 100644 drivers/iommu/virtio-iommu-topology.c
 create mode 100644 include/linux/virt_iommu.h

-- 
2.25.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
