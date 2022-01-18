Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B3A0C433F5
	for <iommu@archiver.kernel.org>; Tue, 18 Jan 2022 13:49:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 01F4340951;
	Tue, 18 Jan 2022 13:49:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id S6xQsX0VG_FQ; Tue, 18 Jan 2022 13:49:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id BDBF14092F;
	Tue, 18 Jan 2022 13:49:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9D957C0031;
	Tue, 18 Jan 2022 13:49:44 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 45955C002F
 for <iommu@lists.linux-foundation.org>; Tue, 18 Jan 2022 13:49:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3378160C17
 for <iommu@lists.linux-foundation.org>; Tue, 18 Jan 2022 13:49:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gyRbN91-gAJk for <iommu@lists.linux-foundation.org>;
 Tue, 18 Jan 2022 13:49:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0939A60A84
 for <iommu@lists.linux-foundation.org>; Tue, 18 Jan 2022 13:49:42 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0EAE11FB;
 Tue, 18 Jan 2022 05:49:42 -0800 (PST)
Received: from [10.57.67.190] (unknown [10.57.67.190])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E25EB3F766;
 Tue, 18 Jan 2022 05:49:40 -0800 (PST)
Message-ID: <9913d026-fddd-c188-0873-0f7a66fb2c3c@arm.com>
Date: Tue, 18 Jan 2022 13:49:36 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3] iommu: Fix potential use-after-free during probe
Content-Language: en-GB
To: Vijayanand Jitta <quic_vjitta@quicinc.com>, joro@8bytes.org,
 will@kernel.org, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org
References: <1641993184-1232-1-git-send-email-quic_vjitta@quicinc.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <1641993184-1232-1-git-send-email-quic_vjitta@quicinc.com>
Cc: vjitta@codeaurora.org, kernel-team@android.com
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 2022-01-12 13:13, Vijayanand Jitta wrote:
> Kasan has reported the following use after free on dev->iommu.
> when a device probe fails and it is in process of freeing dev->iommu
> in dev_iommu_free function, a deferred_probe_work_func runs in parallel
> and tries to access dev->iommu->fwspec in of_iommu_configure path thus
> causing use after free.
> 
> BUG: KASAN: use-after-free in of_iommu_configure+0xb4/0x4a4
> Read of size 8 at addr ffffff87a2f1acb8 by task kworker/u16:2/153
> 
> Workqueue: events_unbound deferred_probe_work_func
> Call trace:
>   dump_backtrace+0x0/0x33c
>   show_stack+0x18/0x24
>   dump_stack_lvl+0x16c/0x1e0
>   print_address_description+0x84/0x39c
>   __kasan_report+0x184/0x308
>   kasan_report+0x50/0x78
>   __asan_load8+0xc0/0xc4
>   of_iommu_configure+0xb4/0x4a4
>   of_dma_configure_id+0x2fc/0x4d4
>   platform_dma_configure+0x40/0x5c
>   really_probe+0x1b4/0xb74
>   driver_probe_device+0x11c/0x228
>   __device_attach_driver+0x14c/0x304
>   bus_for_each_drv+0x124/0x1b0
>   __device_attach+0x25c/0x334
>   device_initial_probe+0x24/0x34
>   bus_probe_device+0x78/0x134
>   deferred_probe_work_func+0x130/0x1a8
>   process_one_work+0x4c8/0x970
>   worker_thread+0x5c8/0xaec
>   kthread+0x1f8/0x220
>   ret_from_fork+0x10/0x18
> 
> Allocated by task 1:
>   ____kasan_kmalloc+0xd4/0x114
>   __kasan_kmalloc+0x10/0x1c
>   kmem_cache_alloc_trace+0xe4/0x3d4
>   __iommu_probe_device+0x90/0x394
>   probe_iommu_group+0x70/0x9c
>   bus_for_each_dev+0x11c/0x19c
>   bus_iommu_probe+0xb8/0x7d4
>   bus_set_iommu+0xcc/0x13c
>   arm_smmu_bus_init+0x44/0x130 [arm_smmu]
>   arm_smmu_device_probe+0xb88/0xc54 [arm_smmu]
>   platform_drv_probe+0xe4/0x13c
>   really_probe+0x2c8/0xb74
>   driver_probe_device+0x11c/0x228
>   device_driver_attach+0xf0/0x16c
>   __driver_attach+0x80/0x320
>   bus_for_each_dev+0x11c/0x19c
>   driver_attach+0x38/0x48
>   bus_add_driver+0x1dc/0x3a4
>   driver_register+0x18c/0x244
>   __platform_driver_register+0x88/0x9c
>   init_module+0x64/0xff4 [arm_smmu]
>   do_one_initcall+0x17c/0x2f0
>   do_init_module+0xe8/0x378
>   load_module+0x3f80/0x4a40
>   __se_sys_finit_module+0x1a0/0x1e4
>   __arm64_sys_finit_module+0x44/0x58
>   el0_svc_common+0x100/0x264
>   do_el0_svc+0x38/0xa4
>   el0_svc+0x20/0x30
>   el0_sync_handler+0x68/0xac
>   el0_sync+0x160/0x180
> 
> Freed by task 1:
>   kasan_set_track+0x4c/0x84
>   kasan_set_free_info+0x28/0x4c
>   ____kasan_slab_free+0x120/0x15c
>   __kasan_slab_free+0x18/0x28
>   slab_free_freelist_hook+0x204/0x2fc
>   kfree+0xfc/0x3a4
>   __iommu_probe_device+0x284/0x394
>   probe_iommu_group+0x70/0x9c
>   bus_for_each_dev+0x11c/0x19c
>   bus_iommu_probe+0xb8/0x7d4
>   bus_set_iommu+0xcc/0x13c
>   arm_smmu_bus_init+0x44/0x130 [arm_smmu]
>   arm_smmu_device_probe+0xb88/0xc54 [arm_smmu]
>   platform_drv_probe+0xe4/0x13c
>   really_probe+0x2c8/0xb74
>   driver_probe_device+0x11c/0x228
>   device_driver_attach+0xf0/0x16c
>   __driver_attach+0x80/0x320
>   bus_for_each_dev+0x11c/0x19c
>   driver_attach+0x38/0x48
>   bus_add_driver+0x1dc/0x3a4
>   driver_register+0x18c/0x244
>   __platform_driver_register+0x88/0x9c
>   init_module+0x64/0xff4 [arm_smmu]
>   do_one_initcall+0x17c/0x2f0
>   do_init_module+0xe8/0x378
>   load_module+0x3f80/0x4a40
>   __se_sys_finit_module+0x1a0/0x1e4
>   __arm64_sys_finit_module+0x44/0x58
>   el0_svc_common+0x100/0x264
>   do_el0_svc+0x38/0xa4
>   el0_svc+0x20/0x30
>   el0_sync_handler+0x68/0xac
>   el0_sync+0x160/0x180
> 
> Fix this by taking device_lock during probe_iommu_group.
> 
> Signed-off-by: Vijayanand Jitta <quic_vjitta@quicinc.com>
> ---
>   drivers/iommu/iommu.c | 12 ++++++++----
>   1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index dd7863e..261792d 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -1617,7 +1617,7 @@ static int probe_iommu_group(struct device *dev, void *data)
>   {
>   	struct list_head *group_list = data;
>   	struct iommu_group *group;
> -	int ret;
> +	int ret = 0;
>   
>   	/* Device is probed already if in a group */
>   	group = iommu_group_get(dev);
> @@ -1626,9 +1626,13 @@ static int probe_iommu_group(struct device *dev, void *data)
>   		return 0;
>   	}
>   
> -	ret = __iommu_probe_device(dev, group_list);
> -	if (ret == -ENODEV)
> -		ret = 0;
> +	ret = device_trylock(dev);
> +	if (ret) {

This doesn't seem right - we can't have a non-deterministic situation 
where __iommu_probe_device() may or may not be called depending on what 
anyone else might be doing with the device at the same time.

I don't fully understand how __iommu_probe_device() and 
of_iommu_configure() can be running for the same device at the same 
time, but if that's not a race which can be fixed in its own right, then 
I think adding a refcount to dev_iommu would be a more sensible way to 
mitigate it.

Robin.

> +		ret = __iommu_probe_device(dev, group_list);
> +		if (ret == -ENODEV)
> +			ret = 0;
> +		device_unlock(dev);
> +	}
>   
>   	return ret;
>   }
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
