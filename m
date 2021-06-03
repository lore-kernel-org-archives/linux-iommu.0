Return-Path: <SRS0=MHXQ=K5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07B9EC47096
	for <iommu@archiver.kernel.org>; Thu,  3 Jun 2021 16:45:11 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FE0F613B1
	for <iommu@archiver.kernel.org>; Thu,  3 Jun 2021 16:45:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FE0F613B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 66660401E6;
	Thu,  3 Jun 2021 16:45:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id W_Qn2sF-AR9f; Thu,  3 Jun 2021 16:45:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3A9AB4054D;
	Thu,  3 Jun 2021 16:45:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 070CEC000D;
	Thu,  3 Jun 2021 16:45:06 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B71BAC0001
 for <iommu@lists.linux-foundation.org>; Thu,  3 Jun 2021 16:45:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A59B54054F
 for <iommu@lists.linux-foundation.org>; Thu,  3 Jun 2021 16:45:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id g6akQdpGmmGp for <iommu@lists.linux-foundation.org>;
 Thu,  3 Jun 2021 16:45:00 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 by smtp2.osuosl.org (Postfix) with ESMTPS id AC07B401E6
 for <iommu@lists.linux-foundation.org>; Thu,  3 Jun 2021 16:45:00 +0000 (UTC)
Received: by mail-ej1-x62c.google.com with SMTP id l1so10218728ejb.6
 for <iommu@lists.linux-foundation.org>; Thu, 03 Jun 2021 09:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=rVr43q21YvffQjChkPWUcI2ScgfaIcHVrqYlABk7dec=;
 b=WQhBmtRwXgI6m5iQhMkj9hoEJVfreNZxFRV+7f9uqHbaNxKpFwYxHOuzlGhSFxSqDQ
 Z+caS2pe7ZUIRkggw/8uDPEpbgvxlD7MszlPTx3ChXn4j3L0I/iid8BExBNj1ntFffsP
 P8Wkzt/MXT5Dco56uZB3WD/1SrQ/CnTbBOp0ZFPkerWD0Ip7sEGvSHkKpYUGUcpw/Khu
 HDNssduz88YziRNdRKa0/hLBeyjEhowAVj3AMm7tWcACp6D0VXBlkiJ69FQVWOGKimJI
 h11S7zwozVjyAGp2OxoCqhu3+sfQ+EX7lZnR5Z6BUn4m9xl6wK5W6gibH9JTWS1u6yxH
 J04g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=rVr43q21YvffQjChkPWUcI2ScgfaIcHVrqYlABk7dec=;
 b=RdxxhlCzulvF0cKfjJjBWRAyRf7zTVWaEiXMoJtyA2SwHST37sxNO4zufc7/g4LJEP
 0Td5Yiw/RI/UJdFztx8JkK5LZ8MOE0wVUfP3yQO8/4jJZjy7zJv5/467x99fkvdIxSwE
 yadAWtn8X+smq3TudVl97nAlTE/Y4PAJe3XA+tjX6zygN6W+4dYCIBs8DDcUxQ7hZPBv
 aDGNIDb4+EUYAgagvLg193OqNzb4W0akhKapyAU4jBt2paFsgH0sgadLKNuwUp7hwGED
 yhHLkWuoxnpMujHACTqngILvuU/wJ+f0R2BkJGKpYj1867vUPkjIBkfMNpXPbBkX+WE6
 Mwhg==
X-Gm-Message-State: AOAM532Nb0rMfrPf4zeoBuyfXCp5ik8yF2Rga5zQueEvJphqfec/jaQx
 0vNSc3pKgEu/Ure0VHIdTi0=
X-Google-Smtp-Source: ABdhPJyxuKFzTXzdUUuuRg5+fasUmQpB/t2zP4zUfnwWo9ap4jiRhmDgHF8d2hjtKx2m6KQTLYRBhw==
X-Received: by 2002:a17:906:17d8:: with SMTP id
 u24mr308766eje.106.1622738698879; 
 Thu, 03 Jun 2021 09:44:58 -0700 (PDT)
Received: from localhost ([62.96.65.119])
 by smtp.gmail.com with ESMTPSA id m4sm1694353eje.8.2021.06.03.09.44.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Jun 2021 09:44:57 -0700 (PDT)
From: Thierry Reding <thierry.reding@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>, Will Deacon <will@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH v3 0/9] arm64: tegra: Prevent early SMMU faults
Date: Thu,  3 Jun 2021 18:46:23 +0200
Message-Id: <20210603164632.1000458-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Cc: iommu@lists.linux-foundation.org, Jon Hunter <jonathanh@nvidia.com>,
 Nicolin Chen <nicolinc@nvidia.com>, linux-tegra@vger.kernel.org,
 Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
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
this through device tree updates. Patch 10 (that was included in earlier
version to show how SMMU will be enabled for display controllers) has
been dropped for now while waiting for the identity mappings support to
land.

The end result is that various peripherals will have SMMU enabled, while
the display controllers will keep using passthrough, as initially set up
by firmware. Once the device tree bindings have been accepted and the
SMMU driver has been updated to create identity mappings for the display
controllers, they can be hooked up to the SMMU and the code in this
series will automatically program the SID overrides to enable SMMU
translations at the right time.

Will, Krzysztof: as discussed, it'd be best if Krzysztof picked up patch
1 into the memory controller tree on top of v3 of the driver unification
series I sent out earlier today and then sent out a PR for Will to merge
and apply patches 2-6. I can then take patches 7-9 in via the Tegra tree
since there are no hard dependencies.

Changes in v3:
- move hunk from patch 4 to patch 5 to preserve bisectibility

Changes in v2:
- split off the preparatory work into a separate series (that needs to
  be applied first)
- address review comments by Robin

Thierry

Thierry Reding (9):
  memory: tegra: Implement SID override programming
  dt-bindings: arm-smmu: Add Tegra186 compatible string
  iommu/arm-smmu: Implement ->probe_finalize()
  iommu/arm-smmu: tegra: Detect number of instances at runtime
  iommu/arm-smmu: tegra: Implement SID override programming
  iommu/arm-smmu: Use Tegra implementation on Tegra186
  arm64: tegra: Use correct compatible string for Tegra186 SMMU
  arm64: tegra: Hook up memory controller to SMMU on Tegra186
  arm64: tegra: Enable SMMU support on Tegra194

 .../devicetree/bindings/iommu/arm,smmu.yaml   | 11 ++-
 arch/arm64/boot/dts/nvidia/tegra186.dtsi      |  4 +-
 arch/arm64/boot/dts/nvidia/tegra194.dtsi      | 86 ++++++++++++++++++
 drivers/iommu/arm/arm-smmu/arm-smmu-impl.c    |  3 +-
 drivers/iommu/arm/arm-smmu/arm-smmu-nvidia.c  | 90 +++++++++++++++----
 drivers/iommu/arm/arm-smmu/arm-smmu.c         | 13 +++
 drivers/iommu/arm/arm-smmu/arm-smmu.h         |  1 +
 drivers/memory/tegra/mc.c                     |  9 ++
 drivers/memory/tegra/tegra186.c               | 72 +++++++++++++++
 include/soc/tegra/mc.h                        |  3 +
 10 files changed, 269 insertions(+), 23 deletions(-)

-- 
2.31.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
