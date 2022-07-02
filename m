Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3C0CC433EF
	for <iommu@archiver.kernel.org>; Sat,  2 Jul 2022 02:00:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2454E60B0A;
	Sat,  2 Jul 2022 02:00:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2454E60B0A
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kk7/1PD2
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RG57j9vjZEz3; Sat,  2 Jul 2022 02:00:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id ACBA760B09;
	Sat,  2 Jul 2022 02:00:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org ACBA760B09
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 76DB9C0035;
	Sat,  2 Jul 2022 02:00:39 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C70D1C002D
 for <iommu@lists.linux-foundation.org>; Sat,  2 Jul 2022 02:00:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8C73E4189B
 for <iommu@lists.linux-foundation.org>; Sat,  2 Jul 2022 02:00:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8C73E4189B
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=kk7/1PD2
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id a84RhFDDwxm4 for <iommu@lists.linux-foundation.org>;
 Sat,  2 Jul 2022 02:00:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 33666415A0
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 33666415A0
 for <iommu@lists.linux-foundation.org>; Sat,  2 Jul 2022 02:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1656727237; x=1688263237;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=UQ8rm6he44UkqobDuw9OLVJ2BgIRmbGPjiGXkEH/j+k=;
 b=kk7/1PD2DdrtpfBaseP0hTRiAiM3lcoMsg+PI5+KIXn2VgVPFRMWc2jZ
 5wA3cVwGhFR+rDFKQY3SZhjyKYg4DnLTs4N+VIuU74q9uksQB8NUVOgoa
 9qLxUL6t+TBQIwrs2pZlPpkiJVnlxafApZs4XlvBOZQL7o8rHZktEMMjX
 Eq9ifRstbSRL3eMQ00CYCLIkeHg6RNJ7M5BSo8ve4IJb5oHa4vQydiRf/
 xmKpgoaUo3OB9qXqNM/f01qr+qfqE8kX37uawa4HkaSRKQEt3YeBhV+kE
 HdAp+KILfmSO1pVpJStCq9/XudOur1f2jWPf9a/esKecXZ/nnjG8urEVV A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10395"; a="280338336"
X-IronPort-AV: E=Sophos;i="5.92,238,1650956400"; d="scan'208";a="280338336"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jul 2022 19:00:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,238,1650956400"; d="scan'208";a="589518271"
Received: from allen-box.sh.intel.com ([10.239.159.48])
 by orsmga007.jf.intel.com with ESMTP; 01 Jul 2022 19:00:32 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>, Steve Wahl <steve.wahl@hpe.com>,
 Kevin Tian <kevin.tian@intel.com>
Subject: [PATCH v2 0/6] iommu/vt-d: Reset DMAR_UNITS_SUPPORTED
Date: Sat,  2 Jul 2022 09:56:04 +0800
Message-Id: <20220702015610.2849494-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Cc: Dimitri Sivanich <sivanich@hpe.com>, Russ Anderson <russ.anderson@hpe.com>,
 Mike Travis <mike.travis@hpe.com>, Jerry Snitselaar <jsnitsel@redhat.com>,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev, David Woodhouse <dwmw2@infradead.org>
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

This is a follow-up series of changes proposed by this patch:

https://lore.kernel.org/linux-iommu/20220615183650.32075-1-steve.wahl@hpe.com/

It removes several static arrays of size DMAR_UNITS_SUPPORTED and sets
the DMAR_UNITS_SUPPORTED to 1024.

This series is also available on github:

https://github.com/LuBaolu/intel-iommu/commits/reset-DMAR_UNITS_SUPPORTED-v2

Please help review and suggest.

Best regards,
baolu

Change log:

v2:
 - Set the right @max for ida_alloc_range() and return the right error
   when ida_alloc_range() returns failure.
 - Replace xa_store() with xa_cmpxchg().
 - Set domain->nid to NUMA_NO_NODE when domain is detached from an
   iommu.
 - Avoid adding a new VTD_FLAG_IOMMU_PROBED flag. Remove the duplicate
   check directly.

v1:
 - https://lore.kernel.org/lkml/20220625125204.2199437-1-baolu.lu@linux.intel.com/
 - Initial post.

Lu Baolu (6):
  iommu/vt-d: Remove unused domain_get_iommu()
  iommu/vt-d: Use IDA interface to manage iommu sequence id
  iommu/vt-d: Refactor iommu information of each domain
  iommu/vt-d: Remove unnecessary check in intel_iommu_add()
  iommu/vt-d: Remove global g_iommus array
  iommu/vt-d: Make DMAR_UNITS_SUPPORTED default 1024

 include/linux/dmar.h        |   6 +-
 drivers/iommu/intel/iommu.h |  30 ++++--
 drivers/iommu/intel/dmar.c  |  35 ++-----
 drivers/iommu/intel/iommu.c | 189 ++++++++++++++----------------------
 drivers/iommu/intel/pasid.c |   2 +-
 drivers/iommu/intel/svm.c   |   2 +-
 6 files changed, 103 insertions(+), 161 deletions(-)

-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
