Return-Path: <SRS0=Fh/M=IX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_RED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86CA0C433C1
	for <iommu@archiver.kernel.org>; Thu, 25 Mar 2021 07:45:34 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1352761A0A
	for <iommu@archiver.kernel.org>; Thu, 25 Mar 2021 07:45:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1352761A0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id CC3984013A;
	Thu, 25 Mar 2021 07:45:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QYUVr0-9Sco7; Thu, 25 Mar 2021 07:45:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id A76EA400CC;
	Thu, 25 Mar 2021 07:45:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7BAC7C000D;
	Thu, 25 Mar 2021 07:45:32 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CDF02C000A
 for <iommu@lists.linux-foundation.org>; Thu, 25 Mar 2021 07:45:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with UTF8SMTP id A71F94013A
 for <iommu@lists.linux-foundation.org>; Thu, 25 Mar 2021 07:45:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with UTF8SMTP id IYepyNCmKl-M for <iommu@lists.linux-foundation.org>;
 Thu, 25 Mar 2021 07:45:28 +0000 (UTC)
X-Greylist: delayed 00:05:03 by SQLgrey-1.8.0
Received: from m43-7.mailgun.net (m43-7.mailgun.net [69.72.43.7])
 by smtp2.osuosl.org (Postfix) with UTF8SMTPS id 86094400CC
 for <iommu@lists.linux-foundation.org>; Thu, 25 Mar 2021 07:45:28 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1616658328; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=5V/X73Qvmby+KZEDF3giACHPZGd7oaDcpBQsgLRANQE=;
 b=NaHvV+n1G4st/VP+GzPMDer4tKE+1ZfcFA+J+XXu7gjKPuNT3cZ8m8Nlea2iD9wU5o8pF7Nt
 hZkgkjOn9q2Ju1sTdKJoxautl3lmfLaU8IjzwxJ0atPDAEmVDf8XrXrxbClmL10ZefmlhoBk
 uareal2/6H5Hri+spXYHznpEvkU=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3NDkwMCIsICJpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 605c3e5e9114a69de7c4e891 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 25 Mar 2021 07:40:14
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id E7FCBC43464; Thu, 25 Mar 2021 07:40:13 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: saiprakash.ranjan)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id DB834C433C6;
 Thu, 25 Mar 2021 07:40:12 +0000 (UTC)
MIME-Version: 1.0
Date: Thu, 25 Mar 2021 13:10:12 +0530
From: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To: Will Deacon <will@kernel.org>
Subject: Re: [PATCHv2 2/2] iommu/arm-smmu-qcom: Move the adreno smmu specific
 impl earlier
In-Reply-To: <8cfaed1915ad6dd0c34ac7eb2391b410@codeaurora.org>
References: <YDlIrjkfv16o4Nu3@builder.lan>
 <20210227135321.420-1-saiprakash.ranjan@codeaurora.org>
 <YEqn1SjsGgK0V8K4@builder.lan>
 <8cfaed1915ad6dd0c34ac7eb2391b410@codeaurora.org>
Message-ID: <727fa9fe2e644f88ba35c2877d71788e@codeaurora.org>
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

Hi Will,

On 2021-03-15 00:31, Sai Prakash Ranjan wrote:
> On 2021-03-12 04:59, Bjorn Andersson wrote:
>> On Sat 27 Feb 07:53 CST 2021, Sai Prakash Ranjan wrote:
>> 
>>> Hi Bjorn,
>>> 
>>> On 2021-02-27 00:44, Bjorn Andersson wrote:
>>> > On Fri 26 Feb 12:23 CST 2021, Rob Clark wrote:
>>> >
>>> >
>>> > The current logic picks one of:
>>> > 1) is the compatible mentioned in qcom_smmu_impl_of_match[]
>>> > 2) is the compatible an adreno
>>> > 3) no quirks needed
>>> >
>>> > The change flips the order of these, so the only way I can see this
>>> > change affecting things is if we expected a match on #2, but we got one
>>> > on #1.
>>> >
>>> > Which implies that the instance that we want to act according to the
>>> > adreno impl was listed in qcom_smmu_impl_of_match[] - which either is
>>> > wrong, or there's a single instance that needs both behaviors.
>>> >
>>> > (And I believe Jordan's answer confirms the latter - there's a single
>>> > SMMU instance that needs all them quirks at once)
>>> >
>>> 
>>> Let me go through the problem statement in case my commit message 
>>> wasn't
>>> clear. There are two SMMUs (APSS and GPU) on SC7280 and both are 
>>> SMMU500
>>> (ARM SMMU IP).
>>> 
>>> APSS SMMU compatible - ("qcom,sc7280-smmu-500", "arm,mmu-500")
>>> GPU SMMU compatible - ("qcom,sc7280-smmu-500", "qcom,adreno-smmu", 
>>> "arm,mmu-500")
>>> 
>>> Now if we take SC7180 as an example, GPU SMMU was QSMMU(QCOM SMMU IP)
>>> and APSS SMMU was SMMU500(ARM SMMU IP).
>>> 
>>> APSS SMMU compatible - ("qcom,sc7180-smmu-500", "arm,mmu-500")
>>> GPU SMMU compatible - ("qcom,sc7180-smmu-v2", "qcom,adreno-smmu", 
>>> "qcom,smmu-v2")
>>> 
>>> Current code sequence without this patch,
>>> 
>>> if (of_match_node(qcom_smmu_impl_of_match, np))
>>>                  return qcom_smmu_create(smmu, &qcom_smmu_impl);
>>> 
>>> if (of_device_is_compatible(np, "qcom,adreno-smmu"))
>>>         return qcom_smmu_create(smmu, &qcom_adreno_smmu_impl);
>>> 
>>> Now if we look at the compatible for SC7180, there is no problem 
>>> because
>>> the APSS SMMU will match the one in qcom_smmu_impl_of_match[] and GPU 
>>> SMMU
>>> will match "qcom,adreno-smmu" because the compatible strings are 
>>> different.
>>> But for SC7280, both the APSS SMMU and GPU SMMU 
>>> compatible("qcom,sc7280-smmu-500")
>>> are same. So GPU SMMU will match with the one in 
>>> qcom_smmu_impl_of_match[]
>>> i.e.., "qcom,sc7280-smmu-500" which functionally doesn't cause any 
>>> problem
>>> but we will miss settings for split pagetables which are part of GPU 
>>> SMMU
>>> specific implementation.
>>> 
>>> We can avoid this with yet another new compatible for GPU SMMU 
>>> something like
>>> "qcom,sc7280-adreno-smmu-500" but since we can handle this easily in 
>>> the
>>> driver and since the IPs are same, meaning if there was a hardware 
>>> quirk
>>> required, then we would need to apply to both of them and would this 
>>> additional
>>> compatible be of any help?
>>> 
>> 
>> No, I think you're doing the right thing of having them both. I just
>> didn't remember us doing that.
>> 
>>> Coming to the part of quirks now, you are right saying both SMMUs 
>>> will need
>>> to have the same quirks in SC7280 and similar others where both are 
>>> based on
>>> same IPs but those should probably be *hardware quirks* and if they 
>>> are
>>> software based like the S2CR quirk depending on the firmware, then it 
>>> might
>>> not be applicable to both. In case if it is applicable, then as 
>>> Jordan mentioned,
>>> we can add the same quirks in GPU SMMU implementation.
>>> 
>> 
>> I do suspect that at some point (probably sooner than later) we'd have
>> to support both inheriting of stream from the bootloader and the 
>> Adreno
>> "quirks" in the same instance.
>> 
>> But for now this is okay to me.
>> 
> 
> Sure, let me know if you or anyone face any issues without it and I 
> will
> add it. I will resend this series with the dt-bindings patch for sc7280 
> smmu
> which wasn't cc'd to smmu folks by mistake.
> 

I think there is consensus on this series. I can resend if required but 
it
still applies cleanly, let me know if you have any comments?

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
