Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB78723B627;
	Fri, 14 Nov 2025 14:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763129576; cv=none; b=pcKjUit926oC7DhuhBEDwWcoA/c4XcgB6LkYqN+qJ6WE8XhtZ0rWtiELuoqCh8HBsAkTxKREWLz4VrdnTzPf2ocYDgok+neTzGBJsdqSuMdYq2D11gqZCpOC8ryxtlfJMkEV7ylCBKYr0lIxjSsN5VXJdaogqoMaDaSCDfNkyas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763129576; c=relaxed/simple;
	bh=E1D9hm5bO8N8kbex64sVlG1YZDBmIdI/KickLssrJGk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GqXOEiIuwuPmnM+wk9d4D6v3YHypGEw0+2VRzvNWzRowXglxAxWhqQhsvh00fBnOPxIxP2e6afI7q2TKzJu0a6EsUqo4bZZvQbZHDYtigv2UbA7eJYmt8LDBRmEK2Dlc5vpm1ck88OHpUXC9axmHc1IbAvx6H6Y6xnoCaHvSD4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HL3ellPq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HL3ellPq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0327C4CEF5;
	Fri, 14 Nov 2025 14:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763129576;
	bh=E1D9hm5bO8N8kbex64sVlG1YZDBmIdI/KickLssrJGk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HL3ellPqvQsBNvvHF7IfDNJxNlTHpagm2GH2q4/uTD6uW07e47h8hLfW0VNvqbPL3
	 3dYBCW794fUe+xZ1IKDkW7oplRi2C0dWN9ExALHmbsfWylW1PpL1NdvszGUV3RDM+p
	 FXxjC/gZyrlLC6ocgA9qv1JL43wNM8BxWcnEGwRqipEswsr77gmsfoKSxS9aBNIhre
	 kf9mXiCiJoJ64HDoEledkzmn+evWkK4Xu1jOHqxZFeGey7W15B1qkVNHK6boV+F+kw
	 QHX+yhxQUMpopYeBrp41cKDt0ozeKKYDw2y2Lwkr++ATV9CzfNCPdHZxytH+J8mrx7
	 d3aog2aSpyXZA==
Date: Fri, 14 Nov 2025 14:12:50 +0000
From: Will Deacon <will@kernel.org>
To: Wang Wensheng <wangwensheng4@huawei.com>
Cc: robin.murphy@arm.com, joro@8bytes.org, jgg@ziepe.ca,
	nicolinc@nvidia.com, kevin.tian@intel.com, praan@google.com,
	baolu.lu@linux.intel.com, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	chenjun102@huawei.com
Subject: Re: [RFC PATCH] iommu/arm-smmu-v3: Defer shutdown to syscore_ops
Message-ID: <aRc44pvWsWdmNnQx@willie-the-truck>
References: <20251013063529.108949-1-wangwensheng4@huawei.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251013063529.108949-1-wangwensheng4@huawei.com>

On Mon, Oct 13, 2025 at 02:35:29PM +0800, Wang Wensheng wrote:
> We meet several softlockup while shutdown or reboot the system. The
> kernel log is here:
> 
> [  126.487508] arm-smmu-v3 a8000000.camera_smmu_controller0: CMD_SYNC timeout at 0x000001a3 [hwprod 0x000001a4, hwcons 0x00000016]
> [  126.487675] (4375,3191)[drv_camera][hicam_buf] isp_smmu_cleanup_iova_dom cluster_id=0 unmap, key=0x0000000000000000, iova=0x0000000000000000, size=49152
> [  127.300458] rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
> [  127.300464] rcu: 	3-...0: (8 ticks this GP) idle=086/1/0x4000000000000000 softirq=25646/25646 fqs=2475
> [  127.300466] rcu: 	(detected by 0, t=5252 jiffies, g=30897, q=752)
> [  127.300470] Sending NMI from CPU 0 to CPUs 3:
> [  127.556735] arm-smmu-v3 a8000000.camera_smmu_controller0: CMD_SYNC timeout at 0x000001b0 [hwprod 0x000001b1, hwcons 0x00000016]
> [  127.556966] (4375,3191)[drv_camera][hicam_buf] isp_smmu_cleanup_iova_dom cluster_id=0 unmap, key=0x0000000000000000, iova=0x0000000000000000, size=49152
> [  128.626066] arm-smmu-v3 a8000000.camera_smmu_controller0: CMD_SYNC timeout at 0x000001bd [hwprod 0x000001be, hwcons 0x00000016]
> [  128.626232] (4375,3191)[drv_camera][hicam_buf] isp_smmu_cleanup_iova_dom cluster_id=0 unmap, key=0x0000000000000000, iova=0x0000000000000000, size=49152
> ...
> [  132.903350] watchdog: BUG: soft lockup - CPU#7 stuck for 23s! [dds_discovery:3191]
> ...
> [  132.903564] Call trace:
> [  132.903566]  arm_smmu_cmdq_issue_cmdlist+0x560/0x6c8
> [  132.903568]  __arm_smmu_tlb_inv_range.isra.41+0x160/0x20c
> [  132.903570]  arm_smmu_tlb_inv_range_domain+0x90/0x164
> [  132.903572]  arm_smmu_iotlb_sync+0x3c/0x50
> [  132.903576]  iommu_unmap+0x88/0xc0
> [  132.903589]  isp_smmu_do_iommu_unmap.isra.6+0x5c/0x128 [drv_hicam_buf]
> [  132.903594]  isp_smmu_unmap_iova+0x128/0x2f4 [drv_hicam_buf]
> [  132.903598]  isp_smmu_cleanup_iova_dom+0xf0/0x1c8 [drv_hicam_buf]
> [  132.903602]  hicambuf_check_and_ummap_remain_buffer+0x90/0xa0 [drv_hicam_buf]
> [  132.903609]  himdcisp_release+0x1d0/0x228 [drv_himdcisp]
> [  132.903615]  __fput+0xa4/0x2cc
> [  132.903617]  ____fput+0x20/0x30
> [  132.903620]  task_work_run+0x120/0x198
> [  132.903623]  do_exit+0x444/0xd20
> [  132.903625]  do_group_exit+0x40/0x140
> [  132.903628]  get_signal+0x21c/0xab0
> [  132.903630]  do_notify_resume+0x380/0x4a8
> 
> The direct reason for this softlockup is that the driver want to access
> the smmu device after it has been shutdown. Here the driver call the
> iommu_unmap() a few times and get CMD_SYNC timeout, cost one second a
> time, then the cpu where the driver runs on get stuck. There is another
> case where a process that was bound to several smmu devices is exiting,
> then the process would access the smmu devices through mmu_notifer
> callbacks and get the similar stuck.
> 
> [   93.161307] Call trace:
> [   93.161309]  arm_smmu_cmdq_issue_cmdlist+0x58c/0x948
> [   93.161313]  __arm_smmu_cmdq_issue_cmd+0x60/0xb0
> [   93.161316]  arm_smmu_tlb_inv_asid+0x6c/0x98
> [   93.161321]  arm_smmu_mm_release+0x70/0xd4
> [   93.161325]  __mmu_notifier_release+0x88/0x268
> [   93.161332]  exit_mmap+0x374/0x4b4
> [   93.161339]  mmput+0x7c/0x1c4
> [   93.161346]  xsmem_release+0x6a8/0x91c [xsmem]
> [   93.161364]  __fput+0x21c/0x340
> [   93.161369]  ____fput+0x20/0x30
> [   93.161371]  task_work_run+0x104/0x1a0
> [   93.161377]  do_exit+0x4c0/0xe60
> [   93.161382]  do_group_exit+0x38/0x138
> 
> Normally the reboot/shutdown command would kill all the process before
> calling into kernel. But the user process may not exit in time, so the
> process could run on the reboot_cpu while the reboot/shutdown command
> running on another cpu run into kernel and shutdown smmu devices. Then
> the process runs on the reboot_cpu would get stcuk and block the
> reboot/shutdown command in migrate_to_reboot_cpu(). Move the shutdown
> for smmu to syscore_ops to solve the issue. Because syscore_ops
> would be called after migrate_to_reboot_cpu() and even another process
> would access smmu device in other cpus after smmu shutdown, it cannot
> block the reboot process.
> 
> Signed-off-by: Wang Wensheng <wangwensheng4@huawei.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 39 ++++++++++++++++-----
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  2 ++

It looks to me like devices are shutdown in the reverse order from which
they probed (modulo adjustments to device links). So in this case, I
would expect the probe-deferrals from dma_configure() to ensure that
the IOMMU is only shutdown after its clients. If you're using the IOMMU
API directly then you'll need to find some other way to ensure this
ordering.

In any case, it looks like you're using some out-of-tree drivers and
we shouldn't be hacking around this in the SMMUv3 driver.

Will
