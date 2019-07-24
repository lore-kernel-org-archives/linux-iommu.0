Return-Path: <SRS0=WqUy=VV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CC8CC7618F
	for <iommu@archiver.kernel.org>; Wed, 24 Jul 2019 13:49:48 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1BA5214C6
	for <iommu@archiver.kernel.org>; Wed, 24 Jul 2019 13:49:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1BA5214C6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 88443E63;
	Wed, 24 Jul 2019 13:49:47 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 1C67DE1E
	for <iommu@lists.linux-foundation.org>;
	Wed, 24 Jul 2019 13:49:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id 5818A224
	for <iommu@lists.linux-foundation.org>;
	Wed, 24 Jul 2019 13:49:44 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DE10E28;
	Wed, 24 Jul 2019 06:49:43 -0700 (PDT)
Received: from [10.1.197.57] (e110467-lin.cambridge.arm.com [10.1.197.57])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 88C793F71A;
	Wed, 24 Jul 2019 06:49:42 -0700 (PDT)
Subject: Re: [PATCH] media: staging: ipu3: Enable IOVA API only when IOMMU
	support is enabled
To: Sakari Ailus <sakari.ailus@linux.intel.com>,
	YueHaibing <yuehaibing@huawei.com>
References: <20190722134749.21580-1-yuehaibing@huawei.com>
	<20190724103027.GD21370@paasikivi.fi.intel.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <e48fc180-06cc-eac7-d8ca-9be1699c8677@arm.com>
Date: Wed, 24 Jul 2019 14:49:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190724103027.GD21370@paasikivi.fi.intel.com>
Content-Language: en-GB
Cc: devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
	yong.zhi@intel.com, hverkuil-cisco@xs4all.nl, digetx@gmail.com,
	mchehab@kernel.org, linux-media@vger.kernel.org
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
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On 24/07/2019 11:30, Sakari Ailus wrote:
> Hi Yue,
> 
> On Mon, Jul 22, 2019 at 09:47:49PM +0800, YueHaibing wrote:
>> If IOMMU_SUPPORT is not set, ipu3 driver may select IOMMU_IOVA to m.
>> But for many drivers, they use "select IOMMU_IOVA if IOMMU_SUPPORT"
>> in the Kconfig, for example, CONFIG_TEGRA_VDE is set to y but IOMMU_IOVA
>> is m, then the building fails like this:
>>
>> drivers/staging/media/tegra-vde/iommu.o: In function `tegra_vde_iommu_map':
>> iommu.c:(.text+0x41): undefined reference to `alloc_iova'
>> iommu.c:(.text+0x56): undefined reference to `__free_iova'
>>
>> Reported-by: Hulk Robot <hulkci@huawei.com>
>> Fixes: 7fc7af649ca7 ("media: staging/intel-ipu3: Add imgu top level pci device driver")
>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>> ---
>>   drivers/staging/media/ipu3/Kconfig | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/staging/media/ipu3/Kconfig b/drivers/staging/media/ipu3/Kconfig
>> index 4b51c67..b7df18f 100644
>> --- a/drivers/staging/media/ipu3/Kconfig
>> +++ b/drivers/staging/media/ipu3/Kconfig
>> @@ -4,7 +4,7 @@ config VIDEO_IPU3_IMGU
>>   	depends on PCI && VIDEO_V4L2
>>   	depends on MEDIA_CONTROLLER && VIDEO_V4L2_SUBDEV_API
>>   	depends on X86
>> -	select IOMMU_IOVA
>> +	select IOMMU_IOVA if IOMMU_SUPPORT
> 
> This doesn't seem right: the ipu3-cio2 driver needs IOMMU_IOVA
> independently of IOMMU_SUPPORT.
> 
> Looking at tegra-vde, it seems to depend on IOMMU_SUPPORT but that's not
> declared in its Kconfig entry. I wonder if adding that would be the right
> way to fix this.
> 
> Cc'ing the IOMMU list.

Right, I also had the impression that we'd made the IOVA library 
completely standalone. And what does the IPU3 driver's Kconfig have to 
do with some *other* driver failing to link anyway?

Robin.

> 
>>   	select VIDEOBUF2_DMA_SG
>>   	help
>>   	  This is the Video4Linux2 driver for Intel IPU3 image processing unit,
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
