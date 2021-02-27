Return-Path: <SRS0=v/hM=H5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22E9CC433DB
	for <iommu@archiver.kernel.org>; Sat, 27 Feb 2021 13:54:01 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8283164EB7
	for <iommu@archiver.kernel.org>; Sat, 27 Feb 2021 13:53:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8283164EB7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 4535B4347E;
	Sat, 27 Feb 2021 13:53:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1yAVhdR89rLI; Sat, 27 Feb 2021 13:53:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2988A42FC7;
	Sat, 27 Feb 2021 13:53:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EDDCFC000B;
	Sat, 27 Feb 2021 13:53:57 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CF427C0001
 for <iommu@lists.linux-foundation.org>; Sat, 27 Feb 2021 13:53:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with UTF8SMTP id B9A256F549
 for <iommu@lists.linux-foundation.org>; Sat, 27 Feb 2021 13:53:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=mg.codeaurora.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with UTF8SMTP id fsPl2Es4x2Ox for <iommu@lists.linux-foundation.org>;
 Sat, 27 Feb 2021 13:53:55 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from z11.mailgun.us (z11.mailgun.us [104.130.96.11])
 by smtp3.osuosl.org (Postfix) with UTF8SMTPS id C0A5A6F527
 for <iommu@lists.linux-foundation.org>; Sat, 27 Feb 2021 13:53:53 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1614434035; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=DgtWfT+ggYoDBm8woYV9yvXhaOPvGJGBMdZaWUjPB3U=;
 b=VZrZ9e5QQncKu08n5Dx6gTZFbFMuM8kMdLWCHhSR6VK9aeVQad6vFJF2ZE8pBDJg/za4NUP6
 TE8jsUhKBDo+gDap+AjTYWPmOAFnm8pWgUMx6yntY+R93Cj9W3hYmV4sYEMokwC9dxMfT3GE
 YgEqabOIqNZHLQJeZNXDpLLWb2I=
X-Mailgun-Sending-Ip: 104.130.96.11
X-Mailgun-Sid: WyI3NDkwMCIsICJpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 603a4ee68f0d5ba6c5bf2ada (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sat, 27 Feb 2021 13:53:42
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id 23233C433ED; Sat, 27 Feb 2021 13:53:42 +0000 (UTC)
Received: from blr-ubuntu-253.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: saiprakash.ranjan)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 0E411C433CA;
 Sat, 27 Feb 2021 13:53:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0E411C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail
 smtp.mailfrom=saiprakash.ranjan@codeaurora.org
From: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To: bjorn.andersson@linaro.org
Subject: Re: [PATCHv2 2/2] iommu/arm-smmu-qcom: Move the adreno smmu specific
 impl earlier
Date: Sat, 27 Feb 2021 19:23:21 +0530
Message-Id: <20210227135321.420-1-saiprakash.ranjan@codeaurora.org>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <YDlIrjkfv16o4Nu3@builder.lan>
References: <YDlIrjkfv16o4Nu3@builder.lan>
MIME-Version: 1.0
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Hi Bjorn,

On 2021-02-27 00:44, Bjorn Andersson wrote:
> On Fri 26 Feb 12:23 CST 2021, Rob Clark wrote:
> 
> 
> The current logic picks one of:
> 1) is the compatible mentioned in qcom_smmu_impl_of_match[]
> 2) is the compatible an adreno
> 3) no quirks needed
> 
> The change flips the order of these, so the only way I can see this
> change affecting things is if we expected a match on #2, but we got one
> on #1.
> 
> Which implies that the instance that we want to act according to the
> adreno impl was listed in qcom_smmu_impl_of_match[] - which either is
> wrong, or there's a single instance that needs both behaviors.
> 
> (And I believe Jordan's answer confirms the latter - there's a single
> SMMU instance that needs all them quirks at once)
> 

Let me go through the problem statement in case my commit message wasn't
clear. There are two SMMUs (APSS and GPU) on SC7280 and both are SMMU500
(ARM SMMU IP).

APSS SMMU compatible - ("qcom,sc7280-smmu-500", "arm,mmu-500")
GPU SMMU compatible - ("qcom,sc7280-smmu-500", "qcom,adreno-smmu", "arm,mmu-500")

Now if we take SC7180 as an example, GPU SMMU was QSMMU(QCOM SMMU IP)
and APSS SMMU was SMMU500(ARM SMMU IP).

APSS SMMU compatible - ("qcom,sc7180-smmu-500", "arm,mmu-500")
GPU SMMU compatible - ("qcom,sc7180-smmu-v2", "qcom,adreno-smmu", "qcom,smmu-v2")

Current code sequence without this patch,

if (of_match_node(qcom_smmu_impl_of_match, np))
                 return qcom_smmu_create(smmu, &qcom_smmu_impl);

if (of_device_is_compatible(np, "qcom,adreno-smmu"))
        return qcom_smmu_create(smmu, &qcom_adreno_smmu_impl);

Now if we look at the compatible for SC7180, there is no problem because
the APSS SMMU will match the one in qcom_smmu_impl_of_match[] and GPU SMMU
will match "qcom,adreno-smmu" because the compatible strings are different.
But for SC7280, both the APSS SMMU and GPU SMMU compatible("qcom,sc7280-smmu-500")
are same. So GPU SMMU will match with the one in qcom_smmu_impl_of_match[]
i.e.., "qcom,sc7280-smmu-500" which functionally doesn't cause any problem
but we will miss settings for split pagetables which are part of GPU SMMU
specific implementation.

We can avoid this with yet another new compatible for GPU SMMU something like
"qcom,sc7280-adreno-smmu-500" but since we can handle this easily in the
driver and since the IPs are same, meaning if there was a hardware quirk
required, then we would need to apply to both of them and would this additional
compatible be of any help?

Coming to the part of quirks now, you are right saying both SMMUs will need
to have the same quirks in SC7280 and similar others where both are based on
same IPs but those should probably be *hardware quirks* and if they are
software based like the S2CR quirk depending on the firmware, then it might
not be applicable to both. In case if it is applicable, then as Jordan mentioned,
we can add the same quirks in GPU SMMU implementation.

Thanks,
Sai

--
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
