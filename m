Return-Path: <SRS0=9cYo=U7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 406DEC06510
	for <iommu@archiver.kernel.org>; Tue,  2 Jul 2019 20:31:11 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A4A121897
	for <iommu@archiver.kernel.org>; Tue,  2 Jul 2019 20:31:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y0c3Zbx/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A4A121897
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id B0A862155;
	Tue,  2 Jul 2019 20:31:10 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id DEA61212A
	for <iommu@lists.linux-foundation.org>;
	Tue,  2 Jul 2019 20:26:46 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-qt1-f193.google.com (mail-qt1-f193.google.com
	[209.85.160.193])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id B431F782
	for <iommu@lists.linux-foundation.org>;
	Tue,  2 Jul 2019 20:26:45 +0000 (UTC)
Received: by mail-qt1-f193.google.com with SMTP id h24so50069qto.0
	for <iommu@lists.linux-foundation.org>;
	Tue, 02 Jul 2019 13:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=aM7TEuKumvUMe3SbB3+XmY4I8aQKFrST7xx8ZApBOcM=;
	b=Y0c3Zbx/HklkB3ZQUMPUnd3cuD2+CXBd/qv6pY0OkEJTg/+z03wi0oF1CvFJYsaUkZ
	4zHdADC6xI/bjao5kJDJAheklnpxnkP641vjkWWAD6dXp83EK+bgIBqRrhp5R+e9GhCz
	zCGy7sAlE3XsPTlqcBMQPxFhUYqm5Yg2JhxtQejc7AlhxkxL1xSYYXRVk6l4V/OzXbVr
	F2N4nVUleb2SyZc8sgC2poSaaQ+CgHZiuCRWIi+78YgA4bpPN5KzS8h7SHnC0qrpdgs/
	YZxrEttZo98QKBCnwb20wNLc3UgkTsaMpeRea2ivIhOm1ixPyotAxAUbQecsF1pxUnqv
	E1Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=aM7TEuKumvUMe3SbB3+XmY4I8aQKFrST7xx8ZApBOcM=;
	b=UUS+ATgIAbqALb3rU3/SH56jyQLxl9y55vitTpy8jlaOgpOlvKTFQYZHjXpGwdR42W
	9nxgP0wpecKt1Qujg+69gAaal40ks8W7DJRR4md51RD2DxTzJQ15fgrzJvdwROH/f5HX
	pdYlXsayuE+bD8dxHXpTpX0ma6AkFZ8gG4Qc092kbCSVow8inEw/x4twSpHf8Flpfqhe
	V8V/Q6gBTexA9tWzg1REdIMurZNwQR1t++0YH9I8SnCoYcLJJ5YFdkUXbweGAqEQqK0o
	E/hzrGhsMGS8+ueo3YpdLvxWyXoA4IGYJFnhzpwFiAKuu/d+uuYKASpefh9QEP+UOP9X
	llsA==
X-Gm-Message-State: APjAAAWbP4GPaXcpOf52qoeryL2eSV5dFvm4cIxcWZUreizbjL9cuVbU
	WlOQ3WQWNEw+jvWITJWOZhQku9XuTQMUSg==
X-Google-Smtp-Source: APXvYqxHJBmk2g0xpgV4VUHGsLMtAzHIfVL3nv7QBsGBAXs8stUf9sYJU+dbtd2Yxf85Z4tgzUX1Cw==
X-Received: by 2002:a0c:b755:: with SMTP id q21mr27605171qve.92.1562099204529; 
	Tue, 02 Jul 2019 13:26:44 -0700 (PDT)
Received: from localhost ([2601:184:4780:7861:5010:5849:d76d:b714])
	by smtp.gmail.com with ESMTPSA id f6sm6267017qkk.79.2019.07.02.13.26.43
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Tue, 02 Jul 2019 13:26:44 -0700 (PDT)
From: Rob Clark <robdclark@gmail.com>
To: iommu@lists.linux-foundation.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH 0/2] iommu: handle drivers that manage iommu directly
Date: Tue,  2 Jul 2019 13:26:17 -0700
Message-Id: <20190702202631.32148-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Rob Clark <robdclark@chromium.org>, Jonathan Marek <jonathan@marek.ca>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Mamta Shukla <mamtashukla555@gmail.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Joerg Roedel <jroedel@suse.de>, "open list:DRM DRIVER FOR MSM ADRENO GPU"
	<linux-arm-msm@vger.kernel.org>, Abhinav Kumar <abhinavk@codeaurora.org>,
	Bruce Wang <bzwang@chromium.org>, Sean Paul <seanpaul@chromium.org>,
	Jeykumar Sankaran <jsanka@codeaurora.org>,
	aarch64-laptops@lists.linaro.org, Boris Brezillon <bbrezillon@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	open list <linux-kernel@vger.kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>, Joe Perches <joe@perches.com>,
	"open list:DRM DRIVER FOR MSM ADRENO GPU"
	<freedreno@lists.freedesktop.org>, Daniel Mack <daniel@zonque.org>
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

One of the challenges we need to handle to enable the aarch64 laptops
upstream is dealing with the fact that the bootloader enables the
display and takes the corresponding SMMU context-bank out of BYPASS.
Unfortunately, currently, the IOMMU framework attaches a DMA (or
potentially an IDENTITY) domain before the driver is probed and has
a chance to intervene and shutdown[1] scanout.  Which makes things go
horribly wrong.

This also happens to solve a problem that is blocking us from supporting
per-context pagetables on the GPU, due to domain that is attached before
driver has a chance to attach it's own domain for the GPU.

But since the driver is managing it's own iommu domains directly, and
does not use dev->iommu_group->default_domain at all, the simple
solution to both problems is to just avoid attaching that domain in the
first place.

[1] Eventually we want to be able to do a seemless transition from
    efifb to drm/msm... but first step is to get the core (iommu,
    clk, genpd) pieces in place, so a first step of disabling the
    display before first modeset enables us to get all of the
    dependencies outside of drm/msm in place.  And this at least
    gets us parity with windows (which also appears to do a modeset
    between bootloader and HLSO).  After that there is a bunch of
    drm/msm work that is probably not interesting to folks outside
    of dri-devel.

Rob Clark (2):
  iommu: add support for drivers that manage iommu explicitly
  drm/msm: mark devices where iommu is managed by driver

 drivers/gpu/drm/msm/adreno/adreno_device.c |  1 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c    |  1 +
 drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c   |  1 +
 drivers/gpu/drm/msm/msm_drv.c              |  1 +
 drivers/iommu/iommu.c                      | 11 +++++++++++
 include/linux/device.h                     |  3 ++-
 6 files changed, 17 insertions(+), 1 deletion(-)

-- 
2.20.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
