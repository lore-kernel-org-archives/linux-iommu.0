Return-Path: <SRS0=meaX=6A=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B8EEC2BB85
	for <iommu@archiver.kernel.org>; Thu, 16 Apr 2020 16:24:08 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7DAB20857
	for <iommu@archiver.kernel.org>; Thu, 16 Apr 2020 16:24:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="wDNWiqZb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7DAB20857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id AD5AF86B67;
	Thu, 16 Apr 2020 16:24:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nWu6XPWdtgKG; Thu, 16 Apr 2020 16:24:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id BA62586BEC;
	Thu, 16 Apr 2020 16:24:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9F3C7C1AE8;
	Thu, 16 Apr 2020 16:24:06 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B6F0FC0172
 for <iommu@lists.linux-foundation.org>; Thu, 16 Apr 2020 16:24:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id ADFE587E9C
 for <iommu@lists.linux-foundation.org>; Thu, 16 Apr 2020 16:24:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oWUS05OqOMqA for <iommu@lists.linux-foundation.org>;
 Thu, 16 Apr 2020 16:24:03 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail27.static.mailgun.info (mail27.static.mailgun.info
 [104.130.122.27])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 718D587E93
 for <iommu@lists.linux-foundation.org>; Thu, 16 Apr 2020 16:24:03 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1587054243; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=bwde/P04Uj3GTzNnCbAcH3UyrPWOeOqsIWQwb1Jxqqc=;
 b=wDNWiqZbI1eJJvKhi8Hk3uP883nhclWKZzU3NgLKzA6yyy27lw9NXdOYkkRq+IpM7tVM1buF
 9FvsJ3WhMR8nt3rZ4yuYKVQABnslp4rZu4rBWJr1xaKIi/m/3ycMPgkC0P+K79syUnK/oRe/
 qR2GxcAc91c13gsG0UR3yp2LLDM=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3NDkwMCIsICJpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e9886a1.7fbac3363ea0-smtp-out-n05;
 Thu, 16 Apr 2020 16:24:01 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id A0736C4478C; Thu, 16 Apr 2020 16:23:59 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: saiprakash.ranjan)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 8065AC433BA;
 Thu, 16 Apr 2020 16:23:58 +0000 (UTC)
MIME-Version: 1.0
Date: Thu, 16 Apr 2020 21:53:58 +0530
From: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 2/2] iommu/arm-smmu: Allow client devices to select direct
 mapping
In-Reply-To: <3f12cefb-3887-859c-ddf5-c7a0fc755152@arm.com>
References: <cover.1579692800.git.saiprakash.ranjan@codeaurora.org>
 <813cc5b2da10c27db982254b274bf26008a9e6da.1579692800.git.saiprakash.ranjan@codeaurora.org>
 <3f12cefb-3887-859c-ddf5-c7a0fc755152@arm.com>
Message-ID: <540fc55811d0a60a929ff1f694d6d271@codeaurora.org>
X-Sender: saiprakash.ranjan@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Cc: Rajendra Nayak <rnayak@codeaurora.org>, linux-arm-msm@vger.kernel.org,
 iommu@lists.linux-foundation.org, Matthias Kaehlcke <mka@chromium.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 linux-arm-kernel@lists.infradead.org, Stephen Boyd <swboyd@chromium.org>,
 Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
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

Hi Robin,

On 2020-04-16 19:28, Robin Murphy wrote:
> On 2020-01-22 11:48 am, Sai Prakash Ranjan wrote:
>> From: Jordan Crouse <jcrouse@codeaurora.org>
>> 
>> Some client devices want to directly map the IOMMU themselves instead
>> of using the DMA domain. Allow those devices to opt in to direct
>> mapping by way of a list of compatible strings.
>> 
>> Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
>> Co-developed-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
>> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
>> ---
>>   drivers/iommu/arm-smmu-qcom.c | 39 
>> +++++++++++++++++++++++++++++++++++
>>   drivers/iommu/arm-smmu.c      |  3 +++
>>   drivers/iommu/arm-smmu.h      |  5 +++++
>>   3 files changed, 47 insertions(+)
>> 
>> diff --git a/drivers/iommu/arm-smmu-qcom.c 
>> b/drivers/iommu/arm-smmu-qcom.c
>> index 64a4ab270ab7..ff746acd1c81 100644
>> --- a/drivers/iommu/arm-smmu-qcom.c
>> +++ b/drivers/iommu/arm-smmu-qcom.c
>> @@ -3,6 +3,7 @@
>>    * Copyright (c) 2019, The Linux Foundation. All rights reserved.
>>    */
>>   +#include <linux/of_device.h>
>>   #include <linux/qcom_scm.h>
>>     #include "arm-smmu.h"
>> @@ -11,6 +12,43 @@ struct qcom_smmu {
>>   	struct arm_smmu_device smmu;
>>   };
>>   +static const struct arm_smmu_client_match_data qcom_adreno = {
>> +	.direct_mapping = true,
>> +};
>> +
>> +static const struct arm_smmu_client_match_data qcom_mdss = {
>> +	.direct_mapping = true,
>> +};
> 
> Might it make sense to group these by the desired SMMU behaviour
> rather than (apparently) what kind of device the client happens to be,
> which seems like a completely arbitrary distinction from the SMMU
> driver's PoV?
> 

Sorry, I did not get the "grouping by the desired SMMU behaviour" thing.
Could you please give some more details?

>> +
>> +static const struct of_device_id qcom_smmu_client_of_match[] = {
>> +	{ .compatible = "qcom,adreno", .data = &qcom_adreno },
>> +	{ .compatible = "qcom,mdp4", .data = &qcom_mdss },
>> +	{ .compatible = "qcom,mdss", .data = &qcom_mdss },
>> +	{ .compatible = "qcom,sc7180-mdss", .data = &qcom_mdss },
>> +	{ .compatible = "qcom,sdm845-mdss", .data = &qcom_mdss },
>> +	{},
>> +};
>> +
>> +static const struct arm_smmu_client_match_data *
>> +qcom_smmu_client_data(struct device *dev)
>> +{
>> +	const struct of_device_id *match =
>> +		of_match_device(qcom_smmu_client_of_match, dev);
>> +
>> +	return match ? match->data : NULL;
> 
> of_device_get_match_data() is your friend.
> 

Ok will use it.

>> +}
>> +
>> +static int qcom_smmu_request_domain(struct device *dev)
>> +{
>> +	const struct arm_smmu_client_match_data *client;
>> +
>> +	client = qcom_smmu_client_data(dev);
>> +	if (client)
>> +		iommu_request_dm_for_dev(dev);
>> +
>> +	return 0;
>> +}
>> +
>>   static int qcom_sdm845_smmu500_reset(struct arm_smmu_device *smmu)
>>   {
>>   	int ret;
>> @@ -41,6 +79,7 @@ static int qcom_smmu500_reset(struct arm_smmu_device 
>> *smmu)
>>   }
>>     static const struct arm_smmu_impl qcom_smmu_impl = {
>> +	.req_domain = qcom_smmu_request_domain,
>>   	.reset = qcom_smmu500_reset,
>>   };
>>   diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
>> index 16c4b87af42b..67dd9326247a 100644
>> --- a/drivers/iommu/arm-smmu.c
>> +++ b/drivers/iommu/arm-smmu.c
>> @@ -1448,6 +1448,9 @@ static int arm_smmu_add_device(struct device 
>> *dev)
>>   	device_link_add(dev, smmu->dev,
>>   			DL_FLAG_PM_RUNTIME | DL_FLAG_AUTOREMOVE_SUPPLIER);
>>   +	if (smmu->impl && smmu->impl->req_domain)
>> +		return smmu->impl->req_domain(dev);
>> +
> 
> There are about 5 different patchsets flying around at the moment that
> all touch default domain allocation, so this is a fast-moving target,
> but I think where the dust should settle is with arm_smmu_ops
> forwarding .def_domain_type (or whatever it ends up as) calls to
> arm_smmu_impl as appropriate.
> 

I'll wait till the dust settles down and then post the next version.

>>   	return 0;
>>     out_cfg_free:
>> diff --git a/drivers/iommu/arm-smmu.h b/drivers/iommu/arm-smmu.h
>> index 8d1cd54d82a6..059dc9c39f64 100644
>> --- a/drivers/iommu/arm-smmu.h
>> +++ b/drivers/iommu/arm-smmu.h
>> @@ -244,6 +244,10 @@ enum arm_smmu_arch_version {
>>   	ARM_SMMU_V2,
>>   };
>>   +struct arm_smmu_client_match_data {
>> +	bool direct_mapping;
>> +};
> 
> Does this need to be public? I don't see the other users...
> 

Will move this out.

Thanks,
Sai

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a 
member
of Code Aurora Forum, hosted by The Linux Foundation
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
