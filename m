Return-Path: <SRS0=FWOh=HO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F5C6C433E0
	for <iommu@archiver.kernel.org>; Fri, 12 Feb 2021 10:59:20 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9494864E2D
	for <iommu@archiver.kernel.org>; Fri, 12 Feb 2021 10:59:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9494864E2D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3E13E6F665
	for <iommu@archiver.kernel.org>; Fri, 12 Feb 2021 10:59:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id k0UC0ncYvloc for <iommu@archiver.kernel.org>;
	Fri, 12 Feb 2021 10:59:18 +0000 (UTC)
Received: by smtp3.osuosl.org (Postfix, from userid 1001)
	id 3AC316F5D3; Fri, 12 Feb 2021 10:59:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id B66396F5E0;
	Fri, 12 Feb 2021 10:59:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8DBDAC0174;
	Fri, 12 Feb 2021 10:59:15 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8F34AC013A;
 Fri, 12 Feb 2021 10:59:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7BFA36F5D3;
 Fri, 12 Feb 2021 10:59:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vNduFG-aV-fC; Fri, 12 Feb 2021 10:59:13 +0000 (UTC)
Received: by smtp3.osuosl.org (Postfix, from userid 1001)
 id 93A576F5E1; Fri, 12 Feb 2021 10:59:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp3.osuosl.org (Postfix) with ESMTP id BA4266F5D3;
 Fri, 12 Feb 2021 10:59:11 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E3658113E;
 Fri, 12 Feb 2021 02:59:10 -0800 (PST)
Received: from usa.arm.com (a074945.blr.arm.com [10.162.16.71])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9843B3F719;
 Fri, 12 Feb 2021 02:59:06 -0800 (PST)
From: Vivek Gautam <vivek.gautam@arm.com>
To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux-foundation.org, virtualization@lists.linux-foundation.org
Subject: [PATCH 0/2] Domain nesting info for arm-smmu
Date: Fri, 12 Feb 2021 16:28:57 +0530
Message-Id: <20210212105859.8445-1-vivek.gautam@arm.com>
X-Mailer: git-send-email 2.17.1
Cc: jean-philippe@linaro.org, kevin.tian@intel.com, mst@redhat.com,
 will.deacon@arm.com, alex.williamson@redhat.com, robin.murphy@arm.com
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

These couple of patches are adding nesting information for arm
and are based on the domain nesting info patches by Yi [1,2,3].

Based on the discussion in the thread [4], sending these out as
I have been using in my tree [5] for nested translation based
on virtio-iommu on Arm reference platforms.

Thanks & regards
Vivek

[1] https://lore.kernel.org/kvm/1599734733-6431-2-git-send-email-yi.l.liu@intel.com/
[2] https://lore.kernel.org/kvm/1599734733-6431-3-git-send-email-yi.l.liu@intel.com/
[3] https://lore.kernel.org/kvm/1599734733-6431-4-git-send-email-yi.l.liu@intel.com/
[4] https://lore.kernel.org/kvm/306e7dd2-9eb2-0ca3-6a93-7c9aa0821ce9@arm.com/
[5] https://github.com/vivek-arm/linux/tree/5.11-rc3-nested-pgtbl-arm-smmuv3-virtio-iommu

Vivek Gautam (2):
  iommu: Report domain nesting info for arm-smmu-v3
  iommu: arm-smmu-v3: Report domain nesting info reuqired for stage1

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 16 +++++++++--
 include/uapi/linux/iommu.h                  | 31 +++++++++++++++++----
 2 files changed, 39 insertions(+), 8 deletions(-)

-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
