Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2566AC433F5
	for <iommu@archiver.kernel.org>; Sat, 14 May 2022 01:47:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BCAC340133;
	Sat, 14 May 2022 01:47:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oiPxZmunKUPx; Sat, 14 May 2022 01:47:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 8ACDC4015D;
	Sat, 14 May 2022 01:47:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 71587C0032;
	Sat, 14 May 2022 01:47:06 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 28225C002D
 for <iommu@lists.linux-foundation.org>; Sat, 14 May 2022 01:47:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 08AD8404A9
 for <iommu@lists.linux-foundation.org>; Sat, 14 May 2022 01:47:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 92P4i_lEJH3i for <iommu@lists.linux-foundation.org>;
 Sat, 14 May 2022 01:47:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7550B4049A
 for <iommu@lists.linux-foundation.org>; Sat, 14 May 2022 01:47:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1652492824; x=1684028824;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=XbwqW8vSlHbl+VRBpjcHQ0sS7eNwoXn7JqpMKEUCRQ8=;
 b=Lyd3KiEc30gC9qTFaah9sF9FJjZ8NKm7CpwKtqrj928E3ujAVpG5BcsV
 C+nNqQ6z1whMa0JCGg0I/EO2eUj1cj5sMB1obNeWwUpNqCPBtvEbfn0n+
 6WPG5joEKBjkQlJ1BKXwTdqifk0DJKaEdIpplX3s1hr/Qr3RVTU9g2aLa
 KW9eNThy7lOwc830hXxxa47F1TEC2JrcUWpsf/jW29kjxSZc7T0CLzZEO
 yKH2Pk3T5qdhLPkKmxrTjYAfHyFZ03pjvWX4ev7+eALhws690lWglvgSh
 zpvdNmhV+JTqdtEM7htC6pqyHTh0PLKUUbR3fPPwv8fw2oyoqbB3JMGSz Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10346"; a="250358182"
X-IronPort-AV: E=Sophos;i="5.91,223,1647327600"; d="scan'208";a="250358182"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 May 2022 18:47:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,223,1647327600"; d="scan'208";a="712630812"
Received: from allen-box.sh.intel.com ([10.239.159.48])
 by fmsmga001.fm.intel.com with ESMTP; 13 May 2022 18:46:58 -0700
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
Subject: [PATCH 5/7] KVM: x86: Remove unnecessary include
Date: Sat, 14 May 2022 09:43:20 +0800
Message-Id: <20220514014322.2927339-6-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220514014322.2927339-1-baolu.lu@linux.intel.com>
References: <20220514014322.2927339-1-baolu.lu@linux.intel.com>
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

intel-iommu.h is not needed in kvm/x86 anymore. Remove its include.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 arch/x86/kvm/x86.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 4790f0d7d40b..fdf6ce5855d9 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -41,7 +41,6 @@
 #include <linux/mman.h>
 #include <linux/highmem.h>
 #include <linux/iommu.h>
-#include <linux/intel-iommu.h>
 #include <linux/cpufreq.h>
 #include <linux/user-return-notifier.h>
 #include <linux/srcu.h>
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
