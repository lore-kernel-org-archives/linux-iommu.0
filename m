Return-Path: <SRS0=J3Yr=GZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FFFEC433E0
	for <iommu@archiver.kernel.org>; Fri, 22 Jan 2021 12:53:47 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29BC423106
	for <iommu@archiver.kernel.org>; Fri, 22 Jan 2021 12:53:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29BC423106
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id B5D1D86EA5;
	Fri, 22 Jan 2021 12:53:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dLXDSvwJcXGO; Fri, 22 Jan 2021 12:53:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id B8E9286EA2;
	Fri, 22 Jan 2021 12:53:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8B777C088B;
	Fri, 22 Jan 2021 12:53:44 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3FF60C013A
 for <iommu@lists.linux-foundation.org>; Fri, 22 Jan 2021 12:53:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 2D951872FE
 for <iommu@lists.linux-foundation.org>; Fri, 22 Jan 2021 12:53:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jd2slddvK+nw for <iommu@lists.linux-foundation.org>;
 Fri, 22 Jan 2021 12:53:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by hemlock.osuosl.org (Postfix) with ESMTP id 34E36872F7
 for <iommu@lists.linux-foundation.org>; Fri, 22 Jan 2021 12:53:42 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9BD7511B3;
 Fri, 22 Jan 2021 04:53:41 -0800 (PST)
Received: from [10.57.39.58] (unknown [10.57.39.58])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2AF2D3F66E;
 Fri, 22 Jan 2021 04:53:18 -0800 (PST)
Subject: Re: [PATCH v2 1/3] iommu/arm-smmu: Add support for driver IOMMU fault
 handlers
To: Will Deacon <will@kernel.org>, Jordan Crouse <jcrouse@codeaurora.org>
References: <20201124191600.2051751-1-jcrouse@codeaurora.org>
 <20201124191600.2051751-2-jcrouse@codeaurora.org>
 <20210122124125.GA24102@willie-the-truck>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <8ba2f53d-abbf-af7f-07f6-48ad7f383a37@arm.com>
Date: Fri, 22 Jan 2021 12:53:17 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210122124125.GA24102@willie-the-truck>
Content-Language: en-GB
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-arm-kernel@lists.infradead.org
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

On 2021-01-22 12:41, Will Deacon wrote:
> On Tue, Nov 24, 2020 at 12:15:58PM -0700, Jordan Crouse wrote:
>> Call report_iommu_fault() to allow upper-level drivers to register their
>> own fault handlers.
>>
>> Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
>> ---
>>
>>   drivers/iommu/arm/arm-smmu/arm-smmu.c | 16 +++++++++++++---
>>   1 file changed, 13 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
>> index 0f28a8614da3..7fd18bbda8f5 100644
>> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
>> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
>> @@ -427,6 +427,7 @@ static irqreturn_t arm_smmu_context_fault(int irq, void *dev)
>>   	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
>>   	struct arm_smmu_device *smmu = smmu_domain->smmu;
>>   	int idx = smmu_domain->cfg.cbndx;
>> +	int ret;
>>   
>>   	fsr = arm_smmu_cb_read(smmu, idx, ARM_SMMU_CB_FSR);
>>   	if (!(fsr & ARM_SMMU_FSR_FAULT))
>> @@ -436,11 +437,20 @@ static irqreturn_t arm_smmu_context_fault(int irq, void *dev)
>>   	iova = arm_smmu_cb_readq(smmu, idx, ARM_SMMU_CB_FAR);
>>   	cbfrsynra = arm_smmu_gr1_read(smmu, ARM_SMMU_GR1_CBFRSYNRA(idx));
>>   
>> -	dev_err_ratelimited(smmu->dev,
>> -	"Unhandled context fault: fsr=0x%x, iova=0x%08lx, fsynr=0x%x, cbfrsynra=0x%x, cb=%d\n",
>> +	ret = report_iommu_fault(domain, dev, iova,
>> +		fsynr & ARM_SMMU_FSYNR0_WNR ? IOMMU_FAULT_WRITE : IOMMU_FAULT_READ);
>> +
>> +	if (ret == -ENOSYS)
>> +		dev_err_ratelimited(smmu->dev,
>> +		"Unhandled context fault: fsr=0x%x, iova=0x%08lx, fsynr=0x%x, cbfrsynra=0x%x, cb=%d\n",
>>   			    fsr, iova, fsynr, cbfrsynra, idx);
>>   
>> -	arm_smmu_cb_write(smmu, idx, ARM_SMMU_CB_FSR, fsr);
>> +	/*
>> +	 * If the iommu fault returns an error (except -ENOSYS) then assume that
>> +	 * they will handle resuming on their own
>> +	 */
>> +	if (!ret || ret == -ENOSYS)
>> +		arm_smmu_cb_write(smmu, idx, ARM_SMMU_CB_FSR, fsr);
> 
> Hmm, I don't grok this part. If the fault handler returned an error and
> we don't clear the FSR, won't we just re-take the irq immediately?

If we don't touch the FSR at all, yes. Even if we clear the fault 
indicator bits, the interrupt *might* remain asserted until a stalled 
transaction is actually resolved - that's that lovely IMP-DEF corner.

Robin.

> I think
> it would be better to do this unconditionally, and print the "Unhandled
> context fault" message for any non-zero value of ret.
> 
> Will
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
