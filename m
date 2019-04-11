Return-Path: <SRS0=Ap1T=SN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04900C10F13
	for <iommu@archiver.kernel.org>; Thu, 11 Apr 2019 12:14:07 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9A6C2064B
	for <iommu@archiver.kernel.org>; Thu, 11 Apr 2019 12:14:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9A6C2064B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 01C4D24A4;
	Thu, 11 Apr 2019 12:14:05 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id B6F11249B
	for <iommu@lists.linux-foundation.org>;
	Thu, 11 Apr 2019 12:13:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from huawei.com (szxga07-in.huawei.com [45.249.212.35])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 11598F4
	for <iommu@lists.linux-foundation.org>;
	Thu, 11 Apr 2019 12:13:20 +0000 (UTC)
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
	by Forcepoint Email with ESMTP id 8C56641F068B8E92FEB3;
	Thu, 11 Apr 2019 20:13:18 +0800 (CST)
Received: from [127.0.0.1] (10.202.227.238) by DGGEMS401-HUB.china.huawei.com
	(10.3.19.201) with Microsoft SMTP Server id 14.3.408.0;
	Thu, 11 Apr 2019 20:13:10 +0800
Subject: Re: [PATCH] driver core: Postpone DMA tear-down until after devres
	release for probe failure
To: Robin Murphy <robin.murphy@arm.com>, Greg KH <gregkh@linuxfoundation.org>
References: <1553767685-27077-1-git-send-email-john.garry@huawei.com>
	<703aca1f-9475-b50d-624a-5f1ceea2c3b2@huawei.com>
	<20190403081433.GA13222@kroah.com>
	<3e1f3e2e-a1d3-ecaf-0931-44b4c10faffe@huawei.com>
	<cd21fd51-dc71-a9f1-abbb-965e8c2e7801@huawei.com>
	<d2504066-3d1a-176f-0f7e-7f86431ef88c@huawei.com>
	<198058c6-63c6-ac3c-62b7-438e5e3b3f0e@arm.com>
From: John Garry <john.garry@huawei.com>
Message-ID: <b66fa725-30d6-8816-3a4d-5bd711302afc@huawei.com>
Date: Thu, 11 Apr 2019 13:13:03 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
	Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <198058c6-63c6-ac3c-62b7-438e5e3b3f0e@arm.com>
X-Originating-IP: [10.202.227.238]
X-CFilter-Loop: Reflected
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="UTF-8"; format="flowed"
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190411121303.QT52f5UmAdGPgdBjRzlMh3Y9PMNvjSyA--duW0Fw_-M@z>

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


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
