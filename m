Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B74DC433F5
	for <iommu@archiver.kernel.org>; Fri, 11 Feb 2022 03:06:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CC33383122;
	Fri, 11 Feb 2022 03:06:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ceUbVbudJPjz; Fri, 11 Feb 2022 03:06:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id BC9EA83123;
	Fri, 11 Feb 2022 03:06:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 91A57C0011;
	Fri, 11 Feb 2022 03:06:56 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8F395C000B
 for <iommu@lists.linux-foundation.org>; Fri, 11 Feb 2022 03:06:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6EF3883122
 for <iommu@lists.linux-foundation.org>; Fri, 11 Feb 2022 03:06:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8hJGsL3i-oix for <iommu@lists.linux-foundation.org>;
 Fri, 11 Feb 2022 03:06:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 293AE83103
 for <iommu@lists.linux-foundation.org>; Fri, 11 Feb 2022 03:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1644548814; x=1676084814;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=CfAPPn4CPgGS2bE7xNJZrnMTTobRXydSSnt+IPub/Ow=;
 b=Cxlwynlygdq/49GXJCkxDgRcl+Dpzw3gTT3EusXEYyQqiN3vUTS74+h5
 hqBoNnCq7xFt3ryi0h5ucKSIc+SkTDmqoF3lJRQVNjFzqdO2tfWfgq3A2
 1DeBd1aeZKFGV6X9UtDuRQMX0p00LA/QIkRDvXrQ+xTlGgu+AJixTzVSj
 MC5yP5ErC3oQ8XQMC4tx/uZZjimQFI4sqgSyyWvSNJKYzuKa0aPWK6lzx
 uXpBwrP/T+oQCLXmfiOUfBbor8G5GTuZkCKD3HjuOLYbp3Lej9EQwOFMY
 ih6G1tfVnPgUaNNYQrZqidj76mLQbL7hhI85Hx7JlMZceXUpPeFxonwIB Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10254"; a="274202596"
X-IronPort-AV: E=Sophos;i="5.88,359,1635231600"; d="scan'208";a="274202596"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Feb 2022 19:06:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,359,1635231600"; d="scan'208";a="483062803"
Received: from allen-box.sh.intel.com ([10.239.159.118])
 by orsmga003.jf.intel.com with ESMTP; 10 Feb 2022 19:06:50 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: David Airlie <airlied@linux.ie>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Chris Wilson <chris@chris-wilson.co.uk>,
 Nathan Myers <ncm@cantrip.org>
Subject: [PATCH 0/2] Replace intel_iommu_gfx_mapped with device_iommu_mapped()
Date: Fri, 11 Feb 2022 11:05:29 +0800
Message-Id: <20220211030531.2398789-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Cc: Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
 Lucas De Marchi <lucas.demarchi@intel.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>
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

Hi,

This follows commit cca084692394a ("drm/i915: Use per device iommu check")
to convert intel_iommu_gfx_mapped use in agp/intel to device_iommu_mapped().
With this changed, the export intel_iommu_gfx_mapped could be removed.

Best regards,
baolu

Lu Baolu (2):
  agp/intel: Use per device iommu check
  iommu/vt-d: Remove unnecessary exported symbol

 include/linux/intel-iommu.h  |  1 -
 drivers/char/agp/intel-gtt.c | 17 +++++++----------
 drivers/iommu/intel/iommu.c  |  6 ------
 3 files changed, 7 insertions(+), 17 deletions(-)

-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
