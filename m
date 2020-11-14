Return-Path: <SRS0=1Qk8=EU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D158AC5519F
	for <iommu@archiver.kernel.org>; Sat, 14 Nov 2020 15:28:33 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A71A22275
	for <iommu@archiver.kernel.org>; Sat, 14 Nov 2020 15:28:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=marek-ca.20150623.gappssmtp.com header.i=@marek-ca.20150623.gappssmtp.com header.b="boEvE1jJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A71A22275
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=marek.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id EAD04877B2;
	Sat, 14 Nov 2020 15:28:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KdwT1s1CAqQq; Sat, 14 Nov 2020 15:28:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 46BF9877B1;
	Sat, 14 Nov 2020 15:28:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 29DBDC0891;
	Sat, 14 Nov 2020 15:28:30 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 71D2BC0800
 for <iommu@lists.linux-foundation.org>; Sat, 14 Nov 2020 15:28:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 55879203CA
 for <iommu@lists.linux-foundation.org>; Sat, 14 Nov 2020 15:28:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Vh7Y1wdAfAMf for <iommu@lists.linux-foundation.org>;
 Sat, 14 Nov 2020 15:28:27 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-qt1-f196.google.com (mail-qt1-f196.google.com
 [209.85.160.196])
 by silver.osuosl.org (Postfix) with ESMTPS id A7E122002B
 for <iommu@lists.linux-foundation.org>; Sat, 14 Nov 2020 15:28:26 +0000 (UTC)
Received: by mail-qt1-f196.google.com with SMTP id t5so9512624qtp.2
 for <iommu@lists.linux-foundation.org>; Sat, 14 Nov 2020 07:28:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marek-ca.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=mvYHfNLs//x0UCoGzcml3CX/lFayNp6bncJ+PAIIQPg=;
 b=boEvE1jJkCl5kJSpNhQF7m+CWiLQrRnX4NgMtu+8CGdOfGnxn8Z0uaApWYc6uNYioP
 zlrG6UqUkEuW6eFK1RNAC3KMpZdDwYuCxnUz+tX10junMhLMWHuEPBZwvbKd3qEOAfDL
 Lp+EwFz9g5852MJSCOYd5xNh3eb0Gj+X/lo8govtalB2Z7KGNqGeSh0NVlwt93str0iM
 X7NrX7VK8O4HdqKdrU/Ie/gEkzzq7ogWYGTGA9Nk2iNgeFaKI0eQuKp2NJHHkB2DMwjM
 /FVfVPjuD3BQI5i+zz2ToqxgdC/tNc/AFBHseUfPVnsDyQIGJUKr/jLuT3OECxPQbXNh
 spJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=mvYHfNLs//x0UCoGzcml3CX/lFayNp6bncJ+PAIIQPg=;
 b=pH+gHB/FLu7jCGJE4wo683MrZk3jyTHeH5rd5MOKXSo2KKrrSrt95gv47l7hI9aOEG
 Qo8+4DeoUpEYjZyhKJxu8DVFNeRL+DqiYGMtKqJem22vc/8MbDSAWMsI5F0B7VWN0TrB
 YxVlHPSHag99FC7CudOI8QJ+GgzPey7aUWIfuAY0y8P1h5oCFGeTUfms2rZ7DZekbHsB
 0xy6ncT+TGIkQROCRkBOAMi6Zvjl+sZrEigRTc2ObqZbidyuBcp0t2q9zo5VauuKj11K
 iw5iIT7WxDlcGnswja+PttY8crzOg1r4dnhhNSXbEhE9do//PRcU76l2KihvhAItVZw4
 fbkQ==
X-Gm-Message-State: AOAM531COS6zrC54XasRbpM0kdOIQrHjZKboXhkPTNVvZ/a64pM9Nnov
 egjY+Kwn1a5GhAMHItEo6Uxkx+Cn7xxlHgzRsrc=
X-Google-Smtp-Source: ABdhPJzYGqTlUKPKSmkhBmM3csDOKzxzLYFelg6G+ya85IQqawa27V6Kv716IjBszDX0515vEabeeg==
X-Received: by 2002:a05:620a:2455:: with SMTP id
 h21mr6867791qkn.123.1605367262284; 
 Sat, 14 Nov 2020 07:21:02 -0800 (PST)
Received: from localhost.localdomain
 (modemcable068.184-131-66.mc.videotron.ca. [66.131.184.68])
 by smtp.gmail.com with ESMTPSA id h125sm8888368qkc.36.2020.11.14.07.21.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Nov 2020 07:21:01 -0800 (PST)
From: Jonathan Marek <jonathan@marek.ca>
To: freedreno@lists.freedesktop.org,
	hch@lst.de
Subject: [RESEND PATCH v2 0/5] drm/msm: support for host-cached BOs
Date: Sat, 14 Nov 2020 10:17:08 -0500
Message-Id: <20201114151717.5369-1-jonathan@marek.ca>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Cc: Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
 "open list:DRM DRIVER FOR MSM ADRENO GPU" <linux-arm-msm@vger.kernel.org>,
 Sharat Masetty <smasetty@codeaurora.org>,
 "open list:DRM DRIVER FOR MSM ADRENO GPU" <dri-devel@lists.freedesktop.org>,
 "open list:DMA MAPPING HELPERS" <iommu@lists.linux-foundation.org>,
 Daniel Vetter <daniel@ffwll.ch>, Shawn Guo <shawn.guo@linaro.org>,
 Robin Murphy <robin.murphy@arm.com>, open list <linux-kernel@vger.kernel.org>
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

v2:
 - added patches 2/3 to enable using dma_ops_bypass
 - changed DRM_MSM_GEM_SYNC_CACHE patch to use dma_sync_sg_for_device()
   and dma_sync_sg_for_cpu(), and renamed sync flags.

Not sure I did the right thing with for the dma_ops_bypass part,
this is what I came up with reading the emails.

Jonathan Marek (5):
  drm/msm: add MSM_BO_CACHED_COHERENT
  dma-direct: add dma_direct_bypass() to force direct ops
  drm/msm: call dma_direct_bypass()
  drm/msm: add DRM_MSM_GEM_SYNC_CACHE for non-coherent cache maintenance
  drm/msm: bump up the uapi version

 drivers/gpu/drm/msm/Kconfig                |  1 +
 drivers/gpu/drm/msm/adreno/adreno_device.c |  1 +
 drivers/gpu/drm/msm/msm_drv.c              | 32 +++++++++++++++++++---
 drivers/gpu/drm/msm/msm_drv.h              |  3 ++
 drivers/gpu/drm/msm/msm_gem.c              | 31 +++++++++++++++++++++
 include/linux/dma-direct.h                 |  9 ++++++
 include/uapi/drm/msm_drm.h                 | 25 +++++++++++++++--
 kernel/dma/direct.c                        | 23 ++++++++++++++++
 8 files changed, 118 insertions(+), 7 deletions(-)

-- 
2.26.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
