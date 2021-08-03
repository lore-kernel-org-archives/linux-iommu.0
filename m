Return-Path: <SRS0=qwh6=M2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C88A2C4338F
	for <iommu@archiver.kernel.org>; Tue,  3 Aug 2021 06:06:24 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 797D860F8F
	for <iommu@archiver.kernel.org>; Tue,  3 Aug 2021 06:06:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 797D860F8F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4130A82F37;
	Tue,  3 Aug 2021 06:06:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id w70VLnNqoDwK; Tue,  3 Aug 2021 06:06:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 23D4582E95;
	Tue,  3 Aug 2021 06:06:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 09277C0010;
	Tue,  3 Aug 2021 06:06:23 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 89DD4C000E
 for <iommu@lists.linux-foundation.org>; Tue,  3 Aug 2021 06:06:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with UTF8SMTP id 642A340261
 for <iommu@lists.linux-foundation.org>; Tue,  3 Aug 2021 06:06:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=mg.codeaurora.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with UTF8SMTP id 8T8ogTFSLMDc for <iommu@lists.linux-foundation.org>;
 Tue,  3 Aug 2021 06:06:21 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from so254-9.mailgun.net (so254-9.mailgun.net [198.61.254.9])
 by smtp2.osuosl.org (Postfix) with UTF8SMTPS id D9F804016F
 for <iommu@lists.linux-foundation.org>; Tue,  3 Aug 2021 06:06:18 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1627970781; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=2cVRR6X0LJPFMsvW7MYfIuMqP7lLF7KckuG7UikunoI=;
 b=KlLLkjjbhzIgAxq8DJfoaCRIJS3HeMvBLevQrkQ9hBYUoSZ/nh6F0nMk/f0JhqWw2YA4DQst
 HxOvLzKBicyXLnKWeKydXD76h8XqokuntgrLLZ+teL0veJV8FdLrhMPKIn+9x+CO/6GOawmn
 3RDuxaQ1ZQVgTvcnif2PuwRHLrg=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3NDkwMCIsICJpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 6108dcd59771b05b243088ee (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 03 Aug 2021 06:06:13
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id 2443EC4338A; Tue,  3 Aug 2021 06:06:13 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: saiprakash.ranjan)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 296A2C433D3;
 Tue,  3 Aug 2021 06:06:12 +0000 (UTC)
MIME-Version: 1.0
Date: Tue, 03 Aug 2021 11:36:12 +0530
From: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To: Will Deacon <will@kernel.org>
Subject: Re: [PATCH] iommu/arm-smmu: Add clk_bulk_{prepare/unprepare} to
 system pm callbacks
In-Reply-To: <20210802161206.GA29168@willie-the-truck>
References: <20210727093322.13202-1-saiprakash.ranjan@codeaurora.org>
 <20210802161206.GA29168@willie-the-truck>
Message-ID: <5aefcc8950ec8ced0a67815c92e985df@codeaurora.org>
X-Sender: saiprakash.ranjan@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Cc: Taniya Das <tdas@codeaurora.org>, robdclark@chromium.org,
 Rajendra Nayak <rnayak@codeaurora.org>, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Robin Murphy <robin.murphy@arm.com>, srimuc <srimuc@codeaurora.org>,
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

On 2021-08-02 21:42, Will Deacon wrote:
> On Tue, Jul 27, 2021 at 03:03:22PM +0530, Sai Prakash Ranjan wrote:
>> Some clocks for SMMU can have parent as XO such as 
>> gpu_cc_hub_cx_int_clk
>> of GPU SMMU in QTI SC7280 SoC and in order to enter deep sleep states 
>> in
>> such cases, we would need to drop the XO clock vote in unprepare call 
>> and
>> this unprepare callback for XO is in RPMh (Resource Power 
>> Manager-Hardened)
>> clock driver which controls RPMh managed clock resources for new QTI 
>> SoCs
>> and is a blocking call.
>> 
>> Given we cannot have a sleeping calls such as clk_bulk_prepare() and
>> clk_bulk_unprepare() in arm-smmu runtime pm callbacks since the iommu
>> operations like map and unmap can be in atomic context and are in fast
>> path, add this prepare and unprepare call to drop the XO vote only for
>> system pm callbacks since it is not a fast path and we expect the 
>> system
>> to enter deep sleep states with system pm as opposed to runtime pm.
>> 
>> This is a similar sequence of clock requests (prepare,enable and
>> disable,unprepare) in arm-smmu probe and remove.
>> 
>> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
>> Co-developed-by: Rajendra Nayak <rnayak@codeaurora.org>
>> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
>> ---
>>  drivers/iommu/arm/arm-smmu/arm-smmu.c | 20 ++++++++++++++++++--
>>  1 file changed, 18 insertions(+), 2 deletions(-)
> 
> [+Rob]
> 
> How does this work with that funny GPU which writes to the SMMU 
> registers
> directly? Does the SMMU need to remain independently clocked for that 
> to
> work or is it all in the same clock domain?
> 

As Rob mentioned, device link should take care of all the dependencies 
between
SMMU and its consumers. But not sure how the question relates to this 
patch as this
change is for system pm and not runtime pm, so it is exactly the 
sequence of
SMMU probe/remove which if works currently for that GPU SMMU, then it 
should work
just fine for system suspend and resume as well.

>> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c 
>> b/drivers/iommu/arm/arm-smmu/arm-smmu.c
>> index d3c6f54110a5..9561ba4c5d39 100644
>> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
>> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
>> @@ -2277,6 +2277,13 @@ static int __maybe_unused 
>> arm_smmu_runtime_suspend(struct device *dev)
>> 
>>  static int __maybe_unused arm_smmu_pm_resume(struct device *dev)
>>  {
>> +	int ret;
>> +	struct arm_smmu_device *smmu = dev_get_drvdata(dev);
>> +
>> +	ret = clk_bulk_prepare(smmu->num_clks, smmu->clks);
>> +	if (ret)
>> +		return ret;
>> +
>>  	if (pm_runtime_suspended(dev))
>>  		return 0;
> 
> If we subsequently fail to enable the clks in arm_smmu_runtime_resume()
> should we unprepare them again?
> 

If we are unable to turn on the clks then its fatal and we will not live 
for long.

Thanks,
Sai

> Will
> 
>> @@ -2285,10 +2292,19 @@ static int __maybe_unused 
>> arm_smmu_pm_resume(struct device *dev)
>> 
>>  static int __maybe_unused arm_smmu_pm_suspend(struct device *dev)
>>  {
>> +	int ret = 0;
>> +	struct arm_smmu_device *smmu = dev_get_drvdata(dev);
>> +
>>  	if (pm_runtime_suspended(dev))
>> -		return 0;
>> +		goto clk_unprepare;
>> 
>> -	return arm_smmu_runtime_suspend(dev);
>> +	ret = arm_smmu_runtime_suspend(dev);
>> +	if (ret)
>> +		return ret;
>> +
>> +clk_unprepare:
>> +	clk_bulk_unprepare(smmu->num_clks, smmu->clks);
>> +	return ret;
>>  }
>> 
>>  static const struct dev_pm_ops arm_smmu_pm_ops = {
>> --
>> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a 
>> member
>> of Code Aurora Forum, hosted by The Linux Foundation
>> 

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a 
member
of Code Aurora Forum, hosted by The Linux Foundation
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
