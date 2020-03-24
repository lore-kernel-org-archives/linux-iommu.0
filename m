Return-Path: <SRS0=P7ka=5J=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B055EC4332B
	for <iommu@archiver.kernel.org>; Tue, 24 Mar 2020 09:18:30 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C5F720A8B
	for <iommu@archiver.kernel.org>; Tue, 24 Mar 2020 09:18:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C5F720A8B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 4BAF8861C9;
	Tue, 24 Mar 2020 09:18:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tdo1LXbTeErd; Tue, 24 Mar 2020 09:18:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id B7D5086155;
	Tue, 24 Mar 2020 09:18:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AC229C089F;
	Tue, 24 Mar 2020 09:18:28 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 03A97C0177
 for <iommu@lists.linux-foundation.org>; Tue, 24 Mar 2020 09:18:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id E030C88928
 for <iommu@lists.linux-foundation.org>; Tue, 24 Mar 2020 09:18:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xbLL7vsGWi6B for <iommu@lists.linux-foundation.org>;
 Tue, 24 Mar 2020 09:18:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from huawei.com (lhrrgout.huawei.com [185.176.76.210])
 by hemlock.osuosl.org (Postfix) with ESMTPS id C174E88927
 for <iommu@lists.linux-foundation.org>; Tue, 24 Mar 2020 09:18:25 +0000 (UTC)
Received: from lhreml702-cah.china.huawei.com (unknown [172.18.7.108])
 by Forcepoint Email with ESMTP id DA4C5305CE469B927D24;
 Tue, 24 Mar 2020 09:18:22 +0000 (GMT)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 lhreml702-cah.china.huawei.com (10.201.108.43) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 24 Mar 2020 09:18:22 +0000
Received: from [127.0.0.1] (10.210.165.24) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 24 Mar
 2020 09:18:21 +0000
Subject: Re: arm-smmu-v3 high cpu usage for NVMe
To: Marc Zyngier <maz@kernel.org>
References: <20190821151749.23743-1-will@kernel.org>
 <b2a6e26d-6d0d-7f0d-f222-589812f701d2@huawei.com>
 <20200318205313.GB8094@willie-the-truck>
 <c6ab8020-dc06-0c7d-7a41-e792d90f97ba@huawei.com>
 <20200319184349.GA1697676@myrica>
 <c9ebe17d-66b8-1b8c-cc2c-5be0bd1501a7@huawei.com>
 <20200320111842.GD1702630@myrica>
 <b412fc9c-6266-e320-0769-f214d7752675@huawei.com>
 <5198fcffc8ad6233e0274ebff9e9aa5f@kernel.org>
 <cca67355-672d-81c5-3d37-72004eb8f14f@huawei.com>
 <dd375cf6bffacd82174c84a4c7d46283@kernel.org>
From: John Garry <john.garry@huawei.com>
Message-ID: <0e00de15-596a-d342-f3cb-e19c389294e6@huawei.com>
Date: Tue, 24 Mar 2020 09:18:10 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <dd375cf6bffacd82174c84a4c7d46283@kernel.org>
Content-Language: en-US
X-Originating-IP: [10.210.165.24]
X-ClientProxiedBy: lhreml732-chm.china.huawei.com (10.201.108.83) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Cc: Mark Rutland <mark.rutland@arm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Robin Murphy <robin.murphy@arm.com>, Ming Lei <ming.lei@redhat.com>,
 iommu@lists.linux-foundation.org, Will Deacon <will@kernel.org>,
 Julien Thierry <julien.thierry.kdev@gmail.com>
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

On 23/03/2020 09:16, Marc Zyngier wrote:

+ Julien, Mark

Hi Marc,

>>> Time to enable pseudo-NMIs in the PMUv3 driver...
>>>
>>
>> Do you know if there is any plan for this?
> 
> There was. Julien Thierry has a bunch of patches for that [1], but they 
> needs
> reviving.
> 

So those patches still apply cleanly (apart from the kvm patch, which I 
can skip, I suppose) and build, so I can try this I figure. Is there 
anything else which I should ensure or know about? Apart from enable 
CONFIG_ARM64_PSUEDO_NMI.

A quickly taken perf annotate and report is at the tip here: 
https://github.com/hisilicon/kernel-dev/commits/private-topic-nvme-5.6-profiling 


>>
>> In the meantime, maybe I can do some trickery by putting the
>> local_irq_restore() in a separate function, outside
>> arm_smmu_cmdq_issue_cmdlist(), to get a fair profile for that same
>> function.
> 

Scratch that :)

> I don't see how you can improve the profiling without compromising
> the locking in this case...
> 

Cheers,
John

[1] https://patchwork.kernel.org/cover/11047407/
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
