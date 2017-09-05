From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: Re: [RFC PATCH 5/6] iommu/arm-smmu-v3: fix panic when handle stall
 mode irq
Date: Tue, 5 Sep 2017 13:53:53 +0100
Message-ID: <50b249e6-8224-26fe-364f-c63b78601c6f@arm.com>
References: <1504167642-14922-1-git-send-email-xieyisheng1@huawei.com>
 <1504167642-14922-6-git-send-email-xieyisheng1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1504167642-14922-6-git-send-email-xieyisheng1@huawei.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
To: Yisheng Xie <xieyisheng1@huawei.com>
Cc: joro@8bytes.org, robh+dt@kernel.org, mark.rutland@arm.com, lorenzo.pieralisi@arm.com, hanjun.guo@linaro.org, sudeep.holla@arm.com, rjw@rjwysocki.net, lenb@kernel.org, will.deacon@arm.com, robin.murphy@arm.com, robert.moore@intel.com, lv.zheng@intel.com, iommu@lists.linux-foundation.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devel@acpica.org, liubo95@huawei.com, chenjiankang1@huawei.com, xieyisheng@huawei.com
List-Id: iommu@lists.linux-foundation.org

On 31/08/17 09:20, Yisheng Xie wrote:
> When SMMU do not support SVM feature, however the master support SVM,
> which means matser can stall and with mult-pasid number, then the user
> can bind a task to device using API like iommu_bind_task(). however,
> when device trigger a stall mode fault i will cause panic:
> 
> [  106.996087] Unable to handle kernel NULL pointer dereference at virtual address 00000100
> [  106.996122] user pgtable: 4k pages, 48-bit VAs, pgd = ffff80003e023000
> [  106.996150] [0000000000000100] *pgd=000000003e04a003, *pud=000000003e04b003, *pmd=0000000000000000
> [  106.996201] Internal error: Oops: 96000006 [#1] PREEMPT SM
> [  106.996224] Modules linked in:
> [  106.996256] CPU: 0 PID: 916 Comm: irq/14-arm-smmu Not tainted 4.13.0-rc5-00035-g1235ddd-dirty #67
> [  106.996288] Hardware name: Hisilicon PhosphorHi1383 ESL (DT)
> [  106.996317] task: ffff80003adc1c00 task.stack: ffff80003a9f8000
> [  106.996347] PC is at __queue_work+0x30/0x3a8
> [  106.996374] LR is at queue_work_on+0x60/0x78
> [  106.996401] pc : [<ffff0000080d7d10>] lr : [<ffff0000080d80e8>] pstate: 40c001c9
> [  106.996430] sp : ffff80003a9fbc20
> [  106.996451] x29: ffff80003a9fbc20 x28: ffff80003adc1c00
> [  106.996488] x27: ffff000008d05080 x26: ffff80003ab0e028
> [  106.996526] x25: ffff80003a9900ac x24: 0000000000000001
> [  106.996562] x23: 0000000000000040 x22: 0000000000000000
> [  106.996598] x21: 0000000000000000 x20: 0000000000000140
> [  106.996634] x19: ffff80003ab0e028 x18: 0000000000000010
> [  106.996670] x17: 0000ffffa52a5040 x16: ffff00000820f260
> [  106.996708] x15: 00000018e97629e0 x14: ffff80003fb89468
> [  106.996744] x13: 0000000000000000 x12: ffff80003abb0600
> [  106.996781] x11: 0000000000000000 x10: 0000010100000100
> [  106.996817] x9 : 0000ffff85de5010 x8 : 00000000e4830001
> [  106.996854] x7 : ffff80003a9fbcf8 x6 : 0000000fffffffe0
> [  106.996890] x5 : 0000000000000000 x4 : 0000000000000001
> [  106.996926] x3 : 0000000000000000 x2 : ffff80003ab0e028
> [  106.996962] x1 : 0000000000000000 x0 : 00000000000001c0
> [  106.997002] Process irq/14-arm-smmu (pid: 916, stack limit =0xffff80003a9f8000)
> [  106.997035] Stack: (0xffff80003a9fbc20 to 0xffff80003a9fc000)
> [...]
> [  106.998366] Call trace:
> [  106.998842] [<ffff0000080d7d10>] __queue_work+0x30/0x3a8
> [  106.998874] [<ffff0000080d80e8>] queue_work_on+0x60/0x78
> [  106.998912] [<ffff00000857aae4>] arm_smmu_handle_stall+0x104/0x138
> [  106.998952] [<ffff00000857b150>] arm_smmu_evtq_thread+0xc0/0x158
> [  106.998989] [<ffff000008112128>] irq_thread_fn+0x28/0x68
> [  106.999025] [<ffff0000081123e0>] irq_thread+0x128/0x1d0
> [  106.999060] [<ffff0000080df6bc>] kthread+0xfc/0x128
> [  106.999093] [<ffff000008082ec0>] ret_from_fork+0x10/0x50
> [  106.999130] Code: a90153f3 a90573fb d53b4220 363814c0 (b94102a0)
> [  106.999159] ---[ end trace 7e5c9f0cb1f2fecd ]---
> 
> And the resean is we donot init fault_queue while the fault handle need
> to use it. 
>
> Fix by return -EINVAL in arm_smmu_bind_task() when smmu do not
> support the feature of SVM.
> 
> Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
> ---
>  drivers/iommu/arm-smmu-v3.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index d44256a..dbda2eb 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -2922,6 +2922,8 @@ static int arm_smmu_bind_task(struct device *dev, struct task_struct *task,
>  		return -EINVAL;
>  
>  	smmu = master->smmu;
> +	if (!(smmu->features & ARM_SMMU_FEAT_SVM))
> +		return -EINVAL;

FEAT_SVM is set when the SMMU supports the same page table format as the
MMU, it doesn't say anything about PRI/stall ability. To fix the above
splat we should either instantiate fault_queue even when !FEAT_SVM, or
avoid enabling master->can_fault and can_stall if !FEAT_SVM. I prefer the
latter.

Thanks,
Jean
