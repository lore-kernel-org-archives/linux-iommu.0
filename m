Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B495917E
	for <iommu@lists.linux.dev>; Fri, 26 Jan 2024 23:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706312245; cv=none; b=FtNnZhkdLW9QPY22SsLtN9iCWfzbt/OHJFYnawO/W0YSItbmoVNYjcsVNuTdQanzMkHipzK3o55nzHcLRTPB1MrHC9Ig13UdBRZgsUbjmDQfN0s+GIpjQeRF2fGtulrvu2ocJXPlCaVDe1p66uFHy0irvaP5qEPlu5ViXjAT+ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706312245; c=relaxed/simple;
	bh=TiUyHPWp/CruDSgiWpJ9abORXg7ueQkxnjZwsyBxeWU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DeV0FGijiBDiK/tYCkluzhfw8Gi3XVYwWCvvrFq2o7hb565sUsq7wQzFOGQs46CPl8pivNXqu12xD95Iyz2zJ3StC7Z5O2w2OUt7pTOZ1iq9YNicet/xjCA4wkq5oIlx+N1h6bZ4pTwKlkzxE9EQihubuEu9y+FSHe7OIuAcdMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FraVXCkx; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FraVXCkx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706312244; x=1737848244;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TiUyHPWp/CruDSgiWpJ9abORXg7ueQkxnjZwsyBxeWU=;
  b=FraVXCkxXU/3vhlQtTzfOwyjHVegnNoZgmZSPv0Md58V70itjdVMLBB/
   WrXRg8Lapdc1vJGAqbhA9qDkLu3+wTu01f75+iiGe+8/9TmcGvdQjWixU
   GSJ9podJ2hK+yDdILetDk04YGZmh+4U6shMN7S4Z+hwtKdj3dtfJ7GV7l
   c069/5huUtent2gt+SnITDM/0+TXFh3woF5ozmv6JditC8tAq9lAtL1/y
   rwF9sWEtOpxf9VYqM/TT5rObeo5u4eOEKX76SgA8buoCedvBUA1oxCwjU
   azBxrYvEYPN284Q/DEligu5i3Lhdqyg/HLJVncyo2NfBAtnxFlimpG8Lz
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="9990659"
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="9990659"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2024 15:37:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="821290722"
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="821290722"
Received: from srinivas-otcpl-7600.jf.intel.com (HELO jacob-builder.jf.intel.com) ([10.54.39.116])
  by orsmga001.jf.intel.com with ESMTP; 26 Jan 2024 15:37:20 -0800
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
Subject: [PATCH 04/15] x86/irq: Add a Kconfig option for posted MSI
Date: Fri, 26 Jan 2024 15:42:26 -0800
Message-Id: <20240126234237.547278-5-jacob.jun.pan@linux.intel.com>
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

This option will be used to support delivering MSIs as posted
interrupts. Interrupt remapping is required.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 arch/x86/Kconfig | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 5edec175b9bf..79f04ee2b91c 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -463,6 +463,17 @@ config X86_X2APIC
 
 	  If you don't know what to do here, say N.
 
+config X86_POSTED_MSI
+	bool "Enable MSI and MSI-x delivery by posted interrupts"
+	depends on X86_X2APIC && X86_64 && IRQ_REMAP
+	help
+	  This enables MSIs that are under interrupt remapping to be delivered as
+	  posted interrupts to the host kernel. Interrupt throughput can
+	  potentially be improved by coalescing CPU notifications during high
+	  frequency bursts.
+
+	  If you don't know what to do here, say N.
+
 config X86_MPPARSE
 	bool "Enable MPS table" if ACPI
 	default y
-- 
2.25.1

