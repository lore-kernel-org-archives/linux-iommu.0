Return-Path: <SRS0=MJs7=WM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C491FC3A59C
	for <iommu@archiver.kernel.org>; Fri, 16 Aug 2019 10:11:26 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95401206C1
	for <iommu@archiver.kernel.org>; Fri, 16 Aug 2019 10:11:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95401206C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 5D08AEBA;
	Fri, 16 Aug 2019 10:11:26 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id A4B91E37
	for <iommu@lists.linux-foundation.org>;
	Fri, 16 Aug 2019 10:11:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from huawei.com (szxga04-in.huawei.com [45.249.212.190])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id D214E76D
	for <iommu@lists.linux-foundation.org>;
	Fri, 16 Aug 2019 10:11:22 +0000 (UTC)
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
	by Forcepoint Email with ESMTP id BDFEF4EE51FFEEC89001;
	Fri, 16 Aug 2019 18:11:17 +0800 (CST)
Received: from [127.0.0.1] (10.202.227.238) by DGGEMS401-HUB.china.huawei.com
	(10.3.19.201) with Microsoft SMTP Server id 14.3.439.0;
	Fri, 16 Aug 2019 18:11:10 +0800
From: John Garry <john.garry@huawei.com>
Subject: Re: [PATCH 00/13] Rework IOMMU API to allow for batching of
	invalidation
To: Will Deacon <will@kernel.org>
References: <20190814175634.21081-1-will@kernel.org>
	<78d366b7-590f-b114-1a9a-91dea01cde4d@huawei.com>
	<20190815135528.d7ip6dkqdwwvjy64@willie-the-truck>
Message-ID: <4834c243-465c-f4ef-30df-aab230456c93@huawei.com>
Date: Fri, 16 Aug 2019 11:11:02 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
	Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20190815135528.d7ip6dkqdwwvjy64@willie-the-truck>
X-Originating-IP: [10.202.227.238]
X-CFilter-Loop: Reflected
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Vijay Kilary <vkilari@codeaurora.org>,
	Jon Masters <jcm@redhat.com>, Jan Glauber <jglauber@marvell.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	iommu@lists.linux-foundation.org,
	Jayachandran Chandrasekharan Nair <jnair@marvell.com>,
	David Woodhouse <dwmw2@infradead.org>, Robin Murphy <robin.murphy@arm.com>
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

On 15/08/2019 14:55, Will Deacon wrote:
> On Thu, Aug 15, 2019 at 12:19:58PM +0100, John Garry wrote:
>> On 14/08/2019 18:56, Will Deacon wrote:
>>> If you'd like to play with the patches, then I've also pushed them here:
>>>
>>>   https://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git/log/?h=iommu/unmap
>>>
>>> but they should behave as a no-op on their own.
>>
>> As anticipated, my storage testing scenarios roughly give parity throughput
>> and CPU loading before and after this series.
>>
>> Patches to convert the
>>> Arm SMMUv3 driver to the new API are here:
>>>
>>>   https://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git/log/?h=iommu/cmdq
>>
>> I quickly tested this again and now I see a performance lift:
>>
>> 			before (5.3-rc1)		after
>> D05 8x SAS disks	907K IOPS			970K IOPS
>> D05 1x NVMe		450K IOPS			466K IOPS
>> D06 1x NVMe		467K IOPS			466K IOPS
>>
>> The CPU loading seems to track throughput, so nothing much to say there.
>>
>> Note: From 5.2 testing, I was seeing >900K IOPS from that NVMe disk for
>> !IOMMU.
>
> Cheers, John. For interest, how do things look if you pass iommu.strict=0?
> That might give some indication about how much the invalidation is still
> hurting us.

So I tested for iommu/cmdq for NVMe only, and I see:

	 !SMMU		5.3-rc4 strict/!strict	cmdq strict/!strict
D05 NVMe 750K IOPS	456K/540K IOPS		466K/537K
D06 NVMe 750K IOPS	456K/740K IOPS		466K/745K

I don't know why the D06 iommu.strict performance is ~ same as D05, 
while !strict is so much better. D06 SMMU implementation is supposed to 
be generally much better than that of D05, so I would have thought that 
the strict performance would be better (than that of D05).

>
>> BTW, what were your thoughts on changing
>> arm_smmu_atc_inv_domain()->arm_smmu_atc_inv_master() to batching? It seems
>> suitable, but looks untouched. Were you waiting for a resolution to the
>> performance issue which Leizhen reported?
>
> In principle, I'm supportive of such a change, but I'm not currently able
> to test any ATS stuff so somebody else would need to write the patch.
> Jean-Philippe is on holiday at the moment, but I'd be happy to review
> something from you if you send it out.

Unfortunately I don't have anything ATS-enabled either. Not many do, it 
seems.

Cheers,
John

>
> Will
>
> .
>


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
