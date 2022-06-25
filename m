Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521637C
	for <iommu@lists.linux.dev>; Sat, 25 Jun 2022 12:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656161808; x=1687697808;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=t65pYKyMV4XOK7nEHhdalG87XLHrbrBHX7dnd091tts=;
  b=jrTFY70sEYytG3uwjclP/yzMmjXtQHwXl4IhSDAZXjYMonh9hAwcpJu6
   XI5HyzvAJjxgvFEDyZU/ChCH1vwhYtVH9eZC6lizJ84XE+pslZMk64ncv
   mxt0wqAJ2JCPpx9KELbieDPWZ1hXiLJvZPEvUZtG1/EjXaSRosYvj3hD2
   o3gX+lPYlMPrTyE2/vcYaxvGGWxzh7jcVQarGicnMRBrIZK+OGeTO8t7F
   xbJtRenlznHmFQEgmeoxlMzxceobcmviyn56Rfc7SmXc1XjLVQp7Uo4Nh
   k+z6gUjY60IugtYEOv/W6V7qRhxE9UeenyAQdyv+sVoGMKzljAoADhs1T
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10388"; a="261600758"
X-IronPort-AV: E=Sophos;i="5.92,222,1650956400"; 
   d="scan'208";a="261600758"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2022 05:56:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,222,1650956400"; 
   d="scan'208";a="586890410"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga007.jf.intel.com with ESMTP; 25 Jun 2022 05:56:45 -0700
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
Subject: [PATCH v1 6/6] iommu/vt-d: Make DMAR_UNITS_SUPPORTED default 1024
Date: Sat, 25 Jun 2022 20:52:04 +0800
Message-ID: <20220625125204.2199437-7-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220625125204.2199437-1-baolu.lu@linux.intel.com>
References: <20220625125204.2199437-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID: <20220625125204.hi3jE_zJcW7MPmIM_mtvdGyZLaX9X2Vt2rwn3gRlay8@z>

If the available hardware exceeds DMAR_UNITS_SUPPORTED (previously set
to MAX_IO_APICS, or 128), it causes these messages: "DMAR: Failed to
allocate seq_id", "DMAR: Parse DMAR table failure.", and "x2apic: IRQ
remapping doesn't support X2APIC mode x2apic disabled"; and the system
fails to boot properly.

To support up to 64 sockets with 10 DMAR units each (640), make the
value of DMAR_UNITS_SUPPORTED default 1024.

Signed-off-by: Steve Wahl<steve.wahl@hpe.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
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

