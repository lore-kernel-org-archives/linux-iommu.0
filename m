Return-Path: <SRS0=D+h4=F2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A43ECC433DB
	for <iommu@archiver.kernel.org>; Tue, 22 Dec 2020 00:45:02 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A89822AED
	for <iommu@archiver.kernel.org>; Tue, 22 Dec 2020 00:45:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A89822AED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id D47FC8689B;
	Tue, 22 Dec 2020 00:45:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HWCOYL3O5b0Q; Tue, 22 Dec 2020 00:44:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 6B1E68665F;
	Tue, 22 Dec 2020 00:44:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 58188C1787;
	Tue, 22 Dec 2020 00:44:58 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A7E6CC0893
 for <iommu@lists.linux-foundation.org>; Tue, 22 Dec 2020 00:44:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id A15EB8695F
 for <iommu@lists.linux-foundation.org>; Tue, 22 Dec 2020 00:44:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4cXXI5PrQ-25 for <iommu@lists.linux-foundation.org>;
 Tue, 22 Dec 2020 00:44:55 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from so254-31.mailgun.net (so254-31.mailgun.net [198.61.254.31])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 656F786930
 for <iommu@lists.linux-foundation.org>; Tue, 22 Dec 2020 00:44:54 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1608597895; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=5QqKTkS2soo2qWsEDKwLX6CMQA26eceY3bgJcreaYHE=;
 b=KPdDdOtmuRBgEi6tmI7Fcj84Wi0hg/zNb6MrRbIor8ri+tA1uSJvHrjGymukadOu4RaGF/3M
 /XhbB0erZEpMzJhXQM5YbAwCHtIvLfrbuWY0WydV8isbnckGmmORO/Jv7+ZEKkxWfP+UWCS7
 RSHHgpA4dylBdP3YQld568ZriLQ=
X-Mailgun-Sending-Ip: 198.61.254.31
X-Mailgun-Sid: WyI3NDkwMCIsICJpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 5fe1417e6d2f42c6668cb1da (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 22 Dec 2020 00:44:46
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id 839D0C43467; Tue, 22 Dec 2020 00:44:45 +0000 (UTC)
Received: from isaacm-linux.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: isaacm)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 10AF8C433C6;
 Tue, 22 Dec 2020 00:44:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 10AF8C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 spf=fail smtp.mailfrom=isaacm@codeaurora.org
From: "Isaac J. Manjarres" <isaacm@codeaurora.org>
To: iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, freedreno@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org
Subject: [RFC PATCH v2 0/7] iommu: Permit modular builds of io-pgtable drivers
Date: Mon, 21 Dec 2020 16:44:29 -0800
Message-Id: <1608597876-32367-1-git-send-email-isaacm@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Cc: "Isaac J. Manjarres" <isaacm@codeaurora.org>, will@kernel.org,
 pdaly@codeaurora.org, kernel-team@android.com, robin.murphy@arm.com,
 pratikp@codeaurora.org
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

The goal of the Generic Kernel Image (GKI) effort is to have a common
kernel image that works across multiple Android devices. This involves
generating a kernel image that has core features integrated into it,
while SoC specific functionality can be added to the kernel for the
device as a module.

Along with modularizing IOMMU drivers, this also means building the
io-pgtable code as modules, which allows for SoC vendors to only include
the io-pgtable implementations that they use. For example, GKI for arm64
must include support for both the IOMMU ARM LPAE/V7S formats at the
moment. Having the code for both formats as modules allows SoC vendors
to only provide the page table format that they use, along with their
IOMMU driver.

Main changes since v1:

1) Retain io-pgtable.c as part of the core kernel

The patches are split into 4 parts:

1) Modularizing io-pgtable-arm[-v7s].c, while leaving the io-pgtable.c
code as part of the core kernel, requires removing the references to
the ARM LPAE and ARM V7S io-pgtable init functions, and using a
dynamic method for formats to register their io-pgtable init functions.

The reason for defining an io_pgtable_init_fns_node structure is to
not have the data structures used to store the init functions seep into
the io-pgtable fmt drivers. Doing so allows for changing the internal
data structure used to keep track of the init functions, without impacting
the client data structures.

2) Taking references to the io-pgtable format drivers to ensure that they
cannot be unloaded while in use.

3) Adding pre MODULE_SOFTDEP() dependencies to drivers in the kernel
that are tristate, and invoke [alloc/free]_io_pgtable_ops(). This makes
it so that the io-pgtable format drivers are loaded before the driver
that needs them.

4) Changing the Kconfig options for the ARM LPAE nad ARM V7S to tristate.

Thanks in advance for the feedback,

Isaac J. Manjarres

Isaac J. Manjarres (7):
  iommu/io-pgtable: Introduce dynamic io-pgtable fmt registration
  iommu/io-pgtable: Add refcounting for io-pgtable format modules
  iommu/arm-smmu: Add dependency on io-pgtable format modules
  iommu/arm-smmu-v3: Add dependency on io-pgtable-arm format module
  drm/msm: Add dependency on io-pgtable-arm format module
  drm/panfrost: Add dependency on io-pgtable-arm format module
  iommu/io-pgtable-arm: Allow building modular io-pgtable fmts

 drivers/gpu/drm/msm/msm_drv.c               |   1 +
 drivers/gpu/drm/panfrost/panfrost_drv.c     |   1 +
 drivers/iommu/Kconfig                       |   4 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c |   1 +
 drivers/iommu/arm/arm-smmu/arm-smmu.c       |   1 +
 drivers/iommu/io-pgtable-arm-v7s.c          |  37 +++++++++-
 drivers/iommu/io-pgtable-arm.c              |  97 +++++++++++++++++++-------
 drivers/iommu/io-pgtable.c                  | 104 +++++++++++++++++++++++-----
 include/linux/io-pgtable.h                  |  53 +++++++++-----
 9 files changed, 236 insertions(+), 63 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
