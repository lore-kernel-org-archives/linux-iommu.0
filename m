Return-Path: <SRS0=rqG6=XB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A1EEC43331
	for <iommu@archiver.kernel.org>; Fri,  6 Sep 2019 21:46:37 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5CEE20838
	for <iommu@archiver.kernel.org>; Fri,  6 Sep 2019 21:46:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bB+2a204"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5CEE20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 9D0FB27C1;
	Fri,  6 Sep 2019 21:46:36 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 9BDC027AF
	for <iommu@lists.linux-foundation.org>;
	Fri,  6 Sep 2019 21:46:34 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com
	[209.85.210.194])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 39CF67DB
	for <iommu@lists.linux-foundation.org>;
	Fri,  6 Sep 2019 21:46:34 +0000 (UTC)
Received: by mail-pf1-f194.google.com with SMTP id y5so2701618pfo.4
	for <iommu@lists.linux-foundation.org>;
	Fri, 06 Sep 2019 14:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=X+UKEokhysiEjhebMkmydc3Xut+rkxm/820z0jqk+pw=;
	b=bB+2a2042/w5fLDKgGxSCU63OZJdemRj5lstmeKzyz2kKsymPU9qKVPAWAO5XqEpoX
	NQjWZboO1Xqc9cYWPK+zS0a3/dsBVhTx70hSi7CyLwAMb2LXE/egWyxML/yi+G4vilyP
	nAL/lrr66lcMxFh/V1lf0zajAvVc9b7txxr2NelsFwTbWER/5mfQ/zuuL5HzZO9fMRnn
	jGNd8gO46slJn5TOTEht06yzy1gkw82s82dF+024ICCWEH7H3wPEZO1EkRhjI8sD8ae+
	z38HpfgWvwwlmJc+rBx98Ea9ZmRte4k86rNSkO4ohCvZ0gLKR42divMBeZ74wTyoYj5y
	FgEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=X+UKEokhysiEjhebMkmydc3Xut+rkxm/820z0jqk+pw=;
	b=AJ7lKQojRJHSDq3E/GtQtZzy61s7VK6qCgz12kHUVfajA1dCNacvZx5WoHHR5iWMKo
	D2sos+2tIADA+NND7z0TNx2Tz2yACM30jBFw+lTYZwJO58BSEAMdLNOutoI9sdTF/6/j
	AMvUJKePoIs7O53UMU/9K+VVrs4XQzNvjlARULKJyHxzVrnXp7sAOm9W5vFbLfMadAca
	NSKh9VfcypQ/RD98RCW580XzsZ6axnpTwzlo6XCc6iy9ErNZvrzMWnMZPJMh8mI8ODts
	233Dk6LS8D5xYzy9SrDix8VBPGVdpmAIxUP1pqLC1cytrAXMOoAptkBswsoK+70QZk7t
	ocfQ==
X-Gm-Message-State: APjAAAXx14tyY9o3ykfC0MzXDwC5qIrFFIlv/7uuS+gstZajoDL9uyGC
	xXvwaK61u8ypwjNKCvwVkCdq0hJTKATKGQ==
X-Google-Smtp-Source: APXvYqxAQm+A/TufbfRwRtbAOXBB+uXmA4OqTTf7BWWv93xs12KzKxBrIOgomoXlI9U4Nb+Q86U1eg==
X-Received: by 2002:a17:90a:bf0a:: with SMTP id
	c10mr11992578pjs.78.1567806393371; 
	Fri, 06 Sep 2019 14:46:33 -0700 (PDT)
Received: from localhost ([100.118.89.196]) by smtp.gmail.com with ESMTPSA id
	74sm13108243pfy.78.2019.09.06.14.46.32
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Fri, 06 Sep 2019 14:46:32 -0700 (PDT)
From: Rob Clark <robdclark@gmail.com>
To: iommu@lists.linux-foundation.org
Subject: [PATCH v3 0/2] iommu: handle drivers that manage iommu directly
Date: Fri,  6 Sep 2019 14:44:00 -0700
Message-Id: <20190906214409.26677-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Jeffrey Hugo <jeffrey.l.hugo@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	dri-devel@lists.freedesktop.org, Will Deacon <will@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, Rob Clark <robdclark@chromium.org>,
	Jonathan Marek <jonathan@marek.ca>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Mamta Shukla <mamtashukla555@gmail.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Joerg Roedel <jroedel@suse.de>, Arnd Bergmann <arnd@arndb.de>,
	Suzuki K Poulose <suzuki.poulose@arm.com>, linux-arm-msm@vger.kernel.org,
	Sudeep Holla <sudeep.holla@arm.com>,
	Abhinav Kumar <abhinavk@codeaurora.org>, Bruce Wang <bzwang@chromium.org>,
	Alexios Zavras <alexios.zavras@intel.com>,
	Sean Paul <seanpaul@chromium.org>,
	Jeykumar Sankaran <jsanka@codeaurora.org>,
	Allison Randal <allison@lohutok.net>,
	Boris Brezillon <bbrezillon@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	open list <linux-kernel@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Joe Perches <joe@perches.com>, Andrew Morton <akpm@linux-foundation.org>,
	"open list:DRM DRIVER FOR MSM ADRENO GPU"
	<freedreno@lists.freedesktop.org>,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

From: Rob Clark <robdclark@chromium.org>

One of the challenges we have to enable the aarch64 laptops upstream
is dealing with the fact that the bootloader enables the display and
takes the corresponding SMMU context-bank out of BYPASS.  Unfortunately,
currently, the IOMMU framework attaches a DMA (or potentially an
IDENTITY) domain before the driver is probed and has a chance to
intervene and shutdown scanout.  Which makes things go horribly wrong.

But in this case, drm/msm is already directly managing it's IOMMUs
directly, the DMA API attached iommu_domain simply gets in the way.
This series adds a way that a driver can indicate to drivers/iommu
that it does not wish to have an DMA managed iommu_domain attached.
This way, drm/msm can shut down scanout cleanly before attaching it's
own iommu_domain.

NOTE that to get things working with arm-smmu on the aarch64 laptops,
you also need a patchset[1] from Bjorn Andersson to inherit SMMU config
at boot, when it is already enabled.

[1] https://www.spinics.net/lists/arm-kernel/msg732246.html

NOTE that in discussion of previous revisions, RMRR came up.  This is
not really a replacement for RMRR (nor does RMRR really provide any
more information than we already get from EFI GOP, or DT in the
simplefb case).  I also don't see how RMRR could help w/ SMMU handover
of CB/SMR config (Bjorn's patchset[1]) without defining new tables.

This perhaps doesn't solve the more general case of bootloader enabled
display for drivers that actually want to use DMA API managed IOMMU.
But it does also happen to avoid a related problem with GPU, caused by
the DMA domain claiming the context bank that the GPU firmware expects
to use.  And it avoids spurious TLB invalidation coming from the unused
DMA domain.  So IMHO this is a useful and necessary change.

Rob Clark (2):
  iommu: add support for drivers that manage iommu explicitly
  drm/msm: mark devices where iommu is managed by driver

 drivers/gpu/drm/msm/adreno/adreno_device.c | 1 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c    | 1 +
 drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c   | 1 +
 drivers/gpu/drm/msm/msm_drv.c              | 1 +
 drivers/iommu/iommu.c                      | 2 +-
 drivers/iommu/of_iommu.c                   | 3 +++
 include/linux/device.h                     | 3 ++-
 7 files changed, 10 insertions(+), 2 deletions(-)

-- 
2.21.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
