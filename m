Return-Path: <SRS0=aFDh=SL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3104BC10F0E
	for <iommu@archiver.kernel.org>; Tue,  9 Apr 2019 20:54:32 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3FFC2084F
	for <iommu@archiver.kernel.org>; Tue,  9 Apr 2019 20:54:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3FFC2084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id C2A41F32;
	Tue,  9 Apr 2019 20:54:31 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 7F3F3F25
	for <iommu@lists.linux-foundation.org>;
	Tue,  9 Apr 2019 20:54:30 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-oi1-f196.google.com (mail-oi1-f196.google.com
	[209.85.167.196])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 0D6C5F4
	for <iommu@lists.linux-foundation.org>;
	Tue,  9 Apr 2019 20:54:29 +0000 (UTC)
Received: by mail-oi1-f196.google.com with SMTP id v7so14807613oie.8
	for <iommu@lists.linux-foundation.org>;
	Tue, 09 Apr 2019 13:54:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=OQOCMV3xKrmHqHY1PVCBaCxVJYAiJpfExHpXaR163xc=;
	b=B3Y6NzKZvNGD/ec4L1BZZNikjfxcS+uAsgbNtxcbaYLgBEG+KOLHdz3FWR5n3r3l+P
	BEnoRrs8Ten2vFNlAXbxbL/1eB1LPahpmq+oUSBSI0lK8FPaHydVEfushQz8kuP4z7D7
	jnldUzHS6bsvqtgsgqt5J+Yxmlg5naLKEj9fJB1MV+l9fwAl3D/cDrq+6uowd+uoIvJd
	X46fPToMrUQMYlbH/vd9ge2GKrj3ztooRXp6Zua9/znzdmCxLg+l7YoMSxQWpkCE0CBe
	jV8mKs9gWTKRoluxxR42GCig2DlYzsToRX/SBydGGJUH8F3GHZI5reyvq4+emLDiLUK+
	sjRg==
X-Gm-Message-State: APjAAAVpNr1SxBf263s6hEnroT37lTK9l78OptlZFfks4Pi/ZzS7oCiv
	86e7hbtjHzqgSBqsa3l/1g==
X-Google-Smtp-Source: APXvYqzEDQZ7uqfTLestu2+gWF7kbkRYF6dpRyRzZVYhYW3aFz+roUub5HfG+RvptTkyfEeN5bo6lw==
X-Received: by 2002:aca:b886:: with SMTP id i128mr207754oif.169.1554843268821; 
	Tue, 09 Apr 2019 13:54:28 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net.
	[24.155.109.49]) by smtp.googlemail.com with ESMTPSA id
	o66sm6472175oig.11.2019.04.09.13.54.27
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Tue, 09 Apr 2019 13:54:28 -0700 (PDT)
From: Rob Herring <robh@kernel.org>
To: dri-devel@lists.freedesktop.org
Subject: [PATCH v3 0/3] Initial Panfrost driver
Date: Tue,  9 Apr 2019 15:54:24 -0500
Message-Id: <20190409205427.6943-1-robh@kernel.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Cc: Sean Paul <sean@poorly.run>, Lyude Paul <lyude@redhat.com>,
	Eric Anholt <eric@anholt.net>, Maxime Ripard <maxime.ripard@bootlin.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Neil Armstrong <narmstrong@baylibre.com>,
	Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org,
	Steven Price <steven.price@arm.com>, David Airlie <airlied@linux.ie>,
	iommu@lists.linux-foundation.org,
	Boris Brezillon <boris.brezillon@collabora.com>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>, Daniel Vetter <daniel@ffwll.ch>,
	Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190409205424.fUn5faprKimkntP2qltL55hH4I4m1R01otWPTdSagIo@z>

Here's v3 of the panfrost driver. Lot's of changes from review comments
and further testing. Details are in each patch. Of note, a problem with
MMU page faults has been addressed improving the stability. In the
process, the TLB invalidate has been optimized which Tomeu says has
improved the performance some.

Several dependencies have been applied already, but the first 2 patches
are the remaining dependencies. We need to take the iommu change via
drm-misc or we need a stable branch.

I'm hoping this is the last version. I'm hoping to apply this to drm-misc
this week before -rc5 cutoff.

A git branch is here[1].

Rob

[1] git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git panfrost-rebase-v3


Rob Herring (3):
  iommu: io-pgtable: Add ARM Mali midgard MMU page table format
  drm: Add a drm_gem_objects_lookup helper
  drm/panfrost: Add initial panfrost driver

 MAINTAINERS                                  |   9 +
 drivers/gpu/drm/Kconfig                      |   2 +
 drivers/gpu/drm/Makefile                     |   1 +
 drivers/gpu/drm/drm_gem.c                    |  93 ++-
 drivers/gpu/drm/panfrost/Kconfig             |  14 +
 drivers/gpu/drm/panfrost/Makefile            |  12 +
 drivers/gpu/drm/panfrost/TODO                |  27 +
 drivers/gpu/drm/panfrost/panfrost_devfreq.c  | 218 ++++++++
 drivers/gpu/drm/panfrost/panfrost_devfreq.h  |  14 +
 drivers/gpu/drm/panfrost/panfrost_device.c   | 252 +++++++++
 drivers/gpu/drm/panfrost/panfrost_device.h   | 124 ++++
 drivers/gpu/drm/panfrost/panfrost_drv.c      | 460 +++++++++++++++
 drivers/gpu/drm/panfrost/panfrost_features.h | 309 ++++++++++
 drivers/gpu/drm/panfrost/panfrost_gem.c      |  95 ++++
 drivers/gpu/drm/panfrost/panfrost_gem.h      |  29 +
 drivers/gpu/drm/panfrost/panfrost_gpu.c      | 362 ++++++++++++
 drivers/gpu/drm/panfrost/panfrost_gpu.h      |  19 +
 drivers/gpu/drm/panfrost/panfrost_issues.h   | 176 ++++++
 drivers/gpu/drm/panfrost/panfrost_job.c      | 560 +++++++++++++++++++
 drivers/gpu/drm/panfrost/panfrost_job.h      |  51 ++
 drivers/gpu/drm/panfrost/panfrost_mmu.c      | 369 ++++++++++++
 drivers/gpu/drm/panfrost/panfrost_mmu.h      |  17 +
 drivers/gpu/drm/panfrost/panfrost_regs.h     | 298 ++++++++++
 drivers/iommu/io-pgtable-arm.c               |  91 ++-
 drivers/iommu/io-pgtable.c                   |   1 +
 include/drm/drm_gem.h                        |   2 +
 include/linux/io-pgtable.h                   |   7 +
 include/uapi/drm/panfrost_drm.h              | 142 +++++
 28 files changed, 3722 insertions(+), 32 deletions(-)
 create mode 100644 drivers/gpu/drm/panfrost/Kconfig
 create mode 100644 drivers/gpu/drm/panfrost/Makefile
 create mode 100644 drivers/gpu/drm/panfrost/TODO
 create mode 100644 drivers/gpu/drm/panfrost/panfrost_devfreq.c
 create mode 100644 drivers/gpu/drm/panfrost/panfrost_devfreq.h
 create mode 100644 drivers/gpu/drm/panfrost/panfrost_device.c
 create mode 100644 drivers/gpu/drm/panfrost/panfrost_device.h
 create mode 100644 drivers/gpu/drm/panfrost/panfrost_drv.c
 create mode 100644 drivers/gpu/drm/panfrost/panfrost_features.h
 create mode 100644 drivers/gpu/drm/panfrost/panfrost_gem.c
 create mode 100644 drivers/gpu/drm/panfrost/panfrost_gem.h
 create mode 100644 drivers/gpu/drm/panfrost/panfrost_gpu.c
 create mode 100644 drivers/gpu/drm/panfrost/panfrost_gpu.h
 create mode 100644 drivers/gpu/drm/panfrost/panfrost_issues.h
 create mode 100644 drivers/gpu/drm/panfrost/panfrost_job.c
 create mode 100644 drivers/gpu/drm/panfrost/panfrost_job.h
 create mode 100644 drivers/gpu/drm/panfrost/panfrost_mmu.c
 create mode 100644 drivers/gpu/drm/panfrost/panfrost_mmu.h
 create mode 100644 drivers/gpu/drm/panfrost/panfrost_regs.h
 create mode 100644 include/uapi/drm/panfrost_drm.h

--
2.19.1
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
