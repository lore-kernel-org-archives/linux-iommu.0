Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3754A33
	for <iommu@lists.linux.dev>; Mon, 22 Aug 2022 20:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661198944; x=1692734944;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=d7Gle5OSsrdUa5bkReBAsKwZ6ONZP3Cp0kZ76kvnrJA=;
  b=AD1ZgfRz5DAmDg58Dzt2ESwp0cYSmHn+cXnpO+0kMiSQc4L7UYyXs6hb
   UiOLLDs2qUlglEoKPb+KIjXZjwrePKtToceCRf1zC7y6j/ph/2XBJR94d
   kwKowoZvDjwxp0s6zGj1mtPLXOxMUnnsVSfUsrUeOuVNOkGA+Z6ywz42H
   AElucZFqq702d1HlhLxQz7xAkMAR5HaoqKOIU4KlDxjb7KKe8MHMVEuAa
   KAOsVaKGMHpnAY1GlZ6vqjmHvqlEIXbdkCFOxuzo49294O7STn2xay7bG
   UOqgiIdP0EWbjurfNYsLxc146HX62ST4g/UE6GIJkV9JIKJwMxs4zatGO
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10447"; a="319547413"
X-IronPort-AV: E=Sophos;i="5.93,255,1654585200"; 
   d="scan'208";a="319547413"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2022 13:09:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,255,1654585200"; 
   d="scan'208";a="698414219"
Received: from otc-wp-03.jf.intel.com (HELO jacob-builder.jf.intel.com) ([10.54.39.79])
  by FMSMGA003.fm.intel.com with ESMTP; 22 Aug 2022 13:09:03 -0700
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
Subject: [PATCH 1/2] x86: mm: Allow PTI helpers to be used outside x86/mm
Date: Mon, 22 Aug 2022 13:12:12 -0700
Message-Id: <20220822201213.352289-2-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220822201213.352289-1-jacob.jun.pan@linux.intel.com>
References: <20220822201213.352289-1-jacob.jun.pan@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With the support of shared virtual addressing(SVA), x86 IOMMUs also
need to get access to user PGD when sharing user mappings.

This patch makes sure the PTI helper function to retrieve user PGD
is available regardless the state of CONFIG_PAGE_TABLE_ISOLATION.
So far, such need is x86 only.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 arch/x86/include/asm/pgtable.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 44e2d6f1dbaa..42f55281e232 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -1227,6 +1227,11 @@ static inline p4d_t *user_to_kernel_p4dp(p4d_t *p4dp)
 {
 	return ptr_clear_bit(p4dp, PTI_PGTABLE_SWITCH_BIT);
 }
+#else
+static inline pgd_t *kernel_to_user_pgdp(pgd_t *pgdp)
+{
+	return pgdp;
+}
 #endif /* CONFIG_PAGE_TABLE_ISOLATION */
 
 /*
-- 
2.25.1

