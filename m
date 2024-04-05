Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F4088175563
	for <iommu@lists.linux.dev>; Fri,  5 Apr 2024 22:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712356010; cv=none; b=Xa4tEmktmoe+Ybjr6awPvYs+kW5k+YqoK4AjRARvk+GTKc/LnHdyGafaIRRmPDDsN8ZnpthBjg6DWZkbOPGp6zB+UCJhnGHsznf72uW72LhPlsQ7mAk25j8KX8qSH6rVqs0uqULMEQAizw+XoxRT//0GPIgJThPoK5yxWnYgRh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712356010; c=relaxed/simple;
	bh=BpLqiaNgpSDbcOwdg5E2m/UG/ZOHZCK4TD1uJoCRw+g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QSIAbDk0yNf/J4qT9eoL6ETFdp9pnLscW34kK/H+TnuILT+D6mTxwZVQkecWGsydauHsDNmBj5PsJQhTU9afBPIVbX7RjLYnSXHUwMON3MvFqlSMK+d9TsM0wY/1gktE5FHEKlmYV+PcXo/VUG5+dPJGrs2QuDjkGJZtE10Z5To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IVEqZ1Ga; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IVEqZ1Ga"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712356009; x=1743892009;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BpLqiaNgpSDbcOwdg5E2m/UG/ZOHZCK4TD1uJoCRw+g=;
  b=IVEqZ1Ga+2+EYjqst1gzCuYLsw3QuoxkqnJ95nmLC/RLdXd9vFus0ycx
   KCjtF9ZGNpEiU7UAkzkDabmi6C1PgEjtMlBw3QAf4b4Ql9m6Qv0uUCCuV
   lO7Tm65eXYgWbMIS8L5uTa46RWEeZkmmf9A4yHewjAoOzTzHGoE2gw3bD
   BcegDYj/2Ec0QOcnYQjIC/hb8y844naG5DejYhoHZkPrJV3dG/hIOXqe/
   RZPtYOrxX/HPd6RRMXIwrs4vhhBBFloJlAJwGrrvnyyNKhn79nSMC8PMy
   zKneDeu+0oOePZJfHqneb9rNM6KHu9YPTn55FHK79diGX7S52BYBmSzlf
   w==;
X-CSE-ConnectionGUID: l1PhqT5WQxOz0XiHif7vGg==
X-CSE-MsgGUID: bpz1oN9aSL6tyi+3dmoK1w==
X-IronPort-AV: E=McAfee;i="6600,9927,11035"; a="19062716"
X-IronPort-AV: E=Sophos;i="6.07,182,1708416000"; 
   d="scan'208";a="19062716"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2024 15:26:47 -0700
X-CSE-ConnectionGUID: 13qTgNPtQAOkBjpU3IPkgQ==
X-CSE-MsgGUID: mpnrgrsBTUWcfeColep1OQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,182,1708416000"; 
   d="scan'208";a="23928317"
Received: from jacob-builder.jf.intel.com ([10.54.39.125])
  by fmviesa004.fm.intel.com with ESMTP; 05 Apr 2024 15:26:46 -0700
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
	jim.harris@samsung.com,
	a.manzanares@samsung.com,
	"Bjorn Helgaas" <helgaas@kernel.org>,
	guang.zeng@intel.com,
	robert.hoo.linux@gmail.com,
	Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v2 04/13] x86/irq: Add a Kconfig option for posted MSI
Date: Fri,  5 Apr 2024 15:31:01 -0700
Message-Id: <20240405223110.1609888-5-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240405223110.1609888-1-jacob.jun.pan@linux.intel.com>
References: <20240405223110.1609888-1-jacob.jun.pan@linux.intel.com>
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
v2: Remove x2apic dependency
---
 arch/x86/Kconfig | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 39886bab943a..f5688f4e299b 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -464,6 +464,17 @@ config X86_X2APIC
 
 	  If you don't know what to do here, say N.
 
+config X86_POSTED_MSI
+	bool "Enable MSI and MSI-x delivery by posted interrupts"
+	depends on X86_64 && IRQ_REMAP
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

