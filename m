Return-Path: <SRS0=Fh/M=IX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_RED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F7AFC433DB
	for <iommu@archiver.kernel.org>; Thu, 25 Mar 2021 13:03:23 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A95161A1B
	for <iommu@archiver.kernel.org>; Thu, 25 Mar 2021 13:03:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A95161A1B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0F603401B8;
	Thu, 25 Mar 2021 13:03:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id N0dRue6awrAE; Thu, 25 Mar 2021 13:03:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id E3CE14016B;
	Thu, 25 Mar 2021 13:03:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A4CEBC000D;
	Thu, 25 Mar 2021 13:03:21 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1FEA2C000A
 for <iommu@lists.linux-foundation.org>; Thu, 25 Mar 2021 13:03:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E321D401B8
 for <iommu@lists.linux-foundation.org>; Thu, 25 Mar 2021 13:03:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RFzGWAKLdwZV for <iommu@lists.linux-foundation.org>;
 Thu, 25 Mar 2021 13:03:19 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 124C54016B
 for <iommu@lists.linux-foundation.org>; Thu, 25 Mar 2021 13:03:18 +0000 (UTC)
Received: by mail-wm1-x32a.google.com with SMTP id
 n11-20020a05600c4f8bb029010e5cf86347so4315537wmq.1
 for <iommu@lists.linux-foundation.org>; Thu, 25 Mar 2021 06:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=H2WPu7kAL1q4h+0RYh+mqLBhq3ffqKO8EiTzgDurYuc=;
 b=Ml9c/DvziLIkmKNowFExNd4w3KMaGGvXTDaHY2sDavPTbklrdO0CdS9uYSw/Mhi7xy
 fsMvkc4uFIYWeqXGRmeBnUj+KB24waK5LibuOLmEmGDjXKoXOhdqoWNu4s7nOvWNy8xB
 ykwKiorHS6zPip0fdkZ9jjtXU5hShV+GYBLpJOYC03pO0Q2eKqFqOdHOpndc4uFm4uF4
 nkTQKk4w89gwyH2sTkEKc7BQDFiH8bqjqbGRiyDuwRulWMuOJUvHjRyIyLnfZRBMpPpg
 mH7MZoIrnM+NWS+2wkhUkEdqaRvlXQPcE4SjBWYIgOQUk5Mb0gV1KCXlUnw0S20SJJ9Q
 3jgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=H2WPu7kAL1q4h+0RYh+mqLBhq3ffqKO8EiTzgDurYuc=;
 b=YRZWcA9lZkih79tG17Nvuku7/Rgb7CXOzRjRhux92d2eH8iZ5+lXa8mUlefEMhuwJ4
 Kpr0bIlJ3ZjPl27Dwj/LrSgjF85pz6O4FADlZM9lCdPpZuej4qpQ0UQKK8wgEaWeDx2N
 3L40woAmww8BJ8LpH5GfR7qLjIwWp5fFvC7NIAmki+uQvZk8OkM2RyR1LiXJg8+VxxoF
 pV651N9pWWUra61TYFNvclPhPcDt2OvRz65sUq7xZYkFmVyLwuV0PLYJqSAB2f6JeI0c
 c5Rpc9yIRhC71PgAgqTTmEzyn0LikS4dTvG7rfXq01VvDxeC9Qu9puFObYpAql/mRr3J
 CqGg==
X-Gm-Message-State: AOAM533eZMncnQQQIpmH+qOOpFHT4yyqF1KglfXbpv57b61hwbumMSKP
 V7CdisJMHszUPsFrcuXARgY=
X-Google-Smtp-Source: ABdhPJwBE80kgdsbJqdbbvbPWZsiA5GMuJ2QHWb4YxLiisgVdPuYlebUysJdTajlINmwR56phghGyA==
X-Received: by 2002:a1c:c20a:: with SMTP id s10mr7873916wmf.144.1616677396065; 
 Thu, 25 Mar 2021 06:03:16 -0700 (PDT)
Received: from localhost ([62.96.65.119])
 by smtp.gmail.com with ESMTPSA id h9sm6317280wmb.35.2021.03.25.06.03.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Mar 2021 06:03:14 -0700 (PDT)
From: Thierry Reding <thierry.reding@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH 0/9] arm64: tegra: Prevent early SMMU faults
Date: Thu, 25 Mar 2021 14:03:23 +0100
Message-Id: <20210325130332.778208-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Cc: iommu@lists.linux-foundation.org, Jon Hunter <jonathanh@nvidia.com>,
 Nicolin Chen <nicolinc@nvidia.com>, linux-tegra@vger.kernel.org,
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

From: Thierry Reding <treding@nvidia.com>

Hi,

this is a set of patches that is the result of earlier discussions
regarding early identity mappings that are needed to avoid SMMU faults
during early boot.

The goal here is to avoid early identity mappings altogether and instead
postpone the need for the identity mappings to when devices are attached
to the SMMU. This works by making the SMMU driver coordinate with the
memory controller driver on when to start enforcing SMMU translations.
This makes Tegra behave in a more standard way and pushes the code to
deal with the Tegra-specific programming into the NVIDIA SMMU
implementation.

Patches 1 and 2 are preparatory work that is used in patch 3 to provide
a mechanism to program SID overrides at runtime. Patches 4 and 5 create
the fundamentals in the SMMU driver to support this and also make this
functionality available on Tegra186. Patch 6 hooks the ARM SMMU up to
the memory controller so that the memory overrides can be programmed at
the right time.

Patch 7 extends this mechanism to Tegra186 and patches 8-9 enable all of
this through device tree updates.

The end result is that various peripherals will have SMMU enabled, while
the display controllers will keep using passthrough, as initially set up
by firmware. Once the device tree bindings have been accepted and the
SMMU driver has been updated to create identity mappings for the display
controllers, they can be hooked up to the SMMU and the code in this
series will automatically program the SID overrides to enable SMMU
translations at the right time.

Thierry

Thierry Reding (9):
  memory: tegra: Move internal data structures into separate header
  memory: tegra: Add memory client IDs to tables
  memory: tegra: Implement SID override programming
  iommu/arm-smmu: Implement ->probe_finalize()
  iommu/arm-smmu: tegra: Detect number of instances at runtime
  iommu/arm-smmu: tegra: Implement SID override programming
  iommu/arm-smmu: Use Tegra implementation on Tegra186
  arm64: tegra: Hook up memory controller to SMMU on Tegra186
  arm64: tegra: Enable SMMU support on Tegra194

 arch/arm64/boot/dts/nvidia/tegra186.dtsi     |   2 +
 arch/arm64/boot/dts/nvidia/tegra194.dtsi     |  86 ++++++
 drivers/iommu/arm/arm-smmu/arm-smmu-impl.c   |   3 +-
 drivers/iommu/arm/arm-smmu/arm-smmu-nvidia.c |  81 ++++--
 drivers/iommu/arm/arm-smmu/arm-smmu.c        |  17 ++
 drivers/iommu/arm/arm-smmu/arm-smmu.h        |   1 +
 drivers/iommu/tegra-gart.c                   |   2 +-
 drivers/iommu/tegra-smmu.c                   |   2 +-
 drivers/memory/tegra/mc.h                    |   2 +-
 drivers/memory/tegra/tegra186.c              | 288 ++++++++++++++++++-
 include/soc/tegra/mc-internal.h              |  62 ++++
 include/soc/tegra/mc.h                       |  60 +---
 12 files changed, 529 insertions(+), 77 deletions(-)
 create mode 100644 include/soc/tegra/mc-internal.h

-- 
2.30.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
