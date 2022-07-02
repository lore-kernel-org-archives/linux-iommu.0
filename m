Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5768AC43334
	for <iommu@archiver.kernel.org>; Sat,  2 Jul 2022 02:00:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E773284740;
	Sat,  2 Jul 2022 02:00:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E773284740
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=H9/zdWOE
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aKsKJh317bOh; Sat,  2 Jul 2022 02:00:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id CD3A38472E;
	Sat,  2 Jul 2022 02:00:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CD3A38472E
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A141BC0035;
	Sat,  2 Jul 2022 02:00:57 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 384FBC002D
 for <iommu@lists.linux-foundation.org>; Sat,  2 Jul 2022 02:00:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 05964418AA
 for <iommu@lists.linux-foundation.org>; Sat,  2 Jul 2022 02:00:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 05964418AA
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=H9/zdWOE
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id N4ZF0KV_pFmm for <iommu@lists.linux-foundation.org>;
 Sat,  2 Jul 2022 02:00:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org F2123418A6
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by smtp4.osuosl.org (Postfix) with ESMTPS id F2123418A6
 for <iommu@lists.linux-foundation.org>; Sat,  2 Jul 2022 02:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1656727254; x=1688263254;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ES4BgWmczuXVvIJOwIS6o6KxGZWScbVt38+yOQD7Uwo=;
 b=H9/zdWOEDQLQ4yJEhDjK/tjIcTvozN4eOvg//ZrRBC8BoTV+W9L1ufvv
 jz5Xu6fOn0ElTfnFeimH/A92zEtUMqx9SgNtNNjNYO7qmY9nOWXw+uU0t
 ThYQjZ+rcqSZ1W6KCqgwt8VmM4NvInzD2mjfqVp7DpnLS1vLgIvosESra
 wjo6qfUWkNPGKsF4UTIVJ3ueopM3mSvIRsHLrkXW0+JhRZCf6AvQl+TfG
 q4SgsbeZfEzIRpcV1VCHcoJanmWkwwsmlSXXrdjcL7hH9mwo+C8pshD04
 O2Kcl3I6LYnQcy+7tgAljo8IxmIUgjDpkTuxtUETTCjczdpKXV03BoXjb g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10395"; a="280338401"
X-IronPort-AV: E=Sophos;i="5.92,238,1650956400"; d="scan'208";a="280338401"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jul 2022 19:00:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,238,1650956400"; d="scan'208";a="589518343"
Received: from allen-box.sh.intel.com ([10.239.159.48])
 by orsmga007.jf.intel.com with ESMTP; 01 Jul 2022 19:00:51 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>, Steve Wahl <steve.wahl@hpe.com>,
 Kevin Tian <kevin.tian@intel.com>
Subject: [PATCH v2 6/6] iommu/vt-d: Make DMAR_UNITS_SUPPORTED default 1024
Date: Sat,  2 Jul 2022 09:56:10 +0800
Message-Id: <20220702015610.2849494-7-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220702015610.2849494-1-baolu.lu@linux.intel.com>
References: <20220702015610.2849494-1-baolu.lu@linux.intel.com>
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

If the available hardware exceeds DMAR_UNITS_SUPPORTED (previously set
to MAX_IO_APICS, or 128), it causes these messages: "DMAR: Failed to
allocate seq_id", "DMAR: Parse DMAR table failure.", and "x2apic: IRQ
remapping doesn't support X2APIC mode x2apic disabled"; and the system
fails to boot properly.

To support up to 64 sockets with 10 DMAR units each (640), make the
value of DMAR_UNITS_SUPPORTED default 1024.

Signed-off-by: Steve Wahl<steve.wahl@hpe.com>
Link: https://lore.kernel.org/linux-iommu/20220615183650.32075-1-steve.wahl@hpe.com/
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
---
 include/linux/dmar.h | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/include/linux/dmar.h b/include/linux/dmar.h
index cbd714a198a0..d81a51978d01 100644
--- a/include/linux/dmar.h
+++ b/include/linux/dmar.h
@@ -18,11 +18,7 @@
 
 struct acpi_dmar_header;
 
-#ifdef	CONFIG_X86
-# define	DMAR_UNITS_SUPPORTED	MAX_IO_APICS
-#else
-# define	DMAR_UNITS_SUPPORTED	64
-#endif
+#define DMAR_UNITS_SUPPORTED	1024
 
 /* DMAR Flags */
 #define DMAR_INTR_REMAP		0x1
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
