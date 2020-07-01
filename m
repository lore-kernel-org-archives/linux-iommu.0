Return-Path: <SRS0=cxdO=AM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A98F6C433E0
	for <iommu@archiver.kernel.org>; Wed,  1 Jul 2020 10:11:14 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FDEA20722
	for <iommu@archiver.kernel.org>; Wed,  1 Jul 2020 10:11:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="eMlITMYb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FDEA20722
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id D64AE30184;
	Wed,  1 Jul 2020 10:11:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id m8iJaDsHgH18; Wed,  1 Jul 2020 10:11:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id E2D012FD39;
	Wed,  1 Jul 2020 10:11:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D2B9FC0865;
	Wed,  1 Jul 2020 10:11:12 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5873CC0733
 for <iommu@lists.linux-foundation.org>; Wed,  1 Jul 2020 10:11:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 47063892A5
 for <iommu@lists.linux-foundation.org>; Wed,  1 Jul 2020 10:11:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MkUd-9zxmefM for <iommu@lists.linux-foundation.org>;
 Wed,  1 Jul 2020 10:11:10 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail29.static.mailgun.info (mail29.static.mailgun.info
 [104.130.122.29])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 5A68189268
 for <iommu@lists.linux-foundation.org>; Wed,  1 Jul 2020 10:11:08 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1593598269; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=amiqoJGPjX9RNHOLVHTe5Q2mOjhh5iGIl3d/MtXJOIs=;
 b=eMlITMYbIFjHc7uoLmqiaaIzwggBXoKl4ccpyP3RTxYD2CFB3gD+M4YudExvhBUFiAE3Pg5J
 V78yr3ycugDqTP4jFib7gLnTrTMPVDWSD5ZA5/0uLGBIEYRDnlc4GzlicgiddKv75mfOtSDY
 PjIxtZxUijeqghlTqKKuvqGCpJY=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3NDkwMCIsICJpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n09.prod.us-west-2.postgun.com with SMTP id
 5efc61394c9690533a499e35 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 01 Jul 2020 10:11:05
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id 22B97C433CB; Wed,  1 Jul 2020 10:11:05 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: saiprakash.ranjan)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id B6F35C433C8;
 Wed,  1 Jul 2020 10:11:03 +0000 (UTC)
MIME-Version: 1.0
Date: Wed, 01 Jul 2020 15:41:03 +0530
From: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To: Robin Murphy <robin.murphy@arm.com>, Jordan Crouse
 <jcrouse@codeaurora.org>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH v9 0/7] iommu/arm-smmu: Enable split pagetable support
In-Reply-To: <20200626200042.13713-1-jcrouse@codeaurora.org>
References: <20200626200042.13713-1-jcrouse@codeaurora.org>
Message-ID: <bdc2a4348230f430138d320e49e188c0@codeaurora.org>
X-Sender: saiprakash.ranjan@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Cc: Sean Paul <sean@poorly.run>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, David Airlie <airlied@linux.ie>,
 linux-arm-msm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>, Takashi Iwai <tiwai@suse.de>,
 iommu@lists.linux-foundation.org, Andy Gross <agross@kernel.org>,
 John Stultz <john.stultz@linaro.org>, dri-devel@lists.freedesktop.org,
 Daniel Vetter <daniel@ffwll.ch>, Shawn Guo <shawn.guo@linaro.org>,
 freedreno@lists.freedesktop.org, linux-arm-msm-owner@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Brian Masney <masneyb@onstation.org>
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

Hi Will, Robin,

On 2020-06-27 01:30, Jordan Crouse wrote:
> Another iteration of the split-pagetable support for arm-smmu and the 
> Adreno GPU
> SMMU. After email discussions [1] we opted to make a arm-smmu 
> implementation for
> specifically for the Adreno GPU and use that to enable split pagetable 
> support
> and later other implementation specific bits that we need.
> 
> On the hardware side this is very close to the same code from before 
> [2] only
> the TTBR1 quirk is turned on by the implementation and not a domain 
> attribute.
> In drm/msm we use the returned size of the aperture as a clue to let us 
> know
> which virtual address space we should use for global memory objects.
> 
> There are two open items that you should be aware of. First, in the
> implementation specific code we have to check the compatible string of 
> the
> device so that we only enable TTBR1 for the GPU (SID 0) and not the GMU 
> (SID 4).
> I went back and forth trying to decide if I wanted to use the 
> compatible string
> or the SID as the filter and settled on the compatible string but I 
> could be
> talked out of it.
> 
> The other open item is that in drm/msm the hardware only uses 49 bits 
> of the
> address space but arm-smmu expects the address to be sign extended all 
> the way
> to 64 bits. This isn't a problem normally unless you look at the 
> hardware
> registers that contain a IOVA and then the upper bits will be zero. I 
> opted to
> restrict the internal drm/msm IOVA range to only 49 bits and then sign 
> extend
> right before calling iommu_map / iommu_unmap. This is a bit wonky but I 
> thought
> that matching the hardware would be less confusing when debugging a 
> hang.
> 
> v9: Fix bot-detected merge conflict
> v7: Add attached device to smmu_domain to pass to implementation 
> specific
> functions
> 
> [1] 
> https://lists.linuxfoundation.org/pipermail/iommu/2020-May/044537.html
> [2] https://patchwork.kernel.org/patch/11482591/
> 
> 
> Jordan Crouse (7):
>   iommu/arm-smmu: Pass io-pgtable config to implementation specific
>     function
>   iommu/arm-smmu: Add support for split pagetables
>   dt-bindings: arm-smmu: Add compatible string for Adreno GPU SMMU
>   iommu/arm-smmu: Add a pointer to the attached device to smmu_domain
>   iommu/arm-smmu: Add implementation for the adreno GPU SMMU
>   drm/msm: Set the global virtual address range from the IOMMU domain
>   arm: dts: qcom: sm845: Set the compatible string for the GPU SMMU
> 
>  .../devicetree/bindings/iommu/arm,smmu.yaml   |  4 ++
>  arch/arm64/boot/dts/qcom/sdm845.dtsi          |  2 +-
>  drivers/gpu/drm/msm/adreno/adreno_gpu.c       | 13 +++++-
>  drivers/gpu/drm/msm/msm_iommu.c               |  7 +++
>  drivers/iommu/arm-smmu-impl.c                 |  6 ++-
>  drivers/iommu/arm-smmu-qcom.c                 | 45 ++++++++++++++++++-
>  drivers/iommu/arm-smmu.c                      | 38 +++++++++++-----
>  drivers/iommu/arm-smmu.h                      | 30 ++++++++++---
>  8 files changed, 120 insertions(+), 25 deletions(-)

Any chance reviewing this?

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
