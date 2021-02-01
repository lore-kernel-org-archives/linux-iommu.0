Return-Path: <SRS0=Rmex=HD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4C60C433E6
	for <iommu@archiver.kernel.org>; Mon,  1 Feb 2021 12:53:28 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16B3364ED8
	for <iommu@archiver.kernel.org>; Mon,  1 Feb 2021 12:53:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16B3364ED8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id C800485D3A;
	Mon,  1 Feb 2021 12:53:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AiQPcw2m4LMt; Mon,  1 Feb 2021 12:53:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 0516185D39;
	Mon,  1 Feb 2021 12:53:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 87D47C0174;
	Mon,  1 Feb 2021 12:53:25 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E553CC013A
 for <iommu@lists.linux-foundation.org>; Mon,  1 Feb 2021 12:53:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id CAEC885CC7
 for <iommu@lists.linux-foundation.org>; Mon,  1 Feb 2021 12:53:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YhevDRHlRS+T for <iommu@lists.linux-foundation.org>;
 Mon,  1 Feb 2021 12:53:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 3E19D863A6
 for <iommu@lists.linux-foundation.org>; Mon,  1 Feb 2021 12:53:22 +0000 (UTC)
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
 by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4DTnry0dngz7fHl;
 Mon,  1 Feb 2021 20:52:02 +0800 (CST)
Received: from [127.0.0.1] (10.40.188.87) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.498.0; Mon, 1 Feb 2021
 20:53:12 +0800
Subject: Re: [PATCH v12 10/10] iommu/arm-smmu-v3: Add stall support for
 platform devices
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
References: <20210127154322.3959196-1-jean-philippe@linaro.org>
 <20210127154322.3959196-11-jean-philippe@linaro.org>
 <8adc79cc-7afb-dfe8-4f7b-07fa6dc5b905@hisilicon.com>
 <YBfij71tyYvh8LhB@myrica>
From: Zhou Wang <wangzhou1@hisilicon.com>
Message-ID: <ddeae968-62c8-63ce-c531-035f6f9a9968@hisilicon.com>
Date: Mon, 1 Feb 2021 20:53:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <YBfij71tyYvh8LhB@myrica>
X-Originating-IP: [10.40.188.87]
X-CFilter-Loop: Reflected
Cc: devicetree@vger.kernel.org, kevin.tian@intel.com,
 linux-acpi@vger.kernel.org, robin.murphy@arm.com, sudeep.holla@arm.com,
 rjw@rjwysocki.net, vivek.gautam@arm.com, iommu@lists.linux-foundation.org,
 robh+dt@kernel.org, linux-accelerators@lists.ozlabs.org, guohanjun@huawei.com,
 zhangfei.gao@linaro.org, will@kernel.org, linux-arm-kernel@lists.infradead.org,
 lenb@kernel.org
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

On 2021/2/1 19:14, Jean-Philippe Brucker wrote:
> Hi Zhou,
> 
> On Mon, Feb 01, 2021 at 09:18:42AM +0800, Zhou Wang wrote:
>>> @@ -1033,8 +1076,7 @@ int arm_smmu_write_ctx_desc(struct arm_smmu_domain *smmu_domain, int ssid,
>>>  			FIELD_PREP(CTXDESC_CD_0_ASID, cd->asid) |
>>>  			CTXDESC_CD_0_V;
>>>  
>>> -		/* STALL_MODEL==0b10 && CD.S==0 is ILLEGAL */
>>> -		if (smmu->features & ARM_SMMU_FEAT_STALL_FORCE)
>>> +		if (smmu_domain->stall_enabled)
>>
>> Could we add ssid checking here? like: if (smmu_domain->stall_enabled && ssid).
>> The reason is if not CD.S will also be set when ssid is 0, which is not needed.
> 
> Some drivers may want to get stall events on SSID 0:
> https://lore.kernel.org/kvm/20210125090402.1429-1-lushenming@huawei.com/#t

Hi Jean,

I did not notice this before. Yes, if we need to support IOPF in vfio, we
need enable stall events on SSID 0.

> 
> Are you seeing an issue with stall events on ssid 0?  Normally there
> shouldn't be any fault on this context, but if they happen and no handler

It happened that there is bug in the test code of HiSilicon HPRE crypto driver.
We used a wrong iova which triggered a SMMU event with stall bit :)

> is registered, the SMMU driver will just abort them and report them like a
> non-stall event.

It will report event 0x10 with stall bit.

Best,
Zhou

> 
> Thanks,
> Jean
> 
> .
> 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
