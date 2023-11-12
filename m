Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88821FA9
	for <iommu@lists.linux.dev>; Sun, 12 Nov 2023 04:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AkWgFevY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699762330; x=1731298330;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ouYom2tBlHd3aDBaZZVG3gi5SN++gaATZnTLzCcbbws=;
  b=AkWgFevYFBWHzox1muOyScVCq0Jp+Bu/Smspity4O1rZOZWvBFrKrgPa
   aYEreWP0lU+tU7awanjgaU3Ghd3TBN+aCrxtR9K2iJA97YVKfnRKdu9td
   P1glnQ73VIPQ4wkI6Dm163WUBaP9s/qvyIxGP+8plHSA2EcRi+SE2sft0
   kZ6zyIPlGrHzKuXgtpaA0FzPwcxvChCE2KSzdSGFNbNbSLg6sErI2gUvy
   cV3GRgYTgWGSMffM39v+99EwIHpk2qkkLNNPu6Z6ryxxDxjQKo8jDv1Mb
   mO14lwQxOgTcgXZMRSchsV8y6nMJ2Fy+4+MVuQe2ecnpUSYEeh0CvxkvU
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10891"; a="476533861"
X-IronPort-AV: E=Sophos;i="6.03,296,1694761200"; 
   d="scan'208";a="476533861"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2023 20:12:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10891"; a="713936743"
X-IronPort-AV: E=Sophos;i="6.03,296,1694761200"; 
   d="scan'208";a="713936743"
Received: from srinivas-otcpl-7600.jf.intel.com (HELO jacob-builder.jf.intel.com) ([10.54.39.116])
  by orsmga003.jf.intel.com with ESMTP; 11 Nov 2023 20:12:07 -0800
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: LKML <linux-kernel@vger.kernel.org>,
	X86 Kernel <x86@kernel.org>,
	iommu@lists.linux.dev,
	Thomas Gleixner <tglx@linutronix.de>,
	"Lu Baolu" <baolu.lu@linux.intel.com>,
	kvm@vger.kernel.org,
	Dave Hansen <dave.hansen@intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Borislav Petkov" <bp@alien8.de>,
	"Ingo Molnar" <mingo@redhat.com>
Cc: Raj Ashok <ashok.raj@intel.com>,
	"Tian, Kevin" <kevin.tian@intel.com>,
	maz@kernel.org,
	peterz@infradead.org,
	seanjc@google.com,
	"Robin Murphy" <robin.murphy@arm.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH RFC 03/13] x86: Reserved a per CPU IDT vector for posted MSIs
Date: Sat, 11 Nov 2023 20:16:33 -0800
Message-Id: <20231112041643.2868316-4-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231112041643.2868316-1-jacob.jun.pan@linux.intel.com>
References: <20231112041643.2868316-1-jacob.jun.pan@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Under posted MSIs, all device MSIs are multiplexed into a single CPU
notification vector. MSI handlers will be de-multiplexed at run-time by
system software without IDT delivery.

This vector has a priority class below the rest of the system vectors.

Potentially, external vector number space for MSIs can be expanded to
the entire 0-256 range.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 arch/x86/include/asm/irq_vectors.h | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/irq_vectors.h b/arch/x86/include/asm/irq_vectors.h
index 3a19904c2db6..077ca38f5a91 100644
--- a/arch/x86/include/asm/irq_vectors.h
+++ b/arch/x86/include/asm/irq_vectors.h
@@ -99,9 +99,22 @@
 
 #define LOCAL_TIMER_VECTOR		0xec
 
+/*
+ * Posted interrupt notification vector for all device MSIs delivered to
+ * the host kernel.
+ *
+ * Choose lower priority class bit [7:4] than other system vectors such
+ * that it can be preempted by the system interrupts.
+ *
+ * It is also higher than all external vectors but it should not matter
+ * in that external vectors for posted MSIs are in a different number space.
+ */
+#define POSTED_MSI_NOTIFICATION_VECTOR	0xdf
 #define NR_VECTORS			 256
 
-#ifdef CONFIG_X86_LOCAL_APIC
+#ifdef X86_POSTED_MSI
+#define FIRST_SYSTEM_VECTOR		POSTED_MSI_NOTIFICATION_VECTOR
+#elif defined(CONFIG_X86_LOCAL_APIC)
 #define FIRST_SYSTEM_VECTOR		LOCAL_TIMER_VECTOR
 #else
 #define FIRST_SYSTEM_VECTOR		NR_VECTORS
-- 
2.25.1

