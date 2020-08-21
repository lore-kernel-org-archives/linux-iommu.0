Return-Path: <SRS0=6E3Y=B7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2594AC433E3
	for <iommu@archiver.kernel.org>; Fri, 21 Aug 2020 13:16:15 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9AED20724
	for <iommu@archiver.kernel.org>; Fri, 21 Aug 2020 13:16:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EYBouRuv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9AED20724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id B65A485FB9;
	Fri, 21 Aug 2020 13:16:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jcw9SYXP0RmX; Fri, 21 Aug 2020 13:16:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id EC92A864B3;
	Fri, 21 Aug 2020 13:16:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C6F2BC0893;
	Fri, 21 Aug 2020 13:16:12 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B2E5CC0889
 for <iommu@lists.linux-foundation.org>; Fri, 21 Aug 2020 13:16:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id ACA8E88614
 for <iommu@lists.linux-foundation.org>; Fri, 21 Aug 2020 13:16:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ruwKkivIpY0M for <iommu@lists.linux-foundation.org>;
 Fri, 21 Aug 2020 13:16:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ej1-f67.google.com (mail-ej1-f67.google.com
 [209.85.218.67])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 3B6E388198
 for <iommu@lists.linux-foundation.org>; Fri, 21 Aug 2020 13:16:09 +0000 (UTC)
Received: by mail-ej1-f67.google.com with SMTP id si26so2200350ejb.12
 for <iommu@lists.linux-foundation.org>; Fri, 21 Aug 2020 06:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Y/asOEQ7I5lK9SCfOrPxX9Ij7ThPhJXGbgb9Vg60QdU=;
 b=EYBouRuvx7C7M1g4+Ts8UzFEMdS8ULDwuOJEs1eOkgISO70lUT/4Bvu/b1h1GvERCl
 rKI7LPJD38AhqdjZ/lSpOArHlbNCvqLuAHOWkeu+OWoua5ljvoIl8M1kqX/r2VxoBq//
 SOrSe/51+7gXMFValJMarQpshl2SpMbFVAkyEvvD59ixQdldOvOWlq7nETtEXla4XPyN
 AOPoYkrkNhg9tMEXekpD3atg/nxtUf5yS1cQz2fuBJq10wwAV6IE3DZy7UnG8q5Z3oJ/
 3TWv1ugObjE4oa7EDAXgTv8M7m8QyMKkjXIbXeNK8e3KaTGVDHRHUbJcfn9TlVH9F4AV
 YDEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Y/asOEQ7I5lK9SCfOrPxX9Ij7ThPhJXGbgb9Vg60QdU=;
 b=q19QMuROBuiFeqHF51uDYZmjzFxA12Zs+dgpoxUxq35LybL56u28yk9JGuaUfgHHoN
 yeTqDD1D9qEwXskuUEewfwLaPz67scwXSxFalQ3eq9wcDdEfiBcMNDXczTNKFTZNmLsK
 mJDv4AaVzb+ibnefSvs/Spg/aFINDzU3p5bHi+MFrVdXXHCuZhrFf+EAmt+CuI8oMrzn
 0YHNB6LeswSvMpCQTDc+EWcK8I4WyR02rDWNB+pRoromrmuwhzuFrP4olGEZaJRKZ/AO
 T7LrZBbiuhSnHpghKEoZKM1vtbcX7DEPrGglaE2//aLu7ZhbLZoIlahWY03KRGI1VcMk
 b6QQ==
X-Gm-Message-State: AOAM531owcl6Tr9VZWYXgzYYKx3OAJFxmsGrBYGmFqXTvvXlDOFeLXBl
 JsQAG3qBnItW4IPCqL31UXeE1+S2uPF20abv
X-Google-Smtp-Source: ABdhPJwOy/5jkRbdPAXN7lLeuSinZ0dNBsa/xxJXp4vx3NLHlrjucaVJpRbbUOOksUhqw9JvR5D63A==
X-Received: by 2002:a17:906:dbd2:: with SMTP id
 yc18mr2371358ejb.394.1598015767083; 
 Fri, 21 Aug 2020 06:16:07 -0700 (PDT)
Received: from localhost.localdomain
 ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id v4sm1299748eje.39.2020.08.21.06.16.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2020 06:16:06 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: iommu@lists.linux-foundation.org,
 virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org,
 linux-pci@vger.kernel.org
Subject: [PATCH v3 0/6] Add virtio-iommu built-in topology
Date: Fri, 21 Aug 2020 15:15:34 +0200
Message-Id: <20200821131540.2801801-1-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, kevin.tian@intel.com,
 mst@redhat.com, sebastien.boeuf@intel.com, bhelgaas@google.com,
 jasowang@redhat.com
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

Add a topology description to the virtio-iommu driver and enable x86
platforms.

Since [v2] we have made some progress on adding ACPI support for
virtio-iommu, which is the preferred boot method on x86. It will be a
new vendor-agnostic table describing para-virtual topologies in a
minimal format. However some platforms don't use either ACPI or DT for
booting (for example microvm), and will need the alternative topology
description method proposed here. In addition, since the process to get
a new ACPI table will take a long time, this provides a boot method even
to ACPI-based platforms, if only temporarily for testing and
development.

v3:
* Add patch 1 that moves virtio-iommu to a subfolder.
* Split the rest:
  * Patch 2 adds topology-helper.c, which will be shared with the ACPI
    support.
  * Patch 4 adds definitions.
  * Patch 5 adds parser in topology.c.
* Address other comments.

Linux and QEMU patches available at:
https://jpbrucker.net/git/linux virtio-iommu/devel
https://jpbrucker.net/git/qemu virtio-iommu/devel

[spec] https://lists.oasis-open.org/archives/virtio-dev/202008/msg00067.html
[v2] https://lore.kernel.org/linux-iommu/20200228172537.377327-1-jean-philippe@linaro.org/
[v1] https://lore.kernel.org/linux-iommu/20200214160413.1475396-1-jean-philippe@linaro.org/
[rfc] https://lore.kernel.org/linux-iommu/20191122105000.800410-1-jean-philippe@linaro.org/

Jean-Philippe Brucker (6):
  iommu/virtio: Move to drivers/iommu/virtio/
  iommu/virtio: Add topology helpers
  PCI: Add DMA configuration for virtual platforms
  iommu/virtio: Add topology definitions
  iommu/virtio: Support topology description in config space
  iommu/virtio: Enable x86 support

 drivers/iommu/Kconfig                     |  18 +-
 drivers/iommu/Makefile                    |   3 +-
 drivers/iommu/virtio/Makefile             |   4 +
 drivers/iommu/virtio/topology-helpers.h   |  50 +++++
 include/linux/virt_iommu.h                |  15 ++
 include/uapi/linux/virtio_iommu.h         |  44 ++++
 drivers/iommu/virtio/topology-helpers.c   | 196 ++++++++++++++++
 drivers/iommu/virtio/topology.c           | 259 ++++++++++++++++++++++
 drivers/iommu/{ => virtio}/virtio-iommu.c |   4 +
 drivers/pci/pci-driver.c                  |   5 +
 MAINTAINERS                               |   3 +-
 11 files changed, 597 insertions(+), 4 deletions(-)
 create mode 100644 drivers/iommu/virtio/Makefile
 create mode 100644 drivers/iommu/virtio/topology-helpers.h
 create mode 100644 include/linux/virt_iommu.h
 create mode 100644 drivers/iommu/virtio/topology-helpers.c
 create mode 100644 drivers/iommu/virtio/topology.c
 rename drivers/iommu/{ => virtio}/virtio-iommu.c (99%)

-- 
2.28.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
