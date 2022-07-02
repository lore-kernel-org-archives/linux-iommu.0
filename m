Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3CE71849
	for <iommu@lists.linux.dev>; Sat,  2 Jul 2022 02:00:54 +0000 (UTC)
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
   O2Kcl3I6LYnQcy+7tgAljo8IxmIUgjDpkTuxtUETTCjczdpKXV03BoXjb
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10395"; a="281539723"
X-IronPort-AV: E=Sophos;i="5.92,238,1650956400"; 
   d="scan'208";a="281539723"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2022 19:00:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,238,1650956400"; 
   d="scan'208";a="589518343"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga007.jf.intel.com with ESMTP; 01 Jul 2022 19:00:51 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Steve Wahl <steve.wahl@hpe.com>,
	Kevin Tian <kevin.tian@intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>,
	Jerry Snitselaar <jsnitsel@redhat.com>,
	Mike Travis <mike.travis@hpe.com>,
	Dimitri Sivanich <sivanich@hpe.com>,
	Russ Anderson <russ.anderson@hpe.com>,
	iommu@lists.linux.dev,
	iommu@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v2 6/6] iommu/vt-d: Make DMAR_UNITS_SUPPORTED default 1024
Date: Sat,  2 Jul 2022 09:56:10 +0800
Message-ID: <20220702015610.2849494-7-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220702015610.2849494-1-baolu.lu@linux.intel.com>
References: <20220702015610.2849494-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID: <20220702015610.2JDJsy-1zZPb2K3aPT6x61BGuXDEWNLin7vgsljmrxk@z>

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

