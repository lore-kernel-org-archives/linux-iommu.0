Return-Path: <SRS0=tsXo=JC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4771C433ED
	for <iommu@archiver.kernel.org>; Mon,  5 Apr 2021 08:42:27 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6091A61393
	for <iommu@archiver.kernel.org>; Mon,  5 Apr 2021 08:42:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6091A61393
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1541440222;
	Mon,  5 Apr 2021 08:42:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0uObvZl1tQ9r; Mon,  5 Apr 2021 08:42:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 11709400B8;
	Mon,  5 Apr 2021 08:42:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D9511C000B;
	Mon,  5 Apr 2021 08:42:25 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 60F27C000A
 for <iommu@lists.linux-foundation.org>; Mon,  5 Apr 2021 08:42:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with UTF8SMTP id 4D62D4065F
 for <iommu@lists.linux-foundation.org>; Mon,  5 Apr 2021 08:42:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=mg.codeaurora.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with UTF8SMTP id 0336BL4e1Pnu for <iommu@lists.linux-foundation.org>;
 Mon,  5 Apr 2021 08:42:24 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from m43-7.mailgun.net (m43-7.mailgun.net [69.72.43.7])
 by smtp4.osuosl.org (Postfix) with UTF8SMTPS id 80AB840655
 for <iommu@lists.linux-foundation.org>; Mon,  5 Apr 2021 08:42:22 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1617612144; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=bpbemXH5VxCoagliWnNLvNlKKb6UJpDqoyP8WTf27uw=;
 b=QHIJpZzd6OfUfgg4SVFSJVWcKADQ8RgFPOwpIFOapGQjaCJlgK2Fj+ilSUIyC/p35E3nHsUe
 IpUI8BXCGRSoUK+enl8ycV26Mg4AYU4rd3M2w2HMpqae4cB7YQlV+caKfOySN73vBQXSAOjr
 STL3/0oIZWyKAtgX9//CL9h+TmM=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3NDkwMCIsICJpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 606acd6a8166b7eff75649b0 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 05 Apr 2021 08:42:18
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id 31253C43465; Mon,  5 Apr 2021 08:42:17 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: saiprakash.ranjan)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id A11C6C433C6;
 Mon,  5 Apr 2021 08:42:16 +0000 (UTC)
MIME-Version: 1.0
Date: Mon, 05 Apr 2021 14:12:16 +0530
From: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To: Will Deacon <will@kernel.org>, Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [PATCHv2 2/2] iommu/arm-smmu-qcom: Move the adreno smmu specific
 impl earlier
In-Reply-To: <20210325150506.GD15172@willie-the-truck>
References: <YDlIrjkfv16o4Nu3@builder.lan>
 <20210227135321.420-1-saiprakash.ranjan@codeaurora.org>
 <YEqn1SjsGgK0V8K4@builder.lan>
 <8cfaed1915ad6dd0c34ac7eb2391b410@codeaurora.org>
 <727fa9fe2e644f88ba35c2877d71788e@codeaurora.org>
 <20210325150506.GD15172@willie-the-truck>
Message-ID: <118ced3153cd7fa5e8c16e5f0e2d5d19@codeaurora.org>
X-Sender: saiprakash.ranjan@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 jcrouse@codeaurora.org, akhilpo@codeaurora.org,
 iommu@lists.linux-foundation.org, robin.murphy@arm.com,
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

Hi Bjorn,

On 2021-03-25 20:35, Will Deacon wrote:
> On Thu, Mar 25, 2021 at 01:10:12PM +0530, Sai Prakash Ranjan wrote:

<snip>...

>> 
>> I think there is consensus on this series. I can resend if required 
>> but it
>> still applies cleanly, let me know if you have any comments?
> 
> Please resend with the bindings patch, and I'd like Bjorn's Ack as 
> well.
> 

Can we have your review/ack in case there is nothing pending here?

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
