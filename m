Return-Path: <SRS0=Ap1T=SN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00823C10F13
	for <iommu@archiver.kernel.org>; Thu, 11 Apr 2019 11:02:15 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C62B72133D
	for <iommu@archiver.kernel.org>; Thu, 11 Apr 2019 11:02:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C62B72133D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 7F8A92476;
	Thu, 11 Apr 2019 11:02:14 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id BF6B02469
	for <iommu@lists.linux-foundation.org>;
	Thu, 11 Apr 2019 11:01:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id 36AA5F4
	for <iommu@lists.linux-foundation.org>;
	Thu, 11 Apr 2019 11:01:42 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A5CC8374;
	Thu, 11 Apr 2019 04:01:41 -0700 (PDT)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D0BFD3F59C;
	Thu, 11 Apr 2019 04:01:39 -0700 (PDT)
Subject: Re: [PATCH] driver core: Postpone DMA tear-down until after devres
	release for probe failure
To: John Garry <john.garry@huawei.com>, Greg KH <gregkh@linuxfoundation.org>
References: <1553767685-27077-1-git-send-email-john.garry@huawei.com>
	<703aca1f-9475-b50d-624a-5f1ceea2c3b2@huawei.com>
	<20190403081433.GA13222@kroah.com>
	<3e1f3e2e-a1d3-ecaf-0931-44b4c10faffe@huawei.com>
	<cd21fd51-dc71-a9f1-abbb-965e8c2e7801@huawei.com>
	<d2504066-3d1a-176f-0f7e-7f86431ef88c@huawei.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <198058c6-63c6-ac3c-62b7-438e5e3b3f0e@arm.com>
Date: Thu, 11 Apr 2019 12:01:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <d2504066-3d1a-176f-0f7e-7f86431ef88c@huawei.com>
Content-Language: en-GB
Cc: robh@kernel.org, chenxiang66@hisilicon.com, rafael@kernel.org,
	linux-kernel@vger.kernel.org, linuxarm@huawei.com,
	iommu@lists.linux-foundation.org, geert@linux-m68k.org,
	hch@lst.de, linux-arm-kernel@lists.infradead.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"; format="flowed"
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190411110138.CGJrpHgaDjIKECtvxlYKtj9o1ZcpN6wmWarJPfq2TCs@z>

On 11/04/2019 09:50, John Garry wrote:
> On 04/04/2019 12:17, John Garry wrote:
>> On 03/04/2019 10:20, John Garry wrote:
>>> On 03/04/2019 09:14, Greg KH wrote:
>>>> On Wed, Apr 03, 2019 at 09:02:36AM +0100, John Garry wrote:
>>>>> On 28/03/2019 10:08, John Garry wrote:
>>>>>> In commit 376991db4b64 ("driver core: Postpone DMA tear-down until
>>>>>> after
>>>>>> devres release"), we changed the ordering of tearing down the device
>>>>>> DMA
>>>>>> ops and releasing all the device's resources; this was because the
>>>>>> DMA ops
>>>>>> should be maintained until we release the device's managed DMA
>>>>>> memories.
>>>>>>
>>>>>
>>>>> Hi all,
>>>>>
>>>>> A friendly reminder on this patch... I didn't see any update.
>>>>>
>>>>> I thought that it had some importance.
>>>>>
>>>>> Thanks,
>>>>> John
>>>>>
>>>>>> However, we have seen another crash on an arm64 system when a
>>>>>> device driver probe fails:
>>>>>>
>>>>>> =A0 hisi_sas_v3_hw 0000:74:02.0: Adding to iommu group 2
>>>>>> =A0 scsi host1: hisi_sas_v3_hw
>>>>>> =A0 BUG: Bad page state in process swapper/0=A0 pfn:313f5
>>>>>> =A0 page:ffff7e0000c4fd40 count:1 mapcount:0
>>>>>> =A0 mapping:0000000000000000 index:0x0
>>>>>> =A0 flags: 0xfffe00000001000(reserved)
>>>>>> =A0 raw: 0fffe00000001000 ffff7e0000c4fd48 ffff7e0000c4fd48
>>>>>> 0000000000000000
>>>>>> =A0 raw: 0000000000000000 0000000000000000 00000001ffffffff
>>>>>> 0000000000000000
>>>>>> =A0 page dumped because: PAGE_FLAGS_CHECK_AT_FREE flag(s) set
>>>>>> =A0 bad because of flags: 0x1000(reserved)
>>>>>> =A0 Modules linked in:
>>>>>> =A0 CPU: 49 PID: 1 Comm: swapper/0 Not tainted
>>>>>> 5.1.0-rc1-43081-g22d97fd-dirty #1433
>>>>>> =A0 Hardware name: Huawei D06/D06, BIOS Hisilicon D06 UEFI
>>>>>> RC0 - V1.12.01 01/29/2019
>>>>>> =A0 Call trace:
>>>>>> =A0 dump_backtrace+0x0/0x118
>>>>>> =A0 show_stack+0x14/0x1c
>>>>>> =A0 dump_stack+0xa4/0xc8
>>>>>> =A0 bad_page+0xe4/0x13c
>>>>>> =A0 free_pages_check_bad+0x4c/0xc0
>>>>>> =A0 __free_pages_ok+0x30c/0x340
>>>>>> =A0 __free_pages+0x30/0x44
>>>>>> =A0 __dma_direct_free_pages+0x30/0x38
>>>>>> =A0 dma_direct_free+0x24/0x38
>>>>>> =A0 dma_free_attrs+0x9c/0xd8
>>>>>> =A0 dmam_release+0x20/0x28
>>>>>> =A0 release_nodes+0x17c/0x220
>>>>>> =A0 devres_release_all+0x34/0x54
>>>>>> =A0 really_probe+0xc4/0x2c8
>>>>>> =A0 driver_probe_device+0x58/0xfc
>>>>>> =A0 device_driver_attach+0x68/0x70
>>>>>> =A0 __driver_attach+0x94/0xdc
>>>>>> =A0 bus_for_each_dev+0x5c/0xb4
>>>>>> =A0 driver_attach+0x20/0x28
>>>>>> =A0 bus_add_driver+0x14c/0x200
>>>>>> =A0 driver_register+0x6c/0x124
>>>>>> =A0 __pci_register_driver+0x48/0x50
>>>>>> =A0 sas_v3_pci_driver_init+0x20/0x28
>>>>>> =A0 do_one_initcall+0x40/0x25c
>>>>>> =A0 kernel_init_freeable+0x2b8/0x3c0
>>>>>> =A0 kernel_init+0x10/0x100
>>>>>> =A0 ret_from_fork+0x10/0x18
>>>>>> =A0 Disabling lock debugging due to kernel taint
>>>>>> =A0 BUG: Bad page state in process swapper/0=A0 pfn:313f6
>>>>>> =A0 page:ffff7e0000c4fd80 count:1 mapcount:0
>>>>>> mapping:0000000000000000 index:0x0
>>>>>> [=A0=A0 89.322983] flags: 0xfffe00000001000(reserved)
>>>>>> =A0 raw: 0fffe00000001000 ffff7e0000c4fd88 ffff7e0000c4fd88
>>>>>> 0000000000000000
>>>>>> =A0 raw: 0000000000000000 0000000000000000 00000001ffffffff
>>>>>> 0000000000000000
>>>>>>
>>>>>> The crash occurs for the same reason.
>>>>>>
>>>>>> In this case, on the really_probe() failure path, we are still
>>>>>> clearing
>>>>>> the DMA ops prior to releasing the device's managed memories.
>>>>>>
>>>>>> This patch fixes this issue by reordering the DMA ops teardown and =

>>>>>> the
>>>>>> call to devres_release_all() on the failure path.
>>>>>>
>>>>>> Reported-by: Xiang Chen <chenxiang66@hisilicon.com>
>>>>>> Tested-by: Xiang Chen <chenxiang66@hisilicon.com>
>>>>>> Signed-off-by: John Garry <john.garry@huawei.com>
>>>>
>>>> So does this "fix" 376991db4b64?=A0 If so, should this be added to the
>>>> patch and also backported to the stable trees?
>>>
>>> Hi Greg,
>>>
>>> No, I don't think so. I'd say it supplements it. Here I'm trying to fix
>>> up another path in which we tear down the DMA ops prior to releasing the
>>> device's resources.
>>>
>>> I didn't add a fixes tag as 376991db4b64 didn't have one either. It will
>>> need to be backported to stable, I figure the same as 376991db4b64.
>>
> =

> Hi Greg,
> =

> I still think that we should consider merging this patch.

Bah, sorry, I thought I'd replied to this thread already, but apparently =

not :(

I don't have a particularly strong opinion, but at the moment I am =

leaning slightly towards this being a parallel fix for another part of =

09515ef5ddad, rather than a specific fix of the other fix. Either way, =

you can have a:

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

Thanks,
Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
