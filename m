Return-Path: <SRS0=qFSc=TE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40681C43219
	for <iommu@archiver.kernel.org>; Sat,  4 May 2019 13:25:21 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11C68206BB
	for <iommu@archiver.kernel.org>; Sat,  4 May 2019 13:25:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=arista.com header.i=@arista.com header.b="G3KCFm0f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11C68206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id D373A4229;
	Sat,  4 May 2019 13:25:20 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 3B866417A
	for <iommu@lists.linux-foundation.org>;
	Sat,  4 May 2019 13:24:17 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f65.google.com (mail-ed1-f65.google.com
	[209.85.208.65])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 952FF87
	for <iommu@lists.linux-foundation.org>;
	Sat,  4 May 2019 13:24:16 +0000 (UTC)
Received: by mail-ed1-f65.google.com with SMTP id m4so9452343edd.8
	for <iommu@lists.linux-foundation.org>;
	Sat, 04 May 2019 06:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=arista.com; s=googlenew;
	h=from:to:cc:subject:date:message-id;
	bh=iyAAdc/hWRW2hoexYmZRWuZhkprGVEqqGQbkYpxS37k=;
	b=G3KCFm0fbzzI5F1zvOaRO7d1l4ziZIc3CASA+uBY+RtDmidxSUQwWdeXFWtJOGLvYw
	a8yXmR1xI+Y2k53XMjmr8di4aBIt0In+/ytHYBL5TqUrHglv98FG0Eh0Vd6bmRsYYwYU
	mgxtUdE4nyACk972b901w9YsVjxBsYQseAlIOI3Cy43lAcovNGZEFC8Ba71/Oj//FiL5
	awp0y5M0274CBiGPuUoOAsJisrUXDjTUNJ9Xc3jnQTtRfUxSI/JI+U/AQGIARS0k91zP
	0kA1mk/UoQLSxxaLwLNPvd2A9TNRXxzX7bCEEg5Nrb8THmWNUI1ZqCSYcwSs94pbbFFl
	Zptg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=iyAAdc/hWRW2hoexYmZRWuZhkprGVEqqGQbkYpxS37k=;
	b=Kw5DZBcorf2qOZ6U4cCPqCzJafPjfZl9t08/Oec5Hq+jPpj3IAdHiX1v7o9vRgGub8
	9BLaHZRNGPFVt6nZfh8xTQA2xO1LGf4vRFyN/Vl5GlmXlirFueaCQ8FaTPJbiTA7+fp/
	pGw5tBHaPFe5uA52fXgTX0XwNhO+hq2j444x0YxHpHClBZFWkIR2xEYZGptp16QvqwQ5
	c/kIZdGzaCuqi5D5OG6dBl1GMGcnQ2v44EJP6QatpOABsvo828BvnSkhk8B/0MIARgCB
	86Wmg8e9nlWgoqjqWBo4fLqSuNSkzXbzWKavvZlT/6LayuzGQsVg8gcQ4hbFUCJhcABK
	Pm4A==
X-Gm-Message-State: APjAAAUWej/G/lM3lsz35LmPd003x9JwqOtFlmT75Qn17F3u09byHQeW
	eXCBOT/oyGavYyfksbRHjhh7f5BjHjePmA==
X-Google-Smtp-Source: APXvYqz4LGJhruC7j3NhOPSVnefUenYnUMxbvpiMSoAHKZ2baaSBXg9l+vRLGrvk4q5MJKcE05cUbQ==
X-Received: by 2002:a50:b68b:: with SMTP id d11mr13947835ede.42.1556976254830; 
	Sat, 04 May 2019 06:24:14 -0700 (PDT)
Received: from localhost.localdomain ([79.97.203.116])
	by smtp.gmail.com with ESMTPSA id
	s53sm1391106edb.20.2019.05.04.06.24.13
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sat, 04 May 2019 06:24:14 -0700 (PDT)
To: iommu@lists.linux-foundation.org
Subject: [RFC 0/7] Convert the Intel iommu driver to the dma-ops api
Date: Sat,  4 May 2019 14:23:16 +0100
Message-Id: <20190504132327.27041-1-tmurphy@arista.com>
X-Mailer: git-send-email 2.17.1
Cc: Heiko Stuebner <heiko@sntech.de>, kvm@vger.kernel.org,
	Will Deacon <will.deacon@arm.com>, David Brown <david.brown@linaro.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	linux-s390@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>, linux-rockchip@lists.infradead.org,
	Kukjin Kim <kgene@kernel.org>,
	Gerald Schaefer <gerald.schaefer@de.ibm.com>,
	Andy Gross <andy.gross@linaro.org>, linux-tegra@vger.kernel.org,
	Marc Zyngier <marc.zyngier@arm.com>, linux-arm-msm@vger.kernel.org,
	Alex Williamson <alex.williamson@redhat.com>,
	linux-mediatek@lists.infradead.org,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org,
	Tom Murphy <tmurphy@arista.com>, Robin Murphy <robin.murphy@arm.com>,
	linux-kernel@vger.kernel.org, murphyt7@tcd.ie,
	David Woodhouse <dwmw2@infradead.org>
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
From: Tom Murphy via iommu <iommu@lists.linux-foundation.org>
Reply-To: Tom Murphy <tmurphy@arista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

Convert the intel iommu driver to the dma-ops api so that we can remove a bunch of repeated code.

This patchset depends on the "iommu/vt-d: Delegate DMA domain to generic iommu" and
"iommu/amd: Convert the AMD iommu driver to the dma-iommu api" patch sets which haven't
yet merged so this is just a RFC to get some feedback before I do more testing.

Tom Murphy (7):
  iommu/vt-d: Set the dma_ops per device so we can remove the
    iommu_no_mapping code
  iommu/vt-d: Remove iova handling code from non-dma ops path
  iommu: improve iommu iotlb flushing
  iommu/dma-iommu: Handle freelists in the dma-iommu api path
  iommu/dma-iommu: add wrapper for iommu_dma_free_cpu_cached_iovas
  iommu/vt-d: convert the intel iommu driver to the dma-iommu ops api
  iommu/vt-d: Always set DMA_PTE_READ if the iommu doens't support zero
    length reads

 drivers/iommu/Kconfig           |   1 +
 drivers/iommu/amd_iommu.c       |  14 +-
 drivers/iommu/arm-smmu-v3.c     |   3 +-
 drivers/iommu/arm-smmu.c        |   2 +-
 drivers/iommu/dma-iommu.c       |  48 ++-
 drivers/iommu/exynos-iommu.c    |   3 +-
 drivers/iommu/intel-iommu.c     | 605 +++++---------------------------
 drivers/iommu/iommu.c           |  21 +-
 drivers/iommu/ipmmu-vmsa.c      |   2 +-
 drivers/iommu/msm_iommu.c       |   2 +-
 drivers/iommu/mtk_iommu.c       |   3 +-
 drivers/iommu/mtk_iommu_v1.c    |   3 +-
 drivers/iommu/omap-iommu.c      |   2 +-
 drivers/iommu/qcom_iommu.c      |   2 +-
 drivers/iommu/rockchip-iommu.c  |   2 +-
 drivers/iommu/s390-iommu.c      |   3 +-
 drivers/iommu/tegra-gart.c      |   2 +-
 drivers/iommu/tegra-smmu.c      |   2 +-
 drivers/vfio/vfio_iommu_type1.c |   3 +-
 include/linux/dma-iommu.h       |   3 +
 include/linux/intel-iommu.h     |   1 -
 include/linux/iommu.h           |  24 +-
 22 files changed, 175 insertions(+), 576 deletions(-)

-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
