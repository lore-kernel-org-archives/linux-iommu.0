Return-Path: <SRS0=gpU2=JR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B714C433B4
	for <iommu@archiver.kernel.org>; Tue, 20 Apr 2021 17:25:45 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 917A7613C9
	for <iommu@archiver.kernel.org>; Tue, 20 Apr 2021 17:25:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 917A7613C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0D30E405C4;
	Tue, 20 Apr 2021 17:25:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FE-GAgj6eipn; Tue, 20 Apr 2021 17:25:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8C8C5405AF;
	Tue, 20 Apr 2021 17:25:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6126EC000E;
	Tue, 20 Apr 2021 17:25:42 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 63B3FC000B
 for <iommu@lists.linux-foundation.org>; Tue, 20 Apr 2021 17:25:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 57EAE83C24
 for <iommu@lists.linux-foundation.org>; Tue, 20 Apr 2021 17:25:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uf4bYVZXYJEa for <iommu@lists.linux-foundation.org>;
 Tue, 20 Apr 2021 17:25:38 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 44E7D83C23
 for <iommu@lists.linux-foundation.org>; Tue, 20 Apr 2021 17:25:38 +0000 (UTC)
Received: by mail-ej1-x635.google.com with SMTP id g5so52753259ejx.0
 for <iommu@lists.linux-foundation.org>; Tue, 20 Apr 2021 10:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=MZfyfBXmpvNOGNHqWWXvQz5+eKb6fUwiVC/YMxfDJi8=;
 b=AfzWpj6hX/iMxUb48cEJkEK0YRgyAjBf5fBCK2TNoF9pyNCIN2T4CIQjxQuDe1G3VN
 e/vfIN2h31KNtZmQz7EbEu73F6vcK6py91JzXWNXTf/rr4EEcgz54xluXRxlZPoPONeo
 SyA0KzfJrLGYySvbog4EvsWWlaspOP6oaKNNZrDNVJzgVU2eG9fy18wcF7+/+MSyP9Is
 JBLrQIXYeA2/n0IdTkw2FR7DWNXI+4p8B+jKhYRcBumY6cf5KU/Gsw0j0rtxEtgBz0Kd
 gqtV1HWJhXaU+gjM45g3EK6O+eJXsLyVOg35LD5JocBzNhLZq9511BiSzKdjfJoBKJwo
 nnGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=MZfyfBXmpvNOGNHqWWXvQz5+eKb6fUwiVC/YMxfDJi8=;
 b=FbNNvQ+moqt5Nj3sDE13etVpcp6AtxY5rkLNH0Wg/DP3ckc4gb8szpKMQHP1OZyX/v
 SKFzrYhSUJYyY5NxIxMz6hhhr/D+pe8V17Bi6a2wZKNcVDKyFImmIHy/4C0QB62FNAbc
 /y3eFBLFWPppWFYCakFgx2Kij8yMlOuOPow3KBV6kTy63Ki0Vmjscyp3SHLzIYV+nJMz
 JxUvWI1wow7sVrJcF0peu57UW3PC23cBIT+j6TrIim1ACrj4/Z6rEVzppSBdGlNbNzmO
 pwQZCmNO+KpJzdI6xdpDKLvLDb54zoeVRqWGZHAgN3nf00HwB7X/+JXxA2I+fy+NRmlj
 bD1g==
X-Gm-Message-State: AOAM533u9cDNh7yrYxqCl9yn/HUCEYrvEQn+uFJzPdJ8FY9fhUXFNdke
 BO+jo5huVcmXYPr/Nicc5Do=
X-Google-Smtp-Source: ABdhPJxWJBFuXcYSTbM8eR6TrJnZTuavdZJzbkEU6SplHF+bINy06dwOkdHRSe7eKzR1ZBcTG3tK8A==
X-Received: by 2002:a17:906:6683:: with SMTP id
 z3mr29161911ejo.390.1618939536557; 
 Tue, 20 Apr 2021 10:25:36 -0700 (PDT)
Received: from localhost ([62.96.65.119])
 by smtp.gmail.com with ESMTPSA id z6sm13250574ejp.86.2021.04.20.10.25.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Apr 2021 10:25:35 -0700 (PDT)
From: Thierry Reding <thierry.reding@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH v2 00/10] arm64: tegra: Prevent early SMMU faults
Date: Tue, 20 Apr 2021 19:26:09 +0200
Message-Id: <20210420172619.3782831-1-thierry.reding@gmail.com>
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

Compared to the original version of these patches, I've split the
preparatory work into a separate patch series because it became very
large and will be mostly uninteresting for this audience.

Patch 1 provides a mechanism to program SID overrides at runtime. Patch
2 updates the ARM SMMU device tree bindings to include the Tegra186
compatible string as suggested by Robin during review.

Patches 3 and 4 create the fundamentals in the SMMU driver to support
this and also make this functionality available on Tegra186. Patch 5
hooks the ARM SMMU up to the memory controller so that the memory client
stream ID overrides can be programmed at the right time.

Patch 6 extends this mechanism to Tegra186 and patches 7-9 enable all of
this through device tree updates. Patch 10 is included here to show how
SMMU will be enabled for display controllers. However, it cannot be
applied yet because the code to create identity mappings for potentially
live framebuffers hasn't been merged yet.

The end result is that various peripherals will have SMMU enabled, while
the display controllers will keep using passthrough, as initially set up
by firmware. Once the device tree bindings have been accepted and the
SMMU driver has been updated to create identity mappings for the display
controllers, they can be hooked up to the SMMU and the code in this
series will automatically program the SID overrides to enable SMMU
translations at the right time.

Note that the series creates a compile time dependency between the
memory controller and IOMMU trees. If it helps I can provide a branch
for each tree, modelling the dependency, once the series has been
reviewed.

Changes in v2:
- split off the preparatory work into a separate series (that needs to
  be applied first)
- address review comments by Robin

Thierry

Thierry Reding (10):
  memory: tegra: Implement SID override programming
  dt-bindings: arm-smmu: Add Tegra186 compatible string
  iommu/arm-smmu: Implement ->probe_finalize()
  iommu/arm-smmu: tegra: Detect number of instances at runtime
  iommu/arm-smmu: tegra: Implement SID override programming
  iommu/arm-smmu: Use Tegra implementation on Tegra186
  arm64: tegra: Use correct compatible string for Tegra186 SMMU
  arm64: tegra: Hook up memory controller to SMMU on Tegra186
  arm64: tegra: Enable SMMU support on Tegra194
  arm64: tegra: Enable SMMU support for display on Tegra194

 .../devicetree/bindings/iommu/arm,smmu.yaml   |  11 +-
 arch/arm64/boot/dts/nvidia/tegra186.dtsi      |   4 +-
 arch/arm64/boot/dts/nvidia/tegra194.dtsi      | 166 ++++++++++++++++++
 drivers/iommu/arm/arm-smmu/arm-smmu-impl.c    |   3 +-
 drivers/iommu/arm/arm-smmu/arm-smmu-nvidia.c  |  90 ++++++++--
 drivers/iommu/arm/arm-smmu/arm-smmu.c         |  13 ++
 drivers/iommu/arm/arm-smmu/arm-smmu.h         |   1 +
 drivers/memory/tegra/mc.c                     |   9 +
 drivers/memory/tegra/tegra186.c               |  72 ++++++++
 include/soc/tegra/mc.h                        |   3 +
 10 files changed, 349 insertions(+), 23 deletions(-)

-- 
2.30.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
