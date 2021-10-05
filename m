Return-Path: <SRS0=ORUS=OZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3F38C4332F
	for <iommu@archiver.kernel.org>; Tue,  5 Oct 2021 15:11:58 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BD4F6115A
	for <iommu@archiver.kernel.org>; Tue,  5 Oct 2021 15:11:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5BD4F6115A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2A119406E7;
	Tue,  5 Oct 2021 15:11:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HEalT1IGcXNX; Tue,  5 Oct 2021 15:11:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 0D0DA40502;
	Tue,  5 Oct 2021 15:11:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DE05EC000F;
	Tue,  5 Oct 2021 15:11:56 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 404DBC000D
 for <iommu@lists.linux-foundation.org>; Tue,  5 Oct 2021 15:11:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2C5AF406EA
 for <iommu@lists.linux-foundation.org>; Tue,  5 Oct 2021 15:11:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aorE7Txg0rm7 for <iommu@lists.linux-foundation.org>;
 Tue,  5 Oct 2021 15:11:54 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com
 [IPv6:2607:f8b0:4864:20::52d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4EA9840502
 for <iommu@lists.linux-foundation.org>; Tue,  5 Oct 2021 15:11:54 +0000 (UTC)
Received: by mail-pg1-x52d.google.com with SMTP id s75so2026634pgs.5
 for <iommu@lists.linux-foundation.org>; Tue, 05 Oct 2021 08:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=QSrcQ531lYvMDyqtMmSNSg1D9eOHYmXdh6Sn4g0VZLQ=;
 b=LE+nGxihu74oC3P/yXCbRUT8joVuLjedGgQjvKmK8f3RDbhsFz2Vi3/sS9u9wXnGcX
 K2GgrTHQM2kjOTjbHfEDKSOGaIQ95GlbZ/QF327Ospm5XEbm5TPf6490GoZyuWQ1E/y+
 IeJKKHDWKXVrwoDC9bWA7CsdXkqo8n4aTYFKKesOpEGc2WcdjcTgXydrApYSun1UVsgw
 iY76WfnFfYcz9KR5eDOdItpIDV0s68u3xP+x9H5iDGJotHLBIZgkU1UDs/KH+Jtv0Uja
 Hd84BWPjshr5CEK7HmMKnP/2imJsZdYLGNfIk8+cWZQTHfe+FZ/z7BP+9G5U4gsshMEp
 MPpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=QSrcQ531lYvMDyqtMmSNSg1D9eOHYmXdh6Sn4g0VZLQ=;
 b=2PQaZcE/zcCKnoPaTgJriFCxz1W8xk1OtDWaeumaqwpu49P2KHotyIt3RUcSDrmEht
 NlRXLu3LTsdsaDFDH/wUna0WccyYYbLnE45nCZdi76Jl1nsPKQWSndM8sdB/pUO6em3J
 KZmWW3DlQrcbwZam0xz3zJf6yYK2o3l3RX1nFC9q15wtml9XXMwowySWwJLMye028Wgt
 j2oJv+oDEMwwwOIsJu5mWq3ZV+ijKtvZ3C7nqCS1x4kkm7OEvfACXDhxT6ytD66HYbXE
 uGitWuyA54Z43WqVK044DwX7R4i2G+qC1TPQVEvgg+kPHO8F3kgHZAt6GVYIvYV27Tna
 VBSA==
X-Gm-Message-State: AOAM530LYYyzjHyj/sNbYAGK7skOBgEUhCOCuVPevWZDtclZBrXvV5nI
 D2zHMBp11/uuxVxuTpMXR14=
X-Google-Smtp-Source: ABdhPJxO3G+HWzM6JzFUJostwno3QxJkFsVc0ojvp/XHIKEdzTvHkYlD/6vx1y3wEb8mXk5HXIWGFA==
X-Received: by 2002:aa7:828c:0:b0:44c:28d1:46b9 with SMTP id
 s12-20020aa7828c000000b0044c28d146b9mr19508978pfm.43.1633446713563; 
 Tue, 05 Oct 2021 08:11:53 -0700 (PDT)
Received: from localhost (c-73-25-156-94.hsd1.or.comcast.net. [73.25.156.94])
 by smtp.gmail.com with ESMTPSA id
 k22sm18388032pfi.149.2021.10.05.08.11.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Oct 2021 08:11:51 -0700 (PDT)
From: Rob Clark <robdclark@gmail.com>
To: dri-devel@lists.freedesktop.org
Subject: [PATCH v2 0/3] io-pgtable-arm + drm/msm: Extend iova fault debugging
Date: Tue,  5 Oct 2021 08:16:24 -0700
Message-Id: <20211005151633.1738878-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Cc: Yangtao Li <tiny.windzz@gmail.com>,
 Konrad Dybcio <konrad.dybcio@somainline.org>,
 Akhil P Oommen <akhilpo@codeaurora.org>,
 open list <linux-kernel@vger.kernel.org>, Will Deacon <will@kernel.org>,
 Rob Clark <robdclark@chromium.org>, Jonathan Marek <jonathan@marek.ca>,
 Joerg Roedel <jroedel@suse.de>,
 "open list:DRM DRIVER FOR MSM ADRENO GPU" <linux-arm-msm@vger.kernel.org>,
 Sharat Masetty <smasetty@codeaurora.org>, Stephen Boyd <swboyd@chromium.org>,
 linux-arm-kernel@lists.infradead.org,
 "Isaac J. Manjarres" <isaacm@codeaurora.org>,
 Robin Murphy <robin.murphy@arm.com>, Douglas Anderson <dianders@chromium.org>,
 "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 freedreno@lists.freedesktop.org,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
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

From: Rob Clark <robdclark@chromium.org>

This series extends io-pgtable-arm with a method to retrieve the page
table entries traversed in the process of address translation, and then
beefs up drm/msm gpu devcore dump to include this (and additional info)
in the devcore dump.

The motivation is tracking down an obscure iova fault triggered crash on
the address of the IB1 cmdstream.  This is one of the few places where
the GPU address written into the cmdstream is soley under control of the
kernel mode driver, so I don't think it can be a userspace bug.  The
logged cmdstream from the devcore's I've looked at look correct, and the
TTBR0 read back from arm-smmu agrees with the kernel emitted cmdstream.
Unfortunately it happens infrequently enough (something like once per
1000hrs of usage, from what I can tell from our telemetry) that actually
reproducing it with an instrumented debug kernel is not an option.  So
further spiffying out the devcore dumps and hoping we can spot a clue is
the plan I'm shooting for.

See https://gitlab.freedesktop.org/drm/msm/-/issues/8 for more info on
the issue I'm trying to debug.

v2: Fix an armv7/32b build error in the last patch

Rob Clark (3):
  iommu/io-pgtable-arm: Add way to debug pgtable walk
  drm/msm: Show all smmu info for iova fault devcore dumps
  drm/msm: Extend gpu devcore dumps with pgtbl info

 drivers/gpu/drm/msm/adreno/a6xx_gpu.c   |  2 +-
 drivers/gpu/drm/msm/adreno/adreno_gpu.c | 35 +++++++++++++++++-----
 drivers/gpu/drm/msm/msm_gpu.c           | 10 +++++++
 drivers/gpu/drm/msm/msm_gpu.h           | 10 ++++++-
 drivers/gpu/drm/msm/msm_iommu.c         | 17 +++++++++++
 drivers/gpu/drm/msm/msm_mmu.h           |  2 ++
 drivers/iommu/io-pgtable-arm.c          | 40 ++++++++++++++++++++-----
 include/linux/io-pgtable.h              |  9 ++++++
 8 files changed, 107 insertions(+), 18 deletions(-)

-- 
2.31.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
