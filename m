Return-Path: <SRS0=1cKf=HA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17299C433DB
	for <iommu@archiver.kernel.org>; Fri, 29 Jan 2021 13:15:50 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5651D64DED
	for <iommu@archiver.kernel.org>; Fri, 29 Jan 2021 13:15:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5651D64DED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 163C386D92;
	Fri, 29 Jan 2021 13:15:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VCmJOpVvnRdE; Fri, 29 Jan 2021 13:15:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 3030987159;
	Fri, 29 Jan 2021 13:15:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EAB93C08A1;
	Fri, 29 Jan 2021 13:15:44 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3B3FCC013A
 for <iommu@lists.linux-foundation.org>; Fri, 29 Jan 2021 13:15:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 1DB8A869B8
 for <iommu@lists.linux-foundation.org>; Fri, 29 Jan 2021 13:15:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ymoZtFeU-Rdb for <iommu@lists.linux-foundation.org>;
 Fri, 29 Jan 2021 13:15:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 9E82686200
 for <iommu@lists.linux-foundation.org>; Fri, 29 Jan 2021 13:15:38 +0000 (UTC)
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
 by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DRyV141BVzjFxl;
 Fri, 29 Jan 2021 21:14:17 +0800 (CST)
Received: from [127.0.0.1] (10.174.176.220) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.498.0;
 Fri, 29 Jan 2021 21:15:24 +0800
Subject: Re: [PATCH v3 0/3] perf/smmuv3: Don't reserve the PMCG register spaces
To: Will Deacon <will@kernel.org>
References: <20210127113258.1421-1-thunder.leizhen@huawei.com>
 <20210128203148.GG3016@willie-the-truck>
From: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <f2d8c9d2-c5e3-6e8f-6f9a-7295883ffeb5@huawei.com>
Date: Fri, 29 Jan 2021 21:15:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20210128203148.GG3016@willie-the-truck>
Content-Language: en-US
X-Originating-IP: [10.174.176.220]
X-CFilter-Loop: Reflected
Cc: Mark Rutland <mark.rutland@arm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 iommu <iommu@lists.linux-foundation.org>, Robin Murphy <robin.murphy@arm.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
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



On 2021/1/29 4:31, Will Deacon wrote:
> On Wed, Jan 27, 2021 at 07:32:55PM +0800, Zhen Lei wrote:
>> v2 --> v3:
>> Patch 3 is updated because https://lkml.org/lkml/2021/1/22/532 has been queued in advance.
>>
>> v1 --> v2:
>> According to Robin Murphy's suggestion: https://lkml.org/lkml/2021/1/20/470
>> Don't reserve the PMCG register spaces, and reserve the entire SMMU register space.
>>
>> v1:
>> Since the PMCG may implement its resigters space(4KB Page0 and 4KB Page1)
>> within the SMMUv3 64KB Page0. In this case, when the SMMUv3 driver reserves the
>> 64KB Page0 resource in advance, the PMCG driver try to reserve its Page0 and
>> Page1 resources, a resource conflict occurs.
>>
>> commit 52f3fab0067d6fa ("iommu/arm-smmu-v3: Don't reserve implementation
>> defined register space") reduce the resource reservation range of the SMMUv3
>> driver, it only reserves the first 0xe00 bytes in the 64KB Page0, to avoid
>> the above-mentioned resource conflicts.
>>
>> But the SMMUv3.3 add support for ECMDQ, its registers space is also implemented
>> in the SMMUv3 64KB Page0. This means we need to build two separate mappings.
>> New features may be added in the future, and more independent mappings may be
>> required. The simple problem is complicated because the user expects to map the
>> entire SMMUv3 64KB Page0.
>>
>> Therefore, the proper solution is: If the PMCG register resources are located in
>> the 64KB Page0 of the SMMU, the PMCG driver does not reserve the conflict resources
>> when the SMMUv3 driver has reserved the conflict resources before. Instead, the PMCG
>> driver only performs devm_ioremap() to ensure that it can work properly.
>>
>> Zhen Lei (3):
>>   perf/smmuv3: Don't reserve the PMCG register spaces
>>   perf/smmuv3: Add a MODULE_SOFTDEP() to indicate dependency on SMMU
>>   iommu/arm-smmu-v3: Reserving the entire SMMU register space
> 
> I'll need Robin's ack on these.

Hi, Robin:
  What's your opinion?
  In fact, I have written the patches that SMMU and PMCG whoever come first
will reserve the resources, and whoever comes next does not reserve. However,
the processing logic is relatively complex.

> 
> Will
> 
> .
> 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
