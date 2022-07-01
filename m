Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53C2DC433EF
	for <iommu@archiver.kernel.org>; Fri,  1 Jul 2022 11:33:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CD5CF81A39;
	Fri,  1 Jul 2022 11:33:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CD5CF81A39
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 93dAgxsRndD4; Fri,  1 Jul 2022 11:33:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 7326781A18;
	Fri,  1 Jul 2022 11:33:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7326781A18
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 492FCC0035;
	Fri,  1 Jul 2022 11:33:22 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C7610C002D
 for <iommu@lists.linux-foundation.org>; Fri,  1 Jul 2022 11:33:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A07126135B
 for <iommu@lists.linux-foundation.org>; Fri,  1 Jul 2022 11:33:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A07126135B
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4mUjnVtcn1Q5 for <iommu@lists.linux-foundation.org>;
 Fri,  1 Jul 2022 11:33:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6C3B860FF8
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6C3B860FF8
 for <iommu@lists.linux-foundation.org>; Fri,  1 Jul 2022 11:33:19 +0000 (UTC)
Received: from fraeml707-chm.china.huawei.com (unknown [172.18.147.207])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LZCdf3yhHz6H71B;
 Fri,  1 Jul 2022 19:29:10 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml707-chm.china.huawei.com (10.206.15.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 1 Jul 2022 13:33:16 +0200
Received: from [10.126.173.51] (10.126.173.51) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 1 Jul 2022 12:33:15 +0100
Message-ID: <51af869a-83d4-631a-2d91-edb8b066bf4d@huawei.com>
Date: Fri, 1 Jul 2022 12:33:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] iommu/iova: change IOVA_MAG_SIZE to 127 to save memory
To: Feng Tang <feng.tang@intel.com>
References: <20220630073304.26945-1-feng.tang@intel.com>
 <13db50bb-57c7-0d54-3857-84b8a4591d9e@arm.com>
 <7c29d01d-d90c-58d3-a6e0-0b6c404173ac@huawei.com>
 <117b31b5-8d06-0af4-7f1c-231d86becf1d@arm.com>
 <2920df89-9975-5785-f79b-257d3052dfaf@huawei.com>
 <20220701035622.GB14806@shbuild999.sh.intel.com>
In-Reply-To: <20220701035622.GB14806@shbuild999.sh.intel.com>
X-Originating-IP: [10.126.173.51]
X-ClientProxiedBy: lhreml712-chm.china.huawei.com (10.201.108.63) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Cc: Paul Menzel <pmenzel@molgen.mpg.de>, Robin Murphy <robin.murphy@arm.com>,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>,
 Will Deacon <will@kernel.org>, Christoph Lameter <cl@linux.com>,
 Vlastimil Babka <vbabka@suse.cz>
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
From: John Garry via iommu <iommu@lists.linux-foundation.org>
Reply-To: John Garry <john.garry@huawei.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 01/07/2022 04:56, Feng Tang wrote:
>>> inclination.
>>>
>> ok, what you are saying sounds reasonable. I just remember that when we
>> analyzed the longterm aging issue that we concluded that the FQ size and its
>> relation to the magazine size was a factor and this change makes me a little
>> worried about new issues. Better the devil you know and all that...
>>
>> Anyway, if I get some time I might do some testing to see if this change has
>> any influence.
>>
>> Another thought is if we need even store the size in the iova_magazine? mags
>> in the depot are always full. As such, we only need worry about mags loaded
>> in the cpu rcache and their sizes, so maybe we could have something like
>> this:
>>
>> struct iova_magazine {
>> -       unsigned long size;
>>         unsigned long pfns[IOVA_MAG_SIZE];
>> };
>>
>> @@ -631,6 +630,8 @@ struct iova_cpu_rcache {
>>         spinlock_t lock;
>>         struct iova_magazine *loaded;
>>         struct iova_magazine *prev;
>> +       int loaded_size;
>> +       int prev_size;
>> };
>>
>> I haven't tried to implement it though..
> I have very few knowledge of iova, so you can chose what's the better
> solution. I just wanted to raise the problem and will be happy to see
> it solved:)

I quickly tested your patch for performance and saw no noticeable 
difference, which is no surprise.

But I'll defer to Robin if he thinks that your patch is a better 
solution - I would guess that he does. For me personally I would prefer 
that this value was not changed, as I mentioned before.

thanks,
John
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
