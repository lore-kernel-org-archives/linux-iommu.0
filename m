Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9A75A115
	for <iommu@lists.linux.dev>; Fri, 26 Jan 2024 23:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706312246; cv=none; b=ZvF5gS0zDiVDTGNbHTTcoCzcJM1E5Q68gwPc8JSZwXosHIxHLMZ5ni4j/SEKYpnPJsLSkdVQEyWxBt0BCM0Lbv5CucedPlUdFtvX/zVPhFKqB48Qs3xF1PHY8RTmOwqq6IFIBBXQMJvjJu3wTFae/F/MgBG/yFsN5d3Nn5kBLZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706312246; c=relaxed/simple;
	bh=QJV30lNeix5myDOaVVsdK3RMyy1VcDvQ9cOpKGwrPwg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Jg/UzEWTXw78alXyS1+WD7xmCPnc+jRF3JtyIxufOjrjm9UpDYMYiE6S9KlONQETJXGECSC4+JyqSMlApvqqA1E92PYKjumgt4NjdH+mWGkY8bRjBca+oOQaLvp1BRlWNPr7sNNNeqsCPni9tuf8eNRIMGGuel71oRJ+/4/4I0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WRSiTP26; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WRSiTP26"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706312245; x=1737848245;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QJV30lNeix5myDOaVVsdK3RMyy1VcDvQ9cOpKGwrPwg=;
  b=WRSiTP26jbJKWyUgbZHvQxxhB1QT8EeJAaP4vK7SZpj4l5NK6CpoNztJ
   ciZ68OYBnqIQrUrqGWreH5nUE8G6olavEWRO4zufG+vCYZ+mQQQ1gJlKq
   i5AFUmFLBg2aN81PPNb+rAT37t4Fw8rt0EVQ/c+8lBllLkndDnJbNO+BY
   iZ5LCzHn+Darbp/Y5wxEPdy9Vdf0U01XCkx7p0QP1hm8Ubpx8gNqerQs2
   fqAqpRSNShlYeLI5ZJwAWbHXHnLlLNs1UK1yNVEcVAWG6IYQiviph1s2y
   GxeOldGsJw6u5kHnHAa4M69OTYx9jh86bbkpK5pGdvFzJrzBd3h1lLgD1
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="9990676"
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="9990676"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2024 15:37:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="821290725"
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="821290725"
Received: from srinivas-otcpl-7600.jf.intel.com (HELO jacob-builder.jf.intel.com) ([10.54.39.116])
  by orsmga001.jf.intel.com with ESMTP; 26 Jan 2024 15:37:21 -0800
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: LKML <linux-kernel@vger.kernel.org>,
	X86 Kernel <x86@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	iommu@lists.linux.dev,
	Thomas Gleixner <tglx@linutronix.de>,
	"Lu Baolu" <baolu.lu@linux.intel.com>,
	kvm@vger.kernel.org,
	Dave Hansen <dave.hansen@intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Borislav Petkov" <bp@alien8.de>,
	"Ingo Molnar" <mingo@redhat.com>
Cc: Paul Luse <paul.e.luse@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jens Axboe <axboe@kernel.dk>,
	Raj Ashok <ashok.raj@intel.com>,
	"Tian, Kevin" <kevin.tian@intel.com>,
	maz@kernel.org,
	seanjc@google.com,
	"Robin Murphy" <robin.murphy@arm.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH 05/15] x86/irq: Reserve a per CPU IDT vector for posted MSIs
Date: Fri, 26 Jan 2024 15:42:27 -0800
Message-Id: <20240126234237.547278-6-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240126234237.547278-1-jacob.jun.pan@linux.intel.com>
References: <20240126234237.547278-1-jacob.jun.pan@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When posted MSI is enabled, all device MSIs are multiplexed into a single
notification vector. MSI handlers will be de-multiplexed at run-time by
system software without IDT delivery.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 arch/x86/include/asm/irq_vectors.h | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/irq_vectors.h b/arch/x86/include/asm/irq_vectors.h
index 3a19904c2db6..08329bef5b1d 100644
--- a/arch/x86/include/asm/irq_vectors.h
+++ b/arch/x86/include/asm/irq_vectors.h
@@ -99,9 +99,16 @@
 
 #define LOCAL_TIMER_VECTOR		0xec
 
+/*
+ * Posted interrupt notification vector for all device MSIs delivered to
+ * the host kernel.
+ */
+#define POSTED_MSI_NOTIFICATION_VECTOR	0xeb
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

