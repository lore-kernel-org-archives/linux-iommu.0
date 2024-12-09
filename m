Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1224F17741
	for <iommu@lists.linux.dev>; Mon,  9 Dec 2024 01:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733708474; cv=none; b=upHddlrCV40bzt7ipqRgW/GpG/HUp3YawTjoKoAfyZG1kkZwTf10cDq5731q0BkJGu1NSS/j3ZLX7eBp0gaMgV5lM4i7+HZM2fRr0IPa3Nshdf6KMwLLCOx8fRpu/dx3fg2OixqQdmyCDUW0pjreRmwlbm2ONGunx/7FILp2FFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733708474; c=relaxed/simple;
	bh=25EtLjU1S9Qn/yEfw16OQ2XoLO1RHGzZ2cjVqSCi2z0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lqfDZyuztAtj7fHfnc4cghEJ090uhta1nQrhZgm4ASKnFkoOds308tHdC+LOg+lctld3J3DcO4iDmpCJlkqxvRbVR+1/sbUhs5MCwR3Lbv1JSbL+T7hcLcH7dwn9jZd0t2iz54XD2TOI9oTjT3Gdy6MEFQSpPbHlyhWBp/dPjWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mcrhTnKt; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mcrhTnKt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733708473; x=1765244473;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=25EtLjU1S9Qn/yEfw16OQ2XoLO1RHGzZ2cjVqSCi2z0=;
  b=mcrhTnKtJYoBwMqlynI86H8AJ5jC7MRaYvzfkPlzTEpO+dEZbH/5pmta
   Ei6iYiHEgxHgl38hdEaMnQ+WGhZZqX6dchn/cXKxWgm/J0cmsFKTA6Wfs
   zDfibaTsIStG6gdHhN9yJYdKTRD83PEcujgNhOI9YBeVmZNtFPngmllYZ
   M6H2lPpxHvgyfKcTCh/2jS5M6/q/3wEkGJ4Vnmva+SsXNzBDfxojhuaFH
   Z6Gu/cp0FMl3+e5s73clUymblw1TWbH3Du92FSPuf8Gr6lWpNXBy3lnDO
   bAlhRsE5Iwn52uS3ZorJ7DE2czf6BQ2VvmOmwkxazzNEupQv2luPkMZj3
   w==;
X-CSE-ConnectionGUID: Dc41Fde4QAKNUL2sXbWmgw==
X-CSE-MsgGUID: Xc1QiyzTQzmOASIEtu0tfQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11280"; a="56475745"
X-IronPort-AV: E=Sophos;i="6.12,218,1728975600"; 
   d="scan'208";a="56475745"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2024 17:41:12 -0800
X-CSE-ConnectionGUID: oaGAoZETSN2iCu6/XQxaYQ==
X-CSE-MsgGUID: vKakJtq2TAK6DSHzsyTIng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,218,1728975600"; 
   d="scan'208";a="125820909"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2024 17:41:11 -0800
Message-ID: <ce413d97-ec46-4cd9-932a-af804cd531cf@linux.intel.com>
Date: Mon, 9 Dec 2024 09:39:41 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/vt-d: Fix qi_batch NULL pointer with nested parent
 domain
To: Yi Liu <yi.l.liu@intel.com>, joro@8bytes.org, kevin.tian@intel.com
Cc: chao.p.peng@linux.intel.com, iommu@lists.linux.dev
References: <20241207120304.5710-1-yi.l.liu@intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20241207120304.5710-1-yi.l.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/7/24 20:03, Yi Liu wrote:
> The qi_batch is allocated when assigning cache tag for a domain. While
> for nested parent domain, it is missed. Hence, when trying to map pages
> to the nested parent, NULL dereference occurred.

Yes. Good catch!

> To solve it, allocate qi_batch for the nested parent domain when assigning
> cache tag for the nested domain is enough. However, it seems not quite
> reliable to allocate qi_batch in cache tag as a domain may be used by
> multiple devices, and there is no lock around the domain->qi_batch check.
> As all the domains (except blocking domain and identity domain) are supposed
> to have qi_batch, this fix just allocates the qi_batch in the domain
> allocation.

So there appears to be two problems, the domain->qi_batch is not
allocated for all paths and it's allocated without lock protection that
creates a race case and possibly result in memory leak.

But I don't think there is a need to move the domain->qi_batch
allocation to the domain allocation path. That's a kind of refactoring
and there is no need to mess it with a fix patch like this.

Perhaps add a helper to handle the domain->qi_batch allocation? And then
call it in the necessary paths? Something like this:

--- a/drivers/iommu/intel/cache.c
+++ b/drivers/iommu/intel/cache.c
@@ -105,12 +105,35 @@ static void cache_tag_unassign(struct dmar_domain 
*domain, u16 did,
  	spin_unlock_irqrestore(&domain->cache_lock, flags);
  }

+/* domain->qi_batch will be freed in iommu_free_domain() path. */
+static int domain_qi_batch_alloc(struct dmar_domain *domain)
+{
+	unsigned long flags;
+	int ret = 0;
+
+	spin_lock_irqsave(&domain->cache_lock, flags);
+	if (domain->qi_batch)
+		goto out_unlock;
+
+	domain->qi_batch = kzalloc(sizeof(*domain->qi_batch), GFP_ATOMIC);
+	if (!domain->qi_batch)
+		ret = -ENOMEM;
+out_unlock:
+	spin_unlock_irqrestore(&domain->cache_lock, flags);
+
+	return ret;
+}
+
  static int __cache_tag_assign_domain(struct dmar_domain *domain, u16 did,
  				     struct device *dev, ioasid_t pasid)
  {
  	struct device_domain_info *info = dev_iommu_priv_get(dev);
  	int ret;

+	ret = domain_qi_batch_alloc(domain);
+	if (ret)
+		return ret;
+
  	ret = cache_tag_assign(domain, did, dev, pasid, CACHE_TAG_IOTLB);
  	if (ret || !info->ats_enabled)
  		return ret;
@@ -139,6 +162,10 @@ static int __cache_tag_assign_parent_domain(struct 
dmar_domain *domain, u16 did,
  	struct device_domain_info *info = dev_iommu_priv_get(dev);
  	int ret;

+	ret = domain_qi_batch_alloc(domain);
+	if (ret)
+		return ret;
+
  	ret = cache_tag_assign(domain, did, dev, pasid, CACHE_TAG_NESTING_IOTLB);
  	if (ret || !info->ats_enabled)
  		return ret;
@@ -190,13 +217,6 @@ int cache_tag_assign_domain(struct dmar_domain *domain,
  	u16 did = domain_get_id_for_dev(domain, dev);
  	int ret;

-	/* domain->qi_bach will be freed in iommu_free_domain() path. */
-	if (!domain->qi_batch) {
-		domain->qi_batch = kzalloc(sizeof(*domain->qi_batch), GFP_KERNEL);
-		if (!domain->qi_batch)
-			return -ENOMEM;
-	}
-
  	ret = __cache_tag_assign_domain(domain, did, dev, pasid);
  	if (ret || domain->domain.type != IOMMU_DOMAIN_NESTED)
  		return ret;

> 
> [  176.749284] BUG: kernel NULL pointer dereference, address: 0000000000000200
> [  176.758178] #PF: supervisor read access in kernel mode
> [  176.765052] #PF: error_code(0x0000) - not-present page
> [  176.771985] PGD 8104795067 P4D 0
> [  176.776900] Oops: Oops: 0000 [#1] PREEMPT SMP NOPTI
> [  176.783640] CPU: 223 UID: 0 PID: 4357 Comm: qemu-system-x86 Not tainted 6.13.0-rc1-00028-g4b50c3c3b998-dirty #2632
> [  176.797868] Hardware name: Intel Corporation ArcherCity/ArcherCity, BIOS EGSDCRB1.SYS.0107.D52.2311070228 11/07/2023
> [  176.812762] RIP: 0010:cache_tag_flush_range_np+0x13c/0x260
> [  176.820656] Code: 8b 6e 18 41 f6 45 18 80 0f 85 66 ff ff ff 4c 89 ef e8 e8 98 ff ff 4d 8b 36 49 39 ee 75 a3 4d 85 ed 48 8b ab 28 01 00 00 74 0e <8b> 95 00 02 00 00 85 d2 0f 85 88 00 00 00 48 8b 74 24 08 4c 89 ff
> [  176.847296] RSP: 0018:ff2e80d8b4887aa0 EFLAGS: 00010086
> [  176.855207] RAX: 0000000000000000 RBX: ff18cd64bca69000 RCX: 0000000000000001
> [  176.865337] RDX: 0000000000000000 RSI: ffffffff98206127 RDI: ff18cd6440139c00
> [  176.875453] RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
> [  176.885622] R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000000
> [  176.895802] R13: ff18cd6440139c00 R14: ff18cd64bca69118 R15: ff18cd64bca690d0
> [  176.906056] FS:  00007f070a7fc640(0000) GS:ff18cde22fa00000(0000) knlGS:0000000000000000
> [  176.917459] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  176.926274] CR2: 0000000000000200 CR3: 00000080996ee003 CR4: 0000000000f73ef0
> [  176.936703] PKRU: 55555554
> [  176.942175] Call Trace:
> [  176.947385]  <TASK>
> [  176.952216]  ? __die+0x24/0x70
> [  176.958114]  ? page_fault_oops+0x80/0x150
> [  176.965133]  ? do_user_addr_fault+0x63/0x7b0
> [  176.972462]  ? exc_page_fault+0x7c/0x220
> [  176.979437]  ? asm_exc_page_fault+0x26/0x30
> [  176.986755]  ? cache_tag_flush_range_np+0x13c/0x260
> [  176.994903]  intel_iommu_iotlb_sync_map+0x1a/0x30
> [  177.002880]  iommu_map+0x61/0xf0
> [  177.009198]  batch_to_domain+0x188/0x250
> [  177.016344]  iopt_area_fill_domains+0x125/0x320
> [  177.024220]  ? rcu_is_watching+0x11/0x50
> [  177.031442]  iopt_map_pages+0x63/0x100
> [  177.038420]  iopt_map_common.isra.0+0xa7/0x190
> [  177.046131]  iopt_map_user_pages+0x6a/0x80
> [  177.053435]  iommufd_ioas_map+0xcd/0x1d0
> [  177.060537]  iommufd_fops_ioctl+0x118/0x1c0
> [  177.067918]  __x64_sys_ioctl+0x93/0xc0
> [  177.074736]  do_syscall_64+0x71/0x140
> [  177.081376]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [  177.089489] RIP: 0033:0x7f071491a94f
> [  177.095876] Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00 00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05 <41> 89 c0 3d 00 f0 ff ff 77 1f 48 8b 44 24 18 64 48 2b 04 25 28 00
> [  177.124032] RSP: 002b:00007f070a7f76d0 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> [  177.134964] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f071491a94f
> [  177.145390] RDX: 00007f070a7f7760 RSI: 0000000000003b85 RDI: 0000000000000015
> [  177.155834] RBP: 0000000000000015 R08: 00007f0603e00000 R09: 0000000000000000
> [  177.166247] R10: 000056326cd25970 R11: 0000000000000246 R12: 00000000000a0000
> [  177.177421] R13: 0000000000000004 R14: 0000000000000000 R15: 00000000000a0000
> [  177.187869]  </TASK>
> [  177.192700] Modules linked in: vfio_pci vfio_pci_core vfio_iommu_type1 vfio intel_rapl_msr intel_rapl_common intel_uncore_frequency intel_uncore_frequency_common i10nm_edac skx_edac_common nfit x86_pkg_temp_thermal intel_powerclamp coretemp snd_hda_codec_realtek snd_hda_codec_generic snd_hda_scodec_component snd_hda_intel snd_intel_dspcfg snd_intel_sdw_acpi ofpart snd_hda_codec pmt_telemetry kvm_intel binfmt_misc pmt_class intel_sdsi snd_hda_core spi_nor isst_if_mbox_pci isst_if_mmio kvm dax_hmem mei_me joydev mtd isst_if_common snd_pcm intel_vsec idxd mei snd_timer cxl_acpi cxl_port cxl_core einj acpi_power_meter dm_multipath fuse ip_tables crc32c_intel i2c_i801 spi_intel_pci i2c_smbus i2c_ismt spi_intel drm_shmem_helper igc pinctrl_emmitsburg pinctrl_intel pwm_lpss

Strip the kernel message and leave only valuable messages that
developers might be interested. Something like this,

  BUG: kernel NULL pointer dereference, address: 0000000000000200
  #PF: supervisor read access in kernel mode
  #PF: error_code(0x0000) - not-present page
  PGD 8104795067 P4D 0
  Oops: Oops: 0000 [#1] PREEMPT SMP NOPTI
  CPU: 223 UID: 0 PID: 4357 Comm: qemu-system-x86 Not tainted 
6.13.0-rc1-00028-g4b50c3c3b998-dirty #2632
  Call Trace:
   ? __die+0x24/0x70
   ? page_fault_oops+0x80/0x150
   ? do_user_addr_fault+0x63/0x7b0
   ? exc_page_fault+0x7c/0x220
   ? asm_exc_page_fault+0x26/0x30
   ? cache_tag_flush_range_np+0x13c/0x260
   intel_iommu_iotlb_sync_map+0x1a/0x30
   iommu_map+0x61/0xf0
   batch_to_domain+0x188/0x250
   iopt_area_fill_domains+0x125/0x320
   ? rcu_is_watching+0x11/0x50
   iopt_map_pages+0x63/0x100
   iopt_map_common.isra.0+0xa7/0x190
   iopt_map_user_pages+0x6a/0x80
   iommufd_ioas_map+0xcd/0x1d0
   iommufd_fops_ioctl+0x118/0x1c0
   __x64_sys_ioctl+0x93/0xc0
   do_syscall_64+0x71/0x140
   entry_SYSCALL_64_after_hwframe+0x76/0x7e


> Fixes: 705c1cdf1e73 ("iommu/vt-d: Introduce batched cache invalidation")
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> ---
>   drivers/iommu/intel/cache.c  | 7 -------
>   drivers/iommu/intel/iommu.c  | 7 +++++++
>   drivers/iommu/intel/nested.c | 6 ++++++
>   drivers/iommu/intel/svm.c    | 7 +++++++
>   4 files changed, 20 insertions(+), 7 deletions(-)

[...]

Thanks,
baolu
