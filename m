Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD4134104E
	for <iommu@lists.linux.dev>; Fri, 20 Mar 2026 23:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774047732; cv=none; b=GO79fW5rZIr6pO/wKtt+n7tPsqnHw5n9k8rZkEP7rVH55xvkTL+CYqVHj78xMYW7hZqaCtEm/YUPUbqDPTcOLXaEYduq9++87AdQgMTE+Wbs7j5ddlkfbMocPER8XawOhoYStovM2/7iqORYa45tbuTtxFIc370hINjdd8iVk9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774047732; c=relaxed/simple;
	bh=Nn0ALrdXYnzXye+eQmzrx53e5T7Ey86s5EVAM2zENXE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KjZ30jsXUY0T4QzT5tbokyaKUfZULsWkr04eag01ZE/TsO3cFS/1fERuBE8WWGvDU8aq61RWmnWOgOry3EkWG8o/l30+hj7Hs7DroyxnWUUL9297UvI0ggymQJfWCozqXLsK3hlDEH5Kmhh8VaM8YOX48LcA6ddkAeKQtRBNi3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=J5FCodyS; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J5FCodyS"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2b04c9e3eb7so34595ad.0
        for <iommu@lists.linux.dev>; Fri, 20 Mar 2026 16:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774047729; x=1774652529; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rRn8bETX30Lb2Xb+2jweq88kWDnEQZ7Z1tWRbRz5s4s=;
        b=J5FCodySN9s9aZIJiP89DDBBzUoTvG1JucAPvIf3p2LaE/lTfPH/IybsdLvXB6d6/D
         t0jYHBmn4YUt7HFDb3GSRkqj2WtC5TTHNhDzlwlkRSWE3I9fXCOnxk13YhbFU2ymCjzV
         Bh/jG7BO6WGl3oJMtvcdEUoIYRcSyI1DK37L6UMa25GI3Ewqgz+y0U0X/3d+x1sdjnVf
         ilarvof9ahb2mlRL45Vhjb3siyOr5yY3bAnifFQv5VVydUDoqsCuFxBWlBXTiixeaJ2+
         ZC8g+nDJXwAXhMiYgfnW4dlNT1AVM41ChXtU7N2aNgmPEyZ1tmPR7Nay/TNzmOo1W0r7
         xU7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774047729; x=1774652529;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rRn8bETX30Lb2Xb+2jweq88kWDnEQZ7Z1tWRbRz5s4s=;
        b=PU4fXVBHSOdzFpvTxdoB9pnDx1fglrmtM8GxeIX+2bdCiekj29GzOBRQa+ErBhJtMV
         vxqZt413sdrfZbkI9FxG78t6Jtgro88Wp8X+e9+ASdw6DsZgYIDksOvmsUpt/4dlhZs3
         UH1sFqDR+hrCTnV+alxOgmnlRYerU4DHqwsgKchexHYX55aZGGAiP55NoU6uJMKCXoj6
         /dgwCBSrnaCthfHhTfk+7CiYSknfo99LV3bXdGRbhPUDDXbayI/UGjH+EVbXiv2Jf4EY
         Lq7iOrO2+c+6JgK21TCnQafsMsI3q9i0njJtGveXXn73eK45JexXQdoH0giWc6luUewf
         /HOg==
X-Forwarded-Encrypted: i=1; AJvYcCUm5EK7oC2+Zyn22eP3SW8ObvV+mR4xM3qixmHTND72aIJN7mfChv710WnWEcbh987gjeF5YA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx2+UxtYIVcPzOXW/ZzqaYdzIgAm75CcXYA5aIQ/gC6x9l1K1Sp
	YmcqTz8BjkK+11zvmYVPWBg4HrgL+g8EKEi5dH7MizlvUYhGwmYwVlWN58bDCwFulA==
X-Gm-Gg: ATEYQzw9zSYsD6b1fw82FbpyFWKzUt+EElNtxBgb3cmGKYA29jmrfCpFmkyzLfal32z
	YaCM88VR0k1bqkB+d2zLgmAIvvAC7d8kJXuZZPZtN2S5l/nlrFyvarSzjPxe9gQrUwWXmUD5Pit
	75ZJejppl61UYkhN+pfALrznrFMc7MqoYCf1BJqN+jaEfdzZ4iON70e2rtCtsuKbrq2z1u4aOES
	7WeGD2pbtYr+lKUltFjIHkd0Co0gSez6YGN3V/z7oEK4GtuPsAOPkq/xsZmef9BddtDUXJKLV9Z
	klGM1sJnZ1sc8ONP6Pws7g4suDD2xMtpOzYyVAbTIdUO70fIijnZSel4C2/yliY3J11YqeLTowW
	wESK+pVyCyuLw3U/VPuuhWcI3JdRayGnQ+MmYKyHpYWgxwQTiMRkU6x9T65ICBbzjXZcbJHWcTc
	n+YViU3RM7cdxG3CrMD6Irdid+dl1kajVp0RIOtBKrL7Y50mja32YLkrRsuQ==
X-Received: by 2002:a17:902:f707:b0:2b0:5e19:1862 with SMTP id d9443c01a7336-2b08c4a14c0mr598585ad.5.1774047728180;
        Fri, 20 Mar 2026 16:02:08 -0700 (PDT)
Received: from google.com (10.129.124.34.bc.googleusercontent.com. [34.124.129.10])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c743a7ffafdsm2476969a12.7.2026.03.20.16.02.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 16:02:07 -0700 (PDT)
Date: Fri, 20 Mar 2026 23:01:59 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Parav Pandit <parav@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	David Matlack <dmatlack@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Chris Li <chrisl@kernel.org>, Vipin Sharma <vipinsh@google.com>,
	YiFei Zhu <zhuyifei@google.com>
Subject: Re: [PATCH 06/14] iommu/vt-d: Implement device and iommu
 preserve/unpreserve ops
Message-ID: <ab3R54-kyHGDEW9L@google.com>
References: <20260203220948.2176157-1-skhawaja@google.com>
 <20260203220948.2176157-7-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260203220948.2176157-7-skhawaja@google.com>

On Tue, Feb 03, 2026 at 10:09:40PM +0000, Samiullah Khawaja wrote:
> Add implementation of the device and iommu presevation in a separate
> file. Also set the device and iommu preserve/unpreserve ops in the
> struct iommu_ops.
> 
> During normal shutdown the iommu translation is disabled. Since the root
> table is preserved during live update, it needs to be cleaned up and the
> context entries of the unpreserved devices need to be cleared.
> 
> Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
> ---
>  drivers/iommu/intel/Makefile     |   1 +
>  drivers/iommu/intel/iommu.c      |  47 ++++++++++-
>  drivers/iommu/intel/iommu.h      |  27 +++++++
>  drivers/iommu/intel/liveupdate.c | 134 +++++++++++++++++++++++++++++++
>  4 files changed, 205 insertions(+), 4 deletions(-)
>  create mode 100644 drivers/iommu/intel/liveupdate.c
> 
> diff --git a/drivers/iommu/intel/Makefile b/drivers/iommu/intel/Makefile
> index ada651c4a01b..d38fc101bc35 100644
> --- a/drivers/iommu/intel/Makefile
> +++ b/drivers/iommu/intel/Makefile
> @@ -6,3 +6,4 @@ obj-$(CONFIG_INTEL_IOMMU_DEBUGFS) += debugfs.o
>  obj-$(CONFIG_INTEL_IOMMU_SVM) += svm.o
>  obj-$(CONFIG_IRQ_REMAP) += irq_remapping.o
>  obj-$(CONFIG_INTEL_IOMMU_PERF_EVENTS) += perfmon.o
> +obj-$(CONFIG_IOMMU_LIVEUPDATE) += liveupdate.o
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 134302fbcd92..c95de93fb72f 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -16,6 +16,7 @@
>  #include <linux/crash_dump.h>
>  #include <linux/dma-direct.h>
>  #include <linux/dmi.h>
> +#include <linux/iommu-lu.h>
>  #include <linux/memory.h>
>  #include <linux/pci.h>
>  #include <linux/pci-ats.h>
> @@ -52,6 +53,8 @@ static int rwbf_quirk;
>  
>  #define rwbf_required(iommu)	(rwbf_quirk || cap_rwbf((iommu)->cap))
>  
> +static bool __maybe_clean_unpreserved_context_entries(struct intel_iommu *iommu);
> +
>  /*
>   * set to 1 to panic kernel if can't successfully enable VT-d
>   * (used when kernel is launched w/ TXT)
> @@ -60,8 +63,6 @@ static int force_on = 0;
>  static int intel_iommu_tboot_noforce;
>  static int no_platform_optin;
>  
> -#define ROOT_ENTRY_NR (VTD_PAGE_SIZE/sizeof(struct root_entry))
> -
>  /*
>   * Take a root_entry and return the Lower Context Table Pointer (LCTP)
>   * if marked present.
> @@ -2378,8 +2379,10 @@ void intel_iommu_shutdown(void)
>  		/* Disable PMRs explicitly here. */
>  		iommu_disable_protect_mem_regions(iommu);
>  
> -		/* Make sure the IOMMUs are switched off */
> -		iommu_disable_translation(iommu);
> +		if (!__maybe_clean_unpreserved_context_entries(iommu)) {
> +			/* Make sure the IOMMUs are switched off */
> +			iommu_disable_translation(iommu);
> +		}
>  	}
>  }
>  
> @@ -2902,6 +2905,38 @@ static const struct iommu_dirty_ops intel_second_stage_dirty_ops = {
>  	.set_dirty_tracking = intel_iommu_set_dirty_tracking,
>  };
>  
> +#ifdef CONFIG_IOMMU_LIVEUPDATE
> +static bool __maybe_clean_unpreserved_context_entries(struct intel_iommu *iommu)
> +{
> +	struct device_domain_info *info;
> +	struct pci_dev *pdev = NULL;
> +
> +	if (!iommu->iommu.outgoing_preserved_state)
> +		return false;
> +
> +	for_each_pci_dev(pdev) {

Shouldn't we *also* clean context entries for non-pci devices?

AFAICT, in the current code, we simply turn off translation during
shutdowm. However, with this change, because this cleanup loop only runs
for_each_pci_dev(), it completely ignores any non-PCI devices (like 
platform devices) that might be attached to this IOMMU?

Since the IOMMU is left powered on during the handover, skipping non-PCI
devices in this cleanup loop means their context entries are left
perfectly intact and active in the hardware root table. There could be a
chance that the new kernel doesn't reclaim/overwrite these entries in
which case it could result in zombie DMAs surviving the KHO.

> +		info = dev_iommu_priv_get(&pdev->dev);
> +		if (!info)
> +			continue;
> +
> +		if (info->iommu != iommu)
> +			continue;
> +
> +		if (dev_iommu_preserved_state(&pdev->dev))
> +			continue;
> +
> +		domain_context_clear(info);
> +	}
> +
> +	return true;
> +}
> +#else
> +static bool __maybe_clean_unpreserved_context_entries(struct intel_iommu *iommu)
> +{
> +	return false;
> +}
> +#endif
> +
>  static struct iommu_domain *
>  intel_iommu_domain_alloc_second_stage(struct device *dev,
>  				      struct intel_iommu *iommu, u32 flags)
> @@ -3925,6 +3960,10 @@ const struct iommu_ops intel_iommu_ops = {
>  	.is_attach_deferred	= intel_iommu_is_attach_deferred,
>  	.def_domain_type	= device_def_domain_type,
>  	.page_response		= intel_iommu_page_response,
> +	.preserve_device	= intel_iommu_preserve_device,
> +	.unpreserve_device	= intel_iommu_unpreserve_device,
> +	.preserve		= intel_iommu_preserve,
> +	.unpreserve		= intel_iommu_unpreserve,
>  };
>  
>  static void quirk_iommu_igfx(struct pci_dev *dev)
> diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
> index 25c5e22096d4..70032e86437d 100644
> --- a/drivers/iommu/intel/iommu.h
> +++ b/drivers/iommu/intel/iommu.h
> @@ -557,6 +557,8 @@ struct root_entry {
>  	u64     hi;
>  };
>  
> +#define ROOT_ENTRY_NR (VTD_PAGE_SIZE / sizeof(struct root_entry))
> +
>  /*
>   * low 64 bits:
>   * 0: present
> @@ -1276,6 +1278,31 @@ static inline int iopf_for_domain_replace(struct iommu_domain *new,
>  	return 0;
>  }
>  
> +#ifdef CONFIG_IOMMU_LIVEUPDATE
> +int intel_iommu_preserve_device(struct device *dev, struct device_ser *device_ser);
> +void intel_iommu_unpreserve_device(struct device *dev, struct device_ser *device_ser);
> +int intel_iommu_preserve(struct iommu_device *iommu, struct iommu_ser *iommu_ser);
> +void intel_iommu_unpreserve(struct iommu_device *iommu, struct iommu_ser *iommu_ser);
> +#else
> +static inline int intel_iommu_preserve_device(struct device *dev, struct device_ser *device_ser)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +static inline void intel_iommu_unpreserve_device(struct device *dev, struct device_ser *device_ser)
> +{
> +}
> +
> +static inline int intel_iommu_preserve(struct iommu_device *iommu, struct iommu_ser *iommu_ser)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +static inline void intel_iommu_unpreserve(struct iommu_device *iommu, struct iommu_ser *iommu_ser)
> +{
> +}
> +#endif
> +
>  #ifdef CONFIG_INTEL_IOMMU_SVM
>  void intel_svm_check(struct intel_iommu *iommu);
>  struct iommu_domain *intel_svm_domain_alloc(struct device *dev,
> diff --git a/drivers/iommu/intel/liveupdate.c b/drivers/iommu/intel/liveupdate.c
> new file mode 100644
> index 000000000000..82ba1daf1711
> --- /dev/null
> +++ b/drivers/iommu/intel/liveupdate.c
> @@ -0,0 +1,134 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +/*
> + * Copyright (C) 2025, Google LLC
> + * Author: Samiullah Khawaja <skhawaja@google.com>
> + */
> +
> +#define pr_fmt(fmt)    "iommu: liveupdate: " fmt
> +
> +#include <linux/kexec_handover.h>
> +#include <linux/liveupdate.h>
> +#include <linux/iommu-lu.h>
> +#include <linux/module.h>
> +#include <linux/pci.h>
> +
> +#include "iommu.h"
> +#include "../iommu-pages.h"
> +
> +static void unpreserve_iommu_context(struct intel_iommu *iommu, int end)
> +{
> +	struct context_entry *context;
> +	int i;
> +
> +	if (end < 0)
> +		end = ROOT_ENTRY_NR;
> +
> +	for (i = 0; i < end; i++) {
> +		context = iommu_context_addr(iommu, i, 0, 0);
> +		if (context)
> +			iommu_unpreserve_page(context);
> +
> +		if (!sm_supported(iommu))
> +			continue;
> +
> +		context = iommu_context_addr(iommu, i, 0x80, 0);
> +		if (context)
> +			iommu_unpreserve_page(context);
> +	}
> +}
> +
> +static int preserve_iommu_context(struct intel_iommu *iommu)
> +{
> +	struct context_entry *context;
> +	int ret;
> +	int i;
> +
> +	for (i = 0; i < ROOT_ENTRY_NR; i++) {
> +		context = iommu_context_addr(iommu, i, 0, 0);
> +		if (context) {
> +			ret = iommu_preserve_page(context);
> +			if (ret)
> +				goto error;
> +		}
> +
> +		if (!sm_supported(iommu))
> +			continue;
> +
> +		context = iommu_context_addr(iommu, i, 0x80, 0);
> +		if (context) {
> +			ret = iommu_preserve_page(context);
> +			if (ret)
> +				goto error_sm;
> +		}
> +	}
> +
> +	return 0;
> +
> +error_sm:
> +	context = iommu_context_addr(iommu, i, 0, 0);
> +	iommu_unpreserve_page(context);
> +error:
> +	unpreserve_iommu_context(iommu, i);
> +	return ret;
> +}
> +
> +int intel_iommu_preserve_device(struct device *dev, struct device_ser *device_ser)
> +{
> +	struct device_domain_info *info = dev_iommu_priv_get(dev);
> +
> +	if (!dev_is_pci(dev))
> +		return -EOPNOTSUPP;

Maybe also WARN_ON_ONCE ?

> +
> +	if (!info)
> +		return -EINVAL;
> +
> +	device_ser->domain_iommu_ser.did = domain_id_iommu(info->domain, info->iommu);
> +	return 0;
> +}
> +
> +void intel_iommu_unpreserve_device(struct device *dev, struct device_ser *device_ser)
> +{
> +}

Nit: We can just not populate the unpreserve_device op here, we don't
need an empty function

> +
> +int intel_iommu_preserve(struct iommu_device *iommu_dev, struct iommu_ser *ser)
> +{
> +	struct intel_iommu *iommu;
> +	int ret;
> +
> +	iommu = container_of(iommu_dev, struct intel_iommu, iommu);
> +
> +	spin_lock(&iommu->lock);

Minor note: We call this with the session->mutex acquired which is a
sleepable/preemptable context whereas spin_lock disables preemption and
puts us in an atomic context. 

While iommu_context_addr() happens to be safe here because it uses
GFP_ATOMIC & we pass alloc=0, we are heavily relying on the assumption
that iommu_context_addr() or other helpers will never sleep or attempt
a GFP_KERNEL allocation under the hood.

Given how easy it would be for a future refactor to accidentally
introduce a sleeping lock inside any of the other helpers, I'd recommend
adding an explicit comment here warning that this runs in an atomic
context (same for unpreserve below).

>r +	ret = preserve_iommu_context(iommu);
> +	if (ret)
> +		goto err;
> +
> +	ret = iommu_preserve_page(iommu->root_entry);
> +	if (ret) {
> +		unpreserve_iommu_context(iommu, -1);

Nit: The same overloading discussion as Vipin pointed out in the other
patch.

> +		goto err;
> +	}
> +
> +	ser->intel.phys_addr = iommu->reg_phys;
> +	ser->intel.root_table = __pa(iommu->root_entry);
> +	ser->type = IOMMU_INTEL;
> +	ser->token = ser->intel.phys_addr;
> +	spin_unlock(&iommu->lock);
> +
> +	return 0;
> +err:
> +	spin_unlock(&iommu->lock);
> +	return ret;
> +}
> +
> +void intel_iommu_unpreserve(struct iommu_device *iommu_dev, struct iommu_ser *iommu_ser)
> +{
> +	struct intel_iommu *iommu;
> +
> +	iommu = container_of(iommu_dev, struct intel_iommu, iommu);
> +
> +	spin_lock(&iommu->lock);
> +	unpreserve_iommu_context(iommu, -1);
> +	iommu_unpreserve_page(iommu->root_entry);
> +	spin_unlock(&iommu->lock);
> +}

Thanks,
Praan
