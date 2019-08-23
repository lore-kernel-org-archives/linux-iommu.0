Return-Path: <SRS0=APMu=WT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3A17C3A5A2
	for <iommu@archiver.kernel.org>; Fri, 23 Aug 2019 09:05:50 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D44012166E
	for <iommu@archiver.kernel.org>; Fri, 23 Aug 2019 09:05:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D44012166E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 9B7D21036;
	Fri, 23 Aug 2019 09:05:50 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 83D29101F
	for <iommu@lists.linux-foundation.org>;
	Fri, 23 Aug 2019 09:05:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from huawei.com (szxga07-in.huawei.com [45.249.212.35])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 00CAEE6
	for <iommu@lists.linux-foundation.org>;
	Fri, 23 Aug 2019 09:05:48 +0000 (UTC)
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
	by Forcepoint Email with ESMTP id 0B9099376FC76823520;
	Fri, 23 Aug 2019 17:05:47 +0800 (CST)
Received: from [127.0.0.1] (10.133.215.186) by DGGEMS410-HUB.china.huawei.com
	(10.3.19.210) with Microsoft SMTP Server id 14.3.439.0;
	Fri, 23 Aug 2019 17:05:41 +0800
Subject: Re: [PATCH v3 0/2] improve the concurrency of
	arm_smmu_atc_inv_domain()
To: Will Deacon <will@kernel.org>
References: <20190823024551.24448-1-thunder.leizhen@huawei.com>
	<20190823075026.pwlx33e4crh3m6tn@willie-the-truck>
	<7e28e1ce-2cc3-3c7f-45c7-e7de334c6976@huawei.com>
	<20190823083712.ggzmw3rcodwyhmlf@willie-the-truck>
From: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <c7de4504-6253-49ef-c628-5a702e28fc8d@huawei.com>
Date: Fri, 23 Aug 2019 17:05:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
	Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190823083712.ggzmw3rcodwyhmlf@willie-the-truck>
Content-Language: en-US
X-Originating-IP: [10.133.215.186]
X-CFilter-Loop: Reflected
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
	iommu <iommu@lists.linux-foundation.org>,
	Robin Murphy <robin.murphy@arm.com>,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org



On 2019/8/23 16:37, Will Deacon wrote:
> On Fri, Aug 23, 2019 at 04:06:52PM +0800, Leizhen (ThunderTown) wrote:
>>
>>
>> On 2019/8/23 15:50, Will Deacon wrote:
>>> On Fri, Aug 23, 2019 at 10:45:49AM +0800, Zhen Lei wrote:
>>>> v2 --> v3:
>>>> As Will Deacon's suggestion, I changed the lock type of
>>>> arm_smmu_domain.devices_lock from spinlock_t to rwlock_t, and I saw that the
>>>> performance is all right. And further use nr_ats_masters to quickly check have
>>>> no obvious effect, so I drop it.
>>>
>>> :/
>>>
>>> I already sent two versions of a series fixing this without any locking at
>>> all on the ->unmap() path, and you were on cc. I've also queued that stuff
>>> up.
>>>
>>> Did you not receive my patches?
>> Sorry, my message filter setting is a bit wrong, must contains
>> "linux-kernel@vger.kernel.org", I have corrected it.
> 
> Ha, sounds like the opposite of my email filter ;)
> 
>>> v1: https://lists.linuxfoundation.org/pipermail/iommu/2019-August/038306.html
>>> v2: https://lists.linuxfoundation.org/pipermail/iommu/2019-August/038374.html
>> OK, I will test it when it's my turn to use the board.
> 
> Thanks, although I plan to send it to Joerg today so any changes will need
> to go on top. Does your testing involve ATS, or just non-ATS devices? I've
I also currently only have non-ATS devices. 

> tested the latter locally, although I haven't looked at the performance
> since most of the patches are trying to fix the enable/disable ordering.
> 
> Thanks,
> 
> Will
> 
> .
> 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
