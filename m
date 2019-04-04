From: John Garry <john.garry-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] driver core: Postpone DMA tear-down until after devres
	release for probe failure
Date: Thu, 4 Apr 2019 12:17:37 +0100
Message-ID: <cd21fd51-dc71-a9f1-abbb-965e8c2e7801@huawei.com>
References: <1553767685-27077-1-git-send-email-john.garry@huawei.com>
	<703aca1f-9475-b50d-624a-5f1ceea2c3b2@huawei.com>
	<20190403081433.GA13222@kroah.com>
	<3e1f3e2e-a1d3-ecaf-0931-44b4c10faffe@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <3e1f3e2e-a1d3-ecaf-0931-44b4c10faffe-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, robin.murphy-5wv7dgnIgG8@public.gmane.org
Cc: robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, chenxiang66-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linuxarm-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org, hch-jcswGhMUV9g@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 03/04/2019 10:20, John Garry wrote:
> On 03/04/2019 09:14, Greg KH wrote:
>> On Wed, Apr 03, 2019 at 09:02:36AM +0100, John Garry wrote:
>>> On 28/03/2019 10:08, John Garry wrote:
>>>> In commit 376991db4b64 ("driver core: Postpone DMA tear-down until
>>>> after
>>>> devres release"), we changed the ordering of tearing down the device
>>>> DMA
>>>> ops and releasing all the device's resources; this was because the
>>>> DMA ops
>>>> should be maintained until we release the device's managed DMA
>>>> memories.
>>>>
>>>
>>> Hi all,
>>>
>>> A friendly reminder on this patch... I didn't see any update.
>>>
>>> I thought that it had some importance.
>>>
>>> Thanks,
>>> John
>>>
>>>> However, we have seen another crash on an arm64 system when a
>>>> device driver probe fails:
>>>>
>>>>   hisi_sas_v3_hw 0000:74:02.0: Adding to iommu group 2
>>>>   scsi host1: hisi_sas_v3_hw
>>>>   BUG: Bad page state in process swapper/0  pfn:313f5
>>>>   page:ffff7e0000c4fd40 count:1 mapcount:0
>>>>   mapping:0000000000000000 index:0x0
>>>>   flags: 0xfffe00000001000(reserved)
>>>>   raw: 0fffe00000001000 ffff7e0000c4fd48 ffff7e0000c4fd48
>>>> 0000000000000000
>>>>   raw: 0000000000000000 0000000000000000 00000001ffffffff
>>>> 0000000000000000
>>>>   page dumped because: PAGE_FLAGS_CHECK_AT_FREE flag(s) set
>>>>   bad because of flags: 0x1000(reserved)
>>>>   Modules linked in:
>>>>   CPU: 49 PID: 1 Comm: swapper/0 Not tainted
>>>> 5.1.0-rc1-43081-g22d97fd-dirty #1433
>>>>   Hardware name: Huawei D06/D06, BIOS Hisilicon D06 UEFI
>>>> RC0 - V1.12.01 01/29/2019
>>>>   Call trace:
>>>>   dump_backtrace+0x0/0x118
>>>>   show_stack+0x14/0x1c
>>>>   dump_stack+0xa4/0xc8
>>>>   bad_page+0xe4/0x13c
>>>>   free_pages_check_bad+0x4c/0xc0
>>>>   __free_pages_ok+0x30c/0x340
>>>>   __free_pages+0x30/0x44
>>>>   __dma_direct_free_pages+0x30/0x38
>>>>   dma_direct_free+0x24/0x38
>>>>   dma_free_attrs+0x9c/0xd8
>>>>   dmam_release+0x20/0x28
>>>>   release_nodes+0x17c/0x220
>>>>   devres_release_all+0x34/0x54
>>>>   really_probe+0xc4/0x2c8
>>>>   driver_probe_device+0x58/0xfc
>>>>   device_driver_attach+0x68/0x70
>>>>   __driver_attach+0x94/0xdc
>>>>   bus_for_each_dev+0x5c/0xb4
>>>>   driver_attach+0x20/0x28
>>>>   bus_add_driver+0x14c/0x200
>>>>   driver_register+0x6c/0x124
>>>>   __pci_register_driver+0x48/0x50
>>>>   sas_v3_pci_driver_init+0x20/0x28
>>>>   do_one_initcall+0x40/0x25c
>>>>   kernel_init_freeable+0x2b8/0x3c0
>>>>   kernel_init+0x10/0x100
>>>>   ret_from_fork+0x10/0x18
>>>>   Disabling lock debugging due to kernel taint
>>>>   BUG: Bad page state in process swapper/0  pfn:313f6
>>>>   page:ffff7e0000c4fd80 count:1 mapcount:0
>>>> mapping:0000000000000000 index:0x0
>>>> [   89.322983] flags: 0xfffe00000001000(reserved)
>>>>   raw: 0fffe00000001000 ffff7e0000c4fd88 ffff7e0000c4fd88
>>>> 0000000000000000
>>>>   raw: 0000000000000000 0000000000000000 00000001ffffffff
>>>> 0000000000000000
>>>>
>>>> The crash occurs for the same reason.
>>>>
>>>> In this case, on the really_probe() failure path, we are still clearing
>>>> the DMA ops prior to releasing the device's managed memories.
>>>>
>>>> This patch fixes this issue by reordering the DMA ops teardown and the
>>>> call to devres_release_all() on the failure path.
>>>>
>>>> Reported-by: Xiang Chen <chenxiang66-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>
>>>> Tested-by: Xiang Chen <chenxiang66-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>
>>>> Signed-off-by: John Garry <john.garry-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
>>
>> So does this "fix" 376991db4b64?  If so, should this be added to the
>> patch and also backported to the stable trees?
>
> Hi Greg,
>
> No, I don't think so. I'd say it supplements it. Here I'm trying to fix
> up another path in which we tear down the DMA ops prior to releasing the
> device's resources.
>
> I didn't add a fixes tag as 376991db4b64 didn't have one either. It will
> need to be backported to stable, I figure the same as 376991db4b64.

So 376991db4b64 required manual backporting to stable, and this patch 
would require the same:

https://www.spinics.net/lists/stable/msg289685.html

Robin, any further comment?

Thanks,
John


>> thanks,
>>
>> greg k-h
>>
>> .
>>
>
