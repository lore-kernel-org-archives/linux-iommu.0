Return-Path: <SRS0=amFV=MT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B284AC4320A
	for <iommu@archiver.kernel.org>; Tue, 27 Jul 2021 10:35:25 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CF8F60FA0
	for <iommu@archiver.kernel.org>; Tue, 27 Jul 2021 10:35:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5CF8F60FA0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2C83082430;
	Tue, 27 Jul 2021 10:35:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rEUZlD69jujp; Tue, 27 Jul 2021 10:35:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 14F2081BB0;
	Tue, 27 Jul 2021 10:35:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CEE09C001A;
	Tue, 27 Jul 2021 10:35:23 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EC82DC000E
 for <iommu@lists.linux-foundation.org>; Tue, 27 Jul 2021 10:35:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with UTF8SMTP id E1D5840246
 for <iommu@lists.linux-foundation.org>; Tue, 27 Jul 2021 10:35:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=mg.codeaurora.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with UTF8SMTP id w19qqJYtfx_j for <iommu@lists.linux-foundation.org>;
 Tue, 27 Jul 2021 10:35:21 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from so254-9.mailgun.net (so254-9.mailgun.net [198.61.254.9])
 by smtp4.osuosl.org (Postfix) with UTF8SMTPS id 684AD40227
 for <iommu@lists.linux-foundation.org>; Tue, 27 Jul 2021 10:35:18 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1627382121; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=jcDIGTlNdb13VAIbuMs/ke9zWyHAfziW4NuYUouZlG8=;
 b=oNjgEPkitcS5Qqfj94hU1jlW9rsuVQawUAwd2WrN3XNT2LtviG9pg+DiOQcq/QHfWt2ybIxi
 uD7BzTLCAFHTxKU24ALKXeeLXjfFpViLRTmgQCTEhavmEEuuVeyEp5zaf/KDd4LvBvvv5kbF
 MSP0a5rp6lKtkhf6xmKPWNRDY+w=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3NDkwMCIsICJpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 60ffe162b653fbdadda934d4 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 27 Jul 2021 10:35:14
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id 5DA3BC433F1; Tue, 27 Jul 2021 10:35:13 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: saiprakash.ranjan)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id A5083C433D3;
 Tue, 27 Jul 2021 10:35:12 +0000 (UTC)
MIME-Version: 1.0
Date: Tue, 27 Jul 2021 16:05:12 +0530
From: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH] iommu/arm-smmu: Add clk_bulk_{prepare/unprepare} to
 system pm callbacks
In-Reply-To: <c23a16d8-e39c-253f-5631-cffa94a1d532@arm.com>
References: <20210727093322.13202-1-saiprakash.ranjan@codeaurora.org>
 <955a3034-f7e7-f8f9-4abd-b65efbfbb404@arm.com>
 <c23a16d8-e39c-253f-5631-cffa94a1d532@arm.com>
Message-ID: <ee409973019e7412d221001955045cea@codeaurora.org>
X-Sender: saiprakash.ranjan@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Cc: Taniya Das <tdas@codeaurora.org>, Rajendra Nayak <rnayak@codeaurora.org>,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Will Deacon <will@kernel.org>,
 srimuc <srimuc@codeaurora.org>, linux-arm-kernel@lists.infradead.org
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

On 2021-07-27 16:03, Robin Murphy wrote:
> On 2021-07-27 11:25, Robin Murphy wrote:
>> On 2021-07-27 10:33, Sai Prakash Ranjan wrote:
>>> Some clocks for SMMU can have parent as XO such as 
>>> gpu_cc_hub_cx_int_clk
>>> of GPU SMMU in QTI SC7280 SoC and in order to enter deep sleep states 
>>> in
>>> such cases, we would need to drop the XO clock vote in unprepare call 
>>> and
>>> this unprepare callback for XO is in RPMh (Resource Power 
>>> Manager-Hardened)
>>> clock driver which controls RPMh managed clock resources for new QTI 
>>> SoCs
>>> and is a blocking call.
>>> 
>>> Given we cannot have a sleeping calls such as clk_bulk_prepare() and
>>> clk_bulk_unprepare() in arm-smmu runtime pm callbacks since the iommu
>>> operations like map and unmap can be in atomic context and are in 
>>> fast
>>> path, add this prepare and unprepare call to drop the XO vote only 
>>> for
>>> system pm callbacks since it is not a fast path and we expect the 
>>> system
>>> to enter deep sleep states with system pm as opposed to runtime pm.
>>> 
>>> This is a similar sequence of clock requests (prepare,enable and
>>> disable,unprepare) in arm-smmu probe and remove.
>> 
>> Nope. We call arm_smmu_rpm_get(), which may resume the device, from 
>> atomic contexts. clk_prepare() may sleep. This doesn't work.
> 
> Urgh, or maybe I skimmed the commit message too lightly *and* managed
> to totally misread the patch, sorry :(
> 
> I'll wake up some more and try again later...
> 

No worries, we took our time looking through that many times before 
posting this :)

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
