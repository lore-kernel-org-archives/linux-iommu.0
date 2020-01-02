Return-Path: <SRS0=eP4Y=2X=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03851C2D0DC
	for <iommu@archiver.kernel.org>; Thu,  2 Jan 2020 11:02:33 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB80C215A4
	for <iommu@archiver.kernel.org>; Thu,  2 Jan 2020 11:02:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="gGDN7WHu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB80C215A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 8E57285C6F;
	Thu,  2 Jan 2020 11:02:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CnFKaajMvPwD; Thu,  2 Jan 2020 11:02:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id DCC0F82575;
	Thu,  2 Jan 2020 11:02:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B3780C1D80;
	Thu,  2 Jan 2020 11:02:31 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AB4E6C077D
 for <iommu@lists.linux-foundation.org>; Thu,  2 Jan 2020 11:02:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 91E9185C19
 for <iommu@lists.linux-foundation.org>; Thu,  2 Jan 2020 11:02:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1UpbF1s7VwoJ for <iommu@lists.linux-foundation.org>;
 Thu,  2 Jan 2020 11:02:28 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail26.static.mailgun.info (mail26.static.mailgun.info
 [104.130.122.26])
 by whitealder.osuosl.org (Postfix) with ESMTPS id BAE3785B95
 for <iommu@lists.linux-foundation.org>; Thu,  2 Jan 2020 11:02:28 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1577962948; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=tkKCPLe79npIk6waelmBeTcR6XDop2zkLNOKqt/0Dq0=;
 b=gGDN7WHuabmV5XpJNk/hUOib0fK82QPh64/wjG3Y7JbwfzOTs2BSTqrlAaPhgHFnWj1vzeGh
 80pshInHzIzKdtuHte2ioOibjPBmd8R2XNY0Fq+QGJSbpbinbPBh9zcRmE5+x4AZ2ME1baAq
 ggju27OjwHBu+cXuY7pIbmk3uJQ=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3NDkwMCIsICJpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e0dcdc2.7f9b2d301538-smtp-out-n02;
 Thu, 02 Jan 2020 11:02:26 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id 3F65AC4479F; Thu,  2 Jan 2020 11:02:26 +0000 (UTC)
Received: from smasetty-linux.qualcomm.com
 (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: smasetty)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id C9813C43383;
 Thu,  2 Jan 2020 11:02:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C9813C43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 spf=none smtp.mailfrom=smasetty@codeaurora.org
From: Sharat Masetty <smasetty@codeaurora.org>
To: freedreno@lists.freedesktop.org
Subject: [PATCH v2 0/7] drm/msm/a6xx: System Cache Support
Date: Thu,  2 Jan 2020 16:32:06 +0530
Message-Id: <1577962933-13577-1-git-send-email-smasetty@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Cc: will@kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 dri-devel@freedesktop.org, robin.murphy@arm.com,
 Sharat Masetty <smasetty@codeaurora.org>
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

Some hardware variants contain a system level cache or the last level
cache(llc). This cache is typically a large block which is shared by multiple
clients on the SOC. GPU uses the system cache to cache both the GPU data
buffers(like textures) as well the SMMU pagetables. This helps with
improved render performance as well as lower power consumption by reducing
the bus traffic to the system memory.

The system cache architecture allows the cache to be split into slices which
then be used by multiple SOC clients. This patch series is an effort to enable
and use two of those slices perallocated for the GPU, one for the GPU data
buffers and another for the GPU SMMU hardware pagetables.

v2: Code reviews and rebased code on top of Jordan's split pagetables series

To enable the system cache driver, add [1] to your stack if not already
present. Please review.

[1] https://lore.kernel.org/patchwork/patch/1165298/

Jordan Crouse (3):
  iommu/arm-smmu: Pass io_pgtable_cfg to impl specific init_context
  drm/msm: Attach the IOMMU device during initialization
  drm/msm: Refactor address space initialization

Sharat Masetty (3):
  drm: msm: a6xx: Properly free up the iommu objects
  drm/msm: rearrange the gpu_rmw() function
  drm/msm/a6xx: Add support for using system cache(LLC)

Vivek Gautam (1):
  iommu/arm-smmu: Add domain attribute for QCOM system cache

 drivers/gpu/drm/msm/adreno/a2xx_gpu.c    |  16 ++++
 drivers/gpu/drm/msm/adreno/a3xx_gpu.c    |   1 +
 drivers/gpu/drm/msm/adreno/a4xx_gpu.c    |   1 +
 drivers/gpu/drm/msm/adreno/a5xx_gpu.c    |   1 +
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c    | 124 +++++++++++++++++++++++++++++++
 drivers/gpu/drm/msm/adreno/a6xx_gpu.h    |   3 +
 drivers/gpu/drm/msm/adreno/adreno_gpu.c  |  23 ++++--
 drivers/gpu/drm/msm/adreno/adreno_gpu.h  |   8 ++
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c  |  19 ++---
 drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c |  19 ++---
 drivers/gpu/drm/msm/disp/mdp5/mdp5_cfg.c |   4 -
 drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c |  19 +++--
 drivers/gpu/drm/msm/msm_drv.c            |   8 ++
 drivers/gpu/drm/msm/msm_drv.h            |   9 +--
 drivers/gpu/drm/msm/msm_gem_vma.c        |  37 ++-------
 drivers/gpu/drm/msm/msm_gpu.c            |  49 +-----------
 drivers/gpu/drm/msm/msm_gpu.h            |   9 +--
 drivers/gpu/drm/msm/msm_gpummu.c         |   7 --
 drivers/gpu/drm/msm/msm_iommu.c          |  22 +++---
 drivers/gpu/drm/msm/msm_mmu.h            |   5 +-
 drivers/iommu/arm-smmu-impl.c            |   3 +-
 drivers/iommu/arm-smmu-qcom.c            |  10 +++
 drivers/iommu/arm-smmu.c                 |  25 +++++--
 drivers/iommu/arm-smmu.h                 |   4 +-
 include/linux/iommu.h                    |   1 +
 25 files changed, 269 insertions(+), 158 deletions(-)

--
1.9.1
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
