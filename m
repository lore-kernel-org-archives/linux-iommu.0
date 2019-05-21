Return-Path: <SRS0=R8za=TV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88067C04AAF
	for <iommu@archiver.kernel.org>; Tue, 21 May 2019 16:14:19 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C6922173C
	for <iommu@archiver.kernel.org>; Tue, 21 May 2019 16:14:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Z8byHsO4";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="PSPgUd79"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C6922173C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 430D2AE0;
	Tue, 21 May 2019 16:14:19 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 8A87B255
	for <iommu@lists.linux-foundation.org>;
	Tue, 21 May 2019 16:14:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from smtp.codeaurora.org (smtp.codeaurora.org [198.145.29.96])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 18683E3
	for <iommu@lists.linux-foundation.org>;
	Tue, 21 May 2019 16:14:17 +0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 5DEAD6087F; Tue, 21 May 2019 16:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
	s=default; t=1558455256;
	bh=XEaXjrXY1Q6Wd+gJ+WxNDOVUYRY8dVm52md5PI1E1n4=;
	h=From:To:Cc:Subject:Date:From;
	b=Z8byHsO4rDMrm1ihJHl3rkSHHzJZDP9N6eUb7I8iqHm8OQavgOm3NzkgRelj5D4Np
	iLro/f/8lNbrGEbYnynmqzhj+DnmJJLdr3ypHcS5qrLVLbcSC6ViFqRhneGsRiInt0
	1p17wyMMu+LNVvboC7fOGQxGPt7EIjaPh2VzSs7k=
Received: from jcrouse1-lnx.qualcomm.com (i-global254.qualcomm.com
	[199.106.103.254])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: jcrouse@smtp.codeaurora.org)
	by smtp.codeaurora.org (Postfix) with ESMTPSA id 5E3EA6087F;
	Tue, 21 May 2019 16:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
	s=default; t=1558455250;
	bh=XEaXjrXY1Q6Wd+gJ+WxNDOVUYRY8dVm52md5PI1E1n4=;
	h=From:To:Cc:Subject:Date:From;
	b=PSPgUd79z8v7c0MBhbxiaVungiKnYR6C62UdL/lcaxsCYzg1sTL8UQQvzS2QpH7Y+
	i4ep3OTg7o2XVCF85yUuw4mca3UjOup1LdccPZf9s6IwXvycn1zgXApCCMN+m5fxdr
	6hXcxWeBPpVqXI0L+6UU2qQ54AOiDhZZzZGaM2Go=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5E3EA6087F
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
	dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
	spf=none smtp.mailfrom=jcrouse@codeaurora.org
From: Jordan Crouse <jcrouse@codeaurora.org>
To: freedreno@lists.freedesktop.org
Subject: [PATCH v2 00/15] drm/msm: Per-instance pagetable support
Date: Tue, 21 May 2019 10:13:48 -0600
Message-Id: <1558455243-32746-1-git-send-email-jcrouse@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Cc: Kees Cook <keescook@chromium.org>, Jonathan Marek <jonathan@marek.ca>,
	jean-philippe.brucker@arm.com, linux-arm-msm@vger.kernel.org,
	Sharat Masetty <smasetty@codeaurora.org>,
	Will Deacon <will.deacon@arm.com>, dianders@chromium.org,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	David Airlie <airlied@linux.ie>, iommu@lists.linux-foundation.org,
	Mamta Shukla <mamtashukla555@gmail.com>, hoegsberg@google.com,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Daniel Vetter <daniel@ffwll.ch>, Sean Paul <sean@poorly.run>,
	Wen Yang <wen.yang99@zte.com.cn>, linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

This is a refresh of the per-instance pagetable support for arm-smmu-v2 and the
MSM GPU driver. I think this is pretty mature at this point, so I've dropped the
RFC designation and ask for consideration for 5.3.

Per-instance pagetables allow the target GPU driver to create and manage
an individual pagetable for each file descriptor instance and switch
between them asynchronously using the GPU to reprogram the pagetable
registers on the fly.

Most of the heavy lifting for this is done in the arm-smmu-v2 driver by
taking advantage of the newly added multiple domain API. The first patch in the
series allows opted-in clients to create a default identity domain when the
IOMMU group for the SMMU device is created. This bypasses the DMA domain
creation in the IOMMU core which serves several purposes for the GPU by skipping
the otherwise  unused DMA domain and also keeping context bank 0 unused on the
hardware (for better or worse, the GPU is hardcoded to only use context bank 0
for switching).

The next two patches enable split pagetable support. This is used to map
global buffers for the GPU so we can safely switch the TTBR0 pagetable for the
instance.

The last two arm-smmu-v2 patches enable auxillary domain support. Again the
SMMU client can opt-in to allow auxiliary domains, and if enabled will create
a pagetable but not otherwise touch the hardware. The client can get the address
of the pagetable through an attribute to perform its own switching.

After the arm-smmu-v2 patches are more than several msm/gpu patches to allow
for target specific address spaces, enable 64 bit virtual addressing and
implement the mechanics of pagetable switching.

For the purposes of merging all the patches between

drm/msm/adreno: Enable 64 bit mode by default on a5xx and a6xx targets

and

drm/msm: Add support to create target specific address spaces

can be merged to the msm-next tree without dependencies on the IOMMU changes.
Only the last three patches will require coordination between the two areas.

Jordan Crouse (15):
  iommu/arm-smmu: Allow IOMMU enabled devices to skip DMA domains
  iommu: Add DOMAIN_ATTR_SPLIT_TABLES
  iommu/arm-smmu: Add split pagetable support for arm-smmu-v2
  iommu: Add DOMAIN_ATTR_PTBASE
  iommu/arm-smmu: Add auxiliary domain support for arm-smmuv2
  drm/msm/adreno: Enable 64 bit mode by default on a5xx and a6xx targets
  drm/msm: Print all 64 bits of the faulting IOMMU address
  drm/msm: Pass the MMU domain index in struct msm_file_private
  drm/msm/gpu: Move address space setup to the GPU targets
  drm/msm: Add a helper function for a per-instance address space
  drm/msm/gpu: Add ttbr0 to the memptrs
  drm/msm: Add support to create target specific address spaces
  drm/msm: Add support for IOMMU auxiliary domains
  drm/msm/a6xx: Support per-instance pagetables
  drm/msm/a5xx: Support per-instance pagetables

 drivers/gpu/drm/msm/adreno/a2xx_gpu.c     |  37 +++-
 drivers/gpu/drm/msm/adreno/a3xx_gpu.c     |  50 +++--
 drivers/gpu/drm/msm/adreno/a4xx_gpu.c     |  51 +++--
 drivers/gpu/drm/msm/adreno/a5xx_gpu.c     | 163 +++++++++++++-
 drivers/gpu/drm/msm/adreno/a5xx_gpu.h     |  19 ++
 drivers/gpu/drm/msm/adreno/a5xx_preempt.c |  70 ++++--
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c     | 166 +++++++++++++-
 drivers/gpu/drm/msm/adreno/a6xx_gpu.h     |   1 +
 drivers/gpu/drm/msm/adreno/adreno_gpu.c   |   7 -
 drivers/gpu/drm/msm/msm_drv.c             |  25 ++-
 drivers/gpu/drm/msm/msm_drv.h             |   5 +
 drivers/gpu/drm/msm/msm_gem.h             |   2 +
 drivers/gpu/drm/msm/msm_gem_submit.c      |  13 +-
 drivers/gpu/drm/msm/msm_gem_vma.c         |  53 +++--
 drivers/gpu/drm/msm/msm_gpu.c             |  59 +----
 drivers/gpu/drm/msm/msm_gpu.h             |   3 +
 drivers/gpu/drm/msm/msm_iommu.c           |  99 ++++++++-
 drivers/gpu/drm/msm/msm_mmu.h             |   4 +
 drivers/gpu/drm/msm/msm_ringbuffer.h      |   1 +
 drivers/iommu/arm-smmu-regs.h             |  19 ++
 drivers/iommu/arm-smmu.c                  | 352 +++++++++++++++++++++++++++---
 drivers/iommu/io-pgtable-arm.c            |   3 +-
 drivers/iommu/iommu.c                     |  29 ++-
 include/linux/iommu.h                     |   5 +
 24 files changed, 1052 insertions(+), 184 deletions(-)

-- 
2.7.4

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
