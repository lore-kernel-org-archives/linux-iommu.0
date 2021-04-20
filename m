Return-Path: <SRS0=gpU2=JR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 333D0C433ED
	for <iommu@archiver.kernel.org>; Tue, 20 Apr 2021 06:06:44 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C11D06127C
	for <iommu@archiver.kernel.org>; Tue, 20 Apr 2021 06:06:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C11D06127C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 72EEF607E9;
	Tue, 20 Apr 2021 06:06:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vB1PQ7ya_J_q; Tue, 20 Apr 2021 06:06:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4C485607C2;
	Tue, 20 Apr 2021 06:06:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2645BC000F;
	Tue, 20 Apr 2021 06:06:42 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 57BF2C000B
 for <iommu@lists.linux-foundation.org>; Tue, 20 Apr 2021 06:06:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with UTF8SMTP id 375BB607C2
 for <iommu@lists.linux-foundation.org>; Tue, 20 Apr 2021 06:06:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with UTF8SMTP id eSfDZrPgxanc for <iommu@lists.linux-foundation.org>;
 Tue, 20 Apr 2021 06:06:36 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from m43-7.mailgun.net (m43-7.mailgun.net [69.72.43.7])
 by smtp3.osuosl.org (Postfix) with UTF8SMTPS id 72A5B60654
 for <iommu@lists.linux-foundation.org>; Tue, 20 Apr 2021 06:06:36 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1618898796; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=ewTV/EBlFexuHtL71GPSc2inLeA3xomPSaSc6BLPMEo=;
 b=Osju78jmIxiB2sRCoe7tU7R8w4P99PhKZAv7WQSxgMdntIgMfaAm+Dn9I0//fTjpu9FJn/bg
 Ei4/4pYwNfv0XE2R/X/tukAtch7njp2MmXrhCEblBj/UlGckO5HvKhgpFRKORJJ2GahNrzkh
 iYATICYQ+j9g2Z0dyQOC5MYHG/A=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3NDkwMCIsICJpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 607e6f6c215b831afbeab678 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 20 Apr 2021 06:06:36
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id 269CFC433D3; Tue, 20 Apr 2021 06:06:36 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: saiprakash.ranjan)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 5E8B9C433F1;
 Tue, 20 Apr 2021 06:06:35 +0000 (UTC)
MIME-Version: 1.0
Date: Tue, 20 Apr 2021 11:36:35 +0530
From: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To: Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [PATCHv2 2/2] iommu/arm-smmu-qcom: Move the adreno smmu specific
 impl earlier
In-Reply-To: <20210419143802.GP1538589@yoga>
References: <cover.1614332994.git.saiprakash.ranjan@codeaurora.org>
 <c607d71eb0fe507c8b83cc0ea9b393777f22149a.1614332994.git.saiprakash.ranjan@codeaurora.org>
 <20210419143802.GP1538589@yoga>
Message-ID: <2b940e7f483b567b8e0b3f0ce657b453@codeaurora.org>
X-Sender: saiprakash.ranjan@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Cc: Will Deacon <will@kernel.org>, Akhil P Oommen <akhilpo@codeaurora.org>,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 Jordan Crouse <jcrouse@codeaurora.org>, linux-arm-msm@vger.kernel.org,
 Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
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

On 2021-04-19 20:08, Bjorn Andersson wrote:
> On Fri 26 Feb 03:55 CST 2021, Sai Prakash Ranjan wrote:
> 
>> Adreno(GPU) SMMU and APSS(Application Processor SubSystem) SMMU
>> both implement "arm,mmu-500" in some QTI SoCs and to run through
>> adreno smmu specific implementation such as enabling split pagetables
>> support, we need to match the "qcom,adreno-smmu" compatible first
>> before apss smmu or else we will be running apps smmu implementation
>> for adreno smmu and the additional features for adreno smmu is never
>> set. For ex: we have "qcom,sc7280-smmu-500" compatible for both apps
>> and adreno smmu implementing "arm,mmu-500", so the adreno smmu
>> implementation is never reached because the current sequence checks
>> for apps smmu compatible(qcom,sc7280-smmu-500) first and runs that
>> specific impl and we never reach adreno smmu specific implementation.
>> 
>> Suggested-by: Akhil P Oommen <akhilpo@codeaurora.org>
>> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> 
> Sorry for taking my time thinking about this.
> 
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> 

No worries, thanks Bjorn.

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a 
member
of Code Aurora Forum, hosted by The Linux Foundation
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
