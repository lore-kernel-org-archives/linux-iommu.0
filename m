Return-Path: <SRS0=2lDQ=IM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13F00C433E0
	for <iommu@archiver.kernel.org>; Sun, 14 Mar 2021 19:02:14 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9617664EC3
	for <iommu@archiver.kernel.org>; Sun, 14 Mar 2021 19:02:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9617664EC3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 54CAF83AB9;
	Sun, 14 Mar 2021 19:02:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9N-q2jwYV4gt; Sun, 14 Mar 2021 19:02:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1031383B8A;
	Sun, 14 Mar 2021 19:02:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DBB3EC000B;
	Sun, 14 Mar 2021 19:02:11 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 01FD8C0001
 for <iommu@lists.linux-foundation.org>; Sun, 14 Mar 2021 19:02:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with UTF8SMTP id D99826F4E1
 for <iommu@lists.linux-foundation.org>; Sun, 14 Mar 2021 19:02:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=mg.codeaurora.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with UTF8SMTP id KCDlvka-Q0rF for <iommu@lists.linux-foundation.org>;
 Sun, 14 Mar 2021 19:02:10 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from m42-2.mailgun.net (m42-2.mailgun.net [69.72.42.2])
 by smtp3.osuosl.org (Postfix) with UTF8SMTPS id 8ECDE6F4D4
 for <iommu@lists.linux-foundation.org>; Sun, 14 Mar 2021 19:02:07 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1615748529; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=HR9jJoTf4lyMl8C4ltT6ssDNUpxMI3Jda3CMTcfVWl4=;
 b=L9LxDK9p8FYuGo8DoW1XSquM6IHVIMW2R/nT3AJ2L0IAhzt2VnCnzT11QFaFsuurMmJZGzpX
 03OoOjxuRk23z4I9ULR16YDmgFZkfT1Tn1f+UUcV3115a6DdB7rdBTQ/kI+zhCNqxuT1t/pu
 HgQ5bq4tw8OENfsy7MyznPXY3tc=
X-Mailgun-Sending-Ip: 69.72.42.2
X-Mailgun-Sid: WyI3NDkwMCIsICJpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 604e5da63f267701a4286607 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sun, 14 Mar 2021 19:01:58
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id 27282C43463; Sun, 14 Mar 2021 19:01:58 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: saiprakash.ranjan)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 2E99CC433CA;
 Sun, 14 Mar 2021 19:01:57 +0000 (UTC)
MIME-Version: 1.0
Date: Mon, 15 Mar 2021 00:31:57 +0530
From: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To: Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [PATCHv2 2/2] iommu/arm-smmu-qcom: Move the adreno smmu specific
 impl earlier
In-Reply-To: <YEqn1SjsGgK0V8K4@builder.lan>
References: <YDlIrjkfv16o4Nu3@builder.lan>
 <20210227135321.420-1-saiprakash.ranjan@codeaurora.org>
 <YEqn1SjsGgK0V8K4@builder.lan>
Message-ID: <8cfaed1915ad6dd0c34ac7eb2391b410@codeaurora.org>
X-Sender: saiprakash.ranjan@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Cc: linux-kernel@vger.kernel.org, will@kernel.org,
 linux-arm-msm@vger.kernel.org, jcrouse@codeaurora.org, akhilpo@codeaurora.org,
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

On 2021-03-12 04:59, Bjorn Andersson wrote:
> On Sat 27 Feb 07:53 CST 2021, Sai Prakash Ranjan wrote:
> 
>> Hi Bjorn,
>> 
>> On 2021-02-27 00:44, Bjorn Andersson wrote:
>> > On Fri 26 Feb 12:23 CST 2021, Rob Clark wrote:
>> >
>> >
>> > The current logic picks one of:
>> > 1) is the compatible mentioned in qcom_smmu_impl_of_match[]
>> > 2) is the compatible an adreno
>> > 3) no quirks needed
>> >
>> > The change flips the order of these, so the only way I can see this
>> > change affecting things is if we expected a match on #2, but we got one
>> > on #1.
>> >
>> > Which implies that the instance that we want to act according to the
>> > adreno impl was listed in qcom_smmu_impl_of_match[] - which either is
>> > wrong, or there's a single instance that needs both behaviors.
>> >
>> > (And I believe Jordan's answer confirms the latter - there's a single
>> > SMMU instance that needs all them quirks at once)
>> >
>> 
>> Let me go through the problem statement in case my commit message 
>> wasn't
>> clear. There are two SMMUs (APSS and GPU) on SC7280 and both are 
>> SMMU500
>> (ARM SMMU IP).
>> 
>> APSS SMMU compatible - ("qcom,sc7280-smmu-500", "arm,mmu-500")
>> GPU SMMU compatible - ("qcom,sc7280-smmu-500", "qcom,adreno-smmu", 
>> "arm,mmu-500")
>> 
>> Now if we take SC7180 as an example, GPU SMMU was QSMMU(QCOM SMMU IP)
>> and APSS SMMU was SMMU500(ARM SMMU IP).
>> 
>> APSS SMMU compatible - ("qcom,sc7180-smmu-500", "arm,mmu-500")
>> GPU SMMU compatible - ("qcom,sc7180-smmu-v2", "qcom,adreno-smmu", 
>> "qcom,smmu-v2")
>> 
>> Current code sequence without this patch,
>> 
>> if (of_match_node(qcom_smmu_impl_of_match, np))
>>                  return qcom_smmu_create(smmu, &qcom_smmu_impl);
>> 
>> if (of_device_is_compatible(np, "qcom,adreno-smmu"))
>>         return qcom_smmu_create(smmu, &qcom_adreno_smmu_impl);
>> 
>> Now if we look at the compatible for SC7180, there is no problem 
>> because
>> the APSS SMMU will match the one in qcom_smmu_impl_of_match[] and GPU 
>> SMMU
>> will match "qcom,adreno-smmu" because the compatible strings are 
>> different.
>> But for SC7280, both the APSS SMMU and GPU SMMU 
>> compatible("qcom,sc7280-smmu-500")
>> are same. So GPU SMMU will match with the one in 
>> qcom_smmu_impl_of_match[]
>> i.e.., "qcom,sc7280-smmu-500" which functionally doesn't cause any 
>> problem
>> but we will miss settings for split pagetables which are part of GPU 
>> SMMU
>> specific implementation.
>> 
>> We can avoid this with yet another new compatible for GPU SMMU 
>> something like
>> "qcom,sc7280-adreno-smmu-500" but since we can handle this easily in 
>> the
>> driver and since the IPs are same, meaning if there was a hardware 
>> quirk
>> required, then we would need to apply to both of them and would this 
>> additional
>> compatible be of any help?
>> 
> 
> No, I think you're doing the right thing of having them both. I just
> didn't remember us doing that.
> 
>> Coming to the part of quirks now, you are right saying both SMMUs will 
>> need
>> to have the same quirks in SC7280 and similar others where both are 
>> based on
>> same IPs but those should probably be *hardware quirks* and if they 
>> are
>> software based like the S2CR quirk depending on the firmware, then it 
>> might
>> not be applicable to both. In case if it is applicable, then as Jordan 
>> mentioned,
>> we can add the same quirks in GPU SMMU implementation.
>> 
> 
> I do suspect that at some point (probably sooner than later) we'd have
> to support both inheriting of stream from the bootloader and the Adreno
> "quirks" in the same instance.
> 
> But for now this is okay to me.
> 

Sure, let me know if you or anyone face any issues without it and I will
add it. I will resend this series with the dt-bindings patch for sc7280 
smmu
which wasn't cc'd to smmu folks by mistake.

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
