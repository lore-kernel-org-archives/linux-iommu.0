Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4133FC433EF
	for <iommu@archiver.kernel.org>; Sat, 14 May 2022 01:46:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D4405813C8;
	Sat, 14 May 2022 01:46:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 902oSWkGqxIX; Sat, 14 May 2022 01:46:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id B466881391;
	Sat, 14 May 2022 01:46:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7A6DCC0032;
	Sat, 14 May 2022 01:46:42 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A0C2FC002D
 for <iommu@lists.linux-foundation.org>; Sat, 14 May 2022 01:46:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8883C600B5
 for <iommu@lists.linux-foundation.org>; Sat, 14 May 2022 01:46:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bNpxnWy3pFt6 for <iommu@lists.linux-foundation.org>;
 Sat, 14 May 2022 01:46:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C2A9F6005E
 for <iommu@lists.linux-foundation.org>; Sat, 14 May 2022 01:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1652492798; x=1684028798;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=Q4OHxOkBcZ+3CvVCvY0m+wxDlD8i3ZcBOa66oWnNSzg=;
 b=gopnPECJWp1t8wKNPoFaTVRmzT77myS1lzwADn9kZICa7ioMpVUVdbEg
 JtSAmj6BRHslfGYHd5P60pea7jvAc9HLoXu0DNWOTXcjS3YROuxx5eUaA
 BuYUvO1IJ0Rlx2SShAW/dpVNpWcrZkkuAoTKXsiL5PqOy4BSuwiGnvtQH
 5qvxPU1YFspfk6wYmw9mI8D10VfTZJVmC5n+rdpTXUGAZIlnE7ca5cP9g
 BWwfYcjuV4fsT/ebEVZMEfuSY5IvMsVhP4dZxHFegAw93uMeecRwRIst9
 AqU9Hqm9T8gewMZluqdU+r9+qPl3WNq+JGl0jNspcPVu45LAQwyd/Rn2q w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10346"; a="333487663"
X-IronPort-AV: E=Sophos;i="5.91,223,1647327600"; d="scan'208";a="333487663"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 May 2022 18:46:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,223,1647327600"; d="scan'208";a="712630756"
Received: from allen-box.sh.intel.com ([10.239.159.48])
 by fmsmga001.fm.intel.com with ESMTP; 13 May 2022 18:46:31 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, David Airlie <airlied@linux.ie>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
 Daniel Vetter <daniel@ffwll.ch>, Kevin Tian <kevin.tian@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, Liu Yi L <yi.l.liu@intel.com>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>, Ning Sun <ning.sun@intel.com>
Subject: [PATCH 0/7] iommu/vt-d: Make intel-iommu.h private
Date: Sat, 14 May 2022 09:43:15 +0800
Message-Id: <20220514014322.2927339-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Cc: Steve Wahl <steve.wahl@hpe.com>, Will Deacon <will@kernel.org>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Jason Gunthorpe <jgg@nvidia.com>, Robin Murphy <robin.murphy@arm.com>,
 Christoph Hellwig <hch@lst.de>
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

The include/linux/intel-iommu.h should be private to the Intel IOMMU
driver. Other drivers or components should interact with the IOMMU
drivers through the kAPIs provided by the iommu core.

This series cleanups all includes of intel-iommu.h outside of the Intel
IOMMU driver and move this header from include/linux to
drivers/iommu/intel/.

No functional changes intended. Please help to review and suggest.

Best regards,
baolu

Lu Baolu (7):
  iommu/vt-d: Move trace/events/intel_iommu.h under iommu
  agp/intel: Use per device iommu check
  iommu/vt-d: Remove unnecessary exported symbol
  drm/i915: Remove unnecessary include
  KVM: x86: Remove unnecessary include
  x86/boot/tboot: Move tboot_force_iommu() to Intel IOMMU
  iommu/vt-d: Move include/linux/intel_iommu.h under iommu

 include/linux/tboot.h                         |  2 --
 drivers/gpu/drm/i915/i915_drv.h               |  1 -
 .../iommu/intel/iommu.h                       |  1 -
 .../iommu/intel/trace.h                       |  7 +++++-
 arch/x86/kernel/tboot.c                       | 15 -------------
 arch/x86/kvm/x86.c                            |  1 -
 drivers/char/agp/intel-gtt.c                  | 17 ++++++--------
 drivers/gpu/drm/i915/display/intel_display.c  |  1 -
 .../gpu/drm/i915/gem/i915_gem_execbuffer.c    |  1 -
 drivers/iommu/intel/cap_audit.c               |  2 +-
 drivers/iommu/intel/debugfs.c                 |  2 +-
 drivers/iommu/intel/dmar.c                    |  4 ++--
 drivers/iommu/intel/iommu.c                   | 22 +++++++++++++------
 drivers/iommu/intel/irq_remapping.c           |  2 +-
 drivers/iommu/intel/pasid.c                   |  2 +-
 drivers/iommu/intel/perf.c                    |  2 +-
 drivers/iommu/intel/svm.c                     |  4 ++--
 drivers/iommu/intel/trace.c                   |  2 +-
 MAINTAINERS                                   |  1 -
 19 files changed, 38 insertions(+), 51 deletions(-)
 rename include/linux/intel-iommu.h => drivers/iommu/intel/iommu.h (99%)
 rename include/trace/events/intel_iommu.h => drivers/iommu/intel/trace.h (93%)

-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
