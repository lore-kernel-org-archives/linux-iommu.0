Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711DE4A32
	for <iommu@lists.linux.dev>; Mon, 22 Aug 2022 20:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661198943; x=1692734943;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=FZlZNnLntdAc6dq6GYaLZUJ2/390X4kLPdz2Q4ZKkfg=;
  b=XB86WlIBWGHuWgbjpj7Bg0KiJ/uRsLvxVfUNxqabNq5oe2O40k4Eg5VS
   a1HOAL31VNqrm0LRP3bZibDiCFtk6io7jZn708C88wUF5s5sYm1YOAkPj
   CtjvQeVv6QFMDALMACeb5vXwd4YpTsUw2qGl9tdv4aM8TkhfWFp8eDESQ
   zjOvALXaWpCM4et/Fp0a2ngCgke8V0LNFwlHtOqjjyjhM6HGLLD+6R1Yx
   lpS46NMRtYYt1C6M0ZDEwJ8q8FH1ZxiJxbv7hJloHjn+rD/8sRW9u6L0f
   cytLtMz+Q7P/Dd7Ygz/U0NzjhPSgsk61FNkK/yKIbOZj6ppEP956hrsK8
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10447"; a="319547405"
X-IronPort-AV: E=Sophos;i="5.93,255,1654585200"; 
   d="scan'208";a="319547405"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2022 13:09:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,255,1654585200"; 
   d="scan'208";a="698414214"
Received: from otc-wp-03.jf.intel.com (HELO jacob-builder.jf.intel.com) ([10.54.39.79])
  by FMSMGA003.fm.intel.com with ESMTP; 22 Aug 2022 13:09:02 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: LKML <linux-kernel@vger.kernel.org>,
	iommu@lists.linux.dev,
	x86@kernel.org,
	Joerg Roedel <joro@8bytes.org>,
	"Lu Baolu" <baolu.lu@linux.intel.com>
Cc: Raj Ashok <ashok.raj@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Dave Hansen <dave.hansen@intel.com>,
	"Borislav Petkov" <bp@alien8.de>,
	"Ingo Molnar" <mingo@redhat.com>,
	"Tian, Kevin" <kevin.tian@intel.com>,
	Yi Liu <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH 0/2] Use the correct page tables for SVA under PTI
Date: Mon, 22 Aug 2022 13:12:11 -0700
Message-Id: <20220822201213.352289-1-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Shared virtual addressing allows DMA to user virtual address, But the
x86 IOMMU drivers are using the kernel copy of the process page tables
when PTI is enabled. This patchset tightens the security intended by
PTI by performing SVA binding with the appropriate process PGDs.

I have tested on Intel platform only, would appreciate itif someone
could help with testing SVA-KPTI on an AMD system.

Jacob Pan (2):
  x86: mm: Allow PTI helpers to be used outside x86/mm
  iommu: Use the user PGD for SVA if PTI is enabled

 arch/x86/include/asm/pgtable.h | 5 +++++
 drivers/iommu/amd/iommu_v2.c   | 4 +++-
 drivers/iommu/intel/svm.c      | 5 ++++-
 3 files changed, 12 insertions(+), 2 deletions(-)

-- 
2.25.1

