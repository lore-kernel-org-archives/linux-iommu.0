Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2E0A2F2A
	for <iommu@lists.linux.dev>; Fri, 13 Jan 2023 16:15:26 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3BBFAFEC;
	Fri, 13 Jan 2023 08:16:08 -0800 (PST)
Received: from [10.57.76.81] (unknown [10.57.76.81])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0D9153F67D;
	Fri, 13 Jan 2023 08:15:24 -0800 (PST)
Message-ID: <700deece-41bd-a10f-2be8-a0f30fe1a4eb@arm.com>
Date: Fri, 13 Jan 2023 16:15:15 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 3/3] iommu/amd: Call BUG_ON in page fault hanlder path if
 domain is NULL
Content-Language: en-GB
To: Vasant Hegde <vasant.hegde@amd.com>, iommu@lists.linux.dev,
 joro@8bytes.org
Cc: will@kernel.org, suravee.suthikulpanit@amd.com,
 Matt Fagnani <matt.fagnani@bell.net>
References: <20230113135956.5788-1-vasant.hegde@amd.com>
 <20230113135956.5788-3-vasant.hegde@amd.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20230113135956.5788-3-vasant.hegde@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023-01-13 13:59, Vasant Hegde wrote:
> If IOMMU domain for device group is not setup properly then we may hit
> IOMMU page fault. Current page fault handler assumes that domain is
> always setup and it will hit NULL pointer dereference (see below sample log).
> 
> This is mostly programming error and difficult to recover from here. Hence
> call BUG_ON().

Is it particularly difficult to skip calling report_iommu_fault()? 
Certainly it didn't seem much of a challenge in 00ef8885a945 
("iommu/mediatek: Fix crash on isr after kexec()"), for example.

Otherwise, even disregarding [1], a BUG_ON() for a condition that's 
guaranteed to crash right there anyway doesn't seem particularly 
valuable. The fact that it crashes already pretty conclusively documents 
the fact that it wasn't expected. report_iommu_fault() is not a big 
complex function, with only one possible callsite related to 
amd_iommu_int_thread(), so even with amd_iommu_report_page_fault() 
inlined I'd hope the stacktrace as below is sufficiently obvious even 
without logging an explicit line number.

Thanks,
Robin.

[1] 
https://www.kernel.org/doc/html/latest/process/deprecated.html#bug-and-bug-on

> 
> Sample log:
> ----------
> Jan 06 02:07:52 kernel: amdgpu 0000:00:01.0: amdgpu: SE 1, SH per SE 1, CU per SH 8, active_cu_number 6
> Jan 06 02:07:52 kernel: BUG: kernel NULL pointer dereference, address: 0000000000000058
> Jan 06 02:07:52 kernel: #PF: supervisor read access in kernel mode
> Jan 06 02:07:53 kernel: #PF: error_code(0x0000) - not-present page
> Jan 06 02:07:53 kernel: PGD 0 P4D 0
> Jan 06 02:07:53 kernel: Oops: 0000 [#1] PREEMPT SMP NOPTI
> Jan 06 02:07:53 kernel: CPU: 2 PID: 56 Comm: irq/24-AMD-Vi Not tainted 6.2.0-rc2+ #89
> Jan 06 02:07:53 kernel: Hardware name: xxx
> Jan 06 02:07:53 kernel: RIP: 0010:report_iommu_fault+0x11/0x90
> Jan 06 02:07:53 kernel: Code: 0f 0b eb cd 0f 1f 44 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 0f 1f 44 00 00 41 55 41 54 41 89 cc 55 48 89 d5 53 <48> 8b 47 48 48 89 f3 48 85 c0 74 64 4c 8b 47 50 e8 ea e8 4a 00 41
> Jan 06 02:07:53 kernel: RSP: 0018:ffffb9b7803ebe08 EFLAGS: 00010246
> Jan 06 02:07:53 kernel: RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
> Jan 06 02:07:53 kernel: RDX: 00000001522e2500 RSI: ffff940cc09e30d0 RDI: 0000000000000010
> Jan 06 02:07:53 kernel: RBP: 00000001522e2500 R08: ffff940cc12c2b00 R09: 0000000000000050
> Jan 06 02:07:53 kernel: R10: ffff940cc021e000 R11: 0000000000000000 R12: 0000000000000000
> Jan 06 02:07:53 kernel: R13: ffff940cc005b000 R14: 0000000000000008 R15: 0000000000000000
> Jan 06 02:07:53 kernel: FS:  0000000000000000(0000) GS:ffff940db7500000(0000) knlGS:0000000000000000
> Jan 06 02:07:53 kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> Jan 06 02:07:53 kernel: CR2: 0000000000000058 CR3: 000000010230a000 CR4: 00000000001506e0
> Jan 06 02:07:53 kernel: Call Trace:
> Jan 06 02:07:53 kernel:  <TASK>
> Jan 06 02:07:53 kernel:  amd_iommu_int_thread+0x60c/0x760
> Jan 06 02:07:53 kernel:  ? __pfx_irq_thread_fn+0x10/0x10
> Jan 06 02:07:53 kernel:  irq_thread_fn+0x1f/0x60
> Jan 06 02:07:53 kernel:  irq_thread+0xea/0x1a0
> Jan 06 02:07:53 kernel:  ? preempt_count_add+0x6a/0xa0
> Jan 06 02:07:53 kernel:  ? __pfx_irq_thread_dtor+0x10/0x10
> Jan 06 02:07:53 kernel:  ? __pfx_irq_thread+0x10/0x10
> Jan 06 02:07:53 kernel:  kthread+0xe9/0x110
> Jan 06 02:07:53 kernel:  ? __pfx_kthread+0x10/0x10
> Jan 06 02:07:53 kernel:  ret_from_fork+0x2c/0x50
> Jan 06 02:07:53 kernel:  </TASK>
> 
> Reported-by: Matt Fagnani <matt.fagnani@bell.net>
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> ---
>   drivers/iommu/amd/iommu.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index 26c96b821fa2..2421acba08c7 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -558,6 +558,9 @@ static void amd_iommu_report_page_fault(struct amd_iommu *iommu,
>   		 * prevent logging it.
>   		 */
>   		if (IS_IOMMU_MEM_TRANSACTION(flags)) {
> +			/* Device not attached to domain properly */
> +			BUG_ON(dev_data->domain == NULL);
> +
>   			if (!report_iommu_fault(&dev_data->domain->domain,
>   						&pdev->dev, address,
>   						IS_WRITE_REQUEST(flags) ?
