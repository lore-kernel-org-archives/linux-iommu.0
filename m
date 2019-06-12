Return-Path: <SRS0=EPGj=UL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 611B5C31E46
	for <iommu@archiver.kernel.org>; Wed, 12 Jun 2019 18:30:24 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3058220896
	for <iommu@archiver.kernel.org>; Wed, 12 Jun 2019 18:30:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UMBN/yAC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3058220896
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id DE57522A0;
	Wed, 12 Jun 2019 18:30:23 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id C66FC1F0B
	for <iommu@lists.linux-foundation.org>;
	Wed, 12 Jun 2019 18:28:56 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com
	[209.85.210.195])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 48F84E6
	for <iommu@lists.linux-foundation.org>;
	Wed, 12 Jun 2019 18:28:56 +0000 (UTC)
Received: by mail-pf1-f195.google.com with SMTP id t16so10150626pfe.11
	for <iommu@lists.linux-foundation.org>;
	Wed, 12 Jun 2019 11:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-disposition:in-reply-to:user-agent;
	bh=+79M0qC52KBqcZi+aAUpykO9qkYyBvSKoD8+NYjzNgM=;
	b=UMBN/yACkW2pNaFWRj1LqT4MeRqs6jVBZFDrKU77NJNGt1VVfDJJhryte4q7uKq3Ib
	fn1OfIpyKXGCm7/wU587tEChAQygjDEwkz/IvzS4nUjtKgzz1jngIK+x1Owt2Eia+HVu
	/H3V5yPWRDxfYXA9Zhsb+5mKKfM9WZcjmkQ0aUy0DC6BZQF9QdY+AKqLMUnXcuBjUYUQ
	cjyNOX/IaQ9GipKJj+d2B3ic/GXtZiogNyyhysUgWqMt1PnGnLNvJbhM01n4sMR9wSzK
	Jod4ubMgCZ1RKt2iHUw+WaJtNpBjESm5rnza2DmyPbXAeLFJLpY+m13EdM+fbV/wan6J
	WYUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to:user-agent;
	bh=+79M0qC52KBqcZi+aAUpykO9qkYyBvSKoD8+NYjzNgM=;
	b=jX1OYSZWS/NCkkBEsrWP9dqfR6Vv7as3GfUr5HkPTIgCeQENv5TuzvoSLwE7FtyEPc
	fcj8eiYFpANuWEGIh1nbe4UkI5TZ8vY2xV4I/AKMjRgG0ceF8KDUDZsG7CK/9sA+/X+s
	Zh7lNFVypiEOjRZQrj+KkZJMitWggKYeoB0cXzgTkiO+C4fLCpe8K8v3YAfc+oatKbZK
	GtTeOmEzgmrOzSohONzVAqTDssYrmNjY+3hxSwGfy8AeXZezLrK7aEgc9cNfAfzeNBdo
	We3cXQRrcXektogwNtRzuBewGMjdtcaS5PE7QZoKIxUwJDKHzw+wk//SlwG52n+u92B0
	/BJA==
X-Gm-Message-State: APjAAAXwH0PIhW32HsE0xokJHnSCB0ESjHSR6/as6aplNbwfMsLooVHA
	TwLzlvvEvyeENru7ia82hXGkZA==
X-Google-Smtp-Source: APXvYqxcLb0CPq068YSlGSvzRAqyu+g9y/Z69rYUysAsAXumU30uGmd1vWH79G+P3Vh9Thbj9PPDXQ==
X-Received: by 2002:a63:a08:: with SMTP id 8mr26483042pgk.46.1560364135521;
	Wed, 12 Jun 2019 11:28:55 -0700 (PDT)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net.
	[104.188.17.28]) by smtp.gmail.com with ESMTPSA id
	q198sm252178pfq.155.2019.06.12.11.28.53
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Wed, 12 Jun 2019 11:28:54 -0700 (PDT)
Date: Wed, 12 Jun 2019 11:28:52 -0700
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
Subject: Re: [RFC 2/2] iommu: arm-smmu: Don't blindly use first SMR to
	calculate mask
Message-ID: <20190612182852.GA4814@minitux>
References: <20190605210856.20677-1-bjorn.andersson@linaro.org>
	<20190605210856.20677-3-bjorn.andersson@linaro.org>
	<CAOCk7Nocb7VO5xCcuK1FAPVdPr9U-7z8qOL4yt3ig=05e7brgg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAOCk7Nocb7VO5xCcuK1FAPVdPr9U-7z8qOL4yt3ig=05e7brgg@mail.gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Cc: Patrick Daly <pdaly@codeaurora.org>, Jeffrey Hugo <jhugo@codeaurora.org>,
	MSM <linux-arm-msm@vger.kernel.org>, Will Deacon <will.deacon@arm.com>,
	lkml <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org,
	Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On Wed 12 Jun 10:58 PDT 2019, Jeffrey Hugo wrote:

> On Wed, Jun 5, 2019 at 3:09 PM Bjorn Andersson
> <bjorn.andersson@linaro.org> wrote:
> >
> > With the SMRs inherited from the bootloader the first SMR might actually
> > be valid and in use. As such probing the SMR mask using the first SMR
> > might break a stream in use. Search for an unused stream and use this to
> > probe the SMR mask.
> >
> > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> 
> Reviewed-by: Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
> 
> I don't quite like the situation where the is no SMR to compute the mask, but I
> think the way you've handled it is the best option/
> 

Right, if this happens we would end up using the smr_mask that was
previously calculated. We just won't update it based on the hardware.

> I'm curious, why is this not included in patch #1?  Seems like patch
> #1 introduces
> the issue, yet doesn't also fix it.
> 

You're right, didn't think about that. This needs to either predate that
patch or be included in it.

Thanks,
Bjorn

> > ---
> >  drivers/iommu/arm-smmu.c | 20 ++++++++++++++++----
> >  1 file changed, 16 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> > index c8629a656b42..0c6f5fe6f382 100644
> > --- a/drivers/iommu/arm-smmu.c
> > +++ b/drivers/iommu/arm-smmu.c
> > @@ -1084,23 +1084,35 @@ static void arm_smmu_test_smr_masks(struct arm_smmu_device *smmu)
> >  {
> >         void __iomem *gr0_base = ARM_SMMU_GR0(smmu);
> >         u32 smr;
> > +       int idx;
> >
> >         if (!smmu->smrs)
> >                 return;
> >
> > +       for (idx = 0; idx < smmu->num_mapping_groups; idx++) {
> > +               smr = readl_relaxed(gr0_base + ARM_SMMU_GR0_SMR(idx));
> > +               if (!(smr & SMR_VALID))
> > +                       break;
> > +       }
> > +
> > +       if (idx == smmu->num_mapping_groups) {
> > +               dev_err(smmu->dev, "Unable to compute streamid_mask\n");
> > +               return;
> > +       }
> > +
> >         /*
> >          * SMR.ID bits may not be preserved if the corresponding MASK
> >          * bits are set, so check each one separately. We can reject
> >          * masters later if they try to claim IDs outside these masks.
> >          */
> >         smr = smmu->streamid_mask << SMR_ID_SHIFT;
> > -       writel_relaxed(smr, gr0_base + ARM_SMMU_GR0_SMR(0));
> > -       smr = readl_relaxed(gr0_base + ARM_SMMU_GR0_SMR(0));
> > +       writel_relaxed(smr, gr0_base + ARM_SMMU_GR0_SMR(idx));
> > +       smr = readl_relaxed(gr0_base + ARM_SMMU_GR0_SMR(idx));
> >         smmu->streamid_mask = smr >> SMR_ID_SHIFT;
> >
> >         smr = smmu->streamid_mask << SMR_MASK_SHIFT;
> > -       writel_relaxed(smr, gr0_base + ARM_SMMU_GR0_SMR(0));
> > -       smr = readl_relaxed(gr0_base + ARM_SMMU_GR0_SMR(0));
> > +       writel_relaxed(smr, gr0_base + ARM_SMMU_GR0_SMR(idx));
> > +       smr = readl_relaxed(gr0_base + ARM_SMMU_GR0_SMR(idx));
> >         smmu->smr_mask_mask = smr >> SMR_MASK_SHIFT;
> >  }
> >
> > --
> > 2.18.0
> >
> >
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
