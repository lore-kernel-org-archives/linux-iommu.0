Return-Path: <SRS0=nZOb=FG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED8E5C64E7C
	for <iommu@archiver.kernel.org>; Wed,  2 Dec 2020 15:21:31 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 335CE20B1F
	for <iommu@archiver.kernel.org>; Wed,  2 Dec 2020 15:21:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 335CE20B1F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 7CF742E261;
	Wed,  2 Dec 2020 15:21:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id I-2V2jSTKLS8; Wed,  2 Dec 2020 15:21:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id EF94620411;
	Wed,  2 Dec 2020 15:21:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E0D07C0859;
	Wed,  2 Dec 2020 15:21:28 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DB089C0052
 for <iommu@lists.linux-foundation.org>; Wed,  2 Dec 2020 15:21:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id D2040858F3
 for <iommu@lists.linux-foundation.org>; Wed,  2 Dec 2020 15:21:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aroZ7peKt3mn for <iommu@lists.linux-foundation.org>;
 Wed,  2 Dec 2020 15:21:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 708AF80EA3
 for <iommu@lists.linux-foundation.org>; Wed,  2 Dec 2020 15:21:25 +0000 (UTC)
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.200])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4CmN0h5SFmz67Kll;
 Wed,  2 Dec 2020 23:19:00 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 2 Dec 2020 16:21:22 +0100
Received: from [10.47.3.233] (10.47.3.233) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Wed, 2 Dec 2020
 15:21:20 +0000
Subject: Re: [RESEND PATCH v3 0/4] iommu/iova: Solve longterm IOVA issue
To: Will Deacon <will@kernel.org>
References: <1605608734-84416-1-git-send-email-john.garry@huawei.com>
 <d87ceec4-b7a1-c600-3b78-6852f0320ce2@huawei.com>
 <20201201210215.GB28178@willie-the-truck>
From: John Garry <john.garry@huawei.com>
Message-ID: <627436e2-ae2b-afeb-915c-b6d460d813f8@huawei.com>
Date: Wed, 2 Dec 2020 15:20:52 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20201201210215.GB28178@willie-the-truck>
Content-Language: en-US
X-Originating-IP: [10.47.3.233]
X-ClientProxiedBy: lhreml710-chm.china.huawei.com (10.201.108.61) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Cc: dima@arista.com, linuxarm@huawei.com, linux-kernel@vger.kernel.org,
 yuqi jin <jinyuqi@huawei.com>, iommu@lists.linux-foundation.org,
 Vijayanand Jitta <vjitta@codeaurora.org>, xiyou.wangcong@gmail.com,
 robin.murphy@arm.com
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

On 01/12/2020 21:02, Will Deacon wrote:

cc'ing some more people who have touched iova code recently

> On Tue, Dec 01, 2020 at 03:35:02PM +0000, John Garry wrote:
>> On 17/11/2020 10:25, John Garry wrote:
>> Is there any chance that we can get these picked up for 5.11? We've seen
>> this issue solved here for a long time.
>>
>> Or, @Robin, let me know if not happy with this since v1.
>>
>> BTW, patch #4 has been on the go for ~1 year now, and is a nice small
>> optimisation from Cong, which I picked up and already had a RB tag.
> I can pick the last patch up, but I'd really like some reviewed/tested-bys
> on the others.
> 

ok, fair enough.

Considering the extremes required to unearth the main problem, it'll be 
hard to get testers, but, fwiw, I can provide a tested-by from the reporter:

Tested-by: Xiang Chen <chenxiang66@hisilicon.com>

@Robin, You originally had some interest in this topic - are you now 
satisfied with the changes I am proposing?

Please let me know.

Thanks,
John
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
