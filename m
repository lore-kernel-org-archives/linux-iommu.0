Return-Path: <SRS0=szPT=AU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15441C433E1
	for <iommu@archiver.kernel.org>; Thu,  9 Jul 2020 16:48:47 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D11C320720
	for <iommu@archiver.kernel.org>; Thu,  9 Jul 2020 16:48:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CF2pkdTO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D11C320720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 9D461220A9;
	Thu,  9 Jul 2020 16:48:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id As7JCJR8V93p; Thu,  9 Jul 2020 16:48:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id B147C204FB;
	Thu,  9 Jul 2020 16:48:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9B0F9C0865;
	Thu,  9 Jul 2020 16:48:45 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 588D0C016F
 for <iommu@lists.linux-foundation.org>; Thu,  9 Jul 2020 16:48:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 4B66B87EB5
 for <iommu@lists.linux-foundation.org>; Thu,  9 Jul 2020 16:48:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gyCU0kvIi+90 for <iommu@lists.linux-foundation.org>;
 Thu,  9 Jul 2020 16:48:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com
 [209.85.214.196])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 5F2B4876A6
 for <iommu@lists.linux-foundation.org>; Thu,  9 Jul 2020 16:48:43 +0000 (UTC)
Received: by mail-pl1-f196.google.com with SMTP id x8so1055735plm.10
 for <iommu@lists.linux-foundation.org>; Thu, 09 Jul 2020 09:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=8JulLZkbhkxBJld9UcW1bp7kKFXu909a3L7NGHRfHog=;
 b=CF2pkdTO/cmM1aimn9kGQiMUMY8ZIeZzvrIAjzlPk2GimjcgWS8XUfvFmfhnT6a2KT
 72SMMVNATr1EcnJ6XoPeFH1/wAmjX8QN9y6dnSB5lz2+WYkF0FkvrgIkA0oqIboA4/Ov
 uvNSSUDpDyYwAFfwTsTh7ZbnkuIQsY6dvVXWQ+3m1UEN34wQhbsJBBCKpqmqX959w/CK
 jACQ0XgWOItT5xl+kyOTcT/q5cTvqWZ7vULfsVNwndu4b+w0Eu+1VLDnthMPFTb7A84U
 PxQLIaS+brjNP4vU+sMuQyer+QAWr6xT1HrdciTaxdZ2Li2YF8zCBQkINqtjhzMwtfyt
 T+zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=8JulLZkbhkxBJld9UcW1bp7kKFXu909a3L7NGHRfHog=;
 b=uJnupiiN9PJAuZe2IjfFEs+pSsLM/lji1pZg0flusTbYea5qkLPXAYLLfmxZ2jJn/Y
 Rw7wvpVwpqf/1+HAks08SfnWeqkN5iaisp1zlXTydld+r5mfjF1D7JpxCQlTfucq9xBJ
 ryHf3lg6Q91v94X4Y6M7794rYuL8c1+6FgrZeBJjiS6e2yRK070bXxMfljQ3U7+iPfpm
 KrS45IWfxgVf3FriL13Iw08NQZ4/RT6uhNMqITGeXFaaOXXnu3EpmMDVwiVFud2Id4Sj
 snVspsO6NLRFMcTtNa+o8TS62MUvx/gGxb4CHOwJ0MF4Lc/4HyYDaQZKVvg3q1NbLq0z
 OIdw==
X-Gm-Message-State: AOAM5308YZtDwF8abyN9dHNwCXSoo4xwRL1xI2mFfrEvt0P0/HAT8paa
 314bkJFt6UVsCTpH2ss3ReJ4aQ==
X-Google-Smtp-Source: ABdhPJwDJM3uQ2KakQWSb/5lIKFeBEQm4VshEG9AnmftSIGRVhm29Zscyx+er1CWEdTOkUl3kSyQVg==
X-Received: by 2002:a17:902:ab8e:: with SMTP id
 f14mr57060503plr.80.1594313322777; 
 Thu, 09 Jul 2020 09:48:42 -0700 (PDT)
Received: from yoga (104-188-17-28.lightspeed.sndgca.sbcglobal.net.
 [104.188.17.28])
 by smtp.gmail.com with ESMTPSA id q29sm3225777pfl.77.2020.07.09.09.48.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2020 09:48:42 -0700 (PDT)
Date: Thu, 9 Jul 2020 09:48:37 -0700
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Rob Clark <robdclark@gmail.com>
Subject: Re: [PATCH 2/5] iommu/arm-smmu: Emulate bypass by using context banks
Message-ID: <20200709164833.GR11847@yoga>
References: <20200709050145.3520931-1-bjorn.andersson@linaro.org>
 <20200709050145.3520931-3-bjorn.andersson@linaro.org>
 <CAF6AEGugJYmMpeH_9mWXcegq1awzraUzBTa0S1Rqcr3=Bmk0uQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAF6AEGugJYmMpeH_9mWXcegq1awzraUzBTa0S1Rqcr3=Bmk0uQ@mail.gmail.com>
Cc: Jonathan Marek <jonathan@marek.ca>, Will Deacon <will@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
 Thierry Reding <thierry.reding@gmail.com>,
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

On Thu 09 Jul 09:17 PDT 2020, Rob Clark wrote:

> On Wed, Jul 8, 2020 at 10:01 PM Bjorn Andersson
> <bjorn.andersson@linaro.org> wrote:
[..]
> > @@ -678,7 +680,11 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
> >         if (smmu_domain->smmu)
> >                 goto out_unlock;
> >
> > -       if (domain->type == IOMMU_DOMAIN_IDENTITY) {
> > +       /*
> > +        * Nothing to do for IDENTITY domains,unless disabled context banks are
> > +        * used to emulate bypass mappings on Qualcomm platforms.
> > +        */
> > +       if (domain->type == IOMMU_DOMAIN_IDENTITY && !smmu->qcom_bypass_quirk) {
> 
> maybe I'm overlooking something, but I think this would put us back to
> allocating pgtables (and making iommu->map/unmap() no longer no-ops),
> which I don't think we want
> 

You're right, we are allocating page tables for these contexts and
map/unmap would modify the page tables. But afaict traversal is never
performed, given that the banks are never enabled.

But as drivers probe properly, or the direct mapped drivers sets up
their iommu domains explicitly with translation this would not be used.

So afaict we're just wasting some memory - for the gain of not
overcomplicating this function.

Regards,
Bjorn

> BR,
> -R
> 
> >                 smmu_domain->stage = ARM_SMMU_DOMAIN_BYPASS;
> >                 smmu_domain->smmu = smmu;
> >                 goto out_unlock;
> > @@ -826,6 +832,10 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
> >         domain->geometry.aperture_end = (1UL << ias) - 1;
> >         domain->geometry.force_aperture = true;
> >
> > +       /* Enable translation for non-identity context banks */
> > +       if (domain->type != IOMMU_DOMAIN_IDENTITY)
> > +               cfg->m = true;
> > +
> >         /* Initialise the context bank with our page table cfg */
> >         arm_smmu_init_context_bank(smmu_domain, &pgtbl_cfg);
> >         arm_smmu_write_context_bank(smmu, cfg->cbndx);
> > diff --git a/drivers/iommu/arm-smmu.h b/drivers/iommu/arm-smmu.h
> > index d172c024be61..a71d193073e4 100644
> > --- a/drivers/iommu/arm-smmu.h
> > +++ b/drivers/iommu/arm-smmu.h
> > @@ -305,6 +305,8 @@ struct arm_smmu_device {
> >
> >         /* IOMMU core code handle */
> >         struct iommu_device             iommu;
> > +
> > +       bool                            qcom_bypass_quirk;
> >  };
> >
> >  enum arm_smmu_context_fmt {
> > @@ -323,6 +325,7 @@ struct arm_smmu_cfg {
> >         };
> >         enum arm_smmu_cbar_type         cbar;
> >         enum arm_smmu_context_fmt       fmt;
> > +       bool                            m;
> >  };
> >  #define ARM_SMMU_INVALID_IRPTNDX       0xff
> >
> > --
> > 2.26.2
> >
> > _______________________________________________
> > iommu mailing list
> > iommu@lists.linux-foundation.org
> > https://lists.linuxfoundation.org/mailman/listinfo/iommu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
