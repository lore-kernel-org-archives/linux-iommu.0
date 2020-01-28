Return-Path: <SRS0=+4f7=3R=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0734C33CB3
	for <iommu@archiver.kernel.org>; Tue, 28 Jan 2020 22:16:28 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7550324687
	for <iommu@archiver.kernel.org>; Tue, 28 Jan 2020 22:16:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="m2lM55rT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7550324687
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 6C77086D81;
	Tue, 28 Jan 2020 22:16:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id z+R0S1M0kkRq; Tue, 28 Jan 2020 22:16:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 2BF4A86BB9;
	Tue, 28 Jan 2020 22:16:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 119FDC0175;
	Tue, 28 Jan 2020 22:16:26 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F3A00C0171
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jan 2020 22:16:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id E13CF87FE3
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jan 2020 22:16:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jW4ijf+tkQiK for <iommu@lists.linux-foundation.org>;
 Tue, 28 Jan 2020 22:16:23 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail26.static.mailgun.info (mail26.static.mailgun.info
 [104.130.122.26])
 by hemlock.osuosl.org (Postfix) with ESMTPS id BC66B87FD8
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jan 2020 22:16:22 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1580249783; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=i+aFwz/XZq1hLfURdhwYcNPvIQ+jYpVpqGRNNihkjB8=;
 b=m2lM55rTwVeChdXu7vUygppKDwdm6KdmdG5E21EORyucn82YyyOrnkivuELLVtC9pw+86KjT
 Jml/n+S6p6SEyXW2LhP/Dpnsa2lByt5LiKKbcpFvxWZXhXRZ63pJzx7NVFz28Yu3bvCO3BhS
 P3isUJ8GId7TS8FUUYTi6G3t2D0=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3NDkwMCIsICJpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e30b2b3.7ffa5e6f23b0-smtp-out-n03;
 Tue, 28 Jan 2020 22:16:19 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id B40E0C447A4; Tue, 28 Jan 2020 22:16:18 +0000 (UTC)
Received: from jcrouse1-lnx.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: jcrouse)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id B3BD1C433CB;
 Tue, 28 Jan 2020 22:16:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B3BD1C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 spf=none smtp.mailfrom=jcrouse@codeaurora.org
From: Jordan Crouse <jcrouse@codeaurora.org>
To: iommu@lists.linux-foundation.org
Subject: [PATCH v1 0/6] iommu/arm-smmu: Auxiliary domain and per instance
 pagetables
Date: Tue, 28 Jan 2020 15:16:04 -0700
Message-Id: <1580249770-1088-1-git-send-email-jcrouse@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Cc: freedreno@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
 will@kernel.org, Sharat Masetty <smasetty@codeaurora.org>,
 robin.murphy@arm.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>,
 linux-arm-msm@vger.kernel.org, Sean Paul <sean@poorly.run>,
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Some clients have a requirement to sandbox memory mappings for security and
advanced features like SVM. This series adds support to enable per-instance
pagetables as auxiliary domains in the arm-smmu driver and adds per-instance
support for the Adreno GPU.

This patchset builds on the split pagetable support from [1]. In that series the
TTBR1 address space is programmed for the default ("master") domain and enables
support for auxiliary domains. Each new auxiliary domain will allocate a
pagetable which the leaf driver can program through the usual IOMMU APIs. It can
also query the physical address of the pagetable.

In the SMMU driver the first auxiliary domain will enable and program the TTBR0
space. Subsequent auxiliary domains won't touch the hardware. Similarly when
the last auxiliary domain is detached the TTBR0 region will be disabled again.

In the Adreno driver each new file descriptor instance will create a new
auxiliary domain / pagetable and use it for all the memory allocations of that
instance. The driver will query the base address of each pagetable and switch
them dynamically using the built-in table switch capability of the GPU. If any
of these features fail the driver will automatically fall back to using the
default (global) pagetable.

This patchset had previously been submitted as [2] but has been significantly
modified since then.

Jordan

[1] https://lists.linuxfoundation.org/pipermail/iommu/2020-January/041438.html
[2] https://patchwork.freedesktop.org/series/57441/


Jordan Crouse (6):
  iommu: Add DOMAIN_ATTR_PTBASE
  arm/smmu: Add auxiliary domain support for arm-smmuv2
  drm/msm/adreno: ADd support for IOMMU auxiliary domains
  drm/msm: Add support to create target specific address spaces
  drm/msm/gpu: Add ttbr0 to the memptrs
  drm/msm/a6xx: Support per-instance pagetables

 drivers/gpu/drm/msm/adreno/a6xx_gpu.c |  89 +++++++++++++
 drivers/gpu/drm/msm/msm_drv.c         |  22 +++-
 drivers/gpu/drm/msm/msm_gpu.h         |   2 +
 drivers/gpu/drm/msm/msm_iommu.c       |  72 +++++++++++
 drivers/gpu/drm/msm/msm_mmu.h         |   3 +
 drivers/gpu/drm/msm/msm_ringbuffer.h  |   1 +
 drivers/iommu/arm-smmu.c              | 230 +++++++++++++++++++++++++++++++---
 drivers/iommu/arm-smmu.h              |   3 +
 include/linux/iommu.h                 |   2 +
 9 files changed, 405 insertions(+), 19 deletions(-)

-- 
2.7.4
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
