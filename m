Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830B413F45B
	for <iommu@lists.linux.dev>; Tue, 23 Apr 2024 17:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713893806; cv=none; b=l/I1bhtnKBq37WD0pIRrtZvvsCEXlf1HERf1CSkKM3YlgtOiB+xoGm0lEgsv/u58Bs31QytgQw++C0uxixKk8vgOu+ZrY8O3sFwI6hiUcQ2JXNpzTAFChqPOYw1tF31HvsyHiR9c86k32EtjqitSyUFqzdOLZ/ZnaMkk96RRAYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713893806; c=relaxed/simple;
	bh=o0Yjsx+6/KD/QeqpB4XlDWg/O40xkF5o3T8IHaOlHg0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZM5/wQhXIOv41Z1UQe5Eqrmx3MpjUm6naINzlzh+oevjDALMe/OgadPbnCmDCoiR27RkKwuNtr7lfXQhmGgD/qFSUgz1jvJBDxhRiCZgHxT4nUPQG9NDUs5rkpQMkuYDBoeqyryLAqYOMkNkoLEAFDwspSZ5kBlXZwyfKAKgun0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UFTjwo7A; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UFTjwo7A"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713893806; x=1745429806;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=o0Yjsx+6/KD/QeqpB4XlDWg/O40xkF5o3T8IHaOlHg0=;
  b=UFTjwo7A37pdnoZkP2hw53p2tZeC5ePDRNj3W68UoM71Xx8j3b+E+Yzk
   ahSdH7Z2YoE3yGHV8OvfCb08iIoNnMnH6NEt9slGwV08ZZMLZDAXWQ0Ah
   2xe1Ba9kmnUcpmehTXs/M5ZJm1w5x+c/09WUIyelMzDwbyQGTV2hJHY3l
   8K0mNBFbhqDOh1LcdFuyxpxA9QgIJ4B5T4dyNUEY8Vm4fqXH89XSMq1ck
   ktc91YcP2zGj1OH7a320CsoHqQZwDOlqUl2ZTBJgTdU2Kt8WAogPaw5Ag
   sKYUixsY2UbgU1ymu8gEkKrfIU7tA2goQrzvvIq8Ez9kJs3JARdGrOpF4
   g==;
X-CSE-ConnectionGUID: GgdoVIihTr2AgXccaNQksw==
X-CSE-MsgGUID: QUSN6Gu2QmWBkTDslu8X5g==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="9712347"
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="9712347"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 10:36:42 -0700
X-CSE-ConnectionGUID: sIljL0qNQeS8FAL/3+0B1w==
X-CSE-MsgGUID: YA4r9mSPQJqc2Auq4GGciQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="29097402"
Received: from jacob-builder.jf.intel.com ([10.54.39.125])
  by fmviesa004.fm.intel.com with ESMTP; 23 Apr 2024 10:36:41 -0700
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
	oliver.sang@intel.com,
	acme@kernel.org,
	Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v3  04/12] x86/irq: Add a Kconfig option for posted MSI
Date: Tue, 23 Apr 2024 10:41:06 -0700
Message-Id: <20240423174114.526704-5-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240423174114.526704-1-jacob.jun.pan@linux.intel.com>
References: <20240423174114.526704-1-jacob.jun.pan@linux.intel.com>
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
index 4474bf32d0a4..fed22fc66217 100644
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

