Return-Path: <SRS0=24kn=XD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEE29C4360D
	for <iommu@archiver.kernel.org>; Sun,  8 Sep 2019 16:56:59 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA2DB21479
	for <iommu@archiver.kernel.org>; Sun,  8 Sep 2019 16:56:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tcd-ie.20150623.gappssmtp.com header.i=@tcd-ie.20150623.gappssmtp.com header.b="YkxKYH/E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA2DB21479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tcd.ie
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 68AF1BDC;
	Sun,  8 Sep 2019 16:56:59 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 57C3BBA9
	for <iommu@lists.linux-foundation.org>;
	Sun,  8 Sep 2019 16:56:58 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-pg1-f194.google.com (mail-pg1-f194.google.com
	[209.85.215.194])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 24E2A81A
	for <iommu@lists.linux-foundation.org>;
	Sun,  8 Sep 2019 16:56:57 +0000 (UTC)
Received: by mail-pg1-f194.google.com with SMTP id x15so6366653pgg.8
	for <iommu@lists.linux-foundation.org>;
	Sun, 08 Sep 2019 09:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=tcd-ie.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=E2f3KSrZxRio8/FeHv28ONTThNhL2TjtH0LaTd/eJz4=;
	b=YkxKYH/ERWEtBHeMoD9KlshTjhFsDszVa0tiICeohlWVLEzIcG2mdKPWfiiXIAB9Ep
	h6QalfbgiFdxT1gwzIyDJP5nWISKWpTHIpT1fN2L7ULPQG419Bbi7XY3FDT2eqv7Pdio
	H1K5BfueRIQBGq3EqACgol7GvzJZ1eAgnKKZmazjR0LQiP65cCb17u0sJuotvVHS33a6
	qj4J0lq3fFjn9VBtqa6a2jkRAsYTa2rETqDhPFBFFdRonhlNDlwxzNcmQUhBH77kLi7U
	AS1qIGirCQTlRgJu1+io8rSZUnDci9vM9xSPVt3khu+byAO8nhRLsYoEOS2YUMuEme9n
	8jPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=E2f3KSrZxRio8/FeHv28ONTThNhL2TjtH0LaTd/eJz4=;
	b=aoPLVHyJ63mnMwyqvAQTmaegvQKQmSlHhJNjW/R0KO3RYktbpENHe09dq0HhsYfJTx
	Kpm/Us18r5AcuX2Q+q8gzTrxd47tesbGPMdi4eR81+LlimJ3/06PQHxU8+HuXL04s+EC
	w/KYiElWsYqPWOyC5C4/Vy22deGKEPePrYQ7E7CKlp9toT5RNU7Pi2dSicAlHxKJ9n2c
	1GzxG4GrT9km3IZ+fleUSijahY3np/UcN2s4X9B1+mzNjXgonrLuQzFTzp5OvkKZq33E
	+yxywlRk/1faFDDzjX8A9wvmtv5gBAY8maibziqzUXS3qNIlrtUYMxQNUATiXQGNNyt6
	WpCA==
X-Gm-Message-State: APjAAAWBcEs3YcGp65N0AMIEoTDjiIPyVD/6FeYQVuenOgC8J9et7otD
	I9+Gcqs4dImrHlyxD7Twrj/gArhNrKo/kg==
X-Google-Smtp-Source: APXvYqycW5UHspFXzTlIh/iOGVx+SWpR9vq4XdyDpuh90LK48tRDCdIIhjamCNmUiV+Y56F7gJ75Lw==
X-Received: by 2002:a63:7d05:: with SMTP id y5mr17861065pgc.425.1567961816386; 
	Sun, 08 Sep 2019 09:56:56 -0700 (PDT)
Received: from localhost.localdomain ([24.244.23.109])
	by smtp.googlemail.com with ESMTPSA id
	f188sm13834631pfa.170.2019.09.08.09.56.55
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Sun, 08 Sep 2019 09:56:55 -0700 (PDT)
From: Tom Murphy <murphyt7@tcd.ie>
To: iommu@lists.linux-foundation.org
Subject: [PATCH v6 0/5] iommu/amd: Convert the AMD iommu driver to the
	dma-iommu api
Date: Sun,  8 Sep 2019 09:56:36 -0700
Message-Id: <20190908165642.22253-1-murphyt7@tcd.ie>
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
V6:
-add more details to the description of patch 001-iommu-amd-Remove-unnecessary-locking-from-AMD-iommu-.patch
-rename handle_deferred_device to iommu_dma_deferred_attach
-fix double tabs in 0003-iommu-dma-iommu-Handle-deferred-devices.patch
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
