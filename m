Return-Path: <SRS0=CXUA=H4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4CF6C433E0
	for <iommu@archiver.kernel.org>; Fri, 26 Feb 2021 19:54:25 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18EFB64EAF
	for <iommu@archiver.kernel.org>; Fri, 26 Feb 2021 19:54:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18EFB64EAF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cosmicpenguin.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B3058841E9;
	Fri, 26 Feb 2021 19:54:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ei3ybpfq1g11; Fri, 26 Feb 2021 19:54:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6D99A84164;
	Fri, 26 Feb 2021 19:54:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 42C81C000B;
	Fri, 26 Feb 2021 19:54:23 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0466FC0001
 for <iommu@lists.linux-foundation.org>; Fri, 26 Feb 2021 19:54:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DFADE43202
 for <iommu@lists.linux-foundation.org>; Fri, 26 Feb 2021 19:54:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key)
 header.d=cosmicpenguin-net.20150623.gappssmtp.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CvRSuQ1Bs1Fb for <iommu@lists.linux-foundation.org>;
 Fri, 26 Feb 2021 19:54:20 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mail-io1-f67.google.com (mail-io1-f67.google.com
 [209.85.166.67])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 54368431C4
 for <iommu@lists.linux-foundation.org>; Fri, 26 Feb 2021 19:54:20 +0000 (UTC)
Received: by mail-io1-f67.google.com with SMTP id s24so10885916iob.6
 for <iommu@lists.linux-foundation.org>; Fri, 26 Feb 2021 11:54:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cosmicpenguin-net.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:subject:message-id:mail-followup-to:references
 :mime-version:content-disposition:in-reply-to;
 bh=JIP7pj2bII2YYqVDvOr4T8XZtG0IKAlZ5S5uVeQftY8=;
 b=ReNrLHuTcYMc5CV8DYEubwqgUp8OLflDGEY3KtfN43gOeixyXRxztxX99MgxHh0g5d
 64KTNKWWxXh2DgacpC4Wr91I7A5c/DV52KLxiNYe3/k3tSnFScQqUEYqVhFnrqyAJPCv
 OU7V7jy/7u93j2hDr4MzeddvDsi7nOAxg/L86PTHJhXfrSfMy5J+Wj6K1fp0e7IsjMFI
 b9S9V8UPPqDvUV/hcyBozDp+3fFJuK3M6drZly2dsWbnlnimNN39KgKUgcUMs0xLzOhb
 rRqpiSFSTrSfDaJo77cGfE9CpNFM0cy4knvulCrmTuoZeplJi6wi92xK1eRB97L/Vr6b
 duKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:subject:message-id:mail-followup-to
 :references:mime-version:content-disposition:in-reply-to;
 bh=JIP7pj2bII2YYqVDvOr4T8XZtG0IKAlZ5S5uVeQftY8=;
 b=Lgnyj3ykbVfDieLpl/C6YjW5kv2C25DSJmPrhgDYdWHq1+N7B9Kz1Hdr9adujfsl6A
 L6j1MNYflVHYe9icbpKQAuRqzNsPvLF+eljIwyWmaVivK24VQJzIY7WAWkFx1sboYaY5
 j3GE7gDdwMWmCH9eGZrMKDddzR4SU0aMBTv7eLcDIA7sLn8e80k5aPUAoE1F9XaviHEu
 V+tfVWzDW72UluVm/aVM1Er8eIQa2cy3ZlBzk5YCvrR2mpwM9SFIYoelEQuSRK9tiA39
 nYQwtVayakkMCr2sDR7kRcYquY/4pdEXVCouhC9CbBbcaPKt1W2PZ1jkA2wIiEu+MrSE
 Oefw==
X-Gm-Message-State: AOAM533uOGv3eND+VCAsn7GGxuDJW/rZuRimpYwbsIJJ9Tu9s6BtGHng
 jh+5enePAaVN0uS7+//dvwxgBw==
X-Google-Smtp-Source: ABdhPJxT3JMfcN7o0fe55mwMhIvwoQjsrhAEaDedA6b09+t1iIJRi3Lvanp7xOpZX4iPzsgu8QnT+Q==
X-Received: by 2002:a02:3541:: with SMTP id y1mr4532704jae.66.1614369259483;
 Fri, 26 Feb 2021 11:54:19 -0800 (PST)
Received: from cosmicpenguin.net (c-71-237-100-236.hsd1.co.comcast.net.
 [71.237.100.236])
 by smtp.gmail.com with ESMTPSA id u14sm5012109ilv.0.2021.02.26.11.54.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Feb 2021 11:54:19 -0800 (PST)
Date: Fri, 26 Feb 2021 12:54:16 -0700
From: Jordan Crouse <jordan@cosmicpenguin.net>
To: Bjorn Andersson <bjorn.andersson@linaro.org>,
 Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
 Will Deacon <will@kernel.org>, Akhil P Oommen <akhilpo@codeaurora.org>,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 Jordan Crouse <jcrouse@codeaurora.org>,
 linux-arm-msm@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCHv2 2/2] iommu/arm-smmu-qcom: Move the adreno smmu specific
 impl earlier
Message-ID: <20210226195416.7dzyln7v6lke6ssr@cosmicpenguin.net>
Mail-Followup-To: Bjorn Andersson <bjorn.andersson@linaro.org>,
 Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
 Will Deacon <will@kernel.org>,
 Akhil P Oommen <akhilpo@codeaurora.org>,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 Jordan Crouse <jcrouse@codeaurora.org>,
 linux-arm-msm@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
 linux-arm-kernel@lists.infradead.org
References: <cover.1614332994.git.saiprakash.ranjan@codeaurora.org>
 <c607d71eb0fe507c8b83cc0ea9b393777f22149a.1614332994.git.saiprakash.ranjan@codeaurora.org>
 <YDku5PFQZetP4iG8@builder.lan>
 <20210226184813.t6ohkh3gxeseev2j@cosmicpenguin.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210226184813.t6ohkh3gxeseev2j@cosmicpenguin.net>
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

On Fri, Feb 26, 2021 at 11:48:13AM -0700, Jordan Crouse wrote:
> On Fri, Feb 26, 2021 at 11:24:52AM -0600, Bjorn Andersson wrote:
> > On Fri 26 Feb 03:55 CST 2021, Sai Prakash Ranjan wrote:
> > 
> > > Adreno(GPU) SMMU and APSS(Application Processor SubSystem) SMMU
> > > both implement "arm,mmu-500" in some QTI SoCs and to run through
> > > adreno smmu specific implementation such as enabling split pagetables
> > > support, we need to match the "qcom,adreno-smmu" compatible first
> > > before apss smmu or else we will be running apps smmu implementation
> > > for adreno smmu and the additional features for adreno smmu is never
> > > set. For ex: we have "qcom,sc7280-smmu-500" compatible for both apps
> > > and adreno smmu implementing "arm,mmu-500", so the adreno smmu
> > > implementation is never reached because the current sequence checks
> > > for apps smmu compatible(qcom,sc7280-smmu-500) first and runs that
> > > specific impl and we never reach adreno smmu specific implementation.
> > > 
> > 
> > So you're saying that you have a single SMMU instance that's compatible
> > with both an entry in qcom_smmu_impl_of_match[] and "qcom,adreno-smmu"?
> > 
> > Per your proposed change we will pick the adreno ops _only_ for this
> > component, essentially disabling the non-Adreno quirks selected by the
> > qcom impl. As such keeping the non-adreno compatible in the
> > qcom_smmu_impl_init[] seems to only serve to obfuscate the situation.
> > 
> > Don't we somehow need the combined set of quirks? (At least if we're
> > running this with a standard UEFI based boot flow?)
> 
> We *do* need the combined set of quirks, so there has to be an adreno-smmu
> impelmentation that matches the "generic" implementation with a few extra
> function hooks added on. I'm not sure if there is a clever way to figure out how
> to meld the implementation hooks at runtime but the alternative is to just make
> sure that the adreno-smmu static struct calls the same quirks as its generic
> partner.

To clarify, the gpu-smmu doesn't strictly need the s2cr handoff or the cfg_probe
though it wouldn't hurt to have them since they would be essentially
passthroughs for the GPU. We do need to capture errata like the
sdm845_smmu500_reset which is already part of the upstream adreno
implementation.

I think the main takeaway is that if a new errata or quirk is added
for main mmu500 it needs to be considered for adreno-smmu too.

Jordan

> > > Suggested-by: Akhil P Oommen <akhilpo@codeaurora.org>
> > > Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> > > ---
> > >  drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 12 +++++++++---
> > >  1 file changed, 9 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> > > index bea3ee0dabc2..03f048aebb80 100644
> > > --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> > > +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> > > @@ -345,11 +345,17 @@ struct arm_smmu_device *qcom_smmu_impl_init(struct arm_smmu_device *smmu)
> > >  {
> > >  	const struct device_node *np = smmu->dev->of_node;
> > >  
> > > -	if (of_match_node(qcom_smmu_impl_of_match, np))
> > > -		return qcom_smmu_create(smmu, &qcom_smmu_impl);
> > > -
> > > +	/*
> > > +	 * Do not change this order of implementation, i.e., first adreno
> > > +	 * smmu impl and then apss smmu since we can have both implementing
> > > +	 * arm,mmu-500 in which case we will miss setting adreno smmu specific
> > > +	 * features if the order is changed.
> > > +	 */
> > >  	if (of_device_is_compatible(np, "qcom,adreno-smmu"))
> > >  		return qcom_smmu_create(smmu, &qcom_adreno_smmu_impl);
> > >  
> > > +	if (of_match_node(qcom_smmu_impl_of_match, np))
> > > +		return qcom_smmu_create(smmu, &qcom_smmu_impl);
> > > +
> > >  	return smmu;
> > >  }
> > > -- 
> > > QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> > > of Code Aurora Forum, hosted by The Linux Foundation
> > > 
> > _______________________________________________
> > iommu mailing list
> > iommu@lists.linux-foundation.org
> > https://lists.linuxfoundation.org/mailman/listinfo/iommu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
