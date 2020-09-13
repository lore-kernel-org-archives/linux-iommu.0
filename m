Return-Path: <SRS0=ut7E=CW=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06C66C433E2
	for <iommu@archiver.kernel.org>; Sun, 13 Sep 2020 03:26:10 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8EE7C207EA
	for <iommu@archiver.kernel.org>; Sun, 13 Sep 2020 03:26:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yyrNCTgA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EE7C207EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 266F587098;
	Sun, 13 Sep 2020 03:26:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oz14dRJCVe0M; Sun, 13 Sep 2020 03:26:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 5F9F28707F;
	Sun, 13 Sep 2020 03:26:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4329DC0859;
	Sun, 13 Sep 2020 03:26:08 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 29141C0051
 for <iommu@lists.linux-foundation.org>; Sun, 13 Sep 2020 03:26:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 0DFE786C80
 for <iommu@lists.linux-foundation.org>; Sun, 13 Sep 2020 03:26:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tOeXYkSzXYRI for <iommu@lists.linux-foundation.org>;
 Sun, 13 Sep 2020 03:26:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-oi1-f196.google.com (mail-oi1-f196.google.com
 [209.85.167.196])
 by whitealder.osuosl.org (Postfix) with ESMTPS id EB8D986CB4
 for <iommu@lists.linux-foundation.org>; Sun, 13 Sep 2020 03:26:03 +0000 (UTC)
Received: by mail-oi1-f196.google.com with SMTP id y6so13897849oie.5
 for <iommu@lists.linux-foundation.org>; Sat, 12 Sep 2020 20:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=Ke7lMIRXust3VuSv0nKgJkbwsX5Y5U3wXBvizA4PXrY=;
 b=yyrNCTgAFp3sCepk225S6NTSjOCGVhzw4iRmePIaTzvjnZwKHF3PuOcLpxPadQ3vvq
 OkgdzrIYnZ4nWcncJEqM+FHOgG094D0K/+BioANbWip4mn832eoNK+dWcSxVvlYu2JYQ
 ZBoR0LJ5Lc+YxYqe8zvagnENnOCCUX+VMuZ3EJ/Wv0nOellILxqC31ZzAxjdYWLYyuxY
 FJY1jRg0jdevnILWK2NMHL1mgpgBv5HhDm1IJVSqYdh8oZlnDefvYn1k9H/ZY4rmCLvR
 7kvI70mV4GYFUNiKigTpeSQCuhslkDyJfMhaJt0gQS/lx8H2tZDbm5I6KJbn9wj11oxS
 8CWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Ke7lMIRXust3VuSv0nKgJkbwsX5Y5U3wXBvizA4PXrY=;
 b=LO84mvDIHX6OD8IIzkmM/E/Nsy0AVFaJoXwhAHJ8HGT3ES1ejWIDp0y+kAVyx0VEdU
 P1+kwRU9zAcRy55oP2D5vcc8BOI/JfvhZ2aEyTbnwNrhEXbZLfiHWswx9JWOKgYw468L
 rdeEGJrREyMXHCl1zexJcKMz8Y6/QcuGj0HIcGUV1tnP9arvopRqb6F1cMPnhtWgqKPN
 jtm5hM7XxmnRodHO+6/N05ttlzW+jNuVFRZZZEB1L/PYJqnxOM+ZG/jyNDNYKC38ePww
 s2NqWV/lnsYwqgcD8pdtRYd525P+j+4wXPBJMpjkL5neffTcCQnsBbDJpb1IfF0seJEm
 DOpA==
X-Gm-Message-State: AOAM531XaRiwohXAwJdug8SdR8inF7tHez7FtC2z92xqMP5JINTSyooo
 fr9GbYJDlneC76TyDu0DB4OXBg==
X-Google-Smtp-Source: ABdhPJxuAIm2+/oMuWoP3Xg/emHDDPJVX7MIdtBknMrXrH/r4UieHbwSGIT61sNebSjEFvwanaMmUg==
X-Received: by 2002:aca:1006:: with SMTP id 6mr5092573oiq.2.1599967562993;
 Sat, 12 Sep 2020 20:26:02 -0700 (PDT)
Received: from yoga ([2605:6000:e5cb:c100:8898:14ff:fe6d:34e])
 by smtp.gmail.com with ESMTPSA id 9sm1207669ois.10.2020.09.12.20.26.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2020 20:26:02 -0700 (PDT)
Date: Sat, 12 Sep 2020 22:25:59 -0500
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v3 6/8] iommu/arm-smmu: Add impl hook for inherit boot
 mappings
Message-ID: <20200913032559.GT3715@yoga>
References: <20200904155513.282067-1-bjorn.andersson@linaro.org>
 <20200904155513.282067-7-bjorn.andersson@linaro.org>
 <0bfcc8f7-d054-616b-834b-319461b1ecb9@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0bfcc8f7-d054-616b-834b-319461b1ecb9@arm.com>
Cc: Rob Clark <robdclark@chromium.org>, linux-arm-msm@vger.kernel.org,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 Sibi Sankar <sibis@codeaurora.org>, Will Deacon <will@kernel.org>,
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

On Fri 11 Sep 12:13 CDT 2020, Robin Murphy wrote:

> On 2020-09-04 16:55, Bjorn Andersson wrote:
> > Add a new operation to allow platform implementations to inherit any
> > stream mappings from the boot loader.
> 
> Is there a reason we need an explicit step for this? The aim of the
> cfg_probe hook is that the SMMU software state should all be set up by then,
> and you can mess about with it however you like before arm_smmu_reset()
> actually commits anything to hardware. I would have thought you could
> permanently steal a context bank, configure it as your bypass hole, read out
> the previous SME configuration and tweak smmu->smrs and smmu->s2crs
> appropriately all together "invisibly" at that point.

I did this because as of 6a79a5a3842b ("iommu/arm-smmu: Call
configuration impl hook before consuming features") we no longer have
setup pgsize_bitmap as we hit cfg_probe, which means that I need to
replicate this logic to set up the iommu_domain.

If I avoid setting up an iommu_domain for the identity context, as you
request in patch 8, this shouldn't be needed anymore.

> If that can't work, I'm very curious as to what I've overlooked.
> 

I believe that will work, I will rework the patches and try it out.

Thanks,
Bjorn

> Robin.
> 
> > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > ---
> > 
> > Changes since v2:
> > - New patch/interface
> > 
> >   drivers/iommu/arm/arm-smmu/arm-smmu.c | 11 ++++++-----
> >   drivers/iommu/arm/arm-smmu/arm-smmu.h |  6 ++++++
> >   2 files changed, 12 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> > index eb5c6ca5c138..4c4d302cd747 100644
> > --- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
> > +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> > @@ -85,11 +85,6 @@ static inline void arm_smmu_rpm_put(struct arm_smmu_device *smmu)
> >   		pm_runtime_put_autosuspend(smmu->dev);
> >   }
> > -static struct arm_smmu_domain *to_smmu_domain(struct iommu_domain *dom)
> > -{
> > -	return container_of(dom, struct arm_smmu_domain, domain);
> > -}
> > -
> >   static struct platform_driver arm_smmu_driver;
> >   static struct iommu_ops arm_smmu_ops;
> > @@ -2188,6 +2183,12 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
> >   	if (err)
> >   		return err;
> > +	if (smmu->impl->inherit_mappings) {
> > +		err = smmu->impl->inherit_mappings(smmu);
> > +		if (err)
> > +			return err;
> > +	}
> > +
> >   	if (smmu->version == ARM_SMMU_V2) {
> >   		if (smmu->num_context_banks > smmu->num_context_irqs) {
> >   			dev_err(dev,
> > diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.h b/drivers/iommu/arm/arm-smmu/arm-smmu.h
> > index 235d9a3a6ab6..f58164976e74 100644
> > --- a/drivers/iommu/arm/arm-smmu/arm-smmu.h
> > +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.h
> > @@ -378,6 +378,11 @@ struct arm_smmu_domain {
> >   	struct iommu_domain		domain;
> >   };
> > +static inline struct arm_smmu_domain *to_smmu_domain(struct iommu_domain *dom)
> > +{
> > +	return container_of(dom, struct arm_smmu_domain, domain);
> > +}
> > +
> >   struct arm_smmu_master_cfg {
> >   	struct arm_smmu_device		*smmu;
> >   	s16				smendx[];
> > @@ -442,6 +447,7 @@ struct arm_smmu_impl {
> >   	int (*alloc_context_bank)(struct arm_smmu_domain *smmu_domain,
> >   				  struct arm_smmu_device *smmu,
> >   				  struct device *dev, int start);
> > +	int (*inherit_mappings)(struct arm_smmu_device *smmu);
> >   };
> >   #define INVALID_SMENDX			-1
> > 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
