Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ACD63D76
	for <iommu@lists.linux.dev>; Mon, 14 Jul 2025 07:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752477765; cv=none; b=ligRR8hh4KRzi0ImzMhdsWAj5a6+aKKN7Na+v+bk77zy3EvEtEMaZbOFTYH0rwOJ73CUM0CDWPPIiyps5BrkKIIW2KiW2lkLieIEQhzwRBFv95HLiTbVOn5c5xDDorjbvfVY7alaZMBgF4OQijwaef6TVLAr3UoBOfsgHZRp7ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752477765; c=relaxed/simple;
	bh=hDVQKADURWbLhoPnDRnFeYYCgYSNTTnS+jXlsNlmAME=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JOiNWj+0gN7VEz3FdM5j728ym5y/gd5k5WWYaTiouYkYAcTznfNYO21ng/Y2R69PeiohTIDaZS04CYORMT/zV6Ve7kPFtP7Y1jEROJP28L4uZHcjYQ2MHHRkbtEVQiVOXDMmiKPbOSeeN4d0RglsQBIICMoNL88Iuqx45Az5SdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LlMfniAo; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LlMfniAo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752477764; x=1784013764;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=hDVQKADURWbLhoPnDRnFeYYCgYSNTTnS+jXlsNlmAME=;
  b=LlMfniAowWHCrPn7hd5zP5gT39HuLKarurQB/RM0/+BwmML4q1lGBYjq
   0XzGNucOQDDnlvOuPGy55clEy0QWU+VsmaLH/ibnUn/bmqCfV7UDUHpjC
   1PATTQZZVLF5AmBJePCMk/HCPNxTqBqB0FQm1aCDDDfICKjt5GfL/NfMP
   xSmRqJ+fQdF8ytnSZC1UHNXneTpzPlHOsLy8B660xCCEP4YRf9Wi4NQkv
   qrFlyoB+QABOaJgHL6uinm0xMGyw1ReaGdcJ+thSgCRPubPITDiEpvuZC
   2LH3ztPsRls0uEZO4wtzKfNyDYlALte9bVBFZQF2BMaV9UB8LybW4txs7
   w==;
X-CSE-ConnectionGUID: JRT9D0LuSlKXdHEpGSQlnQ==
X-CSE-MsgGUID: c5cQTT0sSwOeCZIfbKmrsA==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="65238660"
X-IronPort-AV: E=Sophos;i="6.16,310,1744095600"; 
   d="scan'208";a="65238660"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2025 00:22:43 -0700
X-CSE-ConnectionGUID: 2IcU3O8sSrCuARx+gnHZeg==
X-CSE-MsgGUID: VaYw9ZAkRJSP4DbVRYx41w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,310,1744095600"; 
   d="scan'208";a="194070265"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2025 00:22:42 -0700
Message-ID: <33cb4d38-cfc1-496a-a8dc-18d911b6534d@linux.intel.com>
Date: Mon, 14 Jul 2025 15:20:53 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: iommu/vt-d: Use-after-free on sva unbind device with pending
 IOPFs
To: Ethan MILON <ethan.milon@eviden.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>
Cc: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>, Kevin Tian
 <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>
References: <e8b37f3e-8539-40d4-8993-43a1f3ffe5aa@eviden.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <e8b37f3e-8539-40d4-8993-43a1f3ffe5aa@eviden.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/11/25 21:03, Ethan MILON wrote:
> Hi,
> 
> While testing SVA in QEMU with Intel IOMMU, I encountered a double free in
> the kernel when unbinding a device with page requests still in flight. This
> results in a use-after-free error and eventually a kernel panic:
> 
> [   48.227596] refcount_t: underflow; use-after-free.
> [   48.227949] WARNING: CPU: 3 PID: 313 at lib/refcount.c:28 refcount_warn_saturate+0xd8/0xe0
> [   48.228531] Modules linked in: sva(OE) xfs(E) sr_mod(E) sd_mod(E) cdrom(E) sg(E) ahci(E) libahci(E) libata(E) e1000(E) dm_mod(E)
> [   48.229460] CPU: 3 UID: 0 PID: 313 Comm: kworker/u16:4 Kdump: loaded Tainted: G           OE       6.16.0-rc5+ #59 PREEMPT(voluntary)
> [   48.230231] Tainted: [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
> [   48.230568] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
> [   48.231278] Workqueue: iopf_queue/dmar0-iopfq iommu_sva_handle_iopf
> [   48.231697] RIP: 0010:refcount_warn_saturate+0xd8/0xe0
> [   48.232028] Code: ff 48 c7 c7 58 eb 2e 82 c6 05 40 2f 35 01 01 e8 ae e8 ab ff 0f 0b c3 48 c7 c7 00 eb 2e 82 c6 05 2c 2f 35 01 01 e8 98 e8 ab ff <0f> 0b c3 0f 1f 44 00 003
> [   48.233202] RSP: 0018:ffffc900008afe50 EFLAGS: 00010286
> [   48.233541] RAX: 0000000000000000 RBX: ffff888113dccb40 RCX: 0000000000000000
> [   48.234007] RDX: ffff888861daa480 RSI: 0000000000000001 RDI: ffff888861d9c140
> [   48.234461] RBP: ffff8881118e0000 R08: 0000000000000000 R09: ffffc900008afcf8
> [   48.234942] R10: ffffc900008afcf0 R11: ffffffff829dfde8 R12: ffff888100f5c000
> [   48.235396] R13: ffff888100051c00 R14: ffff888100f5c005 R15: ffff88810c480000
> [   48.235860] FS:  0000000000000000(0000) GS:ffff8888dea4f000(0000) knlGS:0000000000000000
> [   48.236381] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   48.236763] CR2: 0000558328aa6468 CR3: 0000000111332002 CR4: 0000000000770ef0
> [   48.237222] PKRU: 55555554
> [   48.237397] Call Trace:
> [   48.237561]  <TASK>
> [   48.237727]  iopf_free_group+0xe/0x20
> [   48.237978]  process_one_work+0x197/0x3d0
> [   48.238239]  worker_thread+0x23a/0x350
> [   48.238487]  ? rescuer_thread+0x4a0/0x4a0
> [   48.238760]  kthread+0xf8/0x230
> [   48.238972]  ? finish_task_switch.isra.0+0x81/0x260
> [   48.239290]  ? kthreads_online_cpu+0x110/0x110
> [   48.239598]  ? kthreads_online_cpu+0x110/0x110
> [   48.239899]  ret_from_fork+0x13b/0x170
> [   48.240155]  ? kthreads_online_cpu+0x110/0x110
> [   48.240434]  ret_from_fork_asm+0x11/0x20
> [   48.240711]  </TASK>
> [   48.240864] ---[ end trace 0000000000000000 ]---
> 
> The trace show that it's caused by a double free of the same iopf group :
> 
> irq/24-d-66        2..... : iommu_report_device_fault <-prq_event_thread
> irq/24-d-66        2..... : iopf_get_dev_fault_param.isra.0 <-iommu_report_device_fault
> irq/24-d-66        2..... : iopf_group_alloc <-iommu_report_device_fault
> irq/24-d-66        2..... : iommu_sva_iopf_handler <-iommu_report_device_fault
>      test-1633      0..... : iommu_sva_unbind_device <-test_handle.isra.0
>      test-1633      0..... : iommu_detach_device_pasid <-iommu_sva_unbind_device
>      test-1633      0..... : iopf_queue_remove_device <-blocking_domain_set_dev_pasid
>      test-1633      0..... : iopf_free_group <-iopf_queue_remove_device
>      test-1633      0..... : iopf_put_dev_fault_param <-iopf_free_group
>      test-1633      0..... : iopf_put_dev_fault_param <-iopf_queue_remove_device
>      test-1633      0..... : iommu_domain_free <-iommu_sva_unbind_device
> kworker/-313       3..... : iommu_sva_handle_iopf <-process_one_work
> kworker/-313       3..... : iopf_group_response <-iommu_sva_handle_iopf
> kworker/-313       3..... : iopf_free_group <-process_one_work
> kworker/-313       3..... : iopf_put_dev_fault_param <-iopf_free_group
> 
> Unbinding a device while page requests are still in flight is likely an edge
> case that shouldn't occur, but investigating it has led me to two questions:
> 
> 1. The issue appear at the commit 17fce9d2336d ("iommu/vt-d: Put iopf
> enablement in domain attach path"), where device are now dynamically added and
> removed from the iopf queue. This commit add a call to the new
> iopf_for_domain_remove() function when removing pasid :
> 
>> @@ -4041,6 +4053,7 @@ static int blocking_domain_set_dev_pasid(struct iommu_domain *domain,
>>   {
>>          struct device_domain_info *info = dev_iommu_priv_get(dev);
>>
>> +       iopf_for_domain_remove(old, dev);
>>          intel_pasid_tear_down_entry(info->iommu, dev, pasid, false);
>>          domain_remove_dev_pasid(old, dev, pasid);
>>
>>          return 0;
>>   }
> 
> Moving iopf_for_domain_remove() after domain_remove_dev_pasid() fix the issue
> above.

This probably is the right fix.

The iommu driver must ensure that all in-flight page faults have been
flushed before removing the device from the fault queue. Otherwise, a
race condition will occur between the SVA unbind path and the fault
handling path.

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index ddb981ad0e19..b1f2a2fb7e06 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4075,8 +4075,8 @@ static int blocking_domain_set_dev_pasid(struct 
iommu_domain *domain,
  {
         struct device_domain_info *info = dev_iommu_priv_get(dev);

-       iopf_for_domain_remove(old, dev);
         intel_pasid_tear_down_entry(info->iommu, dev, pasid, false);
+       iopf_for_domain_remove(old, dev);
         domain_remove_dev_pasid(old, dev, pasid);

         return 0;

The intel_pasid_tear_down_entry() function is responsible for blocking
hardware from generating new page faults and flushing all in-flight
ones. Therefore, moving iopf_for_domain_remove() after this function
should resolve this race condition.

Thanks,
baolu

> 
> Shouldn't iopf_for_domain_remove() be called after
> intel_pasid_tear_down_entry() or domain_remove_dev_pasid() to ensure the device
> can no longer send page requests and the queue has been flushed? Is the current
> ordering intentional?
> 
> 2. Regarding commit 9759ae2cee7c ("iommu: Fix potential memory leak in
> iopf_queue_remove_device()"): the commit frees the pending IOPF groups, but in
> the scenario above, direct references to the groups still exists either in the
> handler or in the workqueue awaiting processing, leading to a double free.
> Reverting this commit fix the issue above.
> 
> I am not sure to see where is the potential memory leak, is there a case where
> a reference to a group exists only in the iommu_fault_param::faults that I'm
> missing?
> 
> Thanks,
> Ethan

