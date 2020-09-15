Return-Path: <SRS0=AdPL=CY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6863FC2D0E0
	for <iommu@archiver.kernel.org>; Tue, 15 Sep 2020 06:58:50 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E49B220684
	for <iommu@archiver.kernel.org>; Tue, 15 Sep 2020 06:58:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="ge6+2eq5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E49B220684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 70FA820491;
	Tue, 15 Sep 2020 06:58:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id R571Kbxi8c+q; Tue, 15 Sep 2020 06:58:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 9A70B20477;
	Tue, 15 Sep 2020 06:58:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5C88AC0864;
	Tue, 15 Sep 2020 06:58:48 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 66D18C0051
 for <iommu@lists.linux-foundation.org>; Tue, 15 Sep 2020 06:58:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 5448287091
 for <iommu@lists.linux-foundation.org>; Tue, 15 Sep 2020 06:58:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id H3FXB7cQsTBr for <iommu@lists.linux-foundation.org>;
 Tue, 15 Sep 2020 06:58:45 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from m43-7.mailgun.net (m43-7.mailgun.net [69.72.43.7])
 by hemlock.osuosl.org (Postfix) with ESMTPS id AC01487051
 for <iommu@lists.linux-foundation.org>; Tue, 15 Sep 2020 06:58:40 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1600153125; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=TqpJbtJ5h/NOs90QzAjCnhYHSI+Sccp918FxJgx7Rwk=;
 b=ge6+2eq5uycQlr19IinxZ0ZFwlhIjDrjUpCR/vPTupzOKg0zeL+aiHyN63qehGoO0e5YMG02
 uUy274pJjN9F8ETjFs6f0lixrNceJ9l5Z5i3uIaKtAiDzn71gOXHQm1sI9v8Mtz2Eesd1ImT
 Kj1wrIDXRcUIi36GEK0TJz7bAVs=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3NDkwMCIsICJpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 5f60661354e87432be5b23cf (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 15 Sep 2020 06:58:27
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id B2278C43387; Tue, 15 Sep 2020 06:58:26 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: saiprakash.ranjan)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 1F9F1C433C8;
 Tue, 15 Sep 2020 06:58:26 +0000 (UTC)
MIME-Version: 1.0
Date: Tue, 15 Sep 2020 12:28:26 +0530
From: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCHv4 6/6] iommu: arm-smmu-impl: Remove unwanted extra blank
 lines
In-Reply-To: <a33160854744942f660fae691a4a30ec@codeaurora.org>
References: <cover.1599832685.git.saiprakash.ranjan@codeaurora.org>
 <010101747d912d9f-c8050b8d-1e81-4be0-ac35-b221f657b490-000000@us-west-2.amazonses.com>
 <c26b5317-f12d-8be9-be45-3307ce5efbfc@arm.com>
 <20200911160706.GA20802@willie-the-truck>
 <010101747df8e9df-fad2f88d-e970-4753-a99a-2cfeeb1a29a9-000000@us-west-2.amazonses.com>
 <7ff9b238-e203-059f-d793-1c44475c6aa2@arm.com>
 <a33160854744942f660fae691a4a30ec@codeaurora.org>
Message-ID: <e815cbc83d6c3d92168d817cf0b01cbb@codeaurora.org>
X-Sender: saiprakash.ranjan@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Cc: Will Deacon <will@kernel.org>, Akhil P Oommen <akhilpo@codeaurora.org>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org,
 "Kristian H . Kristensen" <hoegsberg@google.com>,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
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

On 2020-09-11 22:20, Sai Prakash Ranjan wrote:
> On 2020-09-11 22:04, Robin Murphy wrote:
>> On 2020-09-11 17:21, Sai Prakash Ranjan wrote:
>>> On 2020-09-11 21:37, Will Deacon wrote:
>>>> On Fri, Sep 11, 2020 at 05:03:06PM +0100, Robin Murphy wrote:
>>>>> BTW am I supposed to have received 3 copies of everything? Because 
>>>>> I did...
>>>> 
>>>> Yeah, this seems to be happening for all of Sai's emails :/
>>>> 
>>> 
>>> Sorry, I am not sure what went wrong as I only sent this once
>>> and there are no recent changes to any of my configs, I'll
>>> check it further.
>> 
>> Actually on closer inspection it appears to be "correct" behaviour.
>> I'm still subscribed to LAKML and the IOMMU list on this account, but
>> normally Office 365 deduplicates so aggressively that I have rules set
>> up to copy list mails that I'm cc'ed on back to my inbox, in case they
>> arrive first and cause the direct copy to get eaten - apparently
>> there's something unique about your email setup that manages to defeat
>> the deduplicator and make it deliver all 3 copies intact... :/
>> 
> 
> No changes in my local setup atleast, but in the past we have
> had cases with codeaurora mail acting weird or it could be my vpn,
> will have to check.
> 

This was an issue with codeaurora servers and I am told that it is
fixed now.

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
