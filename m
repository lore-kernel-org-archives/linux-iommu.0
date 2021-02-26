Return-Path: <SRS0=CXUA=H4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 956D5C433E0
	for <iommu@archiver.kernel.org>; Fri, 26 Feb 2021 18:23:46 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E41CB64F1B
	for <iommu@archiver.kernel.org>; Fri, 26 Feb 2021 18:23:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E41CB64F1B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 79DE7433FA;
	Fri, 26 Feb 2021 18:23:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TnmFtsEU7n9T; Fri, 26 Feb 2021 18:23:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6BD0E43408;
	Fri, 26 Feb 2021 18:23:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 438DAC000A;
	Fri, 26 Feb 2021 18:23:44 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4CF62C0001
 for <iommu@lists.linux-foundation.org>; Fri, 26 Feb 2021 18:23:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3A68E842FD
 for <iommu@lists.linux-foundation.org>; Fri, 26 Feb 2021 18:23:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bMWschle3LtZ for <iommu@lists.linux-foundation.org>;
 Fri, 26 Feb 2021 18:23:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 60D96842E8
 for <iommu@lists.linux-foundation.org>; Fri, 26 Feb 2021 18:23:42 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id u125so8596996wmg.4
 for <iommu@lists.linux-foundation.org>; Fri, 26 Feb 2021 10:23:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=+if41+OOIdTEnjXmNHOorURwzXxyDnY3DpTEWUu3DAU=;
 b=Tqtnj1MFHSpc1FQCK2N/CCWbj9CtLdzVblqJKfGWGJ5IUfajvAkCXyiEqAYVCxHNVL
 uZO8z/3ZVDrUjGqZG0qInL91G1v7+ppWG1Gk4KXHSAgbxpEy2jlBbp4HTUC5v4MIAjTn
 fTFtbOrC+rABvac0fwLi8Bd2Oj4dZR0laGAdgLZ/DYei1UYBgYnG1ugMCghuVN2LLp8F
 dEE46iC3ez7ye+881OPToutE8LG1fXjr3Qmk8Ky0p+sYeKElX8gPyPzBkDc0E2xme+8y
 FylDUQzKOtxlAAhX3hK3erL0W4+JR5xjXg1HG6faM7KC8ys/GJ+KwA2qokx3q/6SkusN
 RqaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=+if41+OOIdTEnjXmNHOorURwzXxyDnY3DpTEWUu3DAU=;
 b=Gk2raHPv/p/HvRQ25z0y1acFAseRaBevXnkzYgdMGsZu7ESxbmxqhL2XLg2YP8B49r
 QobN0sk8KSKAAjA9FCqftOALMNofDRHn6CSrSrsfVxv2d5WfzX6m02tMG1ydFT0z0L4a
 ke5AR2gl+RZknNaCaUxwrHEpcBEOe6l4ROqJrdcsOOzTxh/7GPEMIIA+IspqBAWk4of9
 b1EYCOeM0dhMkvC/vmZEylFtIUDLXcN/Sbqx2nr3YZ573TILbY0zp9quwNrmzy/b5gMu
 Fpgouh33KOZUvHvKTE1HQieWAaLgl1qSKjGVYQWIXhGR62GIM8y09KkNHR2O7pWpaYLr
 OSew==
X-Gm-Message-State: AOAM532lgy0dG1EV1RL2H1pgFqzFRBSynzjanm1xMVL/nlEb9e7WEnqM
 LDEIp1FtLFQkJwFmaJ+fGWSl1vXxWoBxdlAsq+8=
X-Google-Smtp-Source: ABdhPJxgrMe0mZZyxBO0ola6cjhlCi4j2IxQKxy4A06JD5sd+FlxIa4WTLYGrTX1znn9Z+cNAcbd5kGORqMGIWA9SlE=
X-Received: by 2002:a05:600c:cc:: with SMTP id
 u12mr4204438wmm.49.1614363820563; 
 Fri, 26 Feb 2021 10:23:40 -0800 (PST)
MIME-Version: 1.0
References: <cover.1614332994.git.saiprakash.ranjan@codeaurora.org>
 <c607d71eb0fe507c8b83cc0ea9b393777f22149a.1614332994.git.saiprakash.ranjan@codeaurora.org>
 <YDku5PFQZetP4iG8@builder.lan>
In-Reply-To: <YDku5PFQZetP4iG8@builder.lan>
From: Rob Clark <robdclark@gmail.com>
Date: Fri, 26 Feb 2021 10:23:28 -0800
Message-ID: <CAF6AEGvJF19JA5hNps37urMrF5r03y90XgvO4FtT6wFPD6UZcA@mail.gmail.com>
Subject: Re: [PATCHv2 2/2] iommu/arm-smmu-qcom: Move the adreno smmu specific
 impl earlier
To: Bjorn Andersson <bjorn.andersson@linaro.org>
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

On Fri, Feb 26, 2021 at 9:24 AM Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
>
> On Fri 26 Feb 03:55 CST 2021, Sai Prakash Ranjan wrote:
>
> > Adreno(GPU) SMMU and APSS(Application Processor SubSystem) SMMU
> > both implement "arm,mmu-500" in some QTI SoCs and to run through
> > adreno smmu specific implementation such as enabling split pagetables
> > support, we need to match the "qcom,adreno-smmu" compatible first
> > before apss smmu or else we will be running apps smmu implementation
> > for adreno smmu and the additional features for adreno smmu is never
> > set. For ex: we have "qcom,sc7280-smmu-500" compatible for both apps
> > and adreno smmu implementing "arm,mmu-500", so the adreno smmu
> > implementation is never reached because the current sequence checks
> > for apps smmu compatible(qcom,sc7280-smmu-500) first and runs that
> > specific impl and we never reach adreno smmu specific implementation.
> >
>
> So you're saying that you have a single SMMU instance that's compatible
> with both an entry in qcom_smmu_impl_of_match[] and "qcom,adreno-smmu"?
>
> Per your proposed change we will pick the adreno ops _only_ for this
> component, essentially disabling the non-Adreno quirks selected by the
> qcom impl. As such keeping the non-adreno compatible in the
> qcom_smmu_impl_init[] seems to only serve to obfuscate the situation.
>
> Don't we somehow need the combined set of quirks? (At least if we're
> running this with a standard UEFI based boot flow?)
>

are you thinking of the apps-smmu handover of display context bank?
That shouldn't change, the only thing that changes is that gpu-smmu
becomes an mmu-500, whereas previously only apps-smmu was..

BR,
-R
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
