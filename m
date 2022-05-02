Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33038C433EF
	for <iommu@archiver.kernel.org>; Mon,  2 May 2022 16:12:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B922460F24;
	Mon,  2 May 2022 16:12:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id I9AX5eUUlex3; Mon,  2 May 2022 16:12:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id B1FE660F26;
	Mon,  2 May 2022 16:12:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4B594C0039;
	Mon,  2 May 2022 16:12:11 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9C7D3C002D
 for <iommu@lists.linux-foundation.org>; Mon,  2 May 2022 16:12:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8476B81762
 for <iommu@lists.linux-foundation.org>; Mon,  2 May 2022 16:12:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=quicinc.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IVSXRDK4lTpq for <iommu@lists.linux-foundation.org>;
 Mon,  2 May 2022 16:12:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com
 [199.106.114.38])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A40248145A
 for <iommu@lists.linux-foundation.org>; Mon,  2 May 2022 16:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1651507929; x=1683043929;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=oqVfvIwO+ekNl8VYKW8L9XfK9KFqSFa9jxkzZ+Hsbz0=;
 b=WxZt7vBG4YtmJiemM8pi0c91UDiuRW5FovSCtSyIPFk3tz7k47frvEEf
 o9e7JqWDDZRvXI3oiR8JSjCyC+CXcFr3SZKy48xlw2N+3LSUrqcaMa9iD
 Ch8LNYTNNyTKXPrZuPSbF233YCnhZkipTlbJFdXfXiZO6NckWhnt9s8IS 4=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
 by alexa-out-sd-01.qualcomm.com with ESMTP; 02 May 2022 09:12:08 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
 by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 May 2022 09:12:08 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 2 May 2022 09:12:07 -0700
Received: from qian (10.80.80.8) by nalasex01a.na.qualcomm.com (10.47.209.196)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 2 May 2022
 09:12:06 -0700
Date: Mon, 2 May 2022 12:12:04 -0400
From: Qian Cai <quic_qiancai@quicinc.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [RESEND PATCH v8 00/11] Fix BUG_ON in vfio_iommu_group_notifier()
Message-ID: <20220502161204.GA22@qian>
References: <20220418005000.897664-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220418005000.897664-1-baolu.lu@linux.intel.com>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Cc: Kevin Tian <kevin.tian@intel.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Jason Gunthorpe <jgg@nvidia.com>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Mon, Apr 18, 2022 at 08:49:49AM +0800, Lu Baolu wrote:
> Hi Joerg,
> 
> This is a resend version of v8 posted here:
> https://lore.kernel.org/linux-iommu/20220308054421.847385-1-baolu.lu@linux.intel.com/
> as we discussed in this thread:
> https://lore.kernel.org/linux-iommu/Yk%2Fq1BGN8pC5HVZp@8bytes.org/
> 
> All patches can be applied perfectly except this one:
>  - [PATCH v8 02/11] driver core: Add dma_cleanup callback in bus_type
> It conflicts with below refactoring commit:
>  - 4b775aaf1ea99 "driver core: Refactor sysfs and drv/bus remove hooks"
> The conflict has been fixed in this post.
> 
> No functional changes in this series. I suppress cc-ing this series to
> all v8 reviewers in order to avoid spam.
> 
> Please consider it for your iommu tree.

Reverting this series fixed an user-after-free while doing SR-IOV.

 BUG: KASAN: use-after-free in __lock_acquire
 Read of size 8 at addr ffff080279825d78 by task qemu-system-aar/22429
 CPU: 24 PID: 22429 Comm: qemu-system-aar Not tainted 5.18.0-rc5-next-20220502 #69
 Call trace:
  dump_backtrace
  show_stack
  dump_stack_lvl
  print_address_description.constprop.0
  print_report
  kasan_report
  __asan_report_load8_noabort
  __lock_acquire
  lock_acquire.part.0
  lock_acquire
  _raw_spin_lock_irqsave
  arm_smmu_detach_dev
  arm_smmu_detach_dev at drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c:2377
  arm_smmu_attach_dev
  __iommu_attach_group
  __iommu_attach_device at drivers/iommu/iommu.c:1942
  (inlined by) iommu_group_do_attach_device at drivers/iommu/iommu.c:2058
  (inlined by) __iommu_group_for_each_dev at drivers/iommu/iommu.c:989
  (inlined by) __iommu_attach_group at drivers/iommu/iommu.c:2069
  iommu_group_release_dma_owner
  __vfio_group_unset_container
  vfio_group_try_dissolve_container
  vfio_group_put_external_user
  kvm_vfio_destroy
  kvm_destroy_vm
  kvm_vm_release
  __fput
  ____fput
  task_work_run
  do_exit
  do_group_exit
  get_signal
  do_signal
  do_notify_resume
  el0_svc
  el0t_64_sync_handler
  el0t_64_sync

 Allocated by task 22427:
  kasan_save_stack
  __kasan_kmalloc
  kmem_cache_alloc_trace
  arm_smmu_domain_alloc
  iommu_domain_alloc
  vfio_iommu_type1_attach_group
  vfio_ioctl_set_iommu
  vfio_fops_unl_ioctl
  __arm64_sys_ioctl
  invoke_syscall
  el0_svc_common.constprop.0
  do_el0_svc
  el0_svc
  el0t_64_sync_handler
  el0t_64_sync

 Freed by task 22429:
  kasan_save_stack
  kasan_set_track
  kasan_set_free_info
  ____kasan_slab_free
  __kasan_slab_free
  slab_free_freelist_hook
  kfree
  arm_smmu_domain_free
  arm_smmu_domain_free at iommu/arm/arm-smmu-v3/arm-smmu-v3.c:2067
  iommu_domain_free
  vfio_iommu_type1_detach_group
  __vfio_group_unset_container
  vfio_group_try_dissolve_container
  vfio_group_put_external_user
  kvm_vfio_destroy
  kvm_destroy_vm
  kvm_vm_release
  __fput
  ____fput
  task_work_run
  do_exit
  do_group_exit
  get_signal
  do_signal
  do_notify_resume
  el0_svc
  el0t_64_sync_handler
  el0t_64_sync
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
