Return-Path: <SRS0=CXUA=H4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 147C8C433DB
	for <iommu@archiver.kernel.org>; Fri, 26 Feb 2021 19:15:01 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CF5564F1F
	for <iommu@archiver.kernel.org>; Fri, 26 Feb 2021 19:15:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CF5564F1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 314F743207;
	Fri, 26 Feb 2021 19:15:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aGibyLupXNSA; Fri, 26 Feb 2021 19:14:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1299D43194;
	Fri, 26 Feb 2021 19:14:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E8463C000B;
	Fri, 26 Feb 2021 19:14:58 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 741E9C0001
 for <iommu@lists.linux-foundation.org>; Fri, 26 Feb 2021 19:14:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4BBAE84380
 for <iommu@lists.linux-foundation.org>; Fri, 26 Feb 2021 19:14:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ao_e6FABkpqs for <iommu@lists.linux-foundation.org>;
 Fri, 26 Feb 2021 19:14:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com
 [209.85.210.48])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 635518437C
 for <iommu@lists.linux-foundation.org>; Fri, 26 Feb 2021 19:14:57 +0000 (UTC)
Received: by mail-ot1-f48.google.com with SMTP id d9so10019544ote.12
 for <iommu@lists.linux-foundation.org>; Fri, 26 Feb 2021 11:14:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=rdjUcLxk2QvpLN9cIgDlB2j3H6R/HkQpTGOCpOO1Kzc=;
 b=mkm2dkX4Y+Z734KK7R323V1DAZfdISDSI0DyUExHe3MEfmafJkwFgjh/MTITPaACIx
 6ri8ig6m2bvOCL6L5Vlj2iD5X04ZxDr7tMQYc+Vl09dTP5tcXLzXZP4enTSGazUZ8WUT
 9jo8+oA2bc4w/7CQ1305a0+MIWEVgGfzw/gBlGvjFRDkrZjYkh1LipSMxOxUqoRuzjnh
 3F2SpdqnJdHkzxXCh/DwUKJGbMPlGENG8X+95/t66ABEPVttZ8DvUR4BYhcWwuM8E2Ga
 bMT64Tv03tP5ceB2fLJJO8qqQctHge9YmIawYoxZN6PXA239Et13LGoTpuh6sg0BHgRC
 Tbbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=rdjUcLxk2QvpLN9cIgDlB2j3H6R/HkQpTGOCpOO1Kzc=;
 b=lUrJVabzhemOetbsa6SiY286YbeN3S+UX6Z9hSz7plzX3iJoZn3gjLsmgqT1ECI/2h
 JsEd0lJCAt5MXRn5FmpxQGXBRTXVBgggP8OJm+fj7mSRGuGJABUzj/PX850nPY7LxRnG
 lq1KMFESf4f6fyNr564bXbOgQK564AkUnr2/nMG9fZSJvDeyJZPH9TPxryq0fUhF9pYF
 ajHjtYArEhMdGcDaZ61wx9JJREehZFk2puHcVafOOH4NvaogeN4MBowvCTs1Ivq5Tfeh
 b3dgbqfuM0208MLZ/kgJFYotdK8ttaaOaiNiO/2tySb3XXXqbpS6mn9ADgt5vrTxblm0
 WtrA==
X-Gm-Message-State: AOAM533xTvIoJaiw4GKmqPg7vD1l6k1TnzfPHPXoHZcKYqRnIEd799Ik
 X5f/8WNRVtlGbPVpGVkpnMi3/w==
X-Google-Smtp-Source: ABdhPJxzYAfho+QsHxzw0qLDDKe+oOdenr7TqRA2BY16Q3eGFcAz2SSEe8X4Q7pgZcv10c+yJEjeAg==
X-Received: by 2002:a9d:ec8:: with SMTP id 66mr3553224otj.217.1614366896253;
 Fri, 26 Feb 2021 11:14:56 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net.
 [104.57.184.186])
 by smtp.gmail.com with ESMTPSA id 64sm1965824otl.5.2021.02.26.11.14.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Feb 2021 11:14:55 -0800 (PST)
Date: Fri, 26 Feb 2021 13:14:54 -0600
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Rob Clark <robdclark@gmail.com>
Subject: Re: [PATCHv2 2/2] iommu/arm-smmu-qcom: Move the adreno smmu specific
 impl earlier
Message-ID: <YDlIrjkfv16o4Nu3@builder.lan>
References: <cover.1614332994.git.saiprakash.ranjan@codeaurora.org>
 <c607d71eb0fe507c8b83cc0ea9b393777f22149a.1614332994.git.saiprakash.ranjan@codeaurora.org>
 <YDku5PFQZetP4iG8@builder.lan>
 <CAF6AEGvJF19JA5hNps37urMrF5r03y90XgvO4FtT6wFPD6UZcA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAF6AEGvJF19JA5hNps37urMrF5r03y90XgvO4FtT6wFPD6UZcA@mail.gmail.com>
Cc: Will Deacon <will@kernel.org>, Akhil P Oommen <akhilpo@codeaurora.org>,
 "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Jordan Crouse <jcrouse@codeaurora.org>,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
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

On Fri 26 Feb 12:23 CST 2021, Rob Clark wrote:

> On Fri, Feb 26, 2021 at 9:24 AM Bjorn Andersson
> <bjorn.andersson@linaro.org> wrote:
> >
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
> >
> 
> are you thinking of the apps-smmu handover of display context bank?
> That shouldn't change, the only thing that changes is that gpu-smmu
> becomes an mmu-500, whereas previously only apps-smmu was..
> 

The current logic picks one of:
1) is the compatible mentioned in qcom_smmu_impl_of_match[]
2) is the compatible an adreno
3) no quirks needed

The change flips the order of these, so the only way I can see this
change affecting things is if we expected a match on #2, but we got one
on #1.

Which implies that the instance that we want to act according to the
adreno impl was listed in qcom_smmu_impl_of_match[] - which either is
wrong, or there's a single instance that needs both behaviors.

(And I believe Jordan's answer confirms the latter - there's a single
SMMU instance that needs all them quirks at once)

Regards,
Bjorn
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
