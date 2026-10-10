Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CBFF288B9
	for <iommu@lists.linux.dev>; Sat, 10 Oct 2026 00:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791591045; cv=none; b=ogGz4hBlFNHZBQVUcTMyHaqS525+02M/MbYTQxdOEc90VoNxypCBctWh1akm3ufYPoyUtEknM+SuDlYs9YFNjaHAFeR+RsIFzLFA82C/pEFhV2IcMa+1Doop5+J48INdT7IfZnVVyGFArGxFQEaoAygvrXMemCkuo/m4Tn9yn3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791591045; c=relaxed/simple;
	bh=PZDn9A4S4W/Ns7KtN8jiqNjpMsMEpf0Zn5SIfwuuFEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dT2xKmUsCDudL9pwa7h/736YbBbVsczZiOY4YQzfCClA2mZ3a/Gfca9NTnCm5N3L+z2HWa2AMFWEuYVUA+x4PArDoj0/rdWDIVb5DwFmgcXJjRPiGHT0Fjv+kH7eh2RBtAB34oZwa8mTO9u814bF/BexJ2Vc8eSuvVmBgOHUvdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=m0AJgFUu; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m0AJgFUu"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2db33db4de9so7615ad.0
        for <iommu@lists.linux.dev>; Fri, 09 Oct 2026 17:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791591043; x=1792195843; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=w4KRkkp0W32oMcIhnTbZjHrMVPNDCUZkNJk5uoEA924=;
        b=m0AJgFUuEglqwG/wfB4u8UdjaI3fK6oPNkXCLxDLMKiwUbTBakIeXTtHGzytVb4mPw
         S1Uulu9B3FrCnhOWmdkZPiRjKd+1HjmRW/ds8+lPAYSGWCLHTvohQkxQXPZ6CQI3lvLc
         0cxLKxJXSukzHe/9YeGxjIZabNrWtSPkkEaRZMjsJoFwvf3lzd4MEf7YYHh51ACgTrjT
         dAlV1kfJn44h+H8nU9kkQ6GcUi7RN94KETOZGYtiCho6rJAkcWCwMaV2KCZkzZ0jjGAc
         ZX+q7WIOhdS8N74pEcK1br1iIUGQzT8CSX1KvIZSaJG1c0A4p9aKNIWwNa7L3fYz0NXy
         m42w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791591043; x=1792195843;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=w4KRkkp0W32oMcIhnTbZjHrMVPNDCUZkNJk5uoEA924=;
        b=qQkandc0ueapfxTHeWSBeulM3QxLEbiI7Tr7eFBlqrr0UtjoFjnwgNSb48UhFgyEGR
         xO/mymckhPt2rEqAIfD3MuY1ShCZGKg/X2ZKM91bmDSahEe/Jh9UXO6gWHSjr0bYZPA9
         Kne2mzcP952oAmiMaovkZJYpZnIe79SDFoxm4QU2r98xWKJ/8JkDadMR3SX4H+xyobVu
         YIbaSLf0v0rPU6lbCyLgc2wRq/Z8dRqIDkDl1BP3Ql40RAK4BtRLA2k8Oxus2YMQNTjJ
         S8X+Xe0E2715NBAPVzCBw+WiyyMWUnJoq6m4AC9PBGhu5ma7/XqVOmzLGEPeE0qxe1hu
         AKdg==
X-Forwarded-Encrypted: i=1; AKwUvBzGIEvMT43k/V3cNhFRCdicA3GUAnZgLc+FzoHXj1IHXkumuXa4OpBWZk+vhIxmBZ7XGx0ujA==@lists.linux.dev
X-Gm-Message-State: AFq9FYKKQgdFXnpZkacpQp+VqfDdsp/ifj9B/uBSnR557XooM9XOUJIo
	gguvsq8uxfm8haU8bv/lnZSWTPt2irM73B4r1g5qI05jvx8u9nNGlxiG4xrc8oyGvQ==
X-Gm-Gg: AYBFou3LWPRBmZ0Rsyu6oHK7c0ec44CsDii9iH1d1bsfM5AUHgbkY1SH9dHcRIr2ei6
	HEZwo/e592RRZvqxGDTau8QOKJc0Q/sTE0KFIn+o8fZfM69P2ouE1rnHX7Za2OvsTD76Rs/fai0
	/lWZrkP8g+U67E/ZK24jU/7H2BfIzbqAP654euTji+ZtH9IBzMFn4k/FaUg7JeIewXTmUjbxJQk
	PtNHRX2/cNLFlpNWuSlMX2d/1FFSPrLhIpwVtRrW0akNK+Hl1dWCJVJ9KJAmysVgPWiCr/kE8xj
	N22t/CwtR/SVPvDuDxA9PAK+voTXBn52TNdpSweaELBlv+IY/DHYlhKaPSL2pdg8DA2l0zCsOJc
	4vvUqQrOs769FbQ6PLqh/YLc9GCpUx5+R2VaPL6N5qTOpfhL9sckvX8SJlyRkft7S9wjS5nqvXX
	/rdgwPG6Gnqwras0RSMZAU/Kg+8Ncbla8mIE1O0LThC/xsZY4Pr53bCTlVtCMpenTlObiCwuHdZ
	RnaUNBuSwH59uwYsLL3rG7khteofLae+RAob2bzXYWVoGjZr/1ilzMHcPZ+yibkUNl0
X-Received: by 2002:a17:902:cf0e:b0:2e6:f400:5655 with SMTP id d9443c01a7336-2e87b9c037fmr819115ad.3.1791591042168;
        Fri, 09 Oct 2026 17:10:42 -0700 (PDT)
Received: from google.com (163.1.145.34.bc.googleusercontent.com. [34.145.1.163])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab37817414sm6239947a91.2.2026.10.09.17.10.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 17:10:41 -0700 (PDT)
Date: Sat, 10 Oct 2026 00:10:38 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>, 
	Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, Pratyush Yadav <pratyush@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, David Matlack <dmatlack@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Pranjal Shrivastava <praan@google.com>, 
	Vipin Sharma <vipinsh@google.com>
Subject: Re: [PATCH v5 07/18] iommu/vt-d: Implement device and iommu
 preserve/unpreserve ops
Message-ID: <asfkCdcIBopkNyie@google.com>
References: <20260921004834.2601285-1-skhawaja@google.com>
 <20260921004834.2601285-8-skhawaja@google.com>
 <04136ffd-de06-470c-8bbd-c7cf651feeb8@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <04136ffd-de06-470c-8bbd-c7cf651feeb8@linux.intel.com>

On Thu, Oct 08, 2026 at 03:54:10PM +0800, Baolu Lu wrote:
>On 9/21/26 08:48, Samiullah Khawaja wrote:
>>Add implementation of the device and iommu preservation in a separate
>>file. Also set the device and iommu preserve/unpreserve ops in the
>>struct iommu_ops.
>>
>>Preservation is refused for devices where ATS is supported. Carrying an
>>active ATS configuration across kexec would require adopting the ATS
>>state in the PCI core and in the context entries, and handling the
>>disable-to-enable, enable-to-disable and STU mismatch cases for a live
>>device.
>>
>>Note that the preserved iommu root table, context table and device pasid
>>table will need cleanup as devices do not go through the release flow
>>during kexec. So the stale entries need to be removed during shutdown.
>>This is done in the next commit.
>>
>>Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
>>---
>>  MAINTAINERS                      |   8 ++
>>  drivers/iommu/intel/Makefile     |   1 +
>>  drivers/iommu/intel/iommu.c      |   9 +-
>>  drivers/iommu/intel/iommu.h      |  13 ++
>>  drivers/iommu/intel/liveupdate.c | 232 +++++++++++++++++++++++++++++++
>>  include/linux/kho/abi/iommu.h    |  24 ++++
>>  6 files changed, 285 insertions(+), 2 deletions(-)
>>  create mode 100644 drivers/iommu/intel/liveupdate.c
>>
>>diff --git a/MAINTAINERS b/MAINTAINERS
>>index 2114b50412ee..ae6df95dc398 100644
>>--- a/MAINTAINERS
>>+++ b/MAINTAINERS
>>@@ -13220,6 +13220,14 @@ S:	Supported
>>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git
>>  F:	drivers/iommu/intel/
>>+INTEL IOMMU LIVEUPDATE (VT-d)
>>+M:	Samiullah Khawaja <skhawaja@google.com>
>>+M:	Lu Baolu <baolu.lu@linux.intel.com>
>>+L:	iommu@lists.linux.dev
>>+S:	Maintained
>>+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git
>>+F:	drivers/iommu/intel/liveupdate.c
>>+
>>  INTEL IPU3 CSI-2 CIO2 DRIVER
>>  M:	Yong Zhi <yong.zhi@intel.com>
>>  M:	Sakari Ailus <sakari.ailus@linux.intel.com>
>>diff --git a/drivers/iommu/intel/Makefile b/drivers/iommu/intel/Makefile
>>index ada651c4a01b..d38fc101bc35 100644
>>--- a/drivers/iommu/intel/Makefile
>>+++ b/drivers/iommu/intel/Makefile
>>@@ -6,3 +6,4 @@ obj-$(CONFIG_INTEL_IOMMU_DEBUGFS) += debugfs.o
>>  obj-$(CONFIG_INTEL_IOMMU_SVM) += svm.o
>>  obj-$(CONFIG_IRQ_REMAP) += irq_remapping.o
>>  obj-$(CONFIG_INTEL_IOMMU_PERF_EVENTS) += perfmon.o
>>+obj-$(CONFIG_IOMMU_LIVEUPDATE) += liveupdate.o
>>diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
>>index 2e3b3ab216f8..4bfc2f173010 100644
>>--- a/drivers/iommu/intel/iommu.c
>>+++ b/drivers/iommu/intel/iommu.c
>>@@ -16,6 +16,7 @@
>>  #include <linux/crash_dump.h>
>>  #include <linux/dma-direct.h>
>>  #include <linux/dmi.h>
>>+#include <linux/iommu-liveupdate.h>
>>  #include <linux/memory.h>
>>  #include <linux/pci.h>
>>  #include <linux/pci-ats.h>
>>@@ -58,8 +59,6 @@ static int rwbf_quirk;
>>   */
>>  int intel_iommu_tboot_noforce;
>>-#define ROOT_ENTRY_NR (VTD_PAGE_SIZE/sizeof(struct root_entry))
>>-
>>  /*
>>   * Take a root_entry and return the Lower Context Table Pointer (LCTP)
>>   * if marked present.
>>@@ -3961,6 +3960,12 @@ const struct iommu_ops intel_iommu_ops = {
>>  	.is_attach_deferred	= intel_iommu_is_attach_deferred,
>>  	.def_domain_type	= device_def_domain_type,
>>  	.page_response		= intel_iommu_page_response,
>>+#ifdef CONFIG_IOMMU_LIVEUPDATE
>>+	.preserve_device	= intel_iommu_preserve_device,
>>+	.unpreserve_device	= intel_iommu_unpreserve_device,
>>+	.preserve		= intel_iommu_preserve,
>>+	.unpreserve		= intel_iommu_unpreserve,
>>+#endif
>>  };
>>  static void quirk_iommu_igfx(struct pci_dev *dev)
>>diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
>>index 23dbe6c24439..785057236e7c 100644
>>--- a/drivers/iommu/intel/iommu.h
>>+++ b/drivers/iommu/intel/iommu.h
>>@@ -552,6 +552,8 @@ struct root_entry {
>>  	u64     hi;
>>  };
>>+#define ROOT_ENTRY_NR (VTD_PAGE_SIZE / sizeof(struct root_entry))
>>+
>>  /*
>>   * low 64 bits:
>>   * 0: present
>>@@ -1296,6 +1298,17 @@ static inline int iopf_for_domain_replace(struct iommu_domain *new,
>>  	return 0;
>>  }
>>+#ifdef CONFIG_IOMMU_LIVEUPDATE
>>+int intel_iommu_preserve_device(struct device *dev,
>>+				struct iommu_device_ser *device_ser);
>>+void intel_iommu_unpreserve_device(struct device *dev,
>>+				   struct iommu_device_ser *device_ser);
>>+int intel_iommu_preserve(struct iommu_device *iommu,
>>+			 struct iommu_hw_ser *iommu_ser);
>>+void intel_iommu_unpreserve(struct iommu_device *iommu,
>>+			    struct iommu_hw_ser *iommu_ser);
>>+#endif
>>+
>>  #ifdef CONFIG_INTEL_IOMMU_SVM
>>  void intel_svm_check(struct intel_iommu *iommu);
>>  struct iommu_domain *intel_svm_domain_alloc(struct device *dev,
>>diff --git a/drivers/iommu/intel/liveupdate.c b/drivers/iommu/intel/liveupdate.c
>>new file mode 100644
>>index 000000000000..0837bb889fed
>>--- /dev/null
>>+++ b/drivers/iommu/intel/liveupdate.c
>>@@ -0,0 +1,232 @@
>>+// SPDX-License-Identifier: GPL-2.0-only
>>+
>>+/*
>>+ * Copyright (C) 2026, Google LLC
>>+ * Author: Samiullah Khawaja <skhawaja@google.com>
>>+ */
>>+
>>+#define pr_fmt(fmt)    "DMAR: liveupdate: " fmt
>>+
>>+#include <linux/kexec_handover.h>
>>+#include <linux/liveupdate.h>
>>+#include <linux/iommu-liveupdate.h>
>>+#include <linux/module.h>
>>+#include <linux/pci.h>
>>+
>>+#include "iommu.h"
>>+#include "../iommu-pages.h"
>>+
>>+/* 2 tables per bus in scalable mode with upper table at odd bit */
>>+#define CONTEXT_TABLE_PRESERVED_BIT(bus, devfn) (((bus) << 1) + ((devfn) >> 7))
>>+static bool is_context_table_preserved(struct intel_iommu *iommu,
>>+				       struct iommu_hw_ser *ser,
>>+				       u8 bus, u8 devfn)
>>+{
>>+	return test_bit(CONTEXT_TABLE_PRESERVED_BIT(bus, devfn),
>>+			(unsigned long *)&ser->intel.context_tables_bitmap[0]);
>>+}
>>+
>>+static void unpreserve_context_table(struct intel_iommu *iommu,
>>+				     struct iommu_hw_ser *ser,
>>+				     u8 bus, u8 devfn)
>>+{
>>+	struct context_entry *context;
>>+
>>+	/*
>>+	 * In the Intel IOMMU driver, context tables are never freed once they
>>+	 * are allocated during runtime, as they can be shared across multiple
>>+	 * devices. So taking the iommu lock here to protect against concurrent
>>+	 * allocations inside iommu_context_addr() should be enough. Once the
>>+	 * address is read, it is safe to use it without holding the lock.
>>+	 */
>>+	spin_lock(&iommu->lock);
>>+	context = iommu_context_addr(iommu, bus, devfn, 0);
>>+	spin_unlock(&iommu->lock);
>>+	if (context && is_context_table_preserved(iommu, ser, bus, devfn)) {
>>+		iommu_unpreserve_pages(context);
>>+		clear_bit(CONTEXT_TABLE_PRESERVED_BIT(bus, devfn),
>>+			  (unsigned long *)&ser->intel.context_tables_bitmap[0]);
>>+	}
>>+}
>>+
>>+static int preserve_context_table(struct intel_iommu *iommu,
>>+				  struct iommu_hw_ser *ser,
>>+				  u8 bus, u8 devfn)
>>+{
>>+	struct context_entry *context;
>>+	int ret;
>>+
>>+	spin_lock(&iommu->lock);
>>+	context = iommu_context_addr(iommu, bus, devfn, 0);
>>+	spin_unlock(&iommu->lock);
>>+
>>+	/*
>>+	 * Intel IOMMU context tables are never freed by the driver once
>>+	 * allocated. It is safe to access the context pointer outside of the
>>+	 * iommu->lock.
>>+	 */
>>+	if (context && !is_context_table_preserved(iommu, ser, bus, devfn)) {
>>+		ret = iommu_preserve_pages(context);
>>+		if (ret)
>>+			return ret;
>>+
>>+		set_bit(CONTEXT_TABLE_PRESERVED_BIT(bus, devfn),
>>+			(unsigned long *)&ser->intel.context_tables_bitmap[0]);
>>+	}
>>+
>>+	return 0;
>>+}
>>+
>>+static void unpreserve_iommu_context_tables(struct intel_iommu *iommu,
>>+					    struct iommu_hw_ser *ser)
>>+{
>>+	int i;
>>+
>>+	for (i = 0; i < ROOT_ENTRY_NR; i++) {
>>+		unpreserve_context_table(iommu, ser, i, 0);
>>+
>>+		if (!sm_supported(iommu))
>>+			continue;
>>+
>>+		unpreserve_context_table(iommu, ser, i, 0x80);
>>+	}
>>+}
>>+
>>+static int preserve_iommu_context_tables(struct device_domain_info *info)
>>+{
>>+	struct iommu_hw_ser *iommu_ser;
>>+	struct intel_iommu *iommu;
>>+	int ret;
>>+	int i;
>>+
>>+	/* IOMMU for this device should already preserved.*/
>>+	iommu = info->iommu;
>>+	iommu_ser = iommu_preserved_state(&iommu->iommu);
>>+	if (!iommu_ser)
>>+		return -EINVAL;
>>+
>>+	/*
>>+	 * We could do preservation of context tables only for the bus of this
>>+	 * device, but these devices can have PCI aliases, so context tables for
>>+	 * those will also require preservation. Also unpreserve would require
>>+	 * some kind of refcounting where the context table will only be
>>+	 * unpreserved when the last device associated with it is unpreserved.
>>+	 *
>>+	 * This introduces unnecessary complication with minimum benefits as the
>>+	 * unpreserved context tables will probably be recreated by the next
>>+	 * kernel as these are all active devices. We follow simpler approach by
>>+	 * just preserving the currently active context tables.
>>+	 */
>>+	for (i = 0; i < ROOT_ENTRY_NR; i++) {
>>+		ret = preserve_context_table(iommu, iommu_ser, i, 0);
>>+		if (ret)
>>+			return ret;
>>+
>>+		if (!sm_supported(iommu))
>>+			continue;
>>+
>>+		ret = preserve_context_table(iommu, iommu_ser, i, 0x80);
>>+		if (ret)
>>+			return ret;
>>+	}
>
>This checks and then sets bits in context_tables_bitmap with no lock
>covering both steps. iommu_preserve_device() is serialized by
>&flb_obj->lock, so it might be worth adding a lockdep_assert_held() or
>at least a comment to explain this?

Sounds good. The lock is private to the iommu core, so the driver cannot
do lockdep_assert_held() on it. I will add a comment to clarify this.
>
>>+
>>+	return 0;
>>+}
>>+
>>+/**
>>+ * intel_iommu_preserve_device() - Intel IOMMU callback to preserve device state
>>+ * @dev: Target device
>>+ * @device_ser: Struct to populate with serialized device state
>>+ *
>>+ * Return: 0 on success, or negative error code.
>>+ */
>>+int intel_iommu_preserve_device(struct device *dev,
>>+				struct iommu_device_ser *device_ser)
>>+{
>>+	struct device_domain_info *info = dev_iommu_priv_get(dev);
>>+	int ret;
>>+
>>+	if (!dev_is_pci(dev)) {
>>+		dev_err(dev, "Cannot preserve non-PCI device\n");
>>+		return -EOPNOTSUPP;
>>+	}
>>+
>>+	if (dev_is_real_dma_subdevice(dev))
>>+		return -EOPNOTSUPP;
>>+
>>+	if (!info || !info->domain)
>>+		return -EINVAL;
>>+
>>+	if (info->ats_supported)
>>+		return -EOPNOTSUPP;
>
>This might be overkill. Could 'supported but disabled' be allowed? If
>that's allowed, checking 'info->ats_enabled' would be better.

I thought about that, but the context entry is set up based on
info->ats_supported, so the preserved context entry still has DTE set
even if ATS is disabled on the device. If the next kernel does not
support ATS, then ats_supported would be out of sync with the preserved
context entry. I think it is better to handle both supported/enabled
together in a follow-up after ATS adoption support is added on the PCI
side.
>>+
>>+	ret = preserve_iommu_context_tables(info);
>>+	if (ret)
>>+		return ret;
>
>Considering that this driver always preserves all active context
>entries, does it make more sense to move preserve_iommu_context_tables()
>to intel_iommu_preserve()?

intel_iommu_preserve() is only called once per IOMMU, when the first
device behind it is preserved. New context tables can be allocated after
that when new devices are added/probed, so this needs to be here so the
context tables of any device preserved later are also preserved.  If it
is moved to intel_iommu_preserve(), the context tables allocated later
will not be preserved. I will add a comment to clarify this.
>
>>+
>>+	device_ser->domain_iommu_ser.attachment_id = domain_id_iommu(info->domain,
>>+								     info->iommu);
>>+	return 0;
>>+}
>>+
>>+/**
>>+ * intel_iommu_unpreserve_device() - Intel IOMMU callback to unpreserve device state
>>+ * @dev: Target device
>>+ * @device_ser: Struct containing serialized device state
>>+ */
>>+void intel_iommu_unpreserve_device(struct device *dev,
>>+				   struct iommu_device_ser *device_ser)
>>+{
>>+	/*
>>+	 * The context tables preserved during device preservation, in the
>>+	 * preserve_device() callback, might be shared with other devices, so
>>+	 * those are unpreserved in the iommu unpreserve() callback. So this
>>+	 * callback is kept empty.
>>+	 *
>>+	 * Once device PASID tables are preserved, the unpreservation of PASID
>>+	 * tables will be added here.
>>+	 */
>>+}
>>+
>>+/**
>>+ * intel_iommu_preserve() - Intel IOMMU callback to preserve hardware state
>>+ * @iommu_dev: Generic IOMMU device handle
>>+ * @ser: Struct to populate with serialized hardware state
>>+ *
>>+ * Return: 0 on success, or negative error code.
>>+ */
>>+int intel_iommu_preserve(struct iommu_device *iommu_dev,
>>+			 struct iommu_hw_ser *ser)
>>+{
>>+	struct intel_iommu *iommu;
>>+	int ret;
>>+
>>+	iommu = container_of(iommu_dev, struct intel_iommu, iommu);
>>+
>>+	ret = iommu_preserve_pages(iommu->root_entry);
>>+	if (ret)
>>+		return ret;
>>+
>>+	ser->intel.phys_addr = iommu->reg_phys;
>>+	ser->intel.root_table = __pa(iommu->root_entry);
>>+	ser->type = IOMMU_INTEL;
>>+	ser->token = ser->intel.phys_addr;
>>+
>>+	return 0;
>>+}
>>+
>>+/**
>>+ * intel_iommu_unpreserve() - Intel IOMMU callback to unpreserve hardware state
>>+ * @iommu_dev: Generic IOMMU device handle
>>+ * @ser: Struct containing serialized hardware state
>>+ */
>>+void intel_iommu_unpreserve(struct iommu_device *iommu_dev,
>>+			    struct iommu_hw_ser *ser)
>>+{
>>+	struct intel_iommu *iommu;
>>+
>>+	iommu = container_of(iommu_dev, struct intel_iommu, iommu);
>>+
>>+	unpreserve_iommu_context_tables(iommu, ser);
>>+	iommu_unpreserve_pages(iommu->root_entry);
>>+}
>>diff --git a/include/linux/kho/abi/iommu.h b/include/linux/kho/abi/iommu.h
>>index aa42085409e5..5aaa29da6832 100644
>>--- a/include/linux/kho/abi/iommu.h
>>+++ b/include/linux/kho/abi/iommu.h
>>@@ -81,6 +81,7 @@
>>   */
>>  enum iommu_type_ser {
>>  	IOMMU_INVALID,
>>+	IOMMU_INTEL,
>>  };
>>  #define IOMMU_SER_FLAG_DELETED	(1 << 0)
>>@@ -144,16 +145,39 @@ struct iommu_device_ser {
>>  	struct iommu_dev_map_ser domain_iommu_ser;
>>  } __packed;
>>+/* There are maximum 256 buses, so maximum 512 context tables */
>>+#define VTD_PRESERVED_BITMAP_LONGS  DIV_ROUND_UP(512, BITS_PER_LONG_LONG)
>>+
>>+/**
>>+ * struct iommu_intel_ser - Serialized state of an Intel IOMMU instance
>>+ * @restored: Whether IOMMU state is restored
>>+ * @phys_addr: Physical address of the IOMMU register base
>>+ * @root_table: Physical address of the root entry table
>>+ * @context_tables_bitmap: Bitmap representing the context tables that are
>>+ * preserved.
>>+ */
>>+struct iommu_intel_ser {
>>+	u8 restored;
>>+	u8 padding[7];
>>+	u64 phys_addr;
>>+	u64 root_table;
>>+	u64 context_tables_bitmap[VTD_PRESERVED_BITMAP_LONGS];
>>+};
>>+
>>  /**
>>   * struct iommu_hw_ser - Serialized state of an IOMMU instance
>>   * @hdr: Common object header
>>   * @token: Unique token for the IOMMU
>>   * @type: IOMMU type serialized state belongs to
>>+ * @intel: Intel specific serialization data
>>   */
>>  struct iommu_hw_ser {
>>  	struct iommu_hdr_ser hdr;
>>  	u64 token;
>>  	u64 type;
>>+	union {
>>+		struct iommu_intel_ser intel;
>>+	};
>>  } __packed;
>>  /**
>
>Thanks,
>baolu

Thanks,
Sam
