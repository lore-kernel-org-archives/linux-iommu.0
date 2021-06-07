Return-Path: <SRS0=ynGH=LB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3494AC4743C
	for <iommu@archiver.kernel.org>; Mon,  7 Jun 2021 08:49:28 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C042061164
	for <iommu@archiver.kernel.org>; Mon,  7 Jun 2021 08:49:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C042061164
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 81E6B831DA;
	Mon,  7 Jun 2021 08:49:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id G0ApQmwLJ1Ro; Mon,  7 Jun 2021 08:49:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id E99F0831E7;
	Mon,  7 Jun 2021 08:49:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C1260C000D;
	Mon,  7 Jun 2021 08:49:22 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 72BCCC0001
 for <iommu@lists.linux-foundation.org>; Mon,  7 Jun 2021 08:49:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4C05C831DA
 for <iommu@lists.linux-foundation.org>; Mon,  7 Jun 2021 08:49:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7HPvjkhHK_mw for <iommu@lists.linux-foundation.org>;
 Mon,  7 Jun 2021 08:49:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DFC238322A
 for <iommu@lists.linux-foundation.org>; Mon,  7 Jun 2021 08:49:16 +0000 (UTC)
Received: from mail-wr1-f70.google.com ([209.85.221.70])
 by youngberry.canonical.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.93)
 (envelope-from <krzysztof.kozlowski@canonical.com>)
 id 1lqAwc-0004kr-NS
 for iommu@lists.linux-foundation.org; Mon, 07 Jun 2021 08:49:14 +0000
Received: by mail-wr1-f70.google.com with SMTP id
 s8-20020adff8080000b0290114e1eeb8c6so7543631wrp.23
 for <iommu@lists.linux-foundation.org>; Mon, 07 Jun 2021 01:49:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=cZ1PobqwBPaq9OP1zdBWQXQtgWjqazmERJP5g1G4lIo=;
 b=W9HH+8iTTQdwwvptE+BUU3q5nKYUelct+D1RbPwblVLGNLC83P62Py0jihvbV4BGlc
 ZrR5FMv41VD1X/HFQyjIIlVUVsg7/1TRxT9PBnGVHVOfOBv1Q9c2zYJoCzaCBrX3Pz+n
 oQKzmlbmeTmMGNyRBfyFJuDU9IrcLMhZauN5qsPosG5zmybi7/R1tfSjpRW1wjhpVSCn
 tD3LL3+JwO5E1zb2bF0baeoPLJWbOlzHfIphrGRWQb3kMtfjoyfPu84zKnEVao+m5iYP
 kQdnYfO7YGR6z+IkkPVB3vaUGQNEoVekT1XZ/GjyVTF3rfgZqA1xcsAAIlYsyBw7HOzS
 IvKQ==
X-Gm-Message-State: AOAM531HP+lZu9g6JRI6quzxyV6FoAYVl5pkh3nJXMbTraYyzpORpnT/
 q5wq3eYa8xIv4cQLAYXTt7KN89rRcdkcDO4/z6nRlIZxkFt1K4yzf50nUt1mqYmzBXryKKAZ/TY
 PB34xCZ1HkencfP7NP7YTBURv1VBBiVjGBGLj20CSE+1tkIY=
X-Received: by 2002:a05:6000:18a8:: with SMTP id
 b8mr15594916wri.208.1623055754370; 
 Mon, 07 Jun 2021 01:49:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzA7m3LT7tZJSbZni7ARguVUZ0E3Tcg3okMcx3uwOvjUO9dttwrLYXz7AJDCS5ICKmPinUN0w==
X-Received: by 2002:a05:6000:18a8:: with SMTP id
 b8mr15594895wri.208.1623055754224; 
 Mon, 07 Jun 2021 01:49:14 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-185-9.adslplus.ch.
 [188.155.185.9])
 by smtp.gmail.com with ESMTPSA id k16sm13380079wmr.42.2021.06.07.01.49.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Jun 2021 01:49:13 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
List-Id: <soc.lore.kernel.org>
To: Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
 arm@kernel.org, soc@kernel.org
Subject: [GIT PULL] memory: Tegra memory controller for v5.14
Date: Mon,  7 Jun 2021 10:49:10 +0200
Message-Id: <20210607084910.21024-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
 Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzk@kernel.org>, Jon Hunter <jonathanh@nvidia.com>,
 iommu@lists.linux-foundation.org, Thierry Reding <thierry.reding@gmail.com>,
 Nicolin Chen <nicolinc@nvidia.com>, linux-tegra@vger.kernel.org,
 Dmitry Osipenko <digetx@gmail.com>, Robin Murphy <robin.murphy@arm.com>,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Hi Olof and Arnd,

Tegra memory controller driver changes with necessary dependency from Thierry
(which you will also get from him):
1. Dmitry's power domain work on Tegra MC drivers,
2. Necessary clock and regulator dependencies for Dmitry's work.


Hi Thierry and Will,

This is the pull for you to base further SMMU aptches (prevent early SMMU
faults).

Best regards,
Krzysztof


The following changes since commit 6efb943b8616ec53a5e444193dccf1af9ad627b5:

  Linux 5.13-rc1 (2021-05-09 14:17:44 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux-mem-ctrl.git tags/memory-controller-drv-tegra-5.14

for you to fetch changes up to 393d66fd2cacba3e6aa95d7bb38790bfb7b1cc3a:

  memory: tegra: Implement SID override programming (2021-06-03 21:50:43 +0200)

----------------------------------------------------------------
Memory controller drivers for v5.14 - Tegra SoC

1. Enable compile testing of Tegra memory controller drivers.
2. Unify Tegra memory controller drivers. From Thierry Reding:
   "This set of patches converges the feature sets of the pre-Tegra186
   and the post-Tegra186 memory controller drivers such that newer chips
   can take advantage of some features that were previously only
   implemented on earlier chips."
3. Implement SID override programming as part of work to prevent early
   SMMU faults.
4. Some simplifications, e.g. use devm-helpers.

This pulls dedicated tag from Thierry Reding with necessary changes to
Tegra memory controller drivers, as a pre-requisite to series applied
here.  The changes from Thierry's tree also include their own
dependencies: regulator and clock driver changes.

----------------------------------------------------------------
Dmitry Osipenko (18):
      clk: tegra30: Use 300MHz for video decoder by default
      clk: tegra: Fix refcounting of gate clocks
      clk: tegra: Ensure that PLLU configuration is applied properly
      clk: tegra: Halve SCLK rate on Tegra20
      clk: tegra: Don't allow zero clock rate for PLLs
      clk: tegra: cclk: Handle thermal DIV2 CPU frequency throttling
      clk: tegra: Mark external clocks as not having reset control
      clk: tegra: Don't deassert reset on enabling clocks
      regulator: core: Add regulator_sync_voltage_rdev()
      soc/tegra: regulators: Bump voltages on system reboot
      soc/tegra: Add stub for soc_is_tegra()
      soc/tegra: Add devm_tegra_core_dev_init_opp_table()
      soc/tegra: fuse: Add stubs needed for compile-testing
      clk: tegra: Add stubs needed for compile-testing
      memory: tegra: Fix compilation warnings on 64bit platforms
      memory: tegra: Enable compile testing for all drivers
      memory: tegra20-emc: Use devm_tegra_core_dev_init_opp_table()
      memory: tegra30-emc: Use devm_tegra_core_dev_init_opp_table()

Krzysztof Kozlowski (1):
      Merge tag 'tegra-for-5.14-memory' of https://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux into for-v5.14/tegra-mc

Thierry Reding (16):
      Merge branch 'for-5.14/regulator' into for-5.14/soc
      Merge branch 'for-5.14/clk' into for-5.14/memory
      Merge branch 'for-5.14/soc' into for-5.14/memory
      memory: tegra: Consolidate register fields
      memory: tegra: Unify struct tegra_mc across SoC generations
      memory: tegra: Introduce struct tegra_mc_ops
      memory: tegra: Push suspend/resume into SoC drivers
      memory: tegra: Make per-SoC setup more generic
      memory: tegra: Extract setup code into callback
      memory: tegra: Parameterize interrupt handler
      memory: tegra: Make IRQ support opitonal
      memory: tegra: Only initialize reset controller if available
      memory: tegra: Unify drivers
      memory: tegra: Add memory client IDs to tables
      memory: tegra: Split Tegra194 data into separate file
      memory: tegra: Implement SID override programming

 drivers/clk/tegra/clk-periph-gate.c      |   80 +-
 drivers/clk/tegra/clk-periph.c           |   11 +
 drivers/clk/tegra/clk-pll.c              |   12 +-
 drivers/clk/tegra/clk-tegra-periph.c     |    6 +-
 drivers/clk/tegra/clk-tegra-super-cclk.c |   16 +-
 drivers/clk/tegra/clk-tegra20.c          |    6 +-
 drivers/clk/tegra/clk-tegra30.c          |    6 +-
 drivers/clk/tegra/clk.h                  |    4 -
 drivers/iommu/tegra-smmu.c               |   16 +-
 drivers/memory/tegra/Kconfig             |   18 +-
 drivers/memory/tegra/Makefile            |    6 +-
 drivers/memory/tegra/mc.c                |  321 +++---
 drivers/memory/tegra/mc.h                |   25 +
 drivers/memory/tegra/tegra114.c          | 1245 ++++++++++++----------
 drivers/memory/tegra/tegra124-emc.c      |    4 +-
 drivers/memory/tegra/tegra124.c          | 1306 ++++++++++++-----------
 drivers/memory/tegra/tegra186.c          | 1679 +++++++++---------------------
 drivers/memory/tegra/tegra194.c          | 1351 ++++++++++++++++++++++++
 drivers/memory/tegra/tegra20-emc.c       |   48 +-
 drivers/memory/tegra/tegra20.c           |  110 +-
 drivers/memory/tegra/tegra210.c          | 1433 +++++++++++++------------
 drivers/memory/tegra/tegra30-emc.c       |   52 +-
 drivers/memory/tegra/tegra30.c           | 1292 ++++++++++++-----------
 drivers/regulator/core.c                 |   23 +
 drivers/soc/tegra/common.c               |   97 ++
 drivers/soc/tegra/pmc.c                  |    5 -
 drivers/soc/tegra/regulators-tegra20.c   |   75 +-
 drivers/soc/tegra/regulators-tegra30.c   |   75 +-
 include/linux/clk/tegra.h                |  100 +-
 include/linux/regulator/driver.h         |    1 +
 include/soc/tegra/common.h               |   31 +
 include/soc/tegra/fuse.h                 |   20 +-
 include/soc/tegra/mc.h                   |   65 +-
 33 files changed, 5566 insertions(+), 3973 deletions(-)
 create mode 100644 drivers/memory/tegra/tegra194.c
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
