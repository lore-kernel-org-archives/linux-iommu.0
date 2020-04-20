Return-Path: <SRS0=cOz4=6E=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEB9BC54FD0
	for <iommu@archiver.kernel.org>; Mon, 20 Apr 2020 16:27:53 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 763B62074F
	for <iommu@archiver.kernel.org>; Mon, 20 Apr 2020 16:27:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="tku8QpzB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 763B62074F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 4A17F21509;
	Mon, 20 Apr 2020 16:27:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zq-3m4DinmCq; Mon, 20 Apr 2020 16:27:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 317EA2035B;
	Mon, 20 Apr 2020 16:27:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1A79FC1D74;
	Mon, 20 Apr 2020 16:27:51 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F0D62C0177
 for <iommu@lists.linux-foundation.org>; Mon, 20 Apr 2020 16:27:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id DA56887E80
 for <iommu@lists.linux-foundation.org>; Mon, 20 Apr 2020 16:27:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4GHE3sRWcnGW for <iommu@lists.linux-foundation.org>;
 Mon, 20 Apr 2020 16:27:49 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail27.static.mailgun.info (mail27.static.mailgun.info
 [104.130.122.27])
 by hemlock.osuosl.org (Postfix) with ESMTPS id E1FBE87CD2
 for <iommu@lists.linux-foundation.org>; Mon, 20 Apr 2020 16:27:48 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1587400068; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=JmEUkT/HF+RFoziT0BX0UCsQ/PoZeQDMFSY5vkJTons=;
 b=tku8QpzBmbEeRyB9J7zN/pdlnMAUKOzQI58FOPWWqx3tjFUAkDDNP7NLxBOkdGSFl4suYhVQ
 4MvWEozpZKI36JLmGDI66th98Dud6PE0PM3kiw1W/7vINcT5Kzsac0T8ehGmIVjbDfKEvveV
 hNZff7U0muoz7J3yR++aUaXDIsM=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3NDkwMCIsICJpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e9dcd84.7f79b7479068-smtp-out-n03;
 Mon, 20 Apr 2020 16:27:48 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id 1BA05C43637; Mon, 20 Apr 2020 16:27:47 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: saiprakash.ranjan)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 50479C433CB;
 Mon, 20 Apr 2020 16:27:46 +0000 (UTC)
MIME-Version: 1.0
Date: Mon, 20 Apr 2020 21:57:46 +0530
From: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCHv2 3/6] iommu/arm-smmu: Implement
 iommu_ops->def_domain_type call-back
In-Reply-To: <6dd26176-448a-985c-90fc-7c47088015ff@arm.com>
References: <cover.1587392905.git.saiprakash.ranjan@codeaurora.org>
 <558b1aee4c699a0a5b14b325178d22a79958488f.1587392905.git.saiprakash.ranjan@codeaurora.org>
 <6dd26176-448a-985c-90fc-7c47088015ff@arm.com>
Message-ID: <10cac2a08ae90afc88cbadff53a41ec5@codeaurora.org>
X-Sender: saiprakash.ranjan@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Cc: linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
 Evan Green <evgreen@chromium.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>, iommu@lists.linux-foundation.org,
 Sibi Sankar <sibis@codeaurora.org>, Stephen Boyd <swboyd@chromium.org>,
 Will Deacon <will@kernel.org>, Matthias Kaehlcke <mka@chromium.org>,
 linux-kernel@vger.kernel.org
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

On 2020-04-20 20:56, Robin Murphy wrote:
> On 2020-04-20 3:37 pm, Sai Prakash Ranjan wrote:
>> Implement the new def_domain_type call-back for the ARM
>> SMMU driver. We need this to support requesting the domain
>> type by the client devices.
>> 
>> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
>> ---
>>   drivers/iommu/arm-smmu.c | 20 ++++++++++++++++++++
>>   1 file changed, 20 insertions(+)
>> 
>> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
>> index e622f4e33379..b5d1d52dfbb8 100644
>> --- a/drivers/iommu/arm-smmu.c
>> +++ b/drivers/iommu/arm-smmu.c
>> @@ -1609,6 +1609,25 @@ static void arm_smmu_get_resv_regions(struct 
>> device *dev,
>>   	iommu_dma_get_resv_regions(dev, head);
>>   }
>>   +static int arm_smmu_def_domain_type(struct device *dev)
>> +{
>> +	struct iommu_fwspec *fwspec;
>> +	struct arm_smmu_device *smmu;
>> +
>> +	fwspec = dev_iommu_fwspec_get(dev);
>> +	if (!fwspec || fwspec->ops != &arm_smmu_ops)
>> +		return -ENODEV;
>> +
>> +	smmu = arm_smmu_get_by_fwnode(fwspec->iommu_fwnode);
>> +	if (!smmu)
>> +		return -ENODEV;
>> +
> 
> AFAICS this should only ever be called for a device in a group, which
> means an initial ->probe_device has succeeded and rather than
> defensively going the long way round, we can safely assume this:
> 
> 	struct arm_smmu_master_cfg = dev_iommu_priv_get(dev);
> 	struct arm_smmu_impl *impl = cfg->smmu->impl;
> 
> 	if (impl && impl->req_domain)
> 		return impl->req_domain(dev);
> 

Yes you are right, will use this.

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
