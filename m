Return-Path: <SRS0=Y/Kh=OV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76DA2C433F5
	for <iommu@archiver.kernel.org>; Fri,  1 Oct 2021 14:34:41 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E69E61A40
	for <iommu@archiver.kernel.org>; Fri,  1 Oct 2021 14:34:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1E69E61A40
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E0BA6421EE;
	Fri,  1 Oct 2021 14:34:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TKINQpuCSW4Y; Fri,  1 Oct 2021 14:34:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id C5A4F421EA;
	Fri,  1 Oct 2021 14:34:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5B2FBC0025;
	Fri,  1 Oct 2021 14:34:39 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E973AC000D
 for <iommu@lists.linux-foundation.org>; Fri,  1 Oct 2021 14:34:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C8B70421EE
 for <iommu@lists.linux-foundation.org>; Fri,  1 Oct 2021 14:34:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id urZxgl0y4jXA for <iommu@lists.linux-foundation.org>;
 Fri,  1 Oct 2021 14:34:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B3E55421C8
 for <iommu@lists.linux-foundation.org>; Fri,  1 Oct 2021 14:34:36 +0000 (UTC)
Received: from localhost.localdomain (unknown
 [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested) (Authenticated sender: bbrezillon)
 by bhuna.collabora.co.uk (Postfix) with ESMTPSA id D77351F457A9;
 Fri,  1 Oct 2021 15:34:33 +0100 (BST)
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org,
 Rob Herring <robh+dt@kernel.org>,
 Tomeu Vizoso <tomeu.vizoso@collabora.com>,
 Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
 Steven Price <steven.price@arm.com>, Robin Murphy <robin.murphy@arm.com>,
 Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 0/5] drm/panfrost: Add extra GPU-usage flags
Date: Fri,  1 Oct 2021 16:34:22 +0200
Message-Id: <20211001143427.1564786-1-boris.brezillon@collabora.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Cc: Boris Brezillon <boris.brezillon@collabora.com>,
 dri-devel@lists.freedesktop.org
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

Hello,

This is a follow-up of [1], which was adding the read/write
restrictions on GPU buffers. Robin and Steven suggested that I add a
flag to restrict the shareability domain on GPU-private buffers, so
here it is.

As you can see, the first patch is flagges RFC, since I'm not sure
adding a new IOMMU_ flag is the right solution, but IOMMU_CACHE
doesn't feel like a good fit either. Please let me know if you have
better ideas.

Regards,

Boris

[1]https://patchwork.kernel.org/project/dri-devel/patch/20210930184723.1482426-1-boris.brezillon@collabora.com/

Boris Brezillon (5):
  [RFC]iommu: Add a IOMMU_DEVONLY protection flag
  [RFC]iommu/io-pgtable-arm: Take the DEVONLY flag into account on
    ARM_MALI_LPAE
  drm/panfrost: Add PANFROST_BO_NO{READ,WRITE} flags
  drm/panfrost: Add a PANFROST_BO_GPUONLY flag
  drm/panfrost: Bump the driver version to 1.3

 drivers/gpu/drm/panfrost/panfrost_drv.c | 15 +++++++++++++--
 drivers/gpu/drm/panfrost/panfrost_gem.c |  3 +++
 drivers/gpu/drm/panfrost/panfrost_gem.h |  3 +++
 drivers/gpu/drm/panfrost/panfrost_mmu.c | 11 ++++++++++-
 drivers/iommu/io-pgtable-arm.c          | 25 +++++++++++++++++--------
 include/linux/iommu.h                   |  7 +++++++
 include/uapi/drm/panfrost_drm.h         |  3 +++
 7 files changed, 56 insertions(+), 11 deletions(-)

-- 
2.31.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
