Return-Path: <SRS0=B4OP=WL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC212C32759
	for <iommu@archiver.kernel.org>; Thu, 15 Aug 2019 11:10:15 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85AE52067D
	for <iommu@archiver.kernel.org>; Thu, 15 Aug 2019 11:10:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tcd-ie.20150623.gappssmtp.com header.i=@tcd-ie.20150623.gappssmtp.com header.b="Q/yj0wdq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85AE52067D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tcd.ie
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 437DDE7A;
	Thu, 15 Aug 2019 11:10:15 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 783ECD48
	for <iommu@lists.linux-foundation.org>;
	Thu, 15 Aug 2019 11:10:14 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com
	[209.85.210.196])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id D71348A3
	for <iommu@lists.linux-foundation.org>;
	Thu, 15 Aug 2019 11:10:13 +0000 (UTC)
Received: by mail-pf1-f196.google.com with SMTP id 129so1192381pfa.4
	for <iommu@lists.linux-foundation.org>;
	Thu, 15 Aug 2019 04:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=tcd-ie.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=pnCulqyNhSM91IKVD9IZn1zR67Z7c5BvAhoQmog/5ec=;
	b=Q/yj0wdq+WilKs254iWd4ctGJJZQhMbIdIQejnyJ2yIZ2I3/VGazT/h5zdi6LD7eY8
	FwgETf3lOfMHLLcqgq8CX6eWsXdSOnzVllHOw4eeaE0NXqiFmk8nmB4m4ILkf0DWUhGl
	JMQh6MEqYX1Y/aId7O5b7KB1SCsX5COS7TIXwL/OLfWSbuLKcOFMiSy2pNH9NkkEkNBr
	vOPWQr2P1jdI57kcED+j4RTWUTiYLR6O+vQhsK1J9F6eA8G9tukV7lXi54eGF07uXuiI
	Xknh1VVTk7+o3JYaC+ItCXjA2eeC6ftIDB3zEkigJNAaCQqM79VsPpgrbJeTAytQ3YC4
	1SFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=pnCulqyNhSM91IKVD9IZn1zR67Z7c5BvAhoQmog/5ec=;
	b=Gpb4ensKk15tuOgudhse2w+9eH9azAqvvVg57/4wOXiJiwil3rAHEwoGW183NpUWxn
	yR8ENkK5rObDeDDSzA4Xan5Bc0pG+mX9TpRUW1xdCiix7H+6CLHK3Ad25t352kVZR5mr
	KUwtcd4PgLcZoQ22GTSe+rtudCAHVZf2IBATR3rs3g8Mz4nwTPDirBUnJtVrJ6brwLV1
	kTT0z26EJEKaJplcbf2YS21/LfUmj6TDjtNqxtw97wTJ/3JtvGOI/4My3MDo9WZdhwnj
	mspL6SDDrf71JyaMlD9FOJW+WiRNLidExwNdLIvPhJAMj3tcFl+/txqWGdco42C0cm0i
	5lhw==
X-Gm-Message-State: APjAAAXBs9tavGjxK2AP9PqgS/nkqeZ6FqzSxWSg7hf8pWo6kWNlBzuc
	QG4bQTsbaoD4zrF31x077mHbNbI0oTDiHA==
X-Google-Smtp-Source: APXvYqxZ8fgFC+B1aOZDDqSuQf6BabOCz/a02ujOJQDOq0sxZQrHZCdzZZ4gWxdnMFReUWQ6Q4YS3Q==
X-Received: by 2002:a65:6458:: with SMTP id s24mr3060394pgv.158.1565867413007; 
	Thu, 15 Aug 2019 04:10:13 -0700 (PDT)
Received: from localhost.localdomain
	([2404:e801:200e:19c4:6c3f:b548:3a9c:7867])
	by smtp.googlemail.com with ESMTPSA id
	z13sm1042678pjn.32.2019.08.15.04.10.06
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Thu, 15 Aug 2019 04:10:12 -0700 (PDT)
From: Tom Murphy <murphyt7@tcd.ie>
To: iommu@lists.linux-foundation.org
Subject: [PATCH V5 0/5] iommu/amd: Convert the AMD iommu driver to the
	dma-iommu api
Date: Thu, 15 Aug 2019 12:09:38 +0100
Message-Id: <20190815110944.3579-1-murphyt7@tcd.ie>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Cc: Heiko Stuebner <heiko@sntech.de>, virtualization@lists.linux-foundation.org,
	linux-tegra@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>,
	Will Deacon <will@kernel.org>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	linux-samsung-soc@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>, linux-rockchip@lists.infradead.org,
	Andy Gross <agross@kernel.org>,
	Gerald Schaefer <gerald.schaefer@de.ibm.com>,
	linux-s390@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Matthias Brugger <matthias.bgg@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	David Woodhouse <dwmw2@infradead.org>,
	linux-kernel@vger.kernel.org, Tom Murphy <murphyt7@tcd.ie>,
	Kukjin Kim <kgene@kernel.org>, Robin Murphy <robin.murphy@arm.com>
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

Convert the AMD iommu driver to the dma-iommu api. Remove the iova
handling and reserve region code from the AMD iommu driver.

Change-log:
V5:
-Rebase on top of linux-next
V4:
-Rebase on top of linux-next
-Split the removing of the unnecessary locking in the amd iommu driver into a seperate patch
-refactor the "iommu/dma-iommu: Handle deferred devices" patch and address comments
v3:
-rename dma_limit to dma_mask
-exit handle_deferred_device early if (!is_kdump_kernel())
-remove pointless calls to handle_deferred_device
v2:
-Rebase on top of this series:
 http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/dma-iommu-ops.3
-Add a gfp_t parameter to the iommu_ops::map function.
-Made use of the reserve region code inside the dma-iommu api

Tom Murphy (5):
  iommu/amd: Remove unnecessary locking from AMD iommu driver
  iommu: Add gfp parameter to iommu_ops::map
  iommu/dma-iommu: Handle deferred devices
  iommu/dma-iommu: Use the dev->coherent_dma_mask
  iommu/amd: Convert AMD iommu driver to the dma-iommu api

 drivers/iommu/Kconfig           |   1 +
 drivers/iommu/amd_iommu.c       | 690 ++++----------------------------
 drivers/iommu/amd_iommu_types.h |   1 -
 drivers/iommu/arm-smmu-v3.c     |   2 +-
 drivers/iommu/arm-smmu.c        |   2 +-
 drivers/iommu/dma-iommu.c       |  43 +-
 drivers/iommu/exynos-iommu.c    |   2 +-
 drivers/iommu/intel-iommu.c     |   2 +-
 drivers/iommu/iommu.c           |  43 +-
 drivers/iommu/ipmmu-vmsa.c      |   2 +-
 drivers/iommu/msm_iommu.c       |   2 +-
 drivers/iommu/mtk_iommu.c       |   2 +-
 drivers/iommu/mtk_iommu_v1.c    |   2 +-
 drivers/iommu/omap-iommu.c      |   2 +-
 drivers/iommu/qcom_iommu.c      |   2 +-
 drivers/iommu/rockchip-iommu.c  |   2 +-
 drivers/iommu/s390-iommu.c      |   2 +-
 drivers/iommu/tegra-gart.c      |   2 +-
 drivers/iommu/tegra-smmu.c      |   2 +-
 drivers/iommu/virtio-iommu.c    |   2 +-
 include/linux/iommu.h           |  21 +-
 21 files changed, 178 insertions(+), 651 deletions(-)

-- 
2.20.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
