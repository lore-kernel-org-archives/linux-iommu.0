Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11798C43334
	for <iommu@archiver.kernel.org>; Mon, 27 Jun 2022 15:01:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7C8074190A;
	Mon, 27 Jun 2022 15:01:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7C8074190A
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id O9jiYdo5qlJI; Mon, 27 Jun 2022 15:01:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id DF9D2409DB;
	Mon, 27 Jun 2022 15:01:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DF9D2409DB
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B0698C0032;
	Mon, 27 Jun 2022 15:01:04 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 40C6CC002D
 for <iommu@lists.linux-foundation.org>; Mon, 27 Jun 2022 11:45:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0C1714159A
 for <iommu@lists.linux-foundation.org>; Mon, 27 Jun 2022 11:45:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0C1714159A
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id I7iLTuzbqAco for <iommu@lists.linux-foundation.org>;
 Mon, 27 Jun 2022 11:45:09 +0000 (UTC)
X-Greylist: delayed 00:06:42 by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 821314158B
Received: from mx1.sbone.de (cross.sbone.de [195.201.62.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 821314158B
 for <iommu@lists.linux-foundation.org>; Mon, 27 Jun 2022 11:45:09 +0000 (UTC)
Received: from mail.sbone.de (mail.sbone.de [IPv6:fde9:577b:c1a9:31::2013:587])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.sbone.de (Postfix) with ESMTPS id 179AF8D4A162;
 Mon, 27 Jun 2022 11:38:18 +0000 (UTC)
Received: from content-filter.sbone.de (content-filter.sbone.de
 [IPv6:fde9:577b:c1a9:31::2013:2742])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mail.sbone.de (Postfix) with ESMTPS id D9724E70810;
 Mon, 27 Jun 2022 11:38:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at sbone.de
Received: from mail.sbone.de ([IPv6:fde9:577b:c1a9:31::2013:587])
 by content-filter.sbone.de (content-filter.sbone.de
 [fde9:577b:c1a9:31::2013:2742]) (amavisd-new, port 10024)
 with ESMTP id hpfsF3TvzMS2; Mon, 27 Jun 2022 11:38:15 +0000 (UTC)
Received: from nv.sbone.de (nv.sbone.de [IPv6:fde9:577b:c1a9:31::2013:138])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mail.sbone.de (Postfix) with ESMTPSA id C8185E7080F;
 Mon, 27 Jun 2022 11:38:13 +0000 (UTC)
Date: Mon, 27 Jun 2022 11:38:12 +0000 (UTC)
From: "Bjoern A. Zeeb" <bzeeb-lists@lists.zabbadoz.net>
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Subject: RE: [PATCH v13 0/9] ACPI/IORT: Support for IORT RMR node
In-Reply-To: <44338c87254d4d439d29694de8f19435@huawei.com>
Message-ID: <alpine.BSF.2.00.2206271005580.68830@ai.fobar.qr>
References: <20220615101044.1972-1-shameerali.kolothum.thodi@huawei.com>
 <03b03d88-87cd-0b29-863b-2cb2a9a117d1@arm.com>
 <44338c87254d4d439d29694de8f19435@huawei.com>
X-OpenPGP-Key-Id: 0x14003F198FEFA3E77207EE8D2B58B8F83CCF1842
MIME-Version: 1.0
X-Mailman-Approved-At: Mon, 27 Jun 2022 15:01:02 +0000
Cc: "lorenzo.pieralisi@gmail.com" <lorenzo.pieralisi@gmail.com>,
 "will@kernel.org" <will@kernel.org>, "jon@solid-run.com" <jon@solid-run.com>,
 Linuxarm <linuxarm@huawei.com>, Steven Price <steven.price@arm.com>,
 "hch@infradead.org" <hch@infradead.org>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 wanghuiqiang <wanghuiqiang@huawei.com>,
 "Guohanjun \(Hanjun Guo\)" <guohanjun@huawei.com>,
 "Sami.Mujawar@arm.com" <Sami.Mujawar@arm.com>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
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

On Fri, 24 Jun 2022, Shameerali Kolothum Thodi wrote:

Hi,

>> -----Original Message-----
>> From: Steven Price [mailto:steven.price@arm.com]
>> Sent: 17 June 2022 13:42
>> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>;
>> linux-arm-kernel@lists.infradead.org; linux-acpi@vger.kernel.org;
>> iommu@lists.linux-foundation.org
>> Cc: Linuxarm <linuxarm@huawei.com>; lorenzo.pieralisi@arm.com;
>> joro@8bytes.org; robin.murphy@arm.com; will@kernel.org; wanghuiqiang
>> <wanghuiqiang@huawei.com>; Guohanjun (Hanjun Guo)
>> <guohanjun@huawei.com>; Sami.Mujawar@arm.com; jon@solid-run.com;
>> eric.auger@redhat.com; laurentiu.tudor@nxp.com; hch@infradead.org
>> Subject: Re: [PATCH v13 0/9] ACPI/IORT: Support for IORT RMR node
>>
>> On 15/06/2022 11:10, Shameer Kolothum wrote:
>>> Hi
>>>
>>> v12 --> v13
>>>   -No changes. Rebased to 5.19-rc1.
>>>   -Picked up tags received from Laurentiu, Hanjun and Will. Thanks!.
>>
>> You've already got my Tested-by tags, but just to confirm I gave this a
>> spin and it works fine.
>
> Thanks Steve.
>
> I think the series is now in a good shape to be merged.
>
> Hi Will/Robin,
>
> Appreciate, if you could please take a look at the remaining SMMU related
> patches(7-9) and provide your approval?
>
> Thanks,
> Shameer

First of all thanks to all of you for keeping this going.

I've read through most of this patch series and it doesn't read
like the best sunny days.

I do understand that there are incentives to get things right; sometimes
first make it work, then make it better? Running code often seems a
better alternative than wrong words on paper as users don't care about
the paper.  They only care if their hardware becomes a paperweight
because it's not working.

I was trying to find diplomatic words but the general problem has become
so much bigger than just this change as I am faced with the fact that
vendors are talking to give up maintaining Arm/ACPI and go back to FDT
exclusively, which I believe would be the wrong but an understandable
exit out of a roundabout.

For me this Arm/Linux/ACPI problem becomes double-impact, as I am not
even a Linux person.  And part of what Arm/ACPI was solving was the
any OS can just works on Arm hardware; for a while people were hoping
it could make FDT the next Flash; it just seems it'll not be because
people cannot get fixes or workarounds for real world problems into
Linux timely?

So a very polite but firm prod towards Cambridge from here as well in
the hope that you can make a big change to this world by helping not
to miss the next merge window/release leading to way bigger impact.
It would be rather sad to close the Arm/ACPI chapter for good but it
seems that we may be standing on the verge of it if things do not move
quick now and different in the future.  It'll certainly need change from
all sides but the good things is that at the end of the day we all want
to make the world a better place.

As I mentioned, I have no stakes in this Linux change.
I just care about Arm and ACPI because I saw light and a chance in it
and I would love to see it stay.
Let's all work together in one direction and make it a brighter future
for everyone.  Can we?  Are you in?


May God bless you and your work,
Bjoern
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
