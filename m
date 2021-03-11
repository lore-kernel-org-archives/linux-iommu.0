Return-Path: <SRS0=X4VR=IJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4361CC433E0
	for <iommu@archiver.kernel.org>; Thu, 11 Mar 2021 23:29:34 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A642664F94
	for <iommu@archiver.kernel.org>; Thu, 11 Mar 2021 23:29:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A642664F94
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 58CFD6F95F;
	Thu, 11 Mar 2021 23:29:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id scoiJ67idIHQ; Thu, 11 Mar 2021 23:29:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7B246606E4;
	Thu, 11 Mar 2021 23:29:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 521BAC000B;
	Thu, 11 Mar 2021 23:29:31 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CC1AEC0001
 for <iommu@lists.linux-foundation.org>; Thu, 11 Mar 2021 23:29:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BA22E6F940
 for <iommu@lists.linux-foundation.org>; Thu, 11 Mar 2021 23:29:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id O2jhMMcAH0Nv for <iommu@lists.linux-foundation.org>;
 Thu, 11 Mar 2021 23:29:28 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CB9AC606E4
 for <iommu@lists.linux-foundation.org>; Thu, 11 Mar 2021 23:29:28 +0000 (UTC)
Received: by mail-ot1-x334.google.com with SMTP id 75so2692370otn.4
 for <iommu@lists.linux-foundation.org>; Thu, 11 Mar 2021 15:29:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=491rIB6TbnxYKUbmp43lo7687n1uls9e/9Yv3zZ/+/M=;
 b=SMNVB6H5xpNSP+Ntt/E41bnstJS/mub/pjKkhJYxD/9m/0JdTt1Sc/JeacWsclnhIa
 saZlM35oEZUGd6GLJc1B0Z8fOHlmarLVRa320OirgMyuk3CMzsKTN3VBH5KUOauAu923
 d2ymYxIDPYCBsoGohPV+44DV5Vg2pH3P1pSno36NGadsaTHK9d6OhoL/AnG1QXTXQjq6
 WfezMMjeqBUM6N2bVJmXtEz+LPF75d9wrFoBjlOAkTBvA8q7hY2kgy7D9mi3SqDP3npX
 UArOx0eMWnVGobKk8hawyEDO7rE3C0zoYDGB3jhrj15GrhugPdE6laoOn+2Xy00KuXrQ
 srhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=491rIB6TbnxYKUbmp43lo7687n1uls9e/9Yv3zZ/+/M=;
 b=F0yiff50KF4LSyIlBJjYLKsvKbNFUEp747r+NPbCDe30tXZQjLzdvgA/pi7DMX5lcN
 5LkUUit7byo25tg9Jmi6d+i6gXFv5TyvjpsyhNc9PbMOY7fadZk8TJeD83Dk0i7mQyEM
 dtu9OobYL43v03/i4jY32Q69BNYsKXplTBhqemCFVXiy8WQi1laWlmNQ1NNSW1b1w2At
 /VVx0ugeOFt7eKuhyKAU4Me+GDO4Fvr9XQMd9l3L+UTIozIWui66+IQyHIgZ2tiPyQ5U
 fcwXR6HIKmIO+hospPYJ8ClyUcTcZCUBJ6FnW+U+Y4fAMip37HBFkrvBykM0e+E9iF6x
 qRSw==
X-Gm-Message-State: AOAM531IyCodni+cGb0zEhNNY40NSV/cRYuOLk7GF5WQJbonhCsR7I/L
 ymgwwJliY22fG+8GKE0NvPxK2w==
X-Google-Smtp-Source: ABdhPJw4KQvalKBsueb6g3JYuyjaH1gcgChPlIne9ccF8RDotEH2OI5ha3PVdoOKbRbxK7d39hmllA==
X-Received: by 2002:a05:6830:101a:: with SMTP id
 a26mr1116383otp.68.1615505367766; 
 Thu, 11 Mar 2021 15:29:27 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net.
 [104.57.184.186])
 by smtp.gmail.com with ESMTPSA id l190sm639403oig.39.2021.03.11.15.29.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Mar 2021 15:29:27 -0800 (PST)
Date: Thu, 11 Mar 2021 17:29:25 -0600
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Subject: Re: [PATCHv2 2/2] iommu/arm-smmu-qcom: Move the adreno smmu specific
 impl earlier
Message-ID: <YEqn1SjsGgK0V8K4@builder.lan>
References: <YDlIrjkfv16o4Nu3@builder.lan>
 <20210227135321.420-1-saiprakash.ranjan@codeaurora.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210227135321.420-1-saiprakash.ranjan@codeaurora.org>
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

On Sat 27 Feb 07:53 CST 2021, Sai Prakash Ranjan wrote:

> Hi Bjorn,
> 
> On 2021-02-27 00:44, Bjorn Andersson wrote:
> > On Fri 26 Feb 12:23 CST 2021, Rob Clark wrote:
> > 
> > 
> > The current logic picks one of:
> > 1) is the compatible mentioned in qcom_smmu_impl_of_match[]
> > 2) is the compatible an adreno
> > 3) no quirks needed
> > 
> > The change flips the order of these, so the only way I can see this
> > change affecting things is if we expected a match on #2, but we got one
> > on #1.
> > 
> > Which implies that the instance that we want to act according to the
> > adreno impl was listed in qcom_smmu_impl_of_match[] - which either is
> > wrong, or there's a single instance that needs both behaviors.
> > 
> > (And I believe Jordan's answer confirms the latter - there's a single
> > SMMU instance that needs all them quirks at once)
> > 
> 
> Let me go through the problem statement in case my commit message wasn't
> clear. There are two SMMUs (APSS and GPU) on SC7280 and both are SMMU500
> (ARM SMMU IP).
> 
> APSS SMMU compatible - ("qcom,sc7280-smmu-500", "arm,mmu-500")
> GPU SMMU compatible - ("qcom,sc7280-smmu-500", "qcom,adreno-smmu", "arm,mmu-500")
> 
> Now if we take SC7180 as an example, GPU SMMU was QSMMU(QCOM SMMU IP)
> and APSS SMMU was SMMU500(ARM SMMU IP).
> 
> APSS SMMU compatible - ("qcom,sc7180-smmu-500", "arm,mmu-500")
> GPU SMMU compatible - ("qcom,sc7180-smmu-v2", "qcom,adreno-smmu", "qcom,smmu-v2")
> 
> Current code sequence without this patch,
> 
> if (of_match_node(qcom_smmu_impl_of_match, np))
>                  return qcom_smmu_create(smmu, &qcom_smmu_impl);
> 
> if (of_device_is_compatible(np, "qcom,adreno-smmu"))
>         return qcom_smmu_create(smmu, &qcom_adreno_smmu_impl);
> 
> Now if we look at the compatible for SC7180, there is no problem because
> the APSS SMMU will match the one in qcom_smmu_impl_of_match[] and GPU SMMU
> will match "qcom,adreno-smmu" because the compatible strings are different.
> But for SC7280, both the APSS SMMU and GPU SMMU compatible("qcom,sc7280-smmu-500")
> are same. So GPU SMMU will match with the one in qcom_smmu_impl_of_match[]
> i.e.., "qcom,sc7280-smmu-500" which functionally doesn't cause any problem
> but we will miss settings for split pagetables which are part of GPU SMMU
> specific implementation.
> 
> We can avoid this with yet another new compatible for GPU SMMU something like
> "qcom,sc7280-adreno-smmu-500" but since we can handle this easily in the
> driver and since the IPs are same, meaning if there was a hardware quirk
> required, then we would need to apply to both of them and would this additional
> compatible be of any help?
> 

No, I think you're doing the right thing of having them both. I just
didn't remember us doing that.

> Coming to the part of quirks now, you are right saying both SMMUs will need
> to have the same quirks in SC7280 and similar others where both are based on
> same IPs but those should probably be *hardware quirks* and if they are
> software based like the S2CR quirk depending on the firmware, then it might
> not be applicable to both. In case if it is applicable, then as Jordan mentioned,
> we can add the same quirks in GPU SMMU implementation.
> 

I do suspect that at some point (probably sooner than later) we'd have
to support both inheriting of stream from the bootloader and the Adreno
"quirks" in the same instance.

But for now this is okay to me.

Regards,
Bjorn
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
