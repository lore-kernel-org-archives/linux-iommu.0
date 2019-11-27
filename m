Return-Path: <SRS0=T/MU=ZT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54707C432C3
	for <iommu@archiver.kernel.org>; Wed, 27 Nov 2019 19:06:25 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 275A520835
	for <iommu@archiver.kernel.org>; Wed, 27 Nov 2019 19:06:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 275A520835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id F2EDC20412;
	Wed, 27 Nov 2019 19:06:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qwgQQASlhfVx; Wed, 27 Nov 2019 19:06:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 99FBB20023;
	Wed, 27 Nov 2019 19:06:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 826F2C1DDA;
	Wed, 27 Nov 2019 19:06:23 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 979ACC0881
 for <iommu@lists.linux-foundation.org>; Wed, 27 Nov 2019 19:06:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 84C59861C9
 for <iommu@lists.linux-foundation.org>; Wed, 27 Nov 2019 19:06:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JpdZHoO4NKMd for <iommu@lists.linux-foundation.org>;
 Wed, 27 Nov 2019 19:06:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by fraxinus.osuosl.org (Postfix) with ESMTP id A272B85A58
 for <iommu@lists.linux-foundation.org>; Wed, 27 Nov 2019 19:06:20 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 04C6F31B;
 Wed, 27 Nov 2019 11:06:20 -0800 (PST)
Received: from [10.1.196.37] (e121345-lin.cambridge.arm.com [10.1.196.37])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D3B673F6C4;
 Wed, 27 Nov 2019 11:06:14 -0800 (PST)
Subject: Re: [PATCH v3 1/7] linux/log2.h: Add roundup/rounddown_pow_two64()
 family of functions
To: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
 Leon Romanovsky <leon@kernel.org>
References: <20191126091946.7970-1-nsaenzjulienne@suse.de>
 <20191126091946.7970-2-nsaenzjulienne@suse.de>
 <20191126125137.GA10331@unreal>
 <6e0b9079-9efd-2884-26d1-3db2d622079d@arm.com>
 <b30002d48c9d010a1ee81c16cd29beee914c3b1d.camel@suse.de>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <c08863a7-49c6-962e-e968-92adb8ee2cc9@arm.com>
Date: Wed, 27 Nov 2019 19:06:12 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <b30002d48c9d010a1ee81c16cd29beee914c3b1d.camel@suse.de>
Content-Language: en-GB
Cc: Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
 Shawn Lin <shawn.lin@rock-chips.com>, Hanjun Guo <guohanjun@huawei.com>,
 Frank Rowand <frowand.list@gmail.com>, Christoph Hellwig <hch@lst.de>,
 f.fainelli@gmail.com, linux-rockchip@lists.infradead.org,
 linux-rdma@vger.kernel.org, maz@kernel.org, phil@raspberrypi.org,
 linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>,
 devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
 Bjorn Helgaas <bhelgaas@google.com>, linux-arm-kernel@lists.infradead.org,
 mbrugger@suse.com, netdev@vger.kernel.org,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org,
 jeremy.linton@arm.com, iommu@lists.linux-foundation.org,
 Rob Herring <robh+dt@kernel.org>, wahrenst@gmx.net, james.quinlan@broadcom.com,
 Sudeep Holla <sudeep.holla@arm.com>, "David S. Miller" <davem@davemloft.net>,
 Tariq Toukan <tariqt@mellanox.com>
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

On 27/11/2019 6:24 pm, Nicolas Saenz Julienne wrote:
> On Wed, 2019-11-27 at 18:06 +0000, Robin Murphy wrote:
>> On 26/11/2019 12:51 pm, Leon Romanovsky wrote:
>>> On Tue, Nov 26, 2019 at 10:19:39AM +0100, Nicolas Saenz Julienne wrote:
>>>> Some users need to make sure their rounding function accepts and returns
>>>> 64bit long variables regardless of the architecture. Sadly
>>>> roundup/rounddown_pow_two() takes and returns unsigned longs. Create a
>>>> new generic 64bit variant of the function and cleanup rougue custom
>>>> implementations.
>>>
>>> Is it possible to create general roundup/rounddown_pow_two() which will
>>> work correctly for any type of variables, instead of creating special
>>> variant for every type?
>>
>> In fact, that is sort of the case already - roundup_pow_of_two() itself
>> wraps ilog2() such that the constant case *is* type-independent. And
>> since ilog2() handles non-constant values anyway, might it be reasonable
>> to just take the strongly-typed __roundup_pow_of_two() helper out of the
>> loop as below?
>>
>> Robin
>>
> 
> That looks way better that's for sure. Some questions.
> 
>> ----->8-----
>> diff --git a/include/linux/log2.h b/include/linux/log2.h
>> index 83a4a3ca3e8a..e825f8a6e8b5 100644
>> --- a/include/linux/log2.h
>> +++ b/include/linux/log2.h
>> @@ -172,11 +172,8 @@ unsigned long __rounddown_pow_of_two(unsigned long n)
>>     */
>>    #define roundup_pow_of_two(n)			\
>>    (						\
>> -	__builtin_constant_p(n) ? (		\
>> -		(n == 1) ? 1 :			\
>> -		(1UL << (ilog2((n) - 1) + 1))	\
>> -				   ) :		\
>> -	__roundup_pow_of_two(n)			\
>> +	(__builtin_constant_p(n) && (n == 1)) ?	\
>> +	1 : (1UL << (ilog2((n) - 1) + 1))	\
> 
> Then here you'd have to use ULL instead of UL, right? I want my 64bit value
> everywhere regardless of the CPU arch. The downside is that would affect
> performance to some extent (i.e. returning a 64bit value where you used to have
> a 32bit one)?

True, although it's possible that 1ULL might result in the same codegen 
if the compiler can see that the result is immediately truncated back to 
long anyway. Or at worst, I suppose "(typeof(n))1" could suffice, 
however ugly. Either way, this diff was only an illustration rather than 
a concrete proposal, but it might be an interesting diversion to 
investigate.

On that note, though, you should probably be using ULL in your current 
patch too.

> Also, what about callers to this function on platforms with 32bit 'unsigned
> longs' that happen to input a 64bit value into this. IIUC we'd have a change of
> behaviour.

Indeed, although the change in such a case would be "start getting the 
expected value instead of nonsense", so it might very well be welcome ;)

Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
