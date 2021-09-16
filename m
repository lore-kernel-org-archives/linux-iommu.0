Return-Path: <SRS0=vqUx=OG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E740C433EF
	for <iommu@archiver.kernel.org>; Thu, 16 Sep 2021 15:00:16 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9EF2610D1
	for <iommu@archiver.kernel.org>; Thu, 16 Sep 2021 15:00:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B9EF2610D1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 79B2882D57;
	Thu, 16 Sep 2021 15:00:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zDAn1Mo3KlVj; Thu, 16 Sep 2021 15:00:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 4514482BC4;
	Thu, 16 Sep 2021 15:00:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BC0C2C0020;
	Thu, 16 Sep 2021 15:00:13 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 98259C000F
 for <iommu@lists.linux-foundation.org>; Thu, 16 Sep 2021 15:00:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7644E60638
 for <iommu@lists.linux-foundation.org>; Thu, 16 Sep 2021 15:00:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kapsi.fi
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3vxQLrix9gah for <iommu@lists.linux-foundation.org>;
 Thu, 16 Sep 2021 15:00:09 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kapsi.fi (mail.kapsi.fi [IPv6:2001:67c:1be8::25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4588C605EF
 for <iommu@lists.linux-foundation.org>; Thu, 16 Sep 2021 15:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
 s=20161220; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject
 :Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=d1cgY/2N+xv4MXaoCUI+OScAKJ5zQNEwfP0dlNZNcwo=; b=hhsZ3vkUGaL+sVrLuQ7bHTvACd
 GKfadCvDHkZVUIQsXERWMUVyQ876cWqDP+Qrdbh3W+Ll9yY2lF+PVtXE+Y5MmuLaoiJARD+S+z6HP
 IRNxYjuB+bpCTOvUsWuBOYL25zAW60IaAyHbieK9DxnJuvPWyBm/eX02TBh2DEcnZjaxMZrNSDzYm
 mK3iftuOJCyd/1SZ22RxpdC8Ml/46TEQFSAQ6APGwSz9eLL7dA5e9gMIaxAL5AICPOPF6yBaI8/iq
 7yxAIDa27IVYxyRqys7ggAPjmeQ414pBEfz5epwJxno35xq4S175vunEYc6Q/ECnujXnZ9N3MPSBK
 WWnAUnYA==;
Received: from dsl-hkibng22-54f986-236.dhcp.inet.fi ([84.249.134.236]
 helo=toshino.localdomain)
 by mail.kapsi.fi with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.89) (envelope-from <mperttunen@nvidia.com>)
 id 1mQsRv-0005Xx-Mt; Thu, 16 Sep 2021 17:33:15 +0300
To: thierry.reding@gmail.com, jonathanh@nvidia.com, joro@8bytes.org,
 will@kernel.org, robh+dt@kernel.org, robin.murphy@arm.com
Subject: [PATCH v2 0/8] Host1x context isolation support
Date: Thu, 16 Sep 2021 17:32:54 +0300
Message-Id: <20210916143302.2024933-1-mperttunen@nvidia.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 84.249.134.236
X-SA-Exim-Mail-From: mperttunen@nvidia.com
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Mikko Perttunen <mperttunen@nvidia.com>,
 iommu@lists.linux-foundation.org, linux-tegra@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
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
From: Mikko Perttunen via iommu <iommu@lists.linux-foundation.org>
Reply-To: Mikko Perttunen <mperttunen@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Hi all,

***
New in v2:

Added support for Tegra194
Use standard iommu-map property instead of custom mechanism
***

this series adds support for Host1x 'context isolation'. Since
when programming engines through Host1x, userspace can program in
any addresses it wants, we need some way to isolate the engines'
memory spaces. Traditionally this has either been done imperfectly
with a single shared IOMMU domain, or by copying and verifying the
programming command stream at submit time (Host1x firewall).

Since Tegra186 there is a privileged (only usable by kernel)
Host1x opcode that allows setting the stream ID sent by the engine
to the SMMU. So, by allocating a number of context banks and stream
IDs for this purpose, and using this opcode at the beginning of
each job, we can implement isolation. Due to the limited number of
context banks only each process gets its own context, and not
each channel.

This feature also allows sharing engines among multiple VMs when
used with Host1x's hardware virtualization support - up to 8 VMs
can be configured with a subset of allowed stream IDs, enforced
at hardware level.

To implement this, this series adds a new host1x context bus, which
will contain the 'struct device's corresponding to each context
bank / stream ID, changes to device tree and SMMU code to allow
registering the devices and using the bus, as well as the Host1x
stream ID programming code and support in TegraDRM.

Device tree bindings are not updated yet pending consensus that the
proposed changes make sense.

Thanks,
Mikko

Mikko Perttunen (8):
  gpu: host1x: Add context bus
  gpu: host1x: Add context device management code
  gpu: host1x: Program context stream ID on submission
  iommu/arm-smmu: Attach to host1x context device bus
  arm64: tegra: Add Host1x context stream IDs on Tegra186+
  drm/tegra: falcon: Set DMACTX field on DMA transactions
  drm/tegra: vic: Implement get_streamid_offset
  drm/tegra: Support context isolation

 arch/arm64/boot/dts/nvidia/tegra186.dtsi  |  12 ++
 arch/arm64/boot/dts/nvidia/tegra194.dtsi  |  12 ++
 drivers/gpu/Makefile                      |   3 +-
 drivers/gpu/drm/tegra/drm.h               |   2 +
 drivers/gpu/drm/tegra/falcon.c            |   8 +
 drivers/gpu/drm/tegra/falcon.h            |   1 +
 drivers/gpu/drm/tegra/submit.c            |  13 ++
 drivers/gpu/drm/tegra/uapi.c              |  34 ++++-
 drivers/gpu/drm/tegra/vic.c               |  38 +++++
 drivers/gpu/host1x/Kconfig                |   5 +
 drivers/gpu/host1x/Makefile               |   2 +
 drivers/gpu/host1x/context.c              | 174 ++++++++++++++++++++++
 drivers/gpu/host1x/context.h              |  27 ++++
 drivers/gpu/host1x/context_bus.c          |  31 ++++
 drivers/gpu/host1x/dev.c                  |  12 +-
 drivers/gpu/host1x/dev.h                  |   2 +
 drivers/gpu/host1x/hw/channel_hw.c        |  52 ++++++-
 drivers/gpu/host1x/hw/host1x06_hardware.h |  10 ++
 drivers/gpu/host1x/hw/host1x07_hardware.h |  10 ++
 drivers/iommu/arm/arm-smmu/arm-smmu.c     |  13 ++
 include/linux/host1x.h                    |  21 +++
 include/linux/host1x_context_bus.h        |  15 ++
 22 files changed, 488 insertions(+), 9 deletions(-)
 create mode 100644 drivers/gpu/host1x/context.c
 create mode 100644 drivers/gpu/host1x/context.h
 create mode 100644 drivers/gpu/host1x/context_bus.c
 create mode 100644 include/linux/host1x_context_bus.h

-- 
2.32.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
