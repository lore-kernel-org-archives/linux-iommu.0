Return-Path: <SRS0=EPGj=UL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDD98C31E46
	for <iommu@archiver.kernel.org>; Wed, 12 Jun 2019 18:44:36 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB25D206E0
	for <iommu@archiver.kernel.org>; Wed, 12 Jun 2019 18:44:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dJYzV8Km"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB25D206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 945FE1F5C;
	Wed, 12 Jun 2019 18:44:36 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 26EDF1F5B
	for <iommu@lists.linux-foundation.org>;
	Wed, 12 Jun 2019 18:42:21 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com
	[209.85.214.194])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id CCA38E6
	for <iommu@lists.linux-foundation.org>;
	Wed, 12 Jun 2019 18:42:19 +0000 (UTC)
Received: by mail-pl1-f194.google.com with SMTP id f97so7005217plb.5
	for <iommu@lists.linux-foundation.org>;
	Wed, 12 Jun 2019 11:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-disposition:in-reply-to:user-agent;
	bh=ei7P1FJwNjKWyY3lSsF0Jir0f+bc/vHFp/Q0OynLu/E=;
	b=dJYzV8Km5ZstyXOMBMh0rmuaW2A/Oy1Jc9a5zkmKoZlsvp/G5nNwyEMJyTApZ+H0Q1
	TWoDMNSRNjZcsFDwcoSZah63BSQJs1G+L196yQDOAskIfE2VYbmJCjWWSvg0W0OlT4gD
	M+eL9xwObkunL6BVLsxe4aCqVFd7UoY17JUjMNcf5HbGIPH6hgw/LO3saS+AnJk2CPQF
	JVy5i3CdtEPD6wu16H/c5kaWPEjKjLuvuvC4fEyr3sf/UrZPek3nSQpzs6wl9S6rJD7x
	TnHa7TqRGvgd23WZrGO9L0bcV+gRglSa2bxDXd8KC8PDGYsoSsIFNemI7hVr4LVW73B+
	g1hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to:user-agent;
	bh=ei7P1FJwNjKWyY3lSsF0Jir0f+bc/vHFp/Q0OynLu/E=;
	b=A6WhvYVqEy+Jtc/Cqp7c0E5/YIg/5uUbkEEeY7YjkWGcCqiLY0zHjRiOh1cdRT4ooe
	G/C+6gmU+NUTcuvE++ceHZ4bs5M3/PKBIfRLfsOcei1xAyIDNRtcns0BVaV1d8PyIQ1O
	dZsSrK9QZF029d1bnFaW887nJVzo9MLuX1Clk8VFgiaRo1/sfPrVpdaDoEVPuFYgGZV9
	ZwcmNzKBl4JedQsQ+Yh4837Wlxt3aRBS2ige8xACvcPXnSmw2ABodQPg99j8jTV/TMPX
	t2aPAq1yt72GubmNqwcUhbRSvFujFNKhtmmI6pNtvAeDC+mjyOS8qW2TP5Tk4g4ucVUt
	4nyw==
X-Gm-Message-State: APjAAAU4GC10XOUsJHS3CUejQjfOEAOKYAWBRt5/ajLYjPvz7NRgzWsH
	IBfZd7fgKkOUhGtM4VNwf/viMw==
X-Google-Smtp-Source: APXvYqx8C6og84A/IMmD7FqpBhMl6FAI4uVwaQWfVofVzKlkV6PqLYC/lD/NOOx00Lmozb+WHJs/pg==
X-Received: by 2002:a17:902:e2:: with SMTP id
	a89mr83814752pla.210.1560364939226; 
	Wed, 12 Jun 2019 11:42:19 -0700 (PDT)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net.
	[104.188.17.28])
	by smtp.gmail.com with ESMTPSA id r7sm262760pfl.134.2019.06.12.11.42.18
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Wed, 12 Jun 2019 11:42:18 -0700 (PDT)
Date: Wed, 12 Jun 2019 11:42:16 -0700
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
Subject: Re: [RFC 1/2] iommu: arm-smmu: Handoff SMR registers and context banks
Message-ID: <20190612184216.GB4814@minitux>
References: <20190605210856.20677-1-bjorn.andersson@linaro.org>
	<20190605210856.20677-2-bjorn.andersson@linaro.org>
	<CAOCk7NpuxpGGYwiPSdwkrZrM=u-euAUTX3wa-yaEsKocDUx-UA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAOCk7NpuxpGGYwiPSdwkrZrM=u-euAUTX3wa-yaEsKocDUx-UA@mail.gmail.com>
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

On Wed 12 Jun 11:07 PDT 2019, Jeffrey Hugo wrote:

> On Wed, Jun 5, 2019 at 3:09 PM Bjorn Andersson
> <bjorn.andersson@linaro.org> wrote:
> >
> > Boot splash screen or EFI framebuffer requires the display hardware to
> > operate while the Linux iommu driver probes. Therefore, we cannot simply
> > wipe out the SMR register settings programmed by the bootloader.
> >
> > Detect which SMR registers are in use during probe, and which context
> > banks they are associated with. Reserve these context banks for the
> > first Linux device whose stream-id matches the SMR register.
> >
> > Any existing page-tables will be discarded.
> >
> > Heavily based on downstream implementation by Patrick Daly
> > <pdaly@codeaurora.org>.
> >
> > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> 
> Reviewed-by: Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
> 
> This is very similar to the hacked up version I did, and I'm glad to see it
> cleaned up and posted.
> 
> This is important work, and I want to see it move forward, however it doesn't
> completely address everything, IMO.  Fixing the remaining issues certainly
> can be follow on work, but I don't know if they would end up affecting this
> implementation.
> 
> So, with this series, we've gone from a crash on msm8998/sdm845, to causing
> context faults.  This is because while we are now not nuking the config, we
> are preventing the bootloader installed translations from working.  Essentially
> the display already has a mapping (technically passthrough) that is likely being
> used by EFIFB.  The instant the SMMU inits, that mapping becomes invalid,
> and the display is going to generate context faults.  While not fatal,
> this provides
> a bad user experience as there are nasty messages, and EFIFB stops working.
> 
> The situation does get resolved once the display driver inits and takes over the
> HW and SMMU mappings, so we are not stuck with it, but it would be nice to
> have that addressed as well, ie have EFIFB working up until the Linux display
> driver takes over.
> 

But do you see this even though you don't enable the mdss driver?

> The only way I can see that happening is if the SMMU leaves the context bank
> alone, with M == 0, and the iommu framework defines a domain attribute or
> some other mechanism to allow the driver to flip the M bit in the context bank
> after installing the necessary handover translations.
> 

From what I can tell this implementation leaves the framebuffer mapping
in working condition until the attach_dev of the display driver, at
which time we do get context faults until the display driver is done
initializing things.

So we're reducing the problem to a question of how to seamlessly carry
over the mapping during the attach.

Regards,
Bjorn

> > ---
> >  drivers/iommu/arm-smmu-regs.h |  2 +
> >  drivers/iommu/arm-smmu.c      | 80 ++++++++++++++++++++++++++++++++---
> >  2 files changed, 77 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/iommu/arm-smmu-regs.h b/drivers/iommu/arm-smmu-regs.h
> > index e9132a926761..8c1fd84032a2 100644
> > --- a/drivers/iommu/arm-smmu-regs.h
> > +++ b/drivers/iommu/arm-smmu-regs.h
> > @@ -105,7 +105,9 @@
> >  #define ARM_SMMU_GR0_SMR(n)            (0x800 + ((n) << 2))
> >  #define SMR_VALID                      (1 << 31)
> >  #define SMR_MASK_SHIFT                 16
> > +#define SMR_MASK_MASK                  0x7fff
> >  #define SMR_ID_SHIFT                   0
> > +#define SMR_ID_MASK                    0xffff
> >
> >  #define ARM_SMMU_GR0_S2CR(n)           (0xc00 + ((n) << 2))
> >  #define S2CR_CBNDX_SHIFT               0
> > diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> > index 5e54cc0a28b3..c8629a656b42 100644
> > --- a/drivers/iommu/arm-smmu.c
> > +++ b/drivers/iommu/arm-smmu.c
> > @@ -135,6 +135,7 @@ struct arm_smmu_s2cr {
> >         enum arm_smmu_s2cr_type         type;
> >         enum arm_smmu_s2cr_privcfg      privcfg;
> >         u8                              cbndx;
> > +       bool                            handoff;
> >  };
> >
> >  #define s2cr_init_val (struct arm_smmu_s2cr){                          \
> > @@ -399,9 +400,22 @@ static int arm_smmu_register_legacy_master(struct device *dev,
> >         return err;
> >  }
> >
> > -static int __arm_smmu_alloc_bitmap(unsigned long *map, int start, int end)
> > +static int __arm_smmu_alloc_cb(struct arm_smmu_device *smmu, int start,
> > +                              struct device *dev)
> >  {
> > +       struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
> > +       unsigned long *map = smmu->context_map;
> > +       int end = smmu->num_context_banks;
> > +       int cbndx;
> >         int idx;
> > +       int i;
> > +
> > +       for_each_cfg_sme(fwspec, i, idx) {
> > +               if (smmu->s2crs[idx].handoff) {
> > +                       cbndx = smmu->s2crs[idx].cbndx;
> > +                       goto found_handoff;
> > +               }
> > +       }
> >
> >         do {
> >                 idx = find_next_zero_bit(map, end, start);
> > @@ -410,6 +424,17 @@ static int __arm_smmu_alloc_bitmap(unsigned long *map, int start, int end)
> >         } while (test_and_set_bit(idx, map));
> >
> >         return idx;
> > +
> > +found_handoff:
> > +       for (i = 0; i < smmu->num_mapping_groups; i++) {
> > +               if (smmu->s2crs[i].cbndx == cbndx) {
> > +                       smmu->s2crs[i].cbndx = 0;
> > +                       smmu->s2crs[i].handoff = false;
> > +                       smmu->s2crs[i].count--;
> > +               }
> > +       }
> > +
> > +       return cbndx;
> >  }
> >
> >  static void __arm_smmu_free_bitmap(unsigned long *map, int idx)
> > @@ -759,7 +784,8 @@ static void arm_smmu_write_context_bank(struct arm_smmu_device *smmu, int idx)
> >  }
> >
> >  static int arm_smmu_init_domain_context(struct iommu_domain *domain,
> > -                                       struct arm_smmu_device *smmu)
> > +                                       struct arm_smmu_device *smmu,
> > +                                       struct device *dev)
> >  {
> >         int irq, start, ret = 0;
> >         unsigned long ias, oas;
> > @@ -873,8 +899,7 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
> >                 ret = -EINVAL;
> >                 goto out_unlock;
> >         }
> > -       ret = __arm_smmu_alloc_bitmap(smmu->context_map, start,
> > -                                     smmu->num_context_banks);
> > +       ret = __arm_smmu_alloc_cb(smmu, start, dev);
> >         if (ret < 0)
> >                 goto out_unlock;
> >
> > @@ -1264,7 +1289,7 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
> >                 return ret;
> >
> >         /* Ensure that the domain is finalised */
> > -       ret = arm_smmu_init_domain_context(domain, smmu);
> > +       ret = arm_smmu_init_domain_context(domain, smmu, dev);
> >         if (ret < 0)
> >                 goto rpm_put;
> >
> > @@ -1798,6 +1823,49 @@ static void arm_smmu_device_reset(struct arm_smmu_device *smmu)
> >         writel(reg, ARM_SMMU_GR0_NS(smmu) + ARM_SMMU_GR0_sCR0);
> >  }
> >
> > +static void arm_smmu_read_smr_state(struct arm_smmu_device *smmu)
> > +{
> > +       u32 privcfg;
> > +       u32 cbndx;
> > +       u32 mask;
> > +       u32 type;
> > +       u32 s2cr;
> > +       u32 smr;
> > +       u32 id;
> > +       int i;
> > +
> > +       for (i = 0; i < smmu->num_mapping_groups; i++) {
> > +               smr = readl_relaxed(ARM_SMMU_GR0(smmu) + ARM_SMMU_GR0_SMR(i));
> > +               mask = (smr >> SMR_MASK_SHIFT) & SMR_MASK_MASK;
> > +               id = smr & SMR_ID_MASK;
> > +               if (!(smr & SMR_VALID))
> > +                       continue;
> > +
> > +               s2cr = readl_relaxed(ARM_SMMU_GR0(smmu) + ARM_SMMU_GR0_S2CR(i));
> > +               type = (s2cr >> S2CR_TYPE_SHIFT) & S2CR_TYPE_MASK;
> > +               cbndx = (s2cr >> S2CR_CBNDX_SHIFT) & S2CR_CBNDX_MASK;
> > +               privcfg = (s2cr >> S2CR_PRIVCFG_SHIFT) & S2CR_PRIVCFG_MASK;
> > +               if (type != S2CR_TYPE_TRANS)
> > +                       continue;
> > +
> > +               /* Populate the SMR */
> > +               smmu->smrs[i].mask = mask;
> > +               smmu->smrs[i].id = id;
> > +               smmu->smrs[i].valid = true;
> > +
> > +               /* Populate the S2CR */
> > +               smmu->s2crs[i].group = NULL;
> > +               smmu->s2crs[i].count = 1;
> > +               smmu->s2crs[i].type = type;
> > +               smmu->s2crs[i].privcfg = privcfg;
> > +               smmu->s2crs[i].cbndx = cbndx;
> > +               smmu->s2crs[i].handoff = true;
> > +
> > +               /* Mark the context bank as busy */
> > +               bitmap_set(smmu->context_map, cbndx, 1);
> > +       }
> > +}
> > +
> >  static int arm_smmu_id_size_to_bits(int size)
> >  {
> >         switch (size) {
> > @@ -2023,6 +2091,8 @@ static int arm_smmu_device_cfg_probe(struct arm_smmu_device *smmu)
> >                 dev_notice(smmu->dev, "\tStage-2: %lu-bit IPA -> %lu-bit PA\n",
> >                            smmu->ipa_size, smmu->pa_size);
> >
> > +       arm_smmu_read_smr_state(smmu);
> > +
> >         return 0;
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
