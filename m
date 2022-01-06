Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 899EEC433F5
	for <iommu@archiver.kernel.org>; Thu,  6 Jan 2022 02:21:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1368340441;
	Thu,  6 Jan 2022 02:21:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Vj65k6enU7CP; Thu,  6 Jan 2022 02:21:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id AEA9040017;
	Thu,  6 Jan 2022 02:21:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8731EC002F;
	Thu,  6 Jan 2022 02:21:53 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C134FC001E
 for <iommu@lists.linux-foundation.org>; Thu,  6 Jan 2022 02:21:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9B3A6402D7
 for <iommu@lists.linux-foundation.org>; Thu,  6 Jan 2022 02:21:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yrL7HO1gk_Tf for <iommu@lists.linux-foundation.org>;
 Thu,  6 Jan 2022 02:21:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B7D6B402D2
 for <iommu@lists.linux-foundation.org>; Thu,  6 Jan 2022 02:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1641435710; x=1672971710;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=exYGrLYHGT8TzV5cnLFjwED9oszGYl1Sy9IWfWRq36I=;
 b=cuwTyMkeJolBJHmcVUEKxaW0eLo+70SwxNCTRo71qdu6RO2Qi0BSy9O0
 ugXDlsncJ1EyHpDcVR7nPg/dEE/aTBOmdT/VLTe120oF9U/b2AMsrkSG/
 M/NFd/detzUax6hMhgj+3VCnnb/snulDToiBEL+CAHXaCds0fq/4aQzr5
 ZIFKGtPZ9dY0mpLjvFnJXCea6dD3ljF9tiEkmBl23yJBn69EpSVxgevv6
 FAADQ7ZOm+MlHTmqDSLgISxoPKzpLrCfud2JxTsmaHHipjLW0nvLZLs3v
 D2JmHzvR8a15K6mC/Fn8DopYKukqnNZmiUAQKWExGxNCQBI0H56agJXf1 g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="222570890"
X-IronPort-AV: E=Sophos;i="5.88,265,1635231600"; d="scan'208";a="222570890"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jan 2022 18:21:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,265,1635231600"; d="scan'208";a="526794259"
Received: from allen-box.sh.intel.com ([10.239.159.118])
 by orsmga008.jf.intel.com with ESMTP; 05 Jan 2022 18:21:42 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Christoph Hellwig <hch@infradead.org>, Kevin Tian <kevin.tian@intel.com>,
 Ashok Raj <ashok.raj@intel.com>
Subject: [PATCH v1 0/8] Scrap iommu_attach/detach_group() interfaces
Date: Thu,  6 Jan 2022 10:20:45 +0800
Message-Id: <20220106022053.2406748-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Cc: kvm@vger.kernel.org, rafael@kernel.org, David Airlie <airlied@linux.ie>,
 linux-pci@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>,
 Diana Craciun <diana.craciun@oss.nxp.com>, Dmitry Osipenko <digetx@gmail.com>,
 Will Deacon <will@kernel.org>, Stuart Yoder <stuyoder@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, Chaitanya Kulkarni <kch@nvidia.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Dan Williams <dan.j.williams@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Cornelia Huck <cohuck@redhat.com>, linux-kernel@vger.kernel.org,
 Li Yang <leoyang.li@nxp.com>, iommu@lists.linux-foundation.org,
 Jacob jun Pan <jacob.jun.pan@intel.com>, Daniel Vetter <daniel@ffwll.ch>
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

Hi folks,

The iommu_attach_device() added first by commit <fc2100eb4d096> ("add
frontend implementation for the IOMMU API") in 2008. At that time,
there was no concept of iommu group yet.

The iommu group was added by commit <d72e31c937462> ("iommu: IOMMU
Groups") four years later in 2012. The iommu_attach_group() was added
at the same time.

Then, people realized that iommu_attach_device() allowed different
device in a same group to attach different domain. This was not in
line with the concept of iommu group. The commit <426a273834eae>
("iommu: Limit iommu_attach/detach_device to device with their own
group") fixed this problem in 2015.

As the result, we have two coexisting interfaces for device drivers
to do the same thing. But neither is perfect:

  - iommu_attach_device() only works for singleton group.
  - iommu_attach_group() asks the device drivers to handle iommu group
    related staff which is beyond the role of a device driver.

Considering from the perspective of a device driver, its motivation is
very simple: "I want to manage my own I/O address space." Inspired by
the discussion [1], we consider heading in this direction:

Make the iommu_attach_device() the only and generic interface for the
device drivers to use their own private domain (I/O address space)
and replace all iommu_attach_group() uses with iommu_attach_device()
and deprecate the former.

This is a follow-up series of this discussion: 
[1] https://lore.kernel.org/linux-iommu/b4405a5e-c4cc-f44a-ab43-8cb62b888565@linux.intel.com/

It depends on the series of "Fix BUG_ON in vfio_iommu_group_notifier()".
The latest version was posted here:
https://lore.kernel.org/linux-iommu/20220104015644.2294354-1-baolu.lu@linux.intel.com/

and the whole patches are available on github:
https://github.com/LuBaolu/intel-iommu/commits/iommu-domain-attach-refactor-v1

Best regards,
baolu

Jason Gunthorpe (1):
  drm/tegra: Use iommu_attach/detatch_device()

Lu Baolu (7):
  iommu: Add iommu_group_replace_domain()
  vfio/type1: Use iommu_group_replace_domain()
  iommu: Extend iommu_at[de]tach_device() for multi-device groups
  iommu/amd: Use iommu_attach/detach_device()
  gpu/host1x: Use iommu_attach/detach_device()
  media: staging: media: tegra-vde: Use iommu_attach/detach_device()
  iommu: Remove iommu_attach/detach_group()

 include/linux/iommu.h                   |  25 ++---
 drivers/gpu/drm/tegra/dc.c              |   1 +
 drivers/gpu/drm/tegra/drm.c             |  47 +++-----
 drivers/gpu/drm/tegra/gr2d.c            |   1 +
 drivers/gpu/drm/tegra/gr3d.c            |   1 +
 drivers/gpu/drm/tegra/vic.c             |   1 +
 drivers/gpu/host1x/dev.c                |   4 +-
 drivers/iommu/amd/iommu_v2.c            |   4 +-
 drivers/iommu/iommu.c                   | 136 +++++++++++++++++-------
 drivers/staging/media/tegra-vde/iommu.c |   6 +-
 drivers/vfio/vfio_iommu_type1.c         |  22 ++--
 11 files changed, 146 insertions(+), 102 deletions(-)

-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
