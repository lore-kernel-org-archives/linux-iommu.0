Return-Path: <SRS0=8SnF=MO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C544C6377D
	for <iommu@archiver.kernel.org>; Thu, 22 Jul 2021 06:34:45 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F21B06024A
	for <iommu@archiver.kernel.org>; Thu, 22 Jul 2021 06:34:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F21B06024A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id AFDB2401CF;
	Thu, 22 Jul 2021 06:34:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eJRtTPdgiFF4; Thu, 22 Jul 2021 06:34:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id C51FE40200;
	Thu, 22 Jul 2021 06:34:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9D5AFC001A;
	Thu, 22 Jul 2021 06:34:42 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3E825C000E
 for <iommu@lists.linux-foundation.org>; Thu, 22 Jul 2021 06:34:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 077A740173
 for <iommu@lists.linux-foundation.org>; Thu, 22 Jul 2021 06:34:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aZezjpbcOHzz for <iommu@lists.linux-foundation.org>;
 Thu, 22 Jul 2021 06:34:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A85FB40172
 for <iommu@lists.linux-foundation.org>; Thu, 22 Jul 2021 06:34:38 +0000 (UTC)
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.55])
 by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4GVjFp12yFz1CM75;
 Thu, 22 Jul 2021 14:28:46 +0800 (CST)
Received: from dggpemm500004.china.huawei.com (7.185.36.219) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 22 Jul 2021 14:34:33 +0800
Received: from [10.174.177.91] (10.174.177.91) by
 dggpemm500004.china.huawei.com (7.185.36.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 22 Jul 2021 14:34:33 +0800
Subject: Re: [PATCH -next] iommu/arm-smmu-v3: Add suspend and resume support
To: Marc Zyngier <maz@kernel.org>, Robin Murphy <robin.murphy@arm.com>
References: <20210721013350.17664-1-cuibixuan@huawei.com>
 <4e506481-5f6c-9c5e-eda3-300861581080@arm.com> <878s1z3j68.wl-maz@kernel.org>
 <848befb0-7a9a-0b2b-8be9-3dfa02919488@arm.com> <877dhj3e4b.wl-maz@kernel.org>
From: Bixuan Cui <cuibixuan@huawei.com>
Message-ID: <5054a5cd-579f-3fe9-1884-5219c8d13531@huawei.com>
Date: Thu, 22 Jul 2021 14:34:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <877dhj3e4b.wl-maz@kernel.org>
Content-Language: en-US
X-Originating-IP: [10.174.177.91]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500004.china.huawei.com (7.185.36.219)
X-CFilter-Loop: Reflected
Cc: jean-philippe@linaro.org, guohanjun@huawei.com,
 linux-kernel@vger.kernel.org, john.wanghui@huawei.com,
 iommu@lists.linux-foundation.org, weiyongjun1@huawei.com,
 dingtianhong@huawei.com, will@kernel.org, linux-arm-kernel@lists.infradead.org
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



On 2021/7/21 23:01, Marc Zyngier wrote:
> On Wed, 21 Jul 2021 14:59:47 +0100,
> Robin Murphy <robin.murphy@arm.com> wrote:
>>
>> On 2021-07-21 14:12, Marc Zyngier wrote:
>>> On Wed, 21 Jul 2021 12:42:14 +0100,
>>> Robin Murphy <robin.murphy@arm.com> wrote:
>>>>
>>>> [ +Marc for MSI bits ]
>>>>
>>>> On 2021-07-21 02:33, Bixuan Cui wrote:
>>>>> Add suspend and resume support for arm-smmu-v3 by low-power mode.
>>>>>
>>>>> When the smmu is suspended, it is powered off and the registers are
>>>>> cleared. So saves the msi_msg context during msi interrupt initialization
>>>>> of smmu. When resume happens it calls arm_smmu_device_reset() to restore
>>>>> the registers.
>>>>>
>>>>> Signed-off-by: Bixuan Cui <cuibixuan@huawei.com>
>>>>> Reviewed-by: Wei Yongjun <weiyongjun1@huawei.com>
>>>>> Reviewed-by: Zhen Lei <thunder.leizhen@huawei.com>
>>>>> Reviewed-by: Ding Tianhong <dingtianhong@huawei.com>
>>>>> Reviewed-by: Hanjun Guo <guohanjun@huawei.com>
>>>>> ---
>>>>>
>>>>>    drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 72 ++++++++++++++++++---
>>>>>    1 file changed, 64 insertions(+), 8 deletions(-)
>>>>>
>>>>> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>>>>> index 235f9bdaeaf2..bf1163acbcb1 100644
>>>>> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>>>>> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>>>>> @@ -40,6 +40,7 @@ MODULE_PARM_DESC(disable_bypass,
>>>>>      static bool disable_msipolling;
>>>>>    module_param(disable_msipolling, bool, 0444);
>>>>> +static bool bypass;
>>>>>    MODULE_PARM_DESC(disable_msipolling,
>>>>>    	"Disable MSI-based polling for CMD_SYNC completion.");
>>>>>    @@ -3129,11 +3130,37 @@ static void arm_smmu_write_msi_msg(struct
>>>>> msi_desc *desc, struct msi_msg *msg)
>>>>>    	doorbell = (((u64)msg->address_hi) << 32) | msg->address_lo;
>>>>>    	doorbell &= MSI_CFG0_ADDR_MASK;
>>>>>    +	/* Saves the msg context for resume if desc->msg is empty */
>>>>> +	if (desc->msg.address_lo == 0 && desc->msg.address_hi == 0) {
>>>>> +		desc->msg.address_lo = msg->address_lo;
>>>>> +		desc->msg.address_hi = msg->address_hi;
>>>>> +		desc->msg.data = msg->data;
>>>>> +	}
>>>>
>>>> My gut feeling is that this is something a device driver maybe
>>>> shouldn't be poking into, but I'm not entirely familiar with the area
>>>> :/
>>>
>>> Certainly not. If you rely on the message being stored into the
>>> descriptors, then implement this in the core code, like we do for PCI.
>>
>> Ah, so it would be an acceptable compromise to *read* desc->msg (and
>> thus avoid having to store our own copy of the message) if the core
>> was guaranteed to cache it? That's good to know, thanks.
> 
> Yeah, vfio, a couple of other weird drivers and (*surprise!*) ia64 are
> using this kind of trick. I don't see a reason not to implement that
> for platform-MSI (although level signalling may be interesting...), or
> even to move it into the core MSI code.
Agree. If msg is saved to desc->msg in MSI core, the code here will not need.
During the initialization of the MSI interrupt of the SMMU, the desc->msg
is never used. So I save msg to desc->msg for resume use.


>>
>>>>> +
>>>>>    	writeq_relaxed(doorbell, smmu->base + cfg[0]);
>>>>>    	writel_relaxed(msg->data, smmu->base + cfg[1]);
>>>>>    	writel_relaxed(ARM_SMMU_MEMATTR_DEVICE_nGnRE, smmu->base + cfg[2]);
>>>>>    }
>>>>>    +static void arm_smmu_resume_msis(struct arm_smmu_device *smmu)
>>>>> +{
>>>>> +	struct msi_desc *desc;
>>>>> +	struct device *dev = smmu->dev;
>>>>> +
>>>>> +	for_each_msi_entry(desc, dev) {
>>>>> +		switch (desc->platform.msi_index) {
>>>>> +		case EVTQ_MSI_INDEX:
>>>>> +		case GERROR_MSI_INDEX:
>>>>> +		case PRIQ_MSI_INDEX:
>>>>> +			arm_smmu_write_msi_msg(desc, &(desc->msg));
>>>
>>> Consider using get_cached_msi_msg() instead of using the internals of
>>> the descriptor.
>>
>> Oh, there's even a proper API for it, marvellous! I hadn't managed to
>> dig that far myself :)
> 
> It is a bit odd in the sense that it takes a copy of the message
> instead of returning a pointer, but at least this solves lifetime
> issues.
The code of arm_smmu_write_msi_msg() is multiplexed to restore the register. Therefore,
the parameter must be supplemented. Generally, desc is sufficient as an input parameter..
:)

Thanks,
Bixuan Cui
> 
> Thanks,
> 
> 	M.
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
