Return-Path: <SRS0=UfkB=G5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96614C433E0
	for <iommu@archiver.kernel.org>; Tue, 26 Jan 2021 11:41:09 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E26723110
	for <iommu@archiver.kernel.org>; Tue, 26 Jan 2021 11:41:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E26723110
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id C508885513;
	Tue, 26 Jan 2021 11:41:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wH2ZcnF0_w8x; Tue, 26 Jan 2021 11:41:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 8F3198544C;
	Tue, 26 Jan 2021 11:41:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 671F1C08A1;
	Tue, 26 Jan 2021 11:41:07 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 07A72C013A
 for <iommu@lists.linux-foundation.org>; Tue, 26 Jan 2021 11:41:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id DF19D203BB
 for <iommu@lists.linux-foundation.org>; Tue, 26 Jan 2021 11:41:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yenr4teOIM75 for <iommu@lists.linux-foundation.org>;
 Tue, 26 Jan 2021 11:41:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by silver.osuosl.org (Postfix) with ESMTP id 8CCB720396
 for <iommu@lists.linux-foundation.org>; Tue, 26 Jan 2021 11:41:01 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6BE5F101E;
 Tue, 26 Jan 2021 03:41:00 -0800 (PST)
Received: from [10.57.43.46] (unknown [10.57.43.46])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 231C13F66B;
 Tue, 26 Jan 2021 03:40:59 -0800 (PST)
Subject: Re: [PATCH v2 1/3] iommu/arm-smmu: Add support for driver IOMMU fault
 handlers
To: Will Deacon <will@kernel.org>, linux-arm-msm@vger.kernel.org,
 iommu@lists.linux-foundation.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Joerg Roedel <joro@8bytes.org>, Krishna Reddy <vdumpa@nvidia.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20201124191600.2051751-1-jcrouse@codeaurora.org>
 <20201124191600.2051751-2-jcrouse@codeaurora.org>
 <20210122124125.GA24102@willie-the-truck>
 <8ba2f53d-abbf-af7f-07f6-48ad7f383a37@arm.com>
 <20210125215107.GB16374@jcrouse1-lnx.qualcomm.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <dc035204-ade7-03ec-0b82-2ecedc856d42@arm.com>
Date: Tue, 26 Jan 2021 11:40:57 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210125215107.GB16374@jcrouse1-lnx.qualcomm.com>
Content-Language: en-GB
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

On 2021-01-25 21:51, Jordan Crouse wrote:
> On Fri, Jan 22, 2021 at 12:53:17PM +0000, Robin Murphy wrote:
>> On 2021-01-22 12:41, Will Deacon wrote:
>>> On Tue, Nov 24, 2020 at 12:15:58PM -0700, Jordan Crouse wrote:
>>>> Call report_iommu_fault() to allow upper-level drivers to register their
>>>> own fault handlers.
>>>>
>>>> Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
>>>> ---
>>>>
>>>>   drivers/iommu/arm/arm-smmu/arm-smmu.c | 16 +++++++++++++---
>>>>   1 file changed, 13 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
>>>> index 0f28a8614da3..7fd18bbda8f5 100644
>>>> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
>>>> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
>>>> @@ -427,6 +427,7 @@ static irqreturn_t arm_smmu_context_fault(int irq, void *dev)
>>>>   	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
>>>>   	struct arm_smmu_device *smmu = smmu_domain->smmu;
>>>>   	int idx = smmu_domain->cfg.cbndx;
>>>> +	int ret;
>>>>   	fsr = arm_smmu_cb_read(smmu, idx, ARM_SMMU_CB_FSR);
>>>>   	if (!(fsr & ARM_SMMU_FSR_FAULT))
>>>> @@ -436,11 +437,20 @@ static irqreturn_t arm_smmu_context_fault(int irq, void *dev)
>>>>   	iova = arm_smmu_cb_readq(smmu, idx, ARM_SMMU_CB_FAR);
>>>>   	cbfrsynra = arm_smmu_gr1_read(smmu, ARM_SMMU_GR1_CBFRSYNRA(idx));
>>>> -	dev_err_ratelimited(smmu->dev,
>>>> -	"Unhandled context fault: fsr=0x%x, iova=0x%08lx, fsynr=0x%x, cbfrsynra=0x%x, cb=%d\n",
>>>> +	ret = report_iommu_fault(domain, dev, iova,
>>>> +		fsynr & ARM_SMMU_FSYNR0_WNR ? IOMMU_FAULT_WRITE : IOMMU_FAULT_READ);
>>>> +
>>>> +	if (ret == -ENOSYS)
>>>> +		dev_err_ratelimited(smmu->dev,
>>>> +		"Unhandled context fault: fsr=0x%x, iova=0x%08lx, fsynr=0x%x, cbfrsynra=0x%x, cb=%d\n",
>>>>   			    fsr, iova, fsynr, cbfrsynra, idx);
>>>> -	arm_smmu_cb_write(smmu, idx, ARM_SMMU_CB_FSR, fsr);
>>>> +	/*
>>>> +	 * If the iommu fault returns an error (except -ENOSYS) then assume that
>>>> +	 * they will handle resuming on their own
>>>> +	 */
>>>> +	if (!ret || ret == -ENOSYS)
>>>> +		arm_smmu_cb_write(smmu, idx, ARM_SMMU_CB_FSR, fsr);
>>>
>>> Hmm, I don't grok this part. If the fault handler returned an error and
>>> we don't clear the FSR, won't we just re-take the irq immediately?
>>
>> If we don't touch the FSR at all, yes. Even if we clear the fault indicator
>> bits, the interrupt *might* remain asserted until a stalled transaction is
>> actually resolved - that's that lovely IMP-DEF corner.
>>
>> Robin.
>>
> 
> This is for stall-on-fault. The idea is that if the developer chooses to do so
> we would stall the GPU after a fault long enough to take a picture of it with
> devcoredump and then release the FSR. Since we can't take the devcoredump from
> the interrupt handler we schedule it in a worker and then return an error
> to let the main handler know that we'll come back around clear the FSR later
> when we are done.

Sure, but clearing FSR is not writing to RESUME to resolve the stalled 
transaction(s). You can already snarf the FSR contents from your 
report_iommu_fault() handler if you want to, so either way I don't see 
what's gained by not clearing it as expected at the point where we've 
handled the *interrupt*, even if it will take longer to decide what to 
do with the underlying *fault* that it signalled. I'm particularly not 
keen on having unusual behaviour in the core interrupt handling which 
callers may unwittingly trigger, for the sake of one 
very-very-driver-specific flow having a slightly richer debugging 
experience.

For actually *handling* faults, I thought we were going to need to hook 
up the new IOPF fault queue stuff anyway?

Robin.

> It is assumed that we'll have to turn off interrupts in our handler to allow
> this to work. Its all very implementation specific, but then again we're
> assuming that if you want to do this then you know what you are doing.
> 
> In that spirit the error that skips the FSR should probably be something
> specific instead of "all errors" - that way a well meaning handler that returns
> a -EINVAL doesn't accidentally break itself.
> 
> Jordan
> 
>>> I think
>>> it would be better to do this unconditionally, and print the "Unhandled
>>> context fault" message for any non-zero value of ret.
> 
>>>
>>> Will
>>>
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
