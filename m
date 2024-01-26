Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06DA95C5E5
	for <iommu@lists.linux.dev>; Fri, 26 Jan 2024 23:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706312249; cv=none; b=BXu2FuVYCpjSqeUIPtsxJ+BVczC+zZXLnWpGbJV7oimw/QE5KmxyzZ4sQKBPcClpUjoxaInkKIvSnIyBFHwiuP11np74dv/Ou/Ks+jjySOyguWufUVPXyYESKue7JJR4asx7KnKuYSoRdIU8deutbOv+mtPY4BKAnspLtOhHh8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706312249; c=relaxed/simple;
	bh=5z7HUBzE7Ul+Bci9YbfIrBXJxLaOXS9r2ggCh19e6Ag=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=R5XVJfSLKkvmuelsT31MXQWdkRjdn01lABTHp+dOj2JzasB9wZMKcvvWBDbdTUxOMl/0sygYuo8FYFmCeHDehIKu/+LUfEylOUzJP4o/35jZ7PD1mG4DRsIAX+lgnzBsv+FzTVieL/s/PK7w5cyPLiyiSJsxo4AKMf5n4aFEwm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c2G55wMG; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c2G55wMG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706312248; x=1737848248;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5z7HUBzE7Ul+Bci9YbfIrBXJxLaOXS9r2ggCh19e6Ag=;
  b=c2G55wMGDCOJk3+85+9QoDEFTjPedxMloyn9POgaySVAH+aduU1kM4wY
   9QAiy4GOgNohyIpe8y+CPqaFeC3HxzfWI2VSj9sjRkCjKJr/c44i2pJ3+
   agF2g30fyfVnD3tKeP7LXxiApoIEJxrAcJ/XDNls45sHs2SI47AOT8b3p
   xKVEscTvsFhfw5Cb1IKfbY6D4BfZz6MHJ8GK+d2LXoe4w7zAoMHC+r+Dj
   YbANedgesJhTkXwaG8Dk1m9+tnUg47YIvOmxuHOHEAiYxKD1eBxehRuEG
   WCxJX9B80PQru9Pym6xxj+Z9+GCzzvPGjqz09DNGEwwNlbIsZrfOtjdtu
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="9990751"
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="9990751"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2024 15:37:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="821290745"
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="821290745"
Received: from srinivas-otcpl-7600.jf.intel.com (HELO jacob-builder.jf.intel.com) ([10.54.39.116])
  by orsmga001.jf.intel.com with ESMTP; 26 Jan 2024 15:37:22 -0800
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
Subject: [PATCH 11/15] x86/irq: Extend checks for pending vectors to posted interrupts
Date: Fri, 26 Jan 2024 15:42:33 -0800
Message-Id: <20240126234237.547278-12-jacob.jun.pan@linux.intel.com>
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

During interrupt affinity change, it is possible to have interrupts delivered
to the old CPU after the affinity has changed to the new one. To prevent lost
interrupts, local APIC IRR is checked on the old CPU. Similar checks must be
done for posted MSIs given the same reason.

Consider the following scenario:
	Device		system agent		iommu		memory 		CPU/LAPIC
1	FEEX_XXXX
2			Interrupt request
3						Fetch IRTE	->
4						->Atomic Swap PID.PIR(vec)
						Push to Global Observable(GO)
5						if (ON*)
	i						done;*
						else
6							send a notification ->

* ON: outstanding notification, 1 will suppress new notifications

If the affinity change happens between 3 and 5 in IOMMU, the old CPU's posted
interrupt request (PIR) could have pending bit set for the vector being moved.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 arch/x86/include/asm/apic.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
index e9d8e554765c..6661fefdd49a 100644
--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -13,6 +13,7 @@
 #include <asm/mpspec.h>
 #include <asm/msr.h>
 #include <asm/hardirq.h>
+#include <asm/posted_intr.h>
 
 #define ARCH_APICTIMER_STOPS_ON_C3	1
 
@@ -500,7 +501,7 @@ static inline bool is_vector_pending(unsigned int vector)
 	if (irr  & (1 << (vector % 32)))
 		return true;
 
-	return false;
+	return pi_pending_this_cpu(vector);
 }
 
 /*
-- 
2.25.1

