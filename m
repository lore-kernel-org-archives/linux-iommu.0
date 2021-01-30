Return-Path: <SRS0=5nCU=HB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87DCEC433DB
	for <iommu@archiver.kernel.org>; Sat, 30 Jan 2021 01:35:13 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04B2764DBD
	for <iommu@archiver.kernel.org>; Sat, 30 Jan 2021 01:35:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04B2764DBD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id B0B31873A1;
	Sat, 30 Jan 2021 01:35:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uxeBa4SVwzOQ; Sat, 30 Jan 2021 01:35:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id D149C8739A;
	Sat, 30 Jan 2021 01:35:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B14B0C08A1;
	Sat, 30 Jan 2021 01:35:09 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1D208C013A
 for <iommu@lists.linux-foundation.org>; Sat, 30 Jan 2021 01:35:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 0C48186B23
 for <iommu@lists.linux-foundation.org>; Sat, 30 Jan 2021 01:35:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RFlR-NeHbrgD for <iommu@lists.linux-foundation.org>;
 Sat, 30 Jan 2021 01:35:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 9B53386B45
 for <iommu@lists.linux-foundation.org>; Sat, 30 Jan 2021 01:35:07 +0000 (UTC)
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
 by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4DSGvK0yY4z7d2C;
 Sat, 30 Jan 2021 09:33:49 +0800 (CST)
Received: from [127.0.0.1] (10.174.176.220) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.498.0;
 Sat, 30 Jan 2021 09:34:56 +0800
Subject: Re: [PATCH v3 2/3] perf/smmuv3: Add a MODULE_SOFTDEP() to indicate
 dependency on SMMU
To: Robin Murphy <robin.murphy@arm.com>, John Garry <john.garry@huawei.com>,
 Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "Joerg
 Roedel" <joro@8bytes.org>, linux-arm-kernel
 <linux-arm-kernel@lists.infradead.org>, iommu
 <iommu@lists.linux-foundation.org>, linux-kernel
 <linux-kernel@vger.kernel.org>
References: <20210127113258.1421-1-thunder.leizhen@huawei.com>
 <20210127113258.1421-3-thunder.leizhen@huawei.com>
 <67e0859b-2633-3516-527f-57557e210fa1@arm.com>
 <4b116f38-84da-9ef9-350c-8900944b0433@huawei.com>
 <a5595eae-0de9-e454-8a3d-5718512422ee@arm.com>
From: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <bc012c2b-4e94-8cd5-68c6-d4d9224aca0f@huawei.com>
Date: Sat, 30 Jan 2021 09:34:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <a5595eae-0de9-e454-8a3d-5718512422ee@arm.com>
Content-Language: en-US
X-Originating-IP: [10.174.176.220]
X-CFilter-Loop: Reflected
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>



On 2021/1/30 1:03, Robin Murphy wrote:
> On 2021-01-29 15:34, John Garry wrote:
>> On 29/01/2021 15:12, Robin Murphy wrote:
>>> On 2021-01-27 11:32, Zhen Lei wrote:
>>>> The MODULE_SOFTDEP() gives user space a hint of the loading sequence. And
>>>> when command "modprobe arm_smmuv3_pmu" is executed, the arm_smmu_v3.ko is
>>>> automatically loaded in advance.
>>>
>>> Why do we need this? If probe order doesn't matter when both drivers are built-in, why should module load order?
>>>
>>> TBH I'm not sure why we even have a Kconfig dependency on ARM_SMMU_V3, given that the drivers operate completely independently :/
>>
>> Can that Kconfig dependency just be removed? I think that it was added under the idea that there is no point in having the SMMUv3 PMU driver without the SMMUv3 driver.
> 
> A PMCG *might* be usable for simply counting transactions to measure device activity regardless of its associated SMMU being enabled.

If that's the case, the SOFTDEP really shouldn't be added. I wasn't trying to make sure they were loaded in order, just to make sure that the SMMU was not forgotten to load.

> Either way, it's not really Kconfig's job to decide what makes sense (beyond the top-level "can this driver *ever* be used on this platform" visibility choices). Imagine if we gave every PCI/USB/etc. device driver an explicit ?dependency on at least one host controller driver being enabled...
> 
> Robin.
> 
> .
> 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
