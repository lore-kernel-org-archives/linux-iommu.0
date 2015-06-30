From: George Wang <xuw2015-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: dma_ops_domain_alloc causes kernel 4.1.0-next-20150626+ panic
Date: Tue, 30 Jun 2015 11:55:24 +0800
Message-ID: <CAPBX1xLA_GDeoi9wq-9A7njwzL3NBqJYYT_PqhwEzBAg=9=8kA@mail.gmail.com>
References: <CAPBX1x+zagVVYebbXU0M7VkEaDkzvqBGnkt6PW_N42fRQRQ9Gg@mail.gmail.com>
	<20150629193402.GM18569@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20150629193402.GM18569-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Tue, Jun 30, 2015 at 3:34 AM, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org> wrote:
> On Tue, Jun 30, 2015 at 01:44:34AM +0800, George Wang wrote:
>> diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
>> index d3e5e9a..4f6da17 100644
>> --- a/drivers/iommu/amd_iommu.c
>> +++ b/drivers/iommu/amd_iommu.c
>> @@ -1882,6 +1882,7 @@ static struct dma_ops_domain *dma_ops_domain_alloc(void)
>>                 return NULL;
>>
>>         spin_lock_init(&dma_dom->domain.lock);
>> +       mutex_init(&dma_dom->domain.api_lock);
>>
>> When I initialize the api_lock, then I can go forward with another problem.
>
> How do you trigger this? The DMA-API domains are not used via the
> IOMMU-API yet, so the initializing the api-lock for it shouldn't matter.
>
>
>         Joerg
>

I don't know what triger it, I just build the kernel, install, and
panic. The call call trace is like below:

[   11.687392] BUG: unable to handle kernel NULL pointer dereference
at           (null)
[   11.690196] IP: [<ffffffff813326ef>] __list_add+0x1f/0xc0
[   11.692026] PGD 0
[   11.692794] Oops: 0000 [#1] SMP
[   11.693939] Modules linked in:
[   11.694997] CPU: 11 PID: 1 Comm: swapper/0 Not tainted
4.1.0-next-20150626+ #6
[   11.697415] Hardware name: HP ProLiant DL385p Gen8, BIOS A28 02/06/2014
[   11.699683] task: ffff880835888000 ti: ffff880236918000 task.ti:
ffff880236918000
[   11.702281] RIP: 0010:[<ffffffff813326ef>]  [<ffffffff813326ef>]
__list_add+0x1f/0xc0
[   11.704935] RSP: 0018:ffff88023691b968  EFLAGS: 00010246
[   11.706702] RAX: 00000000ffffffff RBX: ffff88023691b998 RCX: ffff880835888000
[   11.709199] RDX: ffff880634f58468 RSI: 0000000000000000 RDI: ffff88023691b998
[   11.711597] RBP: ffff88023691b988 R08: 0000000000000000 R09: ffff88023691bab8
[   11.714022] R10: 00000000000f0000 R11: ffff880000000000 R12: ffff880634f58468
[   11.716415] R13: 0000000000000000 R14: 00000000ffffffff R15: ffff880634f58468
[   11.718909] FS:  0000000000000000(0000) GS:ffff880637d40000(0000)
knlGS:0000000000000000
[   11.721575] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
[   11.723541] CR2: 0000000000000000 CR3: 00000000019d4000 CR4: 00000000000406e0
[   11.725960] Stack:
[   11.726632]  0000000000001000 ffff880634f58460 ffff880634f58464
ffff880835888000
[   11.729440]  ffff88023691b9e8 ffffffff8168fde1 ffff88023691b9f8
ffffffff81318798
[   11.732131]  000000000000a1ff 000000008d3d0bb4 00002fdd3691b9e8
ffff880634f58460
[   11.734774] Call Trace:
[   11.735635]  [<ffffffff8168fde1>] __mutex_lock_slowpath+0x91/0x120
[   11.737676]  [<ffffffff81318798>] ? ida_simple_get+0x98/0x100
[   11.739682]  [<ffffffff8168fe93>] mutex_lock+0x23/0x37
[   11.741407]  [<ffffffff8143513a>] amd_iommu_map+0x4a/0x1b0
[   11.743293]  [<ffffffff8143081a>] iommu_map+0xfa/0x200
[   11.745025]  [<ffffffff81431587>] iommu_group_add_device+0x327/0x390
[   11.747184]  [<ffffffff814316fb>] iommu_group_get_forv+0x10b/0x1f0
[   11.849564]  [<ffffffff81436ac6>] amd_iommu_add_device+0x1b6/0x580
[   11.851645]  [<ffffffff8168d891>] ? __schedule+0xe1/0x890
[   11.85350883]  [<ffffffff814304db>] add_iommu_group+0x2b/0x50
[   11.857765]  [<ffffffff8144b40c>] bus_for_each_dev+0x6c/0xc0
[   11.859752]  [<ffffffff814311b4>] ? bus_set_iommu+0x54/0x100
[   11.861698]  [<ffffffff8143121e>] bus_set_iommu+0xbe/0x100
[   11.863485]  [<ffffffff81b77e46>] amd_iommu_init_api+0x17/0x19
[   11.865473]  [<ffffffff81b7993c>] state_next+0x57e/0x715
[   11.867212]  [<ffffffff81b37eec>] ? memblock_find_dma_reserve+0x177/0x177
[   11.869577]  [<ffffffff81b79aed>] iommu_go_to_state+0x1a/0x2d
[   11.871577]  [<ffffffff81b79b72>] amd_iommu_init+0x15/0xfc
[   11.873425]  [<ffffffff81b37eff>] pci_iommu_init+0x13/0x3e
[   11.875259]  [<ffffffff8100213d>] do_one_initcall+0xcd/0x1f0
[   11.877162]  [<ffffffff81098d00>] ? parse_args+0x220/0x470
[   11.879122]  [<ffffffff810bd548>] ? __wake_up+0x48/0x60
[   11.880872]  [<ffffffff81b2e349>] kernel_inia5/0x249
[   12.282919]  [<ffffffff81b2d9dd>] ? initcall_blacklist+0xb6/0xb6
[   12.285018]  [<ffffffff8167b9a0>] ? rest_init+0x80/0x80
[   12.286803]  [<ffffffff8167b9ae>] kernel_init+0xe/0xe0
[   12.288621]  [<ffffffff81691f5f>] ret_from_fork+0x3f/0x70
[   12.290761]  [<ffffffff8167b9a0>] ? rest_init+0x80/0x80
[   12.292516] Code: ff ff ff e9 31 ff ff ff 0f 1f 40 00 55 48 89 e5
41 55 49 89 f5 41 54 49 89 d4 53 48 89 fb 48 83 ec 08 4c 8b 42 08 49
39 f0 75 2e <4d> 8b 45 00 4d 39 c4 75 6c 4c 39 e3 74 42 4c 39 eb 74 3d
49 89
[   12.301447] RIP  [<ffffffff813326ef>] __list_add+0x1f/0xc0
[   12.303331]  RSP <ffff88023691b968>
[   12.304516] CR2: 0000000000000000
[   12.305657] ---[ end trace 20a8e3deaab91b75 ]---

I think the the
add_iommu_group->amd_iommu_add_device->init_iommu_group->iommu_group_get_for_dev->iommu_group_add_device->iommu_group_create_direct_mappings->iommu_map->amd_iommu_map->mutex_lock(&domain->api_lock)

but the is initialized amd_iommu_domain_alloc->dma_ops_domain_alloc,
which has not initialized the api_lock of protect_domain, so got the
panic.


Thanks,

Xu
