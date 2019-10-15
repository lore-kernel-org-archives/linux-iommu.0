Return-Path: <SRS0=BRyA=YI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E28D3C10F14
	for <iommu@archiver.kernel.org>; Tue, 15 Oct 2019 08:47:35 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3E432089C
	for <iommu@archiver.kernel.org>; Tue, 15 Oct 2019 08:47:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3E432089C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 65AA7B8F;
	Tue, 15 Oct 2019 08:47:35 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 20185AF3
	for <iommu@lists.linux-foundation.org>;
	Tue, 15 Oct 2019 08:47:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from huawei.com (szxga07-in.huawei.com [45.249.212.35])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 7DFDC6CE
	for <iommu@lists.linux-foundation.org>;
	Tue, 15 Oct 2019 08:47:33 +0000 (UTC)
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
	by Forcepoint Email with ESMTP id E5CBC381E56DCDE9C84C;
	Tue, 15 Oct 2019 16:47:28 +0800 (CST)
Received: from [127.0.0.1] (10.202.227.179) by DGGEMS406-HUB.china.huawei.com
	(10.3.19.206) with Microsoft SMTP Server id 14.3.439.0;
	Tue, 15 Oct 2019 16:47:19 +0800
Subject: Re: [RFC PATCH 6/6] ACPI/IORT: Drop code to set the PMCG
	software-defined model
To: Hanjun Guo <guohanjun@huawei.com>, <lorenzo.pieralisi@arm.com>,
	<sudeep.holla@arm.com>, <robin.murphy@arm.com>, <mark.rutland@arm.com>, 
	<will@kernel.org>
References: <1569854031-237636-1-git-send-email-john.garry@huawei.com>
	<1569854031-237636-7-git-send-email-john.garry@huawei.com>
	<e4e8adfd-a0af-82cb-c5f6-77153474330a@huawei.com>
From: John Garry <john.garry@huawei.com>
Message-ID: <4de3b360-710f-e109-93bf-30ff942d08c1@huawei.com>
Date: Tue, 15 Oct 2019 09:47:12 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
	Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <e4e8adfd-a0af-82cb-c5f6-77153474330a@huawei.com>
X-Originating-IP: [10.202.227.179]
X-CFilter-Loop: Reflected
Cc: nleeder@codeaurora.org, rjw@rjwysocki.net, linux-kernel@vger.kernel.org,
	linuxarm@huawei.com, iommu@lists.linux-foundation.org,
	linux-arm-kernel@lists.infradead.org, lenb@kernel.org
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

On 15/10/2019 04:06, Hanjun Guo wrote:
>> -/*
>> > - * PMCG model identifiers for use in smmu pmu driver. Please note
>> > - * that this is purely for the use of software and has nothing to
>> > - * do with hardware or with IORT specification.
>> > - */
>> > -#define IORT_SMMU_V3_PMCG_GENERIC        0x00000000 /* Generic SMMUv3 PMCG */
>> > -#define IORT_SMMU_V3_PMCG_HISI_HIP08     0x00000001 /* HiSilicon HIP08 PMCG */
> Since only HiSilicon platform has such erratum, and I think it works with
> both old version of firmware, I'm fine with removing this erratum framework.
>

Yeah, seems a decent change on its own, even without the SMMU PMCG 
driver changes.

But we still need to check on patch "[PATCH RFC 2/6] iommu/arm-smmu-v3: 
Record IIDR in arm_smmu_device structure" to progress any of this.

Will, Robin, Any opinion on that patch?

https://lore.kernel.org/linux-iommu/1569854031-237636-1-git-send-email-john.garry@huawei.com/T/#m1e24771a23ee5426ec94ca2c4ec572642c155a77

> Acked-by: Hanjun Guo <guohanjun@huawei.com>

Cheers,
John

>
> Thanks
> Hanjun
>
>
> .
>


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
