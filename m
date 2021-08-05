Return-Path: <SRS0=+AsR=M4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,URIBL_RED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA217C4338F
	for <iommu@archiver.kernel.org>; Thu,  5 Aug 2021 15:16:41 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B490610FF
	for <iommu@archiver.kernel.org>; Thu,  5 Aug 2021 15:16:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4B490610FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 148F46077E;
	Thu,  5 Aug 2021 15:16:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xMrRFdBMuXQ0; Thu,  5 Aug 2021 15:16:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id ED4096067A;
	Thu,  5 Aug 2021 15:16:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9C38EC001A;
	Thu,  5 Aug 2021 15:16:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4FF79C000E
 for <iommu@lists.linux-foundation.org>; Thu,  5 Aug 2021 15:16:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 321CD6077E
 for <iommu@lists.linux-foundation.org>; Thu,  5 Aug 2021 15:16:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZY9lAnB38Rrh for <iommu@lists.linux-foundation.org>;
 Thu,  5 Aug 2021 15:16:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 337676067A
 for <iommu@lists.linux-foundation.org>; Thu,  5 Aug 2021 15:16:37 +0000 (UTC)
Received: from fraeml734-chm.china.huawei.com (unknown [172.18.147.200])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GgXJ01DVKz6F8Wk;
 Thu,  5 Aug 2021 23:16:16 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml734-chm.china.huawei.com (10.206.15.215) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 5 Aug 2021 17:16:34 +0200
Received: from [10.47.24.8] (10.47.24.8) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2176.2; Thu, 5 Aug 2021
 16:16:33 +0100
Subject: Re: [PATCH] iommu/arm-smmu-v3: Remove some unneeded init in
 arm_smmu_cmdq_issue_cmdlist()
To: Robin Murphy <robin.murphy@arm.com>, <will@kernel.org>
References: <1624293394-202509-1-git-send-email-john.garry@huawei.com>
 <ee1f3ab5-3acc-f442-f2d2-898cf88bc447@arm.com>
 <45a8af4f-4202-ecd8-0882-507acf9b2eb2@huawei.com>
 <577a625a-4fc5-7402-8e4f-4e0e5be93144@arm.com>
From: John Garry <john.garry@huawei.com>
Message-ID: <44c5e07b-e663-5b96-a142-ec25666e2a14@huawei.com>
Date: Thu, 5 Aug 2021 16:16:02 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <577a625a-4fc5-7402-8e4f-4e0e5be93144@arm.com>
Content-Language: en-US
X-Originating-IP: [10.47.24.8]
X-ClientProxiedBy: lhreml706-chm.china.huawei.com (10.201.108.55) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Cc: linuxarm@huawei.com, iommu@lists.linux-foundation.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
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

On 05/08/2021 15:41, Robin Murphy wrote:
>> I suppose they could be combined into a smaller sub-struct and loaded 
>> in a single operation, but it looks messy, and prob without much gain.
> 
> Indeed I wouldn't say that saving memory is the primary concern here, 
> and any more convoluted code is hardly going to help performance. Plus 
> it still wouldn't help the other cases where we're just copying the size 
> into a fake queue to do some prod arithmetic - I hadn't fully clocked 
> what was going on there when I skimmed through things earlier.
> 
> Disregarding the bogus layout change, though, do you reckon the rest of 
> my idea makes sense?

I tried the similar change to avoid zero-init the padding in 
arm_smmu_cmdq_write_entries() and the 
_arm_smmu_cmdq_poll_set_valid_map(), but the disassembly was the same. 
So the compiler must have got smart there.

But for the original change in this patch, it did make a difference. 
It's nice to remove what was a memcpy:

     1770: a9077eff stp xzr, xzr, [x23, #112]
}, head = llq;
     1774: 94000000 bl 0 <memcpy>

And performance was very fractionally better.

As for pre-evaluating "nents", I'm not sure how much that can help, but 
I am not too optimistic. I can try some testing when I get a chance. 
Having said that, I would need to check the disassembly also.

Thanks,
John
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
