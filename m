Return-Path: <SRS0=xQF/=WQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6F13C3A589
	for <iommu@archiver.kernel.org>; Tue, 20 Aug 2019 19:07:03 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B92D52332A
	for <iommu@archiver.kernel.org>; Tue, 20 Aug 2019 19:07:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="cGY7R235";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="M3Z+8dS+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B92D52332A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 662E4D12;
	Tue, 20 Aug 2019 19:06:46 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 3F5AFC79
	for <iommu@lists.linux-foundation.org>;
	Tue, 20 Aug 2019 19:06:44 +0000 (UTC)
Received: from smtp.codeaurora.org (smtp.codeaurora.org [198.145.29.96])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 0FC5389B
	for <iommu@lists.linux-foundation.org>;
	Tue, 20 Aug 2019 19:06:42 +0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id DE4F860E42; Tue, 20 Aug 2019 19:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
	s=default; t=1566328001;
	bh=JVOA+N1GY0FZQY7fgH8GBUcQtg09RuZemNa9uGbRUB4=;
	h=From:To:Cc:Subject:Date:From;
	b=cGY7R235YpB41zyv7M/1ugHWDI/ziFKNIhV41PxzgJpu41F6SGQDPsnKwT6v84uoQ
	fwqeJ4SiPMJHdMcNS8NqeMHuTc+Y0mkoUoewjphPYIoFjfs3bE9TnJaNA0KhyWBgjr
	ByKKqzNSXQ8/sVSsM+l2UJjMV1ECTRqOyl5Afywc=
Received: from jcrouse1-lnx.qualcomm.com (i-global254.qualcomm.com
	[199.106.103.254])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: jcrouse@smtp.codeaurora.org)
	by smtp.codeaurora.org (Postfix) with ESMTPSA id E2A2A608FC;
	Tue, 20 Aug 2019 19:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
	s=default; t=1566327999;
	bh=JVOA+N1GY0FZQY7fgH8GBUcQtg09RuZemNa9uGbRUB4=;
	h=From:To:Cc:Subject:Date:From;
	b=M3Z+8dS+lEFL8B05ojyqH3qIFG+culCff2FSu0EKY/ry/7K1KKZg7C+hKtsTsrbnv
	r7SpMsyJIV9oQxPSzEoaALo1KWXvI5skX+lAVXXVB5SrxlSgeY4eBsNUb67pkptlr6
	71/65oHOvbmE6FBMuD0JfkDviPqBoXzhgDZmtu5M=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E2A2A608FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
	dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
	spf=none smtp.mailfrom=jcrouse@codeaurora.org
From: Jordan Crouse <jcrouse@codeaurora.org>
To: freedreno@lists.freedesktop.org
Subject: [PATCH 0/7] iommu/arm-smmu: Split pagetable support for Adreno GPUs
Date: Tue, 20 Aug 2019 13:06:25 -0600
Message-Id: <1566327992-362-1-git-send-email-jcrouse@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Cc: Mark Rutland <mark.rutland@arm.com>,
	Jeffrey Hugo <jeffrey.l.hugo@gmail.com>,
	David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
	Bjorn Andersson <bjorn.andersson@linaro.org>,
	Will Deacon <will@kernel.org>, Wen Yang <wen.yang99@zte.com.cn>,
	Jonathan Marek <jonathan@marek.ca>, iommu@lists.linux-foundation.org,
	Mamta Shukla <mamtashukla555@gmail.com>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	Fritz Koenig <frkoenig@google.com>,
	Daniel Vetter <daniel@ffwll.ch>, linux-arm-msm@vger.kernel.org,
	Sharat Masetty <smasetty@codeaurora.org>,
	Abhinav Kumar <abhinavk@codeaurora.org>,
	Jeykumar Sankaran <jsanka@codeaurora.org>,
	Alexios Zavras <alexios.zavras@intel.com>,
	Rob Herring <robh+dt@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Sean Paul <sean@poorly.run>, Allison Randal <allison@lohutok.net>,
	Bruce Wang <bzwang@chromium.org>, Boris Brezillon <bbrezillon@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Douglas Anderson <dianders@chromium.org>, linux-kernel@vger.kernel.org,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Robin Murphy <robin.murphy@arm.com>,
	Georgi Djakov <georgi.djakov@linaro.org>,
	Sravanthi Kollukuduru <skolluku@codeaurora.org>
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

This is another iteration to support split pagetables for Adreno GPUs as part of
an incremental process to enable per-context pagetables.

In order to support per-context pagetables the GPU needs to enable split
pagetables so that we can store the global buffers in the TTBR1 space leaving
the GPU free to program the TTBR0 register with the page address of a context
specific pt.

Previous revisions of this series can be found at [1] and [2].

This iteration is built on top of the arm-smmu-impl and arm-smmu-v2
rework code from Robin Murphy [3] and [4].

This code is based on the realization that when split pagetables are enabled the
configuration for the T1 address space is identical to that of the T0 space,
so we can just take the TCR configuration provided by io-pgtable, duplicate it
and shift it by 16 bits.

Since the current split pagetable implementation is specific to the Adreno
GPUs we can also take a small shortcut and only allow split pagetables for SMMUs
with a 49 bit upstream bus which allows us to use the default configuration
for the sign extension bit and we can avoid a lot of extra code to handle
different upstream bus sizes that will never get used.

The first patch implements the split pagetable support for arm-smmu-v2.

The second adds a SMMU model for the Adreno GPU SMMU and enables the split
pagetables if conditions warrant.

The 3rd and 4th patches add a domain attribute to query the status of split
pagetables.

The remaining patches modify drm/msm slightly to allow a6xx targets to
recognize if split pagetables are enabled and adjust the address space
accordingly.

This series only includes support for split pagetables because I wanted to get
this out for discussion and I haven't ported over the aux domain code to this
kernel version, but I don't suspect it will end up being much different than
previous versions [5].

[1] https://patchwork.freedesktop.org/series/63403/
[2] https://patchwork.freedesktop.org/series/64874/
[3] https://lists.linuxfoundation.org/pipermail/iommu/2019-August/037905.html
[4] https://lists.linuxfoundation.org/pipermail/iommu/2019-August/038244.html
[5] https://patchwork.freedesktop.org/patch/307601/


Jordan Crouse (7):
  iommu/arm-smmu: Support split pagetables
  dt-bindings: arm-smmu: Add Adreno GPU variant
  iommu/arm-smmu: Add a SMMU variant for the Adreno GPU
  iommu: Add DOMAIN_ATTR_SPLIT_TABLES
  iommu/arm-smmu: Support DOMAIN_ATTR_SPLIT_TABLES
  drm/msm: Create the msm_mmu object independently from the address
    space
  drm/msm: Use per-target functions to set up address spaces

 .../devicetree/bindings/iommu/arm,smmu.txt         |  7 +++
 drivers/gpu/drm/msm/adreno/a2xx_gpu.c              | 28 +++++++++++
 drivers/gpu/drm/msm/adreno/a3xx_gpu.c              |  1 +
 drivers/gpu/drm/msm/adreno/a4xx_gpu.c              |  1 +
 drivers/gpu/drm/msm/adreno/a5xx_gpu.c              |  1 +
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c              | 56 ++++++++++++++++++++++
 drivers/gpu/drm/msm/adreno/adreno_gpu.c            | 43 ++++++++++++++---
 drivers/gpu/drm/msm/adreno/adreno_gpu.h            |  5 ++
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c            | 16 ++++---
 drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c           | 16 ++++---
 drivers/gpu/drm/msm/disp/mdp5/mdp5_cfg.c           |  4 --
 drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c           | 13 ++++-
 drivers/gpu/drm/msm/msm_drv.h                      |  8 +---
 drivers/gpu/drm/msm/msm_gem_vma.c                  | 30 ++----------
 drivers/gpu/drm/msm/msm_gpu.c                      | 51 ++------------------
 drivers/gpu/drm/msm/msm_gpu.h                      |  4 +-
 drivers/iommu/arm-smmu-impl.c                      | 15 ++++++
 drivers/iommu/arm-smmu.c                           | 46 ++++++++++++++++--
 drivers/iommu/arm-smmu.h                           |  2 +
 include/linux/iommu.h                              |  1 +
 20 files changed, 237 insertions(+), 111 deletions(-)

-- 
2.7.4

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
