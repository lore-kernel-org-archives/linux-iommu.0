From: John Garry <john.garry@huawei.com>
Subject: Re: [PATCH] driver core: Postpone DMA tear-down until after devres
 release for probe failure
Date: Thu, 11 Apr 2019 13:13:03 +0100
Message-ID: <b66fa725-30d6-8816-3a4d-5bd711302afc@huawei.com>
References: <1553767685-27077-1-git-send-email-john.garry@huawei.com>
 <703aca1f-9475-b50d-624a-5f1ceea2c3b2@huawei.com>
 <20190403081433.GA13222@kroah.com>
 <3e1f3e2e-a1d3-ecaf-0931-44b4c10faffe@huawei.com>
 <cd21fd51-dc71-a9f1-abbb-965e8c2e7801@huawei.com>
 <d2504066-3d1a-176f-0f7e-7f86431ef88c@huawei.com>
 <198058c6-63c6-ac3c-62b7-438e5e3b3f0e@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <198058c6-63c6-ac3c-62b7-438e5e3b3f0e@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>, Greg KH <gregkh@linuxfoundation.org>
Cc: rafael@kernel.org, linuxarm@huawei.com, chenxiang66@hisilicon.com, geert@linux-m68k.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, robh@kernel.org, hch@lst.de
List-Id: iommu@lists.linux-foundation.org

On 11/04/2019 12:01, Robin Murphy wrote:
>>>>>>>
>>>>>>> The crash occurs for the same reason.
>>>>>>>
>>>>>>> In this case, on the really_probe() failure path, we are still
>>>>>>> clearing
>>>>>>> the DMA ops prior to releasing the device's managed memories.
>>>>>>>
>>>>>>> This patch fixes this issue by reordering the DMA ops teardown
>>>>>>> and the
>>>>>>> call to devres_release_all() on the failure path.
>>>>>>>
>>>>>>> Reported-by: Xiang Chen <chenxiang66@hisilicon.com>
>>>>>>> Tested-by: Xiang Chen <chenxiang66@hisilicon.com>
>>>>>>> Signed-off-by: John Garry <john.garry@huawei.com>
>>>>>
>>>>> So does this "fix" 376991db4b64?  If so, should this be added to the
>>>>> patch and also backported to the stable trees?
>>>>
>>>> Hi Greg,
>>>>
>>>> No, I don't think so. I'd say it supplements it. Here I'm trying to fix
>>>> up another path in which we tear down the DMA ops prior to releasing
>>>> the
>>>> device's resources.
>>>>
>>>> I didn't add a fixes tag as 376991db4b64 didn't have one either. It
>>>> will
>>>> need to be backported to stable, I figure the same as 376991db4b64.
>>>
>>
>> Hi Greg,
>>
>> I still think that we should consider merging this patch.
>
> Bah, sorry, I thought I'd replied to this thread already, but apparently
> not :(
>
> I don't have a particularly strong opinion, but at the moment I am
> leaning slightly towards this being a parallel fix for another part of
> 09515ef5ddad, rather than a specific fix of the other fix. Either way,
> you can have a:

I'd say a parallel fix of 09515ef5ddad.

>
> Reviewed-by: Robin Murphy <robin.murphy@arm.com>
>

cheers Robin

> Thanks,
> Robin.
