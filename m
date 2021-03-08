Return-Path: <SRS0=OBKs=IG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C2DEC433E0
	for <iommu@archiver.kernel.org>; Mon,  8 Mar 2021 14:56:19 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5799651C5
	for <iommu@archiver.kernel.org>; Mon,  8 Mar 2021 14:56:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5799651C5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 69FB16074F;
	Mon,  8 Mar 2021 14:56:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pUyObd86Jvyn; Mon,  8 Mar 2021 14:56:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5FB0D606A0;
	Mon,  8 Mar 2021 14:56:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 36930C000B;
	Mon,  8 Mar 2021 14:56:17 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4BEE4C0001
 for <iommu@lists.linux-foundation.org>; Mon,  8 Mar 2021 14:56:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2C87B44C77
 for <iommu@lists.linux-foundation.org>; Mon,  8 Mar 2021 14:56:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pTbiipvAVe0t for <iommu@lists.linux-foundation.org>;
 Mon,  8 Mar 2021 14:56:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A134F45BC3
 for <iommu@lists.linux-foundation.org>; Mon,  8 Mar 2021 14:56:14 +0000 (UTC)
Received: from fraeml715-chm.china.huawei.com (unknown [172.18.147.226])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DvLs253wrz67wtT;
 Mon,  8 Mar 2021 22:51:50 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml715-chm.china.huawei.com (10.206.15.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 8 Mar 2021 15:56:11 +0100
Received: from [10.210.165.214] (10.210.165.214) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 8 Mar 2021 14:56:10 +0000
Subject: Re: [PATCH] iommu/dma: Resurrect the "forcedac" option
To: Robin Murphy <robin.murphy@arm.com>, <joro@8bytes.org>
References: <7eece8e0ea7bfbe2cd0e30789e0d46df573af9b0.1614961776.git.robin.murphy@arm.com>
 <76a931ab-fd2a-284e-61ef-9e26bceb4890@huawei.com>
 <3b1d1dea-ebba-f811-06af-d26a8061d678@arm.com>
From: John Garry <john.garry@huawei.com>
Message-ID: <1f7198b6-bbed-1494-19ee-3453217d12a6@huawei.com>
Date: Mon, 8 Mar 2021 14:54:11 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <3b1d1dea-ebba-f811-06af-d26a8061d678@arm.com>
Content-Language: en-US
X-Originating-IP: [10.210.165.214]
X-ClientProxiedBy: lhreml739-chm.china.huawei.com (10.201.108.189) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Cc: dwmw2@infradead.org, linux-kernel@vger.kernel.org, murphyt7@tcd.ie,
 iommu@lists.linux-foundation.org, will@kernel.org
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

On 08/03/2021 13:08, Robin Murphy wrote:
> On 2021-03-05 17:41, John Garry wrote:
>> On 05/03/2021 16:32, Robin Murphy wrote:
>>> In converting intel-iommu over to the common IOMMU DMA ops, it quietly
>>> lost the functionality of its "forcedac" option. Since this is a handy
>>> thing both for testing and for performance optimisation on certain
>>> platforms, reimplement it under the common IOMMU parameter namespace.
>>>
>>> For the sake of fixing the inadvertent breakage of the Intel-specific
>>> parameter, remove the dmar_forcedac remnants and hook it up as an alias
>>> while documenting the transition to the new common parameter.
>>>
>>
>> Do you think that having a kconfig option to control the default for 
>> this can help identify the broken platforms which rely on forcedac=0? 
>> But seems a bit trivial for that, though.
> 
> I think it's still a sizeable can of worms - unlike, say, 
> ARM_SMMU_DISABLE_BYPASS_BY_DEFAULT, we can't actually tell when things 
> have gone awry and explicitly call it out. While I was getting the 
> dma-ranges right on my Juno, everything broke differently - the SATA 
> controller fails gracefully; the ethernet controller got the kernel tied 
> up somewhere (to the point that the USB keyboard died) once it tried to 
> brink up the link, but was at least spewing regular timeout backtraces 
> that implicated the networking layer; having an (unused) NVMe plugged in 
> simply wedged the boot process early on with no hint whatsoever of why.
> 
> TBH I'm not really sure what the best way forward is in terms of trying 
> to weed out platforms that would need quirking.

I was more thinking of an unstable TEST config, like 
DEBUG_TEST_DRIVER_REMOVE. So we know that this particular config breaks 
many platforms. But at least those in the know can turn it on locally 
and detect and fix issues, and strive towards having a platform for 
which it works.

But then it does become a little harder to justify such a config when we 
can enable via commadline.

> Our discussion just 
> reminded me of this option and that it had gone AWOL, so bringing it 
> back to be potentially *some* use to everyone seems justifiable on its own.

Of course.

Cheers,
John
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
