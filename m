Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6783C433EF
	for <iommu@archiver.kernel.org>; Tue, 22 Feb 2022 18:54:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5512D40302;
	Tue, 22 Feb 2022 18:54:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AqLr91daXQDE; Tue, 22 Feb 2022 18:54:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 2EBEF402BC;
	Tue, 22 Feb 2022 18:54:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0BBF8C001A;
	Tue, 22 Feb 2022 18:54:37 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 531BBC0011
 for <iommu@lists.linux-foundation.org>; Tue, 22 Feb 2022 18:54:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id AE22F60EEF
 for <iommu@lists.linux-foundation.org>; Tue, 22 Feb 2022 18:54:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ny3eIpiU8VZh for <iommu@lists.linux-foundation.org>;
 Tue, 22 Feb 2022 18:54:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 24FD660EE0
 for <iommu@lists.linux-foundation.org>; Tue, 22 Feb 2022 18:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1645556074; x=1677092074;
 h=from:to:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=P+VHI+n/RJFH+AzKfcSRwsfvLy40Ni3+5cBuLLVdhtI=;
 b=bRAaSURWGFqxSrXoESzJtF2IwuRIQK1+3/liefMBuQ/ODzubY/cLHFnA
 RuPCQ9QYTi8Te7YcQbhEoPafd0GmPgx+wUbZIK3riOjYXapdlKsTalxAz
 EyN5/VkGnLzqnUdodlHzQrYV6DCrq7YwbZF/EvXyfA8taZwqB6DsxDEu7
 RYSY/iVg3h89psoYZ0785h/YDG7lol0h0VYcyv68hXobN+IJmzHxTX9Sm
 1F+wB+o4Y4bGtHOBnYCwXTD4WImWpFwt3OFmzvv/jlzsM+yY9Uzn/a9ue
 AvoIZvAAXfKlSpPPiuP7FcpN4Xr25JSFxEjJq3M9EFnxleRCeelQp/ZVH A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10266"; a="239168604"
X-IronPort-AV: E=Sophos;i="5.88,387,1635231600"; d="scan'208";a="239168604"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Feb 2022 10:54:24 -0800
X-IronPort-AV: E=Sophos;i="5.88,387,1635231600"; d="scan'208";a="508105487"
Received: from oux.sc.intel.com ([10.3.52.57])
 by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Feb 2022 10:54:24 -0800
From: Yian Chen <yian.chen@intel.com>
To: David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>,
 Ashok Raj <ashok.raj@intel.com>, Sohil Mehta <sohil.mehta@intel.com>,
 Jacob jun Pan <jacob.jun.pan@intel.com>, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, Yian Chen <yian.chen@intel.com>
Subject: [PATCH v2 0/2] Enable ATS for the devices in SATC table
Date: Tue, 22 Feb 2022 10:54:14 -0800
Message-Id: <20220222185416.1722611-1-yian.chen@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
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

The devices in BIOS SATC (SoC integrated Address Translation Cache)
table are all trusted devices to use ATS. This patch set enables
ATS for them.

---
v2:
  - Use dmar_find_matched_satc_unit() to avoid hard coded
    return value.
  - add static declaration for dmar_ats_supported()
    (the function modified from 
     dmar_find_matched_atsr_unit())
---

Yian Chen (2):
  iommu/vt-d: Enable ATS for the devices in SATC table
  iommu/vt-d: Declare dmar_ats_supported() as static function

 drivers/iommu/intel/iommu.c | 128 +++++++++++++++++++++++-------------
 include/linux/intel-iommu.h |   1 -
 2 files changed, 83 insertions(+), 46 deletions(-)

-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
