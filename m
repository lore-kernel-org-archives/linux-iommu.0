Return-Path: <SRS0=5SFN=56=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5204C2BB85
	for <iommu@archiver.kernel.org>; Tue, 14 Apr 2020 16:18:43 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A54F920678
	for <iommu@archiver.kernel.org>; Tue, 14 Apr 2020 16:18:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="EBVOg6X/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A54F920678
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 80EA58511F;
	Tue, 14 Apr 2020 16:18:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id a04WRPOvUkiZ; Tue, 14 Apr 2020 16:18:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 0FCD884EDB;
	Tue, 14 Apr 2020 16:18:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EA2A4C089E;
	Tue, 14 Apr 2020 16:18:42 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DB481C0172
 for <iommu@lists.linux-foundation.org>; Tue, 14 Apr 2020 16:18:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id C281B84737
 for <iommu@lists.linux-foundation.org>; Tue, 14 Apr 2020 16:18:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EtpCIargEUu0 for <iommu@lists.linux-foundation.org>;
 Tue, 14 Apr 2020 16:18:39 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail26.static.mailgun.info (mail26.static.mailgun.info
 [104.130.122.26])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 4E50D81B8A
 for <iommu@lists.linux-foundation.org>; Tue, 14 Apr 2020 16:18:39 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1586881119; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=pjzwfTcChHnISigCJHUetoRvOtw8Q36XYbff0pt71XY=;
 b=EBVOg6X/p8Plyh7uVYSdxlpC70ArYFEMk51fgEK/B/bp2K3IC3orEv8eF9AUu4Su42r8ezrX
 K1qYYCFrTbBc9M/3Zqh/IMWsCue72TzGg9VhmaiDSgEktaKEupqbWlzfvEoULpBcPWQj0zwA
 ypoXb7FqSNiEGrGW/FfJyVMDAuU=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3NDkwMCIsICJpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e95e25e.7f500d6a9730-smtp-out-n02;
 Tue, 14 Apr 2020 16:18:38 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id E87E4C432C2; Tue, 14 Apr 2020 16:18:37 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: saiprakash.ranjan)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 28FA7C433F2;
 Tue, 14 Apr 2020 16:18:37 +0000 (UTC)
MIME-Version: 1.0
Date: Tue, 14 Apr 2020 21:48:37 +0530
From: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To: Evan Green <evgreen@chromium.org>
Subject: Re: [PATCH 2/2] iommu/arm-smmu: Allow client devices to select direct
 mapping
In-Reply-To: <CAE=gft7HFBc7XtgiV1hkG-m3ONMUiE2vu8Vg_7Mu1dfe2BjYpA@mail.gmail.com>
References: <cover.1579692800.git.saiprakash.ranjan@codeaurora.org>
 <813cc5b2da10c27db982254b274bf26008a9e6da.1579692800.git.saiprakash.ranjan@codeaurora.org>
 <CAE=gft7HFBc7XtgiV1hkG-m3ONMUiE2vu8Vg_7Mu1dfe2BjYpA@mail.gmail.com>
Message-ID: <eb30fcf85127676e401ca5d83f9a6ad7@codeaurora.org>
X-Sender: saiprakash.ranjan@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Cc: Rajendra Nayak <rnayak@codeaurora.org>, Will Deacon <will@kernel.org>,
 iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>,
 Matthias Kaehlcke <mka@chromium.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 Stephen Boyd <swboyd@chromium.org>, Robin Murphy <robin.murphy@arm.com>,
 linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>
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

Hi Evan,

On 2020-04-14 04:42, Evan Green wrote:
> On Wed, Jan 22, 2020 at 3:48 AM Sai Prakash Ranjan
> <saiprakash.ranjan@codeaurora.org> wrote:
>> 
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
>>  drivers/iommu/arm-smmu-qcom.c | 39 
>> +++++++++++++++++++++++++++++++++++
>>  drivers/iommu/arm-smmu.c      |  3 +++
>>  drivers/iommu/arm-smmu.h      |  5 +++++
>>  3 files changed, 47 insertions(+)
>> 
>> diff --git a/drivers/iommu/arm-smmu-qcom.c 
>> b/drivers/iommu/arm-smmu-qcom.c
>> index 64a4ab270ab7..ff746acd1c81 100644
>> --- a/drivers/iommu/arm-smmu-qcom.c
>> +++ b/drivers/iommu/arm-smmu-qcom.c
>> @@ -3,6 +3,7 @@
>>   * Copyright (c) 2019, The Linux Foundation. All rights reserved.
>>   */
>> 
>> +#include <linux/of_device.h>
>>  #include <linux/qcom_scm.h>
>> 
>>  #include "arm-smmu.h"
>> @@ -11,6 +12,43 @@ struct qcom_smmu {
>>         struct arm_smmu_device smmu;
>>  };
>> 
>> +static const struct arm_smmu_client_match_data qcom_adreno = {
>> +       .direct_mapping = true,
>> +};
>> +
>> +static const struct arm_smmu_client_match_data qcom_mdss = {
>> +       .direct_mapping = true,
> 
> I don't actually see direct_mapping being used. Shouldn't this member
> be checked somewhere?
> 

Thanks for spotting this, my bad. It should be checked in 
qcom_smmu_request_domain().

diff --git a/drivers/iommu/arm-smmu-qcom.c 
b/drivers/iommu/arm-smmu-qcom.c
index ff746acd1c81..3ff62ca13ad5 100644
--- a/drivers/iommu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm-smmu-qcom.c
@@ -43,7 +43,7 @@ static int qcom_smmu_request_domain(struct device 
*dev)
         const struct arm_smmu_client_match_data *client;

         client = qcom_smmu_client_data(dev);
-       if (client)
+       if (client && client->direct_mapping)
                 iommu_request_dm_for_dev(dev);

         return 0;

-Sai

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a 
member
of Code Aurora Forum, hosted by The Linux Foundation
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
